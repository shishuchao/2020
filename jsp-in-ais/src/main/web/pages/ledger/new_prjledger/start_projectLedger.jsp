<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE HTML>
<html>
	<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/csswin/subModal.js"></script>
	<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
	<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
	<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
	<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script> 
	<script type="text/javascript" src="${contextPath}/pages/tlInteractive/tlInteractiveCommon.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/createOrgTree.js"></script>
	<s:head theme="ajax" />
	<script type="text/javascript">
		function initCreator(){
			var teamleader='${param.teamleader}';//组长
			var auditleader='${param.auditleader}';//主审
			var teamcharge='${param.teamcharge}';//负责人
			document.getElementById('crudObject.xm_prj_teamleaderCode').value=teamleader;
			document.getElementById('crudObject.xm_prj_auditleaderCode').value=auditleader;
			document.getElementById('crudObject.pro_teamcharge').value=teamcharge;
		}

		function beforStartProcess(){
			var currentLoginUserId = '${user.floginname}';
			//var allTeamLeader = document.getElementById('crudObject.pro_teamleader').value;
			var pro_teamcharge = document.getElementById('crudObject.pro_teamcharge').value;
			var allTeamLeader = document.getElementById('crudObject.xm_prj_teamleaderCode').value;
			var allAuditleader = document.getElementById('crudObject.xm_prj_auditleaderCode').value;
			var proType = document.getElementById('pro_type').value;
			var submitOk='false';
			var edit='${param.editLedger}';
			var rework='${rework}';
			var report='${report}';
			if(rework!=null&&rework!=''){
				rework=rework+'';
			}
			if(report!=null&&report!=''){
				report=report+'';
			}
			<s:if test="@ais.project.ProjectSysParamUtil@isReworkStageEnabled()">
			if(rework=='0'||rework=='1'){
				submitOk='true';
			}
			</s:if>
			<s:else>
			if(report=='0'||report=='1'){
				submitOk='true';
			}
			</s:else>
			//判断取证记录和查询通知书是否都审批完成
		   //<s:if test="@ais.project.ProjectSysParamUtil@isXMTZEnabled()">
			/* if(!AccoutFlowFinished()){
				return false;
			} */
           /* </s:if>
			 if(submitOk=='false'){
				showMessage1("项目在终结阶段之后，项目关闭之前，方可启动!");
				return false;
			}*/
			if(allTeamLeader!='' || allAuditleader != '') {
                var teamLeaders = allTeamLeader.split(",");
                for (var i = 0; i < teamLeaders.length; i++) {
                    if (currentLoginUserId == teamLeaders[i]) {
                        return true;
                    }
                }
                /*if(pro_teamcharge!=''){
					var teamLeaders = pro_teamcharge.split(",");
					for(var i=0;i<teamLeaders.length;i++){
						if(currentLoginUserId==teamLeaders[i]){
							return true;
						}
					}
				}*/

                if (allAuditleader != '') {
                    var auditLeaders = allAuditleader.split(",");
                    for (var i = 0; i < auditLeaders.length; i++) {
                        if (currentLoginUserId == auditLeaders[i]) {
                            return true;
                        }
                    }
                } else {
                    showMessage1('只有主审和组长和项目领导才能提交流程!');
                    return false;
                }
                if ("${isRole}" == "true"){
					return true;
				}
            }else{
                showMessage1('只有主审和组长和项目领导才能提交流程!');
                return false;
			}

			// return true;
		     return false;
		}

		function toSubmit(option){
           if (!TzIsFinished()){
                return false;
            }
			<s:if test="isUseBpm=='true'">
			if(document.getElementsByName('isAutoAssign')[0].value=='false'||document.getElementsByName('formInfo.toActorId')[0]!=undefined)
			{
				var actor_name=document.getElementsByName('formInfo.toActorId')[0].value;
				if(actor_name==null||actor_name==''){
					showMessage1('下一步处理人不能为空！');
					return false;
				}
			}
			</s:if>
			<s:else>
			if(!beforStartProcess()){
				return false;
			}
			</s:else>
			$.messager.confirm('确认','确认要提交吗?', function(r){
				if (r) {
					var flowForm = document.getElementById('myform');
					document.getElementById('submitButton').disabled=true;
							<s:if test="isUseBpm=='true'">
								flowForm.action="<s:url action="submit" includeParams="none"/>";
							</s:if>
							<s:else>
								flowForm.action="<s:url action="directSubmit" includeParams="none"/>";
							</s:else>
					flowForm.submit();
				}
			});
		   
		}

		function saveLedger(project_id){
			var url = "${contextPath}/proledger/custom/createLedgerTabs.action?auditleader=${auditleader}&teamleader=${teamleader}&crudId=${crudObject.formId}&permission=full&view=${view}&project_id=${crudObject.xm_formId}";
			//aud$openNewTab('填写台帐', url, false);
			window.location.href=url;
		}
		
		function viewLedger(project_id){
			var url = "${contextPath}/proledger/custom/createLedgerTabs.action?auditleader=${auditleader}&teamleader=${teamleader}&crudId=${crudObject.formId}&permission=full&view=view&project_id=${crudObject.xm_formId}";
			//aud$openNewTab('查看台帐', url, false);
			window.location.href=url;
		}

		function writeLedger() {
			var state = '${crudObject.state}'
			 if('audited'==state) {
	    		  $.messager.confirm("确认对话框","确认修改已复核完毕的台帐吗？",function(r){
	   	    	   if(r){
	   	    		   jQuery.ajax({
	   	   				url:'${contextPath}/operate/manuExt/updateFormInfoState.action',
	   	   				type:'POST',
	   	   				data:{'formId':'${crudObject.formId}','type':'2','project_id':'${crudObject.xm_formId}'},
	   	   				async:false,
	   	   				success:function(data){
	   	   					if(data == "1") {
	   	   					 	window.location.href='${contextPath}/ledger/prjledger/projectLedgerNew/edit.action?crudId=${crudObject.formId}&project_id=${crudObject.xm_formId}&view=process&auditleader=${crudObject.xm_prj_auditleaderCode}&teamleader=${crudObject.xm_prj_teamleaderCode}';
	   	   					}else if(data == "2"){
	   	   						showMessage1("整改阶段已结束，不允许修改");
	   	   					}else{
	   	   	                    showMessage1("更新台帐状态失败！");
	   	   					}
	   	   				},
	   	   				error:function(){
	   	                    showMessage1("系统异常！");
	   	   				}
	   	   			});		
	   	    	  }
	   	       });
	    	  }
		}

		/**
		*	报告阶段最后一步提交前的台账相关校验
		*/
		function AccoutFlowFinished(){
			var result = 'YES';
			var messages = '';
			DWREngine.setAsync(false);
			DWRActionUtil.execute(
				{ namespace:'/ledger/prjledger/projectLedgerNew', action:'accoutFlowFinished', executeResult:'false' }, 
				{'projectStartFormId':'${crudObject.xm_formId}'},
				xxx);
			function xxx(data){
				result = data['accoutFlowFinished'];
				messages = data['messages'];
			} 
			if(result=='YES'){
				return true;
			}else{
				showMessage1(messages);
				return false;
			}
		}

        /**
         * 提交台帐前判断台帐是否已填写
         */
        function TzIsFinished(){
            var result = "YES";
            var messages = "";
            DWREngine.setAsync(false);
            DWRActionUtil.execute(
                { namespace:'/ledger/prjledger/projectLedgerNew', action:'tzFinished', executeResult:'false' },
                {'projectCode':'${crudObject.xm_prj_code}'},
                xxx);
            function xxx(data){
                result = data['tzIsFinished'];
                messages = data['messages'];
            }

            if(result=='YES'){
                return true;
            }else{
                showMessage1(messages);
                return false;
            }
        }

	</script>
	</head>

	<s:if test="taskInstanceId!=null&&taskInstanceId!=''">
		<body onload="end();" style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout">
	</s:if>
	<s:else>
		<body onload="initCreator();" style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout">
	</s:else>
	<div region="center">
		<s:form id="myform" action="save" namespace="/ledger/prjledger/projectLedgerNew">
			<div style="text-align:left;padding-right:5px;margin-top:10px;">
				<%--<s:hidden name="crudObject.pro_teamleader" id="crudObject.pro_teamleader"/>--%>
				<s:hidden name="crudObject.xm_prj_teamleaderCode" id="crudObject.xm_prj_teamleaderCode"/>
				<s:hidden name="crudObject.xm_prj_auditleaderCode" id="crudObject.xm_prj_auditleaderCode"/>
				<s:hidden name="crudObject.pro_teamcharge" id="crudObject.pro_teamcharge"></s:hidden>
				<s:hidden id="pro_type" name="crudObject.xm_prj_typeCode"></s:hidden>
				<s:hidden name="crudObject.xm_formId" />
				<s:hidden name="crudObject.formId" />
				<s:hidden name="crudObject.rework_closed" />
				<s:hidden name="crudObject.xm_auditeeCode" />
				&nbsp;
				<s:if test="${view == 'projectview'}">
					<a id="btn" href="javascript:void(0);" onclick="viewLedger('${crudObject.xm_formId}');" class="easyui-linkbutton" data-options="iconCls:'icon-view'">查看</a>
				</s:if>
				<s:else>
				<s:if test="${crudObject.state != 'audited'}">
					<jsp:include page="/pages/bpm/list_toBeStart.jsp"></jsp:include>
				</s:if>
				<s:if test="${crudObject.xm_formId!=null&&crudObject.xm_formId!=''}">
					<s:if test="${view == 'view'}">
						<s:if test="${projectStartObject.rework_closed != '1'}">
							<a id="btn" href="javascript:void(0);" onclick="writeLedger('${crudObject.xm_formId}');" class="easyui-linkbutton" data-options="iconCls:'icon-write'">修改</a>
						</s:if>
						<a id="btn" href="javascript:void(0);" onclick="viewLedger('${crudObject.xm_formId}');" class="easyui-linkbutton" data-options="iconCls:'icon-view'">查看</a>
					</s:if>
					<s:else>
						<s:if test="${taskInstanceId ne -1}">
							<a id="btn" href="javascript:void(0);" onclick="saveLedger('${crudObject.xm_formId}');" class="easyui-linkbutton" data-options="iconCls:'icon-write'">填写</a>
						</s:if>
						<s:else>
							<a id="btn" href="javascript:void(0);" onclick="viewLedger('${crudObject.xm_formId}');" class="easyui-linkbutton" data-options="iconCls:'icon-view'">查看</a>
						</s:else>
					</s:else>
				</s:if>
				</s:else>
			</div>
			<table cellpadding=0 cellspacing=0 border=0 class="ListTable" align="center" style="width: 98%;">
				<tr>
					<td class="EditHead" style="width: 10%">
						项目名称
					</td>
					<td class="editTd" style="width: 40%">
						<s:property value="crudObject.xm_prj_name" />
					</td>
					<td class="EditHead" style="width: 10%">
						项目编号 
					</td>
					<td class="editTd" style="width: 40%">
						<s:property value="crudObject.xm_prj_code" />
					</td>
				</tr>
				<tr >
					<td class="EditHead">
						计划类别
					</td>
					<td class="editTd">
						<s:property value="crudObject.xm_plan_type" />
					</td>
					<td class="EditHead">
						所属单位
					</td>
					<td class="editTd">
						<s:property value="crudObject.xm_auditee" />
					</td>
				</tr>
				<tr >
					<td class="EditHead">
						被审计单位
					</td>
					<td class="editTd">
						<s:property value="crudObject.xm_audi_obj" />
					</td>
					<td class="EditHead">
						项目类别
					</td>
					<td class="editTd">
						<s:property value="crudObject.xm_prj_type" />
					</td>
				</tr>
			</table>
			<div>
				<s:if test="${taskInstanceId ne -1}">
					<jsp:include flush="true" page="/pages/bpm/list_transition.jsp"></jsp:include>
				</s:if>
				<jsp:include flush="true" page="/pages/bpm/list_taskinstanceinfo.jsp"></jsp:include>
			</div>
		</s:form>
	</div>
	<div id="ledger_div" title="项目统计" style="overflow:hidden;padding:0px">
  		<iframe id="ledger_iframe" src="" width="100%" title="" height="100%" frameborder="0" ></iframe>
  	</div>
	<script type="text/javascript">
		//初始化台账窗口
		$(function(){
			$('#ledger_div').window({   
				width:document.documentElement.clientWidth,   
				height:document.documentElement.clientHeight,   
				modal:true,
				collapsible:false,
				maximizable:false,
				minimizable:false,
				closed:true
			});
			if('${firstManu}'=='A'){
				showMessage1("提交成功");
			}
		});
		function doStart(){
			document.getElementById('myform').action = "start.action";
			document.getElementById('myform').submit();
		}
	</script>
	<jsp:include page="/pages/frReportFlow/ajaxloading.jsp"></jsp:include>
	</body>
</html>