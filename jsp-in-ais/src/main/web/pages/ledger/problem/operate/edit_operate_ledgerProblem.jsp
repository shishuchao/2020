<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<html>
	<link href="${contextPath}/styles/main/ais.css" rel="stylesheet"
		type="text/css">
	<link href="${contextPath}/resources/csswin/subModal.css"
		rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
	<script type="text/javascript" src="${contextPath}/scripts/validate.js"></script>
	<script type="text/javascript" src="${contextPath}/pages/utilTee/js/jquery-1.8.1.min.js"></script>
	<script type="text/javascript"
		src="${contextPath}/resources/csswin/common.js"></script>
	<script type="text/javascript"
		src="${contextPath}/resources/csswin/subModal.js"></script>
	<SCRIPT type="text/javascript" src="${contextPath}/scripts/calendar.js"></SCRIPT>
	<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
	<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
	<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
	<script type="text/javascript" src="${contextPath}/scripts/ufaudTextLengthValidator.js"></script>
	<head>
		<title><s:property value="#title" />
		</title>
		<!-- 审计问题 -->
		<s:head />
	</head>
	   <%String owner=(String)request.getAttribute("owner");
		String isOwner="";
		if("true".equals(owner)){
			isOwner="-owner";
		}else{
			isOwner="";
		}
		%>
	<body>
		<center>
			<s:form id="myform" action="saveOprateTask" namespace="/proledger/problem">
				<table cellpadding=1 cellspacing=1 border=0 bgcolor="#409cce"
					class="ListTable" id="tab1">
					<tr>
						<td class="ListTableTr11">
							问题一级分类:
						</td>
						<td class="ListTableTr22" width="250">
							<s:textfield name="ledgerProblem.sort_big_name"
								cssStyle="width:90%" readonly="true" />
							<s:hidden name="ledgerProblem.sort_big_code" />
						</td>
						<td class="ListTableTr11">
							问题二级分类:
						</td>
						<td class="ListTableTr22" width="230">
							<s:textfield name="ledgerProblem.sort_small_name"
								cssStyle="width:90%" readonly="true" />
							<s:hidden name="ledgerProblem.sort_small_code" />
						</td>
						<td class="ListTableTr11">
							问题三级分类:
						</td>
						<td class="ListTableTr22">
							<s:textfield name="ledgerProblem.sort_three_name"
								cssStyle="width:90%" readonly="true" />
							<s:hidden name="ledgerProblem.sort_three_code" />
						</td>
					</tr>
					<tr>
						<td class="ListTableTr11">
							问题点:
							<FONT color=red>*</FONT>
						</td>
						<td class="ListTableTr22">
							<s:textfield name="ledgerProblem.problem_name"
								cssStyle="width:85%" readonly="true" />
							<s:hidden name="ledgerProblem.problem_code"></s:hidden>
							&nbsp;
							<img
								src="<%=request.getContextPath()%>/resources/images/s_search.gif"
								onclick="showPopWin('<%=request.getContextPath()%>/pages/ledger/problem_tree/select/searchdata.jsp?url=<%=request.getContextPath()%>/ledger/problemledger/allTree.action&paraname=att2&paraid=att&funname=callback()',500,240)"
								border="0" style="cursor: hand">
						</td>
						<td class="ListTableTr11">
							发生数:
							<FONT color=red>*</FONT>
						</td>
						<td class="ListTableTr22">
							<s:textfield name="ledgerProblem.problem_money" id="problem_money"
								cssStyle="width:90%" doubles="true" maxlength="15" />
						</td>
						<td class="ListTableTr11">
							会计制度类型:
						</td>
						<td class="ListTableTr22">
						    <s:select id="accountantSystemTypeName" name="ledgerProblem.accountantSystemTypeName"
							list="basicUtil.accountingTypeList" listKey="code" listValue="name" headerKey="" headerValue=""
							theme="ufaud_simple" templateDir="/strutsTemplate" />
						</td>
					</tr>
					<tr>
						<td class="ListTableTr11">
							问题所属开始日期：
						</td>
						<td class="ListTableTr22">
							<s:textfield name="ledgerProblem.creater_startdate" id="creater_startdate"
								readonly="true" title="单击选择日期" onclick="calendar()"
								cssStyle="width:90%" maxlength="20" />
						</td>
						<td class="ListTableTr11">
							问题所属结束日期：
						</td>
						<td class="ListTableTr22">
							<s:textfield name="ledgerProblem.creater_enddate" id="creater_enddate" readonly="true"
								title="单击选择日期" onclick="calendar()" cssStyle="width:90%"
								maxlength="20" />
						</td>
						<td class="ListTableTr11">
							创建人:
						</td>
						<td class="ListTableTr22">
							<s:textfield name="ledgerProblem.problemCreater" id="problemCreater"
								cssStyle="width:90%" doubles="true" maxlength="15" />
						</td>
					</tr>
					<tr>
						<td class="ListTableTr11">
							问题定性:
							<FONT color=red>*</FONT>
						</td>
						<td class="ListTableTr22">
							<s:select list="basicUtil.problemMethodList" listKey="code"
								listValue="name" emptyOption="true"
								name="ledgerProblem.problem_grade_code"></s:select>
						</td>
						<td class="ListTableTr11">
                                统计数量单位:
                            <FONT color=red>*</FONT>
						</td>
						<td class="ListTableTr22" id="unitsDiv">
						</td>
						<td class="ListTableTr11">
                                被审计单位:
						</td>
						<td class="ListTableTr22">
						  <s:buttonText2 id="audit_object_name" hiddenId="audit_object"
								name="ledgerProblem.audit_object_name" cssStyle="width:90%"
								hiddenName="ledgerProblem.audit_object"
								doubleOnclick="showPopWin('${pageContext.request.contextPath}/pages/utilTee/ansyCheckBoxTreeFrame.jsp?urlAction=${pageContext.request.contextPath}/proledger/problem/utilTree!ansyMakeAudedUnitZtree.action?isFirstLoad=yes&parentid=${ledgerProblem.audit_dept}&nameid=audit_object_name&codeid=audit_objects&chkStyle=radio&radioType=all',600,450,'被审单位');"
								doubleSrc="${pageContext.request.contextPath}/resources/images/s_search.gif"
								doubleCssStyle="cursor:hand;border:0"
								readonly="true" />
						</td>
					</tr>
					<tr>
					  <td class="ListTableTr11">
					审计小组:
					<FONT color=red>*</FONT>
					</td>
					<td class="ListTableTr22" colspan="6">
					<s:textfield name="ledgerProblem.taskAssignName" cssStyle="width:80%"
							readonly="true" />
						<img
							src="<%=request.getContextPath()%>/resources/images/s_search.gif"
							onclick="getOwerGroup()" border="0" style="cursor: hand">
						<s:hidden name="ledgerProblem.taskAssign" />
					</td>
					</tr>
					<tr>
						<td class="ListTableTr11">责任：</td>
						<td class="ListTableTr22" colspan="2"><s:select name="ledgerProblem.zeren" 
							list="#@java.util.LinkedHashMap@{'领导责任':'领导责任','主管责任':'主管责任','直接责任':'直接责任'}"
							listValue="value" listKey="key" emptyOption="true"></s:select></td>
						<td class="ListTableTr11">违规否：</td>
						<td class="ListTableTr22" colspan="2"><s:select name="ledgerProblem.weigui" 
							list="#@java.util.LinkedHashMap@{'领违规':'领违规','损失浪费':'损失浪费','管理不规范':'管理不规范'}"
						listValue="value" listKey="key" emptyOption="true"></s:select></td>
					</tr>
					<tr>
					<td class="ListTableTr11">
					<!-- 原“问题描述”字段 -->
				     定性依据:
					</td>
					<td class="ListTableTr22" colspan="6">
					<s:textarea name="ledgerProblem.audit_law" title="定性依据" id="audit_law"
					cssStyle="width:90%;height:60" /> <input type="hidden"
					id="ledgerProblem.audit_law.maxlength" value="500">
					</td>
					</tr>
					<tr>
					<td class="ListTableTr11" style="BACKGROUND-COLOR: #F5F5F5;">
						<!-- 原“审计建议”字段 -->
						备注
					</td>
					<td class="ListTableTr22" colspan="6">
						<s:textarea name="ledgerProblem.aud_mend_advice" title="备注"
						cssStyle="width:90%;height:60" /> <input type="hidden"
						id="ledgerProblem.aud_mend_advice.maxlength" value="2000">
					</td>
					</tr>
				</table>
				<!-- <div align="left">
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:void(0);" onclick="triggerTab('tab2');">问题整改要求</a>
				</div> -->
				<table cellpadding=1 cellspacing=1 border=0 bgcolor="#409cce"
				    class="ListTable" id="tab2" style="display: none;">
				<tr>
					<td class="ListTableTr11">是否需要整改:</td>
					<td class="ListTableTr22">
						<s:select list="#@java.util.LinkedHashMap@{'是':'是','否':'否'}"
							name="ledgerProblem.isNotMend" id="isNotMend" emptyOption="true"></s:select>
					</td>
					<td class="ListTableTr11">整改期限:</td>
					<td class="ListTableTr22">
						<s:textfield name="ledgerProblem.mend_term" id="mend_term"
							readonly="true" title="单击选择日期" onclick="calendar()"
							cssStyle="width:30%" maxlength="20" />
					     	至
						<s:textfield name="ledgerProblem.mend_term_enddate"
							id="mend_term_enddate" readonly="true" title="单击选择日期"
							onclick="calendar()" cssStyle="width:30%" maxlength="20" />
					</td>
				</tr>
				<tr>
					<td class="ListTableTr11">
						责任单位:
					</td>
					<td class="ListTableTr22">
						<s:textfield name="ledgerProblem.zeren_company" maxlength="200"/>
					</td>
					<td class="ListTableTr11">
						整改责任部门:
					</td>
					<td class="ListTableTr22">
						<s:textfield name="ledgerProblem.zeren_dept" maxlength="200"/>
					</td>
					
				</tr>
				<tr>
				    <td class="ListTableTr11">整改负责人:</td>
					<td class="ListTableTr22">
						<s:textfield name="ledgerProblem.zeren_person" maxlength="100"/>
					</td>
					<td class="ListTableTr11">监督检查人:</td>
					<td class="ListTableTr22">
					    <s:textfield name="ledgerProblem.examine_creater_code" maxlength="100"/>
					</td>
				</tr>
				<tr>
					<td class="ListTableTr11">建议追责方式:</td>
					<td class="ListTableTr22">
						<s:select list="basicUtil.mendMethodList" listKey="code" id="mendSelect"
							listValue="name" emptyOption="true"
							name="ledgerProblem.mend_method_code">
						</s:select>
						<s:hidden name="ledgerProblem.mend_method"></s:hidden>
					</td>
					<td class="ListTableTr11">检查方式:</td>
					<td class="ListTableTr22">
						<s:select list="basicUtil.examineMethodList" listKey="code" id="examineSelect"
							listValue="name" emptyOption="true"
							name="ledgerProblem.examine_method_code">
						</s:select>
						<s:hidden name="ledgerProblem.examine_method"></s:hidden>
					</td>
				</tr>
				<tr>
						<td class="ListTableTr11">整改建议:<font color=DarkGray>(限3000字)</font></td>
						<td class="ListTableTr22" colspan="7">
							<s:textarea
								name="ledgerProblem.aud_action_plan" title="整改建议" cssStyle="width:90%"/>
							<input type="hidden" id="ledgerProblem.aud_action_plan.maxlength" value="3000">
						</td>
				</tr>
			</table>
                <s:hidden name="id" value="${id}" />
				<s:hidden name="project_id" value="${project_id}" />
				<s:hidden name="taskId" value="${taskId}" />
				<s:hidden name="taskPid" value="${taskPid}" />
				<s:hidden name="ledgerProblem.id" />
				<s:hidden name="owner" />
				<input type="hidden" id="att" name="att" value="">
				<input type="hidden" id="att2" name="att2" value="">
				<s:button value="保存" onclick="this.style.disabled='disabled';saveForm();" />&nbsp;&nbsp;
				<s:button value="返回" onclick="backList();" />
			</s:form>
