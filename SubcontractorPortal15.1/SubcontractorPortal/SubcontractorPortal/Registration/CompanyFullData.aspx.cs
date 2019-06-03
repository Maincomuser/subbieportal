using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using System.Data.SqlClient;
using System.Configuration;
using SubcontractorDataComponents;
using System.Data;
using DevExpress.Web;
using System.IO;
using System.Net.Mail;





namespace SubcontractorPortal.Registration
{
    public partial class CompanyFullData : System.Web.UI.Page
    {

        const string UploadDirectory = "~/Images/";
        public static SqlConnection mySQLConnection;
        public static SqlCommand myCommand;

        public void ChangeRequestStatus(string strRequestId, string strNewStatus)
        {
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["DataConnectionString"].ConnectionString);
            SqlCommand myCommand = new SqlCommand(@"update subconreg_requests set REQUEST_state = '" + strNewStatus + "'  where request_id = " + strRequestId, conn);
            conn.Open();
            myCommand.ExecuteNonQuery();
            conn.Close();
        }

        public void LoadSWMSfromDB(string strRequestId)
        {
            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["DataConnectionString"].ConnectionString))
            {

                SqlCommand cmd = new SqlCommand(@"  Select l.swms_code,l.swms_description ,c.answer_value
                                                      from subconreg_swms_list l,
                                                           subconreg_company_swms c
                                                     where c.swms_id = l.swms_code
                                                       and c.request_id = " + strRequestId, conn);
                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.HasRows)
                {
                    while (reader.Read())
                    {

                        if (reader.GetValue(0).ToString() == "1") { lbl_SWMS1.Text = reader.GetValue(1).ToString(); if (reader.GetValue(2).ToString() == "1") { rbl_SWMS1.Items[0].Selected = true; rbl_SWMS1.Items[1].Selected = false; } else { rbl_SWMS1.Items[0].Selected = false; rbl_SWMS1.Items[1].Selected = true; } }
                        if (reader.GetValue(0).ToString() == "2") { lbl_SWMS2.Text = reader.GetValue(1).ToString(); if (reader.GetValue(2).ToString() == "1") { rbl_SWMS2.Items[0].Selected = true; rbl_SWMS2.Items[1].Selected = false; } else { rbl_SWMS2.Items[0].Selected = false; rbl_SWMS2.Items[1].Selected = true; } }
                        if (reader.GetValue(0).ToString() == "3") { lbl_SWMS3.Text = reader.GetValue(1).ToString(); if (reader.GetValue(2).ToString() == "1") { rbl_SWMS3.Items[0].Selected = true; rbl_SWMS3.Items[1].Selected = false; } else { rbl_SWMS3.Items[0].Selected = false; rbl_SWMS3.Items[1].Selected = true; } }
                        if (reader.GetValue(0).ToString() == "4") { lbl_SWMS4.Text = reader.GetValue(1).ToString(); if (reader.GetValue(2).ToString() == "1") { rbl_SWMS4.Items[0].Selected = true; rbl_SWMS4.Items[1].Selected = false; } else { rbl_SWMS4.Items[0].Selected = false; rbl_SWMS4.Items[1].Selected = true; } }
                        if (reader.GetValue(0).ToString() == "5") { lbl_SWMS5.Text = reader.GetValue(1).ToString(); if (reader.GetValue(2).ToString() == "1") { rbl_SWMS5.Items[0].Selected = true; rbl_SWMS5.Items[1].Selected = false; } else { rbl_SWMS5.Items[0].Selected = false; rbl_SWMS5.Items[1].Selected = true; } }
                        if (reader.GetValue(0).ToString() == "6") { lbl_SWMS6.Text = reader.GetValue(1).ToString(); if (reader.GetValue(2).ToString() == "1") { rbl_SWMS6.Items[0].Selected = true; rbl_SWMS6.Items[1].Selected = false; } else { rbl_SWMS6.Items[0].Selected = false; rbl_SWMS6.Items[1].Selected = true; } }
                        if (reader.GetValue(0).ToString() == "7") { lbl_SWMS7.Text = reader.GetValue(1).ToString(); if (reader.GetValue(2).ToString() == "1") { rbl_SWMS7.Items[0].Selected = true; rbl_SWMS7.Items[1].Selected = false; } else { rbl_SWMS7.Items[0].Selected = false; rbl_SWMS7.Items[1].Selected = true; } }
                        if (reader.GetValue(0).ToString() == "8") { lbl_SWMS8.Text = reader.GetValue(1).ToString(); if (reader.GetValue(2).ToString() == "1") { rbl_SWMS8.Items[0].Selected = true; rbl_SWMS8.Items[1].Selected = false; } else { rbl_SWMS8.Items[0].Selected = false; rbl_SWMS8.Items[1].Selected = true; } }
                        if (reader.GetValue(0).ToString() == "9") { lbl_SWMS9.Text = reader.GetValue(1).ToString(); if (reader.GetValue(2).ToString() == "1") { rbl_SWMS9.Items[0].Selected = true; rbl_SWMS9.Items[1].Selected = false; } else { rbl_SWMS9.Items[0].Selected = false; rbl_SWMS9.Items[1].Selected = true; } }
                        if (reader.GetValue(0).ToString() == "10") { lbl_SWMS10.Text = reader.GetValue(1).ToString(); if (reader.GetValue(2).ToString() == "1") { rbl_SWMS10.Items[0].Selected = true; rbl_SWMS10.Items[1].Selected = false; } else { rbl_SWMS10.Items[0].Selected = false; rbl_SWMS10.Items[1].Selected = true; } }
                        if (reader.GetValue(0).ToString() == "11") { lbl_SWMS11.Text = reader.GetValue(1).ToString(); if (reader.GetValue(2).ToString() == "1") { rbl_SWMS11.Items[0].Selected = true; rbl_SWMS11.Items[1].Selected = false; } else { rbl_SWMS11.Items[0].Selected = false; rbl_SWMS11.Items[1].Selected = true; } }
                        if (reader.GetValue(0).ToString() == "12") { lbl_SWMS12.Text = reader.GetValue(1).ToString(); if (reader.GetValue(2).ToString() == "1") { rbl_SWMS12.Items[0].Selected = true; rbl_SWMS12.Items[1].Selected = false; } else { rbl_SWMS12.Items[0].Selected = false; rbl_SWMS12.Items[1].Selected = true; } }
                        if (reader.GetValue(0).ToString() == "13") { lbl_SWMS13.Text = reader.GetValue(1).ToString(); if (reader.GetValue(2).ToString() == "1") { rbl_SWMS13.Items[0].Selected = true; rbl_SWMS13.Items[1].Selected = false; } else { rbl_SWMS13.Items[0].Selected = false; rbl_SWMS13.Items[1].Selected = true; } }
                        if (reader.GetValue(0).ToString() == "14") { lbl_SWMS14.Text = reader.GetValue(1).ToString(); if (reader.GetValue(2).ToString() == "1") { rbl_SWMS14.Items[0].Selected = true; rbl_SWMS14.Items[1].Selected = false; } else { rbl_SWMS14.Items[0].Selected = false; rbl_SWMS14.Items[1].Selected = true; } }
                        if (reader.GetValue(0).ToString() == "15") { lbl_SWMS15.Text = reader.GetValue(1).ToString(); if (reader.GetValue(2).ToString() == "1") { rbl_SWMS15.Items[0].Selected = true; rbl_SWMS15.Items[1].Selected = false; } else { rbl_SWMS15.Items[0].Selected = false; rbl_SWMS15.Items[1].Selected = true; } }
                        if (reader.GetValue(0).ToString() == "16") { lbl_SWMS16.Text = reader.GetValue(1).ToString(); if (reader.GetValue(2).ToString() == "1") { rbl_SWMS16.Items[0].Selected = true; rbl_SWMS16.Items[1].Selected = false; } else { rbl_SWMS16.Items[0].Selected = false; rbl_SWMS16.Items[1].Selected = true; } }
                        if (reader.GetValue(0).ToString() == "17") { lbl_SWMS17.Text = reader.GetValue(1).ToString(); if (reader.GetValue(2).ToString() == "1") { rbl_SWMS17.Items[0].Selected = true; rbl_SWMS17.Items[1].Selected = false; } else { rbl_SWMS17.Items[0].Selected = false; rbl_SWMS17.Items[1].Selected = true; } }
                        if (reader.GetValue(0).ToString() == "18") { lbl_SWMS18.Text = reader.GetValue(1).ToString(); if (reader.GetValue(2).ToString() == "1") { rbl_SWMS18.Items[0].Selected = true; rbl_SWMS18.Items[1].Selected = false; } else { rbl_SWMS18.Items[0].Selected = false; rbl_SWMS18.Items[1].Selected = true; } }

                    }
                }
                reader.Close();

            }
        }

        public string GetSkillDocumentType(string pSkillName)
        {
            string strResult = "0";
            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["DataConnectionString"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand("SUBCONREG_GetTradeSkillDocType", conn))
                {

                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@pTradeSkillName", pSkillName);

                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            strResult = reader.GetValue(0).ToString();
                        }
                        reader.NextResult();
                    }
                }
            }
            return strResult;
        }

        public void LoadCheckBoxesFromDB(string pPlacesofWork)
        {
            if (pPlacesofWork.ToUpper().IndexOf("NSW") > -1) { cbx_NSW.Checked = true; } else { cbx_NSW.Checked = false; }
            if (pPlacesofWork.ToUpper().IndexOf("VIC") > -1) { cbx_VIC.Checked = true; } else { cbx_VIC.Checked = false; }
            if (pPlacesofWork.ToUpper().IndexOf("QLD") > -1) { cbx_QLD.Checked = true; } else { cbx_QLD.Checked = false; }
            if (pPlacesofWork.ToUpper().IndexOf("WA") > -1) { cbx_WA.Checked = true; } else { cbx_WA.Checked = false; }
            if (pPlacesofWork.ToUpper().IndexOf("SA") > -1) { cbx_SA.Checked = true; } else { cbx_SA.Checked = false; }
            if (pPlacesofWork.ToUpper().IndexOf("TAS") > -1) { cbx_TAS.Checked = true; } else { cbx_TAS.Checked = false; }
            if (pPlacesofWork.ToUpper().IndexOf("NZ") > -1) { cbx_NEW_ZEALAND.Checked = true; } else { cbx_NEW_ZEALAND.Checked = false; }
        }

        public string GetLocationIdName(string pLocationId)
        {
            string strResult = "";
            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["DataConnectionString"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand("SUBCONREG_ReadSuburbDetails", conn))
                {

                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@pLocationId", pLocationId);

                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            strResult = reader.GetValue(0).ToString();
                        }
                        reader.NextResult();
                    }
                }
            }
            return strResult;
        }       

        protected void btn_ExitAddEmployeeSkill_Click(object sender, EventArgs e)
        {
            AddEmployeeSkillWindow.Visible = false;
            LoadCompanyDetails(Lbl_RequestId.Text);
        }

        protected void btn_SaveEmployeeSkill_Click(object sender, EventArgs e)
        {


            if (!FileUploadControlEmployeeSkill.HasFile)
            {
                lbl_UploadEmployeeSkillError.Text = "This field is required.";
                lbl_UploadEmployeeSkillError.ForeColor = System.Drawing.Color.Red;
                return;
            }


            string strSkillId = GetSkillDocumentType(cbbEmployeeTradeSkillList.Text);
            string commandText = "insert into SUBCONREG_COMPANY_EMPLOYEES_TRADESKILLS (request_id,employee_id,tradeskill_id,tradeskill_desc,license_number,expiry_date) values (" + Lbl_RequestId.Text + "," + lbl_selectedEmployee.Text + "," + strSkillId + ",'" + cbbEmployeeTradeSkillList.Text + "','" + tbx_EmployeeLicenseNumber.Text + "','" + Convert.ToDateTime(tbx_EmployeeLicenseNumberExpDate.Text).ToString("yyyy/MM/dd") + "' ) ";
            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["DataConnectionString"].ConnectionString))
            using (SqlCommand cmd = new SqlCommand(commandText, conn))
            {
                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();
            }

            //UPDATE THE DETAILS FOR THE FILE UPLOAD  -----------------------------------------------------------------------------------------------
            string downloadpath = "";
            string filename = "";
            string path = "";
            string documentpath = "";
            string NewFileName = "";
            if (FileUploadControlEmployeeSkill.HasFile)
            {
                try
                {
                    //Stage 1 save the file in a temporary location in the server
                    downloadpath = Server.MapPath(DA.TemporaryDocumentsFolder);
                    filename = Path.GetFileName(FileUploadControlEmployeeSkill.FileName);

                    if (!Directory.Exists(downloadpath))
                    {
                        Directory.CreateDirectory(downloadpath);
                    }

                    path = String.Format(@"{0}\{1}", downloadpath, filename);
                    FileUploadControlEmployeeSkill.SaveAs(path);
                    //-------------------------------------------------------------------------------

                    //Stage 2 Get a GUID name for table rename the file and copy this file to its final destination and remove the temporary file.
                    documentpath = Server.MapPath(DA.DocumentsPath);
                    documentpath = documentpath + @"\" + DateTime.Now.Year.ToString() + @"\Sucontractor_document";

                    NewFileName = SUBCONREG_EmployeeSkillAddToDatabaseFromDisk(Convert.ToInt32(Lbl_RequestId.Text), Convert.ToInt32(lbl_selectedEmployee.Text), Convert.ToInt32(strSkillId), filename, Convert.ToDateTime(Convert.ToDateTime(tbx_EmployeeLicenseNumberExpDate.Text).ToString("yyyy/MM/dd")));
                    documentpath = documentpath + @"\" + NewFileName;
                    tbx_InductionCardDocId.Text = NewFileName;

                    byte[] tmpFile;
                    tmpFile = DA.GetPhoto(path);


                    if (File.Exists(path))
                    {
                        DA.ByteArrayToFile(documentpath, tmpFile);
                        File.Delete(path);
                    }
                    //-----------------------------------------------------------------------------------
                }
                catch (Exception ex)
                {
                    lbl_UploadInductioncardError.Text = "Upload status: The file could not be uploaded. The following error occured: " + ex.Message;
                }
            }
            //---------------------------------------------------------------------------------------------------------------------------------------

            LoadCompanyDetails(Lbl_RequestId.Text.Trim());
            sqlDS_employeeskills_tmp.SelectCommand = @"select TRADESKILL_ID,
                                                                TRADESKILL_DESC, 
                                                                license_number,
                                                                expiry_date,
                                                                GUID
                                                    from  SUBCONREG_COMPANY_EMPLOYEES_TRADESKILLS
                                                where  request_id = " + Lbl_RequestId.Text + @"
                                                    and  employee_id = " + lbl_selectedEmployee.Text;
            gv_employee_skills_tmp.DataBind();

            //Clear all form fields after adding
            cbbEmployeeTradeSkillList.Text = "";
            tbx_EmployeeLicenseNumber.Text = "";
            tbx_EmployeeLicenseNumberExpDate.Text = "";
            RegularExpressionValidator2.ErrorMessage = "";
            SqlDsEmployeeTradeSkillsList.SelectCommand = "SELECT [Trade_Name] FROM [Insurance_Trade] WHERE ( [Insurance_Trade_ID] not in ( select TRADESKILL_ID from SUBCONREG_COMPANY_EMPLOYEES_TRADESKILLS where request_id =  " + Lbl_RequestId.Text + " and employee_id = " + lbl_selectedEmployee.Text + " ) )";
            cbbEmployeeTradeSkillList.DataBind();
            lbl_UploadEmployeeSkillError.Text = "";

            //--------------------------------------------------------

        }

        protected void btn_AddEmployeeSkill_click(object sender, EventArgs e)
        {

            AddEmployeeSkillWindow.Visible = true;
            GridViewDataItemTemplateContainer c = ((GridViewDataItemTemplateContainer)(((ASPxButton)sender).NamingContainer));
            lbl_selectedEmployee.Text = c.Grid.GetRowValues(c.VisibleIndex, "employee_id").ToString();

            SqlDsEmployeeTradeSkillsList.SelectCommand = "SELECT [Trade_Name] FROM [Insurance_Trade] WHERE ( [Insurance_Trade_ID] not in ( select TRADESKILL_ID from SUBCONREG_COMPANY_EMPLOYEES_TRADESKILLS where request_id =  " + Lbl_RequestId.Text + " and employee_id = " + lbl_selectedEmployee.Text + " ) )";
            cbbEmployeeTradeSkillList.DataBind();


            sqlDS_employeeskills_tmp.SelectCommand = @"select TRADESKILL_ID,
                                                                TRADESKILL_DESC, 
                                                                license_number,
                                                                expiry_date,
                                                                GUID
                                                    from  SUBCONREG_COMPANY_EMPLOYEES_TRADESKILLS
                                                where  request_id = " + Lbl_RequestId.Text + @"
                                                    and  employee_id = " + lbl_selectedEmployee.Text;
            gv_employee_skills_tmp.DataBind();

        }

        protected void Btn_DeleteEmployeeSkill_Click(object sender, EventArgs e)
        {
            GridViewDataItemTemplateContainer c = ((GridViewDataItemTemplateContainer)(((LinkButton)sender).NamingContainer));



            string commandText = "delete  from SUBCONREG_COMPANY_EMPLOYEES_TRADESKILLS where request_id = " + Lbl_RequestId.Text.Trim() + " and tradeskill_id = " + c.Grid.GetRowValues(c.VisibleIndex, "TRADESKILL_ID").ToString() + " and employee_id = " + lbl_selectedEmployee.Text;
            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["DataConnectionString"].ConnectionString))
            using (SqlCommand cmd = new SqlCommand(commandText, conn))
            {
                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();
            }

            LoadCompanyDetails(Lbl_RequestId.Text.Trim());
            sqlDS_employeeskills_tmp.SelectCommand = @"select TRADESKILL_ID,
                                                                TRADESKILL_DESC, 
                                                                license_number,
                                                                expiry_date,
                                                                GUID
                                                    from  SUBCONREG_COMPANY_EMPLOYEES_TRADESKILLS
                                                where  request_id = " + Lbl_RequestId.Text + @"
                                                    and  employee_id = " + lbl_selectedEmployee.Text;
            gv_employee_skills_tmp.DataBind();
            SqlDsEmployeeTradeSkillsList.SelectCommand = "SELECT [Trade_Name] FROM [Insurance_Trade] WHERE ( [Insurance_Trade_ID] not in ( select TRADESKILL_ID from SUBCONREG_COMPANY_EMPLOYEES_TRADESKILLS where request_id =  " + Lbl_RequestId.Text + " and employee_id = " + lbl_selectedEmployee.Text + " ) )";
            cbbEmployeeTradeSkillList.DataBind();

        }

        protected void btn_DeleteSkill_Click(object sender, EventArgs e)
        {
            GridViewDataItemTemplateContainer c = ((GridViewDataItemTemplateContainer)(((LinkButton)sender).NamingContainer));



            string commandText = "delete  from subconreg_company_tradeskills where request_id = " + Lbl_RequestId.Text.Trim() + " and trade_id = " + c.Grid.GetRowValues(c.VisibleIndex, "TRADE_ID").ToString();
            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["DataConnectionString"].ConnectionString))
            using (SqlCommand cmd = new SqlCommand(commandText, conn))
            {
                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();
            }
            LoadCompanyDetails(Lbl_RequestId.Text.Trim());

        }

        public void SUBCONREG_UpdateCompanyTradeSkill(int pRequestId, int pTradeId)
        {

            mySQLConnection = new SqlConnection(DA.ConnStr);
            mySQLConnection.Open();

            myCommand = new SqlCommand("SUBCONREG_UpdateCompanyTradeSkill", mySQLConnection) { CommandType = System.Data.CommandType.StoredProcedure };
            myCommand.Parameters.AddWithValue("@pRequest_Id", pRequestId);
            myCommand.Parameters.AddWithValue("@pTrade_Id", pTradeId);
            myCommand.Parameters.AddWithValue("@pTrade_Description", hpIsTradeSkillDoc["pSkillName"].ToString());
            myCommand.Parameters.AddWithValue("@pLicense_Number", hpIsTradeSkillDoc["pSkillLicenseNumber"].ToString());
            myCommand.Parameters.AddWithValue("@pLicense_ExpDate", Convert.ToDateTime(hpIsTradeSkillDoc["pSkillLicenseExpDate"].ToString()).ToString("yyyy/MM/dd"));


            myCommand.ExecuteNonQuery();
            myCommand.Dispose();
            myCommand = null;
            mySQLConnection.Close();
            mySQLConnection = null;

        }

        protected void ASPxUploadControl1_FileUploadComplete(object sender, FileUploadCompleteEventArgs e)
        {
            string path = UploadDirectory + e.UploadedFile.FileName;
            e.UploadedFile.SaveAs(Server.MapPath(path));
            int vDocumentType = 0;
            DateTime dtDocExpDate = Convert.ToDateTime(Convert.ToDateTime(TmpDocExpDate["pExpDate"].ToString()).ToString("yyyy/MM/dd"));

            string file = string.Format("{0} ({1}KB)", e.UploadedFile.FileName, e.UploadedFile.ContentLength / 1024);
            string url = ResolveClientUrl(path);
            e.CallbackData = url;



            byte[] image;
            byte[] resizedImage;

            string documentpath = Server.MapPath(DA.DocumentsPath);
            string downloadpath = Server.MapPath(DA.TemporaryDocumentsFolder);
            string NewFileName = null;
            Variation Variation = new Variation();

            if (e.IsValid)
            {
                if (!Directory.Exists(downloadpath))
                {
                    Directory.CreateDirectory(downloadpath);
                }

                path = String.Format(@"{0}\{1}", downloadpath, e.UploadedFile.FileName);

                e.UploadedFile.SaveAs(path);

                //-- Get Variation Label and attach to caption                
                //Variation = Variation.GetVariationDetails(QuoteID);

                if (DA.UseDiskStorage)
                {
                    //Identifying the Document type that will be uploaded
                    if (hpDocTypeId["pDocumentTypeID"].ToString().ToUpper().Trim() == "INDUCTION CARD")
                    { vDocumentType = 9991; }
                    if (hpDocTypeId["pDocumentTypeID"].ToString().ToUpper().Trim() == "WORKER COMPENSATION NUMBER")
                    { vDocumentType = 9992; }
                    if (hpDocTypeId["pDocumentTypeID"].ToString().ToUpper().Trim() == "PUBLIC LIABILITY")
                    { vDocumentType = 9993; }
                    if (hpDocTypeId["pDocumentTypeID"].ToString().ToUpper().Trim() == "POLICE CHECK")
                    { vDocumentType = 9994; }

                    //-----------------------------------------------------

                    if ((vDocumentType != 9991) && (vDocumentType != 9992) && (vDocumentType != 9993) && (vDocumentType != 9994))
                    {
                        vDocumentType = Convert.ToInt32(GetSkillDocumentType(hpDocTypeId["pDocumentTypeID"].ToString()));
                        SUBCONREG_UpdateCompanyTradeSkill(Convert.ToInt32(hpRequestId["pRequestId"].ToString()), vDocumentType);
                    }

                    NewFileName = SUBCONREG_DocumentAddToDatabaseFromDisk(Convert.ToInt32(hpRequestId["pRequestId"].ToString()), vDocumentType, e.UploadedFile.FileName, dtDocExpDate);

                    documentpath = documentpath + @"\" + DateTime.Now.Year.ToString() + @"\Sucontractor_document";

                    if (!Directory.Exists(documentpath))
                    {
                        Directory.CreateDirectory(documentpath);
                    }

                    try
                    {
                        image = DA.GetPhoto(path);
                        resizedImage = DA.GetCompressedImage(image);
                    }
                    catch (Exception ex1)
                    {
                        resizedImage = DA.GetPhoto(path);

                    }

                    documentpath = documentpath + @"\" + NewFileName;






                    if (File.Exists(path))
                    {

                        DA.ByteArrayToFile(documentpath, resizedImage);
                        //File.Copy(path, documentpath);
                    }


                    
                }


                Variation = null;
                // delete image from disk after processing to database
                if (File.Exists(path))
                {
                    File.Delete(path);
                }



            }
        }

        public static string SUBCONREG_EmployeeSkillAddToDatabaseFromDisk(int pRequestId, int pEmployeeId, int pDocumentType, string pFileName, DateTime pExpirationDate)
        {
            string Subconreg_DocumentAddToDatabaseFromDisk = null;
            mySQLConnection = new SqlConnection(DA.ConnStr);
            mySQLConnection.Open();
            myCommand = new SqlCommand("SubConReg_EmployeeSkill_Document_Insert_From_Disk", mySQLConnection) { CommandType = System.Data.CommandType.StoredProcedure };
            myCommand.Parameters.AddWithValue("@RequestID", pRequestId);
            myCommand.Parameters.AddWithValue("@EmployeeID", pEmployeeId);
            myCommand.Parameters.AddWithValue("@DocumentTypeId", pDocumentType);
            myCommand.Parameters.AddWithValue("@AttachedFilename", pFileName);
            myCommand.Parameters.AddWithValue("@Expirationdate", pExpirationDate);

            myCommand.Parameters.Add("@NewFileName", SqlDbType.VarChar, 200);
            myCommand.Parameters["@NewFileName"].Direction = ParameterDirection.Output;
            myCommand.ExecuteNonQuery();
            try
            {
                Subconreg_DocumentAddToDatabaseFromDisk = myCommand.Parameters["@NewFileName"].Value.ToString();
            }
            catch (Exception)
            {

            }
            myCommand.Dispose();
            myCommand = null;
            mySQLConnection.Close();
            mySQLConnection = null;
            return Subconreg_DocumentAddToDatabaseFromDisk;
        }

        public static string SUBCONREG_DocumentAddToDatabaseFromDisk(int pRequestId, int pDocumentType, string pFileName, DateTime pExpirationDate)
        {
            string Subconreg_DocumentAddToDatabaseFromDisk = null;
            mySQLConnection = new SqlConnection(DA.ConnStr);
            mySQLConnection.Open();
            myCommand = new SqlCommand("SubConReg_Registration_Document_Insert_From_Disk", mySQLConnection) { CommandType = System.Data.CommandType.StoredProcedure };
            myCommand.Parameters.AddWithValue("@RequestID", pRequestId);
            myCommand.Parameters.AddWithValue("@DocumentTypeId", pDocumentType);
            myCommand.Parameters.AddWithValue("@AttachedFilename", pFileName);
            myCommand.Parameters.AddWithValue("@Expirationdate", pExpirationDate);

            myCommand.Parameters.Add("@NewFileName", SqlDbType.VarChar, 200);
            myCommand.Parameters["@NewFileName"].Direction = ParameterDirection.Output;
            myCommand.ExecuteNonQuery();
            try
            {
                Subconreg_DocumentAddToDatabaseFromDisk = myCommand.Parameters["@NewFileName"].Value.ToString();
            }
            catch (Exception)
            {

            }
            myCommand.Dispose();
            myCommand = null;
            mySQLConnection.Close();
            mySQLConnection = null;
            return Subconreg_DocumentAddToDatabaseFromDisk;
        }

        protected void ASPxUploadControlBIGWORK_FileUploadComplete(object sender, FileUploadCompleteEventArgs e)
        {
            string strRequestId = "";
            string UploadDirectory = "~/Images/";
            string path = UploadDirectory + e.UploadedFile.FileName;
            e.UploadedFile.SaveAs(Server.MapPath(path));
            int vDocumentType = 0;

            string file = string.Format("{0} ({1}KB)", e.UploadedFile.FileName, e.UploadedFile.ContentLength / 1024);
            string url = ResolveClientUrl(path);
            e.CallbackData = url;



            byte[] tmpFile;

            string documentpath = Server.MapPath(DA.DocumentsPath);
            string downloadpath = Server.MapPath(DA.TemporaryDocumentsFolder);
            string NewFileName = null;
            Variation Variation = new Variation();

            if (e.IsValid)
            {
                if (!Directory.Exists(downloadpath))
                {
                    Directory.CreateDirectory(downloadpath);
                }

                path = String.Format(@"{0}\{1}", downloadpath, e.UploadedFile.FileName);

                e.UploadedFile.SaveAs(path);

                //-- Get Variation Label and attach to caption                
                //Variation = Variation.GetVariationDetails(QuoteID);

                if (DA.UseDiskStorage)
                {

                    strRequestId = hpRequestId["pRequestId"].ToString();
                    vDocumentType = 9996;
                    NewFileName = SUBCONREG_DocumentAddToDatabaseFromDisk(Convert.ToInt32(strRequestId), vDocumentType, e.UploadedFile.FileName, System.DateTime.Today);

                    documentpath = documentpath + @"\" + DateTime.Now.Year.ToString() + @"\Sucontractor_document";

                    if (!Directory.Exists(documentpath))
                    {
                        Directory.CreateDirectory(documentpath);
                    }




                    documentpath = documentpath + @"\" + NewFileName;


                    tmpFile = DA.GetPhoto(path);


                    if (File.Exists(path))
                    {

                        DA.ByteArrayToFile(documentpath, tmpFile);
                        //File.Copy(path, documentpath);
                    }




                }


                Variation = null;
                // delete image from disk after processing to database
                if (File.Exists(path))
                {
                    File.Delete(path);
                }



            }
        }
        
        protected void btn_close_Click(object sender, EventArgs e)
        {
            //Close the session and message to user.
            Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", @"<script type=""text/javascript"">setTimeout(()=>{alert('Your session has now been closed. ');},0);</script>");
            ConfigurationManager.AppSettings["SubbieRegistrationRequestId"] = "0";
            Response.Redirect("RegistrationWelcomePage.aspx");
        }      
        
        public void LoadCompanyDetails(string strRequestId)
        {

            string constr = ConfigurationManager.ConnectionStrings["DataConnectionString"].ConnectionString;
            string filedocumentpath = ".." + DA.DocumentsPath.ToString() + @"/" + DateTime.Now.Year.ToString() + @"/Sucontractor_document";
            string documentpath = "~" + DA.DocumentsPath.ToString() + @"\" + DateTime.Now.Year.ToString() + @"\Sucontractor_document";



            using (SqlConnection conn = new SqlConnection(constr))
            {
                using (SqlCommand cmd = new SqlCommand("SUBCONREG_ReadCompanyDetails", conn))
                {

                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@pRequest_Id", strRequestId);

                    conn.Open();

                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.HasRows)
                    {

                        //reader.GetName(1);

                        while (reader.Read())
                        {


                            //lbl_RequestId.Text = reader.GetValue(0).ToString(); //0 REQUEST_ID 
                            tbx_CompanyName.Text = reader.GetValue(1).ToString();//1 COMPANY_NAME 
                            tbx_DirectorName.Text = reader.GetValue(2).ToString();//2 COMPANY_DIRECTOR_NAME
                            tbx_EmailAddress.Text = reader.GetValue(3).ToString();//3 COMPANY_EMAIL_ADDRESS
                            tbx_StreetAddress.Text = reader.GetValue(4).ToString();//4 COMPANY_ADDRESS 


                            cbbPostcodeSuburb.Text = GetLocationIdName(reader.GetValue(5).ToString());
                            cbbPostcodeSuburbVValue["suburbid"] = reader.GetValue(5).ToString();


                            tbx_CompanyABN.Text = reader.GetValue(6).ToString();//6 COMPANY_ABN 
                            tbx_CompensationNumber.Text = reader.GetValue(9).ToString();//9 COMPANY_COMPENSATION_NUMBER 
                            //10 COMPANY_COMPENSATION_DOCID (IMAGE FILE GUID)
                            img_CompensationNumber.ImageUrl = documentpath + "\\" + reader.GetValue(10).ToString(); img_CompensationNumber.Width = new Unit("128px"); img_CompensationNumber.Height = new Unit("96px");

                            tbx_PublicLiability.Text = reader.GetValue(11).ToString();//11 COMPANY_PUBLIC_LIABILITY_NUMBER
                            //12 COMPANY_PUBLIC_LIABILITY_DOCID (IMAGE FILE GUID)
                            img_PublicLiability.ImageUrl = documentpath + "\\" + reader.GetValue(12).ToString(); img_PublicLiability.Width = new Unit("128px"); img_PublicLiability.Height = new Unit("96px");

                            //13 COMPANY_POLICECHECK_DOCID
                            //14 COMPANY_VULNERABLEPERSON_CHECK_DOCID
                            tbx_COMPANY_CONTACT_PERSON.Text = reader.GetValue(15).ToString(); //15 COMPANY_CONTACT_PERSON
                            tbx_COMPANY_CONTACT_POSITION.Text = reader.GetValue(16).ToString();//16 COMPANY_CONTACT_POSITION 
                            tbx_COMPANY_CONTACT_PHONE.Text = reader.GetValue(17).ToString();//17 COMPANY_CONTACT_PHONE 
                            tbx_CompanyContactPhone.Text = reader.GetValue(17).ToString();//17 COMPANY_CONTACT_PHONE 
                            tbx_COMPANY_CONTACT_EMAILADDRESS.Text = reader.GetValue(18).ToString();//18 COMPANY_CONTACT_EMAILADDRESS
                            tbx_jobcapacity30days.Text = reader.GetValue(19).ToString();//19 COMPANY_JOB_CAPACITY_30_DAYS
                            tbx_averagevaluejob.Text = reader.GetValue(20).ToString();//20 COMPANY_AVERAGE_VALUEXJOB 
                            //21 COMPANY_GENERIC_SAFETYPLAN_DOCID


                            //22 COMPANY_DID_WORK_WITH_MAINCOM                           
                            if (reader.GetValue(22).ToString() == "1")
                            { rbtn_COMPANY_DID_WORK_WITH_MAINCOM.Items[0].Selected = true; rbtn_COMPANY_DID_WORK_WITH_MAINCOM.Items[1].Selected = false; }
                            else
                            { rbtn_COMPANY_DID_WORK_WITH_MAINCOM.Items[0].Selected = false; rbtn_COMPANY_DID_WORK_WITH_MAINCOM.Items[1].Selected = true; }

                            tbx_COMPANY_DID_WORK_WITH_MAINCOM_DETAILS.Text = reader.GetValue(23).ToString();//23 COMPANY_DID_WORK_WITH_MAINCOM_DETAILS
                            //24 COMPANY_HAS_CORRECTIVE_PREVIOUS_JOBS
                            if (reader.GetValue(24).ToString() == "1")
                            { rbtn_COMPANY_HAS_CORRECTIVE_PREVIOUS_JOBS.Items[0].Selected = true; rbtn_COMPANY_HAS_CORRECTIVE_PREVIOUS_JOBS.Items[1].Selected = false; }
                            else
                            { rbtn_COMPANY_HAS_CORRECTIVE_PREVIOUS_JOBS.Items[0].Selected = false; rbtn_COMPANY_HAS_CORRECTIVE_PREVIOUS_JOBS.Items[1].Selected = true; }
                            tbx_COMPANY_HAS_CORRECTIVE_PREVIOUS_JOBS_DETAILS.Text = reader.GetValue(25).ToString();//25 COMPANY_HAS_CORRECTIVE_PREVIOUS_JOBS_DETAILS



                            tbx_COMPANY_BANK_NAME.Text = reader.GetValue(26).ToString();//26 COMPANY_BANK_NAME 
                            tbx_COMPANY_BANK_ACCOUNT_NO.Text = reader.GetValue(27).ToString();//27 COMPANY_BANK_ACCOUNT_NO
                            tbx_COMPANY_BANK_ACCOUNT_BSB.Text = reader.GetValue(28).ToString();//28 COMPANY_BANK_ACCOUNT_BSB
                            tbx_COMPANY_BANK_ACCOUNT_NAME.Text = reader.GetValue(29).ToString();//29 COMPANY_BANK_ACCOUNT_NAME
                            tbx_COMPANY_REFERENCE1_NAME.Text = reader.GetValue(30).ToString();//30 COMPANY_REFERENCE1_NAME
                            tbx_COMPANY_REFERENCE1_COMPANY.Text = reader.GetValue(31).ToString();//31 COMPANY_REFERENCE1_COMPANY 
                            tbx_COMPANY_REFERENCE1_POSITION.Text = reader.GetValue(32).ToString();//32 COMPANY_REFERENCE1_POSITION
                            tbx_COMPANY_REFERENCE1_EMAIL.Text = reader.GetValue(33).ToString();//33 COMPANY_REFERENCE1_EMAIL 
                            tbx_COMPANY_REFERENCE1_PHONE.Text = reader.GetValue(34).ToString();//34 COMPANY_REFERENCE1_PHONE   

                            //35[COMPANY_INDUCTION_CARDEXPDATE] 

                            if (reader.GetValue(36).ToString() != "") { tbx_CompensationNumberExpDate.Text = Convert.ToDateTime(reader.GetValue(36)).ToString("dd/MM/yyyy"); }//36[COMPANY_COMPENSATION_NUMBEREXPDATE] ,
                            if (reader.GetValue(37).ToString() != "") { tbx_PublicLiabilityExpDate.Text = Convert.ToDateTime(reader.GetValue(37)).ToString("dd/MM/yyyy"); }//37[COMPANY_PUBLICLIABILITY_NUMBEREXPDATE],

                            LoadCheckBoxesFromDB(reader.GetValue(40).ToString());//40 [COMPANY_PLACESOFWORK]    

                            //41 [COMPANY_SWMS_DOCID] --------------------------------------------
                            if (reader.GetValue(41).ToString().Length > 0)
                            {
                                tbx_SWMS_DOCID.Text = reader.GetValue(41).ToString();
                                lnk_viewswmsdoc.Visible = true;
                                lnk_viewswmsdoc.HRef = filedocumentpath + "/" + reader.GetValue(41).ToString();
                            }
                            else
                            {
                                lnk_viewswmsdoc.Visible = false;
                            }
                            //-------------------------------------------------------------------

                            //42 [COMPANY_LARGECAPACITY_WORK]
                            if (reader.GetValue(42).ToString() == "1")
                            {
                                rbtn_CompanyCanDoLargeWork.Items[0].Selected = true;
                                rbtn_CompanyCanDoLargeWork.Items[1].Selected = false;
                                if (tbx_SWMS_DOCID.Text.Trim().Length > 0)
                                {
                                    lnk_viewgenericsafetyplan.Visible = true;
                                    lnk_viewgenericsafetyplan.HRef = filedocumentpath + "/" + tbx_SWMS_DOCID.Text.Trim();
                                }
                                else
                                {
                                    lnk_viewgenericsafetyplan.Visible = true;
                                }
                                Page.ClientScript.RegisterStartupScript(this.GetType(), "clientscript", "document.getElementById('bigwork').style.visibility = 'visible';", true);
                            }
                            else
                            {
                                rbtn_CompanyCanDoLargeWork.Items[0].Selected = false;
                                rbtn_CompanyCanDoLargeWork.Items[1].Selected = true;
                                Page.ClientScript.RegisterStartupScript(this.GetType(), "clientscript", "document.getElementById('bigwork').style.visibility = 'hidden';", true);
                            }
                            //----------------------------------------------------------------------------------------------------
                            tbx_GENERICSAFETYPLAN_DOCID.Text = reader.GetValue(43).ToString(); //43 [GENERICSAFETYPLAN_DOCID]
                            //44 [AGREE_USE_MAINCOM_PORTAL]
                            if (reader.GetValue(44).ToString() == "1") { cbl_agree_maincom_site.Items[0].Selected = true; } else { cbl_agree_maincom_site.Items[0].Selected = false; }
                            //45 [AGREE_USE_MAINCOM_INVOICES]
                            if (reader.GetValue(45).ToString() == "1") { cbl_agree_maincom_invoices.Items[0].Selected = true; } else { cbl_agree_maincom_invoices.Items[0].Selected = false; }

                            LoadSWMSfromDB(strRequestId);


                        }
                        reader.NextResult();
                    }


                    conn.Close();
                }
            }



            //sqlDS_TradeSkills.SelectCommand = "SELECT [TRADE_ID], [TRADE_DESCRIPTION], [LICENSE_NUMBER], [LICENSE_EXPDATE],'" + documentpath + "\\" + "'+ GUID as GUID FROM [SUBCONREG_COMPANY_TRADESKILLS] WHERE [REQUEST_ID] = " + strRequestId;
            sqlDS_TradeSkills.SelectCommand = "SELECT [TRADE_ID], [TRADE_DESCRIPTION], [LICENSE_NUMBER], [LICENSE_EXPDATE],'" + documentpath + "\\" + "'+ GUID as GUID,'" + filedocumentpath + "/' + GUID AS GUID1 FROM [SUBCONREG_COMPANY_TRADESKILLS] WHERE [REQUEST_ID] = " + strRequestId;
            CompanyTradeSkills.DataBind();


            SqlDsTradeSkillsList.SelectCommand = "SELECT [Trade_Name] FROM [Insurance_Trade] WHERE ( [Insurance_Trade_ID] not in ( select trade_id from subconreg_company_tradeskills where request_id =  " + strRequestId + " ) )";
            cbbTradeSkillList.DataBind();

            sqlDS_employees.SelectCommand = @"   select employee_id,
                                                        name +' '+ surname as employee,                                                                     
                                                        email,
                                                        phone,
                                                        mobile,
                                                        INDUCTION_CARD_NUMBER ,
                                                        convert(varchar(10),NDUCTION_CARD_EXPIRYDATE,103) as NDUCTION_CARD_EXPIRYDATE,
                                                        '" + filedocumentpath + @"/'+INDUCTION_CARD_DOCID AS INDUCTION_CARD_DOCID,
                                                        POLICECHECK_REFERENCE ,
                                                        convert(varchar(10),POLICECHECK_EXPIRYDATE,103) as POLICECHECK_EXPIRYDATE,
                                                        '" + filedocumentpath + @"/'+POLICECHECK_DOCID AS POLICECHECK_DOCID                                                                     
                                                from  SUBCONREG_COMPANY_EMPLOYEES
                                                where  Request_id = " + strRequestId;
            gv_employees.DataBind();

            for (int i = 0; i < gv_employees.VisibleRowCount; i++)
            {
                //c.Grid.GetRowValues(c.VisibleIndex, "TRADE_ID").ToString()
                SqlDataSource AuxDataSource = gv_employees.FindRowCellTemplateControl(i, gv_employees.Columns["skills"] as GridViewDataColumn, "sqlDS_employeeskills") as SqlDataSource;
                ASPxGridView AuxGridView = gv_employees.FindRowCellTemplateControl(i, gv_employees.Columns["skills"] as GridViewDataColumn, "gv_employee_skills") as ASPxGridView;


                AuxDataSource.SelectCommand = @"select TRADESKILL_ID,
                                                                                TRADESKILL_DESC, 
                                                                                license_number,                                                                              
                                                                                convert(varchar(10), expiry_date,103) as  expiry_date,                                                                            
                                                                                '" + filedocumentpath + @"/'+ GUID AS GUID
                                                                    from  SUBCONREG_COMPANY_EMPLOYEES_TRADESKILLS
                                                                where  request_id = " + strRequestId + @"
                                                                    and  employee_id = " + gv_employees.GetRowValues(i, "employee_id").ToString();
                AuxGridView.DataBind();




            }
            //Validation of the application.
            string strErrors = IsApplicationComplete();
            if (strErrors == "")
            {

                lbl_ReqStatus.Text = "APPLICATION STATUS - COMPLETED";
                lbl_ReqStatus.ForeColor = System.Drawing.Color.DarkGreen;

                //Calculating the state of the application .---------------------
                string strApplicationStatus = CheckApplicationStatus();
                //we must display all the missing points to be completed.   
                ErrorWindow.Visible = true;
                ErrorList.Text = strApplicationStatus;
                btn_sumitapplication.Visible = true;


            }
            else
            {

                lbl_ReqStatus.Text = "APPLICATION STATUS - INCOMPLETE";
                lbl_ReqStatus.ForeColor = System.Drawing.Color.DarkRed;
                btn_sumitapplication.Visible = false;

            }









        }
       
        protected void Page_Load(object sender, EventArgs e)
        {           


            if (ConfigurationManager.AppSettings["SubbieRegistrationRequestId"].ToString() == "0")
            {
                Response.Redirect("RegistrationWelcomePage.aspx");

            }

            if (!IsPostBack)
            {
                Lbl_RequestId.Text = ConfigurationManager.AppSettings["SubbieRegistrationRequestId"].ToString();
                //LNKBTN_TC1.HRef = ".." + DA.DocumentsPath.ToString() + @"/TermsAndConditionsOfTrade.pdf";
                //LNKBTN_TC2.HRef = ".." + DA.DocumentsPath.ToString() + @"/TermsAndConditionsWorkOrder.pdf";
                LoadCompanyDetails(Lbl_RequestId.Text);
              

            }

        }

       

        protected int GetNewEmployeeCode(string strRequestId)
        {
            int iResult = 0;
            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["DataConnectionString"].ConnectionString))
            {

                SqlCommand cmd = new SqlCommand(@"  select isnull(max(employee_id),0)+1 
                                                      from subconreg_company_employees
                                                     where request_id = " + strRequestId, conn);

                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.HasRows)
                {
                    while (reader.Read())
                    {
                        iResult = Convert.ToInt32(reader.GetValue(0).ToString());
                    }
                }
                reader.Close();

            }

            return iResult;
        }

        public void SaveEmployee(string strRequestid, string strEmployeeId)
        {
            bool bErrorFound = false;

            lbl_UploadInductioncardError.Text = "";
            lbl_PoliceCheckError.Text = "";

            if (FileUploadControlInductionCard.HasFile == false)
            {
                lbl_UploadInductioncardError.Text = "This Field is required, please select a file using the choose file button";
                bErrorFound = true;
            }
            else
            {
                if ( FileUploadControlInductionCard.FileName.ToUpper().IndexOf(".PDF") < 1 &&
                     FileUploadControlInductionCard.FileName.ToUpper().IndexOf(".JPEG") < 1 &&
                     FileUploadControlInductionCard.FileName.ToUpper().IndexOf(".JPG") < 1 &&
                    FileUploadControlInductionCard.FileName.ToUpper().IndexOf(".PNG") < 1 &&
                    FileUploadControlInductionCard.FileName.ToUpper().IndexOf(".GIF") < 1 &&
                    FileUploadControlInductionCard.FileName.ToUpper().IndexOf(".DOC") < 1 &&
                    FileUploadControlInductionCard.FileName.ToUpper().IndexOf(".DOCX") < 1 
                   )
                {
                    lbl_UploadInductioncardError.Text = "Invalid File type, valid extensions are: PDF,JPEG,JPG, PNG,GIF,DOC,DOX";
                    bErrorFound = true;
                }
            }
            if (FileUploadPoliceCheck.HasFile == false)
            {
                lbl_PoliceCheckError.Text = "This Field is required, please select a file using the choose file button";
                bErrorFound = true;
            }
            else
            {
                if (FileUploadPoliceCheck.FileName.ToUpper().IndexOf(".PDF") < 1 &&
                     FileUploadPoliceCheck.FileName.ToUpper().IndexOf(".JPEG") < 1 &&
                     FileUploadPoliceCheck.FileName.ToUpper().IndexOf(".JPG") < 1 &&
                    FileUploadPoliceCheck.FileName.ToUpper().IndexOf(".PNG") < 1 &&
                    FileUploadPoliceCheck.FileName.ToUpper().IndexOf(".GIF") < 1 &&
                    FileUploadPoliceCheck.FileName.ToUpper().IndexOf(".DOC") < 1 &&
                    FileUploadPoliceCheck.FileName.ToUpper().IndexOf(".DOCX") < 1
                   )
                {
                    lbl_PoliceCheckError.Text = "Invalid File type, valid extensions are: PDF,JPEG,JPG, PNG,GIF,DOC,DOX";
                    bErrorFound = true;
                }
            }
            if (bErrorFound == true)
            {
                Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", @"<script type=""text/javascript"">setTimeout(()=>{alert('The CONSTRUCTION INDUCTION CARD or POLICE CHECK documents are invalid, please read the error messages for further help.');},0);</script>");
                return;
            }

            int iNewEmployeeCode = 0;
            string strSql = "";

            if (strEmployeeId == "")
            {
                iNewEmployeeCode = GetNewEmployeeCode(strRequestid);
                strSql = @"insert into subconreg_company_employees (request_id,employee_id,name,surname,email, mobile,phone,INDUCTION_CARD_NUMBER,NDUCTION_CARD_EXPIRYDATE,POLICECHECK_REFERENCE,POLICECHECK_EXPIRYDATE) values (" + strRequestid + "," + iNewEmployeeCode.ToString() + ",'" + tbx_employee_NAME.Text + "','" + tbx_employee_SURNAME.Text + "','" + tbx_EmailAddress.Text + "','" + tbx_employee_MOBILE.Text + "','" + tbx_employee_PHONE.Text + "','" + tbx_InductionCard.Text + "','" + Convert.ToDateTime(tbx_InductionCardExpDate.Text).ToString("yyyy/MM/dd") + "','" + tbx_POLICECHECK_REFERENCE.Text + "','" + Convert.ToDateTime(tbx_POLICECHECK_EXPIRYDATE.Text).ToString("yyyy/MM/dd") + "')";
                tbx_EmployeeId.Text = iNewEmployeeCode.ToString();

            }
            else
            {
                strSql = @"update   subconreg_company_employees set 
                                    name    = '" + tbx_employee_NAME.Text + @"',
                                    surname = '" + tbx_employee_SURNAME.Text + @"',
                                    email   = '" + tbx_employee_EMAIL.Text + @"', 
                                    mobile  = '" + tbx_employee_MOBILE.Text + @"',
                                    phone   = '" + tbx_employee_PHONE.Text + @"',
                                    INDUCTION_CARD_NUMBER     = '" + tbx_InductionCard.Text + @"',    
                                    INDUCTION_CARD_EXPIRYDATE = '" + Convert.ToDateTime(tbx_InductionCardExpDate.Text).ToString("yyyy/MM/dd") + @"',   
                                    POLICECHECK_REFERENCE     = '" + tbx_POLICECHECK_REFERENCE.Text + @"',
                                    POLICECHECK_EXPIRYDATE    = '" + Convert.ToDateTime(tbx_POLICECHECK_EXPIRYDATE.Text).ToString("yyyy/MM/dd") + @"'   
                            where   request_id =  " + strRequestid + @" ,
                              and   employee_id = " + strEmployeeId;
            }

            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["DataConnectionString"].ConnectionString);
            SqlCommand myCommand = new SqlCommand(strSql, conn);
            conn.Open();
            myCommand.ExecuteNonQuery();
            conn.Close();





            //upload the induction card Document and Police Check Document-------------------------------------------------------------------------------------
            string downloadpath = "";
            string filename = "";
            string path = "";
            string documentpath = "";
            string NewFileName = "";
            if (FileUploadControlInductionCard.HasFile)
            {
                try
                {
                    //Stage 1 save the file in a temporary location in the server
                    downloadpath = Server.MapPath(DA.TemporaryDocumentsFolder);
                    filename = Path.GetFileName(FileUploadControlInductionCard.FileName);

                    if (!Directory.Exists(downloadpath))
                    {
                        Directory.CreateDirectory(downloadpath);
                    }

                    path = String.Format(@"{0}\{1}", downloadpath, filename);
                    FileUploadControlInductionCard.SaveAs(path);
                    //-------------------------------------------------------------------------------

                    //Stage 2 Get a GUID name for table rename the file and copy this file to its final destination and remove the temporary file.
                    documentpath = Server.MapPath(DA.DocumentsPath);
                    documentpath = documentpath + @"\" + DateTime.Now.Year.ToString() + @"\Sucontractor_document";

                    NewFileName = SUBCONREG_EmployeeSkillAddToDatabaseFromDisk(Convert.ToInt32(Lbl_RequestId.Text), Convert.ToInt32(tbx_EmployeeId.Text), 9991, filename, Convert.ToDateTime(Convert.ToDateTime(tbx_InductionCardExpDate.Text).ToString("yyyy/MM/dd")));
                    documentpath = documentpath + @"\" + NewFileName;
                    tbx_InductionCardDocId.Text = NewFileName;

                    byte[] tmpFile;
                    tmpFile = DA.GetPhoto(path);


                    if (File.Exists(path))
                    {
                        DA.ByteArrayToFile(documentpath, tmpFile);
                        File.Delete(path);
                    }
                    //-----------------------------------------------------------------------------------
                }
                catch (Exception ex)
                {
                    lbl_UploadInductioncardError.Text = "Upload status: The file could not be uploaded. The following error occured: " + ex.Message;
                }
            }


            if (FileUploadPoliceCheck.HasFile)
            {
                try
                {
                    //Stage 1 save the file in a temporary location in the server
                    downloadpath = Server.MapPath(DA.TemporaryDocumentsFolder);
                    filename = Path.GetFileName(FileUploadPoliceCheck.FileName);

                    if (!Directory.Exists(downloadpath))
                    {
                        Directory.CreateDirectory(downloadpath);
                    }

                    path = String.Format(@"{0}\{1}", downloadpath, filename);
                    FileUploadPoliceCheck.SaveAs(path);
                    //-------------------------------------------------------------------------------

                    //Stage 2 Get a GUID name for table rename the file and copy this file to its final destination and remove the temporary file.
                    documentpath = Server.MapPath(DA.DocumentsPath);
                    documentpath = documentpath + @"\" + DateTime.Now.Year.ToString() + @"\Sucontractor_document";

                    NewFileName = SUBCONREG_EmployeeSkillAddToDatabaseFromDisk(Convert.ToInt32(Lbl_RequestId.Text), Convert.ToInt32(tbx_EmployeeId.Text), 9994, filename, Convert.ToDateTime(Convert.ToDateTime(tbx_POLICECHECK_EXPIRYDATE.Text).ToString("yyyy/MM/dd")));
                    documentpath = documentpath + @"\" + NewFileName;
                    tbx_POLICECHECK_DOCID.Text = NewFileName;

                    byte[] tmpFile;
                    tmpFile = DA.GetPhoto(path);


                    if (File.Exists(path))
                    {
                        DA.ByteArrayToFile(documentpath, tmpFile);
                        File.Delete(path);
                    }
                    //-----------------------------------------------------------------------------------
                }
                catch (Exception ex)
                {
                    lbl_PoliceCheckError.Text = "Upload status: The file could not be uploaded. The following error occured: " + ex.Message;
                }
            }
            //----------------------------------------------------------------------------------------------------------------------------
            Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", @"<script type=""text/javascript"">setTimeout(()=>{alert('Employee added successfully. ');},0);</script>");
            AddEmployeeWindow.Visible = false;
            LoadCompanyDetails(Lbl_RequestId.Text);
            //hpEmployeeId.Set("pEmployeeId", tbx_EmployeeId.Text);

        }

        protected void btn_SaveEmployee_Click(object sender, EventArgs e)
        {
            //string strRequestid = hpRequestId["pRequestId"].ToString();
            SaveEmployee(Lbl_RequestId.Text, tbx_EmployeeId.Text);




        }

        protected void btn_SaveRequest_Click(object sender, EventArgs e)
        {
            if (Lbl_RequestId.Text.Replace("Request", "").Trim() != "")
            {


                SUBCONREG_UpdateCompanyDetails(Lbl_RequestId.Text.Replace("Request", "").Trim(),"PRE APPROVED");
            }
            else
            {
                //will need to show a message here for the user saying that a request number must be selected before saving data.
            }
        }

        protected void Btn_DeleteEmployee_Click(object sender, EventArgs e)
        {
            GridViewDataItemTemplateContainer c = ((GridViewDataItemTemplateContainer)(((LinkButton)sender).NamingContainer));


            //Deleting and Employee will require to delete all trade skill linked to the employee firs then we will delete the employee data.
            string commandText = "delete  from SUBCONREG_COMPANY_EMPLOYEES_TRADESKILLS where request_id = " + Lbl_RequestId.Text.Trim() + " and Employee_id= " + c.Grid.GetRowValues(c.VisibleIndex, "employee_id").ToString();
            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["DataConnectionString"].ConnectionString))
            using (SqlCommand cmd = new SqlCommand(commandText, conn))
            {
                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();
            }
            commandText = "delete  from SUBCONREG_COMPANY_EMPLOYEES where request_id = " + Lbl_RequestId.Text.Trim() + " and Employee_id= " + c.Grid.GetRowValues(c.VisibleIndex, "employee_id").ToString();
            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["DataConnectionString"].ConnectionString))
            using (SqlCommand cmd = new SqlCommand(commandText, conn))
            {
                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();
            }
            //---------------------------------------------------------------------------------------------------------------------------------------
            LoadCompanyDetails(Lbl_RequestId.Text.Trim());
        }

        protected void Btn_EditDocument_Click(object sender, EventArgs e)
        {

            GridViewDataItemTemplateContainer c = ((GridViewDataItemTemplateContainer)(((LinkButton)sender).NamingContainer));
            LoadCompanyDetails(c.Grid.GetRowValues(c.VisibleIndex, "request_id").ToString());
            Lbl_RequestId.Text = c.Grid.GetRowValues(c.VisibleIndex, "request_id").ToString();
            hpRequestId.Set("pRequestId", c.Grid.GetRowValues(c.VisibleIndex, "request_id").ToString());


            for (int i = 0; i < c.Grid.VisibleRowCount; i++)
                if (i == c.VisibleIndex)
                { c.Grid.Selection.SelectRow(c.VisibleIndex); }
                else
                { c.Grid.Selection.SetSelection(i, false); }

        }

        protected void btn_ExitAddEmployee_Click(object sender, EventArgs e)
        {
            AddEmployeeWindow.Visible = false;
            LoadCompanyDetails(Lbl_RequestId.Text);
        }

        protected void btn_AddEmployee_Click(object sender, EventArgs e)
        {
            if (Lbl_RequestId.Text != "")
            {
                AddEmployeeWindow.Visible = true;
                hpRequestId.Set("pRequestId", Lbl_RequestId.Text);
                
                //Clear the form to start adding a new employee
                tbx_EmployeeId.Text = "";
                tbx_employee_NAME.Text="";
                tbx_employee_SURNAME.Text="";
                tbx_employee_EMAIL.Text="";
                tbx_employee_PHONE.Text="";
                tbx_employee_MOBILE.Text="";

                tbx_InductionCard.Text="";
                tbx_InductionCardExpDate.Text="";
                tbx_InductionCardDocId.Text="";

                tbx_POLICECHECK_REFERENCE.Text="";
                tbx_POLICECHECK_EXPIRYDATE.Text="";
                tbx_POLICECHECK_DOCID.Text = "";
                
                lbl_PoliceCheckError.Text = "";
                lbl_UploadInductioncardError.Text = "";
                //----------------------------------------------------
            }
            else
            {
                Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", @"<script type=""text/javascript"">setTimeout(()=>{alert('You Must select a REQUEST from the LIST ABOVE before. ');},0);</script>");
            }
        }       
       

        protected void cbbPostcodeSuburb_ItemsRequestedByFilterCondition(object source, ListEditItemsRequestedByFilterConditionEventArgs e)
        {
            ASPxComboBox comboBox = (ASPxComboBox)source;
            SqlSuburb.SelectCommand =
                @"SELECT SUB.ID, SUB.Suburb FROM " +
                @"(SELECT Location_Id AS ID, RTRIM([full_name]) AS Suburb, ROW_NUMBER() OVER (ORDER BY [full_name]) AS Row FROM dbo.Location WITH (NOLOCK) where field1 LIKE @filter) " +
                @"SUB WHERE Row between @startIndex and @endIndex";

            SqlSuburb.SelectParameters.Clear();
            SqlSuburb.SelectParameters.Add("filter", TypeCode.String, string.Format("%{0}%", e.Filter));
            SqlSuburb.SelectParameters.Add("startIndex", TypeCode.Int64, (e.BeginIndex + 1).ToString());
            SqlSuburb.SelectParameters.Add("endIndex", TypeCode.Int64, (e.EndIndex + 1).ToString());
            comboBox.DataSource = SqlSuburb;
            comboBox.DataBind();
        }

        protected void cbbPostcodeSuburb_ItemRequestedByValue(object source, ListEditItemRequestedByValueEventArgs e)
        {


            long value = 0;
            if (!Int64.TryParse(e.Value.ToString(), out value))
                return;
            ASPxComboBox comboBox = (ASPxComboBox)source;
            SqlSuburb.SelectCommand = @"SELECT Location_Id AS ID,  RTRIM([full_name]) AS Suburb FROM dbo.Location WITH (NOLOCK) WHERE (Location_Id = @ID)";
            SqlSuburb.SelectParameters.Clear();
            SqlSuburb.SelectParameters.Add("ID", TypeCode.Int64, e.Value.ToString());
            comboBox.DataSource = SqlSuburb;
            comboBox.DataBind();
        }


        protected void gv_allrequests_HtmlDataCellPrepared(object sender, ASPxGridViewTableDataCellEventArgs e)
        {
            if (e.DataColumn.FieldName == "approval")
            {
                LinkButton tmpLinkButton = ((ASPxGridView)sender).FindRowCellTemplateControl(e.VisibleIndex, e.DataColumn, "btn_ApproveReq") as LinkButton;
                if (((ASPxGridView)sender).GetRowValues(e.VisibleIndex, "request_state").ToString() == "SUBMITED")
                {

                    tmpLinkButton.Visible = true;
                }
                else
                {
                    tmpLinkButton.Visible = false;
                }

            }

        }

        public string CalculateStatesFromCheckBoxes()
        {
            string strResult = "";

            if (cbx_NSW.Checked == true) { strResult = strResult + "NSW,"; }
            if (cbx_VIC.Checked == true) { strResult = strResult + "VIC,"; }
            if (cbx_QLD.Checked == true) { strResult = strResult + "QLD,"; }
            if (cbx_WA.Checked == true) { strResult = strResult + "WA,"; }
            if (cbx_SA.Checked == true) { strResult = strResult + "SA,"; }
            if (cbx_TAS.Checked == true) { strResult = strResult + "TAS,"; }
            if (cbx_NEW_ZEALAND.Checked == true) { strResult = strResult + "NZ,"; }

            if (strResult.Length > 1) { strResult = strResult.Substring(0, strResult.Length - 1); }

            return strResult;
        }

        protected void btn_submitapplication_Click(object sender, EventArgs e)
        {
            //Aplication is complete and now we have to update the status of the application.
            ErrorWindow.Visible = true;
            UpdateRequestState(ConfigurationManager.AppSettings["SubbieRegistrationRequestId"].ToString(), "COMPLETED");
            lbl_ReqStatus.Text = "APPLICATION STATUS - COMPLETED";
            lbl_ReqStatus.ForeColor = System.Drawing.Color.DarkGreen;

            //Prepare text for user with details about what is next when you submit.
            string strResult = "";
            strResult = "<p><b><font size=\"4\" color=\"#0099CC\">THANK YOU FOR SUBMITTING YOUR APPLICATION  </font></b></p><br/>";
            
            strResult = strResult + "<p>An officer at Maincom will NOW be notified  and will revise your application shortly.</p>";
            strResult = strResult + "<p>If your application is successful you will be contacted by an officer from Maincom.</p><br/><br/>";
            strResult = strResult + "<p>Remember you re visit this site and modify your company information at any time.<br/><br/> </p>";
            strResult = strResult + "<p>Thanks for taking the time to complete this application form. </p>";
            ErrorWindow.Visible = true;
            //ErrorsList.InnerHtml = strErrors;
            ErrorList.Text = strResult;
            //--------------------------------------------------------------------
            SendPart2CompletedNotification(tbx_CompanyName.Text, ConfigurationManager.AppSettings["NewSubbieRequestsAdministrator"].ToString());

        }

        public void Update_Company_SWMS()
        {
            int tmpAnswerValue = 0;
            mySQLConnection = new SqlConnection(DA.ConnStr);
            mySQLConnection.Open();

            if (rbl_SWMS1.Items[0].Selected == true) { tmpAnswerValue = 1; } else { tmpAnswerValue = 0; }
            myCommand = new SqlCommand("SUBCONREG_UpdateCompanySWMSitem", mySQLConnection) { CommandType = System.Data.CommandType.StoredProcedure };
            myCommand.Parameters.AddWithValue("@pRequest_Id", ConfigurationManager.AppSettings["SubbieRegistrationRequestId"].ToString());
            myCommand.Parameters.AddWithValue("@pSWMS_Id", 1);
            myCommand.Parameters.AddWithValue("@pAnswerValue", tmpAnswerValue);
            myCommand.ExecuteNonQuery();

            if (rbl_SWMS2.Items[0].Selected == true) { tmpAnswerValue = 1; } else { tmpAnswerValue = 0; }
            myCommand = new SqlCommand("SUBCONREG_UpdateCompanySWMSitem", mySQLConnection) { CommandType = System.Data.CommandType.StoredProcedure };
            myCommand.Parameters.AddWithValue("@pRequest_Id", ConfigurationManager.AppSettings["SubbieRegistrationRequestId"].ToString());
            myCommand.Parameters.AddWithValue("@pSWMS_Id", 2);
            myCommand.Parameters.AddWithValue("@pAnswerValue", tmpAnswerValue);
            myCommand.ExecuteNonQuery();

            if (rbl_SWMS3.Items[0].Selected == true) { tmpAnswerValue = 1; } else { tmpAnswerValue = 0; }
            myCommand = new SqlCommand("SUBCONREG_UpdateCompanySWMSitem", mySQLConnection) { CommandType = System.Data.CommandType.StoredProcedure };
            myCommand.Parameters.AddWithValue("@pRequest_Id", ConfigurationManager.AppSettings["SubbieRegistrationRequestId"].ToString());
            myCommand.Parameters.AddWithValue("@pSWMS_Id", 3);
            myCommand.Parameters.AddWithValue("@pAnswerValue", tmpAnswerValue);
            myCommand.ExecuteNonQuery();

            if (rbl_SWMS4.Items[0].Selected == true) { tmpAnswerValue = 1; } else { tmpAnswerValue = 0; }
            myCommand = new SqlCommand("SUBCONREG_UpdateCompanySWMSitem", mySQLConnection) { CommandType = System.Data.CommandType.StoredProcedure };
            myCommand.Parameters.AddWithValue("@pRequest_Id", ConfigurationManager.AppSettings["SubbieRegistrationRequestId"].ToString());
            myCommand.Parameters.AddWithValue("@pSWMS_Id", 4);
            myCommand.Parameters.AddWithValue("@pAnswerValue", tmpAnswerValue);
            myCommand.ExecuteNonQuery();


            if (rbl_SWMS5.Items[0].Selected == true) { tmpAnswerValue = 1; } else { tmpAnswerValue = 0; }
            myCommand = new SqlCommand("SUBCONREG_UpdateCompanySWMSitem", mySQLConnection) { CommandType = System.Data.CommandType.StoredProcedure };
            myCommand.Parameters.AddWithValue("@pRequest_Id", ConfigurationManager.AppSettings["SubbieRegistrationRequestId"].ToString());
            myCommand.Parameters.AddWithValue("@pSWMS_Id", 5);
            myCommand.Parameters.AddWithValue("@pAnswerValue", tmpAnswerValue);
            myCommand.ExecuteNonQuery();


            if (rbl_SWMS6.Items[0].Selected == true) { tmpAnswerValue = 1; } else { tmpAnswerValue = 0; }
            myCommand = new SqlCommand("SUBCONREG_UpdateCompanySWMSitem", mySQLConnection) { CommandType = System.Data.CommandType.StoredProcedure };
            myCommand.Parameters.AddWithValue("@pRequest_Id", ConfigurationManager.AppSettings["SubbieRegistrationRequestId"].ToString());
            myCommand.Parameters.AddWithValue("@pSWMS_Id", 6);
            myCommand.Parameters.AddWithValue("@pAnswerValue", tmpAnswerValue);
            myCommand.ExecuteNonQuery();


            if (rbl_SWMS7.Items[0].Selected == true) { tmpAnswerValue = 1; } else { tmpAnswerValue = 0; }
            myCommand = new SqlCommand("SUBCONREG_UpdateCompanySWMSitem", mySQLConnection) { CommandType = System.Data.CommandType.StoredProcedure };
            myCommand.Parameters.AddWithValue("@pRequest_Id", ConfigurationManager.AppSettings["SubbieRegistrationRequestId"].ToString());
            myCommand.Parameters.AddWithValue("@pSWMS_Id", 7);
            myCommand.Parameters.AddWithValue("@pAnswerValue", tmpAnswerValue);
            myCommand.ExecuteNonQuery();

            if (rbl_SWMS8.Items[0].Selected == true) { tmpAnswerValue = 1; } else { tmpAnswerValue = 0; }
            myCommand = new SqlCommand("SUBCONREG_UpdateCompanySWMSitem", mySQLConnection) { CommandType = System.Data.CommandType.StoredProcedure };
            myCommand.Parameters.AddWithValue("@pRequest_Id", ConfigurationManager.AppSettings["SubbieRegistrationRequestId"].ToString());
            myCommand.Parameters.AddWithValue("@pSWMS_Id", 8);
            myCommand.Parameters.AddWithValue("@pAnswerValue", tmpAnswerValue);
            myCommand.ExecuteNonQuery();

            if (rbl_SWMS9.Items[0].Selected == true) { tmpAnswerValue = 1; } else { tmpAnswerValue = 0; }
            myCommand = new SqlCommand("SUBCONREG_UpdateCompanySWMSitem", mySQLConnection) { CommandType = System.Data.CommandType.StoredProcedure };
            myCommand.Parameters.AddWithValue("@pRequest_Id", ConfigurationManager.AppSettings["SubbieRegistrationRequestId"].ToString());
            myCommand.Parameters.AddWithValue("@pSWMS_Id", 9);
            myCommand.Parameters.AddWithValue("@pAnswerValue", tmpAnswerValue);
            myCommand.ExecuteNonQuery();

            if (rbl_SWMS10.Items[0].Selected == true) { tmpAnswerValue = 1; } else { tmpAnswerValue = 0; }
            myCommand = new SqlCommand("SUBCONREG_UpdateCompanySWMSitem", mySQLConnection) { CommandType = System.Data.CommandType.StoredProcedure };
            myCommand.Parameters.AddWithValue("@pRequest_Id", ConfigurationManager.AppSettings["SubbieRegistrationRequestId"].ToString());
            myCommand.Parameters.AddWithValue("@pSWMS_Id", 10);
            myCommand.Parameters.AddWithValue("@pAnswerValue", tmpAnswerValue);
            myCommand.ExecuteNonQuery();

            if (rbl_SWMS11.Items[0].Selected == true) { tmpAnswerValue = 1; } else { tmpAnswerValue = 0; }
            myCommand = new SqlCommand("SUBCONREG_UpdateCompanySWMSitem", mySQLConnection) { CommandType = System.Data.CommandType.StoredProcedure };
            myCommand.Parameters.AddWithValue("@pRequest_Id", ConfigurationManager.AppSettings["SubbieRegistrationRequestId"].ToString());
            myCommand.Parameters.AddWithValue("@pSWMS_Id", 11);
            myCommand.Parameters.AddWithValue("@pAnswerValue", tmpAnswerValue);
            myCommand.ExecuteNonQuery();

            if (rbl_SWMS12.Items[0].Selected == true) { tmpAnswerValue = 1; } else { tmpAnswerValue = 0; }
            myCommand = new SqlCommand("SUBCONREG_UpdateCompanySWMSitem", mySQLConnection) { CommandType = System.Data.CommandType.StoredProcedure };
            myCommand.Parameters.AddWithValue("@pRequest_Id", ConfigurationManager.AppSettings["SubbieRegistrationRequestId"].ToString());
            myCommand.Parameters.AddWithValue("@pSWMS_Id", 12);
            myCommand.Parameters.AddWithValue("@pAnswerValue", tmpAnswerValue);
            myCommand.ExecuteNonQuery();

            if (rbl_SWMS13.Items[0].Selected == true) { tmpAnswerValue = 1; } else { tmpAnswerValue = 0; }
            myCommand = new SqlCommand("SUBCONREG_UpdateCompanySWMSitem", mySQLConnection) { CommandType = System.Data.CommandType.StoredProcedure };
            myCommand.Parameters.AddWithValue("@pRequest_Id", ConfigurationManager.AppSettings["SubbieRegistrationRequestId"].ToString());
            myCommand.Parameters.AddWithValue("@pSWMS_Id", 13);
            myCommand.Parameters.AddWithValue("@pAnswerValue", tmpAnswerValue);
            myCommand.ExecuteNonQuery();

            if (rbl_SWMS14.Items[0].Selected == true) { tmpAnswerValue = 1; } else { tmpAnswerValue = 0; }
            myCommand = new SqlCommand("SUBCONREG_UpdateCompanySWMSitem", mySQLConnection) { CommandType = System.Data.CommandType.StoredProcedure };
            myCommand.Parameters.AddWithValue("@pRequest_Id", ConfigurationManager.AppSettings["SubbieRegistrationRequestId"].ToString());
            myCommand.Parameters.AddWithValue("@pSWMS_Id", 14);
            myCommand.Parameters.AddWithValue("@pAnswerValue", tmpAnswerValue);
            myCommand.ExecuteNonQuery();

            if (rbl_SWMS15.Items[0].Selected == true) { tmpAnswerValue = 1; } else { tmpAnswerValue = 0; }
            myCommand = new SqlCommand("SUBCONREG_UpdateCompanySWMSitem", mySQLConnection) { CommandType = System.Data.CommandType.StoredProcedure };
            myCommand.Parameters.AddWithValue("@pRequest_Id", ConfigurationManager.AppSettings["SubbieRegistrationRequestId"].ToString());
            myCommand.Parameters.AddWithValue("@pSWMS_Id", 15);
            myCommand.Parameters.AddWithValue("@pAnswerValue", tmpAnswerValue);
            myCommand.ExecuteNonQuery();

            if (rbl_SWMS16.Items[0].Selected == true) { tmpAnswerValue = 1; } else { tmpAnswerValue = 0; }
            myCommand = new SqlCommand("SUBCONREG_UpdateCompanySWMSitem", mySQLConnection) { CommandType = System.Data.CommandType.StoredProcedure };
            myCommand.Parameters.AddWithValue("@pRequest_Id", ConfigurationManager.AppSettings["SubbieRegistrationRequestId"].ToString());
            myCommand.Parameters.AddWithValue("@pSWMS_Id", 16);
            myCommand.Parameters.AddWithValue("@pAnswerValue", tmpAnswerValue);
            myCommand.ExecuteNonQuery();

            if (rbl_SWMS17.Items[0].Selected == true) { tmpAnswerValue = 1; } else { tmpAnswerValue = 0; }
            myCommand = new SqlCommand("SUBCONREG_UpdateCompanySWMSitem", mySQLConnection) { CommandType = System.Data.CommandType.StoredProcedure };
            myCommand.Parameters.AddWithValue("@pRequest_Id", ConfigurationManager.AppSettings["SubbieRegistrationRequestId"].ToString());
            myCommand.Parameters.AddWithValue("@pSWMS_Id", 17);
            myCommand.Parameters.AddWithValue("@pAnswerValue", tmpAnswerValue);
            myCommand.ExecuteNonQuery();

            if (rbl_SWMS18.Items[0].Selected == true) { tmpAnswerValue = 1; } else { tmpAnswerValue = 0; }
            myCommand = new SqlCommand("SUBCONREG_UpdateCompanySWMSitem", mySQLConnection) { CommandType = System.Data.CommandType.StoredProcedure };
            myCommand.Parameters.AddWithValue("@pRequest_Id", ConfigurationManager.AppSettings["SubbieRegistrationRequestId"].ToString());
            myCommand.Parameters.AddWithValue("@pSWMS_Id", 18);
            myCommand.Parameters.AddWithValue("@pAnswerValue", tmpAnswerValue);
            myCommand.ExecuteNonQuery();









            myCommand.Dispose();
            myCommand = null;

            mySQLConnection.Close();
            mySQLConnection = null;
        }

        public void SUBCONREG_UpdateCompanyDetails(string strRequestId, string strState)
        {

            string filedocumentpath = ".." + DA.DocumentsPath.ToString() + @"/" + DateTime.Now.Year.ToString() + @"/Sucontractor_document";
            int tmpIntVar = 0;
            mySQLConnection = new SqlConnection(DA.ConnStr);
            mySQLConnection.Open();
            myCommand = new SqlCommand("SUBCONREG_UpdateCompanyDetails", mySQLConnection) { CommandType = System.Data.CommandType.StoredProcedure };

            myCommand.Parameters.AddWithValue("@pRequest_Id", strRequestId);
            myCommand.Parameters.AddWithValue("@pCOMPANY_NAME", tbx_CompanyName.Text);
            myCommand.Parameters.AddWithValue("@pCOMPANY_DIRECTOR_NAME", tbx_DirectorName.Text);
            myCommand.Parameters.AddWithValue("@pCOMPANY_EMAIL_ADDRESS", tbx_EmailAddress.Text);
            myCommand.Parameters.AddWithValue("@pCOMPANY_ADDRESS", tbx_StreetAddress.Text);

            if (cbbPostcodeSuburb.Value != null)
            {

                int n;
                if (int.TryParse(cbbPostcodeSuburb.Value.ToString(), out n))
                {
                    cbbPostcodeSuburbVValue["suburbid"] = cbbPostcodeSuburb.Value.ToString();
                }
                myCommand.Parameters.AddWithValue("@pCOMPANY_LOCATION_ID", Convert.ToInt32(cbbPostcodeSuburbVValue["suburbid"].ToString()));
            }
            else
            {
                myCommand.Parameters.AddWithValue("@pCOMPANY_LOCATION_ID", "");
            }


            myCommand.Parameters.AddWithValue("@pCOMPANY_ABN", tbx_CompanyABN.Text);

            myCommand.Parameters.AddWithValue("@pCOMPANY_INDUCTION_CARD", "");
            myCommand.Parameters.AddWithValue("@pCOMPANY_INDUCTION_CARDEXPDATE", ""); //not in use as is not at company level
            myCommand.Parameters.AddWithValue("@pCOMPANY_POLICECHECK_EXPDATE", "");//not in use as is not at company level

            myCommand.Parameters.AddWithValue("@pCOMPANY_COMPENSATION_NUMBER", tbx_CompensationNumber.Text);
            try
            { myCommand.Parameters.AddWithValue("@pCOMPANY_COMPENSATION_NUMBEREXPDATE", Convert.ToDateTime(tbx_CompensationNumberExpDate.Text).ToString("yyyy/MM/dd")); }
            catch (Exception ex2)
            { myCommand.Parameters.AddWithValue("@pCOMPANY_COMPENSATION_NUMBEREXPDATE", ""); }

            myCommand.Parameters.AddWithValue("@pCOMPANY_PUBLIC_LIABILITY_NUMBER", tbx_PublicLiability.Text);
            try
            { myCommand.Parameters.AddWithValue("@pCOMPANY_PUBLIC_LIABILITY_EXPDATE", Convert.ToDateTime(tbx_PublicLiabilityExpDate.Text).ToString("yyyy/MM/dd")); }
            catch (Exception ex3)
            { myCommand.Parameters.AddWithValue("@pCOMPANY_PUBLIC_LIABILITY_EXPDATE", ""); }



            myCommand.Parameters.AddWithValue("@pCOMPANY_VULNERABLEPERSON_EXPDATE", "");
            myCommand.Parameters.AddWithValue("@pCOMPANY_CONTACT_PERSON", tbx_COMPANY_CONTACT_PERSON.Text);
            myCommand.Parameters.AddWithValue("@pCOMPANY_CONTACT_POSITION", tbx_COMPANY_CONTACT_POSITION.Text);
            myCommand.Parameters.AddWithValue("@pCOMPANY_CONTACT_PHONE", tbx_CompanyContactPhone.Text);
            myCommand.Parameters.AddWithValue("@pCOMPANY_CONTACT_EMAILADDRESS", tbx_COMPANY_CONTACT_EMAILADDRESS.Text);

            myCommand.Parameters.AddWithValue("@pCOMPANY_JOB_CAPACITY_30_DAYS", tbx_jobcapacity30days.Text);
            myCommand.Parameters.AddWithValue("@pCOMPANY_AVERAGE_VALUEXJOB", tbx_averagevaluejob.Text);
            if (rbtn_CompanyCanDoLargeWork.Items[0].Selected == true) { tmpIntVar = 1; } else { tmpIntVar = 0; }
            myCommand.Parameters.AddWithValue("@pCOMPANY_GENERIC_SAFETYPLAN_DOCID", tmpIntVar);

            if (rbtn_COMPANY_DID_WORK_WITH_MAINCOM.Items[0].Selected == true) { tmpIntVar = 1; } else { tmpIntVar = 0; }
            myCommand.Parameters.AddWithValue("@pCOMPANY_DID_WORK_WITH_MAINCOM", tmpIntVar);
            myCommand.Parameters.AddWithValue("@pCOMPANY_DID_WORK_WITH_MAINCOM_DETAILS", tbx_COMPANY_DID_WORK_WITH_MAINCOM_DETAILS.Text);
            if (rbtn_COMPANY_HAS_CORRECTIVE_PREVIOUS_JOBS.Items[0].Selected == true) { tmpIntVar = 1; } else { tmpIntVar = 0; }
            myCommand.Parameters.AddWithValue("@pCOMPANY_HAS_CORRECTIVE_PREVIOUS_JOBS ", tmpIntVar);
            myCommand.Parameters.AddWithValue("@pCOMPANY_HAS_CORRECTIVE_PREVIOUS_JOBS_DETAILS", tbx_COMPANY_HAS_CORRECTIVE_PREVIOUS_JOBS_DETAILS.Text);


            myCommand.Parameters.AddWithValue("@pCOMPANY_BANK_NAME", tbx_COMPANY_BANK_NAME.Text);
            myCommand.Parameters.AddWithValue("@pCOMPANY_BANK_ACCOUNT_NO", tbx_COMPANY_BANK_ACCOUNT_NO.Text);
            myCommand.Parameters.AddWithValue("@pCOMPANY_BANK_ACCOUNT_BSB", tbx_COMPANY_BANK_ACCOUNT_BSB.Text);
            myCommand.Parameters.AddWithValue("@pCOMPANY_BANK_ACCOUNT_NAME", tbx_COMPANY_BANK_ACCOUNT_NAME.Text);

            myCommand.Parameters.AddWithValue("@pCOMPANY_REFERENCE1_NAME", tbx_COMPANY_REFERENCE1_NAME.Text);
            myCommand.Parameters.AddWithValue("@pCOMPANY_REFERENCE1_COMPANY", tbx_COMPANY_REFERENCE1_COMPANY.Text);
            myCommand.Parameters.AddWithValue("@pCOMPANY_REFERENCE1_POSITION", tbx_COMPANY_REFERENCE1_POSITION.Text);
            myCommand.Parameters.AddWithValue("@pCOMPANY_REFERENCE1_EMAIL", tbx_COMPANY_REFERENCE1_EMAIL.Text);
            myCommand.Parameters.AddWithValue("@pCOMPANY_REFERENCE1_PHONE", tbx_COMPANY_REFERENCE1_PHONE.Text);
            myCommand.Parameters.AddWithValue("@pCOMPANY_PLACESOFWORK", CalculateStatesFromCheckBoxes());


            //Company can do large works -----------------------------------------------------------------------------------------------------------------------------
            if (rbtn_CompanyCanDoLargeWork.Items[0].Selected == true)
            {
                tmpIntVar = 1;
                if (tbx_SWMS_DOCID.Text.Trim().Length > 0)
                {
                    lnk_viewgenericsafetyplan.Visible = true;
                    lnk_viewgenericsafetyplan.HRef = filedocumentpath + "/" + tbx_SWMS_DOCID.Text.Trim();
                }
                else
                {
                    lnk_viewgenericsafetyplan.Visible = true;
                }
                Page.ClientScript.RegisterStartupScript(this.GetType(), "clientscript", "document.getElementById('bigwork').style.visibility = 'visible';", true);
            }
            else
            {
                tmpIntVar = 0;
                Page.ClientScript.RegisterStartupScript(this.GetType(), "clientscript", "document.getElementById('bigwork').style.visibility = 'hidden';", true);
            }
            myCommand.Parameters.AddWithValue("@pCOMPANY_LARGECAPACITY_WORK", tmpIntVar);
            //--------------------------------------------------------------------------------------------------------------------------------------------------------


            if (cbl_agree_maincom_site.Items[0].Selected == true) { tmpIntVar = 1; } else { tmpIntVar = 0; }
            myCommand.Parameters.AddWithValue("@pAGREE_USE_MAINCOM_PORTAL", tmpIntVar);
            if (cbl_agree_maincom_invoices.Items[0].Selected == true) { tmpIntVar = 1; } else { tmpIntVar = 0; }
            myCommand.Parameters.AddWithValue("@pAGREE_USE_MAINCOM_INVOICES", tmpIntVar);
            
            //Calculating the state of the application before saving it.---------------------            
            myCommand.Parameters.AddWithValue("@pSTATE", "PRE APPROVED");
            //-----------------------------------------------------------------------------

            if (tbx_SWMS_DOCID.Text.Trim().Length > 0)
            {
                lnk_viewswmsdoc.Visible = true;
            }
            else
            {
                lnk_viewswmsdoc.Visible = false;
            }


            myCommand.ExecuteNonQuery();
            myCommand.Dispose();
            myCommand = null;
            mySQLConnection.Close();
            mySQLConnection = null;

            Update_Company_SWMS();

            //Validation of the application.  -----------------------------------------------------------   
            string strErrors = IsApplicationComplete();
            if (strErrors != "")
            {

                //we must display all the missing points to be completed.   
                ErrorWindow.Visible = true;
                //ErrorsList.InnerHtml = strErrors;
                ErrorList.Text = strErrors;
                lbl_ReqStatus.Text = "APPLICATION STATUS - PRE APPROVED";
                lbl_ReqStatus.ForeColor = System.Drawing.Color.DarkRed;

            }
            else { btn_sumitapplication.Visible = true; }
            //--------------------------------------------------------------------------------------



        }

        protected void btn_CheckApplication_Click(object sender, EventArgs e)
        {
            //Calculating the state of the application .---------------------
            string strApplicationStatus = CheckApplicationStatus();           
            //we must display all the missing points to be completed.   
            ErrorWindow.Visible = true;           
            ErrorList.Text = strApplicationStatus;
           

           
        }

        protected void UpdateRequestState(string pStrRequestId, string pStrState)
        {
            string strSql = "";

            if (pStrState == "COMPLETED")
            {
                strSql = @"update subconreg_requests set REQUEST_state = '" + pStrState + "' , REQUEST_PART2COMPLETED_DATE = GETDATE() where request_id = " + pStrRequestId;
            }
            else
            {
                strSql = @"update subconreg_requests set REQUEST_state = '" + pStrState + "'  where request_id = " + pStrRequestId;
            }

            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["DataConnectionString"].ConnectionString);
            SqlCommand myCommand = new SqlCommand(strSql, conn);
            conn.Open();
            myCommand.ExecuteNonQuery();
            conn.Close();

        }

        protected void btn_closeErrorWindow_click(object sender, EventArgs e)
        {
            ErrorWindow.Visible = false;
        }
        protected void SendPart2CompletedNotification(string strCompanyName, string strCompanyEmail)
        {
            string strSubject = "New Sub Contractor Application to work for Maincom";
            string strEmailBody = "Hi Administrator, <br /> Company: <b>" + strCompanyName + "</b> has COMPLETED their application form to work for Maincom. <br />Pleae revise all completed details in our NEW SUB CONTRACTOR REQUESTS TO WORK FOR MAINCOM system. <br />Their contact email address is " + strCompanyEmail + ". <br />Regards, <br />Sevices Maincom";
            Email.SendEmail("services@maincom.net", ConfigurationManager.AppSettings["NewSubbieRequestsAdministrator"].ToString(), strSubject, strEmailBody, ConfigurationManager.AppSettings["NewSubbieRequestsAdministrator"].ToString());

        }

        public string IsApplicationComplete()
        {
            string strEmptyImagePath = Server.MapPath(DA.DocumentsPath) + @"\" + DateTime.Now.Year.ToString() + @"\Sucontractor_document";
            string strResult = "<p><b><font size=\"4\" color=\"green\">YOUR INFORMATION WAS SAVED CORRECTLY </font></b></p><p><b><font size=\"4\" color=\"#0099CC\">TO COMPLETE YOUR APPLICATION PLEASE PROVIDE THE FOLLOWING INFORMATION  </font></b></p>";
            string strSection = "";
            bool bAddSection = false;
            bool bErrorsFound = false;


            DateTime dt1;


            //-----------------------------------------GENERAL INFORMATION TAB-------------------------------------------------------------------------------
            if (cbx_NSW.Checked == false && cbx_VIC.Checked == false && cbx_QLD.Checked == false && cbx_WA.Checked == false && cbx_SA.Checked == false && cbx_TAS.Checked == false && cbx_NEW_ZEALAND.Checked == false)
            {
                strSection = strSection + "<p><b>State where your company will work :</b> You must tick the check boxes whit the states where you intend to work. </p>";
                bAddSection = true;
            }

            if (tbx_CompanyName.Text.Trim() == "")
            {

                strSection = strSection + "<p><b>Company name :</b> This Field is required. </p>";
                bAddSection = true;
            }

            if (tbx_DirectorName.Text.Trim() == "")
            {

                strSection = strSection + "<p><b>Company Director's Name :</b> This Field is required. </p>";
                bAddSection = true;
            }

            if (tbx_EmailAddress.Text.Trim() == "")
            {

                strSection = strSection + "<p><b>Email Address :</b> This Field is required. </p>";
                bAddSection = true;
            }

            if (tbx_StreetAddress.Text.Trim() == "")
            {

                strSection = strSection + "<p><b>Street Address :</b> This Field is required. </p>";
                bAddSection = true;
            }

            if (cbbPostcodeSuburb.Text.Trim() == "")
            {

                strSection = strSection + "<p><b>Suburb (post code) :</b> This Field is required, please type in the post code to autofill. </p>";
                bAddSection = true;
            }

            if (tbx_CompanyABN.Text.Trim() == "")
            {

                strSection = strSection + "<p><b>ABN number :</b> This Field is required. </p>";
                bAddSection = true;
            }

            if (tbx_CompanyContactPhone.Text.Trim() == "")
            {
                strSection = strSection + "<p><b>Contact Phone :</b> This Field is required. </p>";
                bAddSection = true;
            }

            if (tbx_COMPANY_BANK_NAME.Text.Trim() == "")
            {
                strSection = strSection + "<p><b>Bank Name :</b> This Field is required. </p>";
                bAddSection = true;

            }
            
            
            if (tbx_COMPANY_BANK_ACCOUNT_BSB.Text.Trim() == "")
            {
                strSection = strSection + "<p><b>Bank BSB number :</b> This Field is required. </p>";
                bAddSection = true;

            }
            if ( tbx_COMPANY_BANK_ACCOUNT_NO.Text.Trim() == "")
            {
                strSection = strSection + "<p><b>Bank Account Number :</b> This Field is required. </p>";
                bAddSection = true;

            }
            if (tbx_COMPANY_BANK_ACCOUNT_NAME.Text.Trim() == "")
            {
                strSection = strSection + "<p><b>Bank Account Name :</b> This Field is required. </p>";
                bAddSection = true;

            }

            if (rbtn_COMPANY_DID_WORK_WITH_MAINCOM.Items[0].Selected == false && rbtn_COMPANY_DID_WORK_WITH_MAINCOM.Items[1].Selected == false)
            {
                strSection = strSection + "<p><b>Has your Company Conducted any works for MAINCOM in the past in this name or any other name :</b> PLEASE answer this question. </p>";
                bAddSection = true;
            }

            if ( rbtn_COMPANY_DID_WORK_WITH_MAINCOM.Items[0].Selected == true && tbx_COMPANY_DID_WORK_WITH_MAINCOM_DETAILS.Text.Trim() == "")
            {
                strSection = strSection + "<p><b>Has your Company Conducted any works for MAINCOM in the past in this name or any other name :</b> PLEASE PROVIDE DETAILS, This field is required. </p>";
                bAddSection = true;
            }

            if (rbtn_COMPANY_HAS_CORRECTIVE_PREVIOUS_JOBS.Items[0].Selected == false && rbtn_COMPANY_HAS_CORRECTIVE_PREVIOUS_JOBS.Items[1].Selected == false)
            {
                strSection = strSection + "<p><b>Has your company had any contracts terminated over the past 3 years for poor performance or corrective actions :</b> PLEASE answer this question. </p>";
                bAddSection = true;
            }

            if (rbtn_COMPANY_HAS_CORRECTIVE_PREVIOUS_JOBS.Items[0].Selected == true && tbx_COMPANY_HAS_CORRECTIVE_PREVIOUS_JOBS_DETAILS.Text.Trim() == "")
            {
                strSection = strSection + "<p><b>Has your company had any contracts terminated over the past 3 years for poor performance or corrective actions :</b> PLEASE PROVIDE DETAILS, This field is required. </p>";
                bAddSection = true;
            }

            if (tbx_jobcapacity30days.Text.Trim() == "")
            {
                strSection = strSection + "<p><b>Job capacity in 30 days :</b> Tell us how many jobs can you perform in 30 days. </p>";
                bAddSection = true;
            }
            if (tbx_averagevaluejob.Text.Trim() == "")
            {
                strSection = strSection + "<p><b>Your average value per job :</b> This field is required. </p>";
                bAddSection = true;
            }

            if (rbtn_CompanyCanDoLargeWork.Items[0].Selected == true && tbx_GENERICSAFETYPLAN_DOCID.Text.Trim() == "")
            {
                strSection = strSection + "<p><b>Safety Large Projects Generic Safety Plan (file or image upload) :</b> This field is required. </p>";
                bAddSection = true;
            }

            if (tbx_COMPANY_CONTACT_PERSON.Text.Trim() == "")
            {
                strSection = strSection + "<p><b>Contact PersonName :</b> This field is required. </p>";
                bAddSection = true;
            }
            if (tbx_COMPANY_CONTACT_POSITION.Text.Trim() == "")
            {
                strSection = strSection + "<p><b>Contact Person Position :</b> This field is required. </p>";
                bAddSection = true;
            }

            if ( tbx_COMPANY_CONTACT_PHONE.Text.Trim() == "")
            {
                strSection = strSection + "<p><b>Contact Person Phone :</b> This field is required. </p>";
                bAddSection = true;
            }

            if (tbx_COMPANY_CONTACT_EMAILADDRESS.Text.Trim() == "")
            {
                strSection = strSection + "<p><b>Contact Person email address :</b> This field is required. </p>";
                bAddSection = true;
            }


            if (bAddSection == true)
            {
                strResult = strResult + "<p><b><font size=\"4\" color=\"#0099CC\">GENERAL INFORMATION TAB </font></b></p>" + strSection;
                bErrorsFound = true;
            }

            //------------------------------------------------END SECTION 1--------------------------------------------------------------


            //-----------------------------------------REQUIRED DOCUMENTS TAB ------------------------------------------------------------------------------
            strSection = "";
            bAddSection = false;





            if (tbx_CompensationNumber.Text.Trim() == "")
            {
                strSection = strSection + "<p><b>Worker's Compensation Number :</b> This Field is required. </p>";
                bAddSection = true;
            }

            if (tbx_CompensationNumberExpDate.Text.Trim() == "")
            {
                strSection = strSection + "<p><b>Worker's Compensation Expiry Date :</b> This Field is required. </p>";
                bAddSection = true;
            }
            else
            {
                try
                {
                    dt1 = Convert.ToDateTime(Convert.ToDateTime(tbx_CompensationNumberExpDate.Text).ToString("yyyy/MM/dd"));
                    if (DateTime.Compare(dt1, System.DateTime.Today) < 0)
                    {
                        strSection = strSection + "<p><b>Worker's Compensation Expiry Date :</b> Invalid Expiry Date for Worker's Compensation as it has already expired. </p>";
                        bAddSection = true;
                    }
                }
                catch (Exception ex1)
                { }
            }

            if (img_CompensationNumber.ImageUrl.Substring(img_CompensationNumber.ImageUrl.Length - 5).IndexOf(".") < 0)
            {
                strSection = strSection + "<p><b>Worker's Compensation photo or file:</b> You must upload and Image or document. </p>";
                bAddSection = true;
            }

            if (tbx_PublicLiability.Text.Trim() == "")
            {
                strSection = strSection + "<p><b>Public Liability Number :</b> This Field is required. </p>";
                bAddSection = true;
            }

            if (tbx_PublicLiabilityExpDate.Text.Trim() == "")
            {
                strSection = strSection + "<p><b>Public Liability  Expiry Date :</b> This Field is required. </p>";
                bAddSection = true;
            }
            else
            {
                try
                {
                    dt1 = Convert.ToDateTime(Convert.ToDateTime(tbx_PublicLiabilityExpDate.Text).ToString("yyyy/MM/dd"));
                    if (DateTime.Compare(dt1, System.DateTime.Today) < 0)
                    {
                        strSection = strSection + "<p><b>Public Liability Number Expiry Date :</b> Invalid Expiry Date for Public Liability Number as it has already expired. </p>";
                        bAddSection = true;
                    }
                }
                catch (Exception ex1)
                { }
            }

            if (img_PublicLiability.ImageUrl.Substring(img_PublicLiability.ImageUrl.Length - 5).IndexOf(".") < 0)
            {
                strSection = strSection + "<p><b>Public Liability Number photo or file:</b> You must upload and Image or document. </p>";
                bAddSection = true;
            }



            if (bAddSection == true)
            {
                strResult = strResult + "<p><b><font size=\"4\" color=\"#0099CC\">REQUIRED DOCUMENTS TAB </font></b></p>" + strSection;
                bErrorsFound = true;
            }


            //-------------------------------------------------------------END REQUIRED DOCUMENTS TAB -------------------------------------------------------------


            //-----------------------------------------TRADE SKILLS TAB--------------------------------------------------------------------------------------
            strSection = "";
            bAddSection = false;

            if (CompanyTradeSkills.VisibleRowCount < 1)
            {
                strSection = strSection + "<p><b>Trade Skills :</b> You must add at least one trade skill. Use the add skill button and complete the form. </p>";
                bAddSection = true;
            }

            if (bAddSection == true)
            {
                strResult = strResult + "<p><b><font size=\"4\" color=\"#0099CC\">LICENSING AND QUALIFICATIONS TAB </font></b></p>" + strSection;
                bErrorsFound = true;
            }
            //-------------------------------------------------------------END TRADE SKILLS TAB-------------------------------------------------------------------------------

           

            //-----------------------------------------SAFE WORKS METHOD SWMS--------------------------------------------------------------------------------
            strSection = "";
            bAddSection = false;



            if (tbx_SWMS_DOCID.Text.Trim() == "")
            {
                strSection = strSection + "<p><b>SWMS or Job Safety Document (File or image upload) :</b> This field is required. </p>";
                bAddSection = true;
            }

            if (rbl_SWMS1.Items[0].Selected == false)
            {
                strSection = strSection + "<p><b>Safe Work Method (question 1) not answered YES :</b> You must be capable to cover for this requirement. </p>";
                bAddSection = true;
            }

            if (rbl_SWMS2.Items[0].Selected == false)
            {
                strSection = strSection + "<p><b>Safe Work Method (question 2) not answered YES :</b> You must be capable to cover for this requirement. </p>";
                bAddSection = true;
            }

            if (rbl_SWMS3.Items[0].Selected == false)
            {
                strSection = strSection + "<p><b>Safe Work Method (question 3) not answered YES :</b> You must be capable to cover for this requirement. </p>";
                bAddSection = true;
            }

            if (rbl_SWMS4.Items[0].Selected == false)
            {
                strSection = strSection + "<p><b>Safe Work Method (question 4) not answered YES :</b> You must be capable to cover for this requirement. </p>";
                bAddSection = true;
            }
            if (rbl_SWMS5.Items[0].Selected == false)
            {
                strSection = strSection + "<p><b>Safe Work Method (question 5) not answered YES :</b> You must be capable to cover for this requirement. </p>";
                bAddSection = true;
            }
            if (rbl_SWMS6.Items[0].Selected == false)
            {
                strSection = strSection + "<p><b>Safe Work Method (question 6) not answered YES :</b> You must be capable to cover for this requirement. </p>";
                bAddSection = true;
            }
            if (rbl_SWMS7.Items[0].Selected == false)
            {
                strSection = strSection + "<p><b>Safe Work Method (question 7) not answered YES :</b> You must be capable to cover for this requirement. </p>";
                bAddSection = true;
            }
            if (rbl_SWMS8.Items[0].Selected == false)
            {
                strSection = strSection + "<p><b>Safe Work Method (question 8) not answered YES :</b> You must be capable to cover for this requirement. </p>";
                bAddSection = true;
            }
            if (rbl_SWMS9.Items[0].Selected == false)
            {
                strSection = strSection + "<p><b>Safe Work Method (question 9) not answered YES :</b> You must be capable to cover for this requirement. </p>";
                bAddSection = true;
            }
            if (rbl_SWMS10.Items[0].Selected == false)
            {
                strSection = strSection + "<p><b>Safe Work Method (question 10) not answered YES :</b> You must be capable to cover for this requirement. </p>";
                bAddSection = true;
            }
            if (rbl_SWMS11.Items[0].Selected == false)
            {
                strSection = strSection + "<p><b>Safe Work Method (question 11) not answered YES :</b> You must be capable to cover for this requirement. </p>";
            }
            if (rbl_SWMS12.Items[0].Selected == false)
            {
                strSection = strSection + "<p><b>Safe Work Method (question 12) not answered YES :</b> You must be capable to cover for this requirement. </p>";
                bAddSection = true;
            }
            if (rbl_SWMS13.Items[0].Selected == false)
            {
                strSection = strSection + "<p><b>Safe Work Method (question 13) not answered YES :</b> You must be capable to cover for this requirement. </p>";
                bAddSection = true;
            }
            if (rbl_SWMS14.Items[0].Selected == false)
            {
                strSection = strSection + "<p><b>Safe Work Method (question 14) not answered YES :</b> You must be capable to cover for this requirement. </p>";
                bAddSection = true;
            }
            if (rbl_SWMS15.Items[0].Selected == false)
            {
                strSection = strSection + "<p><b>Safe Work Method (question 15) not answered YES :</b> You must be capable to cover for this requirement. </p>";
                bAddSection = true;
            }
            if (rbl_SWMS16.Items[0].Selected == false)
            {
                strSection = strSection + "<p><b>Safe Work Method (question 16) not answered YES :</b> You must be capable to cover for this requirement. </p>";
                bAddSection = true;
            }
            if (rbl_SWMS17.Items[0].Selected == false)
            {
                strSection = strSection + "<p><b>Safe Work Method (question 17) not answered YES :</b> You must be capable to cover for this requirement. </p>";
                bAddSection = true;
            }
            if (rbl_SWMS18.Items[0].Selected == false)
            {
                strSection = strSection + "<p><b>Safe Work Method (question 18) not answered YES :</b> You must be capable to cover for this requirement. </p>";
                bAddSection = true;
            }

            
            if (bAddSection == true)
            {
                strResult = strResult + "<p><b><font size=\"4\" color=\"#0099CC\">SAFE WORKS METHOD (SWMS) TAB </font></b></p>" + strSection;
                bErrorsFound = true;
            }
            //-------------------------------------------------------------END SAFE WORKS METHOD TAB--------------------------------------------------------------------------


            //-----------------------------------------EMPLOYEES    TAB--------------------------------------------------------------------------------------
            strSection = "";
            bAddSection = false;

            if (gv_employees.VisibleRowCount < 1)
            {
                strSection = strSection + "<p><b>Trade Skills :</b> You must add at least one employee. Use the add employee button  in the EMPLOYEES TAB and complete the form. </p>";
                bAddSection = true;
            }

            if (bAddSection == true)
            {
                strResult = strResult + "<p><b><font size=\"4\" color=\"#0099CC\">EMPLOYEES TAB </font></b></p>" + strSection;
                bErrorsFound = true;
            }
            //-------------------------------------------------------------END EMPLOYEES    TAB-------------------------------------------------------------------------------



            //-----------------------------------------TERMS AND CONDITIONS TAB------------------------------------------------------------------------------
            strSection = "";
            bAddSection = false;

            if (cbl_agree_maincom_site.Items[0].Selected == false)
            {
                strSection = strSection + "<p><b>Agreemen to use of MAINCOM SUB CONTRACTOR SITE :</b> Must tick the check button and agree (read term and conditions). </p>";
                bAddSection = true;
            }
            if (cbl_agree_maincom_invoices.Items[0].Selected == false)
            {
                strSection = strSection + "<p><b>Agreemen to use of MAINCOM INVOICES PROCEDURES :</b> Must tick the check button and agree (read term and conditions). </p>";
                bAddSection = true;
            }
            if (bAddSection == true)
            {
                strResult = strResult + "<p><b><font size=\"4\" color=\"#0099CC\">TERMS AND CONDITIONS TAB </font></b></p>" + strSection;
                bErrorsFound = true;
            }
            //-------------------------------------------------------------END TERMS AN CONDITIONS TAB-------------------------------------------------------------------------


            if (bErrorsFound == false)
            { strResult = ""; }


            return strResult;


        }




        public string CheckApplicationStatus()
        {
            string strEmptyImagePath = Server.MapPath(DA.DocumentsPath) + @"\" + DateTime.Now.Year.ToString() + @"\Sucontractor_document";
            string strResult = "<p><b><font size=\"4\" color=\"#0099CC\">TO COMPLETE YOUR APPLICATION PLEASE PROVIDE THE FOLLOWING INFORMATION  </font></b></p>";
            string strSection = "";
            bool bAddSection = false;
            bool bErrorsFound = false;


            DateTime dt1;


            //-----------------------------------------GENERAL INFORMATION TAB-------------------------------------------------------------------------------
            if (cbx_NSW.Checked == false && cbx_VIC.Checked == false && cbx_QLD.Checked == false && cbx_WA.Checked == false && cbx_SA.Checked == false && cbx_TAS.Checked == false && cbx_NEW_ZEALAND.Checked == false)
            {
                strSection = strSection + "<p><b>State where your company will work :</b> You must tick the check boxes whit the states where you intend to work. </p>";
                bAddSection = true;
            }

            if (tbx_CompanyName.Text.Trim() == "")
            {

                strSection = strSection + "<p><b>Company name :</b> This Field is required. </p>";
                bAddSection = true;
            }

            if (tbx_DirectorName.Text.Trim() == "")
            {

                strSection = strSection + "<p><b>Company Director's Name :</b> This Field is required. </p>";
                bAddSection = true;
            }

            if (tbx_EmailAddress.Text.Trim() == "")
            {

                strSection = strSection + "<p><b>Email Address :</b> This Field is required. </p>";
                bAddSection = true;
            }

            if (tbx_StreetAddress.Text.Trim() == "")
            {

                strSection = strSection + "<p><b>Street Address :</b> This Field is required. </p>";
                bAddSection = true;
            }

            if (cbbPostcodeSuburb.Text.Trim() == "")
            {

                strSection = strSection + "<p><b>Suburb (post code) :</b> This Field is required, please type in the post code to autofill. </p>";
                bAddSection = true;
            }

            if (tbx_CompanyABN.Text.Trim() == "")
            {

                strSection = strSection + "<p><b>ABN number :</b> This Field is required. </p>";
                bAddSection = true;
            }

            if (tbx_CompanyContactPhone.Text.Trim() == "")
            {
                strSection = strSection + "<p><b>Contact Phone :</b> This Field is required. </p>";
                bAddSection = true;
            }

            if (tbx_COMPANY_BANK_NAME.Text.Trim() == "")
            {
                strSection = strSection + "<p><b>Bank Name :</b> This Field is required. </p>";
                bAddSection = true;

            }


            if (tbx_COMPANY_BANK_ACCOUNT_BSB.Text.Trim() == "")
            {
                strSection = strSection + "<p><b>Bank BSB number :</b> This Field is required. </p>";
                bAddSection = true;

            }
            if (tbx_COMPANY_BANK_ACCOUNT_NO.Text.Trim() == "")
            {
                strSection = strSection + "<p><b>Bank Account Number :</b> This Field is required. </p>";
                bAddSection = true;

            }
            if (tbx_COMPANY_BANK_ACCOUNT_NAME.Text.Trim() == "")
            {
                strSection = strSection + "<p><b>Bank Account Name :</b> This Field is required. </p>";
                bAddSection = true;

            }

            if (rbtn_COMPANY_DID_WORK_WITH_MAINCOM.Items[0].Selected == false && rbtn_COMPANY_DID_WORK_WITH_MAINCOM.Items[1].Selected == false)
            {
                strSection = strSection + "<p><b>Has your Company Conducted any works for MAINCOM in the past in this name or any other name :</b> PLEASE answer this question. </p>";
                bAddSection = true;
            }

            if (rbtn_COMPANY_DID_WORK_WITH_MAINCOM.Items[0].Selected == true && tbx_COMPANY_DID_WORK_WITH_MAINCOM_DETAILS.Text.Trim() == "")
            {
                strSection = strSection + "<p><b>Has your Company Conducted any works for MAINCOM in the past in this name or any other name :</b> PLEASE PROVIDE DETAILS, This field is required. </p>";
                bAddSection = true;
            }

            if (rbtn_COMPANY_HAS_CORRECTIVE_PREVIOUS_JOBS.Items[0].Selected == false && rbtn_COMPANY_HAS_CORRECTIVE_PREVIOUS_JOBS.Items[1].Selected == false)
            {
                strSection = strSection + "<p><b>Has your company had any contracts terminated over the past 3 years for poor performance or corrective actions :</b> PLEASE answer this question. </p>";
                bAddSection = true;
            }

            if (rbtn_COMPANY_HAS_CORRECTIVE_PREVIOUS_JOBS.Items[0].Selected == true && tbx_COMPANY_HAS_CORRECTIVE_PREVIOUS_JOBS_DETAILS.Text.Trim() == "")
            {
                strSection = strSection + "<p><b>Has your company had any contracts terminated over the past 3 years for poor performance or corrective actions :</b> PLEASE PROVIDE DETAILS, This field is required. </p>";
                bAddSection = true;
            }

            if (tbx_jobcapacity30days.Text.Trim() == "")
            {
                strSection = strSection + "<p><b>Job capacity in 30 days :</b> Tell us how many jobs can you perform in 30 days. </p>";
                bAddSection = true;
            }
            if (tbx_averagevaluejob.Text.Trim() == "")
            {
                strSection = strSection + "<p><b>Your average value per job :</b> This field is required. </p>";
                bAddSection = true;
            }

            if (rbtn_CompanyCanDoLargeWork.Items[0].Selected == true && tbx_GENERICSAFETYPLAN_DOCID.Text.Trim() == "")
            {
                strSection = strSection + "<p><b>Safety Large Projects Generic Safety Plan (file or image upload) :</b> This field is required. </p>";
                bAddSection = true;
            }

            if (tbx_COMPANY_CONTACT_PERSON.Text.Trim() == "")
            {
                strSection = strSection + "<p><b>Contact PersonName :</b> This field is required. </p>";
                bAddSection = true;
            }
            if (tbx_COMPANY_CONTACT_POSITION.Text.Trim() == "")
            {
                strSection = strSection + "<p><b>Contact Person Position :</b> This field is required. </p>";
                bAddSection = true;
            }

            if (tbx_COMPANY_CONTACT_PHONE.Text.Trim() == "")
            {
                strSection = strSection + "<p><b>Contact Person Phone :</b> This field is required. </p>";
                bAddSection = true;
            }

            if (tbx_COMPANY_CONTACT_EMAILADDRESS.Text.Trim() == "")
            {
                strSection = strSection + "<p><b>Contact Person email address :</b> This field is required. </p>";
                bAddSection = true;
            }


            if (bAddSection == true)
            {
                strResult = strResult + "<p><b><font size=\"4\" color=\"#0099CC\">GENERAL INFORMATION TAB </font></b></p>" + strSection;
                bErrorsFound = true;
            }

            //------------------------------------------------END SECTION 1--------------------------------------------------------------


            //-----------------------------------------REQUIRED DOCUMENTS TAB ------------------------------------------------------------------------------
            strSection = "";
            bAddSection = false;





            if (tbx_CompensationNumber.Text.Trim() == "")
            {
                strSection = strSection + "<p><b>Worker's Compensation Number :</b> This Field is required. </p>";
                bAddSection = true;
            }

            if (tbx_CompensationNumberExpDate.Text.Trim() == "")
            {
                strSection = strSection + "<p><b>Worker's Compensation Expiry Date :</b> This Field is required. </p>";
                bAddSection = true;
            }
            else
            {
                try
                {
                    dt1 = Convert.ToDateTime(Convert.ToDateTime(tbx_CompensationNumberExpDate.Text).ToString("yyyy/MM/dd"));
                    if (DateTime.Compare(dt1, System.DateTime.Today) < 0)
                    {
                        strSection = strSection + "<p><b>Worker's Compensation Expiry Date :</b> Invalid Expiry Date for Worker's Compensation as it has already expired. </p>";
                        bAddSection = true;
                    }
                }
                catch (Exception ex1)
                { }
            }

            if (img_CompensationNumber.ImageUrl.Substring(img_CompensationNumber.ImageUrl.Length - 5).IndexOf(".") < 0)
            {
                strSection = strSection + "<p><b>Worker's Compensation photo or file:</b> You must upload and Image or document. </p>";
                bAddSection = true;
            }

            if (tbx_PublicLiability.Text.Trim() == "")
            {
                strSection = strSection + "<p><b>Public Liability Number :</b> This Field is required. </p>";
                bAddSection = true;
            }

            if (tbx_PublicLiabilityExpDate.Text.Trim() == "")
            {
                strSection = strSection + "<p><b>Public Liability  Expiry Date :</b> This Field is required. </p>";
                bAddSection = true;
            }
            else
            {
                try
                {
                    dt1 = Convert.ToDateTime(Convert.ToDateTime(tbx_PublicLiabilityExpDate.Text).ToString("yyyy/MM/dd"));
                    if (DateTime.Compare(dt1, System.DateTime.Today) < 0)
                    {
                        strSection = strSection + "<p><b>Public Liability Number Expiry Date :</b> Invalid Expiry Date for Public Liability Number as it has already expired. </p>";
                        bAddSection = true;
                    }
                }
                catch (Exception ex1)
                { }
            }

            if (img_PublicLiability.ImageUrl.Substring(img_PublicLiability.ImageUrl.Length - 5).IndexOf(".") < 0)
            {
                strSection = strSection + "<p><b>Public Liability Number photo or file:</b> You must upload and Image or document. </p>";
                bAddSection = true;
            }



            if (bAddSection == true)
            {
                strResult = strResult + "<p><b><font size=\"4\" color=\"#0099CC\">REQUIRED DOCUMENTS TAB </font></b></p>" + strSection;
                bErrorsFound = true;
            }


            //-------------------------------------------------------------END REQUIRED DOCUMENTS TAB -------------------------------------------------------------


            //-----------------------------------------TRADE SKILLS TAB--------------------------------------------------------------------------------------
            strSection = "";
            bAddSection = false;

            if (CompanyTradeSkills.VisibleRowCount < 1)
            {
                strSection = strSection + "<p><b>Trade Skills :</b> You must add at least one trade skill. Use the add skill button and complete the form. </p>";
                bAddSection = true;
            }

            if (bAddSection == true)
            {
                strResult = strResult + "<p><b><font size=\"4\" color=\"#0099CC\">LICENSING AND QUALIFICATIONS TAB </font></b></p>" + strSection;
                bErrorsFound = true;
            }
            //-------------------------------------------------------------END TRADE SKILLS TAB-------------------------------------------------------------------------------



            //-----------------------------------------SAFE WORKS METHOD SWMS--------------------------------------------------------------------------------
            strSection = "";
            bAddSection = false;



            if (tbx_SWMS_DOCID.Text.Trim() == "")
            {
                strSection = strSection + "<p><b>SWMS or Job Safety Document (File or image upload) :</b> This field is required. </p>";
                bAddSection = true;
            }

            if (rbl_SWMS1.Items[0].Selected == false)
            {
                strSection = strSection + "<p><b>Safe Work Method (question 1) not answered YES :</b> You must be capable to cover for this requirement. </p>";
                bAddSection = true;
            }

            if (rbl_SWMS2.Items[0].Selected == false)
            {
                strSection = strSection + "<p><b>Safe Work Method (question 2) not answered YES :</b> You must be capable to cover for this requirement. </p>";
                bAddSection = true;
            }

            if (rbl_SWMS3.Items[0].Selected == false)
            {
                strSection = strSection + "<p><b>Safe Work Method (question 3) not answered YES :</b> You must be capable to cover for this requirement. </p>";
                bAddSection = true;
            }

            if (rbl_SWMS4.Items[0].Selected == false)
            {
                strSection = strSection + "<p><b>Safe Work Method (question 4) not answered YES :</b> You must be capable to cover for this requirement. </p>";
                bAddSection = true;
            }
            if (rbl_SWMS5.Items[0].Selected == false)
            {
                strSection = strSection + "<p><b>Safe Work Method (question 5) not answered YES :</b> You must be capable to cover for this requirement. </p>";
                bAddSection = true;
            }
            if (rbl_SWMS6.Items[0].Selected == false)
            {
                strSection = strSection + "<p><b>Safe Work Method (question 6) not answered YES :</b> You must be capable to cover for this requirement. </p>";
                bAddSection = true;
            }
            if (rbl_SWMS7.Items[0].Selected == false)
            {
                strSection = strSection + "<p><b>Safe Work Method (question 7) not answered YES :</b> You must be capable to cover for this requirement. </p>";
                bAddSection = true;
            }
            if (rbl_SWMS8.Items[0].Selected == false)
            {
                strSection = strSection + "<p><b>Safe Work Method (question 8) not answered YES :</b> You must be capable to cover for this requirement. </p>";
                bAddSection = true;
            }
            if (rbl_SWMS9.Items[0].Selected == false)
            {
                strSection = strSection + "<p><b>Safe Work Method (question 9) not answered YES :</b> You must be capable to cover for this requirement. </p>";
                bAddSection = true;
            }
            if (rbl_SWMS10.Items[0].Selected == false)
            {
                strSection = strSection + "<p><b>Safe Work Method (question 10) not answered YES :</b> You must be capable to cover for this requirement. </p>";
                bAddSection = true;
            }
            if (rbl_SWMS11.Items[0].Selected == false)
            {
                strSection = strSection + "<p><b>Safe Work Method (question 11) not answered YES :</b> You must be capable to cover for this requirement. </p>";
            }
            if (rbl_SWMS12.Items[0].Selected == false)
            {
                strSection = strSection + "<p><b>Safe Work Method (question 12) not answered YES :</b> You must be capable to cover for this requirement. </p>";
                bAddSection = true;
            }
            if (rbl_SWMS13.Items[0].Selected == false)
            {
                strSection = strSection + "<p><b>Safe Work Method (question 13) not answered YES :</b> You must be capable to cover for this requirement. </p>";
                bAddSection = true;
            }
            if (rbl_SWMS14.Items[0].Selected == false)
            {
                strSection = strSection + "<p><b>Safe Work Method (question 14) not answered YES :</b> You must be capable to cover for this requirement. </p>";
                bAddSection = true;
            }
            if (rbl_SWMS15.Items[0].Selected == false)
            {
                strSection = strSection + "<p><b>Safe Work Method (question 15) not answered YES :</b> You must be capable to cover for this requirement. </p>";
                bAddSection = true;
            }
            if (rbl_SWMS16.Items[0].Selected == false)
            {
                strSection = strSection + "<p><b>Safe Work Method (question 16) not answered YES :</b> You must be capable to cover for this requirement. </p>";
                bAddSection = true;
            }
            if (rbl_SWMS17.Items[0].Selected == false)
            {
                strSection = strSection + "<p><b>Safe Work Method (question 17) not answered YES :</b> You must be capable to cover for this requirement. </p>";
                bAddSection = true;
            }
            if (rbl_SWMS18.Items[0].Selected == false)
            {
                strSection = strSection + "<p><b>Safe Work Method (question 18) not answered YES :</b> You must be capable to cover for this requirement. </p>";
                bAddSection = true;
            }


            if (bAddSection == true)
            {
                strResult = strResult + "<p><b><font size=\"4\" color=\"#0099CC\">SAFE WORKS METHOD (SWMS) TAB </font></b></p>" + strSection;
                bErrorsFound = true;
            }
            //-------------------------------------------------------------END SAFE WORKS METHOD TAB--------------------------------------------------------------------------


            //-----------------------------------------EMPLOYEES    TAB--------------------------------------------------------------------------------------
            strSection = "";
            bAddSection = false;

            if (gv_employees.VisibleRowCount < 1)
            {
                strSection = strSection + "<p><b>Trade Skills :</b> You must add at least one employee. Use the add employee button  in the EMPLOYEES TAB and complete the form. </p>";
                bAddSection = true;
            }

            if (bAddSection == true)
            {
                strResult = strResult + "<p><b><font size=\"4\" color=\"#0099CC\">EMPLOYEES TAB </font></b></p>" + strSection;
                bErrorsFound = true;
            }
            //-------------------------------------------------------------END EMPLOYEES    TAB-------------------------------------------------------------------------------



            //-----------------------------------------TERMS AND CONDITIONS TAB------------------------------------------------------------------------------
            strSection = "";
            bAddSection = false;

            if (cbl_agree_maincom_site.Items[0].Selected == false)
            {
                strSection = strSection + "<p><b>Agreement to use of MAINCOM SUB CONTRACTOR SITE :</b> Must tick the check button and agree (read term and conditions). </p>";
                bAddSection = true;
            }
            if (cbl_agree_maincom_invoices.Items[0].Selected == false)
            {
                strSection = strSection + "<p><b>Agreement to use of MAINCOM INVOICES PROCEDURES :</b> Must tick the check button and agree (read term and conditions). </p>";
                bAddSection = true;
            }
            if (bAddSection == true)
            {
                strResult = strResult + "<p><b><font size=\"4\" color=\"#0099CC\">TERMS AND CONDITIONS TAB </font></b></p>" + strSection;
                bErrorsFound = true;
            }
            //-------------------------------------------------------------END TERMS AN CONDITIONS TAB-------------------------------------------------------------------------


            if (bErrorsFound == false)
            { strResult = "<p><b><font size=\"4\" color=\"#0099CC\">YOUR APPLICATION IS NOW COMPLETED  </font></b></p><br/>";
            strResult = strResult + "<p>Please <b>SUBMIT</b> your application by clicking  the submit button if you havent done so yet. </p>";
            strResult = strResult + "<p>Once you submit your application, an officer at Maincom will be notified  and will revise your application.</p>";
            strResult = strResult + "<p>If your application is successful you will be contacted by an officer from Maincom.</p><br/><br/>";
            strResult = strResult + "<p>Remember you can modify your company information at any time in this Application Form. </p>";            
            strResult = strResult + "<p>If you need to add more employees to the list please use the EMPLOYEES TAB. </p><br/><br/>";
            
            strResult = strResult + "<p>Thanks for taking the time to complete this application form. </p>";
            }


            return strResult;


        }



        [WebMethod]
        public static string UpdateCompanyDetails(string pRequestId, string pName, string pEmail, string pStreet, string pDirector, string pPhone, string psuburb,
                                                  string pAbn, string pWCnumber, string pWCexpdate,
                                                  string pLNumber, string pLNexpDate, string pjobcapacity30days, string paveragevaluejob, string pPlacesOfWork, string pCanDoLargeWork)
        {
            string result = "";

            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["DataConnectionString"].ConnectionString);
            SqlCommand myCommand = new SqlCommand(@"update subconreg_companies set company_name = '" + pName + "' , company_email_address = '" + pEmail + "', company_address = '" + pStreet + "', company_director_name = '" + pDirector + "', company_contact_phone = '" + pPhone + "' , company_abn= '" + pAbn + "',  COMPANY_COMPENSATION_NUMBER = '" + pWCnumber + "',  COMPANY_PUBLIC_LIABILITY_NUMBER = '" + pLNumber + "',  COMPANY_JOB_CAPACITY_30_DAYS ='" + pjobcapacity30days + "', COMPANY_AVERAGE_VALUEXJOB = '" + paveragevaluejob + "' , COMPANY_PLACESOFWORK = '" + pPlacesOfWork + "' , COMPANY_LARGECAPACITY_WORK = " + pCanDoLargeWork + " where request_id = " + pRequestId, conn);
            conn.Open();
            myCommand.ExecuteNonQuery();


            if (pWCexpdate != null)
            {
                pWCexpdate = Convert.ToDateTime(pWCexpdate).ToString("yyyy/MM/dd");
                myCommand = new SqlCommand(@"update subconreg_companies set  COMPANY_COMPENSATION_NUMBEREXPDATE = '" + pWCexpdate + "'  where request_id = " + pRequestId, conn);
                myCommand.ExecuteNonQuery();
            }

            if (pLNexpDate != null)
            {
                pLNexpDate = Convert.ToDateTime(pLNexpDate).ToString("yyyy/MM/dd");
                myCommand = new SqlCommand(@"update subconreg_companies set  COMPANY_PUBLICLIABILITY_NUMBEREXPDATE = '" + pLNexpDate + "'  where request_id = " + pRequestId, conn);
                myCommand.ExecuteNonQuery();
            }


            conn.Close();

            return result;
        }

 

    }
}