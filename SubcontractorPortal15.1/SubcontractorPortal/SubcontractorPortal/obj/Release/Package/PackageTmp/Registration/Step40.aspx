<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Step40.aspx.cs" Inherits="SubcontractorPortal.Registration.Step40" %>

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
                            <td class="LMFont" colspan="3">&nbsp;</td>
                        </tr>

                        <tr>                
                            <td class="LMFontTop" colspan="3">  
                                What Trade Must Know:<br />                                                  
                            </td>
                        </tr>

                        <tr>
                            <td class="LMFont" colspan="3">&nbsp;</td>
                        </tr>

                    </table>

                    <table width="100%" style="border:solid 2px #000000" cellspacing="5">
                        <tr>
                            <td class="LMFont">Item No</td>
                            <td class="LMFont" align="left">Description</td>
                            <td class="LMFont">Agree</td>
                            <td class="LMFont">Disagree</td>
                        </tr>
                        <tr>
                            <td colspan="4"><hr /></td>
                        </tr>

                        <tr>
                            <td class="LMFont">4.1</td>
                            <td class="LMFont" align="left">
                                Trades MUST have all Tools and Applinces including extension leads tagged and displayed as per current period. 
                            </td>
                            <td class="boxed" id="yes1" onclick="Pty('no1', 'yes1');"> YES</td>
                            <td class="boxed" id="no1" onclick="NotPty('yes1', 'no1');"> NO</td>
                        </tr>
                        <tr>
                            <td colspan="4"><hr /></td>
                        </tr>
                        <tr>
                            <td class="LMFont">4.2</td>
                            <td class="LMFont" align="left">All Plant and equipment Must have up to date log books, service history and registered experienced to be used on site.</td>
                            <td class="boxed" id="yes3" onclick="Skill('no3', 'yes3');"> YES</td>
                            <td class="boxed" id="no3" onclick="Skill('yes3', 'no3');"> NO</td>
                        </tr>
                        <tr>
                            <td colspan="4"><hr /></td>
                        </tr>
                        <tr>
                            <td class="LMFont">4.3</td>
                            <td class="LMFont" align="left">If Hydrolic equipment is used on site, including Pumps, all hoses and Hydrolic connections must show recent evidence of last test and service. </td>
                            <td class="boxed" id="yes5" onclick="Pty('no5', 'yes5');"> YES</td>
                            <td class="boxed" id="no5" onclick="NotPty('yes5', 'no5');"> NO</td>
                        </tr>

                        <tr>
                            <td colspan="4"><hr /></td>
                        </tr>
                        <tr>
                            <td class="LMFont">4.4</td>
                            <td class="LMFont" align="left">Trads must sign this final agreement acting as a contract between you and the Maincom group. </td>
                            <td class="boxed" id="yes6" onclick="Pty('no6', 'yes6');"> YES</td>
                            <td class="boxed" id="no6" onclick="NotPty('yes6', 'no6');"> NO</td>
                        </tr>

                        <tr>
                            <td colspan="4"><hr /></td>
                        </tr>
                        <tr>
                            <td class="LMFont">4.5</td>
                            <td class="LMFont" align="left">The Maincom Code of Conduct Must be read and understood by before signing. This Code of Conduct must be strictly adheared to. </td>
                            <td class="boxed" id="yes7" onclick="Pty('no7', 'yes7');"> YES</td>
                            <td class="boxed" id="no7" onclick="NotPty('yes7', 'no7');"> NO</td>
                        </tr>
                        <tr>
                            <td colspan="4"><hr /></td>
                        </tr>
                        <tr>
                            <td class="LMFont">4.6</td>
                            <td class="LMFont" align="left">The Maincom Vision , Mission and Values must be read, understood and agreed too. </td>
                            <td class="boxed" id="yes8" onclick="Pty('no8', 'yes8');"> YES</td>
                            <td class="boxed" id="no8" onclick="NotPty('yes8', 'no8');"> NO</td>
                        </tr>
                        <tr>
                            <td colspan="4"><hr /></td>
                        </tr>
                        <tr>
                            <td class="LMFont">4.7</td>
                            <td class="LMFont" align="left">When accepting a Work order from Maincom, the Work proceedures MUST be followed. Any Changes to the description of works will be required to be approved by Maincom and a change of Scope of works signed by the Property Owner/Representative. </td>
                            <td class="boxed" id="yes9" onclick="Pty('no9', 'yes9');"> YES</td>
                            <td class="boxed" id="no9" onclick="NotPty('yes9', 'no9');"> NO</td>
                        </tr>
                        <tr>
                            <td colspan="4"><hr /></td>
                        </tr>
                        <tr>
                            <td class="LMFont">4.8</td>
                            <td class="LMFont" align="left">Work Order Dates MUST be met once the work order is accepted. The dates can only be changed via a request from the Subbie Portal and accepted by the Maincom Supervisor. </td>
                            <td class="boxed" id="yes10" onclick="Pty('no10', 'yes10');"> YES</td>
                            <td class="boxed" id="no10" onclick="NotPty('yes10', 'no10');"> NO</td>
                        </tr>
                        <tr>
                            <td colspan="4"><hr /></td>
                        </tr>
                        <tr>
                            <td class="LMFont">4.9</td>
                            <td class="LMFont" align="left">When receiving a Maincom Work Order, the trade MUST accept this and Contact the Property Owner/Represtative within 24Hrs of receiving this Work order. Penalties will apply for late contact. </td>
                            <td class="boxed" id="yes11" onclick="Pty('no11', 'yes11');"> YES</td>
                            <td class="boxed" id="no11" onclick="NotPty('yes11', 'no11');"> NO</td>
                        </tr>
                        <tr>
                            <td colspan="4"><hr /></td>
                        </tr>
                        <tr>
                            <td class="LMFont">4.10</td>
                            <td class="LMFont" align="left">All work MUST be carried out to all respective Building Standards. Do not commence work unless you are absolute the finish can be warranted.  You Touch It - You Own it!</td>
                            <td class="boxed" id="yes12" onclick="Pty('no12', 'yes12');"> YES</td>
                            <td class="boxed" id="no12" onclick="NotPty('yes12', 'no12');"> NO</td>
                        </tr>


                    </table>

                    <table align="center">
                        <tr>
                            <td class="LMFont">&nbsp;</td>
                        </tr>

                        <tr>
                            <td align="center">
                                <dx:ASPxButton ID="NextBtn" ClientInstanceName="NextBtn" runat="server" Width="200px" Height="30px" Text="Save & Continue" Border-BorderStyle="Solid" Border-BorderWidth="2px" Font-Bold="true" AutoPostBack="True" ClientIDMode="Static" EnableClientSideAPI="True"></dx:ASPxButton>
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
