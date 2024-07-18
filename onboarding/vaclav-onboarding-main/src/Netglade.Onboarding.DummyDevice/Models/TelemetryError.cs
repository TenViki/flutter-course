namespace NetGlade.Onboarding.DummyDevice.Models;

public partial class TelemetryError
{
    public int ErrorId { get; set; }
    public long Timestamp { get; set; }
    public byte[] Data { get; set; }
}
