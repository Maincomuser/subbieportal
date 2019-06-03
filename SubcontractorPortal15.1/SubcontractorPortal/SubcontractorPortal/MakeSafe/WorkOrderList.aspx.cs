using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SubcontractorDataComponents;

namespace SubcontractorPortal.MakeSafe
{
    public partial class WorkOrderList : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Users.CheckUser((int)Users.WrongUserRedirect.Nowhere);
            

            if (!string.IsNullOrEmpty(Request.QueryString["statusID"]))
            {
                WOList.Caption = "<div class='WOCaption'>Make Safe - " + DA.WOListCaption(Request.QueryString["statusID"]) + "</div>";
            }
            else
            {
                WOList.Caption = "<div class='WOCaption'>All Make Safe Work Orders</div>";
            }


        }
    }
}