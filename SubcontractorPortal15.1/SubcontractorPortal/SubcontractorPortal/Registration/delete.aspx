<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="delete.aspx.cs" Inherits="SubcontractorPortal.Registration.delete" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
            <dx:ASPxFormLayout runat="server" ID="formLayout" CssClass="formLayout">
                <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="800" />
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
                                                    <dx:ASPxCheckBox ID="cbx_NSW" Text="NSW" runat="server" Visible="true"></dx:ASPxCheckBox>
                                                </td>
                                                <td>
                                                    <dx:ASPxCheckBox ID="cbx_QLD" Text="QLD" runat="server" Visible="true"></dx:ASPxCheckBox>
                                                </td>
                                                <td>
                                                    <dx:ASPxCheckBox ID="cbx_VIC" Text="VIC" runat="server" Visible="true"></dx:ASPxCheckBox>
                                                </td>
                                                <td>
                                                    <dx:ASPxCheckBox ID="cbx_NT" Text="NT" runat="server" Visible="true"></dx:ASPxCheckBox>
                                                </td>
                                                <td>
                                                    <dx:ASPxCheckBox ID="cbx_TAS" Text="TAS" runat="server" Visible="true"></dx:ASPxCheckBox>
                                                </td>
                                                <td>
                                                    <dx:ASPxCheckBox ID="cbx_SA" Text="SA" runat="server" Visible="true"></dx:ASPxCheckBox>
                                                </td>
                                                <td>
                                                    <dx:ASPxCheckBox ID="cbx_WA" Text="WA" runat="server" Visible="true"></dx:ASPxCheckBox>
                                                </td>
                                                <td>
                                                    <dx:ASPxCheckBox ID="cbx_NEW_ZEALAND" Text="NZ" runat="server" Visible="true"></dx:ASPxCheckBox>
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
                                        </dx:ASPxTextBox>
                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>
                           
                            <dx:LayoutItem Caption="Suburb (type PostCode)">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer>
                                        <dx:ASPxComboBox ID="cbbPostcodeSuburb" runat="server">
                                            <Columns>
                                                <dx:ListBoxColumn Caption="Suburb List" FieldName="Suburb" />
                                            </Columns>
                                        </dx:ASPxComboBox>
                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>

                           <dx:EmptyLayoutItem  />

                            <dx:EmptyLayoutItem  width="100%"/>
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
                            <dx:LayoutItem Caption="Has your Company Conducted any works for MAINCOM in the past in this name or any other name?" >
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer>

                                        <dx:ASPxRadioButtonList ID="rbtn_COMPANY_DID_WORK_WITH_MAINCOM" runat="server" RepeatDirection="Horizontal" Paddings-Padding="0" ItemSpacing="10px">

                                            <Paddings Padding="0px"></Paddings>
                                            <Items>
                                                <dx:ListEditItem Text="Yes" Value="1" />
                                                <dx:ListEditItem Text="NO" Value="0" Selected="true" />
                                            </Items>
                                            <Border BorderColor="Transparent" />
                                            <ClientSideEvents SelectedIndexChanged="LargeWork_radiobtn_Changed" />
                                        </dx:ASPxRadioButtonList>

                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>
                            <dx:LayoutItem Caption="Provide Details if YES">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer>
                                        <dx:ASPxTextBox runat="server" ID="tbx_COMPANY_DID_WORK_WITH_MAINCOM_DETAILS" ClientInstanceName="tbx_COMPANY_DID_WORK_WITH_MAINCOM_DETAILS">
                                        </dx:ASPxTextBox>
                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>
                            <dx:LayoutItem Caption="Has your companare ryou over the past 3 years?" >
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer>

                                        <dx:ASPxRadioButtonList ID="rbtn_COMPANY_HAS_CORRECTIVE_PREVIOUS_JOBS" runat="server" RepeatDirection="Horizontal" Paddings-Padding="0" ItemSpacing="10px">

                                            <Paddings Padding="0px"></Paddings>
                                            <Items>
                                                <dx:ListEditItem Text="Yes" Value="1" />
                                                <dx:ListEditItem Text="NO" Value="0" Selected="true" />
                                            </Items>
                                            <Border BorderColor="Transparent" />
                                            <ClientSideEvents SelectedIndexChanged="LargeWork_radiobtn_Changed" />
                                        </dx:ASPxRadioButtonList>

                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>
                            <dx:LayoutItem Caption="Provide details if YES" >
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer>
                                        <dx:ASPxTextBox runat="server" ID="tbx_COMPANY_HAS_CORRECTIVE_PREVIOUS_JOBS_DETAILS" ClientInstanceName="tbx_COMPANY_HAS_CORRECTIVE_PREVIOUS_JOBS_DETAILS">
                                        </dx:ASPxTextBox>
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

                            <dx:LayoutItem Caption="How many jobs can you do in 30 days? " >
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer>
                                        <dx:ASPxTextBox runat="server" ID="tbx_jobcapacity30days" ClientInstanceName="tbx_jobcapacity30days" Width="170px">
                                        </dx:ASPxTextBox>
                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>

                            <dx:LayoutItem Caption="What is your average  $ value per job? 2k, 5k, 10k.. " >
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer>
                                        <dx:ASPxTextBox runat="server" ID="tbx_averagevaluejob" ClientInstanceName="tbx_averagevaluejob" Width="170px">
                                        </dx:ASPxTextBox>
                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>
                            <dx:LayoutItem ShowCaption="False" >
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer>

                                        <dx:ASPxRadioButtonList ID="rbtn_CompanyCanDoLargeWork" runat="server" RepeatDirection="Horizontal" Paddings-Padding="0" Caption="Do you have capacity for large construction work greater than 250k ?" ItemSpacing="10px">

                                            <Paddings Padding="0px"></Paddings>
                                            <Items>
                                                <dx:ListEditItem Text="Yes" Value="1" />
                                                <dx:ListEditItem Text="NO" Value="0" Selected="true" />
                                            </Items>
                                            <Border BorderColor="Transparent" />
                                            <ClientSideEvents SelectedIndexChanged="LargeWork_radiobtn_Changed" />
                                        </dx:ASPxRadioButtonList>

                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>

                            <dx:LayoutItem ShowCaption="False" >
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer>
                                        <div id="bigwork" style="visibility: hidden; border-bottom-width: 1px; padding-top: 5px; border-style: groove; border-width: 1px; border-color: darkblue;">
                                            <table>
                                                <tr>
                                                    <td style="vertical-align: top;">
                                                        <dx:ASPxLabel ID="ASPxLabel8" runat="server" Text="Please provide a Generic Safety Plan Document"></dx:ASPxLabel>
                                                    </td>
                                                    <td style="vertical-align: top;">
                                                        <dx:ASPxTextBox ID="tbx_GENERICSAFETYPLAN_DOCID" runat="server" Width="350px" ClientEnabled="false"></dx:ASPxTextBox>
                                                    </td>
                                                    <td style="vertical-align: top;">
                                                        <dx:ASPxUploadControl ID="ASPxUploadControlGenSafePlan" runat="server" ClientInstanceName="ASPxUploadControlGenSafePlan"
                                                            ShowProgressPanel="True" NullText="Click here to browse files…" Width="320"
                                                             ShowUploadButton="True">
                                                            <UploadButton Text="Upload" Image-Url="../Images/Upload.png" ImagePosition="Right">
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









                            
                           
                        </Items>
                    </dx:LayoutGroup>
                </Items>
            </dx:ASPxFormLayout>
    
    </div>
    </form>
</body>
</html>
