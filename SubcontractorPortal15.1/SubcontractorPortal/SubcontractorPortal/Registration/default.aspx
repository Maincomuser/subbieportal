<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="SubcontractorPortal.Registration._default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <style type="text/css">
        .LMFont
        {
            font-size:16px;
            color:#000000;
            cursor:pointer;
            font-family:Verdana;
        }
        .LMFontTop
        {
            font-size:18px;
            color:#000000;
            cursor:pointer;
            font-family:Verdana;
        }
        .boxed {

            font-size:16px;
            color:#000000;
            cursor:pointer;
            font-family:Verdana;
            border:2px solid #000000;
            padding:5px 5px 5px 5px;   
            
        }

        .btnFloat {float: left;}
        .btnFloatRight {float: right;}
        .btnFloat2 {float: left; margin-left:10px;}
        .spanRight {text-align:right;}

    #PopupWindow{      
        z-index: 999;
        background-color: #B0CCF2;
        text-align: center;
        position: absolute;
        position: fixed;
        left:350px;
        width: 50%;        
        border-left:2px #4F93E3 solid;
        border-right:2px #4F93E3 solid;
        border-bottom:2px #4F93E3 solid;
        display:none;
    }

    .bFont
    {
        font-size: 1.1em;
        font-weight: 500;
        color:#000000;    
        padding:2px 2px 2px 2px;
        font-family:Verdana;
    }

    .List {
    width: 100%;
    height: 400px;
    overflow: scroll;
}

    </style>
        
</head>
<body style="background-color:#009FCE;">

    <script type="text/javascript">

        function CheckForm() {
            window.location.replace('Instructions.aspx');
        }

    </script>
    <form id="form1" runat="server">

        <asp:HiddenField ID="CorrectiveActions" runat="server" ClientIDMode="Static" />
        





        <table style="width:1000px; background-color:white" align="center">
            <tr>
                <td>

        <table align="center">
            <tr>
                
                <td class="LMFontTop">
                    <img src="../Images/Maincom_Group_Logo.jpg" width="200" height="80" />
                    
            </tr>

            <tr>
                
                <td class="LMFontTop">                    
                    Maincom Group Induction</td>
            </tr>

            <tr>
                <td class="LMFont">                     

                </td>
            </tr>

        </table>

    <table width="100%" cellspacing="7">
        <tr>
            <td class="LMFont" align="center">                    
                        Welcome to the maincom group online trade panel application and induction. 
                    
            </td>
        </tr>
        <tr>
            <td class="LMFont" align="center">&nbsp;</td>
        </tr>

        <tr>
            <td class="LMFont">
                Maincom Group is an ISO  Certificied accredited Organisation.                    
            </td>
        </tr>
        <tr>
            <td class="LMFont">
                This covers our standards for:
                <ul>
                    <li style="padding-top:10px;"> ISO 9001 Quality Management Systems</li>
                    <li style="padding-top:10px;">AS/NZS 4801 Occupational Health and Safety Management Systems</li>
                    <li style="padding-top:10px;">ISO 14001 Environmental Managment Systems</li>                                                
                </ul>
                                   
            </td>
        </tr>
        <tr>
            <td class="LMFont"">
                Maincom Group Locations:
                <ul>
                    <li style="padding-top:10px;">Australian Head Office: Penrith NSW and offices in QLD, VIC, WA and SA</li>                    
                    <li style="padding-top:10px;">New Zealand: Offices in Aukland and Christchurch</li>                                                
                </ul>
                                   
            </td>
        </tr>

    </table>
    <table width="100%">
        <tr>
            <td>
                <img src="/Images/site-safe.png" />
            </td>
            <td>
                <img src="/Images/jas-anz.png" />
            </td>
            <td>
                <img src="/Images/sustain.png" />
            </td>

        </tr>
        <tr>
            <td>
                <img src="/Images/master-builders.png" />
            </td>
            <td>
                <img src="/Images/cm3.png" />
            </td>
            <td>
                &nbsp;
            </td>

        </tr>

    </table>

        <table align="center" cellpadding="7">
            <tr>
                <td class="LMFont">&nbsp;</td>
            </tr>

            <tr>
                <td align="center">
                    <dx:ASPxButton ID="NextBtn" ClientInstanceName="NextBtn" runat="server" Width="200px" Height="30px" Text="Continue Induction" BackColor="ForestGreen" Border-BorderStyle="Solid" Border-BorderWidth="2px" Font-Bold="true" AutoPostBack="False" ClientIDMode="Static" EnableClientSideAPI="True" ClientSideEvents-Click="CheckForm"></dx:ASPxButton>
                </td>

            </tr>
            <tr>
                <td class="LMFont">&nbsp;</td>
            </tr>

        </table>

        <!-- end main table -->
                </td>
            </tr>
        </table>



    </form>
</body>
</html>
