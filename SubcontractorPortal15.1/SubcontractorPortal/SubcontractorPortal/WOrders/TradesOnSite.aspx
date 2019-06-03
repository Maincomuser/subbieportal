<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TradesOnSite.aspx.cs" Inherits="SubcontractorPortal.WOrders.TradesOnSite1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" href="/Styles/site.css" type="text/css" media="screen" />

 <style type="text/css">
        .topFont
        {
            font-family:Arial;
            font-size:30px;
            font-weight:bold;
        }
        .HFont
        {
            font-family:Arial;
            font-size:20px;
            font-weight:bold;
        }
        .HFontR
        {
            font-family:Arial;
            font-size:20px;
            font-weight:bold;
            text-align:right;
        }
        .HFontRB
        {
            font-family:Arial;
            font-size:20px;
            font-weight:bold;
            border-right:2px solid #000000;
        }

        .HFontsmall
        {
            font-family:Arial;
            font-size:16px;
            font-weight:bold;
        }

        .reg
        {
            font-family:Arial;
            font-size:16px;
        }
        .MFont
        {
            font-family:Arial;
            font-size:18px;
            font-weight:bold;
        }
        .MFontColored
        {
            font-family:Arial;
            font-size:18px;
            font-weight:bold;
            background-color:#C0C0C0;
            height:30px;
        }

        .MFontLight
        {
            font-family:Arial;
            font-size:16px;            
        }
        .MFontLightLeftBorder
        {
            font-family:Arial;
            font-size:16px;  
            border-left:2px solid #000000;          
            text-align:center; 
        }

        .MFontLightCenter
        {
            font-family:Arial;
            font-size:16px;  
            text-align:center;     
            border-left:2px solid #000000;          
            border-bottom:2px solid #000000;     
            
        }

        .MFontR
        {
            font-family:Arial;
            font-size:18px;
            font-weight:bold;
            text-align:right;
            padding-right:5px;
        }
        .sFont
        {
            font-family:Arial;
            font-size:8px;            
            
        }

        .del
        {border-left:2px solid #000000;
         width:2px;
        }

        .LeftBottomBorder
        {
            border-left:2px solid #000000;          
            border-bottom:2px solid #000000;     
            
        }

        li
        {
            margin-bottom:20px;
        }
        .auto-style1
        {
            font-family: Arial;
            font-size: 18px;
            font-weight: bold;
            text-align: right;
            padding-right: 5px;
            height: 30px;
        }


        .auto-style2
        {
            font-family: Arial;
            font-size: 16px;
            font-weight: bold;
            height: 34px;
        }
        .auto-style3
        {
            font-family: Arial;
            font-size: 16px;
            height: 34px;
        }


    </style>


</head>
<body>
    <form id="form1" runat="server">

        <asp:Panel ID="TradesPanel" runat="server">
            <table width="100%" style="border: 1px solid #000;" cellpadding="3" cellspacing="3">
                <tr>
                    <td>&nbsp;</td>                    
                </tr>
                <%=SubbiesOnSite%>
            </table>


        </asp:Panel>

    </form>
</body>
</html>
