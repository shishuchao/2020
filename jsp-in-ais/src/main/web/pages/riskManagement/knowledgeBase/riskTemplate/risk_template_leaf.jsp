<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://fckeditor.net/tags-fckeditor" prefix="FCK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML>
<s:text id="title" name="'编辑风险事项'"></s:text>
<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<title><s:property value="#title" /></title>
    <title>风险库维护事项详细内容</title>
    <script type="text/javascript" src="${contextPath}/easyui/boot.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/jquery-fileUpload.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/autosize.js"></script>
	<script type="text/javascript" src="${contextPath}/easyui/contextmenu.js"></script>  
	<script type="text/javascript" src="${contextPath}/pages/tlInteractive/tlInteractiveCommon.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/jquery-fileUpload.js"></script>
	<script language="javascript">
		$(function (){
		    var value1 = document.getElementById('estimatedFinancialLoss').value;
            var value2 = document.getElementById('actualFinancialLoss').value;
            var num1 = new Number(value1);
            var num2 = new Number(value2);
            $('#estimatedFinancialLoss').val(num1);
            $('#actualFinancialLoss').val(num2);
			$("#myform").find("textarea").each(function(){
				autoTextarea(this);
			});
		});
		
		//删除
		function deleteRecord(){
			$.messager.confirm('提示信息','确认删除这条记录？',function(flag){
				if(flag){
					$.ajax({
						type:"post",
						data:$('#myform').serialize(),
						url:"${contextPath}/riskManagement/knowledgeBase/riskTemplate/deleteLeaf.action",
						async:false,
						success:function(){
							parent.parent.reloadChildTreeNode('delete');
							showMessage1('删除成功！');
						}
					});
				}
			});
		}

		//保存表单
		function saveFormLeaf(){
			if(audEvd$validateform('myform')) {
				$.ajax({
					url:"${contextPath}/riskManagement/knowledgeBase/riskTemplate/saveLeafDetail.action?tid=<%=request.getParameter("tid")%>",
					type:"POST",
					async:false,
					data:$('#myform').serialize(),
					success:function(data) {
						if(data == '1'){
							showMessage1('保存成功！');
						}
					}
				});
			}
		}
	</script>
