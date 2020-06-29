<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<title>项目信息明细</title>
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
    var stage = "${stage}";
    var t= "";
    var s = { };
    if("${busJtbb}"){
    	s = {
    		'customParam':"(a.pro_year=${pro_year} and a.audit_dept in (select u.fid from UOrganization u where u.ftype='D' and u.fpid = '${busId}' or u.fid='${busId}'))"
    	};
    }else{
    	s = {
   	    	'customParam':"(a.pro_year=${pro_year} and a.audit_dept in (select u.fid from UOrganization u where u.fcode like '${busOrgFcode}%'))"
   	    };
    }
    if (stage == "1"){
    	s.query_eq_prepare_closed='0';
    }else if (stage == "2"){
    	s.query_eq_prepare_closed='1';
    	s.query_eq_actualize_closed='0';
    }else if (stage == "3"){
    	s.query_eq_actualize_closed='1';
    	s.query_eq_archives_closed='0';
    }else if (stage == "4"){
    	s.query_eq_archives_closed='1';
    	s.query_eq_rework_closed='0';
    }else if (stage == "5"){
    	s.query_eq_rework_closed='1';
    }
    var busGridObj = new createQDatagrid({
        // 表格dom对象，必填
        gridObject:$('#'+gridTableId)[0],
        // 要进行检索的表对象(hibernate bean)名称， 进行拼接hql时使用; 必填
        boName:'projectStartObject',
		winWidth:800,
	    winHeight:300,
	    //自定义显示哪些按钮：myToolbar:['delete', 'export', 'search', 'reload'],
	    myToolbar:[],
	    associate:false,
	    gqueryParams:s,
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
	            	var id = row.plan_form_id;
	            	var winTitle = "项目信息查看";
	            	var winUrl = "${contextPath}/plan/detail/view.action?crudId="+id;

	               	aud$openNewTab(winTitle, winUrl, true);
				}
    		},
    		onLoadSuccess:function(data){
    			
    		},
			frozenColumns:[[
       			{field:'is_closed',title:'状态',halign:'center',align:'center',sortable:true, width:'60px',
					 type:'custom', target:$('#queryCond3')[0],
					 formatter:function(value,row,index) {
						 if('closed' == value){
					           return '已关闭';
					        }else if('running' == value){
					           return '进行中';
					        }else{
					        	return '未执行';
					        }
					 }
       			},
       			{field:'project_code',title:'项目编号',width:'200px',sortable:true,halign:'center',align:'left', 
					oper:'like'}
    		]],
			columns:[[  
				{field:'project_name',
						title:'项目名称',
						width:'20%',
						halign:'center',
						align:'left', 
						sortable:true,
						oper:'like',
						formatter:function(value,row,index){
							return value ? "<label title='"+value+"' style='color:blue;cursor:pointer;'>"+value+"</label>" : "";
						}
				},
				{field:'pro_year',
					title:'项目年度',
					halign:'center',
					width:'80px',
					sortable:true, 
					align:'center',
					type:'custom', target:$('#queryCond0')[0]
				},
				{field:'pro_type_name',
					 title:'项目类别',
					 halign:'center',
					 width:'120px',
					 align:'center', 
					 sortable:true,
					 type:'custom', target:$('#queryCond2')[0]
				},
				{field:'audit_dept_name',
					 title:'所属单位',
					 width:'20%', 
					 halign:'center',
					 align:'left', 
					 sortable:true,
					 show:false
				},
				{field:'prepare_closed',
					 title:'准备',
					 halign:'center',
					 align:'center', 
					 sortable:true,
					 width:'80px',
					 formatter:function(value,rowData,rowIndex){
					        if(rowData.prepare_closed == '1'){
					           return '已完成';
					        }else if(rowData.prepare_closed == '0'){
					           return '进行中';
					        }else{
					           return '未执行';
					        }
					 },
					 queryText:'阶段',
					 exportField:'prepareClosedName',
					 type:'custom', target:$('#queryCond4')[0]
				},
				{field:'actualize_closed',
					 title:'实施/报告',
					 halign:'center',
					 align:'center',
					 sortable:true,
					 width:'80px',
					 formatter:function(value,rowData,rowIndex){
					       /*  if(rowData.actualize_closed == '1'){
					           return '已完成';
					        }else if(rowData.actualize_closed == '0'){
					           return '进行中';
					        }else{
					           return '未执行';
					        } */
						 if(rowData.report_closed==null){
									return '未执行';
								}else if(rowData.report_closed=='2' || rowData.report_closed=='1'){
									return '已完成';
								}else if(rowData.report_closed=='0'){
			   					return '进行中';
								}else{
			   					return '未执行';
								}	
					 },
					 exportField:'actualizeClosedName',
					 show:false
				},
/* 				{field:'report_closed',
					 title:'终结',
					 halign:'center',
					 align:'center', 
					 sortable:true,
					 width:'60px',
					 formatter:function(value,rowData,rowIndex){
					        if(rowData.report_closed == '1'){
					           return '已完成';
					        }else if(rowData.report_closed == '2' || rowData.report_closed=='0'){
					           return '进行中';
					        }else{
					           return '未执行';
					        }
					 },
					 exportField:'reportClosedName',
					 show:false
				}, */
				{field:'archives_closed',
					 title:'档案',
					 halign:'center',
					 align:'center', 
					 sortable:true,
					 width:'80px',
					 formatter:function(value,rowData,rowIndex){
					        if(rowData.archives_closed == '1'){
					           return '已完成';
					        }else if(rowData.archives_closed == '0'){
					           return '进行中';
					        }else{
					           return '未执行';
					        }
					 },
					 exportField:'archivesClosedName',
					 show:false
				},
				{field:'rework_closed',
					 title:'整改',
					 halign:'center',
					 align:'center', 
					 sortable:true,
					 width:'80px',
					 formatter:function(value,rowData,rowIndex){
					        if(rowData.rework_closed == '1'){
					           return '已完成';
					        }else if(rowData.rework_closed == '0'){
					           return '进行中';
					        }else{
					           return '未执行';
					        }
					 },
					 exportField:'reworkClosedName',
					 show:false
				}
			]]
        }
    });	
    
    
    var currentYear = "${curYear}";
    var offsetYear = 10;
    var yearArr = [];
    for(var i=currentYear-offsetYear; i<parseInt(currentYear)+offsetYear; i++){
        yearArr.push({
            'code':i,
            'name':i
        });
    }
  	aud$genSelectOption('planYearSelect', yearArr, null);
  	
  	setTimeout(function(){
  		$('#'+gridTableId+'_query_searchAndExportBtn').remove();
  	}, 100)
  	
  	//selectProjectStatus
  	aud$genSelectOption('selectProjectStatus', [{
        'code':'running',
        'name':'进行中'
  	},{
        'code':'closed',
        'name':'已关闭'
  	}]);

  	aud$genSelectOption('selectProjectStage', [{
        'code':'prepare_closed',
        'name':'准备阶段'
  	},{
        'code':'actualize_closed',
        'name':'实施/报告'
  	},{
        'code':'archives_closed',
        'name':'档案阶段'
  	},{
        'code':'rework_closed',
        'name':'整改阶段'
  	}],null,{
  		width:'120px',
  		onSelect:function(rec){
  			//alert(rec.value+"\n"+rec.text)
  			$('#stageValue').attr('name','query_eq_'+rec.value);
  		}
  	});
  	aud$genSelectOption('selectProjectStageCode', [{
        'code':'1',
        'name':'已完成'
  	},{
        'code':'0',
        'name':'进行中'
  	},{
        'code':'isnull',
        'name':'未执行'
  	}],null,{
  		width:'120px',
  		onSelect:function(rec){
  			//alert(rec.value+"\n"+rec.text)
  			$('#stageValue').attr('value',rec.value);
  		}
  	});
});
</script>
</head>
<body style='padding:0px;margin:0px;' class="easyui-layout" fit="true" border="0">
	<div region='center' border='0' title="" split="true" id="layoutCenter" style="overflow-x:hidden;">	
		<table id="busTable"></table>
	</div>
	<div id='queryCond0'>
		<select id="planYearSelect" name="query_eq_pro_year"  panelMaxHeight="150px"
				data-options="editable:false,panelHeight:'auto'"></select>
	</div>

	<div id='queryCond2'>
        <input type='text' name='query_eq_pro_type_name' readonly class="noborder" />
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
		<select id="selectProjectStatus" name="query_eq_is_closed" ></select>
	</div>
	<div id='queryCond4'>
		<select id="selectProjectStage"></select>
		<select id="selectProjectStageCode"></select>
		<input id='stageValue' type='hidden' name='' value='' readonly />
	</div>	
</body>
</html>