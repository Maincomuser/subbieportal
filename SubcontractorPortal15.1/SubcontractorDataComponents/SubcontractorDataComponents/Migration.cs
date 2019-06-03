using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace SubcontractorDataComponents
{
    public class Migration
    {
        private static string connStr = ConfigurationManager.ConnectionStrings["DataConnectionString"].ConnectionString;
      
        public static bool CheckInsuranceLocationByName(string name)
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand("Insurance_Location_Get_Location_By_Name", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Name", name);
                var dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    dr.Close();
                    conn.Close();
                    return true;
                }
                dr.Close();
                conn.Close();
                return false;
            }
        }


        public static bool CheckBusinessEntityByName(string name)
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand("BUSINESS_ENTITY_Get_Business_Entity_By_Name", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Name", name);
                var dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    dr.Close();
                    return true;
                }
                dr.Close();
                conn.Close();
                return false;
            }
        }

        public static int InsertIntoBusinessEntity( string searchCode, string name, string abn, int companyTypeID, int rating, int registeredGST,
                                                    string phone, string fax, string mobilePhone, string emailAddress, string secondaryEmailAddress, 
                                                    bool copyWorkOrderToSecondaryEmail,int engagementMethod, string street, int locationId, string password, 
                                                    string firstName, string lastName, string positionTitle)
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand("BUSINESS_ENTITY_Insert", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@SearchCode", searchCode);
                cmd.Parameters.AddWithValue("@Name", name);
                cmd.Parameters.AddWithValue("@Abn", abn);
                cmd.Parameters.AddWithValue("@CompanyTypeID", companyTypeID);
                cmd.Parameters.AddWithValue("@Rating", rating);
                cmd.Parameters.AddWithValue("@RegisteredGST", registeredGST);
                cmd.Parameters.AddWithValue("@Phone", phone);
                cmd.Parameters.AddWithValue("@PhoneExtension", DBNull.Value);
                cmd.Parameters.AddWithValue("@FAX", fax);
                cmd.Parameters.AddWithValue("@MobilePhone", mobilePhone);
                cmd.Parameters.AddWithValue("@EmailAddress", emailAddress);
                cmd.Parameters.AddWithValue("@SecondaryEmailAddress", secondaryEmailAddress);
                cmd.Parameters.AddWithValue("@CopyWorkOrderToSecondaryEmail", copyWorkOrderToSecondaryEmail);
                cmd.Parameters.AddWithValue("@EngagementMethod", engagementMethod);
                cmd.Parameters.AddWithValue("@Street", street);
                cmd.Parameters.AddWithValue("@LocationId", locationId);
                cmd.Parameters.AddWithValue("@Password", password);
                cmd.Parameters.AddWithValue("@FirstName", firstName);
                cmd.Parameters.AddWithValue("@LastName", lastName);
                cmd.Parameters.AddWithValue("@PositionTitle", positionTitle);
                var beId = Convert.ToInt32(cmd.ExecuteScalar());
                conn.Close();
                return beId;
            }
        }

        public static void InsertIntoCompany(int companyId, string acn, int baseCurrencyId)
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand("COMPANY_Insert", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@CompanyId", companyId);
                cmd.Parameters.AddWithValue("@Acn", acn);
                cmd.Parameters.AddWithValue("@BaseCurrencyId", baseCurrencyId);
                cmd.ExecuteNonQuery();
                conn.Close();
            }
        }

        public static int InsertIntoBeRelation(int parentId, int beId, int relationTypeId)
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand("BE_RELATION_Insert", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@ParentId", parentId);
                cmd.Parameters.AddWithValue("@BeId", beId);
                cmd.Parameters.AddWithValue("@RelationTypeId", relationTypeId);
                var beRelationId = Convert.ToInt32(cmd.ExecuteScalar());
               
                conn.Close();
                return beRelationId;
            }
        }
        public static void InsertIntoDebtorCreditor(int beRelationId)
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand("debtor_creditor_Insert", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@BeRelationId", beRelationId);
                cmd.ExecuteNonQuery();
                conn.Close();
            }
        }
        public static void InsertIntoInsuranceTraderTrade(int insuranceTradeId, int beId)
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand("Insurance_Trader_Trade_Insert", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@InsuranceTradeId", insuranceTradeId);
                cmd.Parameters.AddWithValue("@BeId", beId);
                cmd.ExecuteNonQuery();
                conn.Close();
            }
        }

    }
}