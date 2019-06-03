<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="NewSubContractorRequestAdmin.aspx.cs" Inherits="SubcontractorPortal.Registration.NewSubContractorRequestAdmin" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    </div>
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" DataSourceID="sqlDS_Requests">
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="sqlDS_Requests" runat="server"></asp:SqlDataSource>
    </form>
</body>
</html>
