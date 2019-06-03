using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.IO;
using System.Text;
using System.Configuration;
using System.Drawing;
using Winnovative.PdfCreator;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Net.Mail;
using System.Net;



namespace SubcontractorDataComponents
{
    // Data Access Components for Subby
    public partial class DA
    {
        public static SqlConnection mySQLConnection;
        public static SqlCommand myCommand;
        public static string sql;
        public static SqlDataReader myReader;
        public static string ConnStr = ConfigurationManager.ConnectionStrings["DataConnectionString"].ToString();
        public static string LoginConnStr = ConfigurationManager.ConnectionStrings["SessionConnectionString"].ToString();
        public static string DefaultPage = ConfigurationManager.AppSettings["DefaultPage"];
        public static string DefaultPageStaff = ConfigurationManager.AppSettings["DefaultPageStaff"];
        public static string WorkOrderTemplatePath = ConfigurationManager.AppSettings["WOTemplatePath"];
        public static string WorkOrderTemplateAU = ConfigurationManager.AppSettings["WOTemplateAU"];
        public static string WorkOrderTemplateAUMakeSafe = ConfigurationManager.AppSettings["WOTemplateAUMakeSafe"];

        public static string WorkOrderTemplateTVR = ConfigurationManager.AppSettings["WOTemplateTVR"];
        public static string WorkOrderTemplateTradecom = ConfigurationManager.AppSettings["WOTemplateTradecom"];

        public static string WorkOrderTemplateNZ = ConfigurationManager.AppSettings["WOTemplateNZ"];
        public static string WHSAU = ConfigurationManager.AppSettings["WHSAU"];
        public static string MakeSafeRiskAssessment = ConfigurationManager.AppSettings["MakeSafeRiskAssessment"];

        public static string WHSNZ = ConfigurationManager.AppSettings["WHSNZ"];
        public static string CompletionCertificateAU = ConfigurationManager.AppSettings["CompletionCertificateAU"];
        public static string CompletionCertificateMakeSafe = ConfigurationManager.AppSettings["CompletionCertificateMakeSafe"];
        public static string CompletionCertificateNZ = ConfigurationManager.AppSettings["CompletionCertificateNZ"];
        public static string TermsAndConditionsNZ = ConfigurationManager.AppSettings["TermsAndConditionsNZ"];
        public static string RiskAssessmentNZ = ConfigurationManager.AppSettings["RiskAssessmentNZ"];
        public static string TemporaryDocumentsFolder = "/TEMP";
        public static string MaincomServicesEmail = "services@maincom.net";
        public static string DocumentsPath = ConfigurationManager.AppSettings["DocumentsPath"];
        public static string siteURL = ConfigurationManager.AppSettings["siteURL"];

        public enum Countries { Australia = 1, NZ = 2};
        public enum GST { Australia = 10, NZ = 15 };
        public enum WorkOrderSection { Details = 1, WHS = 2, ComletionCertificate = 3, RiskAssessment = 4, TermsConditions = 5, MakeSafeRiskAssessment = 6 };
        public static readonly int DefaultCompanyID = 1926;
        public enum DocumentTypes { Pictures = 1, RequestforQuote = 5, AuthorisationToProceed = 7, EstimatesQuotes = 8, WorkOrder = 10, CouncilApproval = 101, Report = 1006, WHSStatement = 1023, CompletionCertificate = 1030, ComplianceCertificate = 1013, CreditorInvoice = 1004, ContractorPictures = 1012, SubcontractorReceipts = 1034 };
        public enum InvoiceTypes { DebtorCreditNote = 6, DebtorInvoice = 2, CreditorInvoice = 4 };
        public enum WorkOrderStatus {NotSpecified = 0, New = 300, InProgress = 350, CompleteRequest = 370, Completed = 400, InDispute = 425, Invoiced = 500, Cancelled = 600, DeclinedbySubby = 700};
        public enum EmailType { AcceptWorkOrder = 1, DeclineWorkOrder = 2, ChangeWorkOrderDates = 3, RequestVariation = 4, PartialInvoice = 5, FinalInvoice = 6 };
        public enum WhatToDoParameters { Zero = 0, VariationItems = 1, VariationPhotos = 2 };
        //public enum MaincomCompanies { MaincomServicesAU = 1926, MaincomNewZealand = 2756, Tradecom = 2283 }
        public enum MaincomCompanies { MaincomServicesAU = 1926, MaincomNewZealand = 2756, Tradecom = 1 }
        public enum MakeSafeType { MakeSafe = 1, Report = 2, Tests = 3 }

