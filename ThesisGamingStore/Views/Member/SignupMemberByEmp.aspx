<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/MasterGaming.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    SignupMemberByEmp
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h3 class="page-header">สร้างสมาชิกใหม่</h3>
    <div class="panel panel-primary">
        <div class="panel-heading">
            สร้างสมาชิกใหม่
                 <div class="pull-right"><i class="fa fa-calendar-o"></i>&nbsp<%=System.DateTime.Today.ToString("dddd") %> &nbsp<%=System.DateTime.Today.ToString("dd/MM/yyyy") %></div>
        </div>
        <div class="panel-body">
            <div class="row">
                <section id="form">
                    <!--form-->
                    <div class="container">
                        <div class="row">
                            <form action="#" role="form" data-toggle="validator" id="regexpForm">
                                <div class="col-sm-4 col-sm-offset-1">
                                    <div class="login-form">
                                        <!--signup form-->
                                        <h2>USER ACCOUNT INFORMATION</h2>
                                        <div class="form-group">
                                            <label for="inputEmail" class="control-label">Email</label>
                                            <input type="email" class="form-control" id="inputEmail" name="email" placeholder="Email" data-error="Bruh, that email address is invalid" required>
                                            <div class="help-block with-errors"></div>
                                        </div>
                                        <div class="form-group">
                                            <label for="inputPassword" class="control-label">Password</label>
                                            <input type="password" data-minlength="4" class="form-control" name="password" id="inputPassword" placeholder="Password" data-error="Minimum of 4 characters" required>
                                            <div class="help-block with-errors"></div>
                                        </div>
                                        <div class="form-group">
                                            <label for="confirmPassword" class="control-label">Confirm Password</label>
                                            <input type="password" class="form-control" id="inputPasswordConfirm" name="confirmPassword" data-match="#inputPassword" data-match-error="Whoops, these don't match" placeholder="Confirm" required>
                                            <div class="help-block with-errors"></div>
                                        </div>
                                        <button type="submit" id="btnSubmit" class="btn pull-right" style="background-color: #95AD40 !important">CONFIRM</button>
                                        <%--</form>--%>
                                    </div>
                                    <!--/signup form-->
                                </div>
                                <div class="col-sm-1">
                                </div>
                                <div class="col-sm-4">
                                    <div class="signup-form">
                                        <!--sign up form-->
                                        <h2>CUSTOMER INFORMATION</h2>
                                        <%-- <form action="#" role="form" data-toggle="validator" id="regexpForm2">--%>
                                        <div class="form-group">
                                            <label for="inputName" class="control-label">First Name</label>
                                            <input type="text" class="form-control" id="inputFName" name="inputFName" placeholder="First Name" required>
                                        </div>
                                        <div class="form-group">
                                            <label for="inputName" class="control-label">Last Name</label>
                                            <input type="text" class="form-control" id="inputLName" name="inputLName" placeholder="Last Name" required>
                                        </div>
                                        <div class="form-group">
                                            <label class="radio-inline">
                                                <input type="radio" name="optradio" style="width: 20px !important; height: 15px !important" id="male" value="male">Male</label>
                                            <label class="radio-inline">
                                                <input type="radio" name="optradio" style="width: 20px  !important; height: 15px !important" id="female" value="female">Female</label>
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label" for="textarea-field">Address</label>
                                            <textarea class="form-control" id="textarea-field" placeholder="Your Address" name="address" rows="5" required></textarea>
                                        </div>
                                        <div class="form-group _phone">
                                            <div class="col-xs-8" style="padding-left: 0px !important">
                                                <input type="text" class="form-control phone" name="mobilePhone[]" placeholder="Phone Number" onkeypress="return isNumberKey(event);" />
                                            </div>
                                            <div class="col-xs-4">
                                                <div class="row">
                                                    <button type="button" class="btn btn-info" onclick="Add('1','0')">+</button>
                                                    <button type="button" class="btn btn-danger" onclick="Add('0','0')">- </button>
                                                </div>
                                            </div>
                                        </div>
                                        <%--</form>--%>
                                    </div>
                                    <!--/sign up form-->
                                </div>
                            </form>
                        </div>
                    </div>
                </section>
            </div>
        </div>
    </div>
    <!--/form-->

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="FeaturedContent" runat="server">
    <script type="text/javascript">
        jQuery(function ($) {
            $(".phone").mask("999-999-9999");
            document.getElementById("male").checked = true;
            formValidation();
        });//docready


        var onCreate = true; var CheckPhone = 0; var CheckPhoneBlur = 0;
        var flag = true;
        var valid = true;
        function formValidation() {
            $('#regexpForm').formValidation({
                framework: 'bootstrap',
                fields: {
                    inputFName: {
                        validators: {
                            notEmpty: {
                            },
                            regexp: {
                                regexp: /^[a-z\s]+$/i,
                                message: 'The first name can consist of alphabetical characters and spaces only'
                            }
                        }
                    },
                    inputLName: {
                        validators: {
                            notEmpty: {
                            },
                            regexp: {
                                regexp: /^[a-z\s]+$/i,
                                message: 'The last name can consist of alphabetical characters and spaces only'
                            }
                        }
                    },
                    address: {
                        validators: {
                            notEmpty: {
                            }
                        }
                    },
                    'mobilePhone[]': {
                        validators: {
                            notEmpty: {
                            },
                            stringLength: {
                                min: 12,
                                max: 12,
                                message: 'Invalid length format'
                            }
                        }
                    },
                    email: {
                        validators: {
                            notEmpty: {
                            },
                            emailAddress: {
                                message: 'The value is not a valid email address'
                            },
                            regexp: {
                                regexp: '^[^@\\s]+@([^@\\s]+\\.)+[^@\\s]+$',
                                message: 'The value is not a valid email address'
                            },
                            // Send { email: 'its value', type: 'email' } to the back-end
                            remote: {
                                message: 'Email นี้มีผู้ใช้งานแล้ว',
                                url: '/Member/checkExist/',
                                data: {
                                    type: 'email'
                                },
                                type: 'POST'
                            }
                        }
                    },
                    password: {
                        validators: {
                            notEmpty: {
                            },
                            regexp: {
                                regexp: '(?!^[0-9]*$)(?!^[a-zA-Z]*$)^([a-zA-Z0-9]{6,15})$',
                                message: '* ต้องมีตัวอักษร และ ตัวเลขผสมกัน'
                            },
                            identical: {
                                field: 'confirmPassword',
                                message: 'The password and its confirm are not the same'
                            },
                            stringLength: {
                                min: 6,
                                max: 16,
                                message: 'Please enter value between %s and %s characters long'
                            }
                        }
                    },
                    confirmPassword: {
                        validators: {
                            identical: {
                                field: 'password',
                                message: 'The password and its confirm are not the same'
                            }
                        }
                    }
                }
            })
          .on('err.validator.fv', function (e, data) {
              // data.bv        --> The FormValidation.Base instance
              // data.field     --> The field name
              // data.element   --> The field element
              // data.validator --> The current validator name

              if (data.field === 'email') {
                  // The email field is not valid
                  data.element
                      .data('fv.messages')
                      // Hide all the messages
                      .find('.help-block[data-fv-for="' + data.field + '"]').hide()
                      // Show only message associated with current validator
                      .filter('[data-fv-validator="' + data.validator + '"]').show();
              }
          }).on('keyup', '[name="password"]', function () {
              var isEmpty = $(this).val() == '';
              $('#enableForm')
                      .formValidation('enableFieldValidators', 'password', !isEmpty)
                      .formValidation('enableFieldValidators', 'confirm_password', !isEmpty);

              // Revalidate the field when user start typing in the password field
              if ($(this).val().length == 1) {
                  $('#enableForm').formValidation('validateField', 'password')
                                  .formValidation('validateField', 'confirm_password');
              }
          }).on('blur', '[name="mobilePhone[]"]', function () {
              var textValues = [];
              flag = true;
              //initially mark as valid state
              valid = true;
              $.each($("input[name*='mobilePhone']"), function (i) {
                  if (valid) {
                      if ($(this).val() !== "" && $(this).val().length == 12) {
                          var doesExisit = ($.inArray($(this).val(), textValues) === -1) ? false : true;
                          if (doesExisit === false) {
                              console.log("adding the values to array");
                              textValues.push($(this).val());
                              console.log(textValues);
                              $("#btnSubmit").removeClass("disabled");
                              $("#btnSubmit").prop('disabled', false);
                              onCreate = true;
                              CheckPhoneBlur = 1;
                          } else if ($(this).val().length == 12) {
                              console.log(textValues);
                              //update the state as invalid
                              //    alert("Duplicate Phone number");
                              $("#btnSubmit").addClass("disabled");
                              $("#btnSubmit").prop('disabled', true);
                              CheckPhoneBlur = 2;
                              return false;
                          }
                      } else {
                          //               alert("Invalid length format");
                          $("#btnSubmit").addClass("disabled");
                          $("#btnSubmit").prop('disabled', true);
                          valid = false;
                          CheckPhoneBlur = 3;
                          return false;
                      }
                  }
              });//return the valid state
              //switch (CheckPhoneBlur) {
              //    case 2: alert("เบอร์โทรซ้ำ"); break;
              //    case 3: alert("เบอร์โทรไม่ได้กรอก"); break;
              //}
          }).on('success.form.fv', function (e) {
              // Prevent form submission
              e.preventDefault();
              var $form = $(e.target),
                  fv = $form.data('formValidation');
              if (onCreate) {
                  //check phone= 1 ผ่าน  2 =  ซ้ำ   3 = ว่างหรือน้อยเกินไป 
                  if (flag) {
                      var textValues = [];
                      $.each($("input[name*='mobilePhone']"), function (i) {
                          if ($(this).val() !== "" && $(this).val().length == 12) {
                              var doesExisit = ($.inArray($(this).val(), textValues) === -1) ? false : true;
                              if (doesExisit === false) {
                                  console.log("adding the values to array");
                                  textValues.push($(this).val());
                                  console.log(textValues);
                                  $("#btnSubmit").removeClass("disabled");
                                  $("#btnSubmit").prop('disabled', false);
                                  CheckPhone = 1;
                              } else if ($(this).val().length == 12) {
                                  console.log(textValues);
                                  //update the state as invalid
                                  //    alert("Duplicate Phone number");
                                  $("#btnSubmit").addClass("disabled");
                                  $("#btnSubmit").prop('disabled', true);
                                  CheckPhone = 2;
                              }
                          } else {
                              //               alert("Invalid length format");
                              $("#btnSubmit").addClass("disabled");
                              $("#btnSubmit").prop('disabled', true);
                              CheckPhone = 3;
                          }
                      });//return the valid state
                      switch (CheckPhone) {
                          case 2: alert("เบอร์โทรซ้ำ"); break;
                          case 3: alert("เบอร์โทรไม่ได้กรอก"); break;
                      }
                      flag = false;
                  }
                  if (CheckPhone == 1) {
                      onCreate = false;
                      // Use Ajax to submit form data
                      $.ajax({
                          url: "<%= Url.Action("CreateMemberByEmp","Member") %>",
                          type: 'POST',
                          contentType: 'application/json',
                          data: JSON.stringify($form.serializeArray()),
                          success: function (result) {
                              setTimeout(function () {
                                  window.location.href = "/Member/ListMemberByEmp";
                              }, 1000);
                          }
                      });
                  }
              }
          });
        }

        var id = 1;
        function Add(op, index) {
            if (op == "1") {
                var html = '<div class="form-group _phone" id=' + (id) + '>' +
                                '<div class="col-xs-8" style="padding-left: 0px !important">' +
                              '<input type="text" class="form-control phone" name="mobilePhone[]"  placeholder="Phone Number" onkeypress="return isNumberKey(event);" id="t' + (id) + '" data-fv-field="mobilePhone[]"/>' +
                                ' </div>' +
                                '<div class="col-xs-4"><div class="row">' +
                                  ' <button type="button" class="btn btn-info" onclick="Add(\'' + 1 + '\',\'' + id + '\')">+</button>' +
                              ' <button type="button" class="btn btn-danger"  onclick="Add(\'' + 0 + '\',\'' + id + '\')">- </button>' +
                           '</div> </div>' +
                         '   </div>';
                $("#t" + id).focus();
                id++;
                $(html).insertAfter($("._phone").last());
                formValidation();
                valid = true;
            } else {
                $('#' + index).empty();
                valid = false;
                flag = true;
                $("#btnSubmit").removeClass("disabled");
                $("#btnSubmit").prop('disabled', false);
            }
        }

function isNumberKey(evt) {
    var charCode = (evt.which) ? evt.which : event.keyCode
    if (charCode > 31 && (charCode < 48 || charCode > 57))
        return false;
    return true;
}
    </script>
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ScriptsSection" runat="server">
    <script src="../../Scripts/jquery.mask.js"></script>
    <link href="../../Scripts/vendor/formValidation/css/formValidation.min.css" rel="stylesheet" />
    <script src="../../Scripts/vendor/formValidation/js/formValidation.min.js"></script>
    <script src="../../Scripts/vendor/formValidation/framework/bootstrap.min.js"></script>
</asp:Content>
