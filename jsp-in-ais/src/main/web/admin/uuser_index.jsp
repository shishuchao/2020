<!DOCTYPE HTML>
<%@ page contentType="text/html; charset=utf-8" %>
<%@taglib prefix="s" uri="/struts-tags" %>
<HTML>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<TITLE> index </TITLE>
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>  
<%--
		<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
--%>
<script type="text/javascript">
  $(function(){
	  $('#zcfgTreeSelect').tree({   
			url:'<%=request.getContextPath()%>/admin/asyUorg4User.action?querySource=tree',
		    checkbox:false,
		    animate:false,
		    lines:true,
		    dnd:false,
		    onClick:function(node){
			    var id=node.id;
			   	childBasefrm.location.href='/ais/admin/listUUser.action?view=${view}&fdepid='+id;
		    }
		});
  });
</script>
	</head>
	<body class="easyui-layout" id="codenameLayout">
       <div id="content" region='west' split='true' title="<%--<img  style='vertical-align: middle; cursor: hand;' onclick=$('img[alt=操作帮助]').trigger('click') src='/ais/images/portal/default/window/icon-question-new.gif' />&nbsp;--%>系统用户" style='width:280px;height:500px;'>
			 <div id="content" style="overflow: auto;">
			    <br>
		    	<ul id='zcfgTreeSelect' class='easyui-tree'></ul>
		    	<br>
			</div> 
		 </div>
	    <div region="center" style="overflow:hidden" >
	    		<iframe name="childBasefrm"  width="100%" height="100%"  frameborder="0">main</iframe>
	    </div>
	</body>

</HTML>
