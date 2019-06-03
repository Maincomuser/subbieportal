﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="OtherConditions.aspx.cs" Inherits="SubcontractorPortal.Registration.OtherConditions" %>

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
        function Pty(Clear, Set) {
            SetItem(Clear, Set);
            ShowItem('CM3');
        }

        function NotPty(Clear, Set) {
            SetItem(Clear, Set);
            openTextArea('PopupWindow');
        }

        function CM(Clear, Set) {
            SetItem(Clear, Set);

            var obj = document.getElementById('cm3Item');
            if (obj) {
                obj.value = "1";
            }

            ShowItem('Comp');
        }
        function NotCM(Clear, Set) {
            SetItem(Clear, Set);
            var obj = document.getElementById('cm3Item');
            if (obj) {
                obj.value = "0";
            }

            ShowItem('Comp');

        }

        function Comp(Clear, Set) {
            SetItem(Clear, Set);
            ShowItem('Public');
        }

        function NotComp(Clear, Set) {
            SetItem(Clear, Set);
            openTextArea('PopupWindow');
        }

        function Public(Clear, Set) {
            SetItem(Clear, Set);
            ShowItem('Employees');


        }

        function NotPublic(Clear, Set) {
            SetItem(Clear, Set);
            openTextArea('PopupWindow');
        }


        function Maincom(Clear, Set) {
            SetItem(Clear, Set);
            ShowBlock('MaincomDetail');
            ShowItem('OtherCompany');

            var obj = document.getElementById('CorrectiveActions');
            if (obj) {
                obj.value = "1";
            }

            NextBtn.SetVisible(true);

        }

        function NotMaincom(Clear, Set) {
            SetItem(Clear, Set);
            HideBlock('MaincomDetail');
            ShowItem('OtherCompany');

            var obj = document.getElementById('CorrectiveActions');
            if (obj) {
                obj.value = "0";
            }

            NextBtn.SetVisible(true);

        }


        function SetItem(Clear, Set) {

            var obj2 = document.getElementById(Clear);
            if (obj2) {
                obj2.style.backgroundColor = "white";
            }

            var obj = document.getElementById(Set);
            if (obj) {
                obj.style.backgroundColor = "yellow";
            }
        }
        function ShowItem(item) {
            var obj = document.getElementById(item);
            if (obj) {
                obj.style.visibility = "visible";
            }
        }

        function ShowBlock(item) {
            var obj = document.getElementById(item);
            if (obj) {
                obj.style.display = "block";
            }
        }
        function HideBlock(item) {
            var obj = document.getElementById(item);
            if (obj) {
                obj.style.display = "none";
            }
        }

        function openTextArea(ID) {
            var obj = document.getElementById(ID);
            if (obj.style.display == "block")
            { obj.style.display = "none" }
            else {
                { obj.style.display = "block" }
            }
            // hide current window if required
            var HideObj;
            try {
                HideObj = document.getElementById(objToHide);
                HideObj.style.display = "none";
                objToHide = null;
            } catch (err) {
                //Handle errors here
            }


        }

        function CheckForm() {
            window.location.replace('Step1a.aspx');
        }

        function SaveDoc() {
            var theForm = document.forms['form1'];
            if (!theForm) {
                theForm = document.form1;
            }
            theForm.submit();
        }

        function CancelForm() {
            alert("Induction has been cancelled. You can now close this window.\nYou may return to the induction at any time later.");
        }
        function Back() {
            window.location.replace('<%=BackURL%>');
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
                    Other Conditions you must agree&nbsp;on while working for Maincom Group:</td>
            </tr>

            <tr>
                <td class="LMFont">                     

                </td>
            </tr>

        </table>

    <table width="100%" cellspacing="15">
        <tr>
            <td class="LMFont">                    
                        1. Trades MUST have all Tools and Appliances, including extension leads, tagged and displayed as per current period.</td>
        </tr>
        <tr>
            <td class="LMFont">                    
                        2. All Plant and equipment Must have up to date log books, service history and registered experienced to be used on site.</td>
        </tr>

        <tr>
            <td class="LMFont">                    
                        3. If Hydraulic equipment used on site, including Pumps, all hoses and Hydraulic connections must show recent evidence of last test and service.</td>
        </tr>
        <tr>
            <td class="LMFont">                    
                        4. Trades must sign final agreement acting as a contract between you and The Maincom Group.</td>
        </tr>
        <tr>
            <td class="LMFont">                    
                        5. The Maincom Group Code of Conduct Must be read and understood by before signing. This Code of Conduct must be strictly adhered to.</td>
        </tr>
        <tr>
            <td class="LMFont">                    
                        6. The Maincom Group Vision, Mission and Values must be read, understood and agreed too.</td>
        </tr>
        <tr>
            <td class="LMFont">                    
                        7. When accepting a Work order from The Maincom Group, the Work procedures MUST be followed. Any Changes to the description of works will be required to be approved by The Maincom Group and a change to the Scope of works must be signed and acknowledged by the Property Owner/Representative.
            </td>
        </tr>
        <tr>
            <td class="LMFont">                    
                        8. Work Order Dates MUST be met once the work order is accepted. The dates can only be changed via a request from the Subbie Portal and accepted by the The Maincom Group Supervisor.</td>
        </tr>
        <tr>
            <td class="LMFont">                    
                        9. When receiving a The Maincom Group Work Order, the trade MUST accept this and Contact the Property Owner/Representative within 24Hrs of receiving this Work order. Penalties may apply for late contact.</td>
        </tr>
        <tr>
            <td class="LMFont">                    
                        10. All work MUST be carried out to all respective Building Standards in your region. Do not commence work unless you are absolute the finish can be warranted. You Touch It - You Own it!</td>
        </tr>

    </table>


        <table align="center" cellpadding="7">
            <tr>
                <td class="LMFont" colspan="3">&nbsp;</td>
            </tr>

            <tr>
                <td>
                    <dx:ASPxButton ID="ASPxButton12" ClientInstanceName="ReturnBack" runat="server" Width="200px" Height="30px" Text="Return Back" BackColor="Yellow" Border-BorderStyle="Solid" Border-BorderWidth="2px" Font-Bold="true" AutoPostBack="False" ClientIDMode="Static" EnableClientSideAPI="True" ClientSideEvents-Click="Back"></dx:ASPxButton>
                </td>

                <td align="center">
                    <dx:ASPxButton ID="NextBtn" ClientInstanceName="NextBtn" runat="server" Width="200px" Height="30px" Text="Agree & Continue" BackColor="ForestGreen" Border-BorderStyle="Solid" Border-BorderWidth="2px" Font-Bold="true" AutoPostBack="False" ClientIDMode="Static" EnableClientSideAPI="True" ClientSideEvents-Click="CheckForm"></dx:ASPxButton>
                </td>
                <td align="center">
                    <dx:ASPxButton ID="ASPxButton1" ClientInstanceName="NextBtn" runat="server" Width="200px" Height="30px" Text="Cancel Induction" BackColor="Red" Border-BorderStyle="Solid" Border-BorderWidth="2px" Font-Bold="true" AutoPostBack="False" ClientIDMode="Static" EnableClientSideAPI="True" ClientSideEvents-Click="CancelForm"></dx:ASPxButton>
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
