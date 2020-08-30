<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<ThesisGamingStore.Models.PositionModel>" %>

<div class="container-fluid" ng-app="myApp">
    <div class="container" ng-controller="ctrlDualList">
        <div class="row">
            <div class="col-md-12 text-center">
                <h3>Drag &amp; Drop Roles List</h3>
            </div>
           <div class="col-sm-4">
                <div class="list-group" id="list1" x-lvl-drop-target="true" x-on-drop="drop(dragEl, dropEl, bToA)">
                    <a href="javascript:;" class="list-group-item active">สิทธิ์ยังไม่ได้ใข้งาน
                  <input title="Toggle all" ng-click="toggleA()" ng-model="toggle" value="{{toggle}}" type="checkbox" class="pull-right"></a>
                    <!--n_role = ยังไม่ได้เลือก -->
                    <span ng-repeat="n_role in listA">
                        <a href="javascript:;" data-id="{{n_role.RoleID}}" x-lvl-draggable="true" class="list-group-item">{{n_role.RoleName}}
                    <small class="text-muted"><em>{{n_role.RoleID}}</em></small>
                            <input id="{{n_role.RoleID}}" ng-click="selectedA.push(n_role.RoleID)" name="selectedA[]" value="{{n_role.RoleID}}" ng-checked="selectedA.indexOf(n_role.RoleID) > -1" type="checkbox" class="pull-right">
                        </a>
                    </span>

                </div>
            </div>
            <!--/col-4-->
            <div class="col-md-2 v-center text-center">
                <div class="btn-group">
                    <button type="button" title="Send to list 1" class="btn btn-default" ng-click="bToA()" id="btnA"><i class="glyphicon glyphicon-chevron-left"></i></button>
                    <button type="button" title="Send to list 2" class="btn btn-default" ng-click="aToB()" id="btnB"><i class="glyphicon glyphicon-chevron-right"></i></button>
                  <%--  <input type="button" title="Send to list 1" style="width:40px; height:34px;" class="btn btn-default" ng-click="bToA()" id="btnA"><i class="glyphicon glyphicon-chevron-left"></i>
                    <input type="button" title="Send to list 2" style="width:40px; height:34px;" class="btn btn-default" ng-click="aToB()" id="btnB"><i class="glyphicon glyphicon-chevron-right"></i>--%>
                </div>
                <h6 class="text-center">move from list-to-list</h6>
            </div>
            <!--/col-2-->
             <div class="col-sm-4">
                <div class="list-group" id="list2" x-lvl-drop-target="true" x-on-drop="drop(dragEl, dropEl, aToB)">
                    <a href="javascript:;" class="list-group-item active">สิทธิ์ที่ใช้งาน
                  <input title="Toggle all" ng-click="toggleB()" ng-model="toggle" value="{{toggle}}" type="checkbox" class="pull-right">
                    </a>

                    <!--y_role = เลือกไปแล้ว -->
                    <span ng-repeat="y_role in listB">
                        <a href="javascript:;" data-id="{{y_role.RoleID}}" class="list-group-item" x-lvl-draggable="true">{{y_role.RoleName}}
                    <small class="text-muted"><em>{{y_role.RoleID}}</em></small>
                            <input id="{{y_role.RoleID}}" ng-click="selectedB.push(y_role.RoleID)" name="selectedB[]" value="{{y_role.id}}" ng-checked="selectedB.indexOf(y_role.RoleID) > -1" type="checkbox" class="pull-right">
                        </a>
                    </span>
                </div>
            </div>
            <!--/col-4-->
        </div>
        <!--/row-->
        <%--<div id='sta_list' ng:repeat="itemA in listA">{{itemA}}</div>--%>

        <div class='end_list' ng-show="false" ng:repeat="itemB in listB">
            {{itemB}}
        </div>
        <%--<a href="" ng-click="postList()">More</a>--%>
        <%--<input type="submit" value="More" ng-click="postList()"/>--%>
    </div>
    <!--/container-->
</div>


