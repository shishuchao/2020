<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE HTML>
<s:if test="crudObject.formId!=null">
	<s:text id="title" name="'修改底稿'"></s:text>
</s:if>
<s:else>
	<s:text id="title" name="'增加底稿'"></s:text>
</s:else>
<!-- 审计底稿   -->
<html>
<head>
	<title><s:property value="#title" /></title>
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
	<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
	<script type="text/javascript" src="${contextPath}/scripts/validate.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
	<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
	<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
	<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
	<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/autosize.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/jquery-fileUpload.js"></script>
	<%-- 导致可编辑下拉框，只能初始化时候，可编辑一次，之后再点击下拉框，无法再次输入编辑，暂且注释<script type="text/javascript" src="${contextPath}/scripts/ufaudTextLengthValidator.js"></script> --%>
	<script type="text/javascript" src="${contextPath}/pages/tlInteractive/tlInteractiveCommon.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/ueditor/ueditor.config.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/ueditor/ueditor.all.js"></script>
	<style type="text/css">
		/* 浮动最上层 */
		#div1 {
			z-index: 9;
		}

		#div2 {
			z-index: 1;
		}
	</style>
	<script type="text/javascript">
	
		//每十分钟自动保存
		//var int=self.setInterval("autoSave()",600000)
		var interval = '${manuAutoSaveInterval}';
		if (interval==null || interval==''){
			interval = 10; //没设置自动保存间隔时间则默认10分钟
		}else{
			interval = parseInt(interval, 10);
			interval = interval<1 ? 10 : interval;
		}
		var int=self.setInterval("autoSave()", interval*60*1000);
		
		
		// 设置自动保存
		function autoSave(){
			var bool = true;//提交表单判断参数
			if(!checkWithoutFocus()){
				bool = false;
				return false;
			}
			//完成保存表单操作
			if(bool){
				$.ajax({
					type : "POST",
					dataType : "text",
					url : "${contextPath}/operate/manu/autoSave.action?autoSave=1",
					async : false,
					data:$("#myform").serialize(),
					success : function() {
						window.parent.$.messager.show({
							title : '提示信息',
							msg : "底稿自动保存成功！",
							timeout : 5000,
							showType : 'slide'
						});
					}
				});
			}
		}
		
		//对输入内容校验   防止影响输入，去掉focus()方法
		function checkWithoutFocus() {
			var manu_code = document.getElementsByName("crudObject.ms_code")[0].value;
			var flag = true;
			var bool = true;//提交表单判断参数
			$.ajax({
				type : "POST",
				dataType : "text",
				url : "${contextPath}/operate/manu/checkCode.action",
				async : false,
				data : {
					'project_id' : '${crudObject.project_id}',
					'manu_code' : manu_code,
					'formId' : '${crudObject.formId}'
				},
				success : function(data) {
					if (data != '1') {
						window.parent.$.messager.show({
							title : '提示信息',
							msg : "自动保存失败！底稿编码重复,请重新输入!",
							timeout : 5000,
							showType : 'slide'
						});
						flag = false;
					}
				}
			});
			if (!flag) {
				bool = false;
				return false;
			}

			if (!checkEmptyNumWithoutFocus("crudObject.ms_name", "底稿名称", 100)) {
				bool = false;
				return false;
			}
			if ('${crudObject.formId}' != null && '${crudObject.formId}' != 'null' && '${crudObject.formId}' != '') {
				if (!checkEmptyNumWithoutFocus("crudObject.ms_code", "底稿编码")) {
					bool = false;
					return false;
				}
				var v_3 = "crudObject.ms_code";
				document.getElementsByName(v_3)[0].value=document.getElementsByName(v_3)[0].value.replace(/\s+$|^\s+/g,"");
			}

			//liululu 1.将if判断去掉；2.补全判断条件。问题：taskId的获取与作用？
			if ('${taskId}' == '-1' || '${taskId}' == null || '' == '${taskId}'
					|| '${taskId}' == 'null') {
				if (!checkEmptyNumWithoutFocus("crudObject.task_name", "审计事项")) {
					bool = false;
					return false;
				}
			}
			if (!checkEmptyNumWithoutFocus("crudObject.audit_dept", "被审计单位", 3000)) {
				bool = false;
				return false;
			}
//			setAttendPerson();
			setAuditGroup();
			if(bool){
				return true;
			}
		}

		//去掉前后空格
		String.prototype.Trim =function() {
			return this.replace(/(^\s*)|(\s*$)/g,"");
		}
		
		// 保存成功提示  如果存在我的事项页签 侧刷新我的事项
		<%String pb = (String) request.getParameter("back");%>
		<%String fap = (String) request.getParameter("fap");%>
		//保存成功   显示信息
		var msg="${requestScope.tipMessage}";
		if(msg!=""&&msg=='true'){
			window.parent.$.messager.show({
				title:'提示信息',
				msg:'保存成功',
				timeout:5000,
				showType:'slide'
			});
			//top.$(".nav-tabs li").each(function(){
			top.$(".tabs li").each(function(){
				var  gg = $(this).text();
				if( gg == '我的事项'){
					var tabId = $(this).children('a').attr("aria-controls");
					//刷新有问题，暂时注释
					refreshMyTaskManuGrid(tabId);
				}
			});
		}
		// 保存后 刷新我的事項
		function refreshMyTaskManuGrid(tabId){
			try{
				var browser=navigator.appName
				var b_version=navigator.appVersion
				var version=b_version.split(";");
				var trim_Version=version[1].replace(/[ ]/g,"");
				if(browser=="Microsoft Internet Explorer" && trim_Version=="MSIE8.0")
				{

				} else{
					//var t = top.Addtabs.options.obj.children(".tab-content");
					//var tabIfm = t.find('#'+tabId).find('.iframeClass');
					var tabIfm = top.$("#tabs").tabs("getTab",'我的事项').find('iframe');
					if(tabIfm.length){
						var ifmWin = tabIfm.get(0).contentWindow;
						ifmWin.$('#operate-task-detail-list-1').datagrid('reload');
						ifmWin.$('#'+ifmWin.$('#mytaskTableId').val()).treegrid('reload');
						//ifmWin.$('#'+ifmWin.$('#mytaskTableId').val()).treegrid('select',ifmWin.$('#myTaskTemplateId').val());
					}
				}
			}catch(e){

			}
		}
		
		
	</script>
</head>

<s:if test="taskInstanceId!=null&&taskInstanceId!=''">
<body onload="end();chang2link();"
	  style="overflow: hidden; overflow-x: hidden;" class="easyui-layout">
</s:if>
<s:else>
<body onload="chang2link();"
	  style="overflow: hidden; overflow-x: hidden;" class="easyui-layout">
</s:else>

