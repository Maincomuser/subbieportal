﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SubcontractorDataComponents;

namespace SubcontractorPortal
{
    public partial class TopPageStaff : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Users.CheckStaffUser();
        }
    }
}