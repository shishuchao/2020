<!DOCTYPE HTML>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>

<html>
<head>
	<title>日志备份信息</title>
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
	<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
	<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
	<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
	<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
	<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
	<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>	
	<script type="text/javascript">
		$(function(){
			$("#filenametip").html("");
			$("#visittime1").bind("propertychange", function() { 
				$("#recordNum").html("");
				$("#filenametip").html("");
				$("#oprbtn").removeAttr("disabled");
			}); 
		});
		function addEvent2(){
			document.getElementsByName("visittime1")[0].onpropertychange=function(){
					addSize();		
			}
		}
		function addSize(){
			var backs={"model":${list}};
			for(var i=0;i<backs.model.length;i++){
				backs.model[i].date=backs.model[i].date.replace("-","");
			}
			var mtime=document.getElementsByName("visittime1")[0].value;
			var msize=0;
			if(mtime&&mtime.length>1){
				mtime=mtime.replace("-","");
				for(var i=0;i<backs.model.length;i++){
					if(backs.model[i].date<=mtime){
						msize+=backs.model[i].size;
					}
				}
			}
			document.getElementById("numbers").innerHTML=msize+" 条";
			var tijiao=document.getElementById("tijiao");
			if(msize>0){
				tijiao.disabled=null;
			}else{
				tijiao.disabled="disabled";
			}	
		}
		
		function backupOpr(){
			var tijiao=document.getElementById("tijiao");
				tijiao.disabled="disabled";
			if(confirm("点击备份将删除指定日期前的所有日志，是否备份？")){
				document.forms['myForm'].submit();
			}else{
				tijiao.disabled=null;
			}
		}
		function backUpFun(){
			$("#oprbtn").attr("disabled",true);
			var visittimeValue = $('#visittime1').datebox('getValue'); 
			var logAuthorityValue = $("#logAuthority").val();
			if(null==visittimeValue || visittimeValue==''){
				showMessage1("请选择日期!");
				return;
			}
			$.messager.confirm('提示信息','点击备份将删除指定日期前的所有日志，是否备份？',function(isFlag){
				if(isFlag){
					$.post("/ais/log/backUpLogOpr.action",{visittime1:visittimeValue,logAuthority:logAuthorityValue},function(returnValue2) {
						if(null!=returnValue2){
							var arr = []
							 arr = returnValue2.split("|");
							 if(arr[1]==0){
							 	showMessage1("当前选择日期无日志记录，请重新选择日期!");
							 	$("#oprbtn").removeAttr("disabled");
							 }		
							 if(arr[1]>0){
							 	showMessage1("备份成功\n本次备份"+arr[1]+"条记录\n备份的日志文件为"+arr[0]);
							 	$("#filenametip").html(arr[0]);
							 	$("#recordNum").html(arr[1]);
							 }	
						}
					});	
				}else{
					$("#oprbtn").removeAttr("disabled");
				}
			});
		}			
	</script>
</head>
<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout">
		<!-- <table style="padding: 0; border-spacing: 0; border-collapse: 0; width: 96%;"> -->
		<!-- 列表FORM -->
		<s:form namespace="/log" id="myForm" action="backUpLog.action" method="post" theme="simple">
			<input type="hidden" id="logAuthority" name="logAuthority" value="${logAuthority}">
			<s:if test="${not empty tip}">
				<center><font size="4" color="red">${tip}</font></center>
			</s:if>
			<table cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
				<tr >
					<td class="EditHead" style="width:31%;">对指定日期及以前的日志记录进行备份并删除</td>
					<td class="editTd">
						<input type="text" id="visittime1" editable="false" class="easyui-datebox noborder" name="visittime1" >
					</td>
				</tr>
				<tr >
					<td class="EditHead">本次备份记录数量</td>
					<td class="editTd" id="numbers" ><span id="recordNum"></span>条</td>
				</tr>
					<tr  id="trtip">
						<td class="EditHead">本次备份文件名</td>
						<td class="editTd" ><span id="filenametip"></span></td>						
					</tr>				
				<tr >
					<td class="" colspan="2" style="text-align: center;" >
					<a class="easyui-linkbutton" data-options="iconCls:'icon-export'"  onclick="backUpFun()">备份</a>
				</td>
				</tr>
			</table>
		</s:form>
		<br>
		<%-- 分类的sql
			select SUBSTRING(visit_time,1,10) ,count(SUBSTRING(visit_time,1,10))  from log_info GROUP by SUBSTRING(visit_time,1,10);
		 --%>
	</body>
</html>
