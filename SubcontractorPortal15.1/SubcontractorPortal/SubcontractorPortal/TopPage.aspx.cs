using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SubcontractorDataComponents;

namespace SubcontractorPortal
{
    public partial class TopPage : System.Web.UI.Page
    {
        public bool IsTradecom = false;
        protected void Page_Load(object sender, EventArgs e)
        {
            Users.CheckUser();

            /* Remove this code after pilot test */
            int SubbieID = 0;
            try
            {
                if (Convert.ToInt32(DA.ReadCookie("SubbyID")) == (int)DA.MaincomCompanies.Tradecom)
                {
                    IsTradecom = true;
                }
            }
            catch (Exception)
            {
                
                
            }
            /* END Remove this code after pilot test */

        }
    }
}