<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<s:text id="title" name="'添加流程定义'"></s:text>
<html>
	<head><meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title><s:property value="#title" />
		</title>
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet"
			type="text/css">
			
			
			
<script type="text/javascript">
function del(nobpm_id){
//alert(nobpm_id);
var  define_id = '<s:property  value="noBpmDefinition.id"/>';
var url = "${contextPath}/bpm/definition/nobpm/deleteController.action?nobpm_id="+nobpm_id+"&&noBpmDefinition.id="+define_id;
//alert(url)
window.location = url;
}
		</script>
	</head>

	<body>
		<center>
			<s:form action="saveController" theme="simple">
				<table cellpadding=1 cellspacing=1 border=0 bgcolor="#409cce"
					class="ListTable">
					<tr>
						<td class="listtabletr1">
							字段编码
						</td>
						<td class="listtabletr2">
							字段名称
						</td>
						<td class="listtabletr2">
							操作
						</td>
						
					</tr>
					<s:iterator value="noBpmFormControllerList" status="index">
						<tr>
							<td class="listtabletr1">
								<s:property value="%{code}" />
								<s:hidden name="noBpmFormControllerList[%{#index.index}].code"
									value="%{code}"></s:hidden>
							</td>
							<td class="listtabletr1">
								<s:property value="%{name}" />
								<s:hidden name="noBpmFormControllerList[%{#index.index}].name"
									value="%{name}"></s:hidden>
							</td>
							<td class="listtabletr1">
							  <a href="javascript:void(0);" onclick="del('${id}')" >删除</a>
							</td>
						</tr>
					</s:iterator>
				</table>
				<s:hidden name="noBpmDefinition.id" />
				<s:submit value="保存" />
				<input type="button" name="back" value="返回"
					onclick="javascript:window.location='<s:url action="list" includeParams="none"></s:url>'">
			</s:form>
		</center>

	</body>
</html>
