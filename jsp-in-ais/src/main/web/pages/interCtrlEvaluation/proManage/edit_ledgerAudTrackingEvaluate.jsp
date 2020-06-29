<!DOCTYPE HTML>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="fmt"%>
<html>
	<head>
		<title>缺陷问题跟踪评价</title>
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
	<body>
		<!-- 	<div style="padding:10px;background: #FAFAFA; border: 1px solid #ccc;" align="left">问题属性信息
			</div> -->
			<div class="easyui-panel" style="width:99%;padding:0px;" title="缺陷基本信息">
			<s:form id="myFirstform">
			<table cellpadding=1 cellspacing=1 border=0 class="ListTable" id="tab1" >
					<tr>
						<td class="EditHead">所属控制点</td>
						<td class="editTd" >
							<s:property  value="interCtrlProblem.controlName" />
						</td>
						<td class="EditHead">底稿索引</td>
						<td class="editTd" >
							<s:property  value="interCtrlProblem.manuscriptIndex" />
						</td>
					</tr>
					<tr>
						<td class="EditHead" width="15%">所属主流程</td>
						<td class="editTd" width="35%">
							<s:property value="interCtrlProblem.circuitName" id="circuitName"/>
						</td>
						<td class="EditHead" width="18%">所属子流程</td>
						<td class="editTd" width="35%">
							<s:property  value="interCtrlProblem.sonCircuitName" id="sonCircuitName"/>
						</td>
					</tr>
					<tr>
						<td class="EditHead">被评价单位</td>
						<td class="editTd" colspan="3">
							<s:property  value="interCtrlProblem.evaDept" id="evaDept"/>
						</td>
					</tr>
					<tr>
						<td class="EditHead">内控缺陷编号</td>
						<td class="editTd" colspan="3">
							<s:property  value="interCtrlProblem.defectCode" id="defectCode"/>
						</td>
					</tr>
					<tr>
						<td class="EditHead">内控缺陷名称</td>
						<td class="editTd">
							<%-- <fmt:formatNumber pattern="##################.##"  minFractionDigits="2" >${middleLedgerProblem.problem_money}</fmt:formatNumber>
							&nbsp;万元</td> --%>
							<s:property  value="interCtrlProblem.defectName" id="defectName"/>
						<td class="EditHead">涉及单位部门</td>
						<td class="editTd">
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
						<td class="EditHead">缺陷类型</td>
						<td class="editTd">
							<s:property  value="interCtrlProblem.defectTypeName" id="defectTypeName"/>
						</td>
						<td class="EditHead">涉及的损失/错报的金额（万元）</td>
						<td class="editTd">
							<fmt:formatNumber pattern="##################.##"  minFractionDigits="2" >${interCtrlProblem.relateLoss}</fmt:formatNumber>
							&nbsp;万元</td>
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
						<s:if test="${param.view ne 'view' }">
							<div data-options="fileGuid:'${interCtrlProblem.attachmentId}'"  class="easyui-fileUpload"></div>
						</s:if>
						<s:else>
							<div data-options="fileGuid:'${interCtrlProblem.attachmentId}',isAdd:false,isEdit:false,isDel:false"  class="easyui-fileUpload"></div>
						</s:else>
					</td>
				</tr>
				</table>
				</s:form>
			</div>
			<br/>
			<div class="easyui-panel" style="width:99%;padding:0px;" title="整改措施">
			<table cellpadding=1 cellspacing=1 border=0 class="ListTable" id="tab2" >
				<tr>
					<td class="EditHead">整改措施描述</td>
					<td class="editTd" colspan="5">
					<textarea class='noborder' name="interCtrlProblem." readonly="readonly"
								  rows="5" style="width:98%;overflow-y:hidden;line-height:150%;" UNSELECTABLE='on'>${middleLedgerProblem.audit_advice}</textarea>
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
						<s:property value="interCtrlProblem.planStartTime" />
					</td>
					<td class="EditHead">
						计划完成时间
					</td>
					<td class="editTd">
						<s:property value="interCtrlProblem.planEndTime" />
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
						<s:if test="${param.view ne 'view' }">
							<div data-options="fileGuid:'${interCtrlProblem.mend_measure_file_id}'"  class="easyui-fileUpload"></div>
						</s:if>
						<s:else>
						<div data-options="fileGuid:'${interCtrlProblem.mend_measure_file_id}',isAdd:false,isEdit:false,isDel:false"  class="easyui-fileUpload"></div>
						</s:else>
					</td>
				</tr>
			</table>
			</div>
			<br/>
			<div class="easyui-panel" style="width:99%;padding:0px;" title="整改进度查看">
				<table  class="ListTable" id="tab3">
					<tr>
						<td class="EditHead">整改状态</td>
						<td class="editTd" colspan="3">
							<s:property value="interCtrlProblem.mendMethod" id="mendMethod"/>
						</td>
					</tr>
					<tr>
						<td class="EditHead" style="width:25%">整改进度描述
							<div style="text-align:right;"><font color=DarkGray>(限2000字)</font></div>
						</td>
						<td class="editTd" colspan="3">
						<s:textarea name="interCtrlProblem.mendDescription" id="mend_result" cssClass='noborder' title="整改进度描述"
								rows="5" cssStyle="width:100%;overflow-y:visible;line-height:150%;" readonly="true"/>
							<input type="hidden" id="interCtrlProblem.mendDescription.maxlength" value="200"/>
						</td>
					</tr>
					<tr>
						<td class="EditHead">到期未整改原因
							<div style="text-align:right;"><font color=DarkGray>(限2000字)</font></div>
						</td>
						<td class="editTd" colspan="3">
							<s:textarea id="no_rectification_reason" name="interCtrlProblem.no_rectification_reason" readonly="true" cssClass="noborder"
							cssStyle="width:100%;height:100px;overflow-y:visible;line-height:150%;" title="到期未整改原因"/>
							<input type="hidden" id="interCtrlProblem.no_rectification_reason.maxlength" value="200"/>
						</td>
					</tr>
					<tr>
						<td class="EditHead">是否追责</td>
						<td class="editTd">
						    <s:property value="interCtrlProblem.responsibility"/>	
						</td>
						<td class="EditHead">追责方式</td>
						<td class="editTd" >
							<s:textarea id="responsibility_Mode" name="interCtrlProblem.responsibility_Mode" readonly="true"  cssClass="noborder" cssStyle="height:20px;overflow-y:hidden"/>
						</td>
					</tr>
					<tr>
						<td class="EditHead">实际开始时间</td>
						<td class="editTd">
						    <s:property value="interCtrlProblem.examine_startdate"/>	
						</td>
						<td class="EditHead" style="width:15%">实际完成时间</td>
						<td class="editTd">
							<s:property value="interCtrlProblem.examine_enddate"/>
						</td>
					</tr>
					<tr>
						<td class="EditHead">反馈人</td>
						<td class="editTd">
						    <s:property value="interCtrlProblem.tracker_name"/>	
						</td>
						<td class="EditHead" style="width:15%">反馈时间</td>
						<td class="editTd">
							<s:property value="interCtrlProblem.lastFeedbackTime"/>
						</td>
					</tr>
					<s:if test="interaction==null || interaction==''">
						<tr id="fujian">
							<td class="EditHead">
							附件
							<s:hidden id="feedback_file_id" name="interCtrlProblem.feedback_file_id" />
						</td>
						<td class="editTd" colspan="3">
							<s:if test="${param.view ne 'view' }">
								<div data-options="fileGuid:'${interCtrlProblem.feedback_file_id}'"  class="easyui-fileUpload"></div>
							</s:if>
						<s:else>
								<div data-options="fileGuid:'${interCtrlProblem.feedback_file_id}',isAdd:false,isEdit:false,isDel:false"  class="easyui-fileUpload"></div>
						</s:else>
						</td>
						</tr>
					</s:if>    
			    </table>
			</div>
			<br>
			<div class="easyui-panel" style="width:99%;padding:0px;" title="整改进度检查评价">
			<s:form id="myform" action="updateTrackingProblemEvaluate" namespace="/intctet/proManage">
				<table class="ListTable" cellpadding=1 cellspacing=1 id="tab4">
					<tr>
						<td class="EditHead">整改状态评价</td>
						<td class="editTd">
							<select id="f_mend_opinion_code" class="easyui-combobox" name="interCtrlProblemTracking.f_mend_opinion_code" editable="false" style="width:160px;" data-options="panelHeight:100">
						       <option value="">&nbsp;</option>
						       <s:iterator value="basicUtil.fllowOpinionList" id="entry">
							         <s:if test="${interCtrlProblemTracking.f_mend_opinion_code==code}">
						       			<option selected="selected" value="<s:property value="code"/>"><s:property value="name"/></option>
						       		 </s:if>
						       		 <s:else>
								        <option value="<s:property value="code"/>"><s:property value="name"/></option>
						       		 </s:else>
						       </s:iterator>
						    </select>
						    <s:hidden name="projectStartObject.supervisor_name" />
						    <s:hidden id="f_mend_opinion_name" name="interCtrlProblemTracking.f_mend_opinion_name"></s:hidden>
						</td>
						<td class="EditHead" style="width:15%;"></td>
						<td class="editTd"></td>
					</tr>
					<tr>
						<td class="EditHead" style="width:25%">整改跟踪检查结果描述
							<div style="text-align:right;"><font color=DarkGray>(限2000字)</font></div>
						</td>
						<td class="editTd" colspan="3">
						<s:textarea name="interCtrlProblemTracking.examine_result" id="examine_result" cssClass='noborder' title="整改跟踪检查结果描述"
								rows="5" cssStyle="width:100%;overflow-y:visible;line-height:150%;"/>
							<input type="hidden" id="interCtrlProblemTracking.examine_result.maxlength" value="200"/>
						</td>
					</tr>

					<tr>
						<td class="EditHead" style="width:15%;">检查人</td>
						<td class="editTd" style="width:33%;">
							<s:property id="tracker_name" value="interCtrlProblemTracking.tracker_name"/>
							<input type="hidden" name="interCtrlProblemTracking.tracker_name">
							<input type="hidden" name="interCtrlProblemTracking.tracker_code">
						</td>
						<td class="EditHead" style="width:15%;">检查时间</td>
						<td class="editTd" style="width:33%;">
							<s:property value="interCtrlProblemTracking.feedback_date"/>
							<input type="hidden" name="interCtrlProblemTracking.feedback_date"/>
						</td>
					</tr>
					<s:if test="interaction==null || interaction==''">
					<tr id="fujian">
						<td class="EditHead">
						附件
						<s:hidden id="f_mend_accessory" name="interCtrlProblemTracking.f_mend_accessory" />
					</td>
					<td class="editTd" colspan="3">
						<s:if test="${param.view ne 'view' }">
							<div data-options="fileGuid:'${interCtrlProblemTracking.f_mend_accessory}'"  class="easyui-fileUpload"></div>
						</s:if>
					<s:else>
							<div data-options="fileGuid:'${interCtrlProblemTracking.f_mend_accessory}',isAdd:false,isEdit:false,isDel:false"  class="easyui-fileUpload"></div>
					</s:else>
					</td>
					</tr>
					</s:if>    
			    </table>
				<input type="hidden" name="inter_ctrl_problem_id" value="${inter_ctrl_problem_id }">
				<input type="hidden" name="id" value="${id}">
				<input type="hidden" name="interCtrlProblem.proId" value="${proId}">
				<div align="center">
					<s:if test="interaction==null || interaction==''">
						<s:if test="${isEdit == 'isEdit'}">
							<a class="easyui-linkbutton" iconCls="icon-save" href="javascript:void(0)" onclick="saveForm()">保存</a>
								&nbsp;&nbsp;
						</s:if>
					</s:if>
					<a class="easyui-linkbutton" iconCls="icon-undo" href="javascript:void(0)" onclick="back()">返回</a>
				</div>
			</s:form>
			</div>
			<div id="sidebar"  title='上传附件' style='width:100%;overflow: hidden;' >
	  			<iframe id="upload"  frameborder="0" scrolling="hidden" style="width:100%;height:100%;" src="" ></iframe>
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
			/* var viewURL =  '${contextPath}/commons/file/welcome.action?table_name=mng_aud_workplan_detail&table_guid=w_file&guid='+guid+'&&param='+rnm+'&&deletePermission=true';
			$('#upload').attr("src",viewURL);
			$('#sidebar').window('open'); */
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
				/**
				var isDisplay = document.getElementById(tab).style.display;
				if(isDisplay==''){
					document.getElementById(tab).style.display='none';
				}else{
					document.getElementById(tab).style.display='';
				}*/
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
				
				var f_mend_opinion_code =$("#f_mend_opinion_code").combobox("getValue");
				if(f_mend_opinion_code != null){
					var f_mend_opinion_name	= $("#f_mend_opinion_code").combobox("getText");
					$("#f_mend_opinion_name").val(f_mend_opinion_name);
				}
				var url = "${contextPath}/intctet/proManage/updateTrackingProblemEvaluate.action";
				myform.action = url;
				myform.submit();
				window.parent.saveCloseWin();
				window.parent.reloadtrackList();	
			}
			function back(){
				//window.parent.closeWin();
				window.history.back(-1);
			 // window.location.href="${contextPath}/proledger/problem/auditTrackingList.action?project_id=${project_id}&isEdit=true";
			}
			
		</script>
	</body>
</html>
