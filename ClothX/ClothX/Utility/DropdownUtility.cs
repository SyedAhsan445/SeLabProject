namespace ClothX.Utility
{
    public class DropdownUtility
    {
        private static DropdownUtility _instance;

        public static DropdownUtility Instance
        {
            get
            {
                if (_instance == null)
                    _instance = new DropdownUtility();
                return _instance;
            }
        }

        private DropdownUtility() { }
    }
}
