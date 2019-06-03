<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Step1.aspx.cs" Inherits="SubcontractorPortal.Registration.Step11" %>

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
            window.location.replace('Step2.aspx?regNo=7837RT');
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
        

<div id="PopupWindow">
            <center>
                <table width="100%"  style="cursor:pointer; border-top:solid 2px #4F93E3; align-self:center" cellpadding=0 cellspacing=0>
                    <tr bgcolor="#B0CCF2">
                        <td align="center" class="bFont"  onclick="openTextArea('PopupWindow');"><b><span id="Span4">Induction Terminated</span></b></td>
                        <td align="right" width="25">   
                            <a href="javascript:void(0)" onclick="openTextArea('PopupWindow');"><img alt="close window" src="/images/close.png"  class="borderless"  /></a>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <table style="background-color:#fff; width:100%;">
                                <tr>
                                    <td class="LMFont">
                                        <div class="List">
                                        <font color=red>For any assistance or some further details, Please call the Training and Compliance Manager at The Maincom Group: 0430 033 878</font><br /><br />

                                        You may have selected an answer that does not align with the basic requirements of the Maincom Group.<br /><br />
                                            Here are some reminders of what is required:
                                            <ul>
                                                <li style="padding-top:10px;">You must be a PTY/LTD Company</li>
                                                <li style="padding-top:10px;">You must be truthful in your answers and be prepared to provide evidence of your answers</li>
                                                <li style="padding-top:10px;">You will be required to upload all documents to provide evidence for your answers</li>
                                                <li style="padding-top:10px;">You must have the Skill set you offer to Maincom as an employed skill of your Company and at no time Outsource any skill of work you accept from Maincom</li>
                                                <li style="padding-top:10px;">You will need to show and upload evidence of your valid registered skill licence for the skill you offer</li>
                                                <li style="padding-top:10px;">You will need to provide evidence (Upload the SWMS/SSSP) of your Safe Work Method Statement (SWMS/SSSP) to proceed as per Work Safe regulations in your region</li>
                                                <li style="padding-top:10px;">You must provide evidence of your Company ABN/ACN, Workers Compensation Validation or Government Registeration / Public Liability Insurance to align with your regions requirements</li>
                                                <li style="padding-top:10px;">All Documents must be uploaded for The Maincom Group to review and asses the documents are true and correct prior to finalising this Online Induction.</li>
                                                
                                            </ul>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </td>                        
                    </tr>
                    <tr>
                        <td colspan="2" style="height:25px;">
                            <div class="btnFloat">&nbsp;
                               </div>
                        </td>
                    </tr>
                </table>

            </center>
