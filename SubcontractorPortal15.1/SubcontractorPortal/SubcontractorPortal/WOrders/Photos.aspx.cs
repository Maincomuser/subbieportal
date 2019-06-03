using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SubcontractorDataComponents;

using System.Data.SqlClient;
using DevExpress.Web;
using System.Text;

namespace SubcontractorPortal.WOrders
{
    public partial class Photos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string Order_ID = null, DocPath = null;
            bool IsStaffMember = false;
            IsStaffMember = Users.IsStaffMember();
            if (!IsStaffMember)
            {
                Users.CheckUser(1);
            }
            
            if (DA.ReadCookie("OrderID") != null)
            {
                Order_ID = DA.ReadCookie("OrderID");

                if (DA.UseDiskStorage)
                {
                    DocPath = DA.DocumentsPath;
                    ASPxDataView1.Visible = false;
                    ASPxDataView2.Visible = true;
                    Parameter p = SqlDataSource2.SelectParameters["OrderID"];
                    SqlDataSource2.SelectParameters.Remove(p);
                    SqlDataSource2.SelectParameters.Add("OrderID", Order_ID);
                    SqlDataSource2.DataBind();
                    ASPxDataView2.DataBind();
                }
                else
                {
                    DocPath = "NULL";
                    ASPxDataView1.Visible = true;
                    ASPxDataView2.Visible = false;
                    Parameter p = SqlDataSource1.SelectParameters["OrderID"];
                    SqlDataSource1.SelectParameters.Remove(p);
                    SqlDataSource1.SelectParameters.Add("OrderID", Order_ID);
                    SqlDataSource1.DataBind();
                }
            }


        }

        protected void img_Load(object sender, EventArgs e)
        {
            ASPxBinaryImage img = sender as ASPxBinaryImage;
            DataViewItemTemplateContainer container = img.NamingContainer as DataViewItemTemplateContainer;
            string imgID = DataBinder.Eval(container.DataItem, "Insurance_Document_id").ToString();
        }

        protected void ASPxImage1_Load(object sender, EventArgs e)
        {
            ASPxImage img = sender as ASPxImage;
            DataViewItemTemplateContainer container = img.NamingContainer as DataViewItemTemplateContainer;
            string imgID = DataBinder.Eval(container.DataItem, "Insurance_Document_id").ToString();
            img.ImageUrl = DA.DocumentsPath + DataBinder.Eval(container.DataItem, "FilePath").ToString();
            img.ClientSideEvents.Click = "function (s, e) {SetDelete(" + imgID + ", '" + img.ClientID + "'); }";

        }

    }
}