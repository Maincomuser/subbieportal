using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SubcontractorDataComponents;

namespace SubcontractorPortal.MakeSafe
{
    public partial class TradesOnSite1 : System.Web.UI.Page
    {
        public string SubbiesOnSite = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            string WorkOrderID = DA.ReadCookie("WOID");

            //-- get other subbies on site with WO items
            SubbiesOnSite = WorkOrder.OtherSubbiesOnSiteMakeSafe(WorkOrderID);

        }
    }
}