</head>
<body class="easyui-layout" style="overflow:auto;">
	<center>
		<s:if test="${isView != 'Y'}">
			<div style="text-align:right;margin-top:10px;margin-bottom:10px;padding-right:18px;">
				<a class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="saveFormLeaf();">保存</a>
				<a class="easyui-linkbutton" data-options="iconCls:'icon-delete'" onclick="deleteRecord();">删除</a>
			</div>
            <s:form id="myform" onsubmit="return true;" action="/ais/riskManagement/knowledgeBase/riskTemplate" method="post">
                <table class="ListTable">
                    <tr>
                        <td class="EditHead" style="width: 20%">
                            上级类别名称
                        </td>
                        <td class="editTd">
                            <s:textfield name="riskTaskTemplate.taskPname" title="上级类别名称" id="taskPname" cssClass="noborder"/>
                        </td>
                        <td class="EditHead">
                            <font color="red">*</font>&nbsp;风险类型
                        </td>
                        <td class="editTd">
                            <select class="easyui-combobox" name="riskTaskTemplate.riskTypeCode">
                                <s:iterator value="basicUtil.riskTypeList" id="entry">
                                    <s:if test="${riskTaskTemplate.riskTypeCode == key}">
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
                            <font color="red">*</font>&nbsp;编号
                        </td>
                        <td class="editTd">
                            <s:property value="riskTaskTemplate.taskCode" />
                            <s:hidden name="riskTaskTemplate.taskCode" />
                        </td>
                        <td class="EditHead">
                            风险事项
                        </td>
                        <td class="editTd">
                            <s:textfield name="riskTaskTemplate.taskName" title="风险事项" id="taskName" cssClass="noborder editElement required" maxlength="100"/>
                        </td>
                    </tr>
                    <tr style='display:none;'>
                        <td class="EditHead" >
                            <font color="red">*</font>&nbsp;事项序号
                        </td>
                        <td class="editTd" colspan="3">
                            <s:textfield name="riskTaskTemplate.taskOrder" cssClass="noborder" maxlength="3"
                                         cssStyle='width:150px;' />
                        </td>
                    </tr>
                    <tr>
                        <td class="EditHead">
                            <font color="red">*</font>&nbsp;风险描述
                        </td>
                        <td class="editTd" colspan="3">
                            <textarea type='text' id='riskTaskTemplate_riskDescription' name='riskTaskTemplate.riskDescription'"
                            class="noborder editElement clear required len200" style='border-width:0px;height:50px;width:99%;overflow:hidden;' >${riskTaskTemplate.riskDescription}</textarea>
                        </td>
                    </tr>
                    <tr>
                        <td class="EditHead">
                            <font color="red">*</font>&nbsp;影响描述
                        </td>
                        <td class="editTd" colspan="3">
                            <textarea type='text' id='riskTaskTemplate_influenceDescription' name='riskTaskTemplate.influenceDescription'"
                            class="noborder editElement required clear len200" style='border-width:0px;height:50px;width:99%;overflow:hidden;' >${riskTaskTemplate.influenceDescription}</textarea>
                        </td>
                    </tr>
                    <tr>
                        <td class="EditHead">
                            <font color="red">*</font>&nbsp;所属单位
                        </td>
                        <td class="editTd">
                            <s:buttonText2 id="affiliatedDeptName" hiddenId="affiliatedDeptId" cssClass="noborder editElement required"
                                           name="riskTaskTemplate.affiliatedDeptName"
                                           hiddenName="riskTaskTemplate.affiliatedDeptId"
                                           doubleOnclick="showSysTree(this,
							{ url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action',
								title:'请选择所属单位',
								param:{
									'p_item':1,
									'orgtype':1
								},
								defaultDeptId:'${user.fdepid}',
								onAfterSure:function(data){
									$('#majorDutyDeptName').val('');
									$('#majorDutyDeptId').val('');
								}
							})"
                                           doubleSrc="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png"
                                           doubleCssStyle="cursor:pointer;border:0"
                                           readonly="true"
                                           title="所属单位" maxlength="100"/>
                        </td>
                        <td class="EditHead">
                            <font color="red">*</font>&nbsp;主责部门
                        </td>
                        <td class="editTd">
                            <s:buttonText2 id="majorDutyDeptName" hiddenId="majorDutyDeptId" cssClass="noborder editElement required"
                                           name="riskTaskTemplate.majorDutyDeptName"
                                           hiddenName="riskTaskTemplate.majorDutyDeptId"
                                           doubleOnclick="showSysTree(this,
							{ url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action',
								title:'请选择主责部门',
								param:{
									'p_item':1,
									'orgtype':1
								},
								defaultDeptId:'${user.fdepid}'
							})"
                                           doubleSrc="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png"
                                           doubleCssStyle="cursor:pointer;border:0"
                                           readonly="true"
                                           title="主责部门" maxlength="100"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="EditHead">
                            次要责任部门
                        </td>
                        <td class="editTd">
                            <s:buttonText2 id="minorDutyDeptName" hiddenId="minorDutyDeptId" cssClass="noborder"
                                           name="riskTaskTemplate.minorDutyDeptName"
                                           hiddenName="riskTaskTemplate.minorDutyDeptId"
                                           doubleOnclick="showSysTree(this,
							{ url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action',
								title:'请选择次要责任部门',
								param:{
									'p_item':1,
									'orgtype':1
								},
								defaultDeptId:'${user.fdepid}',
								checkbox:true
							})"
                                           doubleSrc="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png"
                                           doubleCssStyle="cursor:pointer;border:0"
                                           readonly="true"
                                           title="次要责任部门" maxlength="100"/>
                        </td>
                        <td class="EditHead">
                            涉及业务
                        </td>
                        <td class="editTd">
                            <s:textfield name="riskTaskTemplate.involvedBusiness" cssClass="noborder" maxlength="64"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="EditHead">
                            风险成因
                        </td>
                        <td class="editTd" colspan="3">
						<textarea type='text' id='riskTaskTemplate_riskCause' name='riskTaskTemplate.riskCause'
                                  class="noborder editElement clear len200" style='border-width:0px;height:50px;width:99%;overflow:hidden;' >${riskTaskTemplate.riskCause}</textarea>
                        </td>
                    </tr>
                    <tr>
                        <td class="EditHead">
                            风险源
                        </td>
                        <td class="editTd" colspan="3">
						<textarea type='text' id='riskTaskTemplate_riskSource' name='riskTaskTemplate.riskSource'
                                  class="noborder editElement clear len200" style='border-width:0px;height:50px;width:99%;overflow:hidden;' >${riskTaskTemplate.riskSource}</textarea>
                        </td>
                    </tr>
                    <tr>
                        <td class="EditHead">
                            估计财务损失
                        </td>
                        <td class="editTd">
                            <s:textfield name="riskTaskTemplate.estimatedFinancialLoss" id="estimatedFinancialLoss" cssClass="noborder editElement money" maxlength="10"/>万元
                        </td>
                        <td class="EditHead">
                            实际财务损失
                        </td>
                        <td class="editTd">
                            <s:textfield name="riskTaskTemplate.actualFinancialLoss" id="actualFinancialLoss" cssClass="noborder editElement money" maxlength="10"/>万元
                        </td>
                    </tr>
                    <tr>
                        <td class="EditHead">
                            当前管控情况
                        </td>
                        <td class="editTd">
                            <select class="easyui-combobox" name="riskTaskTemplate.currentControlSituation">
                                <s:iterator value="basicUtil.riskChargeList">
                                    <s:if test="${riskTaskTemplate.currentControlSituation == key}">
                                        <option selected="selected" value="<s:property value="code"/>"><s:property value="name"/></option>
                                    </s:if>
                                    <s:else>
                                        <option value="<s:property value="code"/>"><s:property value="name"/></option>
                                    </s:else>
                                </s:iterator>
                            </select>
                        </td>
                        <td class="EditHead">
                            录入时间
                        </td>
                        <td class="editTd">
                            <s:property value="riskTaskTemplate.createTime"/>
                            <s:hidden name="riskTaskTemplate.createTime"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="EditHead">
                            录入部门
                        </td>
                        <td class="editTd">
                            <s:property value="riskTaskTemplate.createrDeptName"/>
                            <s:hidden name="riskTaskTemplate.createrDeptId"/>
                            <s:hidden name="riskTaskTemplate.createrDeptName"/>
                        </td>
                        <td class="EditHead">
                            录入人
                        </td>
                        <td class="editTd">
                            <s:property value="riskTaskTemplate.createrName"/>
                            <s:hidden name="riskTaskTemplate.createrId"/>
                            <s:hidden name="riskTaskTemplate.createrName"/>
                        </td>
                    </tr>
                </table>
                <div border="0" region="south">
                    <div id="risk_file" class="easyui-fileUpload"  data-options="fileGuid:'${riskTaskTemplate.file_id}' ,callbackGridHeight:200"></div>
                </div>
                <s:hidden name="riskTaskTemplate.taskId" />
                <s:hidden name="riskTaskTemplate.templateId" />
                <s:hidden name="riskTaskTemplate.taskPid" />
                <s:hidden name="riskTaskTemplate.taskPcode" />
                <s:hidden name="riskTaskTemplate.template_type" value="2" />
                <s:hidden name="templateId" />
                <s:hidden name="taskId" />
                <s:hidden name="type" />
                <s:hidden name="pro_id" />
                <s:hidden name="path" />
                <s:hidden name="node" />
                <s:hidden name="riskTaskTemplate.file_id" />
                <s:hidden name="riskTaskTemplate.riskDivision" />
                <s:hidden name="riskTaskTemplate.riskClass" />
            </s:form>
		</s:if>
        <s:else>
            <table class="ListTable">
                <tr>
                    <td class="EditHead" style="width: 20%">
                        上级类别名称
                    </td>
                    <td class="editTd">
                        <span class="noborder clear" style='width:50%;display:inline;'>${riskTaskTemplate.taskPname}</span>
                    </td>
                    <td class="EditHead">
                        <font color="red">*</font>&nbsp;风险类型
                    </td>
                    <td class="editTd">
                        <span class="noborder clear" style='width:50%;display:inline;'>${riskTaskTemplate.riskTypeName}</span>
                    </td>
                </tr>
                <tr>
                    <td class="EditHead">
                        <font color="red">*</font>&nbsp;编号
                    </td>
                    <td class="editTd">
                        <span class="noborder clear" style='width:50%;display:inline;'>${riskTaskTemplate.taskCode}</span>
                    </td>
                    <td class="EditHead">
                        风险事项
                    </td>
                    <td class="editTd">
                        <span class="noborder clear" style='width:50%;display:inline;'>${riskTaskTemplate.taskName}</span>
                    </td>
                </tr>
                <tr style='display:none;'>
                    <td class="EditHead" >
                        <font color="red">*</font>&nbsp;事项序号
                    </td>
                    <td class="editTd" colspan="3">
                        <span class="noborder clear" style='width:50%;display:inline;'>${riskTaskTemplate.taskOrder}</span>
                    </td>
                </tr>
                <tr>
                    <td class="EditHead">
                        <font color="red">*</font>&nbsp;风险描述
                    </td>
                    <td class="editTd" colspan="3">
                        <textarea class="noborder clear" style='width:100%; height:50px;overflow:auto;display:inline;' readonly="readonly">${riskTaskTemplate.riskDescription}</textarea>
                    </td>
                </tr>
                <tr>
                    <td class="EditHead">
                        <font color="red">*</font>&nbsp;影响描述
                    </td>
                    <td class="editTd" colspan="3">
                        <textarea class="noborder clear" style='width:100%; height:50px;overflow:auto;;display:inline;' readonly="readonly">${riskTaskTemplate.influenceDescription}</textarea>
                    </td>
                </tr>
                <tr>
                    <td class="EditHead">
                        <font color="red">*</font>&nbsp;所属单位
                    </td>
                    <td class="editTd">
                        <span class="noborder clear" style='width:50%;display:inline;'>${riskTaskTemplate.affiliatedDeptName}</span>
                    </td>
                    <td class="EditHead">
                        <font color="red">*</font>&nbsp;主责部门
                    </td>
                    <td class="editTd">
                        <span class="noborder clear" style='width:50%;display:inline;'>${riskTaskTemplate.majorDutyDeptName}</span>
                    </td>
                </tr>
                <tr>
                    <td class="EditHead">
                        次要责任部门
                    </td>
                    <td class="editTd">
                        <span class="noborder clear" style='width:50%;display:inline;'>${riskTaskTemplate.minorDutyDeptName}</span>
                    </td>
                    <td class="EditHead">
                        涉及业务
                    </td>
                    <td class="editTd">
                        <span class="noborder clear" style='width:50%;display:inline;'>${riskTaskTemplate.involvedBusiness}</span>
                    </td>
                </tr>
                <tr>
                    <td class="EditHead">
                        风险成因
                    </td>
                    <td class="editTd" colspan="3">
                        <textarea class="noborder clear" style='width:100%; height:50px;overflow:auto;;display:inline;' readonly="readonly">${riskTaskTemplate.riskCause}</textarea>
                    </td>
                </tr>
                <tr>
                    <td class="EditHead">
                        风险源
                    </td>
                    <td class="editTd" colspan="3">
                        <textarea class="noborder clear" style='width:100%; height:50px;overflow:auto;;display:inline;' readonly="readonly">${riskTaskTemplate.riskSource}</textarea>
                    </td>
                </tr>
                <tr>
                    <td class="EditHead">
                        估计财务损失
                    </td>
                    <td class="editTd">
                        <span class="noborder clear" style='width:50%;display:inline;'>${riskTaskTemplate.estimatedFinancialLoss}</span>万元
                    </td>
                    <td class="EditHead">
                        实际财务损失
                    </td>
                    <td class="editTd">
                        <span class="noborder clear" style='width:50%;display:inline;'>${riskTaskTemplate.actualFinancialLoss}</span>万元
                    </td>
                </tr>
                <tr>
                    <td class="EditHead">
                        当前管控情况
                    </td>
                    <td class="editTd">
                        <span class="noborder clear" style='width:50%;display:inline;'>${riskTaskTemplate.currentControlSituation}</span>
                    </td>
                    <td class="EditHead">
                        录入时间
                    </td>
                    <td class="editTd">
                        <span class="noborder clear" style='width:50%;display:inline;'>${riskTaskTemplate.createTime}</span>
                    </td>
                </tr>
                <tr>
                    <td class="EditHead">
                        录入部门
                    </td>
                    <td class="editTd">
                        <span class="noborder clear" style='width:50%;display:inline;'>${riskTaskTemplate.createrDeptName}</span>
                    </td>
                    <td class="EditHead">
                        录入人
                    </td>
                    <td class="editTd">
                        <span class="noborder clear" style='width:50%;display:inline;'>${riskTaskTemplate.createrName}</span>
                    </td>
                </tr>
            </table>
            <div border="0" region="south">
                <div id="view_risk_file" class="easyui-fileUpload"  data-options="fileGuid:'${riskTaskTemplate.file_id}',isAdd:false,isEdit:false,isDel:false,callbackGridHeight:200"></div>
            </div>
        </s:else>

	</center>
    <!-- ajax请求前后提示 -->
    <jsp:include flush="true" page="/pages/frReportFlow/ajaxloading.jsp" />
</body>
</html>
