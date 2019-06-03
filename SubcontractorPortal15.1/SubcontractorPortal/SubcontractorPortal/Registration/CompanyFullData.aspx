<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CompanyFullData.aspx.cs" Inherits="SubcontractorPortal.Registration.CompanyFullData" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <script type="text/javascript">

        window.history.forward(1);

        function ShowWheel() {
            document.getElementById("processMessage").style.display = "block";

        }

        function CloseErrorsWindow() {
            var x = document.getElementById("ErrorWindow");
            x.style.visibility = 'hidden';
        }

        function CloseAddEmployeeWindow() {
            var x = document.getElementById("AddEmployeeWindow");
            x.style.visibility = 'hidden';
        }

        function OnBtnUploadClick(s, e) {
            if (cbbTradeSkillList.GetText() == "") {
                alert('Please select a skill from the skills list.');
                return;
            }
            if (tbx_AddLicenseNumber.GetText() == "") {
                alert('Please provide a License Number for the Skill.');
                return;
            }
            if (tbx_AddLicenseNumberExpDate.GetText() == "") {
                alert('Please provide a License Expiry Date for the Skill.');
                return;
            }
            TmpDocExpDate.Set("pExpDate", tbx_AddLicenseNumberExpDate.GetValue());
            if (uploader2.GetText() != "") {

                uploader2.Upload();
                s.SetEnabled(false);
                lbl_uploader2Extensions.SetVisible(false);
                cbbTradeSkillList.SetEnabled(false);
                tbx_AddLicenseNumber.SetEnabled(false);
                tbx_AddLicenseNumberExpDate.SetEnabled(false);
                uploader2.SetEnabled(false);
            }
            else
            {
                alert('Please select a file first (All skills must have License Document)');
            }
        }
        function LargeWork_radiobtn_Changed(s, e) {
            if (s.GetValue() == 0) {

                document.getElementById('bigwork').style.visibility = 'hidden';


            }
            else if (s.GetValue() == 1) {


                document.getElementById('bigwork').style.visibility = 'visible';

            }
        }
        function cbbPostcodeSuburb_SelectedIndexChanged(s) {

            var CountryValue = cbbCountry.GetValue().toString();
            alert(CountryValue);
            //Postcode
            if (s.GetValue() != null) {
                cbbCostCentre.PerformCallback(CountryValue + ',' + s.GetValue().toString());
            }
            else {
                cbbCostCentre.PerformCallback(null);
            }

            var objPostcode = document.getElementById("Postcode");
            if (objPostcode) {
                objPostcode.value = s.GetValue().toString();
            }

            cbbPostcodeSuburb.GetMainElement().style.backgroundColor = "white";
            cbbPostcodeSuburb.GetInputElement().style.backgroundColor = "white";
        }

        function openImageBig(s, e) {
            var iMyWidth;
            var iMyHeight;
            //half the screen width minus half the new window width (plus 5 pixel borders).
            iMyWidth = (window.screen.width / 2) - (75 + 10);
            //half the screen height minus half the new window height (plus title and status bars).
            iMyHeight = (window.screen.height / 2) - (100 + 50);

            window.open(s.GetValue(), "Image Uploaded", "width=500, height=500,left=" + iMyWidth + ",top=" + iMyHeight + " ");
        }


        function validDate(pValue) {

            //var pattern = /^([0-9]{2})\/([0-9]{2})\/([0-9]{4})$/;
            if (pValue == null || pValue == "" /*|| !pattern.test(pValue)*/) {
                alert('Invalid Document Date');
                return false;
            }
            else {
                return true
            }
        }
        function ShowLoginWindow(pDocTypeId, pExpdate) {
            //setting up the value of the clicktype.    
            DocTypeId.SetValue(pDocTypeId);
            hpDocTypeId.Set("pDocumentTypeID", pDocTypeId);
            hpIsTradeSkillDoc.Set("pIsSkillDocument", "0");
            TmpDocExpDate.Set("pExpDate", pExpdate);
            hpRequestId.Set("pRequestId", Lbl_RequestId.GetValue());
            pcLogin.Show();


        }

        function HideLoginWindow(pDocTypeId) {
            pcLogin.Hide();
            window.location.href = "CompanyFullData.aspx";

        }
        function ShowAddSkillWindow(pDocTypeId) {

            hpDocTypeId.Set("pDocumentTypeID", pDocTypeId);
            hpIsTradeSkillDoc.Set("pIsSkillDocument", "1");
            hpRequestId.Set("pRequestId", Lbl_RequestId.GetValue());
            pcAddSkill.Show();
        }
        function HideAddSkillWindow() {
            pcAddSkill.Hide();
            window.location.href = "CompanyFullData.aspx";

        }
        function ShowUploadSWMSWindow() {
            pcAddSWMS.Show();
        }
        function HideUploadSWMSWindow() {
            pcAddSWMS.Hide();
            window.location.href = "CompanyFullData.aspx";

        }

        function ChangeDocumentType(s, e) {

            pDocTypeId = s.GetText();
            hpDocTypeId.Set("pDocumentTypeID", pDocTypeId);

        }
        function UpdateCompanyDetails() {
          
            var PlacesOfWork = "";
            if (cbx_NSW.GetValue() == 1) { PlacesOfWork = PlacesOfWork + "NSW,"; } 
            if (cbx_VIC.GetValue() == 1) { PlacesOfWork = PlacesOfWork + "VIC,"; } 
            if (cbx_QLD.GetValue() == 1) { PlacesOfWork = PlacesOfWork + "QLD,"; }
            if (cbx_WA.GetValue() == 1) { PlacesOfWork = PlacesOfWork + "WA,"; }
            if (cbx_SA.GetValue() == 1) { PlacesOfWork = PlacesOfWork + "SA,"; }
            if (cbx_TAS.GetValue() == 1) { PlacesOfWork = PlacesOfWork + "TAS,"; }
            if (cbx_NEW_ZEALAND.GetValue() == 1) { PlacesOfWork = PlacesOfWork + "NZ,"; }
            
            PageMethods.UpdateCompanyDetails(Lbl_RequestId.GetValue(),
                                            tbx_CompanyName.GetValue(),
                                            tbx_EmailAddress.GetValue(),
                                            tbx_StreetAddress.GetValue(),
                                            tbx_DirectorName.GetValue(),
                                            tbx_CompanyContactPhone.GetValue(),
                                            cbbPostcodeSuburb.GetValue(),
                                            tbx_CompanyABN.GetValue(),
                                            tbx_CompensationNumber.GetValue(),
                                            tbx_CompensationNumberExpDate.GetValue(),
                                            tbx_PublicLiability.GetValue(),
                                            tbx_PublicLiabilityExpDate.GetValue(),
                                            tbx_jobcapacity30days.GetValue(),
                                            tbx_averagevaluejob.GetValue(),
                                            PlacesOfWork,
                                            rbtn_CompanyCanDoLargeWork.GetValue(),
                                            onSucess,
                                            onError);

            function onSucess(result) {
                //alert(result);
            }

            function onError(result) {
                alert('Something went wrong while trying to process the application.');
            }

        }
        function ShowAddEmployee() {


            hpRequestId.Set("pRequestId", Lbl_RequestId.GetValue());
            pcAddEmployee.Show();



        }
        function HideAddEmployee(pRequestId) {
            pcAddEmployee.Hide();
        }
       

        function ValidateEmployeeFields()
        {
            var bShowError = false;
            var strError = "";
           
            try
            {
                if (tbx_employee_NAME.GetText() == "") {
                    strError = strError + "First Name is required \n";
                    bShowError = true;
                }
                if (tbx_employee_SURNAME.GetText() == "") {
                    strError = strError + "Last Name is required \n";
                    bShowError = true;
                }
                if (tbx_employee_EMAIL.GetText() == "") {
                    strError = strError + "Email is required \n";
                    bShowError = true;
                }
                if (tbx_employee_PHONE.GetText() == "") {
                    strError = strError + "Phone is required \n";
                    bShowError = true;
                }
                if (tbx_InductionCard.GetText() == "") {
                    strError = strError + "Worder Induction Card is required \n";
                    bShowError = true;
                }
                if (tbx_InductionCardExpDate.GetText() == "") {
                    strError = strError + "Worker Induction Card Expiration Date is required \n";
                    bShowError = true;
                }
                if (tbx_POLICECHECK_REFERENCE.GetText() == "") {
                    strError = strError + "Police Check Reference Number is required \n";
                    bShowError = true;
                }
                if (tbx_POLICECHECK_EXPIRYDATE.GetText() == "") {
                    strError = strError + "Police Check Expiry Date is required \n";
                    bShowError = true;
                }
                if (bShowError == true) {
                    alert(strError);
                }
            }
            catch (err) {                
            }
        }

    </script>

    <style>
        body {
            padding: 0;
            margin: 0;
            min-height: 240px;
            min-width: 250px;
            background-color: azure;
        }


        .centered {
            margin: 0 auto;
            float: none;
        }



        /* Modal Content */
        .modal-content {
            position: absolute;
            top: 20%;
            left: 15%;
            width: 70%;
            background-color: #fefefe;
            margin: auto;
            padding: 20px;
            border: 1px solid #888;
            border-radius: 5px;
            background-color: azure;
        }
    </style>

