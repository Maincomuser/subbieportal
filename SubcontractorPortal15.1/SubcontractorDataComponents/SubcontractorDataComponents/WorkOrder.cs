using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Text;
using Winnovative;
using System.IO;
using System.Web.UI;
using SubcontractorDataComponents;
using PublicHoliday;


namespace SubcontractorDataComponents
{
    public class WorkOrderItem 
    {
        public string RoomName { get; set; }
        public string long_desc { get; set; }
        public string l_unit { get; set; }
        public string m_unit { get; set; }
        public string LabourUnit { get; set; }
        public string MaterialUnit { get; set; }
        public string l_quantity { get; set; }
        public string m_quantity { get; set; }
        public string l_rate { get; set; }
        public string m_rate { get; set; }
        public string l_total { get; set; }
        public string m_total { get; set; }
        public string l_cost_total { get; set; }
        public string m_cost_total { get; set; }
        public string cost_total { get; set; }
        public string l_cost_rate { get; set; }
        public string m_cost_rate { get; set; }
        public string total { get; set; }

        /*
        public IEnumerator<string> GetEnumerator()
        {
            yield return RoomName;
            yield return long_desc;
            yield return l_unit;
            yield return m_unit;
            yield return LabourUnit;
            yield return MaterialUnit;
            yield return l_quantity;
            yield return m_quantity;
            yield return l_rate;
            yield return m_rate;
            yield return l_total;
            yield return m_total;
            yield return l_cost_total;
            yield return m_cost_total;
            yield return cost_total;
            yield return l_cost_rate;
            yield return m_cost_rate;
            yield return total;

        }

        System.Collections.IEnumerator System.Collections.IEnumerable.GetEnumerator()
        {
            return this.GetEnumerator();
        }
        */
    }

    public class WorkOrder 
    {
        public string OrderID;
        public string ClaimNo;
        public string Insured;
        public string InsuredPhone;
        public string PropertyAddress;
        public string SearchCode;
        public string Estimator;
        public string EstimatorPhone;
        public string InsuredMobile;
        public string InsuredEmail;
        public string EstimatorEmail;
        public string EstimatorMobile;

        public string WorkOrderDate;
        public string WorkOrderStartDate;
        public string WorkOrderCompleteDate;
        public string SupplierNotes;
        public string PublicLiability;
        public string PublicLiabilityDate;
        public string WorkersCompensation;
        public string WorkersCompensationDate;
        public string LicenceNumber;
        public string LicenceNumberDate;
        public string RegistrationNo;

        public string SubcontractorName;
        public string SubcontractorPosition;
        public string SubcontractorABN;
        public string SubcontractorPhone;
        public string SubcontractorEmail;
        public string SubcontractorMobile;
        

        public string WHSSignDate;

        public decimal MaterialTotal;
        public decimal LabourTotal;
        public string InsuranceCompany;
        public string EventType;        
        public int CompanyID;

        public int AgentID;
        public int InsurerID;

        /*-- correction for MakeSafe types */
        public string MakeSafeType;

        public string DisputeReason;
        public int WHS;
        public int CompletionCertificate;
        public int ComplianceCertificate;
        public int CreditorInvoice;
        public int ContractorPictures;
        public int SubcontractorReceipts;

        public bool IsTVRJob;
        public decimal WorkOrderAmount;
        public decimal WorkOrderAmountWithGST;

        public int HasContract;
        public string WOContact;

        public bool ComplianceRequired;
        public bool PhotosRequired;
        public bool DocsRequired;

        public string DisputeMessage;

        /*
        public List<IEnumerable<WorkOrderItem>> WorkOrderItems;
        */


        public static string CheckWorkOrderContracts(int HasContract, string workOrderID, string WorkOrderHTML)
        {
            string CheckWorkOrderContracts = null, Delimiter = null;
            string[] tmpList = null;

            //-- if contract found --> replace WO text
            if (HasContract > 0)
            {
                try
                {
                    // get trades list template
                    Delimiter = "<!-- STANDARD TEXT -->";
                    tmpList = WorkOrderHTML.Split(new[] { Delimiter }, StringSplitOptions.None);
                    CheckWorkOrderContracts = tmpList[0] + tmpList[2];
                }
                catch { }

            }
            else
            {
                try
                {
                    // get trades list template
                    Delimiter = "<!-- CONTRACT TEXT -->";
                    tmpList = WorkOrderHTML.Split(new[] { Delimiter }, StringSplitOptions.None);
                    CheckWorkOrderContracts = tmpList[0] + tmpList[2];
                }
                catch { }

            }

            return CheckWorkOrderContracts;
        }

        public static List<WorkOrderItem> GetWorkOrderItems(string workOrderID, ref WorkOrder WorkOrder)
        {
            List<WorkOrderItem> GetWorkOrderItems = new List<WorkOrderItem>();
            //decimal MaterialTotal = 0, LabourTotal = 0;
            SqlConnection conn = new SqlConnection(DA.ConnStr);
            conn.Open();
            SqlCommand comm = new SqlCommand("Insurance_WorkOrderItems_Get_Items_By_WorkOrderID", conn) { CommandType = System.Data.CommandType.StoredProcedure };
            comm.Parameters.AddWithValue("@Insurance_WorkOrderMain_Id", workOrderID);
            SqlDataReader reader = comm.ExecuteReader();
            while (reader.Read())
            {
                WorkOrderItem WorkOrderItem = new WorkOrderItem() { RoomName = reader["Room"].ToString(), long_desc = reader["long_desc"].ToString(), LabourUnit = reader["LabourUnit"].ToString(), MaterialUnit = reader["MaterialUnit"].ToString(), l_quantity = reader["l_quantity"].ToString(), m_quantity = reader["m_quantity"].ToString(), l_cost_total = reader["l_cost_total"].ToString(), m_cost_total = reader["m_cost_total"].ToString() };

                if (!DBNull.Value.Equals(reader["m_cost_total"]))
                {
                    
                    WorkOrder.MaterialTotal = WorkOrder.MaterialTotal + Convert.ToDecimal(reader["m_cost_total"]);
                }

                if (!DBNull.Value.Equals(reader["l_cost_total"]))
                {
                    WorkOrder.LabourTotal = WorkOrder.LabourTotal + Convert.ToDecimal(reader["l_cost_total"]);
                }
                GetWorkOrderItems.Add(WorkOrderItem);

            }
            reader.Close();
            reader.Dispose();
            comm.Dispose();            
            conn.Close();


            return GetWorkOrderItems;

        }

        public static List<WorkOrderItem> GetMakeSafeWorkOrderItems(string workOrderID, ref WorkOrder WorkOrder)
        {
            List<WorkOrderItem> GetWorkOrderItems = new List<WorkOrderItem>();
            //decimal MaterialTotal = 0, LabourTotal = 0;
            SqlConnection conn = new SqlConnection(DA.ConnStr);
            conn.Open();
            SqlCommand comm = new SqlCommand("Insurance_WorkOrderItems_Get_MakeSafe_Items_By_WorkOrderID", conn) { CommandType = System.Data.CommandType.StoredProcedure };
            comm.Parameters.AddWithValue("@Insurance_WorkOrderMain_Id", workOrderID);
            SqlDataReader reader = comm.ExecuteReader();
            while (reader.Read())
            {
                WorkOrderItem WorkOrderItem = new WorkOrderItem() { long_desc = reader["long_desc"].ToString(), LabourUnit = reader["LabourUnit"].ToString(), MaterialUnit = reader["MaterialUnit"].ToString(), l_quantity = reader["l_quantity"].ToString(), m_quantity = reader["m_quantity"].ToString(), l_cost_total = reader["l_total"].ToString(), m_cost_total = reader["m_total"].ToString() };

                if (!DBNull.Value.Equals(reader["m_total"]))
                {

                    WorkOrder.MaterialTotal = WorkOrder.MaterialTotal + Convert.ToDecimal(reader["m_total"]);
                }

                if (!DBNull.Value.Equals(reader["l_total"]))
                {
                    WorkOrder.LabourTotal = WorkOrder.LabourTotal + Convert.ToDecimal(reader["l_total"]);
                }
                GetWorkOrderItems.Add(WorkOrderItem);

            }
            reader.Close();
            reader.Dispose();
            comm.Dispose();
            conn.Close();


            return GetWorkOrderItems;

        }

        public static bool FoundWorkOrder(string workOrderID, bool IsStaffMember = false)
        {
            bool FoundWorkOrder = false;
            int recordNumber = 0;            
            string SubbyID = DA.ReadCookie("SubbyID");
            SqlConnection conn = new SqlConnection(DA.ConnStr);
            conn.Open();
            if (IsStaffMember)
            {
                SqlCommand comm = new SqlCommand("StaffMember_Search_Work_Order_By_ID", conn) { CommandType = System.Data.CommandType.StoredProcedure };
                comm.Parameters.AddWithValue("@WorkOrderID", workOrderID);                
                //SubbyID
                SqlDataReader reader = comm.ExecuteReader();
                while (reader.Read())
                {
                    recordNumber = (int)reader["WONumber"];
                }
                reader.Close();
                comm.Dispose();

            }
            else
            {
                SqlCommand comm = new SqlCommand("Subcontractor_Search_Work_Order_By_ID", conn) { CommandType = System.Data.CommandType.StoredProcedure };
                comm.Parameters.AddWithValue("@WorkOrderID", workOrderID);
                comm.Parameters.AddWithValue("@SubbyID", SubbyID);
                //SubbyID
                SqlDataReader reader = comm.ExecuteReader();
                while (reader.Read())
                {
                    recordNumber = (int)reader["WONumber"];
                }
                reader.Close();
                comm.Dispose();
            }
            conn.Close();
            if (recordNumber > 0)
            {
                FoundWorkOrder = true;
            }
            return FoundWorkOrder;
        }

