<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE HTML>
<html>
<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<title>项目进度填报（非在线）</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
	<link href="${contextPath}/resources/css/common.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
	<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
	<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
	<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
	<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
	<script type="text/javascript" src="${contextPath}/pages/tlInteractive/tlInteractiveCommon.js"></script>
</head>
<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout">

<div id="dlgSearch" class="searchWindow">
	<div class="search_head">
		<s:form action="listMyOfflineProject" namespace="/project" method="post" name="myform" id="myform">
			<input type="hidden" name="condition" value="yes" reload="false"/>
			<table id="searchTable" cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
				<tr>
					<td class="EditHead" style="width:20%">
						项目编号
					</td>
					<td class="editTd" style="width:30%">
						<s:textfield cssClass="noborder" name="crudObject.project_code"  cssStyle="width:80%"/>
					</td>
					<td class="EditHead" style="width:15%">
						项目名称
					</td>
					<td class="editTd" style="width:35%">
						<s:textfield cssClass="noborder" name="crudObject.project_name" cssStyle="width:80%" maxlength="50"/>
					</td>
				</tr>
				<tr class="listtablehead" height="23">
					<td class="EditHead">
						项目年度
					</td>
					<td class="editTd">
						<select editable="false" id="w_plan_year" class="easyui-combobox" name="crudObject.pro_year" style="width:80%" >
							<option value="">请选择</option>
							<s:iterator value="@ais.project.ProjectUtil@getIncrementSearchYearList(10,9)" id="entry">
								<option value="<s:property value="key"/>"><s:property value="value"/></option>
							</s:iterator>
						</select>
					</td>
					<td class="EditHead">
						项目类别
					</td>
					<td class="editTd">
						<s:buttonText name="crudObject.pro_type_name" cssClass="noborder"
									  hiddenName="crudObject.pro_type" cssStyle="width:80%"
									  doubleOnclick="getItem('/pages/basic/code_name_tree_select.jsp','&nbsp;请选择项目类别',500,400)"
									  doubleSrc="/resources/images/s_search.gif"
									  doubleCssStyle="cursor:hand;border:0" readonly="true"
									  doubleDisabled="false" />
						<input type="hidden" name="crudObject.pro_type_child" value="">
					</td>
				</tr>
<%--				<tr>
					<td class="EditHead" nowrap="nowrap">
						某阶段状态
					</td>
					<td class="editTd">
						<select editable="false" id="searchStage" data-options="panelHeight:'auto'" class="easyui-combobox" name="crudObject.searchStage" style="width:39%" >
							<option value="">&nbsp;</option>
							<s:iterator value="@ais.project.ProjectUtil@getProjectAllStageFieldName()" id="entry">
								<option value="<s:property value="key"/>"><s:property value="value"/></option>
							</s:iterator>
						</select>
						<select  editable="false" id="stageStatus" data-options="panelHeight:'auto'" class="easyui-combobox" name="crudObject.stageStatus" style="width:39%" >
							<option value="">&nbsp;</option>
							<s:iterator value="#@java.util.LinkedHashMap@{'null':'未执行','0':'进行中','1':'已完成'}" id="entry">
								<option value="<s:property value="key"/>"><s:property value="value"/></option>
							</s:iterator>
						</select>
					</td>
					<td class="EditHead">
						项目年度
					</td>
					<td class="editTd">
						<select editable="false" id="w_plan_year" class="easyui-combobox" name="crudObject.pro_year" style="width:80%" >
							<option value="">请选择</option>
							<s:iterator value="@ais.project.ProjectUtil@getIncrementSearchYearList(10,9)" id="entry">
								<option value="<s:property value="key"/>"><s:property value="value"/></option>
							</s:iterator>
						</select>
					</td>
				</tr>--%>
			</table>
		</s:form>
	</div>
	<div class="serch_foot">
		<div class="search_btn">
			列表默认当年，其他年度请使用查询&nbsp;&nbsp;
			<a class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>&nbsp;
			<a class="easyui-linkbutton" data-options="iconCls:'icon-reload'" onclick="restal()">重置</a>&nbsp;
			<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="doCancel()">取消</a>
		</div>
	</div>
