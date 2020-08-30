<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<ThesisGamingStore.Models.Employee>" %>

<%@ Import Namespace="ThesisGamingStore.Models" %>
<section class="col-md-6">
    <div class="editor-label">
        <%: Html.LabelFor(model => model.UserName) %>
    </div>
    <div class="editor-field">
        <%: Html.TextBoxFor(model => model.UserName, new { @style = "width:70%;" }) %>
    </div>
    <div class="editor-field">
        <%: Html.ValidationMessageFor(model => model.UserName) %>
    </div>

    <div class="editor-label">
        <%: Html.LabelFor(model => model.Password) %>
    </div>
    <div class="editor-field">
        <%: Html.PasswordFor(model => model.Password, new { @style = "width:70%;" }) %>
    </div>
    <div class="editor-field">
        <%: Html.ValidationMessageFor(model => model.Password) %>
    </div>

    <div class="editor-label">
        <%: Html.LabelFor(model => model.ConfirmPassword) %>
    </div>
    <div class="editor-field">
        <%: Html.PasswordFor(model => model.ConfirmPassword, new { @style = "width:70%;" }) %>
    </div>
    <div class="editor-field">
        <%: Html.ValidationMessageFor(model => model.ConfirmPassword) %>
    </div>

    <div class="editor-label">
        <%: Html.LabelFor(model => model.Idcard) %>
    </div>
    <div class="editor-field">
        <%: Html.TextBoxFor(model => model.Idcard, new { @maxlength = 13, onkeydown="return ValidateNumber(event);" ,@style = "width:70%;" })%>
    </div>
    <div class="editor-field">
        <%: Html.ValidationMessageFor(model => model.Idcard) %>
    </div>

    <div class="editor-label">
        <%: Html.LabelFor(model => model.Email) %>
    </div>
    <div class="editor-field">
        <%: Html.TextBoxFor(model => model.Email, new { @style = "width:70%;" }) %>
    </div>
    <div class="editor-field">
        <%: Html.ValidationMessageFor(model => model.Email) %>
    </div>
    <br />
    <div class="editor-label">
        <%--<%: Html.LabelFor(model => model.Sex) %>--%>
        <span><%: Html.RadioButtonFor(model => model.Sex,"Male",new {id = "Male",Checked = "checked" , style = "width:20px;"}) %>
            <%: Html.Label("Male","Male") %>
            <%: Html.RadioButtonFor(model => model.Sex,"Female",new {id = "Female",style = "width:20px; "}) %>
            <%: Html.Label("Female","Female")  %> </span>
    </div>
</section>

<section class="col-md-6">
    <div class="editor-label">
        <%: Html.Label("Position") %>
    </div>
    <div class="editor-field">
        <%: Html.DropDownListFor(model => model.PosID,new SelectList(Enumerable.Empty<SelectListItem>()),new { style = "width:70%;height:30px;" }) %>
    </div>

    <div class="editor-label">
        <%: Html.LabelFor(model => model.Fname) %>
    </div>
    <div class="editor-field">
        <%: Html.TextBoxFor(model => model.Fname, new { @style = "width:70%;" }) %>
    </div>
    <div class="editor-field">
        <%: Html.ValidationMessageFor(model => model.Fname) %>
    </div>

    <div class="editor-label">
        <%: Html.LabelFor(model => model.Lname) %>
    </div>
    <div class="editor-field">
        <%: Html.TextBoxFor(model => model.Lname, new { @style = "width:70%;" }) %>
    </div>
    <div class="editor-field">
        <%: Html.ValidationMessageFor(model => model.Lname) %>
    </div>

    <div class="editor-label">
        <%: Html.LabelFor(model => model.Address) %>
    </div>
    <div class="editor-field">
        <%: Html.TextAreaFor(model => model.Address,new { @style = "width:70%;" }) %>
        <%: Html.ValidationMessageFor(model => model.Address) %>
    </div>



    <div class="editor-label">
        <%: Html.LabelFor(model => model.Salary) %>
    </div>
    <div class="editor-field">
        <%: Html.NumberFor(model => model.Salary, new { @maxlength = 6,  onkeypress="return isNumberKey(event);" ,@style = "width:70%;"})%>
    </div>
    <div class="editor-field">
        <%: Html.ValidationMessageFor(model => model.Salary) %>
    </div>
    <div id="phoneNumbers">
        <%: Html.EditorFor(x => x.Phones) %>
    </div>

    <p>
        <%:Html.AddLink("Add More Phone Numbers", "#phoneNumbers", ".phoneNumber", "Phones", typeof(EMPLOYEE_PHONE))%>
    </p>
</section>

