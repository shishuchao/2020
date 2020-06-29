<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
<head><meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
<script type="text/javascript">
  $(function(){
	  $('#zcfgTreeSelect').tree({   
			url:'<%=request.getContextPath()%>/pages/assist/suport/lawsLib/treeMenu.action?querySource=tree&mCodeType=riskCase',
		    checkbox:false,
		    animate:false,
		    lines:true,
		    dnd:false,
		    onClick:function(node){
		    	var id = node.id;
		    	var src = '<%=request.getContextPath()%>/pages/assist/suport/lawsLib/editMenu.action?m_view=view&nodeid=' + id;
                $('#childBasefrm').attr('src',src);
		    }
		});
  });
</script>			

</head>
<div id="container" style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout" fit='true'>
  <div id="content" split='true' region='west' style='width:300px;' title="类别">
	<div style="overflow: auto;">
	    <br>
    	<ul id='zcfgTreeSelect' class='easyui-tree'></ul>
    	<br>
	</div>
  </div>
  <div id="sidebar" region='center' title='详细信息'>
  	<iframe id="childBasefrm" width="100%" frameborder="0" height="98%" scrolling="no" src="<%=request.getContextPath()%>/pages/assist/suport/lawsLib/tishi.jsp" ></iframe>
  </div>
</div>
</html>