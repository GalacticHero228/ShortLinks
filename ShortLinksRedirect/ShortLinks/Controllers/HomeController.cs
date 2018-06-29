using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Mvc;


//Chris burton 2018 to replace ShortLinks existing VBScript code
//Enabling HTTPS possibilities

namespace ShortLinks.Controllers
{
    public class HomeController : Controller
    {
        public ActionResult Index()
        {
            ViewBag.Title = "Home Page";

            return View();
        }

        public void Link(string id)
        {
            string connectString = System.Configuration.ConfigurationManager.ConnectionStrings["shortLinkConnection"].ToString();
            string path = id;
            string select = "";
            string logging = "";
            SqlConnection connection = new SqlConnection(connectString);
            SqlDataReader reader;
            string redirectPath = "";
            int redirID = 0;
            string userIP = GetIPAddress();
            Uri userRefer = Request.UrlReferrer;
            string referURL = "";
            DateTime redirExpire = DateTime.MaxValue;

            if (userRefer != null)
            {
                referURL = userRefer.ToString();
            }

            try
            {
                //Only if there is a path (/path) to parse will this run
                if (path != null && path.Length >= 1)
                {
                    if (path != "index.html")
                    {
                        //Create the query string to grab info based on path above
                        select = string.Format("SELECT * FROM tbl_Forward WHERE fwd_short = '{0}'", path);
                        SqlCommand com = new SqlCommand(select, connection);
                        connection.Open();
                        //Read required data from fwd table
                        reader = com.ExecuteReader();
                        if (reader.HasRows)
                        {
                            while (reader.Read())
                            {
                                redirectPath = reader.GetString(reader.GetOrdinal("fwd_url"));
                                redirID = reader.GetInt32(reader.GetOrdinal("fwd_id"));
                                redirExpire = reader.GetDateTime(reader.GetOrdinal("fwd_expire"));
                            }
                        }
                        else
                        {
                            redirectPath = "Notfound.html";
                        }
                        reader.Close();

                        //Enter a log entry into the click log. Tracks usage of short links and gauges interest.
                        logging = string.Format("INSERT INTO tbl_ClickLog (click_short, click_datetime, click_ip, click_refer) VALUES ({0}, '{1}', '{2}', '{3}')", Convert.ToInt32(redirID), DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss.fff"), userIP, referURL);
                        SqlCommand log = new SqlCommand(logging, connection);
                        log.ExecuteNonQuery();
                        connection.Close();

                        //Redirect to link and keep running this program until it completes. A true value would stop the program in its tracks and not allow for finishing items or redirection.
                        if(redirExpire < DateTime.Now)
                        {
                            Response.Redirect("Expired.html", false);
                        }
                        else if (redirectPath.Contains("helpers/gsearch"))
                        {
                            OPACsearch(redirectPath);
                        }
                        else
                        {
                            Response.Redirect(redirectPath, false);
                        } 
                    }
                }
                else
                {
                    Index();
                }
            }
            catch (Exception ex)
            {
                Response.Redirect(@"404.html", false);
            }
            finally
            {
                //If the SQL Connection is still open then close it. This helps in cases of a catch in the middle of a query. 
                if (connection.State.Equals("Open"))
                {
                    connection.Close();
                }
            }
        }
        protected string GetIPAddress()
        {
            System.Web.HttpContext context = System.Web.HttpContext.Current;
            string ipAddress = context.Request.ServerVariables["HTTP_X_FORWARDED_FOR"];

            if (!string.IsNullOrEmpty(ipAddress))
            {
                string[] addresses = ipAddress.Split(',');
                if (addresses.Length != 0)
                {
                    return addresses[0];
                }
            }

            return context.Request.ServerVariables["REMOTE_ADDR"];
        }

        protected void OPACsearch(string link)
        {
            Uri searchUri = new Uri(link);
            string term = HttpUtility.ParseQueryString(searchUri.Query).Get("term");
            string idx = HttpUtility.ParseQueryString(searchUri.Query).Get("idx");

            string index = "";

            switch(idx)
            {
                case "au":
                    index = "author";
                    break;
                case "is":
                    index = "identifier%7Cisbn";
                    break;
                case "ti":
                    index = "title";
                    break;
                case "kw":
                case "ta":
                    index = "keyword";
                    //Default?
                    break;
                case "su":
                    index = "subject";
                    break;
                case "se":
                    index = "series";
                    break;
            }

            string newUri = string.Format(@"https://live.nflibrary.ca/eg/opac/results?query={0}&qtype={1}", term, index);

            Response.Redirect(newUri);

        }
    }
}
