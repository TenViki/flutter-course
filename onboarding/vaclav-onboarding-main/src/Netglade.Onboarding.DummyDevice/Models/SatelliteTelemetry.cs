using System.Text.Json.Serialization;
using NetGlade.Onboarding.DummyDevice.Authentication;


namespace NetGlade.Onboarding.DummyDevice.Models;

public partial class SatelliteTelemetry
{
    public int TelemetryId { get; set; }

    public long Altitude { get; set; }

    public long Timestamp { get; set; }

    public int Temperature { get; set; }

    public int Velocity { get; set; }

    public int Radiation { get; set; }
    [JsonIgnore]
    public ICollection<ApplicationUser> ApplicationUsers { get; set; } = new List<ApplicationUser>();
}
