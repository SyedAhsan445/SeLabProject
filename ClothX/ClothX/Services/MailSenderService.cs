﻿using System.Net.Mail;
using System.Net;

namespace ClothX.Services
{
    public class MailSenderService
    {
        private static MailSenderService _instance;
        private static SmtpClient smtpClient;

        private static string emailAddress = "unoor2398@gmail.com";
        private static string password = "";

        public static MailSenderService Instance
        {
            get
            {
                if (_instance == null)
                {
                    _instance = new MailSenderService();
                    smtpClient = new SmtpClient();
                    smtpClient.Port = 587;
                    smtpClient.Host = "smtp.gmail.com";
                    smtpClient.EnableSsl = true;
                    smtpClient.Timeout = 30000;
                    smtpClient.DeliveryMethod = SmtpDeliveryMethod.Network;
                    smtpClient.UseDefaultCredentials = false;
                    smtpClient.Credentials = new NetworkCredential(emailAddress, password);
                }
                return _instance;
            }
        }

        private MailSenderService() { }

        public async Task TestEmailSend()
        {
            MailMessage mail = new MailMessage();
            mail.From = new MailAddress(emailAddress);
            mail.To.Add(emailAddress);
            mail.Subject = "This is used for Testing Email Sending Services";
            mail.IsBodyHtml = true;



            string content = "Testing Completing";

            mail.Body = content;
            await smtpClient.SendMailAsync(mail);
        }

        public async Task SendMailToUserOnRegister(string Email, string Name, string code)
        {
            MailMessage mail = new MailMessage();
            mail.From = new MailAddress(emailAddress);
            mail.To.Add(Email);
            mail.Subject = "Registration on ClothX";
            mail.IsBodyHtml = true;



            string content = "";

            mail.Body = content;
            smtpClient.Send(mail);
        }

    }
}
