using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevExpress.Web;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace SubcontractorPortal.Registration
{
    public partial class RegistrationMandatoryDataPage : System.Web.UI.Page
    {
        public static bool EmailExists(string email)
        {
            bool status = false;
            string constr = ConfigurationManager.ConnectionStrings["DataConnectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(constr))
            {
                using (SqlCommand cmd = new SqlCommand("SUBCONREG_CheckEmailAvailability", conn))
                {
                    
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@pEmail", email.Trim());
                    conn.Open();
                    status = Convert.ToBoolean(cmd.ExecuteScalar());
                    conn.Close();
                }
            }
            return status;
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            
           
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("RegistrationWelcomePage.aspx");
        }

        protected void btnCreateAccount_Click(object sender, EventArgs e)
        {
            if (captcha.IsValid && ASPxEdit.ValidateEditorsInContainer(this))
            {
                try
                {
                    if (EmailExists(txb_Email.Text.Trim()))
                    {
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", @"<script type=""text/javascript"">setTimeout(()=>{alert('This email address already exists. An email will be sent to you with your password to login into our system.')},0);</script>");

                    }
                    else
                    {

                        //All validations for the new loging are passed it is now time to insert the records in the database
                        string cs = System.Configuration.ConfigurationManager.ConnectionStrings["DataConnectionString"].ConnectionString;

                        SqlConnection mySQLConnection = new SqlConnection(cs);
                        mySQLConnection.Open();
                       

                        SqlCommand myCommand = new SqlCommand("SUBCONREG_CreateRequestLoginAccount", mySQLConnection) { CommandType = System.Data.CommandType.StoredProcedure };
                        myCommand.Parameters.AddWithValue("@Email", txb_Email.Text.Trim());
                        myCommand.Parameters.AddWithValue("@Password", txb_Password.Text.Trim());
                        

                        myCommand.Parameters.Add("@NewRequestId", SqlDbType.VarChar, 200);
                        myCommand.Parameters["@NewRequestId"].Direction = ParameterDirection.Output;
                        myCommand.ExecuteNonQuery();
                       
                        //  Get the new ID from the table
                        //   Subconreg_DocumentAddToDatabaseFromDisk = myCommand.Parameters["@NewFileName"].Value.ToString();
                        try
                        {
                            ConfigurationManager.AppSettings["SubbieRegistrationRequestId"] = myCommand.Parameters["@NewRequestId"].Value.ToString();
                            //Change the Global variable value to indicate that the user is loged in 
                            ConfigurationManager.AppSettings["UserIsLoggedInRegistrationSystem"] = "1";
                        }
                        catch (Exception)
                        {
                            ConfigurationManager.AppSettings["SubbieRegistrationRequestId"] = "0";                        
                            ConfigurationManager.AppSettings["UserIsLoggedInRegistrationSystem"] = "0";
                        }
                       
                        myCommand.Dispose();
                        myCommand = null;
                        mySQLConnection.Close();
                        mySQLConnection = null;
                        

                        
                   

                        //Message to the user saying we have created the user.
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", @"<script type=""text/javascript"">setTimeout(()=>{alert('You have successfully registered, please use this credentials for future use of our system.')},0);</script>");
                        Response.Redirect("CompanyData.aspx");
                    }
                }
                catch (Exception ex)
                {
                    //Message to the user saying we have created the user.
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", @"<script type=""text/javascript"">setTimeout(()=>{alert('Sorry there was a problem while trying to create your account. Please report this problem to MAINCOM and we will fix it for you.')},0);</script>");
                }

            }

        }
    }
}