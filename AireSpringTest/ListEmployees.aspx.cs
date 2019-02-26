using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AireSpringTest
{
    public partial class ListEmployees : System.Web.UI.Page
    {
        string connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                bind("");
            }
        }

        protected void SearchClick(object sender, EventArgs e)
        {
            if (EmployeeLastNameSearch.Text == "" && PhoneNumberSearch.Text == "")
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Search fields cannot be blank!')", true);

                return;
            }

            else if (EmployeeLastNameSearch.Text != "" && PhoneNumberSearch.Text != "")
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('You cannot use both fields!')", true);

                return;
            }

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();

                var cmd = con.CreateCommand();

                string cmdText;

                if (EmployeeLastNameSearch.Text != "")
                {
                    cmdText = "AireSpringEmployees_GetByLastName";
                    cmd.Parameters.AddWithValue("@EmployeeLastName", EmployeeLastNameSearch.Text);
                }

                else
                {
                    cmdText = "AireSpringEmployees_GetByPhone";
                    cmd.Parameters.AddWithValue("@EmployeePhone", PhoneNumberSearch.Text);
                }

                cmd.CommandText = cmdText;
                cmd.CommandType = System.Data.CommandType.StoredProcedure;

                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    DataTable dTable = new DataTable();

                    dTable.Load(reader);

                    EmployeeList.DataSource = dTable;

                    Session["dtable"] = dTable;

                    EmployeeList.EditIndex = -1;

                    EmployeeList.DataBind();
                }
            }
        }

        protected void searchBind(string sortExpression)
        {            
                sortExpression = sortExpression.Replace("Ascending", "ASC");

                DataTable dTable = (DataTable)Session["dTable"];

                dTable.DefaultView.Sort = sortExpression;

                EmployeeList.DataSource = dTable;

                EmployeeList.DataBind();
        }

        protected void bind(string sortExpression)
        {
            sortExpression = sortExpression.Replace("Ascending", "ASC");

            using (SqlConnection con = new SqlConnection(connectionString))
            {

                con.Open();

                using (SqlDataAdapter dAd = new SqlDataAdapter("AireSpringEmployees_GetAll", con))
                {
                    DataTable dTable = new DataTable();

                    dAd.Fill(dTable);

                    dTable.DefaultView.Sort = sortExpression;

                    EmployeeList.DataSource = dTable;

                    EmployeeList.DataBind();
                }

                Session.Clear();

                con.Close();
            }
        }

        protected void SortListViewRecords(object sender, ListViewSortEventArgs e)

        {

            if (Session["dTable"] == null)
            {
                string sortExpression = e.SortExpression + " " + e.SortDirection;

                bind(sortExpression);
            }

            else
            {
                string sortExpression = e.SortExpression + " " + e.SortDirection;

                searchBind(sortExpression);
            }

        }

        protected void EditListViewItem(object sender, ListViewEditEventArgs e)

        {
            EmployeeList.EditIndex = e.NewEditIndex;

            if (Session["dTable"] == null)
            {
                bind("");

                e.Cancel = true;
            }

            else
            {
                searchBind("");
            }
        }

        protected void UpdateListViewItem(object sender, ListViewUpdateEventArgs e)
        {
            ListViewItem item = EmployeeList.Items[e.ItemIndex];

            TextBox tLastName = (TextBox)item.FindControl("txtEmployeeLastName");
            TextBox tFirstName = (TextBox)item.FindControl("txtEmployeeFirstName");
            TextBox tPhone = (TextBox)item.FindControl("txtEmployeePhone");
            TextBox tZip = (TextBox)item.FindControl("txtEmployeeZip");
            TextBox tHireDate = (TextBox)item.FindControl("txtHireDate");            

            if (tLastName.Text == "" || tFirstName.Text == "" || tPhone.Text == "" || tZip.Text == "" || tHireDate.Text == "")
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Please fill in all fields!')", true);

                return;
            }

            using (SqlConnection con = new SqlConnection(connectionString))
            {

                con.Open();

                var cmd = con.CreateCommand();
                cmd.CommandText = "AireSpringEmployees_Edit";
                cmd.CommandType = System.Data.CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@EmployeeID", Convert.ToInt32(EmployeeList.DataKeys[e.ItemIndex].Value.ToString()));
                cmd.Parameters.AddWithValue("@EmployeeLastName", tLastName.Text);
                cmd.Parameters.AddWithValue("@EmployeeFirstName", tFirstName.Text.Trim());
                cmd.Parameters.AddWithValue("@EmployeePhone", tPhone.Text);
                cmd.Parameters.AddWithValue("@EmployeeZip", tZip.Text);
                cmd.Parameters.AddWithValue("@HireDate", DateTime.ParseExact(tHireDate.Text, "MM/dd/yyyy", null));

                cmd.ExecuteNonQuery();

                con.Close();
            }

            EmployeeList.EditIndex = -1;

            bind("");
        }

        protected void CancelListViewItem(object sender, ListViewCancelEventArgs e)
        {

            if (Session["dTable"] == null)
            {
                EmployeeList.EditIndex = -1;

                bind("");
            }

            else
            {
                EmployeeList.EditIndex = -1;

                searchBind("");

                e.Cancel = true;
            }
        }

        protected void DeleteListViewItem(object sender, ListViewDeleteEventArgs e)
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();

                var cmd = con.CreateCommand();
                cmd.CommandText = "AireSpringEmployees_Delete";
                cmd.CommandType = System.Data.CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@EmployeeID", Convert.ToInt32(EmployeeList.DataKeys[e.ItemIndex].Value.ToString()));

                cmd.ExecuteNonQuery();

                con.Close();

                lblMessage.Text = "Employee Record Deleted Successfully.";
            }

            bind("");
        }

        protected void InsertListViewItem(object sender, ListViewInsertEventArgs e)
        {
            ListViewItem item = e.Item;

            TextBox tLastName = (TextBox)item.FindControl("txtEmployeeLastName");
            TextBox tFirstName = (TextBox)item.FindControl("txtEmployeeFirstName");
            TextBox tPhone = (TextBox)item.FindControl("txtEmployeePhone");
            TextBox tZip = (TextBox)item.FindControl("txtEmployeeZip");
            TextBox tHireDate = (TextBox)item.FindControl("txtHireDate");

            if (tLastName.Text == "" || tFirstName.Text == "" || tPhone.Text == "" || tZip.Text == "" || tHireDate.Text == "")
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

                cmd.Parameters.AddWithValue("@EmployeeLastName", tLastName.Text);
                cmd.Parameters.AddWithValue("@EmployeeFirstName", tFirstName.Text);
                cmd.Parameters.AddWithValue("@EmployeePhone", tPhone.Text);
                cmd.Parameters.AddWithValue("@EmployeeZip", tZip.Text);
                cmd.Parameters.AddWithValue("@HireDate", DateTime.Parse(tHireDate.Text));

                cmd.Parameters.AddWithValue("@EmployeeID", SqlDbType.Int).Direction = ParameterDirection.Output;

                cmd.ExecuteNonQuery();

                employeeID = (int)cmd.Parameters["@EmployeeID"].Value;
            }

            bind("");

            Response.Redirect("~/ListEmployees.aspx", false);
        }
    }
}