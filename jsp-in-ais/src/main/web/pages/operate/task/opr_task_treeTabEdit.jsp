<%@page import="org.apache.commons.lang.StringUtils"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<!DOCTYPE HTML>
<html>
	<head><meta http-equiv="content-type" content="text/html; charset=UTF-8">
		
		<title>实施方案详细信息</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/styles/main/fr.css">
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
	</head>

	<body class="easyui-layout" border="0">
		<div region="center" border="0">
			<div id="tt" class="easyui-tabs" fit="true" border="0">
				<div id='main' title='总体方案' <% if(StringUtils.isNotBlank(request.getParameter("selectedTab")) && request.getParameter("selectedTab").equals("main")){%> selected="true"<%} %> style="overflow:hidden;">
					<iframe id="basefrm1"
						src="${contextPath}/operate/task/showContentRootEdit.action?interCtrl=${interCtrl}&selectedTab=main&node=<%=request.getParameter("node")%>&path=<%=request.getParameter("path")%>&project_id=<%=request.getParameter("project_id")%>&audTemplateId=<%=request.getParameter("audTemplateId")%>"
						frameborder="0"  style="width:100%;height:100%;"></iframe>
				</div>
				<s:if test="'1' == '${type}'">
					<div id='item' title='审计事项' <% if(StringUtils.isNotBlank(request.getParameter("selectedTab")) && request.getParameter("selectedTab").equals("item")){%> selected="true"<%} %> style="overflow:hidden;">
						<iframe id="basefrm2" name="basefrm2"
							src="${contextPath}/operate/task/showContentTypeEdit.action?selectedTab=item&node=<%=request.getParameter("node")%>&path=<%=request.getParameter("path")%>&type=<%=request.getParameter("type")%>&taskPid=<%=request.getParameter("taskPid")%>&taskTemplateId=<%=request.getParameter("taskId")%>&project_id=<%=request.getParameter("project_id")%>&fromAdjust=<%=request.getParameter("fromAdjust")%>"
							frameborder="0" scrolling="yes" style="width:100%;height:100%;"></iframe>
					</div>
				</s:if>
				<s:if test="'2' == '${type}'">
					<div id='item' title='审计事项' <% if(StringUtils.isNotBlank(request.getParameter("selectedTab")) && request.getParameter("selectedTab").equals("item")){%> selected="true"<%} %> style="overflow:hidden;">
						<iframe id="basefrm2" name="basefrm2"
							src="${contextPath}/operate/task/showContentLeafEdit.action?selectedTab=item&node=<%=request.getParameter("node")%>&path=<%=request.getParameter("path")%>&type=<%=request.getParameter("type")%>&taskPid=<%=request.getParameter("taskPid")%>&taskTemplateId=<%=request.getParameter("taskId")%>&project_id=<%=request.getParameter("project_id")%>&fromAdjust=<%=request.getParameter("fromAdjust")%>"
							frameborder="0" scrolling="yes" style="width:100%;height:100%;"></iframe>
					</div>
				</s:if>
				<s:if test="'enabled' == '${shenjichengxu}'">
					<div id='proc' title='审计程序' <% if(StringUtils.isNotBlank(request.getParameter("selectedTab")) && request.getParameter("selectedTab").equals("proc")){%> selected="true"<%} %> style="overflow:hidden;">
						<iframe id="basefrm3"
							src="${contextPath}/operate/task/showContentLeafEditList.action?selectedTab=proc&node=<%=request.getParameter("node")%>&&path=<%=request.getParameter("path")%>type=<%=request.getParameter("type")%>&taskPid=<%=request.getParameter("taskPid")%>&taskTemplateId=<%=request.getParameter("taskId")%>&project_id=<%=request.getParameter("project_id")%>"
							frameborder="0" scrolling="yes" style="width:100%;height:100%;"></iframe>
					</div>
				</s:if>
			</div>
		</div>
		
		<script language="javascript">
		//调用总体方案页面的保存方法
		function change(){
			$('#basefrm1')[0].contentWindow.saveFormRoot();
		};

        
        // 显示预览tab
        function showImportTaskView(ids){
            try{           	
            	var title = "审计事项导入预览";
            	if(!$('#tt').tabs('exists',title)){
	            	$('#tt').tabs('add',{
	            		title: title,
	            		selected: true,
	            		content:$('#importTaskViewGrid').html()
	            	});
            	}else{
            		$('#tt').tabs('select',title);
            	}
            	//alert('ids:\n'+ids);
            	var gridQueryParamJson = {'query_in_id':ids};
                // 更新基础查询参数basicGridParams，以后不管分页、搜索等，查询结果集都会限定在ids的范围内
            	taskviewGrid.setBasicGridParams(gridQueryParamJson);
				QUtil.loadGrid({
			        // 传入的查询参数； 可选
					param:gridQueryParamJson,
			        // 表格对象
			        gridObject:$('#importTaskViewGrid')
				});
            }catch(e){
                alert('showImportTaskView:'+e.message);
            }
        }
        
        function closeImportTaskView(){
            try{           	
            	var title = "审计事项导入预览";
            	$('#tt').tabs('exists',title) ? $('#tt').tabs('close',title) : null;
            }catch(e){
                alert('closeImportTaskView:'+e.message);
            }
        }

	function doAutoHeight1() {
	  if(document.body.clientHeight>165)
      document.all.basefrm1.style.height = document.body.clientHeight-60;
   }

	function doAutoHeight2() {
	  if(document.body.clientHeight>165)
      document.all.basefrm2.style.height = document.body.clientHeight-60;
    }
  <s:if test="'enabled' == '${shenjichengxu}'">
	function doAutoHeight3() {
	  if(document.body.clientHeight>165)
      document.all.basefrm3.style.height = document.body.clientHeight-60;
    }
 </s:if>
</script>
	</body>
</html>
