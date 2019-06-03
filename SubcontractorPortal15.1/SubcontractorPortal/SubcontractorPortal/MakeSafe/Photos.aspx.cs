using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevExpress.Web;
using System.IO;
using SubcontractorDataComponents;

namespace SubcontractorPortal.MakeSafe
{
    public partial class Photos : System.Web.UI.Page
    {
        public string currentURL;
        public string message, messageColor;
        public bool IsStaffMember = false;

        protected void Page_Load(object sender, EventArgs e)
        {

            IsStaffMember = Users.IsStaffMember();
            currentURL = "/MakeSafe/Photos.aspx?WOID=" + Request.QueryString["WOID"] + @"&OID=" + Request.QueryString["OID"];
            message = null;
            messageColor = "green";


            string DocumentsPath = Server.MapPath(DA.DocumentsPath);
            string FilePath = null;


            if (Request.QueryString["delImg"] != null)
            {
                if (!IsStaffMember)
                {
                    string[] tmp = Request.QueryString["delImg"].Split('|');
                    for (int i = 0; i < tmp.Length; i++)
                    {
                        if (tmp != null)
                        {
                            if (DA.UseDiskStorage)
                            {
                                FilePath = DA.PhotoDeleteFromDatabaseAndDisk(tmp[i]);
                                FilePath = DocumentsPath + @"\" + FilePath;



                                if (File.Exists(FilePath))
                                {
                                    File.Delete(FilePath);
                                }
                                message = "Photo has been deleted";
                            }
                            else
                            {
                                if (DA.StoredProExecute("Insurance_Document_Delete", "DocID", tmp[i]))
                                {
                                    message = "Photo has been deleted";
                                }
                                else
                                {
                                    message = "Error in deleting Photo";
                                    messageColor = "red";
                                }

                            }

                        }
                    }
                }
            }

            if (Page.IsPostBack)
            {
                if (!IsStaffMember)
                {
                    foreach (string key in Request.Form)
                    {
                        if (key.StartsWith("Caption"))
                        {
                            string Delimiter = "Caption";
                            string[] tmp = key.Split(new[] { Delimiter }, StringSplitOptions.None);
                            string picCaption = Request.Form[key];
                            if (picCaption != null)
                            {
                                picCaption = picCaption.Replace("'", "");
                            }
                            if (DA.StoredProExecute("Insurance_Document_Update_Caption", "DocID|caption", String.Format("{0}|{1}", tmp[1], picCaption)))
                            {
                                message = "Captions have been updated";
                            }
                            else
                            {
                                message = "Error in updating Captions";
                                messageColor = "red";
                            }
                        }
                    }
                }
            }

            if (Request.QueryString["WOID"] != null)
            {

                if (DA.UseDiskStorage)
                {
                    ASPxDataView1.Visible = false;
                    ASPxDataView2.Visible = true;

                    try
                    {
                        Parameter p = SqlDataSource2.SelectParameters["DocPath"];
                        SqlDataSource2.SelectParameters.Remove(p);

                        SqlDataSource2.SelectParameters.Add("DocPath", DA.DocumentsPath);

                    }
                    catch (Exception)
                    {

                    }
                    SqlDataSource2.DataBind();
                }
                else
                {
                    ASPxDataView1.Visible = true;
                    ASPxDataView2.Visible = false;
                    Parameter p = SqlDataSource1.SelectParameters["SubbyID"];
                    SqlDataSource1.SelectParameters.Remove(p);
                    Parameter p2 = SqlDataSource1.SelectParameters["WorkOrderID"];
                    SqlDataSource1.SelectParameters.Remove(p2);
                    Parameter p3 = SqlDataSource1.SelectParameters["QuoteID"];
                    SqlDataSource1.SelectParameters.Remove(p3);

                    SqlDataSource1.SelectParameters.Add("SubbyID", DA.ReadCookie("SubbyID"));
                    SqlDataSource1.SelectParameters.Add("WorkOrderID", Request.QueryString["WOID"]);
                    SqlDataSource1.SelectParameters.Add("QuoteID", Request.QueryString["OID"]);

                    SqlDataSource1.DataBind();
                }
            }


        }


