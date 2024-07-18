using System.Globalization;
using NetGlade.Onboarding.DummyDevice.Authentication;
using NetGlade.Onboarding.DummyDevice.Models;
using NetGlade.Onboarding.DummyDevice.Services.Abstractions;

namespace NetGlade.Onboarding.DummyDevice.Areas.Telemetries;

public class ExportHandler : IHandler
{
    private readonly ApplicationDbContext _context;

    public ExportHandler(ApplicationDbContext context)
    {
        _context = context;
    }

    public MemoryStream GenerateCsvBytes(IEnumerable<SatelliteTelemetry> telemetryData)
    {
        var memoryStream = new MemoryStream();
        var writer = new StreamWriter(memoryStream);

        writer.WriteLine("Timestamp,Altitude,Radiation,Temperature,Velocity");

        foreach (var telemetry in telemetryData)
        {
            var csvRow = string.Format(CultureInfo.InvariantCulture, "{0},{1},{2},{3},{4}", telemetry.Timestamp, telemetry.Altitude, telemetry.Radiation, telemetry.Temperature, telemetry.Velocity);
            writer.WriteLine(csvRow);
        }

        writer.Flush();
        memoryStream.Seek(0, SeekOrigin.Begin);

        return memoryStream;
    }

}
