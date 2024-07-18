using System.Text.Json;
using NetGlade.Onboarding.DummyDevice.Exceptions;

namespace NetGlade.Onboarding.DummyDevice.Services;

public record ErrorResponse(string Message, int StatusCode);

public class ErrorHandlerMiddleware
{
    private readonly RequestDelegate _next;
    private readonly ILogger _logger;
    private readonly ExceptionResolver _exceptionResolver;

    public ErrorHandlerMiddleware(RequestDelegate next, ILogger<ErrorHandlerMiddleware> logger, ExceptionResolver resolver)
    {
        _next = next;
        _logger = logger;
        _exceptionResolver = resolver;
    }

    public async Task Invoke(HttpContext context)
    {

        try
        {
            await _next(context);
        }
        catch (Exception ex)
        {
            await HandleExceptionAsync(context, ex);
        }
    }

    private Task HandleExceptionAsync(HttpContext context, Exception ex)
    {
        (var exceptionMessage, var errorCode, var statusCode) = _exceptionResolver.ResolveException(ex);
        var json = JsonSerializer.Serialize(exceptionMessage);

        context.Response.ContentType = "application/json";
        context.Response.StatusCode = (int)statusCode;
        _logger.LogError("An exception occured while processing request: {0}", ex);

        return context.Response.WriteAsync(json);
    }
}
