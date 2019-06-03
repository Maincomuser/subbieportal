using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SubcontractorPortal.Registration
{
    public partial class Step1a : System.Web.UI.Page
    {
        public string BackURL = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            BackURL = "OtherConditions.aspx";
            string regNo = null;
            //-- Save data into cookies
            if (Page.IsPostBack)
            {
                Response.Redirect("Step1.aspx?regNo=" + regNo);
            }

        }
    }
}