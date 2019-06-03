<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Instructions.aspx.cs" Inherits="SubcontractorPortal.Registration.Instructions" %>

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
            window.location.replace('CodeOfConduct.aspx');
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
                    Instructions, Terms & Conditions:</td>
            </tr>

            <tr>
                <td class="LMFont">                     

                </td>
            </tr>

        </table>

    <table width="100%" cellspacing="7">
        <tr>
            <td class="LMFont">                    
                        1. In the following questionary each Question must be answered honestly.                    
                    
            </td>
        </tr>
        <tr>
            <td class="LMFont">                    
                        2. You will be asked at the end of the questionare to provide evidence of the answers. This will require the following documents to be scanned and ready to upload:                     
                    <ul>
                        <li style="padding-top:10px;">A signed Code of Conduct by all your team members that will attend a Maincom work site (download is avalaible on next page)</li>
                        <li style="padding-top:10px;"> A copy of your Public Liability Certificate Of Currency</li>
                        <li style="padding-top:10px;"> A copy of your Workers Compensation Certificate of Currency as per Act 1987 (Australian Trades only)</li>
                        <li style="padding-top:10px;"> A copy of a completed generic SWMS for the skills you offer (Australian Trades only)</li>
                        <li style="padding-top:10px;"> A copy of your completed generic SSSPs for the skills you offer (New Zealand Trades only)</li>
                        <li style="padding-top:10px;"> A copy of any skill licences for skills you offer that require a licence</li>
                    </ul>
                    <font color="red"><b>NB: If you do not have the above items to upload, you will not be able to complete this registration correctly and it will not be recorded.</b></font>
                        <br />
            </td>
        </tr>
        <tr>
            <td class="LMFont">                    
                        3. You must save each page as asked. By saving information of each page, you will be agreeing to the The Maincom Group Terms and conditions and this will submit your information to the Maicom Group.
                        <br />
&nbsp;</td>
        </tr>
        <tr>
            <td class="LMFont">                    
                        4. Each answer must align with the minimum requirement of the Maincom Group. If this is not met, you will be advised the Induction is terminating.<br />
                        <br />
                        Items you will agree to provide to The Maincom Group:<ul>
                        <li style="padding-top:10px;">You must be a PTY/LTD Company - Not a Sole Trader</li>
                        <li style="padding-top:10px;">Your Answers are to be truthful and you need to be prepared to provide evidence for your answers</li>
                        <li style="padding-top:10px;">The Trade skills you intend to offer must be in-house and we do not allow Subbie on Subbie action</li>
                        <li style="padding-top:10px;">Your insurances must be valid and these include Workers Compensation (for applicable regions) and Public Liability.</li>
                        <li style="padding-top:10px;">Your Skills Licencing must be valid</li>
                        <li style="padding-top:10px;">Your SWMS/SSSP must be valid and show risks and proper control methods </li>
                        <li style="padding-top:10px;">You must agree to follow your regions WHS regulations</li>
                        <li style="padding-top:10px;">You must be registered for GST and have a valid ABN (AU) or CAN (NZ) number.</li>
                    </ul>
                    
                        <p>
                    <font color="red"><b>NB: If you do not have ready the above items, you will not be able to complete this registration correctly and it will not be recorded.</b></font> 
                            <br />
                        </p>
                    
            </td>
        </tr>
        <tr>
            <td class="LMFont">                    
                        5. All information provided will be reviewed by the Maincom Group and upon review a decision will be made to ensure all items and answers provided are correct. The application may then be accepted or denied. If denied, The Maincom Group will contact you to explain items that may be incorrect.<br><br>* Completion of this registration is not an automatic approved application. The Maincom Group will review all applications.<br />
                    
            </td>
        </tr>
        <tr>
            <td class="LMFont">                    
                        6. You must agree to use the Maincom Group Subbie portal following a training session to be advised.                    
            </td>
        </tr>
        <tr>
            <td class="LMFont">                    
                        7. You agree to provide a signed WHS statement provided to you via the Subbie Portal with every Tax Invoice.
            </td>
        </tr>
        <tr>
            <td class="LMFont">                    
                        8. You agree to provide a Customer Satisfaction sign off with every Tax Invoice.
            </td>
        </tr>
        <tr>
            <td class="LMFont">                    
                        9. You agree to provide the Compliance Certificate for required works with your Tax Invoice.
            </td>
        </tr>
        <tr>
            <td class="LMFont">                    
                        10. Your invoice amount must equal the Work order amount.
            </td>
        </tr>
        <tr>
            <td class="LMFont">                    
                        111. You will regulate your capacity and quality of work to align with all Required regions Building Standards and Start and Finish dates pre-set.
            </td>
        </tr>
        <tr>
            <td class="LMFont">                    
                        12. You will only follow repair strategy as detailed on your Work Orders.
            </td>
        </tr>
        <tr>
            <td class="LMFont">                    
                        13. You will not discuss further repair options or price with any home owner/Insured/Representative.
            </td>
        </tr>
        <tr>
            <td class="LMFont">                    
                        114. You will follow your entire regions Building Code Standard and agree not to complete works that cannot be warranted.
            </td>
        </tr>
        <tr>
            <td class="LMFont">                    
                        15. You will align and follow all Work Safety Procedures as per your regional requirements.
            </td>
        </tr>
        <tr>
            <td class="LMFont">                    
                        16. All work orders are addressed and Clients called within 24 Hrs of accepting the Work Order. 
            </td>
        </tr>

    </table>


        <table align="center" cellpadding="7">
            <tr>
                <td class="LMFont">&nbsp;</td>
            </tr>

            <tr>
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