        public enum Clients { Suncorp = 2551, YOUI = 6753, Guild = 5565, NRMA = 493, NRMAQLD = 4335, NRMASYD = 4340, NRMANWC = 4342, NRMAWA = 4790, NRMARBI = 4765, NRMAECL = 8691, QBCC = 8778 }
        public enum Agents { IAG = 1, QBCC = 1115 }
        public enum States { NSW = 1, QLD = 2, VIC = 3, WA = 4, SA = 8, NZ = 9 }        


        public static readonly string DoNotReply = "<br><br>Do Not Reply To This Message As It Was Sent Automatically";
        public static bool UseDiskStorage = Convert.ToBoolean(ConfigurationManager.AppSettings["UseDiskStorage"]);

        public static string SMSUserName = "Maincom";
        public static string SMSPassword = "FJ7Un5LV";


        /// StoredProReader - function to execute any non complex stored pro with optional 1 or more parameters (separated with '|')        
        public static SqlDataReader StoredProReader(string sql, string DBConnection = null, string ParamName = null, string ParamValue = null)
        {
            SqlDataReader StoredProReader;
            string[] tmpName = null, tmpValue = null;
            string Connection;
            if (DBConnection != null)
            {
                Connection = DBConnection;
            }
            else
            {
                Connection = DA.ConnStr;
            }

            //Connection = DBConnection;

            bool UseMultipleParams = false;

            if (ParamName != null)
            {
                if (ParamName.Contains("|"))
                {
                    UseMultipleParams = true;
                    tmpName = ParamName.Split('|');
                    tmpValue = ParamValue.Split('|');
                }
            }

            mySQLConnection = new SqlConnection(Connection);
            mySQLConnection.Open();
            myCommand = new SqlCommand(sql, mySQLConnection) { CommandType = System.Data.CommandType.StoredProcedure };
            if (ParamName != null)
            {
                if (UseMultipleParams)
                {
                    if (tmpName != null)
                    {
                        for (int i = 0; i < tmpName.Length; i++)
                        {
                            if (tmpValue != null)
                            {
                                myCommand.Parameters.AddWithValue("@" + tmpName[i], tmpValue[i]);
                            }
                        }

                    }
                }
                else
                {
                    myCommand.Parameters.AddWithValue("@" + ParamName, ParamValue);
                }
            }
            StoredProReader = myCommand.ExecuteReader();
            myCommand.Dispose();
            myCommand = null;
            return StoredProReader;
        }
        /// String function to trim to Date format
        public static string ToDate(string Date)
        {
            string ToDate = null;

            try
            {
                if (Date != null)
                {
                    ToDate = Date.Substring(0, 10);
                }

            }
            catch (Exception)
            {
                
                
            }
            return ToDate; 
        }


        /// Execute simple stored procedure with no records to return. Accepts optional 1 or more parameteres with '|' as delimeter        
        public static bool StoredProExecute(string sql, string ParamName = null, string ParamValue = null)
        {
            bool StoredProExecute = false;
            string[] tmpName = null, tmpValue = null;
            bool UseMultipleParams = false;

            //try
            //{                 
            if (ParamName != null)
            {
                if (ParamName.Contains("|"))
                {
                    UseMultipleParams = true;
                    tmpName = ParamName.Split('|');
                    tmpValue = ParamValue.Split('|');
                }
            }

            mySQLConnection = new SqlConnection(ConnStr);
            mySQLConnection.Open();
            myCommand = new SqlCommand(sql, mySQLConnection) { CommandType = System.Data.CommandType.StoredProcedure };
            if (ParamName != null)
            {
                if (UseMultipleParams)
                {

                    for (int i = 0; i < tmpName.Length; i++)
                    {
                        if (tmpValue != null)
                        {
                            myCommand.Parameters.AddWithValue("@" + tmpName[i], tmpValue[i]);
                        }
                    }
                }
                else
                {
                    myCommand.Parameters.AddWithValue("@" + ParamName, ParamValue);
                }
            }
            myCommand.ExecuteNonQuery();
            myCommand.Dispose();
            myCommand = null;
            mySQLConnection.Close();
            mySQLConnection = null;
            StoredProExecute = true;
            //}
            //catch (Exception)
            //{

            //}
            return StoredProExecute;

        }

