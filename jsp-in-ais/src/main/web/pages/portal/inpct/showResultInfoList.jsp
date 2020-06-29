<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<title>项目成果信息统计</title>
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
		field:'title', title:"审计单位", width:'40%',align:'left', halign:'center', sortable:false, 
		formatter:function(value,row,index){
			return value ? "<label title='"+value+"' style='color:blue;cursor:pointer;'>"+value+"</label>" : "";
		},
		type:'custom', target:$('#queryCond1')[0]
	},{
		field:'s1', title:"审计项目", width:'120px',align:'right', halign:'center', sortable:false, 
		formatter:function(value,row,index){
			return value != null ? "<label title='"+value+"' style='color:blue;cursor:pointer;'>"+value+"</label>" : "";
		},
		type:'custom', target:$('#queryCond0')[0], queryText:'年度'
	},{
		field:'s2', title:"发现问题", width:'120px',align:'right', halign:'center', sortable:false, show:false,
		formatter:function(value,row,index){
			return value != null ? "<label title='"+value+"' style='color:blue;cursor:pointer;'>"+value+"</label>" : "";
		}
	},{
		field:'s3', title:"已整改问题", width:'120px',align:'right', halign:'center', sortable:false, show:false,
		formatter:function(value,row,index){
			return value != null ? "<label title='"+value+"' style='color:blue;cursor:pointer;'>"+value+"</label>" : "";
		}
	});
	// 自定义查询方法
	var custom_serviceInstance = 'firstPageService';
  	var custom_serviceMethod = 'inspectPageInfoCusGrid';
    var busGridObj = new createQDatagrid({
        // 表格dom对象，必填
        gridObject:$('#'+gridTableId)[0],
        // 自定义查询服务和方法
        serviceInstance:custom_serviceInstance,
      	serviceMethod  :custom_serviceMethod,
        // 要进行检索的表对象(hibernate bean)名称， 进行拼接hql时使用; 必填
        boName:'MiddleLedgerProblem',
		winWidth:800,
	    winHeight:300,
	    //自定义显示哪些按钮：myToolbar:['delete', 'export', 'search', 'reload'],
	    myToolbar:[],
	    gqueryParams:{
			'cus_model':'${model}'
	    },
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
    		toolbar:['search','-','reload'],
    		onClickCell:function(index, field, value){
				var rows = $(this).datagrid('getRows');
            	var row = rows[index];
            	var winTitle = '';
            	if(row.title.length > 4) {
            		winTitle = row.title.substring(0,2);
    			} else {
    				winTitle = row.title;
    			}
            	var winUrl = "";
               	
				if(field == 'title' || field == 's1'){
					if(field == 'title') {
						winTitle += "成果信息";
					}else{
						winTitle += "审计项目";
					}
					winUrl = "${contextPath}/portal/simple/inspectPageInfo.action?model=resultStatistics&busId="
            			+row.id+"&busOrgFcode="+row.busOrgFcode+"&busRstAuditPro=1";
				}else if(field == 's2'){
					winTitle += "发现问题";
					winUrl = "${contextPath}/portal/simple/inspectPageInfo.action?model=findPbList&busId="
						+row.id+"&busOrgFcode="+row.busOrgFcode+"&busRstAuditFindPb=1";
				}else if(field == 's3'){
					winTitle += "已整改问题";
					winUrl = "${contextPath}/portal/simple/inspectPageInfo.action?model=reformPbList&busId="
						+row.id+"&busOrgFcode="+row.busOrgFcode+"&busRstAuditReformPb=1";
				}
				
				if(row.title == "集团本部"){
					winUrl = winUrl + "&busJtbb=1";
				}
				
				aud$openNewTab(winTitle, winUrl, false, false);
    		},
    		columns:[gridColum]
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
  	
});
</script>
</head>
<body style='padding:0px;margin:0px;' class="easyui-layout" fit="true" border="0">
	<div region='center' border='0' title="" split="true" id="layoutCenter" style="overflow-x:hidden;">	
		<table id="busTable"></table>
	</div>
	<div id='queryCond0'>
		<select id="planYearSelect" name="query_eq_year" panelMaxHeight="180px"
				data-options="editable:false,panelHeight:'auto'"></select>
	</div>
	<div id='queryCond1'>
        <input type='text' name='query_like_orgName'  class="noborder" />
        <input type='hidden'  readonly />
        <a  class="easyui-linkbutton  editElement " iconCls="icon-search" style='border-width:0px;'
              onclick="showSysTree(this,{
              title:'所属单位选择',
              param:{
            	 'rootId':'${magOrganization.fid}',
                 'beanName':'UOrganizationTree',
                 'treeId'  :'fid',
                 'treeText':'fname',
                 'treeParentId':'fpid',
                 'treeOrder':'fcode'                     
             }                                 
         })"></a>
	</div>
</body>
</html>