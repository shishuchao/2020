<%@ page import="ais.resmngt.audobj.model.AuditingObject" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="fmt"%>
<!DOCTYPE HTML>
<html>
<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<title>被审计单位</title>
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>  
	<link rel="stylesheet" type="text/css" href="${contextPath}/resources/csswin/subModal.css" />
	<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/jquery-fileUpload.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/pages/tlInteractive/tlInteractiveCommon.js"></script>
	<s:head theme="ajax" />
	<script>
		<s:if test="refresh==1">
		 	window.parent.frames[0].location.reload();
		</s:if>
			// 如果被审计单位行业性质为：“国家机关”，则显示财政预算代码、单位行政区划这两个字段
		/* 	function isView(){
				var a = '${auditingObject.industryCode}';
				if(a=='101'){
					document.getElementById('tr1').style.display='';
				}else{
					document.getElementById('tr1').style.display='none';
				}

			} */

        <%
            String auditObjectName = ((AuditingObject)request.getAttribute("auditingObject")).getName();
            auditObjectName = URLEncoder.encode(auditObjectName, "UTF-8");
        %>

			function expObj(){
				document.forms[0].action = 'expAuditingObject.action';
				document.forms[0].submit();
			}

			$(function(){
		    	$('#test').tabs({ 
			        border:false, 
			        onSelect:function(title,index){ 
			        	if(title == '历史被审项目') {
							$('#inthistorylist').attr('src','<%=request.getContextPath()%>/mng/audobj/object/listinhis.action?auditingObject.id=${auditingObject.id}');
						}else if(title == '经济责任人') {
							$('#economydutylist').attr('src','<%=request.getContextPath()%>/mng/economyduty/economyDutyAction!list.action?audobjid=${auditingObject.id}&status=');
						}else if(title == '反馈账号') {
							$('#auditlist').attr('src','${contextPath}/auditAccessoryList/editAuditobjAccount.action?audit_object=${auditingObject.id}&audit_object_name=<%=auditObjectName%>&view=view');
						}else if(title == '被审计单位资料查看') {
							$('#auditobject').attr('src','${contextPath}/auditobject/material/initAuditObjectData.action?auditObject=${auditingObject.id}&view=true');
						} else if (title == '离线采集数据查看') {
							$('#listAuditObjectData_iframe').attr('src','${contextPath}/mng/audobj/data/listAuditObjectData.action?root_audit_object=${auditingObject.id}&view=true');
						}
			        } 
			    });
		    });
			
			function viewHistory(){
				var url = "${contextPath}/mng/audobj/object/viewHistory.action?id=${auditingObject.id}";
				// aud$openNewTab('历史变更信息查看',url,false);
				new aud$createTopDialog({
					title: '历史变更信息查看',
					url: url
				}).open();
			}
	</script>
