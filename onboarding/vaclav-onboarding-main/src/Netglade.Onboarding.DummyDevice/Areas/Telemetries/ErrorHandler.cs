using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using NetGlade.Onboarding.DummyDevice.Authentication;
using NetGlade.Onboarding.DummyDevice.Exceptions;
using NetGlade.Onboarding.DummyDevice.Models;
using NetGlade.Onboarding.DummyDevice.Services.Abstractions;

namespace NetGlade.Onboarding.DummyDevice.Areas.Telemetries;

public class ErrorHandler : IHandler
{
    private readonly ApplicationDbContext _context;

    public ErrorHandler(ApplicationDbContext context)
    {
        _context = context;
    }

    public async Task<IList<TelemetryErrorResponse>> GetTelemetryErrors(CancellationToken token, int page = 1, int pageSize = 10)
    {
        if (1 > pageSize || pageSize > 100)
        {
            throw new InternalException("Page size muste be between 1 and 100.", 400, System.Net.HttpStatusCode.BadRequest);
        }

        return await _context.TelemetryErrors
                            .OrderByDescending(x => x.Timestamp)
                            .Skip((page - 1) * pageSize)
                            .Take(pageSize)
                            .AsNoTracking()
                            .Select(error => new TelemetryErrorResponse
                            (
                                error.ErrorId,
                                error.Data,
                                error.Timestamp
                            ))
                            .ToListAsync(token);

    }

    public async Task<ActionResult> DeleteError(int id)
    {
        var error = await _context.TelemetryErrors.FirstOrDefaultAsync(x => x.ErrorId == id);
        if (error != default)
        {
            _context.TelemetryErrors.Remove(error);
            await _context.SaveChangesAsync();
            return new OkResult();
        }
        else
        {
            throw new InternalException("Error doesn't exist", 401, System.Net.HttpStatusCode.NotFound);
        }


    }

}
