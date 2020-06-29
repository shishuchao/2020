<!DOCTYPE HTML>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>实施方案详细信息</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<!-- 引入dwr的js文件 -->
		<script type='text/javascript' src='/ais/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='/ais/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='/ais/dwr/engine.js'></script>
		<script type='text/javascript' src='/ais/dwr/util.js'></script>
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet" type="text/css">
		<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/pages/introcontrol/util/themes/default/easyui.css">
		<script type="text/javascript" src="<%=request.getContextPath()%>/pages/introcontrol/util/jquery-1.7.1.min.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/pages/introcontrol/util/jquery.easyui.min.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/pages/introcontrol/util/easyui-lang-zh_CN.js"></script>
		<s:head theme="ajax" />
	</head>

	<body class="easyui-layout">
		<div region="center" style="overflow:hidden;">
			<div class="easyui-tabs" fit="true">
				<s:if test="'-1' == '${type}'||'null' == '${type}'||'' == '${type}'"><!--根节点显示两个按钮 -->
					<div  id='main' title='审计分工' style="overflow:hidden;" <% if(StringUtils.isNotBlank(request.getParameter("selectedTab")) && request.getParameter("selectedTab").equals("main")){%> selected="true"<%} %>>
						<table class="ListTable">
							<tr align="center" class="listtablehead">
								<td  class="edithead">
									&nbsp; 请选择左侧审计方案节点
								</td>
	
							</tr>
						</table> 
						<div ALIGN="center">
							<input type="button" onclick="goGroup()" value="小组批量设置">&nbsp;&nbsp;
							<input type="button" onclick="goMember()" value=" 组员批量设置">
						</div>
					 </div>
				</s:if>
				<s:if test="'1' == '${type}'"><!--审计类别 -->
					<s:if test="'1' == '${team}'"><!--是一级节点，分配小组 -->
						<div id='item'  title='审计事项 ' style="overflow:hidden;" <% if(StringUtils.isNotBlank(request.getParameter("selectedTab")) && request.getParameter("selectedTab").equals("item")){%> selected="true"<%} %>>
							<iframe id="basefrm2"
								src="${contextPath}/operate/task/project/groupList.action?tree=true&selectedTab=item&node=<%=request.getParameter("node")%>&path=<%=request.getParameter("path")%>&type=<%=request.getParameter("type")%>&taskPid=<%=request.getParameter("taskPid")%>&taskTemplateId=<%=request.getParameter("taskId")%>&project_id=<%=request.getParameter("project_id")%>"
								frameborder="0" scrolling="yes" style="width:100%;height:100%;" onload="doAutoHeight2()"></iframe>
						</div>
					</s:if>
					<s:else><!--不是一级节点，分配人 -->
						<div id='item' title='审计事项'  style="overflow:hidden;" <% if(StringUtils.isNotBlank(request.getParameter("selectedTab")) && request.getParameter("selectedTab").equals("item")){%> selected="true"<%} %>>
							<iframe id="basefrm2"
								src="${contextPath}/operate/task/project/memberList.action?tree=true&selectedTab=item&node=<%=request.getParameter("node")%>&path=<%=request.getParameter("path")%>&type=<%=request.getParameter("type")%>&taskPid=<%=request.getParameter("taskPid")%>&taskTemplateId=<%=request.getParameter("taskId")%>&project_id=<%=request.getParameter("project_id")%>"
								frameborder="0" scrolling="yes" style="width:100%;height:100%;" onload="doAutoHeight2()"></iframe>
						</div>
					</s:else>
				</s:if>
				<s:if test="'2' == '${type}'"><!--审计事项 -->
					<div id='item' title='审计事项' style="overflow:hidden;" <% if(StringUtils.isNotBlank(request.getParameter("selectedTab")) && request.getParameter("selectedTab").equals("item")){%> selected="true"<%} %>>
						<iframe id="basefrm2"
							src="${contextPath}/operate/task/project/memberList.action?tree=true&selectedTab=item&node=<%=request.getParameter("node")%>&path=<%=request.getParameter("path")%>&type=<%=request.getParameter("type")%>&taskPid=<%=request.getParameter("taskPid")%>&taskTemplateId=<%=request.getParameter("taskId")%>&project_id=<%=request.getParameter("project_id")%>"
							frameborder="0" scrolling="yes" style="width:100%;height:100%;" onload="doAutoHeight2()"></iframe>
					</div>
				</s:if>
			</div>
		</div>
		
		<script language="javascript">
		//去小组批量分工
        function goGroup(){
	        var project_id='${project_id}';
	        DWREngine.setAsync(false);
			DWREngine.setVerb("POST");
			DWREngine.setAsync(false);DWRActionUtil.execute(
			{ namespace:'/operate/task/project', action:'canOperateTaskBatchGroup', httpMethod:'POST',executeResult:'false' }, 
			{'project_id':project_id,'group':'true'},xxx);
		     function xxx(data){
		     result =data['auth'];
	          // alert(data['auth']);
			} 
			if(result=='1'){
	        }else if(result=='2'){
	            /* alert("只有一个小组没必要小组批量分工!");
	            return false; */
	        }else{
	            alert("只有整体组的组长、副组长、项目负责人和主审有权操作！");
	            return false;
	          
	        }
	        window.top.location.href='/ais/operate/task/project/mainTaskBatchMember.action?project_id=<%=request.getParameter("project_id")%>&gm=1';
    	}		
        //去组员批量分工
     	function goMember(){
	       	var project_id='${project_id}';
	        DWREngine.setAsync(false);
			DWREngine.setVerb("POST");
			DWREngine.setAsync(false);DWRActionUtil.execute(
			{ namespace:'/operate/task/project', action:'canOperateTaskBatchGroup', httpMethod:'POST',executeResult:'false' }, 
			{'project_id':project_id,'group':'false'},xxx);
		     function xxx(data){
		     result =data['auth'];
	           //alert(data['auth']);
			} 
			
			if(result=='1'){
	        }else{
	            alert("只有组长、副组长、项目负责人和主审有权操作！");
	            return false;
	          
	        }
	     	 window.top.location.href='/ais/operate/task/project/mainTaskBatchMember.action?project_id=<%=request.getParameter("project_id")%>&gm=2';
   		}
		
		
    //设置高度		
	function doAutoHeight1() {
	  if(document.body.clientHeight>165)
      document.all.basefrm1.style.height = document.body.clientHeight-60;
    }
    //设置高度
	function doAutoHeight2() {
	  if(document.body.clientHeight>165)
      document.all.basefrm2.style.height = document.body.clientHeight-60;
    }
    
    //设置高度
   <s:if test="'enabled' == '${shenjichengxu}'">
	function doAutoHeight3() {
	  if(document.body.clientHeight>165)
      document.all.basefrm3.style.height = document.body.clientHeight-60;
    }
 </s:if>
</script>
	</body>
</html>
