<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<ThesisGamingStore.Models.EMPLOYEE_PHONE>" %>
<%@ Import Namespace="ThesisGamingStore.Models" %>
<div class="phoneNumber">
    <p>
        <label>Phone Number</label><br />
        <%:Html.HiddenFor(model => model.EmpID) %>

        <%:Html.TextBoxFor(x => x.Phone,new { @style = "width:70%;" , @maxlength = 10, onkeypress="return isNumberKey(event);" }) %>
        <%:Html.HiddenFor(x => x.DeletePhone, new { @class = "mark-for-delete" }) %>
        <%: Html.RemoveLink("Remove", "div.phoneNumber", "input.mark-for-delete") %>
    </p>
         <div class="editor-field">
        <%: Html.ValidationMessageFor(x => x.Phone) %>
    </div>
</div>
    