using System.Net;
using Microsoft.AspNetCore.Identity;
using NetGlade.Onboarding.DummyDevice.Authentication;
using NetGlade.Onboarding.DummyDevice.Exceptions;
using NetGlade.Onboarding.DummyDevice.Services.Abstractions;

namespace NetGlade.Onboarding.DummyDevice.Areas.Users;

public class RegistrationHandler : IHandler
{
    private readonly UserManager<ApplicationUser> _userManager;

    public RegistrationHandler(UserManager<ApplicationUser> userManager)
    {
        _userManager = userManager;
    }

    public async Task<IdentityResult> RegisterUserAsync(RegisterModel model)
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
        return result;
    }
}
