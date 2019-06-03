using System;
using System.Collections;
using System.Collections.Generic;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;

namespace SubcontractorDataComponents
{
    /// <summary>
    /// 
    /// </summary>
    public partial class DA
    {
        #region Image / File Operations

        public static void PhotoAddToDatabase(int OrderID, string filename, byte[] image, int WorkOrderID, int QuoteID)
        {
            mySQLConnection = new SqlConnection(ConnStr);
            mySQLConnection.Open();
            myCommand = new SqlCommand("Insurance_Document_Photo_Insert", mySQLConnection) { CommandType = System.Data.CommandType.StoredProcedure };
            myCommand.Parameters.AddWithValue("@OrderID", OrderID);
            myCommand.Parameters.AddWithValue("@created_by", ReadCookie("Username"));
            myCommand.Parameters.AddWithValue("@attach_filename", filename);
            myCommand.Parameters.AddWithValue("@attach", image);
            myCommand.Parameters.AddWithValue("@SubcontractorID", ReadCookie("SubbyID"));
            myCommand.Parameters.AddWithValue("@WorkOrderID", WorkOrderID);
            myCommand.Parameters.AddWithValue("@QuoteID", QuoteID);
            myCommand.ExecuteNonQuery();
            myCommand.Dispose();
            myCommand = null;
            mySQLConnection.Close();
            mySQLConnection = null;
        }

        public static void SubcontractorPhotoAddToDatabase(int OrderID, string filename, byte[] image, int WorkOrderID, int QuoteID, string Caption)
        {
            mySQLConnection = new SqlConnection(ConnStr);
            mySQLConnection.Open();
            myCommand = new SqlCommand("Subcontractor_Insurance_Document_Photo_Insert", mySQLConnection) { CommandType = System.Data.CommandType.StoredProcedure };
            myCommand.Parameters.AddWithValue("@OrderID", OrderID);
            myCommand.Parameters.AddWithValue("@created_by", ReadCookie("Username"));
            myCommand.Parameters.AddWithValue("@attach_filename", filename);
            myCommand.Parameters.AddWithValue("@attach", image);
            myCommand.Parameters.AddWithValue("@SubcontractorID", ReadCookie("SubbyID"));
            myCommand.Parameters.AddWithValue("@WorkOrderID", WorkOrderID);
            myCommand.Parameters.AddWithValue("@QuoteID", QuoteID);
            myCommand.Parameters.AddWithValue("@Caption", Caption);
            myCommand.ExecuteNonQuery();
            myCommand.Dispose();
            myCommand = null;
            mySQLConnection.Close();
            mySQLConnection = null;
        }
        

        public static bool ByteArrayToFile(string _FileName, byte[] _ByteArray)
        {
            try
            {
                // Open file for reading
                System.IO.FileStream _FileStream =
                   new System.IO.FileStream(_FileName, System.IO.FileMode.Create, System.IO.FileAccess.Write);
                // Writes a block of bytes to this stream using data from
                // a byte array.
                _FileStream.Write(_ByteArray, 0, _ByteArray.Length);

                // close file stream
                _FileStream.Close();

                return true;
            }
            catch (Exception _Exception)
            {
                // Error
                //Console.WriteLine("Exception caught in process: {0}", _Exception.ToString());
            }

            // error occured, return false
            return false;
        }


        public static string PhotoDeleteFromDatabaseAndDisk(string DocID)
        {
            string PhotoDeleteFromDatabaseAndDisk = null;
            mySQLConnection = new SqlConnection(ConnStr);
            mySQLConnection.Open();
            myCommand = new SqlCommand("Insurance_Document_Delete_From_Disk", mySQLConnection) { CommandType = System.Data.CommandType.StoredProcedure };
            myCommand.Parameters.AddWithValue("@DocID", DocID);
            myCommand.Parameters.Add("@DiskFileName", SqlDbType.VarChar, 200);
            myCommand.Parameters["@DiskFileName"].Direction = ParameterDirection.Output;

            myCommand.ExecuteNonQuery();
            try
            {
                PhotoDeleteFromDatabaseAndDisk = myCommand.Parameters["@DiskFileName"].Value.ToString();
            }
            catch (Exception)
            {

            }
            myCommand.Dispose();
            myCommand = null;
            mySQLConnection.Close();
            mySQLConnection = null;
            return PhotoDeleteFromDatabaseAndDisk;
        }

