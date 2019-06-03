<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SubbiePhotos.aspx.cs" Inherits="SubcontractorPortal.WOrders.SubbiePhotos1" %>

<%@ Register Assembly="DevExpress.Web.v15.1, Version=15.1.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>






<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">


<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <link href="~/Styles/site.css" rel="stylesheet" type="text/css" />
    <link href="~/Styles/modal.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript" src="/scripts/jquery-1.4.1.min.js"></script>
    <script type="text/javascript" src="/scripts/jquery.slidingmessage.js"></script>
    <script type="text/javascript" src="/Scripts/Common.js"></script>
    <style type="text/css">
        .checkBox2 
        {
            
        }
        .btnFloat {float: left;}
        .btnFloatRight {float: right;}
        .btnFloat2 {float: left; margin-left:3px;}

    </style>

</head>
<body>
    <script type="text/javascript">
    <%if (message != null)
      { %>

        $(function () {
            var options = {
                id: 'message_from_top',
                position: 'top',
                size: 50,
                backgroundColor: '<%=messageColor%>',
                fontColor: 'white',
                delay: 2500,
                speed: 500,
                fontSize: '30px'
            };
            $.showMessage('<%=message%>', options);
            return false;
        });

        <%} %>
    </script>


    <script type="text/javascript">
        var imgToDelete;
        var pageURL = "<%=currentURL%>";
        var orderURL = "<%=reorderURL%>";

        function runUpdate() {
            var theForm = document.forms['form1'];
            if (!theForm) {
                theForm = document.form1;
            }
            ShowWin();
            theForm.submit();
        }
        function ClearImages() {
            var imgs = document.getElementsByTagName("img");
            for (var i = 0; i < imgs.length; i++) {
                imgs[i].style.border = '0px';
            }
        }
        function runDelete() {
            var delID = document.getElementById("DelPotos");
            if (delID.value != null) {
                if (confirm("Do you really want to delete this Photo(s)?")) {
                    ShowWin();
                    window.location.replace(pageURL + "&delImg=" + delID.value);
                }
            } else {
                alert('Please click on the image you want to delete');
            }
        }
        function runReorder() {
            ShowWin();
            window.location.replace(orderURL);

        }
        function SetDelete(imgID, imageID) {
            var delID = document.getElementById("DelPotos");
            var delValue = imgID + '|';
            var delValues = delID.value;

            if (delValues.indexOf(delValue) != -1) {
                delID.value = delID.value.replace(delValue, '');
                document.getElementById(imageID).style.border = '0px';
            } else {
                delID.value = delID.value + delValue;
                document.getElementById(imageID).style.border = '3px solid red';
            }

        }

        function ReloadImages() {
            window.location.reload();
        }

        function OnSaveImageClick(s, e) {
            runUpdate();
        }

        function OnBtnUploadClick(s, e) {

            if (uploadControl.GetText() != "") {
                uploadControl.Upload();
            } else {
                alert('Please select photo first');
            }
        }

        function OnFileUploadComplete(s, e) {
            document.location.replace('<%=currentURL%>');
        }



    </script>

    <form id="form1" runat="server" target="_self">
    <asp:Panel ID="CrossPanel" runat="server" class="stickynote20">
        <div align="left">&nbsp; <img src="/images/loading.gif" alt="" align="Absmiddle" /><b>&nbsp;<font face=Verdana size=2>Processing Images ...</font></b></div>
    </asp:Panel>    

        <table width="100%" cellpadding="0" cellspacing="2" align="left" style="background-color: lightgray;display:block;position:fixed;top:0;left:0;">
            <tr>
                    <td align="center">
                        <dx:ASPxUploadControl ID="ASPxUploadControl1" runat="server" Width="280px" ClientInstanceName="uploadControl"
                                ShowProgressPanel="True" UploadMode="Advanced" OnFileUploadComplete="ASPxUploadControl1_FileUploadComplete"
                                ShowClearFileSelectionButton="False">
                                <ValidationSettings AllowedFileExtensions=".jpg, .jpeg, .gif"></ValidationSettings>
                                <ClientSideEvents FileUploadComplete="function(s, e) { OnFileUploadComplete(s, e); }" />                              
                                <CancelButton Text=""></CancelButton>
                                <AdvancedModeSettings EnableMultiSelect="True" />
                        </dx:ASPxUploadControl>

                    </td>

                    <td>
                        <dx:ASPxButton ID="btnUpload" runat="server" ImageSpacing="3px" 
                            Text="Upload Images" Wrap="False" AutoPostBack="False" ClientInstanceName="btnUpload" 
                            CausesValidation="False" UseSubmitBehavior="False">
                                <Image Url="~/Images/Upload.png" Width="16px" Height="16px" ></Image>
                                <ClientSideEvents Click="function(s, e) { OnBtnUploadClick(s, e); }" />
                        </dx:ASPxButton>                           

                    </td>



                <td>
                    <div class="btnFloat">
                        <dx:ASPxButton ID="btnSaveImage" runat="server" ImageSpacing="3px" 
                            Text="Save Captions" Wrap="False" AutoPostBack="False" 
                            CausesValidation="False" UseSubmitBehavior="False">
                                <Image Height="16px" Width="16px" Url="~/Images/save.png"></Image>
                                <ClientSideEvents  Click="function(s, e) { OnSaveImageClick(s, e); }"/>
                        </dx:ASPxButton>        
                    </div>           
            
                    <div class="btnFloat2">
                        <dx:ASPxButton ID="btnReload" runat="server" ImageSpacing="3px" 
                            Text="Reload Photos" Wrap="False" AutoPostBack="False" 
                            CausesValidation="False" UseSubmitBehavior="False">
                                    
                                <ClientSideEvents  Click="function(s, e) { ReloadImages(); }"/>
                        </dx:ASPxButton>        
                    </div>
                </td>
            </tr>

        </table>
        <br /><br />


        <dx:ASPxCallbackPanel ID="ASPxCallbackPanel1" runat="server" Width="200px"></dx:ASPxCallbackPanel>

                                   <dx:ASPxDataView runat="server" RowPerPage="300" DataSourceID="SqlDataSource1" ColumnCount="1"
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
                                                     <td align="right">
                                                         <dx:ASPxCheckBox ID="IncludeInQuote" runat="server" Text="Include in quote" ValueChecked = "true" ValueUnchecked = "false" Value='<%#Bind("is_part_of_quote")%>' ClientInstanceName='<%# Bind("Insurance_Document_id") %>'  ></dx:ASPxCheckBox>

                                                         
                                                     </td>
                                                </tr>

                                                <tr>
                                                    <td valign="top" style="padding-top: 1px;" colspan="2">
                                                        <dx:ASPxBinaryImage ID="ASPxBinaryImage1" runat="server"  ClientIDMode="AutoID"
                                                         
                                                            Value='<%# Eval("attach") %>'>
                                                        </dx:ASPxBinaryImage>                                                        
                                                        
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2">
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
                                                     <td align="right">
                                                         <%-- 
                                                         <input ID='IncludeInQuote<%# Eval("Insurance_Document_id") %>' name='IncludeInQuote<%# Eval("Insurance_Document_id") %>' type="checkbox" class="checkBox2" />

                                                             --%>

                                                         <%-- 
                                                         <dx:ASPxCheckBox ID='IncludeInQuote' runat="server" Text="Include in quote" ValueChecked = "true" ValueUnchecked = "false" Value='<%#Eval("is_part_of_quote")%>' ClientInstanceName='<%# Eval("Insurance_Document_id") %>'  ></dx:ASPxCheckBox> 
                                                         --%>

                                                         
                                                     </td>
                                                </tr>

                                                <tr>
                                                    <td valign="top" style="padding-top: 1px;" colspan="2">
                                                        <dx:ASPxImage ID="ASPxImage1" runat="server" ClientIDMode="AutoID" OnLoad="ASPxImage1_Load"></dx:ASPxImage>                                                        
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2">
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
            SelectCommandType="StoredProcedure"  DataSourceMode="DataReader">
            <SelectParameters>
                <asp:Parameter Name="OrderID" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>

        <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
            ConnectionString="<%$ ConnectionStrings:DataConnectionString %>" 
            SelectCommand="Insurance_Document_Get_Subcontractor_Pictures" 
            SelectCommandType="StoredProcedure"  DataSourceMode="DataReader">
            <SelectParameters>
                <asp:Parameter Name="WorkOrderID" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>


    </form>
</body>
</html>
