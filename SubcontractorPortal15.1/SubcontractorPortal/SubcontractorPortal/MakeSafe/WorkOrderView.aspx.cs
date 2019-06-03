using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Drawing;
using SubcontractorDataComponents;
using DevExpress.Web;



namespace SubcontractorPortal.MakeSafe
{
    public partial class WorkOrderView : System.Web.UI.Page
    {
        public string WhatToDoNextLink = null;
        public string PicFrameLink = null;
        protected void LoadActiveTabPageContent()
        {
            TabPage activePage = ASPxPageControl1.ActiveTabPage;
            if (activePage.Controls.Count == 0)
            {
                Control contentControl = CreateTabPageContentControl(activePage.Name);
                if (contentControl != null)
                    activePage.Controls.Add(contentControl);
            }
        }

        protected Control CreateTabPageContentControl(string name)
        {
            string WOID = Request.QueryString["WOID"];
            switch (name)
            {
                case "CertTab":
                    return LoadControl("CompletionCertificate.ascx");
                //case "ImageTab":
                    //return LoadControl("/MakeSafe/Photos.ascx?WOID=" + WOID);
                case "WHSTab":
                    return LoadControl("RiskAssessment.ascx");
                case "TradesTab":
                    return LoadControl("TradesOnSite.ascx");
                case "InvoiceTab":
                    return LoadControl("WorkOrderInvoice.ascx");
                case "SRATab":
                    return LoadControl("SiteRiskAssessment.ascx");

                case "Administration":
                    return LoadControl("~/Administration/Administration.ascx");
                case "InsuranceAdmin":
                    return LoadControl("~/InsuranceAdmin/InsuranceAdmin.ascx");
                default:
                    return null;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            string WorkOrderID = "0", OrderID = "0";
            int WorkOrderStatus = (int)DA.WorkOrderStatus.New;

            string staff = null;
            staff = DA.ReadCookie("Staff");
            if (staff == null)
            {
                Users.CheckUser(1);
            }

            if (Request.QueryString["WOID"] != null)
            {
                PicFrameLink = "/MakeSafe/Photos.aspx?WOID=" + Request.QueryString["WOID"];
                WorkOrderID = Request.QueryString["WOID"];
                OrderID = WorkOrder.GetMakeSafeOrderID(WorkOrderID, ref WorkOrderStatus);
                DA.SetCookie("WOID", WorkOrderID);
                DA.SetCookie("OrderID", OrderID);
                switch (WorkOrderStatus)
                {
                    case (int)DA.WorkOrderStatus.New:
                        WhatToDoNextLink = "WhatToDo.aspx";
                        break;
                    case (int)DA.WorkOrderStatus.InProgress:
                        WhatToDoNextLink = "WhatToDoProgress.aspx?WOID=" + WorkOrderID + "&OID=" + OrderID;
                        //WhatToDoNextLink = "WhatToDoCancelled.aspx?status=" + Convert.ToString((int)DA.WorkOrderStatus.InProgress) + "&WOID=" + WorkOrderID + "&OID=" + OrderID;
                        break;
                    case (int)DA.WorkOrderStatus.DeclinedbySubby:
                        WhatToDoNextLink = "WhatToDoCancelled.aspx?status=" + Convert.ToString((int)DA.WorkOrderStatus.DeclinedbySubby) + "&WOID=" + WorkOrderID + "&OID=" + OrderID;
                        break;
                    case (int)DA.WorkOrderStatus.Invoiced:
                        WhatToDoNextLink = "WhatToDoCancelled.aspx?status=" + Convert.ToString((int)DA.WorkOrderStatus.Invoiced) + "&WOID=" + WorkOrderID + "&OID=" + OrderID;
                        break;
                    case (int)DA.WorkOrderStatus.CompleteRequest:
                        WhatToDoNextLink = "WhatToDoCancelled.aspx?status=" + Convert.ToString((int)DA.WorkOrderStatus.CompleteRequest) + "&WOID=" + WorkOrderID + "&OID=" + OrderID;
                        break;
                    case (int)DA.WorkOrderStatus.InDispute:
                        WhatToDoNextLink = "WhatToDoCancelled.aspx?status=" + Convert.ToString((int)DA.WorkOrderStatus.InDispute) + "&WOID=" + WorkOrderID + "&OID=" + OrderID;
                        break;
                    case (int)DA.WorkOrderStatus.Cancelled:
                        WhatToDoNextLink = "WhatToDoCancelled.aspx?status=" + Convert.ToString((int)DA.WorkOrderStatus.Cancelled) + "&WOID=" + WorkOrderID + "&OID=" + OrderID;
                        break;
                    case (int)DA.WorkOrderStatus.Completed:
                        WhatToDoNextLink = "WhatToDoCancelled.aspx?status=" + Convert.ToString((int)DA.WorkOrderStatus.Completed) + "&WOID=" + WorkOrderID + "&OID=" + OrderID;
                        break;

                    default:
                        break;
                }

            }
            LoadActiveTabPageContent();

            //-- get Work Order brief fo top label
            //lblWOBrief.Text = WorkOrder.WorkOrderGetBrief(WorkOrderID);


        }
    }
}