<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RegistrationMandatoryDataPage.aspx.cs" Inherits="SubcontractorPortal.Registration.RegistrationMandatoryDataPage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Registration</title>
    <style type="text/css">
         .CenterToPage {
            margin: 0;
            position: absolute;
            top: 50%;
            left: 50%;
            -ms-transform: translate(-50%, -50%);
            transform: translate(-50%, -50%);
        }
        @media(max-width:840px) {
            .mobileGroupIndent {
                padding-top: 20px;
            }
        }
        .mobileAlign {
            text-align: center !important;
        }
        .maxWidth {
            max-width: 360px !important;
        }
        .fullHeight {
            height: 100% !important;
        }
        .fullWidth {
            width: 100% !important;
        }
        .maxWidth {
            margin-top: 36px;
        }
    </style>
    <script type="text/javascript">
        var passwordMinLength = 6;
        function GetPasswordRating(password) {
            var result = 0;
            if (password) {
                result++;
                if (password.length >= passwordMinLength) {
                    if (/[a-z]/.test(password))
                        result++;
                    if (/[A-Z]/.test(password))
                        result++;
                    if (/\d/.test(password))
                        result++;
                    if (!(/^[a-z0-9]+$/i.test(password)))
                        result++;
                }
            }
            return result;
        }
        function OnPasswordTextBoxInit(s, e) {
            ApplyCurrentPasswordRating();
        }
        function OnPassChanged(s, e) {
            ApplyCurrentPasswordRating();
        }
        function ApplyCurrentPasswordRating() {
            var password = passwordTextBox.GetText();
            var passwordRating = GetPasswordRating(password);
            ApplyPasswordRating(passwordRating);
        }
        function ApplyPasswordRating(value) {
            ratingControl.SetValue(value);
            switch (value) {
                case 0:
                    ratingLabel.SetValue("Password safety");
                    break;
                case 1:
                    ratingLabel.SetValue("Not strong, you must have at least 6 Characters");
                    break;
                case 2:
                    ratingLabel.SetValue("Not safe, you must have at least 6 characters and is possible use alphanumeric characters");
                    break;
                case 3:
                    ratingLabel.SetValue("Normal");
                    break;
                case 4:
                    ratingLabel.SetValue("Safe");
                    break;
                case 5:
                    ratingLabel.SetValue("Very safe");
                    break;
                default:
                    ratingLabel.SetValue("Password safety");
            }
        }

        function GetErrorText(editor) {
            if (editor === passwordTextBox) {
                if (ratingControl.GetValue() === 1)
                    return "The password is too simple";
            } else if (editor === confirmPasswordTextBox) {
                if (passwordTextBox.GetText() !== confirmPasswordTextBox.GetText())
                    return "The password you entered do not match";
            }
            return "";
        }
        function OnPassValidation(s, e) {
            var errorText = GetErrorText(s);
            if (errorText) {
                e.isValid = false;
                e.errorText = errorText;
            }
           
        }
        function onControlsInitialized(s, e) {
            FormLayout.AdjustControl();
            var controls = ASPxClientControl.GetControlCollection().GetControlsByPredicate(function (c) {
                return c.GetParentControl() === FormLayout;
            });
            for (var i = 0; i < controls.length; i++) {
                var valEvt = controls[i].Validation;
                if (valEvt)
                    valEvt.AddHandler(onValidation);
            }
        }
        function onValidation(s, e) {
            setTimeout(function () { FormLayout.AdjustControl(); }, 0);
        }
       
        function PtyCompanyChanged(s, e) {
           
            
            if (s.GetValue() == 0) {
                alert('You must be a Proprietary limited company "PTY Ltd" business structure in order to register to work for Maincom.');
                btnCreateAccount.SetEnabled(false);

            }
            else if (s.GetValue() == 1) {
                
                btnCreateAccount.SetEnabled(true);
                
            }


        }
        function PagePrepare()
        {
            btnCreateAccount.SetEnabled(false);
        }
       

       
    </script>
</head>
<body style="background-color: #F0FFFF;" onload="PagePrepare()">
    <span id="message"></span>
    <form id="form1" runat="server">
         <div class="CenterToPage" style="width: 100%; height:550px; background-image: linear-gradient( #0088cc, #66ccff);">
        <div class="CenterToPage" style="width: 70%;">
    <dx:ASPxFormLayout ID="FormLayout" ClientInstanceName="FormLayout" runat="server" RequiredMarkDisplayMode="Auto" UseDefaultPaddings="false" AlignItemCaptionsInAllGroups="true"  Width="100%">
       <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="500" />
        <Paddings PaddingBottom="30" PaddingTop="10" />
        
      
        <Items>
            
                <dx:LayoutGroup GroupBoxDecoration="Box" HorizontalAlign="Center" BackColor="Azure" Border-BorderColor="Azure" ShowCaption="False">              
