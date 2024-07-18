using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using NetGlade.Onboarding.DummyDevice.Authentication;
using NetGlade.Onboarding.DummyDevice.Exceptions;
using NetGlade.Onboarding.DummyDevice.Models;
using NetGlade.Onboarding.DummyDevice.Services.Abstractions;

namespace NetGlade.Onboarding.DummyDevice.Areas.Telemetries;

public class TelemetriesHandler : IHandler
{
    private readonly ApplicationDbContext _context;

    public TelemetriesHandler(ApplicationDbContext context)
    {
        _context = context;
    }

    public async Task<IEnumerable<SatelliteTelemetry>> LoadTelemetriesAsync(CancellationToken token, long startingTimeStamp = 0, long endingTimeStamp = long.MaxValue, long lowestAltitude = 0, long highestAltitude = long.MaxValue, int page = 1, int pageSize = 10)
    {
        if (1 > pageSize || pageSize > 100)
        {
            throw new InternalException("Page size muste be between 1 and 100.", 400, System.Net.HttpStatusCode.BadRequest);
        }

        return await _context.SatelliteTelemetries
                            .Where(x => startingTimeStamp <= x.Timestamp && x.Timestamp <= endingTimeStamp)
                            .Where(x => lowestAltitude <= x.Altitude && x.Altitude <= highestAltitude)
                            .AsNoTracking()
                            .OrderByDescending(x => x.Timestamp)
                            .Skip((page - 1) * pageSize)
                            .Take(pageSize)
                            .OrderBy(x => x.Timestamp)
                            .ToListAsync(token);
    }

    public async Task<ICollection<SatelliteTelemetry>> GetFavouriteTelemetry(string userId, long endingTimeStamp = long.MaxValue)
    {
        var user = await _context.Users.Include(x => x.FavouriteTelemetries).FirstOrDefaultAsync(x => x.Id == userId);
        if (user == default)
        {
            throw new InternalException("User doesn't exist.", 400, System.Net.HttpStatusCode.BadRequest);
        }
        return user.FavouriteTelemetries.Where(x => x.Timestamp <= endingTimeStamp).ToList();
    }

    public async Task<ActionResult> DeleteTelemetry(int telemetryId)
    {
        var telemetry = await _context.SatelliteTelemetries.FirstOrDefaultAsync(x => x.TelemetryId == telemetryId);
        if (telemetry != default)
        {
            _context.SatelliteTelemetries.Remove(telemetry);
            await _context.SaveChangesAsync();
            return new OkResult();
        }
        else
        {
            throw new InternalException("Telemetry doesn't exist", 401, System.Net.HttpStatusCode.NotFound);
        }


    }

    public async Task<ActionResult> PostFavouriteTelemetry(string userId, int telemetryId)
    {
        var user = await _context.Users.FirstOrDefaultAsync(x => x.Id == userId);
        var favouriteTelemetry = user.FavouriteTelemetries.FirstOrDefault(x => x.TelemetryId == telemetryId);
        if (favouriteTelemetry == default)
        {
            var telemetry = await _context.SatelliteTelemetries.FirstAsync(x => x.TelemetryId == telemetryId);
            user.FavouriteTelemetries.Add(telemetry);
            await _context.SaveChangesAsync();
        }
        else
        {
            throw new InternalException("Item already exists", 409, System.Net.HttpStatusCode.Conflict);
        }
        return new OkResult();
    }

    public async Task<ActionResult> DeleteFavouriteTelemetry(string userId, int telemetryId)
    {
        var user = await _context.Users.Include(x => x.FavouriteTelemetries).FirstOrDefaultAsync(x => x.Id == userId);
        var favouriteTelemetry = user.FavouriteTelemetries.FirstOrDefault(x => x.TelemetryId == telemetryId);

        if (favouriteTelemetry != default)
        {
            user.FavouriteTelemetries.Remove(favouriteTelemetry);
            await _context.SaveChangesAsync();
        }
        else
        {
            throw new InternalException("Item doesn't exist", 409, System.Net.HttpStatusCode.Conflict);
        }
        return new OkResult();
    }
}
