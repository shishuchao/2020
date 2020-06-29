<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE HTML >
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>审计日志编辑</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<link href="${contextPath}/resources/css/common.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script> 
		<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>   
		<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
	</head>
	<body style="margin: 0;padding: 0;overflow:auto;" class="easyui-layout">
		<div >
			<s:form action="listAll" namespace="/auditLog" method="post" name="myform" id="myform">
				<div style="width: 100%;position:absolute;top:0px;" id="div1" align="center" >
					<table class="ListTable" align="center" style='width: 98.3%; padding: 0px; margin: 0px;'>
						<tr class="EditHead"> 
							<td  >
							<span style='float: right; text-align: right;'>
								<a class="easyui-linkbutton" iconCls="icon-save" href="javascript:void(0)" onclick="saveAuditLog('save')">保存</a>
		                        <a class="easyui-linkbutton" iconCls="icon-ok"  href="javascript:void(0)" onclick="saveAuditLog('submit')">提交</a> 
		                        <a class="easyui-linkbutton" iconCls="icon-undo"  href="javascript:void(0)" onclick="back()">返回</a>
							</span>
							</td>
						</tr>
					</table>
				</div>
				<div style="position: relative;" id="div2">
					<table  cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable" style="width: 98%;margin-top: 40px;">
						<tr >
							<td class="EditHead" style="width:20%"  nowrap="nowrap">
								被审计单位
							</td>
					<%-- 		<td class="editTd" style="width:30%" >
								<s:textfield cssClass="noborder" name="auditLog.audit_object_name"  id="audit_object_name" cssStyle="width:150px" readonly="true" maxlength="100"/>
								<input type="hidden" id="audit_object" name="auditLog.audit_object" value="<s:property value='auditLog.audit_object'/>">
							
								<img style="cursor:pointer;border:0" src="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png"
									 onclick="showSysTree(this,
											 { url:'${pageContext.request.contextPath}/mng/audobj/object/getAuditedDeptChildByDeptId.action',
											 param:{
											 'departmentId':'${user.fdepid }'
											 },
											 cache:false,
											 checkbox:true,
											 title:'请选择被审计单位'
									})"/>
							</td> --%>
							<td class="editTd">
							<select id="audit_object" class="easyui-combobox" panelHeight="auto"  name="auditLog.audit_object" style="width: 95%;" editable="false">
								<s:iterator value="auditObjectMap" id="entry">
									<s:if test="${auditLog.audit_object==key}">
										<option selected="selected" value="<s:property value="key"/>"><s:property value="value" /></option>
									</s:if>
									<s:else>
										<option value="<s:property value="key"/>"><s:property value="value" /></option>
									</s:else>
								</s:iterator>
						     </select>
						     <s:hidden name="auditLog.audit_object_name" id="audit_object_name"/>
					    	</td>
							<td class="EditHead" style="width:15%">
								状态
							</td>
							<td class="editTd" style="width:35%">
								<s:if test="${auditLog.status == '1' }">
								已提交
								</s:if>
								<s:else>
								未提交
								</s:else>
							</td>
						</tr>
						<tr >
							<td class="EditHead" style="width:20%">
						                  今日完成事项
			                	<div>
									<font color=DarkGray>(限1000字)</font>
								</div>
					        </td>
				        	<td class="editTd" colspan="3"><s:textarea
								cssClass="noborder" title="今日完成事项"
								name="auditLog.today_finish_task" id='today_finish_task'
								value="${auditLog.today_finish_task}" rows="5"
								cssStyle="width:100%;overflow:hidden;line-height:150%;" /> 
								<input type="hidden" id="auditLog.today_finish_task.maxlength" value="1000">
							</td>
						</tr>
						<tr >
							<td class="EditHead" style="width:20%">
						                  后续关注事项
			                	<div>
									<font color=DarkGray>(限1000字)</font>
								</div>
					        </td>
				        	<td class="editTd" colspan="3"><s:textarea
								cssClass="noborder" title="后续关注事项"
								name="auditLog.follow_up_task" id='follow_up_task'
								value="${auditLog.follow_up_task}" rows="5"
								cssStyle="width:100%;overflow:hidden;line-height:150%;" /> 
								<input type="hidden" id="auditLog.follow_up_task.maxlength" value="1000">
							</td>
						</tr>
						<tr >
							<td class="EditHead" style="width:20%">
						                  需协助事项
			                	<div>
									<font color=DarkGray>(限1000字)</font>
								</div>
					        </td>
				        	<td class="editTd" colspan="3"><s:textarea
								cssClass="noborder" title="需协助事项"
								name="auditLog.assistanceMatters" id='assistanceMatters'
								value="${auditLog.assistanceMatters}" rows="5"
								cssStyle="width:100%;overflow:hidden;line-height:150%;" /> 
								<input type="hidden" id="auditLog.assistanceMatters.maxlength" value="1000">
							</td>
						</tr>
						<tr >
							<td class="EditHead" style="width:20%">
						                  其他事项
			                	<div>
									<font color=DarkGray>(限1000字)</font>
								</div>
					        </td>
				        	<td class="editTd" colspan="3"><s:textarea
								cssClass="noborder" title=" 其他事项"
								name="auditLog.others" id='others'
								value="${auditLog.others}" rows="5"
								cssStyle="width:100%;overflow:hidden;line-height:150%;" /> 
								<input type="hidden" id="auditLog.others.maxlength" value="1000">
							</td>
						</tr>
						<tr >
							<td class="EditHead" style="width:20%">
						                  编制人
					        </td>
					        <td class="editTd" style="width:30%">
						      ${user.fname }
					        </td>
							<td class="EditHead" style="width:15%">
								编制时间
							</td>
							<td class="editTd" style="width:35%">
								<%-- <s:textfield cssClass="noborder" name="auditLog.createTime" cssStyle="width:80%" maxlength="100"/> --%>
								<s:property value="auditLog.createTime" />
							</td>
						</tr>
					</table>
				</div>
				<s:hidden name="auditLog.id"></s:hidden>
				<s:hidden name="auditLog.status"></s:hidden>
				<s:hidden name="auditLog.createPerson"></s:hidden>
				<s:hidden name="auditLog.createPersonCode"></s:hidden>
				<s:hidden name="project_id" ></s:hidden>
				<s:hidden name="auditLog.project_id" value="${project_id }"></s:hidden>
				<s:hidden name="auditLog.createTime"></s:hidden>
			</s:form>
		</div>
		<script type="text/javascript">
		function saveAuditLog(type){
            //校验字数
            var tft = $("#today_finish_task").val().length;
            if(tft > 1000){
                $.messager.show({
                    title:'提示信息',
                    msg:'今日完成事项的长度不能大于1000字！',
                    timeout:5000,
                    showType:'slide'
                });
                $("#today_finish_task").focus();
                return false;
            }
            var fup = $("#follow_up_task").val().length;
            if(fup > 1000){
                $.messager.show({
                    title:'提示信息',
                    msg:'后续关注事项的长度不能大于1000字！',
                    timeout:5000,
                    showType:'slide'
                });
                $("#follow_up_task").focus();
                return false;
            }
            var am = $("#assistanceMatters").val().length;
            if(am > 1000){
                $.messager.show({
                    title:'提示信息',
                    msg:'需协助事项的长度不能大于1000字！',
                    timeout:5000,
                    showType:'slide'
                });
                $("#assistanceMatters").focus();
                return false;
            }
            var ot = $("#others").val().length;
            if(ot > 1000){
                $.messager.show({
                    title:'提示信息',
                    msg:'其他事项的长度不能大于1000字！',
                    timeout:5000,
                    showType:'slide'
                });
                $("#others").focus();
                return false;
            }
			var status = '${auditLog.status}';
			if(status == '1'){
				window.parent.$.messager.show({
	                title:'提示信息',
	                msg:"该记录已提交不能进行保存或提交操作！",
	                timeout:5000,
	                showType:'slide'
	            });
				return false;
			}
			var myform = document.getElementById("myform");
			var audit_object_name = $('#audit_object').combobox('getText');
			$("#audit_object_name").val(audit_object_name);
			myform.action="${contextPath}/auditLog/save.action?type="+type;
			myform.submit();
			window.parent.$.messager.show({
                title:'提示信息',
                msg:"操作成功",
                timeout:5000,
                showType:'slide'
            });
// 			window.location.reload();
		}
		/*jQuery(document).ready(function(){
			$('#today_finish_task').attr('maxlength',1000); 
			$('#follow_up_task').attr('maxlength',1000);
			$('#assistanceMatters').attr('maxlength',1000);
			$('#others').attr('maxlength',1000);
		});*/
		
		function back(){
			window.location.href="${contextPath}/auditLog/listAll.action?view=${view}&project_id=${project_id}";
		}
		</script>	
	</body>
</html>
