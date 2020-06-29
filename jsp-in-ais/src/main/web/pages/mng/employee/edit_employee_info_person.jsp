<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<title>修改个人信息</title>
<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
	<link href="<%=request.getContextPath()%>/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
	<link href="<%=request.getContextPath()%>/resources/css/common.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/common.js"></script>
	<script type="text/javascript" src="${contextPath}/scripts/employeeValidate/checkboxSelected.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>
	<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
	<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
	<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
	<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
	<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
	<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css">
	<script type="text/javascript" src="${contextPath}/scripts/base64_Encode_Decode.js"></script>
	<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
	<script type="text/javascript" src="${contextPath}/scripts/employeeValidate/validate.js"></script>
	<link href="${contextPath}/styles/jquery.multiSelect.css" rel="stylesheet" type="text/css">
	<script type='text/javascript' src='${contextPath}/scripts/jquery.multiSelect.js'></script>
	<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
	<%-- <script type="text/javascript" src="${contextPath}/scripts/ufaudTextLengthValidator.js"></script> --%>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/autosize.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/jquery-fileUpload.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/jquery-parseExcel.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/pages/tlInteractive/tlInteractiveCommon.js"></script>
</head>
<s:if test="taskInstanceId!=null&&taskInstanceId!=''">
	<body onload="end();sucFun();">
</s:if>
<s:else>
	<body onload="sucFun();">
