﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="history.aspx.cs" Inherits="shynet_history" MaintainScrollPositionOnPostback="True" %>
<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student History</title>
    <link href="//netdna.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet"/>
    <script src="//ajax.googleapis.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script>
    <script src="//netdna.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>
    <div class="container body-content" style="margin-top:10px;">
    <form runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server" />

        <b><asp:Literal ID="litHeading" runat="server" /></b><br/>

        <asp:SqlDataSource ID="srcClasses" runat="server" 
            ConnectionString="<%$ ConnectionStrings:SHYnet %>" 
            ProviderName="<%$ ConnectionStrings:SHYnet.ProviderName %>"  
            SelectCommand="SELECT id, name FROM classes ORDER BY name"
            DataSourceMode="DataReader"
        />

        <asp:SqlDataSource ID="srcInstructors" runat="server" 
            ConnectionString="<%$ ConnectionStrings:SHYnet %>" 
            ProviderName="<%$ ConnectionStrings:SHYnet.ProviderName %>"          
            SelectCommand="SELECT id, lastname + ', ' + firstname AS name FROM instructors ORDER BY lastname"
            DataSourceMode="DataReader"
        />

        <asp:SqlDataSource ID="srcLocations" runat="server" 
            ConnectionString="<%$ ConnectionStrings:SHYnet %>" 
            ProviderName="<%$ ConnectionStrings:SHYnet.ProviderName %>"    
            SelectCommand="SELECT id, name FROM locations ORDER BY name"
            DataSourceMode="DataReader"
        />

        <asp:SqlDataSource ID="srcPaymentTypes" runat="server" 
            ConnectionString="<%$ ConnectionStrings:SHYnet %>" 
            ProviderName="<%$ ConnectionStrings:SHYnet.ProviderName %>"    
            SelectCommand="SELECT id, name FROM payment_types ORDER BY ordinal"
            DataSourceMode="DataReader"
        />

        <asp:SqlDataSource ID="srcHistory" runat="server" 
            ConnectionString="<%$ ConnectionStrings:SHYnet %>" 
            ProviderName="<%$ ConnectionStrings:SHYnet.ProviderName %>"
            SelectCommand="sp_show_history" 
            SelectCommandType="StoredProcedure"
            DeleteCommand="sp_delete_history"
            DeleteCommandType="StoredProcedure"
            UpdateCommand="sp_update_history"
            UpdateCommandType="StoredProcedure"
            >
            <SelectParameters>
                <asp:Parameter Name="student_id" DbType="Guid" Direction="Input" />
            </SelectParameters>
            <DeleteParameters>
                <asp:Parameter Name="transaction_type" DbType="String" Direction="Input" />
                <asp:Parameter Name="id" DbType="Guid" Direction="Input" />
            </DeleteParameters>
            <UpdateParameters>
                <asp:Parameter Name="transaction_type" DbType="String" Direction="Input" />
                <asp:Parameter Name="id" DbType="Guid" Direction="Input" />
                <asp:Parameter Name="transaction_date" Direction="Input" DbType="Date" />
                <asp:Parameter Name="instructor_id" DbType="Guid" Direction="Input" />
                <asp:Parameter Name="location_id" DbType="Guid" Direction="Input" />
                <asp:Parameter Name="class_id" DbType="Guid" Direction="Input" />
                <asp:Parameter Name="quantity" DbType="Int16" Direction="Input" />
                <asp:Parameter Name="payment_type_id" DbType="Guid" Direction="Input" />
            </UpdateParameters>
        </asp:SqlDataSource>

        <asp:GridView ID="dgHistory"
            CssClass="table table-striped table-hover table-condensed table-bordered"
            AllowPaging="True"
            AutoGenerateColumns="False"
            DataSourceID="srcHistory"
            DataKeyNames="transaction_type,id"
            PageSize="20" 
            runat="server"
            AutoGenerateDeleteButton="True"
            AutoGenerateEditButton="True" 
            onrowdeleting="dgHistory_RowDeleting"
            onrowcancelingedit="dgHistory_RowCanceling"
            onrowediting="dgHistory_RowEditing" onrowdatabound="dgHistory_RowDataBound"
            PagerSettings-PageButtonCount="5">
            <Columns>
                <asp:BoundField DataField="transaction_type" Visible="false" ReadOnly="true" />
                <asp:BoundField DataField="id" Visible="false" ReadOnly="true" />
                <asp:TemplateField HeaderText="Date" ItemStyle-Width="90px">
                    <EditItemTemplate>
                        <asp:TextBox ID="txtClassDate" CssClass="form-control" TextMode="Date" Text='<%# Bind("transaction_date","{0:yyyy-MM-dd}") %>' runat="server" Width="160px" AutoPostBack="True" />
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="transaction_date" runat="server" Text='<%# Bind("transaction_date","{0:d}") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Description">
                    <EditItemTemplate>
                        <asp:dropdownlist id="lstInstructor" CssClass="form-control" runat="server" DataSourceID="srcInstructors" DataTextField="name" DataValueField="id" SelectedValue='<%# Bind("instructor_id") %>' AutoPostBack="true" />
                        <asp:dropdownlist id="lstClasses" CssClass="form-control" runat="server" DataSourceID="srcClasses" DataTextField="name" DataValueField="id" SelectedValue='<%# Bind("class_id") %>' AutoPostBack="true" />
                        <asp:dropdownlist id="lstLocations" CssClass="form-control" runat="server" DataSourceID="srcLocations" DataTextField="name" DataValueField="id" SelectedValue='<%# Bind("location_id") %>' AutoPostBack="true" />
                        <asp:dropdownlist id="lstPaymentTypes" CssClass="form-control" runat="server" DataSourceID="srcPaymentTypes" DataTextField="name" DataValueField="id" SelectedValue='<%# Bind("payment_type_id") %>' AutoPostBack="true" />
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("Description") %>'></asp:Label>
                    </ItemTemplate>
                    <HeaderStyle HorizontalAlign="Left" />
                </asp:TemplateField>
                <asp:BoundField DataField="Quantity" HeaderText="Qty" ControlStyle-CssClass="form-control" HeaderStyle-CssClass="text-center" ItemStyle-HorizontalAlign="Right" ItemStyle-Width="60px" />
                <asp:BoundField DataField="Balance" HeaderText="Balance" ItemStyle-HorizontalAlign="Right" ItemStyle-Width="60px" ReadOnly="True" />
            </Columns>
        </asp:GridView>
    </form>
    </div>
</body>
</html>
