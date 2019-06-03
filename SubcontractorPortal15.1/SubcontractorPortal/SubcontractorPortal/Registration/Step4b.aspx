<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Step4b.aspx.cs" Inherits="SubcontractorPortal.Registration.Step4b" %>

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
            window.location.replace('Step4.aspx');
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
                    Work Order Conditions you must agree on:</td>
            </tr>

            <tr>
                <td class="LMFont">                     

                </td>
            </tr>

        </table>

    <table width="100%" cellspacing="15">
        <tr>
            <td class="LMFont">                    
                        <div id="" style="overflow:scroll; height:400px;">
                    This agreement ("Work Order Conditions") sets out the general terms and conditions on which the Subcontractor has agreed to carry out works on behalf of the Maincom Group.  The Work Order Conditions consist of this front page, the attached Terms and Conditions and the attached Appendices including Appendices 1 to 3. <br>The Work Order Conditions are the agreed general terms and conditions to be incorporated into any 'Work Order' issued by the Maincom Group.  A Work Order is a direction and/or instruction by the Maincom Group to the Subcontractor to carry out works as specified in that Work Order. 
                            <br />
                            <br>An example of the form of a Work Order is at Appendix 1.  By executing these Work Order Conditions, the Subcontractor agrees, acknowledges and represents that: 
                            <br />
                            <br> (a) all contracts and dealings between The Maincom Group and the Subcontractor relating to any works which the Subcontractor is engaged by The Maincom Group to carry out including works the subject of a Work Order issued by The Maincom Group to the Subcontractor are subject to the terms and conditions set out in this Work Order Conditions unless otherwise expressly agreed by The Maincom Group in writing. 
                            <br />
                            <br> (b) the terms and conditions set out in this Work Order Conditions may be amended and/or supplemented by Order Details set out in a Work Order. To the extent that there may be any inconsistency between the Order Details in the Work Order Conditions and the e Order Details in any Work Order, the terms of the relevant Work Order will prevail.  
                            <br />
                            <br> (c)  if there are Special Conditions set out in any Work Order, to the extent that there may be any inconsistency between the Special Conditions set out in the Work Order and the terms and conditions in the Work Order Conditions, the Special Conditions in the relevant Work Order will prevail.  <br> (d) it is aware of the terms and conditions set out in this Work Order Conditions and agrees to be bound by those terms and conditions in the event that a Work Order is issued to the Subcontractor to carry out works specified in a Work Order; <br> (e) The Maincom Group is not obliged and may, including for no reason, at its sole and unfettered discretion not issue a Work Order to the Subcontractor;  <br /><br> (f) The Maincom Group is otherwise not obliged to engage the Subcontractor to carry out any works;  <br /><br> (g) where The Maincom Group does not issue a Work Order, The Maincom Group does not have any liability to the Subcontractor  <br /><br> (h) if works are carried out not to Building regulations, then responsibility will be to the Subcontractor to amend the repairs to align with the required standards.

                        </div>
            </td>
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
