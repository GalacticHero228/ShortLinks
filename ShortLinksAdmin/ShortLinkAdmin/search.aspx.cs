using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ShortLinkAdmin
{
    public partial class search : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string query = Request.QueryString["q"];
                if (query != "" && query != null && Convert.ToInt32(query) > 0)
                {
                    string select = string.Format("SELECT * FROM [tbl_Forward] WHERE [fwd_id] = {0}", query);
                    SqlDataSource1.SelectCommand = select;
                    ListView1.DataBind();
                }
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string data = ddlSearch.SelectedValue;
            Session["data"] = data;
            dataSelect(data);
        }

        public void dataSelect(string data)
        {
            string searchType = data;
            string select = "";

            //Change query based on 'Search By' option selected
            switch (searchType)
            {
                //Keyword
                case "klink":
                    select = "SELECT * FROM [tbl_Forward] WHERE (UPPER([fwd_kwd]) LIKE '%' + UPPER(@fwd_url) + '%')";
                    break;
                //Absolute URL
                case "alink":
                    select = "SELECT * FROM [tbl_Forward]  WHERE (UPPER([fwd_url]) LIKE '%' + UPPER(@fwd_url) + '%')";
                    break;
                //Short Link URL indicator
                case "slink":
                    select = "SELECT * FROM [tbl_Forward]  WHERE (UPPER([fwd_short]) LIKE '%' + UPPER(@fwd_url) + '%')";
                    break;
                //Show ALL
                case "all":
                    select = "SELECT * FROM [tbl_Forward] ORDER BY fwd_short";
                    break;
                //Search all options by default
                default:
                    select = "SELECT * FROM [tbl_Forward]  WHERE (UPPER([fwd_url]) LIKE '%' + UPPER(@fwd_url) + '%') OR (UPPER([fwd_short]) LIKE '%' + UPPER(@fwd_url) + '%') OR (UPPER([fwd_kwd]) LIKE '%' + UPPER(@fwd_url) + '%')";
                    break;
            }
            SqlDataSource1.SelectCommand = select;
            ListView1.DataBind();
        }

        protected void ListView1_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
        {
            string data = (string)Session["data"];
            dataSelect(data);
        }
    }
}