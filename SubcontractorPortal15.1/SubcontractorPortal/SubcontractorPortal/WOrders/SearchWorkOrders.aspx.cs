using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SubcontractorDataComponents;

namespace SubcontractorPortal.WOrders
{
    public partial class SearchWorkOrders : System.Web.UI.Page
    {
        public string HTMLLabel;
        protected void Page_Load(object sender, EventArgs e)
        {
            string staff = null;
            bool IsStaffMember = false;
            staff = DA.ReadCookie("Staff");
            if (staff == null)
            {
                Users.CheckUser((int)Users.WrongUserRedirect.Nowhere);
            }
            else
            {
                IsStaffMember = true;                
            }
            string WorkOrderID = "0";           
            if (Request.QueryString["WOID"] != null)
            {
                WorkOrderID = Request.QueryString["WOID"];
                if (WorkOrder.FoundWorkOrder(WorkOrderID, IsStaffMember))
                {
                    Server.Transfer("/WOrders/WorkOrderView.aspx?WOID=" + WorkOrderID);
                }
                else
                {
                    HTMLLabel = "No Matching Work Orders Found";
                }
            }
            


        }
    }
}