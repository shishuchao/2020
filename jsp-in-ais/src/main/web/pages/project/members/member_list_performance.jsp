<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="ais.sysparam.util.SysParamUtil"%>
<html>
	<head>
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet" type="text/css">
		<link href="${contextPath}/styles/main/manu.css" rel="stylesheet" type="text/css">
		<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/csswin/subModal.js"></script>
		<SCRIPT type="text/javascript" src="${contextPath}/scripts/calendar.js"></SCRIPT>
		<script lang="javascript">	            
         function checkAll(checkbox){
		    if(checkbox.checked){
				var checkbox=document.getElementsByName("userIds"); 	
			    for(var i=0;i<checkbox.length;i++){
			      if(checkbox[i].disabled==true){
			      }else{
			        checkbox[i].checked=true; 
			      }
			       
			     } 
			}else{
			
			     var checkbox=document.getElementsByName("userIds"); 	
			    for(var i=0;i<checkbox.length;i++)
			      if(checkbox[i].disabled==true){
			      }else{
			        checkbox[i].checked=false; 
			      } 
			}		    			       				    
        }
		
		function recal(){
		  var crudId = document.getElementsByName("crudId")[0].value;
	      var url = "${contextPath}/project/getMembersForPerformance.action?crudId="+crudId;
          window.location = url;
        }
        function checkSelect(){
		     var checkbox=document.getElementsByName("userIds"); 	
			 for(var i=0;i<checkbox.length;i++){
			       if(checkbox[i].checked==true){
			        return true;
			       }
			 }
			 alert("请选择项目成员！");
			 return false;			    
        }
        function cancelAuth(){
        	 var flag = false;
	         if(confirm('确定取消授权吗?')){
				 if(checkSelect()){
					 var form = document.getElementById('myform');
		         	 form.action='${contextPath}/project/cancelAccessoryAuth.action';
		         	 form.submit();
				 }
	         }
        }
       </script>
		<title>个人绩效考核页面</title>
	<script type="text/javascript" src="${contextPath}/scripts/jquery-1.4.3.min.js"></script>
	<script type="text/javascript">
	$(function(){
	  var a = document.getElementsByName("score");
	  var b = document.getElementsByName("scoreKey");
	  for(var i = 0;i<b.length;i++){      
	     		if(a[i].options[0].value==b[i].value){
	     			a[i].options[0].selected=true;
	     			continue;
	     		}else if(a[i].options[1].value==b[i].value){
	     			a[i].options[1].selected=true;
	     			continue;
	     		}else if(a[i].options[2].value==b[i].value){
	     			a[i].options[2].selected=true;
	     			continue;
	     		}else if(a[i].options[3].value==b[i].value){
	     			a[i].options[3].selected=true;
	     			continue;
	     		}else if(a[i].options[4].value==b[i].value){
	     			a[i].options[4].selected=true;
	     			continue;
	     		}
	  }
	   
	 })
	</script>
	</head>	 
	<body>	 
	<center>	     
       <form id="myform" name="my_form" onsubmit="return checkSelect();" action="${contextPath}/project/saveMembersPerformance.action" method="post">
       <input type="hidden" name="crudId" value="${crudId}">
       <display:table id="proMember" name="members" pagesize="10" class="its" requestURI="${contextPath}/project/getMembersForPerformance.action">
					<display:column title="选择<input name='manuAll' type='checkbox' onclick='checkAll(this)' />" headerClass="center" class="center">						
							<input name='userIds' type='checkbox' value='${proMember.userId}' />&nbsp;&nbsp;
					</display:column>					
					<display:column property="userName" title="姓名" headerClass="center" class="center" style="WHITE-SPACE: nowrap"  sortable="true"/>
					<display:column property="belongToUnitName" title="所属单位" headerClass="center" class="center" style="WHITE-SPACE: nowrap"  sortable="true"/>
					<display:column title="考核评价" headerClass="center" class="center" style="WHITE-SPACE: nowrap"  sortable="true">						
						<select name="score" id="score">
							<option value=""></option>
							<option value="4">优秀</option>
							<option value="3">良好</option>
							<option value="2">合格</option>
							<option value="1">不合格</option>						
						</select>
						<input name="scoreKey" type="hidden" value="${proMember.score}" />
					</display:column>
					<display:column title="查看" headerClass="center" class="center"  media="html" style="WHITE-SPACE: nowrap">
						<s:if test="${proMember.isOutSystem!='Y'}">
							<% if(SysParamUtil.getSysParam("ais.prepare.employee.link")==null || SysParamUtil.getSysParam("ais.prepare.employee.link").equals("Y")){%>
								<a href="${contextPath}/mng/employee/employeeInfoView.action?ul=${proMember.userId}" target="_blank">人员信息</a>&nbsp;
							<%}%>
							<a href="${contextPath}/mng/examproject/members/audProjectMembersInfo/lookAtDetail.action?ul=${proMember.userId}" target="_blank">人员状态</a>
						</s:if>
					</display:column>
				</display:table>
				<br/>		   		
				<div align="right">
					<s:submit value="提交"/>
					&nbsp;&nbsp;
					<s:button value="重置" onclick="recal();"/>
					&nbsp;&nbsp;
				</div>
		</form>
	</center>
	</body>
</html>
