<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<title>项目成果详情</title>
<script type="text/javascript" src="${contextPath}/easyui/boot.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/jquery-fileUpload.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
<script type="text/javascript" src="${contextPath}/pages/tlInteractive/tlInteractiveCommon.js"></script>
<script type="text/javascript">
$(function(){
	if("${errorMsg}"){
		top.$.messager.alert("提示信息","${errorMsg}", "warning", function(){			
			aud$closeTab();
		});
		setTimeout(aud$closeTab,0);
	}
	var isView = "${view}" == true || "${view}" == "true" ? true : false;
	var gridTableId = "busTable";

	// 自定义查询方法
	var custom_serviceInstance = 'firstPageService';
  	var custom_serviceMethod = 'inspectPageInfoCusGrid';
  	var gqueryParams = {
  		'cus_model':'${model}',
  		'query_eq_busOrgFcode':'${busOrgFcode}'
  	};
    if("${busJtbb}"){
    	gqueryParams.customParam01 = "(a.audit_dept in (select u.fid from UOrganization u where u.ftype='D' and u.fpid = '${busId}' or u.fid='${busId}'))";
    }else{
    	gqueryParams.customParam = "1";
    }
    if("${busRstAuditPro}"){
    	
    }else if("${busRstAuditFindPb}"){
    	
    }else if("${busRstAuditReformPb}"){
    	gqueryParams.query_eq_mend_state_code = '1';
    }
    
    var busGridObj = new createQDatagrid({
        // 自定义查询服务和方法
        serviceInstance:custom_serviceInstance,
      	serviceMethod  :custom_serviceMethod,
        // 表格dom对象，必填
        gridObject:$('#'+gridTableId)[0],
        // 要进行检索的表对象(hibernate bean)名称， 进行拼接hql时使用; 必填
        boName:'MiddleLedgerProblem',
		winWidth:800,
	    winHeight:300,
	    //自定义显示哪些按钮：myToolbar:['delete', 'export', 'search', 'reload'],
	    myToolbar:[],
	    associate:false,
	    gqueryParams:gqueryParams,
        gridJson:{
			rownumbers:true,
		    pageSize:20,
		    pagination:true,
        	singleSelect:true,
        	checkOnSelect:false,
        	selectOnCheck:false,
    		border:0,
    		//自定义工具栏按钮
    		toolbar:['search','-','export','-','reload'],
    		onClickCell:function(index, field, value){
				if(field == 'project_name'){
					var rows = $(this).datagrid('getRows');
	            	var row = rows[index];
	            	var id = row.planFormId;
	            	var winTitle = "项目信息查看";
	            	var winUrl = "${contextPath}/plan/detail/view.action?crudId="+id;
	               	aud$openNewTab(winTitle, winUrl, true);
				}else if(field == 'findPbSum'){
					var rows = $(this).datagrid('getRows');
	            	var row = rows[index];
	            	var id = row.project_id;
	            	var winTitle = "发现问题信息";
	            	var winUrl = "${contextPath}/portal/simple/inspectPageInfo.action?model=findPbList&busId="+id+"&busRstProjectId="+id;
	               	aud$openNewTab(winTitle, winUrl, false);
				}else if(field == 'reformPbSum'){
					var rows = $(this).datagrid('getRows');
	            	var row = rows[index];
	            	var id = row.project_id;
	            	var winTitle = "整改跟踪信息";
	            	var winUrl = "${contextPath}/portal/simple/inspectPageInfo.action?model=reformPbList&busId="+id+"&busRstProjectId="+id;
	               	aud$openNewTab(winTitle, winUrl, false);
				}else if(field == 'audit_object_name'){
					var rows = $(this).datagrid('getRows');
	            	var row = rows[index];
	            	var id = row.audit_object;
	            	var winTitle = "被审计单位信息";
	            	var winUrl = '${contextPath}/mng/audobj/object/view.action?superiorCode=${currentCode}&status=view&auditingObject.id='+id;
	            	//var winUrl = "${contextPath}/portal/simple/inspectPageInfo.action?model=reformPbList&busId="+id;
	               	aud$openNewTab(winTitle, winUrl, false);
				}
    		},
			columns:[[  
       			{field:'project_code',title:'项目编号',width:'220px',sortable:false,halign:'center',align:'left', oper:'like'},
				{field:'project_name',title:'项目名称',width:'30%',halign:'center',align:'left', sortable:false,oper:'like',
					formatter:function(value,row,index){
						return value ? "<label title='"+value+"' style='color:blue;cursor:pointer;'>"+value+"</label>" : "";
					}
				},
				{field:'audit_dept_name', title:'审计单位',width:'17%',halign:'center',align:'left',sortable:false,
					 type:'custom', target:$('#queryCond0')[0], queryText:'年度'
				},				
				{field:'audit_object_name',title:'被审计单位', width:'17%', halign:'center', align:'left',  sortable:false,
					type:'custom', target:$('#queryCond1')[0],
					formatter:function(value,row,index){
						return value ? "<label title='"+value+"' style='color:blue;cursor:pointer;'>"+value+"</label>" : "";
					}
				},
				{field:'findPbSum',title:'发现问题', width:'80px', halign:'center', align:'right',  sortable:false,show:false,
					formatter:function(value,row,index){
						return value != null ? "<label title='"+value+"' style='color:blue;cursor:pointer;'>"+value+"</label>" : "";
					}
				},
				{field:'reformPbSum',title:'已整改问题', width:'80px', halign:'center', align:'right',  sortable:false,show:false,
					formatter:function(value,row,index){
						return value != null ? "<label title='"+value+"' style='color:blue;cursor:pointer;'>"+value+"</label>" : "";
					}
				}
			]]
        }
    });	
    
  	setTimeout(function(){
  		$('#'+gridTableId+'_query_searchAndExportBtn').remove();
  	}, 100)
    
    var currentYear = "${curYear}";
    var offsetYear = 5;
    var yearArr = [];
    for(var i=currentYear-offsetYear; i<parseInt(currentYear)+offsetYear; i++){
        yearArr.push({
            'code':i,
            'name':i
        });
    }
  	aud$genSelectOption('planYearSelect', yearArr, null);
});
</script>
</head>
<body style='padding:0px;margin:0px;' class="easyui-layout" fit="true" border="0">
	<div region='center' border='0' title="" split="true" id="layoutCenter" style="overflow-x:hidden;">	
		<table id="busTable"></table>
	</div>	
	<div id='queryCond0'>
		<select id="planYearSelect" name="query_eq_pro_year" ></select>
	</div>
	<div id='queryCond1'>
        <input type='text'  class="noborder" name='query_like_audit_object_name'/>
        <input type='hidden'  readonly />
        <a  class="easyui-linkbutton  editElement " iconCls="icon-search" style='border-width:0px;'
              onclick="showSysTree(this,{
            	url:'${contextPath}/mng/audobj/object/getAuditedDeptChildByDeptId.action',
				param:{
					'departmentId':'${busId}'
				},
				checkbox:false,
				title:'请选择被审计单位',
         })"></a>
	</div>
</body>
</html>