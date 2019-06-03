using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SubcontractorDataComponents;

namespace SubcontractorPortal.WOrders
{
    public partial class SiteRiskAssessment1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            ASPxHyperLink1.Visible = false;

            int WorkOrderStatus = 0;
            int WO_SubbieID = 0;
            string WorkOrderID = DA.ReadCookie("WOID");
            string OrderID = WorkOrder.GetOrderID(WorkOrderID, ref WorkOrderStatus, ref WO_SubbieID);
            string wordDoc = null;
            wordDoc = WorkOrder.Subcontractor_Get_Site_Risk_Assessment(OrderID);
            if (!String.IsNullOrEmpty(wordDoc))
            {
                ASPxHyperLink1.Visible = true;
                ASPxHyperLink1.NavigateUrl = "";
            }

            /*
            if (Page.IsPostBack)
            {


                
                if (wordDoc != null)
                {
                    Response.ContentType = "application/msword";
                    Response.AddHeader("Content-Disposition", "attachment; filename=Site-Risk-Assessment.doc");
                    Response.Cache.SetExpires(DateTime.Now.AddSeconds(1));
                    Response.BinaryWrite(wordDoc);
                    Response.Flush();
                    Response.End();
                }
              
            }
                */
        }
    }
}