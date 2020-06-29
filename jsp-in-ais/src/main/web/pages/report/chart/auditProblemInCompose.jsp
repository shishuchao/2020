<%@ page language="java" pageEncoding="UTF-8"
	contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
<head>
<title>审出问题构成比</title>
<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
	<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
	<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
	<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
	<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
	<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
	<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/csswin/subModal.js"></script>
	<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
	<script type='text/javascript' src='${pageContext.request.contextPath}/scripts/turnPage.js'></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/scripts/check.js"></script>
	
	<link href="${contextPath}/styles/main/aisCommon.css" rel="stylesheet" type="text/css">
	<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
<script language="javascript">
		
			function CheckSubmit(){
				if(!frmCheck(document.forms[0], "tab1"))
					return false;
				if(document.getElementsByName("startDate")[0].value==""||document.getElementsByName("endDate")[0].value==""){
					alert("统计区间不能为空！");
					return false;
				}
				document.forms[0].action = "auditProblemChartAction!inCompose.action";
				if(document.all.ismax.checked){
					showreport.location.href = "${contextPath}/blank.jsp";
					document.forms[0].target = "_blank";
					document.forms[0].submit();
       			}else{
					document.forms[0].target = "showreport";
					document.forms[0].submit();
				}
			}
			function setfmid(obj,name){
				var str;
				str=obj.options[obj.selectedIndex].text;
				document.getElementsByName(name)[0].value=str;
			}
			function optionsClear(selectobj){
				selectobj.options.length=0; 
				selectobj.options[0] = new Option("请选择","");
			}
			function changeBigType(){
				var problemId = document.getElementById("problemType").value;
				if(problemId!=""){
					DWREngine.setAsync(false);
					DWREngine.setAsync(false);DWRActionUtil.execute(
						{ namespace:'/report', action:'selectProblemList', executeResult:'false' }, 
						{'problemId':problemId},
						xxx);
					function xxx(rs){
						var data = eval(rs['problemObject']);
						if(null!=data&&data.length>0){
							var smallType = document.getElementById("problemChildType");
							var problemUnit = document.getElementById("problemUnit");
							optionsClear(smallType);
							optionsClear(problemUnit);
							for(var i in data){
								if(data[i].isSort=='Y'){
									smallType.options.add(new Option(data[i].name,data[i].id));
								}else if(data[i].isSort=='N'){
									updateProblemUnit(data[i].unit,data[i].unit_name);
								}
							}
					    }
					}
				}
			}
			function updateProblemUnit(vUnit,vUnitName){
				var unit = vUnit.split(",");
				var unitName = vUnitName.split(",");
				var problemUnit = document.getElementById("problemUnit");
				var op = problemUnit.options;
				for(var i in unit){
					var ishas = false;
					for(var j=0;j<op.length;j++){
						if(op[j].value==unit[i]){
							ishas = true;
							break;
						}
					}
					if(!ishas){
						problemUnit.options.add(new Option(unitName[i],unit[i]));
					}
				}
			}
			function changeSmallType(){
				var problemId = document.getElementById("problemChildType").value;
				if(problemId!=""){
					DWREngine.setAsync(false);
					DWREngine.setAsync(false);DWRActionUtil.execute(
						{ namespace:'/report', action:'selectProblemList', executeResult:'false' }, 
						{'problemId':problemId},
						xxx);
					function xxx(rs){
						data = eval(rs['problemObject']);
						if(null!=rs&&data.length>0){
							var problemUnit = document.getElementById("problemUnit");
							optionsClear(problemUnit);
							for(var i in data){
								if(data[i].isSort=='N'){
									updateProblemUnit(data[i].unit,data[i].unit_name);
								}
							}
					    }
					}
				}
			}
			function changeUnit(){
				var problemUnit = document.getElementById("problemUnit");
				document.getElementById("problemUnitName").value=problemUnit.options[problemUnit.selectedIndex].text;
			}
			 var num=Math.random();
		     var rnm=Math.round(num*9000000000+1000000000);//随机参数清除模态窗口缓存
		     function showPopWindow(){
			    	showPopWin('/ais/pages/system/search/searchdatamuti.jsp?url=/ais/ledger/problemledger/mutiCheckTree.action&paraname=problemName&paraid=problemPoint&unit='+document.getElementById('problemUnit').value+'&param='+rnm,600,350,'审计问题');
			}
		</script>
