<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<jsp:directive.page import="ais.framework.util.UUID"/>

<html>
<title>新增风险列表</title>
<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
	<link href="<%=request.getContextPath()%>/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
	<link href="<%=request.getContextPath()%>/resources/css/common.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/createOrgTree.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>  
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/common.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/pages/tlInteractive/tlInteractiveCommon.js"></script> 
<script type="text/javascript">
var editFlag = undefined;
var g1;
var collectTaskId = '${collectTaskId}';
var collectTaskName = '${collectTaskName}';
var collectTaskYear = '${collectTaskYear}';
var templateId = '${templateId}';
$(function(){
	var bodyW = $('body').width();    
    var bodyH = $('body').height(); 
 
    frloadOpen();
    g1 = new createQDatagrid({
        // 表格dom对象，必填
        gridObject:$('#sDTable')[0],
        // 要进行检索的表对象(hibernate bean)名称， 进行拼接hql时使用; 必填
        boName:'RiskTask',
        // 对象主键,删除数据时使用-默认为“id”；必填
        pkName:'formId',
        whereSql: 'operateType=\'1\' and collectTaskId=\''+ collectTaskId +'\'',
        /* order:'asc',
        sort:'taskCode', */
        gridJson:{    
            checkOnSelect:false,
            selectOnCheck:false,
            singleSelect:false,
            onLoadSuccess:frloadClose,
						columns : [ [
								{
									field : 'taskId',
									title : '选择',
									checkbox : true,
									align : 'center',
									show : 'false',
									hidden : true
								},
								{
									field : 'taskCode',
									title : '编号',
									width : bodyW * 0.1 + 'px',
									align : 'center',
									sortable : true,
									show : 'true',
									oper : 'eq'
								},
								{
									field : 'riskDescription',
									title : '风险描述',
									width : bodyW * 0.12 + 'px',
									align : 'center',
									sortable : true,
									show : 'true',
									oper : 'like'
								},
								{
									field : 'taskPname',
									title : '风险分类',
									width : bodyW * 0.12 + 'px',
									align : 'center',
									sortable : true,
									show : 'true',
									oper : 'like'
								},
								{
									field : 'influenceDescription',
									title : '影响描述',
									width : bodyW * 0.11 + 'px',
									align : 'center',
									sortable : true,
									type : 'custom'
								},
								{
									field : 'affiliatedDeptName',
									width : bodyW * 0.125 + 'px',
									title : '所属单位',
									align : 'center',
									sortable : true,
									show : 'true',
									oper : 'eq'
								},
								{
									field : 'majorDutyDeptName',
									width : bodyW * 0.125 + 'px',
									title : '主责部门',
									align : 'center',
									sortable : true,
									show : 'true',
									oper : 'eq'
								},
								{
									field : 'adjustIllustrate',
									width : bodyW * 0.125 + 'px',
									title : '调整说明',
									align : 'center',
									sortable : true,
									show : 'true',
									oper : 'eq'
								},
								{
									field : 'operate',
									width : bodyW * 0.125 + 'px',
									title : '操作',
									align : 'center',
									sortable : false,
									show : 'false',
									oper : 'eq',
									formatter : function(value, rowData,
											rowIndex) {
											var url = '${contextPath}/riskManagement/management/riskRegister/editAdjustRisk.action?isView=Y&templateId='
												+ templateId
												+ '&collectTaskId='
												+ collectTaskId
												+ '&taskId='
												+ rowData.formId;
										return '<a href=\'#\' onclick="edit(\''
												+ url + '\')">查看</a>';
									}
								} ] ],
					}
				});
		g1.batchSetBtn([ {
			'index' : 1,
			'display' : false
		}, {
			'index' : 2,
			'display' : false
		}, {
			'index' : 3,
			'display' : false
		}, {
			'index' : 4,
			'display' : true
		}, {
			'index' : 5,
			'display' : false
		}, {
			'index' : 6,
			'display' : false
		}, {
			'index' : 7,
			'display' : false
		}, {
			'index' : 8,
			'display' : false
		} ]);
		
		$('#myDiv').window({
			title:'风险树',
			width:800,
			height:150,
			closed:true
		});
	});

	function edit(url) {
		aud$openNewTab('调整风险-查看', url, true);
	}
	
	 function getTaskPid(obj) {
		 showSysTree(obj,
					{ reeTabTitle1:'风险树',
					  cascadeCheck:false,
					  dnd:true,
					  noMsg:true,
					  queryBox:false,
					  onlyLeafClick:true,
	               	  param:{
	                  	   'rootParentId':'-1',
	                  	   'whereHql':'template_Id = \'${templateId}\'',
	                       'beanName':'RiskTaskTemplateTree',
	                       'treeId'  :'taskId',
						   'treeText':'taskName',
						   'treeParentId':'taskPid',
						   'treeOrder':'taskCode',
						   'treeAtrributes':'template_type'
	                  }                                
		});
	 }
	 
	 function adjust() {
		 var taskPid = $('#taskPid').val();
		 if(taskPid != '') {
			 var editUrl = '${contextPath}/riskManagement/management/riskRegister/editAdjustRisk.action?templateId='
					+ templateId
					+ '&collectTaskId='
					+ collectTaskId
					+ '&collectTaskName='
					+ collectTaskName
					+ '&collectTaskYear='
					+ collectTaskYear
					+ '&taskPid='
					+ taskPid;
			aud$openNewTab('调整风险', editUrl);
			$('#myDiv').window('close');
		 }else
			 showMessage1('请选择风险事项！');
	 }
	 
	 function closeWin(){
		 $('#myDiv').window('close');
	 }
</script>
</head>
<body>
    <div id="container" class='easyui-layout' fit='true'>	
        <div region="center">   	 	
            <table id='sDTable'></table>
        </div>
    </div> 
    
    <div id="myDiv">
    	<table cellpadding=1 cellspacing=1 border=0 class="ListTable">
    		<tr>
    			<td class="EditHead">
    				<font color="color">*</font>风险事项
    			</td>
    			<td class="editTd">
    				<s:buttonText2 id="taskPname" hiddenId="taskPid" cssClass="noborder editElement required"
							name="taskPname" 
							hiddenName="taskPid"
							doubleOnclick="getTaskPid(this)"
							doubleSrc="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png"
							doubleCssStyle="cursor:pointer;border:0"
							readonly="true"
							title="风险树" maxlength="100" cssStyle="width:96%"/>
    			</td>
    		</tr>
    	</table>
    	<div style="text-align:right;margin-top:10px;margin-bottom:10px;padding-right:18px;">
				<a class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="adjust();">确定</a>
				<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="closeWin();">关闭</a>
		</div>
    </div>
    
    
   <!-- ajax请求前后提示 -->
   <jsp:include flush="true" page="/pages/frReportFlow/ajaxloading.jsp" />
</body>
</html>
