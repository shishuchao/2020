<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/blue/ufaud.css">
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/displaytag/maven-base.css">
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/displaytag/maven-theme.css">
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/displaytag/site.css">
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/displaytag/screen.css">
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/displaytag/print.css">
		<script type="text/javascript" src="<%=request.getContextPath()%>/scripts/aisui.js"></script>
		
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
		<script language="javascript">
			function goBack(){
				history.go(-1);
			}
		</script>
	</head>
	<body class="easyui-layout">
		<s:form id="dataForm" action="sysParamAction!paramSave" method="post" namespace="/sysparam" theme="simple">		
				<table cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
				<tr >
					<td class="EditHead">
						<font color="red">*</font>&nbsp;参数编码
					</td>
					<td class="editTd">
						<s:textfield cssClass="noborder" name="sysParamDetail.fpcode" cssStyle="width: 300px;"/>
					</td>
				</tr>
				<tr >
					<td class="EditHead">
						<font color="red">*</font>&nbsp;参数名称
					<td class="editTd">
						<s:textfield cssClass="noborder" name="sysParamDetail.fpname" cssStyle="width: 300px;"/>
					</td>
				</tr>
				<tr >
					<td class="EditHead">
					参数值
					</td>
					<td class="editTd">
<%--					<s:textarea cssClass="noborder" cssStyle="height:60;" name="sysParamDetail.frealvalue" ></s:textarea>--%>
						<s:textfield cssClass="noborder" name="sysParamDetail.frealvalue" cssStyle="width: 300px;"/>
					</td>
					
				</tr>
				
				<tr >
					<td class="EditHead">
						参数范围
					</td>
					<td class="editTd">
						<s:textfield cssClass="noborder"  name="sysParamDetail.fvalidations" cssStyle="width: 100%;"/>
					</td>
				</tr>
				
				<tr >
					<td class="EditHead">
					默认值
					</td>
					<td class="editTd">
<%--					<s:textarea cssClass="noborder" cssStyle="height:60;" name="sysParamDetail.fdefaultvalue"></s:textarea>--%>
						<s:textfield cssClass="noborder" name="sysParamDetail.fdefaultvalue" cssStyle="width: 300px;"/>
					</td>
				</tr>
				<tr>
					<td class="EditHead">
						参数说明
					</td>
					<td class="editTd">
						<s:textfield  cssClass="noborder" name="sysParamDetail.fpdesc" cssStyle="width: 300px;"/>
					</td>
				</tr>
				<tr  >
					<td class="EditHead">
						编辑样式
					</td>
					<td class="editTd">
						<select class="easyui-combobox" editable='false' name="sysParamDetail.fstyle" style="width:150px;" >
						   			
						   	    <option value="">&nbsp;</option>
						      	 <s:iterator value="#@java.util.LinkedHashMap@{'input':'文本输入','item':'列表选项', 'checkbox':'复选框', 'date':'日期'}" id="status">
								<s:if test="${sysParamDetail.fstyle==key}">
						       	 <option selected="selected" value="<s:property value="key"/>"><s:property value="value"/></option>
						       	</s:if>
						       	<s:else>
						         <option value="<s:property value="key"/>"><s:property value="value"/></option>
								</s:else>
								
							      </s:iterator>

						    </select>
					</td>
				</tr>
				<tr >
					<td class="EditHead">
						参数类型
					</td>
					<td class="editTd">
				
				
				<select class="easyui-combobox" editable="fasle" name="sysParamDetail.fptype" style="width:150px;" >
						   			
						   	    <option value="">&nbsp;</option>
						      	 <s:iterator value='#@java.util.LinkedHashMap@{"I":"整数", "S":"字符", "D":"日期"}' id="status">
								<s:if test="${sysParamDetail.fptype==key}">
						       	 <option selected="selected" value="<s:property value="key"/>"><s:property value="value"/></option>
						       	</s:if>
						       	<s:else>
						         <option value="<s:property value="key"/>"><s:property value="value"/></option>
								</s:else>
								
							      </s:iterator>

						    </select>
					</td>
				</tr>
				<tr >
					<td class="EditHead">
						备注
					</td>
					<td class="editTd">
						<s:textfield cssClass="noborder" name="sysParamDetail.fnote" cssStyle="width: 300px;"/>
					</td>
				</tr>
			</table>
			<s:hidden name="sysParamDetail.fid" />
			<s:hidden name="sysParamDetail.fkid" />
			<table style="width: 97%; border: 0">
				<tr>
					<td>
						<span style="float: right;"> 
						<a class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="doSave();">保存</a>&nbsp;&nbsp;
						<a class="easyui-linkbutton" data-options="iconCls:'icon-undo'" name="add" onclick="goBack();">返回</a>&nbsp;&nbsp;
						</span>
					</td>
				</tr>
			</table>
		</s:form>	
		<script language="javascript">
			/*var aisUi=new AisUi({
			datas:"<s:property value="sysParamDetail.fvalidations"/>",
			tagvalue:"<s:property value="frealvalue"/>",
			tagid:"paramhtml",
			tagname:"sysParamDetail.frealvalue",
			tagstyle:"<s:property value="sysParamDetail.fstyle"/>"
			});
			aisUi.create();*/
			function doSave(){
				$.ajax({
					url:'${contextPath}/sysparam/sysParamAction!paramSave.action',
					type:'post',
					async:false,
					data:$('#dataForm').serialize(),
					success:function(data) {
						if(data == '1') {
							showMessage1('保存成功！');
						} else if(data == '2') {
							showMessage1('文件服务器配置错误，保存失败！');
						}
					}
				});
			}
			function doBack(){
				
			}					
		</script>	
	</body>
</html>
