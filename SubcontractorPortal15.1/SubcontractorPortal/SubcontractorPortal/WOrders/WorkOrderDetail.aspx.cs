using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SubcontractorDataComponents;

namespace SubcontractorPortal.WOrders
{
    public partial class WorkOrderDetail : System.Web.UI.Page
    {
        public string WorkOrderHTML = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            bool IsStaffMember = false;
            IsStaffMember = Users.IsStaffMember();
            int Country = (int)DA.Countries.Australia;

            string WorkOrderID = "0";
            bool Print = false, IsTradecom = false;
            if (Request.QueryString["print"] != null && Request.QueryString["WOID"] != null) { Print = true; }

            if (!Print)
            {
                if (!IsStaffMember)
                {
                    Users.CheckUser();
                }
            }

            WorkOrderID = DA.ReadCookie("WOID");

            if (Request.QueryString["WOID"] != null)
            {
                WorkOrderID = Request.QueryString["WOID"];
            }

            if (WorkOrderID != null)
            {

                WorkOrder WorkOrder = new WorkOrder();
                List<WorkOrderItem> WorkOrderItems = new List<WorkOrderItem>();
                Dictionary<string, string> LookUpDictionary = new Dictionary<string, string>();
                
                WorkOrder = WorkOrder.GetWorkOrderDetails(WorkOrderID, ref LookUpDictionary);
                if (WorkOrder.CompanyID == (int)DA.MaincomCompanies.MaincomNewZealand)
                {
                    Country = (int)DA.Countries.NZ;
                }
                if (WorkOrder.CompanyID == (int)DA.MaincomCompanies.Tradecom)
                {
                    IsTradecom = true;
                }


                WorkOrderHTML = WorkOrder.WorkOrderDetailstoHTML(LookUpDictionary, (int)DA.WorkOrderSection.Details, Country, false, WorkOrder.IsTVRJob, IsTradecom);
                WorkOrderItems = WorkOrder.GetWorkOrderItems(WorkOrderID, ref WorkOrder);
                WorkOrderHTML = WorkOrder.WorkOrderItemstoHTML(WorkOrderItems, WorkOrder, (int)DA.WorkOrderSection.Details, Country, WorkOrderHTML, WorkOrder.IsTVRJob);

                WorkOrderHTML = WorkOrder.CheckWorkOrderContracts(WorkOrder.HasContract, WorkOrderID, WorkOrderHTML);

                if (!String.IsNullOrEmpty(WorkOrder.WOContact))
                {
                    WorkOrderHTML = WorkOrderHTML.Replace("<!-- WOContact -->", "<tr><td class='HFontR'>Important!</td><td><font class='HFont'>" + WorkOrder.WOContact + "</font></td></tr>");
                }


                // Add options bar to document view
                if (!Print)
                {
                    WorkOrderHTML = WorkOrder.AddOptionsHTML(WorkOrderHTML, WorkOrderID, (int)DA.WorkOrderSection.Details, HttpContext.Current.Request.Url.AbsoluteUri);
                }

                LookUpDictionary = null;
                WorkOrder = null;
            }
            //string bb = WorkOrder.SearchCode;

            
        }
    }
}