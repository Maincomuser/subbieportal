<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Step4a.aspx.cs" Inherits="SubcontractorPortal.Registration.Step4a" %>

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
            window.location.replace('Step4b.aspx');
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
                    Terms & Conditions you must agree on:</td>
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
1. Scope of Contract and Payment - A reference to Order Details in these Terms and Conditions means the Order Details as specified on the front page of the Work Order
Conditions and which may be amended and or supplemented by the Order Details as specified in any Work Order subsequently issued by Maincom Services to which these terms and conditions are incorporated by reference. <br />
Except as otherwise expressly agreed upon in rating between a duly authorised officer of Maincom Services   and the Subcontractor, the e Terms and Conditions will apply notwithstanding any provisions to the contrary which may appear on any quotation, order form or other document issued by the Subcontractor. <br />
The Subcontractor shall complete the Works in a professional, expeditious, safe and Workmanlike manner. <br />
The Subcontractors shall follow the Code of Conduct and adhere to the Maincom Values, Vision and Mission statements at all times. The Subcontractor shall be responsible for the hole of the Works, including the Work of any sub-contractors. <br />
Maincom Services   shall, in accordance with any Work Order, pay to the Subcontractor the Subcontract Sum stated in the Order Details as such sum may be adjusted in accordance with the Work Order. 
                            <br />
                            <br />
