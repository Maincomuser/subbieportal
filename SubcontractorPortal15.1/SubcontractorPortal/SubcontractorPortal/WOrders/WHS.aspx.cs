using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SubcontractorDataComponents;

namespace SubcontractorPortal.WOrders
{
    public partial class WHS : System.Web.UI.Page
    {
        public string WorkOrderHTML = null;
        protected void Page_Load(object sender, EventArgs e)
        {

            bool IsStaffMember = false;
            IsStaffMember = Users.IsStaffMember();

            int Country = (int)DA.Countries.Australia;
            
            string WorkOrderID = "0";
            bool Print = false;
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
                Dictionary<string, string> LookUpDictionary = new Dictionary<string, string>();


                WorkOrder = WorkOrder.GetWorkOrderDetails(WorkOrderID, ref LookUpDictionary);
                if (WorkOrder.CompanyID == (int)DA.MaincomCompanies.MaincomNewZealand)
                {
                    Country = (int)DA.Countries.NZ;
                }


                WorkOrderHTML = WorkOrder.WorkOrderDetailstoHTML(LookUpDictionary, (int)DA.WorkOrderSection.WHS, Country);

                // Add options bar to document view
                if (!Print)
                {                    
                    WorkOrderHTML = WorkOrder.AddOptionsHTML(WorkOrderHTML, WorkOrderID, (int)DA.WorkOrderSection.WHS, HttpContext.Current.Request.Url.AbsoluteUri);
                }

                LookUpDictionary = null;
                WorkOrder = null;
            }

        }
    }
}