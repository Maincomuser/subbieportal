<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RegistrationWelcomePage.aspx.cs" Inherits="SubcontractorPortal.Registration.RegistrationWelcomePage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style>
        .CenterToPage {
            margin: 0;
            position: absolute;
            top: 50%;
            left: 50%;
            -ms-transform: translate(-50%, -50%);
            transform: translate(-50%, -50%);
        }

        .ResizeToCenter {
            background-position: center center;
            /* Background image doesn't tile */
            background-repeat: no-repeat;
            /* Background image is fixed in the viewport so that it doesn't move when 
               the content's height is greater than the image's height */
            background-attachment: fixed;
            /* This is what makes the background image rescale based
               on the container's size */
            background-size: cover;
            /* Set a background color that will be displayed
               while the background image is loading */
            background-color: #464646;
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
        function ShowRecoverPwdWindow() {
            pcLogin.Show();
        }
        function HideRecoverPwdWindow()
        {
            pcLogin.Hide();
        }
    </script>
</head>
<body  style="background-color: #F0FFFF;">
    <form id="form1" runat="server">
        <div class="CenterToPage" style="width: 100%; height:500px; background-image: linear-gradient( #0088cc, #66ccff);">
       
        <div class="CenterToPage" style="width: 70%;">
            <h2 style="color: white;">APPLICATION TO WORK FOR MAINCOM</h2>

            
          <h3 style="color: white;">Welcome to our Sub-Contractor registration page to work for the Maincom group.</h3>
            <dx:ASPxRoundPanel ID="ASPxRoundPanel1" ClientInstanceName="roundPanel" HeaderText="Log in details" runat="server" Width="100%" >
        <PanelCollection>
            <dx:PanelContent>
                
                <table>
                    <tr>
                        <td>
                            <dx:ASPxLabel ID="ASPxLabel1" runat="server" Text="E-mail ">
                            </dx:ASPxLabel>
                        </td>
                       
                    </tr>
                    <tr>
                        <td>
                            <dx:ASPxTextBox ID="txb_Email" runat="server">
                               
                            </dx:ASPxTextBox>
                        </td>

                    </tr>
                    <tr>
                        <td>
                            <dx:ASPxLabel ID="ASPxLabel2" runat="server" Text="Password ">
                            </dx:ASPxLabel>
                        </td>

                    </tr>
                    <tr>
                        <td>
                            <dx:ASPxTextBox ID="txb_password" runat="server" ClientInstanceName="passwordTextBox" Password="True">
                            </dx:ASPxTextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <br />
                            <dx:ASPxButton ID="btn_signIn" runat="server" CssClass="btn" Text="Sign In" Width="200px" OnClick="btn_signIn_Click">
                            </dx:ASPxButton>


                        </td>

                    </tr>
                    <tr>
                        <td>
                            <br/>
                            <dx:ASPxHyperLink ID="ASPxHyperLink1" runat="server" Text="Forgot your Passord?"   Cursor="pointer" Font-Underline="true" Font-Bold="true">
                                <ClientSideEvents Click="function(s, e) { ShowRecoverPwdWindow(); }" />
                            </dx:ASPxHyperLink>
                        </td>

                    </tr>
                </table>
                <hr/>
                 <h3>New to this Site? <br/>Create a login account to register</h3>
                <table>
                    
                    <tr>
                        <td>
                            <dx:ASPxButton ID="btn_CreateAccount" runat="server" CssClass="btn" Text="Create an account" OnClick="btn_CreateAccount_Click" >
                            </dx:ASPxButton>
                        </td>
                    </tr>


                </table>
                    
              
                
            </dx:PanelContent>

        </PanelCollection>
    </dx:ASPxRoundPanel>
        </div>
       </div>
            <dx:ASPxPopupControl ID="pcLogin" runat="server" Width="500" CloseAction="CloseButton" CloseOnEscape="true" Modal="True"
            PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" ClientInstanceName="pcLogin"
            HeaderText="Password Recovery" AllowDragging="True" PopupAnimationType="None" EnableViewState="False" AutoUpdatePosition="true" ScrollBars="Auto">
            <ClientSideEvents PopUp="function(s, e) { ASPxClientEdit.ClearGroup('entryGroup'); tbLogin.Focus(); }" />
            <ContentCollection>
                <dx:PopupControlContentControl runat="server">

                    <dx:ASPxFormLayout runat="server" ID="formLayout" CssClass="formLayout">
                        <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="980" />
                        <Items>
                            <dx:LayoutItem ShowCaption="False" HorizontalAlign="left">
                                <Paddings PaddingTop="10" />
                                <Paddings PaddingBottom="10" />
                                <NestedControlCellStyle CssClass="maxWidth"></NestedControlCellStyle>
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer>
                                       <h4> We will email your password to this address.</h4>
                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>
                            <dx:LayoutItem Caption="Email Address">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer>
                                        <dx:ASPxTextBox runat="server" ID="tbx_EmailAddress">
                                            <ValidationSettings ErrorDisplayMode="Text" Display="Dynamic" ErrorTextPosition="Bottom" SetFocusOnError="true">
                                                <ErrorFrameStyle Wrap="True" />
                                                <RegularExpression ErrorText="Invalid e-mail" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" />
                                                <RequiredField IsRequired="True" ErrorText="The value is required" />
                                            </ValidationSettings>
                                        </dx:ASPxTextBox>
                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>
                             
                            <dx:LayoutItem ShowCaption="False" HorizontalAlign="Right" Width="100%">
                                 <Paddings PaddingTop="20" />
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer>
                                        <table>
                                            <tr>
                                                <td style="padding-right: 10px">
                                                    <dx:ASPxButton ID="btnRecoverPassword" runat="server" Text="Send Password" Width="100" OnClick="btnRecoverPassword_Click">
                                                         <ClientSideEvents Click="function(s, e) { HideRecoverPwdWindow(); }" />                                                        
                                                    </dx:ASPxButton>
                                                </td>
                                                <td>
                                                    <dx:ASPxHyperLink runat="server" ID="linkCancel" Text="Cancel" >
                                                         <ClientSideEvents Click="function(s, e) { HideRecoverPwdWindow(); }" />

                                                    </dx:ASPxHyperLink>
                                                </td>
                                            </tr>
                                        </table>
                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>
                        </Items>
                    </dx:ASPxFormLayout>
                    

                </dx:PopupControlContentControl>
            </ContentCollection>
            <ContentStyle>
                <Paddings PaddingBottom="5px" />
            </ContentStyle>
        </dx:ASPxPopupControl>
    </form>
</body>
</html>