<script type="text/javascript">
    /* load drag-and-drop directives -- credit: http://logicbomb.github.io/ng-directives/script/lvl-drag-drop.js */
    $(document).ready(function () {
        jQuery.event.props.push('dataTransfer'); //prevent conflict with drag-drop
    });

    function e_submit() {
        var roles = [];
        if ($.trim($(".end_list").html()) == '') {
            alert("กรูณาเลือกสิทธิของตำแหน่ง !!");
        }
        else {
            //var passVal = $(".end_list").length;
            //for (var i = 0, len = myArray.length; i < len; i++) {
            //    data = $(".end_list").html().chai
            //}
            var divs = $("div[class*='end_list']");
            $.each(divs, function (i, obj) {
                roles.push([$.trim($(this).text()).split(/\r\n|\r|\n/g)])
            });
            //  alert(roles);
            //alert($(".end_list").html());
            // $("#Temp").val(roles.toString());
            // var ar = ($.trim(roles)).split(;
            // alert(json_encode(roles.toString()))
            //alert(roles.toString())
            var format = "{0}{1}{2}".replace('{0}', '[').replace('{1}', roles).replace('{2}', ']');
           // alert(format)
            $("#Temp").val(format);
        }
    }








    angular
    .module('lvl.services', [])
    .factory('uuid', function () {
        var svc = {
            new: function () {
                function _p8(s) {
                    var p = (Math.random().toString(16) + "000000000").substr(2, 8);
                    return s ? "-" + p.substr(0, 4) + "-" + p.substr(4, 4) : p;
                }
                return _p8() + _p8(true) + _p8(true) + _p8();
            },

            empty: function () {
                return '00000000-0000-0000-0000-000000000000';
            }
        };

        return svc;
    });

    var module = angular.module("lvl.directives.dragdrop", ['lvl.services']);

    module.directive('lvlDraggable', ['$rootScope', 'uuid', function ($rootScope, uuid) {
        return {
            restrict: 'A',
            link: function (scope, el, attrs, controller) {
                angular.element(el).attr("draggable", "true");

                var id = angular.element(el).attr("id");

                if (!id) {
                    id = uuid.new()
                    angular.element(el).attr("id", id);
                }

                el.bind("dragstart", function (e) {
                    e.dataTransfer.setData('text', id);
                    $rootScope.$emit("LVL-DRAG-START");
                });

                el.bind("dragend", function (e) {
                    $rootScope.$emit("LVL-DRAG-END");
                });
            }
        }
    }]);
    module.directive('lvlDropTarget', ['$rootScope', 'uuid', function ($rootScope, uuid) {
        return {
            restrict: 'A',
            scope: {
                onDrop: '&'
            },
            link: function (scope, el, attrs, controller) {

                var id = angular.element(el).attr("id");

                if (!id) {
                    id = uuid.new();
                    angular.element(el).attr("id", id);
                }

                el.bind("dragover", function (e) {
                    if (e.preventDefault) {
                        e.preventDefault();
                    }

                    e.dataTransfer.dropEffect = 'move';
                    return false;
                });

                el.bind("dragenter", function (e) {
                    // this / e.target is the current hover target.
                    angular.element(e.target).addClass('lvl-over');
                });

                el.bind("dragleave", function (e) {
                    angular.element(e.target).removeClass('lvl-over');  // this / e.target is previous target element.
                });

                el.bind("drop", function (e) {
                    if (e.preventDefault) {
                        e.preventDefault();
                    }

                    if (e.stopPropagation) {
                        e.stopPropagation();
                    }
                    var data = e.dataTransfer.getData("text");
                    var dest = document.getElementById(id);
                    var src = document.getElementById(data);

                    scope.onDrop({ dragEl: src, dropEl: dest });
                    $rootScope.$emit("LVL-DRAG-END");
                });

                $rootScope.$on("LVL-DRAG-START", function () {
                    var el = document.getElementById(id);
                    angular.element(el).addClass("lvl-target");
                });

                $rootScope.$on("LVL-DRAG-END", function () {
                    var el = document.getElementById(id);
                    angular.element(el).removeClass("lvl-target");

                    var els = document.getElementsByClassName("lvl-over");
                    for (var e in els) {
                        angular.element(els[e]).removeClass("lvl-over");
                    }
                });
            }
        }
    }]);
    /*end directives*/
    var roleData_NONE = (function () {
        var roleData_NONE = null;
        $.ajax({
            async: false,
            type: 'Get',
            url: "<%= Url.Action("ListRole","Role") %>", // we are calling json method
            dataType: 'json',
            success: function (data) {
                // var jsonData = JSON.stringify(data);
                //  $("#ttt").html(jsonData);
                roleData_NONE = data;
            },
            error: function (ex) {
                alert('Failed to retrieve roleData' + ex);
            }
        });
        return roleData_NONE;
     })();

    var roleData = (function () {
        var roleData = null;
        $.ajax({
            async: false,
            type: 'Get',
            url: "<%= Url.Action("JsonEditPosInRole","Dep_Pos") %>", // we are calling json method
            dataType: 'json',
            success: function (data) {
                // var jsonData = JSON.stringify(data);
                //  $("#ttt").html(jsonData);
                roleData = data;
            },
            error: function (ex) {
             //   alert('Failed to retrieve roleData' + ex);
            }
        });
        return roleData;
    })();


    function ctrlDualList($scope) {

        // init
        $scope.selectedA = [];
        $scope.selectedB = [];

        if (roleData == null) roleData = [];
        //Remove Dupicate Data 
        for (var i = 0, len = roleData.length; i < len; i++) {
            for (var j = 0, len2 = roleData_NONE.length; j < len2; j++) {
                if (roleData[i].RoleID === roleData_NONE[j].RoleID) {
                    roleData_NONE.splice(j, 1);
                    len2 = roleData_NONE.length;
                }
            }
        }
        
        $scope.listA = roleData_NONE.slice(0, roleData_NONE.length);
        $scope.listB = roleData.slice(0, roleData.length);
        var AllItem = $scope.listA.concat($scope.listB)
        $scope.items = AllItem; //all item


        $scope.checkedA = false;
        $scope.checkedB = false;

        function arrayObjectIndexOf(myArray, searchTerm, property) {
            for (var i = 0, len = myArray.length; i < len; i++) {
                if (myArray[i][property] === searchTerm) return i;
            }
            return -1;
        }

        $scope.aToB = function () {
            for (i in $scope.selectedA) {
                var moveId = arrayObjectIndexOf($scope.items, $scope.selectedA[i], "RoleID");
                $scope.listB.push($scope.items[moveId]);
                var delId = arrayObjectIndexOf($scope.listA, $scope.selectedA[i], "RoleID");
                $scope.listA.splice(delId, 1);
            }
            reset();
        };

        $scope.bToA = function () {
            for (i in $scope.selectedB) {
                var moveId = arrayObjectIndexOf($scope.items, $scope.selectedB[i], "RoleID");
                $scope.listA.push($scope.items[moveId]);
                var delId = arrayObjectIndexOf($scope.listB, $scope.selectedB[i], "RoleID");
                $scope.listB.splice(delId, 1);
            }
            reset();
        };

        function reset() {
            $scope.selectedA = [];
            $scope.selectedB = [];
            $scope.toggle = 0;
        }

        $scope.toggleA = function () {

            if ($scope.selectedA.length > 0) {
                $scope.selectedA = [];
            }
            else {
                for (i in $scope.listA) {
                    $scope.selectedA.push($scope.listA[i].RoleID);
                }
            }
        }

        $scope.toggleB = function () {

            if ($scope.selectedB.length > 0) {
                $scope.selectedB = [];
            }
            else {
                for (i in $scope.listB) {
                    $scope.selectedB.push($scope.listB[i].RoleID);
                }
            }
        }

        $scope.drop = function (dragEl, dropEl, direction) {

            var drag = angular.element(dragEl);
            var drop = angular.element(dropEl);
            var id = drag.attr("data-id");
            var el = document.getElementById(id);

            if (!angular.element(el).attr("checked")) {
                angular.element(el).triggerHandler('click');
            }

            direction();
            $scope.$digest();
        };

        $scope.postList = function () {
            alert($scope.listB.length);
        }
    };

    angular
      .module('myApp', ['lvl.directives.dragdrop'])
      .controller('ctrlDualList', ['$scope', ctrlDualList]);



</script>