using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using iTextSharp.text;
using iTextSharp.text.pdf;
using Microsoft.AspNetCore.Authorization;
using System.Data;
using ClothX.DbModels;

namespace ClothX.Controllers
{
	public class ReportController : Controller
	{

		private int totalCols = 0;
		private Document document = new Document();
		private Font font;
		private Font boldFont = new Font(Font.FontFamily.TIMES_ROMAN, 16, Font.BOLD);
		private Font textFont = new Font(Font.FontFamily.TIMES_ROMAN, 12);
		private PdfPTable table;
		private PdfPCell cell;
		private MemoryStream stream = new MemoryStream();


		UserManager<IdentityUser> _userManager;
		RoleManager<IdentityRole> _roleManager;

		public ReportController(IServiceProvider service)
		{
			_userManager = service.GetService<UserManager<IdentityUser>>();
			_roleManager = service.GetService<RoleManager<IdentityRole>>();
		}

		private PdfPCell GetHeaderCell(string txt)
		{
			cell = new PdfPCell(new Phrase(txt));
			cell.HorizontalAlignment = Element.ALIGN_CENTER;
			cell.BackgroundColor = new BaseColor(128, 128, 128);
			return cell;
		}
		private PdfPCell GetTableCell(string txt)
		{
			cell = new PdfPCell(new Phrase(txt));
			cell.HorizontalAlignment = Element.ALIGN_CENTER;
			return cell;
		}


		private Document TitlePage(ref Document document, string title, string header)
		{
			// Set page size, margins, author, date, title, header
			//document.SetPageSize(PageSize.A4);
			//document.SetMargins(30, 30, 30, 30);
			//document.AddAuthor("Umair Noor");
			//document.AddCreationDate();
			//document.AddTitle("PDF Report");
			//document.AddHeader("Title", "FYP Management System");

			document.SetPageSize(PageSize.A4);
			document.SetMargins(30, 30, 30, 30);
			document.AddAuthor("Software Square Society Development team");
			document.AddCreationDate();
			document.AddTitle(title);
			document.AddHeader("Title", header);



			//Adding title page
			document.NewPage();
			Paragraph Title = new Paragraph(header, boldFont);
			Title.SpacingBefore = 50f;
			Title.SpacingAfter = 50f;
			Title.Font.Size = 28;
			Title.Alignment = Element.ALIGN_CENTER;
			document.Add(Title);

			//string imageURL = "wwwroot/Images/logo.jpg";
			//iTextSharp.text.Image jpg = iTextSharp.text.Image.GetInstance(imageURL);
			//jpg.ScaleToFit(140f, 120f);
			//jpg.SpacingBefore = 10f;
			//jpg.SpacingAfter = 1f;
			//jpg.Alignment = Element.ALIGN_CENTER;

			//document.Add(jpg);



			Paragraph session = new Paragraph(DateTime.Now.ToString("dd-MM-yyyy"), textFont);
			session.SpacingBefore = 10f;
			session.SpacingAfter = 50f;
			session.Alignment = Element.ALIGN_CENTER;
			document.Add(session);


			//Paragraph submittedParagraph = new Paragraph("Created By:", boldFont);
			//submittedParagraph.SpacingBefore = 10f;
			//submittedParagraph.Font.Size = 16;
			//submittedParagraph.Alignment = Element.ALIGN_CENTER;
			//document.Add(submittedParagraph);


			//Paragraph nameParagraph = new Paragraph("Software Square Development Team", textFont);
			//nameParagraph.SpacingBefore = 10f;
			//nameParagraph.SpacingAfter = 80f;
			//nameParagraph.Font.Size = 14;
			//nameParagraph.Alignment = Element.ALIGN_CENTER;
			//document.Add(nameParagraph);


			//Paragraph submittedToParagraph = new Paragraph("Submitted To:", boldFont);
			//submittedToParagraph.SpacingBefore = 10f;
			//submittedToParagraph.Font.Size = 16;
			//submittedToParagraph.Alignment = Element.ALIGN_CENTER;
			//document.Add(submittedToParagraph);


			//Paragraph teacherParagraph = new Paragraph("Sir Samyan", textFont);
			//teacherParagraph.SpacingBefore = 10f;
			//teacherParagraph.SpacingAfter = 50f;
			//teacherParagraph.Font.Size = 14;
			//teacherParagraph.Alignment = Element.ALIGN_CENTER;
			//document.Add(teacherParagraph);

			Paragraph departmentParagraph = new Paragraph("Department of Computer Science", textFont);
			departmentParagraph.SpacingBefore = 80f;
			departmentParagraph.SpacingAfter = 10f;
			departmentParagraph.Font.Size = 18;
			departmentParagraph.Alignment = Element.ALIGN_CENTER;
			document.Add(departmentParagraph);

			Paragraph uetParagraph = new Paragraph("University of Engineering And Technology, Lahore", boldFont);
			uetParagraph.SpacingBefore = 10f;
			uetParagraph.SpacingAfter = 10f;
			uetParagraph.Font.Size = 24;
			uetParagraph.Alignment = Element.ALIGN_CENTER;
			document.Add(uetParagraph);

			return document;
		}


