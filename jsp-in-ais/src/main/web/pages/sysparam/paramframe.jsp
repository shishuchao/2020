<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>  
		<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>	
		
		<script type="text/javascript">
		  $(function(){
			  $('#zcfgTreeSelect').tree({   
					url:'<%=request.getContextPath()%>/sysparam/sysParamAction!paramTree.action?querySource=tree',
				    checkbox:false,
				    animate:false,
				    lines:true,
				    dnd:false,
				    onClick:function(node){
				    	var id = node.parentId;
				    	//if(id == 3) return;/ais/system/omEdit.action?view=view&abf.ffunid=${ffunid}
				    	var src = '<%=request.getContextPath()%>/sysparam/sysParamAction!paramList.action?code=' + id;
		                $('#childBasefrm').attr('src',src);
				    }
				});
		  });
</script>
	</head>
	<body class="easyui-layout" id="codenameLayout">
		
		
		
		<s:url id="paramtree" action="sysParamAction" method="paramTree" namespace="/sysparam" />
		<div region="west" title="<%--<img  style='vertical-align: middle; cursor: hand;' onclick=$('img[alt=操作帮助]').trigger('click') src='/ais/images/portal/default/window/icon-question-new.gif' />&nbsp;--%>参数设置" style="width:200px;height: 100%" split="true">
	  		<div id="content" style="width: 100%;height: 100%">
				<!-- <iframe name="left" scrolling="auto" src="<s:text name="%{paramtree}"/>" width="100%" height="100%" frameborder="0" ></iframe> -->
			<ul id='zcfgTreeSelect' class='easyui-tree'></ul>
			</div> 
	    </div>
	    <div region="center" style="overflow:hidden;">
	    	<iframe name="childBasefrm" id="childBasefrm" style="overflow:hidden;" src="<%=request.getContextPath()%>/blank.jsp" width="100%" height="100%" frameborder="0"></iframe>      	
	    </div>
	</body>
	<%-- <body>
		
			<table cellpadding=0 cellspacing=1 border=0 bgcolor="#409cce"
				class="ListTable" width="100%" align="center">
				<tr class="listtablehead">
					<td colspan="4" class="edithead" style="text-align: left;width: 100%;">
						<s:property escape="false" value="@ais.framework.util.NavigationUtil@getNavigation('/ais/sysparam/sysParamAction!paramFrame.action')"/>
					</td>
				</tr>
			</table>
			
			<s:url id="paramtree" action="sysParamAction" method="paramTree" namespace="/sysparam" />
			<iframe name="left" scrolling="auto" src="<s:text name="%{paramtree}"/>" width="20%" height="95%" frameborder="0" ></iframe>
			<iframe name="childBasefrm" src="<%=request.getContextPath()%>/blank.jsp" width="80%" height="95%" frameborder="0"></iframe>
	</body> --%>
</html>