<s:if test="">

</s:if>
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
        var p_unit= document.getElementsByName("ledgerProblem.p_unit_code")[0].value;
        if(p_unit==''||p_unit==null){
   		 alert("请选择统计数量单位!");
   		 return false;
   	    }
        var mend_term= document.getElementById("mend_term").value.replace(/-/g, "/"); 
        var mend_term_enddate= document.getElementById("mend_term_enddate").value;
        if(mend_term!=null&&mend_term!=""&&mend_term_enddate!=null&&mend_term_enddate!=""){
        	mend_term = mend_term.replace(/-/g, "/");
        	mend_term_enddate = mend_term_enddate.replace(/-/g, "/");
        	if(Date.parse(mend_term) - Date.parse(mend_term_enddate) > 0){
           	 alert("整改期限开始日期不能大于结束日期!");
           	 return false;
            }
        }
        var url = "${contextPath}/proledger/problem/saveOprateTask.action";
	    myform.action = url;
	    
	    //取得 select 的text值
					var selectObj = document.getElementById("mendSelect") ;
					document.getElementById("ledgerProblem.mend_method").value = selectObj.options[selectObj.selectedIndex].text ;
					var selectObj = document.getElementById("examineSelect") ;
					document.getElementById("ledgerProblem.examine_method").value = selectObj.options[selectObj.selectedIndex].text ;
					
	    myform.submit();
    }
}

