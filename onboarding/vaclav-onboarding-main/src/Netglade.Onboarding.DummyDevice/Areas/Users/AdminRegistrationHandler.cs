using System.Net;
using Microsoft.AspNetCore.Identity;
using NetGlade.Onboarding.DummyDevice.Authentication;
using NetGlade.Onboarding.DummyDevice.Exceptions;
using NetGlade.Onboarding.DummyDevice.Services.Abstractions;

namespace NetGlade.Onboarding.DummyDevice.Areas.Users;

public class AdminRegistrationHandler : IHandler
{
    private readonly UserManager<ApplicationUser> _userManager;
    private readonly RoleManager<IdentityRole> _roleManager;

    public AdminRegistrationHandler(UserManager<ApplicationUser> userManager, RoleManager<IdentityRole> roleManager)
    {
        _userManager = userManager;
        _roleManager = roleManager;
    }

    public async Task<IdentityResult> RegisterAdminAsync(RegisterModel model)
    {
        var userExists = await _userManager.FindByNameAsync(model.Username);
        if (userExists != null)
        {
            throw new InternalException("User already exists!", 1001, HttpStatusCode.Conflict);
        }

        var user = new ApplicationUser()
        {
            Email = model.Email,
            SecurityStamp = Guid.NewGuid().ToString(),
            UserName = model.Username
        };
        var result = await _userManager.CreateAsync(user, model.Password);

        if (result.Succeeded == false)
        {
            throw new InternalException(result.ToString(), 1002, HttpStatusCode.InternalServerError);
        }

        if (await _roleManager.RoleExistsAsync(UserRoles.Administrator) == false)
        {
            await _roleManager.CreateAsync(new IdentityRole(UserRoles.Administrator));
        }
        result = await _userManager.AddToRoleAsync(user, UserRoles.Administrator);

        if (result.Succeeded == false)
        {
            throw new InternalException(result.ToString(), 1003, HttpStatusCode.InternalServerError);
        }
        return result;
    }
}
