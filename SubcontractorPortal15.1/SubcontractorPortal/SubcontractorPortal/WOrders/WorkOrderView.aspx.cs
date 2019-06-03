using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Drawing;
using SubcontractorDataComponents;
using DevExpress.Web;

namespace SubcontractorPortal.WOrders
{
    public partial class WorkOrderView : System.Web.UI.Page
    {
        public string WhatToDoNextLink = null;
        public string SubbiePhotosLink = null;
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
            switch (name)
            {
                case "CertTab":
                    return LoadControl("CompletionCertificate.ascx");
                case "ImageTab":
                    return LoadControl("Photos.ascx");
                case "WHSTab":
                    return LoadControl("WHS.ascx");
                case "TradesTab":
                    return LoadControl("TradesOnSite.ascx");
                case "InvoiceTab":
                    return LoadControl("WorkOrderInvoice.ascx");
                case "SRATab":
                    return LoadControl("SiteRiskAssessment.ascx");
                /*
                case "SubbiePhotos":
                    return LoadControl("SubbiePhotos.aspx?" + Request.QueryString["WOID"]);
                */

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
            string WorkOrderID = "0", OrderID="0";
            int WorkOrderStatus = (int)DA.WorkOrderStatus.New;
            int WO_SubbieID = 0;

            string staff = null;
            staff = DA.ReadCookie("Staff");
            if (staff == null)
            {
                Users.CheckUser(1);
            }
            
            if (Request.QueryString["WOID"] != null)
            {
                SubbiePhotosLink = "/WOrders/SubbiePhotos.aspx?WOID=" + Request.QueryString["WOID"];

                WorkOrderID = Request.QueryString["WOID"];
                OrderID = WorkOrder.GetOrderID(WorkOrderID, ref WorkOrderStatus, ref WO_SubbieID);                             
                DA.SetCookie("WOID", WorkOrderID);
                DA.SetCookie("OrderID", OrderID);
                switch (WorkOrderStatus)
                {
                    case (int)DA.WorkOrderStatus.New:
                        WhatToDoNextLink = "WhatToDo.aspx";
                        break;
                    case (int)DA.WorkOrderStatus.InProgress:

                        //-- Change to WhatToDoProgressNew.aspx for all companies after testing 
                        if (WO_SubbieID == (int)DA.MaincomCompanies.Tradecom)
                        {
                            //WhatToDoNextLink = "WhatToDoProgressNew.aspx?WOID=" + WorkOrderID + "&OID=" + OrderID;
                            WhatToDoNextLink = "WhatToDoProgress.aspx?WOID=" + WorkOrderID + "&OID=" + OrderID;
                        }
                        else
                        {
                            WhatToDoNextLink = "WhatToDoProgress.aspx?WOID=" + WorkOrderID + "&OID=" + OrderID;
                        }
                        
                        break;
                    case (int)DA.WorkOrderStatus.DeclinedbySubby:
                        WhatToDoNextLink = "WhatToDoCancelled.aspx?status=" + Convert.ToString((int)DA.WorkOrderStatus.DeclinedbySubby) +"&WOID=" + WorkOrderID + "&OID=" + OrderID;
                        break;
                    case (int)DA.WorkOrderStatus.Invoiced:
                        WhatToDoNextLink = "WhatToDoCancelled.aspx?status=" + Convert.ToString((int)DA.WorkOrderStatus.Invoiced) +"&WOID=" + WorkOrderID + "&OID=" + OrderID;
                        break;
                    case (int)DA.WorkOrderStatus.CompleteRequest:
                        WhatToDoNextLink = "WhatToDoCancelled.aspx?status=" + Convert.ToString((int)DA.WorkOrderStatus.CompleteRequest) + "&WOID=" + WorkOrderID + "&OID=" + OrderID;
                        break;
                    case (int)DA.WorkOrderStatus.InDispute:

                        //-- Change to WhatToDoDispute.aspx for all companies after testing 
                        if (WO_SubbieID == (int)DA.MaincomCompanies.Tradecom)
                        {
                            WhatToDoNextLink = "WhatToDoDispute.aspx?WOID=" + WorkOrderID + "&OID=" + OrderID;
                        }
                        else
                        {
                            WhatToDoNextLink = "WhatToDoCancelled.aspx?WOID=" + WorkOrderID + "&OID=" + OrderID;
                        }

                        //WhatToDoNextLink = "WhatToDoDispute.aspx?status=" + Convert.ToString((int)DA.WorkOrderStatus.InDispute) + "&WOID=" + WorkOrderID + "&OID=" + OrderID;
                        break;
                    case (int)DA.WorkOrderStatus.Cancelled:
                        WhatToDoNextLink = "WhatToDoCancelled.aspx?status=" + Convert.ToString((int)DA.WorkOrderStatus.Cancelled) +"&WOID=" + WorkOrderID + "&OID=" + OrderID;
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