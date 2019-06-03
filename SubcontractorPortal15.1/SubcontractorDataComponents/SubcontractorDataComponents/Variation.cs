using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;

namespace SubcontractorDataComponents
{
    public class Variation
    {
        public string VariationReason;
        public string VariationCaption;
        public string DateCreated;
        public string DateSent;
        public string Status;
        public string VersionLabel;
        public int StatusID;
        public int SubbyStatus;

        public static Variation GetVariationDetails(string quoteID)
        {
            Variation Variation = new Variation();            
            SqlConnection conn = new SqlConnection(DA.ConnStr);
            conn.Open();
            SqlCommand comm = new SqlCommand("Subcontractor_Get_Variation_Details", conn) { CommandType = System.Data.CommandType.StoredProcedure };
            comm.Parameters.AddWithValue("@Insurance_Quote_id", quoteID);
            SqlDataReader reader = comm.ExecuteReader();
            while (reader.Read())
            {
                Variation.VariationReason = reader["details_and_Circumstances"].ToString();
                Variation.VariationCaption = "<b>Variation Items for: " + reader["DateCreated"].ToString() + ' ' + reader["details_and_Circumstances"].ToString() + "</b>";
                Variation.DateCreated = reader["DateCreated"].ToString();
                Variation.DateSent = reader["DateSent"].ToString();
                Variation.Status = reader["Status"].ToString();
                Variation.VersionLabel = reader["VersionLabel"].ToString();
                Variation.StatusID = (int)reader["StatusID"];
                Variation.SubbyStatus = (int)reader["SubbyStatus"];
            }
            reader.Close();
            comm.Dispose();
            comm = null;
            conn.Close();

            return Variation;
        }

    }
}