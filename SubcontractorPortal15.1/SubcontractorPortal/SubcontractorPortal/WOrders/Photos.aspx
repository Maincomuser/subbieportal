<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Photos.aspx.cs" Inherits="SubcontractorPortal.WOrders.Photos" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="~/Styles/site.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
                                   <dx:ASPxDataView runat="server" RowPerPage="100" DataSourceID="SqlDataSource1" ColumnCount="1"
                                    ID="ASPxDataView1" Width="100%" EnableDefaultAppearance="False" 
                                    EnableTheming="False" EnableCallBacks="False" ShowLoadingPanel="False" 
                                    ViewStateMode="Disabled">
                                    <PagerSettings Visible="False">
                                    </PagerSettings>
                                    <Paddings Padding="0px"></Paddings>
                                    <ItemTemplate>
                                        <table border="0" cellpadding="0" cellspacing="0" style="margin-left: 5px;">
                                            <tbody>

                                                 <tr>
                                                    <td valign="top">
                                                        <input class="caption" id='Caption<%# Eval("Insurance_Document_id") %>' name=Caption<%# Eval("Insurance_Document_id") %> type="text"  value="<%# Eval("caption") %>" maxlength="100" />
                                                    </td>
                                                </tr>

                                                <tr>
                                                    <td valign="top" style="padding-top: 1px;">
                                                        <dx:ASPxBinaryImage ID="ASPxBinaryImage1" runat="server"  ClientIDMode="AutoID"
                                                         OnLoad="img_Load"
                                                            Value='<%# Eval("attach") %>'>
                                                        </dx:ASPxBinaryImage>                                                        
                                                        
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <div class="Spacer" style="width: 13px;">
                                                        </div>
                                                    </td>
                                                 </tr>

                                            </tbody>
                                        </table>
                                    </ItemTemplate>
                                    <ItemStyle Width="100%" />
                                </dx:ASPxDataView>

                                <dx:ASPxDataView runat="server" RowPerPage="300" DataSourceID="SqlDataSource2" ColumnCount="1"
                                    ID="ASPxDataView2" Width="100%" EnableDefaultAppearance="False" 
                                    EnableTheming="False" EnableCallBacks="False" ShowLoadingPanel="False" 
                                    ViewStateMode="Disabled">
                                    <PagerSettings Visible="False">
                                    </PagerSettings>
                                    <Paddings Padding="0px"></Paddings>
                                    <ItemTemplate>
                                        <table border="0" cellpadding="0" cellspacing="0" style="margin-left: 5px;">
                                            <tbody>

                                                 <tr>
                                                    <td valign="top">
                                                        <input class="caption" id='Caption<%# Eval("Insurance_Document_id") %>' name=Caption<%# Eval("Insurance_Document_id") %> type="text"  value="<%# Eval("caption") %>" maxlength="100" />
                                                    </td>
                                                </tr>

                                                <tr>
                                                    <td valign="top" style="padding-top: 1px;">
                                                        <dx:ASPxImage ID="ASPxImage1" runat="server" ClientIDMode="AutoID" OnLoad="ASPxImage1_Load"></dx:ASPxImage>                                                        
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <div class="Spacer" style="width: 13px;">
                                                        </div>
                                                    </td>
                                                 </tr>

                                            </tbody>
                                        </table>
                                    </ItemTemplate>
                                    <ItemStyle Width="100%" />
                                </dx:ASPxDataView>


        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:DataConnectionString %>" 
            SelectCommand="Insurance_Document_Get_Pictures_By_OrderID" 
            SelectCommandType="StoredProcedure" >
            <SelectParameters>
                <asp:CookieParameter CookieName="OrderID" DefaultValue="0" Name="OrderID" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>

        <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
            ConnectionString="<%$ ConnectionStrings:DataConnectionString %>" 
            SelectCommand="Insurance_Document_Get_Pictures_By_OrderID_From_Disk" 
            SelectCommandType="StoredProcedure" >
            <SelectParameters>
                <asp:Parameter Name="OrderID" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>

    </form>
</body>
</html>
