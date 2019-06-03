using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SubcontractorDataComponents;

namespace SubcontractorPortal.WOrders
{
    public partial class WhatToDo : System.Web.UI.Page
    {
        public string Insured = null, ContactOn = null, WOStatus = null, UpdateAudit = null;
        public bool IsStaffMember = false;

        protected void Page_Load(object sender, EventArgs e)
        {
            string Phone = null, Mobile = null;
            string WorkOrderID = DA.ReadCookie("WOID");
            string OrderID = null;
            string fromAddress = null;
            string SubcontractorDetail = null;

            IsStaffMember = Users.IsStaffMember();

            WOStatus = "New Work Order";
            DeclineLbl.Visible = false;
            WorkOrder WorkOrder = new WorkOrder();
            //List<WorkOrderItem> WorkOrderItems = new List<WorkOrderItem>();
            Dictionary<string, string> LookUpDictionary = new Dictionary<string, string>();

            if (WorkOrderID != null)
            {                

                WorkOrder = WorkOrder.GetWorkOrderDetails(WorkOrderID, ref LookUpDictionary);
                // top level label with WO details
                WODetail.Text = "Work Order No: " + WorkOrderID + ". Insured: " + WorkOrder.Insured + ". Address: " + WorkOrder.PropertyAddress;
                WOAddress.Value = "Address: " + WorkOrder.PropertyAddress;
                InsuranceDetail.Text = "Insurance Company: " + WorkOrder.InsuranceCompany + ". Event caused damage: " + WorkOrder.EventType;

                if (WorkOrder.CompanyID == (int)DA.MaincomCompanies.MaincomNewZealand)
                {
                    fromAddress = Email.fromAddress_NewZealand;
                }
                else
                {
                    fromAddress = Email.fromAddress_Australia;
                }


                OrderID = WorkOrder.OrderID;
                Insured = WorkOrder.Insured;
                if (WorkOrder.InsuredMobile != null)
                {
                    Mobile = "Mobile - " + WorkOrder.InsuredMobile;
                }
                if (WorkOrder.InsuredPhone != null && WorkOrder.InsuredPhone.Length > 0)
                {
                    Phone = ", Phone - " + WorkOrder.InsuredPhone;
                }

                ContactOn = Mobile + Phone;

                SubcontractorDetail = WorkOrder.SubcontractorName +" (phone:" + WorkOrder.SubcontractorPhone + ", mobile: " + WorkOrder.SubcontractorMobile + ", email: "+ WorkOrder.SubcontractorEmail + ")";

                if (!Page.IsPostBack)
                {
                    WOStart.Date = Convert.ToDateTime(WorkOrder.WorkOrderStartDate);
                    WOFinish.Date = Convert.ToDateTime(WorkOrder.WorkOrderCompleteDate);
                }

            }
            if (Page.IsPostBack)
            {
                string AcceptWO = Request.Form["AcceptWO"];
                if (!IsStaffMember)
                {
                    if (AcceptWO == "0")
                    {
                        //-- Decline WO                    
                        WorkOrder.DeclineWorkOrder(OrderID, WorkOrderID, DeclineReason.Text);
                        WorkOrder.EmailDeclineWorkOrder(WOAddress.Value, WorkOrderID, WorkOrder.SearchCode, fromAddress, DeclineReason.Text, SubcontractorDetail, WorkOrder.EstimatorEmail);
                        WOStatus = "Declined by Subcontractor";
                        Panel1.Visible = false;
                        DeclineLbl.Visible = true;
                        DeclineLbl.Text = "This Work Order has been declined by subcontractor. Information has been sent to Supervisor.";
                    }

                    if (AcceptWO == "1")
                    {
                        //-- Record acceptance in database


                        WorkOrder.AcceptWorkOrder(OrderID, WorkOrderID, null, WOStart.Date.ToString("s"), WOFinish.Date.ToString("s"), CalledInsured.Date.ToString("s"));
                        WorkOrder.EmailAcceptedWorkOrder(WOAddress.Value, OrderID, WorkOrderID, WorkOrder.SearchCode, fromAddress, CalledInsured.Date.ToShortDateString(), WorkOrder.WorkOrderStartDate, WorkOrder.WorkOrderCompleteDate, WOStart.Date.ToString(), WOFinish.Date.ToString(), SubcontractorDetail, WorkOrder.EstimatorEmail);
                        WOStatus = "Work Order In Progress";
                        Panel1.Visible = false;
                        DeclineLbl.Visible = false;
                        AcceptLbl.Visible = true;
                        AcceptLbl.Text = "This Work Order has been accepted by subcontractor. Confirmation has been sent to Supervisor.<br><br>Work Order has been moved to Work Orders In Progress";
                        UpdateAudit = "parent.UpdateAudit();";
                    }

                    if (AcceptWO == "2")
                    {
                        //-- Message Maincom
                        //-- get supervisor email


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
            WorkOrder = null;


        }
    }
}