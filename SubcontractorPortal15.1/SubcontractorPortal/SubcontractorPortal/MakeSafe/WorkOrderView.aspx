<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WorkOrderView.aspx.cs" Inherits="SubcontractorPortal.MakeSafe.WorkOrderView" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <script type="text/javascript" src="/Scripts/common.js"></script>
    <script type="text/javascript"  src="/Scripts/trace.js"></script>

    <style type="text/css">
        .topLabel
        {
            background-color:#F5F5DC;
        }
    </style>
</head>
<body onload="setMiniIframeHeight('WOFrame');setMiniIframeHeight('PhFrame');setMiniIframeHeight('WHSFrame');setMiniIframeHeight('CertFrame');setMiniIframeHeight('InvoiceFrame');setMiniIframeHeight('TradesFrame');setMiniIframeHeight('AuditFrame');setMiniIframeHeight('ToDoFrame');">
    <script type="text/javascript">parent.HideWin();</script>
    <form id="form1" runat="server">
    <%--
            <table width="100%">
                <tr>
                    <td class="topLabel">                        
                        <dx:ASPxLabel ID="lblWOBrief" runat="server" Text=""></dx:ASPxLabel>
                    </td>
                </tr>

            </table>
         --%>
    
        <dx:ASPxPageControl ID="ASPxPageControl1" runat="server" ActiveTabIndex="0" Width="100%"
            ClientInstanceName="PageTabControl"  EnableCallBacks="True">
            <TabPages>
                <dx:TabPage Name="NextTab" Text="What to do now">
                    <ContentCollection>
                        <dx:ContentControl ID="ContentControl1" runat="server" SupportsDisabledAttribute="True">
                            <iframe src="<%=WhatToDoNextLink %>" id="ToDoFrame" scrolling="auto" frameborder="0" style="width:100%"></iframe>
                        </dx:ContentControl>
                    </ContentCollection>
                </dx:TabPage>

                <dx:TabPage Name="WOTab" Text="Work Order">
                    <ContentCollection>
                        <dx:ContentControl ID="ContentControl2" runat="server" SupportsDisabledAttribute="True">
                            <iframe src="WorkOrderDetail.aspx" id="WOFrame" scrolling="auto" frameborder="0" style="width:100%"></iframe>
                        </dx:ContentControl>
                    </ContentCollection>
                </dx:TabPage>
                <dx:TabPage Name="ImageTab" Text="Photos">
                    <ContentCollection>
                        <dx:ContentControl ID="image1" runat="server" SupportsDisabledAttribute="True">
                            <iframe src="<%=PicFrameLink %>" id="PhFrame" scrolling="auto" frameborder="0" style="width:100%"></iframe>
                        </dx:ContentControl>
                    </ContentCollection>
                </dx:TabPage>
                <dx:TabPage Name="WHSTab" Text="Risk Assessement">
                    <ContentCollection>
                        <dx:ContentControl ID="WHS" runat="server" SupportsDisabledAttribute="True"></dx:ContentControl>
                    </ContentCollection>
                </dx:TabPage>
                <dx:TabPage Name="CertTab" Text="Completion Certificate">
                    <ContentCollection>
                        <dx:ContentControl ID="Cert" runat="server" SupportsDisabledAttribute="True"></dx:ContentControl>
                    </ContentCollection>
                </dx:TabPage>

                <dx:TabPage Name="TradesTab" Text="Trades On Site">
                    <ContentCollection>
                        <dx:ContentControl ID="Trades" runat="server" SupportsDisabledAttribute="True"></dx:ContentControl>
                    </ContentCollection>
                </dx:TabPage>

                <dx:TabPage Name="Audit" Text="Work Order Audit">
                    <ContentCollection>
                        <dx:ContentControl ID="Audit" runat="server" SupportsDisabledAttribute="True">                            
                            <iframe src="WorkOrderAudit.aspx" id="AuditFrame" scrolling="auto" frameborder="0" style="width:100%"></iframe>
                        </dx:ContentControl>
                    </ContentCollection>
                </dx:TabPage>
            </TabPages>
        <LoadingPanelImage Url="~/Images/loading.gif">
        </LoadingPanelImage>
        <ClientSideEvents ActiveTabChanged="function(s, e) {
	    setMiniIframeHeight('WOFrame');setMiniIframeHeight('PhFrame');setMiniIframeHeight('WHSFrame');setMiniIframeHeight('CertFrame');setMiniIframeHeight('InvoiceFrame');setMiniIframeHeight('TradesFrame');setMiniIframeHeight('ToDoFrame');setMiniIframeHeight('AuditFrame');
}" TabClick="function(s, e) {
	  if (e.tab.name == 'Audit')
            {
                UpdateAudit();
            }
}" />

        </dx:ASPxPageControl>    

    </form>
</body>
</html>
