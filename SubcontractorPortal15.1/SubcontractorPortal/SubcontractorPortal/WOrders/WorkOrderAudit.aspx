<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WorkOrderAudit.aspx.cs" Inherits="SubcontractorPortal.WOrders.WorkOrderAudit" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" DataSourceID="SqlDataSource1" Width="100%">
            <SettingsBehavior AllowDragDrop="False" AllowSelectSingleRowOnly="True" />
            <SettingsPager Mode="ShowAllRecords" Visible="False">
            </SettingsPager>
        </dx:ASPxGridView>
        <br />
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DataConnectionString %>" SelectCommand="Subcontractor_Audit_by_Work_Order" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:CookieParameter CookieName="WOID" Name="Insurance_WorkOrderMain_Id" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
    </div>
    </form>
</body>
</html>