</head>
<body >
	<div class='easyui-tabs' fit='true' id='test'>
		<div id='one' title='基本信息'>
		  <div class="easyui-layout" fit="true" border='0'>
		  	   <div region='north' style="height:32px;overflow:hidden;" border='0'>
					<s:form action="expAuditingObject" namespace="/mng/audobj/object">
						<s:hidden name="auditingObject.id" />
						<div style="text-align:left;padding:6px 2px 0px 8px;">
							<a class="easyui-linkbutton" data-options="iconCls:'icon-export'" onclick="expObj();" id="exp_id">导出本级及下级</a>&nbsp;&nbsp
							<span>基本信息更新记录：<a href="javascript:;" onclick="viewHistory()">${hisNum}</a></span>
						</div>	
					</s:form>
		  	   </div>
		  	   <div region='center' border='0'>
					<table cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
						<tr>
							<td class="EditHead" style="width: 15%" nowrap>组织机构编码</td>
							<td class="editTd" style='width: 35%'>
								<s:property   value="auditingObject.currentCode" />
							</td>
							<td class="EditHead" style="width: 15%" nowrap>上级组织机构编码</td>
							<td class="editTd" style='width: 35%'>
								<s:property  value="auditingObject.superiorCode" />
							</td>
						</tr>
						<tr>
							<td class="EditHead">单位名称</td>
							<td class="editTd">
								<s:property  value="auditingObject.name" />
							</td>
							<td class="EditHead">上级单位</td>
							<td class="editTd">
								<s:property  value="auditingObject.parentName" />
							</td>
						</tr>
						<tr>
									<td class="EditHead">
										法人机构编码
									</td>
									<td class="editTd">
										<s:property value="auditingObject.corporationCode"/>
									</td>
									<td class="EditHead">
										机构英文名称
									</td>
									<td class="editTd">
										<s:property value="auditingObject.nameEng"/>
									</td>
								</tr>
								<tr>
									<td class="EditHead">
										注册资本
									</td>
									<td class="editTd">
										<s:property value="auditingObject.regCapital"/>
									</td>
									<td class="EditHead">
										管理主体
									</td>
									<td class="editTd">
										<s:property value="auditingObject.mngSubject"/>
									</td>
								</tr>
								<tr>
									<td class="EditHead">
										注册地
									</td>
									<td class="editTd">
										<s:property value="auditingObject.regAddress"/>
									</td>
									<td class="EditHead">
										投资主体
									</td>
									<td class="editTd">
										<s:property value="auditingObject.invSubject"/>
									</td>
								</tr>
								<tr>
									<td class="EditHead">
										占股比
									</td>
									<td class="editTd">
										<s:property value="auditingObject.shareRatio"/>
									</td>
									<td class="EditHead">
										成立日期
									</td>
									<td class="editTd">
										<s:property value="auditingObject.establishDate"/>
									</td>
								</tr>
								<tr>
									<td class="EditHead">
										法人级次
									</td>
									<td class="editTd" colspan="3">
										<s:property value="auditingObject.orgLevelName"/>
									</td>
								</tr>
								<tr>
									<td class="EditHead" nowrap>
										所属审计单位
									</td>
									<td class="editTd">
										<s:property value="auditingObject.departmentName"/>
									</td>
									<td class="EditHead" nowrap>
										是否属于覆盖范围
									</td>
									<td class="editTd">
										<select class="easyui-combobox" name="auditingObject.auditCover" style="width:150px;"  editable="false" disabled="disabled">
											<option value="">&nbsp;&nbsp;</option>
											<s:iterator value='#@java.util.LinkedHashMap@{"1":"是","0":"否"}'>
												<s:if test="${auditingObject.auditCover == key}">
													<option selected="selected" value="${key}">${value}</option>
												</s:if>
												<s:else>
													<option value="${key}">${value}</option>
												</s:else>
											</s:iterator>
										</select>
									</td>
								</tr>
								<tr>
									<td class="EditHead">
										本级及以下资产总额(万元)
									</td>
									<td class="editTd">
										<fmt:formatNumber value="${auditingObject.generalAssetsA}" pattern="###,###.##" type="currency" minFractionDigits="2"/>
									</td>
									<td class="EditHead">
										本单位资产总额(万元)
									</td>
									<td class="editTd">
										<fmt:formatNumber value="${auditingObject.generalAssetsO}" pattern="###,###.##" type="currency" minFractionDigits="2"/>
									</td>
								</tr>
								<tr>
									<td class="EditHead">
										总部办公地址
									</td>
									<td class="editTd">
										<s:property value="auditingObject.officeAddress"/>
									</td>
									<td class="EditHead">
										单位负责人
									</td>
									<td class="editTd">
										<s:property value="auditingObject.director"/>
									</td>
								</tr>
								<tr>
									<td class="EditHead">
										财务负责人
									</td>
									<td class="editTd">
										<s:property value="auditingObject.financialDirector"/>
									</td>
									<td class="EditHead">
										财务联系人
									</td>
									<td class="editTd">
										<s:property value="auditingObject.financialLinkman"/>
									</td>
								</tr>
								<tr>
									<td class="EditHead">
										单位性质
									</td>
									<td class="editTd">
										<s:hidden name="auditingObject.comTypeName"></s:hidden>
								        <select  class="easyui-combobox" name="auditingObject.comTypeCode" style="width:150px;"  editable="false" disabled="disabled"
								        	onchange="setfmid(this,'auditingObject.comTypeName');">
									       <option value="">&nbsp;</option>
									       <s:iterator value="basicUtil.comattributeList" id="entry">
									       		<s:if test="${auditingObject.comTypeCode==code}">	
								             		<option selected="selected" value="<s:property value='code'/>"><s:property value='name'/></option>
								             	</s:if>	
								             	<s:else>
								             		<option value="<s:property value='code'/>"><s:property value='name'/></option>
								             	</s:else>
									       </s:iterator>
									    </select>							
									</td>
									<td class="EditHead">
										单位电话
									</td>
									<td class="editTd">
										<s:property value="auditingObject.officePhone"/>
									</td>
								</tr>
								<tr>
									<td class="EditHead">
										单位传真
									</td>
									<td class="editTd">
										<s:property value="auditingObject.faxCode"/>
									</td>
									<td class="EditHead">
										人员数量
									</td>
									<td class="editTd">
										<s:property value="auditingObject.employeesNum"/>
									</td>
								</tr>
								<tr>
									<td class="EditHead">
										最近更新人
									</td>
									<td class="editTd">
										<s:property value="auditingObject.updatePersonName"/>
									</td>
									<td class="EditHead">
										最近更新时间
									</td>
									<td class="editTd">
										<s:property value="auditingObject.updateDate"/>
									</td>
								</tr>
					</table>		  	  
		  	  </div>
		  	  <%-- <div region="south" style="overflow:hidden;" border='0'>
					<div id="doubtReasionFile" class="easyui-fileUpload"
						 data-options="fileGuid:'${auditingObject.otherResourceFile}', 
						 			   callbackGridHeight:200,					 			   
						               isAdd:false,
						               isEdit:false,
						               isDel:false,
						               isView:true,
						               isDownload:true,
						               isdebug:true," >
					</div>
		  	  </div> --%>
		  </div>
		</div>
		<div id='three' title='历史被审项目' style="overflow: hidden;">
			<iframe id="inthistorylist"
				src="" frameborder=0 width="100%" height="100%" scrolling="no"></iframe>
		</div>
		<%-- 将经济责任人添加到被审计单位 --%>
		<div id='seven' title='经济责任人' style="overflow:hidden;">
			<iframe id='economydutylist'
				src="" frameborder=0 width="100%" height="100%" scrolling="no"></iframe>
		</div>
		<div id='eight' title='反馈账号' style="width: 100%;overflow:hidden;">
					<iframe id='auditlist'
						src=""
						frameborder=0 width="100%" height="100%" scrolling="no"></iframe>
		</div>
		<div id='nine' title='被审计单位资料查看' style="width: 100%;overflow:hidden;">
					<iframe id='auditobject'
						src=""
						frameborder=0 width="100%" height="100%" scrolling="no"></iframe>
		</div>
		<div id="listAuditObjectData_div" title="离线采集数据查看" style="width: 100%;overflow:hidden;">
			<iframe id="listAuditObjectData_iframe"
					src=""
					frameborder=0 width="100%" height="100%" scrolling="no"></iframe>
		</div>
	</div>
</body>
</html>
