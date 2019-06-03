using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SubcontractorPortal.Registration
{
    public partial class Step11 : System.Web.UI.Page
    {
        public string BackURL = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            BackURL = "Step1a.aspx";

        }
    }
}