<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Step20.aspx.cs" Inherits="SubcontractorPortal.Registration.Step20" %>

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
            var objCompanyName = CompanyName.GetText();
            if (objCompanyName == null || objCompanyName == "") {
                alert("Error! Company name must be provided.");
                return;
            }

            var objContactName = ContactName.GetText();
            if (objContactName == null || objContactName == "") {
                alert("Error! Contact name must be provided.");
                return;
            }

            var objABN = ABN.GetText();
            if (objABN == null || objABN == "") {
                alert("Error! ABN must be provided.");
                return;
            }

            SaveDoc();
        }

        function SaveDoc() {
            var theForm = document.forms['form1'];
            if (!theForm) {
                theForm = document.form1;
            }
            theForm.submit();
        }

    </script>
    <form id="form1" runat="server">

        <asp:HiddenField ID="CorrectiveActions" runat="server" ClientIDMode="Static" />
        





        <table style="width:1000px; background-color:white" align="center">
            <tr>
                <td>

        <table align="center">
            <tr>
                
                <td class="LMFontTop" colspan="3" >
                    <img src="../Images/Maincom_Group_Logo.jpg" width="200" height="80" />
                    
            </tr>

            <tr>
                
                <td class="LMFontTop" colspan="3">                    
                    Please answer the following questions:</td>
            </tr>

            <tr>
                <td class="LMFont" colspan="3">&nbsp;</td>
            </tr>

        </table>

    <table width="100%" cellspacing="7">
        <tr>
            <td class="LMFont" align="right">Company Name:</td>
            <td class="LMFont">
                        <dx:ASPxTextBox ID="CompanyName" ClientInstanceName="CompanyName" runat="server" Border-BorderStyle="Solid" Border-BorderWidth="2px" Height="30px" Width="450px" Border-BorderColor="Black" Font-Size="20px">
                            <Border BorderColor="Black" BorderStyle="Solid" BorderWidth="2px"></Border>
                        </dx:ASPxTextBox>
            </td>
        </tr>
        <tr>
            <td class="LMFont" align="right">Directors Name:</td>
            <td class="LMFont">
                        <dx:ASPxTextBox ID="DirectorsName" ClientInstanceName="DirectorsName" runat="server" Border-BorderStyle="Solid" Border-BorderWidth="2px" Height="30px" Width="450px" Border-BorderColor="Black" Font-Size="20px">
                            <Border BorderColor="Black" BorderStyle="Solid" BorderWidth="2px"></Border>
                        </dx:ASPxTextBox>
            </td>
        </tr>
        <tr>
            <td class="LMFont" align="right">Contact Name:</td>
            <td class="LMFont">
                        <dx:ASPxTextBox ID="ContactName" ClientInstanceName="ContactName" runat="server" Border-BorderStyle="Solid" Border-BorderWidth="2px" Height="30px" Width="450px" Border-BorderColor="Black" Font-Size="20px">
                            <Border BorderColor="Black" BorderStyle="Solid" BorderWidth="2px"></Border>
                        </dx:ASPxTextBox>
            </td>
        </tr>
        <tr>
            <td class="LMFont" align="right">Person Completing this Induction: </td>
            <td class="LMFont">
                        <dx:ASPxTextBox ID="Person" ClientInstanceName="Person" runat="server" Border-BorderStyle="Solid" Border-BorderWidth="2px" Height="30px" Width="450px" Border-BorderColor="Black" Font-Size="20px">
                            <Border BorderColor="Black" BorderStyle="Solid" BorderWidth="2px"></Border>
                        </dx:ASPxTextBox>
            </td>
        </tr>
        <tr>
            <td class="LMFont" align="right">ABN  number:</td>
            <td class="LMFont">
                        <dx:ASPxTextBox ID="ABN" ClientInstanceName="ABN" runat="server" Border-BorderStyle="Solid" Border-BorderWidth="2px" Height="30px" Width="450px" Border-BorderColor="Black" Font-Size="20px">
                            <Border BorderColor="Black" BorderStyle="Solid" BorderWidth="2px"></Border>
                        </dx:ASPxTextBox>
            </td>
        </tr>
        <tr>
            <td class="LMFont" align="right">ACN  number (if applicable):</td>
            <td class="LMFont">
                        <dx:ASPxTextBox ID="ACN" ClientInstanceName="ACN" runat="server" Border-BorderStyle="Solid" Border-BorderWidth="2px" Height="30px" Width="450px" Border-BorderColor="Black" Font-Size="20px">
                            <Border BorderColor="Black" BorderStyle="Solid" BorderWidth="2px"></Border>
                        </dx:ASPxTextBox>
            </td>
        </tr>

    </table>


        <table align="center">
            <tr>
                <td class="LMFont">&nbsp;</td>
            </tr>

            <tr>
                <td align="center">
                    <dx:ASPxButton ID="NextBtn" ClientInstanceName="NextBtn" runat="server" Width="200px" Height="30px" Text="Save & Continue" Border-BorderStyle="Solid" Border-BorderWidth="2px" Font-Bold="true" AutoPostBack="False" ClientIDMode="Static" EnableClientSideAPI="True" ClientSideEvents-Click="CheckForm"></dx:ASPxButton>
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
