<%@page language="java" pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@taglib prefix="s" uri="/struts-tags"%>
<html>
	<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
	<title>我的事项</title>
	<link rel="stylesheet" type="text/css"
			href="${pageContext.request.contextPath}/cloud/styles/extjs/resources/css/ext-all.css" />
		<link rel="stylesheet" type="text/css"
			href="${pageContext.request.contextPath}/cloud/styles/extjs/examples/ux/css/ux-all.css" />
		<link rel="stylesheet" type="text/css"
			href="${pageContext.request.contextPath}/cloud/styles/css/common.css" />
		<link rel="stylesheet" type="text/css"
			href="${pageContext.request.contextPath}/cloud/styles/css/color-blue.css" />
		<script type="text/javascript"
			src="${pageContext.request.contextPath}/cloud/styles/extjs/adapter/jquery/jquery.js"></script>
		<script type="text/javascript"
			src="${pageContext.request.contextPath}/cloud/styles/extjs/adapter/jquery/ext-jquery-adapter.js"></script>
		<script type="text/javascript"
			src="${pageContext.request.contextPath}/cloud/styles/extjs/ext-all.js"></script>
		<script type="text/javascript"
			src="${pageContext.request.contextPath}/cloud/styles/extjs/examples/ux/StatusBar.js"> </script>
		<script type="text/javascript"
			src="${pageContext.request.contextPath}/cloud/styles/extjs/examples/ux/ColumnNodeUI.js"> </script>
		<script type="text/javascript"
			src="${pageContext.request.contextPath}/cloud/styles/extjs/examples/ux/GroupTabPanel.js"> </script>
		<script type="text/javascript"
			src="${pageContext.request.contextPath}/cloud/styles/extjs/examples/ux/GroupTab.js"> </script>
		<script type="text/javascript"
			src="${pageContext.request.contextPath}/cloud/styles/extjs/locale/ext-lang-zh_CN.js"></script>
		<script type="text/javascript"
			src="${pageContext.request.contextPath}/cloud/styles/js/main.js"></script>
		<script type="text/javascript"
			src="${pageContext.request.contextPath}/cloud/styles/js/ui.js"></script>
		<link rel="stylesheet" type="text/css"
			href="/ais/scripts/portal/tree/column-tree.css" />
		<link
			href="${pageContext.request.contextPath}/resources/csswin/subModal.css"
			rel="stylesheet" type="text/css" />
		<!-- 引入dwr的js文件 -->
		<script type="text/javascript"
			src="${pageContext.request.contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript"
			src="${pageContext.request.contextPath}/resources/csswin/subModal.js"></script>
		<!-- 引入dwr的js文件 -->
		<script type='text/javascript' src='/ais/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='/ais/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='/ais/dwr/engine.js'></script>
		<script type='text/javascript' src='/ais/dwr/util.js'></script>

		<style type="text/css">
		textarea { /** auto break line */
			word-wrap: break-word;
			word-break: break-all;
		}
		
		.EditHead {
			background-image: url(../../images/ais/bg1a.jpg);
			background-repeat: repeat;
			height: 26px;
			text-align: left;
			vertical-align: middle;
			font-size: 12px;
			font-family: "simsun";
			font-weight: bold;
			color: #007FFF;
			background-repeat: repeat;
		}
		
		.ListTable {
			background-color: #7CA4E9;
			font-size: 12px;
			border: 0px;
			width: 97%;
			margin: 0px;
		}
		
		.ListTable2 {
			font-size: 12px;
			border: 0px;
			width: 97%;
			margin: 0px;
		}
		
		.ListTableTr1 {
			BACKGROUND-COLOR: #F5F5F5;
			height: 22;
			vertical-align: middle;;
		}
		
		.ListTableTr2 {
			BACKGROUND-COLOR: #ffffff;
			height: 20;
			padding-left: 5px;
		}
		
		.ListTableTr22 {
			BACKGROUND-COLOR: #ffffff;
			width: 35%;
			height: 20;
			padding-left: 5px;
		}
		
		.ListTableTr3 {
			BACKGROUND-COLOR: #ffffff;
			height: 20;
			padding-left: 5px;
		}
		
		.titletable1 {
			background-color: #EEF7FF;
			height: 21;
		}
		</style>
			<script type="text/javascript">	
		<%
		String owner = "-owner";
		%>

    	//-------------ext--------开始-----
		Ext.onReady(function(){
		    var t=new Usp.Tab({
		  		tabConfig:{id:'common-data-dataframe-tab<%=owner%>'}//tab容器的id
		  	});
		  
		  	t.openTab({//在tab容器里打开一个tab，并且给tab定义了一个id，就是右侧的“审计事项”
			  	id:'common-data-dataframe-tab2<%=owner%>',
			  	title:'审计事项',
			  	isFrame:true,
			  	height:Ext.getBody().getHeight()-panleHeight,
			  	autoHeight:false,
			  	closable:false,
			  	actionUrl:'${url}'//action的mainOwnerTaskUi方法定义
		  	});
		  	
		  	//tab里面的工作面板定义，并且给工作面板定义了一个id
		    var workPanel2=new Usp.WorkPanel({
			    hasLeft:true,
				leftConfig:{width:'32%'},
				mainConfig:{id:'common-data-dataframe-main<%=owner%>'}
			});
		
			workPanel2.main.add(t.getTabPanel());//加入前面定义的tab容器
		    workPanel2.wp.render('common-data-dataframe<%=owner%>');//渲染的div的id
		    //左侧树，“我的任务”是一个grid
		    workPanel2.left.loadUrl({url:'${pageContext.request.contextPath}/operate/taskExt/myTaskUiOwner.action?owner=true&permission=<%=request.getParameter("permission")%>&isView=<%=request.getParameter("isView")%>&project_id=<%=request.getParameter("project_id")%>'});
		    //设置当前tab
		    t.getTabPanel().setActiveTab('common-data-dataframe-tab2<%=owner%>');
		});
		//-------------ext--------结束----
	
	
	

        //左侧实施方案页签下使用的方法    
        //审计事项下“执行”链接对应的方法，点击打开底稿页签
		function digao(project_id,taskId,taskPid,sq,isView,isPem){
	         Usp.doTabPanel({
		     height:Ext.getBody().getHeight()-panleHeight, 
		     isFrame:true,
	         id:'common-data-dataframe-tab3',
	         pid:'common-data-dataframe-tab',
	         title:'审计底稿',
	         url:'${pageContext.request.contextPath}/operate/manuExt/manuUi.action',
	           params:{project_id:project_id,taskId:taskId,taskPid:taskPid,sq:sq,isView:isView,permission:isPem},
	         refresh:true
	         });
         }
		
		 function doOpenMyTab(url,id,pid,title){
			 Usp.doTabPanel({
		       		height:Ext.getBody().getHeight()-panleHeight,
	           		id:id,
	           		pid:pid,
	           		title:title,
	           		url:url,
		         	refresh:true
		        });
		 }
         //左侧我的任务页签下使用的方法 
         //审计事项下“执行”链接对应的方法，点击打开底稿页签
         function digaoOwner(project_id,taskId,taskPid,sq,isView,isPem,isOwner,groupCode){
			   var ownerStr='';
			   if(isOwner=='true'){
			    	ownerStr='-owner'
		  		}
          		Usp.doTabPanel({
		       		height:Ext.getBody().getHeight()-panleHeight,
	           		id:'common-data-dataframe-tab3-owner',
	           		pid:'common-data-dataframe-tab-owner',
	           		title:'审计底稿',
	           		url:'${pageContext.request.contextPath}/operate/manuExt/manuUiOwner.action',
	           		params:{groupCode:groupCode,project_id:project_id,taskId:taskId,taskPid:taskPid,sq:sq,isView:isView,permission:isPem,owner:isOwner},
		         	refresh:true
		        });
         }
          //左侧实施方案页签下使用的方法 
          //审计事项下“执行”链接对应的方法，点击打开疑点页签
          function yidian(project_id,taskId,taskPid,sq,isView,isPem){
	           Usp.doTabPanel({
		       height:Ext.getBody().getHeight()-panleHeight,
	           id:'common-data-dataframe-tab4',
	           pid:'common-data-dataframe-tab',
	           title:'审计疑点',
	           url:'${pageContext.request.contextPath}/operate/doubtExt/doubtUi.action',
	           params:{project_id:project_id,taskId:taskId,taskPid:taskPid,sq:sq,isView:isView,permission:isPem},
	          refresh:true
	         });
         }
        //左侧我的任务页签下使用的方法 
          //审计事项下“执行”链接对应的方法，点击打开审计问题页签
        function yidianOwner(project_id,taskId,taskPid,sq,isView,isPem,isOwner,groupCode){
        
           var ownerStr='';
    		  if(isOwner=='true'){
    		    ownerStr='-owner'
    		  }
           Usp.doTabPanel({
    	       height:Ext.getBody().getHeight()-panleHeight,
            id:'common-data-dataframe-tab4'+ownerStr,
            pid:'common-data-dataframe-tab'+ownerStr,
            title:'审计疑点',
            url:'${pageContext.request.contextPath}/operate/doubtExt/doubtUiOwner.action',
            params:{groupCode:groupCode,project_id:project_id,taskId:taskId,taskPid:taskPid,sq:sq,isView:isView,permission:isPem,owner:isOwner},
           refresh:true
          });
          }
          
         //左侧我的任务页签下使用的方法 
         //审计事项下“执行”链接对应的方法，点击打开审计问题页签
       function auditProblemOwner(project_id,taskId,taskPid,isView,isPem,isOwner,groupCode){
    	  
          var ownerStr='';
		  if(isOwner=='true'){
		    ownerStr='-owner'
		  }
          Usp.doTabPanel({
	       height:Ext.getBody().getHeight()-panleHeight,
           id:'common-data-dataframe-tab5'+ownerStr,
           pid:'common-data-dataframe-tab'+ownerStr,
           title:'审计问题',
           url:'${pageContext.request.contextPath}/proledger/problem/oprLedgerProlemUi.action',
           params:{groupCode:groupCode,project_id:project_id,taskId:taskId,taskPid:taskPid,isView:isView,permission:isPem,owner:isOwner},
          refresh:true
         });
         }

       //左侧实施方案页签下使用的方法 
       //审计事项下“执行”链接对应的方法，点击打开审计问题页签
       function auditProblem(project_id,taskId,taskPid,isView,isPem){
    	  
	           Usp.doTabPanel({
		       height:Ext.getBody().getHeight()-panleHeight,
	           id:'common-data-dataframe-tab5',
	           pid:'common-data-dataframe-tab',
	           title:'审计问题',
	           url:'${pageContext.request.contextPath}/proledger/problem/oprLedgerProlemUi.action',
	           params:{project_id:project_id,taskId:taskId,taskPid:taskPid,isView:isView,permission:isPem},
	          refresh:true
	         });
      }
       
	</script>
	</head>
	<body style='overflow:hidden;'>
		<div id='common-data-dataframe<%=owner%>' style='overflow:hidden;'/>
	</body>
</html>