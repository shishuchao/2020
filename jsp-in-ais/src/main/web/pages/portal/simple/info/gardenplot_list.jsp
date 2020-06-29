
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<html>
<head><meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
<s:text id="title" name="'信息管理'"></s:text>
<title><s:property value="#title" /></title>
<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
<!-- 
 <link href="${contextPath}/styles/main/ais.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="${contextPath}/resources/csswin/subModal.css">
<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/normal.js"></script>
<script type="text/javascript" src="${contextPath}/scripts/calendar.js"></script>
<script type="text/javascript" src="${contextPath}/resources/csswin/subModal.js"></script>
<script type='text/javascript' src='${pageContext.request.contextPath}/scripts/turnPage.js'></script>
 -->
<SCRIPT type="text/javascript">
	function realDel(id,type){
		if(window.confirm("确认删除吗？")){
			url="<%=request.getContextPath()%>/portal/simple/information/deleteByType.action?information.id="+id+"&information.type="+type;
			window.location=url;
		}
	}
	function chgnums(formid){
		var puts_temp=document.getElementsByTagName('input');
		var puts,j=0,temp;
		for(i=0;i<puts_temp.length;i++){
			if(puts_temp[i].name.indexOf("id_")!=-1){
				temp=puts_temp[i].value;
				if(/^[0-9]+$/.test( temp ))
					continue;
				else{
					alert("请输入数字");
					return false;
				}
			}
		}
		document.getElementById(formid).submit();
	}
</SCRIPT>
</head>
<body class="easyui-layout" >
<!-- 
<s:form id="myform"   action="/portal/simple/information/gardenPlotList.action" method="post">
<display:table name="studyGardenPlotList" id="row" requestURI="${contextPath}/portal/simple/information/gardenPlotList.action"  class="its" pagesize="15" export="false" style="word-break:break-all; word-wrap: break-word;">
	
	<display:column property="title" title="标题" sortable="true"  class="center" headerClass="center" maxLength="15"></display:column>
	<display:column property="creator_name" title="创建人" sortable="true"style="white-space:nowrap;"  class="center" headerClass="center"></display:column>
	<display:column property="create_date" title="创建时间" sortable="true"style="white-space:nowrap;"  class="center" headerClass="center"></display:column>
	<display:column title="操作" style="white-space:nowrap;"  class="center" headerClass="center">
		<a href="javascript:;" onclick="window.location='${contextPath}/portal/simple/information/gardenPlotEdit.action?studyGardenPlot.id=${row.id}&studyGardenPlot.parent_id=${row.parent_id}'">详情</a>
		<a href="javascript:;" onclick="if(window.confirm('确认删除吗？')){window.location='${contextPath}/portal/simple/information/gardenPlotDelete.action?studyGardenPlot.id=${row.id}&studyGardenPlot.parent_id=${row.parent_id}';}">删除</a>
	</display:column>			
</display:table>
</s:form>
<br>
<br>
	<input type="button" name="add" value="增加" onclick="javascript:window.location='${contextPath}/portal/simple/information/gardenPlotEdit.action?studyGardenPlot.parent_id=${studyGardenPlot.parent_id}'">

 -->
 <table id="studyGardenPlotList"></table>
<script type="text/javascript">
$(function(){
	$('#studyGardenPlotList').datagrid({
		url : "<%=request.getContextPath()%>/portal/simple/information/gardenPlotList.action?querySource=grid&studyGardenPlot.parent_id=${studyGardenPlot.parent_id}",
		method:'post',
		showFooter:false,
		rownumbers:true,
		pagination:true,
		striped:true,
		autoRowHeight:false,
		fit: true,
		fitColumns:true,
		idField:'id',	
		border:false,
		singleSelect:true,
		remoteSort: false,
		toolbar:[{
				id:'newYear',
				text:'新增',
				iconCls:'icon-add',
				handler:function(){
					toAdd();
				}
			}
		],
		frozenColumns:[[
		       			{field:'title',title:'标题',width:'100px',align:'center',sortable:true},
		       			{field:'creator_name',title:'创建人',width:'100px',sortable:true,align:'left'}
		    		]],
		columns:[[  
			{field:'create_date',
					title:'创建时间',
					width:80,
					align:'center', 
					sortable:true,
					formatter:function (value,row,rowIndex){
						if(value!=null){
							return value.substring(0,10);
						}
					}
			},
			{field:'operate',
				 title:'操作',
				 width:100, 
				 align:'center', 
				 sortable:false,
				 formatter:function(value,row,index){
					 return '<a href="${contextPath}/portal/simple/information/gardenPlotEdit.action?studyGardenPlot.id='+row.id+'&studyGardenPlot.parent_id='+row.parent_id+'" >详情</a>'+'&nbsp;&nbsp;'+
					 		'<a href=\"javascript:void(0)\" onclick="if(window.confirm(\'确认删除吗？\')){window.location=\'${contextPath}/portal/simple/information/gardenPlotDelete.action?studyGardenPlot.id='+row.id+'&studyGardenPlot.parent_id='+row.parent_id+'\';}">删除</a>';
				 }
			}
		]]   
	}); 
});
function toAdd(){
	window.location.href="${contextPath}/portal/simple/information/gardenPlotEdit.action?studyGardenPlot.parent_id=${studyGardenPlot.parent_id}";
}
</script>
</body>
</html>
