<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WhatToDoProgress.aspx.cs" Inherits="SubcontractorPortal.MakeSafe.WhatToDoProgress" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <link href="/Styles/WO.css" rel="stylesheet" type="text/css" />
    
    <script type="text/javascript">
        function CheckReason() {
            var reason = ChangeDateReason.GetText();
            if (reason == null || reason == '') {
                alert('Please provide reason for dates change');
            } else {
                if (confirm('Do you really want to change dates for this Work Order?')) {
                    SetActionWO("1");
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
                    SetActionWO("4");
                    SaveDoc();
                }
            }
        }


        function CheckVariation() {
            var reason = VariationReason.GetText();
            if (reason == null || reason == '') {
                alert('Please provide reason for this Variation');
            } else {
                SetActionWO("2");
                VarGrid.UpdateEdit();
            }
        }

        function SaveDoc() {
            var theForm = document.forms['form1'];
            if (!theForm) {
                theForm = document.form1;
            }
            theForm.submit();
        }
        function SetActionWO(Param) {
            document.getElementById("ActionWO").value = Param;
        }

        function OnValueChanged(s, e) {
            Page_ClientValidate("");
        }

        function validateDates(s, e) {
            var date1 = e1.GetDate();
            var date2 = e2.GetDate();
            e.IsValid = date1 == null || date2 == null || date1 <= date2;
            //alert(e.IsValid);
        }

    </script>

