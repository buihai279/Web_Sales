<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Web_Sales._Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h1>Hello word !!! </h1>
        </div>
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="product_id" DataSourceID="SqlDataSource1" EnableModelValidation="True" AllowPaging="True" AllowSorting="True" CellPadding="4" ForeColor="#333333" GridLines="None" PageSize="48">
            <AlternatingRowStyle BackColor="White" />
            <Columns>
                <asp:BoundField DataField="product_id" HeaderText="product_id" InsertVisible="False" ReadOnly="True" SortExpression="product_id" />
                <asp:BoundField DataField="name" HeaderText="name" SortExpression="name" />
                <asp:BoundField DataField="description" HeaderText="description" SortExpression="description" />
                <asp:BoundField DataField="image" HeaderText="image" SortExpression="image" />
            </Columns>
            <EditRowStyle BackColor="#7C6F57" />
            <FooterStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#666666" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="#E3EAEB" />
            <SelectedRowStyle BackColor="#C5BBAF" Font-Bold="True" ForeColor="#333333" />
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:OnlineShoppingConnectionString %>" SelectCommand="SELECT [product_id], [name], [description], [image] FROM [products]"></asp:SqlDataSource>
    </form>
    <p>
        &nbsp;</p>
    </body>
</html>