function callback(){
	var codes= document.getElementById("att").value;
	var names= document.getElementById("att2").value;
	var sort_code= codes.split("#");
	document.getElementById("ledgerProblem.problem_code").value=sort_code[0];
	
	if(sort_code.length-4 <= 0){
	document.getElementsByName("ledgerProblem.sort_three_code")[0].value='';
	}else{
	document.getElementsByName("ledgerProblem.sort_three_code")[0].value=sort_code[sort_code.length-4];
	}
	
	if(sort_code.length-3 == 0){
	document.getElementById("ledgerProblem.sort_small_code").value='';
	}else{
	document.getElementById("ledgerProblem.sort_small_code").value=sort_code[sort_code.length-3];
	}
	document.getElementById("ledgerProblem.sort_big_code").value=sort_code[sort_code.length-2];
	
	var sort_name= names.split("#");
	document.getElementById("ledgerProblem.problem_name").value=sort_name[0];
	
	if(sort_name.length-4 <= 0){
	document.getElementsByName("ledgerProblem.sort_three_name")[0].value='';
	}else{
	document.getElementsByName("ledgerProblem.sort_three_name")[0].value=sort_name[sort_name.length-4];
	}
	
	if(sort_name.length-3 == 0){
	document.getElementById("ledgerProblem.sort_small_name").value='';
	}else{
	document.getElementById("ledgerProblem.sort_small_name").value=sort_name[sort_name.length-3];
	}
	document.getElementById("ledgerProblem.sort_big_name").value=sort_name[sort_name.length-2];
	problemUnitList(sort_code[0],'');
	
	
	getGist(sort_code[0]);
	
	}
	
	
