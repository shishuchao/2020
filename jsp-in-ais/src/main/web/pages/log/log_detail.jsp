<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>查看日志详情</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
	</head>
	<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout">
		<table cellpadding=0 cellspacing=0 border=0  align ="center" class="ListTable">
				<input type="hidden" id="onLine" name="onLine" value="${onLine}">
				<tr>
					<td class="EditHead" style="width:20%" align ="center">操作账号</td>
					<td  class="editTd" style="width:80%">
						${log2.loginname}
					</td>
				</tr>
				<tr>
					<td  class="EditHead" align ="center">报警级别</td>
					<td  class="editTd">
						普通操作
					</td>
				</tr>
				<tr>
 					<td  class="EditHead" align ="center">操作人员</td>
					<td  class="editTd">
						${log2.chiname}
					</td>
				</tr>
				<tr>
 					<td  class="EditHead" align ="center">组织机构</td>
					<td  class="editTd">
						${log2.orgName}
					</td>
				</tr>
				<tr>
					<td class="EditHead"  align ="center">功能模块</td>
					<td class="editTd" >
						${log2.module}
					</td>
				</tr>
				<tr>
					<td class="EditHead" align ="center">描述信息</td>
					<td class="editTd" >
						${log2.description}
					</td>
				</tr>
				<tr>
 					<td class="EditHead" align ="center">访问时间</td>
					<td class="editTd">
						<fmt:formatDate value="${log2.visittime}" pattern="yyyy-MM-dd HH:mm:ss"/> 
					</td>
				</tr>
				<tr>
 					<td class="EditHead" align ="center">IP地址</td>
					<td class="editTd">
						${log2.ip}
					</td>
				</tr>		
				<tr>
 					<td class="EditHead" align ="center">机器名</td>
					<td class="editTd">
						${log2.localName}
					</td>
				</tr>	
				<tr>
 					<td class="EditHead" align ="center">功能点</td>
					<td class="editTd">
						${log2.funPoint}
					</td>
				</tr>						
				<tr>
 					<td class="EditHead" >操作类型</td>
					<td class="editTd">
						${log2.oppType}
					</td>
				</tr>						
		</table>
			<br/>
	</body>
	
	<script type="text/javascript">

	</script>
</html>