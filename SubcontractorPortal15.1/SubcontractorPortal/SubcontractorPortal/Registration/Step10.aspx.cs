using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SubcontractorDataComponents;

namespace SubcontractorPortal.Registration
{
    public partial class Step10 : System.Web.UI.Page
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
                DA.SetCookie("cm3", cm3Item.Value.ToString());
                try
                {
                    DA.SetCookie("EmployeeNumber", EmployeeNumber.Value.ToString());
                }
                catch (Exception)
                {
                    DA.SetCookie("EmployeeNumber", "1");                    
                }

                try
                {
                    DA.SetCookie("CompanyYears", CompanyYears.Value.ToString());
                }
                catch (Exception)
                {
                    DA.SetCookie("CompanyYears", "0");
                }

                try
                {
                    DA.SetCookie("CompanyMonth", CompanyMonth.Value.ToString());
                }
                catch (Exception)
                {
                    DA.SetCookie("CompanyMonth", "0");
                }


                try
                {
                    DA.SetCookie("WorkForMaincom", WorkForMaincom.Value.ToString());
                }
                catch (Exception)
                {
                    DA.SetCookie("WorkForMaincom", "");
                }

                try
                {
                    DA.SetCookie("OtherCompanyText", OtherCompanyText.Value.ToString());
                }
                catch (Exception)
                {
                    DA.SetCookie("OtherCompanyText", "");
                }

                Response.Redirect("Step2.aspx?regNo=" + regNo);

            }
        }
    }
}