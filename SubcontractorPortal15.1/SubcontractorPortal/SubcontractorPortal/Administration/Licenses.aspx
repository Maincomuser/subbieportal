<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Licenses.aspx.cs" Inherits="SubcontractorPortal.Administration.Licenses" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        legend
        {
            font-family:Arial;
            font-size:16px;
        }

    </style>
    <script type="text/javascript">

        function uploadControl_FileUploadStart() {
            uploadControl.SetEnabled(false);
            btnUploadAttachDocument.SetEnabled(false);
        }

        function uploadControl_FileUploadComplete() {
            btnUploadAttachDocument.SetEnabled(true);
            //gvwAttachDocuments.SetFocusedRowIndex(gvwAttachDocuments.GetPageCount() * (gvwAttachDocuments.GetVisibleRowsOnPage() + 1));
            gvwAttachDocuments.Refresh();
        }

        function cbbDocumentType_SelectedIndexChanged() {
            document.getElementById("hiddenField").value = cbbDocumentType.GetSelectedIndex();
        }

        function btnUploadAttachDocument_Click() {
            if (uploadControl.GetText() !== "" && document.getElementById("hiddenField").value > 0) {
                uploadControl.Upload();
            } else {
                alert('File is missing or document type is not selected');
            }
        }

        function rblPendingApproved_SelectedIndexChanged() {
            document.getElementById("hiddenField_rblPendingApproved").value = rblPendingApproved.GetSelectedIndex();
        }

        //

        function btnUploadAttachAuditDocument_Click() {
            if (uploadControl1.GetText() !== "" && cbbAuditResult.GetSelectedIndex() > 0 && dteAuditDate.GetDate() != null) {
                uploadControl1.Upload();
            } else {
                alert('File or Audit Date or Audit Result is missing');
            }
        }

        function uploadControl1_FileUploadStart() {
            uploadControl1.SetEnabled(false);
            btnUploadAttachAuditDocument.SetEnabled(false);
        }

        function uploadControl1_FileUploadComplete() {
            btnUploadAttachAuditDocument.SetEnabled(true);
            gvwAttachAuditDocuments.Refresh();
        }

        //

        function rblPendingApproved_Init() {
            rblPendingApproved.SetSelectedIndex(1);
        }

        //

        function cApprovedBy_CheckedChanged() {
            cApprovedBy.SetEnabled(!cApprovedBy.GetChecked());

        }
    </script>

