<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<ThesisGamingStore.Models.SUPPLIER_PHONE>" %>
<%@ Import Namespace="ThesisGamingStore.Models" %>
<div class="phoneNumber">
    <p>
        <label>Phone Number</label><br />
        <%:Html.HiddenFor(model => model.SupID) %>

        <%:Html.TextBoxFor(x => x.Phone,new { @style = "width:70%;" , @maxlength = 10, onkeydown="return ValidateNumber(event);" }) %>
      
        <%:Html.HiddenFor(x => x.DeletePhone, new { @class = "mark-for-delete" }) %>
        <%: Html.RemoveLink("Remove", "div.phoneNumber", "input.mark-for-delete") %>
        <br />
        <%: Html.ValidationMessageFor(x => x.Phone) %>
    </p>
</div>
    