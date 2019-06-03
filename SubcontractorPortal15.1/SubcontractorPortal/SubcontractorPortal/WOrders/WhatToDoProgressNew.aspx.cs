using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SubcontractorDataComponents;
using DevExpress.Web;
using DevExpress.Web.Data;
using System.IO;

namespace SubcontractorPortal.WOrders
{
    public partial class WhatToDoProgressNew : System.Web.UI.Page
    {
        public string UpdateAudit = null, URL = null, URL2 = null, quoteID = null;
        public bool IsStaffMember = false;
        public string currentURL;

        protected void Page_Load(object sender, EventArgs e)
        {
            IsStaffMember = Users.IsStaffMember();
            string Phone = null, Mobile = null;
            string fromAddress = null;
            string SubcontractorDetail = null;

            //string WorkOrderID = DA.ReadCookie("WOID");
            string WorkOrderID = Request.QueryString["WOID"];

            string OrderID = null;
            string quoteID = Request.QueryString["quoteID"];
            bool ShowCompleteButton = false;
            WHSOk.Visible = false;

            WOStatusLbl.Text = "Work Order In Progress";
            DeclineLbl.Visible = false;
            WHSLabel.Visible = false;
            //SignOffNumber.Visible = false;
            //SubmitNumberButton.Visible = false;
            CertificateOk.Visible = false;
            ComplianceOk.Visible = false;
            //InvoiceOk.Visible = false;
            CompleteBtn.Visible = false;
            PhotosOk.Visible = false;
            ReceiptsOk.Visible = false;

            bool VariationLocked = false;

            WorkOrder WorkOrder = new WorkOrder();
            Variation Variation = new Variation();
            //List<WorkOrderItem> WorkOrderItems = new List<WorkOrderItem>();
            Dictionary<string, string> LookUpDictionary = new Dictionary<string, string>();

            if (WorkOrderID != null)
            {

                WorkOrder = WorkOrder.GetWorkOrderDetails(WorkOrderID, ref LookUpDictionary, true, SignedBy.Text, FullName.Text);

                // top level label with WO details
                WODetail.Text = "Work Order No: " + WorkOrderID + ". Insured: " + WorkOrder.Insured + ". Address: " + WorkOrder.PropertyAddress;
                InsuranceDetail.Text = "Insurance Company: " + WorkOrder.InsuranceCompany + ". Event caused damage: " + WorkOrder.EventType;

                if (WorkOrder.WHS > 0)
                {
                    WHSOk.Visible = true;
                    WHSButton.Visible = false;
                }

                if (WorkOrder.CompletionCertificate > 0)
                {
                    CertificateOk.Visible = true;
                }

                if (WorkOrder.ComplianceCertificate > 0)
                {
                    ComplianceOk.Visible = true;
                }
                /*
                if (WorkOrder.CreditorInvoice > 0)
                {
                    InvoiceOk.Visible = true;
                }
                */
                //if (WorkOrder.WHS > 0 && WorkOrder.CompletionCertificate > 0 && WorkOrder.CreditorInvoice > 0)

                if (WorkOrder.ComplianceRequired)
                {
                    ComplianceSpan.InnerHtml = "- <b>Required!</b>";
                }
                else
                {
                    ComplianceSpan.InnerHtml = "(If Required)";
                }

                if (WorkOrder.PhotosRequired)
                {
                    PhotosSpan.InnerHtml = "- <b>Required!</b>";
                }
                else
                {
                    PhotosSpan.InnerHtml = "(If Required)";
                }

                if (WorkOrder.DocsRequired)
                {
                    DocsSpan.InnerHtml = "- <b>Required!</b>";
                }
                else
                {
                    DocsSpan.InnerHtml = "(If Required)";
                }

                if (WorkOrder.WHS > 0 && WorkOrder.CompletionCertificate > 0)
                {
                    if (WorkOrder.ComplianceRequired)
                    {
                        
                        if (WorkOrder.ComplianceCertificate > 0)
                        {
                            CompleteBtn.Visible = true;
                            ComplianceOk.Visible = true;
                            ShowCompleteButton = true;
                        }
                        else
                        {
                            ComplianceOk.Visible = false;
                            ShowCompleteButton = false;
                        }
                    }
                    else
                    {
                        
                        CompleteBtn.Visible = true;
                        ShowCompleteButton = true;
                    }

                    if (ShowCompleteButton)
                    {
                        if (WorkOrder.PhotosRequired)
                        {
                            
                            if (WorkOrder.ContractorPictures > 0)
                            {
                                CompleteBtn.Visible = true;
                                PhotosOk.Visible = true;
                                ShowCompleteButton = true;
                            }
                            else
                            {
                                CompleteBtn.Visible = false;
                                PhotosOk.Visible = false;
                                ShowCompleteButton = false;
                            }
                        }
                        else
                        {
                            
                            CompleteBtn.Visible = true;
                            ShowCompleteButton = true;
                        }
                    }

                    if (ShowCompleteButton)
                    {
                        if (WorkOrder.DocsRequired)
                        {
                            
                            if (WorkOrder.SubcontractorReceipts > 0)
                            {
                                CompleteBtn.Visible = true;
                                ReceiptsOk.Visible = true;
                                ShowCompleteButton = true;
                            }
                            else
                            {
                                CompleteBtn.Visible = false;
                                ShowCompleteButton = false;
                                ReceiptsOk.Visible = false;
                            }
                        }
                        else
                        {
                            CompleteBtn.Visible = true;
                            ShowCompleteButton = true;
                        }
                    }



                }

                OrderID = WorkOrder.OrderID;
                DA.SetCookie("OID", OrderID);

                if (!String.IsNullOrEmpty(WorkOrder.InsuredMobile))
                {
                    WorkOrder.InsuredMobile = WorkOrder.InsuredMobile.Replace(" ", "");
                    //SendTo.Items.Add("Insured / Owner", WorkOrder.InsuredMobile);
                    //SendTo.Items.Add("Insured / Owner", "0403383547");
                }
                if (!String.IsNullOrEmpty(WorkOrder.EstimatorMobile))
                {
                    WorkOrder.EstimatorMobile = WorkOrder.EstimatorMobile.Replace(" ", "");
                    //SendTo.Items.Add("Supervisor", WorkOrder.EstimatorMobile);
                }

                if (String.IsNullOrEmpty(WorkOrder.InsuredMobile) && String.IsNullOrEmpty(WorkOrder.EstimatorMobile))
                {
                    //SMSTable.Visible = false;
                }

                //-- temp block of SMS send tabvle
                //SMSTable.Visible = false;

                if (WorkOrder.CompanyID == (int)DA.MaincomCompanies.MaincomNewZealand)
                {
                    fromAddress = Email.fromAddress_NewZealand;
                }
                else
                {
                    fromAddress = Email.fromAddress_Australia;
                }


                InsuredLbl.Text = WorkOrder.Insured;
                if (WorkOrder.InsuredMobile != null)
                {
                    Mobile = "Mobile - " + WorkOrder.InsuredMobile;
                }
                if (WorkOrder.InsuredPhone != null && WorkOrder.InsuredPhone.Length > 0)
                {
                    Phone = ", Phone - " + WorkOrder.InsuredPhone;
                }

                ContactOnLbl.Text = Mobile + Phone;
                SubcontractorDetail = WorkOrder.SubcontractorName + " (phone:" + WorkOrder.SubcontractorPhone + ", mobile: " + WorkOrder.SubcontractorMobile + ", email: " + WorkOrder.SubcontractorEmail + ")";

                if (!Page.IsPostBack)
                {
                    WOStart.Date = Convert.ToDateTime(WorkOrder.WorkOrderStartDate);
                    WOFinish.Date = Convert.ToDateTime(WorkOrder.WorkOrderCompleteDate);
                }
                URL = "&WOID=" + WorkOrderID + "&OID=" + OrderID;

            }

            PhotoPanel.Visible = false;
            PanelItemsNavigation.Visible = false;
            PanelVariationItems.Visible = false;
            GotoItemsBtn.Visible = false;
            //PanelVariations.Visible = true;

            int Parameter = 0;
            if (Request.QueryString["p"] != null)
            {
                Parameter = Convert.ToInt32(Request.QueryString["p"]);
            }

            //-- Load variation items
            if (Request.QueryString["quoteID"] != null)
            {
                quoteID = Request.QueryString["quoteID"];
                URL2 = URL + "&quoteID=" + quoteID;


                if (Request.QueryString["rowIndex"] != null)
                {
                    ASPxGridViewVariations.FocusedRowIndex = Convert.ToInt32(Request.QueryString["rowIndex"]);
                    //URL = URL + "&rowIndex=" + Request.QueryString["rowIndex"];
                    URL2 = URL2 + "&rowIndex=" + Request.QueryString["rowIndex"];
                }

                if (Parameter == (int)DA.WhatToDoParameters.VariationItems)
                {
                    PanelItemsNavigation.Visible = true;
                    PanelVariationItems.Visible = true;
                    PhotoPanel.Visible = false;
                    quoteID = Request.QueryString["quoteID"];
                    Variation = Variation.GetVariationDetails(quoteID);
                    //-- Check if Variation locked or nor
                    //VariationLocked = 
                    if (Variation.SubbyStatus > 0)
                    {
                        VariationLocked = true;
                        EmailBtn.Visible = false;
                        AddItemBtn.Visible = false;
                        ASPxGridViewItems.Columns[0].Visible = false;

                    }


                    ASPxGridViewItems.Caption = Variation.VariationCaption;
                }

                if (Parameter == (int)DA.WhatToDoParameters.VariationPhotos)
                {
                    AddItemBtn.Visible = false;
                    GotoItemsBtn.Visible = true;
                    PanelVariationItems.Visible = false;
                    PanelItemsNavigation.Visible = true;
                    PhotoPanel.Visible = true;

                }

            }


            /*
            Response.Write("OrderID=" + WorkOrderID.ToString());
            Response.Write("SubbyID=" + DA.ReadCookie("SubbyID"));
            */
            if (Page.IsPostBack && !Page.IsCallback)
            {
                string ActionWO = Request.Form["ActionWO"];
                if (!IsStaffMember)
                {
                    if (ActionWO == "1")
                    {
                        //-- Record change dates in database
                        WorkOrder.ChangeDates(OrderID, WorkOrderID, ChangeDateReason.Text, WOStart.Date.ToString("s"), WOFinish.Date.ToString("s"));
                        WorkOrder.EmailRequestChangedDates(WorkOrder.OrderID, WorkOrderID, WorkOrder.SearchCode, fromAddress, ChangeDateReason.Text, WorkOrder.WorkOrderStartDate, WorkOrder.WorkOrderCompleteDate, WOStart.Date.ToString(), WOFinish.Date.ToString(), SubcontractorDetail, WorkOrder.EstimatorEmail);
                        AcceptLbl.Visible = true;
                        //AcceptLbl.Text = "Work Order Dates has been changed by subcontractor. <br>Notification has been sent to Supervisor.";
                        AcceptLbl.Text = "Request for changing Work Order Dates has been sent to Maincom.";
                        UpdateAudit = "parent.UpdateAudit();";
                    }

                    if (ActionWO == "2")
                    {
                        //-- Record variation request
                        WorkOrder.VariationRequestToAudit(OrderID, WorkOrderID, quoteID);
                        WorkOrder.EmailRequestForVariation(WorkOrderID, WorkOrder.SearchCode, fromAddress, WorkOrder.EstimatorEmail, SubcontractorDetail, WorkOrder.EstimatorEmail);
                        AcceptLbl.Visible = true;
                        AcceptLbl.Text = "Variation Request has been sent to Supervisor.";
                        UpdateAudit = "parent.UpdateAudit(); Navigate(0);";

                    }

                    //-- Complete Work Order
                    if (ActionWO == "3")
                    {
                        //-- Record change dates in database
                        //WorkOrder.CompleteWorkOrder(OrderID, WorkOrderID);

                        WorkOrder.CompleteWorkOrderWithPublicHolidays(OrderID, WorkOrderID);

                        WorkOrder.EmailRequestToCompleteWorkOrder(WorkOrderID, WorkOrder.SearchCode, fromAddress, WorkOrder.EstimatorEmail, SubcontractorDetail, WorkOrder.EstimatorEmail);
                        AcceptLbl.Visible = true;
                        AcceptLbl.Text = "Request to Invoice Work Order has been sent to Supervisor.";
                        UpdateAudit = "parent.UpdateAudit();";
                    }

                    //-- Send message to Maincom
                    if (ActionWO == "4")
                    {
                        WorkOrder.MessageToMaincom(OrderID, WorkOrderID, Message.Text);
                        WorkOrder.EmailMessageToMaincom(WorkOrderID, WorkOrder.SearchCode, fromAddress, Message.Text, SubcontractorDetail, WorkOrder.EstimatorEmail);
                        //Panel1.Visible = false;
                        Message.Text = null;
                        DeclineLbl.Visible = false;
                        AcceptLbl.Visible = true;
                        AcceptLbl.Text = "Message has been sent to Maincom.";
                        UpdateAudit = "parent.UpdateAudit();";
                    }

                    //-- Send WHS to Maincom
                    if (ActionWO == "5")
                    {
                        //WorkOrder.MessageToMaincom(OrderID, WorkOrderID, Message.Text);
                        //WorkOrder.EmailMessageToMaincom(WorkOrderID, WorkOrder.SearchCode, fromAddress, Message.Text, SubcontractorDetail, WorkOrder.EstimatorEmail);
                        //Panel1.Visible = false;
                        int Country = 1;
                        bool DocSaved = false;
                        string DiskFileName = null;
                        if (WorkOrder.CompanyID == (int)DA.MaincomCompanies.MaincomNewZealand)
                        {
                            Country = (int)DA.Countries.NZ;
                        }

                        string WorkOrderHTML = WorkOrder.WorkOrderDetailstoHTML(LookUpDictionary, (int)DA.WorkOrderSection.WHS, Country);
                        WorkOrder.ConvertHTMLStringToPDF(OrderID, WorkOrderHTML, DA.siteURL, Session.SessionID, false, true, Session.SessionID, ref DiskFileName);
                        DocSaved = WorkOrder.DocumentSaveToDatabase(OrderID, WorkOrderID, DiskFileName, "WHS Statement for WO - " + WorkOrderID + ".pdf", (int)DA.DocumentTypes.WHSStatement);

                        if (DocSaved)
                        {
                            Message.Text = null;
                            DeclineLbl.Visible = false;
                            AcceptLbl.Visible = false;
                            WHSButton.Visible = false;
                            WHSLabel.Visible = true;
                            WHSOk.Visible = true;
                            WHSLabel.Text = "WHS Statement has been sent to Maincom.";
                            UpdateAudit = "parent.UpdateAudit();";
                        }
                        else
                        {
                            WHSLabel.Visible = true;
                            WHSLabel.Text = "Error! Could not save WHS Statement.";

                        }
                    }

                    //-- Send Authorisation Code to Owner --> code removed see SubcontractorPortal1                   
                    

                }


            }

            LookUpDictionary = null;
            Variation = null;
            WorkOrder = null;


        }