//获取定性依据
function getGist(problemCode){
    $.ajax({
      type: "POST",
      url: "${contextPath}/proledger/problem/saveOprateTask!getGist.action",
      data: {"problemCode":problemCode},
      success: function(msg){
          if(msg != ""){
             $("#audit_law").val(msg);
          }
      }
    });
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
			}
			document.getElementById('unitsDiv').innerHTML = problemUnitSelect;
		} 
}			

//返回上级list页面
function backList(){
  
   var u='${pageContext.request.contextPath}/proledger/problem/oprLedgerProlemUi.action?owner=${owner}&taskId=<%=request.getParameter("taskId")%>&permission=<%=request.getParameter("permission")%>&isView=<%=request.getParameter("isView")%>&project_id=<%=request.getParameter("project_id")%>'
   window.parent.Usp.doTabLoad({
           tabId:'common-data-dataframe-tab<%=isOwner%>',
           pid:'common-data-dataframe-tab5<%=isOwner%>',
           url:u
           });            
              
}

problemUnitList('${ledgerProblem.problem_code}','${ledgerProblem.p_unit_code}');

var msg="${requestScope.tipMessage}";
if(msg!=""&&msg=='true'){
	alert('保存成功!');
}

//选择小组  
function  getOwerGroup(){
     var num=Math.random();
	 var rnm=Math.round(num*9000000000+1000000000);
 	 var code=document.getElementsByName("project_id")[0].value; 
 	 showPopWin('${pageContext.request.contextPath}/pages/system/search/searchdataManu.jsp?url=<%=request.getContextPath()%>/operate/diary/selectGroup.action&a=a&x='+rnm+'&project_id='+code+'&paraname=ledgerProblem.taskAssignName&paraid=ledgerProblem.taskAssign',500,330,'审计小组选择');
 }  
 
		</SCRIPT>
	</body>
</html>
