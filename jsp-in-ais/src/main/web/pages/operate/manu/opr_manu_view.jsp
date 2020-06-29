<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE HTML>
<s:text id="title" name="'查看审计底稿'"></s:text>
<html>
<head>
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/autosize.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/jquery-fileUpload.js"></script>
	<script type="text/javascript" src="${contextPath}/pages/tlInteractive/tlInteractiveCommon.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/ueditor/ueditor.config.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/ueditor/ueditor.all.js"></script>
	<SCRIPT language="JavaScript">
		$(document).ready(function(){
			$("#myform").find("textarea").each(function(){
				autoTextarea(this);
			});

			var prom = document.getElementsByName("crudObject.prom")[0].value;
			if(prom != null &&  prom != "" && prom != '0'){
				getTai(prom);
			}

			$('#manuProblemDiv').window({
				width: '100%',
				height:'100%',
				modal:true,
				collapsible:false,
				maximizable:true,
				minimizable:false,
				closed:true
			});

			var ue = UE.getEditor('crudaudit_record',{elementPathEnabled:false,zIndex:2});

			ue.ready(function() {
				ue.setContent('${crudObject.audit_record}');
				ue.setDisabled();
			});

			var ue01 = UE.getEditor('crudaudit_con',{elementPathEnabled:false,zIndex:2});

			ue01.ready(function() {
				ue01.setContent('${crudObject.audit_con}');
				ue01.setDisabled();
			});

		});
		/* function changeManuType(){
            var manuType = '${crudObject.manuType}';
	if(manuType=='COMPREHENSIVE'){
		$('#record').show();
		$('#desc').hide();
		$('#law').hide();
		$('#advice').hide();
	}else{
		$('#record').hide();
		$('#desc').show();
		$('#law').show();
		$('#advice').show();
	}
} */

		//渲染关联底稿为链接
		function Test(){
			var code3=document.getElementsByName("crudObject.audit_found")[0].value;
			var code4=document.getElementsByName("crudObject.audit_matter")[0].value;
			var codeArray3=code3.split(',');
			var codeArray4=code4.split(',');
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
		function go2(s){
			//window.open("${contextPath}/operate/doubt/view.action?type=YD&doubt_id="+s,"","height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no");
			var width = ($(window).width()-1200)*0.5;
			var height = ($(window).height()-550)*0.2;
			var myurl = "${contextPath}/operate/doubt/view.action?type=YD&doubt_id="+s;
			parent.addTab("tabs","审计疑点查看","manuViewTab",myurl,false);
		}

		// 审计问题

		function getTai(rows){
			$("#sjproblemtr").css("display","block");
			var ms_code= '${crudObject.formId}';
			var pro_code= '${crudObject.project_id}';
			if(ms_code==""||ms_code=="null"){
				return true;
			}else{
				var iframe = document.getElementById("mainIFrame");
				iframe.height=100+30*rows;
				iframe.src = "/ais/proledger/problem/listDigaoEditProblem.action?project_id=${crudObject.project_id}&manuscript_id=${crudObject.formId}&manuscriptType=digao&view=view";
			}

		}
		function viewOldVersionManu(oldVersionId){
			var url = "${contextPath}/operate/manu/viewOldVersion.action?id="+oldVersionId;
			aud$openNewTab("底稿查看", url, true);
		}

		function viewLinkedManu(formId){
			var url = "${contextPath}/operate/manu/view.action?crudId="+formId;
			aud$openNewTab("引用底稿查看", url, true);
		}
	</SCRIPT>
</head>
<body style="overflow:hidden;padding:0px;margin:0px;" onload="Test();">
<div class='easyui-layout' fit='true' border='0'>
	<div region='center' border='0'>
		<center>
			<table class="ListTable" style="width:98%">
				<tr>
					<td style="text-align:left;" class="EditHead">
						<s:property value="#title" />
					</td>
				</tr>
			</table>
			<table id="myform" class="ListTable" style="width:98%">
				<tr>
					<td class="EditHead" style="width: 15%">
						<font color="red"></font>&nbsp;&nbsp;&nbsp;底稿状态
					</td>
					<!--标题栏-->
					<td class="editTd" colspan="3" style="width: 35%">
						<s:if test="crudObject.ms_status == '010'">
							底稿草稿
						</s:if>
						<s:if test="crudObject.ms_status == '015'">
							等待征求
						</s:if>
						<s:if test="crudObject.ms_status == '020'">
							正在征求
						</s:if>
						<s:if test="crudObject.ms_status == '030'">
							等待复核
						</s:if>
						<s:if test="crudObject.ms_status == '040'">
							正在复核
						</s:if>
						<s:if test="crudObject.ms_status == '050'">
							复核完毕
						</s:if>
						<s:if test="crudObject.ms_status == '060'">
							已经注销
						</s:if>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						${versionUrl }
					</td>
					<s:hidden name="crudObject.prom"></s:hidden>
				</tr>
				<tr>
					<td class="EditHead" >审计事项</td>
					<td class="editTd">${crudObject.task_name }</td>
					<td class="EditHead"><font color="red"></font>审计小组</td>
					<td class="editTd"><s:property value="crudObject.groupName" /></td>
					<!-- 						<td class="EditHead" style="width: 15%"></td> -->
					<!-- 						<td class="editTd " style="width:35%"></td>				 -->
				</tr>
				<tr>
					<td class="EditHead" style="width: 15%">底稿名称</td>
					<td class="editTd" style="width: 35%">${crudObject.ms_name }</td>
					<td class="EditHead" style="width: 15%">
						底稿编码
					</td>
					<td class="editTd" style="width: 35%">
						<s:property value="crudObject.ms_code" />

					</td>
					<%-- 				<td class="EditHead" style="width: 15%">参与人</td>
                                        <td class="editTd " style="width:35%"><s:property value="crudObject.attendMemberNames" /></td> --%>
				</tr>

				<s:hidden name="crudObject.audit_found" />
				<s:hidden name="crudObject.audit_matter" />
				<tr>
					<td class="EditHead">关联索引</td>
					<td class="editTd"><span id="p1"></span></td>
					<td class="EditHead">被审计单位</td>
					<td class="editTd"><s:property value="crudObject.audit_dept_name"/></td>
				</tr>
				<tr>
					<td class="EditHead">底稿录入人</td>
					<td class="editTd"><s:property value="crudObject.ms_author_name" /></td>
					<td class="EditHead">底稿所属人</td>
					<td class="editTd">
						<s:property value="crudObject.ms_owner" />
					</td>
				</tr>
				<tr>
					<td class="EditHead">
						引用底稿
					</td>
					<td class="editTd">${crudObject.linkManuName}</td>
					<td class="EditHead">创建日期</td>
					<td class="editTd"><s:property value="crudObject.ms_date" /></td>
				</tr>
				<tr id="record">
					<td class="EditHead">审计过程记录</td>
					<td class="editTd" colspan="3">
						<script id="crudaudit_record" name="crudaudit_record" type="text/plain" style="width:100%"></script>
					</td>
				</tr>
				<tr>
					<td class="EditHead">审计结论</td>

					<td class="editTd" colspan="3">
						<script id="crudaudit_con" name="crudaudit_con" type="text/plain" style="width:100%"></script>
					</td>
				</tr>

				<s:if test="${tableType == '1'}">
					<tr>
						<td class="EditHead">
							关联底稿
						</td>
						<td class="editTd">
							<s:textfield name="ledgerProblem.linkManuName"  cssStyle='width:260px' readonly="true" />
							<!--一般文本框-->
							<s:hidden name="ledgerProblem.linkManuId" />
							<img src="<%=request.getContextPath()%>/resources/images/s_search.gif" onclick="getOwerManu()" border=0 style="cursor: hand">
						</td>
						<td class="EditHead">被审计单位</td>
						<td  class="editTd">
							<s:textfield name="ledgerProblem.audit_object_name" cssStyle='width:260px' readonly="true" />
							<s:hidden name="ledgerProblem.audit_object" />
							<img src="<%=request.getContextPath()%>/resources/images/s_search.gif" onclick="getGroup();" border=0 style="cursor: hand">
						</td>
					</tr>
					<tr>
						<td class="EditHead">审计结论</td>
						<td class="editTd" colspan="5">
									<textarea class='noborder'  name="ledgerProblem.sjjl" readonly="readonly"
											  rows="5" style="border-width:0px;width:98%;overflow-y:visible;line-height:150%;"  >${crudObject.sjjl}</textarea>
								<%--<s:textarea name="ledgerProblem.sjjl" title="审计结论" id="sjjl" cssClass='autoResizeTexareaHeight' cssStyle="width:90%;height:200" />--%>
							<input type="hidden" id="ledgerProblem.sjjl.maxlength" value="500">
						</td>
					</tr>
					<tr>
						<td class="EditHead">事实描述</td>
						<td class="editTd" colspan="5">
									<textarea class='noborder'  name="ledgerProblem.ssms" readonly="readonly"
											  rows="5" style="border-width:0px;width:98%;overflow-y:visible;line-height:150%;"  >${crudObject.ssms}</textarea>
								<%--<s:textarea name="ledgerProblem.ssms" title="事实描述" id="ssms" cssClass='autoResizeTexareaHeight' cssStyle="width:90%;height:200" />--%>
							<input type="hidden" id="ledgerProblem.ssms.maxlength" value="500">
						</td>
					</tr>
					<tr>
						<td class="EditHead">处理决定</td>
						<td class="editTd" colspan="5">
							<s:textarea name="ledgerProblem.cljd" title="处理决定" id="cljd" cssClass='autoResizeTexareaHeight' cssStyle="border-width:0px;width:90%;height:200" />
							<input type="hidden" id="ledgerProblem.cljd.maxlength" value="500">
						</td>
					</tr>
				</s:if>

				<%-- 	<tr id="law">
						<td class="EditHead">定性依据
							<input type="hidden" value="查看法规制度" onclick="law()" />
						</td>
						<td class="editTd" colspan="3">
							<textarea class='noborder'  name="crudObject.audit_law" readonly="readonly"
									  rows="5" style="border-width:0px;width:98%;overflow-y:visible;line-height:150%;"  >${crudObject.audit_law}</textarea>
						</td>
					</tr> --%>
				<%-- 	<tr id="advice">
					<td class="EditHead">处理建议</td>
					<td class="editTd" colspan="3">
						<textarea class='noborder'  name="crudObject.audit_advice" readonly="readonly"
								  rows="5" style="border-width:0px;width:98%;overflow-y:visible;line-height:150%;"  >${crudObject.audit_advice}</textarea>
					</td>
				</tr>
				 --%>
	<%--			<s:if test="crudObject.interact==1">
					<tr>
						<td class="EditHead">
							审计证据
						</td>
						<td class="editTd" colspan="3">
							<div id="subModelHTML" runat="server"
								 style="border-style: none; left: 0px; width: 98%; position: relative; top: 0px; line-height:150% ;">									<s:property escape="false" value="crudObject.subModelHTML" />
							</div>
							<s:hidden name="crudObject.subModelHTML" />
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
							<s:hidden name="crudObject.subModelHTML" />
							<s:hidden name="crudObject.ms_description" />
						</td>

					</tr>
				</s:elseif>--%>
				<s:if test="'GZNX' == '${dqxm}'">
					<tr>
						<td class="EditHead">查证过程</td>
						<td class="editTd" colspan="3">
						</td>
					</tr>
					<tr>
						<td class="editTd" colspan="4">

							<s:textarea cssClass='noborder'  name="crudObject.audit_method_name" readonly="true" disabled="true"
										rows="5" cssStyle="border-width:0px;width:100%;overflow-y:visible;line-height:150%;" />
						</td>
					</tr>
				</s:if>
				
				<s:if test="digaofankui=='enabled'">
					<tr>
						<td class="EditHead">&nbsp;&nbsp;&nbsp;被审计单位反馈意见
							<font color=DarkGray>(限3000字)</font>
						</td>
						<td class="editTd" colspan="3"><s:textarea
								cssClass='noborder'
								name="crudObject.audit_dept_feedback" readonly="true"
								cssStyle="width:100%;height:200px;overflow-y:hidden;" /></td>

					</tr>
				</s:if>
				<s:else>
					<s:hidden name="crudObject.audit_dept_feedback" />
				</s:else>
			</table>

			<s:if test="digaofankui=='enabled'">
				<s:if test="crudObject.ms_status=='050'||crudObject.ms_status=='020'||crudObject.ms_status=='015'">
					<%@include file="/pages/operate/feedback/list_feedbackinfo_view.jsp"%>
				</s:if>
			</s:if>
			
			<div id="sjproblemtr" style="display:none">
				<br>
				<table class="ListTable" align="center" style='width: 98%; padding: 0px; margin: 0px;'>
					<tr >
						<td class="EditHead" id="sjproblemtd1" style="text-align: left;">审计问题</td>

					</tr>
					<tr>
						<td class="EditHead" colspan="3" id="sjproblemtd2">
							<iframe width=100% height=100 frameborder=0 scrolling=auto id="mainIFrame" src=""></iframe>
						</td>
					</tr>
				</table>
				</br>
			</div>
			</br>
			<s:if test="${crudObject.isSureUpload=='1'}">
				<div id="manu_file2" class="easyui-fileUpload" data-options="fileGuid:'${crudObject.sure_guid}',isAdd:false,isEdit:false,isDel:false,fileGridTitle:'已确认底稿',callbackGridHeight:200"></div>
			</s:if>

			<%@include file="/pages/bpm/list_taskinstanceinfo.jsp"%>
		</center>
		<table class="ListTable" align="center" style='width: 98%; padding: 0px; margin: 0px;'>
			<tr>
				<td style="height: 300px;">
					<s:if test="(interaction!=null && interaction=='interaction' )|| (${viewmanu != 'process' })">
						<div data-options="fileGuid:'${crudObject.file_id}',isAdd:false,isEdit:false,isDel:false,callbackGridHeight:300"
							 class="easyui-fileUpload" ></div>
					</s:if>
					<s:else>
						<div id="manu_file" class="easyui-fileUpload" data-options="fileGuid:'${crudObject.file_id}',isAdd:false,isEdit:false,isDel:false,callbackGridHeight:300"></div>
					</s:else>
				</td>
			</tr>
		</table>

	</div>
</div>
<div id="manuProblemDiv" title="问题" style='overflow: hidden; padding: 0px;'>
	<iframe id="myFrameProblem" name="myFrameProblem" title="问题" src="" width="100%" height="100%" frameborder="0">
	</iframe>
</div>
</body>
</html>
