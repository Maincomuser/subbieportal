<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WhatToDo.aspx.cs" Inherits="SubcontractorPortal.WOrders.WhatToDo" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="/Styles/WO.css" rel="stylesheet" type="text/css" />

</head>
<body>

    <script type="text/javascript">
        function CheckReason() {
            var reason = DeclineReason.GetText();
            if (reason == null || reason == '') {
                alert('Please provide reason for decline');
            } else {
                if (confirm('Do you really want to Decline this Work Order?')) {                    
                    SetAcceptWO("0");
                    SaveDoc();
                    
                }
            }
        }

        function CheckMessage() {
            var reason = Message.GetText();
            if (reason == null || reason == '') {
                alert('Please provide message text');
            } else {
                if (confirm('Do you really want to Send this message to Maincom?')) {                    
                    SetAcceptWO("2");
                    SaveDoc();                    
                }
            }
        }

        function SaveDoc() {
            var theForm = document.forms['form1'];
            if (!theForm) {
                theForm = document.form1;
            }
            theForm.submit();
        }
        function SetAcceptWO(Param) {
            document.getElementById("AcceptWO").value = Param;
        }

        function OnValueChanged(s, e) {
            Page_ClientValidate("");
        }

        function validateDates(s, e) {
            var date1 = e1.GetDate();
            var date2 = e2.GetDate();
            e.IsValid = date1 == null || date2 == null || date1 <= date2;
        }

    </script>

    <form id="form1" runat="server">
        <script type="text/javascript"><%=UpdateAudit%></script>
        <input id="AcceptWO" name="AcceptWO" type="hidden" value="1" />
        <asp:HiddenField ID="WOAddress" runat="server" />
    <center>
        <table cellpadding="5" cellspacing="5">
            <tr>
                <td class="status">Work Order Status: <%=WOStatus %></td>
            </tr>
            <tr>
                <td class="status"><dx:aspxlabel runat="server" text="" id="WODetail" CssClass="status"></dx:aspxlabel>
                    </td>
            </tr>
            <tr>
                <td class="status"><dx:aspxlabel runat="server" text="" id="InsuranceDetail" CssClass="status"></dx:aspxlabel>
                    </td>
            </tr>

        </table>
        <asp:Label ID="DeclineLbl" runat="server" Text="" CssClass="decline"></asp:Label>
        <asp:Label ID="AcceptLbl" runat="server" Text="" CssClass="accept"></asp:Label>

        <asp:Panel ID="Panel1" runat="server">
        <dx:ASPxPageControl ID="ASPxPageControl1" runat="server" ActiveTabIndex="0" Width="850px" Theme="Office2003Blue">
            <TabPages>
                <dx:TabPage Text="Accept Work Order">
                    <ContentCollection>
                        <dx:ContentControl runat="server" SupportsDisabledAttribute="True">
                            <table cellpadding="5" cellspacing="5">
                                <tr>
                                    <th></th>
                                    <th>By accepting this work order you confirm that:</th>
                                    <th></th>
                                </tr>
                            </table>
                            <table cellpadding="5" cellspacing="5">
                                <tr>
                                    <td>1.</td>
                                    <td><b>You have called Insured on </b>
                                        
                                    </td>
                                    <td >
                                        <dx:ASPxDateEdit ID="CalledInsured" runat="server" HorizontalAlign="Left"  Width="100"></dx:ASPxDateEdit>
                                    </td>
                                    <td align="left"><b>and have arranged your work dates on site.</b>
                                    </td>
                                </tr>
                                <tr>                                    
                                    <td>&nbsp;</td>
                                    <td>Insured:&nbsp;<%=Insured %></td>
                                    <td align="left" colspan="2">Contact info:&nbsp;<%=ContactOn %></td>
                                </tr>
                            </table>

                            <table cellpadding="5" cellspacing="5">
                                <tr>
                                    
                                    <td>2.</td>
                                    <td><b>You agree to sign Subcontractor WHS Statement</b></td>
                                    <td></td>
                                </tr>
                            </table>
                            <table cellpadding="5" cellspacing="5">
                                <tr>
                                    
                                    <td>3.</td>
                                    <td ><b>Work on site will be undergoing on these dates:</b></td>
                                    <td align="right">Start Date</td>
                                    <td align="left">
                                        <dx:ASPxDateEdit ID="WOStart" runat="server" HorizontalAlign="Left" Width="100" ClientInstanceName="e1">
                                               <ClientSideEvents ValueChanged="OnValueChanged" />
                                        </dx:ASPxDateEdit>
                                    </td>
                                    <td align="right">End Date</td>
                                    <td align="left">
                                        <dx:ASPxDateEdit ID="WOFinish" runat="server" HorizontalAlign="Left" Width="100" ClientInstanceName="e2">
                                               <ClientSideEvents ValueChanged="OnValueChanged" />
                                        </dx:ASPxDateEdit>
                                    </td>
                                </tr>
                                <tr>
                                    <td>&nbsp;</td>
                                    <td colspan="5">(Change dates start or end dates if required)</td>
                                </tr>
                               </table>
                            <table cellpadding="5" cellspacing="5">
                                <tr>                                
                                    <td>&nbsp;</td>
                                    <td>
                                        <dx:ASPxButton ID="AcceptBtn" runat="server" Text="Accept Work Order" UseSubmitBehavior="False" AutoPostBack="True">
                                            <ClientSideEvents CheckedChanged="function(s, e) {	SetAcceptWO('1');}" />
                                            <Image Height="20px" Url="~/Images/accept.png" Width="20px">
                                            </Image>
                                        </dx:ASPxButton>

                                    </td>  
                                    <td>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Called Insured Date Is Required! " ControlToValidate="CalledInsured"  Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Work Start Date Is Required! " ControlToValidate="WOStart"  Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Work End Date Is Required! " ControlToValidate="WOFinish"  Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                        <asp:CustomValidator ID="CustomValidator1" runat="server" ClientValidationFunction="validateDates" ErrorMessage="Work Order Date Range is Incorrect!" Display="Dynamic" ForeColor="Red"></asp:CustomValidator>
                                    </td>                                  
                                </tr>
                            </table>
                        </dx:ContentControl>
                    </ContentCollection>
                </dx:TabPage>
                <dx:TabPage Text="Decline Work Order">
                    <ContentCollection>
                        <dx:ContentControl runat="server" SupportsDisabledAttribute="True">
                            <table cellpadding="5" cellspacing="5">
                                <tr>                                    
                                    <th>Please provide reason for declining this Work Order:</th>                                    
                                </tr>
                                <tr>
                                    <td>
                                        <dx:ASPxMemo ID="DeclineReason" runat="server" Height="90px" Width="800px" ClientInstanceName="DeclineReason" ClientIDMode="Static"></dx:ASPxMemo>
                                    </td>

                                </tr>
                            </table>
                            <table cellpadding="5" cellspacing="5">
                                <tr>                                
                                    
                                    <td>
                                        <dx:ASPxButton ID="DeclineBtn" runat="server" Text="Decline Work Order" AutoPostBack="False" CausesValidation="False">
                                            <ClientSideEvents Click="function(s, e) {
	CheckReason();
}" />
                                            <Image Height="20px" Url="~/Images/decline.png" Width="20px">
                                            </Image>
                                        </dx:ASPxButton>
                                        

                                    </td>                                    
                                </tr>
                            </table>

                        </dx:ContentControl>
                    </ContentCollection>
                </dx:TabPage>
                <dx:TabPage Text="Message Maincom">
                    <ContentCollection>
                        <dx:ContentControl ID="ContentControl1" runat="server" SupportsDisabledAttribute="True">
                            <table cellpadding="5" cellspacing="5">
                                <tr>                                    
                                    <th>Please leave your message to Maincom here:</th>                                    
                                </tr>
                                <tr>
                                    <td>
                                        <dx:ASPxMemo ID="Message" runat="server" Height="90px" Width="800px" ClientInstanceName="Message" ClientIDMode="Static"></dx:ASPxMemo>
                                    </td>

                                </tr>
                            </table>
                            <table cellpadding="5" cellspacing="5">
                                <tr>                                
                                    
                                    <td>
                                        <dx:ASPxButton ID="MessageBtn" runat="server" Text="Send Message" AutoPostBack="False" CausesValidation="False">
                                            <ClientSideEvents Click="function(s, e) {
	CheckMessage();
}" />
                                            <Image Height="20px" Url="~/Images/mail.png" Width="20px">
                                            </Image>
                                        </dx:ASPxButton>
                                        

                                    </td>                                    
                                </tr>
                            </table>

                        </dx:ContentControl>
                    </ContentCollection>
                </dx:TabPage>


            </TabPages>
        </dx:ASPxPageControl>
        </asp:Panel>
        
    </center>
    </form>
</body>
</html>