        public static WorkOrder GetWorkOrderDetails(string workOrderID, ref Dictionary<string, string> Dictionary, bool IsElectronic = false, string Position = null, string Name = null)
        {
            bool HasQBCC = false;
            WorkOrder GetWorkOrderDetails = new WorkOrder();

            Dictionary.Add("{WOID}", workOrderID);

            SqlConnection conn = new SqlConnection(DA.ConnStr);
            conn.Open();
            SqlCommand comm = new SqlCommand("Subcontractor_Get_WorkOrder_Details", conn) { CommandType = System.Data.CommandType.StoredProcedure };
            comm.Parameters.AddWithValue("@Insurance_WorkOrderMain_Id", workOrderID);
            SqlDataReader reader = comm.ExecuteReader();
            while (reader.Read())
            {


                if (!DBNull.Value.Equals(reader["WOContact"]))
                {
                    GetWorkOrderDetails.WOContact = reader["WOContact"].ToString();
                }
                else
                {
                    GetWorkOrderDetails.WOContact = null;
                }

                if (!DBNull.Value.Equals(reader["DisputeMessage"]))
                {
                    GetWorkOrderDetails.DisputeMessage = reader["DisputeMessage"].ToString();
                }
                else
                {
                    GetWorkOrderDetails.DisputeMessage = null;
                }

                //-- fix for TVR jobs
                try
                {
                    GetWorkOrderDetails.IsTVRJob = Convert.ToBoolean(reader["IsTVRJob"]);
                }
                catch (Exception)
                {
                    GetWorkOrderDetails.IsTVRJob = false;

                }

                //-- Check if other Certificates or docs Required
                try
                {
                    GetWorkOrderDetails.ComplianceRequired = Convert.ToBoolean(reader["ComplianceRequired"]);
                }
                catch (Exception)
                {
                    GetWorkOrderDetails.ComplianceRequired = false;

                }

                try
                {
                    GetWorkOrderDetails.PhotosRequired = Convert.ToBoolean(reader["PhotosRequired"]);
                }
                catch (Exception)
                {
                    GetWorkOrderDetails.PhotosRequired = false;

                }

                try
                {
                    GetWorkOrderDetails.DocsRequired = Convert.ToBoolean(reader["DocsRequired"]);
                }
                catch (Exception)
                {
                    GetWorkOrderDetails.DocsRequired = false;

                }


                if (GetWorkOrderDetails.IsTVRJob)
                {
                    try
                    {
                        decimal GSTAmount = 0;
                        GetWorkOrderDetails.WorkOrderAmount = Convert.ToDecimal(reader["WorkOrderAmount"]);

                        GSTAmount = Math.Round((GetWorkOrderDetails.WorkOrderAmount * (decimal)DA.GST.Australia) / 100, 2);
                        GetWorkOrderDetails.WorkOrderAmountWithGST = GetWorkOrderDetails.WorkOrderAmount + GSTAmount;

                        Dictionary.Add("{WorkOrderAmount}", GetWorkOrderDetails.WorkOrderAmount.ToString());
                        Dictionary.Add("{WorkOrderAmountWithGST}", GetWorkOrderDetails.WorkOrderAmountWithGST.ToString());
                    }
                    catch (Exception)
                    {


                    }
                }
                else
                {
                    GetWorkOrderDetails.WorkOrderAmount = 0;
                    GetWorkOrderDetails.WorkOrderAmountWithGST = 0;
                }


                //-- fix for Contracts --//
                GetWorkOrderDetails.HasContract = Convert.ToInt32(reader["HasContract"]);

                //-- fix for QBCC --//

                GetWorkOrderDetails.AgentID = Convert.ToInt32(reader["Insurance_Agent_id"]);
                GetWorkOrderDetails.InsurerID = Convert.ToInt32(reader["CLIENT_ID"]);
                if (GetWorkOrderDetails.AgentID == (int)DA.Agents.QBCC || GetWorkOrderDetails.InsurerID == (int)DA.Clients.QBCC)
                {
                    HasQBCC = true;
                }
                if (HasQBCC)
                {
                    Dictionary.Add("{QBCC}", "Our client for this work is QBCC");
                }
                else
                {
                    Dictionary.Add("{QBCC}", null);
                }



                if (!DBNull.Value.Equals(reader["mContact_Email"]))
                {
                    GetWorkOrderDetails.InsuredEmail = reader["mContact_Email"].ToString();
                }
                else
                {
                    GetWorkOrderDetails.InsuredEmail = null;
                }


                if (!DBNull.Value.Equals(reader["DisputeReason"]))
                {
                    GetWorkOrderDetails.DisputeReason = reader["DisputeReason"].ToString();
                }
                else
                {
                    GetWorkOrderDetails.DisputeReason = null;
                }

                GetWorkOrderDetails.OrderID = reader["Order_id"].ToString();

                GetWorkOrderDetails.SearchCode = reader["search_code"].ToString();
                Dictionary.Add("{SEARCH_CODE}", GetWorkOrderDetails.SearchCode);

                GetWorkOrderDetails.ClaimNo = reader["supplier_ref"].ToString();
                Dictionary.Add("{supplier_ref}", GetWorkOrderDetails.ClaimNo);

                GetWorkOrderDetails.Insured = reader["main_contact"].ToString();
                Dictionary.Add("{Insured}", GetWorkOrderDetails.Insured);
                // collect all phones
                GetWorkOrderDetails.InsuredPhone = reader["mContact_Home_Phone"].ToString();
                GetWorkOrderDetails.InsuredMobile = reader["mContact_Mobile"].ToString();
                if (GetWorkOrderDetails.InsuredPhone != null)
                {
                    Dictionary.Add("{InsuredPhone}", "Phone: " + GetWorkOrderDetails.InsuredPhone);
                }
                if (GetWorkOrderDetails.InsuredMobile != null)
                {
                    Dictionary.Add("{InsuredMobile}", " Mobile: " + GetWorkOrderDetails.InsuredMobile);
                }

                GetWorkOrderDetails.PropertyAddress = reader["s_street_address"].ToString() + ", " + reader["location_name"].ToString();
                Dictionary.Add("{PropertyAddress}", GetWorkOrderDetails.PropertyAddress);

                GetWorkOrderDetails.Estimator = reader["supervisor_first_name"].ToString() + ", " + reader["supervisor_last_name"].ToString();
                Dictionary.Add("{Estimator}", GetWorkOrderDetails.Estimator);

                GetWorkOrderDetails.EstimatorPhone = reader["supervisor_mobile"].ToString();
                Dictionary.Add("{EstimatorPhone}", GetWorkOrderDetails.EstimatorPhone);

                GetWorkOrderDetails.EstimatorEmail = reader["supervisor_email"].ToString();
                Dictionary.Add("{EstimatorEmail}", GetWorkOrderDetails.EstimatorEmail);

                GetWorkOrderDetails.WorkOrderDate = reader["issued_date"].ToString();
                Dictionary.Add("{WODate}", DA.ToDate(GetWorkOrderDetails.WorkOrderDate));

                GetWorkOrderDetails.WorkOrderStartDate = reader["WO_start_date"].ToString();
                Dictionary.Add("{WOStartDate}", DA.ToDate(GetWorkOrderDetails.WorkOrderStartDate));

                GetWorkOrderDetails.WorkOrderCompleteDate = reader["WO_end_date"].ToString();
                Dictionary.Add("{WOCompleteDate}", DA.ToDate(GetWorkOrderDetails.WorkOrderCompleteDate));

                GetWorkOrderDetails.SupplierNotes = reader["work_order_notes"].ToString();
                Dictionary.Add("{SupplierNotes}", GetWorkOrderDetails.SupplierNotes);

                GetWorkOrderDetails.PublicLiability = reader["Public_Liability_number"].ToString();
                Dictionary.Add("{PublicLiability}", GetWorkOrderDetails.PublicLiability);

                GetWorkOrderDetails.PublicLiabilityDate = reader["Public_Liability_date"].ToString();
                Dictionary.Add("{PublicLiabilityDate}", GetWorkOrderDetails.PublicLiabilityDate);

                GetWorkOrderDetails.WorkersCompensation = reader["Workers_Comp_number"].ToString();
                Dictionary.Add("{WorkersCompensation}", GetWorkOrderDetails.WorkersCompensation);

                GetWorkOrderDetails.WorkersCompensationDate = reader["Workers_Comp_date"].ToString();
                Dictionary.Add("{WorkersCompensationDate}", GetWorkOrderDetails.WorkersCompensationDate);

                GetWorkOrderDetails.LicenceNumber = reader["Licence_Number"].ToString();
                Dictionary.Add("{LicenceNumber}", GetWorkOrderDetails.LicenceNumber);

                GetWorkOrderDetails.LicenceNumberDate = reader["Licence_date"].ToString();
                Dictionary.Add("{LicenceNumberDate}", GetWorkOrderDetails.LicenceNumberDate);

                GetWorkOrderDetails.SubcontractorName = reader["subbie_name"].ToString();
                Dictionary.Add("{Subcontractor}", GetWorkOrderDetails.SubcontractorName);

                GetWorkOrderDetails.SubcontractorPhone = reader["subbie_phone"].ToString();
                Dictionary.Add("{SubcontractorPhone}", GetWorkOrderDetails.SubcontractorPhone);

                GetWorkOrderDetails.SubcontractorEmail = reader["subbie_email"].ToString();
                Dictionary.Add("{SubcontractorEmail}", GetWorkOrderDetails.SubcontractorEmail);

                GetWorkOrderDetails.SubcontractorMobile = reader["subbie_mobile"].ToString();
                Dictionary.Add("{SubcontractorMobile}", GetWorkOrderDetails.SubcontractorMobile);

                GetWorkOrderDetails.SubcontractorABN = reader["subbie_abn"].ToString();
                Dictionary.Add("{ABN}", GetWorkOrderDetails.SubcontractorABN);

                GetWorkOrderDetails.RegistrationNo = reader["Registration_Number"].ToString();
                Dictionary.Add("{ContractNo}", GetWorkOrderDetails.RegistrationNo);

                GetWorkOrderDetails.InsuranceCompany = reader["insurer_name"].ToString();
                GetWorkOrderDetails.EventType = reader["EventType"].ToString();

                GetWorkOrderDetails.CompanyID = Convert.ToInt32(reader["COMPANY_ID"]);

                // temporary fix - replace later
                Dictionary.Add("{SignDate}", DateTime.Now.ToShortDateString());
                Dictionary.Add("{ClientSignature}", "_________________________________" );                


                // WHS temporary fix
                /*
                if (!DBNull.Value.Equals(reader["WHSName"]))
                {
                    Name =  reader["WHSName"].ToString();
                }
                if (!DBNull.Value.Equals(reader["WHSPosition"]))
                {
                    Position = reader["WHSName"].ToString();
                }
                */

                if (IsElectronic)
                {
                    Dictionary.Add("{Signature}", "Signed Electronically");
                }
                else
                {
                    Dictionary.Add("{Signature}", "");
                }

                if (Name != null)
                {
                    Dictionary.Add("{SubcontractorName}", Name);
                }
                else
                {
                    Dictionary.Add("{SubcontractorName}", "");
                }

                if (Position != null)
                {
                    Dictionary.Add("{SubcontractorPosition}", Position);
                }
                else
                {
                    Dictionary.Add("{SubcontractorPosition}", "");                                        
                }

                GetWorkOrderDetails.WHS = Convert.ToInt32(reader["WHS"]);
                GetWorkOrderDetails.CompletionCertificate = Convert.ToInt32(reader["CompletionCertificate"]);
                GetWorkOrderDetails.ComplianceCertificate = Convert.ToInt32(reader["ComplianceCertificate"]);
                GetWorkOrderDetails.CreditorInvoice = Convert.ToInt32(reader["CreditorInvoice"]);
                GetWorkOrderDetails.ContractorPictures = Convert.ToInt32(reader["ContractorPictures"]);
                GetWorkOrderDetails.SubcontractorReceipts = Convert.ToInt32(reader["SubcontractorReceipts"]);

                if (!DBNull.Value.Equals(reader["supervisor_mobile"]))
                {
                    GetWorkOrderDetails.EstimatorMobile = reader["supervisor_mobile"].ToString();
                }
                else
                {
                    GetWorkOrderDetails.EstimatorMobile = null;
                }


            }
            reader.Close();
            comm.Dispose();            
            conn.Close();
            
            return GetWorkOrderDetails;
        }