        /// Execute SQL query against database
        public static bool SQLExecuteNonQuery(string sql)
        {
            bool SQLExecuteNonQuery = false;
            try
            {
                mySQLConnection = new SqlConnection(ConnStr);
                mySQLConnection.Open();
                myCommand = new SqlCommand(sql, mySQLConnection) { CommandType = System.Data.CommandType.Text };
                myCommand.ExecuteNonQuery();
                myCommand.Dispose();
                myCommand = null;
                mySQLConnection.Close();
                mySQLConnection = null;
                return SQLExecuteNonQuery = true;
            }
            catch (Exception)
            {

            }
            return SQLExecuteNonQuery;
        }

        public static string SendSMS(string SMSUserName, string SMSPassword, string TOMobile, string SMSMessage)
        {
            WebClient client = new System.Net.WebClient();
            client.Headers.Add("user-agent", "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.2; .NET CLR 1.0.3705;)");
            client.QueryString.Add("username", SMSUserName);
            client.QueryString.Add("password", SMSPassword);
            client.QueryString.Add("to", TOMobile);
            client.QueryString.Add("from", "Maincom");
            client.QueryString.Add("message", SMSMessage);
            client.QueryString.Add("ref", "123");
            client.QueryString.Add("maxsplit", "2");
            string baseurl = "http://www.smsbroadcast.com.au/api-adv.php";
            Stream data = client.OpenRead(baseurl);
            StreamReader reader = new StreamReader(data);
            string s = reader.ReadToEnd();
            data.Close();
            reader.Close();
            return (s);

        }


        #region PDF Creator
        public static void ConvertURLToPDF(string URL, bool ShowHeader, bool ShowFooter, string PDFAuthor, string PDFTitle, string PDFFilePath)        
        {
            LicensingManager.LicenseKey = "DSY8LTw1LTstPiM9LT48Izw/IzQ0NDQ=";            
            string urlToConvert = URL;
            //create a PDF document     
            Document document = new Document();
            //optional settings for the PDF document like margins, compression level,
            //security options, viewer preferences, document information, etc        
            document.CompressionLevel = CompressionLevel.NormalCompression;
            document.Margins = new Margins(10, 10, 0, 0);
            //document.Security.CanPrint == true;
            //document.Security.UserPassword = "";
            document.DocumentInformation.Author = PDFAuthor;
            //document.DocumentInformation.Title = PDFTitle;
            document.ViewerPreferences.HideToolbar = false;
            
            //Add a first page to the document. The next pages will inherit the settings from this page 
            PdfPage Page = document.Pages.AddNewPage(PageSize.A4, new Margins(10, 10, 0, 0), PageOrientation.Portrait);
            PdfFont Font = document.Fonts.Add(new System.Drawing.Font(new System.Drawing.FontFamily("Times New Roman"), 10, System.Drawing.GraphicsUnit.Point));
            //add HTML header
            HtmlToPdfElement HtmlToPdfElement = new HtmlToPdfElement(0, 0, -1, -1, urlToConvert);
            AddElementResult addResult = Page.AddElement(HtmlToPdfElement);
            // Save to file code
            //document.Save(PDFFilePath);
            // Save to Response object            
            document.Save(HttpContext.Current.Response, false, PDFTitle);
            
            //recicle
            HtmlToPdfElement = null;
            Page = null;
            Font = null;
            addResult = null;
            document.Close();
            document = null;
        }

        #endregion


