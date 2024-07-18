using System.Net;

namespace NetGlade.Onboarding.DummyDevice.Exceptions;

public class InternalException : Exception
{
    public HttpStatusCode StatusCode { get; }
    public int ErrorCode { get; }

    public InternalException(string message, int errorCode, HttpStatusCode statusCode) : base(message)
    {
        ErrorCode = errorCode;
        StatusCode = statusCode;
    }
}

