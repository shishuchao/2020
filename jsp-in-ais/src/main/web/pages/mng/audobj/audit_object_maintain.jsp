<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<!DOCTYPE HTML>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
	<title>被审计单位</title>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/createOrgTree.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/common.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/scripts/ais_functions.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/autosize.js"></script>
<%--	<script type="text/javascript" src="<%=request.getContextPath()%>/scripts/ufaudTextLengthValidator.js"></script>--%>
	<script type="text/javascript" src="<%=request.getContextPath()%>/scripts/check.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/pages/tlInteractive/tlInteractiveCommon.js"></script>
	<STYLE type="">
		.fontStyle{
			margin-right: 5px;
			color: red;
		}
	</STYLE>
</head>
<body  style="overflow:hidden;" class="easyui-layout">
	<div class= "easyui-tabs" fit= "true" border="0" id="ao-tabs">
		<c:choose>
		<c:when test="${en eq 'en'}">
		<div id='one' title='Basic Information'>
		</c:when>
		<c:otherwise>
		<div id='one' title='基本信息'>
		</c:otherwise>
		</c:choose>
			<s:form id="myform" action="save" namespace="/mng/audobj/object">
				<div style="text-align:right;padding:5px 10px;">
					<span>
						<c:choose>
							<c:when test="${en eq 'en'}">
								Update Record:
							</c:when>
							<c:otherwise>
								基本信息更新记录：
							</c:otherwise>
						</c:choose>
						<a href="javascript:;" onclick="viewHistory()">${hisNum}</a>
					</span>&nbsp;&nbsp;
					<a class="easyui-linkbutton" data-options="iconCls:'icon-save'"  onclick="saveObj()" id="save_id">
						<c:choose>
							<c:when test="${en eq 'en'}">
								Save
							</c:when>
							<c:otherwise>
								保存
							</c:otherwise>
						</c:choose>
					</a>&nbsp;&nbsp;
					<a class="easyui-linkbutton" data-options="iconCls:'icon-ok'"  onclick="submitObj()" id="update_id">
						<c:choose>
							<c:when test="${en eq 'en'}">
								Update
							</c:when>
							<c:otherwise>
								提交更新
							</c:otherwise>
						</c:choose>
					</a>
				</div>
				<table cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable" id="tab1">
					<tr>
						<td class="EditHead" style="width: 15%">
							<c:choose>
								<c:when test="${en eq 'en'}">
									Org. Code
								</c:when>
								<c:otherwise>
									组织机构编码
								</c:otherwise>
							</c:choose>
						</td>
						<td class="editTd" style="width: 35%">
							<s:textfield  cssClass="noborder"  name="auditingObjectEdit.currentCode" readonly="true" maxlength="64"></s:textfield>
						</td>
						<td class="EditHead" style="width: 15%" nowrap="nowrap">
							<c:choose>
								<c:when test="${en eq 'en'}">
									Organization Gradation
								</c:when>
								<c:otherwise>
									法人级次
								</c:otherwise>
							</c:choose>
						</td>
						<td class="editTd" style="width: 35%">
							<s:textfield  cssClass="noborder"  name="auditingObjectEdit.orgLevelName" readonly="true" maxlength="64"></s:textfield>
							<s:hidden  cssClass="noborder" id="orgLevelCode" name="auditingObjectEdit.orgLevelCode"></s:hidden>
						</td>
					</tr>
					<tr>
						<td class="EditHead">
							<c:choose>
								<c:when test="${en eq 'en'}">
									Chinese Name
								</c:when>
								<c:otherwise>
									单位名称
								</c:otherwise>
							</c:choose>
						</td>
						<td class="editTd">
							<s:textfield  cssClass="noborder" name="auditingObjectEdit.name" readonly="true" maxlength="100"></s:textfield>
						</td>
						<td class="EditHead">
							<c:choose>
								<c:when test="${en eq 'en'}">
									English Name
								</c:when>
								<c:otherwise>
									英文名称
								</c:otherwise>
							</c:choose>
						</td>
						<td class="editTd">
							<s:textfield cssClass="noborder" name="auditingObjectEdit.nameEng" readonly="true"></s:textfield>
							<s:hidden cssClass="noborder" name="auditingObjectEdit.parentName"></s:hidden>
							<s:hidden cssClass="noborder" name="auditingObjectEdit.corporationCode"></s:hidden>
							<s:hidden name="parentId"></s:hidden>
						</td>
					</tr>
					<tr>
						<td class="EditHead">
							<c:choose>
								<c:when test="${en eq 'en'}">
									Registered Capital
								</c:when>
								<c:otherwise>
									注册资本
								</c:otherwise>
							</c:choose>
						</td>
						<td class="editTd">
							<s:textfield  cssClass="noborder" name="auditingObjectEdit.regCapital" readonly="true" maxlength="255"></s:textfield>
						</td>
						<td class="EditHead">
							<c:choose>
								<c:when test="${en eq 'en'}">
									Management Subject
								</c:when>
								<c:otherwise>
									管理主体
								</c:otherwise>
							</c:choose>
						</td>
						<td class="editTd">
							<s:textfield cssClass="noborder" name="auditingObjectEdit.mngSubject" readonly="true" maxlength="255"></s:textfield>
						</td>
					</tr>
					<tr>
						<td class="EditHead">
							<c:choose>
								<c:when test="${en eq 'en'}">
									Reistered Address
								</c:when>
								<c:otherwise>
									注册地
								</c:otherwise>
							</c:choose>

						</td>
						<td class="editTd">
							<s:textfield  cssClass="noborder" name="auditingObjectEdit.regAddress" readonly="true" maxlength="255"></s:textfield>
						</td>
						<td class="EditHead">
							<c:choose>
								<c:when test="${en eq 'en'}">
									Investment Entity
								</c:when>
								<c:otherwise>
									投资主体
								</c:otherwise>
							</c:choose>

						</td>
						<td class="editTd">
							<s:textfield cssClass="noborder" name="auditingObjectEdit.invSubject" readonly="true" maxlength="255"></s:textfield>
						</td>
					</tr>
					<tr>
						<td class="EditHead">
							<c:choose>
								<c:when test="${en eq 'en'}">
									Share Holder's Proportion
								</c:when>
								<c:otherwise>
									占股比
								</c:otherwise>
							</c:choose>

						</td>
						<td class="editTd">
							<s:textfield  cssClass="noborder" name="auditingObjectEdit.shareRatio" readonly="true" maxlength="255"></s:textfield>
						</td>
						<td class="EditHead">
							<c:choose>
								<c:when test="${en eq 'en'}">
									Founded Date
								</c:when>
								<c:otherwise>
									成立日期
								</c:otherwise>
							</c:choose>

						</td>
						<td class="editTd">
							<s:textfield cssClass="noborder" name="auditingObjectEdit.establishDate" readonly="true" maxlength="255"></s:textfield>
						</td>
					</tr>
					<tr>
						<td class="EditHead">
							<c:choose>
								<c:when test="${en eq 'en'}">
									The Company And Subcompany's Total Assets(Ten Thousand RMB)
								</c:when>
								<c:otherwise>
									本级及以下资产总额(万元)
								</c:otherwise>
							</c:choose>
						</td>
						<td class="editTd">
							<input name="auditingObjectEdit.generalAssetsA" value="${auditingObjectEdit.generalAssetsA}" class="easyui-numberbox" data-options="precision:2,groupSeparator:','">
						</td>
						<td class="EditHead">
							<label style="color: red;">*</label>
							<c:choose>
								<c:when test="${en eq 'en'}">
									The Company's Total Assets(Ten Thousand RMB)
								</c:when>
								<c:otherwise>
									本单位资产总额(万元)
								</c:otherwise>
							</c:choose>
						</td>
						<td class="editTd">
							<input name="auditingObjectEdit.generalAssetsO" value="${auditingObjectEdit.generalAssetsO}" class="easyui-numberbox" data-options="precision:2,groupSeparator:','">
						</td>
					</tr>
					<tr>
						<td class="EditHead">
							<label style="color: red;">*</label>
							<c:choose>
								<c:when test="${en eq 'en'}">
									Office Address
								</c:when>
								<c:otherwise>
									总部办公地址
								</c:otherwise>
							</c:choose>
						</td>
						<td class="editTd">
							<s:textfield  cssClass="noborder editElement required" name="auditingObjectEdit.officeAddress" maxlength="255"></s:textfield>
						</td>
						<td class="EditHead">
							<label style="color: red;">*</label>
							<c:choose>
								<c:when test="${en eq 'en'}">
									General Manager
								</c:when>
								<c:otherwise>
									单位负责人
								</c:otherwise>
							</c:choose>
						</td>
						<td class="editTd">
							<s:textfield cssClass="noborder editElement required" name="auditingObjectEdit.director" maxlength="255"></s:textfield>
						</td>
					</tr>
					<tr>
						<td class="EditHead">
							<label style="color: red;">*</label>
							<c:choose>
								<c:when test="${en eq 'en'}">
									Chief Financial Officer
								</c:when>
								<c:otherwise>
									财务负责人
								</c:otherwise>
							</c:choose>

						</td>
						<td class="editTd">
							<s:textfield  cssClass="noborder editElement required" name="auditingObjectEdit.financialDirector" maxlength="255"></s:textfield>
						</td>
						<td class="EditHead">
							<label style="color: red;">*</label>
							<c:choose>
								<c:when test="${en eq 'en'}">
									Financial Contact Person
								</c:when>
								<c:otherwise>
									财务联系人
								</c:otherwise>
							</c:choose>

						</td>
						<td class="editTd">
							<s:textfield cssClass="noborder editElement required" name="auditingObjectEdit.financialLinkman" maxlength="255"></s:textfield>
						</td>
					</tr>
					<tr>
						<td class="EditHead">
							<label style="color: red;">*</label>
							<c:choose>
								<c:when test="${en eq 'en'}">
									Type
								</c:when>
								<c:otherwise>
									单位性质
								</c:otherwise>
							</c:choose>

						</td>
						<td class="editTd">
							<input id="comtype" class="required" editable="false"/>
							<s:hidden name="auditingObjectEdit.comTypeName" id="comTypeName"></s:hidden>
							<s:hidden name="auditingObjectEdit.comTypeCode" id="comTypeCode"></s:hidden>
						</td>
						<td class="EditHead">
							<label style="color: red;">*</label>
							<c:choose>
								<c:when test="${en eq 'en'}">
									Telephone
								</c:when>
								<c:otherwise>
									单位电话
								</c:otherwise>
							</c:choose>
						</td>
						<td class="editTd">
							<s:textfield id="officePhone" cssClass="noborder editElement required"  name="auditingObjectEdit.officePhone" maxlength="20"></s:textfield>
						</td>
					</tr>
					<tr>
						<td class="EditHead">
							<label style="color: red;">*</label>
							<c:choose>
								<c:when test="${en eq 'en'}">
									Fax
								</c:when>
								<c:otherwise>
									单位传真
								</c:otherwise>
							</c:choose>
						</td>
						<td class="editTd">
							<s:textfield id="faxCode" cssClass="noborder editElement required"  name="auditingObjectEdit.faxCode" maxlength="20"></s:textfield>
						</td>
						<td class="EditHead">
							<c:choose>
								<c:when test="${en eq 'en'}">
									Staff Number
								</c:when>
								<c:otherwise>
									人员数量
								</c:otherwise>
							</c:choose>
						</td>
						<td class="editTd">
							<input name="auditingObjectEdit.employeesNum" value="${auditingObjectEdit.employeesNum}" class="easyui-numberbox required"  data-options="precision:0,min:0">
						</td>
					</tr>
					<tr>
						<td class="EditHead">
							<c:choose>
								<c:when test="${en eq 'en'}">
									Reviser
								</c:when>
								<c:otherwise>
									最近更新人
								</c:otherwise>
							</c:choose>
						</td>
						<td class="editTd">
							<s:property value="auditingObjectEdit.updatePersonName"/>
							<s:hidden name="auditingObjectEdit.updatePersonCode"/>
							<s:hidden name="auditingObjectEdit.updatePersonName"/>
						</td>
						<td class="EditHead">
							<c:choose>
								<c:when test="${en eq 'en'}">
									Revise Time
								</c:when>
								<c:otherwise>
									最近更新时间
								</c:otherwise>
							</c:choose>
						</td>
						<td class="editTd">
							<s:property value="auditingObjectEdit.updateDate"/>
							<s:hidden name="auditingObjectEdit.updateDate"/>
						</td>
					</tr>
					<s:if test="${not  empty  auditList}">
						<tr id="c_datasrcid_td">
							<td class="EditHead" nowrap>
								业财数据源
							</td>
							<td class="editTd" colspan="3" id="bigdataSjyId" >
								<select   class="easyui-combobox"  style="width:150px;"   data-options="panelHeight:'auto'">
									<c:forEach items="${auditList}" var="sjy">
										<s:if test= "${defaultSjy eq sjy.key}">
											<option value="${sjy.key}" selected="selected" >${sjy.value}</option>
										</s:if>
										<s:else>
											<option value="${sjy.key}">${sjy.value}</option>
										</s:else>
									</c:forEach>
								</select>
							</td>
						</tr>
					</s:if>
				</table>
				<s:hidden name="auditingObjectEdit.departmentName"/>
				<s:hidden name="auditingObjectEdit.departmentId"/>
				<s:hidden name="auditingObjectEdit.auditCover"/>
				<s:hidden name="auditingObjectEdit.superiorCode"/>
				<s:hidden name="auditingObjectEdit.otherResourceFile"/>
				<s:hidden name="auditingObjectEdit.createDepartmentName"/>
				<s:hidden name="auditingObjectEdit.createDepartmentCode"/>
				<s:hidden name="auditingObjectEdit.createPersonName"/>
				<s:hidden name="auditingObjectEdit.createPersonCode"/>
				<s:hidden name="auditingObjectEdit.createDate"/>
				<s:hidden name="auditingObjectEdit.associateDeptCode"/>
				<s:hidden name="auditingObjectEdit.associateDept"/>
				<s:hidden name="auditingObjectEdit.id" id="id"/>
				<s:hidden name="status" />
			</s:form>
		</div>
		<c:choose>
		<c:when test="${en eq 'en'}">
		<div title='Auditee Data' style="overflow: hidden;">
		</c:when>
		<c:otherwise>
		<div title='被审计单位资料' style="overflow: hidden;">
		</c:otherwise>
		</c:choose>
			<iframe id="editIframe" width="100%" height="100%" marginheight="0"  marginwidth="0"  frameborder="0" src=""></iframe>
		</div>
	</div>

	<script type="text/javascript">
		var en = '${en}' == 'en'?true:false;
		$(function(){
			$('#comtype').combobox({
				data:${comTypeList},
				valueField:'code',
				textField:'name',
				onLoadSuccess:function(data){
					$('#comtype').combobox('setValue','${auditingObjectEdit.comTypeCode}');
				},
				onChange:function (newValue,oldValue) {
					$('#comTypeCode').val(newValue);
					var data = $('#comtype').combobox('getData');
					for(var i in data){
						var obj = data[i];
						if(obj.code == newValue){
							$('#comTypeName').val(obj.name);
							break;
						}
					}
				}
			});

			var tab = '${tab}';
			setTimeout(function () {
				$('#editIframe').attr('src','${contextPath}/auditobject/material/initAuditObjectData.action?en=${en}&auditObject=${auditingObject.id}');
				if(tab == '2'){
					$('#ao-tabs').tabs('select',en ? 'Auditee Data':'被审计单位资料');
				}else{
					$('#ao-tabs').tabs('select',en ? 'Basic Information':'基本信息');
				}
			},300)

			if (${EDIT_DISABLED}) {
				$('#comtype').combobox('disable');
				$('#myform .easyui-linkbutton').linkbutton('disable');
				$('#myform input').prop('disabled', true);
			}
		});

		/*
		 * 保存表单
		 */
		function saveObj(){

            if (!validataForm('myform')) {
                return;
            }

			if (!(new RegExp('^(((\\+\\d{2}-)?0\\d{2,3}-\\d{7,8})|((\\+\\d{2}-)?(\\d{2,3}-)?([1][3,4,5,7,8][0-9]\\d{8})))$')).test($('#officePhone').val())){
				showMessage1('单位电话格式不正确！');
				return false;
			}
			if (!(new RegExp('^(\\d{3,4}-)?\\d{7,8}$')).test($('#faxCode').val())){
				showMessage1('单位传真格式不正确！');
				return false;
			}
			if($('#comtype').combobox('getValues') == ''){
                showMessage1('单位性质不能为空！');
                return false;
			}
			aud$saveForm("myform",'${contextPath}/mng/audobj/object/save.action',function(data){
				if(data.flag == 'success'){
					showMessage1(en ? 'The information saved successfully!':'保存成功!');
					window.location.reload();
				}else{
					showMessage1(en ? 'Failed to save the information!':'保存失败!' + data.msg);
				}
			});
		}

		function submitObj() {
			var id = $('#id').val();
			var title = en ? 'Confirm':'确认';
			var info = en ? 'Do you confirm to update the information?':'确认要更新信息吗？';
			top.$.messager.confirm(title,info,function (r) {
				if(r){
					$.ajax({
						url : '${contextPath}/mng/audobj/object/submitObj.action',
						dataType:'json',
						type: "post",
						data: {'id':id},
						success: function(data){
							if(data.flag == '1'){
								showMessage1(en ? 'The information saved successfully!':'提交更新成功!');
								window.location.reload();
							}else if (data.flag == '0') {
								showMessage1(en ? 'Please save the basic information first!':'请先保存基本信息!');
							} else {
								showMessage1(data.flag);
							}
						}

					});
				}
			});

		}
		function setfmid(obj,otherName){
			var str;
			str=obj.options[obj.selectedIndex].text;
			document.getElementsByName(otherName)[0].value=str;
		}
		function viewHistory(){
			var url = "${contextPath}/mng/audobj/object/viewHistory.action?id=${auditingObjectEdit.id}&en=${en}";
			aud$openNewTab(en ? 'Update Record':'历史变更信息查看',url,false);
		}
	</script>
</body>
</html>