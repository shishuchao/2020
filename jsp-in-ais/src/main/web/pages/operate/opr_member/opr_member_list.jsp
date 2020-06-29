<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.util.List"%>
<%@ page import="ais.operate.task.model.AudMember"%>
<%@ page import="ais.sysparam.util.SysParamUtil"%>
<s:text id="title" name="'审计分工审计人员列表'"></s:text>
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
			 <!-- 引入dwr的js文件 -->
		<script type='text/javascript' src='/ais/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='/ais/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='/ais/dwr/engine.js'></script>
		<script type='text/javascript' src='/ais/dwr/util.js'></script>
		<script lang="javascript">
		    /**
			*	打开增加外部用户页面
			*/
			function openAddOutSystemMemberPage(){
				showPopWin('${contextPath}/project/members/editMember.action?projectFormId=${project_id}&addMemberOption=outSystem',750,660,'title');
			}
			
			/**
				打开添加组员页面
			*/
			function openAddMemberPage(){
			  	showPopWin('${contextPath}/project/members/editMember.action?projectFormId=${project_id}',750,660,'title');
			}
		   
		  function uncheckAll(){
		    var checkbox=document.getElementsByName("manuIds"); 	
			    for(var i=0;i<checkbox.length;i++)
			     checkbox[i].checked=false;   	
			    
          }
          
           function checkAll(checkbox){
		    if(checkbox.checked){
				var checkbox=document.getElementsByName("manuIds"); 	
			    for(var i=0;i<checkbox.length;i++){
			      if(checkbox[i].disabled==true){
			      }else{
			        checkbox[i].checked=true; 
			      }
			     } 
			}else{
			    var checkbox=document.getElementsByName("manuIds"); 	
			    for(var i=0;i<checkbox.length;i++)
			      if(checkbox[i].disabled==true){
			      }else{
			        checkbox[i].checked=false; 
			      } 
			}
          }
		
		function searchrecal(){
	      var url = "${contextPath}/operate/task/project/memberList.action?project_id=${project_id}&taskPid=${taskPid}&taskTemplateId=${taskTemplateId}&tree=${tree}";
          window.location = url;
        }
        
        function saveFormTree(){
         var resullt=''; 
         var code='';
         var codeAll='';
          var checkbox=document.getElementsByName("manuIds"); 	
			    for(var i=0;i<checkbox.length;i++){
			       if(checkbox[i].checked==true){
			         //alert(checkbox[i].value);//
			         if((checkbox[i].value)!=null){
			           var arrayTemp = (checkbox[i].value).split(',');
			           if(code==''){
			            code=arrayTemp[0];
			           }else{
			              code=code+','+arrayTemp[0];
			           }
			           if(codeAll==''){
			            codeAll=arrayTemp[0];
			           }else{
			              codeAll=codeAll+','+arrayTemp[0];
			           }
			         }
			       }else{
			          var arrayTemp = (checkbox[i].value).split(',');
			           if(codeAll==''){
			            codeAll=arrayTemp[0];
			           }else{
			              codeAll=codeAll+','+arrayTemp[0];
			           }
			       }
			    }
			    document.getElementById("memIds").value=code;
			    document.getElementById("memAllIds").value=codeAll;
			     var project_id='${project_id}';
			     var taskPid='${taskPid}';
			     var taskTemplateId='${taskTemplateId}';
			      var memIds=document.getElementById("memIds").value;
			      var memAllIds=document.getElementById("memAllIds").value;
				 DWREngine.setAsync(false);
				 DWREngine.setVerb("POST");
					DWREngine.setAsync(false);DWRActionUtil.execute(
				{ namespace:'/operate/task/project', action:'checkMembers', httpMethod:'POST',executeResult:'false' }, 
				{'project_id':project_id,'taskPid':taskPid,'taskId':taskTemplateId,'memIds':memIds,'memAllIds':memAllIds},xxx);
			     function xxx(data){
			     result =data['auth'];
				} 
		        if(result==''||result==null){
		        	
		        }else{
		         if( confirm(result+"在下级节点已经分工，是否删除本级节点的分工?\n点'确定'按钮保存本级节点分工，点'取消'按钮重新设置本级节点分工。")){
		         
		         }else{
		            return false;
		         }
		        }
		        //return false;
		          var url = "${contextPath}/operate/task/project/saveMemberList.action";
		          myform.action = url;
			      myform.submit();
			      window.top.frames['f_left'].location.href='${contextPath}/operate/task/project/showTreeListEdit.action?node=${node}&path=${path}&project_id=<%=request.getParameter("project_id")%>';
			      //window.top.frames['topFrame'].location.href='${contextPath}/operate/task/project/editGroup.action?project_id=<%=request.getParameter("project_id")%>';
         }
        
       function closeGenM(){
         window.parent.closeGenW('MS');
         window.close()
       }
 
         function checkSelect(){
		    var checkbox=document.getElementsByName("manuIds"); 	
			    for(var i=0;i<checkbox.length;i++){
			       if(checkbox[i].checked==true){
			        return true;
			       }
			    }
			    alert("请选择项目成员！");
			    return false;  	
			    
          }

       </script>
		<SCRIPT type="text/javascript"
			src="${contextPath}/scripts/calendar.js"></SCRIPT>
		<script type='text/javascript'
			src='${pageContext.request.contextPath}/js/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript'
			src='${pageContext.request.contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript'
			src='${pageContext.request.contextPath}/dwr/engine.js'></script>
		<title><s:property value="#title" /></title>
		<s:head />
	</head>
	<body>
	<center>
		<form id="myform" name="my_form" onsubmit="return checkSelect();"
				action="/ais/operate/task/project/saveMemberList.action" method="post"
				style=""> 
			 <table cellpadding=1 cellspacing=1 border=0 bgcolor="#409cce"
		class="ListTable">
		<tr class="listtablehead">
			 	<s:hidden name="project_id" />
				<s:hidden name="taskPid" />
				<s:hidden name="memIds" />
				<s:hidden name="memAllIds" />
				<s:hidden name="taskTemplateId" />
				<s:hidden name="tree" />
				<td colspan="5" align="left" class="edithead">
					&nbsp;项目组成员列表
				</td>
				</tr>
					<tr align="center" class="titletable1">
						<td width=20%>
							<center>
								组别
							</center>
						</td>
						<td width=20%>
							<center>
								姓名
							</center>
						</td>
						<td>
							<center width=20%>
								职务
							</center>
						</td>
						<td width=20%>
							<center>
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<input name='manuAll' type='checkbox' onclick="checkAll(this)" />
								选择
							</center>
						</td>
						<%
							if (SysParamUtil.getSysParam("ais.prepare.employee.link") == null
									|| SysParamUtil.getSysParam("ais.prepare.employee.link")
											.equals("Y")) {
						%>
						<td width=20%>
							<center>
								人员信息
							</center>
						</td>
						<%
							}
						%>
					</tr>
					<%
						List list = (List) request.getAttribute("memberInfoList");
						for (int a = 0; a < list.size(); a++) {
							AudMember audMember = (AudMember) list.get(a);
							if (audMember != null) {

							} else {
								continue;
							}
							//System.out.println(audManuscript);

							String linked = audMember.getLinked();//回显标志，是否打勾
							String work = audMember.getWork();//显示是否分工图片的
							String selected = audMember.getSelected();//是否是变灰的disabled
					%>
                       <tr>
	                       <td class="listtabletr2"
									style='word-break: break-all; word-wrap: break-word; width: 20%'>
									<center>
										<%=audMember.getGroup()%>
									</center>
							</td>
	                       <td class="listtabletr2"
									style='word-break: break-all; word-wrap: break-word; width: 20%'>

								<center>
								    <%if("1".equals(work)){%>
								<img src='/ais/cloud/images/edit.gif' title='已分工'>
								 
								<%} %>
									<%=audMember.getUser_name()%>
								</center>
							</td>
							<td class="listtabletr2" style='word-break: break-all; word-wrap: break-word; width: 20%'>
								<center>
									<%=audMember.getDuty()%>
								</center>
							</td>
						<!-- 选择值START -->
						<td class="ListTableTr2">
							<center>
                            <%
                            	if ("true".equals(selected)) {
                            %>
							<%
								if ("1".equals(linked)) {    //linked回显标志，是否打勾
							%>
							    <input name='manuIds' type='checkbox' 
								checked=false' value='<%=audMember.getUser_code()%>,<%=audMember.getUser_name()%>,<%=audMember.getProMemberId()%>,<%=audMember.getGroupId()%>' />
								<%
									} else {
								%> 
								<input name='manuIds' type='checkbox' 
								  value='<%=audMember.getUser_code()%>,<%=audMember.getUser_name()%>,<%=audMember.getProMemberId()%>,<%=audMember.getGroupId()%>' />
								<%
									}
								%>
							<%
								} else {
							%>	
							
							<%
								if ("1".equals(linked)) {
							%>
							    <input name='manuIds' type='checkbox' 
								checked=false' disabled='true' value='<%=audMember.getUser_code()%>,<%=audMember.getUser_name()%>,<%=audMember.getProMemberId()%>,<%=audMember.getGroupId()%>' />
								<%
									} else {
								%> 
								<input name='manuIds' type='checkbox'  disabled='true'
								  value='<%=audMember.getUser_code()%>,<%=audMember.getUser_name()%>,<%=audMember.getProMemberId()%>,<%=audMember.getGroupId()%>' />
								<%
									}
								%>
                           <%
                           	}
                           %>
						</center>
					</td>
					<!-- 选择值END -->
					<%
							if (SysParamUtil.getSysParam("ais.prepare.employee.link") == null
														|| SysParamUtil
																.getSysParam("ais.prepare.employee.link")
																.equals("Y")) {
					%>
					<td class="listtabletr2">
					<center>
								<a href='/ais/mng/employee/employeeInfoView.action?ul=<%=audMember.getUser_code()%>' 
								target='_blank'>人员信息</a>  
								</center>
				  </td>
							<%
  								}
  							%>
				</tr>
			   <%
			   	}
			   %>
				</table>
				<div align="right">
					  <s:if test="${teamAuth=='1'}">
					<s:button value="保存" onclick="javascript:saveFormTree();" />
					&nbsp;&nbsp;
                     </s:if>
				</div>
		</form>
	</center>
	</body>
</html>
