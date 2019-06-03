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
    public partial class WhatToDoProgress : System.Web.UI.Page
    {
        public string UpdateAudit = null, URL = null, URL2 = null, quoteID = null, OrderType = null;
        public bool IsStaffMember = false;

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

                WOStatusLbl.Text = OrderType + "WO In Progress";

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


            int Parameter = 0;
            if (Request.QueryString["p"] != null)
            {
                Parameter = Convert.ToInt32(Request.QueryString["p"]);
            }


            if (Page.IsPostBack && !Page.IsCallback)
            {
                string ActionWO = Request.Form["ActionWO"];
                if (!IsStaffMember)
                {
                    if (ActionWO == "1")
                    {
                        //-- Record change dates in database
                        WorkOrder.ChangeDatesMakeSafe(OrderID, WorkOrderID, ChangeDateReason.Text, WOStart.Date.ToString("s"), WOFinish.Date.ToString("s"));
                        WorkOrder.EmailRequestChangedDates(WorkOrder.OrderID, WorkOrderID, WorkOrder.SearchCode, fromAddress, ChangeDateReason.Text, WorkOrder.WorkOrderStartDate, WorkOrder.WorkOrderCompleteDate, WOStart.Date.ToString(), WOFinish.Date.ToString(), SubcontractorDetail, fromAddress, true);
                        AcceptLbl.Visible = true;
                        //AcceptLbl.Text = "Work Order Dates has been changed by subcontractor. <br>Notification has been sent to Supervisor.";
                        AcceptLbl.Text = "Request for changing Work Order Dates has been sent to Maincom.";
                        UpdateAudit = "parent.UpdateAudit();";
                    }


                    //-- Complete Work Order
                    if (ActionWO == "3")
                    {
                        //-- Record change dates in database
                        WorkOrder.CompleteMakeSafeWorkOrder(OrderID, WorkOrderID);
                        WorkOrder.EmailRequestToCompleteWorkOrder(WorkOrderID, WorkOrder.SearchCode, fromAddress, WorkOrder.EstimatorEmail, SubcontractorDetail, fromAddress, true);
                        AcceptLbl.Visible = true;
                        AcceptLbl.Text = "Request to Complete Work Order has been sent to Supervisor.";
                        UpdateAudit = "parent.UpdateAudit();";
                    }

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