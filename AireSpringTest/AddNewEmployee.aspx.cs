using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AireSpringTest
{
    public partial class AddNewEmployee : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        string connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

        protected void CreateNewEmployeeClick(object sender, EventArgs e)
        {
            if (NewEmployeeLastName.Text == "" || NewEmployeeFirstName.Text == "" || NewEmployeePhoneNumber.Text == "" || NewEmployeeZipCode.Text == "" || NewEmployeeHireDate.Text == "")
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Please fill in all fields!')", true);

                return;
            }

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();

                int employeeID = 0;

                var cmd = con.CreateCommand();
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.CommandText = "AireSpringEmployees_Create";

                cmd.Parameters.AddWithValue("@EmployeeLastName", NewEmployeeLastName.Text);
                cmd.Parameters.AddWithValue("@EmployeeFirstName", NewEmployeeFirstName.Text);
                cmd.Parameters.AddWithValue("@EmployeePhone", NewEmployeePhoneNumber.Text);
                cmd.Parameters.AddWithValue("@EmployeeZip", NewEmployeeZipCode.Text);
                cmd.Parameters.AddWithValue("@HireDate", DateTime.Parse(NewEmployeeHireDate.Text));

                cmd.Parameters.AddWithValue("@EmployeeID", SqlDbType.Int).Direction = ParameterDirection.Output;

                cmd.ExecuteNonQuery();

                employeeID = (int)cmd.Parameters["@EmployeeID"].Value;                
            }

            Response.Redirect("~/ListEmployees.aspx", false);
        }
    }
}