        protected void grid_RowInserting(object sender, ASPxDataInsertingEventArgs e)
        {
            ASPxGridView grid = sender as ASPxGridView;
            ASPxMemo VariationReason = grid.FindEditFormTemplateControl("VariationReason") as ASPxMemo;
            e.NewValues["details_and_Circumstances"] = VariationReason.Text;
            if (IsStaffMember)
            {
                e.Cancel = true;
            }

        }

        protected void ASPxGridViewItems_RowInserting(object sender, ASPxDataInsertingEventArgs e)
        {
            ASPxGridView grid = sender as ASPxGridView;

            ASPxComboBox cRoom = grid.FindEditFormTemplateControl("cRoom") as ASPxComboBox;
            e.NewValues["room_id"] = cRoom.Value;

            ASPxComboBox cTrade = grid.FindEditFormTemplateControl("cTrade") as ASPxComboBox;
            e.NewValues["Insurance_Trade_Id"] = cTrade.Value;

            ASPxMemo clong_desc = grid.FindEditFormTemplateControl("clong_desc") as ASPxMemo;
            e.NewValues["long_desc"] = clong_desc.Text;

            ASPxSpinEdit cm_quantity = grid.FindEditFormTemplateControl("cm_quantity") as ASPxSpinEdit;
            e.NewValues["m_quantity"] = cm_quantity.Text;

            ASPxComboBox cm_unit = grid.FindEditFormTemplateControl("cm_unit") as ASPxComboBox;
            e.NewValues["m_unit"] = cm_unit.Value;

            ASPxSpinEdit cm_rate = grid.FindEditFormTemplateControl("cm_rate") as ASPxSpinEdit;
            e.NewValues["m_rate"] = cm_rate.Text;

            ASPxSpinEdit cl_quantity = grid.FindEditFormTemplateControl("cl_quantity") as ASPxSpinEdit;
            e.NewValues["l_quantity"] = cl_quantity.Text;

            ASPxComboBox cl_unit = grid.FindEditFormTemplateControl("cl_unit") as ASPxComboBox;
            e.NewValues["l_unit"] = cl_unit.Value;

            ASPxSpinEdit cl_rate = grid.FindEditFormTemplateControl("cl_rate") as ASPxSpinEdit;
            e.NewValues["l_rate"] = cl_rate.Text;

            if (IsStaffMember)
            {
                e.Cancel = true;
            }


        }

