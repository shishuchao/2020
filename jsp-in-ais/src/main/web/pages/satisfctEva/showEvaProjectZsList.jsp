<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<title>评价项目主审</title>
<script type="text/javascript" src="${contextPath}/easyui/boot.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/jquery-fileUpload.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
<script type="text/javascript" src="${contextPath}/pages/tlInteractive/tlInteractiveCommon.js"></script>
	<STYLE type="text/css">
		.datagrid-cell {
			height:25px;
		}
		.datagrid-cell-rownumber {
			height:25px;
		}
	</STYLE>
<script type="text/javascript">

$(function(){
	// 基础信息
	var busBaseUrl = "${contextPath}/satisfctEva/";
	var isView = "${view}" == true || "${view}" == "true" ? true : false;
	var tabTitle = isView ? "查看" : "编辑";
	var gridTableId = "busTable";
	// 是否主审评价得分查看
	var zsScoreView = "${zsScoreView}" == true || "${zsScoreView}" == "true" ? true : false;
	
	var cusToolbar = ['search','-','reload','-',helpBtn];
	var gridColums = [];
	var gridFrozenColumns= [];
	$.merge(gridColums, [
   		{field:'w_plan_code', title:"项目编码", exportTitle:'项目编码',
 			width:'15%',align:'left', halign:'center', sortable:true, oper:'like',
 			formatter:function(value,row,index){
 				return value ? "<label title='"+value+"'>"+value+"</label>" : "";
 			}
 		},
 		{field:'w_plan_name', title:"项目名称", width:'20%',align:'left', halign:'center', sortable:true, oper:'like',
 			formatter:function(value,row,index){
 				return value ? "<label title='"+value+"' style='color:blue;cursor:pointer;'>"+value+"</label>" : "";
 			}
 		},
 		{field:'pro_type_name', title:"项目类型", width:'130px',align:'center', halign:'center', sortable:true, oper:'like',
 			formatter:function(value,row,index){
 				return value ? "<label title='"+value+"'>"+value+"</label>" : "";
 			}
 		},
 		{field:'audit_dept_name', title:"审计单位", width:'160px',align:'left', halign:'center', sortable:true, oper:'like',
 			formatter:function(value,row,index){
 				return value ? "<label title='"+value+"'>"+value+"</label>" : "";
 			}
 		}              
	]);
    $.merge(gridColums, [

		{field:'audit_object_name', title:"被审计单位", width:'185px',align:'left', halign:'center', sortable:true, oper:'like',
			formatter:function(value,row,index){
				return value ? "<label title='"+value+"'>"+value+"</label>" : "";
			}
		},
		{field:'pro_auditleader_name', title:"项目主审", width:'100px',align:'center', halign:'center', sortable:true, oper:'like',
			formatter:function(value,row,index){
				return value ? "<label title='"+value+"'>"+value+"</label>" : "";
			}
		},
		{field:'operation', title:"操作", width:'95px',align:'center', halign:'center', sortable:true, show:'false',
			formatter:function(value,row,index){				
				var projectId = row['formId'];
				var btnText = "";
				var btnIcon = "";
				var winTitle = "";
				var evaAction = "";	
				if(zsScoreView){//主审得分查看
					btnText = "查看得分";
					btnIcon = "icon-view";
					winTitle = "评分结果查看";
					evaAction = "viewZsEvaScoreResultList";
				}else{
					// 计算主审个数
					var zsCount = row['pro_auditleader'].split(',').length;
					var isViewEva = isView || isAlreadyProjectEva(projectId, zsCount);
					btnText = isViewEva ? "查看" : "评价";
					btnIcon = isViewEva ? "icon-view" : "icon-edit";
					winTitle = isViewEva ? "评分结果查看" : "项目主审-满意度评价";
					evaAction = isViewEva ? "viewSatisfctEvaList" : "showSatisfctEvaList";
				}
				window.setTimeout(function(){
					$('#editItem_'+index).linkbutton({    
					    iconCls: btnIcon,
					    text:btnText
					}).bind('click', function(){
	 			        new aud$createTopDialog({
	 			            title:winTitle,
	 			            url  :busBaseUrl + evaAction + ".action?projectId="+projectId
	 			     	}).open();
					}); 
				},0)
				return "<span id='editItem_"+index+"' title='单击打开满意度"+btnText+"' style='border-width:0px;color:blue;cursor:pointer;'></span>";
			}
		}
	]);
    
    // 当前人员对指定项目是否已经进行了评价打分
    function isAlreadyProjectEva(projectId, zsCount){
    	var flag = false;
        $.ajax({
            url: "${contextPath}/commonPlug/countBeans.action",
            dataType: 'json',
            type: "post",
            async: false,
            data: {
                'beanName':'SatisfctEva',
                'query_eq_projectId':projectId,
            	//主审评价模板
                'query_eq_tpTypeCode':'20',
                'query_eq_examinePersonId':'${user.floginname}',
                'query_eq_evaStatusCode':'1'
            },
            success: function(data) {
                if(data && data.type == 'info'){
                    var count = data.count;
                    if(count > 0 && count >= zsCount){
                         flag = true;
                    }
              }
            },
            error: function(data) {
                top.$.messager.show({
                    title: '提示信息',
                    msg: '请求失败！请检查网络配置或者与管理员联系！'
                });
            }
        });
        return flag;
    }
	
    var busGridObj = new createQDatagrid({
        // 表格dom对象，必填
        gridObject:$('#'+gridTableId)[0],
        // 要进行检索的表对象(hibernate bean)名称， 进行拼接hql时使用; 必填
        boName:'workPlanDetail',
        // 对象主键,删除数据时使用-默认为“id”；必填
        pkName:'formId',
        order :'asc',
        sort  :'w_plan_year,w_plan_code',
		winWidth:800,
	    winHeight:300,
	    gqueryParams:{
	    	'query_eq_audit_dept':'${user.fdepid}',
	    	'query_eq_status':'9000',
	    	'query_eq_code':'100'
	    },
	    //自定义显示哪些按钮：myToolbar:['delete', 'export', 'search', 'reload'],
	    myToolbar:[],
        gridJson:{
			rownumbers:true,
		    pageSize:20,
        	singleSelect:true,
        	checkOnSelect:false,
        	selectOnCheck:false,
    		border:0,
    		//自定义工具栏按钮
    		toolbar:cusToolbar,
			onBeforeLoad:function(data){
				initHelpBtn();
			},
    		onClickCell:function(rowIndex, field, value){
    			if(field == 'w_plan_name'){
                    var rows = $(this).datagrid('getRows');
                    var row = rows[rowIndex];
    				var viewUrl = "${contextPath}/plan/detail/view.action?crudId="+row.formId;
 			        new aud$createTopDialog({
 			            title:'查看['+value+']',
 			            url  :viewUrl
 			     	}).open();
    			}
    		},
    		frozenColumns:[gridFrozenColumns],
    		columns:[gridColums]
        }
    });	
    window.aud$zhushenEvaGrid = busGridObj;
});
</script>
</head>
<body style='padding:0px;margin:0px;' class="easyui-layout" fit="true" border="0">
	<div region='center' border='0' title="" split="true" id="layoutCenter" style="overflow-x:hidden;">	
		<table id="busTable"></table>
	</div>
</body>
</html>
