<%@page language="java" pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@taglib prefix="s" uri="/struts-tags"%>
<html>
	<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
	<title>实施方案</title>
	<script type="text/javascript">	
	//---ext----定义开始-----
	Ext.onReady(function(){
		var t=new Usp.Tab({
	  		tabConfig:{id:'common-data-dataframe-tab'}
	  	});
	  	//在左侧打开了两个页签，并且默认设置总体方案是当前页签
	  	t.openTab({
		  	id:'common-data-dataframe-tab1',
		  	isFrame:true,
		  	autoHeight:false,
		  	height:Ext.getBody().getHeight()-90,
		  	title:'总体方案',
		  	closable:false,
		  	actionUrl:'${pageContext.request.contextPath}/operate/taskExt/taskDetailListUi.action?permission=<%=request.getParameter("permission")%>&isView=<%=request.getParameter("isView")%>&project_id=<%=request.getParameter("project_id")%>&audTemplateId=<%=request.getParameter("audTemplateId")%>'
	  	});
	  	t.openTab({
		  	id:'common-data-dataframe-tab2',//id
		  	title:'审计事项',
		  	height:Ext.getBody().getHeight()-90,
		  	autoHeight:false,
		  	closable:false,
		  	actionUrl:'${pageContext.request.contextPath}/operate/task/project/showContentTypeView.action?coll=0&taskTemplateId=null&taskId=null&taskPid=null&permission=<%=request.getParameter("permission")%>&isView=<%=request.getParameter("isView")%>&project_id=<%=request.getParameter("project_id")%>'
	  	});
	  	
		var workPanel=new Usp.WorkPanel({
						hasLeft:true,
						leftConfig:{width:240},
						mainConfig:{id:'common-data-dataframe-main'}
						});
		workPanel.main.add(t.getTabPanel());
	    workPanel.wp.render('common-data-dataframe');
	    workPanel.left.loadUrl({url:'${pageContext.request.contextPath}/operate/taskExt/taskUi.action?permission=<%=request.getParameter("permission")%>&isView=<%=request.getParameter("isView")%>&project_id=<%=request.getParameter("project_id")%>'});
	   	t.getTabPanel().setActiveTab('common-data-dataframe-tab1');//默认当前页签
	  });
	 //---ext----定义结束----
	 
	  //执行，打开底稿
	  function digao(project_id,taskId,taskPid,sq,isView,isPem){
	         Usp.doTabPanel({
			     height:Ext.getBody().getHeight()-98, 
		         id:'common-data-dataframe-tab3',
		         pid:'common-data-dataframe-tab',
		         title:'审计底稿',
		         url:'${pageContext.request.contextPath}/operate/manuExt/manuUi.action',
		         params:{project_id:project_id,taskId:taskId,taskPid:taskPid,sq:sq,isView:isView,permission:isPem},
		         refresh:true
	         });
	     }
	    
	    //执行，打开疑点     
	    function yidian(project_id,taskId,taskPid,sq,isView,isPem){
	           Usp.doTabPanel({
		       height:Ext.getBody().getHeight()-88,
	           id:'common-data-dataframe-tab4',
	           pid:'common-data-dataframe-tab',
	           title:'审计疑点',
	           url:'${pageContext.request.contextPath}/operate/doubtExt/doubtUi.action',
	           params:{project_id:project_id,taskId:taskId,taskPid:taskPid,sq:sq,isView:isView,permission:isPem},
	           refresh:true
	         });
	     }

      //审计事项下“执行”链接对应的方法，点击打开审计问题页签
	       function auditProblem(project_id,taskId,taskPid,sq,isView,isPem){
		       
		           Usp.doTabPanel({
			       height:Ext.getBody().getHeight()-88,
		           id:'common-data-dataframe-tab5',
		           pid:'common-data-dataframe-tab',
		           title:'审计问题',
		           url:'${pageContext.request.contextPath}/proledger/problem/oprLedgerProlemUi.action',
		           params:{project_id:project_id,taskId:taskId,taskPid:taskPid,sq:sq,isView:isView,permission:isPem},
		          refresh:true
		         });
	      }
	</script>
	</head>
	<body>
	<div id='common-data-dataframe'/> 
	</body>
</html>