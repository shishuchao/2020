<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<!DOCTYPE HTML>		   
<html>
<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<title>风险维护事项概要信息修改</title>
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
	<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
	<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
	<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
	<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
	<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/csswin/subModal.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/autosize.js"></script>
	<script language="javascript">
		$(function (){
			$("#myform").find("textarea").each(function(){
				autoTextarea(this);
			});
			if("${param.isView}"=="Y"){
                document.getElementById("riskTaskTemplate.taskName").readOnly=true;
                document.getElementById("riskDescription").readOnly=true;
            }
		});
		//检查是否是类别1还是子项2，是2就返回false
		function checkItem(){
			var result=''; 
			$.ajax({
				url:'${contextPath}/riskManagement/knowledgeBase/riskTemplate/checkItem.action',
				type:'POST',
				async:false,
				data:{'taskId':'${taskId}','templateId':'${templateId}'},
				success:function(data){
					result = data;
				}
			});
			if(result=='1'){
				return true;
			}else{
				return false;
			}
		}
	
		//检查是否有下级 有下级返回false
		function checkDetail(){
			var resullt=''; 
			var s='<%=request.getParameter("taskId")%>';
			var q='<%=request.getParameter("templateId")%>';
			DWREngine.setAsync(false);
			DWRActionUtil.execute(
			{ namespace:'/riskManagement/knowledgeBase/riskTemplate', action:'checkDetail', executeResult:'false' }, 
			{'taskId':s,'templateId':q},xxx);
			function xxx(data){
				result = data['auth'];
			}
			if(result=='1'){
				return true;
			}else{
				return false;
			}
		}
		//输入检查
		function check(){
			var v_3 = "riskTaskTemplate.taskName";//field
			var title_3 = '名称';//field name
			var notNull = 'true';//notnull
			var t=document.getElementsByName(v_3)[0].value;
			if(t.length>128){
				showMessage1("事项名称的长度不能大于128字！");
				document.getElementById(v_3).focus();
				return false;
			}
			return true;
		}
	
		function generateLeaf2(){
			$('#listTaskDiv').datagrid('reload');
			var url = '${contextPath}/riskManagement/knowledgeBase/riskTemplate/addLeaf.action?taskPname=${riskTaskTemplate.taskName}&selectedTab=<%=request.getParameter("selectedTab")%>&type=<%=request.getParameter("type")%>&node=<%=request.getParameter("taskId")%>&taskId=<%=request.getParameter("taskId")%>&taskPid=<%=request.getParameter("taskPid")%>&templateId=<%=request.getParameter("templateId")%>';
			showWinIf('addLeaf_div',url,'增加风险事项',800,500);
		}
		//生成
		function generateType() {
		    if(!checkItem()){
				showMessage1("已经增加了风险事项的详细内容,不能增加子事项!");
				return false;
		    }else{
				var url = '${contextPath}/riskManagement/knowledgeBase/riskTemplate/addType.action?selectedTab=<%=request.getParameter("selectedTab")%>&type=<%=request.getParameter("type")%>&node=<%=request.getParameter("taskId")%>&taskId=<%=request.getParameter("taskId")%>&taskPid=<%=request.getParameter("taskPid")%>&templateId=<%=request.getParameter("templateId")%>';
				showWinIf('addType_div',url,'增加事项类别',800,400);
			}           
		} 
		function generateLeaf(){
			if(!checkDetail()){
				showMessage1("已经增加了下级节点,不能增加详细内容,请到末级节点增加详细内容!");
				return false;
			}else{
				title="增加审计事项详细内容";
				window.paramw = "模态窗口";
				showPopWin('${contextPath}/riskManagement/knowledgeBase/riskTemplate/showContentTypeDetail.action?type=1&selectedTab=item&node=<%=request.getParameter("taskId")%>&tab=item&taskPid=<%=request.getParameter("taskPid")%>&taskId=<%=request.getParameter("taskId")%>&templateId=<%=request.getParameter("templateId")%>',550,360,title);
			}          
		} 
		//删除
		function deleteRecord() {
			$.messager.confirm('提示','删除后会丢失该类别下的相关事项，确认删除事项类别吗？',function(flag){
				if(flag){
					$.ajax({
						type:"post",
						data:$('#myform').serialize(),
						url:"${contextPath}/riskManagement/knowledgeBase/riskTemplate/deleteType.action",
						async:false,
						success:function(){
							parent.parent.reloadChildTreeNode('delete');
							showMessage1('删除成功！');
						}
					});
				}
			});
		}
          
		function onlyNumbers1(s){
			re = /^\d+\d*$/
			var str=s.replace(/\s+$|^\s+/g,"");
			if(str==""){
				return false;
			}
			if(!re.test(str)){
				showMessage1("事项序号只能输入正整数,请重新输入!");
				return true ;   
			}
		}

		//保存表单
		function saveFormLeaf(){
			var v_3 = "riskTaskTemplate.taskName";//field
			var title_3 = '名称';//field name
			var notNull = 'true';//notnull
			if(document.getElementsByName(v_3)[0].value=="" && notNull=="true" && notNull != ""){
				showMessage1(title_3+"不能为空!");
				bool = false;
				document.getElementById(v_3).focus();
				return false;
			}
			if(document.getElementsByName(v_3)[0].value.replace(/\s+$|^\s+/g,"")==""){
				showMessage1(title_3+"不能为空!");
				bool = false;
				document.getElementById(v_3).focus();
				return false;
			}
			var v_2 =  "riskTaskTemplate.taskOrder"
			var title_2 = '事项序号';//field name
			var notNull = 'true'; //notnull
			if(document.getElementsByName(v_2)[0].value=="" && notNull=="true" && notNull != ""){
				showMessage1(title_2+"不能为空!");
				bool = false;
				document.getElementById(v_2).focus();
				return false;
			}
			if(document.getElementsByName(v_2)[0].value.replace(/\s+$|^\s+/g,"")==""){
				showMessage1(title_2+"不能为空!");
				bool = false;
				document.getElementById(v_2).focus();
				return false;
			}
			var s = document.getElementsByName(v_2)[0].value;
			if(onlyNumbers1(s)){
				document.getElementById(v_2).focus();
				return false;
			}
			if(!check()){
				return false;
			}
			$.ajax({
				type:"post",
				data:$('#myform').serialize(),
				url:'${contextPath}/riskManagement/knowledgeBase/riskTemplate/saveType.action?selectedTab=<%=request.getParameter("selectedTab")%>',
				async:false,
				success:function(){
					showMessage1('保存成功！');
				}
			});
		}
    </script>