        public static string SubcontractorDocumentAddToDatabaseFromDisk(int OrderID, string filename, string WorkOrderID,  string Caption, int DocumentType)
        {
            string SubcontractorPhotoAddToDatabaseFromDisk = null;
            mySQLConnection = new SqlConnection(ConnStr);
            mySQLConnection.Open();
            myCommand = new SqlCommand("Subcontractor_Insurance_Document_Insert_From_Disk", mySQLConnection) { CommandType = System.Data.CommandType.StoredProcedure };
            myCommand.Parameters.AddWithValue("@OrderID", OrderID);
            myCommand.Parameters.AddWithValue("@created_by", ReadCookie("Username"));
            myCommand.Parameters.AddWithValue("@attach_filename", filename);
            myCommand.Parameters.AddWithValue("@SubcontractorID", ReadCookie("SubbyID"));
            myCommand.Parameters.AddWithValue("@WorkOrderID", WorkOrderID);            
            myCommand.Parameters.AddWithValue("@Caption", Caption);
            myCommand.Parameters.AddWithValue("@Insurance_Document_Type_Id", DocumentType);
            myCommand.Parameters.Add("@NewFileName", SqlDbType.VarChar, 200);
            myCommand.Parameters["@NewFileName"].Direction = ParameterDirection.Output;
            myCommand.ExecuteNonQuery();
            try
            {
                SubcontractorPhotoAddToDatabaseFromDisk = myCommand.Parameters["@NewFileName"].Value.ToString();
            }
            catch (Exception)
            {

            }
            myCommand.Dispose();
            myCommand = null;
            mySQLConnection.Close();
            mySQLConnection = null;
            return SubcontractorPhotoAddToDatabaseFromDisk;
        }
       
     

        public static string SubcontractorPhotoAddToDatabaseFromDisk(int OrderID, string filename, string WorkOrderID, string QuoteID, string Caption)
        {
            string SubcontractorPhotoAddToDatabaseFromDisk = null;
            mySQLConnection = new SqlConnection(ConnStr);
            mySQLConnection.Open();
            myCommand = new SqlCommand("Subcontractor_Insurance_Document_Photo_Insert_From_Disk", mySQLConnection) { CommandType = System.Data.CommandType.StoredProcedure };
            myCommand.Parameters.AddWithValue("@OrderID", OrderID);
            myCommand.Parameters.AddWithValue("@created_by", ReadCookie("Username"));
            myCommand.Parameters.AddWithValue("@attach_filename", filename);
            myCommand.Parameters.AddWithValue("@SubcontractorID", ReadCookie("SubbyID"));
            myCommand.Parameters.AddWithValue("@WorkOrderID", WorkOrderID);
            myCommand.Parameters.AddWithValue("@QuoteID", QuoteID);
            myCommand.Parameters.AddWithValue("@Caption", Caption);
            myCommand.Parameters.Add("@NewFileName", SqlDbType.VarChar, 200);
            myCommand.Parameters["@NewFileName"].Direction = ParameterDirection.Output;
            myCommand.ExecuteNonQuery();
            try
            {
                SubcontractorPhotoAddToDatabaseFromDisk = myCommand.Parameters["@NewFileName"].Value.ToString();
            }
            catch (Exception)
            {

            }
            myCommand.Dispose();
            myCommand = null;
            mySQLConnection.Close();
            mySQLConnection = null;
            return SubcontractorPhotoAddToDatabaseFromDisk;
        }


        public static byte[] GetCompressedImage(byte[] image)
        {
            byte[] GetCompressedImage = null;
            GetCompressedImage = ResizeImage(640, 480, image);
            return GetCompressedImage;

        }

        // **** Read Image into Byte Array from Filesystem
        public static byte[] GetPhoto(string filePath)
        {
            FileStream fs = new FileStream(filePath, FileMode.Open, FileAccess.Read);
            BinaryReader br = new BinaryReader(fs);
            byte[] photo = br.ReadBytes((int)fs.Length);
            br.Close();
            fs.Close();
            return photo;
        }

        public static byte[] ResizeImage(int MaxWidth, int MaxHeight, byte[] image)
        {

            MemoryStream ms = new MemoryStream(image);
            Bitmap OriginalBmp = new Bitmap(ms);

            // load up the image, figure out a "best fit"
            // resize, and then save that new image
            Size ResizedDimensions = GetDimensions(MaxWidth, MaxHeight, ref OriginalBmp);
            Bitmap NewBmp = new Bitmap(OriginalBmp, ResizedDimensions);

            MemoryStream nms = new MemoryStream();
            NewBmp.Save(nms, System.Drawing.Imaging.ImageFormat.Jpeg);
            return nms.GetBuffer();
        }
        public static Size GetDimensions(int MaxWidth, int MaxHeight, ref Bitmap Bmp)
        {
            int Width;
            int Height;
            float Multiplier;

            Height = Bmp.Height;
            Width = Bmp.Width;

            // this means you want to shrink
            // an image that is already shrunken!
            if (Height <= MaxHeight && Width <= MaxWidth)
                return new Size(Width, Height);

            // check to see if we can shrink it width first
            Multiplier = (float)MaxWidth / (float)Width;
            if ((Height * Multiplier) <= MaxHeight)
            {
                Height = (int)(Height * Multiplier);
                return new Size(MaxWidth, Height);
            }

            // if we can't get our max width, then use the max height
            Multiplier = (float)MaxHeight / (float)Height;
            Width = (int)(Width * Multiplier);
            return new Size(Width, MaxHeight);
        }

        #endregion
    }
}