        public static void RecordWorkOrderSignNumber(string WorkOrderID, string SignNumber)
        {

            SqlConnection SQLConnection = new SqlConnection(DA.ConnStr);
            SQLConnection.Open();
            SqlCommand myCommand = new SqlCommand("Subcontractor_Set_WorkOrder_SignNumber", SQLConnection) { CommandType = System.Data.CommandType.StoredProcedure };
            myCommand.Parameters.AddWithValue("@WorkOrderID", WorkOrderID);
            myCommand.Parameters.AddWithValue("@SignNumber", SignNumber);                         
            myCommand.ExecuteNonQuery();
            myCommand.Dispose();
            myCommand = null;
            SQLConnection.Close();
            SQLConnection = null;
        }

        public static int CheckSignNumber(string WorkOrderID, string SignNumber)
        {
            int CheckSignNumber = 0;
            SqlConnection SQLConnection = new SqlConnection(DA.ConnStr);
            SQLConnection.Open();
            SqlCommand myCommand = new SqlCommand("Subcontractor_Check_SignNumber", SQLConnection) { CommandType = System.Data.CommandType.StoredProcedure };
            myCommand.Parameters.AddWithValue("@WorkOrderID", WorkOrderID);
            myCommand.Parameters.AddWithValue("@SignNumber", SignNumber);
            SqlDataReader Reader = myCommand.ExecuteReader();
            while (Reader.Read())
            {
                CheckSignNumber = Convert.ToInt32(Reader["HasMatch"]);
            }
            Reader.Close();
            Reader.Dispose();
            myCommand.Dispose();
            SQLConnection.Close();
            SQLConnection = null;
            return CheckSignNumber;
        }

        public static void SignCompletetionCertificate(string WorkOrderID, int SignNumber = 0)
        {

            SqlConnection SQLConnection = new SqlConnection(DA.ConnStr);
            SQLConnection.Open();
            SqlCommand myCommand = new SqlCommand("Subcontractor_WorkOrder_Sign_By_Client", SQLConnection) { CommandType = System.Data.CommandType.StoredProcedure };
            myCommand.Parameters.AddWithValue("@WorkOrderID", WorkOrderID);
            myCommand.Parameters.AddWithValue("@SignNumber", SignNumber);     
            myCommand.Parameters.AddWithValue("@userCode", DA.ReadCookie("Username"));            
            myCommand.ExecuteNonQuery();
            myCommand.Dispose();
            myCommand = null;
            SQLConnection.Close();
            SQLConnection = null;
        }

        public static WorkOrder GetMakeSafeWorkOrderDetails(string workOrderID, ref Dictionary<string, string> Dictionary)
        {
            bool HasQBCC = false;
            WorkOrder GetWorkOrderDetails = new WorkOrder();

            Dictionary.Add("{WOID}", workOrderID);

            SqlConnection conn = new SqlConnection(DA.ConnStr);
            conn.Open();
            SqlCommand comm = new SqlCommand("Subcontractor_Get_MakeSafe_WorkOrder_Details", conn) { CommandType = System.Data.CommandType.StoredProcedure };
            comm.Parameters.AddWithValue("@Insurance_WorkOrderMain_Id", workOrderID);
            SqlDataReader reader = comm.ExecuteReader();
            while (reader.Read())
            {

                //-- fix for QBCC --//

                GetWorkOrderDetails.AgentID = Convert.ToInt32(reader["Insurance_Agent_id"]);
                GetWorkOrderDetails.InsurerID = Convert.ToInt32(reader["CLIENT_ID"]);
                if (GetWorkOrderDetails.AgentID == (int)DA.Agents.QBCC || GetWorkOrderDetails.InsurerID == (int)DA.Clients.QBCC)
                {
                    HasQBCC = true;
                }
                if (HasQBCC)
                {
                    Dictionary.Add("{QBCC}", "Our client for this work is QBCC");
                }
                else
                {
                    Dictionary.Add("{QBCC}", null);
                }


                GetWorkOrderDetails.MakeSafeType = reader["make_safe_type"].ToString();

                GetWorkOrderDetails.OrderID = reader["Order_id"].ToString();

                GetWorkOrderDetails.SearchCode = reader["search_code"].ToString();
                Dictionary.Add("{SEARCH_CODE}", GetWorkOrderDetails.SearchCode);

                GetWorkOrderDetails.ClaimNo = reader["supplier_ref"].ToString();
                Dictionary.Add("{supplier_ref}", GetWorkOrderDetails.ClaimNo);

                GetWorkOrderDetails.Insured = reader["main_contact"].ToString();
                Dictionary.Add("{Insured}", GetWorkOrderDetails.Insured);
                // collect all phones
                GetWorkOrderDetails.InsuredPhone = reader["mContact_Home_Phone"].ToString();
                GetWorkOrderDetails.InsuredMobile = reader["mContact_Mobile"].ToString();
                if (GetWorkOrderDetails.InsuredPhone != null)
                {
                    Dictionary.Add("{InsuredPhone}", "Phone: " + GetWorkOrderDetails.InsuredPhone);
                }
                if (GetWorkOrderDetails.InsuredMobile != null)
                {
                    Dictionary.Add("{InsuredMobile}", " Mobile: " + GetWorkOrderDetails.InsuredMobile);
                }

                GetWorkOrderDetails.PropertyAddress = reader["s_street_address"].ToString() + ", " + reader["location_name"].ToString();
                Dictionary.Add("{PropertyAddress}", GetWorkOrderDetails.PropertyAddress);

                GetWorkOrderDetails.Estimator = reader["supervisor_first_name"].ToString() + ", " + reader["supervisor_last_name"].ToString();
                Dictionary.Add("{Estimator}", GetWorkOrderDetails.Estimator);

                GetWorkOrderDetails.EstimatorPhone = reader["supervisor_mobile"].ToString();
                Dictionary.Add("{EstimatorPhone}", GetWorkOrderDetails.EstimatorPhone);

                GetWorkOrderDetails.EstimatorEmail = reader["supervisor_email"].ToString();
                Dictionary.Add("{EstimatorEmail}", GetWorkOrderDetails.EstimatorEmail);

                GetWorkOrderDetails.WorkOrderDate = reader["issued_date"].ToString();
                Dictionary.Add("{WODate}", DA.ToDate(GetWorkOrderDetails.WorkOrderDate));

                GetWorkOrderDetails.WorkOrderStartDate = reader["WO_start_date"].ToString();
                Dictionary.Add("{WOStartDate}", DA.ToDate(GetWorkOrderDetails.WorkOrderStartDate));

                GetWorkOrderDetails.WorkOrderCompleteDate = reader["WO_end_date"].ToString();
                Dictionary.Add("{WOCompleteDate}", DA.ToDate(GetWorkOrderDetails.WorkOrderCompleteDate));

                GetWorkOrderDetails.SupplierNotes = reader["work_order_notes"].ToString();
                Dictionary.Add("{SupplierNotes}", GetWorkOrderDetails.SupplierNotes);

                GetWorkOrderDetails.PublicLiability = reader["Public_Liability_number"].ToString();
                Dictionary.Add("{PublicLiability}", GetWorkOrderDetails.PublicLiability);

                GetWorkOrderDetails.PublicLiabilityDate = reader["Public_Liability_date"].ToString();
                Dictionary.Add("{PublicLiabilityDate}", GetWorkOrderDetails.PublicLiabilityDate);

                GetWorkOrderDetails.WorkersCompensation = reader["Workers_Comp_number"].ToString();
                Dictionary.Add("{WorkersCompensation}", GetWorkOrderDetails.WorkersCompensation);

                GetWorkOrderDetails.WorkersCompensationDate = reader["Workers_Comp_date"].ToString();
                Dictionary.Add("{WorkersCompensationDate}", GetWorkOrderDetails.WorkersCompensationDate);

                GetWorkOrderDetails.LicenceNumber = reader["Licence_Number"].ToString();
                Dictionary.Add("{LicenceNumber}", GetWorkOrderDetails.LicenceNumber);

                GetWorkOrderDetails.LicenceNumberDate = reader["Licence_date"].ToString();
                Dictionary.Add("{LicenceNumberDate}", GetWorkOrderDetails.LicenceNumberDate);

                GetWorkOrderDetails.SubcontractorName = reader["subbie_name"].ToString();
                Dictionary.Add("{Subcontractor}", GetWorkOrderDetails.SubcontractorName);

                GetWorkOrderDetails.SubcontractorPhone = reader["subbie_phone"].ToString();
                Dictionary.Add("{SubcontractorPhone}", GetWorkOrderDetails.SubcontractorPhone);

                GetWorkOrderDetails.SubcontractorEmail = reader["subbie_email"].ToString();
                Dictionary.Add("{SubcontractorEmail}", GetWorkOrderDetails.SubcontractorEmail);

                GetWorkOrderDetails.SubcontractorMobile = reader["subbie_mobile"].ToString();
                Dictionary.Add("{SubcontractorMobile}", GetWorkOrderDetails.SubcontractorMobile);

                GetWorkOrderDetails.SubcontractorABN = reader["subbie_abn"].ToString();
                Dictionary.Add("{ABN}", GetWorkOrderDetails.SubcontractorABN);

                GetWorkOrderDetails.RegistrationNo = reader["Registration_Number"].ToString();
                Dictionary.Add("{ContractNo}", GetWorkOrderDetails.RegistrationNo);

                GetWorkOrderDetails.InsuranceCompany = reader["insurer_name"].ToString();
                GetWorkOrderDetails.EventType = reader["EventType"].ToString();

                GetWorkOrderDetails.CompanyID = Convert.ToInt32(reader["COMPANY_ID"]);

                // temporary fix - replace later
                Dictionary.Add("{SignDate}", DateTime.Now.ToShortDateString());
                Dictionary.Add("{ClientSignature}", "_________________________________");
                // WHS temporary fix
                Dictionary.Add("{Signature}", "");
                Dictionary.Add("{SubcontractorName}", "");
                Dictionary.Add("{SubcontractorPosition}", "");


            }
            reader.Close();
            comm.Dispose();
            conn.Close();

            return GetWorkOrderDetails;
        }



