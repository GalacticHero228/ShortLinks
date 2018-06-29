using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data.SqlTypes;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ShortLinkAdmin
{
    public partial class new_edit : System.Web.UI.Page
    {
        string connectString = System.Configuration.ConfigurationManager.ConnectionStrings["ShortLinkConnectionString"].ToString();
        string qs = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            qs = Request.QueryString["q"];
            if(!IsPostBack)
            {
                if (qs != null && qs != "")
                {
                    insertItem(qs);
                }
                else
                {
                    lblEvent.Text = "Create New";
                }
            }
        }

        private void insertItem(string qString)
        {
            string q = qString;
            string selectItem = string.Format("SELECT * FROM tbl_Forward WHERE fwd_id = {0}", q);
            SqlDataReader reader;
            SqlConnection con = new SqlConnection(connectString);
            SqlCommand com = new SqlCommand(selectItem, con);


            string shortUrl = "";
            string longUrl = "";
            string kwd = "";
            DateTime expire = DateTime.Now;

            con.Open();
            reader = com.ExecuteReader();

            while (reader.Read())
            {
                shortUrl = (string) reader["fwd_short"];
                longUrl = (string) reader["fwd_url"];
                if(reader["fwd_kwd"] != DBNull.Value)
                {
                    kwd = (string)reader["fwd_kwd"];
                }
                expire = (DateTime) reader["fwd_expire"];
            }

            lblEvent.Text = "Edit";
            txtShortUrl.Text = shortUrl;
            txtActualUrl.Text = longUrl;
            txtDesK.Text = kwd;
            txtExpire.Text = expire.ToString("yyyy-MM-dd");


            con.Close();
        }

        public string randomString(int l)
        {
            //Create a random string using only these characters at the length passed into method
            Random random = new Random();
            const string chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
            return new string(Enumerable.Repeat(chars, l)
              .Select(s => s[random.Next(s.Length)]).ToArray());
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            string shortUrl = txtShortUrl.Text;
            string actUrl = txtActualUrl.Text;
            string kwd = txtDesK.Text;
            string expire = "";
            int id = -1;
            bool error = false;
            string errorMsg = "An unknown error has occurred";

            if (txtExpire.Text != "")
            {
                DateTime exp = Convert.ToDateTime(txtExpire.Text);
                expire = exp.ToString("yyyy-MM-dd HH:mm:ss.fff");
            }
            else
                expire = SqlDateTime.MaxValue.ToString();

            SqlDataReader reader;
            SqlConnection con = new SqlConnection(connectString);
            try
            {
                con.Open();
                string existShort = string.Format("SELECT COUNT(*) FROM tbl_Forward WHERE fwd_short = '{0}'", shortUrl);
                string existLong = string.Format("SELECT COUNT(*) FROM tbl_Forward WHERE fwd_url = '{0}'", actUrl);
                SqlCommand scom = new SqlCommand(existShort, con);
                SqlCommand lcom = new SqlCommand(existLong, con);

                int shortCount = (int)scom.ExecuteScalar();
                int longCount = (int)lcom.ExecuteScalar();

                //If item exists - Then Update
                if (qs != null && qs != "")
                {
                    string shortID = qs;
                    //Update
                    string updateItem = string.Format("UPDATE tbl_Forward SET fwd_short = '{0}', fwd_url = '{1}', fwd_kwd = '{2}', fwd_expire = '{3}' WHERE fwd_id = {4} ", shortUrl, actUrl, kwd, expire, shortID);
                    SqlCommand com = new SqlCommand(updateItem, con);
                    com.ExecuteNonQuery();
                    id = Convert.ToInt32(shortID);
                }
                //If item doesn't exist - Then Insert
                else if((shortCount + longCount) == 0)
                {
                    //Create
                    string insertItem = string.Format("INSERT INTO tbl_Forward  (fwd_short, fwd_url, fwd_kwd, fwd_expire, fwd_create) OUTPUT INSERTED.fwd_id VALUES ('{0}', '{1}', '{2}', '{3}', '{4}')", shortUrl, actUrl, kwd, expire, DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss.fff"));
                    SqlCommand com = new SqlCommand(insertItem, con);
                    id = (int) com.ExecuteScalar();
                }
                //Prevents duplicating short URL codes or 
                else
                {
                    error = true;
                    if (shortCount != 0)
                    {
                        errorMsg = "This short URL is already in use. Please try again.";
                    }
                    else if(longCount != 0)
                    {
                        errorMsg = "This Absolute URL already has a short link. Please use or update the existing link.";
                    }
                }
                con.Close();
            }
            catch(Exception ex)
            {
                error = true;
                errorMsg = "A problem has occurred with the program. Please try again.";
            }
            finally
            {
                if(con.State.Equals("Open"))
                {
                    con.Close();
                }

                if (error == false)
                {
                    //success
                    ClientScript.RegisterStartupScript(this.GetType(), "Result", "alert('This process has completed!');window.location.href='search.aspx?q=" + id + "'", true);
                }
                else
                {
                    //fail
                    ClientScript.RegisterStartupScript(this.GetType(), "Result", "alert('" + errorMsg + "');", true);
                }
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("search.aspx");
        }

        protected void btnCat_Click(object sender, EventArgs e)
        {
            //Helper for library OPAC caltalogue searches with Evergreen ILS
            txtActualUrl.Text = "https://short.link/helpers/gsearch.asp?idx={INDEX}&term={TERM}";
        }

        protected void btnRand_Click(object sender, EventArgs e)
        {
             //Create a random string using the selected length using the randomString method
             int l = Convert.ToInt32(ddlLength.SelectedValue);
             txtShortUrl.Text = randomString(l);
        }
    }
}