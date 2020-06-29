<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE HTML>
<html>
	<head>
		<title>编辑审计问题中间表</title>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet" type="text/css" />
		<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/validate.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/csswin/subModal.js"></script>
		<SCRIPT type="text/javascript" src="${contextPath}/scripts/calendar.js"></SCRIPT>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
		<script type="text/javascript" src="${contextPath}/scripts/ufaudTextLengthValidator.js"></script>
		<style type="text/css">
			.ListTableTr11 {
				BACKGROUND-COLOR: #F5F5F5;
				width: 8%;
				height: 20;
				vertical-align: middle;
				text-align: right;
			}
			.ListTableTr22 {
				BACKGROUND-COLOR: #ffffff;
				width: 35%;
				height: 20;
				padding-left: 5px;
			}
			.ListTableTrStage {
				BACKGROUND-COLOR: #ffffff;
				width: 15%;
				height: 20;
				vertical-align :"middle"
			}
		</style>
	</head>
	<body>
		<center>
			<br />
			<br />
			<s:form name="midForm" id="myform" action="saveMiddleProblem" namespace="/proledger/problem">
				<table id="tab1" cellpadding=0 cellspacing=1 border=0 bgcolor="#409cce" class="ListTable" align="center">
					<tr>
						<td class="ListTableTr11" style="BACKGROUND-COLOR: #F5F5F5;" style="BACKGROUND-COLOR: #F5F5F5;">
							问题类别:
						</td>
						<td class="ListTableTr22">
							<s:textfield name="middleLedgerProblem.sort_big_name"
								cssStyle="width:90%" readonly="true" />
							<s:hidden name="middleLedgerProblem.sort_big_code" />
						</td>
						<td class="ListTableTr11" style="BACKGROUND-COLOR: #F5F5F5;">
							问题子类别:
						</td>
						<td class="ListTableTr22">
							<s:textfield name="middleLedgerProblem.sort_small_name"
								cssStyle="width:90%" readonly="true" />
							<s:hidden name="middleLedgerProblem.sort_small_code" />
						</td>
					</tr>
					<tr>
						<td class="ListTableTr11" style="BACKGROUND-COLOR: #F5F5F5;">
							问题点:
							<FONT color=red>*</FONT>
						</td>
						<td class="ListTableTr22">
							<s:textfield name="middleLedgerProblem.problem_name"
								cssStyle="width:90%" readonly="true" />
							<s:hidden name="middleLedgerProblem.problem_code"></s:hidden>
							&nbsp;
							<img
								src="<%=request.getContextPath()%>/resources/images/s_search.gif"
								onclick="wentidian()"
								border="0" style="cursor: hand">
						</td>
						<td class="ListTableTr11" style="BACKGROUND-COLOR: #F5F5F5;">
							发生数:
							<FONT color=red>*</FONT>
						</td>
						<td class="ListTableTr22">
							<s:textfield name="middleLedgerProblem.problem_money" id="problem_money"
								cssStyle="width:90%" doubles="true" maxlength="15" />
						</td>
					</tr>
					<tr>
						<td class="ListTableTr11" style="BACKGROUND-COLOR: #F5F5F5;" nowrap="nowrap">
							问题所属开始日期：
						</td>
						<td class="ListTableTr22">
							<s:textfield name="middleLedgerProblem.creater_startdate" id="creater_startdate"
								readonly="true" title="单击选择日期" onclick="calendar()"
								cssStyle="width:90%" maxlength="20" />
						</td>
						<td class="ListTableTr11" style="BACKGROUND-COLOR: #F5F5F5;" nowrap="nowrap">
							问题所属结束日期：
						</td>
						<td class="ListTableTr22">
							<s:textfield name="middleLedgerProblem.creater_enddate" id="creater_enddate" readonly="true"
								title="单击选择日期" onclick="calendar()" cssStyle="width:90%"
								maxlength="20" />
						</td>
					</tr>
					<tr>
						<td class="ListTableTr11" style="BACKGROUND-COLOR: #F5F5F5;">
							问题定性:
							<FONT color=red>*</FONT>
						</td>
						<td class="ListTableTr22">
							<s:select list="basicUtil.problemMethodList" listKey="code"
								listValue="name" emptyOption="true"
								name="middleLedgerProblem.problem_grade_code"></s:select>
						</td>
						<td class="ListTableTr11" style="BACKGROUND-COLOR: #F5F5F5;" nowrap="nowrap">
                                                   统计数量单位:
                            <FONT color=red>*</FONT>
						</td>
						<td class="ListTableTr22" id="unitsDiv">
						</td>
					</tr>
					<tr>
					<td class="ListTableTr11" style="BACKGROUND-COLOR: #F5F5F5;">
					所属底稿:
					</td>
					<td class="ListTableTr22">
					    <s:textfield name="middleLedgerProblem.manuscript_name"
							cssStyle="width:80%" readonly="true" />
						<s:hidden name="middleLedgerProblem.manuscript_id"></s:hidden>
						&nbsp;
						<img
								src="<%=request.getContextPath()%>/resources/images/s_search.gif"
								onclick="showPopWin('<%=request.getContextPath()%>/pages/system/search/searchdata.jsp?url=<%=request.getContextPath()%>/proledger/problem/selectOperateDiGao.action&paraname=middleLedgerProblem.manuscript_name&paraid=middleLedgerProblem.manuscript_id&p_item=<%=request.getParameter("project_id")%>&orgtype=<%=request.getParameter("taskId")%>',500,240,'所属底稿选择')"
								border="0" style="cursor: hand">
					</td>
					<td class="ListTableTr11" style="BACKGROUND-COLOR: #F5F5F5;">
					审计小组:
					<FONT color=red>*</FONT>
					</td>
					<td class="ListTableTr22">
					<s:textfield name="middleLedgerProblem.taskAssignName" cssStyle="width:80%"
							readonly="true" />
						<img
							src="<%=request.getContextPath()%>/resources/images/s_search.gif"
							onclick="getOwerGroup()" border="0" style="cursor: hand">
						<s:hidden name="middleLedgerProblem.taskAssign" />
					</td>
					</tr>
					<tr>
						<td class="ListTableTr11" style="BACKGROUND-COLOR: #F5F5F5;">
							被审计单位:
						</td>
						<td class="ListTableTr22" colspan="3">
							<s:textfield name="middleLedgerProblem.audit_object_name" cssStyle="width:80%"
								readonly="true" />
							<img
								src="<%=request.getContextPath()%>/resources/images/s_search.gif"
								onclick="getAuditObject()" border="0" style="cursor: hand">
							<s:hidden name="middleLedgerProblem.audit_object" />
						</td>
					</tr>
					<tr>
					<td class="ListTableTr11" style="BACKGROUND-COLOR: #F5F5F5;">
						问题描述:
					</td>
					<td class="ListTableTr22" colspan="3">
						<s:textarea name="middleLedgerProblem.problem_desc" title="问题描述"
						cssStyle="width:90%;height:60" /> 
						<input type="hidden" id="middleLedgerProblem.problem_desc.maxlength" value="2000">
					</td>
					</tr>
					<tr>
					<td class="ListTableTr11" style="BACKGROUND-COLOR: #F5F5F5;">
						审计建议:<font color=DarkGray>(限2000字)</font>
					</td>
					<td class="ListTableTr22" colspan="3">
						<s:textarea name="middleLedgerProblem.aud_mend_advice" title="审计建议"
						cssStyle="width:90%;height:60" /> 
						<input type="hidden" id="middleLedgerProblem.aud_mend_advice.maxlength" value="2000">
					</td>
					</tr>
				</table>
				<div align="left">
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:void(0);" onclick="triggerTab('tab2');">问题整改要求</a>
				</div>
				<table cellpadding=1 cellspacing=1 border=0 bgcolor="#409cce"
				    class="ListTable" id="tab2" style="display: none;">
				<tr>
					<td class="ListTableTr11">是否整改:</td>
					<td class="ListTableTr22">
						<s:select list="#@java.util.LinkedHashMap@{'是':'是','否':'否'}"
							name="middleLedgerProblem.isNotMend" id="isNotMend" emptyOption="true"></s:select>
					</td>
					<td class="ListTableTr11">整改期限:</td>
					<td class="ListTableTr22">
						<s:textfield name="middleLedgerProblem.mend_term" id="mend_term"
							readonly="true" title="单击选择日期" onclick="calendar()"
							cssStyle="width:30%" maxlength="20" />
					     	至
						<s:textfield name="middleLedgerProblem.mend_term_enddate"
							id="mend_term_enddate" readonly="true" title="单击选择日期"
							onclick="calendar()" cssStyle="width:30%" maxlength="20" />
					</td>
				</tr>
				<tr>
					<td class="ListTableTr11">
						整改责任部门:
					</td>
					<td class="ListTableTr22">
						<s:textfield name="middleLedgerProblem.zeren_dept" maxlength="200"/>
					</td>
					<td class="ListTableTr11">
						责任单位:
					</td>
					<td class="ListTableTr22">
						<s:textfield name="middleLedgerProblem.zeren_company" maxlength="200"/>
					</td>
				</tr>
				<tr>
				    <td class="ListTableTr11">整改负责人:</td>
					<td class="ListTableTr22">
						<s:textfield name="middleLedgerProblem.zeren_person" maxlength="100"/>
					</td>
					<td class="ListTableTr11">监督检查人:</td>
					<td class="ListTableTr22">
					    <s:textfield name="middleLedgerProblem.examine_creater_code" maxlength="100"/>
					</td>
				</tr>
				<tr>
					<td class="ListTableTr11">整改方式:</td>
					<td class="ListTableTr22">
						<s:select list="basicUtil.mendMethodList" listKey="code" id="mendSelect"
							listValue="name" emptyOption="true"
							name="middleLedgerProblem.mend_method_code">
						</s:select>
						<s:hidden name="middleLedgerProblem.mend_method"></s:hidden>
					</td>
					<td class="ListTableTr11">检查方式:</td>
					<td class="ListTableTr22">
						<s:select list="basicUtil.examineMethodList" listKey="code" id="examineSelect"
							listValue="name" emptyOption="true"
							name="middleLedgerProblem.examine_method_code">
						</s:select>
						<s:hidden name="middleLedgerProblem.examine_method"></s:hidden>
					</td>
				</tr>
				<tr>
						<td class="ListTableTr11">整改建议:<font color=DarkGray>(限3000字)</font></td>
						<td class="ListTableTr22" colspan="7">
							<s:textarea
								name="middleLedgerProblem.aud_action_plan" title="被审计单位行动计划" cssStyle="width:90%"/>
							<input type="hidden" id="middleLedgerProblem.aud_action_plan.maxlength" value="3000">
						</td>
				</tr>
			</table>
                <s:hidden name="id" value="${id}" />
				<s:hidden name="project_id" value="${project_id}" />
				<s:hidden name="taskId" value="${taskId}" />
				<s:hidden name="taskPid" value="${taskPid}" />
				<s:hidden name="middleLedgerProblem.id" />
				<s:hidden name="owner" />
				<input type="hidden" id="att" name="att" value="">
				<input type="hidden" id="att2" name="att2" value="">
				<s:button value="保存" onclick="this.style.disabled='disabled';saveForm();" />&nbsp;&nbsp;
				<s:button value="返回" onclick="backList();" />
			</s:form>
		</center>
		<script language="javascript">
			function triggerTab(tab){
				var isDisplay = document.getElementById(tab).style.display;
				if(isDisplay==''){
					document.getElementById(tab).style.display='none';
				}else{
					document.getElementById(tab).style.display='';
				}
			}
		
	        /*
	        *	选择被审计单位
	        */
	        function getAuditObject(){
	          var code=document.getElementsByName("middleLedgerProblem.taskAssign")[0].value; 
	          var name=document.getElementsByName("middleLedgerProblem.taskAssignName")[0].value;
	          var num=Math.random();
			  var rnm=Math.round(num*9000000000+1000000000);
	          var url='/ais/pages/system/search/searchdataManu.jsp?url=/ais/operate/task/selectDept.action&a=a&x='+rnm+'&group_id='+code+'&paraname=middleLedgerProblem.audit_object_name&paraid=middleLedgerProblem.audit_object';
	          if(name==null||name==""){
	             alert("请先选择审计小组!");
	             return false;
	          }
	          showPopWin(url,500,330,'被审计单位选择');
	        }
        
			function wentidian(){
				showPopWin('<%=request.getContextPath()%>/pages/ledger/problem_tree/select/searchdata.jsp?url=<%=request.getContextPath()%>/ledger/problemledger/allTree.action&paraname=att2&paraid=att&funname=callback()',500,240)
			}
			
			function saveForm(){
				var problem_money= document.getElementById("problem_money").value;
				var creater_startdate= document.getElementById("creater_startdate").value.replace(/-/g, "/"); 
				var creater_enddate= document.getElementById("creater_enddate").value.replace(/-/g, "/");
				var d1=new Date(creater_startdate);
				var d2=new Date(creater_enddate);
				if(Date.parse(d1) - Date.parse(d2) > 0){
				alert("问题所属开始日期不能大于结束日期!");
					return false;
				}
				if(frmCheck(document.forms[0], 'tab1')){
					if(!isMoneyNum1(problem_money)){
						alert("发生数应该填写金额!");
						return false;
					}
					var p_unit= document.getElementById("p_unit_code").value;
					if(p_unit==''||p_unit==null){
						alert("请选择统计数量单位！");
						return false;
					}
					//取得 select 的text值
					var selectObj = document.getElementById("mendSelect") ;
					document.getElementById("middleLedgerProblem.mend_method").value = selectObj.options[selectObj.selectedIndex].text ;
					var selectObj = document.getElementById("examineSelect") ;
					document.getElementById("middleLedgerProblem.examine_method").value = selectObj.options[selectObj.selectedIndex].text ;
					
					myform.submit();
				}
			}
			
			function callback(){
				var codes= document.getElementById("att").value;
				var names= document.getElementById("att2").value;
				var sort_code= codes.split("#");
				document.getElementById("middleLedgerProblem.problem_code").value=sort_code[0];
				if(sort_code.length-3==0){
				document.getElementById("middleLedgerProblem.sort_small_code").value='';
				}else{
				document.getElementById("middleLedgerProblem.sort_small_code").value=sort_code[sort_code.length-3];
				}
				document.getElementById("middleLedgerProblem.sort_big_code").value=sort_code[sort_code.length-2];
				var sort_name= names.split("#");
				document.getElementById("middleLedgerProblem.problem_name").value=sort_name[0];
				if(sort_name.length-3==0){
				document.getElementById("middleLedgerProblem.sort_small_name").value='';
				}else{
				document.getElementById("middleLedgerProblem.sort_small_name").value=sort_name[sort_name.length-3];
				}
				document.getElementById("middleLedgerProblem.sort_big_name").value=sort_name[sort_name.length-2];
				problemUnitList(sort_code[0],'');
			}
			/**
				取得数量单位的下拉菜单
			**/
			function problemUnitList(problemCode,problemUnitCode){
			  DWREngine.setAsync(false);
					DWREngine.setAsync(false);DWRActionUtil.execute(
						{ namespace:'/proledger/problem', action:'problemUnitList', executeResult:'false' }, 
						{'problemCode':problemCode,'problemUnitCode':problemUnitCode},
						xxx);
					function xxx(data){
						problemUnitSelect = data['problemUnitSelect'];
						if(problemUnitSelect==null){
						  problemUnitSelect='';
						}else{
							problemUnitSelect = problemUnitSelect.replace('ledgerProblem.p_unit_code','middleLedgerProblem.p_unit_code');
						}
						document.getElementById('unitsDiv').innerHTML = problemUnitSelect;
					} 
			}			
			
			/*
			*	返回到列表 页面
			*/
			function backList(){
			   window.parent.Usp.doTabLoad({
				   //title:'整改问题一览表',
				   title:'入报告问题',
			       tabId:'common-data-dataframe-tab1',
			       pid:'common-data-dataframe-tab',
			       url:'${pageContext.request.contextPath}/proledger/problem/projectProblemMiddleTab.action?project_id=<%=request.getParameter("project_id")%>'
			   });            
			}
			
			problemUnitList('${middleLedgerProblem.problem_code}','${middleLedgerProblem.p_unit_code}');
			var msg="${requestScope.tipMessage}";
			if(msg!=""&&msg=='true'){
				alert('保存成功!');
			}
			//选择小组  
			function  getOwerGroup(){
			     var num=Math.random();
				 var rnm=Math.round(num*9000000000+1000000000);
			 	 var code=document.getElementsByName("project_id")[0].value; 
			 	 showPopWin('${pageContext.request.contextPath}/pages/system/search/searchdataManu.jsp?url=<%=request.getContextPath()%>/operate/diary/selectGroup.action&a=a&x='+rnm+'&project_id='+code+'&paraname=middleLedgerProblem.taskAssignName&paraid=middleLedgerProblem.taskAssign',500,330,'审计小组选择');
			 }
			
		</script>
	</body>
</html>