</head>
<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout">
<div region="north" title="查询条件" data-options="split:false" style="height:150px;overflow:hidden;">
	<s:form name="form">
	<table id="tab1" cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable" >
		<tr>
			<td align="left" class="EditHead">审计单位：<FONT color=red>*</FONT></td>
			<td align="left" class="editTd">
			<%--<s:buttonText
				name="auditDeptName"  hiddenName="auditDept"
				doubleOnclick="showPopWin('/pages/system/search/searchdatamuti.jsp?url=/system/uSystemAction!companyList4muti.action&paraname=auditDeptName&paraid=auditDept&p_item=m5&param='+rnm,600,350,'所属单位')"
				doubleSrc="/resources/images/s_search.gif"
				doubleCssStyle="cursor:hand;border:0" readonly="true" />--%>
			<s:buttonText2 name="auditDeptName" hiddenName="auditDept" cssClass="noborder" cssStyle="width:80%"
						doubleOnclick="showSysTree(this,
						{ url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action',
						  checkbox:true,
						  title:'审计单位'
						})"
						doubleSrc="${pageContext.request.contextPath}/resources/images/s_search.gif"
						doubleCssStyle="cursor:hand;border:0" readonly="true" 
						doubleDisabled="false"/>
			</td>
			<td align="left" class="EditHead">统计区间：<FONT color=red>*</FONT>
			</td>
			<td align="left" class="editTd">
				<!--<s:textfield cssClass="noborder" cssStyle='width:37%' name="startDate" readonly="true" maxlength="10" title="单击选择日期" size="15" onclick="calendar()"></s:textfield>-->
				<input type="text" id="startDate" name="startDate" editable="false" Class="easyui-datebox noborder" />
				--
				<!--<s:textfield cssClass="noborder" cssStyle='width:38%' name="endDate" id="endDate" readonly="true" maxlength="10" title="单击选择日期" size="15" onclick="calendar()"></s:textfield>-->
				 <input type="text" id="endDate" name="endDate" editable="false" title="单击选择日期" Class="easyui-datebox noborder" />
			</td>
		</tr>
		<tr>
			<td align="left" class="EditHead">问题数量单位<FONT color=red>*</FONT> </td>
			<td align="left" class="editTd">
				<%-- <s:select id="unit" name="problemUnit" emptyOption="true" onchange="changeUnit()" listKey="code" listValue="name" list="basicUtil.ledger_unitList"></s:select> --%>
				<!-- <input  value="万元" disabled="disabled"> -->
				<s:textfield name="plan.w_plan_name" value="万元" readonly="true" cssClass="noborder" cssStyle="width:80%" maxlength="255" />
				<input type="hidden" name="problemUnitName" id="problemUnitName"/>
			</td>
			<td align="left" class="EditHead">问题点：<FONT color=red>*</FONT>
			</td>
			<td align="left" class="editTd">
				<%-- <s:buttonText
				name="problemName"  hiddenName="problemPoint"
				doubleOnclick="showPopWindow()"
				doubleSrc="/resources/images/s_search.gif"
				doubleCssStyle="cursor:hand;border:0" readonly="true" />--%>
				<s:buttonText
					name="problemName" cssClass="noborder" cssStyle="width:80%" hiddenName="problemPoint"
					doubleOnclick="showSysTree(this,{
	    				url:'${contextPath}/plan/detail/problemTreeViewByAsyn.action',
	    				checkbox:true,
	    				onlyLeafCheck:true,
	    				title:'请选择问题点'
					})"
					doubleSrc="/resources/images/s_search.gif"
					doubleCssStyle="cursor:hand;border:0" readonly="true" />
				
			</td>
		</tr>
		<tr>
			<td colspan="4"  class="editTd">
			<div style="text-align:right;padding-right:20px;">
			<input type="checkbox"name="ismax"/> 新窗口显示
				<a class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="CheckSubmit();">查询</a>
			</div>
			</td>
		</tr>
</table>
</s:form>
</div>
<div region="center" >
<table class="its" width="100%">
	<tr>
		<td><iframe allowtransparency="true" align="center"
			name="showreport" src="<%=request.getContextPath()%>/blank.jsp"
			frameborder="0" scrolling="auto" width="100%" height="400"></iframe>
		</td>
	</tr>
</table>
</div>
</body>
</html>
