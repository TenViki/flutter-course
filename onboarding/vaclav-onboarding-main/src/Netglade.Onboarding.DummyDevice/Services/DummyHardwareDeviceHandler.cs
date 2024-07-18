using System.Text;
using Force.Crc32;
using Microsoft.EntityFrameworkCore;
using NetGlade.Onboarding.DummyDevice.Authentication;
using NetGlade.Onboarding.DummyDevice.Models;
using NetGlade.Onboarding.HardwareDummyDeviceAspSdk;
using NetGlade.Onboarding.HardwareDummyDeviceAspSdk.Services;

public class DummyHardwareDeviceHandler : IDummyHardwareDeviceHandler
{

    private readonly ILogger _logger;
    private readonly IDbContextFactory<ApplicationDbContext> _dbContextFactory;

    public DummyHardwareDeviceHandler(ILogger<DummyHardwareDeviceHandler> logger, IDbContextFactory<ApplicationDbContext> factory)
    {
        _logger = logger;
        _dbContextFactory = factory;
    }
    public void HandleConnectionChange(ConnectionState oldState, ConnectionState newState)
    {

        if (oldState == ConnectionState.Disconnected && newState == ConnectionState.Connected)
        {
            _logger.LogInformation("Database connected.");
        }
        else if (oldState == ConnectionState.Connected && newState == ConnectionState.Disconnected)
        {
            _logger.LogError("Connection to database lost.");
        }
        return;
    }
    public async Task HandleNewData(IHardwareDummyDeviceReceivedData receivedData, CancellationToken cancellationToken)
    {
        using var dbContext = _dbContextFactory.CreateDbContext();
        var data = receivedData.GetBytes().ToArray();
        int delimiterIndex = data.TakeWhile(b => b != 0x7C).Count();
        byte[] crc32Hash = data.Take(delimiterIndex).Skip(1).ToArray();
        byte[] restOfData = data.Skip(delimiterIndex).SkipLast(1).ToArray();

        if (Convert.ToUInt32(Encoding.ASCII.GetString(crc32Hash)) != Crc32Algorithm.Compute(restOfData))
        {
            _logger.LogError("CRC32 hash check failed, data corrupted\n Expected hash: {0}\n Recieved hash: {1}\n Data recieved {2}  ", Convert.ToUInt32(Encoding.ASCII.GetString(crc32Hash)), Crc32Algorithm.Compute(restOfData), Encoding.ASCII.GetString(restOfData));

            var timeNow = new DateTimeOffset(DateTime.UtcNow);
            var telemetryError = new TelemetryError
            {
                Timestamp = timeNow.ToUnixTimeSeconds(),
                Data = data
            };

            dbContext.TelemetryErrors.Add(telemetryError);
            await dbContext.SaveChangesAsync();
            return;
        }

        var dataString = (Encoding.ASCII.GetString(restOfData)).Split('|');
        bool conversionSuccesful = true;

        //This works as if there was a bool for each conversion and they were all ANDed together
        conversionSuccesful &= Int64.TryParse(dataString[1], out long timestamp);
        conversionSuccesful &= Int64.TryParse(dataString[2], out long altitude);
        conversionSuccesful &= Int32.TryParse(dataString[3], out int velocity);
        conversionSuccesful &= Int32.TryParse(dataString[4], out int temperature);
        conversionSuccesful &= Int32.TryParse(dataString[5], out int radiation);

        if (conversionSuccesful)
        {
            var telemetry = new SatelliteTelemetry
            {
                Timestamp = timestamp,
                Altitude = altitude,
                Velocity = velocity,
                Temperature = temperature,
                Radiation = radiation
            };

            _logger.LogDebug("Data succesfully received and added to database: {data} ", Encoding.ASCII.GetString(restOfData));
            dbContext.SatelliteTelemetries.Add(telemetry);
            await dbContext.SaveChangesAsync();
        }
    }
}