</div>





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
                    Maincom Group Induction.</td>
            </tr>

            <tr>
                <td class="LMFont">                     

                </td>
            </tr>

        </table>

    <table width="100%" cellspacing="7">
        <tr>
            <td class="LMFont" align="center">                    
                        Please answer the following questions:
                    
            </td>
        </tr>
    </table>
    <table width="100%" cellspacing="7">

        <tr>
            <td class="LMFont" align="right">Company Name:</td>
            <td class="LMFont">
                                <dx:ASPxTextBox ID="Company" ClientInstanceName="Company" runat="server" Border-BorderStyle="Solid" Border-BorderWidth="2px" Height="30px" Width="450px" Border-BorderColor="Black" Font-Size="20px">
                                    <Border BorderColor="Black" BorderStyle="Solid" BorderWidth="2px"></Border>
                                </dx:ASPxTextBox>
            </td>
        </tr>

            <tr>
                <td class="LMFont" align="right">Are you a Pty/Ltd Company?</td>
                <td>
                    <table>
                        <tr>
                            <td class="boxed" id="yes1" onclick="Pty('no1', 'yes1');"> YES</td>
                            <td class="boxed" id="no1" onclick="NotPty('yes1', 'no1');"> NO</td>
                        </tr>
                    </table>
                </td>
            </tr>


        <tr>
            <td class="LMFont" align="right">Comany Directors Name:</td>
            <td class="LMFont">
                                <dx:ASPxTextBox ID="Director" ClientInstanceName="Director" runat="server" Border-BorderStyle="Solid" Border-BorderWidth="2px" Height="30px" Width="450px" Border-BorderColor="Black" Font-Size="20px">
                                    <Border BorderColor="Black" BorderStyle="Solid" BorderWidth="2px"></Border>
                                </dx:ASPxTextBox>

            </td>
        </tr>

        <tr>
            <td class="LMFont" align="right">Email Address:</td>
            <td class="LMFont">
                                <dx:ASPxTextBox ID="Email" ClientInstanceName="Email" runat="server" Border-BorderStyle="Solid" Border-BorderWidth="2px" Height="30px" Width="450px" Border-BorderColor="Black" Font-Size="20px">
                                    <Border BorderColor="Black" BorderStyle="Solid" BorderWidth="2px"></Border>
                                </dx:ASPxTextBox>
            </td>
        </tr>
        <tr>
            <td class="LMFont" align="right">Business address:</td>
            <td class="LMFont">
                                <dx:ASPxTextBox ID="Address" ClientInstanceName="Address" runat="server" Border-BorderStyle="Solid" Border-BorderWidth="2px" Height="30px" Width="450px" Border-BorderColor="Black" Font-Size="20px">
                                    <Border BorderColor="Black" BorderStyle="Solid" BorderWidth="2px"></Border>
                                </dx:ASPxTextBox>
            </td>
        </tr>
        <tr>
            <td class="LMFont" align="right">Suburb:</td>
            <td class="LMFont">
                                <dx:ASPxTextBox ID="Suburb" ClientInstanceName="Suburb" runat="server" Border-BorderStyle="Solid" Border-BorderWidth="2px" Height="30px" Width="350px" Border-BorderColor="Black" Font-Size="20px">
                                    <Border BorderColor="Black" BorderStyle="Solid" BorderWidth="2px"></Border>
                                </dx:ASPxTextBox>
            </td>
        </tr>
        <tr>
            <td class="LMFont" align="right">Postcode:</td>
            <td class="LMFont">
                                <dx:ASPxTextBox ID="Postcode" ClientInstanceName="Postcode" runat="server" Border-BorderStyle="Solid" Border-BorderWidth="2px" Height="30px" Width="100px" Border-BorderColor="Black" Font-Size="20px">
                                    <Border BorderColor="Black" BorderStyle="Solid" BorderWidth="2px"></Border>
                                </dx:ASPxTextBox>
            </td>
        </tr>
        <tr>
            <td class="LMFont" align="right">State/Region:</td>
            <td class="LMFont">
                                <dx:ASPxTextBox ID="State" ClientInstanceName="State" runat="server" Border-BorderStyle="Solid" Border-BorderWidth="2px" Height="30px" Width="100px" Border-BorderColor="Black" Font-Size="20px">
                                    <Border BorderColor="Black" BorderStyle="Solid" BorderWidth="2px"></Border>
                                </dx:ASPxTextBox>
            </td>
        </tr>
        <tr>
            <td class="LMFont" align="right">Postal address:</td>
            <td class="LMFont">
                                <dx:ASPxTextBox ID="Postal" ClientInstanceName="Postal" runat="server" Border-BorderStyle="Solid" Border-BorderWidth="2px" Height="30px" Width="450px" Border-BorderColor="Black" Font-Size="20px">
                                    <Border BorderColor="Black" BorderStyle="Solid" BorderWidth="2px"></Border>
                                </dx:ASPxTextBox>
            </td>
        </tr>
        <tr>
            <td class="LMFont" colspan="2"><hr /></td>
        </tr>
        <tr>
            <td class="LMFont" align="right">Contact Name:</td>
            <td class="LMFont">
                                <dx:ASPxTextBox ID="Contact" ClientInstanceName="Contact" runat="server" Border-BorderStyle="Solid" Border-BorderWidth="2px" Height="30px" Width="450px" Border-BorderColor="Black" Font-Size="20px">
                                    <Border BorderColor="Black" BorderStyle="Solid" BorderWidth="2px"></Border>
                                </dx:ASPxTextBox>
            </td>
        </tr>
        <tr>
            <td class="LMFont" align="right">Contact position:</td>
            <td class="LMFont">
                                <dx:ASPxTextBox ID="Position" ClientInstanceName="Position" runat="server" Border-BorderStyle="Solid" Border-BorderWidth="2px" Height="30px" Width="450px" Border-BorderColor="Black" Font-Size="20px">
                                    <Border BorderColor="Black" BorderStyle="Solid" BorderWidth="2px"></Border>
                                </dx:ASPxTextBox>
            </td>
        </tr>
        <tr>
            <td class="LMFont" align="right">Mobile Number:</td>
            <td class="LMFont">
                                <dx:ASPxTextBox ID="Mobile" ClientInstanceName="Mobile" runat="server" Border-BorderStyle="Solid" Border-BorderWidth="2px" Height="30px" Width="250px" Border-BorderColor="Black" Font-Size="20px">
                                    <Border BorderColor="Black" BorderStyle="Solid" BorderWidth="2px"></Border>
                                </dx:ASPxTextBox>
            </td>
        </tr>
        <tr>
            <td class="LMFont" align="right">Office Number:</td>
            <td class="LMFont">
                                <dx:ASPxTextBox ID="Office" ClientInstanceName="Office" runat="server" Border-BorderStyle="Solid" Border-BorderWidth="2px" Height="30px" Width="250px" Border-BorderColor="Black" Font-Size="20px">
                                    <Border BorderColor="Black" BorderStyle="Solid" BorderWidth="2px"></Border>
                                </dx:ASPxTextBox>
            </td>
        </tr>
        <tr>
            <td class="LMFont" align="right">Contact Email Address:</td>
            <td class="LMFont">
                                <dx:ASPxTextBox ID="ContactEmail" ClientInstanceName="ContactEmail" runat="server" Border-BorderStyle="Solid" Border-BorderWidth="2px" Height="30px" Width="450px" Border-BorderColor="Black" Font-Size="20px">
                                    <Border BorderColor="Black" BorderStyle="Solid" BorderWidth="2px"></Border>
                                </dx:ASPxTextBox>
            </td>
        </tr>

        <tr>
            <td class="LMFont" align="right">Fax (if applicable):</td>
            <td class="LMFont">
                                <dx:ASPxTextBox ID="Fax" ClientInstanceName="Fax" runat="server" Border-BorderStyle="Solid" Border-BorderWidth="2px" Height="30px" Width="250px" Border-BorderColor="Black" Font-Size="20px">
                                    <Border BorderColor="Black" BorderStyle="Solid" BorderWidth="2px"></Border>
                                </dx:ASPxTextBox>
            </td>
        </tr>
        <tr>
            <td class="LMFont" align="right">Website:</td>
            <td class="LMFont">
                                <dx:ASPxTextBox ID="Website" ClientInstanceName="Website" runat="server" Border-BorderStyle="Solid" Border-BorderWidth="2px" Height="30px" Width="450px" Border-BorderColor="Black" Font-Size="20px">
                                    <Border BorderColor="Black" BorderStyle="Solid" BorderWidth="2px"></Border>
                                </dx:ASPxTextBox>
            </td>
        </tr>

    </table>

        <table align="center" cellpadding="7">
            <tr>
                <td class="LMFont" colspan="2">&nbsp;</td>
            </tr>

            <tr>
            <td>
                <dx:ASPxButton ID="ASPxButton1" ClientInstanceName="ReturnBack" runat="server" Width="200px" Height="30px" Text="Return Back" BackColor="Yellow" Border-BorderStyle="Solid" Border-BorderWidth="2px" Font-Bold="true" AutoPostBack="False" ClientIDMode="Static" EnableClientSideAPI="True" ClientSideEvents-Click="Back"></dx:ASPxButton>
            </td>

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