        public static string DocumentAddToDatabaseFromDisk(string OrderID, string WorkOrderID, string caption, int DocTypeID, string filename)
        {
            string DocumentAddToDatabaseFromDisk = null;
            mySQLConnection = new SqlConnection(ConnStr);
            mySQLConnection.Open();
            myCommand = new SqlCommand("Subcontractor_Document_Insert_From_Disk", mySQLConnection) { CommandType = System.Data.CommandType.StoredProcedure };
            myCommand.Parameters.AddWithValue("@OrderID", OrderID);
            myCommand.Parameters.AddWithValue("@WorkOrderID", WorkOrderID);
            myCommand.Parameters.AddWithValue("@SubcontractorID", ReadCookie("SubbyID"));
            myCommand.Parameters.AddWithValue("@caption", caption);
            myCommand.Parameters.AddWithValue("@DocTypeID", DocTypeID);
            myCommand.Parameters.AddWithValue("@created_by", ReadCookie("Username"));
            myCommand.Parameters.AddWithValue("@attach_filename", filename);
            myCommand.Parameters.Add("@NewFileName", SqlDbType.VarChar, 200);
            myCommand.Parameters["@NewFileName"].Direction = ParameterDirection.Output;
            myCommand.ExecuteNonQuery();
            try
            {
                DocumentAddToDatabaseFromDisk = myCommand.Parameters["@NewFileName"].Value.ToString();
            }
            catch (Exception)
            {

            }
            myCommand.Dispose();
            myCommand = null;
            mySQLConnection.Close();
            mySQLConnection = null;
            return DocumentAddToDatabaseFromDisk;

        }

        public static string GetCostGuideRegion(string orderID)
        {
            string GetCostGuideRegion = "1";
            SqlConnection SQLConnection = new SqlConnection(DA.ConnStr);
            SQLConnection.Open();
            SqlCommand myCommand = new SqlCommand("Get_CostGuide_Region_ID_By_Order_ID", SQLConnection) { CommandType = System.Data.CommandType.StoredProcedure };
            myCommand.Parameters.AddWithValue("@OrderID", orderID);
            SqlDataReader Reader = myCommand.ExecuteReader();
            while (Reader.Read())
            {
                if (!DBNull.Value.Equals(Reader["CostGuide_Region_ID"]))
                { GetCostGuideRegion = Reader["CostGuide_Region_ID"].ToString(); }
            }
            Reader.Close();
            myCommand.Dispose();
            myCommand = null;
            SQLConnection.Close();
            SQLConnection = null;

            return GetCostGuideRegion;

        }


        #region Work with Files

        public static string ReadFileToString(string FilePath)
        {
            string readFileToString = null;
            System.IO.FileInfo file = new System.IO.FileInfo(FilePath);

            if (file.Exists)
            {
                StreamReader streamReader = new StreamReader(FilePath);
                readFileToString = streamReader.ReadToEnd();
                streamReader.Close();
            }

            //try
            //{
            //    if (file.Exists)
            //    {
            //        StreamReader streamReader = new StreamReader(FilePath);
            //        readFileToString = streamReader.ReadToEnd();
            //        streamReader.Close();
            //    }
            //}
            //catch (Exception ex)
            //{

            //}
            return readFileToString;
        }

        public static void DeleteFileFromDisk(string FilePath)
        {
            System.IO.FileInfo file = new System.IO.FileInfo(FilePath);
            try
            {
                if (file.Exists)
                {
                    file.Delete();
                }
            }
            catch (Exception)
            {

            }
        }




        #endregion

        #region Cookies
        public static void SetCookie(string cookieName, string cookieValue)
        {
            HttpCookie cookie = new HttpCookie(cookieName) { Value = cookieValue };
            HttpContext.Current.Response.Cookies.Add(cookie);
        }
        public static string ReadCookie(string cookieName)
        {
            string readCookie = null;

            try
            {
                if (HttpContext.Current.Request.Cookies[cookieName] != null)
                {
                    if (HttpContext.Current.Request.Cookies[cookieName].Value != null)
                    {
                        readCookie = HttpContext.Current.Request.Cookies[cookieName].Value;
                        return readCookie;
                    }

                }
            }
            catch (Exception)
            {

            }
            return readCookie;
        }
        public static void RemoveAllCookies()
        {
            string[] currcookies = HttpContext.Current.Request.Cookies.AllKeys;
            foreach (string cookie in currcookies)
            {
                HttpContext.Current.Response.Cookies[cookie].Expires = DateTime.Now.AddDays(-1);
                HttpContext.Current.Response.Cookies[cookie].Value = null;
            }
        }
        #endregion

