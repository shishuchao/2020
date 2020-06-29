<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="s" uri="/struts-tags" %>

<html>
	<head>
	  	<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
		<link href="<%=request.getContextPath()%>/resources/css/site.css" rel="stylesheet" type="text/css">
		<script language="Javascript">
			function RightGo(id,name){
				<s:url id="url"    action="getUserOwnList" namespace="/systemnew"/>
				var url='<s:text name="%{url}"/>';
				if(url.indexOf('?')!=-1)
					url=url+'&amp;';
				else
					url=url+'?';
	  			parent.main.location.href=url+'p_deptid='+id+'&amp;p_deptname='+encodeURIComponent(name);
			}
		</script>
	</head>
	<body>
		<div class="TreeView" id="configtree" Checkbox="0" SelectedColor="#FFFF00">
			<s:iterator value="#request.orgtree"  id="row">
				<s:if test="${row.orgType!='1' && orgtype=='1'}">
            		<p  title="<s:property value="fname"/>" sid="<s:property value="fid"/>"  pid="<s:property value="fpid"/>" ></p>
				</s:if>
				<s:else>
           			<p  title="<s:property value="fname"/>" sid="<s:property value="fid"/>" pid="<s:property value="fpid"/>" click="RightGo('<s:property value="fid"/>','<s:property value="fname"/>')"></p>
				</s:else>
			</s:iterator>
		</div>
		<br>
		<input type=hidden id="paranamevalue">
		<input type=hidden id="paraidvalue">
 		<div id="sellist" class="datalist" ondelrow="reCount()"></div>
	</body>
</html>