</head>
<body>
    <script type="text/javascript">parent.HideWin();</script>
    <form id="form1" runat="server">
        <asp:HiddenField ID="hiddenField" runat="server" Value="0" />
    <asp:HiddenField ID="hiddenField_rblPendingApproved" runat="server" Value="0" />        
    <table>
        <colgroup>
            <col style="width:150px">
            <col style="width:100px">
            <col style="width:100px">
            <col style="width:100px">
            <col style="width:100px">
            <col style="width:100px">
            <col style="width:100px">
            <col style="width:120px">
            <col style="width:25px">
        </colgroup>
                                                    
        <tr>
            <td colspan="9">
                <div style="width:945px; margin-left:20px">
                    <fieldset>
                        <legend style="font-size:14px">Documents Required by Maincom</legend>
                        <table>
                            <colgroup>
                                <col style="width:140px">
                                <col style="width:100px">
                                <col style="width:100px">
                                <col style="width:100px">
                                <col style="width:100px">
                                <col style="width:100px">
                                <col style="width:100px">
                                <col style="width:75px">
                                <col style="width:25px">
                            </colgroup>
                            <tr>
                                <td colspan="9">&nbsp;</td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <dx:ASPxLabel ID="lblDocumentType" runat="server" Text="Document Type"  ></dx:ASPxLabel>
                                </td>
                                <td>        
                                    <dx:ASPxComboBox ID="cbbDocumentType" runat="server" ClientInstanceName="cbbDocumentType" EnableClientSideAPI="True"  Width="250px">
                                        <ClientSideEvents SelectedIndexChanged="function(s,e){cbbDocumentType_SelectedIndexChanged();}" />
                                    </dx:ASPxComboBox>
                                    </td>                                                                                                                                                    
                                <td></td>
                                <td align="right">
                                    <dx:ASPxLabel ID="lblExpirationDate" runat="server"  Text="Expiration Date">
                                    </dx:ASPxLabel>
                                </td>
                                <td>
                                    <dx:ASPxDateEdit ID="dteExpirationDate" runat="server" OnInit="dteExpirationDate_Init" Width="100%">
                                    </dx:ASPxDateEdit>
                                </td>
                                <td></td>
                                <td colspan="3">
                                </td>
                            </tr>                            

                            <tr>
                                    <td align="right">
                                        <dx:ASPxLabel ID="lblAttachDocument" runat="server"  Text="Attach Document" Width="100%">
                                        </dx:ASPxLabel>
                                    </td>
                                    <td colspan="7">
                                        <dx:ASPxUploadControl ID="upldAttachDocument" runat="server" ClientInstanceName="uploadControl" FileUploadMode="OnPageLoad" OnFileUploadComplete="upldAttachDocument_FileUploadComplete" ShowProgressPanel="True" Width="100%">
                                            <ClientSideEvents FileUploadComplete="function(s, e) { uploadControl_FileUploadComplete(); }" FileUploadStart="function(s,e){uploadControl_FileUploadStart();}" />
                                            <ValidationSettings AllowedFileExtensions=".xls, .xlsx, .doc, .docx, .pdf, .txt, .gif, .jpeg, .jpg, .tif" />
                                            <AdvancedModeSettings PacketSize="40960" />
                                        </dx:ASPxUploadControl>                                                                                
                                    </td>
                                    <td>
                                        <dx:ASPxButton ID="btnUploadAttachDocument" runat="server" AutoPostBack="False" ClientInstanceName="btnUploadAttachDocument"  Text="Upload" Width="100%" Wrap="False">
                                            <ClientSideEvents Click="function(s,e){btnUploadAttachDocument_Click();}" />
                                            <Image  Url="~/Images/Upload.png" Width="12px">
                                            </Image>
                                        </dx:ASPxButton>
                                    </td>
                            </tr>

                            
                            <tr>
                                <td colspan="9">&nbsp;</td>
                            </tr>
                            </table>
                        <table width="100%">
                            <tr>                                                                        
                                <td></td>
                                <td colspan="8">
                                    <asp:SqlDataSource ID="sdsAttachDocuments" runat="server" ConnectionString="<%$ ConnectionStrings:DataConnectionString %>" 
                                        SelectCommand="select doctypes.doctype, docs.GUID, docs.CreationDate, docs.Approved, docs.ApprovedBy, docs.ExpirationDate, docs.IsPending 
                                            from Subcontractor_Documents as docs 
                                            inner join Subcontractor_DocTypes as doctypes 
                                            on docs.doctype_id=doctypes.doctype_id 
                                            where docs.be_id=@BeId AND doctypes.DocType!='Audit document' AND doctypes.DocType!='Registration document'" 
                                        UpdateCommand="UPDATE [dbo].[Subcontractor_Documents] WITH (ROWLOCK) SET ApprovedBy=@ApprovedBy, ExpirationDate=@ExpirationDate WHERE GUID=@GUID">
                                        <SelectParameters>
                                            <asp:CookieParameter CookieName="SubbyID" Name="@BeId" />
                                        </SelectParameters>
                                        <UpdateParameters>
                                            <asp:Parameter Name="ApprovedBy" />
                                            <asp:Parameter Name="ExpirationDate" />
                                            <asp:Parameter Name="GUID" />
                                        </UpdateParameters>
                                    </asp:SqlDataSource>
                                    <dx:ASPxGridView ID="gvwAttachDocuments" runat="server" AutoGenerateColumns="False" Caption="Your Current Documents Stored in Maincom" ClientInstanceName="gvwAttachDocuments" DataSourceID="sdsAttachDocuments" KeyFieldName="GUID" OnRowUpdating="gvwAttachDocuments_RowUpdating" OnStartRowEditing="gvwAttachDocuments_StartRowEditing" Width="100%">
                                        <ClientSideEvents RowClick="function(s, e) {  gvwAttachDocuments.SetFocusedRowIndex(e.visibleIndex);  gvwAttachDocuments.StartEditRow(e.visibleIndex); }" />
                                        <Columns>
                                            <dx:GridViewDataTextColumn Caption="Doc Type" FieldName="doctype" ReadOnly="True" ShowInCustomizationForm="True" VisibleIndex="1">
                                                <CellStyle HorizontalAlign="Left">
                                                </CellStyle>
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataDateColumn Caption="Expiration Date" FieldName="ExpirationDate" ShowInCustomizationForm="True" VisibleIndex="2">
                                                <CellStyle HorizontalAlign="Left">
                                                </CellStyle>
                                            </dx:GridViewDataDateColumn>

                                            <dx:GridViewDataDateColumn Caption="Uploaded" FieldName="CreationDate" ReadOnly="True" ShowInCustomizationForm="True" VisibleIndex="3">
                                                        <CellStyle HorizontalAlign="Left">
                                                </CellStyle>
                                            </dx:GridViewDataDateColumn>
                                            <dx:GridViewDataDateColumn Caption="Approved On" FieldName="Approved" ShowInCustomizationForm="True" VisibleIndex="4">
                                                <CellStyle HorizontalAlign="Left">
                                                </CellStyle>
                                            </dx:GridViewDataDateColumn>
                                            
                                            <dx:GridViewDataTextColumn FieldName="GUID" Visible="false">
                                            </dx:GridViewDataTextColumn>
                                        </Columns>
                                        <SettingsBehavior AllowSelectByRowClick="True" AllowSelectSingleRowOnly="True" ConfirmDelete="True" AllowDragDrop="False" EnableRowHotTrack="True" />
                                        <SettingsPager Visible="False">
                                        </SettingsPager>
                                        <SettingsEditing Mode="EditForm" />
                                        <SettingsText ConfirmDelete="Do you really want to delete this record?" PopupEditFormCaption="Options" />
                                        <SettingsDetail AllowOnlyOneMasterRowExpanded="True" />
                                        <Templates>
                                            <EditForm>
                                                <table style="width:100%; border:1px solid #000000;">
                                                    <tr>
                                                        <th align="left">Link to Document</th>
                                                        <th style="width:8px"></th>
                                                        <th align="left">Expiration Date</th>                                                       
                                                        
                                                    </tr>
                                                    <tr>
                                                        <td style="float:left">
                                                            <asp:LinkButton ID="cLinkToDocument" runat="server" Text='<%# Eval("docType") %>' OnClick="cLinkToDocument_Click">
                                                            </asp:LinkButton>
                                                        </td>
                                                        <td style="width:8px"></td>
                                                        <td>
                                                            <dx:ASPxLabel ID="ASPxLabel1" runat="server" Text='<%# Bind("ExpirationDate")%>' ></dx:ASPxLabel>
                                                        </td>
                                                        
                                                    </tr>
                                                    <tr><td colspan="3">&nbsp;</td></tr>
                                                </table>
                                                <br />
                                                <table>
                                                    <tr>
                                                        <td>
                                                            <dx:ASPxButton ID="btnCancel" runat="server" AutoPostBack="False" ClientSideEvents-Click="function(s, e) { gvwAttachDocuments.CancelEdit(); }" Text="Close View" UseSubmitBehavior="False">
                                                            </dx:ASPxButton>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </EditForm>
                                        </Templates>
                                    </dx:ASPxGridView>
                                </td>
                            </tr>
                            
                        </table>                                                                                                            
                    </fieldset>
                </div>
            </td>
        </tr>
        </table>                 
                                                    


    </form>
</body>
</html>
