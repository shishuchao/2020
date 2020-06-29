<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>  
<script type="text/javascript">
  $(function(){
	  $('#zcfgTreeSelect').tree({   
			url:'<%=request.getContextPath()%>/portal/simple/information/gardenPlotTree.action',
		    checkbox:false, 
		    animate:false,
		    lines:false,
		    dnd:false,
		    onClick:function(node){
			    var src='<%=request.getContextPath()%>/portal/simple/information/gardenPlotList.action?studyGardenPlot.parent_id='+node.id+'&studyGardenPlot.company_id=${user.fdepid}&view=${view}';
			    $('#childBasefrm').attr('src',src);
		    }
		});

	});
		
</script>
</head>
<table  class="ListTable" style="display: none;">
	<tr >
		<td align="left" class="EditHead">
			<div style="display: inline;width:80%;">
				<s:property escape="false"
					value="@ais.framework.util.NavigationUtil@getNavigation('/ais/portal/simple/information/gardenPlotMain.action')" />
			</div>
		</td>
	</tr>
</table>
<div id="container" class='easyui-layout' fit='true'>
  <div id="content" region='west' split='true'>
  
			<div id='content' region="west"  split="true" style='overflow:hidden;width:300px;height:500px;' 
				title="<%--<img  style='vertical-align: middle; cursor: hand;' onclick=$('img[alt=操作帮助]').trigger('click') src='/ais/images/portal/default/window/icon-question-new.gif' />&nbsp;--%>学习园地"
			
			 </div>
	 <div id="content" style="overflow: auto;">
	    <br>
    	<ul id='zcfgTreeSelect' class='easyui-tree'></ul>
    	<br>
	</div> 
  </div>
  <div id="sidebar" title="详细信息" region="center">
	<iframe id="childBasefrm" width="100%" frameborder="0" height="100%" name="childBasefrm"
		src="${contextPath}/blank.jsp"></iframe>
  </div>

</html>