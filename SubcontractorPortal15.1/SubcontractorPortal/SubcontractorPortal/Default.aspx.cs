using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SubcontractorDataComponents;

namespace SubcontractorPortal {
    public partial class _Default : System.Web.UI.Page {
        protected void Page_Load(object sender, EventArgs e) 
        {
            UserName.Focus();
            bool IsStaffMember = false;

            if (Page.IsPostBack)
            {
                if (Users.SubbyLogonToVisionary(UserName.Text, Password.Text, ref IsStaffMember))
                {
                    if (IsStaffMember)
                    {
                        Server.Transfer(DA.DefaultPageStaff);
                    }
                    else
                    {
                        Server.Transfer(DA.DefaultPage);
                    }
                }
                else { FailureText.Text = "Incorrect Username or Password"; }
            }


        }
    }
}