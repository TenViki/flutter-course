using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using NetGlade.Onboarding.DummyDevice.Authentication;
using NetGlade.Onboarding.DummyDevice.Models;

namespace NetGlade.Onboarding.DummyDevice.Areas.Telemetries;

[ApiController]
public class SatelliteDataController : ControllerBase
{
    private readonly TelemetriesHandler _telemetriesLoader;

    public SatelliteDataController(TelemetriesHandler loader)
    {
        _telemetriesLoader = loader;
    }

    [Authorize]
    [HttpGet]
    [Route("telemetry")]
    public async Task<ActionResult<IEnumerable<SatelliteTelemetry>>> GetData(
        CancellationToken token,
        [FromQuery] long startingTimeStamp = 0,
        long endingTimeStamp = long.MaxValue / 2,
        long lowestAltitude = 0,
        long highestAltitude = long.MaxValue / 2,
        int page = 1,
        int pageSize = 10
        )
    {
        var items = await _telemetriesLoader.LoadTelemetriesAsync(token, startingTimeStamp, endingTimeStamp, lowestAltitude, highestAltitude, page, pageSize);
        return Ok(items);
    }

    [Authorize(Roles = UserRoles.Administrator)]
    [HttpDelete]
    [Route("telemetry")]
    public async Task<ActionResult> DeleteTelemetry(int telemetryId)
    {
        return Ok(await _telemetriesLoader.DeleteTelemetry(telemetryId));
    }

    [HttpGet]
    [Route("telemetry/errors")]
    public async Task<ActionResult<IEnumerable<TelemetryError>>> GetData(ErrorHandler handler, CancellationToken token, int page = 1, int pageSize = 10)
    {
        var items = await handler.GetTelemetryErrors(token, page, pageSize);
        return Ok(items);
    }

    [Authorize(Roles = UserRoles.Administrator)]
    [HttpDelete]
    [Route("telemetry/errors")]
    public async Task<ActionResult> DeleteTelemetry(ErrorHandler handler, int errorId)
    {
        return Ok(await handler.DeleteError(errorId));
    }

    [HttpGet]
    [Route("telemetry/export/pdf")]
    public async Task<IActionResult> GetPdfReport(PdfHandler handler)
    {
        var stream = await handler.GeneratePdfStream();
        HttpContext.Response.RegisterForDispose(stream);

        return File(stream, "application/pdf", "telemetry.pdf");
    }

    [HttpGet]
    [Route("telemetry/export")]
    public async Task<IActionResult> GetCsvData(
        ExportHandler exportHandler,
        CancellationToken token,
        [FromQuery] long startingTimeStamp = 0,
        long endingTimeStamp = long.MaxValue / 2,
        long lowestAltitude = 0,
        long highestAltitude = long.MaxValue / 2,
        int page = 1,
        int pageSize = 10
        )
    {
        var telemetryData = await _telemetriesLoader.LoadTelemetriesAsync(token, startingTimeStamp, endingTimeStamp, lowestAltitude, highestAltitude, page, pageSize);
        var csvBytes = exportHandler.GenerateCsvBytes(telemetryData);

        return File(csvBytes, "text/csv", "telemetry.csv");
    }

    [HttpGet]
    [Route("favourite-telemetry")]
    public async Task<ActionResult<ICollection<SatelliteTelemetry>>> GetData(string userId, long endingTimeStamp = long.MaxValue / 2)
    {
        return Ok(await _telemetriesLoader.GetFavouriteTelemetry(userId, endingTimeStamp));
    }

    [HttpPost]
    [Route("favourite-telemetry")]
    public async Task<ActionResult> PostData(string userId, int telemetryId)
    {
        return Ok(await _telemetriesLoader.PostFavouriteTelemetry(userId, telemetryId));
    }

    [HttpDelete]
    [Route("favourite-telemetry")]
    public async Task<ActionResult> DeleteData(string userId, int telemetryId)
    {
        return Ok(await _telemetriesLoader.DeleteFavouriteTelemetry(userId, telemetryId));
    }
}

