using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SubcontractorPortal.Registration
{
    public partial class Step20 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string regNo = null;

            if (!String.IsNullOrEmpty(Request.QueryString["regNo"]))
            {
                regNo = Request.QueryString["regNo"];
            }
            else
            {
                Response.Write("<center><br><br><font size=3 color=red face='Verdana'><b>Error! Unable to proceed without Registration Number</b></font></center>");
                Response.End();
            }

            //-- Save data into cookies
            if (Page.IsPostBack)
            {
                Response.Redirect("WHS-Intro.aspx?regNo=" + regNo);
            }
        }
    }
}