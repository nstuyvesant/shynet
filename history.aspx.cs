﻿using System;
using System.Configuration;
using System.Data;
using System.Web.UI.WebControls;
using Npgsql;

public partial class history : System.Web.UI.Page {

  private string CONNECTION_STRING = ConfigurationManager.ConnectionStrings["Heroku"].ToString();

  protected void Page_Load(object sender, EventArgs e) {
    srcHistory.SelectParameters[0].DefaultValue = Request.QueryString["id"];
    litHeading.Text = Request.QueryString["name"];

    if (User.Identity.Name == "SHYNET\\shy") {
      gvHistory.AutoGenerateDeleteButton = false;
      gvHistory.AutoGenerateEditButton = false;
    }
  }

  protected void gvHistory_RowDeleting(object sender, GridViewDeleteEventArgs e) {
    srcHistory.DeleteParameters[0].DefaultValue = gvHistory.DataKeys[e.RowIndex].Values["transaction_type"].ToString(); // Transaction type (P or A)
    srcHistory.DeleteParameters[1].DefaultValue = gvHistory.DataKeys[e.RowIndex].Values["id"].ToString();  // attendance or purchase ID
  }

  protected void gvHistory_RowEditing(object sender, GridViewEditEventArgs e) {
    // Make quantity editable for purchases only
    if (gvHistory.DataKeys[e.NewEditIndex].Values["transaction_type"].ToString() == "A") // Attendance
      ((BoundField)gvHistory.Columns[4]).ReadOnly = true; // quantity is read-only
    else
      ((BoundField)gvHistory.Columns[4]).ReadOnly = false; // quantity is editable
  }

  protected void gvHistory_RowUpdating(object sender, GridViewUpdateEventArgs e) {
    string transactionType = gvHistory.DataKeys[e.RowIndex].Values["transaction_type"].ToString();
    srcHistory.UpdateParameters[0].DefaultValue = transactionType; // Transaction type (P or A)
    srcHistory.UpdateParameters[1].DefaultValue = gvHistory.DataKeys[e.RowIndex].Values["id"].ToString();  // attendance or purchase ID
    GridViewRow row = gvHistory.Rows[e.RowIndex];
    TextBox txtTransactionDate = (TextBox)row.FindControl("txtTransactionDate");
    srcHistory.UpdateParameters[2].DefaultValue = txtTransactionDate.Text;
    DropDownList lstInstructor = (DropDownList)row.FindControl("lstInstructor");
    srcHistory.UpdateParameters[3].DefaultValue = lstInstructor.SelectedValue;
    DropDownList lstLocation = (DropDownList)row.FindControl("lstLocation");
    srcHistory.UpdateParameters[4].DefaultValue = lstLocation.SelectedValue;
    DropDownList lstClass = (DropDownList)row.FindControl("lstClass");
    srcHistory.UpdateParameters[5].DefaultValue = lstClass.SelectedValue;

    if (transactionType == "P") {
      srcHistory.UpdateParameters[6].DefaultValue = ((TextBox)row.Cells[5].Controls[0]).Text;
    } else {
      srcHistory.UpdateParameters[6].DefaultValue = "-1";
    }

    DropDownList lstPaymentType = (DropDownList)row.FindControl("lstPaymentType");
    srcHistory.UpdateParameters[7].DefaultValue = lstPaymentType.SelectedValue;
    srcHistory.Update();
  }

  private void bindDropDown(GridViewRowEventArgs e, NpgsqlConnection cn, string sql, string dropDownName, string selectedValueField) {
    DropDownList thisDropDown = (DropDownList)e.Row.FindControl(dropDownName);
    // Do not show Payment Type for Attendances
    if (dropDownName == "lstPaymentType" && gvHistory.DataKeys[e.Row.RowIndex].Values["transaction_type"].ToString() == "A") {
      thisDropDown.Visible = false;
      return;
    }
    // Show only Payment Types for Purchases
    if (dropDownName != "lstPaymentType" && gvHistory.DataKeys[e.Row.RowIndex].Values["transaction_type"].ToString() == "P") {
      thisDropDown.Visible = false;
      return;
    }
    NpgsqlCommand cmd = new NpgsqlCommand(sql, cn);
    NpgsqlDataReader reader = cmd.ExecuteReader();
    thisDropDown.DataSource = reader;
    thisDropDown.DataTextField = "name";
    thisDropDown.DataValueField = "id";
    thisDropDown.DataBind();
    reader.Close();
    DataRowView dr = e.Row.DataItem as DataRowView;
    thisDropDown.SelectedValue = dr[selectedValueField].ToString();
  }

  protected void gvHistory_RowDataBound(object sender, GridViewRowEventArgs e) {
    if (e.Row.RowType == DataControlRowType.DataRow) {
      if ((e.Row.RowState & DataControlRowState.Edit) > 0) {
        // Populate dropdowns only once using ViewState to retain their contents
        NpgsqlConnection conn = new NpgsqlConnection(CONNECTION_STRING);
        conn.Open();
        bindDropDown(e, conn, "SELECT id, lastname || ', ' || firstname AS name FROM old_instructors ORDER BY lastname", "lstInstructor", "instructor_id");
        bindDropDown(e, conn, "SELECT id, name FROM old_classes ORDER BY name", "lstClass", "class_id");
        bindDropDown(e, conn, "SELECT id, name FROM old_locations ORDER BY name", "lstLocation", "location_id");
        bindDropDown(e, conn, "SELECT id, name FROM old_payment_types ORDER BY ordinal", "lstPaymentType", "payment_type_id");
        conn.Close();
      }
    }
  }

}
