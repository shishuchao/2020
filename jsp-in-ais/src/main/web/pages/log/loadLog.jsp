<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="fmt"%>
<!DOCTYPE HTML>
<html>
<head>
<title>日志装载信息</title>

<SCRIPT type="text/javascript" src="<%=request.getContextPath()%>/pages/log/log.js"></SCRIPT>
<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
<link href="${contextPath}/resources/css/common.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
<%--<STYLE type="text/css">
	.datagrid-row {
	  	height: 30px;
	}
	.datagrid-cell {
		height:10%;
		padding:1px;
	}
</STYLE>--%>
<script type="text/javascript">
			var num=0;
			var len=0;
			function dis_submit(){
				sb=$_id('sub_mit');
				sb.disabled=true;
				inputs=$_id('row').getElementsByTagName('input');
				len=inputs.length;
				for(i=0;i<inputs.length;i++){
					obj=inputs[i];
					if(obj.type=='checkbox'){
						obj.onclick=function(){
							if(this.checked){
								num+=1;
							}else{
								num-=1;
							}
							if(num>0){
								sb.disabled=false;
							}else{
								num=0;
								sb.disabled=true;
							}
						}
					}
				}
			}
			function enab(){
				sb=$_id('sub_mit');
				num=len;
				if(len>0)
					sb.disabled=false;
			}
		function loadLogFiles(fileNameValue){
			$.post("/ais/log/loadLogOperFun.action",{fileName:fileNameValue},function(returnValue2) {
				showMessage1("装载成功，本次装载"+returnValue2+"条记录");
			});				
		}			
		
		function loadSelectedLogfiles(){
			var rows2=$('#its').datagrid('getSelections');
			if(rows2.length == 0){
				showMessage1("请选择日志备份文件!");
				return;
			}
			
			var s = "";
			
			for(var i=0;i<rows2.length;i++){
				alert(rows2[i].fileBlobId);
				 s+=rows2[i].fileBlobId+",";
			}
			  loadLogFiles(s);
		};
		</script>		
	</head>
<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout" fit='true' border='0'>
	<div  data-options="split:false">
		<!-- 列表FORM -->
		<s:form namespace="/log" action="loadLog.action" method="post" theme="simple">
			<input type="hidden" id="onLine" name="onLine" value="N">		
			<input type="hidden" id="endDay" name="endDay" value="${endDay}">
			<input type="hidden" id="startDay" name="startDay" value="${startDay}">
			<input type="hidden" id="size" name="size" value="${size}">
		</s:form>
		
	</div>
	
	<div region="center" border='0' >
		<table id="its"></table>
	</div>

		<!-- 分类的sql
			select SUBSTRING(visit_time,1,10) ,count(SUBSTRING(visit_time,1,10))  from log_info GROUP by SUBSTRING(visit_time,1,10);
		 -->
		 
		 
	<script type="text/javascript">
		function doSearch(){
        	$('#its').datagrid({
    			queryParams:form2Json('searchForm')
    		});
        }
		$(function(){
			// 初始化生成表格
			$('#its').datagrid({
				url : "<%=request.getContextPath()%>/log/listBackUpLog.action?querySource=grid",
				method:'post',
				showFooter:false,
				rownumbers:true,
				pagination:true,
				striped:true,
				autoRowHeight:false,
				fit: true,
				pageSize:20,
				fitColumns: true,
				idField:'id',	
				border:false,
				singleSelect:true,
				remoteSort: false,
				toolbar:[{
					id:'search',
					text:'离线日志查看',
					iconCls:'icon-view',	
					handler:function(){
						var url = '<%=request.getContextPath()%>/log/searchOff.action?onLine=N';
						top.addTab('tabs','离线日志查看','',url,true);
						//window.location.href='<%=request.getContextPath()%>/log/searchOff.action?onLine=N';
					}
				},'-',helpBtn],
				onLoadSuccess:function(){
					initHelpBtn();
				},
				columns:[[  
	       			{field:'fileName',title:'备份文件名',width:'40%',halign:'center',align:'left'},
	       			{field:'recordNum',title:'记录数量',width:'10%',halign:'center',sortable:true,align:'right'},
					{field:'createDate',
						 title:'创建时间',
						 width:'25%',
						 halign:'center',
						 align:'center',
						 sortable:true,
						 formatter:function(value,rowData,rowIndex) {
							return rowData.createDateStr;
						 }
					},
					{field:'option',
						 title:'操作',
						 width:'15%',
						 halign:'center',
						 align:'center',
						 sortable:false,
						 formatter:function(value,rowData,rowIndex){
							 return  '<a href=\"javascript:void(0)\" onclick=\"loadLogFiles(\''+rowData.fileName+'\');\">装载</a>';
						 }
					}
				]]   
			}); 
			
		});
	</script>
</body>
</html>
