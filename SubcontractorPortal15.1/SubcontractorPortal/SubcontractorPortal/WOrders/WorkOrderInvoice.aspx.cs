using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SubcontractorDataComponents;

namespace SubcontractorPortal.WOrders
{
    public partial class WorkOrderInvoice1 : System.Web.UI.Page
    {
        public string WorkOrderHTML = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            string WorkOrderID = "0";
            bool Print = false;
            if (Request.QueryString["print"] != null && Request.QueryString["WOID"] != null) { Print = true; }

            if (!Print)
            {
                Users.CheckUser();
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
                WorkOrderHTML = WorkOrder.WorkOrderDetailstoHTML(LookUpDictionary, (int)DA.WorkOrderSection.Details, (int)DA.Countries.Australia);
                WorkOrderItems = WorkOrder.GetWorkOrderItems(WorkOrderID, ref WorkOrder);
                WorkOrderHTML = WorkOrder.WorkOrderItemstoHTML(WorkOrderItems, WorkOrder, (int)DA.WorkOrderSection.Details, (int)DA.Countries.Australia, WorkOrderHTML);

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