using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SubcontractorDataComponents;

namespace SubcontractorPortal.MakeSafe
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
                List<WorkOrderItem> WorkOrderItems = new List<WorkOrderItem>();
                Dictionary<string, string> LookUpDictionary = new Dictionary<string, string>();

                WorkOrder = WorkOrder.GetMakeSafeWorkOrderDetails(WorkOrderID, ref LookUpDictionary);
                if (WorkOrder.CompanyID == (int)DA.MaincomCompanies.MaincomNewZealand)
                {
                    Country = (int)DA.Countries.NZ;
                }


                WorkOrderHTML = WorkOrder.WorkOrderDetailstoHTML(LookUpDictionary, (int)DA.WorkOrderSection.Details, Country, true);
                WorkOrderItems = WorkOrder.GetMakeSafeWorkOrderItems(WorkOrderID, ref WorkOrder);
                WorkOrderHTML = WorkOrder.WorkOrderItemstoHTML(WorkOrderItems, WorkOrder, (int)DA.WorkOrderSection.Details, Country, WorkOrderHTML);

                //-- correction for WO type
                if (!String.IsNullOrEmpty(WorkOrder.MakeSafeType))
                {
                    if (Convert.ToInt32(WorkOrder.MakeSafeType) == (int)DA.MakeSafeType.MakeSafe)
                    {
                        WorkOrderHTML = WorkOrderHTML.Replace("@MakeSafeHeader@", "Make Safe Work");
                    }
                    if (Convert.ToInt32(WorkOrder.MakeSafeType) == (int)DA.MakeSafeType.Report)
                    {
                        WorkOrderHTML = WorkOrderHTML.Replace("@MakeSafeHeader@", "Report");
                    }

                    if (Convert.ToInt32(WorkOrder.MakeSafeType) == (int)DA.MakeSafeType.Tests)
                    {
                        WorkOrderHTML = WorkOrderHTML.Replace("@MakeSafeHeader@", "Tests");
                    }
                    if (Convert.ToInt32(WorkOrder.MakeSafeType) == 0)
                    {
                        WorkOrderHTML = WorkOrderHTML.Replace("@MakeSafeHeader@", "Undefined");
                    }
                }
                else
                {
                    WorkOrderHTML = WorkOrderHTML.Replace("@MakeSafeHeader@", "Undefined");
                }


                // Add options bar to document view
                if (!Print)
                {
                    WorkOrderHTML = WorkOrder.AddOptionsHTML(WorkOrderHTML, WorkOrderID, (int)DA.WorkOrderSection.Details, HttpContext.Current.Request.Url.AbsoluteUri);
                }

                LookUpDictionary = null;
                WorkOrder = null;
            }           


        }
    }
}