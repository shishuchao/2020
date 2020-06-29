<!DOCTYPE HTML>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="s" uri="/struts-tags" %>
<HTML>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<TITLE> index </TITLE>
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>  
<script type="text/javascript">
  $(function(){
	  $('#zcfgTreeSelect').tree({   
			url:'<%=request.getContextPath()%>/basic/codename/codeTree.action?querySource=tree',
		    checkbox:false,
		    animate:false,
		    lines:true,
		    dnd:false,
		    onClick:function(node){
		    	var id = node.attributes;
		    	var code=node.parentId;
		    	var src ="";
		    	if(code=='1'|id=='1'|id=='0'){
		    		src='<%=request.getContextPath()%>/basic/codename/list2.action?codeHead.pid=' + node.id;
		    	} else {
		    		src='<%=request.getContextPath()%>/basic/codename/list.action?type='+code+'&codeHead.id='+node.id+'&codeHead.type='+node.desc+'&codeHead.level='+node.level;
		    	}
		    	//if(id == 3) return;/ais/system/omEdit.action?view=view&abf.ffunid=${ffunid}
		    
		    	childBasefrm.location.href=src;
		    }
		});
  });
</script>
	</head>
	<s:url id="url"  action="codeTree"  namespace="/basic/codename"/>
	<body class="easyui-layout" id="codenameLayout">
		<div style='display:none;'>
			<s:property escape="false" value="@ais.framework.util.NavigationUtil@getNavigation('/ais/pages/basic/codename_index.jsp')"/>
		</div>
		<div id="content" region='west' split='true' title="<%--<img  style='vertical-align: middle; cursor: hand;' onclick=$('img[alt=操作帮助]').trigger('click') src='/ais/images/portal/default/window/icon-question-new.gif' />&nbsp;--%>基础信息设置"  style='width:200px;height:500px;'>
			 <div id="content" style="overflow: auto;">
			    <br>
		    	<ul id='zcfgTreeSelect'  class='easyui-tree'></ul>
		    	<br>
			</div> 
  		</div>
	    <div region="center" style="overflow:hidden">
	    	<iframe name="childBasefrm" src="<%=request.getContextPath()%>/blank.jsp" width="100%" height="100%" frameborder="0"><!-- main --></iframe>
	    </div>
	</body>
</HTML>
