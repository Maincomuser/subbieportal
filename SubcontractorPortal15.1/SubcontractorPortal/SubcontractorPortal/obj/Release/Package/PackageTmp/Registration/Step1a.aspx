<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Step1a.aspx.cs" Inherits="SubcontractorPortal.Registration.Step1a" %>

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
    }

    function NotPty(Clear, Set) {
        SetItem(Clear, Set);
        var obj = document.getElementById('HasNo');
        if (obj) {
            obj.value = "1";
        }
        openTextArea('PopupWindow');

    }

    function Skill(Clear, Set) {
        SetItem(Clear, Set);
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
        /*
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
        */
        window.location.replace("Step1.aspx?regNo=7837RT");
    }

    function SaveDoc() {
        var theForm = document.forms['form1'];
        if (!theForm) {
            theForm = document.form1;
        }
        theForm.submit();
    }

    function Back() {
        window.location.replace('<%=BackURL%>');
    }


    </script>

    
    <form id="form1" runat="server">

        <asp:HiddenField ID="HasNo" runat="server" ClientIDMode="Static" />
        

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
                
                            <td class="LMFontTop" colspan="3" >
                                <img src="../Images/Maincom_Group_Logo.jpg" width="200" height="80" />
                    
                        </tr>
                        <tr>
                            <td class="LMFont" colspan="3">&nbsp;</td>
                        </tr>

                        <tr>                
                            <td class="LMFontTop" colspan="3">                    
                                Please answer the following questions:
                            </td>
                        </tr>

                        <tr>
                            <td class="LMFont" colspan="3">&nbsp;</td>
                        </tr>

                    </table>

                    <table width="100%" style="border:solid 2px #000000" cellspacing="5">

                        <tr>                            
                            <td class="LMFont" align="left">For Australia - Do you have a Valid Construction Induction Card?
                                <br /><br />
                                For New Zealand - Do you have a valid SiteWise Passport?
                            </td>
                            <td class="boxed" id="yes1" onclick="Pty('no1', 'yes1');"> YES</td>
                            <td class="boxed" id="no1" onclick="NotPty('yes1', 'no1');"> NO</td>
                        </tr>
                        <tr>
                            <td colspan="3"><hr /></td>
                        </tr>
                        <tr>                            
                            <td class="LMFont" align="left">Does the skill you provide require a Licence?  </td>
                            <td class="boxed" id="yes3" onclick="Skill('no3', 'yes3');"> YES</td>
                            <td class="boxed" id="no3" onclick="Skill('yes3', 'no3');"> NO</td>
                        </tr>
                        <tr>                            
                            <td class="LMFont" align="left">If yes are you licenced for this skill?  </td>
                            <td class="boxed" id="yes4" onclick="Pty('no4', 'yes4');"> YES</td>
                            <td class="boxed" id="no4" onclick="NotPty('yes4', 'no4');"> NO</td>
                        </tr>
                        <tr>
                            <td colspan="3"><hr /></td>
                        </tr>
                        <tr>                            
                            <td class="LMFont" align="left">Do you agree to prepare a WHS (Work Health & Safety) Plan for high risk work as required by your regional Regulations?  </td>
                            <td class="boxed" id="yes5" onclick="Pty('no5', 'yes5');"> YES</td>
                            <td class="boxed" id="no5" onclick="NotPty('yes5', 'no5');"> NO</td>
                        </tr>

                        <tr>
                            <td colspan="3"><hr /></td>
                        </tr>
                        <tr>                            
                            <td class="LMFont" align="left">Do you agree to provide Maincom Group your Generic (AU) SWMS (Safe Work Method Statement) or (NZ) SSSP (Site Specific Safety plan) as required by your regional Regulations?</td>
                            <td class="boxed" id="yes6" onclick="Pty('no6', 'yes6');"> YES</td>
                            <td class="boxed" id="no6" onclick="NotPty('yes6', 'no6');"> NO</td>
                        </tr>

                        <tr>
                            <td colspan="3"><hr /></td>
                        </tr>
                        <tr>                            
                            <td class="LMFont" align="left">Do you agree to provide Maincom Group your JSA (Job Safety Analysis) for any high Risk found on individual on Job Sites as required by your regional Regulations? </td>
                            <td class="boxed" id="yes7" onclick="Pty('no7', 'yes7');"> YES</td>
                            <td class="boxed" id="no7" onclick="NotPty('yes7', 'no7');"> NO</td>
                        </tr>
                        <tr>
                            <td colspan="3"><hr /></td>
                        </tr>
                        <tr>                            
                            <td class="LMFont" align="left">Do you agree to provide on all jobs the MSDS (Material Safety Data Sheets) for the materials used?</td>
                            <td class="boxed" id="yes8" onclick="Pty('no8', 'yes8');"> YES</td>
                            <td class="boxed" id="no8" onclick="NotPty('yes8', 'no8');"> NO</td>
                        </tr>
                        <tr>
                            <td colspan="3"><hr /></td>
                        </tr>
                        <tr>                            
                            <td class="LMFont" align="left">Do you agree to provide with your Tax Invoice all Compliance Certification, Signed WHS document, Customer Sign off documents for work completed? </td>
                            <td class="boxed" id="yes9" onclick="Pty('no9', 'yes9');"> YES</td>
                            <td class="boxed" id="no9" onclick="NotPty('yes9', 'no9');"> NO</td>
                        </tr>

                    </table>

                    <table align="center">
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

                </td>
            </tr>
            
        </table>



    </form>
</body>
</html>
