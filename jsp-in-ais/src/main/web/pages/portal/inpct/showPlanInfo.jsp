<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<title>计划信息</title>
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


    var gridColum = [];
    gridColum.push({
		field:'w_plan_name', title:"项目名称", width:'260px',align:'left', halign:'center', sortable:true, 
		formatter:function(value,row,index){
			return value ? "<label title='"+value+"' style='color:blue;cursor:pointer;'>"+value+"</label>" : "";
		},
		oper:'like'
	},{
		field:'pro_type_name', title:"项目类别", width:'100px',align:'center', halign:'center', sortable:false,
		formatter:function(value,row,index){
			return value != null ? "<label title='"+value+"'>"+value+"</label>" : "";
		},
		type:'custom', target:$('#queryCond2')[0]
	},{
		field:'w_plan_year', title:"项目年度", width:'70px',align:'center', halign:'center', sortable:false, 
		formatter:function(value,row,index){
			return value != null ? "<label title='"+value+"'>"+value+"</label>" : "";
		},
		type:'custom', target:$('#queryCond0')[0]
	},{
		field:'audit_dept_name', title:"审计单位", width:'150px',align:'left', halign:'center', sortable:false, 
		formatter:function(value,row,index){
			return value != null ? "<label title='"+value+"'>"+value+"</label>" : "";
		},
		show:false
	},{
		field:'audit_object_name', title:"被审计单位", width:'150px',align:'left', halign:'center', sortable:false,
		formatter:function(value,row,index){
			return value != null ? "<label title='"+value+"'>"+value+"</label>" : "";
		},
		type:'custom', target:$('#queryCond4')[0]
	},{
		field:'pro_auditleader_name', title:"项目主审", width:'100px',align:'center', halign:'center', sortable:false,
		formatter:function(value,row,index){
			return value != null ? "<label title='"+value+"'>"+value+"</label>" : "";
		},
		type:'custom', target:$('#queryCond3')[0], singleRow:true
	},{
		field:'pro_starttime', title:"项目开始时间", width:'100px',align:'center', halign:'center', sortable:false, 
		formatter:function(value,row,index){
			if(value){    						
				var t = value.indexOf("T");
				if(t != -1){
					value = value.substr(0, t);
				}
			}
			return value ? "<label title='"+value+"'>"+value+"</label>" : "";
		},
		type:'datebt', queryKey:'-to_char-pro_starttime'
	},{
		field:'pro_endtime', title:"项目结束时间", width:'100px',align:'center', halign:'center', sortable:false,
		formatter:function(value,row,index){
			if(value){    						
				var t = value.indexOf("T");
				if(t != -1){
					value = value.substr(0, t);
				}
			}
			return value ? "<label title='"+value+"'>"+value+"</label>" : "";
		},
		type:'datebt', queryKey:'-to_char-pro_endtime'
	},{
		field:'audit_start_time', title:"审计期间开始", width:'100px',align:'center', halign:'center', sortable:false,
		formatter:function(value,row,index){
			if(value){    						
				var t = value.indexOf("T");
				if(t != -1){
					value = value.substr(0, t);
				}
			}
			return value ? "<label title='"+value+"'>"+value+"</label>" : "";
		},
		type:'datebt', queryKey:'-to_char-audit_start_time'
	},{
		field:'audit_end_time', title:"审计期间结束", width:'100px',align:'center', halign:'center', sortable:false,
		formatter:function(value,row,index){
			if(value){    						
				var t = value.indexOf("T");
				if(t != -1){
					value = value.substr(0, t);
				}
			}
			return value ? "<label title='"+value+"'>"+value+"</label>" : "";
		},
		type:'datebt', queryKey:'-to_char-audit_end_time'
	});
    var planStatus = "${planStatus}";
    var gqueryParams = {};
    var isAuditPage = planStatus ? true : false;
    if(isAuditPage){//审计首页
    	gqueryParams = {
   			'query_eq_code':'100',
   			'query_eq_w_plan_year':'${curYear}',
   			'query_in_audit_dept' :'${user.juniorOrganiazations}',
   			'query_in_status':planStatus
   	    };
    }else{//纪检首页
    	//alert("${busOrgFcode}")
    	gqueryParams = {
			//'query_eq_audit_dept':'${busId}',
			'query_eq_code':'100',
			'query_in_status':'${busStatus}'
	    };
    
        if("${busJtbb}"){
        	gqueryParams.customParam = "(a.audit_dept in (select u.fid from UOrganization u where u.ftype='D' and u.fpid = '${busId}' or u.fid='${busId}'))";
        }else{
        	gqueryParams.customParam = "(a.audit_dept in (select u.fid from UOrganization u where u.fcode like '${busOrgFcode}%'))";
        }
    
    }
    //alert('${user.fdepid}')
    var busGridObj = new createQDatagrid({
        // 表格dom对象，必填
        gridObject:$('#'+gridTableId)[0],
        // 要进行检索的表对象(hibernate bean)名称， 进行拼接hql时使用; 必填
        boName:'workPlanDetail',
		winWidth:800,
	    winHeight:300,
	    //自定义显示哪些按钮：myToolbar:['delete', 'export', 'search', 'reload'],
	    myToolbar:[],
	    gqueryParams:gqueryParams,
        pkName:'formId',
        sort  :'w_plan_year desc',
	    associate:false,
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
				if(field == 'w_plan_name'){
					var rows = $(this).datagrid('getRows');
	            	var row = rows[index];
	            	//alert(row.id)
	            	var winTitle = "项目信息查看";
	            	var winUrl = "${contextPath}/plan/detail/view.action?crudId="+row.formId;

	               	aud$openNewTab(winTitle, winUrl, true);
				}
    		},
    		columns:[gridColum]
        }
    });	
    
    var currentYear = "${curYear}";
    //alert(currentYear)
    var offsetYear = 10;
    var yearArr = [];
    for(var i=currentYear-offsetYear; i<parseInt(currentYear)+offsetYear; i++){
        yearArr.push({
            'code':i,
            'name':i
        });
    }
  	aud$genSelectOption('planYearSelect', yearArr, isAuditPage ? currentYear  : null);
});
</script>
</head>
<body style='padding:0px;margin:0px;' class="easyui-layout" fit="true" border="0">
	<div region='center' border='0' title="" split="true" id="layoutCenter" style="overflow-x:hidden;">	
		<table id="busTable"></table>
	</div>
	
	<div id='queryCond0'>
		<select id="planYearSelect" name="query_eq_w_plan_year" panelMaxHeight="180px"
				data-options="editable:false,panelHeight:'auto'"></select>
	</div>

	<div id='queryCond2'>
        <input type='text'  class="noborder" name='query_like_pro_type_name'/>
        <input type='hidden'  readonly />
        <a  class="easyui-linkbutton  editElement " iconCls="icon-search" style='border-width:0px;'
              onclick="showSysTree(this,{
                  title:'项目类别选择',
                  onlyLeafClick:true,
                  param:{
                    'customRoot':'项目类别',
                    'serverCache':false,
                    'rootParentId':'0',
                    'beanName':'CodeName',
                    'whereHql':'type=\'1003\' and level1=1 ',
                    'plugId':'codename_1003',
                    'treeId'  :'id',
                    'treeText':'name',
                    'treeParentId':'pid',
                    'treeOrder':'code',
                    'treeAtrributes':'code,pid,name'
                 }                                
         })"></a>
	</div>
	<div id='queryCond3'>
        <input type='text' class="noborder" name='query_like_pro_auditleader_name'/>
        <input type='hidden'  readonly />
        <a  class="easyui-linkbutton  editElement " iconCls="icon-search" style='border-width:0px;'
              onclick="showSysTree(this,{
            	  url:'${contextPath}/systemnew/orgListByAsyn.action',
                  param:{
                     'p_item':1,
                     'orgtype':1
                  },
                  title:'请选择项目主审',
                  type:'treeAndEmployee'                               
         })"></a>
	</div>
	
	<div id='queryCond4'>
        <input type='text' class="noborder" name='query_like_audit_object_name'/>
        <input type='hidden'  readonly />
        <a  class="easyui-linkbutton  editElement " iconCls="icon-search" style='border-width:0px;'
              onclick="showSysTree(this,{
				 url:'${contextPath}/mng/audobj/object/getAuditedDeptChildByDeptId.action',
				 param:{
				 	'departmentId':'${busId}'
				 },
				 cache:false,
				 checkbox:false,
				 title:'请选择被审计单位',                            
         })"></a>
	</div>
</body>
</html>