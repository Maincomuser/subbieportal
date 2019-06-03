<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CompanyData.aspx.cs" Inherits="SubcontractorPortal.Registration.CompanyData" %>

<%@ Import Namespace="System.Configuration" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <script type="text/javascript">

        window.history.forward(1);

        function CloseErrorsWindow()
        {
            var x = document.getElementById("ErrorWindow");
            x.style.visibility = 'hidden';
        }

        function LargeWork_radiobtn_Changed(s, e) {
            if (s.GetValue() == 0) {

                document.getElementById('bigwork').style.visibility = 'hidden';


            }
            else if (s.GetValue() == 1) {


                document.getElementById('bigwork').style.visibility = 'visible';

            }
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
           
            PageMethods.UpdateCompanyDetails(lbl_RequestId.GetValue(),
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
                //alert('Something went wrong.');
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

        function OnPassValidation(s, e) {
            var errorText = GetErrorText(s);
            if (errorText) {
                e.isValid = false;
                e.errorText = errorText;
            }

        }

        function onValidation(s, e) {
            setTimeout(function () { FormLayout.AdjustControl(); }, 0);
        }

        function validDate(pValue) {
            
            //var pattern = /^([0-9]{2})\/([0-9]{2})\/([0-9]{4})$/;
            if (pValue == null || pValue == "" /*|| !pattern.test(pValue)*/) {
                alert( 'Invalid Document Date');
                return false;
            }
            else {
                return true
            }
        }

        function ShowLoginWindow(pDocTypeId,pExpdate) {
           
            //setting up the value of the clicktype.    
            DocTypeId.SetValue(pDocTypeId);
            hpDocTypeId.Set("pDocumentTypeID", pDocTypeId);
            hpIsTradeSkillDoc.Set("pIsSkillDocument", "0");
            TmpDocExpDate.Set("pExpDate", pExpdate);
            pcLogin.Show();


        }

        function HideLoginWindow(pDocTypeId) {
            pcLogin.Hide();
            window.location.href = "CompanyData.aspx";
        }
        function ShowAddSkillWindow(pDocTypeId) {

            hpDocTypeId.Set("pDocumentTypeID", pDocTypeId);
            hpIsTradeSkillDoc.Set("pIsSkillDocument", "1");
            pcAddSkill.Show();
        }
        function HideAddSkillWindow() {
            pcAddSkill.Hide();
            window.location.href = "CompanyData.aspx";
        }
        function ShowUploadSWMSWindow() {
            pcAddSWMS.Show();
        }
        function HideUploadSWMSWindow() {
            pcAddSWMS.Hide();
            window.location.href = "CompanyData.aspx";
        }

        function ChangeDocumentType(s, e) {

            pDocTypeId = s.GetText();
            hpDocTypeId.Set("pDocumentTypeID", pDocTypeId);

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
        function OnBtnUploadClick(s, e) {
            
            if (cbbTradeSkillList.GetText() == "")
            {
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
              
                
            } else
            {
                alert('Please select a file first (All skills must have License Document)');
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
    position:absolute;
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


        <dx:ASPxPanel ID="TopPanel" runat="server" ClientInstanceName="TopPanel" Width="90%" CssClass="centered">
            <PanelCollection>
                <dx:PanelContent runat="server" SupportsDisabledAttribute="True">
                    <dx:ASPxFormLayout runat="server" ID="ASPxFormLayout1" ClientInstanceName="FormLayout">
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
                                                <dx:ASPxLabel ID="lbl_TopHeaderText" runat="server" Text="SUBCONTRACTOR APPLICATION TO WORK WITH MAINCOM (PART 1)" Font-Bold="True" ForeColor="#0099CC" Font-Size="Medium"></dx:ASPxLabel>                                                                                               
                                                <br />
                                                <dx:ASPxLabel ID="lbl_ReqStatus" runat="server" Text="APPLICATION STATUS - INCOMPLETE" Font-Bold="True" Font-Size="Large" ClientInstanceName="lbl_ReqStatus" ForeColor="#CC0000"></dx:ASPxLabel>
                                                <dx:ASPxLabel ID="lbl_RequestId" runat="server" Text="" Font-Bold="True" ForeColor="Azure" Font-Size="Medium" ClientInstanceName="lbl_RequestId"></dx:ASPxLabel>

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
                                                        <td colspan="2" align="right">
                                                            <dx:ASPxButton ID="ASPxButton2" runat="server" ImageSpacing="3px" Text="SAVE APPLICATION" Image-Url="~/Images/save.png" OnClick="btn_save_Click">
                                                                <Image Url="~/Images/save.png"></Image>
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
                </dx:PanelContent>
            </PanelCollection>

        </dx:ASPxPanel>

        <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePartialRendering="true" EnablePageMethods="true" />

        <dx:ASPxPanel ID="CompanyPanel" runat="server" ClientInstanceName="CompanyPanel" Width="90%" CssClass="centered">
            <PanelCollection>
                <dx:PanelContent>



                    <dx:ASPxFormLayout runat="server" ID="formLayout" ClientInstanceName="FormLayout">
                        <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="800" />
                        <Items>
                            <dx:LayoutGroup Caption="Application Form - Please complete all 6 sections" ColCount="2" GroupBoxDecoration="Default" UseDefaultPaddings="false" Paddings-PaddingTop="10">
                                <Paddings PaddingTop="10px"></Paddings>
                                <GroupBoxStyle>
                                    <Caption Font-Bold="true" Font-Size="13" />
                                </GroupBoxStyle>
                                <Items>
                                                                  
                                    
                                    <dx:LayoutItem ShowCaption="False" Width="100%">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer>
                                                <dx:ASPxLabel runat="server" Text="1) Company Information" Font-Size="Medium" Font-Bold="true" ForeColor="#0099CC"></dx:ASPxLabel>
                                            </dx:LayoutItemNestedControlContainer>
                                        </LayoutItemNestedControlCollection>
                                    </dx:LayoutItem>

                                    <dx:LayoutItem Caption="Where is your business intending to work?" Width="100%">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer>
                                                <table>
                                                    <tr>
                                                        <td>
                                                            <dx:ASPxCheckBox ID="cbx_NSW"  ClientInstanceName="cbx_NSW" Text="NSW" runat="server" Visible="true"></dx:ASPxCheckBox>
                                                        </td>
                                                        <td>
                                                            <dx:ASPxCheckBox ID="cbx_QLD" ClientInstanceName="cbx_QLD" Text="QLD" runat="server" Visible="true"></dx:ASPxCheckBox>
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
                                                <dx:ASPxTextBox runat="server" ID="tbx_EmailAddress" ClientInstanceName="tbx_EmailAddress">
                                                    <ValidationSettings ErrorDisplayMode="Text" Display="Dynamic" ErrorTextPosition="Bottom" SetFocusOnError="true">
                                                        <ErrorFrameStyle Wrap="True" />
                                                        <RegularExpression ErrorText="Invalid e-mail" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" />
                                                        
                                                    </ValidationSettings>
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
                                    <dx:LayoutItem Caption="ABN ">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer>
                                                <dx:ASPxTextBox runat="server" ID="tbx_CompanyABN" ClientInstanceName="tbx_CompanyABN">
                                                    <ValidationSettings Display="Dynamic"  RegularExpression-ValidationExpression=".{11}" RegularExpression-ErrorText="ABN must have 11 characters in lenght"  ErrorDisplayMode="Text" SetFocusOnError="true" ErrorTextPosition="Bottom" ErrorFrameStyle-Wrap="true"/>
                                                </dx:ASPxTextBox>
                                            </dx:LayoutItemNestedControlContainer>
                                        </LayoutItemNestedControlCollection>
                                    </dx:LayoutItem>
                                    <dx:LayoutItem Caption="Suburb (type PostCode and Select from List)">
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
                                                <dx:ASPxLabel runat="server" Text="2) Insurances " Font-Size="Medium" Font-Bold="true" ForeColor="#0099CC"></dx:ASPxLabel>
                                            </dx:LayoutItemNestedControlContainer>
                                        </LayoutItemNestedControlCollection>
                                    </dx:LayoutItem>

                                  


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
                                                                    <ClientSideEvents Click="function(s, e) {  if (validDate(tbx_CompensationNumberExpDate.GetValue()) == true)
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
                                                                    <ClientSideEvents Click="function(s, e) { if (validDate(tbx_PublicLiabilityExpDate.GetValue()) == true)
                                                                                                              {
                                                                                                                 UpdateCompanyDetails(); 
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


                                

                                    <dx:EmptyLayoutItem Width="100%" />
                                    <dx:LayoutItem ShowCaption="False">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer>
                                                <dx:ASPxLabel runat="server" Text="3) Licensing and Qualifications" Font-Size="Medium" Font-Bold="true" ForeColor="#0099CC"></dx:ASPxLabel>
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
                                                    <EditFormLayoutProperties>
                                                        <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="600" />
                                                    </EditFormLayoutProperties>
                                                    <Columns>

                                                        <dx:GridViewDataTextColumn FieldName="TRADE_ID" Caption="Code" Width="50px" ShowInCustomizationForm="True" VisibleIndex="0">
                                                        </dx:GridViewDataTextColumn>
                                                        <dx:GridViewDataTextColumn FieldName="TRADE_DESCRIPTION" Caption="Skill Name" ShowInCustomizationForm="True" VisibleIndex="1">
                                                        </dx:GridViewDataTextColumn>
                                                        <dx:GridViewDataTextColumn FieldName="LICENSE_NUMBER" Caption="License Number" ShowInCustomizationForm="True" VisibleIndex="2">
                                                        </dx:GridViewDataTextColumn>
                                                        <dx:GridViewDataDateColumn FieldName="LICENSE_EXPDATE" Caption="Exp Date" Width="100px" ShowInCustomizationForm="True" VisibleIndex="3">
                                                        </dx:GridViewDataDateColumn>
                                                        <dx:GridViewDataTextColumn Caption="Attached Document" ShowInCustomizationForm="True" VisibleIndex="4">
                                                            <DataItemTemplate>
                                                               
                                                                 <a id="clickElement" target="_blank" href='<%#  Eval("GUID1") %>'>View Document</a>
                                                            </DataItemTemplate>
                                                        </dx:GridViewDataTextColumn>
                                                        <dx:GridViewDataTextColumn Width="80px" ShowInCustomizationForm="True" VisibleIndex="5">
                                                            <DataItemTemplate>
                                                                <asp:LinkButton ID="btn_DeleteSkill" runat="server" OnClientClick="return confirm('Are you sure you want to remove this skill from the list?')" OnClick="btn_DeleteSkill_Click">Remove</asp:LinkButton>
                                                            </DataItemTemplate>
                                                        </dx:GridViewDataTextColumn>
                                                    </Columns>


                                                </dx:ASPxGridView>





                                                <asp:SqlDataSource ID="sqlDS_TradeSkills" runat="server" ConnectionString="<%$ ConnectionStrings:DataConnectionString %>"></asp:SqlDataSource>
                                            </dx:LayoutItemNestedControlContainer>
                                        </LayoutItemNestedControlCollection>
                                    </dx:LayoutItem>

                                    <dx:EmptyLayoutItem Width="100%" />
                                    <dx:LayoutItem ShowCaption="False" Width="100%">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer>
                                                <dx:ASPxLabel runat="server" Text="4) Business Capacity  " Font-Size="Medium" Font-Bold="true" ForeColor="#0099CC"></dx:ASPxLabel>
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
                                    <dx:LayoutItem ShowCaption="False" Width="100%">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer>
                                                <table>
                                                    <tr>
                                                        <td>
                                                            <dx:ASPxLabel ID="ASPxLabel13" runat="server" Text="Do you have capacity for large construction work greater than 250k ?"></dx:ASPxLabel>
                                                        </td>
                                                        <td>
                                                            <dx:ASPxRadioButtonList ID="rbtn_CompanyCanDoLargeWork" ClientInstanceName="rbtn_CompanyCanDoLargeWork"  runat="server" RepeatDirection="Horizontal" Paddings-Padding="0" ItemSpacing="10px">

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

                                    <dx:LayoutItem ShowCaption="False" Width="100%">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer>
                                                <div id="bigwork" style="visibility: hidden; border-bottom-width: 1px; padding-top: 5px; border-style: groove; border-width: 1px; border-color: darkblue;">
                                                    <table>
                                                        <tr>
                                                            <td style="vertical-align: top;">
                                                                <dx:ASPxLabel ID="ASPxLabel8" runat="server" Text="Please provide a Generic Safety Plan Document"></dx:ASPxLabel>
                                                            </td>
                                                            <td style="vertical-align: top;">
                                                                <dx:ASPxTextBox ID="tbx_GENERICSAFETYPLAN_DOCID" runat="server" Width="350px" ClientEnabled="false" NullText="CLICK ON BROWSE BUTTON TO UPLOAD A FILE"></dx:ASPxTextBox>
                                                                  <a id="lnk_viewgenericsafetyplan"   runat="server" target="_blank" href='d'>View Document Attached</a>
                                                            </td>
                                                            <td style="vertical-align: top;">
                                                                <dx:ASPxUploadControl ID="ASPxUploadControlGenSafePlan" runat="server" ClientInstanceName="ASPxUploadControlGenSafePlan"
                                                                    ShowProgressPanel="True" NullText="Click here to browse files…" Width="320"
                                                                    OnFileUploadComplete="ASPxUploadControlBIGWORK_FileUploadComplete" ShowUploadButton="True">
                                                                    <UploadButton Text="Upload&nbsp;&nbsp;" Image-Url="../Images/Upload.png" ImagePosition="Right">
                                                                        <Image Url="../Images/Upload.png"></Image>                                                                        
                                                                    </UploadButton>
                                                                    <AdvancedModeSettings EnableDragAndDrop="true" />
                                                                    <ValidationSettings MaxFileSize="4194304" AllowedFileExtensions=".jpg,.jpeg,.png,.bmp,.pdf,.doc,.docx" />
                                                                     <ClientSideEvents  FileUploadComplete="function(s, e) { alert('File added successfully!'); window.location.href = 'CompanyData.aspx'; }" />
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
                                                <dx:ASPxLabel runat="server" Text="5) Safe Work Method Statements" Font-Size="Medium" Font-Bold="true" ForeColor="#0099CC"></dx:ASPxLabel>
                                            </dx:LayoutItemNestedControlContainer>
                                        </LayoutItemNestedControlCollection>
                                    </dx:LayoutItem>

                                    <dx:LayoutItem Caption="Please upload your SWMS Document (if multiple please join them in one file) " Width="100%">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer>
                                                <table>
                                                    <tr>
                                                        <td>
                                                            <dx:ASPxTextBox ID="tbx_SWMS_DOCID" runat="server" ClientInstanceName="tbx_SWMS_DOCID" ClientEnabled="false" Width="350px"></dx:ASPxTextBox>
                                                              <a id="lnk_viewswmsdoc"   runat="server" target="_blank" href='d'>View Docuemnt Attached</a>
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

                                    <dx:LayoutItem ShowCaption="False" Width="100%">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer>
                                                <dx:ASPxLabel runat="server" Text="Please answer each one of the questions bellow."  Font-Bold="true" ></dx:ASPxLabel>
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


                                    <dx:EmptyLayoutItem Width="100%" />
                                    <dx:LayoutItem ShowCaption="False" Width="100%">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer>
                                                <dx:ASPxLabel runat="server" Text="6) Compulsory Agreements" Font-Size="Medium" Font-Bold="true" ForeColor="#0099CC"></dx:ASPxLabel>
                                            </dx:LayoutItemNestedControlContainer>
                                        </LayoutItemNestedControlCollection>
                                    </dx:LayoutItem>
                                    <dx:LayoutItem ShowCaption="False" Width="100%">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer>
                                                <dx:ASPxLabel runat="server" Text="You MUST read carefully both documents before agreeing"></dx:ASPxLabel>
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

                                    <dx:EmptyLayoutItem Width="100%" />
                                    <dx:LayoutItem ShowCaption="False" Width="100%" HorizontalAlign="Right">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer>

                                                <dx:ASPxButton ID="btn_save" runat="server" ImageSpacing="3px" Text="SAVE APPLICATION" Image-Url="~/Images/save.png" OnClick="btn_save_Click">
                                                    <Image Url="~/Images/save.png"></Image>
                                                </dx:ASPxButton>
                                            </dx:LayoutItemNestedControlContainer>
                                        </LayoutItemNestedControlCollection>
                                    </dx:LayoutItem>

                                </Items>
                            </dx:LayoutGroup>


                        </Items>
                    </dx:ASPxFormLayout>


                    <dx:ASPxHiddenField runat="server" ClientInstanceName="TmpDocExpDate" ID="TmpDocExpDate">
                    </dx:ASPxHiddenField>

                </dx:PanelContent>
            </PanelCollection>
            <Paddings Padding="8px" />
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
                                <dx:ASPxButton ID="btnCancel" runat="server" Text="Close Window"  AutoPostBack="false" >
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
        |
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
                                <dx:ASPxComboBox ID="cbbTradeSkillList"  ClientInstanceName="cbbTradeSkillList" runat="server" ValueType="System.String" DataSourceID="SqlDsTradeSkillsList" Width="400px" >
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

                        <ValidationSettings MaxFileSize="4194304" AllowedFileExtensions=".jpg,.jpeg,.png,.bmp,.pdf,.doc,.docx"  >
                              
                        </ValidationSettings>

                        <ClientSideEvents FileUploadComplete="function(s, e) {img2.SetImageUrl(e.callbackData); alert('Skill added successfully.');}" />

                    </dx:ASPxUploadControl>
                    <dx:ASPxLabel ID="lbl_uploader2Extensions" ClientInstanceName="lbl_uploader2Extensions" runat="server" EncodeHtml="false" Text="Upload a File (photo) of your license  <br/> Allowed file extensions: .jpg,.jpeg,.png,.bmp,.pdf,.doc,.docx"></dx:ASPxLabel>

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


        <dx:ASPxPopupControl ID="pcAddSWMS" runat="server" Width="500" CloseAction="CloseButton" CloseOnEscape="true" Modal="True"
            PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="Middle" ClientInstanceName="pcAddSWMS"
            HeaderText="Upload your Safety Work Method Statment (SWMS) document" AllowDragging="True" PopupAnimationType="None" EnableViewState="False" AutoUpdatePosition="true" ScrollBars="Auto" ShowCloseButton="False">
            <ClientSideEvents PopUp="function(s, e) { ASPxClientEdit.ClearGroup('entryGroup'); tbLogin.Focus(); }" />
            <ContentCollection>
                <dx:PopupControlContentControl runat="server">




                    <dx:ASPxUploadControl ID="ASPxUploadControlSWMS" runat="server" ClientInstanceName="ASPxUploadControlSWMS"
                        ShowProgressPanel="True" NullText="Click here to browse files…" Width="320"
                        OnFileUploadComplete="ASPxUploadControlSWMS_FileUploadComplete" ShowUploadButton="True">
                        <UploadButton Text="Upload&nbsp;&nbsp;" Image-Url="../Images/Upload.png" ImagePosition="Right"></UploadButton>
                        <AdvancedModeSettings EnableDragAndDrop="true" />
                        <ValidationSettings MaxFileSize="4194304" AllowedFileExtensions=".jpg,.jpeg,.png,.bmp,.pdf,.doc,.docx" />
                        <ClientSideEvents FileUploadComplete="function(s, e) { img1.SetImageUrl(e.callbackData);alert('Your document was uploaded successfully!'); HideUploadSWMSWindow();}" />
                    </dx:ASPxUploadControl>

                    <dx:ASPxLabel ID="ASPxLabel11" runat="server" Font-Size="8pt"
                        Text='<%# "Allowed file types: " + string.Join(", ", ASPxUploadControlSWMS.ValidationSettings.AllowedFileExtensions) %>' />
                    <br />
                    <dx:ASPxLabel ID="ASPxLabel12" runat="server" Font-Size="8pt"
                        Text='<%# "Maximum file size: " + ASPxUploadControlSWMS.ValidationSettings.MaxFileSize / 1048576 + "Mb" %>' />
                    <br />
                    <br />

                    <table>
                        <tr>

                            <td>
                                <dx:ASPxButton ID="ASPxButton6" runat="server" Text="Close" AutoPostBack="false">
                                    <ClientSideEvents Click="function(s, e) { HideUploadSWMSWindow(); }" />
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
       
        
           <div runat="server" id="ErrorWindow"  class="modal-content" visible="false">
               <dx:ASPxButton ID="ASPxButton4" runat="server" ImageSpacing="3px" HorizontalAlign="Right" 
                                                                Text="Close" Wrap="False" AutoPostBack="False"
                                                                CausesValidation="False" UseSubmitBehavior="False">
                                                                <ClientSideEvents Click="function(s, e) {	CloseErrorsWindow()}" />
                                                                <Image Height="16px" Width="16px" Url="../Images/exit.png"></Image>
                                                            </dx:ASPxButton>
             

               <dx:ASPxLabel ID="ErrorList" runat="server" EncodeHtml="false" Text="ASPxLabel"></dx:ASPxLabel>
           </div>
        



    </form>
</body>
</html>