		private Document CoursesTable(Document document, string titleText, List<ClientOrder> orders)
		{
			try
			{
				document.NewPage();
				Paragraph title = new Paragraph(titleText, boldFont);
				title.SpacingBefore = 20f;
				title.SpacingAfter = 20f;
				title.Font.Size = 20;
				title.Alignment = Element.ALIGN_CENTER;
				document.Add(title);


				totalCols = 5;
				table = new PdfPTable(totalCols);
				table.WidthPercentage = 100;


				table.AddCell(GetHeaderCell("User"));
				table.AddCell(GetHeaderCell("Order"));
				table.AddCell(GetHeaderCell("Order Type"));
				table.AddCell(GetHeaderCell("Price"));
				table.AddCell(GetHeaderCell("Status"));


				foreach (var o in orders)
				{
					table.AddCell(GetTableCell(o.Client.FirstName + " " + o.Client.LastName));
					table.AddCell(GetTableCell(o.Title));
					table.AddCell(GetTableCell(o.OrderTypeNavigation.Name));
					table.AddCell(GetTableCell(o.Price.ToString()));
					if (o.IsActive == false)
					{
						table.AddCell(GetTableCell("In-Active"));
					}
					else if (o.IsDelivered == true)
					{
						table.AddCell(GetTableCell("Delivered"));
					}
					else if (o.IsConfirmed == true)
					{
						table.AddCell(GetTableCell("Confirmed"));
					}
					else if (o.IsPaid == true)
					{
						table.AddCell(GetTableCell("Paid"));
					}
					else
					{
						table.AddCell(GetTableCell("Not Paid"));
					}
				}

				document.Add(table);

			}
			catch (Exception ex)
			{
				TempData["Message"] = "Error While Saving Changes";
				TempData["Class"] = "alert-danger";
			}

			return document;
		}
		//[Authorize(Roles = "Admin")]
		public IActionResult Order(bool Month = true)
		{
			PdfWriter.GetInstance(document, stream);
			document.Open();
			//document = TitlePage(ref document, "Courses", "Courses Report");

			// Report Body Function Calling Starts

			ClothXDbContext db = new ClothXDbContext();
			var orders = db.ClientOrders.Where(x => x.IsActive == true && x.AddedOn.Year == DateTime.Now.Year).ToList();
			if (Month == true)
			{
				orders = orders.Where(x => x.AddedOn.Month == DateTime.Now.Month).ToList();
			}
			//var courses = db.Courses.ToList();
			document = CoursesTable(document, Month == true ? "Monthly Orders Report" : "Yearly Orders Report", orders);

			// Report Body Function Calling Ends

			document.Close();
			byte[] abytes = stream.ToArray();
			return File(abytes, "application/pdf");
		}


	}
}
