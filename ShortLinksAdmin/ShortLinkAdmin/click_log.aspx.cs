using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ShortLinkAdmin
{
    public partial class click_log : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string connectString = System.Configuration.ConfigurationManager.ConnectionStrings["ShortLinkConnectionString"].ToString();
            string q = Request.QueryString["q"];
            if (q != null)
            {
                
                string select = string.Format("SELECT fwd_short FROM tbl_Forward WHERE fwd_id = {0}", q);
                string count = string.Format("SELECT Count(*) FROM tbl_ClickLog WHERE click_short = {0}", q);
                SqlConnection con = new SqlConnection(connectString);
                SqlCommand com = new SqlCommand(select, con);
                SqlCommand cou = new SqlCommand(count, con);

                con.Open();
                string a = (string)com.ExecuteScalar();
                int c = (int)cou.ExecuteScalar();
                string shortLink = @"https://short.link/" + a;

                hlShort.NavigateUrl = shortLink;
                hlShort.Text = shortLink;
                lblCount.Text = c.ToString();
                con.Close();
            }
        }
    }
}