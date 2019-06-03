using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SubcontractorDataComponents;
using DevExpress.Web;
using DevExpress.Web.Data;

namespace SubcontractorPortal.MakeSafe
{
    public partial class WhatToDoCancelled : System.Web.UI.Page
    {
        public string UpdateAudit = null, URL = null, URL2 = null, quoteID = null, OrderType = null;
        public bool IsStaffMember = false;

        protected void Page_Load(object sender, EventArgs e)
        {

            IsStaffMember = Users.IsStaffMember();

            string Phone = null, Mobile = null, WOStatus = null;
            string fromAddress = null;
            //string WorkOrderID = DA.ReadCookie("WOID");
            string WorkOrderID = Request.QueryString["WOID"];

            string OrderID = null;
                        
            string SubcontractorDetail = null;


            int WorkOrderStatus = 0;
            WOStatusLbl.Text = "Make Safe WO In Progress";
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

                WorkOrder = WorkOrder.GetMakeSafeWorkOrderDetails(WorkOrderID, ref LookUpDictionary);

                if (!String.IsNullOrEmpty(WorkOrder.MakeSafeType))
                {
                    if (Convert.ToInt32(WorkOrder.MakeSafeType) == (int)DA.MakeSafeType.MakeSafe)
                    {
                        OrderType = "Make Safe ";
                    }
                    if (Convert.ToInt32(WorkOrder.MakeSafeType) == (int)DA.MakeSafeType.Report)
                    {
                        OrderType = "Report ";
                    }

                    if (Convert.ToInt32(WorkOrder.MakeSafeType) == (int)DA.MakeSafeType.Tests)
                    {
                        OrderType = "Test ";
                    }
                    if (Convert.ToInt32(WorkOrder.MakeSafeType) == 0)
                    {
                        OrderType = "Make Safe ";
                    }
                }
                else
                {
                    OrderType = "Make Safe ";
                }


                // top level label with WO details
                WODetail.Text = OrderType + "WO No: " + WorkOrderID + ". Insured: " + WorkOrder.Insured + ". Address: " + WorkOrder.PropertyAddress;
                InsuranceDetail.Text = "Insurance Company: " + WorkOrder.InsuranceCompany + ". Event caused damage: " + WorkOrder.EventType;


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

            //PhotoPanel.Visible = false;
            //PanelItemsNavigation.Visible = false;
            //PanelVariationItems.Visible = false;
            //GotoItemsBtn.Visible = false;
            //PanelVariations.Visible = true;

            int Parameter = 0;
            if (Request.QueryString["p"] != null)
            {
                Parameter = Convert.ToInt32(Request.QueryString["p"]);
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
                    //-- Send message to Maincom
                    if (ActionWO == "4")
                    {
                        WorkOrder.MessageToMaincomMakeSafe(OrderID, WorkOrderID, Message.Text);
                        WorkOrder.EmailMessageToMaincom(WorkOrderID, WorkOrder.SearchCode, fromAddress, Message.Text, SubcontractorDetail, fromAddress, true);
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
    }
}