<div fit="true" class="easyui-layout" region="center" border='0'  style="overflow: auto; ">
	<div region="center" border='0'>
		<s:form id="myform" action="submit" namespace="/operate/manu" onsubmit="return testStatus()">
			<div style="width: 100%;position:absolute;top:0px;" id="div1" align="center" >
				<table class="ListTable" align="center" style='width: 98.3%; padding: 0px; margin: 0px;'>
					<tr class="EditHead">
						<td >
						<span style='float: left; text-align: left;'>
						<s:property value="#title" /></span>
						</td>
						<td  >
						<span style='float: right; text-align: right;'>
				<%-- 	 	<s:if test="crudObject.formId==null">
								<a href="javascript:void(0);" id="importManu" class="easyui-linkbutton" data-options="iconCls:'icon-import'" onclick="importManuLederPro();">导入</a>&nbsp;
							</s:if>  --%>
							<s:if test="crudObject.formId!=null">
								<%@include file="/pages/bpm/list_toBeStart.jsp"%>&nbsp;
								<!-- <a href="javascript:void(0);" id="manuproblem" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="addManuLederPro();">新增问题</a>&nbsp; -->
							</s:if>
							<span id="addProblem">
									<a href="javascript:void(0);" id="manuproblem" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="addManuLederPro();">新增问题</a>&nbsp;
							</span>
							<a href="javascript:void(0);" id="root" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="saveForm();">保存</a>&nbsp;
							<%if("true".equals(pb)){%> <% }else{%>
							  <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-undo'" onclick="backList();">返回</a>&nbsp;
							<% }%>
						    </span>
						</td>
					</tr>

				</table>
			</div>
			<div class="position:relative" id="div2">
				<table class="ListTable" align="center" style='margin-top: 40px; overflow: auto;'>
					<tr>
						<td class="EditHead" style="width: 15%;"><font color="red"></font>&nbsp;&nbsp;&nbsp;底稿状态
						</td>
						<td class="editTd" style="width: 35%;" colspan="3"><s:if
								test="crudObject.ms_status == '010'">
							底稿草稿
						</s:if> <s:if test="crudObject.ms_status == '020'">
							正在征求
						</s:if> <s:if test="crudObject.ms_status == '030'">
							等待复核
						</s:if> <s:if test="crudObject.ms_status == '040'">
							正在复核
						</s:if> <s:if test="crudObject.ms_status == '050'">
							复核完毕
						</s:if>
							<input type="hidden" name="manu_id" id="manu_id" value="${crudObject.formId}" />
							<s:if test="${taskInstanceId >0 }">
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								${versionUrl }
							</s:if>
						</td>
					</tr>
					<tr>
						<s:if test="${taskPid=='auditObject'} || ${taskPid =='groupId'}">
							<s:hidden name="crudObject.task_name" id="task_name" />
							<td class="EditHead" style="width: 15%">
								<s:hidden name="crudObject.change_code" />
								<font color="red">*</font>
								审计事项
							</td>
							<td class="editTd" style="width: 35%">
								<select id="task_id" class="easyui-combobox" panelHeight="auto" name="crudObject.task_id" style="width: 32%;" editable="false">
									<s:iterator value="matterObjectMap" id="entry">
										<s:if test="${crudObject.task_id==key}">
											<option selected="selected" value="<s:property value="key"/>"><s:property value="value" /></option>
										</s:if>
										<s:else>
											<option value="<s:property value="key"/>"><s:property value="value" /></option>
										</s:else>
									</s:iterator>
								</select>
							</td>
						</s:if>
						<s:else>
							<s:hidden name="crudObject.task_id" id="task_id" />
							<s:if test=" ${taskId=='-1'} || ${taskId } == null || ${taskId ==''}">
								<td class="EditHead" style="width: 15%">
									<s:hidden name="crudObject.change_code" />
									<font color="red">*</font>
									审计事项
								</td>
								<td class="editTd" style="width: 35%">
									<c:choose>
										<c:when test="${pso.planProcess eq 'simplified'}">
											<input type='text' oninput="clearTaskId()"
												   name="crudObject.task_name" value="${crudObject.task_name}"
												   id="task_name" style="width: 90%;"
												   class="noborder" maxlength="200"/>
											<img style="cursor: pointer; border: 0"  src="/ais/resources/images/s_search.gif" onclick="$('#atTreeWrap').window('open')" id="task_name_id"/>
										</c:when>
										<c:otherwise>
											<input type='text'
												   name="crudObject.task_name" value="${crudObject.task_name}"
												   id="task_name" style="width: 90%;"
												   class="noborder" />
											<img style="cursor: pointer; border: 0"  src="/ais/resources/images/s_search.gif" onclick="$('#atTreeWrap').window('open')"/>
										</c:otherwise>
									</c:choose>
	
								</td>
							</s:if>
							<s:elseif
									test="${todoback  == '1'} || ${taskInstanceId!=null&&taskInstanceId>0}">
								<td class="EditHead" style="width: 15%">
									<s:hidden name="crudObject.change_code" />
									<font color="red">*</font>
									审计事项
								</td>
								<td class="editTd" style="width: 35%">
									<c:choose>
										<c:when test="${pso.planProcess eq 'simplified'}">
											<input type='text' oninput="clearTaskId()"
												   name="crudObject.task_name" value="${crudObject.task_name}"
												   id="task_name" style="width: 90%;"
												   class="noborder" maxlength="200" />
											<img style="cursor: pointer; border: 0" src="/ais/resources/images/s_search.gif" onclick="$('#atTreeWrap').window('open')" id="task_name_id"></img>
										</c:when>
										<c:otherwise>
											<input type='text'
												   name="crudObject.task_name" value="${crudObject.task_name}"
												   id="task_name" style="width: 90%;"
												   class="noborder" readonly="readonly"/>
											<img style="cursor: pointer; border: 0" src="/ais/resources/images/s_search.gif" onclick="$('#atTreeWrap').window('open')"></img>
										</c:otherwise>
									</c:choose>
								</td>
							</s:elseif>
							<s:else>
								<s:hidden name="crudObject.change_code" value="1" />
								<td class="EditHead" style="width: 15%">
									&nbsp;&nbsp;&nbsp;审计事项</td>
								<!--标题栏-->
								<td class="editTd" style="width: 35%">
									<s:property value="crudObject.task_name" />
									<s:hidden name="crudObject.task_name" />
								</td>
							</s:else>
						</s:else>

							<%-- <td class="EditHead" style="width: 15%"><font color="red"></font>
                                参与人</td>
                            <td class="editTd" style="width: 35%">
                            <input id="attendPerson" />
                            <input type="hidden" id="attendMemberIds" name="crudObject.attendMemberIds" value="${crudObject.attendMemberIds}" />
                            <input type="hidden" id="attendMemberNames" name="crudObject.attendMemberNames" value="${crudObject.attendMemberNames}" /></td> --%>

						<td class="EditHead" >
							<!-- 							<span style="display:none"> -->
							<font color="red">*</font> 审计小组
							<!-- 							</span> -->
						</td>
						<td class="editTd">
							<!-- <span  style="display:none"> -->
							<input id="auditGroup"/>
							<input type="hidden" id="groupId" name="crudObject.groupId" value="${crudObject.groupId}" />
							<input type="hidden" id="groupName" name="crudObject.groupName"value="${crudObject.groupName}" />
							<!-- 						</span> -->
							<s:hidden name="crudObject.manu_start" />
							<s:hidden name="crudObject.audit_found" />
							<s:hidden name="crudObject.audit_matter" />
							<s:hidden name="crudObject.manu_end" /></td>
					</tr>

					<tr>
						<td class="EditHead" style="width: 15%">
							<font color="red">*</font>
							底稿名称</td>
						<!--标题栏-->
						<td class="editTd" style="width: 35%">
							<!--一般文本框-->
							<s:textfield name="crudObject.ms_name" id="ms_name" cssStyle='width:90%' cssClass="noborder" maxlength="500" />
							<s:hidden name="crudObject.customId" />
							<s:hidden name="crudObject.customName" />
							<s:hidden name="crudObject.task_code" />
						</td>

						<s:hidden name="crudObject.project_name" />

						<td class="EditHead" style="width: 15%">
							底稿编码
						</td>

						<td class="editTd" style="width: 35%">
								<%-- 		<s:if test="crudObject.formId!=null">
                                            <s:textfield name="crudObject.ms_code" cssStyle='width:260px'
                                                maxLength="80" onfocus="conCode()" />
                                            <input type="hidden" name="manu_id" id="manu_id" value="${crudObject.formId}"/>
                                            <font color="red">自动生成,请谨慎修改</font>
                                        </s:if>
                                        <s:else> --%>
							<s:property value="crudObject.ms_code" />
							<s:hidden name="crudObject.ms_code" />
							<s:hidden id="crudObject.ms_status" name="crudObject.ms_status" />
								<%-- 	</s:else> --%>
						</td>
					</tr>
					<tr>
						<td class="EditHead">&nbsp;&nbsp;&nbsp;关联索引</td>
						<td class="editTd"><span id="p1"></span></td>


						<td class="EditHead"><font color="red">*</font> 被审计单位</td>
						<td class="editTd">
							<select id="audit_dept" class="easyui-combobox" panelHeight="auto" name="crudObject.audit_dept" style="width: 176px;"
									editable="false" >
								<s:iterator value="auditObjectMap" id="entry">
									<s:if test="${crudObject.audit_dept==key}">
										<option selected="selected" value="<s:property value="key"/>"><s:property
												value="value" /></option>
									</s:if>
									<s:else>
										<option value="<s:property value="key"/>"><s:property
												value="value" /></option>
									</s:else>
								</s:iterator>
							</select></td>

					</tr>
					<tr>
						<td class="EditHead">底稿录入人</td>
						<!--标题栏-->
						<td class="editTd">
							<s:property value="crudObject.ms_author_name" /> <!--一般文本框-->
							<s:hidden name="crudObject.project_id" />
							<s:hidden name="crudObject.ms_author_name" />
							<s:hidden name="crudObject.ms_author" />
						</td>
						<td class="EditHead">底稿所属人</td>
						<!--标题栏-->
						<td class="editTd">
							<%-- <s:textfield id="ms_owner" name="crudObject.ms_owner" maxlength="100" cssClass="noborder"></s:textfield> --%>
							<select id="ms_owner" class="easyui-combobox" panelHeight="auto" name="crudObject.ms_owner" style="width: 176px;"
								editable="true" >
								<s:iterator value="memberObjectMap" id="entry">
									<s:if test="${crudObject.ms_owner==key}">
										<option selected="selected" value="<s:property value="key"/>"><s:property
												value="value" /></option>
									</s:if>
									<s:else>
										<option value="<s:property value="key"/>"><s:property
												value="value" /></option>
									</s:else>
								</s:iterator>
							</select>
						</td>
					</tr>

					<tr>
						<td class="EditHead">关联底稿</td>
						<td class="editTd">
							<s:textfield readonly="true" name="crudObject.linkManuName" id="mylinkManuName" cssStyle='width:90%' cssClass="noborder" />
							<input type="hidden" name="crudObject.linkManuId" id="mylinkManuId" value="${crudObject.linkManuId}" />
							
							  <img src="<%=request.getContextPath()%>/resources/images/s_search.gif"
								 onclick="getOwerManu()" border=0 style="cursor: pointer" >
							
							
						</td>
						<td class="EditHead">创建日期</td>
						<td class="editTd">
							<s:property value="crudObject.ms_date" />
							<s:hidden name="crudObject.ms_date" />
						</td>

					</tr>
					<tr id="record">
						<td class="EditHead">审计过程记录
							<div>
								<font color=DarkGray>(限5000字)</font>
							</div>
						</td>
						<td class="editTd" colspan="3">
								<%--<s:textarea
                                   cssClass="noborder" title="审计过程记录"
                                   name="crudObject.audit_record" id='crudaudit_record'
                                   value="${crudObject.audit_record}" rows="5"
                                   cssStyle="width:100%;overflow:hidden;line-height:150%;" />
                               <input type="hidden" id="crudObject.audit_record.maxlength" value="5000">--%>

							<script id="crudaudit_record" name="crudaudit_record" type="text/plain" style="width:100%"></script>
							<s:hidden name="crudObject.audit_record" id="crudaudit_record_value"></s:hidden>
						</td>
					</tr>
					<tr id="tr_audit_con" >
						<td class="EditHead">
							<span id="auditconclusion" ></span>审计结论
							<div>
								<font color=DarkGray>(限5000字)</font>
							</div>
						</td>
						<td class="editTd" colspan="3">
								<%-- <s:textarea cssClass="noborder" title="审计结论" name="crudObject.audit_con" id='audit_con'
                                value="${crudObject.audit_con}" rows="5" cssStyle="width:100%;overflow:hidden;line-height:150%;" />
                                <input type="hidden" id="crudObject.audit_con.maxlength" value="5000"> --%>
							<script id="crudaudit_con" name="crudaudit_con" type="text/plain" style="width:100%" ></script>
							<s:hidden name="crudObject.audit_con" id="crudaudit_con_value"></s:hidden>
						</td>
					</tr>

	<%--				<s:if test="crudObject.interact==1">
						<tr>
							<td class="EditHead">
								审计证据
							</td>
							<td class="editTd" colspan="3">
								<div id="subModelHTML" runat="server"
									 style="border-style: none; left: 0px; width: 98%; position: relative; top: 0px; line-height:150% ;">
									<s:property escape="false" value="crudObject.subModelHTML" />
								</div>
								<s:hidden name="crudObject.subModelHTML" id="subModelHTMLHidden"/>
								<s:hidden name="crudObject.ms_description" />
							</td>

						</tr>
					</s:if>
					<s:elseif test="crudObject.interact==2">
						<tr>
							<td class="EditHead">
								审计证据
							</td>
							<td class="editTd" colspan="3">
								<div id="subModelHTML" runat="server"
									 style="border-style: none; left: 0px; width: 98%; position: relative; top: 0px; line-height:150% ;">									<s:property escape="false" value="crudObject.subModelHTML" />
								</div>
								<s:hidden name="crudObject.subModelHTML"  id="subModelHTMLHidden" />
								<s:hidden name="crudObject.ms_description" />
							</td>

						</tr>
					</s:elseif>--%>
					<s:hidden name="crudObject.interact" id="interact" />
						<%-- 					<tr id="law"  >
                                                <td class="EditHead"><br>
                                                    定性依据
                                                    <div style='margin-top:3px;'>
                                                        <a id="lr_openZcfgTree" mc='audit_law' href="javascript:void(0);" class="easyui-linkbutton"
                                                      title="定性依据" data-options="iconCls:'icon-search'" >引用法规制度</a>
                                                    </div>
                                                    <div><font color=DarkGray>(限3000字)</font></div>
                                                    <s:hidden name="tableType" />

                                                    <input type="hidden" id="att" name="att" value="">
                                                    <input type="hidden" id="att2" name="att2" value="">
                                                </td>
                                                <td class="editTd" colspan="4">
                                                    <s:textarea  cssClass='noborder' name="crudObject.audit_law" id='audit_law' title="定性依据"
                                                        rows="5" cssStyle="width:100%;overflow:hidden;line-height:150%;"/>
                                                    <input type="hidden" id="crudObject.audit_law.maxlength" value="3000">

                                                </td>
                                            </tr> --%>

					<!-- add by qfucee, 2013.11.7 -->
						<%-- 	<tr id="advice">
                                <td class="EditHead">处理建议
                                    <div>
                                        <font color=DarkGray>(限3000字)</font>
                                    </div>
                                </td>
                                <td class="editTd" colspan="3"><s:textarea
                                        cssClass='noborder' title="处理建议" id="audit_advice"
                                        name="crudObject.audit_advice"
                                        value="${crudObject.audit_advice}" rows="5"
                                        cssStyle="width:100%;overflow:hidden;line-height:150%;" /> <input
                                    type="hidden" id="crudObject.audit_advice.maxlength" value="3000">
                                </td>
                            </tr> --%>
					<!-- end -->
					<s:if test="digaofankui=='enabled'">
						<tr>
							<td class="EditHead">&nbsp;&nbsp;&nbsp;被审计单位反馈意见
								<font color=DarkGray>(限3000字)</font>
							</td>
							<td class="editTd" colspan="3"><s:textarea
									cssClass='autoResizeTexareaHeight'
									name="crudObject.audit_dept_feedback"
									cssStyle="width:100%;height:200px;overflow-y:hidden;" /></td>

						</tr>
					</s:if>
					<s:else>
						<s:hidden name="crudObject.audit_dept_feedback" />
					</s:else>
					<s:hidden name="crudObject.audit_regulation" />
					<s:hidden name="crudObject.audit_file" />
					<s:hidden name="project_id" id='curProjectId' />
					<s:hidden name="taskPid" />
					<s:hidden name="taskId" />
					<s:hidden name="back" value="<%=pb%>" />
					<s:hidden name="fap" value="<%=fap%>" />
					<s:hidden name="crudObject.id" />
					<s:hidden name="crudObject.task_code_sort" />
					<s:hidden name="crudObject.ms_code_sort" />
					<s:hidden name="taskInstanceId" />
					<s:hidden name="crudObject.prom" />
					<s:hidden name="crudObject.feedback" />
					<s:hidden name="crudObject.batch" />
					<s:hidden name="crudObject.audit_law" />
					<s:hidden name="owner" />
					<s:hidden name="groupCode" />
					<s:hidden id="w_file" name="crudObject.file_id" />
					<s:hidden name="crudObject.sure_guid" />
					<s:hidden name="crudObject.isSureUpload"/>
				</table>

			</div>


			<s:hidden name="problemFlag" id="problemFlag"/>
			<s:hidden name="crudObject.formId" />
			<s:hidden name="processName" />
			<s:hidden name="project_name" />
			<s:hidden name="formNameDetail" />

		    <div id="sjproblemtr" style="display:none">
			<table class="ListTable" align="center" style='width: 98%; padding: 0px; margin: 0px;'>
				<tr>
					<td class="EditHead" id="sjproblemtd1" style="text-align: left;">审计问题
					</td>
				</tr>
				<tr>
					<td class="EditHead" colspan="3" id="sjproblemtd2">

						<iframe  width=100% height=150 frameborder=0 scrolling=auto id="mainIFrame" src=""></iframe>
					</td>
				</tr>
			</table>
		</div>
		   <br>
			<table class="ListTable" align="center" style='width: 98%; padding: 0px; margin: 0px;'>
			<tr>
				<td style="height: 300px;">
					<s:if test="${crudObject.isSureUpload=='1'}">
						<div id="manu_file2" class="easyui-fileUpload" data-options="fileGuid:'${crudObject.sure_guid}',isAdd:false,isEdit:false,isDel:false,fileGridTitle:'已确认底稿',callbackGridHeight:300"></div>
					</s:if>
					<div id="manu_file" class="easyui-fileUpload"
						 data-options="fileGuid:'${crudObject.file_id}',callbackGridHeight:300"></div>
				</td>
			</tr>
		</table>
			<jsp:include flush="true" page="/pages/bpm/list_transition.jsp" />
			<%@include file="/pages/bpm/list_taskinstanceinfo.jsp"%>
		</s:form>
	</div>
