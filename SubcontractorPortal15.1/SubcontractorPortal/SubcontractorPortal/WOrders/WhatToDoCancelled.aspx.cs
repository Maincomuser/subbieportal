using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SubcontractorDataComponents;
using DevExpress.Web;
using DevExpress.Web.Data;


namespace SubcontractorPortal.WOrders
{
    public partial class WhatToDoCancelled : System.Web.UI.Page
    {
        public string UpdateAudit = null, URL = null, URL2 = null, quoteID = null;
        public bool IsStaffMember = false;
        protected void Page_Load(object sender, EventArgs e)
        {
            
            IsStaffMember = Users.IsStaffMember();

            string Phone = null, Mobile = null, WOStatus = null;
            string fromAddress = null;
            //string WorkOrderID = DA.ReadCookie("WOID");
            string WorkOrderID = Request.QueryString["WOID"];

            string OrderID = null;
            string quoteID = Request.QueryString["quoteID"];
            bool VariationLocked = false;
            string SubcontractorDetail = null;


            int WorkOrderStatus = 0;
            WOStatusLbl.Text = "Work Order In Progress";
            if (Request.QueryString["status"] != null)
            {
                WorkOrderStatus = Convert.ToInt32(Request.QueryString["status"]);

                switch (WorkOrderStatus)
                {
                    case (int)DA.WorkOrderStatus.DeclinedbySubby:
                        WOStatus = "Declined by Subcontractor";
                        WOStatusLbl.Text = "Declined by Subcontractor";
                        break;
                    case (int)DA.WorkOrderStatus.Invoiced:
                        WOStatus = "Invoiced";
                        WOStatusLbl.Text = "Invoiced";
                        break;
                    case (int)DA.WorkOrderStatus.CompleteRequest:
                        WOStatus = "Complete Request";
                        WOStatusLbl.Text = "Complete Request from Subcontractor";
                        break;
                    case (int)DA.WorkOrderStatus.Cancelled:
                        WOStatus = "Cancelled";
                        WOStatusLbl.Text = "Cancelled";
                        break;
                    case (int)DA.WorkOrderStatus.InDispute:
                        WOStatus = "In Dispute";
                        WOStatusLbl.Text = "In Dispute";
                        break;
                    case (int)DA.WorkOrderStatus.Completed:
                        WOStatus = "Completed";
                        WOStatusLbl.Text = "Completed";
                        break;
                    default:
                        break;
                }
            }


            DeclineLbl.Visible = false;
            WorkOrder WorkOrder = new WorkOrder();
            Variation Variation = new Variation();
            //List<WorkOrderItem> WorkOrderItems = new List<WorkOrderItem>();
            Dictionary<string, string> LookUpDictionary = new Dictionary<string, string>();

            if (WorkOrderID != null)
            {

                WorkOrder = WorkOrder.GetWorkOrderDetails(WorkOrderID, ref LookUpDictionary);

                // top level label with WO details
                WODetail.Text = "Work Order No: " + WorkOrderID + ". Insured: " + WorkOrder.Insured + ". Address: " + WorkOrder.PropertyAddress;
                InsuranceDetail.Text = "Insurance Company: " + WorkOrder.InsuranceCompany + ". Event caused damage: " + WorkOrder.EventType;
                if (WorkOrder.DisputeReason != null)
                {
                    WOStatusLbl.Text = WOStatusLbl.Text + " - " + WorkOrder.DisputeReason;
                }

                OrderID = WorkOrder.OrderID;
                DA.SetCookie("OID", OrderID);

                if (WorkOrder.CompanyID == (int)DA.MaincomCompanies.MaincomNewZealand)
                {
                    fromAddress = Email.fromAddress_NewZealand;
                }
                else
                {
                    fromAddress = Email.fromAddress_Australia;
                }

                
                if (WorkOrder.InsuredMobile != null)
                {
                    Mobile = "Mobile - " + WorkOrder.InsuredMobile;
                }
                if (WorkOrder.InsuredPhone != null && WorkOrder.InsuredPhone.Length > 0)
                {
                    Phone = ", Phone - " + WorkOrder.InsuredPhone;
                }

                SubcontractorDetail = WorkOrder.SubcontractorName + " (phone:" + WorkOrder.SubcontractorPhone + ", mobile: " + WorkOrder.SubcontractorMobile + ", email: " + WorkOrder.SubcontractorEmail + ")";
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
                    if (ActionWO == "2")
                    {
                        //-- Record variation request
                        WorkOrder.VariationRequestToAudit(OrderID, WorkOrderID, quoteID);
                        WorkOrder.EmailRequestForVariation(WorkOrderID, WorkOrder.SearchCode, fromAddress, WorkOrder.EstimatorEmail, SubcontractorDetail, WorkOrder.EstimatorEmail);
                        AcceptLbl.Visible = true;
                        AcceptLbl.Text = "Variation Request has been sent to Supervisor.";
                        UpdateAudit = "parent.UpdateAudit(); Navigate(0);";

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




    }
}