<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML >
<html>
<title>内控评价-总体流程</title>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<script type="text/javascript" src="${contextPath}/easyui/boot.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
<script type="text/javascript" src="${contextPath}/pages/tlInteractive/tlInteractiveCommon.js"></script>
<script type="text/javascript">
$(function(){
	var isView = "${view}" == true || "${view}" == "true" ? true : false;
	var projectId = '${projectId}';
	var mpCode = '${mpCode}';
	var auditId = '${orgId}';
	//内控矩阵选择
	var isSelectCp = true;
	var tabTitle = isView ? "查看" : "编辑";
	var gridTableId = "totalProcessTable";
	
	var addBtn = {
         text:'确定',
         iconCls:'icon-ok',
         handler:function(){
        	 var rows = $('#totalProcessTable').datagrid('getChecked');//返回是个数组
      		 var cpId ="";
		     for(i=0;i <rows.length;i++){
		     	cpId += rows[i].cpId + ","; 
		     }
       	 	 saveRow(cpId,auditId,mpCode);
         }
	};

	var cusToolbar = isView ? [] : [addBtn, "-"];

    var g1 = new createQDatagrid({
        // 表格dom对象，必填
        gridObject:$('#'+gridTableId)[0],
        // 要进行检索的表对象(hibernate bean)名称， 进行拼接hql时使用; 必填
        boName:'ControlPoint',
        // 对象主键,删除数据时使用-默认为“id”；必填
        pkName:'cpId',
        order :'asc',
        sort  :'cpCode',
		winWidth:500,
	    winHeight:250,
	    //自定义显示哪些按钮：myToolbar:['delete', 'export', 'search', 'reload'],
	    myToolbar:['reload'],
	    associate:true,
		//定制查询条件
		whereSql: "projectId='${projectId}' exists (select 1 from ControlPoint cp, AudBusRelation ar  where a.cpId = cp.cpId  and cp.apId = ar.bid "+
			    "and (ar.attrName = 'intctet_level' and ar.itemCode='"+deptId+"' or ar.attrName='intctet_indtSector' and ar.itemCode = ''))",
        gridJson:{
        	singleSelect:true,
        	checkOnSelect:false,
        	selectOnCheck:false,
    		border:0,
    		toolbar:cusToolbar,
            onClickCell:function(rowIndex, field, value){
                var rows = $(this).datagrid('getRows');
                var row = rows[rowIndex];
                $(this).datagrid('unselectRow',rowIndex);
                $(this).datagrid('uncheckRow',rowIndex);
                if(field == 'cpCode'){
					var ctrlPointEditUrl = "${contextPath}/intctet/mainProcess/editControlPoint.action?view=${view}&cpId="+row['cpId'];
   					aud$openNewTab("控制点" + tabTitle, ctrlPointEditUrl);
                }
            },
            frozenColumns:[[         	
				{field:'cpId',   title:"选择",checkbox:true, width:'10px', align:'center', halign:'center', show:false},
				{field:'cpCode', title:"控制点编码", width:'180px', align:'center', halign:'center', show:false},
    			{field:'cpName', title:"控制点说明", width:'150px', align:'center', halign:'center', show:false},
            ]],
    		columns:[[
				{field:'ctrlImportName', title:"控制重要程度", width:'100px', align:'center', halign:'center', show:false},
				{field:'levelName',      title:"适用层级",    width:'80px', align:'center', halign:'center', show:false},
				{field:'indtSectorName', title:"适用板块",    width:'40%', align:'left', halign:'center', show:false}
          ]]
        }
    });
    
	function  saveRow(cpId,auditId,mpCode){
			$.ajax({
				url : "${contextPath}/intctet/prepare/assessScheme/saveProControlPoint.action?view=${view}&mpCode="+mpCode+"&cpId="+cpId+"&projectFormId="+projectFormId+"&auditId="+auditId,
				dataType:'json',
				type: "post",
				success: function(data){
					data.msg ? showMessage1(data.msg) : null;
	       			if(data.type = 'info'){
	       				top.$.messager.show({title:'提示信息',msg:'保存成功！'});
	       				
	       			}
				},
				error:function(data){
					top.$.messager.show({title:'提示信息',msg:'请求失败！请检查网络配置或者与管理员联系！'});
				}
			});
	}
});


</script>
</head>
<body style='padding:0px;margin:0px;overflow:hidden;' class="easyui-layout" fit="true" border="0">
	<input type='hidden' id="mpCode" name="mpCode"  class="noborder editElement clear" value="${mpCode}"/>
	<input type='hidden' id="projectId" name="projectId"  class="noborder editElement clear" value="${formId}"/>
	<div region="center"  border="0">	
		<table id="totalProcessTable"></table>
	</div>
</body>
</html>