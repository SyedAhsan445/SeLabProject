using ClothX.Constants;
using ClothX.Utility;

namespace ClothX.Services
{
    public class UploadFileService
    {
        private static UploadFileService _instance;

        public static UploadFileService Instance
        {
            get
            {
                if (_instance == null)
                    _instance = new UploadFileService();
                return _instance;
            }
        }

        private UploadFileService() { }

        public async Task<string> AddImageToFolder(IFormFile image, List<FilePathEnum> folderPath, IWebHostEnvironment webHost)
        {
            var webRootPath = webHost.WebRootPath;
            string path = "";
            foreach (var fPath in folderPath)
            {
                path += fPath.ToString();
            }
            var WebFolder = Path.Combine(webRootPath, path);

            if (!Directory.Exists(WebFolder))
            {
                Directory.CreateDirectory(WebFolder);
            }

            var imagesFolder = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot", path);
            var fileName = Path.Combine(imagesFolder, $"{Guid.NewGuid().ToString()}{Path.GetExtension(image.FileName)}");

            string uploadFilePath = Path.Combine(Directory.GetCurrentDirectory(), WebFolder, fileName);
            using (FileStream file = new FileStream(uploadFilePath, FileMode.Create))
            {
                image.CopyTo(file);
            }
            path = "/" + path + fileName;

            return path;
        }
    }
}