        protected void ASPxGridViewItems_RowUpdating(object sender, ASPxDataUpdatingEventArgs e)
        {
            ASPxGridView grid = sender as ASPxGridView;

            ASPxComboBox cRoom = grid.FindEditFormTemplateControl("cRoom") as ASPxComboBox;
            e.NewValues["room_id"] = cRoom.Value;

            ASPxComboBox cTrade = grid.FindEditFormTemplateControl("cTrade") as ASPxComboBox;
            e.NewValues["Insurance_Trade_Id"] = cTrade.Value;

            ASPxMemo clong_desc = grid.FindEditFormTemplateControl("clong_desc") as ASPxMemo;
            e.NewValues["long_desc"] = clong_desc.Text;

            ASPxSpinEdit cm_quantity = grid.FindEditFormTemplateControl("cm_quantity") as ASPxSpinEdit;
            e.NewValues["m_quantity"] = cm_quantity.Text;

            ASPxComboBox cm_unit = grid.FindEditFormTemplateControl("cm_unit") as ASPxComboBox;
            e.NewValues["m_unit"] = cm_unit.Value;

            ASPxSpinEdit cm_rate = grid.FindEditFormTemplateControl("cm_rate") as ASPxSpinEdit;
            e.NewValues["m_rate"] = cm_rate.Text;

            ASPxSpinEdit cl_quantity = grid.FindEditFormTemplateControl("cl_quantity") as ASPxSpinEdit;
            e.NewValues["l_quantity"] = cl_quantity.Text;

            ASPxComboBox cl_unit = grid.FindEditFormTemplateControl("cl_unit") as ASPxComboBox;
            e.NewValues["l_unit"] = cl_unit.Value;

            ASPxSpinEdit cl_rate = grid.FindEditFormTemplateControl("cl_rate") as ASPxSpinEdit;
            e.NewValues["l_rate"] = cl_rate.Text;

            if (IsStaffMember)
            {
                e.Cancel = true;
            }


        }

