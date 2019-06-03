<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WhatToDoCancelled.aspx.cs" Inherits="SubcontractorPortal.MakeSafe.WhatToDoCancelled" %>

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
        <asp:SqlDataSource ID="SQLVariations" runat="server" ConnectionString="<%$ ConnectionStrings:DataConnectionString %>" SelectCommand="Subcontractor_Get_Variations_By_OrderID" SelectCommandType="StoredProcedure" InsertCommand="Subcontractor_Create_Variation" InsertCommandType="StoredProcedure">
            <InsertParameters>
                
                <asp:CookieParameter CookieName="WOID" Name="Insurance_WorkOrderMain_Id" Type="Int32" />
                <asp:Parameter Name="details_and_Circumstances" Type="String" />
                <asp:CookieParameter CookieName="SubbyID" Name="SubcontractorID" Type="Int32" />                
            </InsertParameters>
            <SelectParameters>
                <asp:QueryStringParameter Name="OrderID" QueryStringField="OID" Type="Int32" />
                <asp:CookieParameter CookieName="SubbyID" Name="SubcontractorID" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>

        <asp:SqlDataSource ID="SQLItems" runat="server" ConnectionString="<%$ ConnectionStrings:DataConnectionString %>" SelectCommand="Subcontractor_Get_Items_For_Variation" SelectCommandType="StoredProcedure" InsertCommandType="StoredProcedure" InsertCommand="Subcontractor_Variation_Item_Insert" UpdateCommand="Subcontractor_Variation_Item_Update" UpdateCommandType="StoredProcedure" DeleteCommand="Subcontractor_Delete_Variation_Item" DeleteCommandType="StoredProcedure">
            <DeleteParameters>
                <asp:Parameter Name="Insurance_Estimator_Item_id" />
            </DeleteParameters>
            <InsertParameters>
                <asp:QueryStringParameter DefaultValue="" Name="Insurance_Quote_id" QueryStringField="quoteID" Type="Int32" />
                <asp:Parameter Name="room_id" Type="Int32" />                
                <asp:Parameter Name="long_desc" Type="String" />
                <asp:Parameter Name="l_unit" Type="Int32" />
                <asp:Parameter Name="m_unit" Type="Int32" />
                <asp:Parameter Name="l_quantity" Type="Decimal" />
                <asp:Parameter Name="m_quantity" Type="Decimal" />
                <asp:Parameter Name="l_rate" Type="Decimal" />
                <asp:Parameter Name="m_rate" Type="Decimal" />
                <asp:CookieParameter CookieName="Username" DefaultValue="" Name="created_by" Type="String" />
                <asp:Parameter Name="Insurance_Trade_Id" Type="Int32" />
            </InsertParameters>
            <SelectParameters>
                <asp:QueryStringParameter Name="Insurance_Quote_id" QueryStringField="quoteID" Type="Int32" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="Insurance_Estimator_Item_Id" Type="Int32" />
                <asp:Parameter Name="room_id" Type="Int32" />
                <asp:Parameter Name="long_desc" Type="String" />
                <asp:Parameter Name="l_unit" Type="Int32" />
                <asp:Parameter Name="m_unit" Type="Int32" />
                <asp:Parameter Name="l_quantity" Type="Decimal" />
                <asp:Parameter Name="m_quantity" Type="Decimal" />
                <asp:Parameter Name="l_rate" Type="Decimal" />
                <asp:Parameter Name="m_rate" Type="Decimal" />
                <asp:Parameter Name="created_by" Type="String" />
                <asp:Parameter Name="Insurance_Trade_Id" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlUnit" runat="server" 
            ConnectionString="<%$ ConnectionStrings:DataConnectionString %>" 
            SelectCommand="SELECT [Insurance_Unit_ID], [Name] FROM [Insurance_Unit] WITH (NOLOCK) ORDER BY [Name]">
        </asp:SqlDataSource>

        <asp:SqlDataSource ID="SqlTrade" runat="server" 
            ConnectionString="<%$ ConnectionStrings:DataConnectionString %>" 
            DataSourceMode="DataReader" 
            SelectCommand="SELECT [Insurance_Trade_ID], [Trade_Name] FROM [Insurance_Trade] WITH (NOLOCK) ORDER BY [Trade_Name]">
        </asp:SqlDataSource>


        <asp:SqlDataSource ID="SqlRoom" runat="server" 
            ConnectionString="<%$ ConnectionStrings:DataConnectionString %>" 
            DataSourceMode="DataReader" 
            SelectCommand="SELECT [Insurance_Room_Id],[name]  FROM [Insurance_Room]  WITH (NOLOCK) ORDER BY [name]">
        </asp:SqlDataSource>

    </form>
 </body>
</html>
