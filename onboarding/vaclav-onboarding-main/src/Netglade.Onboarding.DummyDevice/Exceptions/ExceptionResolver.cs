using System.Net;

namespace NetGlade.Onboarding.DummyDevice.Exceptions;

public class ExceptionResolver
{
    public (string Error, int InternalCode, HttpStatusCode StatusCode) ResolveException(Exception exception) => exception switch
    {
        InternalException e
            => (e.Message, e.ErrorCode, e.StatusCode),
        _
            => ("Unexpected internal server error occured.", 500, HttpStatusCode.InternalServerError)
    };
}
