<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.util.List"%>
<%@ page import="ais.operate.task.model.AudMember"%>
<s:text id="title" name="'项目小组列表'"></s:text>
<html>
	<head>
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet"
			type="text/css">
		<link href="${contextPath}/styles/main/manu.css" rel="stylesheet"
			type="text/css">
		<link href="${contextPath}/resources/csswin/subModal.css"
			rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
		<script type="text/javascript"
			src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript"
			src="${contextPath}/resources/csswin/subModal.js"></script>
		<script lang="javascript">
		
		    
		   
		  //反选
		  function uncheckAll(){
		    
		    var checkbox=document.getElementsByName("manuIds"); 	
			    for(var i=0;i<checkbox.length;i++)
			     checkbox[i].checked=false;   	
			    
          }
          
          //全选
          function checkAll(checkbox){
		    if(checkbox.checked){
				var checkbox=document.getElementsByName("manuIds"); 	
			    for(var i=0;i<checkbox.length;i++){
			       checkbox[i].checked=true; 
			     } 
			}else{
			
			     var checkbox=document.getElementsByName("manuIds"); 	
			    for(var i=0;i<checkbox.length;i++)
			     checkbox[i].checked=false;   
			}

		    
			       	
			    
          }
		//重置
		function searchrecal(){
	      var url = "${contextPath}/operate/task/project/groupList.action?project_id=${project_id}&taskPid=${taskPid}&taskTemplateId=${taskTemplateId}&tree=${tree}";
          window.location = url;
        }
  
  
        //保存
        function saveFormTree(){
          var url = "${contextPath}/operate/task/project/saveGroup.action";
          myform.action = url;
	      myform.submit();
	      window.top.frames['f_left'].location.href='${contextPath}/operate/task/project/showTreeListEdit.action?node=${node}&path=${path}&project_id=<%=request.getParameter("project_id")%>';
	      window.top.frames['topFrame'].location.href='${contextPath}/operate/task/project/editGroup.action?project_id=<%=request.getParameter("project_id")%>';
         }
        
       
         //检查选择项
         function checkSelect(){
		    var checkbox=document.getElementsByName("manuIds"); 	
			    for(var i=0;i<checkbox.length;i++){
			       if(checkbox[i].checked==true){
			        return true;
			       }
			    }
			    alert("请选择项目小组！");
			    return false;  	
			    
          }

       </script>
		<title><s:property value="#title" />
		</title>
		<s:head />
	</head>




	<body>

		<center>

			<form id="myform" name="my_form" onsubmit="return checkSelect();"
				action="/ais/operate/task/project/saveMemberList.action"
				method="post" style="">
				<s:hidden name="project_id" />
				<s:hidden name="taskPid" />
				<s:hidden name="taskTemplateId" />
				<s:hidden name="tree" />
				<table cellpadding=1 cellspacing=1 border=0 bgcolor="#409cce"
					class="ListTable">
					<tr class="listtablehead">
						<td colspan="5" align="left" class="edithead">
							&nbsp;项目小组列表
						</td>



					</tr>

					<tr align="center" class="titletable1">



						<td width=50%>
							<center>
								组名
							</center>
						</td>

						<td width=50%>
							<center>
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<input name='manuAll' type='checkbox' onclick="checkAll(this)" />
								选择
							</center>

						</td>

					</tr>
					<%
						List list = (List) request.getAttribute("memberInfoList");
						for (int a = 0; a < list.size(); a++) {
							AudMember audMember = (AudMember) list.get(a);
							if (audMember != null) {

							} else {
								continue;
							}

							String linked = audMember.getLinked();//回显已经选择的
							String work = audMember.getWork();//分工的标志
					       %>


                       <tr>
                       <td class="listtabletr2"
								style='word-break: break-all; word-wrap: break-word; width: 50%'>
                                
								<center>
								<%if("1".equals(work)){%>
								<img src='/ais/cloud/images/edit.gif' title='已分工'>
								 
								<%} %>
									<%= audMember.getUser_name()%>
								</center>
							</td>

					<td class="ListTableTr2">
						<center>

							
							   <%if("1".equals(linked)){%>
								    <input name='manuIds' type='checkbox' checked=false' value='<%= audMember.getUser_code()%>,<%= audMember.getUser_name()%>' />
								<%}else{%> 
									<input name='manuIds' type='checkbox' value='<%= audMember.getUser_code()%>,<%= audMember.getUser_name()%>' />
								<%}%>
								

						</center>
					</td>
 
							
						</tr>
						<%}%>
				</table>
				<s:hidden name="path" />
				<s:hidden name="node" />
				<div align="right">
					 <s:if test="${teamAuth=='1'}">
					<s:button value="保存" onclick="javascript:saveFormTree();" />
					&nbsp;&nbsp;
					<s:button value="重置" onclick="javascript:searchrecal();" />
					&nbsp;&nbsp;
                     </s:if>


				</div>

			</form>
		</center>
	</body>
</html>
