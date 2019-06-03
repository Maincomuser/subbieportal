using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Drawing;
using DevExpress.Web;
using SubcontractorDataComponents;
using System.IO;
using System.Web.UI.HtmlControls;


namespace SubcontractorPortal.Administration
{
    public partial class Licenses : System.Web.UI.Page
    {
        // change to use web config & DA
        public const string uploadFolder = "Licences";
        protected void Page_Load(object sender, EventArgs e)
        {
            Documents.Initialize();

            if (!IsPostBack)
            {
                PopulateDetailView_Subcontractor();
            }

            if (!sdsAttachDocuments.SelectParameters.Contains(sdsAttachDocuments.SelectParameters["BeId"]))
            {
                sdsAttachDocuments.SelectParameters.Add("BeId", DbType.Int32, DA.ReadCookie("SubbyID"));
            }


        }

        private void PopulateDetailView_Subcontractor()
        {
            PopulateDetailedView_DefaultValues_Subcontractor();

            if (Session["Dr"] != null)
            {
                (Session["Dr"] as SqlDataReader).Close();
            }
            SqlDataReader dr = Documents.GetBusinessEntityById(Convert.ToInt32(DA.ReadCookie("SubbyID")) as int?);
            Session["Dr"] = dr;

            if (dr.Read())
            {
                //if (dr["Last_audit_date"] as DateTime? != null)
                //{
                //    dteAuditDate.Date = (DateTime)dr["Last_audit_date"];
                //}
                //if (dr["AuditResultId"] as int? != null && dr["AuditResultId"] as int? > 0)
                //{
                //    cbbAuditResult.SelectedIndex = Convert.ToInt32(dr["AuditResultId"]);
                //}
                /*
                if (dr["Registration_Number"] as string != null && dr["Registration_Date"] as DateTime? != null)
                {
                }
                if (dr["Suspended"] as bool? != null && (bool)(dr["Suspended"] as bool?) == true && dr["SuspentionReason"] as string != null && dr["SuspensionID"] as int? != null)
                {
                    ckbSuspended.Checked = true;
                    cbbSuspensionReason.SelectedIndex = (int)(dr["SuspensionID"] as int?);
                    memSuspensionComments.Text = dr["SuspentionReason"] as string;
                }
                else
                {
                    ckbSuspended.Checked = false;
                    cbbSuspensionReason.SelectedIndex = 0;
                    memSuspensionComments.Text = "";

                    cbbSuspensionReason.ClientEnabled = false;
                    memSuspensionComments.ClientEnabled = false;
                }
                 */
            }
        }

        private void PopulateDetailedView_DefaultValues_Subcontractor()
        {
            // Populate doc types
            List<string> docTypeList = new List<string>();
            Documents.GetDocTypes(ref docTypeList);
            cbbDocumentType.Items.Clear();
            cbbDocumentType.Items.Add("");
            foreach (var type in docTypeList)
            {
                cbbDocumentType.Items.Add(type);
            }
            cbbDocumentType.SelectedIndex = 0;

        }

        static public void ShowClientSideMessage(Control ctrl, string msg)
        {
            string script = String.Format("alert('{0}');", msg);
            ScriptManager.RegisterStartupScript(ctrl, ctrl.GetType(), "script", script, true);
        }


        protected void dteExpirationDate_Init(object sender, EventArgs e)
        {
            dteExpirationDate.Date = DateTime.Now.AddMonths(12);
        }

        protected void upldAttachDocument_FileUploadComplete(object sender, FileUploadCompleteEventArgs e)
        {

            SavePostedFile(e.UploadedFile, false, false);
            // Refresh datasource to get latest data into gridview
            gvwAttachDocuments.DataBind();
            gvwAttachDocuments.CollapseAll();
        }


