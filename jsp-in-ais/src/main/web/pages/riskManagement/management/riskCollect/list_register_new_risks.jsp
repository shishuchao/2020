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

$(function(){
	var collectTaskId = '${collectTaskId}';
	var collectTaskName = '${collectTaskName}';
	var collectTaskYear = '${collectTaskYear}';
	var templateId = '${templateId}';
	
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
        whereSql: 'operateType=\'0\' and collectTaskId=\''+ collectTaskId +'\'',
        /* order:'asc',
        sort:'taskCode', */
        gridJson:{    
            checkOnSelect:false,
            selectOnCheck:false,
            singleSelect:false,
            onLoadSuccess:frloadClose,
            toolbar:[{
            	text:'新增',
            	iconCls:'icon-add',
            	handler:function () {
							var editUrl = '${contextPath}/riskManagement/management/riskRegister/editNewRisk.action?templateId='
										+ templateId
										+ '&collectTaskId='
										+ collectTaskId
										+ '&collectTaskName='
										+ collectTaskName
										+ '&collectTaskYear='
										+ collectTaskYear;
								aud$openNewTab('新增风险', editUrl);
							}
						} ],
						columns : [ [
								{
									field : 'taskId',
									title : '选择',
									checkbox : true,
									align : 'center',
									show : 'false'
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
									width : bodyW * 0.14 + 'px',
									align : 'center',
									sortable : true,
									show : 'true',
									oper : 'like'
								},
								{
									field : 'taskPname',
									title : '风险分类',
									width : bodyW * 0.14 + 'px',
									align : 'center',
									sortable : true,
									show : 'true',
									oper : 'like'
								},
								{
									field : 'influenceDescription',
									title : '影响描述',
									width : bodyW * 0.14 + 'px',
									align : 'center',
									sortable : true,
									type : 'custom'
								},
								{
									field : 'affiliatedDeptName',
									width : bodyW * 0.14 + 'px',
									title : '所属单位',
									align : 'center',
									sortable : true,
									show : 'true',
									oper : 'eq'
								},
								{
									field : 'majorDutyDeptName',
									width : bodyW * 0.14 + 'px',
									title : '主责部门',
									align : 'center',
									sortable : true,
									show : 'true',
									oper : 'eq'
								},
								{
									field : 'operate',
									width : bodyW * 0.14 + 'px',
									title : '操作',
									align : 'center',
									sortable : false,
									show : 'false',
									oper : 'eq',
									formatter : function(value, rowData,
											rowIndex) {
										var url = '${contextPath}/riskManagement/management/riskRegister/editNewRisk.action?templateId='
												+ templateId
												+ '&collectTaskId='
												+ collectTaskId
												+ '&taskId='
												+ rowData.formId;
										return '<a href=\'#\' onclick="edit(\''
												+ url + '\')">修改</a>';
									}
								} ] ],
					}
				});
		g1.batchSetBtn([ {
			'index' : 1,
			'display' : true
		}, {
			'index' : 2,
			'display' : true
		}, {
			'index' : 3,
			'display' : false
		}, {
			'index' : 4,
			'display' : false
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
	});

	function edit(url) {
		aud$openNewTab('新增风险-修改', url);
	}
</script>
</head>
<body>
    <div id="container" class='easyui-layout' fit='true'>	
        <div region="center">   	 	
            <table id='sDTable'></table>
        </div>
    </div> 
   <!-- ajax请求前后提示 -->
   <jsp:include flush="true" page="/pages/frReportFlow/ajaxloading.jsp" />
</body>
</html>