        public static string WOListCaption(string statusID = "0")
        {
            string WOListCaption = null;
            int status = int.Parse(statusID);

            switch (status)
            {
                case (int)DA.WorkOrderStatus.New:
                    WOListCaption = "New Work Orders";
                    break;
                case (int)DA.WorkOrderStatus.CompleteRequest:
                    WOListCaption = "Completed Work Orders";
                    break;
                case (int)DA.WorkOrderStatus.Completed:
                    WOListCaption = "Completed Work Orders";
                    break;
                case (int)DA.WorkOrderStatus.DeclinedbySubby:
                    WOListCaption = "New Work Orders";
                    break;
                case (int)DA.WorkOrderStatus.InProgress:
                    WOListCaption = "Work Orders in Progress";
                    break;
                case (int)DA.WorkOrderStatus.Invoiced:
                    WOListCaption = "Invoiced Work Orders";
                    break;
                case (int)DA.WorkOrderStatus.Cancelled:
                    WOListCaption = "Cancelled Work Orders";
                    break;

                default:
                    WOListCaption = "All Work Orders";
                    break;
            }

            return WOListCaption;

        }
    }



    public class Email
    {
        public const string fromAddress_Australia = "services@maincom.net";
        public const string fromAddress_NewZealand = "services@maincom.co.nz";
        public const string password_Australia = "S3rv!ces";
        public const string password_NewZealand = "M@innz12";

        public static bool SendEmail(string fromAddress, string toAddress, string subject, string body, string CCto = null)
        {
            bool SendEmail = false;
            string Sender = null;

            SmtpClient sc = new SmtpClient();
            MailMessage msg = new MailMessage();


            if (fromAddress == Email.fromAddress_NewZealand)
            {
                sc.Host = "mail.maincom.co.nz";
                sc.Credentials = new System.Net.NetworkCredential(fromAddress, password_NewZealand);
                Sender = "Maincom NZ";
            }
            else
            {
                sc.Host = "mail.maincom.net";
                sc.Credentials = new System.Net.NetworkCredential(fromAddress, password_Australia);
                Sender = "Maincom Services";
            }

            msg.From = new MailAddress(fromAddress, Sender);

            //msg.From = new MailAddress(fromAddress_Australia, fromAddress_Australia);

            //-- fix for only Estimator receives email. By default toAddress was Services
            //msg.To.Add(new MailAddress(toAddress, toAddress));

            if (CCto != null)
            {
                //msg.CC.Add(new MailAddress(CCto, CCto));
                //-- fix for only Estimator receives email. By default toAddress was Services
                msg.To.Add(new MailAddress(CCto, CCto));
            }

            //msg.To.Add(new MailAddress("abaranovski@maincom.net", "Andrei Baranovski"));
            msg.Subject = subject;
            msg.Body = body;
            msg.IsBodyHtml = true;
            sc.Send(msg);
            /*
            try
            {
                sc.Send(msg);
                SendEmail = true;
            }
            catch (Exception e)
            {                
                
            }
             */
            msg.Dispose();
            return SendEmail;
        }


    }



    public class Encryption
    {
        /// <summary>
        /// Generate a encrypted byte array in the specific length.
        /// </summary>
        /// <param name="ByteLength">If the specific byte length is not long enough, 
        /// the output byte array will set as zero length.</param>
        public static byte[] DESString(string String, int ByteLength)
        {
            try
            {
                byte[] ret = new byte[ByteLength];
                byte[] theString = ASCIIEncoding.ASCII.GetBytes(String);
                MemoryStream msIn = new System.IO.MemoryStream(theString);
                MemoryStream msOut = new System.IO.MemoryStream(ret, true);
                DES des = new DESCryptoServiceProvider() { Key = ASCIIEncoding.ASCII.GetBytes("!@#$%^&*") /*the key is hard-coded( 8 charts).*/, IV = ASCIIEncoding.ASCII.GetBytes("!@#$%^&*") /*the initialization vector is hard-coded(8 charts) as well.*/ };
                CryptoStream encStream = new CryptoStream(msOut, des.CreateEncryptor(des.Key, des.IV), CryptoStreamMode.Write);
                byte[] temp = new byte[ByteLength]; //This is intermediate storage for the encryption.
                int length_toWrite = msIn.Read(temp, 0, ByteLength);
                encStream.Write(temp, 0, length_toWrite);
                encStream.FlushFinalBlock();
                encStream.Close();
                ret = msOut.ToArray();
                msOut.Close();
                msIn.Close();
                return ret;
            }
            catch
            {
                throw new Exception("Error in processing password verification: ");
            }
        }
    }
    // Encription used in the old Visionary


    
}