<Border BorderColor="Azure"></Border>
                <Items>
                     <dx:LayoutItem ShowCaption="False"  HorizontalAlign="left"  >
                         <Paddings PaddingTop="2" />
                        <NestedControlCellStyle CssClass="maxWidth"></NestedControlCellStyle>                       
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <h2>Account Creation</h2>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                    <dx:LayoutItem Caption="E-mail" >
                          <Paddings PaddingTop="15" />
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <dx:ASPxTextBox runat="server" ID="txb_Email">
                                    <ValidationSettings ErrorDisplayMode="Text" Display="Dynamic" ErrorTextPosition="Bottom" SetFocusOnError="true">
                                        <ErrorFrameStyle Wrap="True"/>
                                        <RegularExpression ErrorText="Invalid e-mail" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" />
                                        <RequiredField IsRequired="True" ErrorText="The value is required" />                                        
                                    </ValidationSettings>
                                    
                                </dx:ASPxTextBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                    <dx:LayoutItem Caption="Password">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <dx:ASPxTextBox ID="txb_Password" runat="server" ClientInstanceName="passwordTextBox" Password="true" >
                                    <ValidationSettings ErrorTextPosition="Bottom" ErrorDisplayMode="Text" Display="Dynamic" SetFocusOnError="true">
                                        <RequiredField IsRequired="True" ErrorText="The value is required" />
                                        <ErrorFrameStyle Wrap="True"/>
                                    </ValidationSettings>
                                    <ClientSideEvents Init="OnPasswordTextBoxInit" KeyUp="OnPassChanged" Validation="OnPassValidation" />
                                </dx:ASPxTextBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                    <dx:LayoutItem Caption=" " >
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <div>
                                    <dx:ASPxRatingControl ID="ratingControl" runat="server" ReadOnly="true" ItemCount="5" Value="0" ClientInstanceName="ratingControl" />
                                </div>
                                <div style="padding-top: 10px; padding-bottom: 10px">
                                    <dx:ASPxLabel ID="ratingLabel" runat="server" ClientInstanceName="ratingLabel" Text="Password safety" />
                                </div>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                    <dx:LayoutItem Caption="Confirm password" >
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <dx:ASPxTextBox ID="confirmPasswordTextBox" runat="server" ClientInstanceName="confirmPasswordTextBox" Password="true" Width="100%" >
                                    <ValidationSettings ErrorTextPosition="Bottom" ErrorDisplayMode="Text" Display="Dynamic" SetFocusOnError="true">
                                        <RequiredField IsRequired="True" ErrorText="The value is required" />
                                        <ErrorFrameStyle Wrap="True"/>
                                    </ValidationSettings>
                                    <ClientSideEvents Validation="OnPassValidation" />
                                </dx:ASPxTextBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                    
                    
                    <dx:LayoutItem ShowCaption="False"  HorizontalAlign="left"  >
                         <Paddings PaddingTop="20" />
                        <NestedControlCellStyle CssClass="maxWidth"></NestedControlCellStyle>                       
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                Please type the code below to confirm you are not a robot.
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                    <dx:LayoutItem ShowCaption="False"   >
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <dx:ASPxCaptcha runat="server" ID="captcha" TextBox-Position="Bottom" TextBox-ShowLabel="false" TextBoxStyle-Width="100%" Width="200">
                                    <RefreshButtonStyle Font-Underline="true"></RefreshButtonStyle>

<TextBoxStyle Width="100%"></TextBoxStyle>

                                    <ValidationSettings ErrorDisplayMode="Text" Display="Dynamic" SetFocusOnError="true">
                                        <RequiredField IsRequired="True" ErrorText="The value is required" />
                                    </ValidationSettings>

<TextBox Position="Bottom" ShowLabel="False"></TextBox>

<ChallengeImage ForegroundColor="#000000"></ChallengeImage>
                                </dx:ASPxCaptcha>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                    
                    
                    <dx:LayoutItem HorizontalAlign="Center" ShowCaption="False" >
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <dx:ASPxRadioButtonList ID="rbtnCompanyIsPTY" runat="server" RepeatDirection="Horizontal" Width="100%" Paddings-Padding="0" Caption="Are you a Pty Ltd company type ?" Font-Bold="true">
                                <ClientSideEvents SelectedIndexChanged="PtyCompanyChanged" />
                                <Paddings Padding="0px"></Paddings>
                                <Items>
                                    <dx:ListEditItem Text="Yes" Value="1" Selected="false" />
                                    <dx:ListEditItem Text="NO" Value="0" Selected="true"  />
                                </Items>
                                <Border BorderColor="Transparent" />
                            </dx:ASPxRadioButtonList>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                    
                    <dx:LayoutItem HorizontalAlign="Center" ShowCaption="False" CssClass="btn"  >
                        <Paddings PaddingTop="20" />
                     
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <table>
                                    <tr>
                                        <td>
                                            <dx:ASPxButton runat="server" ID="btnCreateAccount" ClientInstanceName="btnCreateAccount" Text="Create Account" Width="200px" CssClass="btn" OnClick="btnCreateAccount_Click">
                                            </dx:ASPxButton>
                                        </td>
                                        <td>
                                             <dx:ASPxButton runat="server" ID="btnCancel" ClientInstanceName="btnCancel" Text="Cancel" CssClass="btn" CausesValidation="False" OnClick="btnCancel_Click">
                                            </dx:ASPxButton>
                                        </td>

                                    </tr>
                                </table>
                                
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                    <dx:LayoutItem ShowCaption="False"  >
                        <NestedControlCellStyle CssClass="maxWidth"></NestedControlCellStyle>
                        <Paddings PaddingTop="12" />
                           <Paddings PaddingBottom ="20" />
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                By clicking "Create Account", you agree to Maincom's <a href="../TermsNConditions/Privacy Policy.pdf" target="_blank">privacy policy</a> and the <a href="../TermsNConditions/WWW Terms and Conditions.pdf">terms of use</a>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                </Items>
            </dx:LayoutGroup>
        
                
        </Items>
    </dx:ASPxFormLayout>
            </div>
             </div>
    </form>
</body>
</html>
