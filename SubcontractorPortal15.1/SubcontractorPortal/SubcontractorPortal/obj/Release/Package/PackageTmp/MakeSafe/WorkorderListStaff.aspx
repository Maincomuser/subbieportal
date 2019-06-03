<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WorkorderListStaff.aspx.cs" Inherits="SubcontractorPortal.MakeSafe.WorkorderListStaff" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <style type="text/css">
        .WOCaption
        {
            font-weight: bold;
        }

    </style>
    <script type="text/javascript"  src="/Scripts/trace.js"></script>
    <script type="text/javascript"  src="/Scripts/common.js"></script>
    <script type="text/javascript">
        

    </script>

</head>
<body>
    <script type="text/javascript">parent.HideWin();</script>
    <form id="form1" runat="server">        
        <dx:ASPxGridView ID="WOList" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" EnableTheming="True" KeyFieldName="Work Order No" Theme="Aqua" Width="100%" Cursor="pointer">
            <ClientSideEvents RowClick="function(s, e) {
    parent.ShowWin2();                
	var key = s.GetRowKey(e.visibleIndex);
	window.location.replace('/MakeSafe/WorkOrderView.aspx?WOID=' + key);
}" />
            <Columns>
                <dx:GridViewDataTextColumn FieldName="Work Order No" ReadOnly="True" VisibleIndex="0" Width="100px">
                    <CellStyle HorizontalAlign="Left">
                    </CellStyle>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Maincom Ref" VisibleIndex="1" Width="100px">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Order Type" VisibleIndex="2" Width="150px">
                    <Settings AllowAutoFilter="False" AllowHeaderFilter="True" />
                </dx:GridViewDataTextColumn>

                <dx:GridViewDataDateColumn FieldName="Start Date" VisibleIndex="2" Width="100px">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataDateColumn FieldName="End Date" VisibleIndex="3" Width="100px">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="Property Address" ReadOnly="True" VisibleIndex="4">
                    <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Contact" VisibleIndex="5">
                    <Settings AllowAutoFilter="False" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="WO Status" VisibleIndex="7" Width="150px">
                    <Settings AllowAutoFilter="False" AllowHeaderFilter="True" />
                </dx:GridViewDataTextColumn>
            </Columns>
            <SettingsBehavior AllowSelectByRowClick="True" AllowSelectSingleRowOnly="True" EnableRowHotTrack="True" />
            <SettingsPager PageSize="20">
            </SettingsPager>
            <Settings ShowFilterRow="True" ShowHeaderFilterBlankItems="False" />
        </dx:ASPxGridView>
        <br />

        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DataConnectionString %>" SelectCommand="Subcontractor_List_MakeSafe_WOs_For_Staff" SelectCommandType="StoredProcedure">
        </asp:SqlDataSource>
    </form>
</body>
</html>
