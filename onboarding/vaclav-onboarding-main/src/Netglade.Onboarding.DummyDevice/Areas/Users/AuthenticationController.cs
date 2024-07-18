using System.IdentityModel.Tokens.Jwt;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using NetGlade.Onboarding.DummyDevice.Authentication;
using NetGlade.Onboarding.DummyDevice.Models;

namespace NetGlade.Onboarding.DummyDevice.Areas.Users;

public class AuthenticationController : ControllerBase
{
    [HttpPost]
    [Route("login")]
    public async Task<IActionResult> Login([FromBody] LoginModel model, [FromServices] LoginHandler loginHandler)
    {
        var token = await loginHandler.LoginUserAsync(model);

        return Ok(new
        {
            token = new JwtSecurityTokenHandler().WriteToken(token),
            expiration = token.ValidTo
        });
    }

    [HttpPost]
    [Route("register")]
    public async Task<IActionResult> Register([FromBody] RegisterModel model, [FromServices] RegistrationHandler registrationHandler)
    {
        return Ok(await registrationHandler.RegisterUserAsync(model));
    }

    [HttpPost]
    [Route("register-admin")]
    public async Task<IActionResult> RegisterAdmin([FromBody] RegisterModel model, [FromServices] AdminRegistrationHandler adminRegistrationHandler)
    {
        return Ok(await adminRegistrationHandler.RegisterAdminAsync(model));
    }

    [Authorize(Roles = UserRoles.Administrator)]
    [HttpGet]
    [Route("users/get-all")]
    public async Task<ActionResult<IList<UserResponse>>> GetAllUsers([FromQuery] string userId, [FromServices] UsersHandler usersHandler)
    {
        return Ok(await usersHandler.GetAllUsers(userId));
    }

    [Authorize(Roles = UserRoles.Administrator)]
    [HttpPost]
    [Route("users/give-admin-rights")]
    public async Task<ActionResult> GiveAdminRights([FromQuery] string userId, [FromServices] UsersHandler usersHandler)
    {
        return Ok(await usersHandler.GiveAdminRights(userId));
    }

    [Authorize(Roles = UserRoles.Administrator)]
    [HttpPost]
    [Route("users/remove-admin-rights")]
    public async Task<ActionResult> RemoveAdminRights([FromQuery] string userId, [FromServices] UsersHandler usersHandler)
    {
        return Ok(await usersHandler.RemoveAdminRights(userId));
    }

    [Authorize(Roles = UserRoles.Administrator)]
    [HttpDelete]
    [Route("users/{userId}")]
    public async Task<ActionResult> RemoveUser([FromRoute] string userId, [FromQuery] string adminId, [FromServices] UsersHandler usersHandler)
    {
        return Ok(await usersHandler.ArchiveUser(userId, adminId));
    }

    [Authorize(Roles = UserRoles.Administrator)]
    [HttpPost]
    [Route("users/{userId}")]
    public async Task<ActionResult> ReinstateUser([FromRoute] string userId, [FromServices] UsersHandler usersHandler)
    {
        return Ok(await usersHandler.ReinstateUser(userId));
    }
}
