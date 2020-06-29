<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE HTML>
<html>
<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<title>简易流程-项目完成</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
	<link href="${contextPath}/resources/css/common.css" rel="stylesheet" type="text/css" />
	<link href="${contextPath}/index/assets/global/plugins/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
</head>
<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout" fit="true">
	<div region="north" style="height: 105px;" title="查询条件">
		<s:form id="searchForm" name="searchForm" action="projectOverallView" namespace="/project" method="post">
			<table id="planTable" cellpadding=0 cellspacing=0 border=0 class="ListTable" align="center" style="width: 98%">
				<tr>
					<td class="EditHead" style="width:15%;">项目名称</td>
					<td class="editTd" style="width:35%;"><input type="text" name="projectName" maxlength="100" class="noborder" value="${projectName}"/></td>
					<td class="EditHead" nowrap> 计划年度</td>
					<td class="editTd">
						<select id="workPlanYear" class="easyui-combobox" name="year" style="width:150px;" data-options="panelHeight:'auto',editable:false">
							<option value="">&nbsp;</option>
							<s:iterator value="@ais.project.ProjectUtil@getIncrementSearchYearList(10,5)">
								<option value="<s:property value="key"/>"><s:property value="value"/></option>
							</s:iterator>
						</select>
					</td>
				</tr>
				<tr>
					<%--<td class="EditHead" style="width:15%">
						审计单位
					</td>
					<td class="editTd" style="width:35%">
						<s:buttonText2 id="audit_dept_name" hiddenId="auditDept" cssClass="noborder"
									   name="audit_dept_name"
									   hiddenName="auditDept"
									   doubleOnclick="showSysTree(this,
								{ url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action',
									 title:'请选择审计单位',
									 param:{
									   'p_item':1,
									   'orgtype':1
									 },
									  defaultDeptId:'${user.fdepid}'
								})"
								doubleSrc="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png"
								doubleCssStyle="cursor:pointer;border:0"
								readonly="true"
								title="审计单位" maxlength="100"/>
					</td>--%>
					<td class="EditHead" style="width:15%;">关键字(空格分隔)</td>
					<td class="editTd" colspan="3">
						<input type="text" name="keyword" maxlength="200" style="width: 70%;" class="noborder" value="${keyword}" placeholder="支持项目名称，底稿名称，报告、底稿附件名称，审计单位，被审计单位，问题标题"/>
						<span style="float:right;">
							<a class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>&nbsp;
							<a class="easyui-linkbutton" data-options="iconCls:'icon-reload'" onclick="restal()">重置</a>
						</span>
					</td>
				</tr>
			</table>
		</s:form>
	</div>
	<div region="west" style="width: 240px;" title="展示形式" data-options="split:true">
		<ul id="tree"></ul>
	</div>
	<div region="center">
		<div class="easyui-tabs" id="tabs" fit="true">
			<div title="审计报告及附件">
				<table style="width: 100%;" id="reportTable"></table>
			</div>
			<div title="审计底稿">
				<table style="width: 100%;" id="manuTable"></table>
			</div>
			<div title="审计问题">
				<table style="width: 100%;" id="problemTable"></table>
			</div>
		</div>
	</div>
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/jquery-fileUpload.js"></script>
	<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
	<script type="text/javascript" src="${contextPath}/pages/tlInteractive/tlInteractiveCommon.js"></script>
	<script type="text/javascript">
        /*
         * 查询
        */
        function doSearch(){
            $('#searchForm').submit();
        }
        /**
         重置
         */
        function restal(){
            resetForm('searchForm');
            //doSearch();
        }
        function initFileUpload(componentId){
            $('#'+componentId).fileUpload({
                fileGuid:$('#'+componentId).prop('fileGuid'),
                echoType:2,
                isDel:false,
                isEdit:false,
                isAdd:false
            });
        }
        function fetchReport(projectId,index,title){
            var eleId = 'reportTable'+index;
            $('#'+eleId).datagrid({
                url:'${contextPath}/project/projectOverallFruits.action?projectId='+projectId+'&queryType=report&keyword=${keyword}',
                method:'post',
                showFooter:false,
                title:title,
                rownumbers:true,
                pagination:false,
                striped:false,
                nowrap:false,
                autoRowHeight:false,
				fit:title != ''?false:true,
                fitColumns:true,
                border:false,
                columns:[[
                    {field:'nodeName',
                        title:'文件类型',
                        width:'10%',
                        halign:'center',
                        align:'left'},
                    {field:'fileName',
                        title:'文件名称',
                        sortable:false,
                        halign:'center',
                        align:'left',
                        width:'15%'
                    },
                    {field:'createDate',
                        title:'创建日期',
                        width:'12%',
                        halign:'center',
                        align:'center',
                        sortable:false
                    },
                    {field:'creator',
                        title:'创建人',
                        halign:'center',
                        align:'left',
                        width:'8%',
                        sortable:false
                    },
                    {field:'updated',
                        title:'最后编辑日期',
                        halign:'center',
                        align:'center',
                        width:'11%',
                        sortable:false
                    },
                    {field:'updator',
                        title:'最后编辑人',
                        halign:'center',
                        align:'left',
                        width:'8%',
                        sortable:false
                    },
                    {field:'operate',
                        title:'操作',
                        halign:'center',
                        align:'left',
                        width:'10%',
                        sortable:false,
                        formatter:function(value,row,index){
                            return '<a href="javascript:;" onclick="window.open(\'${contextPath}/pages/commons/file/iweb.jsp?fileId='+row.fileId+'&r=t\',\'\',\'height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no\')">查看</a>' +
                                '&nbsp;&nbsp;<a href="${contextPath}/commons/file/downloadFile.action?fileId='+row.fileId+'">下载</a>';
                        }
                    },
                    {field:'attachments',
                        title:'附件',
                        halign:'center',
                        align:'center',
                        width:'20%',
                        sortable:false,
                        formatter:function(value,row,idx){
                            setTimeout(function () {
                                initFileUpload('report_'+index+idx);
                            },100);
                            return '<div id="report_'+index+idx+'" fileGuid="'+row.attachments+'"></div>';
                        }
                    }
                ]]
            });
		}

		function fetchManu(projectId,index,title){
            var eleId = 'manuTable'+index;
            $('#'+eleId).datagrid({
                title:title,
                url:'${contextPath}/project/projectOverallFruits.action?projectId='+projectId+'&queryType=manu&keyword=${keyword}',
                method:'post',
                showFooter:false,
                rownumbers:true,
                pagination:true,
                striped:false,
                nowrap:false,
				fit:title != ''?false:true,
                autoRowHeight:false,
                fitColumns:true,
                border:false,
                columns:[[
                    {field:'ms_name',
                        title:'底稿名称',
                        width:'20%',
                        halign:'center',
                        align:'left',
                        formatter:function(value,rowData,rowIndex){
                            return '<a href=\"javascript:void(0)\" onclick=\"aud$openNewTab(\''+rowData.ms_name+'\',\'${contextPath}/operate/manu/view.action?view=view&projectview=view&pageview=pageview&crudId='+rowData.formId+'&project_id='+rowData.project_id+'\',true);\">'+rowData.ms_name+'</a>';
                        }
                    },
                    {field:'ms_date',
                        title:'创建日期',
                        sortable:false,
                        halign:'center',
                        width:'15%',
                        align:'left',
                        formatter:function(value,row,index){
                            return value == null?'':value.substring(0,10);
                        }
                    },
                    {field:'ms_author_name',
                        title:'创建人',
                        width:'10%',
                        halign:'center',
                        align:'center',
                        sortable:false
                    },
                    {field:'attachments',
                        title:'底稿附件',
                        halign:'center',
                        align:'center',
                        width:'40%',
                        sortable:false,
                        formatter:function(value,row,idx){
                            setTimeout(function () {
                                initFileUpload('manu_'+index+idx);
                            },100);
                            return '<div id="manu_'+index+idx+'" fileGuid="'+row.file_id+'"></div>';
                        }
                    }
                ]]
            });
		}
		function fetchProblem(projectId,index,title){
            var eleId = 'problemTable'+index;
            $('#'+eleId).datagrid({
                title:title,
                url:'${contextPath}/project/projectOverallFruits.action?projectId='+projectId+'&queryType=problem&keyword=${keyword}',
                method:'post',
                showFooter:false,
                rownumbers:true,
                pagination:true,
                striped:false,
                nowrap:false,
                autoRowHeight:false,
                fit:title != ''?false:true,
                fitColumns:false,
                border:false,
                frozenColumns:[[
                    {field:'audit_con',title:'问题标题',width:200,halign:'center',align:'left', sortable:true,
                        formatter:function(value,rowData,rowIndex){
                            return '<a href=\"javascript:void(0)\" onclick=\"aud$openNewTab(\''+rowData.audit_con+'\',\'${contextPath}/proledger/problem/viewSimplifiedProblem.action?problemId='+rowData.id+'\',true);\">'+rowData.audit_con+'</a>';
                        }},
                    {field:'serial_num',title:'问题编号',align:'center', sortable:true,width:150}
                ]],
                columns:[[
                    {field:'problem_name',title:'问题点', width:250,halign:'center',align:'left',sortable:true},
                    {field:'problem_money',title:'发生金额',width:100,halign:'center',align:'right',sortable:true},
                    {field:'problemCount',title:'发生数量',width:100,sortable:true,halign:'center',align:'right'},
                    {field:'creater_name',title:'问题发现人', width:100,halign:'center',align:'left',sortable:true},
                    {field:'isInReport',title:'是否入报告',align:'center',sortable:true,
                        formatter:function(value,rowData,rowIndex){
                            if(value == ''){
                                return '否';
                            }
                            return value;
                        }
                    },{field:'isNotMend',title:'是否整改',align:'center',sortable:true,
                        formatter:function(value,rowData,rowIndex){
                            if(value == ''){
                                return '否';
                            }
                            return value;
                        }
                    },
                    {field:'remarks', title:'备注说明',width:100,halign:'center',align:'left',sortable:true}
                ]]
            });
		}

        /**
		 *
         * @param projectId
         * @param isDoc
         */
		function doFetch(projectId,isDoc){
            /**
			 * 如果为按文档类型展示，projectId为展示类型标题，用于判断
             */
            if(isDoc){
                var projectIdJson = ${projectIdJson};
                var projectNameJson = ${projectNameJson};
                var count = projectIdJson?projectIdJson.length:0;
                var tab = $('#tabs').tabs('getTab',projectId);
                $('#tabs').tabs('enableTab',projectId);
                $('#tabs').tabs('select',projectId);
                if(projectId == '审计报告及附件') {
                    $('#tabs').tabs('disableTab','审计底稿');
                    $('#tabs').tabs('disableTab','审计问题');

                }else if(projectId == '审计底稿'){
                    $('#tabs').tabs('disableTab','审计报告及附件');
                    $('#tabs').tabs('disableTab','审计问题');
                }else if(projectId == '审计问题'){
                    $('#tabs').tabs('disableTab','审计报告及附件');
                    $('#tabs').tabs('disableTab','审计底稿');
                }

                var content = [];
                for(var m = 0;m<count;m++) {
                    if(projectId == '审计报告及附件') {
                        content.push('<table style="width: 100%;" id="reportTable'+m+'"></table>');
                    }else if(projectId == '审计底稿'){
                        content.push('<table style="width: 100%;" id="manuTable'+m+'"></table>');
                    }else if(projectId == '审计问题'){
                        content.push('<table style="width: 100%;" id="problemTable'+m+'"></table>');
                    }
                }
                $('#tabs').tabs('update', {
                    tab: tab,
                    options: {
                        content: content.join('')
                    }
                });

                for(var m = 0;m<count;m++) {
                    if(projectId == '审计报告及附件') {
                        fetchReport(projectIdJson[m], m,projectNameJson[m]);
                    }else if(projectId == '审计底稿'){
                        fetchManu(projectIdJson[m], m,projectNameJson[m]);
                    }else if(projectId == '审计问题'){
                        fetchProblem(projectIdJson[m], m,projectNameJson[m]);
                    }
                }
                setTimeout(function () {
                    for(var m = 0;m<count;m++) {
                        if(projectId == '审计报告及附件') {
                            $('#reportTable'+m).datagrid('resize');
                        }else if(projectId == '审计底稿'){
                            $('#manuTable'+m).datagrid('resize');
                        }else if(projectId == '审计问题'){
                            $('#problemTable'+m).datagrid('resize');
                        }
                    }
                }, 500);


			}else{
                $('#tabs').tabs('enableTab','审计报告及附件');
                $('#tabs').tabs('enableTab','审计底稿');
                $('#tabs').tabs('enableTab','审计问题');
                fetchReport(projectId,'','');
                fetchManu(projectId,'','');
                fetchProblem(projectId,'','');
                setTimeout(function () {
                    $('#reportTable').datagrid('resize');
                    $('#manuTable').datagrid('resize');
                    $('#problemTable').datagrid('resize');
                }, 300);
			}
		}
        $(function(){

            if('${year}' != ''){
                $('#workPlanYear').combobox('setValue','${year}');
                $('#workPlanYear').combobox('setText','${year}');
            }
            if('${auditDept}' != ''){
                $('#auditDept').val('${auditDept}');
                $('#audit_dept_name').val('${audit_dept_name}');
            }

            $('#tree').tree({
				data:${treeNodes},
                onSelect:function(node){
                    var parent = $('#tree').tree('getParent',node.target);
                    if(node.leaf == '1'){
                        if(parent.text == '按文档类型'){
                            doFetch(node.text,true);
                        }else{
                            var projectId = node.id;
                            if(node.id&&node.id.indexOf('_') > -1){
                                projectId = node.id.split('_')[1];
                            }
                            doFetch(projectId,false);
                        }
                    }
                },
                onLoadSuccess:function(node,data){
                    $('#tree').tree("expandAll");
                    $("#tree").find("div[id=_easyui_tree_3]").addClass("tree-node-selected");   //设置第一个节点高亮
                    var n = $("#tree").tree("getSelected");
                    if(n!=null){
                        $("#tree").tree("select",n.target);
                    }
                }

            });
		});
	</script>
</body>
</html>
