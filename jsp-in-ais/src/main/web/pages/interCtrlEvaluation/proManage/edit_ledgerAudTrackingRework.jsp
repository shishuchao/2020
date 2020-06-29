<!DOCTYPE HTML>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="fmt"%>
<html>
	<head>
		<title>被评价单位反馈列表整改进度反馈</title>
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
		<style type="text/css">
			.EditHead {
				width:20%;
			}
			
			.editTd {
				width:30%;
			}
		</style>
		<script type="text/javascript">
		//限定字数
		$(document).ready(function(){
			$("#examine_result").attr("maxlength",2000);
			$("#mend_result").attr("maxlength",2000);
			$("#responsibility_Mode").attr("maxlength",2000);
			$("#no_rectification_reason").attr("maxlength",2000);
			$("#real_examine_creater").attr("maxlength",2000);
			$("#aud_track_result").attr("maxlength",2000);
			//$("#responsibility_Mode").attr("maxlength",200);
			$("#myFirstform").find("textarea").each(function(){
				autoTextarea(this);
			});
			$("#myform").find("textarea").each(function(){
				autoTextarea(this);
			});
		});
		
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
	<body style="margin:0px;padding:0px;">
		<div class="easyui-panel" style="width:100%;padding:0px;" title="缺陷基本信息" border="0">
			<s:form id="myFirstform" cssStyle="width:100%;margin:0px;padding:0px;border-width:0px;">
			<table cellpadding=1 cellspacing=1 border=0 class="ListTable" id="tab1" style="width:100%;margin:0px;padding:0px;border:0px;" >
					<tr>
						<td class="EditHead" style="border-top-width:0px;">所属控制点</td>
						<td class="editTd" colspan="3" style="border-top-width:0px;">
							<s:property  value="interCtrlProblem.controlName" />
						</td>
					</tr>
					<tr>
						<td class="EditHead">所属主流程</td>
						<td class="editTd" colspan="3">
							<s:property value="interCtrlProblem.circuitName" id="circuitName"/>
						</td>
					</tr>
					<tr>
						<td class="EditHead">所属子流程</td>
						<td class="editTd" colspan="3">
							<s:property  value="interCtrlProblem.sonCircuitName" id="sonCircuitName"/>
						</td>
					</tr>
					<tr>
						<td class="EditHead">被评价单位</td>
						<td class="editTd">
							<s:property  value="interCtrlProblem.evaDept" id="evaDept"/>
						</td>
						<td class="EditHead">底稿索引</td>
						<td class="editTd" >
							<s:property  value="interCtrlProblem.manuscriptIndex" />
						</td>
					</tr>
					<tr>
						<td class="EditHead">内控缺陷编号</td>
						<td class="editTd">
							<s:textfield name="interCtrlProblem.defectCode" cssClass="noborder" readonly="true"></s:textfield>
						</td>
						<td class="EditHead">内控缺陷名称</td>
						<td class="editTd">
							<s:textfield name="interCtrlProblem.defectName" cssClass="noborder" readonly="true"></s:textfield>
						</td>
					</tr>
					<tr>
						
						<td class="EditHead">涉及单位部门</td>
						<td class="editTd" colspan="3">
							<s:property  value="interCtrlProblem.involveDept" id="involveDept"/>
						</td>
					</tr>
					<tr>
						<td class="EditHead">内控缺陷描述</td>
						<td class="editTd" colspan="3">
							<s:property  value="interCtrlProblem.defectDescription" id="defectDescription"/>
						</td>
					</tr>
					<tr>
						<td class="EditHead">缺陷成因</td>
						<td class="editTd" colspan="3">
							<s:property  value="interCtrlProblem.defectCause" id="defectCause"/>
						</td>
					</tr>
					<tr>
						<td class="EditHead">涉及的损失/错报的金额</td>
						<td class="editTd">
							<fmt:formatNumber pattern="##################.##"  minFractionDigits="2" >${interCtrlProblem.relateLoss}</fmt:formatNumber>
							&nbsp;万元</td>
						<td class="EditHead">缺陷类型</td>
						<td class="editTd">
							<s:property  value="interCtrlProblem.defectTypeName" id="defectTypeName"/>
						</td>
					</tr>
					<tr>
						<td class="EditHead">风险及影响</td>
						<td class="editTd" colspan="3">
							<s:property value="interCtrlProblem.riskEffect" id="riskEffect"/>
						</td>
					</tr>
					<tr>
						<td class="EditHead">认定结果</td>
						<td class="editTd" colspan="3">
							<s:property value="interCtrlProblem.defineResult" id="defineResult"/>
						</td>
					</tr>
					<tr>
						<td class="EditHead">整改建议</td>
						<td class="editTd" colspan="3">
							<s:property value="interCtrlProblem.mendAdvice" id="mendAdvice"/>
						</td>
					</tr>
					<tr>
						<td class="EditHead">整改建议描述</td>
						<td class="editTd" colspan="3">
							<s:property value="interCtrlProblem.suggestDescription" id="suggestDescription"/>
						</td>
					</tr>
					<tr>
						<td class="EditHead">整改责任单位</td>
						<td class="editTd">
							<s:property value="interCtrlProblem.accountabilityUnit" id="accountabilityUnit"/>
						</td>
						<td class="EditHead">整改主责部门</td>
						<td class="editTd">
							<s:property value="interCtrlProblem.accountabilityDept" id="accountabilityDept"/>
						</td>
					</tr>
					<tr>
						<td class="EditHead">整改责任人</td>
						<td class="editTd">
							<s:property value="interCtrlProblem.personLiable" id="personLiable"/>
						</td>
						<td class="EditHead">联系电话</td>
						<td class="editTd">
							<s:property value="interCtrlProblem.telephone" id="telephone"/>
						</td>
					</tr>
					<tr>
						<td class="EditHead">整改期限</td>
						<td class="editTd">
							<s:property value="interCtrlProblem.mendDeadline" id="mendDeadline"/>
						</td>
						<td class="EditHead">整改方式</td>
						<td class="editTd">
							<s:property value="interCtrlProblem.mendMethod" id=""/>
						</td>
					</tr>
					<tr>
						<td class="EditHead">监督检查人</td>
						<td class="editTd">
							<s:property value="interCtrlProblem.checkPeople" id="checkPeople"/>
						</td>
						<td class="EditHead">检查方式</td>
						<td class="editTd">
							<s:property value="interCtrlProblem.checkMethod" id="checkMethod"/>
						</td>
					</tr>
					<tr>
					<td class="EditHead">
						附件
					</td>
					<td class="editTd" colspan="3">
						<div data-options="fileGuid:'${interCtrlProblem.attachmentId}',isAdd:false,isEdit:false,isDel:false"  class="easyui-fileUpload"></div>
					</td>
				</tr>
				</table>
				</s:form>
			</div>
			<div class="easyui-panel" style="width:100%;padding:0px;" title="整改措施" border="0">
				<table cellpadding=1 cellspacing=1 border=0 class="ListTable" id="tab2" 
					style="width:100%;margin:0px;padding:0px;border:0px;" >
					<tr>
						<td class="EditHead" style="border-top-width:0px;">整改措施描述</td>
						<td class="editTd" colspan="3" style="border-top-width:0px;">
						<textarea class='noborder' name="interCtrlProblem.mendMeasureDescription" readonly="readonly"
									  rows="5" style="width:100%;overflow-y:hidden;line-height:150%;" UNSELECTABLE='on'>${interCtrlProblem.mendMeasureDescription}</textarea>
						</td>
					</tr>
					<tr>
						<td class="EditHead">整改负责部门/个人</td>
						<td class="editTd" colspan="3">
							<s:property value="interCtrlProblem.mendDeptPerson" id="mendDeptPerson"/>
						</td>
					</tr>
					<tr>
						<td class="EditHead">
							计划开始时间
						</td>
						<td class="editTd">
							<input name="interCtrlProblem.planStartTime" value="${interCtrlProblem.planStartTime }" readonly="readonly" class="noborder" style="width:140px;">
						</td>
						<td class="EditHead">
							计划完成时间
						</td>
						<td class="editTd">
							<input name="interCtrlProblem.planEndTime" value="${interCtrlProblem.planEndTime }" readonly="readonly" class="noborder" style="width:140px;">
						</td>
					</tr>
					<tr>
					    <td class="EditHead">录入人</td>
						<td class="editTd">
							<s:property value="interCtrlProblem.writePerson" />
						</td>
						<td class="EditHead">录入时间</td>
						<td class="editTd">
							<s:property value="interCtrlProblem.writeTime" />
						</td>
					</tr>
					<tr>
						<td class="EditHead">
							附件
						</td>
						<td class="editTd" colspan="3">
							<div data-options="fileGuid:'${interCtrlProblem.mend_measure_file_id}',isAdd:false,isEdit:false,isDel:false"  class="easyui-fileUpload"></div>
						</td>
					</tr>
				</table>
			</div>
			<div class="easyui-panel" style="width:100%;padding:0px;"  title="整改进度" border="0">
			<s:form id="myform" action="updateTrackingProblemRework" namespace="/intctet/proManage"
				cssStyle="width:100%;margin:0px;padding:0px;border-width:0px;">
				<table  cellpadding=1 cellspacing=1 border=0 class="ListTable" id="tab3"
					style="width:100%;margin:0px;padding:0px;border:0px;">
					<tr>
						<td class="EditHead" style="border-top-width:0px;">整改状态</td>
						<td class="editTd" colspan="3" style="border-top-width:0px;">
							<select id="mend_state_code" class="easyui-combobox" name="interCtrlProblemTracking.mend_state_code" editable="false" style="width:160px;" data-options="panelHeight:100">
						       <option value="">&nbsp;</option>
						       <s:iterator value="basicUtil.fllowOpinionList" id="entry">
							         <s:if test="${interCtrlProblemTracking.mend_state_code==code}">
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
						<td class="EditHead">整改进度描述
							<div style="text-align:right;"><font color=DarkGray>(限2000字)</font></div>
						</td>
						<td class="editTd" colspan="3">
						<s:textarea name="interCtrlProblemTracking.mend_result" id="mend_result" cssClass='noborder' title="整改进度描述"
								rows="5" cssStyle="width:100%;overflow-y:visible;line-height:150%;" />
							<input type="hidden" id="interCtrlProblemTracking.mend_result.maxlength" value="200"/>
						</td>
					</tr>
					<tr>
						<td class="EditHead">到期未整改原因
							<div style="text-align:right;"><font color=DarkGray>(限2000字)</font></div>
						</td>
						<td class="editTd" colspan="3">
							<s:textarea id="no_rectification_reason" name="interCtrlProblemTracking.no_rectification_reason" cssClass="noborder"
							cssStyle="width:100%;height:100px;overflow-y:visible;line-height:150%;" title="到期未整改原因"/>
							<input type="hidden" id="interCtrlProblemTracking.no_rectification_reason.maxlength" value="200"/>
						</td>
					</tr>
					<tr>
						<td class="EditHead">是否追责</td>
						<td class="editTd">
							<select id="responsibility" class="easyui-combobox" name="interCtrlProblemTracking.responsibility" editable="false" style="width:160px;" data-options="panelHeight:75">
						       <option value="">&nbsp;</option>
						       <s:iterator value='#@java.util.LinkedHashMap@{"是":"是","否":"否"}' id="entry">
							         <s:if test="${interCtrlProblemTracking.responsibility==key}">
						       			<option selected="selected" value="<s:property value="key"/>"><s:property value="value"/></option>
						       		 </s:if>
						       		 <s:else>
								        <option value="<s:property value="key"/>"><s:property value="value"/></option>
						       		 </s:else>
						       </s:iterator>
						    </select>	
						</td>
						<td class="EditHead">追责方式</td>
						<td class="editTd" >
							<s:textarea id="responsibility_Mode" name="interCtrlProblemTracking.responsibility_Mode"  cssClass="noborder" cssStyle="height:20px;overflow-y:hidden"/>
						</td>
					</tr>
					<tr>
						<td class="EditHead">实际整改开始时间</td>
						<td class="editTd">
							<input type="text" id="examine_startdate" name="interCtrlProblemTracking.examine_startdate" value="${interCtrlProblemTracking.examine_startdate }"
								class="easyui-datebox" editable="false" style="width: 130px"/>
						</td>
						<td class="EditHead">实际整改完成时间</td>
						<td class="editTd">
							<input type="text" id="examine_enddate" name="interCtrlProblemTracking.examine_enddate" value="${interCtrlProblemTracking.examine_enddate }"
							class="easyui-datebox" editable="false" style="width: 130px"/>
						</td>
					</tr>
					<tr>
						<td class="EditHead">反馈日期</td>
						<td class="editTd" colspan="3">
							<s:property id="mend_date" value="interCtrlProblemTracking.mend_date"/>
							<input type="hidden" name="interCtrlProblemTracking.mend_date" value="${interCtrlProblemTracking.mend_date }"/>
						</td>
					</tr>
					<tr id="fujian">
						<td class="EditHead">
						附件
						<s:hidden id="f_mend_accessory" name="interCtrlProblemTracking.f_mend_accessory" />
						<s:hidden id="file_id" name="interCtrlProblemTracking.file_id" />
					</td>
					<td class="editTd" colspan="3">
						<s:if test="${isView != 'yes'}">
							<div data-options="fileGuid:'${interCtrlProblemTracking.file_id}'"  class="easyui-fileUpload"></div>
						</s:if>
						<s:else>
							<div data-options="fileGuid:'${interCtrlProblemTracking.file_id}',isAdd:false,isEdit:false,isDel:false"  class="easyui-fileUpload"></div>
						</s:else>
					</td>
					</tr>
			    </table>
			    <s:hidden name="interCtrlProblemTracking.stateCode"/>
			    <s:hidden name="isEdit" />
				<s:hidden name="project_code" />
				<s:hidden name="project_id" />
				<s:hidden name="permission" />
				<s:hidden name="interCtrlProblem.proId" value="%{project_id}" />
				<s:hidden name="interCtrlProblem.id"/>
				<s:hidden name="inter_ctrl_problem_id" value="${interCtrlProblem.id}"/>
				<s:hidden name="formId" value="${interCtrlProblemTracking.formId}"/>
				<s:hidden name="id" />
				<s:hidden name="wpd_stagecode" id="zwq"/>
				<div align="center" style="text-align:right;padding:10px;">
					<s:if test="${isView != 'yes'}">
						<a class="easyui-linkbutton" iconCls="icon-save" href="javascript:void(0)" onclick="saveForm()">保存</a>
						&nbsp;&nbsp;
					</s:if>
					<a class="easyui-linkbutton" iconCls="icon-undo" href="javascript:void(0)" onclick="back()">返回</a>
				</div>
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
				var mend_state_code =$("#mend_state_code").combobox("getValue");
				if(mend_state_code && mend_state_code != null && mend_state_code != null){
				var mend_state	= $("#mend_state_code").combobox("getText");
				$("#mend_state").val(mend_state);
				}
				var url = "${contextPath}/intctet/proManage/updateTrackingProblemRework.action";
				myform.action = url;
				myform.submit();
				window.parent.saveCloseWin();
				window.parent.reloadtrackList();	
			}
			
			function back(){
				window.location.href = "${contextPath}/intctet/proManage/feedbackListForAuditObject.action?inter_ctrl_problem_id=${interCtrlProblem.id}&project_id=${project_id}";
			}
			
		</script>
	</body>
</html>
