using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SubcontractorDataComponents;

namespace SubcontractorPortal
{
    public partial class PDF : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string URL = null;
            string WOSection = "WorkOrder.pdf";

            if (Request.QueryString["WOID"] != null && Request.QueryString["URL"] != null)
            {
                if (Request.QueryString["Section"] != null)
                {
                    if (Convert.ToInt32(Request.QueryString["Section"]) == (int)DA.WorkOrderSection.Details)
                    {
                        WOSection = "WorkOder-" + Request.QueryString["WOID"] + ".pdf";
                    }
                    if (Convert.ToInt32(Request.QueryString["Section"]) == (int)DA.WorkOrderSection.WHS)
                    {
                        WOSection = "WHS-" + Request.QueryString["WOID"] + ".pdf";
                    }
                    if (Convert.ToInt32(Request.QueryString["Section"]) == (int)DA.WorkOrderSection.ComletionCertificate)
                    {
                        WOSection = "ComletionCertificate-" + Request.QueryString["WOID"] + ".pdf";
                    }

                }
                    //Section
                URL = Request.QueryString["URL"] + "?WOID=" + Request.QueryString["WOID"] +"&print=1";
                DA.ConvertURLToPDF(URL, false, false, "", WOSection, "");
            }

        }
    }
}