        public void SavePostedFile(UploadedFile uploadedFile, bool isRegistrationDocument, bool isAuditDocument)
        {
            if (!uploadedFile.IsValid)
            {
                return;
            }
            /*
            try
            {
             */
                bool? isPending;
                if (!isRegistrationDocument && !isAuditDocument)
                {
                    isPending = Convert.ToInt32(hiddenField_rblPendingApproved.Value) == 0 ? true : false;
                    if (!(bool)isPending)
                    {

                        List<string> guIdList = Documents.GetDocumentByBusinessEntityAndDoctype(Convert.ToInt32(DA.ReadCookie("SubbyID")), Convert.ToInt32(hiddenField.Value));

                        // Delete pending file(s) of the same type
                        List<string> allFiles = Directory.GetFiles(Path.Combine(Server.MapPath("/images") + @"\", uploadFolder)).ToList<string>();
                        List<string> absoluteFilePathList = new List<string>();
                        foreach (var id in guIdList)
                        {
                            absoluteFilePathList.Add(allFiles.Select(n => n).Where(n => n.Contains(id)).FirstOrDefault<string>());
                            Documents.DeleteDocumentByGuid(id);
                        }
                        foreach (var filePath in absoluteFilePathList)
                        {
                            File.Delete(filePath);
                        }
                    }
                }
                else
                {
                    isPending = null; // make null while it is registration document or audit document

                    int docTypeId = isRegistrationDocument ? 5 : 6;

                    List<string> guIdList = Documents.GetDocumentByBusinessEntityAndDoctype(Convert.ToInt32(DA.ReadCookie("SubbyID")), docTypeId);

                    // Delete pending file(s) of the same type
                    List<string> allFiles = Directory.GetFiles(Path.Combine(Server.MapPath("/images") + @"\", uploadFolder)).ToList<string>();
                    List<string> absoluteFilePathList = new List<string>();
                    foreach (var id in guIdList)
                    {
                        absoluteFilePathList.Add(allFiles.Select(n => n).Where(n => n.Contains(id)).FirstOrDefault<string>());
                        Documents.DeleteDocumentByGuid(id);
                    }
                    foreach (var filePath in absoluteFilePathList)
                    {
                        File.Delete(filePath);
                    }
                }


                int docTypeId1 = Convert.ToInt32(hiddenField.Value);
                DateTime expirationDate = dteExpirationDate.Date;
                DateTime? approvedDate = (bool)isPending ? new Nullable<DateTime>() : DateTime.Now;
                //string approvedBy = (bool)isPending ? null : Request.Cookies["userCode"].Value;
                string approvedBy = null;


                var guId = Documents.InsertIntoSubcontractorDocuments(Convert.ToInt32(DA.ReadCookie("SubbyID")), docTypeId1, expirationDate, isPending,
                    approvedDate, approvedBy, DateTime.Now);



                var fileExtension = Path.GetExtension(uploadedFile.FileName);
                if (!Directory.Exists(Path.Combine(Server.MapPath("/images") + @"\", uploadFolder)))
                {
                    Directory.CreateDirectory(Path.Combine(Server.MapPath("/images") + @"\", uploadFolder));
                }
                if (!File.Exists(Path.Combine(Server.MapPath("/images") + @"\", uploadFolder, guId + fileExtension)))
                {
                    uploadedFile.SaveAs(Path.Combine(Server.MapPath("/images") + @"\", uploadFolder, guId + fileExtension));
                }
            /*
            }
            catch (Exception ex)
            {

            }
             */
            //return ThumbnailFileName;
        }

        protected void cLinkToDocument_Click(object sender, EventArgs e)
        {
            string guId = (gvwAttachDocuments.GetRow(gvwAttachDocuments.EditingRowVisibleIndex) as DataRowView).Row.ItemArray[1].ToString();
            string docType = (sender as LinkButton).Text.Trim();
            DownloadFromLink(docType, guId);

        }

        private void DownloadFromLink(string docType, string guId)
        {
            var fileNameWithExtension = Directory.GetFiles(Path.Combine(Server.MapPath("/images") + @"\", uploadFolder)).ToList<string>().Select(n => n).Where(n => n.Contains(guId)).FirstOrDefault<string>();

            // Get client download file name
            var extension = Path.GetExtension(fileNameWithExtension);
            var clientFileNameWithExtension = docType + extension;

            // Let client user download doc
            Response.ContentType = "application/octet-stream";
            Response.AppendHeader("Content-Disposition", "attachment; filename=\"" + clientFileNameWithExtension + "\"");            
            Response.TransmitFile(fileNameWithExtension);
            
            Response.End();
        }

        protected void gvwAttachDocuments_RowUpdating(object sender, DevExpress.Web.Data.ASPxDataUpdatingEventArgs e)
        {
            ASPxCheckBox eApprovedBy = gvwAttachDocuments.FindEditFormTemplateControl("cApprovedBy") as ASPxCheckBox;
            string connStr = ConfigurationManager.ConnectionStrings["DataConnectionString"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            conn.Open();
            string queryStr;
            if (eApprovedBy.Checked == true)
            {
                e.NewValues["ApprovedBy"] = Request.Cookies["userCode"].Value;
                queryStr = "UPDATE Subcontractor_Documents WITH (ROWLOCK) SET Approved = GETDATE(), IsPending=" + 0 + " WHERE GUID='" + e.Keys["GUID"].ToString() + "'";
            }
            else
            {
                e.NewValues["ApprovedBy"] = string.Empty;
                queryStr = "UPDATE Subcontractor_Documents WITH (ROWLOCK) SET Approved=NULL, IsPending=" + 1 + " WHERE GUID='" + e.Keys["GUID"].ToString() + "'";
            }
            SqlCommand cmd = new SqlCommand(queryStr, conn);
            cmd.ExecuteNonQuery();
            conn.Close();

            ASPxDateEdit eExpirationDate = gvwAttachDocuments.FindEditFormTemplateControl("cExpirationDate") as ASPxDateEdit;
            if (eExpirationDate.Value != null)
            {
                e.NewValues["ExpirationDate"] = eExpirationDate.Value;
            }


            if (eApprovedBy.Checked)
            {
                // delete non-approved one(s) of the same doc type when the current one is being saved as approved
                var currentRow = gvwAttachDocuments.GetRow(gvwAttachDocuments.FocusedRowIndex) as DataRowView;
                var t = currentRow["approvedby"].ToString();
                var currentDocType = currentRow["doctype"].ToString();
                var currentGUID = currentRow["GUID"].ToString();
                var docTypeList = new List<string>();
                Documents.GetDocTypes(ref docTypeList);
                int docTypeId = 0;
                for (int i = 0; i < docTypeList.Count; i++)
                {
                    if (docTypeList[i].ToLower().Trim() == currentDocType.ToLower().Trim())
                    {
                        docTypeId = i + 1;
                    }
                }

                List<string> guIdList = Documents.GetDocumentByBusinessEntityAndDoctype(Convert.ToInt32(DA.ReadCookie("SubbyID")), docTypeId);
                guIdList = guIdList.Select(n => n).Where(n => n.Trim() != currentGUID.Trim()).ToList();

                // Delete pending file(s) of the same type
                List<string> allFiles = Directory.GetFiles(Path.Combine(Server.MapPath("/images") + @"\", uploadFolder)).ToList<string>();
                List<string> absoluteFilePathList = new List<string>();
                foreach (var id in guIdList)
                {
                    absoluteFilePathList.Add(allFiles.Select(n => n).Where(n => n.Contains(id)).FirstOrDefault<string>());
                    Documents.DeleteDocumentByGuid(id);
                }
                foreach (var filePath in absoluteFilePathList)
                {
                    File.Delete(filePath);
                }

                // Refresh datasource to get latest data into gridview
                gvwAttachDocuments.DataBind();
                gvwAttachDocuments.CollapseAll();
            }
        }

        protected void gvwAttachDocuments_StartRowEditing(object sender, DevExpress.Web.Data.ASPxStartRowEditingEventArgs e)
        {
            //ASPxCheckBox eApprovedBy = gvwAttachDocuments.FindEditFormTemplateControl("cApprovedBy") as ASPxCheckBox;
            //bool isApproved = (gvwAttachDocuments.GetRow(gvwAttachDocuments.EditingRowVisibleIndex) as DataRowView).Row.ItemArray[4].ToString().Trim() !=
            //    "" ? true : false; // ItemArray[4] holds ApprovedBy
            //eApprovedBy.Checked = isApproved ? true : false;
        }

    }
}