        public static string WorkOrderItemstoHTML(List<WorkOrderItem> WorkOrderItems, WorkOrder WorkOrder, int WorkOrderSectionID = 1, int countryID = 1, string TemplateToReplace = null, bool IsTVRJob = false)
        {
            string WorkOrderItemstoHTML = null;

            string path = SectionTemplatePath(WorkOrderSectionID, countryID, false, IsTVRJob); string template = DA.ReadFileToString(path);
            if (template != null)
            {
                // get Work Order Items sybtemplate from template
                string Delimiter = "<!-- WOItems -->";
                string[] tmpList = null;
                string TradesTemplate = null, tmpTemplate = null;
                tmpList = template.Split(new[] { Delimiter }, StringSplitOptions.None);
                TradesTemplate = tmpList[1];

                foreach (var WorkOrderItem in WorkOrderItems)
                {
                    // get trades teplate
                    tmpTemplate = TradesTemplate;
                    // populate subtemplate for WO Items
                    tmpTemplate = tmpTemplate.Replace("{Room}", WorkOrderItem.RoomName);
                    tmpTemplate = tmpTemplate.Replace("{WOItem}", WorkOrderItem.long_desc);
                    tmpTemplate = tmpTemplate.Replace("{m_quantity}", WorkOrderItem.m_quantity);
                    tmpTemplate = tmpTemplate.Replace("{MaterialUnit}", WorkOrderItem.MaterialUnit);
                    tmpTemplate = tmpTemplate.Replace("{m_cost_total}", WorkOrderItem.m_cost_total);
                    tmpTemplate = tmpTemplate.Replace("{l_quantity}", WorkOrderItem.l_quantity);
                    tmpTemplate = tmpTemplate.Replace("{LabourUnit}", WorkOrderItem.LabourUnit);
                    tmpTemplate = tmpTemplate.Replace("{l_cost_total}", WorkOrderItem.l_cost_total);
                    WorkOrderItemstoHTML = WorkOrderItemstoHTML + tmpTemplate;
                }

                if (TemplateToReplace != null)
                {
                    // get totals
                    decimal WOTotal = WorkOrder.MaterialTotal + WorkOrder.LabourTotal;
                    decimal GST = 0, WOTotalWithGST = 0;

                    if (countryID == (int)DA.Countries.Australia)
                    {
                        GST = WOTotal * ((decimal)DA.GST.Australia / 100);
                    }
                    else
                    {
                        GST = WOTotal * ((decimal)DA.GST.NZ / 100);
                    }
                    WOTotalWithGST = WOTotal + GST;

                    TemplateToReplace = TemplateToReplace.Replace("{MaterialTotal}", WorkOrder.MaterialTotal.ToString());
                    TemplateToReplace = TemplateToReplace.Replace("{LabourTotal}", WorkOrder.LabourTotal.ToString());
                    TemplateToReplace = TemplateToReplace.Replace("{WOTotalWithGST}", String.Format ("{0:C}",WOTotalWithGST));
                    

                    tmpList = TemplateToReplace.Split(new[] { Delimiter }, StringSplitOptions.None);
                    WorkOrderItemstoHTML = tmpList[0] + WorkOrderItemstoHTML + tmpList[2];
                }
            }            

            return WorkOrderItemstoHTML;
        }


        public static void ConvertHTMLStringToPDF(string OrderID, string htmlString, string baseURL, string DocName, bool SendAsAttachment, bool SaveToFile, string ClientReference, ref string DiskFileName)
        {
            
            //bool selectablePDF = true;

            // Create the PDF converter. Optionally the HTML viewer width can be specified as parameter
            // The default HTML viewer width is 1024 pixels.
            PdfConverter pdfConverter = new PdfConverter();

            // set the license key
            pdfConverter.LicenseKey = "rCIyIzIjMTQjOi0zIzAyLTIxLTo6Ojo=";

            // set the converter options
            pdfConverter.PdfDocumentOptions.PdfPageSize = PdfPageSize.A4;
            pdfConverter.PdfDocumentOptions.PdfCompressionLevel = PdfCompressionLevel.Normal;
            pdfConverter.PdfDocumentOptions.PdfPageOrientation = PdfPageOrientation.Portrait;
            pdfConverter.PdfDocumentOptions.TopMargin = 30;
            pdfConverter.PdfDocumentOptions.BottomMargin = 10;
            pdfConverter.PdfDocumentOptions.LeftMargin = 40;
            pdfConverter.PdfDocumentOptions.RightMargin = 30;

            // set if header and footer are shown in the PDF - optional - default is false 
            pdfConverter.PdfDocumentOptions.ShowHeader = false;
            pdfConverter.PdfDocumentOptions.ShowFooter = false;
            // set if the HTML content is resized if necessary to fit the PDF page width - default is true
            pdfConverter.PdfDocumentOptions.FitWidth = true;
            // 
            // set the embedded fonts option - optional - default is false
            pdfConverter.PdfDocumentOptions.EmbedFonts = true;

            // set the live HTTP links option - optional - default is true
            pdfConverter.PdfDocumentOptions.LiveUrlsEnabled = false;

            // set if the JavaScript is enabled during conversion to a PDF - default is true
            pdfConverter.JavaScriptEnabled = false;

            // set if the images in PDF are compressed with JPEG to reduce the PDF document size - default is true
            pdfConverter.PdfDocumentOptions.JpegCompressionEnabled = true;

            /*
            pdfConverter.PdfDocumentOptions.InternalLinksEnabled = true;
            pdfConverter.PdfDocumentOptions.LiveUrlsEnabled = true;

            pdfConverter.AuthenticationOptions.UseDefaultCredentials = true;
             */

            /*
            // Performs the conversion and get the pdf document bytes that can be further 
            // saved to a file or sent as response to browser
            //
            // The baseURL parameter helps the converter to get the CSS files and images
            // referenced by a relative URL in the HTML string.  
            */

            /*
            if (OrderID != null)
            {
                AddFooter(pdfConverter, OrderID);
            }
            */

            byte[] pdfBytes = null;
            //baseURL = HttpContext.Current.Request.Url.AbsoluteUri;


            if (baseURL.Length > 0)
            {
                pdfBytes = pdfConverter.GetPdfBytesFromHtmlString(htmlString, baseURL);
            }
            else
            {
                pdfBytes = pdfConverter.GetPdfBytesFromHtmlString(htmlString);
            }

            //pdfBytes = pdfConverter.GetPdfBytesFromHtmlString(htmlString);


            pdfBytes = pdfConverter.GetPdfBytesFromHtmlString(htmlString);


            if (SaveToFile)
            {
                DiskFileName = HttpContext.Current.Server.MapPath(DA.TemporaryDocumentsFolder) + @"\" + ClientReference + ".pdf";
                pdfConverter.SavePdfFromHtmlStringToFile(htmlString, DiskFileName);
            }

            //-- delete temp footer file
            //DA.DeleteFileFromDisk(HttpContext.Current.Server.MapPath(DA.TemporaryDocumentsFolder) + @"\" + OrderID + ".html");


            if (!SaveToFile)
            {
                // send the generated PDF document to client browser
                // get the object representing the HTTP response to browser
                HttpResponse httpResponse = HttpContext.Current.Response;

                // add the Content-Type and Content-Disposition HTTP headers
                httpResponse.AddHeader("Content-Type", "application/pdf");

                if (SendAsAttachment)
                {
                    if (DocName != null)
                    {
                        httpResponse.AddHeader("Content-Disposition", String.Format("attachment; filename=" + DocName + "-" + ClientReference + ".pdf; size={0}", pdfBytes.Length.ToString()));
                    }
                    else
                    {
                        httpResponse.AddHeader("Content-Disposition", String.Format("attachment; filename=Estimation-Quote-" + ClientReference + ".pdf; size={0}", pdfBytes.Length.ToString()));
                    }
                }
                else
                {
                    httpResponse.AddHeader("Content-Disposition", String.Format("inline; filename=Estimation-Quote-" + ClientReference + ".pdf; size={0}", pdfBytes.Length.ToString()));
                }

                // write the PDF document bytes as attachment to HTTP response 
                httpResponse.BinaryWrite(pdfBytes);
                // Note: it is important to end the response, otherwise the ASP.NET
                // web page will render its content to PDF document stream
                httpResponse.End();
            }
        }

        public static bool DocumentSaveToDatabase(string OrderID, string WorkOrderID, string DiskFileName, string FileName, int DocTypeID = 1)
        {
            bool saved = false;
            string caption = null;
            string documentpath = HttpContext.Current.Server.MapPath(DA.DocumentsPath);

            if (DocTypeID == (int)DA.DocumentTypes.WHSStatement)
            {
                caption = "WHS Statement for WO - " + WorkOrderID;
            }
            if (DocTypeID == (int)DA.DocumentTypes.CompletionCertificate)
            {
                caption = "Completion Certificate for WO - " + WorkOrderID;
            }

            string NewFileName = DA.DocumentAddToDatabaseFromDisk(OrderID, WorkOrderID, caption, DocTypeID, FileName);

            documentpath = documentpath + @"\" + DateTime.Now.Year.ToString() + @"\Insurance_document";
            if (!Directory.Exists(documentpath))
            {
                Directory.CreateDirectory(documentpath);
            }

            documentpath = documentpath + @"\" + NewFileName;

            if (File.Exists(DiskFileName))
            {
                File.Copy(DiskFileName, documentpath);
                saved = true;
            }

            File.Delete(DiskFileName);

            return saved;

        }

        public static string WorkOrderDetailstoHTML(Dictionary<string, string> Dictionary, int WorkOrderSectionID = 1, int countryID = 1, bool IsMakeSafe = false, bool IsTVRJob = false, bool IsTradecom = false)
        {
            string WorkOrderDetailstoHTML = null;
            string path = null;
            path = SectionTemplatePath(WorkOrderSectionID, countryID, IsMakeSafe, IsTVRJob, IsTradecom);
            string template = DA.ReadFileToString(path);
            if (template != null)
            {
                WorkOrderDetailstoHTML = ProcessTemplateToXML(template, Dictionary);
            }

            return WorkOrderDetailstoHTML;
        }

        public static string SectionTemplatePath(int WorkOrderSectionID = 1, int countryID = 1, bool IsMakeSafe = false, bool IsTVRJob = false, bool IsTradecom = false)
        {
            string SectionTemplatePath = null;
            
            if (countryID == (int)DA.Countries.Australia)
            {
                if (WorkOrderSectionID == (int)DA.WorkOrderSection.Details)
                {
                    if (IsMakeSafe)
                    {
                        SectionTemplatePath = String.Concat(HttpContext.Current.Server.MapPath(DA.WorkOrderTemplatePath), "\\" + DA.WorkOrderTemplateAUMakeSafe);
                    }
                    else
                    {
                        if (IsTVRJob)
                        {
                            SectionTemplatePath = String.Concat(HttpContext.Current.Server.MapPath(DA.WorkOrderTemplatePath), "\\" + DA.WorkOrderTemplateTVR);
                        }
                        else
                        {
                            if (IsTradecom)
                            {
                                SectionTemplatePath = String.Concat(HttpContext.Current.Server.MapPath(DA.WorkOrderTemplatePath), "\\" + DA.WorkOrderTemplateTradecom);
                            }
                            else
                            {
                                SectionTemplatePath = String.Concat(HttpContext.Current.Server.MapPath(DA.WorkOrderTemplatePath), "\\" + DA.WorkOrderTemplateAU);
                            }
                        }

                        //SectionTemplatePath = String.Concat(HttpContext.Current.Server.MapPath(DA.WorkOrderTemplatePath), "\\" + DA.WorkOrderTemplateAU);
                    }
                }
                if (WorkOrderSectionID == (int)DA.WorkOrderSection.WHS)
                {
                    SectionTemplatePath = String.Concat(HttpContext.Current.Server.MapPath(DA.WorkOrderTemplatePath), "\\" + DA.WHSAU);
                }
                if (WorkOrderSectionID == (int)DA.WorkOrderSection.MakeSafeRiskAssessment)
                {
                    SectionTemplatePath = String.Concat(HttpContext.Current.Server.MapPath(DA.WorkOrderTemplatePath), "\\" + DA.MakeSafeRiskAssessment);
                }

                if (WorkOrderSectionID == (int)DA.WorkOrderSection.ComletionCertificate)
                {
                    if (IsMakeSafe)
                    {
                        SectionTemplatePath = String.Concat(HttpContext.Current.Server.MapPath(DA.WorkOrderTemplatePath), "\\" + DA.CompletionCertificateMakeSafe);
                    }
                    else
                    {
                        SectionTemplatePath = String.Concat(HttpContext.Current.Server.MapPath(DA.WorkOrderTemplatePath), "\\" + DA.CompletionCertificateAU);
                    }
                }

            }
            else
            {
                if (WorkOrderSectionID == (int)DA.WorkOrderSection.Details)
                {
                    SectionTemplatePath = String.Concat(HttpContext.Current.Server.MapPath(DA.WorkOrderTemplatePath), "\\" + DA.WorkOrderTemplateNZ);
                }
                if (WorkOrderSectionID == (int)DA.WorkOrderSection.WHS)
                {
                    SectionTemplatePath = String.Concat(HttpContext.Current.Server.MapPath(DA.WorkOrderTemplatePath), "\\" + DA.WHSNZ);
                }
                if (WorkOrderSectionID == (int)DA.WorkOrderSection.ComletionCertificate)
                {
                    SectionTemplatePath = String.Concat(HttpContext.Current.Server.MapPath(DA.WorkOrderTemplatePath), "\\" + DA.CompletionCertificateNZ);
                }

            }            

            return SectionTemplatePath;

        }

