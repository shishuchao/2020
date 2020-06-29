<!DOCTYPE HTML>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<html>
	<head>
		<title>被审计单位项目反馈列表整改跟踪</title>
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script> 
		<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/csswin/subModal.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/calendar.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
		<script type="text/javascript" src="${contextPath}/scripts/ufaudTextLengthValidator.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/js/jquery-fileUpload.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/autosize.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/pages/tlInteractive/tlInteractiveCommon.js"></script>
		<style type="text/css">
			.EditHead {
				width: 20%;
			}
			
			.editTd {
				width: 30%;
			}
		</style>
		<script type="text/javascript">
		//限定字数
		$(document).ready(function(){
            var reg = /^[0-9]\d*$/;
            $.extend($.fn.validatebox.defaults.rules, {
                number: {
                    validator: function(value){
                        return reg.test(value);
                    },
                    message: '必须是正整数'
                }
            });

			$("#examine_result").attr("maxlength",2000);
			$("#mend_result").attr("maxlength",2000);
			$("#responsibility_Mode").attr("maxlength",2000);
			$("#no_rectification_reason").attr("maxlength",2000);
			$("#real_examine_creater").attr("maxlength",2000);
			$("#aud_track_result").attr("maxlength",2000);
			//$("#responsibility_Mode").attr("maxlength",200);
			/*$("#myFirstform").find("textarea").each(function(){
				autoTextarea(this);
			});*/
			$("#myform").find("textarea").each(function(){
				autoTextarea(this);
			});


		});

		/*
    校验两个日期大小顺序
*/
		function validateDate(beginDateId,endDateId){
			var s1 = $('#'+beginDateId);
			var e1 = $('#'+endDateId);
			if(s1 && e1){
				var s = s1.datebox('getValue');
				var e = e1.datebox('getValue');
				if(s!='' && e!=''){
					var s1 = s1.attr('title') || s1.parents('td').prev('td').html();
					var e1title = e1.attr('title') || e1.parents('td').prev('td').html();
					var s_date=new Date(s.replace("-","/"));
					var e_date=new Date(e.replace("-","/"));
					if(s_date.getTime()>e_date.getTime()){
						top.$.messager.alert("错误",s1+"必须小于等于"+e1title+"!");
						return false;
					}
				}
			}
			return true;
		}
		//把引用的底稿或者疑点渲染为链接，点击引用底稿的名称
		function manu(){
			
			//默认加载tab1
			document.getElementById("tab1").style.display='';
			document.getElementById("tab2").style.display='none';
			document.getElementById("tab3").style.display='none';
			
			
          var code3=document.getElementsByName("middleLedgerProblem.linkManuName")[0].value; 
        
          var code4=document.getElementsByName("middleLedgerProblem.linkManuId")[0].value; 
      
          var codeArray3=code3.split(',');
          var codeArray4=code4.split(',');
          //alert(codeArray3[0]);
          var tt1='';
          var tt2='';
          var tt3='';
          var tt4='';
          var tt5='';
          var strName1='引用备忘';
          var strName2='引用疑点';
          var strName4='引用重大事项';
          var strName3='引用发现';
          var strName5='引用底稿';
          if(codeArray3!=null)
          {
            for(var a=0;a<codeArray4.length;a++){
             if(codeArray4[a]!=null&&codeArray4[a]!='')
             {
              if(tt3=='')
              {
               tt3='<a href=# onclick=go1(\"'+codeArray4[a]+'\")>'+codeArray3[a]+'</a>';
              }else{
              tt3=tt3+'&nbsp;&nbsp;<a href=# onclick=go1(\"'+codeArray4[a]+'\")>'+codeArray3[a]+'</a>';
              }
             }
            }
           p2.innerHTML= tt3 ;
         }

       }
		
		 //查看底稿
	    function go1(s){
	      window.open("${contextPath}/operate/manu/view.action?crudId="+s+"&project_id=${project_id}","","height=700px, width=800px, toolbar=no, menubar=no, scrollbars=yes,resizable=yes,location=no, status=no");
	    }
	    
		</script>
	</head>
	<body>
		<div style="position: fixed; top: 0; background-color: #FAFAFA; width: 100%; text-align: right; z-index: 999;">
			<div style="margin: 10px;">
				<a class="easyui-linkbutton" id="saveBtn" iconCls="icon-save" href="javascript:void(0)" onclick="saveForm()">
					<c:choose>
						<c:when test="${en eq 'en'}">
							Save
						</c:when>
						<c:otherwise>
							保存
						</c:otherwise>
					</c:choose>
				</a>
				&nbsp;&nbsp;
				<a class="easyui-linkbutton" iconCls="icon-undo" href="javascript:void(0)" onclick="back()">
					<c:choose>
						<c:when test="${en eq 'en'}">
							Back
						</c:when>
						<c:otherwise>
							返回
						</c:otherwise>
					</c:choose>
				</a>
			</div>
		</div>
		<div align="center" style="margin-top: 45px">
			<s:form id="myform" action="updateTrackingProblemRework" namespace="/proledger/problem">
			<table cellpadding=1 cellspacing=1 border=0 class="ListTable" id="tab1" >
				<c:choose>
					<c:when test="${en eq 'en'}">
						<tr><td colspan="4">Basic Information Of Audit Findings</td></tr>
					</c:when>
					<c:otherwise>
						<tr><td colspan="4">问题属性信息</td></tr>
					</c:otherwise>
				</c:choose>
					<tr>
						<td class="EditHead">
							<c:choose>
								<c:when test="${en eq 'en'}">
									Title
								</c:when>
								<c:otherwise>
									问题标题
								</c:otherwise>
							</c:choose>
						</td>
						<td class="editTd">
							<s:property  value="middleLedgerProblem.audit_con" id="audit_con"/>
						</td>
						<td class="EditHead">
							<c:choose>
								<c:when test="${en eq 'en'}">
									Type
								</c:when>
								<c:otherwise>
									审计发现类型
								</c:otherwise>
							</c:choose>
						</td>
						<td class="editTd">
							<s:property  value="middleLedgerProblem.problem_grade_name" id="audit_con"/>
						</td>
					</tr>
					<tr>
						<td class="EditHead">
							<c:choose>
								<c:when test="${en eq 'en'}">
									Abstact
								</c:when>
								<c:otherwise>
									问题摘要
								</c:otherwise>
							</c:choose>
						</td>
						<td class="editTd" colspan="3">
							<textarea class='noborder'  name="middleLedgerProblem.describe" readonly="readonly"
									  rows="5" style="width:98%;overflow-y:visible;line-height:150%;" UNSELECTABLE='on'>${middleLedgerProblem.describe}</textarea>
						</td>
					</tr>
					<tr>
						<td class="EditHead">
							<c:choose>
								<c:when test="${en eq 'en'}">
									Qualitative Rationale
								</c:when>
								<c:otherwise>
									定性依据
								</c:otherwise>
							</c:choose>
						</td>
						<td class="editTd" colspan="3">
						<textarea class='noborder'  name="middleLedgerProblem.audit_law" readonly="readonly"
									  rows="5" style="width:98%;overflow-y:visible;line-height:150%;" UNSELECTABLE='on'>${middleLedgerProblem.audit_law}</textarea>
						</td>
					</tr>
					<tr>
						<td class="EditHead">
							<c:choose>
								<c:when test="${en eq 'en'}">
									Recommendation
								</c:when>
								<c:otherwise>
									审计建议
								</c:otherwise>
							</c:choose>
						</td>
						<td class="editTd" colspan="3">
						<textarea class='noborder'  name="middleLedgerProblem.audit_advice" readonly="readonly"
									  rows="5" style="width:98%;overflow-y:hidden;line-height:150%;" UNSELECTABLE='on'>${middleLedgerProblem.audit_advice}</textarea>
						</td>
					</tr>
				<c:choose>
					<c:when test="${en eq 'en'}">
						<tr><td colspan="4">Requirements Of Rectification Data</td></tr>
					</c:when>
					<c:otherwise>
						<tr><td colspan="4">问题整改要求</td></tr>
					</c:otherwise>
				</c:choose>
				<tr>
					<td class="EditHead">
						<c:choose>
							<c:when test="${en eq 'en'}">
								Initiate Date
							</c:when>
							<c:otherwise>
								整改期限开始
							</c:otherwise>
						</c:choose>
					</td>
					<td class="editTd">
						<s:property value="middleLedgerProblem.mend_term" />
					</td>
					<td class="EditHead">
						<c:choose>
							<c:when test="${en eq 'en'}">
								Implementation Date
							</c:when>
							<c:otherwise>
								整改期限结束
							</c:otherwise>
						</c:choose>
					</td>
					<td class="editTd">
						<s:property value="middleLedgerProblem.mend_term_enddate" />
					</td>

				</tr>
				<tr>
					<td class="EditHead" style="width:15%;">
						<c:choose>
							<c:when test="${en eq 'en'}">
								Inspector
							</c:when>
							<c:otherwise>
								监督检查人
							</c:otherwise>
						</c:choose>
					</td>
					<td class="editTd" style="width:33%;" colspan='3'>
					 	<s:property value="middleLedgerProblem.examine_creater_name" />
					</td>
				</tr>
					<c:choose>
						<c:when test="${en eq 'en'}">
							<tr><td colspan="4">Feedback On Problem</td></tr>
						</c:when>
						<c:otherwise>
							<tr><td colspan="4">问题整改结果</td></tr>
						</c:otherwise>
					</c:choose>
					<tr>
						<td class="EditHead">
							<label style="color: red;">*</label>
							<c:choose>
								<c:when test="${en eq 'en'}">
									Actions
									<div style="text-align:right;"><label style="color: DarkGray;">(限2000字)</label></div>
								</c:when>
								<c:otherwise>
									整改措施
									<div style="text-align:right;"><label style="color: DarkGray;">(限2000字)</label></div>
								</c:otherwise>
							</c:choose>
						</td>
						<td class="editTd" colspan="3">
						<s:textarea name="problemTracking.mend_result" id="mend_result" cssClass='noborder editElement required' title="整改措施"
								rows="5" cssStyle="width:100%;overflow-y:visible;line-height:150%;" />
							<input type="hidden" id="problemTracking.mend_result.maxlength" value="2000"/>
						</td>
					</tr>
					<tr>
						<td class="EditHead">到期未整改原因
							<div style="text-align:right;"><font color=DarkGray>(限2000字)</font></div>
						</td>
						<td class="editTd" colspan="3">
							<s:textarea id="no_rectification_reason" name="problemTracking.no_rectification_reason" cssClass="noborder"
										cssStyle="width:100%;height:100px;overflow-y:visible;line-height:150%;" title="到期未整改原因"/>
							<input type="hidden" id="problemTracking.no_rectification_reason.maxlength" value="200"/>
						</td>
					</tr>
					<tr>
						<td class="EditHead">
							<c:choose>
								<c:when test="${en eq 'en'}">
									Planed Starting Date
								</c:when>
								<c:otherwise>
									计划整改开始日期
								</c:otherwise>
							</c:choose>
						</td>
						<td class="editTd">
							<input type="text" id="planStartDate" name="problemTracking.planStartDate" value="${problemTracking.planStartDate }" title="计划整改开始日期"
								   class="easyui-datebox" editable="false" style="width: 160px"/>
						</td>
						<td class="EditHead">
							<c:choose>
								<c:when test="${en eq 'en'}">
									Estimated Finishing Date
								</c:when>
								<c:otherwise>
									计划整改结束日期
								</c:otherwise>
							</c:choose>
						</td>
						<td class="editTd">
							<input type="text" id="planEndDate" name="problemTracking.planEndDate" value="${problemTracking.planEndDate }" title="计划整改结束日期"
								   class="easyui-datebox" editable="false" style="width: 160px"/>
						</td>
					</tr>
					<tr>
						<td class="EditHead">
							<c:choose>
								<c:when test="${en eq 'en'}">
									Actual Starting Date
								</c:when>
								<c:otherwise>
									实际整改开始日期
								</c:otherwise>
							</c:choose>
						</td>
						<td class="editTd">
							<input type="text" id="examine_startdate" name="problemTracking.examine_startdate" value="${problemTracking.examine_startdate }"
								class="easyui-datebox" editable="false" style="width: 160px"/>
						</td>
						<td class="EditHead">
							<c:choose>
								<c:when test="${en eq 'en'}">
									Actual Finishing Date
								</c:when>
								<c:otherwise>
									实际整改结束日期
								</c:otherwise>
							</c:choose>
						</td>
						<td class="editTd">
							<input type="text" id="examine_enddate" name="problemTracking.examine_enddate" value="${problemTracking.examine_enddate }"
							class="easyui-datebox" editable="false" style="width: 160px"/>
						</td>
					</tr>
					<tr>
						<td class="EditHead">
							<c:choose>
								<c:when test="${en eq 'en'}">
									<label style="color: red;">*</label>Status
								</c:when>
								<c:otherwise>
									<label style="color: red;">*</label>整改状态
								</c:otherwise>
							</c:choose>
						</td>
						<td class="editTd">
							<select id="mend_state_code" class="easyui-combobox editElement required" name="problemTracking.mend_state_code" editable="false" style="width:160px;" data-options="panelHeight:100">
						       <option value="">&nbsp;</option>
						       <s:iterator value="basicUtil.fllowOpinionList" id="entry">
							         <s:if test="${problemTracking.mend_state_code==code}">
						       			<option selected="selected" value="<s:property value="code"/>"><s:property value="name"/></option>
						       		 </s:if>
						       		 <s:else>
								        <option value="<s:property value="code"/>"><s:property value="name"/></option>
						       		 </s:else>
						       </s:iterator>
						    </select>
						</td>
						<td class="EditHead">
							<c:choose>
								<c:when test="${en eq 'en'}">
									Responsible Department
								</c:when>
								<c:otherwise>
									整改责任部门
								</c:otherwise>
							</c:choose>
						</td>
						<td class="editTd">
							<input type="text" class="noborder" name="problemTracking.mendDept" value="${problemTracking.mendDept}" maxlength="100"/>
						</td>
					</tr>
					<tr>
						<td class="EditHead" nowrap>
							<c:choose>
								<c:when test="${en eq 'en'}">
									<label style="color: red;">*</label>Updated Policies After Audit(Quantity)
								</c:when>
								<c:otherwise>
									<%--<label style="color: red;">*</label>--%>
									审计完善制度数量（修订数）
								</c:otherwise>
							</c:choose>

						</td>
						<td class="editTd">
							<%--<input type="text" class="noborder number editElement required" name="problemTracking.improveRegulation" value="${problemTracking.improveRegulation}" maxlength="10"/>--%>
							<input type="text" class="noborder naturalNumber editElement" name="problemTracking.improveRegulation" value="${problemTracking.improveRegulation}" maxlength="10"/>
						</td>
						<td class="EditHead">
							<c:choose>
								<c:when test="${en eq 'en'}">
									Revise Description
								</c:when>
								<c:otherwise>
									修订制度说明
								</c:otherwise>
							</c:choose>
						</td>
						<td class="editTd">
							<input type="text" class="noborder" name="problemTracking.impRegulationRemark" value="${problemTracking.impRegulationRemark}" maxlength="400"/>
						</td>
					</tr>
					<tr>
						<td class="EditHead" nowrap>
							<c:choose>
								<c:when test="${en eq 'en'}">
									<label style="color: red;">*</label>New Policies After Audit(Quantity)
								</c:when>
								<c:otherwise>
									<%--<label style="color: red;">*</label>--%>
									审计完善制度数量（新制定数）
								</c:otherwise>
							</c:choose>
						</td>
						<td class="editTd">
							<%--<input type="text" class="noborder number editElement required" name="problemTracking.newRegulation" value="${problemTracking.newRegulation}" maxlength="10"/>--%>
							<input type="text" class="noborder naturalNumber editElement" name="problemTracking.newRegulation" value="${problemTracking.newRegulation}" maxlength="10"/>
						</td>
						<td class="EditHead">
							<c:choose>
								<c:when test="${en eq 'en'}">
									Increase Description
								</c:when>
								<c:otherwise>
									新增制度说明
								</c:otherwise>
							</c:choose>
						</td>
						<td class="editTd">
							<input type="text" class="noborder" name="problemTracking.newRegulationRemark" value="${problemTracking.newRegulationRemark}" maxlength="400"/>
						</td>
					</tr>
					<tr>
						<td class="EditHead" nowrap>
							<c:choose>
								<c:when test="${en eq 'en'}">
									<label style="color: red;">*</label>Audit Accountability(Economic Punishment)
								</c:when>
								<c:otherwise>
									<%--<label style="color: red;">*</label>--%>
									审计问责处理人次（经济处罚）
								</c:otherwise>
							</c:choose>
						</td>
						<td class="editTd">
							<%--<input type="text" class="noborder number editElement required" name="problemTracking.punishPersonEconomic" value="${problemTracking.punishPersonEconomic}" maxlength="10"/>--%>
							<input type="text" class="noborder naturalNumber editElement" name="problemTracking.punishPersonEconomic" value="${problemTracking.punishPersonEconomic}" maxlength="10"/>
						</td>
						<td class="EditHead" nowrap>
							<c:choose>
								<c:when test="${en eq 'en'}">
									<label style="color: red;">*</label>Audit Accountability(Party Discipline And Government Discipline)
								</c:when>
								<c:otherwise>
									<%--<label style="color: red;">*</label>--%>
									审计问责处理人次（党纪政纪处理）
								</c:otherwise>
							</c:choose>
						</td>
						<td class="editTd">
							<%--<input type="text" class="noborder number editElement required" name="problemTracking.punishPersonLaw" value="${problemTracking.punishPersonLaw}" maxlength="10"/>--%>
								<input type="text" class="noborder naturalNumber editElement" name="problemTracking.punishPersonLaw" value="${problemTracking.punishPersonLaw}" maxlength="10"/>
						</td>
					</tr>
					<tr>
						<td class="EditHead" nowrap>
							<c:choose>
								<c:when test="${en eq 'en'}">
									<label style="color: red;">*</label>Audit Accountability(Transfer To The Judiciary Authoritie)
								</c:when>
								<c:otherwise>
									<%--<label style="color: red;">*</label>--%>
									审计问责处理人次（移送司法机关）
								</c:otherwise>
							</c:choose>
						</td>
						<td class="editTd">
							<%--<input type="text" class="noborder number editElement required" name="problemTracking.punishPersonGov" value="${problemTracking.punishPersonGov}" maxlength="10"/>--%>
								<input type="text" class="noborder naturalNumber editElement" name="problemTracking.punishPersonGov" value="${problemTracking.punishPersonGov}" maxlength="10"/>
						</td>
						<td class="EditHead" nowrap>已纠正违纪违规金额（万元）</td>
						<td class="editTd">
							<%--<input type="text" class="noborder money editElement" name="problemTracking.yjzwjwgje" value="${problemTracking.yjzwjwgje}" maxlength="20"/>--%>
							<s:textfield cssClass="noborder money editElement" name="problemTracking.yjzwjwgje" value="%{formatMoney(problemTracking.yjzwjwgje)}"></s:textfield>
						</td>
					</tr>
					<tr>
						<td class="EditHead" nowrap>清退个人不当得利（万元）</td>
						<td class="editTd">
							<%--<input type="text" class="noborder money editElement" name="problemTracking.qtgrbddl" value="${problemTracking.qtgrbddl}" maxlength="20"/>--%>
							<s:textfield cssClass="noborder money editElement" name="problemTracking.qtgrbddl" value="%{formatMoney(problemTracking.qtgrbddl)}"></s:textfield>
						</td>
						<td class="EditHead" nowrap>补缴各类税款（万元）</td>
						<td class="editTd">
							<%--<input type="text" class="noborder money editElement" name="problemTracking.bjglsk" value="${problemTracking.bjglsk}" maxlength="20"/>--%>
							<s:textfield cssClass="noborder money editElement" name="problemTracking.bjglsk" value="%{formatMoney(problemTracking.bjglsk)}"></s:textfield>
						</td>
					</tr>
					<%--<s:if test="${dueTime}">
						<tr>
							<td class="EditHead">
								<c:choose>
									<c:when test="${en eq 'en'}">
										Unrectification Reason
										<div style="text-align:right;"><label style="color: red;">(2000 words limited)</label></div>
									</c:when>
									<c:otherwise>
										到期未整改原因
										<div style="text-align:right;"><label style="color: DarkGray;">(限2000字)</label></div>
									</c:otherwise>
								</c:choose>
							</td>
							<td class="editTd" colspan="3">
								<s:textarea id="no_rectification_reason" name="problemTracking.no_rectification_reason" cssClass="noborder"
								cssStyle="width:100%;height:100px;overflow-y:visible;line-height:150%;" title="到期未整改原因"/>
								<input type="hidden" id="problemTracking.no_rectification_reason.maxlength" value="200"/>
							</td>
						</tr>
					</s:if>--%>
					<tr id="fujian">
						<td class="EditHead">
							<c:choose>
								<c:when test="${en eq 'en'}">
									Rectification Attachment
								</c:when>
								<c:otherwise>
									整改证据
								</c:otherwise>
							</c:choose>
						</td>
						<td class="editTd" colspan="3">
							<s:hidden id="file_id" name="problemTracking.file_id" />
							<s:if test="${param.view ne 'view' }">
								<div data-options="fileGuid:'${problemTracking.file_id}'"  class="easyui-fileUpload"></div>
							</s:if>
							<s:else>
								<div data-options="fileGuid:'${problemTracking.file_id}',isAdd:false,isEdit:false,isDel:false"  class="easyui-fileUpload"></div>
							</s:else>
						</td>
					</tr>
			    </table>
			    <s:hidden name="isEdit" />
				<s:hidden name="project_code" />
				<s:hidden name="project_id" value="%{project_id}"/>
				<s:hidden name="permission" />
				<s:hidden name="middleLedgerProblem.project_id" value="%{project_id}" />
				<s:hidden name="middleLedgerProblem.id"/>
				<s:hidden name="middleLedgerProblem_id" value="${middleLedgerProblem.id}"/>
				<s:hidden name="formId" value="${problemTracking.formId}"/>
				<s:hidden name="problemTracking.mend_date"/>
				<s:hidden name="id" />
				<s:hidden name="wpd_stagecode" id="zwq"/>
				<s:hidden name="en" value="${en }"></s:hidden>
			</s:form>
		</div>

		<div id="sidebar"  title='上传附件' style='width:100%;overflow: hidden;' >
			<iframe id="upload" frameborder="0" scrolling="hidden" style="width:100%;height:100%;" src="" ></iframe>
		</div>
		<script type="text/javascript">
			/*
			 *上传附件
			*/
			function Upload(id,filelist){
				var guid = id;
				var num=Math.random();
				var rnm=Math.round(num*9000000000+1000000000);//随机参数清除模态窗口缓存
				window.showModalDialog('${contextPath}/commons/file/welcome.action?table_name=mng_aud_workplan_detail&table_guid=w_file&guid='+guid+'&&param='+rnm+'&&deletePermission=true',filelist,'dialogWidth:700px;dialogHeight:450px;status:yes');
			}
			$('#sidebar').window({
				width: 700,
				height:450,
				modal: true,
				shadow: true,
				closed: true,
				collapsible:false,
				maximizable:false,
				minimizable:false
			});
			/*
			* 删除附件
			*/
			function deleteFile(fileId,guid,isDelete,isEdit,appType,title){
				var boolFlag=window.confirm("确认删除吗?");
				if(boolFlag==true){
					DWREngine.setAsync(false);DWRActionUtil.execute(
						{ namespace:'/commons/file', action:'delFile', executeResult:'false' }, 
						{'fileId':fileId, 'deletePermission':isDelete, 'isEdit':isEdit, 'guid':guid, 'appType':appType,'title':title},
						xxx);
					function xxx(data){
					  	document.getElementById(guid).parentElement.innerHTML=data['accessoryList'];
					} 
				}
			}
			
			function triggerTab(tab){
				if(tab == "tab1"){
					document.getElementById("tab1").style.display='';
					document.getElementById("tab2").style.display='none';
					document.getElementById("tab3").style.display='none';
				}
				if(tab == "tab2"){
					document.getElementById("tab1").style.display='none';
					document.getElementById("tab2").style.display='';
					document.getElementById("tab3").style.display='';
					
				}
			}
			
			function saveForm(){
				if(audEvd$validateform('myform')) {
					if ( !validateDate("planStartDate","planEndDate")){
						return  false;
					}

					var sdate = $('#examine_startdate').datebox('getValue');
					var edate = $('#examine_enddate').datebox('getValue');
					if(sdate!=""&&edate!=""){
						sdate = sdate.replace("-","").replace("-","");
						edate = edate.replace("-","").replace("-","");
						var sn = new Number(sdate);
						var en = new Number(edate);
						if(sn>en){
							alert("实际整改期限结束日期不能小于开始日期!");
							return false;
						}
					}
					try{
						$('#saveBtn').removeAttr('onclick');
						var mend_state_code =$("#mend_state_code").combobox("getValue");
						if(mend_state_code && mend_state_code != null && mend_state_code != null){
						var mend_state	= $("#mend_state_code").combobox("getText");
						$("#mend_state").val(mend_state);
						}
						var url = "${contextPath}/proledger/problem/updateTrackingProblemRework.action";
						myform.action = url;
						myform.submit();
					}
					finally{
						$('#saveBtn').attr('onclick', 'saveForm();');
                        top.$.messager.show({title:'提示消息',msg:'保存成功！',timeout:3000});

                    }
					window.parent.saveCloseWin();
					window.parent.reloadtrackList();
				}
			}
			
			function back(){
				var mm = '${middleLedgerProblem.id}';
				var pi = '${project_id}';
				window.location.href = "${contextPath}/proledger/problem/feedbackListForAuditObject.action?en=${en}&middleLedgerProblem_id=${middleLedgerProblem.id}&project_id=${project_id}";
			}
			
		</script>
	</body>
</html>
