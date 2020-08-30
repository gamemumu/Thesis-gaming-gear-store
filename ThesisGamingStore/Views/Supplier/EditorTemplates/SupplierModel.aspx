<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<ThesisGamingStore.Models.SupplierModel>" %>

<%@ Import Namespace="ThesisGamingStore.Models" %>
<section class="col-md-6">
    <div class="editor-label">
        <%: Html.LabelFor(model => model.SupName) %>
    </div>
    <div class="editor-field">
        <%: Html.TextBoxFor(model => model.SupName, new { @style = "width:70%;" }) %>
    </div>
    <div class="editor-field">
        <%: Html.ValidationMessageFor(model => model.SupName) %>
    </div>

    <div class="editor-label">
        <%: Html.LabelFor(model => model.SubAddress) %>
    </div>
    <div class="editor-field">
         <%: Html.TextAreaFor(model => model.SubAddress,new { @style = "width:70%;" }) %>
    </div>
    <div class="editor-field">
        <%: Html.ValidationMessageFor(model => model.SubAddress) %>
    </div>

</section>

<section class="col-md-6">
    <div id="phoneNumbers">
        <%: Html.EditorFor(x => x.Phones) %>
        <%: Html.ValidationMessageFor(x => x.Phones) %>
    </div>
    <p>
        <%:Html.AddLink("Add More Phone Numbers", "#phoneNumbers", ".phoneNumber", "Phones", typeof(SUPPLIER_PHONE))%>
    </p>
</section>

