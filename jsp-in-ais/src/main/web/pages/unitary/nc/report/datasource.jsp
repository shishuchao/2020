<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>在线审计数据源</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		
				<script type="text/javascript" src="${contextPath}/scripts/ufaudTextLengthValidator.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
		
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
	<style type="text/css">
		.data_editor{
			readonly:true;
		}
	</style>
	<script type="text/javascript">
		var host="";
		var port="";
		var dbname="";
		var username="";
		var password="";
		$(document).ready(function(){
		$("#host").attr("disabled", true);
		$("#port").attr("disabled", true);
		$("#dbname").attr("disabled", true);
		$("#username").attr("disabled", true);
		$("#password").attr("disabled", true);
		$("#dbtype").attr("disabled", true);
		//$("#savedb").removeAttr("disabled");
		$("#savedb").attr("disabled", "disabled");
		});
	</script>
	</head>
	<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout">
		
		<s:form id="basicSettingForm" action="saveNCDataSource">
			<s:hidden name="ncDataSource.id" />
			<table id="basicSettingTable" cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
				<tr>
					<td class="EditHead" nowrap="nowrap">
						<font color=red>*</font>&nbsp;
						数据库IP地址
					</td>
					<td class="editTd">
						<s:textfield cssClass="noborder"  id="host" name="ncDataSource.host" cssStyle="width:160px;" maxlength="50" title="数据库IP地址" />
					</td>
					<td class="EditHead"  nowrap="nowrap">
						<font color=red>*</font>&nbsp;
						数据库端口
					</td>
					<td class="editTd">
						<s:textfield   cssClass="noborder" id="port" name="ncDataSource.port" disabled="false" cssStyle="width:160px;" maxlength="10" title="数据库端口" />
					</td>
				</tr>
				<tr>
					<td class="EditHead" nowrap="nowrap">
						<font color=red>*</font>&nbsp;
						数据库的类型
					</td>
					<td class="editTd">
					<select  name="ncDataSource.dbtype" class="easyui-combobox" id="dbtype" panelHeight='auto' disabled="true">
						<s:iterator value="#@java.util.LinkedHashMap@{'MySQL':'MySQL','Oracle':'Oracle','DB2':'DB2'}" id="str">
							<s:if test="${ncDataSource.dbtype==key}">
							<option selected="selected" value="${key}" >${value }</option>
							</s:if>
							<option value="${key}" >${value }</option>
						</s:iterator>
					</select>
					</td>
					<td class="EditHead" nowrap="nowrap">
						<font color=red>*</font>&nbsp;
						数据库名称
					</td>
					<td class="editTd">
						<s:textfield id="dbname"    cssClass="noborder"  name="ncDataSource.dbname" cssStyle="width:160px;" maxlength="30" title="数据库名称" />
					</td>
				</tr>
				<tr>
					<td class="EditHead" nowrap="nowrap">
						<font color=red>*</font>&nbsp;
						数据库用户名
					</td>
					<td class="editTd">
						<s:textfield id="username"  cssClass="noborder"   name="ncDataSource.username" cssStyle="width:160px;" maxlength="30" title="数据库用户名" />
					</td>
					<td class="EditHead" nowrap="nowrap">
						<font color=red>*</font>&nbsp;
						数据库密码
					</td>
					<td class="editTd">
						<s:textfield cssClass="noborder" id="password" name="ncDataSource.password" cssStyle="width:160px;" maxlength="30" title="数据库密码" />
					</td>
				</tr>
						
						<%--
						<s:button value="测试是否连通" onclick="testConn();" cssStyle="margin-right: 20px;"/>
						 --%>
			</table>
		</s:form>
		
			<div style="text-align:right;padding-right:20px;">
				<a id="savedb" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="toSave();" disabled="true">保存数据源参数</a>&nbsp;&nbsp;
				<a class="easyui-linkbutton" data-options="iconCls:'icon-edit'" onclick="toUpdate();">修改数据源参数</a>
			</div>
				
		<script type="text/javascript">
			function toUpdate(){
				$("#host").attr("disabled", false);
				$("#port").attr("disabled", false);
				$("#dbname").attr("disabled", false);
				$("#username").attr("disabled", false);
				$("#password").attr("disabled", false);
				$("#dbtype").combobox('enable'); 
				$("#savedb").linkbutton('enable'); 
				
				
			}
			function toSave(){
				var port = $("#port").val();
				var regex = /^[0-9]{4,5}$/;
				if(!regex.test(port) || port <= '1024' || port > '65535'){
					alert("输入端口号范围为：1024-65535之间");
					return false;
				}
				//form的id
				var basicSettingForm = document.getElementById('basicSettingForm');
				if(!frmCheck(basicSettingForm,'basicSettingTable')){
					return false;
				}
				
				basicSettingForm.submit();
				
			}
			
			function testConn(){
				
				
				
			}
		
		</script>
	</body>
</html>
