using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;
using NetGlade.Onboarding.DummyDevice.Models;

namespace NetGlade.Onboarding.DummyDevice.Authentication;

public class ApplicationDbContext : IdentityDbContext<ApplicationUser>
{
    public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options) : base(options)
    {
    }

    public virtual DbSet<SatelliteTelemetry> SatelliteTelemetries { get; set; }
    public virtual DbSet<TelemetryError> TelemetryErrors { get; set; }
    protected override void OnModelCreating(ModelBuilder builder)
    {
        builder.Entity<SatelliteTelemetry>(entity =>
        {
            entity.HasKey(e => e.TelemetryId);
            entity.HasMany(e => e.ApplicationUsers).WithMany(e => e.FavouriteTelemetries);

            entity.ToTable("SatelliteTelemetry");
        });

        builder.Entity<TelemetryError>(entity =>
        {
            entity.HasKey(e => e.ErrorId);
            entity.ToTable("TelemetrtyError");
        });

        Seed(builder);

        base.OnModelCreating(builder);
    }
    private void Seed(ModelBuilder builder)
    {
        var adminRole = new IdentityRole
        {
            Id = "1", // Replace with a unique role ID
            Name = "Administrator"    // Replace with the desired role name
        };

        // Add the administrator role to the IdentityRoles DbSet
        builder.Entity<IdentityRole>().HasData(adminRole);

        var adminUser = new ApplicationUser
        {
            Id = "1",
            UserName = "Admin", // Change to the desired username
            NormalizedUserName = "ADMIN",
            Email = "admin@example.com",
            NormalizedEmail = "ADMIN@EXAMPLE.COM",// Change to the desired email
            EmailConfirmed = true,
            // Add other user properties as needed
        };

        // Hash the password (replace "YourPassword" with the desired password)
        var passwordHasher = new PasswordHasher<ApplicationUser>();
        adminUser.PasswordHash = passwordHasher.HashPassword(adminUser, "Idk123.");

        // Add the administrator user to the Identity DbSet
        builder.Entity<ApplicationUser>().HasData(adminUser);

        // Assign the administrator role to the administrator user
        builder.Entity<IdentityUserRole<string>>().HasData(new IdentityUserRole<string>
        {
            RoleId = adminRole.Id, // Replace with the actual role ID for administrators
            UserId = adminUser.Id
        });
    }

}
