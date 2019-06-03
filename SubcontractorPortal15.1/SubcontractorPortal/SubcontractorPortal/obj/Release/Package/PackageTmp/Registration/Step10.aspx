<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Step10.aspx.cs" Inherits="SubcontractorPortal.Registration.Step10" %>
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
            ShowItem('Actions');
            //NextBtn.SetVisible(true);

        }

        function NotMaincom(Clear, Set) {
            SetItem(Clear, Set);
            HideBlock('MaincomDetail');
            ShowItem('OtherCompany');
            ShowItem('Actions');
            //NextBtn.SetVisible(true);

        }

        function Actions(Clear, Set) {
            SetItem(Clear, Set);
            ShowBlock('ActionsDetail');
            NextBtn.SetVisible(true);
            var obj = document.getElementById('CorrectiveActions');
            if (obj) {
                obj.value = "1";
            }

            
        }

        function NotActions(Clear, Set) {
            SetItem(Clear, Set);
            HideBlock('ActionsDetail');
            NextBtn.SetVisible(true);

            var obj = document.getElementById('CorrectiveActions');
            if (obj) {
                obj.value = "0";
            }

            
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
            var obj = document.getElementById('CorrectiveActions');
            if (obj) {
                if (obj.value == "1") {
                    var text = ActionsDetailText.GetText();
                    if (text == null || text == "") {
                        alert("Error! You answered Yes on the question 5, but did not provide details.\nPlease correct this issue.");
                        return;
                    }
                }
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

        <asp:HiddenField ID="cm3Item" runat="server" ClientIDMode="Static" />
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
                                        You may have selected an answer that does not align with the basic requirements of the Maincom Group.
                                            <ul>
                                                <li style="padding-top:10px;">You must be a PTY/LTD Company</li>
                                                <li style="padding-top:10px;">You must be truthful in your answers and be prepared to provide evidence of your answers</li>
                                                <li style="padding-top:10px;">You will be required to upload all documents to provide evidence for your answers</li>
                                                <li style="padding-top:10px;">You must have the Skill set you offer to Maincom as an employed skill of your Company and at no time Outsource any skill of work you accept from Maincom</li>
                                                <li style="padding-top:10px;">You will need to show and upload evidence of your valid registered skill licence for the skill you offer</li>
                                                <li style="padding-top:10px;">You will need to provide evidence (Upload the SWMS/SSSP) of your Safe Work Method Statement (SWMS/SSSP) to proceed as per Work Safe regulations in your region</li>
                                                <li style="padding-top:10px;">You must provide evidence of your Company ABN/ACN, Workers Compensation Validation or Government Registeration / Public Liability Insurance to align with your regions requirements</li>
                                                <li style="padding-top:10px;">All final Induction Documents prior to finalising this On-Line Induction must be uploaded for Maincom to review and asses the documents are true and correct prior to approval</li>
                                                
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

            <tr>
                <td class="LMFont">Are you a Pty/Ltd Company?</td>
                <td>
                    <table>
                        <tr>
                            <td class="boxed" id="yes1" onclick="Pty('no1', 'yes1');"> YES</td>
                        </tr>
                    </table>
                </td>
                <td>
                    <table>
                        <tr>
                            <td class="boxed" id="no1" onclick="NotPty('yes1', 'no1');"> NO</td>
                        </tr>
                    </table>
                </td>
            </tr>

        </table>

        <table align="center" id="CM3" style="visibility:hidden;">
            <tr>
                <td class="LMFont" colspan="3">&nbsp;</td>
            </tr>

            <tr>
                <td class="LMFont">Is Your Company Registered with Cm3?</td>
                <td>
                    <table>
                        <tr>
                            <td class="boxed" id="cmyes" onclick="CM('cmno', 'cmyes');"> YES</td>
                        </tr>
                    </table>
                </td>
                <td>
                    <table>
                        <tr>
                            <td class="boxed" id="cmno" onclick="NotCM('cmyes', 'cmno');"> NO</td>
                        </tr>
                    </table>
                </td>
            </tr>

        </table>

        <table align="center" id="Comp" style="visibility:hidden; width:800px;">
            <tr>
                <td class="LMFont" colspan="3">&nbsp;</td>
            </tr>

            <tr>
                <td class="LMFont">1a - Does Your Company hold a current Workers Compensation agreement or is covered by a government body (evidence will be required)?</td>
                <td>
                    <table>
                        <tr>
                            <td class="boxed" id="compyes" onclick="Comp('compno', 'compyes');"> YES</td>
                        </tr>
                    </table>
                </td>
                <td>
                    <table>
                        <tr>
                            <td class="boxed" id="compno" onclick="NotComp('compyes', 'compno');"> NO</td>
                        </tr>
                    </table>
                </td>
            </tr>

        </table>

        <table align="center" id="Public" style="visibility:hidden; width:800px;">
            <tr>
                <td class="LMFont" colspan="3">&nbsp;</td>
            </tr>

            <tr>
                <td class="LMFont">1b - Does Your Company Have Public Laibility Insurance (evidence will be required)?</td>
                <td>
                    <table>
                        <tr>
                            <td class="boxed" id="pubyes" onclick="Public('pubno', 'pubyes');"> YES</td>
                        </tr>
                    </table>
                </td>
                <td>
                    <table>
                        <tr>
                            <td class="boxed" id="pubno" onclick="NotPublic('pubyes', 'pubno');"> NO</td>
                        </tr>
                    </table>
                </td>
            </tr>

        </table>

        <table align="center" id="Employees" style="visibility:hidden; width:800px;">
            <tr>
                <td class="LMFont">&nbsp;</td>
            </tr>

            <tr>
                <td class="LMFont">
                    <table cellpadding="5">
                        <tr>
                            <td>2 - How many Employees does your Company employ?</td>
                            <td>
                                <dx:ASPxTextBox ID="EmployeeNumber" ClientInstanceName="EmployeeNumber" runat="server" Border-BorderStyle="Solid" Border-BorderWidth="2px" Height="30px" Width="50px" Border-BorderColor="Black" Font-Size="20px">
                                <ClientSideEvents KeyUp="function(s, e) {
    var num = s.GetText();
    if (num == null || num == ''){
    }else{
	    ShowItem('Oper');
    }
}"

KeyPress="function(s, e) {
	var theEvent = e.htmlEvent || window.event;
    var key = theEvent.keyCode || theEvent.which;
    if(key == 37 || key == 38 || key == 39 || key == 40 || key == 8 || key == 46) { // Left / Up / Right / Down Arrow, Backspace, Delete keys
        return;
    }


    key = String.fromCharCode(key);
   var regex = /[0-9]/;

   if(!regex.test(key))
   {
    theEvent.returnValue = false;
    if(theEvent.preventDefault) 
        theEvent.preventDefault();
   }	
}" 
                                                                        
 />