</head>
<body>
    <form id="form1" runat="server">
        <div>

            <div style="width:95%;">
                <dx:ASPxFormLayout runat="server" ID="ASPxFormLayout5" ClientInstanceName="FormLayout">
                    <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="800" />
                    <Items>
                        <dx:LayoutGroup ShowCaption="False" ColCount="3" GroupBoxDecoration="None" UseDefaultPaddings="false" Paddings-PaddingTop="10">
                            <Paddings PaddingTop="10px"></Paddings>
                            <Items>
                                <dx:LayoutItem ShowCaption="False" Width="20%">
                                    <NestedControlCellStyle CssClass="maxWidth"></NestedControlCellStyle>
                                    <Paddings PaddingTop="12" />
                                    <Paddings PaddingBottom="20" />
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer>
                                            <dx:ASPxImage ID="img_Logo" runat="server" ShowLoadingImage="true" ImageUrl="~/Images/MaincomLogo.png" Height="59px" Width="145px"></dx:ASPxImage>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem ShowCaption="False" Width="50%">
                                    <NestedControlCellStyle CssClass="maxWidth"></NestedControlCellStyle>
                                    <Paddings PaddingTop="12" />
                                    <Paddings PaddingBottom="20" />
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer>
                                            <dx:ASPxLabel ID="lbl_TopHeaderText" runat="server" Text="SUBCONTRACTOR APPLICATION TO WORK WITH MAINCOM (PART 2)" Font-Bold="True" ForeColor="#0099CC" Font-Size="Medium"></dx:ASPxLabel>
                                            <br />
                                            <dx:ASPxLabel ID="lbl_ReqStatus" runat="server" Text="APPLICATION STATUS - PRE APPROVED" Font-Bold="True" Font-Size="Large" ClientInstanceName="lbl_ReqStatus" ForeColor="#CC0000"></dx:ASPxLabel>
                                            <dx:ASPxLabel ID="Lbl_RequestId" runat="server" Text="" Font-Bold="True" ForeColor="Azure" Font-Size="Medium" ClientInstanceName="Lbl_RequestId"></dx:ASPxLabel>

                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem ShowCaption="False" HorizontalAlign="Right" Width="30%">
                                    <NestedControlCellStyle CssClass="maxWidth"></NestedControlCellStyle>
                                    <Paddings PaddingTop="12" />
                                    <Paddings PaddingBottom="20" />
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer>
                                            <table>
                                                <tr>

                                                    <td>
                                                           <dx:ASPxButton ID="btn_CheckApplication" runat="server" ImageSpacing="3px"
                                                            Text="Check Application Status" Wrap="False" AutoPostBack="False"
                                                            CausesValidation="False" UseSubmitBehavior="False" OnClick="btn_CheckApplication_Click">
                                                            <Image Height="16px" Width="16px" Url="../Images/tick2.png"></Image>
                                                        </dx:ASPxButton>
                                                    </td>
                                                    <td>
                                                     
                                                        <dx:ASPxButton ID="btn_Help" runat="server" ImageSpacing="3px"
                                                            Text="Help" Wrap="False" AutoPostBack="False"
                                                            CausesValidation="False" UseSubmitBehavior="False">
                                                            <Image Height="16px" Width="16px" Url="~/Images/wiz.jpg"></Image>
                                                        </dx:ASPxButton>
                                                    </td>
                                                    <td>
                                                        <dx:ASPxButton ID="btn_close" runat="server" ImageSpacing="3px"
                                                            Text="Exit" Wrap="False" AutoPostBack="False"
                                                            CausesValidation="False" UseSubmitBehavior="False" OnClick="btn_close_Click">
                                                            <Image Height="16px" Width="16px" Url="~/Images/exit.png"></Image>
                                                        </dx:ASPxButton>
                                                    </td>

                                                </tr>
                                                <tr>
                                                    <td>
                                                        <dx:ASPxButton ID="btn_sumitapplication" runat="server" Style="float: right;" ImageSpacing="3px"   Text="Submit Application"   OnClick="btn_submitapplication_Click"  Visible="false" >
                                                            <Image Height="16px" Width="16px" Url="~/Images/upload.png"></Image>                                                            
                                                             <ClientSideEvents Click="function(s,e){ShowWheel()}" />
                                                        </dx:ASPxButton>
                                                    </td>
                                                    <td colspan="2">
                                                        <dx:ASPxButton ID="btn_save" runat="server" Style="float: right;" ImageSpacing="3px" Text="SAVE" Image-Url="~/Images/save.png" OnClick="btn_SaveRequest_Click">
                                                            <Image Height="16px" Width="16px"  Url="~/Images/save.png"></Image>
                                                        </dx:ASPxButton>
                                                    </td>
                                                </tr>
                                            </table>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>


                            </Items>

                        </dx:LayoutGroup>
                    </Items>
                </dx:ASPxFormLayout>
            </div>
             <dx:ASPxHiddenField runat="server" ClientInstanceName="TmpDocExpDate" ID="TmpDocExpDate">
             </dx:ASPxHiddenField>

            <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePartialRendering="true" EnablePageMethods="true" />

            <dx:ASPxPanel ID="CompanyPanel" runat="server" ClientInstanceName="CompanyPanel" Width="95%" CssClass="centered">
                <PanelCollection>
                    <dx:PanelContent>
                        <dx:ASPxPageControl ID="CompanyDatapc" Width="100%" runat="server" ActiveTabIndex="0" EnableHierarchyRecreation="True">
                            <TabPages>
                                <dx:TabPage Text="General Information" >
                                    <ContentCollection>
                                        <dx:ContentControl ID="ContentControl1" runat="server">

                                            <dx:ASPxFormLayout runat="server" ID="formLayout" CssClass="formLayout">
                                                <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="900" />
                                                <Items>
                                                    <dx:LayoutGroup ShowCaption="False" ColCount="2" GroupBoxDecoration="None" UseDefaultPaddings="false" Paddings-PaddingTop="10">
                                                        <Paddings PaddingTop="10px"></Paddings>


                                                        <Items>
                                                            <dx:LayoutItem ShowCaption="False" Width="100%">
                                                                <LayoutItemNestedControlCollection>
                                                                    <dx:LayoutItemNestedControlContainer>
                                                                        <dx:ASPxLabel runat="server" Text="Company Details  " Font-Size="Medium" Font-Bold="true" ForeColor="#0099CC"></dx:ASPxLabel>
                                                                    </dx:LayoutItemNestedControlContainer>
                                                                </LayoutItemNestedControlCollection>
                                                            </dx:LayoutItem>

                                                            <dx:LayoutItem Caption="Where is your business intending to work?" Width="100%">
                                                                <LayoutItemNestedControlCollection>
                                                                    <dx:LayoutItemNestedControlContainer>
                                                                        <table>
                                                                            <tr>
                                                                                <td>
                                                                                    <dx:ASPxCheckBox ID="cbx_NSW" ClientInstanceName="cbx_NSW" Text="NSW" runat="server" Visible="true"></dx:ASPxCheckBox>
                                                                                </td>
                                                                                <td>
                                                                                    <dx:ASPxCheckBox ID="cbx_QLD"  ClientInstanceName="cbx_QLD" Text="QLD" runat="server" Visible="true"></dx:ASPxCheckBox>
                                                                                </td>
                                                                                <td>
                                                                                    <dx:ASPxCheckBox ID="cbx_VIC" ClientInstanceName="cbx_VIC" Text="VIC" runat="server" Visible="true"></dx:ASPxCheckBox>
                                                                                </td>
                                                                                <td>
                                                                                    <dx:ASPxCheckBox ID="cbx_NT" ClientInstanceName="cbx_NT" Text="NT" runat="server" Visible="true"></dx:ASPxCheckBox>
                                                                                </td>
                                                                                <td>
                                                                                    <dx:ASPxCheckBox ID="cbx_TAS" ClientInstanceName="cbx_TAS" Text="TAS" runat="server" Visible="true"></dx:ASPxCheckBox>
                                                                                </td>
                                                                                <td>
                                                                                    <dx:ASPxCheckBox ID="cbx_SA" ClientInstanceName="cbx_SA" Text="SA" runat="server" Visible="true"></dx:ASPxCheckBox>
                                                                                </td>
                                                                                <td>
                                                                                    <dx:ASPxCheckBox ID="cbx_WA" ClientInstanceName="cbx_WA" Text="WA" runat="server" Visible="true"></dx:ASPxCheckBox>
                                                                                </td>
                                                                                <td>
                                                                                    <dx:ASPxCheckBox ID="cbx_NEW_ZEALAND" ClientInstanceName="cbx_NEW_ZEALAND" Text="NZ" runat="server" Visible="true"></dx:ASPxCheckBox>
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </dx:LayoutItemNestedControlContainer>
                                                                </LayoutItemNestedControlCollection>
                                                            </dx:LayoutItem>


                                                            <dx:LayoutItem Caption="Company Name">
                                                                <LayoutItemNestedControlCollection>
                                                                    <dx:LayoutItemNestedControlContainer>
                                                                        <dx:ASPxTextBox runat="server" ID="tbx_CompanyName" ClientInstanceName="tbx_CompanyName">
                                                                        </dx:ASPxTextBox>
                                                                    </dx:LayoutItemNestedControlContainer>
                                                                </LayoutItemNestedControlCollection>
                                                            </dx:LayoutItem>

                                                            <dx:LayoutItem Caption="Director's Name">
                                                                <LayoutItemNestedControlCollection>
                                                                    <dx:LayoutItemNestedControlContainer>
                                                                        <dx:ASPxTextBox runat="server" ID="tbx_DirectorName" ClientInstanceName="tbx_DirectorName">
                                                                        </dx:ASPxTextBox>
                                                                    </dx:LayoutItemNestedControlContainer>
                                                                </LayoutItemNestedControlCollection>
                                                            </dx:LayoutItem>

                                                            <dx:LayoutItem Caption="Email Address">
                                                                <LayoutItemNestedControlCollection>
                                                                    <dx:LayoutItemNestedControlContainer>
                                                                        <dx:ASPxTextBox runat="server" ID="tbx_EmailAddress" ClientInstanceName="tbx_EmailAddress" ClientEnabled="false">
                                                                        </dx:ASPxTextBox>
                                                                    </dx:LayoutItemNestedControlContainer>
                                                                </LayoutItemNestedControlCollection>
                                                            </dx:LayoutItem>

                                                            <dx:LayoutItem Caption="Contact Phone">
                                                                <LayoutItemNestedControlCollection>
                                                                    <dx:LayoutItemNestedControlContainer>
                                                                        <dx:ASPxTextBox runat="server" ID="tbx_CompanyContactPhone" ClientInstanceName="tbx_CompanyContactPhone">
                                                                        </dx:ASPxTextBox>
                                                                    </dx:LayoutItemNestedControlContainer>
                                                                </LayoutItemNestedControlCollection>
                                                            </dx:LayoutItem>

                                                            <dx:LayoutItem Caption="Street Address">
                                                                <LayoutItemNestedControlCollection>
                                                                    <dx:LayoutItemNestedControlContainer>
                                                                        <dx:ASPxTextBox runat="server" ID="tbx_StreetAddress" ClientInstanceName="tbx_StreetAddress">
                                                                        </dx:ASPxTextBox>
                                                                    </dx:LayoutItemNestedControlContainer>
                                                                </LayoutItemNestedControlCollection>
                                                            </dx:LayoutItem>

                                                            <dx:LayoutItem Caption="ABN">
                                                                <LayoutItemNestedControlCollection>
                                                                    <dx:LayoutItemNestedControlContainer>
                                                                        <dx:ASPxTextBox runat="server" ID="tbx_CompanyABN" ClientInstanceName="tbx_CompanyABN">
                                                                            <ValidationSettings Display="Dynamic"  RegularExpression-ValidationExpression=".{11}" RegularExpression-ErrorText="ABN must have 11 characters in lenght"  ErrorDisplayMode="Text" SetFocusOnError="true" ErrorTextPosition="Bottom" ErrorFrameStyle-Wrap="true"/>
                                                                        </dx:ASPxTextBox>
                                                                    </dx:LayoutItemNestedControlContainer>
                                                                </LayoutItemNestedControlCollection>
                                                            </dx:LayoutItem>

                                                            <dx:LayoutItem Caption="Suburb (type Post Code)">
                                                                <LayoutItemNestedControlCollection>
                                                                    <dx:LayoutItemNestedControlContainer>
                                                                        <dx:ASPxComboBox ID="cbbPostcodeSuburb" runat="server" EnableViewState="False" EnableCallbackMode="True" CallbackPageSize="10"
                                                                            IncrementalFilteringMode="Contains" ValueField="ID" NullText="TYPE YOUR POSTCODE HERE"
                                                                            OnItemsRequestedByFilterCondition="cbbPostcodeSuburb_ItemsRequestedByFilterCondition" OnItemRequestedByValue="cbbPostcodeSuburb_ItemRequestedByValue"
                                                                            TextFormatString="{0}" DropDownStyle="DropDown" FilterMinLength="4" Width="100%" MaxLength="25" ClientInstanceName="cbbPostcodeSuburb"
                                                                            EnableClientSideAPI="True">
                                                                            <ClientSideEvents SelectedIndexChanged="function(s,e){cbbPostcodeSuburb_SelectedIndexChanged(s);}" />
                                                                            <Columns>
                                                                                <dx:ListBoxColumn Caption="Suburb List" FieldName="Suburb" />
                                                                            </Columns>

                                                                        </dx:ASPxComboBox>
                                                                        <dx:ASPxHiddenField runat="server" ClientInstanceName="cbbPostcodeSuburbVValue" ID="cbbPostcodeSuburbVValue">
                                                                        </dx:ASPxHiddenField>
                                                                        <asp:SqlDataSource ID="SqlSuburb" runat="server" ConnectionString="<%$ ConnectionStrings:DataConnectionString %>"></asp:SqlDataSource>
                                                                    </dx:LayoutItemNestedControlContainer>
                                                                </LayoutItemNestedControlCollection>
                                                            </dx:LayoutItem>

                                                            <dx:EmptyLayoutItem />

                                                            <dx:EmptyLayoutItem Width="100%" />
                                                            <dx:LayoutItem ShowCaption="False" Width="100%">
                                                                <LayoutItemNestedControlCollection>
                                                                    <dx:LayoutItemNestedControlContainer>
                                                                        <dx:ASPxLabel runat="server" Text="Banking Details  " Font-Size="Medium" Font-Bold="true" ForeColor="#0099CC"></dx:ASPxLabel>
                                                                    </dx:LayoutItemNestedControlContainer>
                                                                </LayoutItemNestedControlCollection>
                                                            </dx:LayoutItem>



                                                            <dx:LayoutItem Caption="Bank Name">
                                                                <LayoutItemNestedControlCollection>
                                                                    <dx:LayoutItemNestedControlContainer>
                                                                        <dx:ASPxTextBox runat="server" ID="tbx_COMPANY_BANK_NAME" ClientInstanceName="tbx_COMPANY_BANK_NAME">
                                                                        </dx:ASPxTextBox>
                                                                    </dx:LayoutItemNestedControlContainer>
                                                                </LayoutItemNestedControlCollection>
                                                            </dx:LayoutItem>
                                                            <dx:LayoutItem Caption="BSB number">
                                                                <LayoutItemNestedControlCollection>
                                                                    <dx:LayoutItemNestedControlContainer>
                                                                        <dx:ASPxTextBox runat="server" ID="tbx_COMPANY_BANK_ACCOUNT_BSB" ClientInstanceName="tbx_COMPANY_BANK_ACCOUNT_BSB">
                                                                        </dx:ASPxTextBox>
                                                                    </dx:LayoutItemNestedControlContainer>
                                                                </LayoutItemNestedControlCollection>
                                                            </dx:LayoutItem>

                                                            <dx:LayoutItem Caption="Account Number">
                                                                <LayoutItemNestedControlCollection>
                                                                    <dx:LayoutItemNestedControlContainer>
                                                                        <dx:ASPxTextBox runat="server" ID="tbx_COMPANY_BANK_ACCOUNT_NO" ClientInstanceName="tbx_COMPANY_BANK_ACCOUNT_NO">
                                                                        </dx:ASPxTextBox>
                                                                    </dx:LayoutItemNestedControlContainer>
                                                                </LayoutItemNestedControlCollection>
                                                            </dx:LayoutItem>



                                                            <dx:LayoutItem Caption="Account Name">
                                                                <LayoutItemNestedControlCollection>
                                                                    <dx:LayoutItemNestedControlContainer>
                                                                        <dx:ASPxTextBox runat="server" ID="tbx_COMPANY_BANK_ACCOUNT_NAME" ClientInstanceName="tbx_COMPANY_BANK_ACCOUNT_NAME">
                                                                        </dx:ASPxTextBox>
                                                                    </dx:LayoutItemNestedControlContainer>
                                                                </LayoutItemNestedControlCollection>
                                                            </dx:LayoutItem>



                                                            <dx:EmptyLayoutItem Width="100%" />
                                                            <dx:LayoutItem ShowCaption="False" Width="100%">
                                                                <LayoutItemNestedControlCollection>
                                                                    <dx:LayoutItemNestedControlContainer>
                                                                        <dx:ASPxLabel runat="server" Text="History  " Font-Size="Medium" Font-Bold="true" ForeColor="#0099CC"></dx:ASPxLabel>
                                                                    </dx:LayoutItemNestedControlContainer>
                                                                </LayoutItemNestedControlCollection>
                                                            </dx:LayoutItem>
                                                            <dx:LayoutItem ShowCaption="False">
                                                                <LayoutItemNestedControlCollection>
                                                                    <dx:LayoutItemNestedControlContainer>

                                                                        <table>
                                                                            <tr>
                                                                                <td>
                                                                                    <dx:ASPxLabel ID="lbl_worked_with_maincom" runat="server" Text="Has your Company Conducted any works for MAINCOM in the past in this name or any other name?"></dx:ASPxLabel>
                                                                                </td>
                                                                                <td>
                                                                                    <dx:ASPxRadioButtonList ID="rbtn_COMPANY_DID_WORK_WITH_MAINCOM" runat="server" RepeatDirection="Horizontal" Paddings-Padding="0" ItemSpacing="10px">

                                                                                        <Paddings Padding="0px"></Paddings>
                                                                                        <Items>
                                                                                            <dx:ListEditItem Text="Yes" Value="1" />
                                                                                            <dx:ListEditItem Text="NO" Value="0"  />
                                                                                        </Items>
                                                                                        <Border BorderColor="Transparent" />
                                                                                    </dx:ASPxRadioButtonList>
                                                                                </td>
                                                                            </tr>
                                                                        </table>


                                                                    </dx:LayoutItemNestedControlContainer>
                                                                </LayoutItemNestedControlCollection>
                                                            </dx:LayoutItem>
                                                            <dx:LayoutItem Caption="Provide Details if YES">
                                                                <LayoutItemNestedControlCollection>
                                                                    <dx:LayoutItemNestedControlContainer>

                                                                        <dx:ASPxMemo runat="server" ID="tbx_COMPANY_DID_WORK_WITH_MAINCOM_DETAILS" ClientInstanceName="tbx_COMPANY_DID_WORK_WITH_MAINCOM_DETAILS">
                                                                        </dx:ASPxMemo>
                                                                    </dx:LayoutItemNestedControlContainer>
                                                                </LayoutItemNestedControlCollection>
                                                            </dx:LayoutItem>
                                                            <dx:LayoutItem ShowCaption="False">
                                                                <LayoutItemNestedControlCollection>
                                                                    <dx:LayoutItemNestedControlContainer>
                                                                        <table>
                                                                            <tr>
                                                                                <td>
                                                                                    <dx:ASPxLabel ID="AspxLabel7" runat="server" Text="Has your company had any contracts terminated over the past  3 years for poor performance or corrective actions?"></dx:ASPxLabel>
                                                                                </td>
                                                                                <td>
                                                                                    <dx:ASPxRadioButtonList ID="rbtn_COMPANY_HAS_CORRECTIVE_PREVIOUS_JOBS" runat="server" RepeatDirection="Horizontal" Paddings-Padding="0" ItemSpacing="10px">
                                                                                        <Paddings Padding="0px"></Paddings>
                                                                                        <Items>
                                                                                            <dx:ListEditItem Text="Yes" Value="1" />
                                                                                            <dx:ListEditItem Text="NO" Value="0"  />
                                                                                        </Items>
                                                                                        <Border BorderColor="Transparent" />
                                                                                    </dx:ASPxRadioButtonList>
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </dx:LayoutItemNestedControlContainer>
                                                                </LayoutItemNestedControlCollection>
                                                            </dx:LayoutItem>
                                                            <dx:LayoutItem Caption="Provide details if YES">
                                                                <LayoutItemNestedControlCollection>
                                                                    <dx:LayoutItemNestedControlContainer>

                                                                        <dx:ASPxMemo runat="server" ID="tbx_COMPANY_HAS_CORRECTIVE_PREVIOUS_JOBS_DETAILS" ClientInstanceName="tbx_COMPANY_HAS_CORRECTIVE_PREVIOUS_JOBS_DETAILS">
                                                                        </dx:ASPxMemo>
                                                                    </dx:LayoutItemNestedControlContainer>
                                                                </LayoutItemNestedControlCollection>
                                                            </dx:LayoutItem>



                                                            <dx:EmptyLayoutItem Width="100%" />
                                                            <dx:LayoutItem ShowCaption="False" Width="100%">
                                                                <LayoutItemNestedControlCollection>
                                                                    <dx:LayoutItemNestedControlContainer>
                                                                        <dx:ASPxLabel runat="server" Text="Business Capacity  " Font-Size="Medium" Font-Bold="true" ForeColor="#0099CC"></dx:ASPxLabel>
                                                                    </dx:LayoutItemNestedControlContainer>
                                                                </LayoutItemNestedControlCollection>
                                                            </dx:LayoutItem>

                                                            <dx:LayoutItem Caption="How many work orders (jobs) can you do in 30 days? ">
                                                                <LayoutItemNestedControlCollection>
                                                                    <dx:LayoutItemNestedControlContainer>
                                                                        <dx:ASPxTextBox runat="server" ID="tbx_jobcapacity30days" ClientInstanceName="tbx_jobcapacity30days" Width="170px">
                                                                        </dx:ASPxTextBox>
                                                                    </dx:LayoutItemNestedControlContainer>
                                                                </LayoutItemNestedControlCollection>
                                                            </dx:LayoutItem>

                                                            <dx:LayoutItem Caption="What is your average  $ value per job? 2k, 5k, 10k.. ">
                                                                <LayoutItemNestedControlCollection>
                                                                    <dx:LayoutItemNestedControlContainer>
                                                                        <dx:ASPxTextBox runat="server" ID="tbx_averagevaluejob" ClientInstanceName="tbx_averagevaluejob" Width="170px">
                                                                        </dx:ASPxTextBox>
                                                                    </dx:LayoutItemNestedControlContainer>
                                                                </LayoutItemNestedControlCollection>
                                                            </dx:LayoutItem>
                                                            <dx:LayoutItem ShowCaption="False">
                                                                <LayoutItemNestedControlCollection>
                                                                    <dx:LayoutItemNestedControlContainer>

                                                                        <table>
                                                                            <tr>
                                                                                <td>
                                                                                    <dx:ASPxLabel ID="AspxLabel11" runat="server" Text="Do you have capacity for large construction work greater than 250k ?"></dx:ASPxLabel>
                                                                                </td>
                                                                                <td>
                                                                                    <dx:ASPxRadioButtonList ID="rbtn_CompanyCanDoLargeWork" runat="server" RepeatDirection="Horizontal" Paddings-Padding="0" ItemSpacing="10px">

                                                                                        <Paddings Padding="0px"></Paddings>
                                                                                        <Items>
                                                                                            <dx:ListEditItem Text="Yes" Value="1" />
                                                                                            <dx:ListEditItem Text="NO" Value="0" Selected="true" />
                                                                                        </Items>
                                                                                        <Border BorderColor="Transparent" />
                                                                                        <ClientSideEvents SelectedIndexChanged="LargeWork_radiobtn_Changed" />
                                                                                    </dx:ASPxRadioButtonList>

                                                                                </td>
                                                                            </tr>
                                                                        </table>


                                                                    </dx:LayoutItemNestedControlContainer>
                                                                </LayoutItemNestedControlCollection>
                                                            </dx:LayoutItem>

                                                            <dx:LayoutItem ShowCaption="False">
                                                                <LayoutItemNestedControlCollection>
                                                                    <dx:LayoutItemNestedControlContainer>
                                                                        <div id="bigwork" style="visibility: hidden; border-bottom-width: 1px; padding-top: 5px; border-style: groove; border-width: 1px; border-color: darkblue;">
                                                                            <table>
                                                                                <tr>
                                                                                    <td style="vertical-align: top;">
                                                                                        <dx:ASPxLabel ID="ASPxLabel8" runat="server" Text="Please provide a Generic Safety Plan Document"></dx:ASPxLabel>
                                                                                    </td>
                                                                                    <td style="vertical-align: top;">
                                                                                        <dx:ASPxTextBox ID="tbx_GENERICSAFETYPLAN_DOCID"  NullText="CLICK ON BROWSE BUTTON TO UPLOAD A FILE" runat="server" Width="350px" ClientEnabled="false"></dx:ASPxTextBox>
                                                                                        <a id="lnk_viewgenericsafetyplan" runat="server" target="_blank" href='d'>View Document</a>
                                                                                    </td>
                                                                                    <td style="vertical-align: top;">
                                                                                        <dx:ASPxUploadControl ID="ASPxUploadControlGenSafePlan" runat="server" ClientInstanceName="ASPxUploadControlGenSafePlan"
                                                                                            ShowProgressPanel="True" NullText="Click here to browse files…" Width="320" OnFileUploadComplete="ASPxUploadControlBIGWORK_FileUploadComplete"
                                                                                            ShowUploadButton="True">
                                                                                            <UploadButton Text="Upload&nbsp;&nbsp;" Image-Url="../Images/Upload.png" ImagePosition="Right">
                                                                                                <Image Url="../Images/Upload.png"></Image>

                                                                                            </UploadButton>
                                                                                            <AdvancedModeSettings EnableDragAndDrop="true" />
                                                                                            <ValidationSettings MaxFileSize="4194304" AllowedFileExtensions=".jpg,.jpeg,.png,.bmp,.pdf,.doc,.docx" />

                                                                                        </dx:ASPxUploadControl>

                                                                                        <dx:ASPxLabel ID="ASPxLabel9" runat="server" Font-Size="8pt"
                                                                                            Text='<%# "Allowed file types: " + string.Join(", ", ASPxUploadControlGenSafePlan.ValidationSettings.AllowedFileExtensions) %>' />
                                                                                        <br />
                                                                                        <dx:ASPxLabel ID="ASPxLabel10" runat="server" Font-Size="8pt"
                                                                                            Text='<%# "Maximum file size: " + ASPxUploadControlGenSafePlan.ValidationSettings.MaxFileSize / 1048576 + "Mb" %>' />
                                                                                    </td>
                                                                                </tr>
                                                                            </table>




                                                                        </div>
                                                                    </dx:LayoutItemNestedControlContainer>
                                                                </LayoutItemNestedControlCollection>
                                                            </dx:LayoutItem>
                                                            <dx:EmptyLayoutItem Width="100%" />
                                                            <dx:LayoutItem ShowCaption="False" Width="100%">
                                                                <LayoutItemNestedControlCollection>
                                                                    <dx:LayoutItemNestedControlContainer>
                                                                        <dx:ASPxLabel runat="server" Text="Contact & Reference Details  " Font-Size="Medium" Font-Bold="true" ForeColor="#0099CC"></dx:ASPxLabel>
                                                                    </dx:LayoutItemNestedControlContainer>
                                                                </LayoutItemNestedControlCollection>
                                                            </dx:LayoutItem>

                                                            <dx:LayoutGroup ShowCaption="False" ColCount="2" Width="100%" GroupBoxDecoration="None">
                                                                <Items>
                                                                    <dx:LayoutGroup ShowCaption="false" GroupBoxDecoration="None">
                                                                        <Items>
                                                                            <dx:LayoutItem Caption="Contact Name">
                                                                                <LayoutItemNestedControlCollection>
                                                                                    <dx:LayoutItemNestedControlContainer>
                                                                                        <dx:ASPxTextBox runat="server" ID="tbx_COMPANY_CONTACT_PERSON" ClientInstanceName="tbx_COMPANY_CONTACT_PERSON">
                                                                                        </dx:ASPxTextBox>
                                                                                    </dx:LayoutItemNestedControlContainer>
                                                                                </LayoutItemNestedControlCollection>
                                                                            </dx:LayoutItem>
                                                                            <dx:LayoutItem Caption="Contact Position">
                                                                                <LayoutItemNestedControlCollection>
                                                                                    <dx:LayoutItemNestedControlContainer>
                                                                                        <dx:ASPxTextBox runat="server" ID="tbx_COMPANY_CONTACT_POSITION" ClientInstanceName="tbx_COMPANY_CONTACT_POSITION">
                                                                                        </dx:ASPxTextBox>
                                                                                    </dx:LayoutItemNestedControlContainer>
                                                                                </LayoutItemNestedControlCollection>
                                                                            </dx:LayoutItem>
                                                                            <dx:LayoutItem Caption="Contact Phone Number">
                                                                                <LayoutItemNestedControlCollection>
                                                                                    <dx:LayoutItemNestedControlContainer>
                                                                                        <dx:ASPxTextBox runat="server" ID="tbx_COMPANY_CONTACT_PHONE" ClientInstanceName="tbx_COMPANY_CONTACT_PHONE">
                                                                                        </dx:ASPxTextBox>
                                                                                    </dx:LayoutItemNestedControlContainer>
                                                                                </LayoutItemNestedControlCollection>
                                                                            </dx:LayoutItem>
                                                                            <dx:LayoutItem Caption="Contact Email Address">
                                                                                <LayoutItemNestedControlCollection>
                                                                                    <dx:LayoutItemNestedControlContainer>
                                                                                        <dx:ASPxTextBox runat="server" ID="tbx_COMPANY_CONTACT_EMAILADDRESS" ClientInstanceName="tbx_COMPANY_CONTACT_EMAILADDRESS">
                                                                                        </dx:ASPxTextBox>
                                                                                    </dx:LayoutItemNestedControlContainer>
                                                                                </LayoutItemNestedControlCollection>
                                                                            </dx:LayoutItem>
                                                                        </Items>
                                                                    </dx:LayoutGroup>
                                                                    <dx:LayoutGroup ShowCaption="false" GroupBoxDecoration="None">
                                                                        <Items>
                                                                            <dx:LayoutItem Caption="Referee's Name ">
                                                                                <LayoutItemNestedControlCollection>
                                                                                    <dx:LayoutItemNestedControlContainer>
                                                                                        <dx:ASPxTextBox runat="server" ID="tbx_COMPANY_REFERENCE1_NAME" ClientInstanceName="tbx_COMPANY_REFERENCE1_NAME">
                                                                                        </dx:ASPxTextBox>
                                                                                    </dx:LayoutItemNestedControlContainer>
                                                                                </LayoutItemNestedControlCollection>
                                                                            </dx:LayoutItem>
                                                                            <dx:LayoutItem Caption="Referee's Company">
                                                                                <LayoutItemNestedControlCollection>
                                                                                    <dx:LayoutItemNestedControlContainer>
                                                                                        <dx:ASPxTextBox runat="server" ID="tbx_COMPANY_REFERENCE1_COMPANY" ClientInstanceName="tbx_COMPANY_REFERENCE1_COMPANY">
                                                                                        </dx:ASPxTextBox>
                                                                                    </dx:LayoutItemNestedControlContainer>
                                                                                </LayoutItemNestedControlCollection>
                                                                            </dx:LayoutItem>
                                                                            <dx:LayoutItem Caption="Referee's Position">
                                                                                <LayoutItemNestedControlCollection>
                                                                                    <dx:LayoutItemNestedControlContainer>
                                                                                        <dx:ASPxTextBox runat="server" ID="tbx_COMPANY_REFERENCE1_POSITION" ClientInstanceName="tbx_COMPANY_REFERENCE1_POSITION">
                                                                                        </dx:ASPxTextBox>
                                                                                    </dx:LayoutItemNestedControlContainer>
                                                                                </LayoutItemNestedControlCollection>
                                                                            </dx:LayoutItem>
                                                                            <dx:LayoutItem Caption="Referee's Email Address">
                                                                                <LayoutItemNestedControlCollection>
                                                                                    <dx:LayoutItemNestedControlContainer>
                                                                                        <dx:ASPxTextBox runat="server" ID="tbx_COMPANY_REFERENCE1_EMAIL" ClientInstanceName="tbx_COMPANY_REFERENCE1_EMAIL">
                                                                                        </dx:ASPxTextBox>
                                                                                    </dx:LayoutItemNestedControlContainer>
                                                                                </LayoutItemNestedControlCollection>
                                                                            </dx:LayoutItem>
                                                                            <dx:LayoutItem Caption="Referee's Phone">
                                                                                <LayoutItemNestedControlCollection>
                                                                                    <dx:LayoutItemNestedControlContainer>
                                                                                        <dx:ASPxTextBox runat="server" ID="tbx_COMPANY_REFERENCE1_PHONE" ClientInstanceName="tbx_COMPANY_REFERENCE1_PHONE">
                                                                                        </dx:ASPxTextBox>
                                                                                    </dx:LayoutItemNestedControlContainer>
                                                                                </LayoutItemNestedControlCollection>
                                                                            </dx:LayoutItem>
                                                                        </Items>
                                                                    </dx:LayoutGroup>
                                                                </Items>
                                                            </dx:LayoutGroup>











                                                        </Items>
                                                    </dx:LayoutGroup>
                                                </Items>
                                            </dx:ASPxFormLayout>






                                        </dx:ContentControl>
                                    </ContentCollection>
                                </dx:TabPage>

                                <dx:TabPage Text="Required Documents">
                                    <ContentCollection>
                                        <dx:ContentControl ID="ContentControl2" runat="server">
                                            <dx:ASPxFormLayout runat="server" ID="ASPxFormLayout1" ClientInstanceName="FormLayout" ColCount="2">
                                                <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="900" />
                                                <Items>

                                                    <dx:LayoutGroup Caption="Worker's Compensation Document" ColCount="2">
                                                        <Items>
                                                            <dx:LayoutGroup ShowCaption="false">
                                                                <Items>
                                                                    <dx:LayoutItem ShowCaption="False" Width="100%">
                                                                        <LayoutItemNestedControlCollection>
                                                                            <dx:LayoutItemNestedControlContainer>
                                                                                <dx:ASPxImage ID="img_CompensationNumber" runat="server" ShowLoadingImage="True" AlternateText="Document pending upload">
                                                                                    <ClientSideEvents Click="function (s, e) { openImageBig(s,e) }" />
                                                                                </dx:ASPxImage>
                                                                            </dx:LayoutItemNestedControlContainer>
                                                                        </LayoutItemNestedControlCollection>
                                                                    </dx:LayoutItem>
                                                                </Items>
                                                            </dx:LayoutGroup>
                                                            <dx:LayoutGroup ShowCaption="false" GroupBoxDecoration="None">
                                                                <Items>
                                                                    <dx:LayoutItem Caption="Worker's Compensation Number" CaptionSettings-Location="Top">
                                                                        <LayoutItemNestedControlCollection>
                                                                            <dx:LayoutItemNestedControlContainer>


                                                                                <dx:ASPxTextBox runat="server" ID="tbx_CompensationNumber" ClientInstanceName="tbx_CompensationNumber">
                                                                                </dx:ASPxTextBox>



                                                                            </dx:LayoutItemNestedControlContainer>
                                                                        </LayoutItemNestedControlCollection>

                                                                        <CaptionSettings Location="Top"></CaptionSettings>
                                                                    </dx:LayoutItem>
                                                                    <dx:LayoutItem Caption="Expiry Date" CaptionSettings-Location="Top">
                                                                        <LayoutItemNestedControlCollection>
                                                                            <dx:LayoutItemNestedControlContainer>

                                                                                <dx:ASPxDateEdit runat="server" ID="tbx_CompensationNumberExpDate" ClientInstanceName="tbx_CompensationNumberExpDate">
                                                                                </dx:ASPxDateEdit>




                                                                            </dx:LayoutItemNestedControlContainer>
                                                                        </LayoutItemNestedControlCollection>

                                                                        <CaptionSettings Location="Top"></CaptionSettings>
                                                                    </dx:LayoutItem>
                                                                    <dx:LayoutItem ShowCaption="False" HorizontalAlign="Right">
                                                                        <LayoutItemNestedControlCollection>
                                                                            <dx:LayoutItemNestedControlContainer>
                                                                                <dx:ASPxButton ID="btn_CompensationNumberUpload" runat="server" ImageSpacing="3px" Width="30%"
                                                                                    Text="Upload Document" Wrap="False" AutoPostBack="False" ClientInstanceName="btnUpload"
                                                                                    CausesValidation="True" UseSubmitBehavior="False">
                                                                                    <Image Url="~/Images/Upload.png" Width="16px" Height="16px"></Image>
                                                                                    <ClientSideEvents Click="function(s, e) { if (validDate(tbx_CompensationNumberExpDate.GetValue()) == true)
                                                                                                                              {   UpdateCompanyDetails(); 
                                                                                                                                   ShowLoginWindow('Worker Compensation Number',tbx_CompensationNumberExpDate.GetValue());
                                                                                                                              }
                                                                                                                             }" />
                                                                                </dx:ASPxButton>
                                                                            </dx:LayoutItemNestedControlContainer>
                                                                        </LayoutItemNestedControlCollection>
                                                                    </dx:LayoutItem>
                                                                </Items>
                                                            </dx:LayoutGroup>
                                                        </Items>
                                                    </dx:LayoutGroup>


                                                    <dx:LayoutGroup Caption="Public Liability Document" ColCount="2">
                                                        <Items>
                                                            <dx:LayoutGroup ShowCaption="false">
                                                                <Items>
                                                                    <dx:LayoutItem ShowCaption="False" Width="100%">
                                                                        <LayoutItemNestedControlCollection>
                                                                            <dx:LayoutItemNestedControlContainer>
                                                                                <dx:ASPxImage ID="img_PublicLiability" runat="server" ShowLoadingImage="True" AlternateText="Document pending upload">
                                                                                    <ClientSideEvents Click="function (s, e) { openImageBig(s,e) }" />
                                                                                </dx:ASPxImage>
                                                                            </dx:LayoutItemNestedControlContainer>
                                                                        </LayoutItemNestedControlCollection>
                                                                    </dx:LayoutItem>
                                                                </Items>
                                                            </dx:LayoutGroup>
                                                            <dx:LayoutGroup ShowCaption="false" GroupBoxDecoration="None">
                                                                <Items>
                                                                    <dx:LayoutItem Caption="Public Liability Number" CaptionSettings-Location="Top">
                                                                        <LayoutItemNestedControlCollection>
                                                                            <dx:LayoutItemNestedControlContainer>


                                                                                <dx:ASPxTextBox runat="server" ID="tbx_PublicLiability" ClientInstanceName="tbx_PublicLiability">
                                                                                </dx:ASPxTextBox>



                                                                            </dx:LayoutItemNestedControlContainer>
                                                                        </LayoutItemNestedControlCollection>

                                                                        <CaptionSettings Location="Top"></CaptionSettings>
                                                                    </dx:LayoutItem>
                                                                    <dx:LayoutItem Caption="Expiry Date" CaptionSettings-Location="Top">
                                                                        <LayoutItemNestedControlCollection>
                                                                            <dx:LayoutItemNestedControlContainer>

                                                                                <dx:ASPxDateEdit runat="server" ID="tbx_PublicLiabilityExpDate" ClientInstanceName="tbx_PublicLiabilityExpDate">
                                                                                </dx:ASPxDateEdit>




                                                                            </dx:LayoutItemNestedControlContainer>
                                                                        </LayoutItemNestedControlCollection>

                                                                        <CaptionSettings Location="Top"></CaptionSettings>
                                                                    </dx:LayoutItem>
                                                                    <dx:LayoutItem ShowCaption="False" HorizontalAlign="Right">
                                                                        <LayoutItemNestedControlCollection>
                                                                            <dx:LayoutItemNestedControlContainer>
                                                                                <dx:ASPxButton ID="btn_PublicLiabilityUpload" runat="server" ImageSpacing="3px" Width="30%"
                                                                                    Text="Upload Document" Wrap="False" AutoPostBack="False" ClientInstanceName="btnUpload"
                                                                                    CausesValidation="True" UseSubmitBehavior="False">
                                                                                    <Image Url="~/Images/Upload.png" Width="16px" Height="16px"></Image>
                                                                                    <ClientSideEvents Click="function(s, e) {
                                                                                                                              if (validDate(tbx_PublicLiabilityExpDate.GetValue()) == true)
                                                                                                                              {   UpdateCompanyDetails(); 
                                                                                                                                   ShowLoginWindow('Public Liability',tbx_PublicLiabilityExpDate.GetValue());
                                                                                                                              }
                                                                                                                            }" />
                                                                                </dx:ASPxButton>
                                                                            </dx:LayoutItemNestedControlContainer>
                                                                        </LayoutItemNestedControlCollection>
                                                                    </dx:LayoutItem>
                                                                </Items>
                                                            </dx:LayoutGroup>
                                                        </Items>
                                                    </dx:LayoutGroup>


                                                </Items>
                                            </dx:ASPxFormLayout>
                                        </dx:ContentControl>
                                    </ContentCollection>
                                </dx:TabPage>

                                <dx:TabPage Text="Licensing and Qualifications">
                                    <ContentCollection>
                                        <dx:ContentControl ID="ContentControl3" runat="server">
                                            <dx:ASPxFormLayout runat="server" ID="ASPxFormLayout2" ClientInstanceName="FormLayout" ColCount="2">
                                                <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="800" />
                                                <Items>
                                                    <dx:EmptyLayoutItem Width="100%" />
                                                    <dx:LayoutItem ShowCaption="False">
                                                        <LayoutItemNestedControlCollection>
                                                            <dx:LayoutItemNestedControlContainer>
                                                                <dx:ASPxLabel runat="server" Text="Trade Skills you are licensed for" Font-Size="Medium" Font-Bold="true" ForeColor="#0099CC"></dx:ASPxLabel>
                                                            </dx:LayoutItemNestedControlContainer>
                                                        </LayoutItemNestedControlCollection>
                                                    </dx:LayoutItem>
                                                    <dx:LayoutItem ShowCaption="False" HorizontalAlign="Right">
                                                        <LayoutItemNestedControlCollection>
                                                            <dx:LayoutItemNestedControlContainer>
                                                                <dx:ASPxButton ID="btn_AddSkill" runat="server" ImageSpacing="3px" Width="30%"
                                                                    Text="Add Skill" Font-Bold="true" Wrap="False" AutoPostBack="False" ClientInstanceName="btnUpload"
                                                                    CausesValidation="False" UseSubmitBehavior="False">
                                                                    <Image Url="~/Images/add.png" Width="16px" Height="16px"></Image>
                                                                    <ClientSideEvents Click="function(s, e) { ShowAddSkillWindow('Trade Skill'); }" />
                                                                </dx:ASPxButton>
                                                            </dx:LayoutItemNestedControlContainer>
                                                        </LayoutItemNestedControlCollection>
                                                    </dx:LayoutItem>
                                                    <dx:LayoutItem ShowCaption="False" Width="100%">
                                                        <LayoutItemNestedControlCollection>
                                                            <dx:LayoutItemNestedControlContainer>

                                                                <dx:ASPxGridView ID="CompanyTradeSkills" KeyFieldName="TRADE_ID" ClientInstanceName="CompanyTradeSkills" runat="server" Width="100%" DataSourceID="sqlDS_TradeSkills">
                                                                    <Columns>

                                                                        <dx:GridViewDataTextColumn FieldName="TRADE_ID" Caption="CODE" Width="50px" ShowInCustomizationForm="True" VisibleIndex="0">
                                                                        </dx:GridViewDataTextColumn>
                                                                        <dx:GridViewDataTextColumn FieldName="TRADE_DESCRIPTION" Caption="SKILL DESCRIPTION" ShowInCustomizationForm="True" VisibleIndex="1">
                                                                        </dx:GridViewDataTextColumn>
                                                                        <dx:GridViewDataTextColumn FieldName="LICENSE_NUMBER" Caption="LICENSE NUMBER" ShowInCustomizationForm="True" VisibleIndex="2">
                                                                        </dx:GridViewDataTextColumn>
                                                                        <dx:GridViewDataDateColumn FieldName="LICENSE_EXPDATE" Caption="EXPIRY DATE" Width="100px" ShowInCustomizationForm="True" VisibleIndex="3">
                                                                        </dx:GridViewDataDateColumn>
                                                                        <dx:GridViewDataTextColumn Caption="ATTACHED FILE" ShowInCustomizationForm="True" VisibleIndex="4">
                                                                            <DataItemTemplate>                                                                               
                                                                                <a id="clickElement" target="_blank" href='<%#  Eval("GUID1") %>'>Viewn attached File</a>
                                                                            </DataItemTemplate>
                                                                        </dx:GridViewDataTextColumn>
                                                                        <dx:GridViewDataTextColumn Width="80px" ShowInCustomizationForm="True" VisibleIndex="5">
                                                                            <DataItemTemplate>
                                                                                <asp:LinkButton ID="btn_DeleteSkill" runat="server" OnClientClick="return confirm('Are you sure you want to remove this skill from the list?')" OnClick="btn_DeleteSkill_Click">Remove</asp:LinkButton>
                                                                            </DataItemTemplate>
                                                                        </dx:GridViewDataTextColumn>
                                                                    </Columns>
                                                                    <SettingsBehavior ColumnResizeMode="Control" />

                                                                </dx:ASPxGridView>





                                                                <asp:SqlDataSource ID="sqlDS_TradeSkills" runat="server" ConnectionString="<%$ ConnectionStrings:DataConnectionString %>"></asp:SqlDataSource>
                                                            </dx:LayoutItemNestedControlContainer>
                                                        </LayoutItemNestedControlCollection>
                                                    </dx:LayoutItem>

                                                </Items>
                                            </dx:ASPxFormLayout>
                                        </dx:ContentControl>
                                    </ContentCollection>
                                </dx:TabPage>

                                <dx:TabPage Text="Safety Work Methods (SWMS)">
                                    <ContentCollection>
                                        <dx:ContentControl ID="ContentControl4" runat="server">
                                            <dx:ASPxFormLayout runat="server" ID="ASPxFormLayout3" ClientInstanceName="FormLayout" ColCount="2">
                                                <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="800" />
                                                <Items>
                                                    <dx:LayoutItem ShowCaption="False" Width="100%">
                                                        <LayoutItemNestedControlCollection>
                                                            <dx:LayoutItemNestedControlContainer>
                                                                <dx:ASPxLabel runat="server" Text="5) Safe Work Method Statements" Font-Size="Medium" Font-Bold="true" ForeColor="#0099CC"></dx:ASPxLabel>
                                                            </dx:LayoutItemNestedControlContainer>
                                                        </LayoutItemNestedControlCollection>
                                                    </dx:LayoutItem>

                                                    <dx:LayoutItem Caption="Please upload your SWMS known as Job Safety Analisys Document" Width="100%">
                                                        <LayoutItemNestedControlCollection>
                                                            <dx:LayoutItemNestedControlContainer>
                                                                <table>
                                                                    <tr>
                                                                        <td>
                                                                            <dx:ASPxTextBox ID="tbx_SWMS_DOCID" runat="server" ClientInstanceName="tbx_SWMS_DOCID" ClientEnabled="false" Width="350px"></dx:ASPxTextBox>
                                                                            <a id="lnk_viewswmsdoc" runat="server" target="_blank" href='d'>View Document</a>
                                                                        </td>

                                                                    </tr>
                                                                    <tr>
                                                                        <td align="right">
                                                                            <dx:ASPxButton ID="btn_AddSWMS" runat="server" ImageSpacing="3px"
                                                                                Text="Add SWMS Document" Font-Bold="true" Wrap="False" AutoPostBack="False" ClientInstanceName="btn_AddSWMS"
                                                                                CausesValidation="False" UseSubmitBehavior="False">
                                                                                <Image Url="~/Images/add.png" Width="16px" Height="16px"></Image>
                                                                                <ClientSideEvents Click="function(s, e) {UpdateCompanyDetails();  ShowUploadSWMSWindow(); }" />
                                                                            </dx:ASPxButton>
                                                                        </td>
                                                                    </tr>
                                                                </table>

                                                            </dx:LayoutItemNestedControlContainer>
                                                        </LayoutItemNestedControlCollection>
                                                    </dx:LayoutItem>


                                                    <dx:LayoutItem ShowCaption="False" HorizontalAlign="Left">
                                                        <LayoutItemNestedControlCollection>
                                                            <dx:LayoutItemNestedControlContainer>
                                                                <table>
                                                                    <tr>
                                                                        <td>
                                                                            <dx:ASPxLabel ID="lbl_SWMS1" runat="server" Text="I do provide description or task of work to be undertaken "></dx:ASPxLabel>
                                                                        </td>
                                                                        <td>
                                                                            <dx:ASPxRadioButtonList ID="rbl_SWMS1" ClientInstanceName="rbl_SWMS1" runat="server" RepeatDirection="Horizontal" Paddings-Padding="0">
                                                                                <Paddings Padding="0px"></Paddings>
                                                                                <Items>
                                                                                    <dx:ListEditItem Text="Yes" Value="1" />
                                                                                    <dx:ListEditItem Text="NO" Value="0" />
                                                                                </Items>
                                                                                <Border BorderColor="Transparent" />
                                                                            </dx:ASPxRadioButtonList>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <dx:ASPxLabel ID="lbl_SWMS2" runat="server" Text="I do provide date of development of this SWMS "></dx:ASPxLabel>
                                                                        </td>
                                                                        <td>
                                                                            <dx:ASPxRadioButtonList ID="rbl_SWMS2" ClientInstanceName="rbl_SWMS2" runat="server" RepeatDirection="Horizontal" Paddings-Padding="0">
                                                                                <Paddings Padding="0px"></Paddings>
                                                                                <Items>
                                                                                    <dx:ListEditItem Text="Yes" Value="1" />
                                                                                    <dx:ListEditItem Text="NO" Value="0" />
                                                                                </Items>
                                                                                <Border BorderColor="Transparent" />
                                                                            </dx:ASPxRadioButtonList>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <dx:ASPxLabel ID="lbl_SWMS3" runat="server" Text="I do provide names, titles and signature of the authors of this SWMS "></dx:ASPxLabel>
                                                                        </td>
                                                                        <td>
                                                                            <dx:ASPxRadioButtonList ID="rbl_SWMS3" ClientInstanceName="rbl_SWMS3" runat="server" RepeatDirection="Horizontal" Paddings-Padding="0">
                                                                                <Paddings Padding="0px"></Paddings>
                                                                                <Items>
                                                                                    <dx:ListEditItem Text="Yes" Value="1" />
                                                                                    <dx:ListEditItem Text="NO" Value="0" />
                                                                                </Items>
                                                                                <Border BorderColor="Transparent" />
                                                                            </dx:ASPxRadioButtonList>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <dx:ASPxLabel ID="lbl_SWMS4" runat="server" Text="I do provide names, titles and signature of the authors of this SWMS "></dx:ASPxLabel>
                                                                        </td>
                                                                        <td>
                                                                            <dx:ASPxRadioButtonList ID="rbl_SWMS4" ClientInstanceName="rbl_SWMS4" runat="server" RepeatDirection="Horizontal" Paddings-Padding="0">
                                                                                <Paddings Padding="0px"></Paddings>
                                                                                <Items>
                                                                                    <dx:ListEditItem Text="Yes" Value="1" />
                                                                                    <dx:ListEditItem Text="NO" Value="0" />
                                                                                </Items>
                                                                                <Border BorderColor="Transparent" />
                                                                            </dx:ASPxRadioButtonList>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <dx:ASPxLabel ID="lbl_SWMS5" runat="server" Text="I do provide names, titles and signature of the authors of this SWMS "></dx:ASPxLabel>
                                                                        </td>
                                                                        <td>
                                                                            <dx:ASPxRadioButtonList ID="rbl_SWMS5" ClientInstanceName="rbl_SWMS5" runat="server" RepeatDirection="Horizontal" Paddings-Padding="0">
                                                                                <Paddings Padding="0px"></Paddings>
                                                                                <Items>
                                                                                    <dx:ListEditItem Text="Yes" Value="1" />
                                                                                    <dx:ListEditItem Text="NO" Value="0" />
                                                                                </Items>
                                                                                <Border BorderColor="Transparent" />
                                                                            </dx:ASPxRadioButtonList>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <dx:ASPxLabel ID="lbl_SWMS6" runat="server" Text="I do provide names, titles and signature of the authors of this SWMS "></dx:ASPxLabel>
                                                                        </td>
                                                                        <td>
                                                                            <dx:ASPxRadioButtonList ID="rbl_SWMS6" ClientInstanceName="rbl_SWMS6" runat="server" RepeatDirection="Horizontal" Paddings-Padding="0">
                                                                                <Paddings Padding="0px"></Paddings>
                                                                                <Items>
                                                                                    <dx:ListEditItem Text="Yes" Value="1" />
                                                                                    <dx:ListEditItem Text="NO" Value="0" />
                                                                                </Items>
                                                                                <Border BorderColor="Transparent" />
                                                                            </dx:ASPxRadioButtonList>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <dx:ASPxLabel ID="lbl_SWMS7" runat="server" Text="I do provide names, titles and signature of the authors of this SWMS "></dx:ASPxLabel>
                                                                        </td>
                                                                        <td>
                                                                            <dx:ASPxRadioButtonList ID="rbl_SWMS7" ClientInstanceName="rbl_SWMS7" runat="server" RepeatDirection="Horizontal" Paddings-Padding="0">
                                                                                <Paddings Padding="0px"></Paddings>
                                                                                <Items>
                                                                                    <dx:ListEditItem Text="Yes" Value="1" />
                                                                                    <dx:ListEditItem Text="NO" Value="0" />
                                                                                </Items>
                                                                                <Border BorderColor="Transparent" />
                                                                            </dx:ASPxRadioButtonList>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <dx:ASPxLabel ID="lbl_SWMS8" runat="server" Text="I do provide names, titles and signature of the authors of this SWMS "></dx:ASPxLabel>
                                                                        </td>
                                                                        <td>
                                                                            <dx:ASPxRadioButtonList ID="rbl_SWMS8" ClientInstanceName="rbl_SWMS8" runat="server" RepeatDirection="Horizontal" Paddings-Padding="0">
                                                                                <Paddings Padding="0px"></Paddings>
                                                                                <Items>
                                                                                    <dx:ListEditItem Text="Yes" Value="1" />
                                                                                    <dx:ListEditItem Text="NO" Value="0" />
                                                                                </Items>
                                                                                <Border BorderColor="Transparent" />
                                                                            </dx:ASPxRadioButtonList>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <dx:ASPxLabel ID="lbl_SWMS9" runat="server" Text="I do provide names, titles and signature of the authors of this SWMS "></dx:ASPxLabel>
                                                                        </td>
                                                                        <td>
                                                                            <dx:ASPxRadioButtonList ID="rbl_SWMS9" ClientInstanceName="rbl_SWMS9" runat="server" RepeatDirection="Horizontal" Paddings-Padding="0">
                                                                                <Paddings Padding="0px"></Paddings>
                                                                                <Items>
                                                                                    <dx:ListEditItem Text="Yes" Value="1" />
                                                                                    <dx:ListEditItem Text="NO" Value="0" />
                                                                                </Items>
                                                                                <Border BorderColor="Transparent" />
                                                                            </dx:ASPxRadioButtonList>
                                                                        </td>
                                                                    </tr>

                                                                </table>
                                                            </dx:LayoutItemNestedControlContainer>
                                                        </LayoutItemNestedControlCollection>
                                                    </dx:LayoutItem>
                                                    <dx:LayoutItem ShowCaption="False" HorizontalAlign="Left">
                                                        <LayoutItemNestedControlCollection>
                                                            <dx:LayoutItemNestedControlContainer>
                                                                <table>
                                                                    <tr>
                                                                        <td>
                                                                            <dx:ASPxLabel ID="lbl_SWMS10" runat="server" Text="I do provide description or task of work to be undertaken "></dx:ASPxLabel>
                                                                        </td>
                                                                        <td>
                                                                            <dx:ASPxRadioButtonList ID="rbl_SWMS10" ClientInstanceName="rbl_SWMS10" runat="server" RepeatDirection="Horizontal" Paddings-Padding="0">
                                                                                <Paddings Padding="0px"></Paddings>
                                                                                <Items>
                                                                                    <dx:ListEditItem Text="Yes" Value="1" />
                                                                                    <dx:ListEditItem Text="NO" Value="0" />
                                                                                </Items>
                                                                                <Border BorderColor="Transparent" />
                                                                            </dx:ASPxRadioButtonList>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <dx:ASPxLabel ID="lbl_SWMS11" runat="server" Text="I do provide date of development of this SWMS "></dx:ASPxLabel>
                                                                        </td>
                                                                        <td>
                                                                            <dx:ASPxRadioButtonList ID="rbl_SWMS11" ClientInstanceName="rbl_SWMS11" runat="server" RepeatDirection="Horizontal" Paddings-Padding="0">
                                                                                <Paddings Padding="0px"></Paddings>
                                                                                <Items>
                                                                                    <dx:ListEditItem Text="Yes" Value="1" />
                                                                                    <dx:ListEditItem Text="NO" Value="0" />
                                                                                </Items>
                                                                                <Border BorderColor="Transparent" />
                                                                            </dx:ASPxRadioButtonList>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <dx:ASPxLabel ID="lbl_SWMS12" runat="server" Text="I do provide names, titles and signature of the authors of this SWMS "></dx:ASPxLabel>
                                                                        </td>
                                                                        <td>
                                                                            <dx:ASPxRadioButtonList ID="rbl_SWMS12" ClientInstanceName="rbl_SWMS12" runat="server" RepeatDirection="Horizontal" Paddings-Padding="0">
                                                                                <Paddings Padding="0px"></Paddings>
                                                                                <Items>
                                                                                    <dx:ListEditItem Text="Yes" Value="1" />
                                                                                    <dx:ListEditItem Text="NO" Value="0" />
                                                                                </Items>
                                                                                <Border BorderColor="Transparent" />
                                                                            </dx:ASPxRadioButtonList>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <dx:ASPxLabel ID="lbl_SWMS13" runat="server" Text="I do provide names, titles and signature of the authors of this SWMS "></dx:ASPxLabel>
                                                                        </td>
                                                                        <td>
                                                                            <dx:ASPxRadioButtonList ID="rbl_SWMS13" ClientInstanceName="rbl_SWMS13" runat="server" RepeatDirection="Horizontal" Paddings-Padding="0">
                                                                                <Paddings Padding="0px"></Paddings>
                                                                                <Items>
                                                                                    <dx:ListEditItem Text="Yes" Value="1" />
                                                                                    <dx:ListEditItem Text="NO" Value="0" />
                                                                                </Items>
                                                                                <Border BorderColor="Transparent" />
                                                                            </dx:ASPxRadioButtonList>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <dx:ASPxLabel ID="lbl_SWMS14" runat="server" Text="I do provide names, titles and signature of the authors of this SWMS "></dx:ASPxLabel>
                                                                        </td>
                                                                        <td>
                                                                            <dx:ASPxRadioButtonList ID="rbl_SWMS14" ClientInstanceName="rbl_SWMS14" runat="server" RepeatDirection="Horizontal" Paddings-Padding="0">
                                                                                <Paddings Padding="0px"></Paddings>
                                                                                <Items>
                                                                                    <dx:ListEditItem Text="Yes" Value="1" />
                                                                                    <dx:ListEditItem Text="NO" Value="0" />
                                                                                </Items>
                                                                                <Border BorderColor="Transparent" />
                                                                            </dx:ASPxRadioButtonList>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <dx:ASPxLabel ID="lbl_SWMS15" runat="server" Text="I do provide names, titles and signature of the authors of this SWMS "></dx:ASPxLabel>
                                                                        </td>
                                                                        <td>
                                                                            <dx:ASPxRadioButtonList ID="rbl_SWMS15" ClientInstanceName="rbl_SWMS15" runat="server" RepeatDirection="Horizontal" Paddings-Padding="0">
                                                                                <Paddings Padding="0px"></Paddings>
                                                                                <Items>
                                                                                    <dx:ListEditItem Text="Yes" Value="1" />
                                                                                    <dx:ListEditItem Text="NO" Value="0" />
                                                                                </Items>
                                                                                <Border BorderColor="Transparent" />
                                                                            </dx:ASPxRadioButtonList>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <dx:ASPxLabel ID="lbl_SWMS16" runat="server" Text="I do provide names, titles and signature of the authors of this SWMS "></dx:ASPxLabel>
                                                                        </td>
                                                                        <td>
                                                                            <dx:ASPxRadioButtonList ID="rbl_SWMS16" ClientInstanceName="rbl_SWMS16" runat="server" RepeatDirection="Horizontal" Paddings-Padding="0">
                                                                                <Paddings Padding="0px"></Paddings>
                                                                                <Items>
                                                                                    <dx:ListEditItem Text="Yes" Value="1" />
                                                                                    <dx:ListEditItem Text="NO" Value="0" />
                                                                                </Items>
                                                                                <Border BorderColor="Transparent" />
                                                                            </dx:ASPxRadioButtonList>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <dx:ASPxLabel ID="lbl_SWMS17" runat="server" Text="I do provide names, titles and signature of the authors of this SWMS "></dx:ASPxLabel>
                                                                        </td>
                                                                        <td>
                                                                            <dx:ASPxRadioButtonList ID="rbl_SWMS17" ClientInstanceName="rbl_SWMS17" runat="server" RepeatDirection="Horizontal" Paddings-Padding="0">
                                                                                <Paddings Padding="0px"></Paddings>
                                                                                <Items>
                                                                                    <dx:ListEditItem Text="Yes" Value="1" />
                                                                                    <dx:ListEditItem Text="NO" Value="0" />
                                                                                </Items>
                                                                                <Border BorderColor="Transparent" />
                                                                            </dx:ASPxRadioButtonList>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <dx:ASPxLabel ID="lbl_SWMS18" runat="server" Text="I do provide names, titles and signature of the authors of this SWMS "></dx:ASPxLabel>
                                                                        </td>
                                                                        <td>
                                                                            <dx:ASPxRadioButtonList ID="rbl_SWMS18" ClientInstanceName="rbl_SWMS18" runat="server" RepeatDirection="Horizontal" Paddings-Padding="0">
                                                                                <Paddings Padding="0px"></Paddings>
                                                                                <Items>
                                                                                    <dx:ListEditItem Text="Yes" Value="1" />
                                                                                    <dx:ListEditItem Text="NO" Value="0" />
                                                                                </Items>
                                                                                <Border BorderColor="Transparent" />
                                                                            </dx:ASPxRadioButtonList>
                                                                        </td>
                                                                    </tr>

                                                                </table>
                                                            </dx:LayoutItemNestedControlContainer>
                                                        </LayoutItemNestedControlCollection>
                                                    </dx:LayoutItem>
                                                </Items>
                                            </dx:ASPxFormLayout>
                                        </dx:ContentControl>
                                    </ContentCollection>
                                </dx:TabPage>

                                <dx:TabPage Text="Employees">
                                    <ContentCollection>
                                        <dx:ContentControl ID="ContentControl5" runat="server">
                                            <table>
                                                <tr>
                                                    <td>
                                                        <dx:ASPxButton ID="btn_AddEmployee" runat="server" Text="Add Employee" OnClick="btn_AddEmployee_Click">
                                            </dx:ASPxButton>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                         <dx:ASPxLabel ID="ASPxLabel14" runat="server" Text="Please add an employee using the ADD EMPLOYEE button above."></dx:ASPxLabel>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                         <dx:ASPxLabel ID="ASPxLabel15" runat="server" Text="You must specify the skills of each employee and provide their certifications for each skill you list. To complete this task please use the ADD/DELETE EMPLOYEE SKILLS button."></dx:ASPxLabel>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                         <dx:ASPxLabel ID="ASPxLabel13" runat="server" Text="You can exit this Application Form and return again to it at anytime after when you have all information with you by simply using you loging credentials."></dx:ASPxLabel>
                                                    </td>
                                                </tr>
                                                 <tr>
                                                    <td>
                                                         <dx:ASPxLabel ID="ASPxLabel16" runat="server" Text=""></dx:ASPxLabel>
                                                    </td>
                                                </tr>


                                            </table>
                                            
                                             

                                            <dx:ASPxGridView ID="gv_employees" runat="server" AutoGenerateColumns="False" DataSourceID="sqlDS_employees" KeyFieldName="employee_id" Width="100%">
                                                <Columns>
                                                    <dx:GridViewDataTextColumn Width="40px" ShowInCustomizationForm="True" VisibleIndex="0">
                                                        <DataItemTemplate>
                                                            <asp:LinkButton ID="btn_DeleteEmployee" runat="server" OnClick="Btn_DeleteEmployee_Click">Delete</asp:LinkButton>
                                                        </DataItemTemplate>
                                                    </dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="employee_id" Width="30px" ReadOnly="True" VisibleIndex="1" Caption="ID">
                                                    </dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="employee" VisibleIndex="2" Caption="EMPLOYEE">
                                                    </dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="email" ReadOnly="True" VisibleIndex="3" Caption="EMAIL">
                                                    </dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn ShowInCustomizationForm="True" Caption="TELEPHONES">
                                                        <DataItemTemplate>
                                                            <%# Eval("phone") %>
                                                            <br />
                                                            <%# Eval("mobile") %>
                                                        </DataItemTemplate>
                                                    </dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn ShowInCustomizationForm="True" Caption="INDUCTION CARD">
                                                        <DataItemTemplate>
                                                            Number  : <%#  Eval("INDUCTION_CARD_NUMBER") %>
                                                            <br />
                                                            Exp Date: <%#  Eval("NDUCTION_CARD_EXPIRYDATE") %><br />
                                                            <a id="clickElement" target="_blank" href='<%#  Eval("INDUCTION_CARD_DOCID") %>'>View Attachment</a>
                                                        </DataItemTemplate>
                                                    </dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn ShowInCustomizationForm="True" Caption="POLICE CHECK">
                                                        <DataItemTemplate>
                                                            Number  : <%#  Eval("POLICECHECK_REFERENCE") %>
                                                            <br />
                                                            Exp Date: <%#  Eval("POLICECHECK_EXPIRYDATE") %><br />
                                                            <a id="clickElement" target="_blank" href='<%#  Eval("POLICECHECK_DOCID") %>'>View Attachment</a>
                                                        </DataItemTemplate>
                                                    </dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn ShowInCustomizationForm="True" FieldName="skills" VisibleIndex="7" Caption="TRADE SKILL LICENSES">
                                                        <DataItemTemplate>

                                                            <dx:ASPxButton ID="btn_AddEmployeeSkill" runat="server" Text="Add / Delete Employee Skills" AutoPostBack="True" OnClick="btn_AddEmployeeSkill_click">
                                                                <Image Height="10px" Width="10px" Url="../Images/add.png"></Image>
                                                            </dx:ASPxButton>


                                                            <dx:ASPxGridView ID="gv_employee_skills" runat="server" AutoGenerateColumns="False" DataSourceID="sqlDS_employeeskills" KeyFieldName="TRADESKILL_DESC" Width="100%">
                                                                <Columns>


                                                                    <dx:GridViewDataTextColumn FieldName="TRADESKILL_DESC" ReadOnly="True" VisibleIndex="2" Caption="DESCRIPTION">
                                                                    </dx:GridViewDataTextColumn>
                                                                    <dx:GridViewDataTextColumn FieldName="license_number" VisibleIndex="3" Caption="LICENSE NUMBER">
                                                                    </dx:GridViewDataTextColumn>
                                                                    <dx:GridViewDataTextColumn FieldName="expiry_date" VisibleIndex="4" Caption="EXPIRY DATE">
                                                                    </dx:GridViewDataTextColumn>
                                                                    <dx:GridViewDataTextColumn VisibleIndex="5" Caption="FILE ATTACHED">
                                                                        <DataItemTemplate>
                                                                            <a id="clickElement" target="_blank" href='<%#  Eval("GUID") %>'>View</a>
                                                                        </DataItemTemplate>
                                                                    </dx:GridViewDataTextColumn>

                                                                </Columns>
                                                            </dx:ASPxGridView>
                                                            <asp:SqlDataSource ID="sqlDS_employeeskills" runat="server" ConnectionString="<%$ ConnectionStrings:DataConnectionString %>"
                                                                SelectCommand="select TRADESKILL_ID,
                                                                              TRADESKILL_DESC, 
                                                                              license_number,
                                                                              expiry_date,
                                                                              GUID
                                                                 from  SUBCONREG_COMPANY_EMPLOYEES_TRADESKILLS
                                                                where  request_id = 1
                                                                  and  employee_id = 1 "></asp:SqlDataSource>
                                                        </DataItemTemplate>
                                                    </dx:GridViewDataTextColumn>
                                                </Columns>
                                            </dx:ASPxGridView>

                                            <asp:SqlDataSource ID="sqlDS_employees" runat="server" ConnectionString="<%$ ConnectionStrings:DataConnectionString %>"
                                                SelectCommand="select employee_id,
                                                                      name +' '+ surname as employee,                                                                     
                                                                      email,
                                                                      phone,
                                                                      mobile,
                                                                      INDUCTION_CARD_NUMBER ,
                                                                      convert(varchar,NDUCTION_CARD_EXPIRYDATE) as NDUCTION_CARD_EXPIRYDATE,
                                                                      INDUCTION_CARD_DOCID,
                                                                      POLICECHECK_REFERENCE ,
                                                                      convert(varchar,POLICECHECK_EXPIRYDATE) as POLICECHECK_EXPIRYDATE,
                                                                      POLICECHECK_DOCID                                                                     
                                                                from  SUBCONREG_COMPANY_EMPLOYEES
                                                               where  Request_id = 1"></asp:SqlDataSource>
                                        </dx:ContentControl>
                                    </ContentCollection>
                                </dx:TabPage>

                                <dx:TabPage Text="Terms and Conditions">
                                    <ContentCollection>
                                        <dx:ContentControl ID="ContentControl6" runat="server">
                                            <dx:ASPxFormLayout runat="server" ID="ASPxFormLayout4" CssClass="formLayout">
                                                <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="800" />
                                                <Items>
                                                    <dx:LayoutGroup ShowCaption="False" ColCount="2" GroupBoxDecoration="None" UseDefaultPaddings="false" Paddings-PaddingTop="10">
                                                        <Paddings PaddingTop="10px"></Paddings>


                                                        <Items>
                                                         
                                                            <dx:LayoutItem ShowCaption="False" Width="100%">
                                                                <LayoutItemNestedControlCollection>
                                                                    <dx:LayoutItemNestedControlContainer>
                                                                        <dx:ASPxLabel runat="server" Text="Compulsory Agreements" Font-Size="Medium" Font-Bold="true" ForeColor="#0099CC"></dx:ASPxLabel>
                                                                    </dx:LayoutItemNestedControlContainer>
                                                                </LayoutItemNestedControlCollection>
                                                            </dx:LayoutItem>
                                                            <dx:LayoutItem ShowCaption="False" Width="100%">
                                                                <LayoutItemNestedControlCollection>
                                                                    <dx:LayoutItemNestedControlContainer>
                                                                        <dx:ASPxLabel runat="server" Text="You MUST read carefully both documents before agreeing" ></dx:ASPxLabel>
                                                                    </dx:LayoutItemNestedControlContainer>
                                                                </LayoutItemNestedControlCollection>
                                                            </dx:LayoutItem>
                                                             <dx:EmptyLayoutItem Width="100%" />
                                                            <dx:LayoutItem ShowCaption="False">
                                                                <LayoutItemNestedControlCollection>
                                                                    <dx:LayoutItemNestedControlContainer>
                                                                        <dx:ASPxCheckBoxList ID="cbl_agree_maincom_site" runat="server"
                                                                            ValueField="ID" TextField="Name" RepeatColumns="1" RepeatLayout="Flow">
                                                                            <CaptionSettings Position="Right" />
                                                                            <Items>
                                                                                <dx:ListEditItem Text="I agree to ALL Terms and Condition of TRADING WITH MAINCOM" />
                                                                            </Items>
                                                                        </dx:ASPxCheckBoxList>
                                                                    </dx:LayoutItemNestedControlContainer>
                                                                </LayoutItemNestedControlCollection>
                                                            </dx:LayoutItem>
                                                            <dx:LayoutItem ShowCaption="False" HorizontalAlign="Left">
                                                                <LayoutItemNestedControlCollection>
                                                                    <dx:LayoutItemNestedControlContainer>
                                                                        
                                                                        <a id="LNKBTN_TC1" runat="server" target="_blank" href='~/TermsNConditions/TermsAndConditionsOfTrade.pdf'>READ TERMS AND CONDITIONS</a>
                                                                    </dx:LayoutItemNestedControlContainer>
                                                                </LayoutItemNestedControlCollection>
                                                            </dx:LayoutItem>
                                                            <dx:LayoutItem ShowCaption="False">
                                                                <LayoutItemNestedControlCollection>
                                                                    <dx:LayoutItemNestedControlContainer>
                                                                        <dx:ASPxCheckBoxList ID="cbl_agree_maincom_invoices" runat="server"
                                                                            ValueField="ID" TextField="Name" RepeatColumns="1" RepeatLayout="Flow">
                                                                            <CaptionSettings Position="Right" />
                                                                            <Items>
                                                                                <dx:ListEditItem Text="I agree to ALL Terms and Conditions of using Maincom WORK ORDER" />
                                                                            </Items>
                                                                        </dx:ASPxCheckBoxList>
                                                                    </dx:LayoutItemNestedControlContainer>
                                                                </LayoutItemNestedControlCollection>
                                                            </dx:LayoutItem>
                                                            <dx:LayoutItem ShowCaption="False" HorizontalAlign="Left">
                                                                <LayoutItemNestedControlCollection>
                                                                    <dx:LayoutItemNestedControlContainer>                                                                        
                                                                        <a id="LNKBTN_TC2" runat="server" target="_blank" href='~/TermsNConditions/TermsAndConditionsWorkOrder.pdf'>READ TERMS AND CONDITIONS</a>
                                                                    </dx:LayoutItemNestedControlContainer>
                                                                </LayoutItemNestedControlCollection>
                                                            </dx:LayoutItem>



                                                        </Items>
                                                    </dx:LayoutGroup>
                                                </Items>
                                            </dx:ASPxFormLayout>

                                        </dx:ContentControl>
                                    </ContentCollection>
                                </dx:TabPage>

                            </TabPages>
                        </dx:ASPxPageControl>
                    </dx:PanelContent>
                </PanelCollection>
            </dx:ASPxPanel>

            <dx:ASPxPopupControl ID="pcLogin" runat="server" Width="500" CloseAction="CloseButton" CloseOnEscape="true" Modal="True"
                PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="Middle" ClientInstanceName="pcLogin"
                HeaderText="Document Upload" AllowDragging="True" PopupAnimationType="None" EnableViewState="False" AutoUpdatePosition="true" ScrollBars="Auto" ShowCloseButton="False">
                <ClientSideEvents PopUp="function(s, e) { ASPxClientEdit.ClearGroup('entryGroup'); tbLogin.Focus(); }" />
                <ContentCollection>
                    <dx:PopupControlContentControl runat="server">
                        <table>
                            <tr>
                                <td>
                                    <dx:ASPxLabel ID="ASPxLabel1" runat="server" Text="Uploading document :"></dx:ASPxLabel>
                                </td>
                                <td>
                                    <dx:ASPxTextBox ID="DocTypeId" runat="server" Width="170px" ClientInstanceName="DocTypeId" Text="5" ClientEnabled="false" Font-Bold="True">
                                        <CaptionCellStyle>
                                            <Border BorderStyle="None" />
                                        </CaptionCellStyle>
                                    </dx:ASPxTextBox>
                                    <dx:ASPxHiddenField runat="server" ClientInstanceName="hpDocTypeId" ID="hpDocTypeId">
                                    </dx:ASPxHiddenField>
                                    <dx:ASPxHiddenField runat="server" ClientInstanceName="hpRequestId" ID="hpRequestId">
                                    </dx:ASPxHiddenField>
                                </td>
                            </tr>
                        </table>

                        <dx:ASPxImage ID="ASPxImage1" runat="server" ClientInstanceName="img1" ShowLoadingImage="true" Width="400px" Height="400px" />

                        <dx:ASPxUploadControl ID="ASPxUploadControl1" runat="server" ClientInstanceName="uploader"
                            ShowProgressPanel="True" NullText="Click here to browse files…" Width="320"
                            OnFileUploadComplete="ASPxUploadControl1_FileUploadComplete" ShowUploadButton="True">



                            <UploadButton Text="&nbsp;&nbsp;Upload &amp; Save" Image-Url="../Images/Upload.png">
                            </UploadButton>



                            <AdvancedModeSettings EnableDragAndDrop="true" />

                            <ValidationSettings MaxFileSize="4194304" AllowedFileExtensions=".jpg,.jpeg,.png,.bmp" />

                            <ClientSideEvents FileUploadComplete="function(s, e) { img1.SetImageUrl(e.callbackData); }" />

                        </dx:ASPxUploadControl>

                        <dx:ASPxLabel ID="lblAllowebMimeType" runat="server" Font-Size="8pt"
                            Text='<%# "Allowed file types: " + string.Join(", ", ASPxUploadControl1.ValidationSettings.AllowedFileExtensions) %>' />
                        <br />
                        <dx:ASPxLabel ID="lblMaxFileSize" runat="server" Font-Size="8pt"
                            Text='<%# "Maximum file size: " + ASPxUploadControl1.ValidationSettings.MaxFileSize / 1048576 + "Mb" %>' />
                        <br />
                        <br />

                        <table>
                            <tr>

                                <td>
                                    <dx:ASPxButton ID="btnCancel" runat="server" Text="Close Window" AutoPostBack="false">
                                        <ClientSideEvents Click="function(s, e) { HideLoginWindow(); }" />
                                    </dx:ASPxButton>
                                </td>
                            </tr>
                        </table>

                    </dx:PopupControlContentControl>
                </ContentCollection>

                <ContentStyle>
                    <Paddings PaddingBottom="5px" />
                </ContentStyle>
            </dx:ASPxPopupControl>

            <dx:ASPxPopupControl ID="pcAddSkill" runat="server" Width="500" CloseAction="CloseButton" CloseOnEscape="true" Modal="True"
                PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="Middle" ClientInstanceName="pcAddSkill"
                HeaderText="Add a Trade Skill" AllowDragging="True" PopupAnimationType="None" EnableViewState="False" AutoUpdatePosition="true" ScrollBars="Auto" ShowCloseButton="False">
                <ClientSideEvents PopUp="function(s, e) { ASPxClientEdit.ClearGroup('entryGroup'); cbbTradeSkillList.Focus(); }" />
                <ContentCollection>
                    <dx:PopupControlContentControl runat="server">
                        <table>
                            <tr>
                                <td>
                                    <dx:ASPxLabel ID="ASPxLabel2" runat="server" Text="Trade Skill:"></dx:ASPxLabel>
                                </td>
                                <td>
                                    <dx:ASPxComboBox ID="cbbTradeSkillList" ClientInstanceName="cbbTradeSkillList" runat="server" ValueType="System.String" DataSourceID="SqlDsTradeSkillsList" Width="400px">
                                        <ClientSideEvents SelectedIndexChanged="function(s, e) {hpIsTradeSkillDoc.Set('pSkillName', s.GetText()); ChangeDocumentType(s);  }" />
                                        <Columns>

                                            <dx:ListBoxColumn FieldName="Trade_Name" />
                                        </Columns>
                                    </dx:ASPxComboBox>
                                    <asp:SqlDataSource ID="SqlDsTradeSkillsList" runat="server"
                                        ConnectionString="<%$ ConnectionStrings:DataConnectionString %>"></asp:SqlDataSource>
                                    <dx:ASPxHiddenField runat="server" ClientInstanceName="hpIsTradeSkillDoc" ID="hpIsTradeSkillDoc">
                                    </dx:ASPxHiddenField>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <dx:ASPxLabel ID="ASPxLabel5" runat="server" Text="License Number: "></dx:ASPxLabel>
                                </td>
                                <td>
                                    <dx:ASPxTextBox ID="tbx_AddLicenseNumber" ClientInstanceName="tbx_AddLicenseNumber" runat="server" Width="170px">
                                        <ClientSideEvents TextChanged="function(s,e){hpIsTradeSkillDoc.Set('pSkillLicenseNumber', s.GetText());}" />
                                        <ValidationSettings RequiredField-IsRequired="true" Display="Dynamic">
                                            <RequiredField IsRequired="True"></RequiredField>
                                        </ValidationSettings>
                                    </dx:ASPxTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <dx:ASPxLabel ID="ASPxLabel6" runat="server" Text="Expiry Date: "></dx:ASPxLabel>
                                </td>
                                <td>
                                    <dx:ASPxDateEdit runat="server" ID="tbx_AddLicenseNumberExpDate" ClientInstanceName="tbx_AddLicenseNumberExpDate">
                                        <ClientSideEvents DateChanged="function(s,e){hpIsTradeSkillDoc.Set('pSkillLicenseExpDate', s.GetText());}" />
                                        <ValidationSettings RequiredField-IsRequired="true" Display="Dynamic">
                                            <RequiredField IsRequired="True"></RequiredField>
                                        </ValidationSettings>
                                    </dx:ASPxDateEdit>
                                </td>
                            </tr>
                        </table>

                        <dx:ASPxImage ID="ASPxImage2" runat="server" ClientInstanceName="img2" ShowLoadingImage="true" Width="400px" Height="400px" />

                        <dx:ASPxUploadControl ID="ASPxUploadControl2" runat="server" ClientInstanceName="uploader2"
                            ShowProgressPanel="True" NullText="Click here to browse files..." Width="350"
                            OnFileUploadComplete="ASPxUploadControl1_FileUploadComplete" ShowUploadButton="False">



                            <AdvancedModeSettings EnableDragAndDrop="true" />

                            <ValidationSettings MaxFileSize="4194304" AllowedFileExtensions=".jpg,.jpeg,.png,.bmp,.pdf,.doc,.docx">
                            </ValidationSettings>

                            <ClientSideEvents FileUploadComplete="function(s, e) {img2.SetImageUrl(e.callbackData); alert('Skill added successfully.');}" />

                        </dx:ASPxUploadControl>
                        <dx:ASPxLabel ID="lbl_uploader2Extensions" ClientInstanceName="lbl_uploader2Extensions" runat="server" EncodeHtml="false" Text="Upload a File (photo) of your license  <br/> Allowed file extensions: jpg, jpeg, png, bmp"></dx:ASPxLabel>

                        <dx:ASPxLabel ID="ASPxLabel3" runat="server" Font-Size="8pt"
                            Text='<%# "Allowed file types: " + string.Join(", ", ASPxUploadControl2.ValidationSettings.AllowedFileExtensions) %>' />
                        <br />
                        <dx:ASPxLabel ID="ASPxLabel4" runat="server" Font-Size="8pt"
                            Text='<%# "Maximum file size: " + ASPxUploadControl2.ValidationSettings.MaxFileSize / 1048576 + "Mb" %>' />
                        <br />
                        <br />

                        <table>
                            <tr>
                                <td>
                                    <dx:ASPxButton ID="btnSaveSkill" runat="server" Text="Add to List" AutoPostBack="false">
                                        <ClientSideEvents Click="function(s, e) {  OnBtnUploadClick(s, e);   }" />

                                    </dx:ASPxButton>


                                </td>
                                <td>
                                    <dx:ASPxButton ID="btnCancelSkill" runat="server" Text="Close" AutoPostBack="false">
                                        <ClientSideEvents Click="function(s, e) { HideAddSkillWindow(); }" />
                                    </dx:ASPxButton>
                                </td>
                            </tr>
                        </table>

                    </dx:PopupControlContentControl>
                </ContentCollection>

                <ContentStyle>
                    <Paddings PaddingBottom="5px" />
                </ContentStyle>
            </dx:ASPxPopupControl>

            <div id="AddEmployeeWindow" runat="server" class="modal-content" visible="false">

                <dx:ASPxButton ID="btn_ExitAddEmployee" runat="server" HorizontalAlign="Right" Text="Close" Wrap="False" AutoPostBack="True" CausesValidation="False" OnClick="btn_ExitAddEmployee_Click">

                    <Image Height="16px" Width="16px" Url="../Images/exit.png"></Image>
                </dx:ASPxButton>
                <dx:ASPxButton ID="btn_saveEmployee" runat="server" Text="Save" AutoPostBack="True" HorizontalAlign="Right" OnClick="btn_SaveEmployee_Click"  >
                    <Image Height="16px" Width="16px" Url="../Images/save.png"></Image>
                   <ClientSideEvents Click="function(s,e){ValidateEmployeeFields()}" />
                </dx:ASPxButton>


                <dx:ASPxHiddenField runat="server" ClientInstanceName="hpEmployeeId" ID="hpEmployeeId">
                </dx:ASPxHiddenField>
                <dx:ASPxFormLayout runat="server" ID="AddEmployeeForm" ClientInstanceName="AddEmployeeForm" CssClass="formLayout">

                    <Items>

                        <dx:EmptyLayoutItem Width="100%" />
                        <dx:LayoutItem Caption="Employee Id">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer>
                                    <dx:ASPxTextBox runat="server" ClientEnabled="false" ID="tbx_EmployeeId" ClientInstanceName="tbx_EmployeeId">
                                    </dx:ASPxTextBox>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>

                        <dx:LayoutItem Caption="Employee Name">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer>
                                    <dx:ASPxTextBox runat="server" ID="tbx_employee_NAME" ClientInstanceName="tbx_employee_NAME">
                                        <ValidationSettings RequiredField-IsRequired="true" Display="Dynamic" />
                                    </dx:ASPxTextBox>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>

                        <dx:LayoutItem Caption="Surnames">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer>
                                    <dx:ASPxTextBox runat="server" ID="tbx_employee_SURNAME" ClientInstanceName="tbx_employee_SURNAME">
                                        <ValidationSettings RequiredField-IsRequired="true" Display="Dynamic" />
                                    </dx:ASPxTextBox>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>


                        <dx:LayoutItem Caption="Email Address ">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer>
                                    <dx:ASPxTextBox runat="server" ID="tbx_employee_EMAIL" ClientInstanceName="tbx_employee_EMAIL" NullText="If you dont have one use a reference one" width="300px">
                                         <ValidationSettings  Display="Dynamic" RequiredField-IsRequired="true" >
                                                        
                                                        <RegularExpression ErrorText="Invalid e-mail" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" />
                                                        
                                         </ValidationSettings>
                                    </dx:ASPxTextBox>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>


                        <dx:LayoutItem Caption="Contact phone">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer>
                                    <dx:ASPxTextBox runat="server" ID="tbx_employee_PHONE" ClientInstanceName="tbx_employee_PHONE">
                                        <ValidationSettings RequiredField-IsRequired="true" Display="Dynamic" />
                                    </dx:ASPxTextBox>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>


                        <dx:LayoutItem Caption="Mobile Phone">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer>
                                    <dx:ASPxTextBox runat="server" ID="tbx_employee_MOBILE" ClientInstanceName="tbx_employee_MOBILE">
                                    </dx:ASPxTextBox>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>

                        <dx:LayoutGroup ShowCaption="False" ColCount="2">
                            <Items>
                                <dx:LayoutGroup ShowCaption="False" GroupBoxDecoration="None">
                                    <Items>
                                        <dx:LayoutGroup Caption="CONSTRUCTION INDUCTION CARD INFORMATION" GroupBoxStyle-Caption-ForeColor="#0099CC" GroupBoxStyle-Caption-Font-Bold="true">
                                            <Items>

                                                <dx:LayoutItem Caption="Induction Card Number">
                                                    <LayoutItemNestedControlCollection>
                                                        <dx:LayoutItemNestedControlContainer>
                                                            <dx:ASPxTextBox ID="tbx_InductionCard" ClientInstanceName="tbx_InductionCard" runat="server" Width="350px">
                                                                <ValidationSettings RequiredField-IsRequired="true" Display="Dynamic" />
                                                            </dx:ASPxTextBox>
                                                        </dx:LayoutItemNestedControlContainer>
                                                    </LayoutItemNestedControlCollection>
                                                </dx:LayoutItem>

                                                <dx:LayoutItem Caption="Induction Card Expiry Date">
                                                    <LayoutItemNestedControlCollection>
                                                        <dx:LayoutItemNestedControlContainer>
                                                            <dx:ASPxDateEdit runat="server" ID="tbx_InductionCardExpDate" ClientInstanceName="tbx_InductionCardExpDate">
                                                                <ValidationSettings RequiredField-IsRequired="true" Display="Dynamic" />
                                                            </dx:ASPxDateEdit>
                                                        </dx:LayoutItemNestedControlContainer>
                                                    </LayoutItemNestedControlCollection>
                                                </dx:LayoutItem>

                                                <dx:LayoutItem Caption="Document Attached">
                                                    <LayoutItemNestedControlCollection>
                                                        <dx:LayoutItemNestedControlContainer>




                                                            <table>
                                                                <tr>
                                                                    <td>
                                                                        <dx:ASPxTextBox ID="tbx_InductionCardDocId" ClientInstanceName="tbx_InductionCardDocId" runat="server" Width="350px" NullText="Use the CHOOSE FILE button below to select your file" ClientEnabled="false">
                                                                            <ValidationSettings RequiredField-IsRequired="true" Display="Dynamic" />
                                                                        </dx:ASPxTextBox>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <asp:FileUpload ID="FileUploadControlInductionCard" runat="server" />
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <dx:ASPxLabel ID="lbl_UploadInductioncardError" runat="server" Font-Size="8pt" Text="" ForeColor="Red" />
                                                                    </td>
                                                                </tr>
                                                            </table>



                                                        </dx:LayoutItemNestedControlContainer>
                                                    </LayoutItemNestedControlCollection>
                                                </dx:LayoutItem>



                                            </Items>
                                        </dx:LayoutGroup>
                                    </Items>
                                </dx:LayoutGroup>


                                <dx:LayoutGroup Caption="POLICE CHECK INFORMATION" GroupBoxStyle-Caption-ForeColor="#0099CC" GroupBoxStyle-Caption-Font-Bold="true">
                                    <Items>

                                        <dx:LayoutItem Caption="Police Check Reference">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer>
                                                    <dx:ASPxTextBox ID="tbx_POLICECHECK_REFERENCE" ClientInstanceName="tbx_POLICECHECK_REFERENCE" runat="server" Width="350px">
                                                        <ValidationSettings RequiredField-IsRequired="true" Display="Dynamic" />
                                                    </dx:ASPxTextBox>
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                        </dx:LayoutItem>

                                        <dx:LayoutItem Caption="Police Check Expiry Date">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer>
                                                    <dx:ASPxDateEdit runat="server" ID="tbx_POLICECHECK_EXPIRYDATE" ClientInstanceName="tbx_POLICECHECK_EXPIRYDATE">
                                                        <ValidationSettings RequiredField-IsRequired="true" Display="Dynamic" />
                                                    </dx:ASPxDateEdit>
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                        </dx:LayoutItem>

                                        <dx:LayoutItem Caption="Document Attached">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer>
                                                    <table>
                                                        <tr>                                              
                                                            <td>
                                                                <dx:ASPxTextBox ID="tbx_POLICECHECK_DOCID" ClientInstanceName="tbx_POLICECHECK_DOCID" runat="server" Width="350px" NullText="Use the CHOOSE FILE button below to select your file" ClientEnabled="false">
                                                                    <ValidationSettings RequiredField-IsRequired="true" Display="Dynamic" />
                                                                </dx:ASPxTextBox>
                                                            </td>
                                                        </tr>                                                        
                                                        <tr>                                              
                                                            <td>
                                                                 <asp:FileUpload ID="FileUploadPoliceCheck" runat="server"  />
                                                            </td>
                                                        </tr>                                                        
                                                        <tr>                                              
                                                            <td>
                                                                 <dx:ASPxLabel ID="lbl_PoliceCheckError" runat="server" Font-Size="8pt" Text=""  ForeColor="Red" />
                                                            </td>
                                                        </tr>                                                        
                                                    </table>
                                                    
                                                   
                                                    
                                                  
                                                   
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                        </dx:LayoutItem>



                                    </Items>
                                </dx:LayoutGroup>

                            </Items>
                        </dx:LayoutGroup>
















                    </Items>
                </dx:ASPxFormLayout>


            </div>

            <div id="AddEmployeeSkillWindow" runat="server" class="modal-content" visible="false">
                <dx:ASPxButton ID="btn_ExitAddEmployeeSkill" runat="server" HorizontalAlign="Right" Text="Exit" Wrap="False" AutoPostBack="True" CausesValidation="False" OnClick="btn_ExitAddEmployeeSkill_Click">
                    <Image Height="16px" Width="16px" Url="../Images/exit.png"></Image>
                </dx:ASPxButton>

                <dx:ASPxLabel ID="lbl_selectedEmployee" runat="server" Text="" ForeColor="Azure" />


                <dx:ASPxFormLayout runat="server" ID="AddEmployeeSkillForm" ClientInstanceName="AddEmployeeSkillForm" CssClass="formLayout">

                    <Items>


                        <dx:EmptyLayoutItem Width="100%" />
                        <dx:LayoutItem Caption="Trade Skill :">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer>
                                    <dx:ASPxComboBox ID="cbbEmployeeTradeSkillList" ClientInstanceName="cbbEmployeeTradeSkillList" runat="server" ValueType="System.String" DataSourceID="SqlDsEmployeeTradeSkillsList" Width="200px">
                                        <Columns>
                                            <dx:ListBoxColumn FieldName="Trade_Name" />
                                        </Columns>
                                        <ValidationSettings RequiredField-IsRequired="true" Display="Dynamic">
                                            <RequiredField IsRequired="True"></RequiredField>
                                        </ValidationSettings>
                                    </dx:ASPxComboBox>
                                    <asp:SqlDataSource ID="SqlDsEmployeeTradeSkillsList" runat="server"
                                        ConnectionString="<%$ ConnectionStrings:DataConnectionString %>"></asp:SqlDataSource>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>

                        <dx:LayoutItem Caption="License Number :">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer>
                                    <dx:ASPxTextBox ID="tbx_EmployeeLicenseNumber" ClientInstanceName="tbx_EmployeeLicenseNumber" runat="server" Width="170px">
                                        <ValidationSettings RequiredField-IsRequired="true" Display="Dynamic">
                                            <RequiredField IsRequired="True"></RequiredField>
                                        </ValidationSettings>
                                    </dx:ASPxTextBox>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>

                        <dx:LayoutItem Caption="Expiry Date :">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer>
                                    <dx:ASPxDateEdit runat="server" ID="tbx_EmployeeLicenseNumberExpDate" ClientInstanceName="tbx_EmployeeLicenseNumberExpDate">

                                        <ValidationSettings RequiredField-IsRequired="true" Display="Dynamic">
                                            <RequiredField IsRequired="True"></RequiredField>
                                        </ValidationSettings>
                                    </dx:ASPxDateEdit>

                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>

                        <dx:LayoutItem Caption="Attache Document">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer>
                                    <asp:FileUpload ID="FileUploadControlEmployeeSkill" runat="server" />
                                    <br />
                                     <asp:RegularExpressionValidator
                                         ID="RegularExpressionValidator2" runat="server"
                                         ErrorMessage="allowed file types are: JPG,GIF,PDF,DOC."
                                         ValidationExpression="^(([a-zA-Z]:)|(\\{2}\w+)\$?)(\\(\w[\w].*))(.jpg|.JPG|.gif|.GIF|.pdf|.PDF|.DOC|.doc)$"
                                         ControlToValidate="FileUploadControlEmployeeSkill" Font-Size="8pt"  ForeColor="red">  
                                     </asp:RegularExpressionValidator>
                                    <br />
                                    <dx:ASPxLabel ID="lbl_UploadEmployeeSkillError" runat="server" Font-Size="8pt" Text='' />
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem ShowCaption="False">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer>
                                    <dx:ASPxButton ID="btn_SaveEmployeeSkill" runat="server" Text="Add Skill to List" AutoPostBack="True" HorizontalAlign="Right" OnClick="btn_SaveEmployeeSkill_Click">
                                        <Image Height="16px" Width="16px" Url="../Images/save.png"></Image>
                                    </dx:ASPxButton>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>

                    </Items>
                </dx:ASPxFormLayout>

                <br />
                <dx:ASPxLabel ID="ASPxLabel12" runat="server" Font-Size="12pt" Text="LIST OF EXISTING SKILLS" />

                <dx:ASPxGridView ID="gv_employee_skills_tmp" runat="server" AutoGenerateColumns="False" DataSourceID="sqlDS_employeeskills_tmp" KeyFieldName="TRADESKILL_ID" Width="100%">
                    <Columns>
                        <dx:GridViewDataTextColumn Width="40px" ShowInCustomizationForm="True" VisibleIndex="0">
                            <DataItemTemplate>
                                <asp:LinkButton ID="btn_DeleteEmployeeSkill" runat="server" OnClick="Btn_DeleteEmployeeSkill_Click" OnClientClick="return confirm('Are you sure you want to delete this record?')">Delete</asp:LinkButton>
                            </DataItemTemplate>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="TRADESKILL_ID" Width="60px" ReadOnly="True" VisibleIndex="1" Caption="ID">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="TRADESKILL_DESC" ReadOnly="True" VisibleIndex="2" Caption="DESCRIPTION">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="license_number" VisibleIndex="3" Caption="LICENSE NUMBER">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="expiry_date" VisibleIndex="4" Caption="EXPIRY DATE">
                        </dx:GridViewDataTextColumn>
                    </Columns>
                </dx:ASPxGridView>
                <asp:SqlDataSource ID="sqlDS_employeeskills_tmp" runat="server" ConnectionString="<%$ ConnectionStrings:DataConnectionString %>"
                    SelectCommand="  select TRADESKILL_ID,
                                            TRADESKILL_DESC, 
                                            license_number,
                                            expiry_date,
                                            GUID
                                from  SUBCONREG_COMPANY_EMPLOYEES_TRADESKILLS
                            where  request_id = 1
                                and  employee_id = 1 "></asp:SqlDataSource>
            </div>

           

        </div>
         <div runat="server" id="ErrorWindow"  class="modal-content" visible="false">
               <dx:ASPxButton ID="btn_closeErrorWindow" runat="server" ImageSpacing="3px" HorizontalAlign="Right" 
                                                                Text="Close" Wrap="False" AutoPostBack="true" OnClick="btn_closeErrorWindow_click">
                                                               
                                                                <Image Height="16px" Width="16px" Url="../Images/exit.png"></Image>
                                                            </dx:ASPxButton>
             

               <dx:ASPxLabel ID="ErrorList" runat="server" EncodeHtml="false" Text="ASPxLabel"></dx:ASPxLabel>
           </div>
        <div id="processMessage" style="display:none; position:absolute;  top:50%; left:50%; margin-top: -85px; margin-left: -85px;">              
             <img alt="Loading" src="../images/ajaxloader.gif" />
        </div>
         
    </form>
</body>
</html>

