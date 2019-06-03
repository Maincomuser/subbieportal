<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Step2.aspx.cs" Inherits="SubcontractorPortal.Registration.Step2" %>

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
        .small
        {
            font-size:10px;
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
            //openTextArea('PopupWindow');
            
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

        function BadName(Clear, Set) {
            SetItem(Clear, Set);            

        }
        
        function NotBadName(Clear, Set) {
            SetItem(Clear, Set);
            
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
            window.location.replace('Step2a.aspx');
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
            <td class="LMFont" align="right">Company ABN:</td>
            <td class="LMFont">
                                <dx:ASPxTextBox ID="ABN" ClientInstanceName="ABN" runat="server" Border-BorderStyle="Solid" Border-BorderWidth="2px" Height="30px" Width="450px" Border-BorderColor="Black" Font-Size="20px">
                                    <Border BorderColor="Black" BorderStyle="Solid" BorderWidth="2px"></Border>
                                </dx:ASPxTextBox>
            </td>
        </tr>

        <tr>
            <td class="LMFont" align="right">Company ACN:</td>
            <td class="LMFont">
                                <dx:ASPxTextBox ID="ACN" ClientInstanceName="ACN" runat="server" Border-BorderStyle="Solid" Border-BorderWidth="2px" Height="30px" Width="450px" Border-BorderColor="Black" Font-Size="20px">
                                    <Border BorderColor="Black" BorderStyle="Solid" BorderWidth="2px"></Border>
                                </dx:ASPxTextBox>
            </td>
        </tr>

        <tr>
            <td class="LMFont" align="right">Number of Employees:
                

            </td>
            <td class="LMFont">
                <table>
                    <tr>
                        <td>
                                <dx:ASPxTextBox ID="Employees" ClientInstanceName="Employees" runat="server" Border-BorderStyle="Solid" Border-BorderWidth="2px" Height="30px" Width="50px" Border-BorderColor="Black" Font-Size="20px">
                                    <Border BorderColor="Black" BorderStyle="Solid" BorderWidth="2px"></Border>
                                </dx:ASPxTextBox>

                        </td>
                        <td><span class="small">Please note this must macth the signed names on the Code of Conduct</span></td>
                    </tr>
                </table>

                
            </td>
        </tr>

        <tr>
            <td class="LMFont" align="right">How long has your Company been in operation:</td>
            <td class="LMFont">
                    <div class="btnFloat">
                                <dx:ASPxTextBox ID="CompanyYears" ClientInstanceName="CompanyYears" runat="server" Border-BorderStyle="Solid" Border-BorderWidth="2px" Height="30px" Width="50px" Border-BorderColor="Black" Font-Size="20px">
                                    <Border BorderColor="Black" BorderStyle="Solid" BorderWidth="2px"></Border>
                                </dx:ASPxTextBox>
                    </div>
                    <div class="btnFloat2">Years</div>                
                    <div class="btnFloat2">
                                <dx:ASPxTextBox ID="CompanyMonth" ClientInstanceName="CompanyMonth" runat="server" Border-BorderStyle="Solid" Border-BorderWidth="2px" Height="30px" Width="50px" Border-BorderColor="Black" Font-Size="20px">
                                    <Border BorderColor="Black" BorderStyle="Solid" BorderWidth="2px"></Border>
                                </dx:ASPxTextBox>
                    </div>
                    <div class="btnFloat2">Month</div>

            </td>
        </tr>

        <tr>
            <td class="LMFont" align="right">Are you Registered for GST?</td>
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
            <td colspan="2"><hr /></td>
        </tr>
        <tr>
            <td class="LMFont" align="right">Has the Company conducted work for Maincom in the past in this name or any other name?</td>
            <td>
                <table>
                    <tr>
                        <td class="boxed" id="yes2" onclick="Maincom('no2', 'yes2');"> YES</td>
                        <td class="boxed" id="no2" onclick="NotMaincom('yes2', 'no2');"> NO</td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td class="LMFont" align="right">If yes Provide Details: </td>
            <td class="LMFont">
                <dx:ASPxMemo runat="server" ID="MaincomDetails" ClientInstanceName="MaincomDetails" Width="99%"  Border-BorderWidth="2px" Height="50px" Border-BorderColor="Black" ></dx:ASPxMemo>
            </td>
        </tr>
        <tr>
            <td class="LMFont" align="right"> Has your company had any contracts terminated for poor performances, any contracts where damages are required to be paid, and Corrective Actions against you over the past 3 years? </td>
            <td>
                <table>
                    <tr>
                        <td class="boxed" id="yes3" onclick="BadName('no3', 'yes3');"> YES</td>
                        <td class="boxed" id="no3" onclick="NotBadName('yes3', 'no3');"> NO</td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td class="LMFont" align="right">If yes Provide Details: </td>
            <td class="LMFont">
                <dx:ASPxMemo runat="server" ID="ASPxMemo2" ClientInstanceName="MaincomDetails" Width="99%"  Border-BorderWidth="2px" Height="50px" Border-BorderColor="Black" ></dx:ASPxMemo>
            </td>
        </tr>
        <tr>
            <td colspan="2"><hr /></td>
        </tr>

        <tr>

            <td class="LMFont" align="right">Public Liability Policy Number:</td>
            <td class="LMFont">
                <table>
                    <tr>
                        <td>
                                <dx:ASPxTextBox ID="PublicLiabilityNo" ClientInstanceName="PublicLiabilityNo" runat="server" Border-BorderStyle="Solid" Border-BorderWidth="2px" Height="30px" Width="200px" Border-BorderColor="Black" Font-Size="20px">
                                    <Border BorderColor="Black" BorderStyle="Solid" BorderWidth="2px"></Border>
                                </dx:ASPxTextBox>

                        </td>
                        <td class="LMFont">Expired:</td>
                        <td>
                            <dx:ASPxDateEdit ID="PublicLiabilityExpire" ClientInstanceName="PublicLiabilityExpire" runat="server"  Border-BorderStyle="Solid" Border-BorderWidth="2px" Height="30px" Font-Size="20px" Border-BorderColor="Black"></dx:ASPxDateEdit>
                        </td>
                    </tr>
                </table>

            </td>
        </tr>

        <tr>

            <td class="LMFont" align="right">Workers Compension Policy Number:</td>
            <td class="LMFont">
                <table>
                    <tr>
                        <td>
                                <dx:ASPxTextBox ID="WorkersCompensionNo" ClientInstanceName="WorkersCompensionNo" runat="server" Border-BorderStyle="Solid" Border-BorderWidth="2px" Height="30px" Width="200px" Border-BorderColor="Black" Font-Size="20px">
                                    <Border BorderColor="Black" BorderStyle="Solid" BorderWidth="2px"></Border>
                                </dx:ASPxTextBox>

                        </td>
                        <td class="LMFont">Expired:</td>
                        <td>
                            <dx:ASPxDateEdit ID="WorkersCompensionExpire" ClientInstanceName="WorkersCompensionExpire" runat="server"  Border-BorderStyle="Solid" Border-BorderWidth="2px" Height="30px" Font-Size="20px" Border-BorderColor="Black"></dx:ASPxDateEdit>
                        </td>
                    </tr>
                </table>

            </td>
        </tr>

        <tr>
            <td class="LMFont" align="right">List All Your Contractor Licences:</td>
            <td class="LMFont">
                <dx:ASPxMemo runat="server" ID="Licences" ClientInstanceName="Licences" Width="99%"  Border-BorderWidth="2px" Height="100px" Border-BorderColor="Black" Font-Size="18px"></dx:ASPxMemo>
            </td>
        </tr>
        <tr>
            <td class="LMFont" align="right">List All Your Skills:              
                

            </td>
            <td class="LMFont">
                <table width="100%" cellpadding="0" cellspacing="0">
                    <tr>
                        <td>
                            <dx:ASPxMemo runat="server" ID="ASPxMemo1" ClientInstanceName="Licences" Width="99%"  Border-BorderWidth="2px" Height="100px" Border-BorderColor="Black" Font-Size="18px"></dx:ASPxMemo>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <span class="small">Remember to ensure you are licensed if required and your SWMS/SSSP shows the Risk control for this work.</span>
                        </td>
                    </tr>
                </table>
                
            </td>
        </tr>


        <tr>
            <td class="LMFont" colspan="2"><hr /></td>
        </tr>
                    <tr>
                        <td class="LMFont" align="right">&nbsp;</td>
                        <td>
                            <span class="small">This data is optional, but will facilitate registration if application is successful.</span>
                        </td>
                    </tr>

        <tr>
            <td class="LMFont" align="right">Bank Name:</td>
            <td class="LMFont">
                                <dx:ASPxTextBox ID="Bank" ClientInstanceName="Bank" runat="server" Border-BorderStyle="Solid" Border-BorderWidth="2px" Height="30px" Width="450px" Border-BorderColor="Black" Font-Size="20px">
                                    <Border BorderColor="Black" BorderStyle="Solid" BorderWidth="2px"></Border>
                                </dx:ASPxTextBox>
            </td>
        </tr>
        <tr>
            <td class="LMFont" align="right">Account Name:</td>
            <td class="LMFont">
                                <dx:ASPxTextBox ID="AccountName" ClientInstanceName="AccountName" runat="server" Border-BorderStyle="Solid" Border-BorderWidth="2px" Height="30px" Width="450px" Border-BorderColor="Black" Font-Size="20px">
                                    <Border BorderColor="Black" BorderStyle="Solid" BorderWidth="2px"></Border>
                                </dx:ASPxTextBox>
            </td>
        </tr>
        <tr>
            <td class="LMFont" align="right">Account Number:</td>
            <td class="LMFont">
                                <dx:ASPxTextBox ID="AccountNo" ClientInstanceName="AccountNo" runat="server" Border-BorderStyle="Solid" Border-BorderWidth="2px" Height="30px" Width="250px" Border-BorderColor="Black" Font-Size="20px">
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
