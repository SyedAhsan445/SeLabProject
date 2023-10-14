using Microsoft.AspNetCore.Authorization;

namespace ClothX.CustomAttributes
{
    // This attribute derives from the [Authorize] attribute, adding 
    // the ability for a user to specify an 'age' paratmer. Since authorization
    // policies are looked up from the policy provider only by string, this
    // authorization attribute creates is policy name based on a constant prefix
    // and the user-supplied age parameter. A custom authorization policy provider
    // (`MinimumAgePolicyProvider`) can then produce an authorization policy with 
    // the necessary requirements based on this policy name.
    internal class ClothXPermissionAuthorizeAttribute : AuthorizeAttribute
    {
        const string POLICY_PREFIX = "ClothXPermission";

        public ClothXPermissionAuthorizeAttribute(String permission) => Permission = permission;

        // Get or set the Age property by manipulating the underlying Policy property
        public String Permission
        {
            get
            {
                return Policy.Substring(POLICY_PREFIX.Length);



            }
            set
            {
                Policy = $"{POLICY_PREFIX}{value.ToString()}";
            }
        }
    }
}