<Border BorderColor="Black" BorderStyle="Solid" BorderWidth="2px"></Border>
                                </dx:ASPxTextBox></td>
                        </tr>
                    </table>

                </td>
            </tr>

        </table>

        <table align="center" id="Oper" style="visibility:hidden; width:800px;">
            <tr>
                <td class="LMFont">&nbsp;</td>
            </tr>

            <tr>
                <td class="LMFont">
                    <table cellpadding="5">
                        <tr>
                            <td>3a - How long has your Company been in operation (Years/Months)? </td>
                            <td><dx:ASPxTextBox ID="CompanyYears" ClientInstanceName="CompanyYears" runat="server" Border-BorderStyle="Solid" Border-BorderWidth="2px" Height="30px" Width="50px" Border-BorderColor="Black" Font-Size="20px">
                                <ClientSideEvents KeyUp="function(s, e) {

    var num = s.GetText();
    if (num == null || num == ''){
    }else{
	    ShowItem('Maincom');
    }
	
}" KeyPress="function(s, e) {
	var theEvent = e.htmlEvent || window.event;
    var key = theEvent.keyCode || theEvent.which;
    if(key == 37 || key == 38 || key == 39 || key == 40 || key == 8 || key == 46) { // Left / Up / Right / Down Arrow, Backspace, Delete keys
        return;
    }


    key = String.fromCharCode(key);
   var regex = /[0-9]/;

   if(!regex.test(key))
   {
    theEvent.returnValue = false;
    if(theEvent.preventDefault) 
        theEvent.preventDefault();
   }	
}" />
<Border BorderColor="Black" BorderStyle="Solid" BorderWidth="2px"></Border>
                                </dx:ASPxTextBox></td>
                            <td><dx:ASPxTextBox ID="CompanyMonth" ClientInstanceName="CompanyMonth" runat="server" Border-BorderStyle="Solid" Border-BorderWidth="2px" Height="30px" Width="50px" Border-BorderColor="Black" Font-Size="20px">
                                <ClientSideEvents KeyUp="function(s, e) {
	    var num = s.GetText();
    if (num == null || num == ''){
    }else{
	    ShowItem('Maincom');
    }

}"
KeyPress="function(s, e) {
	var theEvent = e.htmlEvent || window.event;
    var key = theEvent.keyCode || theEvent.which;
    if(key == 37 || key == 38 || key == 39 || key == 40 || key == 8 || key == 46) { // Left / Up / Right / Down Arrow, Backspace, Delete keys
        return;
    }


    key = String.fromCharCode(key);
   var regex = /[0-9]/;

   if(!regex.test(key))
   {
    theEvent.returnValue = false;
    if(theEvent.preventDefault) 
        theEvent.preventDefault();
   }	
}"                                    
/>
<Border BorderColor="Black" BorderStyle="Solid" BorderWidth="2px"></Border>
                                </dx:ASPxTextBox></td>
                        </tr>
                    </table>

                </td>
            </tr>

        </table>


        <table align="center" id="Maincom" style="visibility:hidden; width:800px;">
            <tr>
                <td class="LMFont" colspan="3">&nbsp;</td>
            </tr>

            <tr>
                <td class="LMFont">3.b - Has the Company conducted work for Maincom in the past in this name or any other name?</td>
                <td>
                    <table>
                        <tr>
                            <td class="boxed" id="maincomyes" onclick="Maincom('maincomno', 'maincomyes');"> YES</td>
                        </tr>
                    </table>
                </td>
                <td>
                    <table>
                        <tr>
                            <td class="boxed" id="maincomno" onclick="NotMaincom('maincomyes', 'maincomno');"> NO</td>
                        </tr>
                    </table>
                </td>
            </tr>

        </table>

        <table   align="center" style="display:none; width:800px;" id="MaincomDetail">
            <tr>
                <td class="LMFont" colspan="3">&nbsp;</td>
            </tr>

            <tr>
                <td class="LMFont">Please provide details of your previous work for Maincom</td>
            </tr>
            <tr>
                <td>
                    <dx:ASPxMemo ID="WorkForMaincom" runat="server" Width="799px" Height="100px" Border-BorderColor="Black" Border-BorderStyle="Solid" Border-BorderWidth="2px"></dx:ASPxMemo>
                </td>
            </tr>

        </table>

        <table   align="center" style="visibility:hidden; width:800px;" id="OtherCompany">
            <tr>
                <td class="LMFont" colspan="3">&nbsp;</td>
            </tr>

            <tr>
                <td class="LMFont">4 - Whom else does your Company Service in the industry?</td>
            </tr>
            <tr>
                <td>
                    <dx:ASPxMemo ID="OtherCompanyText" runat="server" Width="799px" Height="100px" Border-BorderColor="Black" Border-BorderStyle="Solid" Border-BorderWidth="2px"></dx:ASPxMemo>
                </td>
            </tr>

        </table>

        <table align="center" id="Actions" style="visibility:hidden; width:800px;">
            <tr>
                <td class="LMFont" colspan="3">&nbsp;</td>
            </tr>

            <tr>
                <td class="LMFont">5 - Has your company had any contracts terminated for poor performances, any contracts where damages are required to be paid, and Corrective Actions against you over the past 3 years?</td>
                <td>
                    <table>
                        <tr>
                            <td class="boxed" id="Actionsyes" onclick="Actions('Actionsno', 'Actionsyes');"> YES</td>
                        </tr>
                    </table>
                </td>
                <td>
                    <table>
                        <tr>
                            <td class="boxed" id="Actionsno" onclick="NotActions('Actionsyes', 'Actionsno');"> NO</td>
                        </tr>
                    </table>
                </td>
            </tr>

        </table>

        <table   align="center" style="display:none; width:800px;" id="ActionsDetail">
            <tr>
                <td class="LMFont" colspan="3">&nbsp;</td>
            </tr>

            <tr>
                <td class="LMFont">Please provide details:</td>
            </tr>
            <tr>
                <td>
                    <dx:ASPxMemo ID="ActionsDetailText" ClientInstanceName="ActionsDetailText" runat="server" Width="799px" Height="100px" Border-BorderColor="Black" Border-BorderStyle="Solid" Border-BorderWidth="2px"></dx:ASPxMemo>
                </td>
            </tr>

        </table>



        <table align="center">
            <tr>
                <td class="LMFont">&nbsp;</td>
            </tr>

            <tr>
                <td align="center">
                    <dx:ASPxButton ID="NextBtn" ClientInstanceName="NextBtn" runat="server" Width="200px" Height="30px" Text="Save & Continue" Border-BorderStyle="Solid" Border-BorderWidth="2px" Font-Bold="true" AutoPostBack="False" ClientIDMode="Static" EnableClientSideAPI="True" ClientVisible="False" ClientSideEvents-Click="CheckForm"></dx:ASPxButton>
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
