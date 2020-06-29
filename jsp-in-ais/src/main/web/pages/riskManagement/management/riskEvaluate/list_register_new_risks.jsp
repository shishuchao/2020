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
	//var collectTaskId = '${collectTaskId}';
	//var collectTaskName = '${collectTaskName}';
	//var collectTaskYear = '${collectTaskYear}';
	//var templateId = '${templateId}';
	
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
        //whereSql: 'operateType=\'0\' and collectTaskId=\''+ collectTaskId +'\'',
        whereSql: 'status=\'1\'',
        /* order:'asc',
        sort:'taskCode', */
        gridJson:{    
            checkOnSelect:false,
            selectOnCheck:false,
            singleSelect:false,
            onLoadSuccess:frloadClose,
            toolbar:[{
						 text:'保存',
						 iconCls:'icon-save',
						 handler:function() {
							 saveRiskWait();
						 }
			 		 }
                     ],
						columns : [ [
								{
									field : 'formId',
									title : '选择',
									checkbox : true,
									align : 'center',
									show : 'false'
								},
								{
									field : 'taskName',
									title : '风险事项',
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
									field : 'influenceDescription',
									title : '影响描述',
									width : bodyW * 0.14 + 'px',
									align : 'center',
									sortable : true,
									type : 'custom'
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
									field : 'operateType',
									width : bodyW * 0.12 + 'px',
									title : '类型',
									align : 'center',
									sortable : true,
									show : 'false',
									formatter:function(value,rowData,rowIndex){
										if(value == '0')
											return '新增';
										else if(value == '1')
											return '调整';
										else
											return '重大风险上报';
									}
								}] ],
					}
				});
		g1.batchSetBtn([ {
			'index' : 1,
			'display' : true
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
	
	// 保存风险到待评估风险表
	function saveRiskWait(){
		
		 var parentTabId = '${parentTabId}';
	 	var curTabId = aud$getActiveTabId();
		var rows = $('#sDTable').datagrid('getChecked');
	    if (rows && rows.length > 0){
	    	top.$.messager.confirm('提示信息','确定选择这些风险事项吗？',function(isSelected){
	    		if(isSelected){
	    			var riskIdArr = [];
	    			var riskevaluate_id = $('#riskevaluate_id').val();
	                $.each(rows, function(i, row){
	                	riskIdArr.push(row.formId);
	                });
	                $.ajax({
	                    dataType:'json',
	                    url : "<%=request.getContextPath()%>/riskManagement/management/riskEvaluate/batchSaveRiskWaitNew.action",
	                    data: {ids:riskIdArr.join(","),riskevaluate_id:riskevaluate_id},
	                    type: "post",
	                    success: function(data){
	                        showMessage1(data.msg);	
							var frameWin = aud$getTabIframByTabId(parentTabId);
							var winIframe = frameWin.$('#gridRisk').get(0).contentWindow;
							winIframe.waitTable.refresh();
							aud$closeTab(curTabId, parentTabId);					
	                    },
	                    error:function(data){
	                        showMessage1('请求失败,请检查网络是否通畅或者与管理员联系！');
	                    }
	                });
	    		}
	    	});
	    }else{
	        showMessage1('请选择要添加的记录！');
	    }
	}

</script>
</head>
<body>
    <div id="container" class='easyui-layout' fit='true'>	
        <div region="center">   	 	
            <table id='sDTable'></table>
        </div>
    </div> 
    <s:hidden id="riskevaluate_id" value="${riskevaluate_id}"></s:hidden>
   <!-- ajax请求前后提示 -->
   <jsp:include flush="true" page="/pages/frReportFlow/ajaxloading.jsp" />
</body>
</html>
