using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SubcontractorDataComponents;

namespace SubcontractorPortal.WOrders
{
    public partial class SiteRiskAssessment : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            System.Threading.Thread.Sleep(1000); // some processing
            int WorkOrderStatus = 0;
            int WO_SubbieID = 0;
            string WorkOrderID = DA.ReadCookie("WOID");
            string OrderID = WorkOrder.GetOrderID(WorkOrderID, ref WorkOrderStatus, ref WO_SubbieID);
            string wordDoc = null;
            wordDoc = WorkOrder.Subcontractor_Get_Site_Risk_Assessment(OrderID);
            if (!String.IsNullOrEmpty(wordDoc))
            {
                SRAFrame.Src = DA.DocumentsPath + wordDoc;
            }
            else
            {
                SRAFrame.Src = "/WOrders/Empty.html";
            }




        }
    }
}