</div>
<div region="center">
	<table id="projectList"></table>
</div>
<div id="subwindow" class="easyui-window" title="" iconCls="icon-search" style="width:500px;height:500px;padding:5px;" closed="true">
	<div class="easyui-layout" fit="true">
		<div region="center" border="false" style="padding:10px;background:#fff;border:1px solid #ccc;">
			<iframe id="item_ifr" name="item_ifr" src="" frameborder="0" width="100%" height="100%" scrolling="auto" ></iframe>
		</div>
		<div region="south" border="false" style="text-align:right;padding:5px 0;">
			<div style="display: inline;" align="right">
				<a class="easyui-linkbutton" iconCls="icon-ok" href="javascript:void(0)" onclick="saveF()">确定</a>
				<a class="easyui-linkbutton" iconCls="icon-remove" href="javascript:void(0)" onclick="cleanF()">清空</a>
				<a class="easyui-linkbutton" iconCls="icon-cancel" href="javascript:void(0)" onclick="closeWin()">关闭</a>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
    /*
    * 查询
    */
    function doSearch(){
/*        document.getElementById('myform').action = "${contextPath}/project/listMyOfflineProject.action";
        $('#projectList').datagrid({
            queryParams:form2Json('myform')
        });
        $('#dlgSearch').dialog('close');*/

		datagrid.datagrid('options').queryParams = form2Json('myform');
		datagrid.datagrid('reload');
		$('#dlgSearch').dialog('close');
    }
    /*
    * 取消
    */
    function doCancel(){
        $('#dlgSearch').dialog('close');
    }
    /**
     重置
     */
    function restal(){
        resetForm('myform');
        //window.location.href='${contextPath}/project/listMyProject.action';
    }

    /*
    *  打开或关闭查询面板
    */
    function triggerSearchTable(){
        var isDisplay = document.getElementById('searchTable').style.display;
        if(isDisplay==''){
            document.getElementById('searchTable').style.display='none';
        }else{
            document.getElementById('searchTable').style.display='';
        }
    }

    var datagrid;
    $(function (){
        showWin('dlgSearch');
        if('${empty crudObject.pro_year}'=='true'){
            var d = new Date();
            $('#w_plan_year').combo('setValue',d.getFullYear());
            $('#w_plan_year').combo('setText',d.getFullYear());
        }
        // 初始化生成表格
        datagrid=$('#projectList').datagrid({
            url : "<%=request.getContextPath()%>/project/listMyOfflineProject.action?querySource=grid",
            method:'post',
            showFooter:true,
            rownumbers:true,
            pagination:true,
            striped:true,
            autoRowHeight:false,
            fit:true,
            pageSize: 20,
            border:false,
            singleSelect:true,
            remoteSort: false,
            toolbar:[
				{
                	id:'search',
                	text:'查询',
                	iconCls:'icon-search',
                	handler:function(){
                    	searchWindShow('dlgSearch');
                	}
            	},'-',
                {
                    id:'add',
                    text:'进度填报',
                    iconCls:'icon-edit',
                    handler:function(){
                        addProcess();
                    }
                },'-',helpBtn
            ],
			onLoadSuccess:function(){
				initHelpBtn();
			},
            frozenColumns:[[
                {field:'status',
                 title:'状态',
                 width:'5%',
                 halign:'center',
                 sortable:true,
                 align:'center'
                },               
				{field:'project_name',
					title:'项目名称',
					width:'20%',
					halign:'center',
					align:'left',
					sortable:true,
					formatter:function(value, rowData, rowIndex){
                        return '<a href=\"javascript:void(0)\" onclick=\"planName(\''+rowData.project_name+'\',\''+rowData.plan_form_id+'\',\''+rowData.formId+'\',\''+rowData.processCode+'\');\">'+rowData.project_name+'</a>';
					}
				}
            ]],
            columns:[[

                {field:'processName',
                    title:'项目阶段',
                    width:'5%',
                    halign:'center',
                    sortable:true,
                    align:'center'
                },
                {field:'remarks',
                    title:'项目进度说明',
                    width:'20%',
                    halign:'center',
                    align:'center',
                    sortable:true
                },
				{field:'pro_year',
					title:'项目年度',
					width:'5%',
					halign:'center',
					align:'center',
					sortable:true
				},
				{field:'project_code',
					title:'项目编号',
					width:'10%',
					halign:'center',
					align:'center',
					sortable:true
				},
				{field:'audit_dept_name',
					title:'审计单位',
					width:'10%',
					halign:'center',
					align:'center',
					sortable:true
				},
				{field:'audit_object_name',
					title:'被审计单位',
					width:'10%',
					halign:'center',
					align:'center',
					sortable:true
				},
				{field:'pro_type_name',
					title:'项目类别',
					width:'10%',
					halign:'center',
					align:'center',
					sortable:true,
					formatter:function(value,rowData,rowIndex){
						if(rowData.pro_type_child_name != null && rowData.pro_type_child_name != '') {
							return rowData.pro_type_child_name;
						} else {
							return value;
						}
					}
				},
				{field:'zz',
					title:'组长',
					width:'5%',
					halign:'center',
					align:'center',
					sortable:true
				},
				{field:'zs',
					title:'主审',
					width:'5%',
					halign:'center',
					align:'center',
					sortable:true
				},
				{field:'createTime',
					title:'最近填报时间',
					width:'10%',
					halign:'center',
					align:'center',
					sortable:true
				}
            ]]
        });
        //单元格tooltip提示
        $('#projectList').datagrid('doCellTip', {
            position : 'bottom',
            maxWidth : '1000px',
			onlyShowInterrupt:true,
            tipStyler : {
                'backgroundColor' : '#EFF5FF',
                borderColor : '#95B8E7',
                boxShadow : '1px 1px 3px #292929'
            }
        });

    });
    function getItem(url,title,width,height){
        $('#item_ifr').attr('src',url);
        $('#subwindow').window({
            title: title,
            width: width,
            height:height,
            modal: true,
            shadow: true,
            closed: false,
            collapsible:false,
            maximizable:false,
            minimizable:false
        });
    }
    function saveF(){
        var ayy = $('#item_ifr')[0].contentWindow.saveF();
        var ay = ayy[0].split(',');
        if(ay.length == 1){
            document.all('crudObject.pro_type').value=ayy[0];
        }else if(ay.length == 2){
            document.all('crudObject.pro_type_child').value=ay[0];
            document.all('crudObject.pro_type').value=ay[1];
        }
        document.all('crudObject.pro_type_name').value=ayy[1];
        closeWin();
    }
    function cleanF(){
        document.all('crudObject.pro_type').value='';
        document.all('crudObject.pro_type_name').value='';
        document.all('crudObject.pro_type_child').value='';
        closeWin();
    }
    function closeWin(){
        $('#subwindow').window('close');
    }

    //项目进度填报
    function addProcess(){
		var finishCode = "<s:property value="@ais.project.ProjectContant@PROCESS_FINISH" />";
		var row = $('#projectList').datagrid('getSelected');
		if(row!=null){
			var projectId = row.formId;
			var processCode = row.processCode;
			if (processCode == null){
				processCode = '';
			}
			var view = "";
			if (processCode == finishCode){
				view = "view";
			}
			var url = "${contextPath}/project/process/edit.action?plan_form_id=" + projectId + "&processCode=" + processCode + "&finishCode=" + finishCode + "&view=" + view;
			aud$openNewTab('项目进度填报', url, true);
		}else{
			showMessage1('请选择项目！');
		}
    }

    function planName(title, id, startId, processCode){
        var viewUrl = "${contextPath}/plan/detail/viewProcess.action?projectId=" + id + "&startId=" + startId + "&processCode=" + processCode;
		aud$openNewTab(title, viewUrl, true);
    }
</script>
</body>
</html>
