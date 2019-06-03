using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SubcontractorDataComponents;
using DevExpress.Web;
using System.IO;

namespace SubcontractorPortal.WOrders
{
    public partial class SubbiePhotos1 : System.Web.UI.Page
    {
        public static string currentURL;
        public static string reorderURL;
        public static bool Reorder;
        public static string message, messageColor;
        public bool IsStaffMember = false;

        protected void Page_Load(object sender, EventArgs e)
        {
            string DocPath = null;

            currentURL = "/WOrders/SubbiePhotos.aspx?WOID=" + Request.QueryString["WOID"] + @"&OID=" + Request.QueryString["OID"] + @"&quoteID=" + Request.QueryString["quoteID"];

            message = null;
            messageColor = "green";            
            IsStaffMember = Users.IsStaffMember();

            if (!IsStaffMember)
            {
                Users.CheckUser(1);
            }


            


            if (Request.QueryString["WOID"] != null)
            {
                string WorkOrderID = Request.QueryString["WOID"];

                DocPath = DA.DocumentsPath;
                ASPxDataView1.Visible = false;
                ASPxDataView2.Visible = true;
                Parameter p = SqlDataSource2.SelectParameters["WorkOrderID"];
                SqlDataSource2.SelectParameters.Remove(p);
                SqlDataSource2.SelectParameters.Add("WorkOrderID", WorkOrderID);
                SqlDataSource2.DataBind();
            }

            string DocumentsPath = Server.MapPath(DA.DocumentsPath);
            string FilePath = null;

            if (Page.IsPostBack)
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

        protected void img_Load(object sender, EventArgs e)
        {
            /*
            ASPxBinaryImage img = sender as ASPxBinaryImage;
            DataViewItemTemplateContainer container = img.NamingContainer as DataViewItemTemplateContainer;

            string imgID = DataBinder.Eval(container.DataItem, "Insurance_Document_id").ToString();
            img.ClientSideEvents.Click = "function (s, e) {SetDelete(" + imgID + ", '" + img.ClientID + "'); }";
            if (Reorder)
            {
                img.Width = new Unit("128px");
                img.Height = new Unit("96px");
            }
            */
        }

        protected void ASPxImage1_Load(object sender, EventArgs e)
        {
            ASPxImage img = sender as ASPxImage;
            DataViewItemTemplateContainer container = img.NamingContainer as DataViewItemTemplateContainer;
            string imgID = DataBinder.Eval(container.DataItem, "Insurance_Document_id").ToString();
            img.ImageUrl = DA.DocumentsPath + DataBinder.Eval(container.DataItem, "FilePath").ToString();
            img.ClientSideEvents.Click = "function (s, e) {SetDelete(" + imgID + ", '" + img.ClientID + "'); }";
            if (Reorder)
            {
                img.Width = new Unit("128px");
                img.Height = new Unit("96px");
            }

        }

        protected void ASPxCallback1_Callback(object source, DevExpress.Web.CallbackEventArgs e)
        {
            int i;
            ASPxCheckBox chkBox = null;
            for (i = 0; i < ASPxDataView2.VisibleItems.Count; i++)
            {
                chkBox = ASPxDataView2.FindItemControl("IncludeInQuote", ASPxDataView2.VisibleItems[i]) as ASPxCheckBox;
                chkBox.Checked = true;
                chkBox.Value = true;
            }

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

                        NewFileName = DA.SubcontractorDocumentAddToDatabaseFromDisk(Convert.ToInt32(OrderID), e.UploadedFile.FileName, WorkOrderID, "Subcontractor Photos for WO - " + WorkOrderID, (int)DA.DocumentTypes.ContractorPictures);
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
                        DA.SubcontractorPhotoAddToDatabase(Convert.ToInt32(OrderID), e.UploadedFile.FileName, resizedImage, Convert.ToInt32(WorkOrderID), 0 , "Subcontractor Photos for WO - " + WorkOrderID);
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