        protected void img_Load(object sender, EventArgs e)
        {
            ASPxBinaryImage img = sender as ASPxBinaryImage;
            DataViewItemTemplateContainer container = img.NamingContainer as DataViewItemTemplateContainer;

            string imgID = DataBinder.Eval(container.DataItem, "Insurance_Document_id").ToString();
            img.ClientSideEvents.Click = "function (s, e) {SetDelete(" + imgID + ", '" + img.ClientID + "'); }";
        }

        protected void ASPxImage1_Load(object sender, EventArgs e)
        {
            ASPxImage img = sender as ASPxImage;
            DataViewItemTemplateContainer container = img.NamingContainer as DataViewItemTemplateContainer;
            string imgID = DataBinder.Eval(container.DataItem, "Insurance_Document_id").ToString();
            //img.ImageUrl = DA.DocumentsPath + DataBinder.Eval(container.DataItem, "FilePath").ToString();
            img.ImageUrl = DataBinder.Eval(container.DataItem, "FilePath").ToString();
            img.ClientSideEvents.Click = "function (s, e) {SetDelete(" + imgID + ", '" + img.ClientID + "'); }";

        }


        protected void ASPxUploadControl1_FileUploadComplete(object sender, FileUploadCompleteEventArgs e)
        {
            string path;
            byte[] image;
            byte[] resizedImage;

            string documentpath = Server.MapPath(DA.DocumentsPath);
            string downloadpath = Server.MapPath(DA.TemporaryDocumentsFolder);
            string OrderID = DA.ReadCookie("OrderID");
            string WorkOrderID = HttpContext.Current.Request.QueryString["WOID"];
            //string QuoteID = HttpContext.Current.Request.QueryString["quoteID"];
            string QuoteID = "0";
            string NewFileName = null;
            Variation Variation = new Variation();

            IsStaffMember = Users.IsStaffMember();

            if (!IsStaffMember)
            {
                if (e.IsValid)
                {
                    if (!Directory.Exists(downloadpath))
                    {
                        Directory.CreateDirectory(downloadpath);
                    }

                    path = String.Format(@"{0}\{1}", downloadpath, e.UploadedFile.FileName);

                    e.UploadedFile.SaveAs(path);

                    //-- Get Variation Label and attach to caption                
                    //Variation = Variation.GetVariationDetails(QuoteID);

                    if (DA.UseDiskStorage)
                    {

                        NewFileName = DA.SubcontractorPhotoAddToDatabaseFromDisk(Convert.ToInt32(OrderID), e.UploadedFile.FileName, WorkOrderID, QuoteID, "Make Safe");
                        documentpath = documentpath + @"\" + DateTime.Now.Year.ToString() + @"\Insurance_document";

                        if (!Directory.Exists(documentpath))
                        {
                            Directory.CreateDirectory(documentpath);
                        }

                        image = DA.GetPhoto(path);
                        resizedImage = DA.GetCompressedImage(image);


                        documentpath = documentpath + @"\" + NewFileName;

                        if (File.Exists(path))
                        {

                            DA.ByteArrayToFile(documentpath, resizedImage);
                            //File.Copy(path, documentpath);
                        }

                    }
                    else
                    {
                        image = DA.GetPhoto(path);
                        resizedImage = DA.GetCompressedImage(image);
                        //DA.SubcontractorPhotoAddToDatabase(Convert.ToInt32(OrderID), e.UploadedFile.FileName, resizedImage, Convert.ToInt32(WorkOrderID), Convert.ToInt32(QuoteID), Variation.VersionLabel + ". ");
                    }

                    Variation = null;
                    // delete image from disk after processing to database
                    if (File.Exists(path))
                    {
                        File.Delete(path);
                    }

                }
            }
        }

    }
}