</s:else>
<div id="tabDiv" class="easyui-tabs" fit="true" border=0>
	<div title="基本信息">
		<div style="width: 100%;position:absolute;padding-top:0;text-align: right;z-index: 1000;" class="EditHead">
			<div style="text-align:right;width:100%;">
				<s:if test="crudObject.formId!=null">
					<jsp:include flush="true" page="/pages/bpm/list_toBeStart.jsp"/>
					&nbsp;&nbsp;&nbsp;&nbsp;
				</s:if>
				<s:if test="${sh != 'y'}">
					<a href="javascript:void(0);" id="root" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="save();">保存</a>&nbsp;&nbsp;&nbsp;&nbsp;
				</s:if>
				<s:else>
					信息更新审批中...&nbsp;&nbsp;&nbsp;&nbsp;
				</s:else>
				<s:if test="${taskInstanceId!=null&&taskInstanceId>0} && ${todoback == '1' }">
					<a class="easyui-linkbutton" data-options="iconCls:'icon-undo'"
					   onclick="
							   this.style.disabled='disabled';
							   window.location.href='${contextPath}/bpm/taskinstance/pending.action?processName=${processName}&project_name=${project_name}&formNameDetail=${formNameDetail}'"
					>返回</a>
				</s:if>
			</div>
		</div>

		<div class="easyui-layout" fit='true' >
			<s:form id="myForm" namespace="/mng/employeePerson" action="saveEP">
				<div region="center" border='0'>
					<div class="position:relative" id="div2">
						<s:hidden name="crudObject.formId" id="id"/>
						<s:hidden name="crudObject.creator" value="${user.floginname}"/>
						<s:hidden name="crudObject.employeeInfoId"/>
						<s:hidden name="crudObject.zhushenNum"/>
						<s:hidden name="crudObject.department"/>
						<s:hidden name="crudObject.departmentCode"/>
						<s:hidden name="crudObject.isSysAccounts"/>
						<s:hidden name="crudObject.orderNo" id="orderNo"/>
						<s:hidden name="crudObject.typeCode"/>
						<s:hidden name="crudObject.strongPointCode1" id="strongPointCode1"/>
						<s:hidden name="crudObject.strongPointCode" id="strongPointCode"/>
						<s:hidden name="listStatus"/>
						<s:hidden id="psncode"/>
						<s:hidden name="definition_idTemp"  id="definition_idTemp"/>
						<s:hidden name="group_idTemp" id="group_idTemp"/>
						<input type="hidden" name="sucFlag" id="sucFlag" value="${sucFlag}"/>
						<table cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable" style='margin-top: 40px; overflow: auto;'>
							<tr>
								<td nowrap class=EditHead>
									系统账号
								</td>
								<td class=editTd align="left">
									<input type="text" name="crudObject.sysAccounts" id="sysAccounts" value="${crudObject.sysAccounts}" class="noborder" readonly="readonly">
								</td>
								<td nowrap class=EditHead>
									<FONT color=red>*</FONT>&nbsp;姓名
								</td>
								<td class=editTd align="left">
									<s:textfield cssClass="noborder" readonly="true" cssStyle="color:Gray;width:40%;" name="crudObject.name" size="37" maxlength="16"/>
									<FONT id="msg1" color="gray">选择系统账号后，自动关联生成</FONT>
								</td>
							</tr>

							<tr>
								<td class=EditHead>
									所属单位/部门
								</td>
								<td class="editTd" align="left">
									<s:textfield cssClass="noborder" cssStyle="color:gray;width:40%;" readonly="true" name="crudObject.company" size="37" maxlength="16"/>
									<FONT id="msg3" color="gray">选择系统账号后，自动关联生成</FONT>
									<s:textfield cssClass="noborder" id="companyCode" name="crudObject.companyCode" cssStyle="color:gray;display:none"/>
								</td>
								<td nowrap class=EditHead>
									<FONT color=red>*</FONT>&nbsp;工号
								</td>
								<td class="editTd" align="left">
									<s:textfield id="personnelCode" cssClass="noborder" readonly="true" cssStyle="color:gray;width:40%;" name="crudObject.personnelCode" size="37" maxlength="16"/>
									<FONT id="msg2" color="gray">选择系统账号后，自动关联生成</FONT>
								</td>
							</tr>

							<tr>
								<td nowrap class=EditHead>
									出生日期
								</td>
								<td class="editTd" align="left">
									<input type="text" id="crudObjectBorn" editable="false" class="easyui-datebox noborder" name="crudObject.birthday" title="单击选择日期" style="width:150px;" value="${crudObject.birthday}"/>
								</td>
								<td nowrap class=EditHead>
									<FONT color=red>*</FONT>&nbsp;性别
								</td>
								<td class="editTd" align="left">
									<s:textfield cssClass="noborder" readonly="true" cssStyle="color:Gray;width:40%;" name="crudObject.sex" id="crudObjectSex" size="37" maxlength="16"/>
								</td>
							</tr>

							<tr>
								<td nowrap class=EditHead>
									籍贯
								</td>
								<td class=editTd align="left" colspan="3">
									<select editable="false" id="nativePlace" name="crudObject.nativePlace" class="easyui-combobox">
										<option value="">&nbsp;</option>
										<s:iterator value="basicUtil.nativeplacList">
											<s:if test="${crudObject.nativePlace == code}">
												<option selected="selected" value=${code}>${name }</option>
											</s:if>
											<s:else>
												<option value=${code}>${name}</option>
											</s:else>
										</s:iterator>
									</select>
								</td>
							</tr>

							<tr>
								<td nowrap class=EditHead>
									民族
								</td>
								<td class=editTd align="left">
									<select editable="false" id="nationCode" name="crudObject.nationCode" class="easyui-combobox" PanelHeight="auto">
										<option value="">&nbsp;</option>
										<s:iterator value="basicUtil.nationList">
											<s:if test="${crudObject.nationCode == code}">
												<option selected="selected" value=${code}>${name}</option>
											</s:if>
											<s:else>
												<option value=${code}>${name}</option>
											</s:else>
										</s:iterator>
									</select>
								</td>
								<td nowrap class=EditHead>
									政治面貌
								</td>
								<td class=editTd>
									<select editable="falsb" id="polityVisageCode" name="crudObject.polityVisageCode" class="easyui-combobox" PanelHeight="auto">
										<option value="">&nbsp;</option>
										<s:iterator value="basicUtil.polityVisageList">
											<s:if test="${crudObject.polityVisageCode == code}">
												<option selected="selected" value=${code}>${name}</option>
											</s:if>
											<s:else>
												<option value=${code}>${name}</option>
											</s:else>
										</s:iterator>
									</select>
								</td>
							</tr>

							<tr>
								<td nowrap class=EditHead>
									婚姻状况
								</td>
								<td class=editTd align="left">
									<s:select name="crudObject.married" list="#@java.util.LinkedHashMap@{'':'','已婚':'已婚','未婚':'未婚'}" cssClass="easyui-combobox" />
								</td>
								<td nowrap class=EditHead>
									职称级别
								</td>
								<td id="zcTd" class=editTd align="left" nowrap="nowrap">
									<s:buttonText2 id="technicalPost" name="crudObject.technicalPost"
												   hiddenId="technicalPostCode" hiddenName="crudObject.technicalPostCode"
												   cssClass="noborder"
												   doubleOnclick="queryData('/ais/mng/employee/quertTechnicalPost.action','职称级别',440,410,'technicalPostCode','technicalPost')"
												   doubleSrc="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png"
												   doubleCssStyle="cursor:hand;border:0" readonly="true"/>
								</td>
							</tr>

							<tr>
								<td nowrap class=EditHead>
									职位
								</td>
								<td class=editTd align="left">
									<s:buttonText2 id="duty" name="crudObject.duty"
												   hiddenId="dutyCode" hiddenName="crudObject.dutyCode"
												   cssClass="noborder"
												   doubleOnclick="queryData('/ais/mng/employee/queryDuty.action',' 职位 ',440,410,'dutyCode','duty')"
												   doubleSrc="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png"
												   doubleCssStyle="cursor:hand;border:0" readonly="true"/>
								</td>
								<td nowrap class=EditHead>专业岗位</td>
								<td class="editTd">
									<s:select list="basicUtil.professionalPositionList" name="crudObject.professionalPositionCode" listKey="code" listValue="name" emptyOption="true" cssClass="easyui-combobox"/>
								</td>
							</tr>

							<tr>
								<td class=EditHead>
									参加工作时间
								</td>
								<td class=editTd align="left">
									<input id="graduateDate" type="text" editable="false" class="easyui-datebox noborder" name="crudObject.graduateDate" title="单击选择日期" style="width:150px;" value="${crudObject.graduateDate}"/>
								</td>
								<td class="EditHead">
									入司时间
								</td>
								<td class="editTd">
									<input type="text" editable="false" class="easyui-datebox noborder" title="单击选择日期" style="width:150px;" name="crudObject.beginWorkDate" value="${crudObject.beginWorkDate}">
								</td>
							</tr>

							<tr>
								<td class=EditHead>
									加入本公司审计部时间
								</td>
								<td class=editTd align="left">
									<input type="text" id="entryTime" editable="false" class="easyui-datebox noborder" title="单击选择日期" style="width:150px;" name="crudObject.entryTime" value="${crudObject.entryTime}">
								</td>
								<td class="EditHead">
									内审从业起始时间
								</td>
								<td class="editTd">
									<input type="text" editable="false" class="easyui-datebox noborder" title="单击选择日期" style="width:150px;" name="crudObject.joinCorpDate" value="${crudObject.joinCorpDate}">
								</td>
							</tr>

							<tr>
								<td nowrap class=EditHead>
									IT技能<FONT color="gray"><br/>(请着重说明数据分析能力与编程能力)</FONT>
								</td>
								<td class="editTd">
									<s:textfield cssClass="noborder" id="itskill" name="crudObject.itskill" cssStyle="width:40%;" size="37" maxlength="200"/>
								</td>
								<td nowrap class=EditHead>精通领域</td>
								<td class="editTd">
									<s:textfield cssClass="noborder" id="masterfield" name="crudObject.masterfield" cssStyle="width:40%;" size="37" maxlength="18"/>
								</td>
							</tr>

							<tr>
								<td class=EditHead>
									人员状态
								</td>
								<td class=editTd align="left">
									<s:textfield cssClass="noborder" id="incumbencyState" readonly="true" name="crudObject.incumbencyState" cssStyle="width:40%;"/>
									<s:hidden id="incumbencyStateCode" name="crudObject.incumbencyStateCode"/>
								</td>
								<td class=EditHead>
									离职时间
								</td>
								<td class=editTd align="left">
									<input type="text" editable="false" class="easyui-datebox noborder" title="单击选择日期" style="width:150px;" name="crudObject.dimissionDate" value="${crudObject.dimissionDate}">
								</td>
							</tr>

							<tr>
								<td nowrap class=EditHead>
									座机
								</td>
								<td class=editTd align="left">
									<s:textfield cssClass="noborder" id="officePhone" name="crudObject.officePhone" cssStyle="width:40%;"/>
								</td>
								<td nowrap class=EditHead>
									手机
								</td>
								<td class=editTd align="left">
									<s:textfield cssClass="noborder" id="mobileTelephone" name="crudObject.mobileTelephone" cssStyle="width:40%;"/>
								</td>
							</tr>

							<tr>
								<td nowrap class=EditHead>
									电子邮箱
								</td>
								<td class=editTd align="left">
									<s:textfield cssClass="noborder" id="email" name="crudObject.email" size="37" cssStyle="width:40%;" maxlength="127"/>
								</td>
								<td nowrap class=EditHead>岗位类别</td>
								<td class=editTd align="left">
									<s:hidden id="postCategoryCode" name="crudObject.postCategoryCode"/>
									<select id="postCategory" editable="false" multiple="multiple" style="width:35%">
										<c:forEach items="${basicUtil.empPostCategoryList}" var="s">
											<option value="${s.code}">${s.name}</option>
										</c:forEach>
									</select>
								</td>
							</tr>

							<tr>
								<td nowrap class=EditHead>
									紧急联系人
								</td>
								<td class=editTd align="left">
									<s:textfield cssClass="noborder" id="emergency" name="crudObject.emergency" cssStyle="width:40%;" size="37" maxlength="16"/>
								</td>
								<td nowrap class=EditHead>
									紧急联系人电话
								</td>
								<td class=editTd align="left">
									<s:textfield cssClass="noborder" id="emergencyPhone" name="crudObject.emergencyPhone" cssStyle="width:40%;" size="37" maxlength="16"/>
								</td>
							</tr>

							<tr>
								<td nowrap class="EditHead" nowrap>
									<FONT color=red>*</FONT>信息更新说明</br>
									<span style="color: DarkGray;">(限500字)</span>
								</td>
								<td class=editTd colspan="3">
									<s:textarea cssClass="noborder" id="explain" name="crudObject.explain" cssStyle="width:100%;overflow-y:visible;" title="信息更新说明"/>
									<input type="hidden" id="crudObject.explain.maxlength" value="500">
								</td>
							</tr>
						</table>
					</div>
					<s:if test="${taskInstanceId ne -1}">
						<div align="center">
							<jsp:include flush="true" page="/pages/bpm/list_transition.jsp" />
						</div>
					</s:if>

					<div align="center">
						<jsp:include flush="true" page="/pages/bpm/list_taskinstanceinfo.jsp" />
					</div>
				</div>
			</s:form>
		</div>
	</div>
	<s:if test="${not empty(crudObject.employeeInfoId)}">
		<div title="教育经历" style="overflow: hidden">
			<iframe width="100%" height="100%" frameborder="0" scrolling="no"></iframe>
		</div>
		<div title="工作履历(加入本单位前)" style="overflow: hidden">
			<iframe width="100%" height="100%" frameborder="0" scrolling="no"></iframe>
		</div>
		<div title="工作履历(加入本单位后)" style="overflow: hidden">
			<iframe width="100%" height="100%" frameborder="0" scrolling="no"></iframe>
		</div>
		<div title="职业资质" style="overflow: hidden">
			<iframe width="100%" height="100%" frameborder="0" scrolling="no"></iframe>
		</div>
		<div title="学术科研能力" style="overflow: hidden">
			<iframe width="100%" height="100%" frameborder="0" scrolling="no"></iframe>
		</div>
		<div title="所获荣誉" style="overflow: hidden">
			<iframe width="100%" height="100%" frameborder="0" scrolling="no"></iframe>
		</div>
		<div title="绩效情况" style="overflow: hidden">
			<iframe width="100%" height="100%" frameborder="0" scrolling="no"></iframe>
		</div>
		<div title="参训情况" style="overflow: hidden">
			<iframe width="100%" height="100%" frameborder="0" scrolling="no"></iframe>
		</div>
		<div title="关联关系情况" style="overflow: hidden">
			<iframe width="100%" height="100%" frameborder="0" scrolling="no"></iframe>
		</div>
		<div title="其他档案文件" style="overflow: hidden">
			<iframe width="100%" height="100%" frameborder="0" scrolling="no"></iframe>
		</div>
	</s:if>