2. Maincom Services Instructions and Variations - Maincom Services may from time to time issue instructions to the Subcontractor regarding the Works and the Subcontractor shall comply with them.   Maincom Services may instruct the Subcontractor to vary the Works.   The Subcontractor shall have No Claim arising out of or in connection with that instruction or any variation to the Works unless either: <br /><br />
(1) Maincom Services and the Subcontractor agree in rating as to the amount of any such payment and to the extent of any extension of time. <br />
For the purposes of agreeing the amount of any such payment, any pre-agreed rates shall be applied; or<br />
(2) notwithstanding any failure to agree as contemplated by sub-clause (1), Maincom Services gives the Subcontractor a written instruction expressed (on the face of the instruction) to be given under this sub-clause (2) and instructing the Subcontractor to proceed. <br />
3. Regulations, Notices, Fees and Consents - The Subcontractor shall comply with the requirements of all authorities having jurisdiction over the Works and shall give and receive all notices and pay all fees and deposits. <br />
If, in connection with the performance of the  Works, it is necessary for the Subcontractor to obtain access to any property, the Subcontractor shall do so at its on cost and shall obtain all necessary consents and approvals from landowners and occupiers to carry out all repairs as per Building Code Of your Region whether instructed by Maincom or not. <br />
The Subcontractor bears absolutely the risk of site conditions including any latent conditions and is deemed to h have inspected the Incident Address and made all relevant inquiries and satisfied itself it can carry out the  Works having regard to those site conditions without t any increase e in the Subcontract Sum. <br />
The Subcontractor is deemed to have allowed in the Subcontract Sum and the Subcontractor's program for all things reasonably incidental to performing the Works under this Subcontract notwithstanding such Work is not expressly stated in any Work Order.  The Subcontractor shall have No Claim against Maincom Services in respect of the matters in this Clause 3. <br />
The Subcontractor shall apply and provide complete evidence of all copies to Maincom Services of all Compliance/Consent Certificates for Works completed if and when such applies. <br />
4. warranties and Acknowledgements - In addition to the other warranties given by the Subcontractor, Including Manufacturer's warranty on all materials under the  Work Order, the Subcontractor hereby warrants to Maincom Services as follows: the Works under the Subcontract will be performed in a proper and Workmanlike manner in accordance with any documents and plans and specifications forming part of the Work Order; all material Order, those materials will be ne; the Works to be executed in accordance with any  Work Order will be done in accordance with and comply with any applicable law; the Works to be executed in accordance with any  Work Order will be done with due diligence and within the time stipulated in the Work Order, or if no time stipulated, within a reasonable time; the Works and all materials used in doing the Works will be fit for the specified purpose or result; and all Work done under any  Work Order will comply it: 
<br /><br />
(a)  The Building Code of your region, specific trade codes and/or equal or above to all required regional Standards; <br />
(b) All other relevant codes, standards and specifications that the Works are required to comply with under any law; and<br />
(c)  The conditions of any relevant development consent or complying development certificate. 
<br />
5. Design Responsibility - The provisions in this Clause 5 will apply if in the Order Details the Subcontractor is stated as being responsible for the Design of the Works for that Work Order.
<br />
(1) For the purposes of this Clause and the Subcontract: <br />
(a) "Design" means such design, conceptual design, design development and design documentation (including shop drawings) as the<br />
Subcontractor must provide under the Work Order. <br />
(b) "Design Documents" means the computer, computer programs, drawings (including modifications to any drawings or any additional drawings), models, patterns, samples, specifications and other information and the like required by the e  Work Order, and created for the design of the Works. <br />
(2)  The Subcontractor shall be fully responsible for the Design required to carry out the Works in accordance with the Work Order. <br />
(3)  The Subcontractor shall carry out the Design so that the Works are in accordance with the Work Order, and so that the Works are fit in every<br />
(4)  Should this Subcontract be terminated for any reason, Maincom Services may take possession of any Design Documents developed for the Purposes of carrying out the Works.  <br />                                                                                                                                                                                                                                                                                                                                          6. Superintendence and Other Subcontractors - The Subcontractor shall superintend the hole of the  Works and shall nominate to Maincom Services in rating a person authorised to receive instructions from Maincom Services as required in relation to his or her purpose on site. <br />
The Subcontractor acknowledges that it does not have sole and exclusive possession of the Incident Address and must co-ordinate its  Works with the Work being carried out by the other contractors, sub -contractors, Workers engaged by Maincom Services and the Client. The Subcontractor must comply with all directions issued by Maincom Services with respect to the co-ordination of the  Works including with the Works carried out by others and must do so at no additional cost to Maincom Services. <br />
The Subcontractor must not without the written approval of Maincom Services. Subcontract any of the Works.  Approval to subcontract will not relieve the Subcontractor from any liability or obligation under any Work Order.  The Subcontractor will be liable to Maincom Services for the acts and omissions of its subcontractors and employees and agents of its subcontractors as if they were acts or omissions of the Subcontractor. <br />
7. Start Date and Completion Date - "Completion" means completion of the Works such that they are useable by the Client and free from identifiable defects, here the Subcontractor has provided the Completion Certificate required under sub clause (4) and here all surplus materials and rubbish have been removed and the Incident Address has been cleaned and tidied. <br />
The Subcontractor shall commence the Works on the Start Date set out in the Details.  Prior to commencing the Works the Subcontractor must complete a Site Risk Assessment and here high risk Work is preformed and identified, the subcontractor must also provide and make available on site a S MS document obtained by their on authority signed by all that attend the property during the risk period and provide a copy to Maincom Services. <br />
The Subcontractor shall achieve Completion by the Date for Completion set out in the Order Details or as such date may be adjusted by Maincom Services at its discretion and (subject to Clause 2) in recognition of the delays caused by any variations or caused by any act, omission or default on the part of Maincom Services, or any servant or agent of Maincom Services. <br />
The Subcontractor shall procure the signature of the Completion Certificate attached at Appendix 3 by the Client hen the Subcontractor considers that it has achieved Completion.  It is a precondition to Completion that the Subcontractor has procured a signed C completion Certificate from the Client. If the Client is not available to sign the Completion Certificate, the Subcontractor must contact Maincom Services and arrange for Maincom Services to inspect the Works and sign the Completion Certificate on behalf of the Client. If the Client or Maincom Services identify any defects in the  Works which require rectification prior to the signing the Completion Certificate, the Subcontractor tor must rectify those defects immediately and to the satisfaction of the Client or Maincom Services  (as the case may be), acting reasonably, and as a precondition to the signing of the Completion Certificate. <br />
8. Damages for Late Completion - Should the date hen Completion is achieved as advised by Maincom Services be after the Date for Completion, then, without prejudice to
Any other rights of Maincom Services the Subcontractor shall allow Maincom Services a sum calculated at the rate stated in the Order Details as Liquidated Damages and such amount may be deducted from payments, from retention and any balance may be recovered by Maincom Services as a debt due to it by the Subcontractor. <br />
Here there is no sum stated on the Order Details, the Subcontractor is liable to pay or allow to be deducted the costs estimated by<br />
Maincom Services to be suffered by it as a result of the delay in completing the Works by the Date for Completion. <br />
If this clause 8 (or any part thereof) is found for any reason to be void, invalid or otherwise inoperative so as to disentitle Maincom Services from claiming delay liquidated damages, Maincom Services is entitled to claim against the Subcontractor damages at la for the Subcontractor's failure to achieve Completion by the Date for Completion. <br />
9. Defects and Defects Liability Period - In addition to rectifying any defects in the  Works, the Subcontractor is required to rectify, replace and/or pay for any damage caused and/or Contributed to by the Subcontractor to the Client's property. <br />
Without limiting the preceding paragraph, the Subcontractor shall be responsible for and make good any defects in materials or Workmanship as advised by Maincom Services for a period after the Date of Completion as stated in the Order Details.  This period shall be deemed the Defects Liability Period. <br />
10. Claims and Payments - The Subcontractor shall be entitled to make a claim for payment upon Completion of the  Works and subject to the submission by the Subcontractor of a copy of any  Work Order, a  Work, Health and Safety Statement, a Completion Certificate signed by the Client or Maincom Services, a signed off Compliance certificate if such applies, a completed and signed S MS document relating to all high risk Work, a proper GST invoice disclosing a valid ABN and the value of any and all applicable taxes including GST and a duly executed Subcontractor's Statement in the approved form of the relevant state in which the  Works were carried out, if such applies in that state. For example, for Works carried out in in your region, the applicable form is set out in Appendix 2 to this Subcontract or a later version as approved by the relevant authorities; without the claim for payment will not be registered for payment approval until these are all received. <br />
Maincom Services shall pay to the Subcontractor within the time stated in the Order Details the amount assessed by Maincom Services to be due, calculated from the date the Subcontractor's claim is made and having regard to any deductions that Maincom Services is entitled to make under this Subcontract including without limitation the estimated cost of rectifying defects. <br />
Payment shall be on account only and no payment shall be deemed to signify approval or acceptance of any Works up to that time completed. <br />
Maincom Services may set off against any amount owing to the Subcontractor the amount of any loss or damage which Maincom Services claims to be due to it as a result of any act or omission of the Subcontractor. <br />
11. Retention - In making payments, Maincom Services shall be entitled to deduct up to the percentage stated in the Order Details from the amount otherwise payable, provided that on the Date of Completion all moneys then retained, other than that sum nominated to be held during the Defects Liability Period as stated in the Order Details shall be released to the Subcontractor. <br />
Any amount so deducted shall be by way of performance security and shall be available to Maincom Services   whenever Maincom Services    may claim to be entitled to the payment of moneys by the Subcontractor under or in conn connection with this Subcontract or the  Works or whenever Maincom Services may claim to be entitled to reimbursement of any moneys paid to others under or in connection with any  Work Order or whenever Maincom Services may claim to be entitled to other moneys payable by the Subcontractor to Maincom Services (whether by way of set-off or otherwise).    <br />
12. Final Payment - On the Expiration of the Defects Liability Period and completion of making good any defects and omissions and on certification n by the Subcontractor that he has completed all the Works in accordance with this Subcontract, the Subcontractor shall be entitled to payment of any amount retained and to any other amount outstanding provided that, in connection with any amount outstanding, it has complied with clause 15 and it has submitted a complete statement of accounts, has handed over all certificates of authorities relating to the Works and all required guarantees and warranties. <br />
13. Insurance - (1) The Subcontractor shall in the joint names of itself, all sub-contractors and Maincom Services for their respective right, interests and liabilities affect all insurances directed by Maincom Services to be effected including without limitation those stipulated in the Order Details in the amounts and for the period nominated in the Order Details. <br />
(2) The insurances referred to in this Clause 13 shall be affected before the Works are commenced and shall be maintained effective until Completion except with respect to any professional indemnity insurance which must be maintained for a period of 6 years after Completion. <br />
(3) All the above mentioned policies shall be affected in accordance with the Order Details or otherwise with an insurer nominated by the Subcontractor and approved by Maincom Services and the Subcontractor must provide Maincom Services with a Certificate of Currency and a copy of the policy wording. <br />
14. Passing of Title - In respect of any materials or goods to be supplied as part of the Works, property in such materials and goods shall pass to the Client upon the happening of the earlier of either: payment being made in respect of those materials or goods; or those materials or goods being delivered to the Incident Address. <br />
15. Notice of Claims - All claims for damages, compensation, unjust enrichment, restitution, or adjustment to the Subcontract Sum, all matters of interpretation and clarification of this Subcontract and all claims whether in contract, tort (including negligence), unjust enrichment not or otherwise (collectively referred to as a "claim") will be dealt with in accordance with this Clause. <br /><br />
Each claim must be in rating and specify: <br />
(a)  the perceived legal basis for the claim including, here appropriate, a reference to the clause of this Subcontract under which the claim is made; <br />
(b)  the facts relied upon in support of the claim in sufficient detail to permit verification; and<br />
(c)  details of the quantification of the sums claimed then known to the Subcontractor and the manner in which such sums have been calculated. <br />
The Subcontractor will not have a right to submit any claim, initiate any action or proceedings against Maincom Services and will have No Claim in respect of any matter, fact or thing of any nature arising out of or in connection with or under any Work Order or the Works unless the Subcontractor within 10 days of the Date of Completion lodges that claim in rating with Maincom Services in accordance with the requirements of this Clause 15. <br />
For the purposes of the Work Order, "No Claim" means no claim for any moneys or for any adjustment to the Subcontract Sum or for any extension of time for Completion or for costs, expense, or loss or damage on any basis whatsoever including, without limitation on, a claim: 
<br /><br />
(a)  pursuant to contract; <br />
(b)  in tort (including negligence); (c) on a quantum merit; <br />
(d)  pursuant to quasi contract; (e) for unjust enrichment; or<br />
(f)  without limitation, pursuant to any other principle of la or equity. <br />
16. Occupational Health and Safety - The Subcontractor must comply as per regional requirements: <br />
(a)  all relevant legislative requirements concerning Occupational Health and Safety and Work Health and Safety; <br />
(b)  directions of Maincom Services with respect to the Incident Address including any occupational health and safety and Work Health and Safety requirements and any site induction requirements of Maincom Services  without limiting the generality of sub-clause (1): <br />
(a) the Subcontractor must exercise all necessary precautions for the health and safety of all persons, including its employees, employees of Maincom Services and members of the public may be affected by the actions of the Subcontractor;
(b) the Subcontractor must inform itself of all occupational health and safety and  Work Health and Safety policies, procedures or measures implemented or adopted by Maincom Services and the occupiers of any premises at or within which the Subcontractor performs the  Works; and<br />
(c)  Maincom Services will be entitled, but under no obligation, to issue directions in relation to occupational health and safety and Work Health and Safety issues and the Subcontractor must, at its on cost, comply with those directions to produce the highest level of health and safety. <br />
(1)   The Subcontractor indemnifies Maincom Services against any action, claim, demand, cost or expense to which it may be exposed <br />
arises from a breach of  its  obligations under this  Clause 16  or  from the  enforcement of  any legislative requirements concerning occupational health and safety and  Work Health and Safety including, without limitation, the Regulations as a result of any breach by the Subcontractor of its obligations under this Subcontract. <br />
17. Termination - Should the Subcontractor be in default of any provision of the Work Order, then Maincom Services may give notice in rating to the Subcontractor describing the default and stating that if it is not remedied within 1 day of sending the notice, either Maincom Services may employ and pay others to remedy the default (at the Subcontractor's cost) or may d determine the employment of the Subcontractor.  If the Subcontractor does not make good the matter in which it is in default within that period of time, then Maincom Services  either may employ and pay others to remedy the default (at the Subcontractor's cost) or may give notice to the Subcontractor that the employment of the Subcontractor is thereby determined. <br />
If the Subcontractor becomes bankrupt, enters into a scheme of arrangement with creditors, goes into liquidation or a receive r is appointed, Maincom Services may terminate this Contract immediately without prejudice to any right which might have accrued or may accrue. <br />
18. Termination and Reduction for Convenience - Maincom Services may, by written notice, terminate any Work Order immediately.  The Subcontractor must immediately do everything possible to mitigate consequential losses and continue Work on the provision of the works not affected by the notice. <br />
there has been a termination under sub-clause (1), Maincom Services will be liable only for: (a) payments for Works performed before termination; and<br />
(b) the cost of materials and goods properly ordered for the Works for which the Subcontractor shall have paid or for which the Subcontractor is legally bound to pay; and<br />
(c)  the reasonable cost of demobilization of the Subcontractor. <br />
The Subcontractor otherwise will have No Claim against Maincom Services.  Maincom Services will not be liable to pay any compensation relating to the termination including for loss of prospective profits. <br />
19. Licensing - The Subcontractor warrants that it is the holder of a current and valid license from the Department of Fair Trading which permits the carrying out of residential building Works which are the subject of any Work Order.  The Subcontractor undertakes to ensure that this license remains valid throughout the period of any Work Order and acknowledges the validity of such license is a fundamental condition of the Work Order. <br />
20. Notices - Any notices required to be given to either party shall be deemed sufficiently given if sent by pre-paid mail or facsimile to the person for whom it is intended at the address appearing in any Work Order.  <br />
21. Goods and Services Tax - The parties agree that: <br />
(1)  if any Payment is consideration for a Taxable Supply for which the supplier is liable to GST, the recipient must pay the GST Amount to the supplier, concurrently with the relevant payment unless otherwise agreed in rating; <br />
(2)  any reference to a cost or expense in any  Work Order excludes any amount of GST forming part of the cost or expense hen the relevant party incurring the cost or expense can claim an Input Tax Credit; and<br />
(3)  the supplier will provide to the recipient a Tax Invoice for each supply. In this Clause 21: GST Amount means any Payment multiplied by the applicable rate at which the GST is levied; <br />
GST Act means the A Ne Tax System (Goods and Services Tax) Act 1999; and<br />
Input Tax Credit, Tax Invoice and Taxable Supply have the meanings given to those expressions in the GST Act. <br />
22. Disputes - Differences or disputes between the parties arising under or in any way related to any Work Order or the subject matter thereof ('dispute') will be resolved in accordance with this Clause 
<br />
23.  A party claiming a dispute has arisen must give written notice thereof to the other specifying the nature of the dispute. <br />
within 7 days of receipt of that notice the parties to the dispute shall seek to resolve the dispute by referring the matter to a meeting of the managing director or chief executive officer, or such other authorised persons, of each of the parties. If the dispute is not resolved within 10 days after such referral, a party may commence litigation with respect to the dispute. <br />
23. Reservation of Common La Rights - The parties acknowledge and agree that the provisions of this Contract shall be in addition to any c common la rights of Maincom Services. No provision of this Contract shall limit the operation or generality of any other provision of this Contract which confers any rights on Maincom Services. <br />
24. Governing Law - (1) The law of your state or region governs any Work Order. The parties submit to the exclusive jurisdiction of the courts of your state or region or any competent Federal court exercising jurisdiction in your state or region. The dispute must be determined in accordance with the la and practice applicable in the court.

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
