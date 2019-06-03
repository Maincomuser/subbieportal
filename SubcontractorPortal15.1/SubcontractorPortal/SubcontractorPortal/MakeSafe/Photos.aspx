<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Photos.aspx.cs" Inherits="SubcontractorPortal.MakeSafe.Photos" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <link href="~/Styles/site.css" rel="stylesheet" type="text/css" />
    <link href="~/Styles/modal.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="/scripts/jquery-1.4.1.min.js"></script>
    <script type="text/javascript" src="/scripts/jquery.slidingmessage.js"></script>

    <style type="text/css">
        .Caption
        {
            font-family:Arial;
            font-size:14px;
        }
        .Normal
        {
            background-color:#fff;
        }

    </style>
</head>
<body class="Normal">
    <script type="text/javascript">
        var pageURL = "<%=currentURL%>";

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

        function runUpdate() {
            var theForm = document.forms['form1'];
            if (!theForm) {
                theForm = document.form1;
            }
            //ShowWin();
            theForm.submit();
        }


        function runDelete() {
            var delID = document.getElementById("DelPotos");
            if (delID.value != null) {
                if (confirm("Do you really want to delete this Photo(s)?")) {
                    //ShowWin();
                    window.location.replace(pageURL + "&delImg=" + delID.value);
                }
            } else {
                alert('Please click on the image you want to delete');
            }
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

    </script>

    <form id="form1" runat="server">    
        <input id="DelPotos" type="hidden" value="" />
        <div id='Options' style='display:block;position:fixed;top:0;right:0; border:solid 1px #B0CCF2; width:100%; background-color:#B0CCF2;'>
            <table>

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
                                <dx:ASPxButton ID="btnSaveImage" runat="server" ImageSpacing="3px" 
                                    Text="Save Captions" Wrap="False" AutoPostBack="False" 
                                    CausesValidation="False" UseSubmitBehavior="False">
                                        <Image Url="~/Images/save.png" Width="16px" Height="16px" />
<Image Height="16px" Width="16px" Url="~/Images/save.png"></Image>
<ClientSideEvents Click="function(s, e) { runUpdate(); }"/>
                                </dx:ASPxButton>                            
                            </td>
                
                    <td>
                        <dx:ASPxButton ID="btnDelImage" runat="server" ImageSpacing="3px" 
                            Text="Delete Image" Wrap="False" AutoPostBack="False">
                                <Image Height="16px" Width="16px" Url="~/Images/recycle.png"></Image>
                                <ClientSideEvents  Click="function(s, e) { runDelete(); }"/>
                        </dx:ASPxButton>                            
                    </td>
                </tr>
            </table>
        </div>
        <br /><br />
                                   <dx:ASPxDataView runat="server" RowPerPage="100" DataSourceID="SqlDataSource1" ColumnCount="1"
                                    ID="ASPxDataView1" Width="100%" EnableDefaultAppearance="False" 
                                    EnableTheming="False" EnableCallBacks="False" ShowLoadingPanel="True" 
                                    ViewStateMode="Disabled">
                                    <PagerSettings Visible="False">
                                    </PagerSettings>
                                    <Paddings Padding="0px"></Paddings>
                                    <ItemTemplate>
                                        <table border="0" cellpadding="0" cellspacing="0" style="margin-left: 5px;">
                                            <tbody>

                                                 <tr>
                                                    <td valign="top">
                                                        <input class="caption" id='Caption<%# Eval("Insurance_Document_id") %>' name='Caption<%# Eval("Insurance_Document_id") %>' type="text"  value="<%# Eval("caption") %>" maxlength="100" />
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
                                                        <input class="caption" id='Caption<%# Eval("Insurance_Document_id") %>' name='Caption<%# Eval("Insurance_Document_id") %>' type="text"  value="<%# Eval("caption") %>" maxlength="100" />
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


        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DataConnectionString %>" SelectCommand="Subcontractor_Get_Variation_Pictures" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:CookieParameter CookieName="SubbyID" Name="SubcontractorID" Type="Int32" />
                <asp:QueryStringParameter Name="WorkOrderID" QueryStringField="WOID" Type="Int32" />
                <asp:QueryStringParameter Name="QuoteID" QueryStringField="QuoteID" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>

        <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
            ConnectionString="<%$ ConnectionStrings:DataConnectionString %>" 
            SelectCommand="Subcontractor_Get_Variation_Pictures_From_Disk" 
            SelectCommandType="StoredProcedure"  >
            <SelectParameters>
                <asp:CookieParameter CookieName="SubbyID" Name="SubcontractorID" Type="Int32" />
                <asp:QueryStringParameter Name="WorkOrderID" QueryStringField="WOID" Type="Int32" />
                <asp:Parameter DefaultValue="0" Name="QuoteID" Type="Int32" />
                

            </SelectParameters>
        </asp:SqlDataSource>


    </form>
</body>
</html>
