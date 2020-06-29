<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE HTML>
<s:text id="title" name="'整改问题信息'"></s:text>
<html>
	<head>
		<title>编辑审计决定问题</title>
		<link href="${contextPath}/styles/main/aisCommon.css" rel="stylesheet" type="text/css">
		<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
		<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/autosize.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
		<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/csswin/subModal.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/scripts/check.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/js/jquery-fileUpload.js"></script>
		
		<%-- <style>
			.a{
				BACKGROUND-COLOR: #ffffff;
				padding-left: 5px;
			}
		</style> --%>
	</head>
	<body>
		<center>
			<div class="easyui-panel" style="width:99%;padding:0px;" title="问题属性信息">
				<form id="ledgerForm">
				<table cellpadding=1 cellspacing=1 border=0 class="ListTable_change" id="tab1">
					<tr>
						<td class="EditHead" style="width: 15%">问题类别</td>
						<td class="editTd" style="width: 35%">
							<s:property  value="middleLedgerProblem.problem_all_name" />
							<s:hidden id="sort_big_code" name="middleLedgerProblem.sort_big_code" />
							<s:hidden id="sort_big_name" name="middleLedgerProblem.sort_big_name" />
							<s:hidden id="sort_small_code" name="middleLedgerProblem.sort_small_code" />
							<s:hidden id="sort_small_name" name="middleLedgerProblem.sort_small_name" />
							<s:hidden id="sort_three_code" name="middleLedgerProblem.sort_three_code" />
							<s:hidden id="sort_three_name" name="middleLedgerProblem.sort_three_name" />
						</td>
						<td class="EditHead" style="width: 15%">审计问题编号</td>
						<td class="editTd" style="width: 35%">
							<s:property  value="middleLedgerProblem.serial_num" />&nbsp;&nbsp;
						</td>
					</tr>
					<tr>
						<td class="EditHead" >问题点</td>
						<td class="editTd">
							<s:property  value="middleLedgerProblem.problem_name" id="problem_name"/> 
							<s:hidden name="middleLedgerProblem.problem_code" id="problem_code"></s:hidden> &nbsp;
						</td>
						<td class="EditHead" id="problemCommentText">备注(问题点为其他)</td>
						<td class="editTd" >
						<s:property  value="middleLedgerProblem.problemComment" id="problemComment"/>
						</td>
					</tr>
					<tr>
					<%-- 	<td class="EditHead">是否可量化</td>
						<td class="editTd">
							<s:property  value="middleLedgerProblem.quantify" id="quantify"/>
						</td> --%>
						<s:if test="middleLedgerProblem.pro_type == '020312'">
							<td class="EditHead">责任<div>(经济责任审计)</div></td>
							<td class="editTd" colspan="3"><s:property  value="middleLedgerProblem.zeren" id="zeren"/></td>
						</s:if>
						<s:else>
							<td class="EditHead">责任<div>(非经济责任审计)</div></td>
							<td class="editTd" colspan="3"><s:property  value="middleLedgerProblem.zeren" id="zeren"/></td>
						</s:else>
					</tr>
					<tr>
						<td class="EditHead">发生金额</td>
						<td class="editTd">
						<fmt:formatNumber value="${middleLedgerProblem.problem_money}" pattern="###.############"/>&nbsp;万元
						<td class="EditHead">发生数量</td>
						<td class="editTd"><s:property  value="middleLedgerProblem.problemCount" id="problemCount"/>&nbsp;个</td>
						
					</tr>
					
					<tr>
						<td class="EditHead">问题所属开始日期</td>
						<td class="editTd"><s:property  value="middleLedgerProblem.creater_startdate" id="creater_startdate"/></td>
						<td class="EditHead">问题所属结束日期</td>
						<td class="editTd"><s:property  value="middleLedgerProblem.creater_enddate" id="creater_enddate"/></td>
					</tr>
					<tr>
						<td class="EditHead">审计发现类型</td>
						<td class="editTd">
							<s:property  value="middleLedgerProblem.problem_grade_name" id="problem_grade_name"/>
						</td>
	               <%--      <td class="EditHead">会计制度类型</td>
						<td class="editTd">
							<s:property  value="middleLedgerProblem.accountantSystemTypeName" id="accountantSystemTypeName"/>
						</td> --%>
						 <td class="EditHead"></td>
						<td class="editTd"></td>
					</tr>
					<tr>
						<td class="EditHead">引用底稿</td>
						<td class="editTd">
							<s:property  value="middleLedgerProblem.linkManuName" id="linkManuName"/>
							<!--一般文本框-->
							<s:hidden name="middleLedgerProblem.linkManuId" />
						</td>
						<td class="EditHead">
							被审计单位
						</td>
						<td class="editTd">
							<s:property  value="middleLedgerProblem.audit_object_name" id="audit_object_name"/>
						</td>
					</tr>
				<tr>
					<td class="EditHead">问题标题</td>
					<td class="editTd" colspan="5">
						<textarea class='noborder'  name="middleLedgerProblem.audit_con" readonly="readonly"
								  rows="5" style="width:98%;line-height:150%;" UNSELECTABLE='on'>${middleLedgerProblem.audit_con}</textarea>
					</td>
				</tr>	
				<tr>
					<td class="EditHead">问题摘要</td>
					<td class="editTd" colspan="5">
						<textarea class='noborder' id="describe"  name="middleLedgerProblem.describe" readonly="readonly"
								  rows="5" style="width:98%;line-height:150%;" UNSELECTABLE='on'>${middleLedgerProblem.describe}</textarea>
					</td>
				</tr>	
				<tr>
					<td class="EditHead">定性依据</td>
					<td class="editTd" colspan="5">
						<textarea class='noborder' id="audit_law"  name="middleLedgerProblem.audit_law" readonly="readonly"
								  rows="5" style="width:98%;line-height:150%;" UNSELECTABLE='on'>${middleLedgerProblem.audit_law}</textarea>
					</td>
				</tr>					
				<tr>
					<td class="EditHead">审计建议</td>
					<td class="editTd" colspan="5">
						<textarea class='noborder' id="audit_advice"  name="middleLedgerProblem.audit_advice" readonly="readonly"
								  rows="5" style="width:98%;line-height:150%;" UNSELECTABLE='on'>${middleLedgerProblem.audit_advice}</textarea>
					</td>
				</tr>								
				</table>
				</form>
				</div>
				<%--<table cellpadding=1 cellspacing=1 border=0 bgcolor="#409cce"
					class="ListTable" id="tab1">
					<tr>
						<td class="EditHead" style="BACKGROUND-COLOR: #F5F5F5;">
						所属底稿
						</td>
						<td class="editTd">
							<s:property value="middleLedgerProblem.manuscript_name"/>
						</td>
						<td class="EditHead" style="BACKGROUND-COLOR: #F5F5F5;">
							审计小组
							
						</td>
						<td class="editTd">
							<s:property value="middleLedgerProblem.taskAssignName"/>
						</td>
					</tr>
					<tr>
						<td class="EditHead" style="BACKGROUND-COLOR: #F5F5F5;">
							被审计单位
						</td>
						<td class="editTd" colspan="3">
							<s:property value="middleLedgerProblem.audit_object_name"/>
						</td>
					</tr>
					<tr>
						<td class="EditHead">发现人</td>
						<td class="editTd">
							<s:property value="middleLedgerProblem.creater_name"/>
						</td>
						<td class="EditHead">发现时间</td>
						<td class="editTd">
							<s:property value="middleLedgerProblem.problem_date"/>
						</td>
					</tr>
					<tr>
						<td class="EditHead">审计事项</td>
						<td class="editTd" colspan="3">
							<s:property value="manuscript.task_name"/>
						</td>
					</tr>
					<tr>
						<td class="EditHead">问题类别</td>
						<td class="editTd" colspan="3">
							<s:property value="middleLedgerProblem.problem_all_name"/>
						</td>
					</tr>
					<tr>
						<td class="EditHead">问题点</td>
						<td class="editTd">
							<s:property value="middleLedgerProblem.problem_name"/>
						</td>
						<td class="EditHead">备注（问题点为其他）</td>
						<td class="editTd">
							<s:property value="middleLedgerProblem.problemComment"/>
						</td>
					</tr>
					<tr>
						<td class="EditHead">发生金额</td>
						<td class="editTd">
							<s:property value="middleLedgerProblem.problem_money"/>&nbsp;万元
						</td>
						<td class="EditHead">发生数量</td>
						<td class="editTd">
							<s:property value="middleLedgerProblem.problemCount"/>&nbsp;个
						</td>
					</tr>
					<tr>
						<td class="EditHead">问题所属开始日期</td>
						<td class="editTd">
							<s:property value="middleLedgerProblem.creater_startdate" />
						</td>
						<td class="EditHead">问题所属结束日期</td>
						<td class="editTd">
							<s:property value="middleLedgerProblem.creater_enddate" />
						</td>
					</tr>
					<tr>
						<td class="EditHead">审计发现类型</td>
						<td class="editTd">
							<s:property value="middleLedgerProblem.problem_grade_name" />
						</td>
						<td class="EditHead">会计制度类型</td>
						<td class="editTd" >
							<s:property value="middleLedgerProblem.accountantSystemTypeName" />
						</td>
					</tr>
					<tr>
						<s:if test="middleLedgerProblem.pro_type == '020312'">
							<td class="EditHead">责任<FONT color=red>*(经济责任审计)</FONT></td>
							<td class="editTd"><s:property value="middleLedgerProblem.zeren" /></td>
							<td class="EditHead"></td>
							<td class="editTd"></td>
						</s:if>
						<s:else>
							
						</s:else>
					</tr>
					<tr>
						<td class="EditHead">定性依据</td>
						<td class="editTd" colspan="3">
							<s:textarea name="middleLedgerProblem.problem_desc" title="定性依据" readonly="true"
								cssStyle="width:100%;color:gray;height:60" />
						</td>
					</tr>
					<tr>
						<td class="EditHead">问题摘要</td>
						<td class="editTd" colspan="3">
							<s:textarea name="manuscript.describe" title="问题摘要" readonly="true"
								cssStyle="width:100%;color:gray;height:60" />
						</td>
					</tr>
					<tr>
						<td class="EditHead">审计建议</td>
						<td class="editTd" colspan="3">
							<s:textarea name="middleLedgerProblem.aud_mend_advice" title="审计建议" readonly="true"
								cssStyle="width:100%;color:gray;height:60" />
						</td>
					</tr>
				</table>
				 --%>	
				 <br/>
				 <div class="easyui-panel" style="width:99%;padding:0px;overflow-x:hidden" title="问题整改要求">
				 <s:form id="myform" action="updateLedgerProblem" namespace="/proledger/problem">
				<table cellpadding=1 cellspacing=1 border=0 class="ListTable_change" id="tab2">
				<tr>
					<%--<td class="EditHead">是否整改</td>
					<td class="editTd">
						<s:select list="#@java.util.LinkedHashMap@{'否':'否'}"  
							name="middleLedgerProblem.isNotMend" id="isNotMend"  headerKey="是" headerValue="是"></s:select>
					</td> --%>
					<s:hidden name="middleLedgerProblem.isNotMend" id="isNotMend" value="是"/>
					<td class="EditHead" style="width:15%"><FONT color=red>*</FONT> 整改期限</td>
					<td class="editTd">
						<input type="text" id="mend_term" name="middleLedgerProblem.mend_term" value="${middleLedgerProblem.mend_term }" editable="false" Class="easyui-datebox noborder" style="width:140px;"/>
						--
				 		<input type="text" id="mend_term_enddate" name="middleLedgerProblem.mend_term_enddate" value="${middleLedgerProblem.mend_term_enddate }" editable="false"  Class="easyui-datebox noborder" style="width:140px;"/>
					
				<!-- 	<s:textfield name="middleLedgerProblem.mend_term" id="mend_term"
							readonly="true" title="单击选择日期" onclick="calendar()"
							cssStyle="width:30%" maxlength="20" />
					     	至
						<s:textfield name="middleLedgerProblem.mend_term_enddate"
							id="mend_term_enddate" readonly="true" title="单击选择日期"
							onclick="calendar()" cssStyle="width:30%" maxlength="20" />-->
					</td>
					<td class="EditHead" style="width:15%">监督检查人</td>
					<td class="editTd">
						<%-- 	<select id="examine_creater_code" class="easyui-combobox" name="middleLedgerProblem.examine_creater_code" editable="false" style="width:160px;" data-options="panelHeight:'auto'">
						       <option value="">&nbsp;</option>
						       <s:iterator value="%{memberList}" id="entry">
							         <s:if test="${middleLedgerProblem.examine_creater_code==userId}">
						       			<option selected="selected" value="<s:property value="userId"/>"><s:property value="userName"/>(<s:property value="roleName"/>)</option>
						       		 </s:if>
						       		 <s:else>
								        <option value="<s:property value="userId"/>"><s:property value="userName"/>(<s:property value="roleName"/>)</option>
						       		 </s:else>
						       </s:iterator>
						    </select>	
						    <s:hidden name="middleLedgerProblem.examine_creater_name" /> --%>
						    <s:property value="middleLedgerProblem.examine_creater_name" />
						    <s:hidden name="middleLedgerProblem.examine_creater_code" />
						</td>
				</tr>
				<tr>
					<td class="EditHead">整改方式</td>
					<%-- <td class="editTd">
						<s:select list="basicUtil.mendMethodList" listKey="code"
							listValue="name" emptyOption="true" cssStyle='width:260px'
							name="middleLedgerProblem.mend_method_code">
						</s:select>
					</td> --%>
					
					<td class="editTd">
							<select id="mend_method_code" class="easyui-combobox" name="middleLedgerProblem.mend_method_code" editable="false" style="width:200px;" data-options="panelHeight:125">
						       <option value="">&nbsp;</option>
						       <s:iterator value="basicUtil.mendMethodList" id="entry">
							         <s:if test="${middleLedgerProblem.mend_method_code==code}">
						       			<option selected="selected" value="<s:property value="code"/>"><s:property value="name"/></option>
						       		 </s:if>
						       		 <s:else>
								        <option value="<s:property value="code"/>"><s:property value="name"/></option>
						       		 </s:else>
						       </s:iterator>
						    </select>	
						</td>
					<td class="EditHead">检查方式</td>
					<%-- <td class="editTd">
						<s:select list="basicUtil.examineMethodList" listKey="code"
							listValue="name" emptyOption="true" cssStyle='width:260px'
							name="middleLedgerProblem.examine_method_code">
						</s:select>
					</td> --%>
					<td class="editTd">
							<select id="examine_method_code" class="easyui-combobox" name="middleLedgerProblem.examine_method_code" editable="false" style="width:160px;" data-options="panelHeight:75">
						       <option value="">&nbsp;</option>
						       <s:iterator value="basicUtil.examineMethodList" id="entry">
							         <s:if test="${middleLedgerProblem.examine_method_code==code}">
						       			<option selected="selected" value="<s:property value="code"/>"><s:property value="name"/></option>
						       		 </s:if>
						       		 <s:else>
								        <option value="<s:property value="code"/>"><s:property value="name"/></option>
						       		 </s:else>
						       </s:iterator>
						    </select>	
						</td>
				</tr>
				<tr>
					<td class="EditHead">
						整改责任单位
					</td>
					<td class="editTd">
						<s:property value="projectStartObject.audit_object_name"/>
					</td>
					<td class="EditHead">
						整改责任部门
					</td>
					<td class="editTd">
						<s:property value="projectStartObject.zeren_dept"/>
					</td>
				</tr>
				<tr>
				    <td class="EditHead">整改责任人</td>
					<td class="editTd">
						<s:property value="projectStartObject.zeren_person"/>
					</td>
					<td class="EditHead">联系电话</td>
					<td class="editTd">
						<s:property value="projectStartObject.telephone"/>
					</td>
				</tr>
				<tr>
					<%-- <td class="EditHead">
					<s:button onclick="Upload('file_id',accelerys,'true','true')" value="上传附件"></s:button>
					<s:hidden id="file_id" name="middleLedgerProblem.file_id" /></td>
					<td class="editTd" colspan="3">
						<div id="accelerys" align="center">
							<s:property escape="false" value="file_idList" />
						</div>
					</td> --%>
					
					<td class="EditHead" nowrap>附件
						<s:hidden id="file_id" name="middleLedgerProblem.file_id" />
					</td>
					<td class="editTd" colspan="3" >
							<div data-options="fileGuid:'${middleLedgerProblem.file_id}'"  class="easyui-fileUpload"></div>

					</td>
					
				</tr>
			</table>
			<s:hidden name="isEdit"/>
			<s:hidden name="permission"/>
			<s:hidden name="project_code" />
			<s:hidden name="project_id" />
			<s:hidden name="middleLedgerProblem.project_id" value="%{project_id}" />
			<s:hidden name="middleLedgerProblem.id" />
			</s:form>
		</div>
			<a class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="saveForm()">保存</a>&nbsp;&nbsp;
			<a class="easyui-linkbutton" data-options="iconCls:'icon-undo'" onclick="back()">返回</a>

		
	</center>
	<script language="javascript">
		function saveForm(){
			var mend_term = $('#mend_term').datebox('getValue');
			var mend_term_enddate = $('#mend_term_enddate').datebox('getValue');
			var isNotMend= document.getElementById("isNotMend").value;
			if(isNotMend=='是'){
				if(mend_term==null||mend_term==''){
		            alert("整改期限开始日期不能为空!");
            		return false;
				}
				if(mend_term_enddate==null||mend_term_enddate==''){
		            alert("整改期限结束日期不能为空!");
		            return false;
				}
				var dts=new Date(Date.parse(mend_term.replace(/-/g,"/")));
        		var dte=new Date(Date.parse(mend_term_enddate.replace(/-/g,"/")));
				if(dte<dts){
					alert("结束日期不能小于开始日期!");
		            return false;
				}
			}
			myform.submit();
			window.parent.saveCloseWin();
		}
		
		function back(){
		  /* window.location.href="${contextPath}/proledger/problem/overallMendLedger.action?project_id=${project_id}&isEdit=${isEdit}&permission=${permission}"; */
		  window.parent.closeWin();
		}
		//上传附件
		function Upload(id,filelist,delete_flag,edit_flag){
			var guid=document.getElementById(id).value;
			var num=Math.random();
			var rnm=Math.round(num*9000000000+1000000000);//随机参数清除模态窗口缓存
			window.showModalDialog('${contextPath}/commons/file/welcome.action?table_name=LedgerProblem&table_guid=file_id&guid='+guid+'&&param='+rnm+'&&deletePermission='+delete_flag+'&&isEdit='+edit_flag,filelist,'dialogWidth:700px;dialogHeight:450px;status:yes');
		}
		//删除方法
 		/*
 			1.第一个参数是附件表的主键ID，第二个参数是该类附件的删除权限，第三个参数是附件的应用类型
 			2.该方法的参数由ais.file.service.imp.FileServiceImpl中的
 				getDownloadListString(String contextPath, String guid,String bool, String appType)生成的HTML产生
 		*/
     function deleteFile(fileId,guid,isDelete,isEdit,appType,title){
		var boolFlag=window.confirm("确认删除吗?");
		if(boolFlag==true)
		{
				DWREngine.setAsync(false);DWRActionUtil.execute(
			{ namespace:'/commons/file', action:'delFile', executeResult:'false' }, 
			{'fileId':fileId, 'deletePermission':isDelete, 'isEdit':isEdit, 'guid':guid, 'appType':appType,'title':title},
			xxx);
			function xxx(data){
			  	document.getElementById(guid).parentElement.innerHTML=data['accessoryList'];
			} 
		}
	}
		//选择监督检查人
        	function  getSupervisor(){
           		var code=document.getElementsByName("project_id")[0].value;
           		showPopWin('/ais/pages/system/search/searchdata.jsp?url=<%=request.getContextPath()%>/proledger/problem/selectMember.action&a=a&project_id='+code+'&paraname=middleLedgerProblem.examine_creater_name&paraid=middleLedgerProblem.examine_creater_code',400,300,'人员选择')
        	}
		$(function(){
			$("#ledgerForm").find("textarea").each(function(){
				autoTextarea(this);
			});
		});
	</script>
	</body>
</html>
