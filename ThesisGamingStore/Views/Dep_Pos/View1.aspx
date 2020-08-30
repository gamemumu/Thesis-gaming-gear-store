﻿<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <meta name="viewport" content="width=device-width" />
    <title>View1</title>
      <!-- Scripts --->
    <script src="<%: Url.Content("~/Scripts/lvl-drag-drop.js") %>" type="text/javascript"></script>
    <script src="<%: Url.Content("~/Scripts/jquery-2.0.2.min.js") %>" type="text/javascript"></script>
    <script src="<%: Url.Content("~/Scripts/angular.min.js") %>" type="text/javascript"></script>
    <!-- Styles --->
    <link href="<%: Url.Content("~/Content/css/bootstrap.min.css") %>" rel="stylesheet" type="text/css" />
    <link href="<%: Url.Content("~/Content/dragg.css") %>" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
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

        var userData = [
          { id: 1, firstName: 'Mary', lastName: 'Goodman', role: 'manager', approved: true, points: 34 },
          { id: 2, firstName: 'Mark', lastName: 'Wilson', role: 'developer', approved: true, points: 4 },
          { id: 3, firstName: 'Alex', lastName: 'Davies', role: 'admin', approved: true, points: 56 },
          { id: 4, firstName: 'Bob', lastName: 'Banks', role: 'manager', approved: false, points: 14 },
          { id: 5, firstName: 'David', lastName: 'Stevens', role: 'developer', approved: false, points: 100 },
          { id: 6, firstName: 'Jason', lastName: 'Durham', role: 'developer', approved: false, points: 0 },
        ];

        function ctrlDualList($scope) {

            // init
            $scope.selectedA = [];
            $scope.selectedB = [];

            $scope.listA = userData.slice(0, 5);
            $scope.listB = [];
            $scope.items = userData;

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
                    var moveId = arrayObjectIndexOf($scope.items, $scope.selectedA[i], "id");
                    $scope.listB.push($scope.items[moveId]);
                    var delId = arrayObjectIndexOf($scope.listA, $scope.selectedA[i], "id");
                    $scope.listA.splice(delId, 1);
                }
                reset();
            };

            $scope.bToA = function () {
                for (i in $scope.selectedB) {
                    var moveId = arrayObjectIndexOf($scope.items, $scope.selectedB[i], "id");
                    $scope.listA.push($scope.items[moveId]);
                    var delId = arrayObjectIndexOf($scope.listB, $scope.selectedB[i], "id");
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
                        $scope.selectedA.push($scope.listA[i].id);
                    }
                }
            }

            $scope.toggleB = function () {

                if ($scope.selectedB.length > 0) {
                    $scope.selectedB = [];
                }
                else {
                    for (i in $scope.listB) {
                        $scope.selectedB.push($scope.listB[i].id);
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

        };

        angular
          .module('myApp', ['lvl.directives.dragdrop'])
          .controller('ctrlDualList', ['$scope', ctrlDualList]);

        $(document).ready(function () {
            jQuery.event.props.push('dataTransfer'); //prevent conflict with drag-drop
        });
    </script>
</head>
<body>
   <hr>
<div class="container-fluid" ng-app="myApp"> 
    <div class="container" ng-controller="ctrlDualList">
      <div class="row">
            <div class="col-md-12 text-center"><h3>Drag &amp; Drop Pick List</h3></div>
            <div class="col-sm-4 col-sm-offset-1">
              <div class="list-group" id="list1" x-lvl-drop-target="true" x-on-drop="drop(dragEl, dropEl, bToA)">
                <a href="javascript:;" class="list-group-item active">Staff
                  <input title="Toggle all" ng-click="toggleA()" ng-model="toggle" value="{{toggle}}" type="checkbox" class="pull-right"></a>
                <span ng-repeat="user in listA">
                  <a href="javascript:;" data-id="{{user.id}}" x-lvl-draggable="true" class="list-group-item">{{user.firstName}}
                    <small class="text-muted"><em>{{user.role}}</em></small>                    
                    <input id="{{user.id}}" ng-click="selectedA.push(user.id)" name="selectedA[]" value="{{user.id}}" ng-checked="selectedA.indexOf(user.id) > -1" type="checkbox" class="pull-right">
                  </a>
                </span>
              </div>
            </div><!--/col-4-->
            <div class="col-md-2 v-center text-center">
              <div class="btn-group">
                <button title="Send to list 1" class="btn btn-default" ng-click="bToA()" id="btnA"><i class="glyphicon glyphicon-chevron-left"></i></button>
                <button title="Send to list 2" class="btn btn-default" ng-click="aToB()" id="btnB"><i class="glyphicon glyphicon-chevron-right"></i></button>
              </div>
              <h6 class="text-center">move from list-to-list</h6>
            </div><!--/col-2-->
            <div class="col-sm-4">
              <div class="list-group" id="list2" x-lvl-drop-target="true" x-on-drop="drop(dragEl, dropEl, aToB)">
                <a href="javascript:;" class="list-group-item active">Team Members
                  <input title="Toggle all" ng-click="toggleB()" ng-model="toggle" value="{{toggle}}" type="checkbox" class="pull-right">
                </a>
                <span ng-repeat="user in listB">
                  <a href="javascript:;" data-id="{{user.id}}" class="list-group-item" x-lvl-draggable="true">{{user.firstName}}
                    <small class="text-muted"><em>{{user.role}}</em></small>
                    <input id="{{user.id}}" ng-click="selectedB.push(user.id)" name="selectedB[]" value="{{user.id}}" ng-checked="selectedB.indexOf(user.id) > -1" type="checkbox" class="pull-right">
                  </a>
                </span>
              </div>
            </div><!--/col-4-->
      </div><!--/row-->
    </div><!--/container-->
   
  <hr>
  <a href="http://www.bootply.com/mW09b0bQcE">Edit on Bootply</a> 
  
  </div><!--/container-fluid-->
</body>
</html>
