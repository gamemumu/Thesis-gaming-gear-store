<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>

<% if (Request.IsAuthenticated && Session["S_EmpID"] != null)
   { %>
    <li>
    <%--<%: Html.ActionLink("    "+User.Identity.Name, "Edit", "Account", routeValues: null, htmlAttributes: new { @class = "fa fa-user fa-fw", title = "Manage" ,@style = "color:#569BD7"}) %> </li>--%>
        <%: Html.ActionLink("    "+User.Identity.Name, "Edit", "Account",  new { EmpID =   Session["S_EmpID"].ToString()}, htmlAttributes: new { @class = "fa fa-user fa-fw", title = "Manage" ,@style = "color:#569BD7"}) %> </li>
    <li>
       <a href="<%= Url.Action("Edit", "Account", new { EmpID =   Session["S_EmpID"].ToString()})%>"><i class="fa fa-gear fa-fw"></i>Settings</a> </li>
      <li>                 
    <% using (Html.BeginForm("LogOff", "Account", FormMethod.Post, new { id = "logoutForm" })) { %>
        <%: Html.AntiForgeryToken() %>
        <a href="javascript:document.getElementById('logoutForm').submit()"><i class="fa fa-sign-out fa-fw"></i>Logout</a> </li>
    <% } %>
<% } else { %>
     <li class="divider"></li>
                        <li>
        <%--<li><%: Html.ActionLink("Register", "CreateEmp", "Account", routeValues: null, htmlAttributes: new { id = "registerLink" })%></li>
        <li><%: Html.ActionLink("Log in", "Login", "Account", routeValues: null, htmlAttributes: new { id = "loginLink" })%></li>--%>
                            <a href="<%= Url.Action("CreateEmp", "Account")%>"><i class="fa fa-user fa-fw"></i>Register</a>
                        </li>
                        <li><a href="<%= Url.Action("Login2", "Account")%>"><i class="fa fa-sign-out fa-fw"></i>Login</a>
                        </li>
<% } %>
                      
                       
                        
