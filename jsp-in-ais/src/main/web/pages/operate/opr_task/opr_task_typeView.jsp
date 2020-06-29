<!DOCTYPE HTML>
<%@page language="java" pageEncoding="UTF-8" contentType="text/html; charset=utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
		<html>
 
       <script type="text/javascript">	
     //修改方案
   	function edit(){
   	    var resullt=''; 
   	    var s='${project_id}';
   		DWREngine.setAsync(false);
   			DWREngine.setAsync(false);DWRActionUtil.execute(
   		{ namespace:'/operate/task', action:'select', executeResult:'false' }, 
   		{'project_id':s},xxx);
   	     function xxx(data){
   	     result =data['auth'];
            //alert(data['auth']);
   		} 
   	 
   	  if(result=='1'){
   	  }else{
   	  alert("只有组长、副组长和主审有权限修改方案！");
   	  return false;
   	  }
   	  win = window.open('${contextPath}/operate/task/mainReadyEdit.action?project_id=${project_id}','pro','height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no');

   	  var h = window.screen.availHeight;
     	  var w = window.screen.width; 
   		win.moveTo(0,0)   
   		win.resizeTo(w,h) 
   		if(win && win.open && !win.closed) 
            win.focus();
   	}
   	 //修改审计分工
   	 function goedit6(){
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
   		  	alert("只有组长、副组长和主审有权限修改审计分工！");
   		  	return false;
   	  	}
   		  win = window.open('${contextPath}/operate/task/project/mainTaskMember.action?project_id=${project_id}','promember','height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no');
   		  var h = window.screen.availHeight;
   	  	  var w = window.screen.width; 
   			win.moveTo(0,0)   
   			win.resizeTo(w,h) 
   			if(win && win.open && !win.closed) 
   	         win.focus();
   	}
   	
   	
   	//回传方案
   	function goedit3(){
       	var resullt=''; 
   	    var s='${project_id}';
   		DWREngine.setAsync(false);
   		DWREngine.setAsync(false);DWRActionUtil.execute(
   		{ namespace:'/operate/task', action:'select', executeResult:'false' }, 
   		{'project_id':s},xxx);
   	     function xxx(data){
   	     result =data['auth'];
            //alert(data['auth']);
   		} 
   	 
   	  	if(result=='1'){
   	 	 }else{
   		  	alert("只有组长、副组长和主审有权限回传改方案！");
   		  	return false;
   	  	}
   		var title="回传方案";
   	    window.open('${contextPath}/operate/task/generate.action?project_id=${project_id}','ret','height=300px, width=500px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no');
       
       
   	}
   	
       //导出方案
   	function goedit4(){
	    var _url = "${contextPath}/commons/oaprint/manuTemplateList.action?moduleid=EnforceTemplate&projectId=${project_id}";
	    window.open(_url);
   	}
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
	  		window.open("${contextPath}/operate/doubt/view.action?type=YD&doubt_id="+s,"","height=600px, width=600px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no");
	    }
	    //执行，打开底稿
		  function digao(project_id,taskId,taskPid,sq,isView,isPem){
		         Usp.doTabPanel({
				     height:Ext.getBody().getHeight()-98, 
			         id:'common-data-dataframe-tab1',
			         pid:'common-data-dataframe-tab',
			         title:'审计底稿',
			         url:'${pageContext.request.contextPath}/operate/manuExt/manuUi.action',
			         params:{project_id:project_id,taskId:taskId,taskPid:taskPid,sq:sq,isView:isView,permission:isPem},
			         refresh:true
		         });
		     }
		 //点“底稿执行“的事件	
		 function digao11(taskId,taskPid){
			var project_id='${audTask.project_id}';
			 var sq='sq';
			 var isView = ${isView};//是否查看 true是
			 //alert(isView + "-" + '${isView}')
			 var isPem='<%=request.getParameter("permission")%>';//权限 full 不走小组授权
			 var isOwner='<%=request.getParameter("owner")%>';//是否在 “我的任务”页签打开
			 var groupCode='<%=request.getParameter("groupCode")%>';//小组
			 isOwner = "true";
			 if(isOwner=='true'){//打开的是我的任务页签
			    digaoOwner(project_id,taskId,taskPid,sq,isView,isPem,isOwner,groupCode);
			 }else{//打开的是实施方案页签
			    digao(project_id,taskId,taskPid,sq,isView,isPem,isOwner);
			 }          
          }
		 function digao22(taskId,taskPid){
				var project_id='${audTask.project_id}';
				 var sq='sq';
				 var isView = ${isView};//是否查看 true是
				 //alert(isView + "-" + '${isView}')
				 var isPem='<%=request.getParameter("permission")%>';//权限 full 不走小组授权
				 var isOwner='<%=request.getParameter("owner")%>';//是否在 “我的任务”页签打开
				 var groupCode='<%=request.getParameter("groupCode")%>';//小组
				 isOwner = "true";
				 if(isOwner=='true'){//打开的是我的任务页签
				    digaoOwner22(project_id,taskId,taskPid,sq,isView,isPem,isOwner,groupCode,'isAll');
				 }else{//打开的是实施方案页签
				    digao(project_id,taskId,taskPid,sq,isView,isPem,isOwner);
				 }          
	          }
		 
		 function digaoListNew(taskId,taskPid){
			 var project_id='${audTask.project_id}';
			 var sq='sq';
			 var isView = 'true';//是否查看 true是
			 var isPem='<%=request.getParameter("permission")%>';//权限 full 不走小组授权
			 var isOwner='<%=request.getParameter("owner")%>';//是否在 “我的任务”页签打开
			 var groupCode='<%=request.getParameter("groupCode")%>';//小组
			 isOwner = "true";
  			 var ownerStr='';
  			 if(isOwner=='true'){
  			    ownerStr='-owner'
  		  	 }
             Usp.doTabPanel({
  		       height:Ext.getBody().getHeight()-88,
  	           id:'common-data-dataframe-tab11',
  	           pid:'common-data-dataframe-tab',
  	           title:'审计底稿',
  	           url:'${pageContext.request.contextPath}/operate/manuExt/manuUiOwnerNew.action',
  	           params:{groupCode:groupCode,project_id:project_id,taskId:taskId,taskPid:taskPid,sq:sq,isView:isView,permission:isPem,owner:isOwner},
  		         refresh:true
  		     });
          }
          
          //点“底稿执行“的事件
          function digao12(taskId,taskPid){
			  var project_id='${audTask.project_id}';
			  
			  var sq='sq';
			  var isView = '${isView}'; 
			  var isPem='<%=request.getParameter("permission")%>';
			  var isOwner='<%=request.getParameter("owner")%>';
			  var groupCode='<%=request.getParameter("groupCode")%>';
	           digaoOwner(project_id,taskId,taskPid,sq,isView,isPem,isOwner,groupCode);
          }

          //点“疑点执行“的事件
          function yidian11(taskId,taskPid){
	          var project_id='${audTask.project_id}';
			  
			  var sq='sq';
			  var isView = '${isView}';
			  var isPem='<%=request.getParameter("permission")%>';
			  var isOwner='<%=request.getParameter("owner")%>';
			  var groupCode='<%=request.getParameter("groupCode")%>';
			  var taskId='<%=request.getParameter("taskId")%>';
			  var taskPid='<%=request.getParameter("taskPid")%>';
			  isOwner=='true';
	          if(isOwner=='true'){
			     yidianOwner(project_id,taskId,taskPid,sq,isView,isPem,isOwner,groupCode);
			  }else{
			    yidian(project_id,taskId,taskPid,sq,isView,isPem);
			  }
          }
          function yidian22(taskId,taskPid){
	          var project_id='${audTask.project_id}';
			  
			  var sq='sq';
			  var isView = '${isView}';
			  var isPem='<%=request.getParameter("permission")%>';
			  var isOwner='<%=request.getParameter("owner")%>';
			  var groupCode='<%=request.getParameter("groupCode")%>';
			  var taskId='<%=request.getParameter("taskId")%>';
			  var taskPid='<%=request.getParameter("taskPid")%>';
			  isOwner='true';
	          if(isOwner=='true'){
			     yidianOwner22(project_id,taskId,taskPid,sq,isView,isPem,isOwner,groupCode,'isAll');
			  }else{
			    yidian(project_id,taskId,taskPid,sq,isView,isPem);
			  }
          }
          
          function yidianListNew(taskId,taskPid){
          	  var project_id='${audTask.project_id}';
			  var sq='sq';
			  var isView = '${isView}';
			  var isPem='<%=request.getParameter("permission")%>';
			  var isOwner='<%=request.getParameter("owner")%>';
			  var groupCode='<%=request.getParameter("groupCode")%>';			  
              var ownerStr='';
      		  if(isOwner=='true'){
      		      ownerStr='-owner';
      		  }
             Usp.doTabPanel({
      	        height:Ext.getBody().getHeight()-88,
                id:'common-data-dataframe-tab4'+ownerStr,
                pid:'common-data-dataframe-tab'+ownerStr,
                title:'审计疑点',
                url:'${pageContext.request.contextPath}/operate/doubtExt/doubtUiOwnerNew.action',
                params:{groupCode:groupCode,project_id:project_id,taskId:taskId,taskPid:taskPid,sq:sq,isView:isView,permission:isPem,owner:isOwner},
                refresh:true
             });
          }
          
          //点“疑点执行“的事件
          function yidian12(taskId,taskPid){
	          var project_id='${audTask.project_id}';
			  
			  var sq='sq';
			  var isView = '${isView}';
			  var isPem='<%=request.getParameter("permission")%>';
			  var isOwner='<%=request.getParameter("owner")%>';
			  var groupCode='<%=request.getParameter("groupCode")%>';
	           yidianOwner(project_id,taskId,taskPid,sq,isView,isPem,isOwner,groupCode);
          }

        //点“审计问题执行“的事件
          function ledgerProblem(taskId,taskPid){
	          var project_id='${audTask.project_id}';
			  var isView = '${isView}';
			  var isPem='<%=request.getParameter("permission")%>';
			  var isOwner='<%=request.getParameter("owner")%>';
			  var groupCode='<%=request.getParameter("groupCode")%>';
	           
	           if(isOwner=='true'){
	        	 auditProblemOwner(project_id,taskId,taskPid,isView,isPem,isOwner,groupCode);
			  }else{
			     auditProblem(project_id,taskId,taskPid,isView,isPem);
			  }
          }
        
        function ledgerProblemNew(taskId,taskPid){
      	  	var project_id='${audTask.project_id}';
			var isView = '${isView}';
			var isPem='<%=request.getParameter("permission")%>';
			var isOwner='<%=request.getParameter("owner")%>';
			var groupCode='<%=request.getParameter("groupCode")%>';
          	var ownerStr='';
  		  	if(isOwner=='true'){
  		    	ownerStr='-owner';
  		  	}
            Usp.doTabPanel({
  	       		height:Ext.getBody().getHeight()-88,
             	id:'common-data-dataframe-tab5'+ownerStr,
             	pid:'common-data-dataframe-tab'+ownerStr,
             	title:'审计问题',
             	url:'${pageContext.request.contextPath}/proledger/problem/oprLedgerProlemUiNew.action',
             	params:{groupCode:groupCode,project_id:project_id,taskId:taskId,taskPid:taskPid,isView:isView,permission:isPem,owner:isOwner},
            	refresh:true
            });
        }
        
          //审计事项下“执行”链接对应的方法，点击打开底稿页签
  		function digao(project_id,taskId,taskPid,sq,isView,isPem){
  	         Usp.doTabPanel({
  		     height:Ext.getBody().getHeight()-98, 
  		     isFrame:true,
  	         id:'common-data-dataframe-tab1',
  	         pid:'common-data-dataframe-tab',
  	         title:'审计底稿',
  	         url:'${pageContext.request.contextPath}/operate/manuExt/manuUi.action',
  	           params:{project_id:project_id,taskId:taskId,taskPid:taskPid,sq:sq,isView:isView,permission:isPem},
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
  			   //此处设置为-1
  			taskId="-1";
            Usp.doTabPanel({
  		       height:Ext.getBody().getHeight()-88,
  	           id:'common-data-dataframe-tab1',
  	           pid:'common-data-dataframe-tab',
  	           title:'审计底稿',
  	           url:'${pageContext.request.contextPath}/operate/manuExt/manuUiOwner.action',
  	           params:{groupCode:groupCode,project_id:project_id,taskId:taskId,taskPid:taskPid,sq:sq,isView:isView,permission:isPem,owner:isOwner},
  		         refresh:true
  		         });
           }
           function digaoOwner22(project_id,taskId,taskPid,sq,isView,isPem,isOwner,groupCode,isAll){
  			   var ownerStr='';
  			   if(isOwner=='true'){
  			    ownerStr='-owner'
  		  	}
  			   //此处设置为-1
  			taskId="-1";
            Usp.doTabPanel({
  		       height:Ext.getBody().getHeight()-88,
  	           id:'common-data-dataframe-tab1',
  	           pid:'common-data-dataframe-tab',
  	           title:'审计底稿',
  	           url:'${pageContext.request.contextPath}/operate/manuExt/manuUiOwner.action',
  	           params:{groupCode:groupCode,project_id:project_id,taskId:taskId,taskPid:taskPid,sq:sq,isView:isView,permission:isPem,owner:isOwner,isAll:isAll},
  		         refresh:true
  		         });
           }
            //左侧实施方案页签下使用的方法 
            //审计事项下“执行”链接对应的方法，点击打开疑点页签
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
          //左侧我的任务页签下使用的方法 
            //审计事项下“执行”链接对应的方法，点击打开审计问题页签
          function yidianOwner(project_id,taskId,taskPid,sq,isView,isPem,isOwner,groupCode){
          
             var ownerStr='';
      		  if(isOwner=='true'){
      		    ownerStr='-owner';
      		  }
      		taskId="-1";
             Usp.doTabPanel({
      	       height:Ext.getBody().getHeight()-88,
              id:'common-data-dataframe-tab4'+ownerStr,
              pid:'common-data-dataframe-tab'+ownerStr,
              title:'审计疑点',
              url:'${pageContext.request.contextPath}/operate/doubtExt/doubtUiOwner.action',
              params:{groupCode:groupCode,project_id:project_id,taskId:taskId,taskPid:taskPid,sq:sq,isView:isView,permission:isPem,owner:isOwner},
             refresh:true
            });
            }
          function yidianOwner22(project_id,taskId,taskPid,sq,isView,isPem,isOwner,groupCode,isAll){
              
              var ownerStr='';
       		  if(isOwner=='true'){
       		    //ownerStr='-owner';
       		  }
       		taskId="-1";
              Usp.doTabPanel({
       	       height:Ext.getBody().getHeight()-panleHeight,
               id:'common-data-dataframe-tab4'+ownerStr,
               pid:'common-data-dataframe-tab'+ownerStr,
               title:'审计疑点',
               url:'${pageContext.request.contextPath}/operate/doubtExt/doubtUiOwner.action',
               params:{groupCode:groupCode,project_id:project_id,taskId:taskId,taskPid:taskPid,sq:sq,isView:isView,permission:isPem,owner:isOwner,isAll:isAll},
              refresh:true
             });
             }
            
           //左侧我的任务页签下使用的方法 
           //审计事项下“执行”链接对应的方法，点击打开审计问题页签
         function auditProblemOwner(project_id,taskId,taskPid,isView,isPem,isOwner,groupCode){
      	  
            var ownerStr='';
  		  if(isOwner=='true'){
  		    ownerStr='-owner';
  		  }
            Usp.doTabPanel({
  	       height:Ext.getBody().getHeight()-88,
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
  		       height:Ext.getBody().getHeight()-88,
  	           id:'common-data-dataframe-tab5',
  	           pid:'common-data-dataframe-tab',
  	           title:'审计问题',
  	           url:'${pageContext.request.contextPath}/proledger/problem/oprLedgerProlemUi.action',
  	           params:{project_id:project_id,taskId:taskId,taskPid:taskPid,isView:isView,permission:isPem},
  	          refresh:true
  	         });
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
             window.open('${contextPath}/operate/task/showContentTypeView.action?node='+q+'&type=1&taskTemplateId='+q+'&project_id=<%=request.getParameter("project_id")%>','',"height=600px, width=700px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no");
           }else{
             window.open('${contextPath}/operate/task/showContentLeafView.action?node='+q+'&type=1&taskTemplateId='+q+'&project_id=<%=request.getParameter("project_id")%>','',"height=600px, width=700px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no");
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
 
    //-----------------ext开始--------------------------
    //-------------------------------------------------
    
    Ext.onReady(function(){
    	
    	/**
    	jQuery('#cttreewrap').css({
    		height:Ext.getBody().getHeight()-panleHeight-2,
            width:'100%'
    	});
    	*/
        //不是末级的审计事项，要显示列表树！！！，html的table就不显示了
        if('${audTask.template_type}'!='2'){
	     
	    var path = "";
	    var nodeId="";
	    
	    var kuandu= (window.screen.width*0.18);//宽度
	    
	    //view
	    var viewModel=[{header:'<div style="text-align:center;font-size:12px;">事项名称</div>',    width:280,dataIndex:'taskName'},
	                   {header:'<div style="text-align:center;font-size:12px;">现场开始时间</div>', width:85,dataIndex:'taskStartTime'},
	                   {header:'<div style="text-align:center;font-size:12px;">现场结束时间</div>', width:85,dataIndex:'taskEndTime'},
	                   {header:'<div style="text-align:center;font-size:12px;">审计小组</div>',    width:150,dataIndex:'group'},
	                   {header:'<div style="text-align:center;font-size:12px;">审计人员</div>',     width:150,dataIndex:'taskAssignName'},
	                   {header:'<div style="text-align:center;font-size:12px;">底稿(已复核/已创建)</div>',   width:130,dataIndex:'dgsum'},
	            	   {header:'<div style="text-align:center;font-size:12px;">疑点(已处理/已创建)</div>',   width:130,dataIndex:'ydsum'},
	           		   {header:'<div style="text-align:center;font-size:12px;">审计问题(入报告/已登记)</div>',width:130,dataIndex:'wtsum'}
	    			    
	    			   ];
	     //tree    			   
	     var tree = new Usp.ColumnTree({
	         		 expanded:true,
		 			 viewModel:viewModel,
		 			 dataUrl:'/ais/pages/operate/task/opr_task_tree_table.jsp', 
				     baseParams:{project_id:'<%=request.getParameter("project_id")%>',task:'-1',taskPid:'<%=request.getParameter("taskId")%>',userCode:'${null!=user?user.floginname:user}'}
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
	    //全部展开
	       	function allExpand(){
	       		tree.getTreePanel().expandAll();
	       	}
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
     
    
    
    
    var winDigao;//底稿查询窗口
    var winYidian;//疑点查询窗口
    
    //-------toolbar工具栏定义开始------------
    //toolbar工具栏，按钮的图片样式见/WebRoot/cloud/styles/js/main.js文件
    
    var toolbar=new Usp.ToolBar();//底稿grid的工具栏
    
	toolbar.addBtn({btnType:'-'});
	toolbar.addBtn({btnType:'VIEW',btnStyle:'visible',handler:view});
	toolbar.addSeparator();
	toolbar.addBtn({btnType:'EXP',btnStyle:'visible',handler:baogao});
	if(${isView != 'true'}){
	 //根据系统参数配置，是否显示底稿反馈按钮
	 if("enabled"=='${digaofankui}'){
	      toolbar.addSeparator(); 
	     toolbar.addBtn({btnType:'COMMENT',btnStyle:'visible',handler:feedback});
	  }
	 }
	 toolbar.addSeparator(); 
	toolbar.addBtn({btnType:'SEARCH',btnStyle:'visible',handler:search});
	toolbar.addSeparator(); 
	toolbar.addBtn({btnType:'EMAIL',btnStyle:'visible',handler:sendMail});
    
	var toolbarDoubt=new Usp.ToolBar();//疑点grid的工具栏
	toolbarDoubt.addBtn({btnType:'-'});
	toolbarDoubt.addBtn({btnType:'VIEW',btnStyle:'visible',handler:viewDoubt});
	toolbarDoubt.addSeparator(); 
	toolbarDoubt.addBtn({btnType:'SEARCH',btnStyle:'visible',handler:searchYidian});

	var toolbarLedger=new Usp.ToolBar();//审计问题grid的工具栏
	toolbarLedger.addBtn({btnType:'-'});
	toolbarLedger.addBtn({btnType:'VIEW',btnStyle:'visible',handler:viewLedgerOwner});
	
	var toolMainbar=new Usp.ToolBar();//窗口上方的工具栏，我的底稿，我的疑点，底稿反馈，查看方案
	<s:if test="interaction==null || interaction==''">
    toolMainbar.addBtn({btnType:'-'});
    toolMainbar.addBtn({btnType:'MYDIGAO',btnStyle:'visible',handler:digao11});//我的底稿
    toolMainbar.addSeparator(); 
    toolMainbar.addBtn({btnType:'MYYIDIAN',btnStyle:'visible',handler:yidian22});//我的疑点
    </s:if>
    
    // add by qfucee, 2014.2.13, 只能由组长或主审进行操作
    if("${viewAllDgYd}" == '1'){
	    toolMainbar.addSeparator();
	    toolMainbar.addBtn({btnType:'AllDIGAO',btnStyle:'visible',handler:digao22});//全部底稿
	    toolMainbar.addSeparator();
	    toolMainbar.addBtn({btnType:'AllYIDIAN',btnStyle:'visible',handler:yidian11});//全部疑点
    }
    // end
    
    
    if(${isView == 'true'}){
    toolMainbar.addSeparator(); 
    toolMainbar.addBtn({btnType:'EXP',btnStyle:'visible',handler:goedit4,text:'导出方案'});
    }else{
   		toolMainbar.addSeparator(); 
	   toolMainbar.addBtn({btnType:'EDIT',btnStyle:'visible',handler:edit,text:'修改方案'});
	   toolMainbar.addSeparator(); 
	   toolMainbar.addBtn({btnType:'MYYIDIAN',btnStyle:'visible',handler:goedit3,text:'回传方案'});
	   toolMainbar.addSeparator(); 
	   toolMainbar.addBtn({btnType:'EXP',btnStyle:'visible',handler:goedit4,text:'导出方案'});
    }
    //add by maotao 增加全部展开按钮
    toolMainbar.addSeparator(); 
	   toolMainbar.addBtn({btnType:'VIEW',btnStyle:'visible',handler:allExpand,text:'全部展开'});
	   toolMainbar.addSeparator(); 
	   
	if(${isView != 'true'}){
      	if("enabled"=='${digaofankui}'){
         toolMainbar.addSeparator(); 
         toolMainbar.addBtn({btnType:'COMMENT',btnStyle:'visible',handler:feedback});//底稿反馈
      	}
	}
		
	      var singlePanel=new Usp.SinglePanel();
		   	singlePanel.main.add(toolMainbar.getToolPanel());
		    singlePanel.main.render('toolbar');  
	//-------toolbar工具栏定义结束------------
 
    
    
     //-------ext的grid定义开始------------
        
        
        //-------底稿的grid定义开始------------
    
     //audTask.template_type不同，显示的数据不同，audTask.template_type=2，显示本级的数据，audTask.template_type=1 显示的是本级和下级的数据
     <s:if test="${audTask.template_type=='2'}">
        var dataModelDigao={url:'${pageContext.request.contextPath}/operate/manuExt/manuListJson.action?permission=<%=request.getParameter("permission")%>&isView=${isView}&project_id=<%=request.getParameter("project_id")%>',
                   cells:['formId','ms_name','ms_author_name','audit_dept_name','task_code','task_name','ms_author','fileCount','audit_found','ms_status','ms_statusName','ms_code','ms_date','project_id','prom','groupId']
		};
     </s:if>
     <s:else>
       var dataModelDigao={url:'${pageContext.request.contextPath}/operate/manuExt/manuListByPidJson.action?permission=<%=request.getParameter("permission")%>&isView=${isView}&project_id=<%=request.getParameter("project_id")%>',
                  cells:['formId','ms_name','ms_author_name','audit_dept_name','task_code','task_name','ms_author','fileCount','audit_found','ms_status','ms_statusName','ms_code','ms_date','project_id','prom','groupId']
		};
	 </s:else>						
		var viewModelDigao=[{header:'formId',dataIndex:'formId',hidden:true,sortable:true},
		 {header:'<div style="text-align:center">底稿名称</div>',dataIndex:'ms_name',sortable:true,width:100,renderer: formatQtip},
    	 {header:'底稿状态',dataIndex:'ms_statusName',sortable:true,width:80,align:'center'},
         {header:'底稿编码',dataIndex:'ms_code',sortable:true,width:70,align:'center'},
         {header:'被审计单位',dataIndex:'audit_dept_name',sortable:true,width:150,align:'center'},
         {header:'审计事项',dataIndex:'task_name',width:80,sortable:true,align:'center'},
         {header:'撰写人',dataIndex:'ms_author_name',sortable:true,width:50,align:'center'},
         {header:'附件',dataIndex:'fileCount',sortable:true,width:30,align:'center'},
         {header:'关联疑点',dataIndex:'audit_found',renderer:setYD,width:70,sortable:true,align:'center'},
         {header:'审计问题数量',dataIndex:'prom',sortable:true,width:80,align:'center'},
         {header:'提交日期',dataIndex:'ms_date',sortable:true,align:'center',width:100,
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
         
        //audTask.template_type不同，显示的数据不同，audTask.template_type=2，显示本级的数据，audTask.template_type=1 显示的是本级和下级的数据
        <s:if test="${audTask.template_type=='2'}">
          var dataModelDoubt={url:'${pageContext.request.contextPath}/operate/doubtExt/doubtListJson.action?permission=<%=request.getParameter("permission")%>&isView=${isView}&project_id=<%=request.getParameter("project_id")%>',
             cells:['doubt_id','doubt_status','doubt_statusName','audit_dept_name','task_code','task_name','doubt_code','fileCount','doubt_name','doubt_author','doubt_author_code','doubt_date','doubt_manu']
		};
        </s:if>
        <s:else>
        var dataModelDoubt={url:'${pageContext.request.contextPath}/operate/doubtExt/doubtListByPidJson.action?permission=<%=request.getParameter("permission")%>&isView=${isView}&project_id=<%=request.getParameter("project_id")%>',
             cells:['doubt_id','doubt_status','doubt_statusName','audit_dept_name','task_code','task_name','doubt_code','fileCount','doubt_name','doubt_author','doubt_author_code','doubt_date','doubt_manu']
		};
        </s:else>
        
         
        
        var viewModelDoubt=[{header:'doubt_id',dataIndex:'doubt_id',hidden:true,sortable:true},
         {header:'<div style="text-align:center">疑点名称</div>',dataIndex:'doubt_name',sortable:true,width:100,renderer: formatQtip},
    	 {header:'疑点状态',dataIndex:'doubt_statusName',sortable:true,width:80,align:'center'},
         {header:'疑点编码',dataIndex:'doubt_code',sortable:true,width:70,align:'center'},
         {header:'被审计单位',dataIndex:'audit_dept_name',sortable:true,width:150,align:'center'},
         {header:'审计事项',dataIndex:'task_name',width:100,sortable:true,align:'center'},
         {header:'撰写人',dataIndex:'doubt_author',sortable:true,width:50,align:'center'},
         {header:'附件',dataIndex:'fileCount',sortable:true,width:30,align:'center'},
         {header:'关联底稿',dataIndex:'doubt_manu',renderer:setDG,width:70,sortable:true,align:'center'},
         {header:'提交日期',dataIndex:'doubt_date',sortable:true,align:'center',width:90,

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
           gridDoubt.getGridPanel().loadData({'audDoubt.flushdata':'1','audDoubt.doubt_type':'YD','audDoubt.project_id':'<%=request.getParameter("project_id")%>','audDoubt.task_id':'-1','taskId':'-1'});
       <%}else{%>
           gridDoubt.getGridPanel().loadData({'audDoubt.flushdata':'1','audDoubt.doubt_type':'YD','audDoubt.project_id':'<%=request.getParameter("project_id")%>','taskPid':'<%=request.getParameter("taskPid")%>','taskId':'<%=request.getParameter("taskId")%>','audDoubt.task_id':'<%=request.getParameter("taskId")%>'});
       <%}%>
       
       
       //-------疑点的grid定义结束------------
       
       //-------审计问题的grid定义开始------------
       
       //audTask.template_type不同，显示的数据不同，audTask.template_type=2，显示本级的数据，audTask.template_type=1 显示的是本级和下级的数据
       <s:if test="${audTask.template_type=='2'}">
         var dataModelLedger={url:'${pageContext.request.contextPath}/proledger/problem/loadLedgerListJson.action?permission=<%=request.getParameter("permission")%>&isView=${isView}&project_id=<%=request.getParameter("project_id")%>',
            cells:['id','manuscript_code','sort_big_name','sort_small_name','problem_name','problem_money','problem_grade_name','manuscript_id','taskAssignName','p_unit','problem_desc']
		};
       </s:if>
       <s:else>
       var dataModelLedger={url:'${pageContext.request.contextPath}/proledger/problem/loadLedgerListByPidJson.action?permission=<%=request.getParameter("permission")%>&isView=${isView}&project_id=<%=request.getParameter("project_id")%>',
    		cells:['id','manuscript_code','sort_big_name','sort_small_name','problem_name','problem_money','problem_grade_name','manuscript_id','taskAssignName','p_unit','problem_desc']
		};
       </s:else>
       
        
       
       var viewModelLedger=[{header:'id',dataIndex:'id',hidden:true,sortable:true},
   	    {header:'底稿编号',dataIndex:'manuscript_code',sortable:true,width:100,align:'center'},
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
     /*var singlePanel1=new Usp.SinglePanel();
     var singlePanel2=new Usp.SinglePanel();
     var singlePanel3=new Usp.SinglePanel();
     singlePanel1.main.add(gridDigao.getGridPanel());//底稿
     singlePanel2.main.add(gridDoubt.getGridPanel());//疑点
     singlePanel3.main.add(gridLedger.getGridPanel());//审计问题
     singlePanel1.main.render('operate-task-detail-list-1');
     singlePanel2.main.render('operate-task-detail-list-2');
     singlePanel3.main.render('operate-task-detail-list-3');*/
  
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
         window.open("${contextPath}/proledger/problem/view.action?&id="+id,"","height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no");
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
        window.open("${contextPath}/operate/doubt/view.action?type=YD&doubt_id="+doubt_id,'',"height=600px, width=600px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no"); 
	});  
    }
    
    //grid的双击事件
    gridDigao.getGridPanel().addListener('rowdblclick', rowdblclickFnManu);  
    function rowdblclickFnManu(grid, rowindex, e){  //双击事件   
   		grid.getSelectionModel().each(function(rec){    
        var formId=rec.get('formId');
       var project_id=gridDigao.getFieldValue('project_id'); 
       if(${isView != 'true'}){
         window.open("${contextPath}/operate/manu/view.action?crudId="+formId+"&project_id="+project_id,'',"height=600px, width=600px, toolbar=no, menubar=no, scrollbars=yes,resizable=yes,location=no, status=no");
	 
       }else{
         window.open("${contextPath}/operate/manu/viewAll.action?crudId="+formId+"&project_id="+project_id,'',"height=600px, width=600px, toolbar=no, menubar=no, scrollbars=yes,resizable=yes,location=no, status=no");
       }
	});  
    }
    
    
    //保存
    function saveMain(){
      window.frames['task_main'].saveFormType();
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
	  	win = window.open("${contextPath}/operate/manu/feedback.action?project_id=<%=request.getParameter("project_id")%>&taskPid=-1","feedback","height=600px, width=600px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no");

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
		    var codeArray3=code3.split(',');
	        var project_id = record.data["project_id"];
	        if(codeArray3[0]!=null&&codeArray3[0]!=''){
	            tt3='<a href=# onclick=goDG(\"'+codeArray3[0]+'\")>'+codeArray3[1]+'</a>';
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
          window.open("${contextPath}/operate/doubt/view.action?type=YD&doubt_id="+doubt_id,'',"height=600px, width=600px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no");
       	}else{
        }
      }

    //查看审计问题
      function viewLedgerOwner(){
    		if(isSingle(gridLedger.getGridPanel())){
     		var id=gridLedger.getFieldValue('id');
    		window.open("${contextPath}/proledger/problem/view.action?&id="+id,'',"height=600px, width=600px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no");
	      }
     }
      
      //查看底稿
     function view(){
       if(isSingle(gridDigao.getGridPanel())){
       	 	var formId=gridDigao.getFieldValue('formId');
        	var project_id=gridDigao.getFieldValue('project_id'); 
        	//alert(right);
        	if(${isView != 'true'}){
         	window.open("${contextPath}/operate/manu/view.action?crudId="+formId+"&project_id="+project_id,'',"height=600px, width=600px, toolbar=no, menubar=no, scrollbars=yes,resizable=yes,location=no, status=no");
	 
        	}else{
          		window.open("${contextPath}/operate/manu/viewAll.action?crudId="+formId+"&project_id="+project_id,'',"height=600px, width=600px, toolbar=no, menubar=no, scrollbars=yes,resizable=yes,location=no, status=no");
        	}
      	}else{
      	}
      }
     
 

           
     
      //-------------ext用到的handler方法结束------------------
      
  
      
      
      //-------------ext查询用到的handler方法开始------------------
      
      //底稿查询
       function query(){
        	gridDigao.getGridPanel().getStore().baseParams=Ext.decode(Ext.encode(simpleForm.getForm().getValues()));
        	gridDigao.getGridPanel().getStore().baseParams['audManuscript.flushdata']='2';
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
  //底稿查看
    function view(){
	       if(isSingle(gridDigao.getGridPanel())){
		       var formId=gridDigao.getFieldValue('formId');
		       var project_id=gridDigao.getFieldValue('project_id'); 
	      
		       if(${isView != 'true'}){
		         window.open("${contextPath}/operate/manu/view.action?crudId="+formId+"&project_id="+project_id,"","height=700px, width=700px, toolbar=no, menubar=no, scrollbars=yes,resizable=yes,location=no, status=no");
			 
		       }else{
		         window.open("${contextPath}/operate/manu/viewAll.action?crudId="+formId+"&project_id="+project_id,"","height=700px, width=700px, toolbar=no, menubar=no, scrollbars=yes,resizable=yes,location=no, status=no");
		       }
	      }else{
	    	 // alert("请选择要查看的审计底稿!");
	      }
    }
      //查看底稿
      function goDG(s){
	      window.open("/ais/operate/manu/viewAll.action?crudId="+s,'',"height=600px, width=600px, toolbar=no, menubar=no, scrollbars=yes,resizable=yes,location=no, status=no");
	 }
	</script>
	</head>
	<body onload="shoWarp()">
		<center>
        <div style="float: both;width: 100%;border: 1px solid #BABABA;"   id="operate-task-detail-list-4">
<!--             <br>-->
			<s:if test="${audTask.template_type=='2'}"><!--audTask.template_type=='2'显示一个表格table，就不显示树了-->
        	<div style="float: both;width: 100%;border: 1px solid #ffffff;"   id="operate-task-detail-list-4">
        	<s:form id="myform" onsubmit="return true;"
				action="/ais/operate/template" method="post">
				<table class="ListTable" style='border:1px solid #99bbe8;border-collapse:collapse;'>
					<tr class ="edithead">
						<td colspan="8" style='border: 1px solid #99bbe8;'>
							<a href="javascript:void(0);" onclick="javascript:task(2,'${audTask.taskTemplateId}')" title="${audTask.url}"><div class="divSim" style="cursor:hand">&nbsp;&nbsp;&nbsp;&nbsp;审计事项: ${audTask.url}</div></a>
						</td>
					</tr>
					<tr>
						<td class ="edithead" style="border:1px solid #99bbe8;width: 15%">
                          <div style="text-align:center"> 
							<font color="red"></font>所需资料
							</div>
						</td>
						<td class ="edithead" style="border:1px solid #99bbe8;width: 37%">
							<div style="text-align:center">
								审计程序
							</div>
						</td>
                       <td class ="edithead" style="border:1px solid #99bbe8;width: 10%">
                        	<div style="text-align:center">
                         	    执行人
							</div>
						</td>
						<td class ="edithead" style="border:1px solid #99bbe8;width: 7%">
						   <div style="text-align:center">
                                                         方案附表
                            </div>
						</td>

						<td class ="edithead" style="border:1px solid #99bbe8;width: 7%">
						   <div style="text-align:center">
                                                         底稿
                            </div>
						</td>
						<td class ="edithead" style="border:1px solid #99bbe8;width: 7%">
						   <div style="text-align:center">
                                                        疑点
                            </div>
						</td>
						<td class ="edithead" style="border:1px solid #99bbe8;width: 7%">
						   <div style="text-align:center">
                                                        审计问题
                            </div>
						</td>
						<td class ="edithead" style="border:1px solid #99bbe8;width: 10%">
						   <div style="text-align:center">
                               分项小结
                            </div>
						</td>
					</tr>
					<tr class="titletable1">
						<td style="border:1px solid #99bbe8;width: 15%" id="taskTarget">
                        &nbsp;&nbsp;
						</td>
						<s:hidden name="audTask.taskTarget"  />
						<s:hidden name="audTask.taskTargetView"  />
						<!--标题栏-->
						<td style="border:1px solid #99bbe8;width: 37%;line-height:130%"  id="taskMethod">
                        &nbsp;&nbsp; 
						</td>
                         <s:hidden name="audTask.taskMethod" />
                         <s:hidden name="audTask.taskMethodView" />
						<td style="border:1px solid #99bbe8;width: 10%" align="center">
	                         <s:property value="audTask.taskAssignName"/>
					         <s:hidden name="audTask.taskGroupAssignName" />
						</td>
						<!--标题栏-->

                        <!-- 附表开始 -->
                        <td style="border:1px solid #99bbe8;width: 7%">
						<div style="text-align:center">
                            <% if("true".equals(request.getParameter("owner"))){%>
                                <a href="javascript:void(0);" onclick="javascript:doAttached('${audTask.id}','${audTask.project_id}')" >执行&nbsp;&nbsp;(<s:property value="#session.attachedTemplates"/>)</a>
                        	<%}else{%>
                                <a href="javascript:void(0);" onclick="javascript:doAttached('${audTask.id}','${audTask.project_id}')" >执行&nbsp;&nbsp;(<s:property value="#session.attachedTemplates"/>)</a>
                            <%}%>
                        </div>
						</td>
						<!-- 附表结束 -->
						<td style="border:1px solid #99bbe8;width: 7%">
						<div style="text-align:center">
                             <%if("true".equals(request.getParameter("owner"))){%>
                                <a href="javascript:void(0);" onclick="javascript:digao12('${audTask.taskTemplateId}','${audTask.taskPid}')" title="1该审计事项已有${audTask.manu}个底稿">执行&nbsp;&nbsp;(${audTask.manu})</a>
                        	<%}else{%>
                                <a href="javascript:void(0);" onclick="javascript:digao11('${audTask.taskTemplateId}','${audTask.taskPid}')" title="该审计事项已有${audTask.manu}个底稿">执行&nbsp;&nbsp;(${audTask.manu})</a>
                        
                            <%}%>
                        </div>
						</td>
						<td style="border:1px solid #99bbe8;width: 7%">
						<div style="text-align:center">
                            <%if("true".equals(request.getParameter("owner"))){%>
                                 <a href="javascript:void(0);" onclick="javascript:yidian12('${audTask.taskTemplateId}','${audTask.taskPid}')" title="该审计事项已有${audTask.doubt}个疑点">执行&nbsp;&nbsp;(${audTask.doubt})</a>
                            <%}else{%>
                                 <a href="javascript:void(0);" onclick="javascript:yidian11('${audTask.taskTemplateId}','${audTask.taskPid}')" title="该审计事项已有${audTask.doubt}个疑点">执行&nbsp;&nbsp;(${audTask.doubt})</a>
                            
                            <%}%>
                        </div>
						</td>
						<td style="border:1px solid #99bbe8;width: 7%">
						<div style="text-align:center">
                            <%if("true".equals(request.getParameter("owner"))){%>
                                 <a href="javascript:void(0);" onclick="javascript:ledgerProblem('${audTask.taskTemplateId}','${audTask.taskPid}')" title="该审计事项已有${audTask.ledgerNum}个审计问题">执行&nbsp;&nbsp;(${audTask.ledgerNum})</a>
                            <%}else{%>
                                 <a href="javascript:void(0);" onclick="javascript:ledgerProblem('${audTask.taskTemplateId}','${audTask.taskPid}')" title="该审计事项已有${audTask.ledgerNum}个审计问题">执行&nbsp;&nbsp;(${audTask.ledgerNum})</a>
                            
                            <%}%>
                        </div>
						</td>
						<td style="border:1px solid #99bbe8;width: 10%">
							<s:if test="${isView != 'true' }">
	                        <div style="text-align:center">
                              <a href="javascript:void(0);" onclick="javascript:jielun()" >编辑</a>&nbsp;&nbsp;<a href="javascript:void(0);" onclick="javascript:jielunView()" >查看</a>
                            </div>
                            </s:if><s:else>
                            	<div style="text-align:center">
                             		 <a href="javascript:void(0);" onclick="javascript:jielunView()" >查看</a>
                            	</div>
                            </s:else>
						</td>
					</tr>

				    </table>
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
           <div id='cttreewrap' style="overflow-x:auto;width:100%;" >
             <table align="center" class="ListTable2">
					<tr class="titletable1">
					<td>
						<!-- <div align="left" style="font-size: 13px;font-weight: bold;" >审计事项
				      	 <a href="javascript:void(0);" onclick="javascript:task(1,'${audTask.taskTemplateId}')" title="${audTask.url}"><div class="divSim" style="cursor:hand">&nbsp;&nbsp;&nbsp;&nbsp;审计事项: ${audTask.url}</div></a>
				     	</div>-->
				     	<div style="float: both;width: 100%;border: 1px solid #7CA4E9;"   id="toolbar"> </div>
                    	<div style="float: both;align:left;width: 100%;border: 1px solid #7CA4E9"    id="tree-ct"></div>
                    </td>
 
					</tr>
					 
				</table>
          </div>
          </s:else>
		</center>
  
	<form id="myform2" name="my_form2" action="/ais/operate/doubt/exportDigao.action?isArray=false" method="post" style="">
		<s:hidden name="manuIds" />
				
	</form>
	<!-- 下面是底稿和疑点的grid显示
	<table align="center" class="ListTable2">
   <tr>
    <td>
       <div id="manu-hello-win">
       </div> 
        <div id="manu-hello-tabs-detail"  ></div>
         
     <div style="float: both;align:right;width: 100%;border: 1px solid #7CA4E9"   id="operate-task-detail-list-1"> 
        
     </div>
    </td>
   </tr>
   
     <tr>
    <td>
     <div id="doubt-hello-tabs-detail"  ></div>
     <div style="float: both;width: 100%;border: 1px solid #7CA4E9;"   id="operate-task-detail-list-2"> </div>
    </td>
    </tr>
    
    <tr>
    <td>
    </td>
    </tr>
    
    <tr>
    <td>
     <div id="ledger-hello-tabs-detail"  ></div>
     <div style="float: both;width: 100%;border: 1px solid #7CA4E9;"   id="operate-task-detail-list-3"> </div>

    </td>
    </tr>
   </table>  -->
   </body>
<script type="text/javascript">
//附表取数操作
function doAttached(audTaskId,projectId){//修改为模态窗体
   var num=Math.random();
	var rnm=Math.round(num*9000000000+1000000000);//随机参数清除模态窗口缓;
	var v = window.showModalDialog("${contextPath}/attached/file/attachedfile!template2TaskFile.action?audTaskId="+audTaskId+"&projectId="+projectId+"&rnm="+rnm,"","dialogWidth:"+window.screen.availHeight+"px;dialogHeight:"+window.screen.availWidth+"px;status:yes;resizable:yes;");
	if(v){
	   window.location.href = window.location.href;
	}
}
</script>
</html>


 

