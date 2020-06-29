<!DOCTYPE HTML>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="fmt"%>
<s:text id="title" name="'整改问题信息'"></s:text>
<html>
	<head>
		<title>编辑审计决定问题</title>
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
		<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/autosize.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/csswin/subModal.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/scripts/check.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/js/jquery-fileUpload.js"></script>
		<link href="${contextPath}/styles/main/aisCommon.css" rel="stylesheet" type="text/css">
		<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
		$(document).ready(function(){
			$("#myFirstform").find("textarea").each(function(){
				autoTextarea(this);
			});
		});	
		</script>
		<style>
			.a{
				BACKGROUND-COLOR: #ffffff;
				padding-left: 5px;
			}
		</style>
	</head>
	<body>
		<center>
			<div class="easyui-panel" style="width:99%;padding:0px;" title="问题属性信息">
			<center>
			 <s:form id="myFirstform">
				<table cellpadding=1 cellspacing=1 border=0 class="ListTable" style="width:98%;padding:0px;" id="tab1">
					<tr>
						<td class="EditHead">问题类别</td>
						<td class="editTd" >
							<%-- <s:textfield id="problem_all_name" name="middleLedgerProblem.problem_all_name" cssStyle="width:60%" disabled="true" />&nbsp;&nbsp; --%>
							<s:property  id="problem_all_name" value="middleLedgerProblem.problem_all_name" />
							<s:hidden id="sort_big_code" name="middleLedgerProblem.sort_big_code" />
							<s:hidden id="sort_big_name" name="middleLedgerProblem.sort_big_name" />
							<s:hidden id="sort_small_code" name="middleLedgerProblem.sort_small_code" />
							<s:hidden id="sort_small_name" name="middleLedgerProblem.sort_small_name" />
							<s:hidden id="sort_three_code" name="middleLedgerProblem.sort_three_code" />
							<s:hidden id="sort_three_name" name="middleLedgerProblem.sort_three_name" />
						</td>
						<td class="EditHead">审计问题编号</td>
						<td class="editTd" >
							<%-- <s:textfield name="middleLedgerProblem.serial_num" cssStyle="width:60%" disabled="true" />&nbsp;&nbsp; --%>
							<s:property  id="serial_num" value="middleLedgerProblem.serial_num" />
						</td>
					</tr>
					<tr>
						<td class="EditHead" width="15%">问题点</td>
						<td class="editTd" width="35%">
							<%-- <s:textfield name="middleLedgerProblem.problem_name" id="problem_name" cssStyle="width:60%" disabled="true" />  --%>
							<s:property  id="problem_name" value="middleLedgerProblem.problem_name" />
							<s:hidden name="middleLedgerProblem.problem_code" id="problem_code"></s:hidden> &nbsp;
						</td>
						<td class="EditHead" id="problemCommentText"  width="15%">备注(问题点为其他)</td>
						<td class="editTd" width="35%">
						<%-- <s:textarea name="middleLedgerProblem.problemComment" id="problemComment" disabled="true" cssStyle="width:60%;height:30px;display:none" /> --%>
						<s:property  id="problemComment" value="middleLedgerProblem.problemComment" />
						</td>
					</tr>
					<tr>
				<%-- 		<td class="EditHead">是否可量化</td>
						<td class="editTd">
							<s:textfield name="middleLedgerProblem.quantify" cssStyle="width:60%" disabled="true"/>
							<s:property  id="quantify" value="middleLedgerProblem.quantify" />
						</td> --%>
						<s:if test="middleLedgerProblem.pro_type == '020312'">
							<td class="EditHead">责任<div>(经济责任审计)</div></td>
							<td class="editTd" >
								<%-- <s:textfield name="middleLedgerProblem.zeren" cssStyle="width:60%" disabled="true"/> --%>
								<s:property  id="zeren" value="middleLedgerProblem.zeren" />
							</td>
							<td class="EditHead" ></td>
						     <td class="editTd">
							</td>
						</s:if>
						<s:else>
							<td class="EditHead">责任<div>(非经济责任审计)</div></td>
							<td class="editTd" >
								<%-- <s:textfield name="middleLedgerProblem.zeren" cssStyle="width:60%" disabled="true"/> --%>
								<s:property  id="zeren" value="middleLedgerProblem.zeren" />
							</td>
							<td class="EditHead" ></td>
						     <td class="editTd">
							</td>
						</s:else>
					</tr>
					<tr>
						<td class="EditHead">发生金额</td>
						<td class="editTd">
							<%-- <s:textfield name="middleLedgerProblem.problem_money" id="problem_money" disabled="true" cssStyle="width:60%" doubles="true" maxlength="15" /> --%>
							<%-- <s:property  id="problem_money" value="middleLedgerProblem.problem_money" /> --%>
							<fmt:formatNumber pattern="##################.##"  minFractionDigits="2" >${middleLedgerProblem.problem_money}</fmt:formatNumber>
							&nbsp;万元
						</td>
						<td class="EditHead">发生数量</td>
						<td class="editTd">
							<%-- <s:textfield name="middleLedgerProblem.problemCount" id="problemCount" disabled="true" cssStyle="width:60%" doubles="true" maxlength="5" /> --%>
							<s:property  id="problemCount" value="middleLedgerProblem.problemCount" />
							&nbsp;个</td>
						
					</tr>
					
					<tr>
						<td class="EditHead" style="width:20%">问题所属开始日期</td>
						<td class="editTd">
							<%-- <s:textfield name="middleLedgerProblem.creater_startdate" id="creater_startdate" disabled="true"  cssStyle="width:60%" maxlength="20" /> --%>
							<s:property  id="creater_startdate" value="middleLedgerProblem.creater_startdate" />
							</td>
						<td class="EditHead" style="width:20%">问题所属结束日期</td>
						<td class="editTd">
							<%-- <s:textfield name="middleLedgerProblem.creater_enddate" id="creater_enddate" disabled="true"  cssStyle="width:60%" maxlength="20" /> --%>
							<s:property  id="creater_enddate" value="middleLedgerProblem.creater_enddate" />
							</td>
					</tr>
					<tr>
						<td class="EditHead">审计发现类型</td>
						<td class="editTd">
							<%-- <s:textfield name="middleLedgerProblem.problem_grade_name" cssStyle="width:60%" disabled="true"/> --%>
							<s:property  id="problem_grade_name" value="middleLedgerProblem.problem_grade_name" />
						</td>
	                <%--     <td class="EditHead">会计制度类型</td>
						<td class="editTd">
							<s:property  id="accountantSystemTypeName" value="middleLedgerProblem.accountantSystemTypeName" />
						</td> --%>
						 <td class="EditHead"></td>
						<td class="editTd"></td>
					</tr>
					<tr>
						<td class="EditHead">引用底稿</td>
						<td class="editTd">
							<%-- <s:textfield name="middleLedgerProblem.linkManuName" cssStyle="width:60%" disabled="true" /> --%>
							<s:property  id="linkManuName" value="middleLedgerProblem.linkManuName" />
							<!--一般文本框-->
							<s:hidden name="middleLedgerProblem.linkManuId" />
						</td>
						<td class="EditHead">
							被审计单位
						</td>
						<td class="editTd">
							<%-- <s:textfield name="middleLedgerProblem.audit_object_name" cssStyle="width:60%" disabled="true" /> --%>
							<s:property  id="audit_object_name" value="middleLedgerProblem.audit_object_name" />
						</td>
					</tr>
				<tr>
					<td class="EditHead">问题标题</td>
					<td class="editTd" colspan="5">
						<%-- <s:textarea cssClass='autoResizeTexareaHeight' name="middleLedgerProblem.audit_con" title="问题标题" readonly="true"
							cssStyle="width:100%;height:70;" />
						<input type="hidden" id="middleLedgerProblem.audit_con.maxlength" value="2000"/> --%>	
						<s:property value="middleLedgerProblem.audit_con"/>				
					</td>
				</tr>	
				<tr>
					<td class="EditHead">问题摘要</td>
					<td class="editTd" colspan="5">
							<textarea class='noborder'  name="middleLedgerProblem.describe" readonly="readonly"
									  rows="5" style="width:98%;overflow-y:visible;line-height:150%;" UNSELECTABLE='on'>${middleLedgerProblem.describe}</textarea>						
					</td>
				</tr>	
				<tr>
					<td class="EditHead">定性依据</td>
					<td class="editTd" colspan="5">
						<textarea class='noborder'  name="middleLedgerProblem.audit_law" readonly="readonly"
									  rows="5" style="width:98%;overflow-y:visible;line-height:150%;" UNSELECTABLE='on'>${middleLedgerProblem.audit_law}</textarea>
					</td>
				</tr>					
				<tr>
					<td class="EditHead">审计建议</td>
					<td class="editTd" colspan="5">
					<textarea class='noborder'  name="middleLedgerProblem.audit_advice" readonly="readonly"
									  rows="5" style="width:98%;overflow-y:hidden;line-height:150%;" UNSELECTABLE='on'>${middleLedgerProblem.audit_advice}</textarea>
					</td>
				</tr>								
				</table>
				</center>
				</s:form>	
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
				 <div class="easyui-panel" style="width:99%;padding:0px;" title="问题整改要求">
				 <center>
				 <s:form id="myform" action="updateLedgerProblem" namespace="/proledger/problem">
				<table cellpadding=1 cellspacing=1 border=0 class="ListTable" id="tab2">
				<tr>
					<%--<td class="EditHead">是否整改</td>
					<td class="editTd">
						<s:select list="#@java.util.LinkedHashMap@{'否':'否'}"  
							name="middleLedgerProblem.isNotMend" id="isNotMend"  headerKey="是" headerValue="是"></s:select>
					</td> --%>
					<s:hidden name="middleLedgerProblem.isNotMend" id="isNotMend" value="是"/>
					<td class="EditHead"><FONT color=red>*</FONT> 整改期限</td>
					<td class="editTd">
						<!-- <input type="text" id="mend_term" name="middleLedgerProblem.mend_term" disabled="true" /> -->
						<s:property  id="mend_term" value="middleLedgerProblem.mend_term" />
						--
				 		<!-- <input type="text" id="mend_term_enddate" name="middleLedgerProblem.mend_term_enddate" disabled="true" /> -->
						<s:property  id="mend_term_enddate" value="middleLedgerProblem.mend_term_enddate" />
				<!-- 	<s:textfield name="middleLedgerProblem.mend_term" id="mend_term"
							readonly="true" title="单击选择日期" onclick="calendar()"
							cssStyle="width:30%" maxlength="20" />
					     	至
						<s:textfield name="middleLedgerProblem.mend_term_enddate"
							id="mend_term_enddate" readonly="true" title="单击选择日期"
							onclick="calendar()" cssStyle="width:30%" maxlength="20" />-->
					</td>
					<td class="EditHead">监督检查人</td>
					<td class="editTd">
					    <%-- <s:textfield name="middleLedgerProblem.examine_creater_name" cssStyle='width:260px' disabled="true"/> --%>
					    <s:property  id="examine_creater_name" value="middleLedgerProblem.examine_creater_name" />
								<!--<s:hidden name="middleLedgerProblem.examine_creater_code" />
								<img src="<%=request.getContextPath()%>/resources/images/s_search.gif"
									onclick="getSupervisor();" border=0 style="cursor: hand">-->
					</td>
				</tr>
				<tr>
					<td class="EditHead">整改方式</td>
					<td class="editTd">
						<%-- <s:select list="basicUtil.mendMethodList" listKey="code"
							listValue="name" emptyOption="true" cssStyle='width:260px'
							name="middleLedgerProblem.mend_method_code" disabled="true">
						</s:select> --%>
						 <s:property  id="mend_method" value="middleLedgerProblem.mend_method" />
					</td>
					<td class="EditHead">检查方式</td>
					<td class="editTd">
						<%-- <s:select list="basicUtil.examineMethodList" listKey="code"
							listValue="name" emptyOption="true" cssStyle='width:260px'
							name="middleLedgerProblem.examine_method_code" disabled="true">
						</s:select> --%>
						 <s:property  id="examine_method" value="middleLedgerProblem.examine_method" />
					</td>
				</tr>
				<%--<tr>
						<td class="EditHead">被审计单位行动计划<font color=DarkGray>(限3000字)</font></td>
						<td class="editTd" colspan="3">
							<s:textarea
								name="middleLedgerProblem.aud_action_plan" title="被审计单位行动计划" cssStyle="width:100%"/>
							<input type="hidden" id="middleLedgerProblem.aud_action_plan.maxlength" value="3000">
						</td>
						<td class="EditHead">审计建议:<font color=DarkGray>(限3000字)</font></td>
						<td class="editTd">
							<s:textarea
								name="middleLedgerProblem.aud_mend_advice" title="审计实施单位整改意见"
								cssStyle="width:90%"/>
								<input type="hidden" id="middleLedgerProblem.aud_mend_advice.maxlength" value="300">
						</td>
				</tr> --%>
				<tr>
					<td class="EditHead">
						整改责任单位
					</td>
					<td class="editTd">
						<%-- <s:textfield name="projectStartObject.audit_object_name" disabled="true" cssStyle='width:260px'/> --%>
						 <s:property  id="audit_object_name" value="middleLedgerProblem.audit_object_name" />
					</td>
					<td class="EditHead">
						整改责任部门
					</td>
					<td class="editTd">
						<%-- <s:textfield name="projectStartObject.zeren_dept" disabled="true" cssStyle='width:260px'/> --%>
						 <s:property  id="zeren_dept" value="middleLedgerProblem.zeren_dept" />
					</td>
				</tr>
				<tr>
				    <td class="EditHead">整改责任人</td>
					<td class="editTd">
						<%-- <s:textfield name="projectStartObject.zeren_person" disabled="true" cssStyle='width:260px'/> --%>
						 <s:property  id="zeren_person" value="middleLedgerProblem.zeren_person" />
					</td>
					<td class="EditHead">联系电话</td>
					<td class="editTd">
						<%-- <s:textfield name="projectStartObject.telephone" disabled="true" cssStyle='width:260px'/> --%>
						 <s:property  id="telephone" value="middleLedgerProblem.telephone" />
					</td>
				</tr>
				<tr>
					<%-- <td class="EditHead">
					附件列表
					<s:hidden id="file_id" name="middleLedgerProblem.file_id" /></td>
					<td class="editTd" colspan="3">
						<div id="file_idList" align="center">
							<s:property escape="false" value="file_idList" />
						</div>
					</td> --%>
					
					<td class="EditHead">附件
						<s:hidden id="file_id" name="middleLedgerProblem.file_id" />
					</td>
					<td class="editTd" colspan="3">
					<s:if test="${param.view ne 'view' }">
					<div data-options="fileGuid:'${middleLedgerProblem.file_id}'"  class="easyui-fileUpload"></div>
					</s:if>
					<s:else>
					<div data-options="fileGuid:'${middleLedgerProblem.file_id}',isAdd:false,isEdit:false,isDel:false"  class="easyui-fileUpload"></div>
					</s:else>
						
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
		<center>	
		</div>
	</center>
	<script language="javascript">
		function saveForm(){
			var mend_term= document.getElementsByName("middleLedgerProblem.mend_term")[0].value;
			var mend_term_enddate= document.getElementsByName("middleLedgerProblem.mend_term_enddate")[0].value;
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
		}
		
		function back(){
		  window.location.href="${contextPath}/proledger/problem/mendLedgerListNew.action?project_id=${project_id}&isEdit=${isEdit}&permission=${permission}";
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
        		
	</script>
	</body>
</html>