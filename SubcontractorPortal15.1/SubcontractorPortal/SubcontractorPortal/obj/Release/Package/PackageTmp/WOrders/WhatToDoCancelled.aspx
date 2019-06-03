<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WhatToDoCancelled.aspx.cs" Inherits="SubcontractorPortal.WOrders.WhatToDoCancelled" %>

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
                <td class="status">Work Order Status:&nbsp;<dx:aspxlabel runat="server" text="" id="WOStatusLbl" CssClass="status"></dx:aspxlabel>
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
                <dx:TabPage Text="Request Variation">
                    <ContentCollection>
                        <dx:ContentControl ID="ContentControl2" runat="server" SupportsDisabledAttribute="True">

                        <asp:Panel ID="PanelVariations" runat="server">
                            <dx:ASPxButton ID="AddVarBtn" runat="server" Text="Create Variation" EnableClientSideAPI="True" UseSubmitBehavior="False" AutoPostBack="False" Image-Url="~/Images/add.png" Image-Height="14" Image-Width="14">
                                <ClientSideEvents Click="function(s, e) {VarGrid.AddNewRow();}" />
                                <Image Height="14px" Url="~/Images/add.png" Width="14px">
                                </Image>
                            </dx:ASPxButton>
                            <dx:ASPxGridView ID="ASPxGridViewVariations" runat="server" AutoGenerateColumns="False" DataSourceID="SQLVariations" KeyFieldName="Insurance_Quote_id" Width="100%" Caption="&lt;b&gt;Variations Requested by Subcontractor &lt;/b&gt;(click on variation to add items)" ClientInstanceName="VarGrid"
                                OnRowInserting="grid_RowInserting"
                                SettingsBehavior-AllowSelectByRowClick="True" SettingsBehavior-AllowSelectSingleRowOnly="True">
                                

                                <ClientSideEvents RowClick="function(s, e) {
                                    
                                    var quoteID = s.GetRowKey(e.visibleIndex);  
                                    var rowIndex = e.visibleIndex;                                    
                                    SetupItems(quoteID, rowIndex);   
	                                
}" />
                                
                                <Columns>
                                     <dx:GridViewDataTextColumn FieldName="Insurance_Quote_id" ReadOnly="True" 
                                         Visible="False" VisibleIndex="0" >
                                        <EditFormSettings Visible="False" />
                                    </dx:GridViewDataTextColumn>

                                    <dx:GridViewDataTextColumn Caption="Sent" FieldName="SubbySent"  VisibleIndex="2" Width="100px">
                                        <CellStyle HorizontalAlign="Left">
                                        </CellStyle>
                                    </dx:GridViewDataTextColumn>
                                     <dx:GridViewDataTextColumn Caption="Reason for Variation" FieldName="details_and_Circumstances" ShowInCustomizationForm="True" VisibleIndex="3">
                                         <CellStyle HorizontalAlign="Left">
                                         </CellStyle>
                                     </dx:GridViewDataTextColumn>
                                     <dx:GridViewDataDateColumn Caption="Created" FieldName="create_date" ShowInCustomizationForm="True" VisibleIndex="1" Width="100px">
                                         <CellStyle HorizontalAlign="Left">
                                         </CellStyle>
                                     </dx:GridViewDataDateColumn>
                                     <dx:GridViewDataTextColumn Caption="Status" FieldName="Status" ShowInCustomizationForm="True" VisibleIndex="4">
                                         <CellStyle HorizontalAlign="Left">
                                         </CellStyle>
                                     </dx:GridViewDataTextColumn>
                                </Columns>
                                <SettingsBehavior AllowSelectByRowClick="True" AllowSelectSingleRowOnly="True" AllowFocusedRow="True"  />

                                <SettingsPager Mode="ShowAllRecords" Visible="False">
                                </SettingsPager>
                                <SettingsEditing Mode="EditForm" />
                                <Templates>
                                    <EditForm>
                                        <table cellpadding="5" cellspacing="5" style="border: solid 1px #000000;">
                                            <tr>                                    
                                                <th align="left">Please provide reason for Variation Request:</th>                                    
                                            </tr>
                                            <tr>
                                                <td>
                                                    <dx:ASPxMemo ID="VariationReason" runat="server" Height="30px" Width="800px" ClientInstanceName="VariationReason" ClientIDMode="Static" Text='<%# Eval("details_and_Circumstances") %>'></dx:ASPxMemo>
                                                </td>

                                            </tr>
                                            <tr>
                                                <td>
                                                    <table>
                                                        <tr>
                                                            <td>
                                                                <dx:ASPxButton ID="ASPxButton1" runat="server" Text="Create Variation"  AutoPostBack="False" Image-Url="~/Images/save.png" Image-Height="14px" Image-Width="14px">
                                                                    <ClientSideEvents Click="function(s, e) { 
                                                                        CheckVariation();                                                                        
                                                                        
                                                                        }" />
                                                                </dx:ASPxButton>                      
                                                            </td>
                                                            <td>
                                                                <dx:ASPxButton ID="ASPxButton2" runat="server" Text="Cancel" AutoPostBack="False" ClientSideEvents-Click="function(s, e) { VarGrid.CancelEdit(); }" UseSubmitBehavior="False">
                                                                </dx:ASPxButton>                            
                                                            </td>
                                                        </tr>
                                                    </table>


                                                </td>
                                            </tr>                    

                                        </table>
                                        
                                    </EditForm>
                                </Templates>
                            </dx:ASPxGridView>
                            <br />
                        </asp:Panel>
            <asp:Panel ID="PanelItemsNavigation" runat="server">
                            <table width="100%" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td width="150">
                           <dx:ASPxButton ID="AddItemBtn" runat="server" Text="Add Variation Item" EnableClientSideAPI="True" UseSubmitBehavior="False" AutoPostBack="False" Image-Url="~/Images/add.png" Image-Height="14" Image-Width="14">
                                <ClientSideEvents Click="function(s, e) {itemsGrid.AddNewRow();}" />
                                <Image Height="14px" Url="~/Images/add.png" Width="14px">
                                </Image>
                            </dx:ASPxButton>
                           <dx:ASPxButton ID="GotoItemsBtn" runat="server" Text="Show Variation Items" EnableClientSideAPI="True" UseSubmitBehavior="False" AutoPostBack="False" >
                                <ClientSideEvents Click="function(s, e) {Navigate(1);}" />
                                
                                
                            </dx:ASPxButton>

                                    </td>
                                    <td width="130">
                           <dx:ASPxButton ID="PhotosBtn" runat="server" Text="Attach Photos" EnableClientSideAPI="True" UseSubmitBehavior="False" AutoPostBack="False" Image-Url="~/Images/camera.png" Image-Height="14" Image-Width="14">
                                <ClientSideEvents Click="function(s, e) {Navigate(2);}" />
                                <Image Height="14px" Url="~/Images/camera.png" Width="14px">
                                </Image>
                            </dx:ASPxButton>

                                    </td>
                                    <td align="left">
                                    <dx:ASPxButton ID="AddItemCancel" runat="server" Text="Hide Variation Items" AutoPostBack="False" ClientSideEvents-Click="function(s, e) { BackToVariations(); }" UseSubmitBehavior="False" Image-Url="~/Images/hide.png" Image-Height="14" Image-Width="14">
                                        <ClientSideEvents Click="function(s, e) { Navigate(0); }" />
                                <Image Height="14px" Url="~/Images/hide.png" Width="14px">
                                </Image>

                                    </dx:ASPxButton>                            


                                    </td>
                                    <td align="right">
                           <dx:ASPxButton ID="EmailBtn" runat="server" Text="Send To Supervisor" EnableClientSideAPI="True" UseSubmitBehavior="False" AutoPostBack="False" Image-Url="~/Images/mail.png" Image-Height="14" Image-Width="14">
                                <ClientSideEvents Click="function(s, e) {SendVariation();}" />
                                <Image Height="14px" Url="~/Images/mail.png" Width="14px">
                                </Image>
                            </dx:ASPxButton>

                                    </td>
                                </tr>
                            </table>
                </asp:Panel>
                <asp:Panel ID="PanelVariationItems" runat="server">
                            <dx:ASPxGridView ID="ASPxGridViewItems" runat="server" AutoGenerateColumns="False"  DataSourceID="SQLItems" KeyFieldName="Insurance_Estimator_Item_Id" Width="100%" SettingsEditing-Mode="EditForm" Settings-GridLines="Both" ClientInstanceName="itemsGrid" OnRowInserting="ASPxGridViewItems_RowInserting"  SettingsBehavior-AllowSelectByRowClick="True" SettingsBehavior-AllowSelectSingleRowOnly="True" OnRowUpdating="ASPxGridViewItems_RowUpdating">
                                <Columns>
                                    <dx:GridViewCommandColumn Caption="Options" ShowInCustomizationForm="True" VisibleIndex="1" Width="20px">
                                    </dx:GridViewCommandColumn>
                                    <dx:GridViewDataTextColumn FieldName="Insurance_Estimator_Item_Id" ReadOnly="True" ShowInCustomizationForm="True" Visible="False" VisibleIndex="0">
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn FieldName="Room" ShowInCustomizationForm="True" VisibleIndex="2" Width="150px">
                                        <CellStyle HorizontalAlign="Left">
                                        </CellStyle>
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn FieldName="Item" ShowInCustomizationForm="True" VisibleIndex="3">
                                        <CellStyle HorizontalAlign="Left">
                                        </CellStyle>
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn  FieldName="LabourTotal" ShowInCustomizationForm="True" VisibleIndex="6" Width="50px" Caption="Labour" CellStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right">
                                        <HeaderStyle HorizontalAlign="Right" />
                                        <CellStyle HorizontalAlign="Right">
                                        </CellStyle>
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn FieldName="MaterialTotal" ShowInCustomizationForm="True" VisibleIndex="10" Width="50px"  Caption="Material" CellStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right">
                                        <HeaderStyle HorizontalAlign="Right" />
                                        <CellStyle HorizontalAlign="Right">
                                        </CellStyle>
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn FieldName="cost_total" ShowInCustomizationForm="True" VisibleIndex="10" Width="50px"  Caption="Total" CellStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right">
                                        <HeaderStyle HorizontalAlign="Right" />
                                        <CellStyle HorizontalAlign="Right">
                                        </CellStyle>
                                    </dx:GridViewDataTextColumn>

                                     <dx:GridViewDataTextColumn FieldName="room_id" 
                                         Visible="false" >
                                        <EditFormSettings Visible="False" />
                                    </dx:GridViewDataTextColumn>

                                     <dx:GridViewDataTextColumn FieldName="Insurance_Trade_ID" 
                                         Visible="false" >
                                        <EditFormSettings Visible="False" />
                                    </dx:GridViewDataTextColumn>

                                     <dx:GridViewDataTextColumn FieldName="long_desc" 
                                         Visible="false" >
                                        <EditFormSettings Visible="False" />
                                    </dx:GridViewDataTextColumn>


                                </Columns>
                                 <Settings ShowFooter="True" />
                                <TotalSummary>
                                    <dx:ASPxSummaryItem FieldName="cost_total" SummaryType="Sum" DisplayFormat="{0}" />
                                </TotalSummary>

                                <SettingsBehavior AllowSelectByRowClick="True" AllowSelectSingleRowOnly="True" ConfirmDelete="True"  />

                                <SettingsPager Mode="ShowAllRecords" Visible="False">
                                </SettingsPager>
                                <SettingsEditing Mode="EditForm" />
                                <SettingsText ConfirmDelete="Do you really want to delete this item?" />  
                                <Templates>
                                    <EditForm>
                                        <table cellpadding="3" cellspacing="3" style="border: solid 1px #000000; width:100%;">
                                            <tr>
                                                <td>
                                                    <table>
                                                        <tr>                                    
                                                            <th align="left">Room</th>                                    
                                                            <th align="left">Trade</th>                                    
                                                            <th align="left">&nbsp;</th>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <dx:ASPxComboBox ID="cRoom" runat="server" DataSourceID="SqlRoom" 
                                                                    TextField="name" ValueField="Insurance_Room_Id" Text='<%# Eval("room_id") %>' IncrementalFilteringMode="StartsWith" ClientInstanceName="cRoom">
                                                                    <ValidationSettings CausesValidation="True" ErrorDisplayMode="ImageWithTooltip">
                                                                        <RequiredField IsRequired="True" />
                                                                    </ValidationSettings>
                                                                </dx:ASPxComboBox>
                                                                                                                               
                                                            </td>
                                                            <td>
                                                                <dx:ASPxComboBox ID="cTrade" runat="server" DataSourceID="SqlTrade" 
                                                                    TextField="Trade_Name" ValueField="Insurance_Trade_ID" Text='<%# Eval("Insurance_Trade_ID") %>' IncrementalFilteringMode="StartsWith" ClientInstanceName="cTrade">
                                                                    <ValidationSettings CausesValidation="True" ErrorDisplayMode="ImageWithTooltip">
                                                                        <RequiredField IsRequired="True" />
                                                                    </ValidationSettings>

                                                                </dx:ASPxComboBox>
                                                            </td>
                                                            <td align="center">
                                                                All fields must be populated, even containing zero's
                                                            </td>
                                                        </tr>

                                                    </table>

                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <table width="100%">
                                                        <tr><th align="left">Item Decsription</th></tr>
                                                        <tr>
                                                            <td>
                                                                <dx:ASPxMemo ID="clong_desc" runat="server" Height="50px" Width="100%" Text='<%# Eval("long_desc")%>' ClientInstanceName="clong_desc" Enabled="True" ReadOnly="False">
                                                                    <ValidationSettings CausesValidation="True" ErrorDisplayMode="ImageWithTooltip">
                                                                        <RequiredField IsRequired="True" />
                                                                    </ValidationSettings>
                                                                </dx:ASPxMemo>
                                                            </td>
                                                        </tr>


                                                    </table>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <table width="50%" cellpadding="5" cellspacing="5" style="border:solid 1px #AECAF0;">
                                                        <tr><th align="left" colspan="3">Material</th><th align="left" colspan="3">Labour</th></tr>
                                                        
                                                        <tr><th align="left">Quantity</th><th align="center">Unit</th><th align="left">Rate</th> <th align="left">Quantity</th><th align="center">Unit</th><th align="left">Rate</th></tr>
                                                        <tr>
                                                            <td>
                                                                <dx:ASPxSpinEdit ID="cm_quantity" runat="server" Height="21px" Number="0" Width="50px" Text='<%# Eval("m_quantity") %>'  ClientInstanceName="cm_quantity">
                                                                    <SpinButtons ShowIncrementButtons="false" />
                                                                    <ValidationSettings CausesValidation="True" ErrorDisplayMode="ImageWithTooltip">
                                                                        <RequiredField IsRequired="True" />
                                                                    </ValidationSettings>
                                                                </dx:ASPxSpinEdit>
                                                            </td>
                                                            <td>
                                                                <dx:ASPxComboBox ID="cm_unit" runat="server" DataSourceID="SqlUnit" 
                                                                    TextField="name" ValueField="Insurance_Unit_ID" Text='<%# Eval("m_unit") %>' IncrementalFilteringMode="StartsWith" ClientInstanceName="cm_unit">
                                                                    <ValidationSettings CausesValidation="True" ErrorDisplayMode="ImageWithTooltip">
                                                                        <RequiredField IsRequired="True" />
                                                                    </ValidationSettings>
                                                                </dx:ASPxComboBox>
                                                            </td>
                                                            <td>
                                                                
                                                                <dx:ASPxSpinEdit ID="cm_rate" runat="server" Height="21px" Number="0" Width="50px" DecimalPlaces="2"  Text='<%# Eval("m_rate") %>' ClientInstanceName="cm_rate">
                                                                    <ValidationSettings CausesValidation="True" ErrorDisplayMode="ImageWithTooltip">
                                                                        <RequiredField IsRequired="True" />
                                                                    </ValidationSettings>
                                                                    <SpinButtons ShowIncrementButtons="false" />
                                                                </dx:ASPxSpinEdit>
                                                            </td>

                                                            <td>                                                                
                                                                <dx:ASPxSpinEdit ID="cl_quantity" runat="server" Height="21px" Number="0" Width="50px" Text='<%# Eval("l_quantity") %>' ClientInstanceName="cl_quantity">
                                                                    <SpinButtons ShowIncrementButtons="false" />
                                                                    <ValidationSettings CausesValidation="True" ErrorDisplayMode="ImageWithTooltip">
                                                                        <RequiredField IsRequired="True" />
                                                                    </ValidationSettings>
                                                                </dx:ASPxSpinEdit>
                                                            </td>
                                                            <td>
                                                                <dx:ASPxComboBox ID="cl_unit" runat="server" DataSourceID="SqlUnit" 
                                                                    TextField="name" ValueField="Insurance_Unit_ID" Text='<%# Eval("l_unit") %>' IncrementalFilteringMode="StartsWith" ClientInstanceName="cl_unit">
                                                                    <ValidationSettings CausesValidation="True" ErrorDisplayMode="ImageWithTooltip">
                                                                        <RequiredField IsRequired="True" />
                                                                    </ValidationSettings>
                                                                </dx:ASPxComboBox>
                                                            </td>
                                                            <td>                                                                
                                                                <dx:ASPxSpinEdit ID="cl_rate" runat="server" Height="21px" Number="0" Width="50px" DecimalPlaces="2" Text='<%# Eval("l_rate") %>' ClientInstanceName="cl_rate">
                                                                    <ValidationSettings CausesValidation="True" ErrorDisplayMode="ImageWithTooltip">
                                                                        <RequiredField IsRequired="True" />
                                                                    </ValidationSettings>
                                                                    <SpinButtons ShowIncrementButtons="false" />
                                                                </dx:ASPxSpinEdit>
                                                            </td>
                                                        </tr>
                                                    </table>

                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <table>
                                                        <tr>
                                                            <td>
                                                                <dx:ASPxButton ID="ASPxButton1" runat="server" Text="Save Variation Item"  Image-Url="~/Images/save.png" Image-Height="14px" Image-Width="14px" UseSubmitBehavior="False" AutoPostBack="False">
                                                                    <ClientSideEvents Click="function(s, e) {                                                                         
                                                                        if (!cRoom.GetIsValid()) {return false;}
                                                                        if (!cTrade.GetIsValid()) {return false;}
                                                                        if (!clong_desc.GetIsValid()) {return false;}
                                                                        if (!cm_quantity.GetIsValid()) {return false;}
                                                                        if (!cm_unit.GetIsValid()) {return false;}
                                                                        if (!cm_rate.GetIsValid()) {return false;}
                                                                        if (!cl_quantity.GetIsValid()) {return false;}
                                                                        if (!cl_unit.GetIsValid()) {return false;}
                                                                        if (!cl_rate.GetIsValid()) {return false;}

                                                                            itemsGrid.UpdateEdit();
                                                                                                                                              
                                                                        }" />

                                                                </dx:ASPxButton>                      
                                                            </td>
                                                            <td>
                                                                <dx:ASPxButton ID="ASPxButton2" runat="server" Text="Cancel" AutoPostBack="False" ClientSideEvents-Click="function(s, e) { itemsGrid.CancelEdit(); }" UseSubmitBehavior="False">
                                                                </dx:ASPxButton>                            
                                                            </td>
                                                        </tr>
                                                    </table>


                                                </td>
                                            </tr>                    

                                        </table>
                                        
                                    </EditForm>
                                </Templates>
                                <ClientSideEvents  RowClick="function(s, e) {  itemsGrid.SetFocusedRowIndex(e.visibleIndex);  itemsGrid.StartEditRow(e.visibleIndex); }" />
                            </dx:ASPxGridView>
                         
                        </asp:Panel>   
                        <asp:Panel ID="PhotoPanel" runat="server">
                            <iframe id="PhotoFrame" width="100%" scrolling="yes" frameborder="0" height="500" src="VariationPhotos.aspx?photo=1<%=URL2 %>"></iframe>
                        </asp:Panel>
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
