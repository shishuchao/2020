<!DOCTYPE HTML>
<%@page language="java" pageEncoding="UTF-8" contentType="text/html; charset=utf-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@ page import="ais.sysparam.util.SysParamUtil"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>实施阶段_审计方案_审计事项</title>
		
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
		
		<link rel="stylesheet" type="text/css"
			href="/ais/scripts/portal/tree/column-tree.css" />
		<link href="${pageContext.request.contextPath}/resources/csswin/subModal.css"
			rel="stylesheet" type="text/css" />
		<!-- 引入dwr的js文件 -->
		<script type="text/javascript"
			src="${pageContext.request.contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript"
			src="${pageContext.request.contextPath}/resources/csswin/subModal.js"></script>	
	    <!-- 引入dwr的js文件 -->
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
			
		<style   type="text/css">    
		textarea {
			/** auto break line */
			word-wrap:break-word;word-break:break-all;
		}

		.divSim{
			display:block;
			width:100%;
			float:left;
			font-size: 12px;
	        font-family: "simsun";
	        font-weight: bold;
			padding:10px;

		}
		.divSim:after{
			/*content:"...";*/
			padding-left:3px;
			font-size:10px;
		}
		
		.td1{  
		    width:15%;  
		    word-break:keep-all;/* 不换行 */  
		    white-space:nowrap;/* 不换行 */  
		    overflow:hidden;/* 内容超出宽度时隐藏超出部分的内容 */  
		    text-overflow:ellipsis;/* 当对象内文本溢出时显示省略标记(...) ；需与overflow:hidden;一起使用*/  
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
			color: #000000;
			background-color: #ffffff;
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
		    white-space:nowrap;
			font-size:13px;
			color: #007FFF;
			font-weight:bolder;
			background: url("../../../images/ais/bg1a.jpg") repeat;
			height:27px;
		}
		
		 
		 
		
		.ListTableTr3 {
			BACKGROUND-COLOR: #ffffff;
			height: 20;
			padding-left: 5px;
		}
		
		.titletable1 {
			background-color: #ffffff;
			height: 21;
		}
		.ListTable22 {
			font-size: 12px;
			border: 0px;
			width: 97%;
			margin: 0px;
		}
	  	table.ListTable22 td{
			border: 1px solid #99bbe8;
			padding: 2px 5px 1px 5px;
		}
		
		
		#tasktable{
			border:1px solid #99bbe8;
			border-collapse:collapse;' 
		}
		#tasktable td{
			border:1px solid #99bbe8;
		}
		
        </style>
 
		 
       <script type="text/javascript">	
    	 /*
		  *  打开或关闭总体方案的内容
	      */
		function triggerSearchTable(divid){
			var isDisplay1 = document.getElementById(divid).style.display;
			if(isDisplay1==''){
				document.getElementById(divid).style.display='none';
			}else{
				document.getElementById(divid).style.display='';
        	}
        }
        
	    //打开疑点的查看页面		
	    function go2(s){
	  		window.open("${contextPath}/operate/doubt/view.action?type=YD&doubt_id="+s);
	    }
	   
		 //点“底稿执行“的事件	
		 function digao11(taskId,taskPid){
			var project_id='${audTask.project_id}';
			 var sq='sq';
			 var isView='<%=request.getParameter("isView")%>';//是否查看 true是
			 var isPem='<%=request.getParameter("permission")%>';//权限 full 不走小组授权
			 var isOwner='<%=request.getParameter("owner")%>';//是否在 “我的任务”页签打开
			 var groupCode='<%=request.getParameter("groupCode")%>';//小组
			 if(isOwner=='true'){//打开的是我的任务页签
			    parent.digaoOwner(project_id,taskId,taskPid,sq,isView,isPem,isOwner,groupCode);
			 }else{//打开的是实施方案页签
			    parent.digao(project_id,taskId,taskPid,sq,isView,isPem,isOwner,groupCode);
			 }
	          
          }
          
          //点“底稿执行“的事件
          function digao12(taskId,taskPid){
			  var project_id='${audTask.project_id}';
			  
			  var sq='sq';
			  var isView='<%=request.getParameter("isView")%>';
			  var isPem='<%=request.getParameter("permission")%>';
			  var isOwner='<%=request.getParameter("owner")%>';
			  var groupCode='<%=request.getParameter("groupCode")%>';
	           parent.digaoOwner(project_id,taskId,taskPid,sq,isView,isPem,isOwner,groupCode);
          }

          //点“疑点执行“的事件
          function yidian11(taskId,taskPid){
	          var project_id='${audTask.project_id}';
	          
			  var sq='sq';
			  var isView='<%=request.getParameter("isView")%>';
			  var isPem='<%=request.getParameter("permission")%>';
			  var isOwner='<%=request.getParameter("owner")%>';
			  var groupCode='<%=request.getParameter("groupCode")%>';
	           
	           if(isOwner=='true'){
			     parent.yidianOwner(project_id,taskId,taskPid,sq,isView,isPem,isOwner,groupCode);
			  }else{
			    parent.yidian(project_id,taskId,taskPid,sq,isView,isPem,groupCode);
			  }
          }
          //点“疑点执行“的事件
          function yidian12(taskId,taskPid){
	          var project_id='${audTask.project_id}';
			  var sq='sq';
			  var isView='<%=request.getParameter("isView")%>';
			  var isPem='<%=request.getParameter("permission")%>';
			  var isOwner='<%=request.getParameter("owner")%>';
			  var groupCode='<%=request.getParameter("groupCode")%>';
	           parent.yidianOwner(project_id,taskId,taskPid,sq,isView,isPem,isOwner,groupCode);
          }

        //点“审计问题执行“的事件
          function ledgerProblem(taskId,taskPid){
	          var project_id='${audTask.project_id}';
			  var isView='<%=request.getParameter("isView")%>';
			  var isPem='<%=request.getParameter("permission")%>';
			  var isOwner='<%=request.getParameter("owner")%>';
			  var groupCode='<%=request.getParameter("groupCode")%>';
	           
	           if(isOwner=='true'){
	        	 parent.auditProblemOwner(project_id,taskId,taskPid,isView,isPem,isOwner,groupCode);
			  }else{
			     parent.auditProblem(project_id,taskId,taskPid,isView,isPem);
			  }
          }
         
          //分项小结的编辑
          function jielun(){
              var auth='0';
              DWREngine.setAsync(false);
			  DWREngine.setAsync(false);DWRActionUtil.execute(
			  { namespace:'/operate/task', action:'checkTaskAssign', executeResult:'false' }, 
				 {'project_id':'<%=request.getParameter("project_id")%>','taskTemplateId':'<%=request.getParameter("taskId")%>','taskPid':'<%=request.getParameter("taskPid")%>'},xxx);
			     function xxx(data){
				 auth =data['auth'];
			  } 
              if(auth=='0'){
	              alert("没有权限编辑！");
	              return false;  
               }
             var title="分项小结";
		     window.paramw = "模态窗口";
		     showPopWin('${contextPath}/operate/task/showContentEvaluation.action?node=<%=request.getParameter("taskTemplateId")%>&type=1&taskTemplateId=<%=request.getParameter("taskTemplateId")%>&project_id=<%=request.getParameter("project_id")%>',550,460,title);
		     var num=Math.random();
		     var rnm=Math.round(num*9000000000+1000000000);//随机参数清除模态窗口缓存
          }
         
          //审计事项table上的超链接，1是审计事项的类型分为1和2（末级）
          function task(s,q){
           if(s=='1'){
             window.open('${contextPath}/operate/task/showContentTypeView.action?node='+q+'&type=1&taskTemplateId='+q+'&project_id=<%=request.getParameter("project_id")%>');
           }else{
             window.open('${contextPath}/operate/task/showContentLeafView.action?node='+q+'&type=1&taskTemplateId='+q+'&project_id=<%=request.getParameter("project_id")%>');
           }
          
                
         }
         //分项小结的查看
         function jielunView(){
             var title="分项小结";
		     window.paramw = "模态窗口";
		     showPopWin('${contextPath}/operate/task/showContentEvaluationView.action?node=<%=request.getParameter("taskTemplateId")%>&type=1&taskTemplateId=<%=request.getParameter("taskTemplateId")%>&project_id=<%=request.getParameter("project_id")%>',550,460,title);
		     var num=Math.random();
		     var rnm=Math.round(num*9000000000+1000000000);//随机参数清除模态窗口缓存
         }
		 <%String right=request.getParameter("isView");%>
		 //增加底稿
		 function addOwnerFrameOwner(){
			 window.open("/ais/operate/manu/edit.action?owner=true&groupCode=<%=request.getParameter("groupCode")%>&project_id=<%=request.getParameter("project_id")%>&taskId=<%=request.getParameter("taskId")%>&taskPid=<%=request.getParameter("taskPid")%>&back=true");
  			/*if('<%=request.getParameter("taskId")%>'=='-1'){
    		  Usp.doTabLoad({url:'/ais/operate/manu/edit.action?owner=true&groupCode=<%=request.getParameter("groupCode")%>&project_id=<%=request.getParameter("project_id")%>&taskId=<%=request.getParameter("taskId")%>&taskPid=<%=request.getParameter("taskPid")%>',
				isFrame:true,
				tabId:'common-data-dataframe-tab',
                pid:'common-data-dataframe-tab1'});
  
  			  }else{
                var auth='0';
                DWREngine.setAsync(false);
				DWREngine.setAsync(false);DWRActionUtil.execute(
				{ namespace:'/operate/task', action:'checkTaskAssign', executeResult:'false' }, 
				{'project_id':'<%=request.getParameter("project_id")%>','taskTemplateId':'<%=request.getParameter("taskId")%>','taskPid':'<%=request.getParameter("taskPid")%>'},xxx);
			    function xxx(data){
					auth =data['auth'];
				} 
				   
				if(auth=='0'){
	 				alert("没有权限增加！");
	  				return false;  
				}
				if('<%=request.getParameter("taskPid")%>'=='-1'||'<%=request.getParameter("taskPid")%>'=='null'){
				 	alert('不能在根节点增加，请先选择事项节点！');
				 	return false;
				}
				var url = '/ais/operate/manu/edit.action?owner=true&groupCode=<%=request.getParameter("groupCode")%>&project_id=<%=request.getParameter("project_id")%>&taskId=<%=request.getParameter("taskId")%>&taskPid=<%=request.getParameter("taskPid")%>';
				parent.doOpenMyTab(url,'common-data-dataframe-tabAddDigao','common-data-dataframe-tab-owner','增加底稿')
				
			  }*/
		 }
		 //增加疑点
		function addDoubtFrameOwner(){
			window.open("/ais/operate/doubt/editDoubt.action?owner=true&groupCode=<%=request.getParameter("groupCode")%>&type=FX&project_id=<%=request.getParameter("project_id")%>&taskId=<%=request.getParameter("taskId")%>&taskPid=<%=request.getParameter("taskPid")%>");
		}
		 
 
    //-----------------ext开始--------------------------
    //-------------------------------------------------
    
    Ext.onReady(function(){
    	
    	jQuery('#oprwrap').css({
    		height:Ext.getBody().getHeight(),
            width:'100%',
    		overflow:'auto'
    	});
    	
        //不是末级的审计事项，要显示列表树！！！，html的table就不显示了
        if('${audTask.template_type}'!='2'){
	     
	    var path = "";
	    var nodeId="";
	    
	    var kuandu= (window.screen.width*0.18);//宽度
	    
	    //view
	    var viewModel=[{header:'<div style="text-align:center">事项名称</div>' ,dataIndex:'taskName',width:kuandu},{header:'<div style="text-align:center">底稿</div>',
	            width:kuandu,
	            dataIndex:'manu'},{header:'<div style="text-align:center">疑点</div>',
	            width:kuandu,
	            dataIndex:'doubt'},
	            {header:'<div style="text-align:center">审计问题</div>',
		           width:kuandu,
		           dataIndex:'ledger'}
	    			    
	    			   ];
	     //tree    			   
	     var tree = new Usp.ColumnTree({
	         		 expanded:false,
		 			 viewModel:viewModel,
		 			 dataUrl:'/ais/pages/operate/task/opr_task_tree_table.jsp', 
				     baseParams:{project_id:'<%=request.getParameter("project_id")%>',task:'-1',taskPid:'<%=request.getParameter("taskId")%>',userCode:'${user.floginname}'}
					 });
	      tree.getTreePanel().on('beforeload',function(node){
	    	tree.getTreePanel().loader.baseParams.taskPid=node.attributes.taskTemplateId;
	    	tree.getTreePanel().loader.baseParams.task='1';
	      });
	         
	      tree.getTreePanel().on('load',function(node){
	    	 if(node.attributes.taskTemplateId=='<%=request.getParameter("taskId")%>'){
	    	  	tree.getTreePanel().selectPath(node.getPath());
	    	 }
	    	 
	     });
	     
	 
	          
	               
	  	//显示树的面板
	    
	      var singlePanel=new Usp.SinglePanel();
	      singlePanel.main.add(tree.getTreePanel());
	      singlePanel.main.render('tree-ct');  
      }
    
    
	  /**v5.9新增功能邮件发送*/
      function sendMail(){
    	 var selectedRows = (gridDigao.getGridPanel()).getSelectionModel().getSelections(); 
         if(selectedRows.length==0){
             alert("请选择要发送的底稿!");
             return;
         }                     
         var str = "";
         for(i=0;i <selectedRows.length;i++){
                str += selectedRows[i].data.formId + ","; 
         }
         DWREngine.setAsync(false);
         DWREngine.setAsync(false);DWRActionUtil.execute(
        			{ namespace:'/operate/doubt', action:'generateEmailAttachments', executeResult:'false' }, 
        			{'manuIds':str},xxx);
        		     function xxx(data){
        		     	result =data['manuAttachmentIds'];
        		     	if(result!=null&&result!=''){
        		     		showPopWin('<%=request.getContextPath()%>/msg/sendMail.action?innerMsg.attachmentsId='+result,500,350,'发送邮件');
        		     	}
        			}
        
     }
	//增加疑点
	function addDoubtOwner(){
		if(isGoOn()){
			  return false;
		  }
	        addDoubtFrameOwner();
	}
	//增加底稿
	function addOwner(){
		if(isGoOn()){
			  return false;
		  }
		addOwnerFrameOwner();
	}
    //编辑疑点
	function editDoubtOwner(){
		if(isGoOn()){
			  return false;
		  }
	    	if(isSingle(gridDoubt.getGridPanel())){
	     		var doubt_author_code=gridDoubt.getFieldValue('doubt_author_code');
	      		var doubt_status=gridDoubt.getFieldValue('doubt_status');
	       		var doubt_id=gridDoubt.getFieldValue('doubt_id');
	     		/*if('${user.floginname}'==doubt_author_code){
			    }else{
			    	alert("没有权限修改！");
			    	return false;
			    }*/
		 	if('010'==doubt_status){
			   var checkCode='0';
	            DWREngine.setAsync(false);
		       DWREngine.setAsync(false);DWRActionUtil.execute(
		       { namespace:'/operate/doubt', action:'checkStatus', executeResult:'false' }, 
		       {'checkStatus':'010','doubt_id':doubt_id},xxx);
		       function xxx(data){
			      checkCode =data['checkCode'];
		       } 
		
		       if(checkCode=='1'){
		       
		       }else{
		           alert("不能修改,疑点已处理或已删除,请刷新数据后重新操作！");
			       return false;
		       }
			 }else{
			    alert("已处理状态不能修改！");
			 	return false;
			 }   	                  
	         if(isSingle(gridDoubt.getGridPanel())){
	              window.open("/ais/operate/doubt/editDoubt.action?owner=true&groupCode=<%=request.getParameter("groupCode")%>&type=FX&doubt_id="+doubt_id+"&project_id=<%=request.getParameter("project_id")%>&taskId=<%=request.getParameter("taskId")%>&taskPid=<%=request.getParameter("taskPid")%>");
	         }
	        }
     }
     //批量删除疑点
     function piliangDelDoubtOwner(){
         var selectedRows = (gridDoubt.getGridPanel()).getSelectionModel().getSelections(); 
                            
         var str = "";
         var myDoubt=new Array()
 
         if(selectedRows.length==1){//一条数据，走单独删除
            delDoubtOwner();
         }else{
           for(i=0;i <selectedRows.length;i++){
              
                var doubt_author_code = selectedRows[i].data.doubt_author_code;
		        var doubt_status = selectedRows[i].data.doubt_status;
		          
		      	
			  	var project_id = selectedRows[i].data.project_id;   
			  	 
      			var id = selectedRows[i].data.doubt_id; 
     			/*if('${user.floginname}'==doubt_author_code){
		    	}else{
		    		Ext.Msg.show({
	                    title: '', 
	                    msg: '所选取的疑点 ['+selectedRows[i].data.doubt_name+'] 没有权限删除！',
	                    icon: Ext.Msg.INFO,
	                    minWidth: 300,
	                    buttons: Ext.Msg.OK
                  	});
		    		return false;
				}*/
               
               if(selectedRows[i].data.doubt_status=='010'){
                  var checkCode='0';
           		  DWREngine.setAsync(false);
	       		  DWREngine.setAsync(false);DWRActionUtil.execute(
	      		  {namespace:'/operate/doubt', action:'checkStatus', executeResult:'false' }, 
	       		  {'checkStatus':'010','doubt_id':id},xxx);
	      		  function xxx(data){
		      		checkCode =data['checkCode'];
	       		 } 
	
	      		 if(checkCode=='1'){
	       
	      		 }else{
	           	   Ext.Msg.show({
                    title: '', 
                    msg: '所选取的疑点 ['+selectedRows[i].data.doubt_name+'] 不能删除,疑点已处理或已删除,请刷新数据后重新操作！',
                    icon: Ext.Msg.INFO,
                    minWidth: 300,
                    buttons: Ext.Msg.OK
                  	});
		       		return false;
	       		}
               }else{
                  Ext.Msg.show({
                    title: '', 
                    msg: '所选取的疑点 ['+selectedRows[i].data.doubt_name+'] 已处理状态不能删除!',
                    icon: Ext.Msg.INFO,
                    minWidth: 300,
                    buttons: Ext.Msg.OK
                });
                return false;
               }
                
           }
            for(i=0;i <selectedRows.length;i++){
               str += selectedRows[i].data.doubt_id + ","; 
               myDoubt[i]=selectedRows[i].data.doubt_id;
               var  j=i+1;
               var delTip='false';
               if(j==selectedRows.length){
                   Usp.doGridDel({
		       		component:gridDoubt,
		       		url:'${pageContext.request.contextPath}/operate/doubtExt/doubtDel.action',
		       		params:{'audDoubt.doubt_id':myDoubt[i]}
		       	  }); 
               }else{
                   Usp.doGridDelBatch({
		       		component:gridDoubt,
		       		url:'${pageContext.request.contextPath}/operate/doubtExt/doubtDel.action',
		       		params:{'audDoubt.doubt_id':myDoubt[i]}
		       	  });
               }
                 
           }
                                  
     	  }
   
     }
     
     
     //删除疑点
     function delDoubtOwner(){
     		if(isSingle(gridDoubt.getGridPanel())){
     			var doubt_author_code=gridDoubt.getFieldValue('doubt_author_code');
      			var doubt_status=gridDoubt.getFieldValue('doubt_status');
      			var id=gridDoubt.getFieldValue('doubt_id');
     			/*if('${user.floginname}'==doubt_author_code){
		          }else{
		            alert("没有权限删除！");
		        	return false;
		        }*/
			 if('010'==doubt_status){
			    var checkCode='0';
	            DWREngine.setAsync(false);
		        DWREngine.setAsync(false);DWRActionUtil.execute(
		        {namespace:'/operate/doubt', action:'checkStatus', executeResult:'false' }, 
		        {'checkStatus':'010','doubt_id':id},xxx);
		        function xxx(data){
			       checkCode =data['checkCode'];
		        } 
		
		        if(checkCode=='1'){
		       
		        }else{
		           alert("不能删除,疑点已处理或已删除,请刷新数据后重新操作！");
			       return false;
		        }
		       }else{
		        alert("已处理状态不能删除！");
		        return false;
		       }                  
     
       		 Usp.doGridDel({
       			component:gridDoubt,
       			url:'${pageContext.request.contextPath}/operate/doubtExt/doubtDel.action',
       			params:{'audDoubt.doubt_id':id}
       		  });
   
    		}
    	}
     
       //处理审计疑点
     function outDoubt(){
     	if(isSingle(gridDoubt.getGridPanel())){//是否是单选一条
        var doubt_author_code = gridDoubt.getFieldValue('doubt_author_code');
        var doubt_status=gridDoubt.getFieldValue('doubt_status');
        /*if('${user.floginname}'==doubt_author_code){
		
		}else{
			alert("没有权限处理！");
			return false;
		}*/
		 var doubt_manu=gridDoubt.getFieldValue('doubt_manu');
		 var id=gridDoubt.getFieldValue('doubt_id');
		if('010'==doubt_status){
		   var checkCode='0';
           DWREngine.setAsync(false);
	       DWREngine.setAsync(false);DWRActionUtil.execute(
	       { namespace:'/operate/doubt', action:'checkStatus', executeResult:'false' }, 
	       {'checkStatus':'010','doubt_id':id},xxx);
	       function xxx(data){
		      checkCode =data['checkCode'];
	       } 
	
	       if(checkCode=='1'){
	       }else{
	           alert("不能处理,疑点已处理或已删除,请刷新数据后重新操作！");
		       return false;
	       }
		                  
		  }else{
			alert("已经是已处理状态！");
		  	return false;
		  }                  
     
          if(confirm("是否录入处理无问题原因?\n点‘确定’按钮录入处理无问题原因，点‘取消’按钮直接处理疑点。")){
           
           	var title = "录入处理无问题原因";
           	showPopWin('${contextPath}/operate/doubt/editDoubtReason.action?chuli=1&doubt_id='+id,600,400,title);
          }else{
         	Usp.doPost({
       				component:gridDoubt,
       				msg:'确认处理疑点吗?',
       				url:'${pageContext.request.contextPath}/operate/doubtExt/doubtIn.action',
       				params:{'audDoubt.doubt_id':id,'audDoubt.doubt_status':'050'}
       				});
         	}
      	 }
      }
       
      //恢复疑点状态为未处理
     function inDoubt(){
     	if(isSingle(gridDoubt.getGridPanel())){
     		var doubt_author_code=gridDoubt.getFieldValue('doubt_author_code');
      		var doubt_status=gridDoubt.getFieldValue('doubt_status');
     		/*if('${user.floginname}'==doubt_author_code){
		    }else{
		   		alert("没有权限恢复！");
		    	return false;
		   	}*/
		 	var doubt_manu=gridDoubt.getFieldValue('doubt_manu');
		 	var id=gridDoubt.getFieldValue('doubt_id');
		    var checkCode='0';
            DWREngine.setAsync(false);
	       	DWREngine.setAsync(false);DWRActionUtil.execute(
	       	{namespace:'/operate/doubt', action:'checkStatus', executeResult:'false' }, 
	       	{'checkStatus':'050','doubt_id':id},xxx);
	       function xxx(data){
		      checkCode =data['checkCode'];
	       } 
	
	       if(checkCode=='1'){
	       
	       }else{
	           alert("不能恢复,疑点未处理或已删除,请刷新数据后重新操作！");
		       return false;
	       }
		                   
     
      		Usp.doPost({
       				component:gridDoubt,
       				msg:'确认恢复疑点吗?',
       				url:'${pageContext.request.contextPath}/operate/doubtExt/doubtIn.action',
       				params:{'audDoubt.doubt_id':id,'audDoubt.doubt_status':'010'}
       			});
 
   
    		}
      }
     function isGoOn(){
     	var flag=false;
     	jQuery.ajax({
 			url:'${contextPath}/operate/manuExt/isGoOn.action',
 			type:'POST',
 			data:{"project_id":'${project_id}'},
 			dataType:'json',
 			async:false,
 			success:function(data){
 				if(data == 2) {
 					alert("实施方案正在调整，暂不允许登记底稿")
 					flag= true;
 				}else{
 					flag= false;
 				}
 			},
 			error:function(){
 				alert("3333")
 			}
 		});
     	return flag;
     }
     
     //编辑底稿
	 function editOwner(){
		 if(isGoOn()){
			  return false;
		  }
	   		if(isSingle(gridDigao.getGridPanel())){
		   		var ms_author=gridDigao.getFieldValue('ms_author');
		        var ms_status=gridDigao.getFieldValue('ms_status');
		        var ms_id=gridDigao.getFieldValue('formId');
		        var url="0";
		        if('${user.floginname}'==ms_author){
				}else{
					alert("没有权限修改！");
					return false;
				}
				                  
		      	if('010'==ms_status){
		      		window.open("/ais/operate/manu/edit.action?owner=true&groupCode=<%=request.getParameter("groupCode")%>&crudId="+ms_id+"&project_id=<%=request.getParameter("project_id")%>&taskId=<%=request.getParameter("taskId")%>&taskPid=<%=request.getParameter("taskPid")%>&back=true");
		    		//editDigaoFrameOwner(ms_id);
				}else if('060'==ms_status){
				 	alert("底稿已经注销,不能修改或者提交!");
					return false;
				}else{
					if('050'==ms_status){
						alert("底稿已经复核完毕,不能修改或者提交!");
						return false;
					}else{
						DWREngine.setAsync(false);
						DWREngine.setAsync(false);DWRActionUtil.execute(
						{namespace:'/operate/manu', action:'getFormUrl', executeResult:'false' }, 
						{'crudId':ms_id},xxx);
						function xxx(data){
							url =data['url'];
						} 
						if(url=="0"){
							alert("底稿已经进入审批流程,不能修改或者提交!");
							return false;
						}else{
							window.open("/ais/operate/manu/edit.action?owner=true&groupCode=<%=request.getParameter("groupCode")%>&crudId="+id+"&taskInstanceId="+taskInstanceId+"&project_id=<%=request.getParameter("project_id")%>&taskId=<%=request.getParameter("taskId")%>&taskPid=<%=request.getParameter("taskPid")%>&back=true");
							//editDigaoFrameUrlOwner(ms_id,url);
					    }
					}
			 	}
	   		 }
	   } 
     //批量删除底稿
     function piliangDelOwner(){
        var selectedRows = (gridDigao.getGridPanel()).getSelectionModel().getSelections(); 
                            
        var str = "";
        var myManu=new Array()
 
        if(selectedRows.length==1){//一条数据，走单独删除
           delOwner();
        }else{
           for(i=0;i <selectedRows.length;i++){
              
                var ms_author = selectedRows[i].data.ms_author;
		        var ms_status = selectedRows[i].data.ms_status;
		          
		      	
			  	var project_id = selectedRows[i].data.project_id;   
               
               if(selectedRows[i].data.ms_status=='010'){
                   /*if('${user.floginname}'==selectedRows[i].data.ms_author){
               		}else{
                  	Ext.Msg.show({
                    title: '', 
                    msg: '所选取的底稿 ['+selectedRows[i].data.ms_name+'] 没有权限删除,不能批量删除!',
                    icon: Ext.Msg.INFO,
                    minWidth: 300,
                    buttons: Ext.Msg.OK
                  	}); 
                  		return false;
               		}*/
               }else if(selectedRows[i].data.ms_status=='060'){//请组长和副组长和主审删除
               
                    var groupId = selectedRows[i].data.groupId;
                   
				    DWREngine.setAsync(false);
					DWREngine.setAsync(false);DWRActionUtil.execute(
					{ namespace:'/operate/manu', action:'getManuDelAuth', executeResult:'false' }, 
					{'groupId':groupId,'project_id':project_id},xxx);
					 function xxx(data){
					 url =data['url'];
					 } 
					if(url=="0"){
						alert("底稿所属小组的组长、副组长、主审有权限删除该底稿!");
						return false;
					}else{
					}
				 }else{
                  Ext.Msg.show({
                    title: '', 
                    msg: '所选取的底稿 ['+selectedRows[i].data.ms_name+'] 不是底稿草稿或者已经注销状态,不能批量删除!',
                    icon: Ext.Msg.INFO,
                    minWidth: 300,
                    buttons: Ext.Msg.OK
                });
                return false;
               }
                
           }
            for(i=0;i <selectedRows.length;i++){
               str += selectedRows[i].data.formId + ","; 
               myManu[i]=selectedRows[i].data.formId;
               var  j=i+1;
               var delTip='false';
               if(j==selectedRows.length){
                    Usp.doGridDel({
		       		component:gridDigao,
		       		url:'${pageContext.request.contextPath}/operate/manuExt/manuDel.action',
		         	params:{'audManuscript.formId':myManu[i]}
		       	}); 
               }else{
                   Usp.doGridDelBatch({
		       		component:gridDigao,
		       		url:'${pageContext.request.contextPath}/operate/manuExt/manuDel.action',
		         	params:{'audManuscript.formId':myManu[i]}
		       	}); 
               }
                 
           }
                                  
     	  }
   
    	}
	    //删除底稿
	     function delOwner(){
	        if(isSingle(gridDigao.getGridPanel())){
		        var ms_author=gridDigao.getFieldValue('ms_author');
		        var ms_status=gridDigao.getFieldValue('ms_status');
		          
		      	var groupId = gridDigao.getFieldValue('groupId');
			  	var project_id = gridDigao.getFieldValue('project_id');   
				                  
		      	if('010'==ms_status){
		        	if('${user.floginname}'==ms_author){
					 }else{
					 	alert("没有权限删除！");
					 	return false;
					}
				 }else if('060'==ms_status){//请组长和副组长和主审删除
				    DWREngine.setAsync(false);
					DWREngine.setAsync(false);DWRActionUtil.execute(
					{ namespace:'/operate/manu', action:'getManuDelAuth', executeResult:'false' }, 
					{'groupId':groupId,'project_id':project_id},xxx);
					 function xxx(data){
					 url =data['url'];
					 } 
					if(url=="0"){
						alert("底稿所属小组的组长、副组长、主审有权限删除该底稿!");
						return false;
					}else{
					}
				 }else{
				   	if('050'==ms_status){
				    	alert("底稿已经复核完毕,不能删除!");
						return false;
						}else {
				    	     alert("底稿已经进入审批流程,不能删除!");
							 return false;
						}
				                    
				 }
				  
			       var id=gridDigao.getFieldValue('formId');
			       Usp.doGridDel({
		       				component:gridDigao,
		       				url:'${pageContext.request.contextPath}/operate/manuExt/manuDel.action',
		       				params:{'audManuscript.formId':id}
		       			});
	     		 }
	      }
    //编辑底稿
			function editDigaoFrameOwner(id){
				Usp.doTabLoad({url:"/ais/operate/manu/edit.action?owner=true&groupCode=<%=request.getParameter("groupCode")%>&crudId="+id+"&project_id=<%=request.getParameter("project_id")%>&taskId=<%=request.getParameter("taskId")%>&taskPid=<%=request.getParameter("taskPid")%>",
					isFrame:true,
					tabId:'common-data-dataframe-tab',
			   	   	pid:'common-data-dataframe-tab1'});
			}
	        //编辑底稿，返回页面不同
			function editDigaoFrameUrlOwner(id,taskInstanceId){
				Usp.doTabLoad({url:"/ais/operate/manu/edit.action?owner=true&groupCode=<%=request.getParameter("groupCode")%>&back=false&crudId="+id+"&taskInstanceId="+taskInstanceId+"&project_id=<%=request.getParameter("project_id")%>&taskId=<%=request.getParameter("taskId")%>&taskPid=<%=request.getParameter("taskPid")%>",
					isFrame:true,
					tabId:'common-data-dataframe-tab',
		        	pid:'common-data-dataframe-tab1'});
			}
	        
	 
	    //底稿注销
      function manuOutOwner(){
    	if(isSingle(gridDigao.getGridPanel())){
        	var ms_author=gridDigao.getFieldValue('ms_author');
         	var ms_status=gridDigao.getFieldValue('ms_status');
      
        	if('${user.floginname}'==ms_author){
				}else{
				alert("没有权限注销！");
				return false;
	      	}
		                  
	      	if('050'==ms_status){
			    }else{
			   alert("只能注销复核完毕的底稿!");
			   return false;
			  }
		  
       		var id=gridDigao.getFieldValue('formId');
	          Usp.doPost({
	       		component:gridDigao,
	       		msg:'确认注销底稿吗?',
	       		url:'${pageContext.request.contextPath}/operate/manuExt/manuUpdate.action',
	       		params:{'audManuscript.formId':id,'audManuscript.ms_status':'060'}
	       		});
      	}			
      }
	    // 恢复底稿//该底稿所属小组的组长、副组长、主审有权限恢复该底稿
      function manuInOwner(){
      	if(isSingle(gridDigao.getGridPanel())){
	        var ms_author=gridDigao.getFieldValue('ms_author');
	        var ms_status=gridDigao.getFieldValue('ms_status');
	     	var groupId = gridDigao.getFieldValue('groupId');
		 	var project_id = gridDigao.getFieldValue('project_id');	                  
	      	if('060'==ms_status){
			 	DWREngine.setAsync(false);
				 DWREngine.setAsync(false);DWRActionUtil.execute(
				{ namespace:'/operate/manu', action:'getManuDelAuth', executeResult:'false' }, 
				{'groupId':groupId,'project_id':project_id},xxx);
				 function xxx(data){
					url =data['url'];
				} 
				if(url=="0"){
					alert("底稿所属小组的组长、副组长、主审有权限恢复该底稿!");
					return false;
				}else{
				}
			 }else{
			    alert("只能恢复已经注销的底稿!");
			    return false;
			}
	       	var id=gridDigao.getFieldValue('formId');
	       	Usp.doPost({
	       		component:gridDigao,
	       		msg:'确认恢复底稿吗?',
	       		url:'${pageContext.request.contextPath}/operate/manuExt/manuUpdate.action',
	       		params:{'audManuscript.formId':id,'audManuscript.ms_status':'050'}
	       		});
      	}
      }
	  //批量提交底稿
     function piliangOwner(){
        var selectedRows = (gridDigao.getGridPanel()).getSelectionModel().getSelections(); 
        if(selectedRows.length==0){
            alert("请选择要提交的底稿!");
            return;
        }                     
        var str = "";
        if(selectedRows.length==1){
           editOwner();
        }else{
           for(i=0;i <selectedRows.length;i++){
               /*if('${user.floginname}'==selectedRows[i].data.ms_author){
               }else{
                  Ext.Msg.show({
                    title: '', 
                    msg: '所选取的底稿 ['+selectedRows[i].data.ms_name+'] 没有权限修改,不能批量提交审批流程,请单独提交!',
                    icon: Ext.Msg.INFO,
                    minWidth: 300,
                    buttons: Ext.Msg.OK
                  }); 
                  return false;
               }*/
               if(selectedRows[i].data.ms_status=='010'){
               }else{
                  Ext.Msg.show({
                    title: '', 
                    msg: '所选取的底稿 ['+selectedRows[i].data.ms_name+'] 不是底稿草稿状态,不能批量提交审批流程,请单独提交!',
                    icon: Ext.Msg.INFO,
                    minWidth: 300,
                    buttons: Ext.Msg.OK
                });
                return false;
               }
               str += selectedRows[i].data.formId + ","; 
           }                                   
       	   document.getElementsByName('manuIds2')[0].value=str;
           var ttt = document.getElementsByName('manuIds2')[0].value;
        
      
	       var title = "底稿批量提交";
		   showPopWin('${contextPath}/operate/manu/batch.action?owner=true&taskId=<%=request.getParameter("taskId")%>&isArray=false&is2=true&manuIds2='+ttt,700,600,title);
     	  }
   
    	}
		
    	//导出底稿
       function baogaoOwner(){
       		/* var selectedRows = (gridDigao.getGridPanel()).getSelectionModel().getSelections(); 
        	if(selectedRows.length==0){
            	 alert("请选择要导出的底稿!");
           		 return;
       		}                     
      		var str = "";
      		for(i=0;i <selectedRows.length;i++){
               str += selectedRows[i].data.formId + ","; 
      		}                                   
      		document.getElementsByName('manuIds2')[0].value=str;
    		 myform22.submit(); */
    	   var selectedRows = (gridDigao.getGridPanel()).getSelectionModel().getSelections(); 
           if(selectedRows.length==0){
               alert("请选择要导出的底稿!");
               return;
           } 
           var str = "";
           for(i=0;i <selectedRows.length;i++){
                  str += selectedRows[i].data.formId + ","; 
           }
           
           //必须通过隐藏域传递参数，否则太长被IE截取
           document.getElementsByName('manuIds2')[0].value=str;
           
           //底稿模板方式导出
         	var manuFormType="1040";
         	var _url = "${contextPath}/commons/oaprint/manuTemplateList.action?dwrModuleid="+manuFormType;
         	window.open(_url);
	  }
    
    var winDigao;//底稿查询窗口
    var winYidian;//疑点查询窗口
    
    //-------toolbar工具栏定义开始------------
    //toolbar工具栏，按钮的图片样式见/WebRoot/cloud/styles/js/main.js文件
    
    var toolbar=new Usp.ToolBar();//底稿grid的工具栏
	toolbar.addBtn({btnType:'-'});
	toolbar.addBtn({btnType:'VIEW',btnStyle:'visible',handler:view});
	 <% if(!"true".equals(right)){%>//根据系统参数配置，是否显示底稿反馈按钮
	 if("enabled"=='${digaofankui}'){
	      toolbar.addSeparator(); 
	     toolbar.addBtn({btnType:'COMMENT',btnStyle:'visible',handler:feedback});
	  }
	<%}%>
	if('${view}' != 'view'){	
	toolbar.addBtn({btnType:'ADD',btnStyle:'visible',handler:addOwner});
	toolbar.addSeparator(); 
	toolbar.addBtn({btnType:'EDIT',btnStyle:'visible',handler:editOwner});
	toolbar.addSeparator(); 
	toolbar.addBtn({btnType:'DEL',btnStyle:'visible',handler:piliangDelOwner});
	toolbar.addSeparator(); 
	toolbar.addBtn({btnType:'OUT',btnStyle:'visible',handler:manuOutOwner});
	toolbar.addSeparator(); 
	toolbar.addBtn({btnType:'IN',btnStyle:'visible',handler:manuInOwner});
	toolbar.addSeparator(); 
	toolbar.addBtn({btnType:'SUBMIT',btnStyle:'visible',handler:piliangOwner});
	toolbar.addSeparator(); 
	}
	/* toolbar.addBtn({btnType:'EXP',btnStyle:'visible',handler:baogaoOwner}); */
	 // 导出单项底稿
          toolbar.addBtn({btnType:'EXPSINGL',btnStyle:'visible',handler:function(){
            expManuscript("UNITERM","单项底稿");
          }});
	      toolbar.addSeparator(); 
          
          // 导出综合底稿
	      toolbar.addBtn({btnType:'EXPMULTI',btnStyle:'visible',handler:function(){
            expManuscript("COMPREHENSIVE","综合底稿");
          }});
	      toolbar.addSeparator(); 
	/* toolbar.addSeparator(); 
	toolbar.addBtn({btnType:'SEARCH',btnStyle:'visible',handler:search});
	toolbar.addSeparator(); 
	toolbar.addBtn({btnType:'EMAIL',btnStyle:'visible',handler:sendMail}); */
    
	var toolbarDoubt=new Usp.ToolBar();//疑点grid的工具栏
	toolbarDoubt.addBtn({btnType:'-'});
	toolbarDoubt.addBtn({btnType:'VIEW',btnStyle:'visible',handler:viewDoubt});
	if('${view}' != 'view'){
	toolbarDoubt.addSeparator();
	toolbarDoubt.addBtn({btnType:'ADD',btnStyle:'visible',handler:addDoubtOwner});//增加
	toolbarDoubt.addSeparator(); 
	toolbarDoubt.addBtn({btnType:'EDIT',btnStyle:'visible',handler:editDoubtOwner});//编辑
	toolbarDoubt.addSeparator(); 
	toolbarDoubt.addBtn({btnType:'DEL',btnStyle:'visible',handler:piliangDelDoubtOwner});//删除 
	toolbarDoubt.addSeparator(); 
	
	toolbarDoubt.addBtn({btnType:'CHECK',btnStyle:'visible',handler:outDoubt});
	toolbarDoubt.addSeparator(); 
	toolbarDoubt.addBtn({btnType:'IN',btnStyle:'visible',handler:inDoubt});
	}
	/* toolbarDoubt.addSeparator(); 
	toolbarDoubt.addBtn({btnType:'SEARCH',btnStyle:'visible',handler:searchYidian}); */
	

	var toolbarLedger=new Usp.ToolBar();//审计问题grid的工具栏
	toolbarLedger.addBtn({btnType:'-'});
	toolbarLedger.addBtn({btnType:'VIEW',btnStyle:'visible',handler:viewLedgerOwner});
 
	//-------toolbar工具栏定义结束------------
 
    
    
     //-------ext的grid定义开始------------
        
        
        //-------底稿的grid定义开始------------
    
     
        var dataModelDigao={url:'${pageContext.request.contextPath}/operate/manuExt/manuListJson.action?permission=<%=request.getParameter("permission")%>&isView=<%=request.getParameter("isView")%>&project_id=<%=request.getParameter("project_id")%>',
                   cells:['formId','ms_name','ms_author_name','audit_dept_name','manuType','manuTypeName','task_code','task_name','ms_author','fileCount','audit_found','ms_status','ms_statusName','ms_code','ms_date','project_id','prom','groupId']
		};
     						
		var viewModelDigao=[{header:'formId',dataIndex:'formId',hidden:true,sortable:true},
		 {header:'<div style="text-align:center">底稿名称</div>',dataIndex:'ms_name',sortable:true,width:100,renderer: formatQtip},
		 {header:'底稿类型',dataIndex:'manuTypeName',width:70,sortable:true,align:'center'},
		 {header:'底稿状态',dataIndex:'ms_statusName',sortable:true,width:80,align:'center'},
         {header:'被审计单位',dataIndex:'audit_dept_name',sortable:true,width:150,align:'center'},
         {header:'审计事项',dataIndex:'task_name',width:80,sortable:true,align:'center'},
         {header:'撰写人',dataIndex:'ms_author_name',sortable:true,width:50,align:'center'},
         {header:'附件',dataIndex:'fileCount',sortable:true,width:30,align:'center'},
         {header:'关联疑点',dataIndex:'audit_found',renderer:setYD,width:70,sortable:true,align:'center'},
         {header:'审计问题数量',dataIndex:'prom',sortable:true,width:80,align:'center'},
         {header:'创建日期',dataIndex:'ms_date',sortable:true,align:'center',width:100,
        	 renderer:function(value,cellmeta,record,rowIndex,columnIndex,color_store){
	             if(value!=null){
	                 return value.substring(0,10);
	             }else{
	                 return null;
	             }
              
             } 
           }
         ];		
			
		 var gridDigao =new Usp.Grid({
           gridConfig:{title:'审计底稿',collapsible:true,autoScroll:true,autoHeight:true,collapsed:
                       false,titleCollapse:true,animCollapse:false,region:'center' ,
            tbar:toolbar.getToolPanel()},
			isSelect:'2',
			isRowNo:'1',
			dataModel:dataModelDigao,
			viewModel:viewModelDigao,
			limit:100
		});
		
		//taskPid不同，显示的数据不同，taskPid=-1，显示全部的数据，taskPid为树节点的id 显示的是本级和下级的数据
		<%String sdigao=request.getParameter("taskPid");%>
        <% if("-1".equals(sdigao)||sdigao==null){%>
           gridDigao.getGridPanel().loadData({'audManuscript.flushdata':'1','audManuscript.project_id':'<%=request.getParameter("project_id")%>','audManuscript.task_id':'-1'});
        <%}else{%>
            gridDigao.getGridPanel().loadData({'audManuscript.flushdata':'1','audManuscript.project_id':'<%=request.getParameter("project_id")%>','audManuscript.task_id':'<%=request.getParameter("taskId")%>','taskPid':'<%=request.getParameter("taskPid")%>','taskId':'<%=request.getParameter("taskId")%>'});
        <%}%>
    
    
         //-------底稿的grid定义结束------------
    
         //-------疑点的grid定义开始------------
         
        var dataModelDoubt={url:'${pageContext.request.contextPath}/operate/doubtExt/doubtListJson.action?permission=<%=request.getParameter("permission")%>&isView=<%=request.getParameter("isView")%>&project_id=<%=request.getParameter("project_id")%>',
             cells:['doubt_id','doubt_status','doubt_statusName','audit_dept_name','task_code','task_name','doubt_code','fileCount','doubt_name','doubt_author','doubt_author_code','doubt_date','doubt_manu','doubt_manu_name']
		};
        
        
         
        
        var viewModelDoubt=[{header:'doubt_id',dataIndex:'doubt_id',hidden:true,sortable:true},
         {header:'<div style="text-align:center">疑点名称</div>',dataIndex:'doubt_name',sortable:true,width:100,renderer: formatQtip},
    	 {header:'疑点状态',dataIndex:'doubt_statusName',sortable:true,width:80,align:'center'},
         {header:'疑点编码',dataIndex:'doubt_code',sortable:true,width:70,align:'center'},
         {header:'被审计单位',dataIndex:'audit_dept_name',sortable:true,width:150,align:'center'},
         {header:'审计事项',dataIndex:'task_name',width:100,sortable:true,align:'center'},
         {header:'撰写人',dataIndex:'doubt_author',sortable:true,width:50,align:'center'},
         {header:'附件',dataIndex:'fileCount',sortable:true,width:30,align:'center'},
         {header:'关联底稿',dataIndex:'doubt_manu_name',renderer:setDG,width:70,sortable:true,align:'center'},
         {header:'创建日期',dataIndex:'doubt_date',sortable:true,align:'center',width:90,

        	 renderer:function(value,cellmeta,record,rowIndex,columnIndex,color_store){
             if(value!=null){
             
              return value.substring(0,10);
             }else{
                 return null;
             }
              
           } 
             }
         ];	
         
        var gridDoubt =new Usp.Grid({
          gridConfig:{title:'审计疑点',collapsible:true,autoHeight:true,collapsed:
                     false,titleCollapse:true,animCollapse:false,
            tbar:toolbarDoubt.getToolPanel()},
		    isSelect:'2',
			isRowNo:'1',
			dataModel:dataModelDoubt,
			viewModel:viewModelDoubt,
			limit:100
		});
		//taskPid不同，显示的数据不同，taskPid=-1，显示全部的数据，taskPid为树节点的id 显示的是本级和下级的数据
       <%String syidian=request.getParameter("taskPid");%>
       <% if("-1".equals(syidian)||syidian==null){%>
           gridDoubt.getGridPanel().loadData({'audDoubt.flushdata':'1','audDoubt.doubt_type':'YD','audDoubt.project_id':'<%=request.getParameter("project_id")%>','audDoubt.task_id':'-1'});
       <%}else{%>
           gridDoubt.getGridPanel().loadData({'audDoubt.flushdata':'1','audDoubt.doubt_type':'YD','audDoubt.project_id':'<%=request.getParameter("project_id")%>','taskPid':'<%=request.getParameter("taskPid")%>','taskId':'<%=request.getParameter("taskId")%>','audDoubt.task_id':'<%=request.getParameter("taskId")%>'});
       <%}%>
       
       
       //-------疑点的grid定义结束------------
       
       //-------审计问题的grid定义开始------------
       
         var dataModelLedger={url:'${pageContext.request.contextPath}/proledger/problem/loadLedgerListJson.action?permission=<%=request.getParameter("permission")%>&isView=<%=request.getParameter("isView")%>&project_id=<%=request.getParameter("project_id")%>',
            cells:['id','manuscript_name','manuscript_code','sort_big_name','sort_small_name','problem_name','problem_money','problem_grade_name','manuscript_id','taskAssignName','p_unit','problem_desc']
		};
       
       
        
       
       var viewModelLedger=[{header:'id',dataIndex:'id',hidden:true,sortable:true},
   	    {header:'底稿名称',dataIndex:'manuscript_name',sortable:true,width:100,align:'center'},
   	 	{header:'底稿编码',dataIndex:'manuscript_code',hidden:true,sortable:true},
        {header:'分组',dataIndex:'taskAssignName',sortable:true,width:70,align:'center'},
        {header:'问题类别',dataIndex:'sort_big_name',sortable:true,width:100,align:'center'},
        {header:'问题子类别',dataIndex:'sort_small_name',width:100,sortable:true,align:'center'},
        {header:'问题点',dataIndex:'problem_name',sortable:true,width:100,align:'center'},
        {header:'发生数',dataIndex:'problem_money',sortable:true,width:50,align:'center'},
        {header:'统计单位',dataIndex:'p_unit',width:50,sortable:true,align:'center'},
        {header:'问题定性',dataIndex:'problem_grade_name',width:100,sortable:true,align:'center'},
        {header:'问题描述',dataIndex:'problem_desc',width:150,sortable:true,align:'center'}
        ];	
        
       var gridLedger =new Usp.Grid({
         gridConfig:{title:'审计问题',collapsible:true,autoHeight:true,collapsed:
                    false,titleCollapse:true,animCollapse:false,
            tbar:toolbarLedger.getToolPanel()},
		    isSelect:'2',
			isRowNo:'1',
			dataModel:dataModelLedger,
			viewModel:viewModelLedger,
			limit:100
		});
		//taskPid不同，显示的数据不同，taskPid=-1，显示全部的数据，taskPid为树节点的id 显示的是本级和下级的数据
      <%String ledger=request.getParameter("taskPid");%>
      <% if("-1".equals(ledger)||ledger==null){%>
         gridLedger.getGridPanel().loadData();
      <%}else{%>
      gridLedger.getGridPanel().loadData();
         gridLedger.getGridPanel().loadData({'taskPid':'<%=request.getParameter("taskPid")%>','taskId':'<%=request.getParameter("taskId")%>'});
      <%}%>
      
      
      //-------审计问题的grid定义结束------------
       
       //-------ext的grid定义结束----------- 
         
         
	   Ext.QuickTips.init();

 
	 //ext显示panel
     var singlePanel1=new Usp.SinglePanel();
     var singlePanel2=new Usp.SinglePanel();
     var singlePanel3=new Usp.SinglePanel();
     singlePanel1.main.add(gridDigao.getGridPanel());//底稿
     singlePanel2.main.add(gridDoubt.getGridPanel());//疑点
     singlePanel3.main.add(gridLedger.getGridPanel());//审计问题
     singlePanel1.main.render('operate-task-detail-list-1');
     singlePanel2.main.render('operate-task-detail-list-2');
     singlePanel3.main.render('operate-task-detail-list-3');
  
      //-------------ext用到的handler方法开始------------------
     
     
     
      //grid每行的提示
      function formatQtip(data,metadata){ 
    	var title ="";
    	var tip =data; 
    	metadata.attr = 'ext:qtitle="' + title + '"' + ' ext:qtip="' + '双击查看' + '"';  
    	return data;  
   	 }

     //grid的双击事件
      gridLedger.getGridPanel().addListener('rowdblclick', rowdblclickLedger);  
      function rowdblclickLedger(grid, rowindex, e){  //双击事件   
     		grid.getSelectionModel().each(function(rec){    
          var id=rec.get('id');
         window.open("${contextPath}/proledger/problem/view.action?&id="+id);
  	});  
      }
   	 
   	 //grid的双击事件
     gridDoubt.getGridPanel().addListener('rowdblclick', rowdblclickFnDoubt);  
     function rowdblclickFnDoubt(grid, rowindex, e){  //双击事件   
   		grid.getSelectionModel().each(function(rec){    
		//alert(rec.get('doubt_id')); //fieldName，记录中的字段名   
		var doubt_id=rec.get('doubt_id');
        var checkCode='0';
            DWREngine.setAsync(false);
	       DWREngine.setAsync(false);DWRActionUtil.execute(
	       { namespace:'/operate/doubt', action:'checkStatus', executeResult:'false' }, 
	       {'checkStatus':'000','doubt_id':doubt_id},xxx);
	       function xxx(data){
		      checkCode =data['checkCode'];
	       } 
	
	       if(checkCode=='1'){
	       
	       }else{
	           //alert("疑点已删除,请刷新数据后重新操作！");
		       return false;
	       }
        window.open("${contextPath}/operate/doubt/view.action?type=YD&doubt_id="+doubt_id); 
	});  
    }
    
    //grid的双击事件
    gridDigao.getGridPanel().addListener('rowdblclick', rowdblclickFnManu);  
    function rowdblclickFnManu(grid, rowindex, e){  //双击事件   
   		grid.getSelectionModel().each(function(rec){    
        var formId=rec.get('formId');
       var project_id=gridDigao.getFieldValue('project_id'); 
       <% if(!"true".equals(right)){%>
         window.open("${contextPath}/operate/manu/view.action?crudId="+formId+"&project_id="+project_id);
	 
       <%}else{%>
         window.open("${contextPath}/operate/manu/viewAll.action?crudId="+formId+"&project_id="+project_id);
       <% }%>
	});  
    }
    
    
    //保存
    function saveMain(){
      window.frames['task_main'].saveFormType();
    }
   
 // 导出综合底稿, add by qfucee, 2014.11.10
    function expManuscript(manuType, manuTypeName){
        // manuType底稿类型  UNITERM-单项底稿，COMPREHENSIVE-综合底稿，不同的类型对应的导出模板不一样，qfucee，2014.11.10
        var selectedRows = (gridDigao.getGridPanel()).getSelectionModel().getSelections(); 
        if(selectedRows.length==0){
            alert("请选择要导出的底稿!");
            return;
        } 
        var idArr = [];
        for(i=0;i <selectedRows.length;i++){
            var data = selectedRows[i].data;
            var smanuType = data.manuType;
            //alert(manuType+' '+smanuType);
            if(!(smanuType && manuType && smanuType.toLowerCase() == manuType.toLowerCase())){
                var ms_code = data.ms_code;
                alert("底稿【"+ms_code+"】不适合【"+manuTypeName+"】导出模板");
                return;
            }
            idArr.push(data.formId);
        }
        if(idArr.length > 0){
            //必须通过隐藏域传递参数，否则太长被IE截取
            document.getElementsByName('manuIds2')[0].value = idArr.join(",");
            //底稿模板方式导出
            var manuFormType="1040";
            var _url = "${contextPath}/commons/oaprint/manuTemplateList.action?dwrModuleid="+manuFormType+"&manuType="+manuType;
            window.open(_url);
        }else{
            alert("获得底稿ID出错！");
        }
    }
     //批量导出到底稿
     function baogao(){
     
        var selectedRows = (gridDigao.getGridPanel()).getSelectionModel().getSelections(); 
        if(selectedRows.length==0){
            alert("请选择要导出的底稿!");
            return;
        }                     
        var str = "";
        for(i=0;i <selectedRows.length;i++){
               str += selectedRows[i].data.formId + ","; 
        }                                     
        document.getElementsByName('manuIds')[0].value=str;
        myform2.submit();
	 }
     
     
     //底稿反馈
     function feedback(){
	    var resullt=''; 
	    var s='${project_id}';
		DWREngine.setAsync(false);
			DWREngine.setAsync(false);DWRActionUtil.execute(
		{ namespace:'/operate/task', action:'select', executeResult:'false' }, 
		{'project_id':s},xxx);
	     function xxx(data){
	     result =data['auth'];
		} 
	 
	  	if(result=='1'){
	    }else{
	  		alert("只有组长、副组长和主审有权设置底稿反馈！");
	  		return false;
	  	}
	  	win = window.open("${contextPath}/operate/manu/feedback.action?project_id=<%=request.getParameter("project_id")%>&taskPid=-1","feedback");

	  	var h = window.screen.availHeight;
  	  	var w = window.screen.width; 
		win.moveTo(0,0)   
		win.resizeTo(w,h) 
		if(win && win.open && !win.closed) 
         win.focus();
	  }
     
      //重新渲染关联疑点字段，使之显示为一个链接
      function setYD(value, cellmeta, record, rowIndex, columnIndex,store) { 
       
       if (typeof record != 'undefined'&& record != null&& record != 'null'&&record.data["audit_found"]!=null){
      
	        var tt3;
	        var mc=record.data["manu"];
	        var dc=record.data["doubt"];
	        var code3=record.data["audit_found"];
		    var codeArray3=code3.split(',');
	        var project_id = record.data["project_id"];
	        if(codeArray3[0]!=null&&codeArray3[0]!=''){
	            tt3='<a href=# onclick=go2(\"'+codeArray3[0]+'\")>'+codeArray3[1]+'</a>';
	            tt3=tt3+"<br />";
	        }
         	return tt3; 
        }else{
          	return '';
        }
      } 
       //重新渲染关联底稿字段，使之显示为一个链接
      function setDG(value, cellmeta, record, rowIndex, columnIndex,store) { 
       if (typeof record != 'undefined'&& record != null&& record != 'null'&&record.data["doubt_manu"]!=null){
      
	        var tt3;
	        
	        var code3=record.data["doubt_manu"];
	        var code4=record.data["doubt_manu_name"];
		    var codeArray3=code3.split(',');
	        var project_id = record.data["project_id"];
	        if(codeArray3[0]!=null&&codeArray3[0]!=''){
	            tt3='<a href=# onclick=goDG(\"'+codeArray3[0]+'\")>'+code4+'</a>';
	            tt3=tt3+"<br />";
	        }
	  
	        return tt3; 
	     }else{
	          return '';
	      }
      }       
 
	   //分项小结的导出
	   function subExport(){
	      location.href='${contextPath}/operate/doubt/exportSubTask.action?project_id=<%=request.getParameter("project_id")%>&taskId=<%=request.getParameter("taskId")%>';//
	   }
   
   
 
 
     //查看疑点
      function viewDoubt(){
       	if(isSingle(gridDoubt.getGridPanel())){
          var doubt_id=gridDoubt.getFieldValue('doubt_id');
          window.open("${contextPath}/operate/doubt/view.action?type=YD&doubt_id="+doubt_id);
       	}else{
        }
      }

    //查看审计问题
      function viewLedgerOwner(){
    		if(isSingle(gridLedger.getGridPanel())){
     		var id=gridLedger.getFieldValue('id');
    		window.open("${contextPath}/proledger/problem/view.action?&id="+id);
	      }
     }
      
      //查看底稿
     function view(){
       if(isSingle(gridDigao.getGridPanel())){
       	 	var formId=gridDigao.getFieldValue('formId');
        	var project_id=gridDigao.getFieldValue('project_id'); 
        	<% if(!"true".equals(right)){%>
         	window.open("${contextPath}/operate/manu/view.action?crudId="+formId+"&project_id="+project_id);
	 
        	<%}else{%>
          		window.open("${contextPath}/operate/manu/viewAll.action?crudId="+formId+"&project_id="+project_id);
        	<% }%>
      	}else{
      	}
      }
     
 

           
     
      //-------------ext用到的handler方法结束------------------
      
  
      
      
      //-------------ext查询用到的handler方法开始------------------
      
      //底稿查询
       function query(){
        	gridDigao.getGridPanel().getStore().baseParams=Ext.decode(Ext.encode(simpleForm.getForm().getValues()));
        	gridDigao.getGridPanel().getStore().baseParams['audManuscript.flushdata']='1';
			gridDigao.getGridPanel().getStore().reload({params:{start:0,limit:100}});

      }
      
      //疑点查询
       function queryYidian(){
        	gridDoubt.getGridPanel().getStore().baseParams=Ext.decode(Ext.encode(simpleFormYidian.getForm().getValues()));
        	gridDoubt.getGridPanel().getStore().baseParams['audDoubt.flushdata']='2';
			gridDoubt.getGridPanel().getStore().reload({params:{start:0,limit:100}});

        }
        
        
        //打开或者关闭底稿查询窗口
        function search(){
                gridDigao.getGridPanel().getStore().baseParams['audManuscript.flushdata']='1';
          		if(!winDigao){
             		if(typeof(winDigao)=='undefined'){
             		simpleForm.render('manu-hello-tabs-detail');
             	}
             
             	document.getElementById('manu-hello-tabs-detail').style.display='';
             	winDigao=true;
         		}  else{
             		document.getElementById('manu-hello-tabs-detail').style.display='none';
            		winDigao=false;
         		}
         
       	}
       	//打开或者关闭疑点查询窗口
       	function searchYidian(){
            	gridDoubt.getGridPanel().getStore().baseParams['audDoubt.flushdata']='1';
            	if(!winYidian){
             		if(typeof(winYidian)=='undefined'){
                	simpleFormYidian.render('doubt-hello-tabs-detail');
             	}
             	document.getElementById('doubt-hello-tabs-detail').style.display='';
             	winYidian=true;
              	}else{
              	document.getElementById('doubt-hello-tabs-detail').style.display='none';
             	 winYidian=false;
          		}
          }
      //-------------ext查询用到的handler方法结束------------------
      
      
      
      //-------------ext查询form开始------------------
      
         //-------------ext底稿查询form开始------------------
      var simpleForm = new Ext.FormPanel({
        layout:'column',
        border:false,
        labelSeparator:'：',
        labelAlign: 'right',
        title: '底稿查询',
        buttonAlign:'center',
        bodyStyle:'padding:5px',
        
        frame:true,
        labelWidth:80,
         items:[{
            columnWidth:.5,
            layout: 'form',
            border:false,
            items: [{
                xtype:'textfield',
                fieldLabel: '底稿名称',
                name: 'audManuscript.ms_name',
                anchor:'100%'
            }]

        },{

            columnWidth:.5,
            layout: 'form',
            border:false,
            items: [{
                xtype:'textfield',
                fieldLabel: '审计事项',
                name: 'audManuscript.task_name',
                anchor:'100%'

            }]

        },{
            columnWidth:.5,
            layout: 'form',
            border:false,
            items: [{
                xtype:'datefield',
                fieldLabel: '开始日期',
                format: 'Y-m-d',
                editable:false,
                name: 'audManuscript.start_search',
                anchor:'100%'
            }]

        },{
            columnWidth:.5,
            layout: 'form',
            border:false,
            items: [{
                xtype:'datefield',
                fieldLabel: '结束日期',
                format: 'Y-m-d',
                editable:false,
                name: 'audManuscript.end_search',
                anchor:'100%'

            }]

        },{
            columnWidth:.5,
            layout: 'form',
            border:false,
            items: [{
                 xtype:'textfield',
                fieldLabel: '撰写人',
                name: 'audManuscript.ms_author_name',
                anchor:'100%'
            }]

        },{
            columnWidth:.5,
            layout: 'form',
            border:false,
            items: [{
                 xtype:'combo',
                fieldLabel: '被审计单位',
                columnWidth:'.5',layout:'column',
                store :new Ext.data.SimpleStore({
                       fields: ['audManuscript.audit_dept_name', 'audit_dept_name'],
                       data : [${deptName}]
                }),
                hiddenName: 'audManuscript.audit_dept_name',
                valueField:'audManuscript.audit_dept_name',
                displayField:'audit_dept_name',
                typeAhead: true,
                editable:false,
                mode: 'local',
                triggerAction: 'all',
                emptyText:'请选择 ...',
                selectOnFocus:true,
                anchor:'100%',
                value:''

            }]

        },{
            columnWidth:.5,
            layout: 'form',
            border:false,
            items: [{
                 xtype:'textfield',
                fieldLabel: '底稿编码',
                name: 'audManuscript.ms_code',
                anchor:'100%'
            }]

        },{

            columnWidth:.5,

            layout: 'form',

            border:false,

            items: [{

                 xtype:'combo',
                fieldLabel: '底稿状态',
                columnWidth:'.5',layout:'column',
                store :new Ext.data.SimpleStore({
                       fields: ['audManuscript.ms_status', 'ms_statusName'],
                       data : [['010','底稿草稿'],
                       <%
							if (  SysParamUtil.getSysParam("ais.project.dgfk")!=null&&
									 SysParamUtil.getSysParam("ais.project.dgfk")
											.equals("enabled")) {
						%>
                       ['020','正在征求'],
                       <%}%>
                       
                       ['030','等待复核'],['040','正在复核'],['050','复核完毕'],['060','已经注销']]
                }),
                hiddenName: 'audManuscript.ms_status',
                valueField:'audManuscript.ms_status',
                displayField:'ms_statusName',
                typeAhead: true,
                editable:false,
                mode: 'local',
                triggerAction: 'all',
                emptyText:'请选择 ...',
                selectOnFocus:true,
                anchor:'100%',
                value:''

            }]

        }
        
        
        , <% if("-1".equals(sdigao)||sdigao==null){%>
              new Ext.form.Hidden({name:'audManuscript.task_id',value:'-1'}),
          <%}else{%>
	          new Ext.form.Hidden({name:'audManuscript.task_id',value:'<%=request.getParameter("taskPid")%>'}),
	          new Ext.form.Hidden({name:'taskId',value:'<%=request.getParameter("taskId")%>'}),
	          new Ext.form.Hidden({name:'taskPid',value:'<%=request.getParameter("taskPid")%>'}),
          <%}%>
		   
             new Ext.form.Hidden({name:'audManuscript.flushdata',value:'1'}),
		     new Ext.form.Hidden({name:'audManuscript.project_id',value:'<%=request.getParameter("project_id")%>'}) 
		 ],

        

        //-------------ext底稿查询按钮------------------
        buttons: [
				{text:'查询',handler:query},
				{text:'重置',
				handler:function(){
				formReset(simpleForm.getForm()); 
				}},{text:'关闭',handler:search}]
         });
      
           
        //-------------ext底稿查询form结束------------------
        
        
        //-------------ext疑点查询form开始------------------
        
        var simpleFormYidian = new Ext.FormPanel({
	        layout:'column',
	        border:false,
	        labelSeparator:'：',
	        labelAlign: 'right',
	        title: '疑点查询',
	        buttonAlign:'center',
	        bodyStyle:'padding:5px',
	        
	        frame:true,
	        labelWidth:80,
	         items:[{
	            columnWidth:.5,
	            layout: 'form',
	            border:false,
	            items: [{
	                xtype:'textfield',
	                fieldLabel: '疑点名称',
	                name: 'audDoubt.doubt_name',
	                anchor:'100%'
	            }]
	
	        },{
	
	            columnWidth:.5,
	            layout: 'form',
	            border:false,
	            items: [{
	                xtype:'textfield',
	                fieldLabel: '审计事项',
	                name: 'audDoubt.task_name',
	                anchor:'100%'
	
	            }]
	
	        },{
	            columnWidth:.5,
	            layout: 'form',
	            border:false,
	            items: [{
	                xtype:'datefield',
	                fieldLabel: '开始日期',
	                format: 'Y-m-d',
	                editable:false,
	                name: 'audDoubt.start_search',
	                anchor:'100%'
	            }]
	
	        },{
	            columnWidth:.5,
	            layout: 'form',
	            border:false,
	            items: [{
	                xtype:'datefield',
	                fieldLabel: '结束日期',
	                format: 'Y-m-d',
	                editable:false,
	                name: 'audDoubt.end_search',
	                anchor:'100%'
	
	            }]
	
	        },{
	            columnWidth:.5,
	            layout: 'form',
	            border:false,
	            items: [{
	                 xtype:'textfield',
	                fieldLabel: '撰写人',
	                name: 'audDoubt.doubt_author',
	                anchor:'100%'
	            }]
	
	        },{
	            columnWidth:.5,
	            layout: 'form',
	            border:false,
	            items: [{
	                 xtype:'combo',
	                fieldLabel: '被审计单位',
	                columnWidth:'.5',layout:'column',
	                store :new Ext.data.SimpleStore({
	                       fields: ['audDoubt.audit_dept_name', 'audit_dept_name'],
	                       data : [${deptName}]
	                }),
	                hiddenName: 'audDoubt.audit_dept_name',
	                valueField:'audDoubt.audit_dept_name',
	                displayField:'audit_dept_name',
	                typeAhead: true,
	                editable:false,
	                mode: 'local',
	                triggerAction: 'all',
	                emptyText:'请选择 ...',
	                selectOnFocus:true,
	                anchor:'100%',
	                value:''
	
	            }]
	
	        },{
	            columnWidth:.5,
	            layout: 'form',
	            border:false,
	            items: [{
	                 xtype:'textfield',
	                fieldLabel: '疑点编码',
	                name: 'audDoubt.doubt_code',
	                anchor:'100%'
	            }]
	
	        },{
	            columnWidth:.5,
	            layout: 'form',
	            border:false,
	            items: [{
	                 xtype:'combo',
	                fieldLabel: '疑点状态',
	                columnWidth:'.5',layout:'column',
	                store :new Ext.data.SimpleStore({
	                       fields: ['audDoubt.doubt_status', 'doubt_statusName'],
	                       data : [['010','未处理'],['050','已处理无问题'],['055','已处理有问题']]
	                }),
	                hiddenName: 'audDoubt.doubt_status',
	                valueField:'audDoubt.doubt_status',
	                displayField:'doubt_statusName',
	                typeAhead: true,
	                editable:false,
	                mode: 'local',
	                triggerAction: 'all',
	                emptyText:'请选择 ...',
	                selectOnFocus:true,
	                anchor:'100%',
	                value:''
	
	            }]
	
	        }
	        , <% if("-1".equals(sdigao)||sdigao==null){%>
	           new Ext.form.Hidden({name:'audDoubt.task_id',value:'-1'}),
	          <%}else{%>
	          new Ext.form.Hidden({name:'audDoubt.task_id',value:'<%=request.getParameter("taskPid")%>'}),
	          new Ext.form.Hidden({name:'taskId',value:'<%=request.getParameter("taskId")%>'}),
	          new Ext.form.Hidden({name:'taskPid',value:'<%=request.getParameter("taskPid")%>'}),
	          <%}%>
			   
	         new Ext.form.Hidden({name:'audDoubt.flushdata',value:'1'}),
			 new Ext.form.Hidden({name:'audDoubt.project_id',value:'<%=request.getParameter("project_id")%>'}) 
			 ],
	
	        buttons: [
					{text:'查询',handler:queryYidian},
					{text:'重置',
					handler:function(){
					formReset(simpleFormYidian.getForm()); 
					}},{text:'关闭',handler:searchYidian}]
	         });
      
      
	});

	//------------ext定义结束---------------

 
    //重新显示格式化的“审计步骤和方法”和“目标”
    function shoWarp(){
          if(${audTask.template_type}=='2'){
          	var code3=document.getElementsByName("audTask.taskMethodView")[0].value; 
          	var code4=document.getElementsByName("audTask.taskTargetView")[0].value;
          	taskMethod.innerHTML=code3 ;
          	taskTarget.innerHTML=code4 ;
         }
    }
    
      //查看底稿
      function goDG(s){
	      window.open("/ais/operate/manu/viewAll.action?crudId="+s);
	 }
	</script>
	</head>
	<body>
    <div id='oprwrap'>
		<center>
        <div   id="operate-task-detail-list-4">
			<s:if test="${audTask.template_type=='2'}"><!--audTask.template_type=='2'显示一个表格table，就不显示树了-->
        	<div style="float: both;width: 100%;border: 1px solid #ffffff;"   id="operate-task-detail-list-4">
        	<s:form id="myform" onsubmit="return true;"
				action="/ais/operate/template" method="post">
	
				<div align="left" style="color: #ffffff;line-height:20px;" >
					<a href="javascript:void(0);" onclick="javascript:task(2,'${audTask.taskTemplateId}')" title="${audTask.url}">
					<div class="divSim" style="cursor:hand">&nbsp;&nbsp;审计事项: ${audTask.url}</div>
					</a>
				</div>
				<div style='padding-bottom:5px;'>
				<table id='tasktable' cellpadding=1 cellspacing=1 border=0  
					class="ListTable22" bgcolor="#409cce">
					<tr class="titletable1">
						<td class ="ListTableTr22" style="width: 15%">
                            <div style="text-align:center;"> 
								审计事项名称
							</div>
						</td>
						<!--标题栏-->
						<td class ="ListTableTr22" style="width: 20%">
							<div style="text-align:center">
								   审计程序和方法
							</div>
						</td>
						<td class ="ListTableTr22" style="width: 25%">
							<div style="text-align:center">
								相关法律法规和监管规定
							</div>
						</td>
						<!--标题栏-->
                       <td class ="ListTableTr22" style="width: 30%">
                        	<div style="text-align:center">
                         	 审计查证要点
							</div>
						</td>
						
						<td class ="ListTableTr22" style="width: 10%">
						   <div style="text-align:center">
                                                                               执行人                         
                            </div>
						</td>
					</tr>
					<tr class="titletable1">
					<!-- <td id="taskTarget" class="td1"> -->
						<td id="taskTarget" >
                        &nbsp;&nbsp;<s:property value="audTask.taskName" />
						</td>
						<s:hidden name="audTask.taskTarget"  />
						<s:hidden name="audTask.taskTargetView"  />
						<!--标题栏-->
						<td id="taskMethod">
                        &nbsp;&nbsp;<s:property value="audTask.taskOther" /> 
						</td>
                         <s:hidden name="audTask.taskMethod" />
                         <s:hidden name="audTask.taskMethodView" />
						<td align="center">
							<s:property value="audTask.law"/>&nbsp;
						</td>
                        <td align="center">
                        	 <s:property value="audTask.taskMethod"/>
						</td>
						<td align="center">
							<s:property value="audTask.taskAssignName"/>
					         <s:hidden name="audTask.taskGroupAssignName" />
						</td>
					</tr>
				    </table>
				    </div>
			
					 <s:hidden name="audTask.taskTemplateId" />
					 <s:hidden name="audTask.taskPid" />
					 <s:hidden name="audTemplateId" />
					 <s:hidden name="taskTemplateId" />
					 <s:hidden name="audTask.templateId" />
                     <s:hidden name="audTask.taskAssignName" />
				     <s:hidden name="audTask.taskGroupAssignName" />
					 <s:hidden name="audTask.taskAssign" />
					 <s:hidden name="audTask.taskGroupAssign" />
					 <s:hidden name="audTask.taskBeforeName" />
					 <s:hidden name="audTask.taskBeforeCode" />
					 <s:hidden name="newDoubt_type" />
				     <s:hidden name="audTask.checkStatus" />
				     <s:hidden name="audTemplate.doubt_id" />
				     <s:hidden name="doubt_id" />
				     <s:hidden name="type" />
				     <s:hidden name="project_id" />
				     <s:hidden name="audTask.id" />
 
			</s:form>
            </div>
            </s:if>
           <s:else><!--audTask.template_type !='2'显示树了-->
             <table align="center" class="ListTable2">
					<tr class="titletable1">
					<td>
						<div align="left" style="color: #ffffff;" >
				      	<a href="javascript:void(0);" onclick="javascript:task(1,'${audTask.taskTemplateId}')" title="${audTask.url}"><div class="divSim" style="cursor:hand">&nbsp;&nbsp;&nbsp;&nbsp;审计事项: ${audTask.url}</div></a>
				     	</div><br>
                    	<div style="float: both;align:left;width: 100%;border: 1px solid #7CA4E9"    id="tree-ct"></div>
                    </td>
 
					</tr>
					 
				</table>
          
          </s:else>
		</div>
		</center>
  
	<form id="myform2" name="my_form2" action="/ais/operate/doubt/exportDigao.action?isArray=false" method="post" style="">
		<s:hidden name="manuIds" />
				
	</form>
	<form id="myform22" name="my_form22" target="_blank" action="/ais/operate/doubt/exportDigao.action?isArray=false&is2=true" method="post" style="">
			<s:hidden name="manuIds2" />
			<s:hidden name="manuArray" />
	</form>
	<table align="center" class="ListTable2"><!--下面是底稿和疑点的grid显示-->
   <tr>
    <td style='padding-bottom:5px;'>
       <div id="manu-hello-win">
       </div> 
        <div id="manu-hello-tabs-detail"  ></div>
         
     <div style="float: both;align:right;width: 100%;border: 1px solid #7CA4E9"   id="operate-task-detail-list-1"> 
        
     </div>
 

    </td>
    
   </tr>
   
     <tr>
    <td style='padding-bottom:5px;'>
     <div id="doubt-hello-tabs-detail"  ></div>
     <div style="float: both;width: 100%;border: 1px solid #7CA4E9;"   id="operate-task-detail-list-2"> </div>
     
     
    </td>
    </tr>
    
    <tr>
    <td>

    </td>
    </tr>
    
    <tr>
    <td style='padding-bottom:5px;'>
     <div id="ledger-hello-tabs-detail"  ></div>
     <div style="float: both;width: 100%;border: 1px solid #7CA4E9;"   id="operate-task-detail-list-3"> </div>

    </td>
    </tr>
   </table> 
   </div>
   </body>
<script type="text/javascript">
//附表取数操作
function doAttached(audTaskId,projectId){
   top.location="<%=basePath%>attached/file/attachedfile!template2TaskFile.action?audTaskId="+audTaskId+"&projectId="+projectId;
}
</script>
</html>