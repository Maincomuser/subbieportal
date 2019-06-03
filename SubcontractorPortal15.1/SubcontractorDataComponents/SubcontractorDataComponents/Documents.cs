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

namespace SubcontractorDataComponents
{
    public class Documents
    {

        private static SqlConnection conn;
        private static SqlConnection conn1;
        private static SqlCommand cmd;
        private static SqlCommand cmd1;

        public static void Initialize()
        {
            var connStr = ConfigurationManager.ConnectionStrings["DataConnectionString"].ConnectionString;
            conn = new SqlConnection(connStr);
            conn.Open();
            cmd = new SqlCommand();
            conn1 = new SqlConnection(connStr);
            conn1.Open();
            cmd1 = new SqlCommand();
        }

        public static void CloseConnection()
        {
            if (conn != null)
            {
                conn.Close();
            }
            if (conn1 != null)
            {
                conn1.Close();
            }
        }

        public static SqlDataReader GetBusinessEntityById(int? beId)
        {
            cmd = new SqlCommand("BUSINESS_ENTITY_Get_Business_Entity_By_Id", conn) { CommandType = CommandType.StoredProcedure };
            cmd.Parameters.AddWithValue("@BeId", beId);
            SqlDataReader dr = cmd.ExecuteReader();
            return dr;
        }

        public static void GetDocTypes(ref List<string> docTypeList)
        {
            cmd1 = new SqlCommand("Subcontractor_DocTypes_Get_DocTypes", conn1) { CommandType = CommandType.StoredProcedure };
            var dr1 = cmd1.ExecuteReader();
            while (dr1.Read())
            {
                if (!dr1["DocType"].ToString().ToLower().Contains("audit") && !dr1["DocType"].ToString().ToLower().Contains("registration"))
                {
                    docTypeList.Add(dr1["DocType"].ToString());
                }
            }
            dr1.Close();
        }

        public static string InsertIntoSubcontractorDocuments(int beId, int docTypeId, DateTime expirationDate, bool? isPending, DateTime? approvedDate, string approvedBy, DateTime creationDate)
        {
            cmd1 = new SqlCommand("Subcontractor_Documents_Insert", conn1) { CommandType = CommandType.StoredProcedure };
            cmd1.Parameters.AddWithValue("@BeId", beId);
            cmd1.Parameters.AddWithValue("@DoctypeId", docTypeId);
            cmd1.Parameters.AddWithValue("@ExpirationDate", expirationDate);
            if (isPending != null)
            {
                cmd1.Parameters.AddWithValue("@IsPending", isPending);
                cmd1.Parameters.AddWithValue("@Approved", approvedDate == null ? new DateTime(1900, 1, 1) : approvedDate);
                cmd1.Parameters.AddWithValue("@ApprovedBy", approvedBy == null ? "" : approvedBy);
            }
            else
            {
                cmd1.Parameters.AddWithValue("@IsPending", DBNull.Value);
                cmd1.Parameters.AddWithValue("@Approved", DBNull.Value);
                cmd1.Parameters.AddWithValue("@ApprovedBy", DBNull.Value);
            }
            cmd1.Parameters.AddWithValue("@CreationDate", creationDate);
            var guId = Convert.ToString(cmd1.ExecuteScalar());
            return guId;
        }

        public static List<string> GetDocumentByBusinessEntityAndDoctype(int beId, int docType)
        {
            cmd1 = new SqlCommand("Subcontractor_Documents_Get_By_Be_And_Doctype", conn1);
            cmd1.CommandType = CommandType.StoredProcedure;
            cmd1.Parameters.AddWithValue("@BeId", beId);
            cmd1.Parameters.AddWithValue("@DoctypeId", docType);
            var dr1 = cmd1.ExecuteReader();
            List<string> guIdList = new List<string>();
            while (dr1.Read())
            {
                guIdList.Add(Convert.ToString(dr1["GUID"]));
            }
            dr1.Close();
            return guIdList;
        }


        public static void DeleteDocumentByGuid(string guId)
        {
            cmd1 = new SqlCommand("Subcontractor_Documents_Delete_By_Guid", conn1);
            cmd1.CommandType = CommandType.StoredProcedure;
            cmd1.Parameters.AddWithValue("@Guid", guId);
            cmd1.ExecuteNonQuery();
        }

        public static List<string> GetDocumentApprovedInfoByBusinessEntityAndDoctype(int beId, int docType)
        {
            cmd1 = new SqlCommand("Subcontractor_Documents_Get_By_Be_And_Doctype", conn1);
            cmd1.CommandType = CommandType.StoredProcedure;
            cmd1.Parameters.AddWithValue("@BeId", beId);
            cmd1.Parameters.AddWithValue("@DoctypeId", docType);
            var dr1 = cmd1.ExecuteReader();
            List<string> approvedByList = new List<string>();
            while (dr1.Read())
            {
                approvedByList.Add(Convert.ToString(dr1["ApprovedBy"]));
            }
            dr1.Close();
            return approvedByList;
        }



    }
}