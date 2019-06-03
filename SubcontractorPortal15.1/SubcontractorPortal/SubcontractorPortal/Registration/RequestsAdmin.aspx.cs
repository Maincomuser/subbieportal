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
    public partial class RequestsAdmin : System.Web.UI.Page
    {
        const string UploadDirectory = "~/Images/";
        public static SqlConnection mySQLConnection;
        public static SqlCommand myCommand;

        public void ChangeRequestStatus(string strRequestId, string strNewStatus)
        {
            string strSql = "";

            if (strNewStatus == "PRE APPROVED")
            {
                strSql = @"update subconreg_requests set REQUEST_state = '" + strNewStatus + "' , REQUEST_PREAPPROVED_DATE = GETDATE() where request_id = " + strRequestId;
            }
            if (strNewStatus == "APPROVED" || strNewStatus == "REJECTED")
            {
                strSql = @"update subconreg_requests set REQUEST_state = '" + strNewStatus + "',  REQUEST_APPROVEDREJECTED_DATE= GETDATE() where request_id = " + strRequestId;
            }
            if (strNewStatus == "" || strNewStatus == "MIGRATED")
            {
                strSql = @"update subconreg_requests set REQUEST_state = '" + strNewStatus + "'  where request_id = " + strRequestId;
            }

            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["DataConnectionString"].ConnectionString);
            SqlCommand myCommand = new SqlCommand(strSql, conn);
            conn.Open();
            myCommand.ExecuteNonQuery();
            conn.Close();
        }
    
        public void btn_MigrateSubbie_Click(object sender, EventArgs e)
        {
            GridViewDataItemTemplateContainer c = ((GridViewDataItemTemplateContainer)(((LinkButton)sender).NamingContainer));

            //---------------------------------------------- LOAD THE INFORMATION THAT WILL BE REQUIRED.
            LoadCompanyDetails(c.Grid.GetRowValues(c.VisibleIndex, "request_id").ToString());
            Lbl_RequestId.Text = c.Grid.GetRowValues(c.VisibleIndex, "request_id").ToString();
            hpRequestId.Set("pRequestId", c.Grid.GetRowValues(c.VisibleIndex, "request_id").ToString());
            //-----------------------------------------------

            
            if (MigrateSubContractor())
            { 
                ChangeRequestStatus(c.Grid.GetRowValues(c.VisibleIndex, "request_id").ToString(), "MIGRATED"); 
            }
            gv_allrequests.DataBind();
            
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
                            {   rbtn_COMPANY_DID_WORK_WITH_MAINCOM.Items[0].Selected = false; rbtn_COMPANY_DID_WORK_WITH_MAINCOM.Items[1].Selected = true;}
                           
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
                                                                where  request_id = " +strRequestId+@"
                                                                  and  employee_id = " + gv_employees.GetRowValues(i, "employee_id").ToString();
                AuxGridView.DataBind();

               


            }

            
            



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

        public static string SUBCONREG_EmployeeSkillAddToDatabaseFromDisk(int pRequestId,int pEmployeeId, int pDocumentType, string pFileName, DateTime pExpirationDate)
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
        
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                AddEmployeeWindow.Visible = false;
                //LNKBTN_TC1.HRef = ".." + DA.DocumentsPath.ToString() + @"/TermsAndConditionsOfTrade.pdf";
                //LNKBTN_TC2.HRef = ".." + DA.DocumentsPath.ToString() + @"/TermsAndConditionsWorkOrder.pdf";
            }
           
        }

        protected int GetSelectedRow(string strRequestId)
        {
            int iResult = -1;
            for (int i = 0; i < gv_allrequests.VisibleRowCount; i++)
            {
                if (gv_allrequests.GetRowValues(i, "request_id").ToString() == strRequestId)
                {

                    return i;
                }
            }

            return iResult;
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

        public void SaveEmployee(string strRequestid,string strEmployeeId)
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
                if (FileUploadControlInductionCard.FileName.ToUpper().IndexOf(".PDF") < 1 &&
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
                            where   request_id =  "+strRequestid+ @" ,
                              and   employee_id = "+ strEmployeeId ;  
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
            string strRequestid = hpRequestId["pRequestId"].ToString();
            SaveEmployee(strRequestid, tbx_EmployeeId.Text);




        }

        protected void btn_SaveRequest_Click(object sender, EventArgs e)
        {
            if (Lbl_RequestId.Text.Replace("Request", "").Trim() != "")
            {


                SUBCONREG_UpdateCompanyDetails(Lbl_RequestId.Text.Replace("Request", "").Trim(), gv_allrequests.GetRowValues(GetSelectedRow(Lbl_RequestId.Text.Replace("Request", "").Trim()), "request_state").ToString());
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
            hpRequestId.Set("pRequestId" , c.Grid.GetRowValues(c.VisibleIndex, "request_id").ToString());
            
            
           for (int i = 0; i < c.Grid.VisibleRowCount;i++ )
                if (i == c.VisibleIndex)
                { c.Grid.Selection.SelectRow(c.VisibleIndex); }
                else
                { c.Grid.Selection.SetSelection(i, false); }
           CompanyDatapc.Enabled = true;

        }

        protected void btn_ExitAddEmployee_Click(object sender, EventArgs e)
        {
            AddEmployeeWindow.Visible = false;
        }

        protected void btn_AddEmployee_Click(object sender, EventArgs e)
        {
            if (Lbl_RequestId.Text != "")
            {
                AddEmployeeWindow.Visible = true;
                hpRequestId.Set("pRequestId", Lbl_RequestId.Text);
                
                //Clear the form to start adding a new employee
                tbx_EmployeeId.Text = "";
                tbx_employee_NAME.Text = "";
                tbx_employee_SURNAME.Text = "";
                tbx_employee_EMAIL.Text = "";
                tbx_employee_PHONE.Text = "";
                tbx_employee_MOBILE.Text = "";

                tbx_InductionCard.Text = "";
                tbx_InductionCardExpDate.Text = "";
                tbx_InductionCardDocId.Text = "";

                tbx_POLICECHECK_REFERENCE.Text = "";
                tbx_POLICECHECK_EXPIRYDATE.Text = "";
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

        protected void SendPreApprovedEmail(string strCompanyName, string strCompanyEmail)
        {
            string strSubject = "PRE APPROVAL of application to work for Maincom";
            string strEmailBody = @"Dear " + strCompanyName + @", <br />
                                    <br /> 
                                    We are happy to inform you that your application to work with MAINCOM was PRE APPROVED.  <br />
                                    Please login to our registration page using your login details that you previously created and complete the second part of your application.<br /> 
                                    <br />
                                    Regards, <br />
                                    Services Maincom";
            Email.SendEmail("services@maincom.net", strCompanyEmail, strSubject, strEmailBody, strCompanyEmail );
            
        }

        protected void SendApprovedEmail(string strCompanyName, string strCompanyEmail)
        {
            string strSubject = "Your Application to work for Maincom as a Sub Contractor is APPROVED";
            string strEmailBody = @"Dear " + strCompanyName + @", <br />
                                    <br /> 
                                    We are glad to inform you that your application to work with MAINCOM was APPROVED.  <br />
                                    A compulsory induction will have to completed before any work orders are allocated to you. <br />
                                    Please be advised that  our Induction details will be emailed to you separately.<br /> 
                                    <br />
                                    Regards, <br />
                                    Services Maincom";
            Email.SendEmail("services@maincom.net", strCompanyEmail, strSubject, strEmailBody, strCompanyEmail);

        }

        protected void SendRejectedEmail(string strCompanyName, string strCompanyEmail)
        {
            string strSubject = "Your Application to work for Maincom as a Sub Contractor WAS NOT SUCCESSFUL";
            string strEmailBody = @"Dear " + strCompanyName + @", 
                                   <br />
                                   <br /> 
                                   We regret to inform you that your applications to work with MAINCOM was NOT SUCCESSFUL.<br />
                                   Details of this decision will be emailed to you separetly.<br /> 
                                   <br />
                                   Regards, <br />
                                   Services Maincom";
            Email.SendEmail("services@maincom.net", strCompanyEmail, strSubject, strEmailBody, strCompanyEmail);

        }

        protected void btn_ApproveReq_Click(object sender, EventArgs e)
        {
            GridViewDataItemTemplateContainer c = ((GridViewDataItemTemplateContainer)(((LinkButton)sender).NamingContainer));
            ChangeRequestStatus(c.Grid.GetRowValues(c.VisibleIndex, "request_id").ToString(), "PRE APPROVED");
            SendPreApprovedEmail(c.Grid.GetRowValues(c.VisibleIndex, "company_name").ToString(), c.Grid.GetRowValues(c.VisibleIndex, "company_email_address").ToString());
            gv_allrequests.DataBind();
        }

        protected void btn_FinalApproveReq_Click(object sender, EventArgs e)
        {
            GridViewDataItemTemplateContainer c = ((GridViewDataItemTemplateContainer)(((LinkButton)sender).NamingContainer));
            ChangeRequestStatus(c.Grid.GetRowValues(c.VisibleIndex, "request_id").ToString(), "APPROVED");
            SendApprovedEmail(c.Grid.GetRowValues(c.VisibleIndex, "company_name").ToString(), c.Grid.GetRowValues(c.VisibleIndex, "company_email_address").ToString());
            gv_allrequests.DataBind();
        }

        protected void btn_RejectReq_Click(object sender, EventArgs e)
        {
            GridViewDataItemTemplateContainer c = ((GridViewDataItemTemplateContainer)(((LinkButton)sender).NamingContainer));
            ChangeRequestStatus(c.Grid.GetRowValues(c.VisibleIndex, "request_id").ToString(), "REJECTED");
            SendRejectedEmail(c.Grid.GetRowValues(c.VisibleIndex, "company_name").ToString(), c.Grid.GetRowValues(c.VisibleIndex, "company_email_address").ToString());
            gv_allrequests.DataBind();
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
                LinkButton tmpLnkBtn_PreApprove = ((ASPxGridView)sender).FindRowCellTemplateControl(e.VisibleIndex, e.DataColumn, "btn_ApproveReq") as LinkButton;
                LinkButton tmpLnkBtn_Approve = ((ASPxGridView)sender).FindRowCellTemplateControl(e.VisibleIndex, e.DataColumn, "btn_FinalApproveReq") as LinkButton;
                LinkButton tmpLnkBtn_Reject = ((ASPxGridView)sender).FindRowCellTemplateControl(e.VisibleIndex, e.DataColumn, "btn_RejectReq") as LinkButton;
                LinkButton tmpLnkBtn_Migrate = ((ASPxGridView)sender).FindRowCellTemplateControl(e.VisibleIndex, e.DataColumn, "btn_MigrateSubbie") as LinkButton;
                
                //Manage the state of the actions that can be taken based on the state of the request
               
                
                if (((ASPxGridView)sender).GetRowValues(e.VisibleIndex, "request_state").ToString() == "STARTED")
                {
                    tmpLnkBtn_PreApprove.Visible = false;
                    tmpLnkBtn_Approve.Visible = false;
                    tmpLnkBtn_Reject.Visible = false;
                    tmpLnkBtn_Migrate.Visible = false;
                    
                }
                if (((ASPxGridView)sender).GetRowValues(e.VisibleIndex, "request_state").ToString() == "SUBMITED")
                {
                    tmpLnkBtn_PreApprove.Visible = true;
                    tmpLnkBtn_Approve.Visible = false;
                    tmpLnkBtn_Reject.Visible = true;
                    tmpLnkBtn_Migrate.Visible = false;

                }
                if (((ASPxGridView)sender).GetRowValues(e.VisibleIndex, "request_state").ToString() == "PRE APPROVED")
                {
                    tmpLnkBtn_PreApprove.Visible = false;
                    tmpLnkBtn_Approve.Visible = false;
                    tmpLnkBtn_Reject.Visible = true;
                    tmpLnkBtn_Migrate.Visible = false;

                }
                if (((ASPxGridView)sender).GetRowValues(e.VisibleIndex, "request_state").ToString() == "COMPLETED")
                {
                    tmpLnkBtn_PreApprove.Visible = false;
                    tmpLnkBtn_Approve.Visible = true;
                    tmpLnkBtn_Reject.Visible = true;
                    tmpLnkBtn_Migrate.Visible = false;

                }
                if (((ASPxGridView)sender).GetRowValues(e.VisibleIndex, "request_state").ToString() == "APPROVED")
                {
                    tmpLnkBtn_PreApprove.Visible = false;
                    tmpLnkBtn_Approve.Visible = false;
                    tmpLnkBtn_Reject.Visible = false;
                    tmpLnkBtn_Migrate.Visible = true;
                }
                if (((ASPxGridView)sender).GetRowValues(e.VisibleIndex, "request_state").ToString() == "REJECTED")
                {
                    tmpLnkBtn_PreApprove.Visible = false;
                    tmpLnkBtn_Approve.Visible = false;
                    tmpLnkBtn_Reject.Visible = false;
                    tmpLnkBtn_Migrate.Visible = false;

                }
                if (((ASPxGridView)sender).GetRowValues(e.VisibleIndex, "request_state").ToString() == "MIGRATED")
                {
                    tmpLnkBtn_PreApprove.Visible = false;
                    tmpLnkBtn_Approve.Visible = false;
                    tmpLnkBtn_Reject.Visible = false;
                    tmpLnkBtn_Migrate.Visible = false;

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

        public void SUBCONREG_UpdateCompanyDetails(string strRequestId,string strState)
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
            { myCommand.Parameters.AddWithValue("@pCOMPANY_PUBLIC_LIABILITY_EXPDATE", Convert.ToDateTime(tbx_PublicLiabilityExpDate.Text).ToString("yyyy/MM/dd"));  }
            catch (Exception ex3)
            { myCommand.Parameters.AddWithValue("@pCOMPANY_PUBLIC_LIABILITY_EXPDATE", ""); }
            
            
                        
            myCommand.Parameters.AddWithValue("@pCOMPANY_VULNERABLEPERSON_EXPDATE", "");
            myCommand.Parameters.AddWithValue("@pCOMPANY_CONTACT_PERSON", tbx_COMPANY_CONTACT_PERSON.Text);
            myCommand.Parameters.AddWithValue("@pCOMPANY_CONTACT_POSITION",tbx_COMPANY_CONTACT_POSITION.Text);
            myCommand.Parameters.AddWithValue("@pCOMPANY_CONTACT_PHONE", tbx_CompanyContactPhone.Text);
            myCommand.Parameters.AddWithValue("@pCOMPANY_CONTACT_EMAILADDRESS",tbx_COMPANY_CONTACT_EMAILADDRESS.Text);
            
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
            myCommand.Parameters.AddWithValue("@pSTATE", strState);

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

           


        }
     
       

        [WebMethod]
        public static string UpdateCompanyDetails(string pRequestId, string pName, string pEmail, string pStreet, string pDirector, string pPhone, string psuburb,
                                                  string pAbn,  string pWCnumber, string pWCexpdate,
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


        protected bool MigrateSubContractor()
        {
            bool bResult = false;
            try
            {
                //Verify that the location added is valid in our database. (post code)
                bool success =Migration.CheckInsuranceLocationByName(cbbPostcodeSuburb.Text.Trim());
                if (success)
                {
                    
                    // Find if the name already exists in the database
                    bool duplicateFound = Migration.CheckBusinessEntityByName(tbx_CompanyName.Text.Trim());

                    if (!duplicateFound)
                    {

                        InsertRecordToVisionary(Convert.ToInt32(cbbPostcodeSuburbVValue["suburbid"].ToString()));
                        bResult = true;
                    }
                    else // alert that task can not be completed. as the record exists
                    {
                        
                    }

                    
                }
                
            }
            catch (Exception ex)
            {
                string msg = "'" + ex.Message + "'";
                Response.Write("<script>alert(" + msg + ")</script>");
            }
            return bResult;
        }


        private void InsertRecordToVisionary(int iLocationId)
        {
            int iCompanyType = 2; //2 = Pty Ltd in table Company_Types
            int iCompanyRating = 2;// 2 = Average in table Rating
            int iRegisterForGst = 2;// 2 = YES in default set up of a company
            bool bCopyWorkOrderToSecondaryEmail = false;
            int iEngagementMethod = 5; //5 = Not Specified in table EngagementMethod
            int iCurrency = 1; //1 = AUD in table Currency


            //Dont forget to resolve what the value of the password should be when we create a new company(do we keep the one they have already typed?)
            int beId = Migration.InsertIntoBusinessEntity(tbx_CompanyName.Text.Trim(), tbx_CompanyName.Text.Trim(), tbx_CompanyABN.Text.Trim(), iCompanyType, iCompanyRating,
                iRegisterForGst, tbx_CompanyContactPhone.Text.Trim(), "", "", tbx_EmailAddress.Text.Trim(),
                tbx_COMPANY_CONTACT_EMAILADDRESS.Text.Trim(), bCopyWorkOrderToSecondaryEmail, iEngagementMethod, tbx_StreetAddress.Text.Trim(), iLocationId,
                "1234", tbx_COMPANY_CONTACT_PERSON.Text.Trim(), tbx_COMPANY_CONTACT_PERSON.Text.Trim(), tbx_COMPANY_CONTACT_POSITION.Text.Trim());           

            

            // Insert into Company table  ----------------------------------------------------------------------------------------
            Migration.InsertIntoCompany(beId, tbx_CompanyABN.Text.Trim(), iCurrency); //COMPANY is the table involved here.
            //--------------------------------------------------------------------------------------------------------------------

            // Insert into BE_RELATION table -----------------------------------------------------------------------------------
            int parentId =  1;
            if (cbx_NEW_ZEALAND.Checked == true)
            {
                parentId =Convert.ToInt32( DA.MaincomCompanies.MaincomNewZealand);
            }
            else
            {
                parentId = Convert.ToInt32(DA.MaincomCompanies.MaincomServicesAU); 
            }
            int beRelationId = Migration.InsertIntoBeRelation(parentId, beId, 4);  //BE_RELATION is the table involved here.
            //------------------------------------------------------------------------------------------------------------------

            // Insert into debtor_creditor table -----------------------------------------------------------
            Migration.InsertIntoDebtorCreditor(beRelationId); //DEBTOR_CREDITOR is the table involved here.
            //----------------------------------------------------------------------------------------------

            //Create the Skills the company has instock. -----------------------------------------------
            for (int i = 1; i < CompanyTradeSkills.VisibleRowCount; i++)
            {                
                //BusinessEntities.GetTradeByName(item.ToString(), ref insuranceTradeId);
                Migration.InsertIntoInsuranceTraderTrade(Convert.ToInt32(CompanyTradeSkills.GetRowValues(i, "TRADE_ID").ToString()), beId); //INSURANCE_TRADER_TRADE is the table involved here
            }
            //------------------------------------------------------------------------------------------
            
            // Need to Decide if we will be CREATING NEW COST CENTRES FOR THE NEW BUSINESS ENTITY
            //---------------------------------------------------------------------------------------
        }
       

       
        

    }
}