<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE HTML>
<html>
<title>修改审计人员分工</title>
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>
    <script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/pages/tlInteractive/tlInteractiveCommon.js"></script>
    <script type="text/javascript">
        $(function() {
            var isDebug = true;
            var taskTree = $('#taskTreeId');
            var group_id = $("#group_id").val();
            var menuTaskId, menuTaskName;
            var dnd = false;
            var titleArr = new Array();
            var treeOptions = {
                treeTabTitle1: "审计分组分工",
                container: taskTree,
                checkbox: true,
                dnd: dnd,
                noMsg: true,
                cascadeExpand:true,
                param: {
                    'isOracle': false,
                    'serverCache': false,
                    'rootParentId': '-1',
                    'whereHql': "project_id='${project_id}'",
                    'beanName': 'AudTaskTree',
                    'treeId': 'taskTemplateId',
                    'treeText': 'taskName',
                    'treeParentId': 'taskPid',
                    'treeOrder': 'taskOrder',
                    'treeAtrributes': 'template_type'
                },
                onTreeClick: function(node, treeDom) {
                    try{
                        var parent = $('#taskTreeId').tree('getParent',node.target);
                        var id = node.id;
                        var type = node.leaf==0 ? "1":"2";
                        var taskPid = parent ? parent.id : null;
                        var path = "";
                        if(!taskPid){
                        	window.parent.frames['childBasefrm'].location.href="/ais/operate/task/showContentView.action?selectedTab=main&type="+type+"&taskPid="+taskPid+"&taskId="+id+"&project_id=<%=request.getParameter("project_id")%>";
                    	}else{
                    		window.parent.frames['childBasefrm'].location.href="/ais/operate/task/showContentView.action?selectedTab=item&type="+type+"&taskPid="+taskPid+"&taskId="+id+"&project_id=<%=request.getParameter("project_id")%>&fromAdjust=<%=request.getParameter("fromAdjust")%>";
                         }
                     }catch(e){
                          isDebug ? top.$.messager.alert('提示信息',"onTreeClick:"+e.message,'error') : null;
                     }
                },
                onTreeLoadSuccess: function(node, data) {
                    var result = '1';
                    var audTaskUser ="";
                    var deleteTask = "";
                    var rootId = "";
                    var audProMembers = ""; // 已被分工的信息
                    jQuery.ajax({
                        async: false,
                        url: '/ais/operate/task/project/getTreeNodeMemerWorks.action?proMemberId=${proMemberId}&project_id=${project_id}&group_id=' + group_id,
                        type: 'post',
                        success: function(data) {
                            result = data.taskTemplateIds;
                            audTaskUser = data.audTaskUser;
                            deleteTask = data.deleteTask;
                            rootId = data.rootId;
                            audProMembers = data.audProMembers;
                        }
                    });
                    

                    if (audProMembers != ""){
                        var ids = audProMembers.split(',');
                        for (var i = 0; i < ids.length; i++) {
                        	  var node = $('#taskTreeId').tree('find', ids[i]);
                              if (node) {
                            	  var x = node.target.getElementsByClassName("tree-title");
                                  if(titleArr.indexOf(x[0]) == -1) {
                                      var img = document.createElement("img");
                                      img.src = "/ais/cloud/images/edit.gif";
                                      x[0].parentNode.insertBefore(img,x[0]);
                                      titleArr.push(x[0]);
                                  }
                              }
                        }
                    }
                    $('.tree-checkbox0').css("display","none");
                    if (result != '') {
                        var ids = result.split(',');
                        for (var i = 0; i < ids.length; i++) {
                            var node = $('#taskTreeId').tree('find', ids[i]);
                            if (node) {
                            	var x = node.target.getElementsByClassName("tree-checkbox0");
                            	for (var t = 0; t < x.length; t++) {
                            	    x[t].style.display = "";
                            	}
                            }
                        }
                    }else{
                    	 $('.tree-checkbox0').css("display",'');
                    	if ( rootId && rootId != ""){
                    		var node = $('#taskTreeId').tree('find', rootId);
                    	     if (node) {
                             	var x = node.target.getElementsByClassName("tree-checkbox0");
                             	for (var t = 0; t < x.length; t++) {
                             	    x[t].style.display = "none";
                             	}
                             }
                    	}
                    }
                     if (audTaskUser != '') {
                        var ids = audTaskUser.split(',');
                        for (var i = 0; i < ids.length; i++) {
                            var node = $('#taskTreeId').tree('find', ids[i]);
                            if (node) {
                                $('#taskTreeId').tree('check', node.target);
                            }
                        }
                    } 
                    
                }
            }
            showSysTree(taskTree, treeOptions);
        });

         // 保存
        function saveTaskGroudBtn() {
            var treeIds = '';
            var selNodes = $('#taskTreeId').tree('getChecked');
            var taskTemplateId = '';
            var taskIdArr = [];
            $.each(selNodes, function(m, node) {
                taskIdArr.push(node.id);
            });
            treeIds = taskIdArr.join(",");
            taskIdArr = null;
/*             if (treeIds == '') {
                top.$.messager.show({
                    title: '提示信息',
                    msg: '请选择要保存的审计事项!'
                });
                return false;
            } else { */
                saveGroupTaskData(treeIds);
          //  }
        }

        function saveGroupTaskData(treeIds) {
            group_id = document.getElementById("group_id").value;
            $.ajax({
                url: '${contextPath}/operate/task/project/batchSaveMemerWorkTask.action',
                type: 'post',
                cache: false,
                data: {
                    'treeIds': treeIds,
                    'groupId': group_id,
                    'proMemberId': "${proMemberId}",
                    'project_id': '${project_id}'
                },
                success: function(data) {
                    if (data == 'suc') {
                        top.$.messager.show({
                            title: '提示消息',
                            msg: "保存成功!",
                            timeout: 5000,
                            showType: 'slide'
                        });
                        $('#taskTreeId').tree('reload');
                        var activeTabId = '${activeTabId}';
        		  		var frameWin = aud$getTabIframByTabId(activeTabId);
        		        if (frameWin){
        		        	frameWin.$("#dg").datagrid('reload');
        		        }
                    } else {
                        top.$.messager.show({
                            title: '提示消息',
                            mgs: '保存失败'
                        });
                    }
                }
            });
        }
    </script>
</head>

<body class='easyui-layout' fit='true' border="0">
    <div region="south" style='overflow:hidden; padding:10px;text-align:right;white-space:nowrap;' border="0">	
    <s:if test="${view != 'view'}" >
          <a href='javascript:void(0)' id='saveTaskGroud' onclick="saveTaskGroudBtn()" class="easyui-linkbutton" data-options="iconCls:'icon-save'">保存</a>
    </s:if>
    </div>
    <div region="center" style='overflow:hidden;' border="0">
        <div id='taskTreeId'></div>
    </div>
    <s:hidden name="project_id" />
    <s:hidden id="group_id" name="group_id" />
</body>

</html>