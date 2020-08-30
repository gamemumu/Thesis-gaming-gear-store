<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/MasterGaming.Master" Inherits="System.Web.Mvc.ViewPage<ThesisGamingStore.Models.Employee>" %>
<%@ Import Namespace="ThesisGamingStore.Models" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Edit
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <script src="<%: Url.Content("~/Scripts/CustomJs.js") %>" type="text/javascript"></script>
      <h3 class="page-header">Edit Employe</h3>
    <% using (Html.BeginForm())
       { %>
    <%: Html.AntiForgeryToken() %>
    <%: Html.ValidationSummary(true) %>

    <fieldset>

        <section class="col-md-6">
            <div class="editor-label">
                <%: Html.LabelFor(model => model.EmpID) %>
            </div>
            <div class="editor-field">
                <%: Html.TextBoxFor(model => model.EmpID,new { disabled="disabled", @readonly = "readonly",style = "background-color: ButtonFace !important;"}) %>
                  <%: Html.HiddenFor(model => model.EmpID) %>
                <%: Html.ValidationMessageFor(model => model.EmpID) %>
            </div>
             <div class="editor-label">
                <%: Html.LabelFor(model => model.Idcard) %>
            </div>
            <div class="editor-field">
                <%: Html.TextBoxFor(model => model.Idcard,new { disabled="disabled", @readonly = "readonly",style = "background-color: ButtonFace !important;"}) %>
                <%: Html.HiddenFor(model => model.Idcard) %>
                <%: Html.ValidationMessageFor(model => model.Idcard) %>
            </div>

            <div class="editor-label">
                <%: Html.LabelFor(model => model.UserName) %>
            </div>
            <div class="editor-field">
                <%: Html.TextBoxFor(model => model.UserName,new { disabled="disabled", @readonly = "readonly",style = "background-color: ButtonFace !important;"}) %>
                 <%: Html.HiddenFor(model => model.UserName) %>
                <%: Html.ValidationMessageFor(model => model.UserName) %>
            </div>


            <%--<div class="editor-label">
                  <%: Html.LabelFor(model => model.Password) %>
            </div>--%>
            <div class="editor-field">
                <%: Html.HiddenFor(model => model.Password) %>
                <%: Html.ValidationMessageFor(model => model.Password) %>
            </div>

            <div class="editor-label">
                <%: Html.LabelFor(model => model.Email) %>
            </div>
            <div class="editor-field">
                <%: Html.EditorFor(model => model.Email) %>
                <%: Html.ValidationMessageFor(model => model.Email) %>
            </div>

        </section>
        <%: Html.HiddenFor(model => model.PosID,new {id = "_PosID"}) %>
        <section class="col-md-6">

            <div class="editor-label">

                <%: Html.DropDownListFor(model => model.PosID, new SelectList(Enumerable.Empty<SelectListItem>()), new { style = "width:68%;height:32px;"})%>

                <%--####### เปิด สิทธิ์สำหรับแอดมินในการแก้ไข ตำแหน่ง ################--%>
                 <% if (Page.User.IsInRole("สิทธิจัดการตำแหน่ง"))
                           { %>
                    <button type="button" id="myButton" data-loading-text="Loading..." class="btn btn-primary" autocomplete="off" onclick="ChangePos()">Change</button>
                <% } %>
            </div>

            <div class="editor-label">
                <%: Html.LabelFor(model => model.Fname) %>
            </div>
            <div class="editor-field">
                <%: Html.EditorFor(model => model.Fname) %>
                <%: Html.ValidationMessageFor(model => model.Fname) %>
            </div>

            <div class="editor-label">
                <%: Html.LabelFor(model => model.Lname) %>
            </div>
            <div class="editor-field">
                <%: Html.EditorFor(model => model.Lname) %>
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
                <%: Html.LabelFor(model => model.Sex) %>
            </div>
            <div class="editor-label">
                <%--<%: Html.LabelFor(model => model.Sex) %>--%>
                <span><%: Html.RadioButtonFor(model => model.Sex,"Male",new {id = "Male",style = "width:20px;"}) %>
                    <%: Html.Label("Male","Male") %>
                    <%: Html.RadioButtonFor(model => model.Sex,"Female",new {id = "Female",style = "width:20px; "}) %>
                    <%: Html.Label("Female","Female")  %> </span>
            </div>

            <div class="editor-label">
                <%: Html.LabelFor(model => model.Salary) %>
            </div>
            <div class="editor-field">

              <% if (Page.User.IsInRole("สิทธิจัดการพนักงาน"))
                           { %>
                        <%: Html.EditorFor(model => model.Salary) %>
                <% }else{ %>
                       <%: Html.TextBoxFor(model => model.Salary ,new { disabled="disabled", @readonly = "readonly",style = "background-color: ButtonFace !important;"})%> 
                         <%: Html.HiddenFor(model => model.Salary) %>
                <%} %>
                <%: Html.ValidationMessageFor(model => model.Salary) %>
            </div>

            <div id="phoneNumbers">
            <div class="editor-field">
                <%: Html.EditorFor(model => model.Phones) %>
                <%: Html.ValidationMessageFor(model => model.Phones) %>
            </div>
                </div>
            <p>
                <%:Html.AddLink("Add More Phone Numbers", "#phoneNumbers", ".phoneNumber", "Phones", typeof(EMPLOYEE_PHONE))%>
            </p>
        </section>


        <p>
            <input type="submit" value="Save" onclick="SendData()" />
        </p>
    </fieldset>
    <% } %>

    <div>
        <%: Html.ActionLink("Back to List", "ListEmp2") %>
    </div>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="FeaturedContent" runat="server">
    <script type="text/javascript">
        var flag = 0;
        $(document).ready(function () {
            flag = 0;
            $.ajax({
                type: 'Get',
                url: "<%= Url.Action("JsonListPosit","Dep_Pos") %>", // we are calling json method
                dataType: 'json',
                success: function (data) {
                    $.each(data, function (i, obj) {
                        if ($("#_PosID").val() == obj.PosID) {
                            $("#PosID").append('<option value="' + obj.PosID + '">' + obj.DepName + '  [ ' + obj.PosName + ' ]</option>');
                        }
                    });
                },
                error: function (ex) {
                    alert('Failed to retrieve Department' + ex);
                }
            });
        });

        function ChangePos() {
            if (flag == 0) {
                $.ajax({
                    type: 'Get',
                    url: "<%= Url.Action("JsonListPosit","Dep_Pos") %>", // we are calling json method
                    dataType: 'json',
                    success: function (data) {
                        $.each(data, function (i, obj) {
                            $("#PosID").append('<option value="' + obj.PosID + '">' + obj.DepName + '  [ ' + obj.PosName + ' ]</option>');
                        });
                        flag = 1;
                    },
                    error: function (ex) {
                        alert('Failed to retrieve Department' + ex);
                    }
                });
            }
        }
        function SendData() {
            $("#_PosID").val($("#PosID").val())
        }
        function ValidateNumber(e) {
            var evt = (e) ? e : window.event;
            var charCode = (evt.keyCode) ? evt.keyCode : evt.which;
            if (charCode > 31 && (charCode < 48 || charCode > 57)) {
                return false;
            }
            return true;
        };
    </script>
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ScriptsSection" runat="server">
    <%--<%: Scripts.Render("~/bundles/jqueryval") %>--%>
</asp:Content>
