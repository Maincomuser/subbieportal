using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;

namespace SubcontractorDataComponents
{
    public class Users
    {
        public enum WrongUserRedirect { DefaultPage = 0, Nowhere = 1 };
        /// Subby logon to visionary
        public static bool SubbyLogonToVisionary(string username, string password, ref bool IsStaffMember)
        {
            bool SubbyLogonToVisionary = false;
            string BE_ID = null;
            SqlDataReader reader = DA.StoredProReader("Subcontractor_Login", DA.ConnStr, "username|password", username + "|" + password);
            if (reader != null)
            {
                while (reader.Read())
                {
                    BE_ID = reader["BE_ID"].ToString();
                    SubbyLogonToVisionary = true;
                }

            }
            /*
            if (reader != null)
                while (reader.Read())
                {
                    //Compare the encrypted password with the existing password from the database.                    
                    System.Data.SqlTypes.SqlBinary pwd = reader.GetSqlBinary(0);
                    string a = Convert.ToBase64String(pwd.Value);
                    string b = Convert.ToBase64String(Encryption.DESString(password, 512));
                    if (a == b)
                    {
                        SubbyLogonToVisionary = true;                        
                        BE_ID = reader["BE_ID"].ToString();
                    }
                }
            */
            if (reader != null) { reader.Close(); reader = null; DA.mySQLConnection.Close(); }
            // set cookies to trace user
            if (SubbyLogonToVisionary) {
                DA.SetCookie("SubbyID", BE_ID); DA.SetCookie("Username", username);                
            }
            else
            {
                //-- check if this is login for staff member
                SubbyLogonToVisionary = UserLogonToVisionary(username, password);
                if (SubbyLogonToVisionary)
                {
                    IsStaffMember = true;
                }
            }
            return SubbyLogonToVisionary;
        }


        /// Using Visionary Approach to user login --> separate database with logins
        public static bool UserLogonToVisionary(string username, string password)
        {
            bool userLoginVisionary = false, IsLimited = false;

            string loginName = String.Empty, IsLimitedSupervisor = String.Empty;

            SqlDataReader reader = default(SqlDataReader);
            
            try
            {
                reader = DA.StoredProReader("GetPassword", DA.LoginConnStr, "username", username);
            }
            catch (SqlException)
            {
                reader = default(SqlDataReader);
            }          
            

            if ((reader != null) && reader.HasRows)
            {
                while (reader.Read())
                {
                    //Compare the encrypted password with the existing password from the database.
                    System.Data.SqlTypes.SqlBinary pwd = reader.GetSqlBinary(0);

                    string a = Convert.ToBase64String(pwd.Value);
                    string b = Convert.ToBase64String(Encryption.DESString(password, 512));

                    if (a == b)
                    {
                        userLoginVisionary = true;
                        loginName = reader["description"].ToString();
                        if ((bool)reader["IsLimitedSupervisor"])
                        {                            
                            IsLimited = true;
                        }
                    }
                }

                reader.Close();
                reader.Dispose();

                reader = null;
            }

            DA.mySQLConnection.Close();

            // set cookies to trace user
            if (userLoginVisionary && !IsLimited)
            {
                DA.SetCookie("Staff", "1");
                DA.SetCookie("Username", loginName);
            }
            if (userLoginVisionary && IsLimited)
            {
                userLoginVisionary = false;
            }

            return userLoginVisionary;
        }


        /// checks if userID is set in cookies
        public static void CheckUser(int SubPage = 0)
        {
            string userID = null;
            userID = DA.ReadCookie("SubbyID");            
            if (userID == null)
                if (SubPage == 0)
                {
                    HttpContext.Current.Server.Transfer("/default.aspx");
                }
                else
                {
                    HttpContext.Current.Response.End();
                }
        }

        public static bool IsStaffMember()
        {
            bool IsStaffMember = false;
            string staff = null;
            staff = DA.ReadCookie("Staff");
            if (staff != null)
            {
                IsStaffMember = true;
            }
            return IsStaffMember;
        }

        public static void CheckStaffUser(int SubPage = 0)
        {
            string staff = null;            
            staff = DA.ReadCookie("Staff");
            if (staff == null)
                if (SubPage == 0)
                {
                    HttpContext.Current.Server.Transfer("/default.aspx");                    
                }
                else
                {
                    HttpContext.Current.Response.End();
                }
        }

        public static void Logout()
        {
            string[] currcookies;
            currcookies = HttpContext.Current.Request.Cookies.AllKeys;
            foreach (string cookie in currcookies)
            {
                HttpContext.Current.Response.Cookies[cookie].Expires = DateTime.Now.AddDays(-1);
                HttpContext.Current.Response.Cookies[cookie].Value = "";
            }
            HttpContext.Current.Server.Transfer("/default.aspx");
        }

    }
}