</head>
<body class="easyui-layout" border="0">
	<div region="north" border="0" style="height:180px; overflow:auto;">
		<s:form id="myform" onsubmit="return true;" action="/ais/riskManagement/knowledgeBase/riskTemplate" method="post">
			<table cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
				<tr>
					<td class="EditHead" style="width: 20%">
						<font color="red">*</font>&nbsp;编号
					</td>
					<td class="editTd" colspan="3">
						<s:textfield cssClass="noborder" name="riskTaskTemplate.taskCode" id="riskTaskTemplate.taskCode" readonly="true"/>
					</td>
				</tr>
				<tr>
					<td class="EditHead">
						<font color="red">*</font>&nbsp;名称
					</td>
					<td class="editTd" colspan=3>
						<s:textfield cssClass="noborder" name="riskTaskTemplate.taskName" id="riskTaskTemplate.taskName"/>
					</td>
				</tr>
				<tr style='display:none;'>
					<td class="EditHead">
						<font color="red">*</font>&nbsp;事项序号
					</td>
					<td class="editTd" colspan="4">
						<s:textfield name="riskTaskTemplate.taskOrder" cssClass="noborder" maxlength="10" cssStyle='width:150px;'/>
					</td>
				</tr>
				<tr>
					<td class="EditHead">
						描述
					</td>
					<td class="editTd" colspan="4">
						<s:textarea cssClass="noborder" id="riskDescription" name="riskTaskTemplate.riskDescription" cssStyle="width:100%;overflow-y:hidden"/>
					</td>
				</tr>
			</table>
			<s:hidden name="riskTaskTemplate.taskId" />
			<s:hidden name="riskTaskTemplate.templateId" />
			<s:hidden name="riskTaskTemplate.taskPid" />
			<s:hidden name="riskTaskTemplate.taskPcode" />
			<s:hidden name="riskTaskTemplate.template_type" value="1" />
			<s:hidden name="templateId" />
			<s:hidden name="taskId" />
			<s:hidden name="type" />
			<s:hidden name="pro_id" />
			<s:hidden name="path" />
			<s:hidden name="node" />
		</s:form>
		<div style="text-align:right;padding:8px 8px 0 0;">
			<%--  <s:if test="'1' == '${detail}'">
				<input type="button" value="增加详细内容" onclick="generateLeaf();"
					title="增加下级节点后不能再增加详细内容" disabled="true" />
			</s:if>
			<s:else>
				<input type="button" value="增加详细内容" onclick="generateLeaf();"
					title="增加下级节点后不能再增加详细内容" />
			</s:else>  --%>
			<s:if test="${isView != 'Y'}">
				<a class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="generateType();">增加类别</a>
				<a class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="generateLeaf2();">增加事项</a>
				<a class="easyui-linkbutton" data-options="iconCls:'icon-delete'" onclick="deleteRecord();">删除类别</a>
				<a class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="saveFormLeaf();">保存</a>
			</s:if>
		</div>
	</div>
	<div region="center" border="0">
		<table id="listTaskDiv" ></table>
	</div>
	<div id="addType_div" ></div>
	<div id="addLeaf_div" ></div>
</body>
	<script>
	 	$(function(){
	 		showWin('addType_div','增加风险类别');
	 		showWin('addLeaf_div','增加风险事项');
			// 初始化生成表格
			$('#listTaskDiv').datagrid({
				url : "<%=request.getContextPath()%>/riskManagement/knowledgeBase/riskTemplate/showContentTypeViewByUi.action?taskId=${taskId}",
				method:'post',
				showFooter:false,
				rownumbers:true,
				pagination: false,
				striped:true,
				autoRowHeight:false,
				fit: true,
				fitColumns: false,
				idField:'taskId',	
				border:false,
				singleSelect:true,
				remoteSort: false,
				frozenColumns:[[
					{field:'riskDivision',
						title:'风险大类',
						width:'15%',
						halign:'center',
						align:'center', 
						sortable:true
					}, 
					{field:'riskClass',
						title:'风险子类',
						width:'15%',
						sortable:true, 
						align:'center'
					},
					{field:'taskName',
						title:'风险事项',
						width:'15%', 
						align:'center', 
						sortable:true
						}
				]],
				columns:[[  
					
					{field:'affiliatedDeptName',
						title:'所属单位',
						width:'20%', 
						align:'left', 
						sortable:true
					},
					{field:'majorDutyDeptName',
						title:'主责部门',
						width:'20%', 
						align:'left', 
						sortable:false
					},
					{field:'riskDescription',
						title:'风险描述',
						width:'20%', 
						align:'left', 
						sortable:false
					}/* ,
					{field:'liveStateName',
						title:'启用状态',
						width:'10%', 
						align:'left', 
						sortable:false
					}
					,
					{field:'operate',
						title:'操作',
						width:'150px', 
						align:'center', 
						sortable:false
					} */
				]]   
			}); 
		});
	</script>
</html>
