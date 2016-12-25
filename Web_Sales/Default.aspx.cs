using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using System.Data.SqlClient;

namespace Web_Sales
{
    public partial class _Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            SqlCommand cmd;
            SqlConnection conn;
            SqlDataReader dr;
            conn = new SqlConnection(@"Data Source=.\SQLEXPRESS;Initial Catalog=Shop;Integrated Security=True");
            conn.Open();            
            cmd = new SqlCommand("spInsertProduct", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@ProductName", txtUsername.Text.ToString());
            cmd.Parameters.AddWithValue("@ProductDes", txtUsername.Text.ToString());
            cmd.Parameters.AddWithValue("@ProductImg", txtUsername.Text.ToString());
            cmd.Parameters.AddWithValue("@CategoryID", 1);
            cmd.Parameters.AddWithValue("@Quantity", 8);
            cmd.Parameters.AddWithValue("@Price", 8);
            try
            {
                cmd.ExecuteNonQuery(); 
            }
            catch (Exception ex)
            {
                Response.Write(ex);
            }    

            cmd = new SqlCommand("spGetProduct", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                Response.Write(string.Format("{0}", dr[1]));
            }
        }
    }
}
