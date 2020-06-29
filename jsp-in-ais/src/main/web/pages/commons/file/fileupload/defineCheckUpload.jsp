<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<base target="_self">
	<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
		<title>选择审计方案文件添加至当前模块</title>
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet"
			type="text/css">
		<SCRIPT type="text/javascript"
			src="${contextPath}/scripts/calendar.js"></SCRIPT>
		<link rel="stylesheet" type="text/css"
			href="${contextPath}/resources/csswin/subModal.css" />
		<script type="text/javascript"
			src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript"
			src="${contextPath}/resources/csswin/subModal.js"></script>
		<script type="text/javascript"
			src="${contextPath}/scripts/ais_functions.js"></script>
       <script type="text/javascript">
	function checkfun(){
	var url = "${contextPath}/commons/file/welcome.action";
	tempForm.action = url;
	tempForm.submit();
	}
	

	
	
	
function sub(){ 
var f=0; 
var len = document.getElementsByName("checked_guid").length;
for(var i=0;i<len; i++){
if(document.getElementsByName("checked_guid")[i].checked == true){
	f=1; 
	break; 
		}
	} 
if(f==0){
 alert("请选择审计方案！"); 
 return false;
}
var flag =  confirm('确认导入审计方案?');
 if(flag){
       welForm.action = "<s:url action="welcome" includeParams="none"/>";
	   welForm.submit();
	   return true;
	   }else{
	   return false;
	   }
} 
		</script>
	</head>
<body onload="onloadPage()">
	
	<form name="tempForm" method="post">
	<s:hidden name="title"/>
	<s:hidden name="guid" />
	<s:hidden name="deletePermission" />
	<s:hidden name="isEdit" />
	<s:hidden id="onlyOne" name="onlyOne" />
	<s:hidden name="fromCheckFile" value="false"/>
	<s:hidden id="rewrite" name="rewrite" />
	</form>
		<center>
			<table>
				<tr class="listtablehead">
					<td colspan="5" align="left" class="edithead">
						方案对象选择列表
					</td>
				</tr>
			</table>
			<s:form action="welcome" namespace="/commons/file" method="post" name="welForm">
			
			<s:hidden name="title"/>
			
				<display:table id="row" name="checkList" pagesize="10"
					class="its" requestURI="${contextPath}/commons/file/defineCheck.action">
					<display:column title="选择" media="html" headerClass="center"
						class="center">
						<input type="radio" name="checked_guid" value="${row.muuid}" />
					</display:column>
					<display:column title="方案编号" headerClass="center" class="center"
						property="codification" maxLength="10" sortable="true"></display:column>
					<display:column title="方案名称" headerClass="center" class="center"
						property="title" maxLength="10" sortable="true"></display:column>
					<display:setProperty name="paging.banner.placement" value="bottom" />
				</display:table>
									<br>
									<div align="center">
				<s:if test="checkList.size!=0">

<%--						<input type="button" name="Submit" value="全选"--%>
<%--							onClick="selectAll(welcome)">--%>
<%--						&nbsp;--%>
<%--						<input type="button" name="Submit2" value="反选"--%>
<%--							onClick="inverse(welcome)">--%>
<%--						&nbsp;--%>
							<br><br>

<%--                        <s:button  value="选择导入"  onclick="return sub();"/>--%>
               <s:if test="%{fileList.size>=1&&onlyOne==true}">
				</s:if>
				<s:else>
<%--                          <s:submit  value="选择导入"  />--%>
                          <s:button  value="选择导入"  onclick="return sub();"/>
              </s:else> 
              </s:if>
              			 &nbsp;	&nbsp;<s:button  name="okBnt" disabled="true"  onclick="window.close();" value="关 闭" />      
					</div>
					<br><br>
		
				<div align="right">
<%--				<s:button onclick="checkfun()" value="取 消" />--%>
					&nbsp;	&nbsp;
				</div>
				<s:hidden name="guid" />
				<s:hidden name="deletePermission" />
	            <s:hidden name="isEdit" />
				<s:hidden name="fromCheckFile"  value="true"/>
				<s:hidden id="onlyOne" name="onlyOne" />
				<s:hidden id="rewrite" name="rewrite" />
				
			</s:form>

		</center>
	</body>
<script>
function onloadPage(){
	var arg = window.dialogArguments;
	if(document.getElementById('rewrite').value==null||document.getElementById('rewrite').value==''||document.getElementById('rewrite').value!='true'){
		if(arg!=undefined){
		arg.innerHTML='<s:property escape="false" value="accessoryList"/>';
		}
	    //准备阶段上传审计方案的其他附件		
         if(arg!=undefined && arg.fun!=undefined){
                  arg.fun.call();
                    }
	}
	else{
		arg.location.reload();
	}
		document.all.okBnt.disabled = false;  //初始化完成了，按钮disabled设置成false（可用）
}

</script>
</html>
