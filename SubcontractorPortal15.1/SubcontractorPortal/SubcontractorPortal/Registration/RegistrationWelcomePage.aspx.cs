using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace SubcontractorPortal.Registration
{
    public partial class RegistrationWelcomePage : System.Web.UI.Page
    {

        public static bool LoginAccountExists(string pemail,string pPassword)
        {
            bool status = false;
            string constr = ConfigurationManager.ConnectionStrings["DataConnectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(constr))
            {
                using (SqlCommand cmd = new SqlCommand("SUBCONREG_CheckLoginAccountExists", conn))
                {

                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@pEmail", pemail.Trim());
                    cmd.Parameters.AddWithValue("@pPassword", pPassword.Trim());
                    conn.Open();
                    status = Convert.ToBoolean(cmd.ExecuteScalar());
                    conn.Close();
                }
            }
            return status;
        }
        public void GetRequestInfo(string pemail, string pPassword,out string pRequestStatus,out string pRequestId )
        {

            pRequestStatus = "";
            pRequestId = "";
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["DataConnectionString"].ConnectionString);
            conn.Open();
                
            SqlCommand cmd = new SqlCommand("SUBCONREG_GetRegistrationRequestDetails", conn) { CommandType = System.Data.CommandType.StoredProcedure };                    
            cmd.Parameters.AddWithValue("@pEmail", pemail.Trim());
            cmd.Parameters.AddWithValue("@pPassword", pPassword.Trim());
                    
            cmd.Parameters.Add("@pRequestId",SqlDbType.Int);
            cmd.Parameters["@pRequestId"].Direction = ParameterDirection.Output;
            
            cmd.Parameters.Add("@pRequestDate", SqlDbType.DateTime);
            cmd.Parameters["@pRequestDate"].Direction = ParameterDirection.Output;

            cmd.Parameters.Add("@pRequestPart1CompletedDate", SqlDbType.DateTime);
            cmd.Parameters["@pRequestPart1CompletedDate"].Direction = ParameterDirection.Output;

            cmd.Parameters.Add("@pRequestPreApprovedDate", SqlDbType.DateTime);
            cmd.Parameters["@pRequestPreApprovedDate"].Direction = ParameterDirection.Output;

            cmd.Parameters.Add("@pRequestPart2CompletedDate", SqlDbType.DateTime);
            cmd.Parameters["@pRequestPart2CompletedDate"].Direction = ParameterDirection.Output;

            cmd.Parameters.Add("@pRequestApprovedRejectedDate", SqlDbType.DateTime);
            cmd.Parameters["@pRequestApprovedRejectedDate"].Direction = ParameterDirection.Output;
            
            cmd.Parameters.Add("@pRequestState", SqlDbType.VarChar,15);
            cmd.Parameters["@pRequestState"].Direction = ParameterDirection.Output;
            
            cmd.ExecuteNonQuery();
                   
            try
            {
                pRequestId = cmd.Parameters["@pRequestId"].Value.ToString();
                pRequestStatus = cmd.Parameters["@pRequestState"].Value.ToString();
            }
            catch (Exception)
            {

            }

            cmd.Dispose();
            cmd = null;
            conn.Close();
            conn = null;
            
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", @"<script type=""text/javascript"">setTimeout(()=>{ pcLogin.Hide();},0);</script>");
            }
        }

        protected void btn_CreateAccount_Click(object sender, EventArgs e)
        {
            Response.Redirect("RegistrationMandatoryDataPage.aspx");
        }

        protected void btn_signIn_Click(object sender, EventArgs e)
        {
            string strRequestStatus = "";
            string strRequestId = "";
            if (LoginAccountExists(txb_Email.Text, txb_password.Text))
            {
                //Change the Global variable value to indicate that the user is loged in 
                ConfigurationManager.AppSettings["UserIsLoggedInRegistrationSystem"] = "1";
                GetRequestInfo(txb_Email.Text.Trim(), txb_password.Text.Trim(),out strRequestStatus,out strRequestId);
                ConfigurationManager.AppSettings["SubbieRegistrationRequestId"] = strRequestId;
                if (strRequestStatus == "REJECTED")
                {
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", @"<script type=""text/javascript"">setTimeout(()=>{alert('This login is no longer valid as YOUR APPLICATION WAS NOT SUCCESSFUL');},0);</script>");
                }
                else
                {
                    if (strRequestStatus == "STARTED" || strRequestStatus == "SUBMITED")
                    {
                        Response.Redirect("CompanyData.aspx");
                    }
                    else
                    {
                        Response.Redirect("CompanyFullData.aspx");
                    }
                }
                
                
            }
            else
            {
                //Message to the user saying we have created the user.
                Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", @"<script type=""text/javascript"">setTimeout(()=>{alert('Invalid User account')},0);</script>");
            }
        }

        protected void btnRecoverPassword_Click(object sender, EventArgs e)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", @"<script type=""text/javascript"">setTimeout(()=>{alert('An e-mail has been sent out to this address with your password. ');},0);</script>");
        }
    }
}