<%@page language="java" pageEncoding="UTF-8" contentType="text/html; charset=utf-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>我的任务-审计底稿</title>



		<script type="text/javascript">	
		//增加底稿
		 function addDigaoFrameOwner(){
  			if('<%=request.getParameter("taskId")%>'=='-1'){
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
				Usp.doTabLoad({url:'/ais/operate/manu/edit.action?owner=true&groupCode=<%=request.getParameter("groupCode")%>&project_id=<%=request.getParameter("project_id")%>&taskId=<%=request.getParameter("taskId")%>&taskPid=<%=request.getParameter("taskPid")%>',
					isFrame:true,
					tabId:'common-data-dataframe-tab',
	                pid:'common-data-dataframe-tab1'});
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


 
 

 
		//---------------ext开始----------------
		//-------------------------------------
 
		Ext.onReady(function(){
			Ext.BLANK_IMAGE_URL = '/ais/cloud/styles/extjs/resources/images/default/s.gif';
			var win;//查询窗口
			//----------toolbar审计底稿工具栏-------开始----------
			//按钮的图片样式见/WebRoot/cloud/styles/js/main.js文件
		    var toolbar=new Usp.ToolBar();
    		<%String right=request.getParameter("isView");%>//查看权限
         	  	 toolbar.addBtn({btnType:'-'});
        	<%if("true".equals(right)){%>
          	  	toolbar.addBtn({btnType:'VIEW',btnStyle:'visible',handler:viewOwner});
        	<%}else{%>
		          toolbar.addBtn({btnType:'ADD',btnStyle:'visible',handler:addOwner});
			      toolbar.addSeparator(); 
			      toolbar.addBtn({btnType:'EDIT',btnStyle:'visible',handler:editOwner});
			      toolbar.addSeparator(); 
			      toolbar.addBtn({btnType:'VIEW',btnStyle:'visible',handler:viewOwner});
			      toolbar.addSeparator(); 
			      toolbar.addBtn({btnType:'DEL',btnStyle:'visible',handler:piliangDelOwner});
			      toolbar.addSeparator(); 
			      toolbar.addBtn({btnType:'OUT',btnStyle:'visible',handler:manuOutOwner});
			      toolbar.addSeparator(); 
			      toolbar.addBtn({btnType:'IN',btnStyle:'visible',handler:manuInOwner});
			      toolbar.addSeparator(); 
			      toolbar.addBtn({btnType:'SUBMIT',btnStyle:'visible',handler:piliangOwner});
			      toolbar.addSeparator(); 
			      toolbar.addBtn({btnType:'EXP',btnStyle:'visible',handler:baogaoOwner});
			      toolbar.addSeparator(); 
			      toolbar.addBtn({btnType:'SEARCH',btnStyle:'visible',handler:searchOwner});
		      if("enabled"=='${taizhang}'){//台帐系统参数
			      toolbar.addSeparator(); 
			      toolbar.addBtn({btnType:'PROBLEM',btnStyle:'visible',handler:taizhangOwner});
		      }
		      
		      toolbar.addSeparator();
	        <%}%>
	        
	         //----------toolbar审计底稿工具栏------结束----------
	         
	         
			//----------审计底稿grid-------开始------------------

     
	        var dataModelDigao={url:'${pageContext.request.contextPath}/operate/manuExt/manuListJsonNew.action?taskId=<%=request.getParameter("taskId")%>&permission=<%=request.getParameter("permission")%>&isView=<%=request.getParameter("isView")%>&project_id=<%=request.getParameter("project_id")%>',
	                   cells:['formId','ms_name','ms_author_name','manuType','manuTypeName','task_code',,'audit_dept_name','task_name','ms_author','fileCount','audit_found','ms_status','ms_statusName','ms_code','ms_date','project_id','prom','groupId']
			};
				
		    if("enabled"=='${taizhang}'){//台帐系统参数
		      	var viewModelDigao=[{header:'formId',dataIndex:'formId',hidden:true,sortable:true},
				 {header:'<div style="text-align:center">底稿名称</div>',dataIndex:'ms_name',sortable:true,width:150,renderer: formatQtip},
				 {header:'底稿类型',dataIndex:'manuTypeName',width:70,sortable:true,align:'center'},
		    	 {header:'底稿状态',dataIndex:'ms_statusName',width:100,sortable:true,align:'center'},
		         {header:'底稿编码',dataIndex:'ms_code',sortable:true,width:120,align:'center'},
		         {header:'被审计单位',dataIndex:'audit_dept_name',sortable:true,width:150,align:'center'},
		         {header:'审计事项',dataIndex:'task_name',width:130,sortable:true,align:'center'},
		         {header:'撰写人',dataIndex:'ms_author_name',sortable:true,width:100,align:'center'},
		         {header:'附件',dataIndex:'fileCount',sortable:true,width:50,align:'center'},
		         {header:'关联疑点',dataIndex:'audit_found',renderer:setYD,sortable:true,width:80,align:'center'},
		         {header:'审计问题数量',dataIndex:'prom',sortable:true,width:80,align:'center'},
		         {header:'提交日期',dataIndex:'ms_date',sortable:true,width:100,align:'center',
	
		        	 renderer:function(value,cellmeta,record,rowIndex,columnIndex,color_store){
			             if(value!=null){
			             
			              return value.substring(0,10);
			             }else{
			                 return null;
			             }
	           			} 
	             	}
	         	];	
		     }else{
			     var viewModelDigao=[{header:'formId',dataIndex:'formId',hidden:true,sortable:true},
				 {header:'<div style="text-align:center">底稿名称</div>',dataIndex:'ms_name',width:150,renderer: formatQtip},
		    	 {header:'底稿状态',dataIndex:'ms_statusName',width:70,sortable:true,align:'center'},
		         {header:'底稿编码',dataIndex:'ms_code',sortable:true,width:120,align:'center'},
		         {header:'<div style="text-align:center">审计事项</div>',dataIndex:'task_name',width:130},
		         {header:'撰写人',dataIndex:'ms_author_name',sortable:true,width:100,align:'center'},
		         {header:'附件',dataIndex:'fileCount',sortable:true,width:50,align:'center'},
		         {header:'关联疑点',dataIndex:'audit_found',renderer:setYD,width:80,sortable:true,align:'center'},
		         {header:'提交日期',dataIndex:'ms_date',sortable:true,width:100,align:'center',
		
		        	 renderer:function(value,cellmeta,record,rowIndex,columnIndex,color_store){
		             if(value!=null){
		              	return value.substring(0,10);
		             }else{
		                 return null;
		             }
		            } 
		           }
		         ];	
		      }				
			
			
		 var gridDigao =new Usp.Grid({
            gridConfig:{title:'',collapsible:true,autoHeight:false,height:window.screen.availHeight-260,collapsed:false,
            tbar:toolbar.getToolPanel()},
			isSelect:'2',
			isRowNo:'1',
			dataModel:dataModelDigao,
			viewModel:viewModelDigao,
			limit:${page.limit20}
		});
		
		
		//taskPid不同，显示的数据不同，taskPid=-1，显示全部的数据，taskPid为树节点的id 显示的是本级和下级的数据
		<%String s = request.getParameter("taskPid");%>
       <%if ("-1".equals(s) || s == null) {%>
           gridDigao.getGridPanel().loadData({'audManuscript.flushdata':'1','audManuscript.project_id':'<%=request.getParameter("project_id")%>','audManuscript.task_id':'-1'});
        <%} else {%>
            gridDigao.getGridPanel().loadData({'audManuscript.flushdata':'1','audManuscript.project_id':'<%=request.getParameter("project_id")%>','audManuscript.task_id':'<%=request.getParameter("taskId")%>'});
        <%}%>
        
        //----------审计底稿grid-------结束------------------
      
       
		//panel
	     var singlePanel=new Usp.SinglePanel();
	     singlePanel.main.add(gridDigao.getGridPanel());
	   	 singlePanel.main.render('operate-opr_manu-operate_manu_list-owner');
  
   		//----------ext的handler方法-------开始------------------
   		
   		//增加底稿
	    function addOwner(){
	      addDigaoFrameOwner();
	    }	
    
        //提示信息
	   	function formatQtip(data,metadata){ 
	    	var title ="";
	    	var tip =data; 
	    	metadata.attr = 'ext:qtitle="' + title + '"' + ' ext:qtip="' + '双击查看' + '"';  
	    	return data;  
	   	}
    
    
        //单击事件  
	    gridDigao.getGridPanel().addListener('rowdblclick', rowdblclickFn);  
	    function rowdblclickFn(grid, rowindex, e){  //单击事件   
	   		grid.getSelectionModel().each(function(rec){    
	        var formId=rec.get('formId');
	        var project_id=gridDigao.getFieldValue('project_id'); 
	        <% if(!"true".equals(right)){%>
	         window.open("${contextPath}/operate/manu/view.action?crudId="+formId+"&project_id="+project_id,"","height=700px, width=800px, toolbar=no, menubar=no, scrollbars=yes,resizable=yes,location=no, status=no");
	       <%}else{%>
	         window.open("${contextPath}/operate/manu/viewAll.action?crudId="+formId+"&project_id="+project_id,"","height=700px, width=800px, toolbar=no, menubar=no, scrollbars=yes,resizable=yes,location=no, status=no");
	       <% }%>
		});  
	    }
    
    	//渲染关联疑点为一个链接
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
      	//增加台帐
	    function taizhangOwner(){
	     	if(isSingle(gridDigao.getGridPanel())){
	     		var ms_author=gridDigao.getFieldValue('ms_author');
	        	var ms_status=gridDigao.getFieldValue('ms_status');
	          	if('${user.floginname}'==ms_author){
			   	 }else{
			     	alert("没有权限增加台账！");
			    	return false;
			    }
			                  
	      		if('010'==ms_status||'020'==ms_status||'030'==ms_status||'040'==ms_status){
			   	 }else if('060'==ms_status){
			   	    alert("底稿已经注销,不能增加台账！");
			    	return false;
			     }else{
			     	alert("底稿已经复核完毕,不能增加台账！");
			     	return false;
			     }
	   			var formId=gridDigao.getFieldValue('formId');
	    		window.open("/ais/proledger/problem/listDigaoEditProblem.action?project_id=<%=request.getParameter("project_id")%>&manuscript_id="+formId+"&view=add","","height=700px, width=800px, toolbar=no, menubar=no, scrollbars=yes,resizable=yes,location=no, status=no");
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
               if('${user.floginname}'==selectedRows[i].data.ms_author){
               }else{
                  Ext.Msg.show({
                    title: '', 
                    msg: '所选取的底稿 ['+selectedRows[i].data.ms_name+'] 没有权限修改,不能批量提交审批流程,请单独提交!',
                    icon: Ext.Msg.INFO,
                    minWidth: 300,
                    buttons: Ext.Msg.OK
                  }); 
                  return false;
               }
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
                   if('${user.floginname}'==selectedRows[i].data.ms_author){
               		}else{
                  	Ext.Msg.show({
                    title: '', 
                    msg: '所选取的底稿 ['+selectedRows[i].data.ms_name+'] 没有权限删除,不能批量删除!',
                    icon: Ext.Msg.INFO,
                    minWidth: 300,
                    buttons: Ext.Msg.OK
                  	}); 
                  		return false;
               		}
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
    
      
       //编辑底稿
	   function editOwner(){
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
		    		editDigaoFrameOwner(ms_id);
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
							editDigaoFrameUrlOwner(ms_id,url);
					    }
					}
			 	}
	   		 }
	   } 
    	
     
         //查看底稿
	     function viewOwner(){
	       	if(isSingle(gridDigao.getGridPanel())){
		       var formId=gridDigao.getFieldValue('formId');
		       var project_id=gridDigao.getFieldValue('project_id'); 
		       <% if(!"true".equals(right)){%>
		         window.open("${contextPath}/operate/manu/view.action?crudId="+formId+"&project_id="+project_id,"","height=700px, width=800px, toolbar=no, menubar=no, scrollbars=yes,resizable=yes,location=no, status=no");
		       <%}else{%>
		         window.open("${contextPath}/operate/manu/viewAll.action?crudId="+formId+"&project_id="+project_id,"","height=700px, width=800px, toolbar=no, menubar=no, scrollbars=yes,resizable=yes,location=no, status=no");
		       <% }%>
		      }else{
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

 
    
    	
      
       //导出底稿
       function baogaoOwner(){
       		var selectedRows = (gridDigao.getGridPanel()).getSelectionModel().getSelections(); 
        	if(selectedRows.length==0){
            	 alert("请选择要导出的底稿!");
           		 return;
       		}                     
      		var str = "";
      		for(i=0;i <selectedRows.length;i++){
               str += selectedRows[i].data.formId + ","; 
      		}                                   
      		document.getElementsByName('manuIds2')[0].value=str;
    		 myform22.submit();
	  }
	
	
	
	  //-------------ext用到的handler方法结束------------------
	
	
      //-------------ext底稿查询form开始------------------
       var qbtnsForm=[
		{text:'查询',handler:query},
		{text:'重置',
		handler:function(){
			formReset(qform.getFormPanel().getForm()); 
		}}
		];
       var viewModelFrom ={
         layout: 'from',
         cells:[
		  
		 {fieldLabel:'底稿名称',name:'audManuscript.ms_name',value:'',columnWidth:'1',layout:'form'},
		 {fieldLabel:'审计事项',name:'audManuscript.task_name',value:'',columnWidth:'1',layout:'from'} ,
		 {fieldLabel:'开始日期',name:'audManuscript.start_search',xtype:'datefield',value:'',format: 'Y-m-d',editable:false,columnWidth:'.5',layout:'column'},
		 {fieldLabel:'结束日期',name:'audManuscript.end_search',xtype:'datefield',value:'',format: 'Y-m-d',editable:false,columnWidth:'.5',layout:'column'},
		 {fieldLabel:'撰写人',name:'audManuscript.ms_author_name',value:'',columnWidth:'1',layout:'from'},
		 {fieldLabel:'底稿编码',name:'audManuscript.ms_code',value:'',columnWidth:'1',layout:'from'} ,
		
		    {
                xtype:'combo',
                fieldLabel: '底稿状态',
                store :new Ext.data.SimpleStore({
                       fields: ['audManuscript.ms_status', 'ms_statusName'],
                       data : [['010','底稿草稿'],['020','正在征求'],['030','等待复核'],['040','正在复核'],['050','复核完毕'],['060','已经注销']]
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
                value:''
            },{
		  
		        xtype:'combo',
                fieldLabel: '被审计单位',
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
                value:''
            
        },
		 
           new Ext.form.Hidden({name:'audManuscript.task_id',value:'-1'}),
           new Ext.form.Hidden({name:'audManuscript.flushdata',value:'1'}),
		   new Ext.form.Hidden({name:'audManuscript.project_id',value:'<%=request.getParameter("project_id")%>'})
		 ],
		 qbtn:Usp.regButton()};
		 
	    var qform=new Usp.QForm({formConfig:{collapsible :false,collapsed :false,title:'底稿查询'},viewModel:viewModelFrom});
		function query(){
        	gridDigao.getGridPanel().getStore().baseParams=Ext.decode(Ext.encode(qform.getFormPanel().getForm().getValues()));
        	gridDigao.getGridPanel().getStore().baseParams['audManuscript.flushdata']='2';
			gridDigao.getGridPanel().getStore().reload({params:{start:0,limit:${page.limit}}});

         }
      

    
      function searchOwner(){
          if(!win){
            win = new Ext.Window({
                applyTo:'manu-hello-win-owner',
                layout:'form',
                width:500,
                height:245,
                closeAction:'hide',
                plain: false,
                items: qform.getFormPanel(),
                buttons: [
				{text:'查询',handler:query},
				{text:'重置',
				handler:function(){
				formReset(qform.getFormPanel().getForm()); 
				}},{
                    text: '关闭',
                    handler: function(){
                    gridDigao.getGridPanel().getStore().baseParams['audManuscript.flushdata']='1';
                        win.hide();
                    }
                }]
            });
        	}  

        	win.show(this);
    	}
    	//-------------ext底稿查询form结束------------------
    	
    	
        
	});

    //-------------ext结束------------------


    //关闭窗口
    function closeGenW(s){
	  	window.location.reload();
    }

    
      
    //查看疑点 
    function go2(s){
		window.open("${contextPath}/operate/doubt/view.action?type=YD&doubt_id="+s,"","height=700px, width=800px, toolbar=no, menubar=no, scrollbars=yes,resizable=yes,location=no, status=no");
	}
	</script>
	</head>
	
	
	<body>
		<form id="myform22" name="my_form22" target="_blank" action="/ais/operate/doubt/exportDigao.action?isArray=false&is2=true" method="post" style="">
			<s:hidden name="manuIds2" />
			<s:hidden name="manuArray" />
		</form>
		<div id='operate-opr_manu-operate_manu_list-owner' />
		<div id="manu-hello-win-owner" />
		<div id="manu-hello-tabs-owner" />
	</body>
</html>