        protected void ASPxGridViewItems_RowDeleting(object sender, ASPxDataDeletingEventArgs e)
        {
            if (IsStaffMember)
            {
                e.Cancel = true;
            }

        }

        protected void UploadCertificate_FileUploadComplete(object sender, DevExpress.Web.FileUploadCompleteEventArgs e)
        {
            string path;
            string documentpath = Server.MapPath(DA.DocumentsPath);
            string downloadpath = Server.MapPath(DA.TemporaryDocumentsFolder);
            string OrderID = DA.ReadCookie("OrderID");
            string WorkOrderID = HttpContext.Current.Request.QueryString["WOID"];
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

                    NewFileName = DA.SubcontractorDocumentAddToDatabaseFromDisk(Convert.ToInt32(OrderID), e.UploadedFile.FileName, WorkOrderID, "Completion Certificate for WO - " + WorkOrderID, (int)DA.DocumentTypes.CompletionCertificate);
                    documentpath = documentpath + @"\" + DateTime.Now.Year.ToString() + @"\Insurance_document";

                    if (!Directory.Exists(documentpath))
                    {
                        Directory.CreateDirectory(documentpath);
                    }

                    //image = DA.GetPhoto(path);
                    //resizedImage = DA.GetCompressedImage(image);

                    documentpath = documentpath + @"\" + NewFileName;

                    if (File.Exists(path))
                    {

                        //DA.ByteArrayToFile(documentpath, resizedImage);
                        File.Copy(path, documentpath);
                    }


                    // delete image from disk after processing to database
                    if (File.Exists(path))
                    {
                        File.Delete(path);
                    }

                }
            }
        }

        protected void UploadCompliance_FileUploadComplete(object sender, DevExpress.Web.FileUploadCompleteEventArgs e)
        {
            string path;
            string documentpath = Server.MapPath(DA.DocumentsPath);
            string downloadpath = Server.MapPath(DA.TemporaryDocumentsFolder);
            string OrderID = DA.ReadCookie("OrderID");
            string WorkOrderID = HttpContext.Current.Request.QueryString["WOID"];
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


                    NewFileName = DA.SubcontractorDocumentAddToDatabaseFromDisk(Convert.ToInt32(OrderID), e.UploadedFile.FileName, WorkOrderID, "Compliance Certificate for WO - " + WorkOrderID, (int)DA.DocumentTypes.ComplianceCertificate);
                    documentpath = documentpath + @"\" + DateTime.Now.Year.ToString() + @"\Insurance_document";

                    if (!Directory.Exists(documentpath))
                    {
                        Directory.CreateDirectory(documentpath);
                    }

                    //image = DA.GetPhoto(path);
                    //resizedImage = DA.GetCompressedImage(image);

                    documentpath = documentpath + @"\" + NewFileName;

                    if (File.Exists(path))
                    {

                        //DA.ByteArrayToFile(documentpath, resizedImage);
                        File.Copy(path, documentpath);
                    }


                    // delete image from disk after processing to database
                    if (File.Exists(path))
                    {
                        File.Delete(path);
                    }

                }
            }

        }

        protected void UploadPhotos_FileUploadComplete(object sender, DevExpress.Web.FileUploadCompleteEventArgs e)
        {
            string path;
            string documentpath = Server.MapPath(DA.DocumentsPath);
            string downloadpath = Server.MapPath(DA.TemporaryDocumentsFolder);
            string OrderID = DA.ReadCookie("OrderID");
            string WorkOrderID = HttpContext.Current.Request.QueryString["WOID"];
            string NewFileName = null;
            byte[] image;
            byte[] resizedImage;

            //Variation Variation = new Variation();

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

                    image = DA.GetPhoto(path);
                    resizedImage = DA.GetCompressedImage(image);


                    NewFileName = DA.SubcontractorDocumentAddToDatabaseFromDisk(Convert.ToInt32(OrderID), e.UploadedFile.FileName, WorkOrderID, "Subcontractor Photos for WO - " + WorkOrderID, (int)DA.DocumentTypes.ContractorPictures);
                    documentpath = documentpath + @"\" + DateTime.Now.Year.ToString() + @"\Insurance_document";

                    if (!Directory.Exists(documentpath))
                    {
                        Directory.CreateDirectory(documentpath);
                    }


                    documentpath = documentpath + @"\" + NewFileName;

                    if (File.Exists(path))
                    {

                        DA.ByteArrayToFile(documentpath, resizedImage);
                        //File.Copy(path, documentpath);
                    }


                    // delete image from disk after processing to database
                    if (File.Exists(path))
                    {
                        File.Delete(path);
                    }

                }
            }

        }

        protected void UploadReceipts_FileUploadComplete(object sender, DevExpress.Web.FileUploadCompleteEventArgs e)
        {
            string path;
            string documentpath = Server.MapPath(DA.DocumentsPath);
            string downloadpath = Server.MapPath(DA.TemporaryDocumentsFolder);
            string OrderID = DA.ReadCookie("OrderID");
            string WorkOrderID = HttpContext.Current.Request.QueryString["WOID"];
            string NewFileName = null;            

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

                    NewFileName = DA.SubcontractorDocumentAddToDatabaseFromDisk(Convert.ToInt32(OrderID), e.UploadedFile.FileName, WorkOrderID, "Subcontractor Receipt for WO - " + WorkOrderID, (int)DA.DocumentTypes.SubcontractorReceipts);
                    documentpath = documentpath + @"\" + DateTime.Now.Year.ToString() + @"\Insurance_document";

                    if (!Directory.Exists(documentpath))
                    {
                        Directory.CreateDirectory(documentpath);
                    }


                    documentpath = documentpath + @"\" + NewFileName;

                    if (File.Exists(path))
                    {                        
                        File.Copy(path, documentpath);
                    }

                    // delete image from disk after processing to database
                    if (File.Exists(path))
                    {
                        File.Delete(path);
                    }

                }
            }

        }

        protected void UploadInvoice_FileUploadComplete(object sender, DevExpress.Web.FileUploadCompleteEventArgs e)
        {
            string path;
            string documentpath = Server.MapPath(DA.DocumentsPath);
            string downloadpath = Server.MapPath(DA.TemporaryDocumentsFolder);
            string OrderID = DA.ReadCookie("OrderID");
            string WorkOrderID = HttpContext.Current.Request.QueryString["WOID"];
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


                    NewFileName = DA.SubcontractorDocumentAddToDatabaseFromDisk(Convert.ToInt32(OrderID), e.UploadedFile.FileName, WorkOrderID, "Creditor Invoice for WO - " + WorkOrderID, (int)DA.DocumentTypes.CreditorInvoice);
                    documentpath = documentpath + @"\" + DateTime.Now.Year.ToString() + @"\Insurance_document";

                    if (!Directory.Exists(documentpath))
                    {
                        Directory.CreateDirectory(documentpath);
                    }

                    //image = DA.GetPhoto(path);
                    //resizedImage = DA.GetCompressedImage(image);

                    documentpath = documentpath + @"\" + NewFileName;

                    if (File.Exists(path))
                    {

                        //DA.ByteArrayToFile(documentpath, resizedImage);
                        File.Copy(path, documentpath);
                    }


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