        public string AddOptionsHTML(string Template, string WorkOrderID, int WorkOrderSection, string URLToPrint = null)
        {
            string AddOptionsHTML = null;
            string URL = "http://subcontractor.maincom.net/pdf.aspx?WOID=" + WorkOrderID + "&Section=" + WorkOrderSection + "&url=" + URLToPrint;
            
            string Options = @"<div id='Options' style='display:block;position:fixed;top:0;right:0;'>" +                      
                      @"<a href='" + URL + "' class='dxb'><img src='/Images/printer.png' title='Print document' alt='Print document' border=0 /></a>" +
                      @"</div>";
            /*
            string Options = @"<div id='Options' style='display:block;position:fixed;top:0;right:0;'>" +
                      @"<input id='Button1' type='button' value='Print Document' style='height:25px;border:1px solid #A4A4A4;' onclick=""window.location.replace('" + URL + @"')""/>" +
                      @"</div>";
            */
            
            /*
            string Options = @"<div id='Options' style='display:block;position:fixed;top:0;right:0;'>" +
                      @"<dx:ASPxButton ID='AcceptBtn' runat='server' Text='Print Document' UseSubmitBehavior='False' AutoPostBack='True' OnClick=""window.location.replace('" + URL + @"')"">" +
                      @"</dx:ASPxButton></div>";
            */
            AddOptionsHTML = Template.Replace("<!-- OPTIONS -->", Options);

            return AddOptionsHTML;
        }
        public static string ProcessTemplate(string Template, Dictionary<string, string> WhatToReplace)
        {
            string processTemplate = null;
            if (Template == null)
                return processTemplate;

            processTemplate = Template;
            foreach (KeyValuePair<string, string> pair in WhatToReplace)
            {
                processTemplate = processTemplate.Replace(String.Format("{{{0}}}", pair.Key), pair.Value.Replace(Environment.NewLine, "<br>"));
            }
            return processTemplate;
        }

        public static string ProcessTemplateToXML(string Template, Dictionary<string, string> WhatToReplace)
        {
            string ProcessTemplateToXML = null;
            if (Template == null)
                return ProcessTemplateToXML;

            ProcessTemplateToXML = Template;
            foreach (KeyValuePair<string, string> pair in WhatToReplace)
            {
                ProcessTemplateToXML = ProcessTemplateToXML.Replace(pair.Key, pair.Value);
            }
            return ProcessTemplateToXML;
        }


        public static string WorkOrderGetBrief(string OrderID, string workOrderID)
        {
            string WorkOrderGetBrief = null;
            SqlConnection conn = new SqlConnection(DA.ConnStr);
            conn.Open();

                SqlCommand comm = new SqlCommand("Subcontractor_Get_Work_Order_Brief", conn) { CommandType = System.Data.CommandType.StoredProcedure };
                comm.Parameters.AddWithValue("@Insurance_WorkOrderMain_Id", workOrderID);
                SqlDataReader reader = comm.ExecuteReader();
                while (reader.Read())
                {
                    WorkOrderGetBrief = "Work Order No: " + reader["Work Order No"].ToString();
                    WorkOrderGetBrief += ", Maincom Ref: " + reader["Maincom Ref"].ToString();
                    try
                    {
                        WorkOrderGetBrief += ", Start Date: " + reader["Start Date"].ToString().Substring(0, 10);
                        WorkOrderGetBrief += ", End Date: " + reader["End Date"].ToString().Substring(0, 10);
                    }
                    catch (Exception)
                    {
                    }
                    WorkOrderGetBrief += ", Address: " + reader["Property Address"].ToString();
                    WorkOrderGetBrief += ", Contact: " + reader["Contact"].ToString();
                    OrderID = reader["OrderID"].ToString();
                }
                reader.Close();
                comm.Dispose();
                comm = null;
                conn.Close();
            


            return WorkOrderGetBrief;

        }

        public static void DeclineWorkOrder(string OrderID, string workOrderID, string DeclineReason)
        {          
            string SubbyID = DA.ReadCookie("SubbyID");
            SqlConnection conn = new SqlConnection(DA.ConnStr);
            conn.Open();
            SqlCommand comm = new SqlCommand("Subcontractor_Accept_Decline_Work_Order", conn) { CommandType = System.Data.CommandType.StoredProcedure };
            comm.Parameters.AddWithValue("@OrderID", OrderID);
            comm.Parameters.AddWithValue("@Insurance_WorkOrderMain_Id", workOrderID);
            comm.Parameters.AddWithValue("@EventTypeID", 2);
            comm.Parameters.AddWithValue("@Description", DeclineReason);
            comm.Parameters.AddWithValue("@be_id", SubbyID);            
            comm.ExecuteNonQuery();
            comm.Dispose();
            conn.Close();            
        }

        public static void DeclineMakeSafeWorkOrder(string OrderID, string workOrderID, string DeclineReason)
        {
            string SubbyID = DA.ReadCookie("SubbyID");
            SqlConnection conn = new SqlConnection(DA.ConnStr);
            conn.Open();
            SqlCommand comm = new SqlCommand("Subcontractor_Accept_Decline_MakeSafe_Work_Order", conn) { CommandType = System.Data.CommandType.StoredProcedure };
            comm.Parameters.AddWithValue("@OrderID", OrderID);
            comm.Parameters.AddWithValue("@Insurance_WorkOrderMain_Id", workOrderID);
            comm.Parameters.AddWithValue("@EventTypeID", 2);
            comm.Parameters.AddWithValue("@Description", DeclineReason);
            comm.Parameters.AddWithValue("@be_id", SubbyID);
            comm.ExecuteNonQuery();
            comm.Dispose();
            conn.Close();
        }

        public static void MessageToMaincom(string OrderID, string workOrderID, string Message)
        {
            string SubbyID = DA.ReadCookie("SubbyID");
            SqlConnection conn = new SqlConnection(DA.ConnStr);
            conn.Open();
            SqlCommand comm = new SqlCommand("Subcontractor_Send_Message", conn) { CommandType = System.Data.CommandType.StoredProcedure };
            comm.Parameters.AddWithValue("@OrderID", OrderID);
            comm.Parameters.AddWithValue("@Insurance_WorkOrderMain_Id", workOrderID);
            comm.Parameters.AddWithValue("@EventTypeID", 2);
            comm.Parameters.AddWithValue("@Description", Message);
            comm.Parameters.AddWithValue("@be_id", SubbyID);
            comm.ExecuteNonQuery();
            comm.Dispose();
            conn.Close();
        }

        public static void MessageToMaincomMakeSafe(string OrderID, string workOrderID, string Message)
        {
            string SubbyID = DA.ReadCookie("SubbyID");
            SqlConnection conn = new SqlConnection(DA.ConnStr);
            conn.Open();
            SqlCommand comm = new SqlCommand("Subcontractor_Send_Message_MakeSafe", conn) { CommandType = System.Data.CommandType.StoredProcedure };
            comm.Parameters.AddWithValue("@OrderID", OrderID);
            comm.Parameters.AddWithValue("@Insurance_WorkOrderMain_Id", workOrderID);
            comm.Parameters.AddWithValue("@EventTypeID", 2);
            comm.Parameters.AddWithValue("@Description", Message);
            comm.Parameters.AddWithValue("@be_id", SubbyID);
            comm.ExecuteNonQuery(); 
            comm.Dispose();
            conn.Close();
        }

        public static void AcceptWorkOrder(string OrderID, string workOrderID, string Description, string StartDate, string EndDate, string InsuredContactDate)
        {
            string SubbyID = DA.ReadCookie("SubbyID");
            SqlConnection conn = new SqlConnection(DA.ConnStr);
            conn.Open();
            SqlCommand comm = new SqlCommand("Subcontractor_Accept_Decline_Work_Order", conn) { CommandType = System.Data.CommandType.StoredProcedure };
            comm.Parameters.AddWithValue("@OrderID", OrderID);
            comm.Parameters.AddWithValue("@Insurance_WorkOrderMain_Id", workOrderID);
            comm.Parameters.AddWithValue("@EventTypeID", 1);
            comm.Parameters.AddWithValue("@Description", Description);
            comm.Parameters.AddWithValue("@be_id", SubbyID);
            comm.Parameters.AddWithValue("@StartDate", StartDate);
            comm.Parameters.AddWithValue("@EndDate", EndDate);
            comm.Parameters.AddWithValue("@InsuredContactDate", InsuredContactDate);
            comm.ExecuteNonQuery();
            comm.Dispose();
            conn.Close();
        }

        public static void AcceptMakeSafeWorkOrder(string OrderID, string workOrderID, string Description, string StartDate, string EndDate, string InsuredContactDate)
        {
            string SubbyID = DA.ReadCookie("SubbyID");
            SqlConnection conn = new SqlConnection(DA.ConnStr);
            conn.Open();
            SqlCommand comm = new SqlCommand("Subcontractor_Accept_Decline_MakeSafe_Work_Order", conn) { CommandType = System.Data.CommandType.StoredProcedure };
            comm.Parameters.AddWithValue("@OrderID", OrderID);
            comm.Parameters.AddWithValue("@Insurance_WorkOrderMain_Id", workOrderID);
            comm.Parameters.AddWithValue("@EventTypeID", 1);
            comm.Parameters.AddWithValue("@Description", Description);
            comm.Parameters.AddWithValue("@be_id", SubbyID);
            comm.Parameters.AddWithValue("@StartDate", StartDate);
            comm.Parameters.AddWithValue("@EndDate", EndDate);
            comm.Parameters.AddWithValue("@InsuredContactDate", InsuredContactDate);
            comm.ExecuteNonQuery();
            comm.Dispose();
            conn.Close();
        }

       public static string ISODate(string DateValue)
       {
           string ISODate = null;
           string[] tmp = null;
           tmp = DateValue.Split('/');
           ISODate = tmp[2] + "-" + tmp[1] + "-" + tmp[0];
           return ISODate;
       }