</div>
<!-- 审计事项树(单选,双击选择） -->
<div id='atTreeWrap' title='审计事项'
	 style='text-align: center; overflow: hidden; padding: 5px; border: 1px solid #cccccc;'>
	<div style="text-align: left; padding: 0 0 2px 5px;">
		搜索:&nbsp;&nbsp;
		<s:textfield id="contion_taskName" maxLength="100"
					 cssStyle="width:180px;height:24px;padding-top:5px;"></s:textfield>
		&nbsp;&nbsp;
		<button id='searchAtTree' class="easyui-linkbutton"
				iconCls="icon-search">搜索</button>
		&nbsp;&nbsp;
		<button id='sureAtTree' class="easyui-linkbutton" iconCls="icon-ok">确定</button>
		&nbsp;&nbsp;
		<button id='clearAtTree' class="easyui-linkbutton"
				iconCls="icon-empty">清空</button>
		&nbsp;&nbsp;
		<button id='exitAtTree' class="easyui-linkbutton"
				iconCls="icon-cancel">关闭</button>
	</div>
	<ul id='atTree'
		style='height: 350px; width: 670px; text-align: left; border: 1px solid #cccccc; border-bottom: 0px; padding: 5px; overflow: auto;'></ul>
</div>
<div id="manuReferenceDiv" title="引用底稿数据"
	 style='overflow: hidden; padding: 0px;'>
	<iframe id="myFrame" name="myFrame" title="引用底稿" src="" width="100%"
			height="100%" frameborder="0">
		<!-- main -->
	</iframe>
</div>
<div id="fileReferenceDiv" title="引用附件"
	 style='overflow: hidden; padding: 0px;'>
	<iframe id="myFileFrame" name="myFileFrame" title="引用附件" src="" width="100%" height="100%" frameborder="0">
		<!-- main -->
	</iframe>
</div>
<div id="manuProblemDiv" title="" style='overflow: hidden; padding: 0px;'>
	<iframe id="myFrameProblem"  title="" name="myFrameProblem" src="" width="100%" height="100%" frameborder="0">
	</iframe>
</div>
<div id="viewDoubtDiv" title="关联疑点查看"
	 style='overflow: hidden; padding: 0px;'>
	<iframe id="myDoubtFrame" name="myDoubtFrame" title="关联索引" src=""
			width="100%" height="100%" frameborder="0">
		<!-- main -->
	</iframe>
</div>
<div region="center" border='0'>
	<div id="layer" style="display: none" align="center">
		<img src="${contextPath}/images/uploading.gif"> <br> 正在读取，请稍候......
	</div>
	<div align="left" id="errorInfo1">
		<s:if test="%{#tipList.size != 0}">
			<s:iterator value="%{#tipList}">
				&nbsp;&nbsp;&nbsp;●<s:property value="%{position}" />：<s:property value="%{errorInfo}" />
				<br>
			</s:iterator>
		</s:if>
	</div>
	<div align="left" id="errorInfo2">
		<s:if test="%{#tipMessage != null}">
			&nbsp;&nbsp;&nbsp;●<s:property value="%{#tipMessage.errorInfo}" />
		</s:if>
	</div>
	<div id="audSearch" style="overflow: hidden;"></div>
</div>
<div id="importXML" class="easyui-window" closed="true">
	<s:form id="importForm" action="mutualToManage" namespace="/interact/interactProxyToWork" method="post" enctype="multipart/form-data" onsubmit="wait();">
		<table cellpadding=0 cellspacing=0 border=0 class="ListTable" align="center">
			<tr>
				<td align="left" class="EditHead" style="vertical-align: middle;">选择文件</td>
				<td class="editTd" align="left">
					<s:file name="myfile" size="66%" cssStyle="font-size:15px" accept="application/vnd.ms-xml"/></td>
				<td class="editTd" align="right"><a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-import'" id="importButton" onclick="submit_dr();">导入</a></td>
			</tr>
		</table>
		<s:hidden name="project_id"></s:hidden>
	</s:form>
</div>
<%-- <jsp:include flush="true" page="/pages/adl/zcfgTree.jsp" /> --%>
</body>
<script type="text/javascript">

    var editProblemWrite = "${varMap['editProblemWrite']}";
    var audit_recordWrite =  "${varMap['audit_recordWrite']}";
    var audit_conWrite =  "${varMap['audit_conWrite']}";
    // 富文本框
	var ue = UE.getEditor('crudaudit_record',{elementPathEnabled:false, zIndex: 2,autoFloatEnabled:false});
	ue.ready(function() {
		ue.setContent('${crudObject.audit_record}');
		if ( audit_recordWrite != null &&  String(audit_recordWrite) == "false" ){
			ue.setDisabled();
		}
	});

	var ue01 = UE.getEditor('crudaudit_con',{elementPathEnabled:false, zIndex: 2,autoFloatEnabled:false});
	ue01.ready(function() {
		ue01.setContent('${crudObject.audit_con}');
		if (audit_conWrite != null &&  String(audit_conWrite) == "false" ){
			ue01.setDisabled();
		}
	});

	// 流程判断是否可填写
	if (  editProblemWrite != null &&  String(editProblemWrite) == "false" ){
		document.getElementById("addProblem").style.display = "none";   
	}
	

	jQuery(document).ready(function(){
		// 滚动条top为0
		window.setTimeout(function(){
			$('body')[0].scrollTop = 0;
		},500);

		$("#lr_openZcfgTree").attr("maxlength",3000);
		//	$("#audit_advice").attr("maxlength",3000);
		//	$("#audit_law").attr("maxlength",3000);
		$("#audit_con_max").attr("maxlength",5000);
		$('#audit_con').attr('maxlength',5000); //审计结果

		/*  $('#task_name').on('input',function () {
             $('#task_id').val('');
         }); */


		// textarea 自动增加高度
		$("#myform").find("textarea").each(function(){
			autoTextarea(this);
		});
		// 审计小组数据设置
		var json1 = eval('(${groups})');
		$('#auditGroup').combobox({
			data:json1.groupList,
			valueField:'groupId',
			panelHeight:'auto',
			textField:'groupName',
			editable:false,
			onChange:function(newValue,oldValue){
				$.ajax({
					url : "<%=request.getContextPath()%>/operate/manu/getAuditObjectByGroupId.action",
					dataType:'json',
					cache:false,
					type:"POST",
					data:{'groupId':newValue},
					success:function(data){
						if (newValue != null && newValue != "" && newValue.length >3 ){
							$("#audit_dept").combobox({
								valueField:'audit_object',
								textField:'audit_object_name',
								data:data.auditObject
							});
							if ( data.auditObject){
								$('#audit_dept').combobox('setValue', data.auditObject[0].audit_object);
								$('#audit_dept').combobox('setText', data.auditObject[0].audit_object_name);
							}

							//初始化 底稿所属人
							$("#ms_owner").combobox({
								valueField:'userCode',
								textField:'userName',
								data:data.memberObject
							});
						}
					}
				});
				loadSjsxTree();
			}
		});
		
		// 审计事项 窗口
		$('#atTreeWrap').window({
			width:700,
			height:460,
			modal:true,
			collapsible:false,
			maximizable:true,
			minimizable:false,
			closed:true
		});

		//初始化关联索引窗口
		$('#viewDoubtDiv').window({
			width:800,
			height:500,
			modal:true,
			collapsible:false,
			maximizable:true,
			minimizable:false,
			closed:true
		});

		// 审计问题新增-编辑窗口
		$('#manuProblemDiv').window({
			width: '100%',
			height:'100%',
			modal:true,
			collapsible:false,
			maximizable:false,
			minimizable:false,
			closed:true,
			closable:true
		});


		//初始化引用底稿窗口
		$('#manuReferenceDiv').window({
			width:650,
			height:450,
			modal:true,
			collapsible:false,
			maximizable:true,
			minimizable:false,
			closed:true
		});

		// 初始化引用附件窗口
		$('#fileReferenceDiv').window({
			width:950,
			height:450,
			modal:true,
			collapsible:false,
			maximizable:true,
			minimizable:false,
			closed:true
		});

		// 导入底稿窗口
		$('#importXML').window({
			title:'导入底稿文件',
			modal:true,
			width:900,
			minimizable: false,
			maximizable: false,
			collapsible: false,
			closed:true
		});


		//审计事项 查询
		$('#searchAtTree').bind('click',loadSjsxTree);
		// 注销审计树加载
	//	loadSjsxTree();
		
		// 审计事项  清空
		$('#clearAtTree').bind('click',function(){
			$('#contion_taskName').val('');
			loadSjsxTree();
		});
		//审计事项 退出
		$('#exitAtTree').bind('click',function(){
			$('#atTreeWrap').window('close');
		});
		
        // 审计事项  确定
        $('#sureAtTree').bind('click',function(){
            var node =  $('#atTree').tree('getSelected');
            //var arr = node.text.split("<font style=\"color:red;\">");
            //var wtlbMc = node.text;
            //for(var i=0; i<arr.length; i++){
            //    wtlbMc = wtlbMc.replace(/<font style="color:red;">/g,"").replace(/<\/font>/g,"");
            //}
            $('#task_id').val(node.id);
            doTaskName();
            $('#atTreeWrap').window('close');
//             if(node && $('#atTree').tree('isLeaf',node.target)){
//                 var arr = node.text.split("<font style=\"color:red;\">");
//                 var wtlbMc = node.text;
//                 for(var i=0; i<arr.length; i++){
//                     wtlbMc = wtlbMc.replace("<font style=\"color:red;\">","").replace("</font>","");
//                 }
//                 $('#task_id').val(node.id);
//                 doTaskName();
//                 $('#atTreeWrap').window('close');
//             }else{
//                 $.messager.alert('提示信息','只能选择末级节点','error');
//             }
		});
		
		
		// 审计问题列表
		var prom = document.getElementsByName("crudObject.prom")[0].value;
		if(prom != null &&  prom != "" && prom != '0'){
			manuLederPro();
		}
		//打开问题界面
		if('${problemFlag}'=='1'){
			$('#problemFlag').val('0');
			addManuLederPro();
		}
		
		//设置底稿所属人
		if('${crudObject.ms_owner}'!=null&&'${crudObject.ms_owner}'!=''){
			$('#ms_owner').combobox('setValue','${crudObject.ms_owner}');
			$('#ms_owner').combobox('setText','${crudObject.ms_owner}');
		}
		
		// 设置审计小组
		if('${crudObject.groupId}'!=null&&'${crudObject.groupId}'!=''){
			$('#auditGroup').combobox('setValue','${crudObject.groupId}'.split(','));
			$('#auditGroup').combobox('setText','${crudObject.groupName}');
		}

		// 被审计单位
		var auditCode = $('#audit_dept').combobox('getValue');
		var auditName = $('#audit_dept').combobox('getText');
		$('#audit_dept').combobox({
			onChange:function(newValue,oldValue){
				loadSjsxTree();
			}
		});

		// 设置被审计单位i
		$('#audit_dept').combobox('setValue', auditCode);
		$('#audit_dept').combobox('setText', auditName);
		
		
	});



	// 清理审计事项
	function clearTaskId(){
		$('#task_id').val('');
	}

	// 审计事项 加载树
	function loadSjsxTree(){
		try{
			$("#atTree").tree('loadData', []);
		}catch(e){
		}
		var contion_taskName=$("#contion_taskName").val();
		$.ajax({
			url : "<%=request.getContextPath()%>/adl/getAuditTaskTree.action",
			dataType:'json',
			cache:false,
			type:"POST",
			data:{'showmanusum':'1','projectId':'${crudObject.project_id}','contion_taskName':contion_taskName,'isdigao':'Y',
				'groupId':$('#auditGroup').combobox('getValue'),'auditObject':$('#audit_dept').combobox('getValue')},
			success:function(data){
                debugger;
                if(data.type=='success'){
					var treeData = data.atTreeJson;
					$('#atTree').tree({
						lines:true,
						data:treeData,
						onlyLeafCheck:true,
						onDblClick:function(node){
							$('#sureAtTree').trigger('click');
						}
					});
				}else{
					if('${pso.planProcess}' != 'simplified') {
						$.messager.alert('提示信息', data.msg, 'error');
					} else {
						$('#task_name_id').hide();
					}
				}
			}
		})
	}

	//添加回车查询 审计事项
	$(document).keydown(function(event){
		if(event.keyCode == 13){
			loadSjsxTree();
		}
	});
	
	//重新设置事项名称
	function doTaskName(){
		var task_id = $("#task_id").val();
		var projectid = "${crudObject.project_id}";
		if(task_id != ""){
			$.ajax({
				type: "POST",
				url: "${contextPath}/proledger/problem/save!resetTaskName.action",
				data: {"getMethod":"1","task_id":task_id,"projectid":projectid},
				success: function(msg){
					var arr = msg.split("||");
					var taskName = arr[0];
					taskName = taskName.replace(/<font style="color:red;">/g,"").replace(/<\/font>/g,"");
                    			$("#task_name").val(taskName);
                    			$("#ms_name").val(taskName);

					var s = (arr[1]==null||arr[1]=='null')?'':arr[1];
					var sjgcjl = s.split(/\s/);
					var record = "";
					for(var j = 0; j < sjgcjl.length; j++){
                        record +=  sjgcjl[j] + "<br/>";
					}
					//审计记录中添加查证要点
					ue.setContent(record);
					var content = ue.getContent();
					//先去掉审计记录自动添加的一句话
					var s2 = '';
					//var s2 = "\n\n结论意见（按审计人员的岗位分工或查证要点，逐条提出评价意见）:";

					s += s2;
					//var t = content.val("");
					//content.focus().val(s);
					//content.focus().val(s);
					//content.autoResizeTexareaHeight();
				}
			});
		}
	}


	//选择引用底稿
	function  getOwerManu(){
		var myurl = "${contextPath}/operate/manu/queryManuSelect.action?project_id=${crudObject.project_id}&manuId=${crudObject.id}";
		$("#myFrame").attr("src",myurl);
		$('#manuReferenceDiv').window('open');
	}

	// 选择引用附件
	function getOwerFile() {
		var myurl = "${contextPath}/operate/manu/querySelectManu.action?project_id=${crudObject.project_id}&fileGuid=${crudObject.file_id}";
		$("#myFileFrame").attr("src",myurl);
		$('#fileReferenceDiv').window('open');
	}

	//把关联的底稿或者疑点渲染为链接，关联索引: 点击疑点编码
	function chang2link(){
		var code3=document.getElementsByName("crudObject.audit_found")[0].value;
		var code4=document.getElementsByName("crudObject.audit_matter")[0].value;
		var codeArray3=code3.split(',');
		var codeArray4=code4.split(',');
		//alert(codeArray3[0]);
		var tt1='';
		var tt2='';
		var tt3='';
		var tt4='';
		var tt5='';
		var strName1='关联备忘';
		var strName2='关联疑点';
		var strName4='关联重大事项';
		var strName3='关联疑点';
		var strName5='关联底稿';

		if(codeArray3[0]!=null&&codeArray3[0]!=''){
			tt3='<a href=# onclick=go2(\"'+codeArray3[0]+'\")>'+codeArray3[1]+'</a>';
			tt3=tt3+"<br />";
		}
		if(codeArray4[0]!=null&&codeArray4[0]!=''){
			tt4='<a href=# onclick=go2(\"'+codeArray4[0]+'\")>'+strName4+'</a>';
			tt4=tt4+"<br />";
		}
		p1.innerHTML= tt3+tt4 ;
	}

	//查看疑点
	function go2(s){
		var myurl = "${contextPath}/operate/doubt/view.action?type=YD&doubt_id="+s;
		$("#myDoubtFrame").attr("src",myurl);
		$('#viewDoubtDiv').window('open');
	}

   // 导入
	function importManuLederPro(){
		$('#download').linkbutton('enable');
		$('#importXML').window('open')
	}

   // 导入提交
	function submit_dr(){
		var template = document.all('myfile').value;
		if(template == ''){
			$.messager.alert('系统提示',"请先选择要导入的文件",'warning');
			return;
		}
		//var importForm = document.getElementById("importForm");
		//importForm.action = "${contextPath}/interact/interactProxyToWork/mutualToManage.action";
		//importForm.submit();
		var w_file = document.getElementById("w_file").value;

		var importForm = new FormData(document.getElementById("importForm"));
		$.ajax({
			url:'${contextPath}/interact/interactProxyToWork/mutualToManu.action?file_id='+w_file,
			type:'post',
			data:importForm,
			aysnec:false,
			cache: false,//上传文件无需缓存
			processData:false,//用于对data参数进行序列化处理 这里必须false
			contentType:false, //必须
			success:function(data){
				$('#importXML').window('close');
				$("#ms_name").val(data.hMs_name);
				$("#interact").val("1");
				ue.setContent(data.hAudit_record)
				$("#audit_con").val(data.hAudit_con);
				$('#manu_file').fileUpload('reloadFileGrid');
			}
		});

	}
    
    // 导入等待
	function wait() {
		$('#importProjects').window('close');
		document.getElementById("importButton").disabled = true;
		document.getElementById("layer").style.display = "";
		document.getElementById("errorInfo1").style.display = "none";
		document.getElementById("errorInfo2").style.display = "none";
	}

	//底稿返回底稿列表   返回上级list页面
	function backList(){
		//var flag=window.confirm('确定是否关闭？请先保存，以免数据丢失');//isSubmit
		parent.$.messager.confirm('确认对话框', '确定是否关闭？请先保存，以免数据丢失', function(r){
			if(r){
				if('true'=='${owner}'){
					var u='${pageContext.request.contextPath}/operate/manuExt/mainUi.action?owner=true&groupCode=${groupCode}&project_id=${crudObject.project_id}&taskId=${taskId}&taskPid=${crudObject.task_id}'
					window.location.href = u;
				}else{
					var u='${pageContext.request.contextPath}/operate/manuExt/mainUi.action?project_id=${crudObject.project_id}&taskId=${taskId}&taskPid=${crudObject.task_id}'
					window.location.href = u;
				}
			}else{
				return false;
			}
		});

	}
	

	// 是否为空
	function checkEmpty(code,name){
		var v_3 = code;  // field
		var title_3 = name;// field name
		var notNull = 'true'; // notnull
		var bool = true ;
		if(document.getElementsByName(v_3)[0].value=="" && notNull=="true" && notNull != ""){
			showMessage1(title_3+"不能为空!");
			bool = false;
			document.getElementsByName(v_3)[0].focus();
			return false;
		}
		if(document.getElementsByName(v_3)[0].value.replace(/\s+$|^\s+/g,"")==""){
			showMessage1(title_3+"不能为空!");
			bool = false;
			document.getElementsByName(v_3)[0].focus();
			return false;
		}
		if(bool){
			return true;
		}
	}
	//长度
	function checkNumber(code,name,num ){
		var v_3 = code;  // field
		var title_3 = name;// field name
		var bool = true ;
		var t=document.getElementsByName(v_3)[0].value;
		if(t.length> num){
			showMessage1(title_3+"的长度不能大于"+num+"字！");
			document.getElementsByName(v_3)[0].focus();
			bool = false;
			return false;
		}
		if(bool){
			return true;
		}
	}


	// 为空和长度
	function checkEmptyNum(code,name,num){
		var v_3 = code;  // field
		var title_3 = name;// field name
		var bool = 'true';
		var notNull = 'true'; // notnull
		if(document.getElementsByName(v_3)[0] != null ){
			var t = document.getElementsByName(v_3)[0].value ;
			if(t == "" && notNull=="true" && notNull != ""){
				showMessage1(title_3+"不能为空!");
				bool = false;
				document.getElementsByName(v_3)[0].focus();
				return false;
			}
			if(t.replace(/\s+$|^\s+/g,"")==""){
				showMessage1(title_3+"不能为空!");
				bool = false;
				document.getElementsByName(v_3)[0].focus();
				return false;
			}

			if(t.length> num){
				howMessage1(title_3+"的长度不能大于"+num+"字！");
				document.getElementsByName(v_3)[0].focus();
				bool = false;
				return false;
			}
		}
		if(bool){
			return true;
		}
	}
	
	// 为空和长度
	function checkEmptyNumWithoutFocus(code,name,num){
		var v_3 = code;  // field
		var title_3 = name;// field name
		var bool = 'true';
		var notNull = 'true'; // notnull
		if(document.getElementsByName(v_3)[0] != null ){
			var t = document.getElementsByName(v_3)[0].value ;
			if(t == "" && notNull=="true" && notNull != ""){
				showMessage1("自动保存失败！"+title_3+"不能为空!");
				bool = false;
				return false;
			}
			if(t.replace(/\s+$|^\s+/g,"")==""){
				showMessage1("自动保存失败！"+title_3+"不能为空!");
				bool = false;
				return false;
			}

			if(t.length> num){
				showMessage1("自动保存失败！"+title_3+"的长度不能大于"+num+"字！");
				bool = false;
				return false;
			}
		}
		if(bool){
			return true;
		}
	}
	
	function noblank(txtObject){
		if(txtObject.value.replace(/\s+$|^\s+/g,"")=="null"){
			showMessage1("不能输入'null'!");
			return false;
		}
		if(txtObject.value.replace(/\s+$|^\s+/g,"")=="NULL"){
			showMessage1("不能输入'NULL'!");
			return false;
		}
		return true;
	}
	
	//输入检查，只能输入数字
	function onlyNumbers1(s) {
		re = /^\d+\d*$/
		var str = s.replace(/\s+$|^\s+/g, "");
		if (str == "") {
			return false;
		}
		if (!re.test(str)) {
			showMessage1("只能输入正整数，请重新输入！");
			return true;
		}
	}

	//对输入内容校验
	function check() {
		var manu_code = document.getElementsByName("crudObject.ms_code")[0].value;
		var flag = true;
		var bool = true;//提交表单判断参数
		if(manu_code != '') {
			$.ajax({
				type : "POST",
				dataType : "text",
				url : "${contextPath}/operate/manu/checkCode.action",
				async : false,
				data : {
					'project_id' : '${crudObject.project_id}',
					'manu_code' : manu_code,
					'formId' : '${crudObject.formId}'
				},
				success : function(data) {
					if (data != '1') {
						window.parent.$.messager.show({
							title : '提示信息',
							msg : "底稿编码重复,请重新输入!",
							timeout : 5000,
							showType : 'slide'
						});
						document.getElementById("crudObject.ms_code").focus();
						flag = false;
					}
				}
			});
		}
		if (!flag) {
			bool = false;
			return false;
		}

		if (!checkEmptyNum("crudObject.ms_name", "底稿名称", 100)) {
			bool = false;
			return false;
		}
		if ('${crudObject.formId}' != null && '${crudObject.formId}' != 'null'
				&& '${crudObject.formId}' != '') {
			if (!checkEmpty("crudObject.ms_code", "底稿编码")) {
				bool = false;
				return false;
			}
			var v_3 = "crudObject.ms_code";
			document.getElementsByName(v_3)[0].value=document.getElementsByName(v_3)[0].value.replace(/\s+$|^\s+/g,"");
		}

		//liululu 1.将if判断去掉；2.补全判断条件。问题：taskId的获取与作用？
		if ('${taskId}' == '-1' || '${taskId}' == null || '' == '${taskId}'
				|| '${taskId}' == 'null') {
			if (!checkEmpty("crudObject.task_name", "审计事项")) {
				bool = false;
				return false;
			}
		}
		if (!checkEmptyNum("crudObject.audit_dept", "被审计单位", 3000)) {
			bool = false;
			return false;
		}
//		setAttendPerson();
		setAuditGroup();
		if (!checkNumber("crudObject.linkManuName", "引用底稿", 3000)) {
			bool = false;
			return false;
		}
		if (!checkNumber("crudObject.linkManuId", "引用底稿", 3000)) {
			bool = false;
			return false;
		}

		if (!checkNumber("crudObject.audit_file", "查阅资料", 3000)) {
			bool = false;
			return false;
		}
		var v_3 = "crudObject.describe"; // field
		var title_3 = '审计查证要点';// field name
		if (!checkNumber("crudObject.audit_regulation", "规章制度", 3000)) {
			bool = false;
			return false;
		}
		if (!checkNumber("crudObject.audit_dept_feedback", "底稿反馈意见", 3000)) {
			bool = false;
			return false;
		}

		if('${crudObject.interact}'=='1'||'${crudObject.interact}'=='2'){
			//var t=document.getElementById('subModelHTML');
			//	alert(t);
			//	alert(t.innerHTML)
			//	document.getElementById('crudObject.subModelHTML').value=t.innerHTML;
			//$("#subModelHTMLHidden").val(t.innerHTML)
		}
		if(bool){
			return true;
		}
	}
	
	//保存表单
	function saveForm(){
		$('#ms_owner').combobox('setValue',$('#ms_owner').combobox('getText'));
		var bool = true;//提交表单判断参数
		if(!check()){
			bool = false;
			return false;
		}
		//完成保存表单操作
		if(bool){
			$('#crudaudit_record_value').val(ue.getContent('crudaudit_record'));
			$('#crudaudit_con_value').val(ue01.getContent('crudaudit_con'));
			var url = '${contextPath}/operate/manu/save.action?isSh=${isSh}';
			myform.action = url;
			document.getElementById("root").disabled=true;
			myform.submit();

		}
	}


	
	// 提交校验
	function testStatus(){
		document.getElementsByName('crudObject.ms_status')[0].value='040';
		var d=document.getElementsByName('crudObject.ms_status')[0].value;
		var bool = true;//提交表单判断参数
		if( !checkEmpty("crudObject.ms_name","底稿名称")){
			return false;
		}
		if('${crudObject.formId}'!=null&&'${crudObject.formId}'!='null'&&'${crudObject.formId}'!=''){
			if( !checkEmpty("crudObject.ms_code","底稿编码")){
				return false;
			}
		}
		if('${taskId}'=='-1'){
			if( !checkEmpty("crudObject.task_name","审计事项")){
				return false;
			}
		}
		if( !checkEmpty("crudObject.audit_dept","被审计单位")){
			return false;
		}
		if( !check()){
			return false;
		}
	}
	
	// 提交前
	function beforStartProcess() {
		$('#crudaudit_record_value').val(ue.getContent('crudaudit_record'));
		$('#crudaudit_con_value').val(ue01.getContent('crudaudit_con'));
		return true;
	}
	
	function doStart(){
		//	setAttendPerson();
		setAuditGroup();
		document.getElementById('myform').action = "start.action";
		document.getElementById('myform').submit();
	}

	// 提交
	function toSubmit(option){
		$('#crudaudit_record_value').val(ue.getContent('crudaudit_record'));
		$('#crudaudit_con_value').val(ue01.getContent('crudaudit_con'));
		<s:if test="isUseBpm=='true'">
		if(document.getElementsByName('isAutoAssign')[0].value=='false'||document.getElementsByName('formInfo.toActorId')[0]!=undefined){
			var actor_name=document.getElementsByName('formInfo.toActorId')[0].value;
			if(actor_name==''){
				showMessage1("下一步处理人不能为空！");
				return false;
			}
		}
		if('${dqxm}'=='GZNX'){
			var content_gznx=document.getElementsByName('taskInstanceInfo.comments')[0].value;
			if(content_gznx==''){
				showMessage1("处理意见不能为空！");
				return false;
			}
		}
		</s:if>
		var bool = true;//提交表单判断参数

		if(!check()){
			bool = false;
			return false;
		}
		//完成保存表单操作
		if(bool){
			parent.$.messager.confirm('确认对话框', '确认提交吗？', function(r) {
				if (r) {
					if('${crudObject.interact}'=='1'||'${crudObject.interact}'=='2'){
					}
					document.getElementById('submitButton').disabled=true;
					if('${owner}' == 'true'){
						$.ajax({
							type:'POST',
							url:"<%=request.getContextPath()%>/operate/manu/submit.action",
							data : $('#myform').serialize(),
							dataType : 'json',
							async:false,
							success : function(data) {
								if (data.winclose == "winclose") {
									/*   var selectedTab = top.$('#tabs').tabs('getSelected');
                                      var tabIndex = top.$('#tabs').tabs('getTabIndex',selectedTab);
                                             top.$('#tabs').tabs('close',tabIndex); */
									//top.$(".nav-tabs li").each(function(){
									top.$(".tabs li").each(function(){
										var  gg = $(this).text();
										if( gg == '审计底稿' || gg == '编辑底稿'){
											//var tabId = $(this).children('a').attr("aria-controls");
											//top.Addtabs.close(tabId);
											top.$("#tabs").tabs("close", gg);
										}else if (gg == '我的事项'){
											var tabId = $(this).children('a').attr("aria-controls");
											refreshMyTaskManuGrid(tabId);
										}

									});
								}
							}

						});
					} else {
						myform.action = "<s:url action="submit" includeParams="none"/>";
						myform.submit();
					}
				} else {
					return false;
				}

			});
		}
	}

	//提交表单
	function submitForm() {
		var bool = true;//提交表单判断参数
		if (!check()) {
			return false;
		}
		if (document.getElementsByName("formInfo.toActorId_name")[0] != null
				&& document.getElementsByName("formInfo.toActorId_name")[0].value == ""
				&& notNull == "true" && notNull != "") {
			//window.alert("请选择下一步处理人！");
			showMessage1("请选择下一步处理人！");
			bool = false;
			document.getElementById("formInfo.toActorId_name").focus();
			return false;
		}
		var flag = window.confirm('确认提交吗?');
		if (flag == true) {
			document.getElementById("submitButton").disabled = true;
			myform.submit();
		} else {
			return false;
		}
	}



	// 设置审计小组数据
	function setAuditGroup() {
		var text = $('#auditGroup').combobox('getText');
		var value = $('#auditGroup').combobox('getValue');
		$('#groupId').val(value);
		$('#groupName').val(text);
	}



	//上传附件
	function Upload(id,filelist,delete_flag,edit_flag){
		var guid=document.getElementsByName(id)[0].value;
		var num=Math.random();
		var rnm=Math.round(num*9000000000+1000000000);//随机参数清除模态窗口缓存
		window.showModalDialog('${contextPath}/commons/file/welcome.action?table_name=aud_manuscript_operate&table_guid=file_id&guid='+guid+'&&param='+rnm+'&&deletePermission='+delete_flag+'&&isEdit='+edit_flag,filelist,'dialogWidth:700px;dialogHeight:450px;status:yes');
	}

	//删除方法
	/*
        1.第一个参数是附件表的主键ID，第二个参数是该类附件的删除权限，第三个参数是附件的应用类型
        2.该方法的参数由ais.file.service.imp.FileServiceImpl中的
            getDownloadListString(String contextPath, String guid,String bool, String appType)生成的HTML产生
    */
	function deleteFile(fileId,guid,isDelete,isEdit,appType,title){
		parent.$.messager.confirm('确认对话框', '确认删除吗?', function(r){
			if (r){
				DWREngine.setAsync(false);DWRActionUtil.execute(
						{ namespace:'/commons/file', action:'delFile', executeResult:'false' },
						{'fileId':fileId, 'deletePermission':isDelete, 'isEdit':isEdit, 'guid':guid, 'appType':appType,'title':title},
						xxx);
				function xxx(data){
					document.getElementById(guid).parentElement.innerHTML=data['accessoryList'];
				}
			}
		});
		/* var boolFlag=window.confirm("确认删除吗?");
		if(boolFlag==true){
			DWREngine.setAsync(false);DWRActionUtil.execute(
				{ namespace:'/commons/file', action:'delFile', executeResult:'false' },
				{'fileId':fileId, 'deletePermission':isDelete, 'isEdit':isEdit, 'guid':guid, 'appType':appType,'title':title},
				xxx);
			function xxx(data){
			  	document.getElementById(guid).parentElement.innerHTML=data['accessoryList'];
			}
		} */
	}



	function closeWinUI(){
		$('#manuReferenceDiv').window('close');
	}

	function closeWinUI_file() {
		$("#manu_file").fileUpload('reloadFileGrid');
		$('#fileReferenceDiv').window('close');
	}

	// 底稿查看
	function viewOldVersionManu(oldVersionId){
		var url = "${contextPath}/operate/manu/viewOldVersion.action?id="+oldVersionId;
		aud$openNewTab("底稿查看", url, true);
	}

</script>

<!-- 1. 处理问题位置 -->
<script type="text/javascript">

// 刷新问题列表
function flushProblem(){
	var prom = document.getElementsByName("crudObject.prom")[0].value;
	if(prom == null ||  prom == "" || prom == '0'){
		$("#sjproblemtr").css("display","block");
		getTai();
	}
	$("#mainIFrame")[0].contentWindow.$("#ledgerProblemList").datagrid('reload');
}

// 关闭问题
function closePronlem(){
	$("#myFrameProblem").attr('src','');
	$('#manuProblemDiv').window('close');
}
// 新增审计问题
function manuLederPro(){
	$("#sjproblemtr").css("display","block");
	getTai();
}

// 改变问题的高度
function changProblemHeight(rows){
	if(rows){
		document.getElementById("mainIFrame").height=100+30*rows;
	}
}

// 新增问题
function addManuLederPro(){
	//底稿为保存先保存，否则打开问题新增界面
	if('${crudObject.formId}'!='null'&&'${crudObject.formId}'!=''){
		var myurl = "${contextPath}/proledger/problem/editDigao.action?project_id=${crudObject.project_id}&id=0&manuscript_id=${crudObject.formId}&manuscriptType=digao";
		$("#myFrameProblem").attr("src",myurl);
		$('#manuProblemDiv').window('open');
	}else{
		$('#problemFlag').val('1');
		saveForm();
	}
}
</script>

<script type="text/javascript">
	// 暂时未找到使用 位置的方法

	function getTai(){
		var ms_code= '${crudObject.formId}';
		var pro_code= '${crudObject.project_id}';
		if(ms_code==""||ms_code=="null"){
			return true;
		}else{
			var iframe = document.getElementById("mainIFrame");
			var v ="";
			
			if (   (editProblemWrite != null && String(editProblemWrite) ==  "false" )){
				v = "&view=view";
			}else{
				v = "&view=add";
			}
			iframe.src = "/ais/proledger/problem/listDigaoEditProblem.action?project_id=${crudObject.project_id}&manuscript_id=${crudObject.formId}&manuscriptType=digao&taskId=${taskId}&taskPid=${taskPid}"+v;

		}

	}

	//检查底稿编码是否改变
	function conCode(){
		document.onkeydown = function(){
			document.getElementsByName("crudObject.change_code")[0].value = "1";
		}
	}
	//查看底稿
	function go1(s){
		window.open("${contextPath}/operate/manu/view.action?crudId="+s+"&project_id=${crudObject.project_id}","","height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no");
	}

	//选择审计小组
	function getGroup(){
		var code=document.getElementsByName("crudObject.groupId")[0].value;
		var name=document.getElementsByName("crudObject.groupName")[0].value;
		var num=Math.random();
		var rnm=Math.round(num*9000000000+1000000000);
		var url='/ais/pages/system/search/searchdataManu.jsp?url=<%=request.getContextPath()%>/operate/task/selectDept.action&a=a&x='+rnm+'&group_id='+code+'&paraname=crudObject.audit_dept_name&paraid=crudObject.audit_dept';
		if(name==null||name==""){
			window.parent.$.messager.show({
				title:'提示信息',
				msg:"请先选择审计小组!",
				timeout:5000,
				showType:'slide'
			});
			return false;
		}
		showPopWin(url,500,330,'被审计单位选择');
	}


	//打开台帐页面
	function taizhangEdit(){
		var ms_code= '${crudObject.formId}';
		var pro_code= '${crudObject.project_id}';
		if(ms_code==""||ms_code=="null"){
			window.parent.$.messager.show({
				title:'提示信息',
				msg:"请先保存审计底稿!",
				timeout:5000,
				showType:'slide'
			});

			return false;
		}
		window.open("/ais/proledger/problem/listDigaoEditProblem.action?project_id="+pro_code+"&manuscript_id="+ms_code+"&view=add","","height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no");
	}
	//打开台帐页面
	function taizhangView(){
		var ms_code= '${crudObject.formId}';
		var pro_code= '${crudObject.project_id}';
		window.open("/ais/proledger/problem/listDigaoEditProblem.action?project_id="+pro_code+"&manuscript_id="+ms_code+"&isView=true","","height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no");
	}

	//查看审计底稿反馈意见
	function viewFeedback(s,q){
		var title = "查看审计底稿反馈意见";
		window.open('${contextPath}/operate/feedback/viewFeedbackInfo.action?feed_id='+s,'','height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no');
		var num=Math.random();
		var rnm=Math.round(num*9000000000+1000000000);//随机参数清除模态窗口缓存
	}

	//法规制度
	function regu(){
		window.open('${contextPath}/pages/assist/suport/comsys/view_lawslibFrame.jsp?zuoye=bs','law',"height=600px, width=600px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no");
	}
	//法规制度
	function law(){
		win=window.open('${contextPath}/pages/operate/manu/law_redirect.jsp','regu','height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no');if(win && win.open && !win.closed) win.focus();
	}

	// 附件列表增加引用按钮
	$(function () {
		$('#manu_file').fileUpload('addToolbarBtn', {text: '我的附件', iconCls:'icon-search', handler: getOwerFile});
	});
</script>
	<SCRIPT language="JavaScript">
		<!--全局变量
		//标志位,值为false代表未打开一个编辑框,值为true为已经打开一个编辑框开始编辑
		var editer_table_cell_tag = false;
		//开启编辑功能标志,值为true时为允许编辑
		var run_edit_flag = true;
		var run_edit_all = "";
		//-->
	</SCRIPT>
	<SCRIPT language="JavaScript">
		//-----------------------------------------------
		//--------------交互内容用到的脚本-------开始-----------
		//-----------------------------------------------
		/**
		 * 编辑表格函数
		 * 单击某个单元格可以对里面的内容进行自由编辑
		 * @para tableID 为要编辑的table的id
		 * @para noEdiID 为不要编辑的td的ID,比如说table的标题
		 * 可以写为<TD id="no_editer">自由编辑表格</TD>
		 * 此时该td不可编辑
		 */
		function editerTableCell(tableId,noEdiId){
			var tdObject = event.srcElement;
			var tObject =  null;
			if ( tdObject.parentNode != null ){
				if ((tdObject.parentNode).parentNode != null  ){
					if ( ((tdObject.parentNode).parentNode).parentNode != null ){
						tObject =((tdObject.parentNode).parentNode).parentNode ;
					}else{
						tObject =(tdObject.parentNode).parentNode;
					}
				}else{
					tObject =tdObject.parentNode;
				}
			}
			/*
                    var tObject = ((tdObject.parentNode).parentNode).parentNode; */
			if(tObject && tObject.id && tObject.id == tableId &&tdObject.id != noEdiId&&editer_table_cell_tag == false && run_edit_flag == true){
				var tpObject = (((tdObject.parentNode).parentNode).parentNode).parentNode;
				tdObject.innerHTML = "<input type='text' id='edit_table_txt'  maxlength='100'  name='edit_table_txt' value='"+tdObject.innerText+"' size='15' onKeyDown='enterToTab()'>  <input type=button value=' 确定 ' onclick='certainEdit()'>";
				editer_table_cell_tag = true;
			}else{
				return false;
			}
		}

		/**
		 * 确定修改
		 */
		function certainEdit(){
			var bObject = event.srcElement;
			var tdObject = bObject.parentNode;
			var txtObject = tdObject.firstChild;
			if(noblank(txtObject)){
			}else{
				return false;
			}
			tdObject.innerHTML = txtObject.value;
			//代表编辑框已经关闭
			editer_table_cell_tag = false;
			//修改按钮提示信息
			//editTip.innerText = "请单击某个单元格进行编辑!";
		}

		function enterToTab(){
			if(event.srcElement.type != 'button' && event.srcElement.type != 'textarea'&& event.keyCode == 13){
				event.keyCode = 9;
			}
		}

		/**
		 * 控制是否编辑
		 */
		function editStart(){
			if(editer_table_cell_tag == false){
			}else{
				top.$.messager.show({
					title:'提示信息',
					msg:"请先点'确定'按钮,确定修改的内容!",
					timeout:5000,
					showType:'slide'
				});
				return false;
			}
			if(event.srcElement.value == "开始编辑"){
				if(run_edit_flag==true){
					top.$.messager.show({
						title:'提示信息',
						msg:"一次只能编辑一个表格!请先点'编辑完成'按钮",
						timeout:5000,
						showType:'slide'
					});
					return false;
				}else{
				}
				event.srcElement.value = "编辑完成";
				run_edit_flag = true;
			}else{
				//如果当前没有编辑框,则编辑成功,否则,无法提交
				//必须按确定按钮后才能正常提交
				if(editer_table_cell_tag == false){
					top.$.messager.show({
						title:'提示信息',
						msg:"编辑成功结束!请点页面下方的保存按钮保存数据!",
						timeout:5000,
						showType:'slide'
					});
					event.srcElement.value = "开始编辑";
					run_edit_flag = false;
					//var t=document.getElementById('subModelHTML');
					//document.getElementById('audManuscript.subModelHTML').value=t.innerHTML;
				}else{
					top.$.messager.show({
						title:'提示信息',
						msg:"请先点'确定'按钮,确定修改的内容!",
						timeout:5000,
						showType:'slide'
					});
					return false;
				}
			}
		}

		/**
		 * 根据不同的按钮提供不同的提示信息
		 */
		function showTip(){
			if(event.srcElement.value == "编辑完成"){
				editTip.style.top = event.y + 15;
				editTip.style.left = event.x + 12;
				editTip.style.visibility = "visible";
			}else{
				editTip.style.visibility = "hidden";
			}
		}
		
		
		function deleteCell(){
			var flag=true;
			if(editer_table_cell_tag == false){
			}else{
				top.$.messager.show({
					title:'提示信息',
					msg:"请先点'确定'按钮,确定修改的内容!",
					timeout:5000,
					showType:'slide'
				});
				return false;
			}
			var tdObject = event.srcElement;
			var tpObject = ((tdObject.parentNode).parentNode).parentNode;
			if(flag){
				top.$.messager.confirm("提示消息","确认删除本行的数据吗?",function(r){
					if (r){
						var tpObject2 = ((tdObject.parentNode).parentNode);
						tpObject.removeChild(tpObject2);
					}
				})
			}else{
				top.$.messager.show({
					title:'提示信息',
					msg:"一次只能编辑一个表格!请先点本表格'开始编辑'按钮!",
					timeout:5000,
					showType:'slide'
				});
				return false;
			}
		}

		function fff(){
			//var t=document.getElementById('subModelHTML');
			//run_edit_all = t.innerHTML;
		}

		function editReset(){
			if(editer_table_cell_tag == false){
			}else{
				top.$.messager.show({
					title:'提示信息',
					msg:"请先点'确定'按钮,确定修改的内容!",
					timeout:5000,
					showType:'slide'
				});
				return false;
			}
			var conTip="确认重置数据吗?";
			if(confirm(conTip)){
				//var t=document.getElementById('subModelHTML');
				//t.innerHTML=document.getElementById('crudObject.subModelHTML').value;
			}else{
			}
		}

		function deleteCellAll(){
			var flag=true;
			if(editer_table_cell_tag == false){
			}else{
				top.$.messager.show({
					title:'提示信息',
					msg:"请先点确定按钮,确定修改的内容!",
					timeout:5000,
					showType:'slide'
				});
				return false;
			}
			var tdObject = event.srcElement;
			var tpObject = (((tdObject.parentNode).parentNode).parentNode).parentNode;
			var nodes = ((tpObject.parentNode.lastChild.lastChild.lastChild.childNodes));
			if(flag){
				top.$.messager.confirm("提示消息","确认清空本表格的数据吗?",function(r){
					var ulListChild = tpObject.childNodes;
					for(var i=0; i<ulListChild.length; i+=1){
						var tpObject = (ulListChild[i]);
						var dd = tpObject.firstChild;
						// alert(tpObject.value );
						if(dd!=null){
							tpObject.removeChild(dd);
						}
					}
				});
			}
		}
		//-----------------------------------------------
		//--------------交互内容用到的脚本-------结束-----------
		//-----------------------------------------------
	</SCRIPT>
</html>
