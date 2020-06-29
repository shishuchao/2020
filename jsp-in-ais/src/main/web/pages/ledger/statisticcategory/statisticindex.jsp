<!DOCTYPE HTML>
<%@ page contentType="text/html; charset=utf-8" %>
<%@taglib prefix="s" uri="/struts-tags" %>
<HTML>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>统计类别库总页</title>
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
		<style type="text/css"> 
	 	</style>
	 	 <script type="text/javascript">
	      $(function(){
	    	  $('#treeMatter').tree({
    			 url:'/ais/ledger/problemledger/statisticRreeExpand.action',
    			 checkbox:false,
    			 animate:false,
    			 lines:true,
    			 dnd:false,
    			 onClick:function(node){
    				var state = node.state;
    				var id = node.id;
    				var src = '<%=request.getContextPath()%>/ledger/problemledger/statisticListFrame.action?view=<%=request.getParameter("view")%>&id=' + id;
                    $('#childBasefrm').attr('src',src);
    			}
    		 });
	      }); 
	      function reloadSelectedNode(node){
	    	if (!node) {
	    		var node = $('#treeMatter').tree('getSelected');
	    		var isLeaf = $('#treeMatter').tree('isLeaf',node.target);
	    		if(isLeaf){
	    			var node = $('#treeMatter').tree('getParent',node.target);
	    		}
		    	$('#treeMatter').tree('reload',node.target);
	    	}
	      }
	    </script>
	</head>
	<body class="easyui-layout" id="codenameLayout" fit="true" style="overflow:hidden;" border="0">
		<div region="west" border="0" style="width:300px;height:100%;overflow:hidden;padding-top:5px;bottom:10px" title="<%--<img  style='vertical-align: middle; cursor: hand;' onclick=$('img[alt=操作帮助]').trigger('click') src='/ais/images/portal/default/window/icon-question-new.gif' />&nbsp;--%>统计类别设置"  split="true">
		    <ul id="treeMatter" class='easyui-tree' border="0" style="height:100%;overflow:auto;"></ul>
	    </div>
	    <div region="center" border="0" style="overflow:hidden;" >
	    	<iframe id="childBasefrm" name="childBasefrm" style="overflow:hidden;" src="<%=request.getContextPath()%>/pages/ledger/statisticcategory/index.jsp" width="100%" height="100%" frameborder="0">
	    </div>
	    <table cellpadding=0 cellspacing=1 border=0 bgcolor="#409cce" class="ListTable" width="100%" align="center" style="display: none;">
			<tr class="listtablehead">
				<td colspan="5" align="left" class="edithead">
					<s:if test="${param.view eq 'yes'}">
						<s:property escape="false" value="@ais.framework.util.NavigationUtil@getNavigation('/ais/pages/ledger/statisticcategory/statisticindex.jsp?view=yes')"/>
					</s:if>
					<s:else>
						<s:property escape="false" value="@ais.framework.util.NavigationUtil@getNavigation('/ais/pages/ledger/statisticcategory/statisticindex.jsp')"/>
					</s:else>
				</td>
			</tr>
		</table>
	</body>
</HTML>
