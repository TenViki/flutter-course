using System.Text.Json.Serialization;
using Microsoft.AspNetCore.Identity;
using NetGlade.Onboarding.DummyDevice.Models;

namespace NetGlade.Onboarding.DummyDevice.Authentication;

public class ApplicationUser : IdentityUser
{
    public bool IsDeleted { get; set; }
    public DateTime? DeletedDate { get; set; }
    public string? DeletedBy { get; set; }
    [JsonIgnore]
    public ICollection<SatelliteTelemetry> FavouriteTelemetries { get; set; } = new List<SatelliteTelemetry>();
}
