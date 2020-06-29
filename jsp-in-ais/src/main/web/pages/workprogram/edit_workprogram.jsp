<!DOCTYPE HTML>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>工作方案模板编辑</title>
		<s:head theme="ajax" />
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
		<link rel="stylesheet" type="text/css" href="${contextPath}/resources/csswin/subModal.css">
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
		<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
		<script language="javascript">
			function saveval(){
			    var projtype = document.getElementsByName("workprogram.projecttypeid")[0];
			    var childprojtype=document.getElementsByName("workprogram.projectchildtypeid")[0];
			    var programname=document.getElementsByName("workprogram.workprogramname")[0];
			    if(programname){
			        if(programname.value==""){
			            showMessage1("请填写工作方案模板的名称!");
			            return false;
			        }
			        if(programname.value.length>20){
			            showMessage1("您输入的工作方案模板名称的长度不能超过20个字!");
			            return false;
			        }
			    }
			    var pvalue="";
			    var cpvalue="";
			    var pname="";
			    var cpname="";
			    if(projtype){
			    	if(projtype.options.length>0){
			        	pvalue=projtype.options[projtype.selectedIndex].value;
			        	pname=projtype.options[projtype.selectedIndex].text;
			        }
			    }
			    if(childprojtype){
			    	if(childprojtype.options.length>0){
			    		cpvalue=childprojtype.options[childprojtype.selectedIndex].value;
			    		cpname=childprojtype.options[childprojtype.selectedIndex].text;
			    	}
			    }
			    var retmessage="";
			    DWREngine.setAsync(false);
				DWREngine.setAsync(false);
				DWRActionUtil.execute(
						{namespace: '/workprogram', action: 'listWorkProgramByProjType', executeResult: 'false'},
						{'wp_projtypeid': pvalue, 'wp_childprojtypeid': cpvalue, 'wpid': '<s:property value="workprogram.workprogramid"/>'},
						xxx
				);
			    function xxx(data){
			        retmessage=data['ret_message'];
			    } 
			    if(retmessage!="ok"){
			        if(cpname!=""){
			        	showMessage1("已经存在项目类别为【"+pname+"-"+cpname+"】的工作方案模板，请重新选择项目类别！");
			        }else{
			        	showMessage1("已经存在项目类别为【"+pname+"】的工作方案模板，请重新选择项目类别！");
			        }
			        
			        return false;
			    }else{
			        return true;
			    }
			}

			function submitF(){
				if (saveval()) {
					document.getElementById('workprogramForm').submit();
				}
				// top.$.messager.confirm('提示信息', '确定保存吗?', function (isSave) {
				// 	if (isSave) {
				// 		var boo = saveval();
				// 		if (!boo) {
				// 			return false;
				// 		}
				// 		document.getElementById('workprogramForm').submit();
				// 	}
				// });
			}
		</script>
	</head>
	<body style="overflow:hidden">
		<table cellpadding=0 cellspacing=1 border=0 
		    class="ListTable" width="100%" align="center">
		    <tr >
		        <td colspan="5" align="left" class="topTd">
		            <div style="display: inline;width:80%;">
		            <s:if test='#parameters.options[0]=="edit"'>
		           		 编辑工作方案模板
		            </s:if>
		             <s:if test='#parameters.options[0]=="add"'>
		            	添加工作方案模板
		            </s:if>
		            </div>
		        </td>
		    </tr>
		</table>
		<s:form id="workprogramForm" action="saveWorkProgram" namespace="/workprogram" onsubmit="return saveval()" method="post" >
			<s:hidden name="workprogram.workprogramid"/>
			<s:hidden name="workprogram.version"/>
			<table cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable" id="templateInfo">
				<tr>
					<td align="left" class="EditHead" style="width:10%;"><font color="red">*</font>&nbsp;模板名称</td>
					<td align="left" class="editTd" style="width:40%;">
						<s:textfield name="workprogram.workprogramname" cssStyle="width:160px;" title="工作方案模板名称" maxlength="255" cssClass="noborder"/>
					</td>
					<td align="left" class="EditHead">项目类别</td>
					<td align="left" class="editTd">
						<s:doubleselect id="pro_type" doubleId="pro_type_child" cssStyle="width:160px;"
							doubleList="projectTypeMap[top]" doubleListKey="code"
							doubleListValue="name" listKey="code" listValue="name"
							name="workprogram.projecttypeid" list="projectTypeMap.keySet()"
							doubleName="workprogram.projectchildtypeid" theme="ufaud_simple"
							templateDir="/strutsTemplate"/>
					</td>
				</tr>
				<tr>
					<td align="left" class="EditHead">创建人</td>
					<td align="left" class="editTd">
						<s:textfield name="workprogram.createman" readonly="true" cssStyle="width:160px;" title="创建人" maxlength="20" cssClass="noborder"/>
					</td>
					<td align="left" class="EditHead">创建日期</td>
					<td align="left" class="editTd">
					<s:textfield name="workprogram.createdate" readonly="true" cssStyle="width:160px;" title="创建日期" maxlength="255" cssClass="easyui-datebox noborder"/>
					</td>
				</tr>
				<tr>
					<td align=right  class="bottomTd" colspan="6">
					    <a class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="submitF()">保存并继续</a>&nbsp;&nbsp;
					    <a class="easyui-linkbutton" data-options="iconCls:'icon-undo'" onclick="history.back()">返回</a>
					</td>
				</tr>
			</table>
		</s:form>
	</body>
</html>