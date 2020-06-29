<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<jsp:directive.page import="ais.framework.util.UUID"/>

<html>
<title>查看历次评价</title>
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
	var hmId = '${hmId}';
	var bodyW = $('body').width();    
    var bodyH = $('body').height(); 
    var parentTabId = '${parentTabId}';
    var curTabId = aud$getActiveTabId();
 
    frloadOpen();
    g1 = new createQDatagrid({
        // 表格dom对象，必填
        gridObject:$('#sDTable')[0],
        // 要进行检索的表对象(hibernate bean)名称， 进行拼接hql时使用; 必填
        boName:'ImpResultInfo',
        // 对象主键,删除数据时使用-默认为“id”；必填
        pkName:'id',
        whereSql: 'hmId=\''+ hmId +'\'',
        order:'desc',
        sort:'enterTime',
        winWidth:800,
        winHeight:250,
        gridJson:{    
            checkOnSelect:false,
            selectOnCheck:false,
            singleSelect:false,
            onLoadSuccess:frloadClose,
            /* toolbar:[{
			 text:'关闭',
			 iconCls:'icon-cancel',
			 handler:function() {
				 aud$closeTab(curTabId, parentTabId);
			 }
		 }], */
   			columns : [ [
	  						   {
									field : 'impStatusEvaluate',
									title : '执行状态评价',
									width : bodyW * 0.16 + 'px',
									align : 'center',
									sortable : true,
									oper : 'like'
								},
								{
									field : 'evaluateDes',
									title : '评价描述',
									width : bodyW * 0.16 + 'px',
									align : 'center',
									sortable : true,
									oper : 'like'
								},
								{
									field : 'evaluateDeptName',
									width : bodyW * 0.16 + 'px',
									title : '评价部门',
									align : 'center',
									sortable : true,
									oper : 'eq'
								},
								{
									field : 'evaluateManName',
									width : bodyW * 0.16 + 'px',
									title : '评价人',
									align : 'center',
									sortable : true,
									oper : 'eq'
								},
								{
									field : 'evaluateTime',
									width : bodyW * 0.16 + 'px',
									title : '评价时间',
									align : 'center',
									show : 'false'
								},
								{
									field : 'file_id02',
									title : '附件',
									width : bodyW * 0.16 + 'px',
									align : 'center',
									show : 'false',
									formatter:function(value,rowData,rowIndex) {
										var result = "";
										$.ajax({
											url:'${contextPath}/commons/file/getFileListByGuid.action?fileId=' + value,
											async:false,
											type:'POST',
											success:function(data){
												if(data.result == '1') {
													result = data.file;
												}
											}
										});
										return result;
									}
								}
								/* ,
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
										var url = '${contextPath}/riskManagement/management/riskCollect/editNewRisk.action?templateId='
												+ templateId
												+ '&collectTaskId='
												+ collectTaskId
												+ '&taskId='
												+ rowData.taskId;
										return '<a href=\'#\' onclick="edit(\''
												+ url + '\')">修改</a>';
									}
								} */ ] ],
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

 function fileDownload(fileId) {
	 window.location.href='${contextPath}/commons/file/downloadFile.action?fileId=' + fileId;
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