</div>
  
  <div id="subwindow" class="easyui-window" title="" style="width:500px;height:500px;padding:5px;" closed="true">
			<div class="easyui-layout" fit="true">
				<div region="center" border="false" style="padding:10px;background:#fff;border:1px solid #ccc;overflow:hidden">
					<iframe id="item_ifr" name="item_ifr" src="" frameborder="0" width="100%" height="100%" scrolling="auto" title=""></iframe>
				</div>
				<div region="south" border="false" style="text-align:right;padding:5px 0;">
				    <div style="display: inline;" align="right">
				        <input type="hidden" id="para1" value="">
				        <input type="hidden" id="para2" value=""> 
						<a class="easyui-linkbutton" data-options="iconCls:'icon-ok'" href="javascript:void(0)" onclick="saveF()">确定</a>
						<a class="easyui-linkbutton" data-options="iconCls:'icon-empty'" href="javascript:void(0)" onclick="cleanF()">清空</a>
						<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" href="javascript:void(0)" onclick="closeWin()">关闭</a>
				    </div>
				</div>
			</div>
	</div>
    
	<!-- 自定义查询条件  -->
	<select id="query_year" name="query_year" style='width:130px; display:none;'></select>
	<select id="query_status" name="query_status" style="width:130px;display:none;"></select>
	<select id="query_tradePlate" name="query_tradePlate" style='width:130px; display:none;'></select>
	<!-- ajax请求前后提示 -->
	<jsp:include flush="true" page="/pages/frReportFlow/ajaxloading.jsp" />

	<script type="text/javascript">
		$(function(){
			initFields();

			var sysAccounts = [$('#sysAccounts').val()];
			if (sysAccounts[0]) {
				getUserById(sysAccounts);
				initFrames('${crudObject.employeeInfoId}');
			}
		});

		//-----------------模态窗口------刷新父窗口------------------------------
		function openWindowByUrl(url){//打开模态窗口
			var arg=new Object();//传递进去的参数
			arg.win=window;//把当前窗口的引用当参数传进去
			newopen=showModalDialog(url,arg ,"dialogHeight:548px;dialogWidth:708px;center:yes;status:no;resizable:no;");
		}

        // 岗位类别多选框
        (function(){
            var postCategoryCode = $('#postCategoryCode');
            var postCategory = $('#postCategory');

            var ids = postCategoryCode.val().split(',');
            postCategory.find('option').each(function (i, option) {
                option.selected = $.inArray(option.value, ids) != -1;
            });

            postCategory.multiSelect({
                selectAll: false,
                oneOrMoreSelected: '*',
                selectAllText: '全选',
                noneSelected: ''
            }, function() {
                postCategoryCode.val($('#postCategory').selectedValuesString());
            });
        })();

		function initFields() {
			$('#workingAbroad').attr('maxlength',500);
			$('#explain').attr('maxlength',500);

			$("#myForm").find("textarea").each(function(){
				autoTextarea(this);
			});
		}

		function initFrames(employeeInfo_id) {
			if (employeeInfo_id != '') {
				var srcArray = [
					'',
					// 教育经历
					'${contextPath}/mng/employee/personnel/getEducationExperience.action?employeeInfo_id=' + employeeInfo_id,
					// 工作履历(加入本单位前)
					'${contextPath}/mng/employee/personnel/getBeforeJob.action?employeeInfo_id=' + employeeInfo_id,
					// 工作履历(加入本单位后)
					'${contextPath}/mng/employee/personnel/getAfterJob.action?employeeInfo_id=' + employeeInfo_id,
					// 职业资质
					'${contextPath}/mng/employee/personnel/getProfessionalCertificate.action?employeeInfo_id=' + employeeInfo_id,
					// 学术科研能力
					'${contextPath}/mng/employee/personnel/getAcademicCapabilities.action?employeeInfo_id=' + employeeInfo_id,
					// 所获荣誉
					'${contextPath}/mng/employee/personnel/getHonours.action?employeeInfo_id=' + employeeInfo_id,
					// 绩效情况
					'${contextPath}/mng/employee/personnel/getPerformance.action?employeeInfo_id=' + employeeInfo_id,
					// 参训情况
					'${contextPath}/mng/employee/personnel/getParticipation.action?employeeInfo_id=' + employeeInfo_id,
					// 关联关系情况
					'${contextPath}/mng/employee/personnel/getRelationsStatus.action?employeeInfo_id=' + employeeInfo_id,
					// 其他档案文件
					'${contextPath}/mng/employee/personnel/getOtherFile.action?employeeInfo_id=' + employeeInfo_id
				];
				$('#tabDiv').tabs({
					border: false,
					onSelect: function (title, idx) {
						if (idx > 0) {
							var iframe = $(this).tabs('getTab', idx).find('iframe');
							if (!iframe.attr('src')) {
								iframe.attr('src', srcArray[idx]);
							}
						}
					}
				});
			}
		}

		function getUserById(id) {
			$.ajax({
				url: '${pageContext.request.contextPath}/mng/employee/getUserById.action',
				type: 'POST',
				data: {'userId': id[0]},
				async: false,
				success: function (data) {
					data = eval('(' + data + ')');
					// 排序编号
					if ($('#orderNo').val() == '') {
						$('#orderNo').val(data.forder != null ? data.forder : '');
					}
					// 所属单位/部门
					document.getElementsByName("crudObject.companyCode")[0].value = data.fdepid;
					document.getElementsByName("crudObject.company")[0].value = data.fdepname;
					// 人员状态
					$('#incumbencyStateCode').val(data.fstate);
					$('#incumbencyState').val(data.fstateName);
					// // 出生日期
					// $('#crudObjectBorn').datebox('setValue', getDate(data.fborn));
					// // 性别
					// $('#crudObjectSex').val(data.fsex != null ? data.fsex : '');
					// // 座机
					// $('#officePhone').val(data.fphone != null ? data.fphone : '');
					// // 手机
					// $('#mobileTelephone').val(data.fmobile != null ? data.fmobile : '');
					// // 电子邮箱
					// $('#email').val(data.femail != null ? data.femail : '');
				}
			})
		}

		function inputtable(){
			var psncode=document.getElementById('psncode').value;
			window.location='${contextPath}/mng/employee/employeeInfoAdd_feng.action?psncode='+psncode;
		}
		function save(){
			if (!audEvd$validateform('myForm')) {
				return;
			}

			var explain = document.getElementById("explain").value;
			if (explain == null || explain == "" || explain.length == 0) {
				showMessage1("信息更新说明不能为空!");
				return false;
			}
			if (explain.length > 500) {
				showMessage1("信息更新说明不能超过500字!");
				return false;
			}

			myForm.submit();
		}

		//清空离职时间后执行该方法
		function afterClear(){
			if(WebCalendar.objExport.name == 'crudObject.dimissionDate')
				document.getElementsByName('crudObject.incumbencyStateCode')[0].value = '801710';
		}

		//选择离职时间后执行该方法
		function afterClick(){
			if(WebCalendar.objExport.name == 'crudObject.dimissionDate')
				document.getElementsByName('crudObject.incumbencyStateCode')[0].value = '801720';
		}

		//验证系统帐号
		function validateSysAcc(loginname, id){
			var flag = false;
			//if(sys!=null && sys=='是'){//系统账号必填
			if(loginname==null || loginname==''){
				alert("请选择系统账号！");
				return false;
			}else{
				DWREngine.setAsync(false);
				DWREngine.setAsync(false);DWRActionUtil.execute(
						{ namespace:'/mng/employee', action:'validateSysAccounts', executeResult:'false' },
						{ 'ln':loginname, 'poid':id },
						xxx);
				function xxx(data){
					if(data['message'] != null && data['message'] != ""){
						alert(data['message']);
						flag = false;
					}else{
						flag = true;
					}
				}
				return flag;
			}
			//}else
			//	flag = true;
			return  flag;

		}

		function nameAndCode(){
			var sysName = document.getElementsByName("crudObject.sysAccounts")[0].value;
			//填写姓名 和人员编码
			DWREngine.setAsync(false);
			DWREngine.setAsync(false);DWRActionUtil.execute(
					{ namespace:'/mng/employee', action:'findNameAndCode', executeResult:'false' },
					{'sysAccounts':sysName},
					xxx1);
			function xxx1(data){
				if(data['name'] != null && data['name'] != ''){
					document.getElementsByName("crudObject.name")[0].value=data['name'];
				}
				if(data['personnelCode'] != null && data['personnelCode'] != ''){
					document.getElementsByName("crudObject.personnelCode")[0].value=data['personnelCode'];
				}
			}
		}
		//验证人员编码是否重复
		function personCodeValidate(){
			var flag = false;
			var personnelCode = document.getElementsByName("crudObject.personnelCode")[0].value;
			DWREngine.setAsync(false);
			DWREngine.setAsync(false);DWRActionUtil.execute(
					{ namespace:'/mng/employee', action:'validatePersonCode', executeResult:'false' },
					{ 'personnelCode':personnelCode},
					xxx);
			function xxx(data){
				if(data['message'] != null && data['message'] != ""){
					alert(data['message']);
					flag = false;
				}else{
					flag = true;
				}
			}
			return flag;
		}

		function sucFun(){
			if($("#sucFlag").val()=='1'){
				$("#sucFlag").val('');
				$.messager.show({title:'提示信息',msg:'保存成功!'});
			}
		}

		function toSubmit(act){
			if (!audEvd$validateform('myForm')) {
				return false;
			}

			<s:if test="isUseBpm=='true'">
			if(document.getElementsByName('isAutoAssign')[0].value=='false'||document.getElementsByName('formInfo.toActorId')[0]!=undefined){
				var actor_name=document.getElementsByName('formInfo.toActorId')[0].value;
				if(actor_name==''){
					$.messager.show({title:'提示信息',msg:'下一步处理人不能为空！'});
					return false;
				}
			}
			</s:if>
			jQuery("#myForm").attr("action","submit.action");
			jQuery("#myForm").submit();
		}

		function beforStartProcess() {
			if(audEvd$validateform('myForm')) {
				$('#submitButton2Start').linkbutton('disable');
				myForm.action =  "<s:url action="start" includeParams="none"/>";
				return true;
			} else {
				return false;
			}
		}

		function doStart(){
			// 流程信息为空
			var processName=document.getElementById("definition_id").value.replace(/\s+$|^\s+/g,"");
			var groupName=document.getElementById("group_id").value.replace(/\s+$|^\s+/g,"");
			document.getElementById("definition_idTemp").value=processName;
			document.getElementById("group_idTemp").value=groupName;
			document.getElementById('myForm').action = "start.action";
			document.getElementById('myForm').submit();
		}

		function queryData(url,title,width,height,para1,para2){
			if($('#item_ifr').attr('title') == title){
				if($('#item_ifr').attr('src') == ''){
					$('#item_ifr').attr('src',url);
				}
			}else{
				$('#item_ifr').attr('title',title);
				$('#item_ifr').attr('src',url);
			}
			$('#para1').attr('value',para1);
			$('#para2').attr('value',para2);
			$('#subwindow').window({
				title: title,
				width: width,
				height:height,
				modal: true,
				shadow: true,
				closed: false,
				collapsible:false,
				maximizable:false,
				minimizable:false
			});
		}
		function saveF(){
			var ayy = $('#item_ifr')[0].contentWindow.saveF();
			var p1 = $('#para1').attr('value');
			var p2 = $('#para2').attr('value');
			document.all(p1).value=ayy[0];
			document.all(p2).value=ayy[1];
			closeWin();
		}
		function cleanF(){
			var p1 = $('#para1').attr('value');
			var p2 = $('#para2').attr('value');
			document.all(p1).value='';
			document.all(p2).value='';
			closeWin();
		}
		function closeWin(){
			$('#subwindow').window('close');
		}
	</script>
</body>
</html>
