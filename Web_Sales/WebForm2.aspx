<%@ Page Title="" Language="C#" MasterPageFile="~/home.Master" AutoEventWireup="true" CodeBehind="WebForm2.aspx.cs" Inherits="Web_Sales.WebForm2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="page-content" style="text-align: center;margin: 0 auto;max-width:1200px;">
<!-- Slide Show -->
<!-- breadcrumb -->
        <!-- Product grid -->
        <div class="w3-row w3-grayscale">
            <div class="w3-col l3 s6">
             <%
                System.Data.SqlClient.SqlCommand cmd;
                System.Data.SqlClient.SqlConnection conn;
                System.Data.SqlClient.SqlDataReader dr;
                conn = new System.Data.SqlClient.SqlConnection(@"Data Source=.\SQLEXPRESS;Initial Catalog=Shop;Integrated Security=True");
                conn.Open();
                //System.Data.DataTable sp = new System.Data.DataTable();
                cmd = new System.Data.SqlClient.SqlCommand("spGetProduct", conn);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                dr = cmd.ExecuteReader();
                while (dr.Read())
                {%>
             <div class="w3-container">
                    <img src="images/<% Response.Write(string.Format("{0}", dr[3])); %>" style="width:100%">
                    <p><% Response.Write(string.Format("{0}", dr[1])); %>
                        <br><b><% Response.Write(string.Format("{0}", dr[6])); %></b>
                    </p>
                </div>
            <%} %>
                </div>
        </div>
<!-- Band Description -->
<!-- Band Members -->
<!-- Content -->
<!-- pagination -->
<ul class="pagination">
  <li><a href="#">&laquo;</a></li>
  <li><a href="#">1</a></li>
  <li><a class="active" href="#">2</a></li>
  <li><a href="#">3</a></li>
  <li><a href="#">4</a></li>
  <li><a href="#">5</a></li>
  <li><a href="#">6</a></li>
  <li><a href="#">&raquo;</a></li>
</ul>
</div> 
<!-- end page-content -->
<!-- Footer -->
</asp:Content>