        public static void ChangeDates(string OrderID, string workOrderID, string Description, string StartDate, string EndDate)
        {
            
            if (StartDate.Contains ("/"))
            {
                StartDate = ISODate(StartDate);
                EndDate = ISODate(EndDate);
            }
            string SubbyID = DA.ReadCookie("SubbyID");
            SqlConnection conn = new SqlConnection(DA.ConnStr);
            conn.Open();
            SqlCommand comm = new SqlCommand("Subcontractor_Change_Work_Order_Dates", conn) { CommandType = System.Data.CommandType.StoredProcedure };
            comm.Parameters.AddWithValue("@OrderID", OrderID);
            comm.Parameters.AddWithValue("@Insurance_WorkOrderMain_Id", workOrderID);
            comm.Parameters.AddWithValue("@EventTypeID", 1);
            comm.Parameters.AddWithValue("@Description", Description);
            comm.Parameters.AddWithValue("@be_id", SubbyID);
            comm.Parameters.AddWithValue("@StartDate", StartDate);
            comm.Parameters.AddWithValue("@EndDate", EndDate);
            
            comm.ExecuteNonQuery();
            comm.Dispose();
            conn.Close();
        }

        public static void ChangeDatesMakeSafe(string OrderID, string workOrderID, string Description, string StartDate, string EndDate)
        {

            if (StartDate.Contains("/"))
            {
                StartDate = ISODate(StartDate);
                EndDate = ISODate(EndDate);
            }
            string SubbyID = DA.ReadCookie("SubbyID");
            SqlConnection conn = new SqlConnection(DA.ConnStr);
            conn.Open();
            SqlCommand comm = new SqlCommand("Subcontractor_Change_MakeSafe_Work_Order_Dates", conn) { CommandType = System.Data.CommandType.StoredProcedure };
            comm.Parameters.AddWithValue("@OrderID", OrderID);
            comm.Parameters.AddWithValue("@Insurance_WorkOrderMain_Id", workOrderID);
            comm.Parameters.AddWithValue("@EventTypeID", 1);
            comm.Parameters.AddWithValue("@Description", Description);
            comm.Parameters.AddWithValue("@be_id", SubbyID);
            comm.Parameters.AddWithValue("@StartDate", StartDate);
            comm.Parameters.AddWithValue("@EndDate", EndDate);

            comm.ExecuteNonQuery();
            comm.Dispose();
            conn.Close();
        }

        public static void CompleteWorkOrderWithPublicHolidays(string OrderID, string workOrderID)
        {
            bool UseAustralianHolidays = true;
            string CostGuideRegionID = DA.GetCostGuideRegion(OrderID);
            AustraliaPublicHoliday.States CurrentState = AustraliaPublicHoliday.States.NSW;

            if (!String.IsNullOrEmpty(CostGuideRegionID))
            {
                if (Convert.ToInt32(CostGuideRegionID) == (int)DA.States.NSW)
                {
                    CurrentState = AustraliaPublicHoliday.States.NSW;
                }
                if (Convert.ToInt32(CostGuideRegionID) == (int)DA.States.QLD)
                {
                    CurrentState = AustraliaPublicHoliday.States.QLD;
                }
                if (Convert.ToInt32(CostGuideRegionID) == (int)DA.States.QLD)
                {
                    CurrentState = AustraliaPublicHoliday.States.QLD;
                }
                if (Convert.ToInt32(CostGuideRegionID) == (int)DA.States.SA)
                {
                    CurrentState = AustraliaPublicHoliday.States.SA;
                }
                if (Convert.ToInt32(CostGuideRegionID) == (int)DA.States.VIC)
                {
                    CurrentState = AustraliaPublicHoliday.States.VIC;
                }
                if (Convert.ToInt32(CostGuideRegionID) == (int)DA.States.WA)
                {
                    CurrentState = AustraliaPublicHoliday.States.WA;
                }
                if (Convert.ToInt32(CostGuideRegionID) == (int)DA.States.NZ)
                {
                    UseAustralianHolidays = false;
                }

            }
            else
            {
                CurrentState = AustraliaPublicHoliday.States.NSW;
            }



            /* Populate array of the days and check if any of given days falls into public holiday. If so add extra day to process */
            int NumberOfDays = 7;
            DateTime[] ApproveDates = new DateTime[7];            
            for (int i = 0; i < 6; i++)
            {
                ApproveDates[i] = DateTime.Now.AddDays(i + 1);
            }


            if (UseAustralianHolidays)
            {
                for (int i = 0; i < 6; i++)
                {

                    if (ApproveDates[i] == AustraliaPublicHoliday.AnzacDay(DateTime.Now.Year, CurrentState))
                    {
                        NumberOfDays = NumberOfDays + 1;
                    }
                    if (ApproveDates[i] == AustraliaPublicHoliday.AustraliaDay(DateTime.Now.Year))
                    {
                        NumberOfDays = NumberOfDays + 1;
                    }
                    if (ApproveDates[i] == AustraliaPublicHoliday.BoxingDay(DateTime.Now.Year))
                    {
                        NumberOfDays = NumberOfDays + 1;
                    }
                    if (ApproveDates[i] == AustraliaPublicHoliday.Christmas(DateTime.Now.Year))
                    {
                        NumberOfDays = NumberOfDays + 1;
                    }
                    if (ApproveDates[i] == AustraliaPublicHoliday.EasterMonday(DateTime.Now.Year))
                    {
                        NumberOfDays = NumberOfDays + 1;
                    }
                    if (ApproveDates[i] == AustraliaPublicHoliday.GoodFriday(DateTime.Now.Year))
                    {
                        NumberOfDays = NumberOfDays + 1;
                    }
                    if (ApproveDates[i] == AustraliaPublicHoliday.LabourDay(DateTime.Now.Year, CurrentState))
                    {
                        NumberOfDays = NumberOfDays + 1;
                    }
                    if (ApproveDates[i] == AustraliaPublicHoliday.MelbourneCup(DateTime.Now.Year))
                    {
                        NumberOfDays = NumberOfDays + 1;
                    }

                    if (ApproveDates[i] == AustraliaPublicHoliday.NewYear(DateTime.Now.Year))
                    {
                        NumberOfDays = NumberOfDays + 1;
                    }

                    if (ApproveDates[i] == AustraliaPublicHoliday.QueenBirthday(DateTime.Now.Year, CurrentState))
                    {
                        NumberOfDays = NumberOfDays + 1;
                    }

                    if (ApproveDates[i] == AustraliaPublicHoliday.WesternAustraliaDay(DateTime.Now.Year))
                    {
                        NumberOfDays = NumberOfDays + 1;
                    }

                    /* exclude weekends */
                    if (ApproveDates[i].DayOfWeek == DayOfWeek.Saturday || ApproveDates[i].DayOfWeek == DayOfWeek.Sunday)
                    {
                        NumberOfDays = NumberOfDays + 1;
                    }

                }
            }
            else
            {
                for (int i = 0; i < 6; i++)
                {

                    if (ApproveDates[i] == NewZealandPublicHoliday.AnzacDay(DateTime.Now.Year))
                    {
                        NumberOfDays = NumberOfDays + 1;
                    }

                    if (ApproveDates[i] == NewZealandPublicHoliday.BoxingDay(DateTime.Now.Year))
                    {
                        NumberOfDays = NumberOfDays + 1;
                    }

                    if (ApproveDates[i] == NewZealandPublicHoliday.Christmas(DateTime.Now.Year))
                    {
                        NumberOfDays = NumberOfDays + 1;
                    }
                    if (ApproveDates[i] == NewZealandPublicHoliday.DayAfterNewYear(DateTime.Now.Year))
                    {
                        NumberOfDays = NumberOfDays + 1;
                    }
                    if (ApproveDates[i] == NewZealandPublicHoliday.EasterMonday(DateTime.Now.Year))
                    {
                        NumberOfDays = NumberOfDays + 1;
                    }
                    if (ApproveDates[i] == NewZealandPublicHoliday.GoodFriday(DateTime.Now.Year))
                    {
                        NumberOfDays = NumberOfDays + 1;
                    }
                    if (ApproveDates[i] == NewZealandPublicHoliday.LabourDay(DateTime.Now.Year))
                    {
                        NumberOfDays = NumberOfDays + 1;
                    }
                    if (ApproveDates[i] == NewZealandPublicHoliday.NewYear(DateTime.Now.Year))
                    {
                        NumberOfDays = NumberOfDays + 1;
                    }
                    if (ApproveDates[i] == NewZealandPublicHoliday.QueenBirthday(DateTime.Now.Year))
                    {
                        NumberOfDays = NumberOfDays + 1;
                    }
                    if (ApproveDates[i] == NewZealandPublicHoliday.WaitangiDay(DateTime.Now.Year))
                    {
                        NumberOfDays = NumberOfDays + 1;
                    }

                    /* exclude weekends */
                    if (ApproveDates[i].DayOfWeek == DayOfWeek.Saturday || ApproveDates[i].DayOfWeek == DayOfWeek.Sunday)
                    {
                        NumberOfDays = NumberOfDays + 1;
                    }

                }

            }

            DateTime SentDate = DateTime.Now;
            DateTime DueDate = DateTime.Now.AddDays(NumberOfDays);          

            

            string SubbyID = DA.ReadCookie("SubbyID");
            SqlConnection conn = new SqlConnection(DA.ConnStr);
            conn.Open();
            SqlCommand comm = new SqlCommand("Subcontractor_Complete_Work_Order_DueDate", conn) { CommandType = System.Data.CommandType.StoredProcedure };
            comm.Parameters.AddWithValue("@OrderID", OrderID);
            comm.Parameters.AddWithValue("@Insurance_WorkOrderMain_Id", workOrderID);
            comm.Parameters.AddWithValue("@be_id", SubbyID);
            comm.Parameters.AddWithValue("@CompleteRequestDate", SentDate);
            comm.Parameters.AddWithValue("@DueDate", DueDate);
            comm.ExecuteNonQuery();
            comm.Dispose();
            conn.Close();
            
        }        

        public static void CompleteWorkOrder(string OrderID, string workOrderID)
        {
            string SubbyID = DA.ReadCookie("SubbyID");
            SqlConnection conn = new SqlConnection(DA.ConnStr);
            conn.Open();
            SqlCommand comm = new SqlCommand("Subcontractor_Complete_Work_Order", conn) { CommandType = System.Data.CommandType.StoredProcedure };
            comm.Parameters.AddWithValue("@OrderID", OrderID);
            comm.Parameters.AddWithValue("@Insurance_WorkOrderMain_Id", workOrderID);
            comm.Parameters.AddWithValue("@be_id", SubbyID);
            comm.ExecuteNonQuery();
            comm.Dispose();
            conn.Close();
        }

        public static void CompleteMakeSafeWorkOrder(string OrderID, string workOrderID)
        {
            string SubbyID = DA.ReadCookie("SubbyID");
            SqlConnection conn = new SqlConnection(DA.ConnStr);
            conn.Open();
            SqlCommand comm = new SqlCommand("Subcontractor_Complete_MakeSafe_Work_Order", conn) { CommandType = System.Data.CommandType.StoredProcedure };
            comm.Parameters.AddWithValue("@OrderID", OrderID);
            comm.Parameters.AddWithValue("@Insurance_WorkOrderMain_Id", workOrderID);
            comm.Parameters.AddWithValue("@be_id", SubbyID);
            comm.ExecuteNonQuery();
            comm.Dispose();
            conn.Close();
        }

