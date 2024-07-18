using System.Net;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using NetGlade.Onboarding.DummyDevice.Authentication;
using NetGlade.Onboarding.DummyDevice.Exceptions;
using NetGlade.Onboarding.DummyDevice.Models;
using NetGlade.Onboarding.DummyDevice.Services.Abstractions;

namespace NetGlade.Onboarding.DummyDevice.Areas.Users;

public class UsersHandler : IHandler
{
    private readonly ApplicationDbContext _context;
    private readonly UserManager<ApplicationUser> _userManager;
    private readonly RoleManager<IdentityRole> _roleManager;
    public UsersHandler(ApplicationDbContext context, UserManager<ApplicationUser> userManager, RoleManager<IdentityRole> roleManager)
    {
        _context = context;
        _userManager = userManager;
        _roleManager = roleManager;
    }

    public async Task<ActionResult> GiveAdminRights(string userId)
    {
        var user = await _userManager.FindByIdAsync(userId);
        if (user == null)
        {
            throw new InternalException("User doesn't exist!", 400, HttpStatusCode.BadRequest);
        }

        if (await _roleManager.RoleExistsAsync(UserRoles.Administrator) == false)
        {
            await _roleManager.CreateAsync(new IdentityRole(UserRoles.Administrator));
        }

        if (_userManager.IsInRoleAsync(user, UserRoles.Administrator).Result == false)
        {
            var result = await _userManager.AddToRoleAsync(user, UserRoles.Administrator);

            if (result.Succeeded == false)
            {
                throw new InternalException(result.ToString(), 1003, HttpStatusCode.InternalServerError);
            }
            return new OkResult();
        }
        else
        {
            throw new InternalException("User already has admin rights", 409, HttpStatusCode.Conflict);
        }


    }

    public async Task<IdentityResult> ArchiveUser(string userId, string adminId)
    {
        var user = await _userManager.FindByIdAsync(userId);
        if (user == null)
        {
            throw new InternalException("User doesn't exist", 400, HttpStatusCode.BadRequest);
        }
        if (user.IsDeleted == true)
        {
            throw new InternalException("User is already deleted", 400, HttpStatusCode.BadRequest);
        }
        user.IsDeleted = true;
        user.DeletedDate = DateTime.UtcNow;
        user.DeletedBy = adminId;
        user.FavouriteTelemetries.Clear();

        return await _userManager.UpdateAsync(user);
    }

    public async Task<IdentityResult> ReinstateUser(string userId)
    {
        var user = await _userManager.FindByIdAsync(userId);
        if (user == null)
        {
            throw new InternalException("User doesn't exist", 400, HttpStatusCode.BadRequest);
        }
        if (user.IsDeleted == false)
        {
            throw new InternalException("User is already active", 400, HttpStatusCode.BadRequest);
        }

        user.IsDeleted = false;
        user.DeletedDate = null;
        user.DeletedBy = null;

        return await _userManager.UpdateAsync(user);
    }

    public async Task<ActionResult> RemoveAdminRights(string userId)
    {
        var user = await _userManager.FindByIdAsync(userId);
        if (user == null)
        {
            throw new InternalException("User doesn't exist!", 400, HttpStatusCode.BadRequest);
        }

        if (_userManager.IsInRoleAsync(user, UserRoles.Administrator).Result == true)
        {
            var result = await _userManager.RemoveFromRoleAsync(user, UserRoles.Administrator);

            if (result.Succeeded == false)
            {
                throw new InternalException(result.ToString(), 1003, HttpStatusCode.InternalServerError);
            }
            return new OkResult();
        }
        else
        {
            throw new InternalException("User already doesn't have admin rights", 409, HttpStatusCode.Conflict);
        }

    }

    public async Task<IList<UserResponse>> GetAllUsers(string userId)
    {
        var users = await _context.Users
        .Where(x => x.Id != userId)
        .ToListAsync();

        var userRoles = await _context.UserRoles
            .Where(userRole => users.Select(user => user.Id).Contains(userRole.UserId))
            .Join(
                _context.Roles,
                userRole => userRole.RoleId,
                role => role.Id,
                (userRole, role) => new { userRole.UserId, RoleName = role.Name }
            )
            .ToListAsync();

        var responseUsers = users.Select(user => new UserResponse(
            user.Id,
            user.IsDeleted,
            user.UserName,
            userRoles
             .Where(userRole => userRole.UserId == user.Id)
             .Select(userRole => userRole.RoleName)
             .ToArray()
        )).ToList();

        return responseUsers;

    }
}
