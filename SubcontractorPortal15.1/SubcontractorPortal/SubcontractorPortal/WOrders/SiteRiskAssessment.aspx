<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SiteRiskAssessment.aspx.cs" Inherits="SubcontractorPortal.WOrders.SiteRiskAssessment1" %>






<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <script type="text/javascript">
        var ReportNumber = null;
        function CreateReport(ID) {
            var URL = "/temp/QuoteReports.aspx?" + ID;
            window.location.replace(URL);
        }
    </script>

    <form id="form1" runat="server">
    <div>
        <dx:ASPxButton ID="ASPxButton1" runat="server" Text="Download Site Inspection Report"></dx:ASPxButton>
        <dx:ASPxHyperLink ID="ASPxHyperLink1" runat="server" Text="ASPxHyperLink"></dx:ASPxHyperLink>
        
    </div>
    </form>
</body>
</html>