        public static void VariationRequestToAudit(string OrderID, string workOrderID, string quoteID)
        {
            string SubbyID = DA.ReadCookie("SubbyID");
            SqlConnection conn = new SqlConnection(DA.ConnStr);
            conn.Open();
            SqlCommand comm = new SqlCommand("Subcontractor_Audit_Variation_Request", conn) { CommandType = System.Data.CommandType.StoredProcedure };
            comm.Parameters.AddWithValue("@OrderID", OrderID);
            comm.Parameters.AddWithValue("@Insurance_WorkOrderMain_Id", workOrderID);
            comm.Parameters.AddWithValue("@be_id", SubbyID);
            comm.Parameters.AddWithValue("@quoteID", quoteID);
            comm.ExecuteNonQuery();
            comm.Dispose();
            conn.Close();
        }

        public static void EmailRequestToCompleteWorkOrder(string WorkOrderID, string WOSearchCode, string fromAddress, string EstimatorEmail, string SubcontractorDetail = null, string CCto = null, bool IsMakeSafe = false)
        {
            string subject = null, message = null, MakeSafe = "";
            //-- Check Dates if different show in email to Supervisor
            //-- constract message
            if (SubcontractorDetail == null)
            {
                SubcontractorDetail = "Subcontractor";
            }
            if (IsMakeSafe)
            {
                MakeSafe = "Make Safe ";
            }


            /* Remove after testing with Tradecom */
            if (Convert.ToInt32(DA.ReadCookie("SubbyID")) == (int)DA.MaincomCompanies.Tradecom)
            {
                if (!IsMakeSafe)
                {
                    subject = "Notification. Subcontractor has requested to Approve " + MakeSafe + "Work Order No: " + WorkOrderID + ", Job: " + WOSearchCode;
                    message = SubcontractorDetail + " has requested to Approve " + MakeSafe + "Work Order No: " + WorkOrderID + ", Job: " + WOSearchCode + "<br><br>";
                    message = message + "Please check that the work was completed, all required documents are uploaded and Approve this Order. If not - Decline this workorder.";
                    message = message + "<br><br>Do Not Reply To This Message As It Was Sent Automatically";
                }
                else
                {
                    subject = "Notification. Subcontractor has requested to Complete " + MakeSafe + "Work Order No: " + WorkOrderID + ", Job: " + WOSearchCode;
                    message = SubcontractorDetail + " has requested to Complete " + MakeSafe + "Work Order No: " + WorkOrderID + ", Job: " + WOSearchCode + "<br><br>";
                    message = message + "Please check that the work was completed and change status for this " + MakeSafe + "Work Order to Complete.";
                    message = message + "<br><br>Do Not Reply To This Message As It Was Sent Automatically";
                }
            }
            else
            {

                subject = "Notification. Subcontractor has requested to Complete " + MakeSafe + "Work Order No: " + WorkOrderID + ", Job: " + WOSearchCode;
                message = SubcontractorDetail + " has requested to Complete " + MakeSafe + "Work Order No: " + WorkOrderID + ", Job: " + WOSearchCode + "<br><br>";
                message = message + "Please check that the work was completed and change status for this " + MakeSafe + "Work Order to Complete.";
                message = message + "<br><br>Do Not Reply To This Message As It Was Sent Automatically";
            }
            //-- send email
            Email.SendEmail(fromAddress, EstimatorEmail, subject, message, CCto);
        }


        public static void EmailChangedDates(string OrderID, string WorkOrderID, string WOSearchCode, string EstimatorEmail, string ChangeReason, string OriginalStartDate, string OriginalEndDate, string StartDate, string EndDate, string SubcontractorDetail = null)
        {
            string DateChangeStr = null, subject = null, message = null;
            //-- Check Dates if different show in email to Supervisor
            if (OriginalStartDate != StartDate || OriginalEndDate != EndDate)
            {
                try
                {
                    DateChangeStr = "Subcontractor has changed Work Order Dates from: " + OriginalStartDate.Substring(0, 10) + " - " + OriginalEndDate.Substring(0, 10) + " to " + StartDate.Substring(0, 10) + " - " + EndDate.Substring(0, 10);
                    ChangeDates(OrderID, WorkOrderID, "Subcontractor has changed Work Order dates", StartDate.Substring(0, 10), EndDate.Substring(0, 10));

                }
                catch (Exception e)
                {
                    
                    
                }
                
            }
            //-- constract message
            if (SubcontractorDetail == null)
            {
                SubcontractorDetail = "Subcontractor";
            }
            subject = "Notification. Subcontractor has changed Work Order dates for Work Order No: " + WorkOrderID + ", Job: " + WOSearchCode;
            message = SubcontractorDetail + " - Work Order Dates have been changed for Work Order: " + WorkOrderID + ", Job: " + WOSearchCode + "<br><br>";            
            message = message + DateChangeStr;
            message = message + "Reason for dates change: " + ChangeReason;
            message = message + "<br><br>Do Not Reply To This Message As It Was Sent Automatically";
            //-- send email
            Email.SendEmail(EstimatorEmail, EstimatorEmail, subject, message);
        }

        public static void EmailRequestChangedDates(string OrderID, string WorkOrderID, string WOSearchCode, string EstimatorEmail, string ChangeReason, string OriginalStartDate, string OriginalEndDate, string StartDate, string EndDate, string SubcontractorDetail = null, string CCto = null, bool IsMakeSafe = false)
        {
            string DateChangeStr = null, subject = null, message = null, MakeSafe = "";

            if (IsMakeSafe)
            {
                MakeSafe = "Make Safe ";
            }

            try
            {
                DateChangeStr = "Subcontractor has requested to change "+ MakeSafe +"Work Order Dates from: " + OriginalStartDate.Substring(0, 10) + " - " + OriginalEndDate.Substring(0, 10) + " to " + StartDate.Substring(0, 10) + " - " + EndDate.Substring(0, 10) + ". ";

            }
            catch (Exception e)
            {


            }
            //-- constract message
            if (SubcontractorDetail == null)
            {
                SubcontractorDetail = "Subcontractor";
            }

            subject = "Notification. Subcontractor has requested to change "+ MakeSafe +"Work Order dates for Work Order No: " + WorkOrderID + ", Job: " + WOSearchCode;
            message = SubcontractorDetail + " has requested to change "+ MakeSafe +"WO dates for Work Order: " + WorkOrderID + ", Job: " + WOSearchCode + "<br><br>";
            message = message + DateChangeStr;
            message = message + "Reason for dates change: " + ChangeReason;
            message = message + "<br><br>Do Not Reply To This Message As It Was Sent Automatically";
            //-- send email
            Email.SendEmail(EstimatorEmail, EstimatorEmail, subject, message, CCto);
        }


        public static void EmailAcceptedWorkOrder(string WOAddress, string OrderID, string WorkOrderID, string WOSearchCode, string EstimatorEmail, string CalledInsuredDate, string OriginalStartDate, string OriginalEndDate, string StartDate, string EndDate, string SubcontractorDetail = null, string CCto = null, bool IsMakeSafe = false)
        {
            string DateChangeStr = null, subject = null, message = null, MakeSafe = " ";
            //-- Check Dates if different show in email to Supervisor
            /*
            if (OriginalStartDate != StartDate || OriginalEndDate != EndDate)
            {
                DateChangeStr = "Subcontractor has changed Work Order Dates from: " + OriginalStartDate.Substring(0, 10) + " - " + OriginalEndDate.Substring(0, 10) + " to " + StartDate.Substring(0, 10) + " - " + EndDate.Substring(0, 10);
                ChangeDates(OrderID, WorkOrderID, "Subcontractor has changed Work Order dates", StartDate.Substring(0, 10), EndDate.Substring(0, 10));
            }
             */
            //-- constract message
            if (SubcontractorDetail == null)
            {
                SubcontractorDetail = "Subcontractor";
            }
            if (IsMakeSafe)
            {
                MakeSafe = "Make Safe ";
            }
            subject = "Notification. Subcontractor has accepted " + MakeSafe + "Work Order No: " + WorkOrderID + " for Job: " + WOSearchCode + ". Address: " + WOAddress;
            message = SubcontractorDetail + " has accepted "+ MakeSafe +"Work Order No: " + WorkOrderID + " for Job: " + WOSearchCode + "<br><br>";
            message = message + "Insured has been contacted on " + CalledInsuredDate + "<br>";
            message = message + DateChangeStr;
            message = message + DA.DoNotReply;
            //-- send email to Services
            Email.SendEmail(EstimatorEmail, EstimatorEmail, subject, message, CCto);            
        }

        public static void EmailDeclineWorkOrder(string WOAddress, string WorkOrderID, string WOSearchCode, string EstimatorEmail, string DeclineReason, string SubcontractorDetail = null, string CCto = null, bool IsMakeSafe = false)
        {
            string subject = null, message = null, MakeSafe = " ";
            //-- constract message
            if (SubcontractorDetail == null)
            {
                SubcontractorDetail = "Subcontractor";
            }

            if (IsMakeSafe)
            {
                MakeSafe = "Make Safe ";
            }
            subject = "Notification. Subcontractor has Declined " + MakeSafe + "Work Order No: " + WorkOrderID + " for Job: " + WOSearchCode + ". Address: " + WOAddress;
            message = SubcontractorDetail + " has Declined "+ MakeSafe + "Work Order No: " + WorkOrderID + " for Job: " + WOSearchCode + "<br><br>";
            message = message + "Reason: " + DeclineReason + "<br><br>";
            message = message + "Your actions: 1. Cancel " + MakeSafe +"Work Order. 2. Assign Work Order to another Subcontractor<br><br>";           
            message = message + DA.DoNotReply;
            //-- send email
            //-- send email to Services
            Email.SendEmail(EstimatorEmail, EstimatorEmail, subject, message, CCto);

        }

        public static void EmailMessageToMaincom(string WorkOrderID, string WOSearchCode, string EstimatorEmail, string SubbieMessage, string SubcontractorDetail = null, string CCto = null, bool IsMakeSafe = false)
        {
            string subject = null, message = null, MakeSafe = "";
            //-- constract message
            if (SubcontractorDetail == null)
            {
                SubcontractorDetail = "Subcontractor";
            }
            if (IsMakeSafe)
            {
                MakeSafe = "Make Safe ";
            }
            subject = "Notification. Subcontractor message in regards to " + MakeSafe + "Work Order No: " + WorkOrderID + " for Job: " + WOSearchCode;
            message = SubcontractorDetail + " message in regards to " + MakeSafe + "Work Order No: " + WorkOrderID + " for Job: " + WOSearchCode + "<br><br>";
            message = message + "Message: " +  SubbieMessage + "<br><br>";
            message = message + "Your actions: 1. Contact Subcontractor in regards to this message <br><br>";
            message = message + DA.DoNotReply;
            //-- send email
            //-- send email to Services
            Email.SendEmail(EstimatorEmail, EstimatorEmail, subject, message, CCto);
        }


