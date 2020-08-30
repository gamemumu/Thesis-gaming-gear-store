<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/MasterGaming.Master" Inherits="System.Web.Mvc.ViewPage<ThesisGamingStore.Models.LoginModel>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Login
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

 <h3>Sign In</h3>
    <section id="loginForm">
    <% using (Html.BeginForm(new {ReturnUrl = ViewBag.ReturnUrl })) {%>
    <%: Html.AntiForgeryToken() %>
    <%: Html.ValidationSummary(true) %>
    <fieldset>
        <legend>Sign In</legend>
            <ul>
                <li>
                    <%: Html.LabelFor(model => model.UserName) %>
                    <%: Html.TextBoxFor(model => model.UserName) %>
                    <%: Html.ValidationMessageFor(model => model.UserName) %>
                </li>
                <li>
                    <%: Html.LabelFor(model => model.Password) %>
                    <%: Html.PasswordFor(model => model.Password) %>
                    <%: Html.ValidationMessageFor(model => model.Password) %>
                </li>
                <li>
                    <%: Html.CheckBoxFor(model => model.RememberMe) %>
                    <%: Html.LabelFor(m => m.RememberMe, new { @class = "checkbox" }) %>
                </li>
            </ul>
         <input type="submit" value="Log in" />
        <%: Html.ActionLink("Forgot your Password?","ForgottenPassword", "Account") %>
    </fieldset>
        </section>
<% } %>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ScriptsSection" runat="server">
</asp:Content>
