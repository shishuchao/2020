<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<title>人员列表信息明细</title>
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

	var gqueryParams = {};
	
    if("${busJtbb}"){
    	gqueryParams.query_eq_companyCode = '${busId}';
    }else{
    	gqueryParams.customParam = "(a.companyCode in (select u.fid from UOrganization u where u.fcode like '${busOrgFcode}%'))";
    }
	
	if("${busPsLevelM3}"){
		gqueryParams.query_mtq_psLevel = "3";
	}
	if('${busPsLevel}'){
		gqueryParams.query_eq_psLevel = '${busPsLevel}';
	}
	var busUserWpc = "${busUserWpc}";
	if(busUserWpc){
		gqueryParams.customParam2 = "(not exists (select 1 from ProMember c where c.userId = a.sysAccounts))"
	}
	
    var busGridObj = new createQDatagrid({
        // 表格dom对象，必填
        gridObject:$('#'+gridTableId)[0],
        // 要进行检索的表对象(hibernate bean)名称， 进行拼接hql时使用; 必填
        boName:'employeeInfo',
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
				if(field == 'name'){
					var rows = $(this).datagrid('getRows');
	            	var row = rows[index];
	            	var id = row.id;
	            	var winTitle = "人员详细信息查看";
	            	var winUrl = "${contextPath}/mng/employee/employeeInfoView.action?employeeInfo.id="+id;

	               	aud$openNewTab(winTitle, winUrl, true);
				}
    		},
    		onLoadSuccess:function(data){
    			
    		},
			frozenColumns:[[
       			{field:'id',width:'50px',hidden:true, align:'center',show:false},
       			{field:'name',title:'姓名',width:'150px',halign:'center',align:'left',sortable:true, oper:'like',
					formatter:function(value,row,index){
						return value ? "<label title='"+value+"' style='color:blue;cursor:pointer;'>"+value+"</label>" : "";
					}
       			},
       			{field:'sex',title:'性别',width:'60px',halign:'center',sortable:true,align:'center',
       			 type:'custom', target:$('#queryCond0')[0]
       			}
    		]],
			columns:[[
				{field:'age',
					 title:'年龄',
					 width:100,
					 halign:'center',
					 align:'center', 
					 sortable:true,
					 show:false
				},
				{field:'speciality',
					 title:'专业',
					 width:'120px',
					 halign:'center',
					 align:'center', 
					 sortable:true,
					 type:'custom', target:$('#queryCond1')[0]
				},
				{field:'psLevel',
					 title:'专业序列等级',
					 width:'120px',
					 halign:'center', 
					 align:'center', 
					 sortable:true,
					 type:'custom', target:$('#queryCond2')[0],
					formatter:function(value,row,index){
						return value ? "<label title='"+value+"'>T"+value+"</label>" : "";
					}
				},
				{field:'company',
					 title:'所属单位',
					 width:'230px',
					 halign:'center', 
					 align:'left', 
					 sortable:true,show:false
				},
				{field:'duty',
					 title:'职务级别',
					 width:'150px',
					 halign:'center', 
					 align:'center', 
					 sortable:true,
					 type:'custom', target:$('#queryCond3')[0]
				},
				{field:'auditAgeLimit',
					 title:'工作年限',
					 width:'120px',
					 halign:'center', 
					 align:'right', 
					 sortable:true ,show:false}
			]]   
        }
    });	
    
    
  	aud$genSelectOption('sexSelect', [{
        'code':'男',
        'name':'男'
  	},{
        'code':'女',
        'name':'女'
  	}]);
  	
  	// levelSelect
  	aud$genSelectOption('levelSelect', [{
        'code':'1',
        'name':'T1'
  	},{
        'code':'2',
        'name':'T2'
  	},{
        'code':'3',
        'name':'T3'
  	},{
        'code':'4',
        'name':'T4'
  	},{
        'code':'5',
        'name':'T5'
  	}]);
});
</script>
</head>
<body style='padding:0px;margin:0px;' class="easyui-layout" fit="true" border="0">
	<div region='center' border='0' title="" split="true" id="layoutCenter" style="overflow-x:hidden;">	
		<table id="busTable"></table>
	</div>
	
	<div id='queryCond0'>
		<select id="sexSelect" name="query_eq_sex" ></select>
	</div>
	<div id='queryCond1'>
		<select editable="false" class="easyui-combobox" name="query_eq_specialityCode"  PanelHeight="auto">
			<option value="">&nbsp;</option>
			<s:iterator value="basicUtil.specialtyList4Search" >
	        	<option value="${code}">${name}</option>
	       </s:iterator>
		</select>
	</div>
	<div id='queryCond2'>
		<select id="levelSelect" name="query_eq_psLevel" ></select>
	</div>
	<div id='queryCond3'>
		<select editable="false" name="query_eq_dutyCode"   class="easyui-combobox" PanelHeight="auto">
				<option value="">&nbsp;</option>
			<s:iterator value="basicUtil.dutyList4Search" id="enitty">
				<option value="${code}">${name }</option>
			</s:iterator>
		</select>
	</div>
</body>
</html>