</head>
<body>
    <script type="text/javascript">
        function SetupItems(quoteID, rowIndex) {
            window.location.replace('whattodoprogress.aspx?p=1&rowIndex=' + rowIndex + '&quoteID=' + quoteID + '<%=URL%>');
        }
        function Navigate(Parameter) {
            window.location.replace('whattodoprogress.aspx?p=' + Parameter + '<%=URL2%>');
        }
        function SendVariation2() {
            if (confirm("Do you really want to send this Variation to Supervisor?")) {
                window.location.replace('whattodoprogress.aspx?sendVariation=<%=quoteID%><%=URL%>');
            }
        }
        function CompleteWO() {
            if (confirm("Supervisor will be notified that you have requested to Compelete Work Order.\n This Work Order will be moved to 'Complete Request' status")) {
                //window.location.replace('whattodoprogress.aspx?complete=1<%=URL%>');
                SetActionWO("3");
                SaveDoc();

            }
        }
        function SendVariation() {

            if (confirm("Supervisor will be notified that you have requested Variation to Work Order.\n\nAttention! Do not proceed with requested work until Supervisor approves it.\n\nVariation will be locked for changes.")) {
                SetActionWO("2");
                SaveDoc();
            }
        }

    </script>
    <form id="form1" runat="server">
        <script type="text/javascript"><%=UpdateAudit%></script>
        <input id="ActionWO" name="ActionWO" type="hidden" value="0" />
    <center>
        <table cellpadding="5" cellspacing="5">
            <tr>
                <td class="status"><%=OrderType%> WO Status:&nbsp;<dx:aspxlabel runat="server" text="" id="WOStatusLbl" CssClass="status"></dx:aspxlabel>
                    </td>
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
        <dx:ASPxPageControl ID="ASPxPageControl1" runat="server" ActiveTabIndex="1" Width="950px" Theme="Office2003Blue">
            <TabPages>
                <dx:TabPage Text="Request to Change Work Order Dates">
                    <ContentCollection>
                        <dx:ContentControl ID="ContentControl1" runat="server" SupportsDisabledAttribute="True">
                            
                            <table cellpadding="5" cellspacing="5">
                                <tr>
                                    <td colspan="2"><b>Please send your request for Work Order dates change to Maincom.</b>                                        
                                    </td>
                                </tr>
                                <tr>                                    
                                    <th align="left">N.B. Dates on Work Order will be changed only after Maincom approval.</th>                                    
                                </tr>

                                <!--
                                <tr>                                    
                                    
                                    <td>Insured:&nbsp;<asp:Label ID="InsuredLbl" runat="server" Text=""></asp:Label></td>
                                    <td align="left" colspan="2">Contact info:&nbsp;<asp:Label ID="ContactOnLbl" runat="server" Text=""></asp:Label></td>
                                </tr>
                                -->
                            </table>

                            <table cellpadding="5" cellspacing="5">
                                <tr>                                    
                                    <th align="left">Please provide reason for changing dates for this Work Order:</th>                                    
                                </tr>
                                <tr>
                                    <td>
                                        <dx:ASPxMemo ID="ChangeDateReason" runat="server" Height="90px" Width="800px" ClientInstanceName="ChangeDateReason" ClientIDMode="Static"></dx:ASPxMemo>
                                    </td>

                                </tr>
                            </table>

                            <table cellpadding="5" cellspacing="5">
                                <tr>                                    
                                    
                                    <td ><b>Work on site will be undergoing on these dates (requested date change):</b></td>
                                    <td align="right">Start Date</td>
                                    <td align="left">
                                        <dx:ASPxDateEdit ID="WOStart" runat="server" HorizontalAlign="Left" Width="100px" ClientInstanceName="e1">
                                               <ClientSideEvents ValueChanged="OnValueChanged" />
                                        </dx:ASPxDateEdit>
                                    </td>
                                    <td align="right">End Date</td>
                                    <td align="left">
                                        <dx:ASPxDateEdit ID="WOFinish" runat="server" HorizontalAlign="Left" Width="100px" ClientInstanceName="e2">
                                               <ClientSideEvents ValueChanged="OnValueChanged" />
                                        </dx:ASPxDateEdit>
                                    </td>
                                </tr>
                                <!--
                                <tr>
                                    
                                    <td colspan="5">Change dates start or end dates if required. Your Supervisor will be notified.</td>
                                </tr>
                                -->
                               </table>
                            <table cellpadding="5" cellspacing="5">
                                <tr>                                
                                    
                                    <td>
                                        <dx:ASPxButton ID="AcceptBtn" runat="server" Text="Send Request to Maincom" AutoPostBack="False" UseSubmitBehavior="False" ClientInstanceName="AcceptBtn" EnableClientSideAPI="True">
                                            <ClientSideEvents 
                                                Click="function(s, e) {
	CheckReason();
}" />
                                            <Image Height="20px" Url="~/Images/accept.png" Width="20px">
                                            </Image>
                                        </dx:ASPxButton>

                                    </td>  
                                    <td>                                        
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Work Start Date Is Required! " ControlToValidate="WOStart"  Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Work End Date Is Required! " ControlToValidate="WOFinish"  Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                        <asp:CustomValidator ID="CustomValidator1" runat="server" ClientValidationFunction="validateDates" ErrorMessage="Work Order Date Range is Incorrect!" Display="Dynamic" ForeColor="Red"></asp:CustomValidator>
                                    </td>                                  
                                </tr>
                            </table>
                        </dx:ContentControl>
                    </ContentCollection>
                </dx:TabPage>
                <dx:TabPage Text="Complete Work Order">
                    <ContentCollection>
                        <dx:ContentControl ID="ContentControl4" runat="server" SupportsDisabledAttribute="True">
                            <table cellpadding="5" cellspacing="5">
                                <tr>
                                    <th></th>
                                    <th>Click on "Complete Work Order" button to notify Supervisor.</th>
                                    <th></th>
                                </tr>
                            </table>

                            <table cellpadding="5" cellspacing="5">
                                <tr>
                                    <td>Upon completion of Work Order you must provide the following documents to Maincom:</td>
                                </tr>
                                <tr>
                                    <td>1. Completion Certificate Signed Off by Customer</td>
                                </tr>
                                <tr>
                                    <td>2. Signed Subcontractor Risk Assessment</td>
                                </tr>
                                <tr>
                                    <td>3. Compliance certification (If Required)</td>
                                </tr>
                                <tr>
                                    <td>4. Invoice with address/search code of this Work Order.</td>
                                </tr>

                            </table>

                            <table cellpadding="5" cellspacing="5">
                                <tr>                                
                                    
                                    <td>
                                        <dx:ASPxButton ID="ASPxButton3" runat="server" Text="Complete Work Order" AutoPostBack="False" UseSubmitBehavior="False" ClientInstanceName="CompleteWOBtn" EnableClientSideAPI="True">
                                            <ClientSideEvents 
                                                Click="function(s, e) {
	CompleteWO();
}" />
                                            <Image Height="20px" Url="~/Images/accept.png" Width="20px">
                                            </Image>
                                        </dx:ASPxButton>

                                    </td>  
                                    <td>                                        
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Work Start Date Is Required! " ControlToValidate="WOStart"  Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="Work End Date Is Required! " ControlToValidate="WOFinish"  Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                        <asp:CustomValidator ID="CustomValidator2" runat="server" ClientValidationFunction="validateDates" ErrorMessage="Work Order Date Range is Incorrect!" Display="Dynamic" ForeColor="Red"></asp:CustomValidator>
                                    </td>                                  
                                </tr>
                            </table>


                        </dx:ContentControl>
                    </ContentCollection>
                </dx:TabPage>

                <dx:TabPage Text="Message Maincom">
                    <ContentCollection>
                        <dx:ContentControl ID="ContentControl3" runat="server" SupportsDisabledAttribute="True">
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