        public static void EmailRequestForVariation(string WorkOrderID, string WOSearchCode, string fromAddress, string EstimatorEmail, string SubcontractorDetail = null, string CCto = null)
        {
            string subject = null, message = null;
            //-- Check Dates if different show in email to Supervisor
            //-- constract message
            if (SubcontractorDetail == null)
            {
                SubcontractorDetail = "Subcontractor";
            }
            subject = "Notification. Subcontractor has requested Variation to Work Order No: " + WorkOrderID + ", Job: " + WOSearchCode;
            message = SubcontractorDetail + " has requested requested Variation to Work Order No: " + WorkOrderID + ", Job: " + WOSearchCode + "<br><br>";
            message = message + "Please check for Variation in Quotes tab of visionary.";
            message = message + "<br><br>Do Not Reply To This Message As It Was Sent Automatically";
            //-- send email
            Email.SendEmail(fromAddress, EstimatorEmail, subject, message, CCto);
        }



        public static string Subcontractor_Get_Site_Risk_Assessment(string OrderID)
        {
            string Subcontractor_Get_Site_Risk_Assessment;
            Subcontractor_Get_Site_Risk_Assessment = null;
            int i = 0;
            SqlConnection conn = new SqlConnection(DA.ConnStr);
            conn.Open();
            SqlCommand comm = new SqlCommand("Subcontractor_Get_Site_Risk_Assessment", conn) { CommandType = System.Data.CommandType.StoredProcedure };
            comm.Parameters.AddWithValue("@OrderID", OrderID);
            SqlDataReader reader = comm.ExecuteReader();
            while (reader.Read())
            {
                 Subcontractor_Get_Site_Risk_Assessment = reader["FilePath"].ToString();
            }
            reader.Close();
            comm.Dispose();
            comm = null;
            conn.Close();
            return Subcontractor_Get_Site_Risk_Assessment;

        }


        public static string GetOrderID(string workOrderID, ref int WorkOrderStatus, ref int WO_SubbieID)
        {
            bool IsStaffMember = false;
            IsStaffMember = Users.IsStaffMember();

            string GetOrderID = null;
            string SubbyID = null;
            SqlConnection conn = new SqlConnection(DA.ConnStr);
            conn.Open();

            SqlCommand comm = new SqlCommand("Subcontractor_Get_Work_Order_Brief", conn) { CommandType = System.Data.CommandType.StoredProcedure };
            comm.Parameters.AddWithValue("@Insurance_WorkOrderMain_Id", workOrderID);
            SqlDataReader reader = comm.ExecuteReader();
            while (reader.Read())
            {
                GetOrderID = reader["OrderID"].ToString();
                WorkOrderStatus = (int)reader["status_id"];
                SubbyID = reader["be_id"].ToString();
            }
            reader.Close();
            comm.Dispose();
            comm = null;
            conn.Close();

            WO_SubbieID = Convert.ToInt32(SubbyID);

            if (IsStaffMember)
            {
                DA.SetCookie("SubbyID", SubbyID);
            }

            return GetOrderID;

        }


        public static string GetMakeSafeOrderID(string workOrderID, ref int WorkOrderStatus)
        {
            bool IsStaffMember = false;
            IsStaffMember = Users.IsStaffMember();

            string GetOrderID = null;
            string SubbyID = null;
            SqlConnection conn = new SqlConnection(DA.ConnStr);
            conn.Open();

            SqlCommand comm = new SqlCommand("Subcontractor_Get_MakeSafe_Work_Order_Brief", conn) { CommandType = System.Data.CommandType.StoredProcedure };
            comm.Parameters.AddWithValue("@Insurance_WorkOrderMain_Id", workOrderID);
            SqlDataReader reader = comm.ExecuteReader();
            while (reader.Read())
            {
                GetOrderID = reader["OrderID"].ToString();
                WorkOrderStatus = (int)reader["status_id"];
                SubbyID = reader["be_id"].ToString();
            }
            reader.Close();
            comm.Dispose();
            comm = null;
            conn.Close();

            if (IsStaffMember)
            {
                DA.SetCookie("SubbyID", SubbyID);
            }

            return GetOrderID;

        }


        public static string OtherSubbiesOnSite (string workOrderID)
        {

            List<WorkOrderItem> WorkOrderItems = new List<WorkOrderItem>();
            WorkOrder WorkOrder = new WorkOrder();
            string WorkOrderID = null, EmployeeNames = null;

            string OtherSubbiesOnSite = null;
            SqlConnection conn = new SqlConnection(DA.ConnStr);
            conn.Open();

            SqlCommand comm = new SqlCommand("Get_All_Work_Orders_By_WOID", conn) { CommandType = System.Data.CommandType.StoredProcedure };
            comm.Parameters.AddWithValue("@WorkOrderID", workOrderID);
            SqlDataReader reader = comm.ExecuteReader();
            while (reader.Read())
            {
                OtherSubbiesOnSite = OtherSubbiesOnSite + "<tr><td class=MFont colspan='2'>" + reader["start_date"].ToString() + " - " + reader["end_date"].ToString() + "; Contractor: ";
                OtherSubbiesOnSite = OtherSubbiesOnSite + reader["BE_NAME"].ToString();

                
                if (!DBNull.Value.Equals(reader["EmployeeNames"]))
                {
                    if (!String.IsNullOrEmpty(reader["EmployeeNames"].ToString()))
                    {
                        EmployeeNames = reader["EmployeeNames"].ToString();
                        EmployeeNames = EmployeeNames.Substring(0, EmployeeNames.Length - 2);
                        OtherSubbiesOnSite = OtherSubbiesOnSite + " (" + EmployeeNames + ") ";
                    }
                }

                
                OtherSubbiesOnSite = OtherSubbiesOnSite + "<br>Contact details - ";
                if (!DBNull.Value.Equals(reader["PHONE"]))
                {
                    OtherSubbiesOnSite = OtherSubbiesOnSite + "&nbsp;Phone: " + reader["PHONE"].ToString() + "; ";
                }
                if (!DBNull.Value.Equals(reader["mobile_phone"]))
                {
                    OtherSubbiesOnSite = OtherSubbiesOnSite + "&nbsp;Mobile: " + reader["mobile_phone"].ToString() + "; ";
                }
                if (!DBNull.Value.Equals(reader["fax"]))
                {
                    OtherSubbiesOnSite = OtherSubbiesOnSite + "&nbsp;Fax: " + reader["fax"].ToString() + "; ";
                }

                if (!DBNull.Value.Equals(reader["EMAIL_ADDRESS"]))
                {
                    OtherSubbiesOnSite = OtherSubbiesOnSite + "&nbsp;Email: <a href='mailto:" + reader["EMAIL_ADDRESS"].ToString() + "'>" + reader["EMAIL_ADDRESS"].ToString() + "</a>";
                }

                
                OtherSubbiesOnSite = OtherSubbiesOnSite + "</td></tr>";
                WorkOrderID = reader["Insurance_WorkOrderMain_Id"].ToString();

                //-- Get Work Order for this subbie
                WorkOrder = new WorkOrder();
                WorkOrderItems = WorkOrder.GetWorkOrderItems(WorkOrderID, ref WorkOrder);
                OtherSubbiesOnSite = OtherSubbiesOnSite + "<tr><td class=MFontLight align=left>Area</td><td class=MFontLight>Work Order Item</td></tr>";
                foreach (var WorkOrderItem in WorkOrderItems)
                {
                    OtherSubbiesOnSite = OtherSubbiesOnSite + "<tr><td align=left valign=top>" + WorkOrderItem.RoomName + "</td><td valign=top>" + WorkOrderItem.long_desc + "</td></tr>";
                }
                OtherSubbiesOnSite = OtherSubbiesOnSite + "<tr><td class=MFontLight align=left>&nbsp;</td><td class=MFontLight>&nbsp;</td></tr>";


            }
            reader.Close();
            comm.Dispose();
            comm = null;
            conn.Close();
            return OtherSubbiesOnSite;

        }

        public static string OtherSubbiesOnSiteMakeSafe(string workOrderID)
        {

            List<WorkOrderItem> WorkOrderItems = new List<WorkOrderItem>();
            WorkOrder WorkOrder = new WorkOrder();
            string WorkOrderID = null;

            string OtherSubbiesOnSite = null;
            SqlConnection conn = new SqlConnection(DA.ConnStr);
            conn.Open();

            SqlCommand comm = new SqlCommand("MakeSafe_Get_All_Work_Orders_By_WOID", conn) { CommandType = System.Data.CommandType.StoredProcedure };
            comm.Parameters.AddWithValue("@WorkOrderID", workOrderID);
            SqlDataReader reader = comm.ExecuteReader();
            while (reader.Read())
            {
                OtherSubbiesOnSite = OtherSubbiesOnSite + "<tr><td class=MFont colspan='2'>" + reader["start_date"].ToString() + " - " + reader["end_date"].ToString() + "; Contractor: ";
                OtherSubbiesOnSite = OtherSubbiesOnSite + reader["BE_NAME"].ToString();

                OtherSubbiesOnSite = OtherSubbiesOnSite + "<br>Contact details - ";
                if (!DBNull.Value.Equals(reader["PHONE"]))
                {
                    OtherSubbiesOnSite = OtherSubbiesOnSite + "&nbsp;Phone: " + reader["PHONE"].ToString() + "; ";
                }
                if (!DBNull.Value.Equals(reader["mobile_phone"]))
                {
                    OtherSubbiesOnSite = OtherSubbiesOnSite + "&nbsp;Mobile: " + reader["mobile_phone"].ToString() + "; ";
                }
                if (!DBNull.Value.Equals(reader["fax"]))
                {
                    OtherSubbiesOnSite = OtherSubbiesOnSite + "&nbsp;Fax: " + reader["fax"].ToString();
                }

                OtherSubbiesOnSite = OtherSubbiesOnSite + "</td></tr>";
                WorkOrderID = reader["Insurance_MakeSafe_WorkOrder_Id"].ToString();

                //-- Get Work Order for this subbie
                WorkOrder = new WorkOrder();
                WorkOrderItems = WorkOrder.GetMakeSafeWorkOrderItems(WorkOrderID, ref WorkOrder);
                OtherSubbiesOnSite = OtherSubbiesOnSite + "<tr><td class=MFontLight>Work Order Item</td></tr>";
                foreach (var WorkOrderItem in WorkOrderItems)
                {
                    OtherSubbiesOnSite = OtherSubbiesOnSite + "<tr><td align=left valign=top>" + WorkOrderItem.long_desc + "</td></tr>";
                }
                OtherSubbiesOnSite = OtherSubbiesOnSite + "<tr><td class=MFontLight>&nbsp;</td></tr>";


            }
            reader.Close();
            comm.Dispose();
            comm = null;
            conn.Close();
            return OtherSubbiesOnSite;

        }

        public static string GetVariationLabel(string workOrderID)
        {
            string GetOrderID = null;
            SqlConnection conn = new SqlConnection(DA.ConnStr);
            conn.Open();

            SqlCommand comm = new SqlCommand("Subcontractor_Get_Work_Order_Brief", conn) { CommandType = System.Data.CommandType.StoredProcedure };
            comm.Parameters.AddWithValue("@Insurance_WorkOrderMain_Id", workOrderID);
            SqlDataReader reader = comm.ExecuteReader();
            while (reader.Read())
            {
                GetOrderID = reader["OrderID"].ToString();
                
            }
            reader.Close();
            comm.Dispose();
            comm = null;
            conn.Close();
            return GetOrderID;

        }




    }
}