<%@page language="java" pageEncoding="UTF-8" contentType="text/html; charset=utf-8"%>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>审计实施控制</title>

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

		<script language="javascript">

 		Ext.onReady(function(){
 		// 整体布局
  
        //定义审计实施控制左侧tab页面的链接地址
	    var t1=new Usp.Tab();
	  	t1.openTab({
		  	//id:'common-data-dataframe-tab1',
		  	title:'实施方案',
		  	closable:false,
		  	actionUrl:'${pageContext.request.contextPath}/operate/taskExt/mainTaskUi.action?permission=<%=request.getParameter("permission")%>&isView=<%=request.getParameter("isView")%>&project_id=<%=request.getParameter("project_id")%>' 
	  	});
	  	//定义审计实施控制左侧tab页面的链接地址
	  	var t11=new Usp.Tab();
	  	t11.openTab({
		  	id:'common-data-dataframe-tab11',
		  	title:'我的任务',
		  	autoHeight:false,
		  	height:Ext.getBody().getHeight()-62,
		  	closable:false,
		  	actionUrl:'${pageContext.request.contextPath}/operate/taskExt/mainOwnerTaskUi.action?owner=true&permission=<%=request.getParameter("permission")%>&isView=<%=request.getParameter("isView")%>&project_id=<%=request.getParameter("project_id")%>' 
	  	});
	  	//定义审计实施控制左侧tab页面的链接地址
	    var t13=new Usp.Tab();
	  	t13.openTab({
		  	id:'common-data-dataframe-tab13',
		  	title:'审计分工',
		  	autoHeight:false,
		  	height:Ext.getBody().getHeight()-62,
		  	closable:false,
		  	actionUrl:'${pageContext.request.contextPath}/operate/task/project/showContentTypeWorkView.action?owner=true&permission=<%=request.getParameter("permission")%>&isView=<%=request.getParameter("isView")%>&project_id=<%=request.getParameter("project_id")%>' 
	  	});

	  	//定义审计实施控制左侧tab页面的项目问题统计链接地址
	    var t14=new Usp.Tab();
	  	t14.openTab({
		  	id:'common-data-dataframe-tab14',
		  	title:'项目问题统计',
		  	autoHeight:false,
		  	height:Ext.getBody().getHeight()-62,
		  	closable:false,
		  	actionUrl:'${pageContext.request.contextPath}/proledger/problem/oprProjectProlemUi.action?permission=<%=request.getParameter("permission")%>&isView=<%=request.getParameter("isView")%>&project_id=<%=request.getParameter("project_id")%>' 
	  	});
	  	
	    //定义审计实施控制左侧tab页面的链接地址
	  	var t2=new Usp.Tab({tabConfig:{id:'operate-index-tab'}});
	  	t2.openTab({
		  	id:'common-data-dataframe-tab12',
		  	title:'审计日记',
		  	autoHeight:false,
		  	height:Ext.getBody().getHeight()-62,
		  	closable:false,
		  	actionUrl:'${pageContext.request.contextPath}/operate/diaryExt/diaryList.action?permission=<%=request.getParameter("permission")%>&isView=<%=request.getParameter("isView")%>&project_id=<%=request.getParameter("project_id")%>'
	  	});
	  	
			  	//定义审计实施控制左侧tab页面的审计问题中间表链接地址
			    var t141=new Usp.Tab({tabConfig:{id:'problem-middle-tab'}});
			  	t141.openTab({
				  	id:'common-data-dataframe-tab141',
				  	//title:'整改问题一览表',
				  	title:'入报告问题',
				  	autoHeight:false,
				  	height:Ext.getBody().getHeight()-62,
				  	closable:false,
				  	actionUrl:'${pageContext.request.contextPath}/proledger/problem/projectProblemMiddleTab.action?permission=<%=request.getParameter("permission")%>&isView=<%=request.getParameter("isView")%>&project_id=<%=request.getParameter("project_id")%>' 
			  	});
	  	
	  	
	  	//审计实施控制左侧的tab定义
    	var gtab = new Ext.ux.GroupTabPanel({
    		activeGroup: 0,
    		//autoWidth:true,
    		//width:Ext.getBody().getWidth(),
    		//bodyStyle:'width:90%',
    		tabMargin:1,
    		tabWidth:30,
            region:'center',
            
            <%String permission=request.getParameter("permission");//权限参数，full 有全部权限
              String view=request.getParameter("isView");//查看项目用
              if("true".equals(view)){//如果是查看项目，只显示左侧“实施方案”和“审计分工”两个tab页签
            %>
            items: [
            {items: [{
    				title: '实<br>施<br>方<br>案',
    			    items:[t1.getTabPanel()]//打开上面tab的链接地址
    			}]
            },{
                items: [{
                    title: '审<br>计<br>分<br>工',
                    items:[t13.getTabPanel()]//打开上面tab的链接地址
                }]
            },{items: [{
				    title: '项<br>目<br>问<br>题<br>统<br>计',
			        items:[t14.getTabPanel()]//打开上面tab的链接地址
			    }]
              },{items: [{
					    title: '整<br>改<br>问<br>题<br>一<br>览<br>表',
				        items:[t141.getTabPanel()]//打开上面tab的链接地址
				       }]
		            }
            ]
            
            <%}else{%>
            items: [//全部显示3个页签
    		 {
                items: [{
                    title: '我<br>的<br>任<br>务',
                    items:[t11.getTabPanel()]//打开上面tab的链接地址
                }]
            },	{items: [{
    				title: '实<br>施<br>方<br>案',
    			    items:[t1.getTabPanel()]//打开上面tab的链接地址
    			}]
            },/*  {
                items: [{
                    title: '审<br>计<br>分<br>工',
                    items:[t13.getTabPanel()]//打开上面tab的链接地址
                }]
            } , */{items: [{
			    title: '项<br>目<br>问<br>题<br>统<br>计',
		        items:[t14.getTabPanel()]//打开上面tab的链接地址
		       }]
            },{items: [{
					    title: '整<br>改<br>问<br>题<br>一<br>览<br>表',
				        items:[t141.getTabPanel()]//打开上面tab的链接地址
				       }]
		            }
           ]
            <%}%>
    		
     });
   
   
	 Usp.main=gtab;
	 Usp.state=new Ext.Panel({
	 region:'south',
	   border:false,
	   contentEl:'usp_status',
	        layout: 'fit',
	        tbar: new Ext.ux.StatusBar({
	            defaultText: '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;项目名称：'+'${projectStartObject.project_name}'+'&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;当前用户：'+'${user.fname}',
	            id: 'statusbar'
	        })
	    });
	    
	    
	    
	 Usp.center=new Ext.Panel({
	   region:'center',
	   layout:'border',
	   border:false,
	   id:'usp_center',
	   items:[Usp.main,Usp.state]
	 });
 
 
	 Usp.viewport = new Ext.Viewport({
	        layout:'border',
	         border:false,
	         frame:false,
	         monitorResize:true,
	        items:[Usp.center] 
	  });
 	// 布局结束
	});

</script>
	</head>
	<body>
		<div id="usp_status"></div>
	</body>
</html>