<%@page language="java" pageEncoding="UTF-8" contentType="text/html; charset=utf-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>我的任务-审计疑点</title>

		<script type="text/javascript">	
		<%String owner="-owner";%>
 
        //增加疑点
		function addDoubtFrameOwner(){
		
		  if('<%=request.getParameter("taskId")%>'=='-1'){
		     Usp.doTabLoad({url:'/ais/operate/doubt/editDoubt.action?owner=true&type=FX&owner=true&groupCode=<%=request.getParameter("groupCode")%>&project_id=<%=request.getParameter("project_id")%>&taskId=<%=request.getParameter("taskId")%>&taskPid=<%=request.getParameter("taskPid")%>',
			 isFrame:true,
			 tabId:'common-data-dataframe-tab<%=owner%>',
		  	 pid:'common-data-dataframe-tab4<%=owner%>'});
		  }else{
			 var auth='0';
		  	 DWREngine.setAsync(false);
			 DWREngine.setAsync(false);DWRActionUtil.execute(
			 {namespace:'/operate/task', action:'checkTaskAssign', executeResult:'false' }, 
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
		  Usp.doTabLoad({url:'/ais/operate/doubt/editDoubt.action?owner=true&groupCode=<%=request.getParameter("groupCode")%>&type=FX&project_id=<%=request.getParameter("project_id")%>&taskId=<%=request.getParameter("taskId")%>&taskPid=<%=request.getParameter("taskPid")%>',
			isFrame:true,
			tabId:'common-data-dataframe-tab<%=owner%>',
		    pid:'common-data-dataframe-tab4<%=owner%>'});
		  }              
		}

        //编辑疑点
		function editDoubtFrameOwner(id){
			Usp.doTabLoad({url:"/ais/operate/doubt/editDoubt.action?owner=true&groupCode=<%=request.getParameter("groupCode")%>&type=FX&doubt_id="+id+"&project_id=<%=request.getParameter("project_id")%>&taskId=<%=request.getParameter("taskId")%>&taskPid=<%=request.getParameter("taskPid")%>",
			isFrame:true,
			tabId:'common-data-dataframe-tab<%=owner%>',
			pid:'common-data-dataframe-tab4<%=owner%>'});
		}

 
        //--ext-----开始----

		Ext.onReady(function(){

			Ext.BLANK_IMAGE_URL = '/ais/cloud/styles/extjs/resources/images/default/s.gif'; 
   			var winYidian; //疑点的查询窗口
			//toolbar
			var toolbarDoubt=new Usp.ToolBar();
			toolbarDoubt.addBtn({btnType:'-'});
	
			<%String right=request.getParameter("isView");%>
       
       		<%if("true".equals(right)){%>
          		  toolbarDoubt.addBtn({btnType:'VIEW',btnStyle:'visible',handler:viewDoubtOwner});//查看
        	<%}else{%>
		          toolbarDoubt.addBtn({btnType:'ADD',btnStyle:'visible',handler:addDoubtOwner});//增加
			      toolbarDoubt.addSeparator(); 
			      toolbarDoubt.addBtn({btnType:'EDIT',btnStyle:'visible',handler:editDoubtOwner});//编辑
			      toolbarDoubt.addSeparator(); 
			      toolbarDoubt.addBtn({btnType:'VIEW',btnStyle:'visible',handler:viewDoubtOwner});//查看
			      toolbarDoubt.addSeparator(); 
			      toolbarDoubt.addBtn({btnType:'DEL',btnStyle:'visible',handler:piliangDelOwner});//删除  
			      toolbarDoubt.addSeparator(); 
			      toolbarDoubt.addBtn({btnType:'CHECK',btnStyle:'visible',handler:outDoubtOwner});//注销
			      toolbarDoubt.addSeparator(); 
			      toolbarDoubt.addBtn({btnType:'IN',btnStyle:'visible',handler:inDoubtOwner});//恢复
			      toolbarDoubt.addSeparator(); 
			      toolbarDoubt.addBtn({btnType:'SEARCH',btnStyle:'visible',handler:searchOwner});//查询
        	<%}%>
	 
			 //疑点grid
	         var dataModelDoubt={url:'${pageContext.request.contextPath}/operate/doubtExt/doubtListJson.action?taskId=<%=request.getParameter("taskId")%>&permission=<%=request.getParameter("permission")%>&isView=<%=request.getParameter("isView")%>&project_id=<%=request.getParameter("project_id")%>&isAll=<%=request.getParameter("isAll")%>',
	             cells:['doubt_id','doubt_status','task_code',,'audit_dept_name','task_name','doubt_statusName','fileCount','doubt_code','doubt_name','doubt_author','doubt_author_code','doubt_date','doubt_manu']
			 };
             //view
       		 var viewModelDoubt=[{header:'doubt_id',dataIndex:'doubt_id',hidden:true,sortable:true},
	         {header:'<div style="text-align:center">疑点名称</div>',dataIndex:'doubt_name',width:150,renderer: formatQtip},
	    	 {header:'疑点状态',dataIndex:'doubt_statusName',width:100,sortable:true,align:'center'},
	         {header:'疑点编码',dataIndex:'doubt_code',sortable:true,width:120,align:'center'},
	         {header:'被审计单位',dataIndex:'audit_dept_name',sortable:true,width:150,align:'center'},
	         {header:'审计事项',dataIndex:'task_name',width:130,sortable:true,align:'center'},
	         {header:'撰写人',dataIndex:'doubt_author',sortable:true,width:100,align:'center'},
	         {header:'附件',dataIndex:'fileCount',sortable:true,width:50,align:'center'},
	         {header:'关联底稿',dataIndex:'doubt_manu',renderer:setYD,width:80,sortable:true,align:'center'},
	         {header:'提交日期',dataIndex:'doubt_date',sortable:true,align:'center',width:100,
	        	 renderer:function(value,cellmeta,record,rowIndex,columnIndex,color_store){
	             if(value!=null){
	                  return value.substring(0,10);
	             }else{
	                 return null;
	             }
           		} 
          		}
         	];	
         	//height:Ext.getBody().getHeight()-panleHeight
	        var gridDoubt =new Usp.Grid({
	            gridConfig:{title:'审计疑点',id:'common-data-datadetaillist-g2<%=owner%>',collapsible:true,autoHeight:false,collapsed:
	            false,height:window.screen.availHeight-260,
	            tbar:toolbarDoubt.getToolPanel()},
			    isSelect:'2',
				isRowNo:'1',
				dataModel:dataModelDoubt,
				viewModel:viewModelDoubt,
				limit:${page.limit20}
			});
		
		//加载数据，传递参数
        <%String s=request.getParameter("taskPid");%>
        <%if("-1".equals(s)||s==null){%>
           gridDoubt.getGridPanel().loadData({'audDoubt.flushdata':'1','audDoubt.doubt_type':'YD','audDoubt.project_id':'<%=request.getParameter("project_id")%>','audDoubt.task_id':'-1'});
        <%}else{%>
           gridDoubt.getGridPanel().loadData({'audDoubt.flushdata':'1','audDoubt.doubt_type':'YD','audDoubt.project_id':'<%=request.getParameter("project_id")%>','audDoubt.task_id':'<%=request.getParameter("taskId")%>'});
        <%}%>
        
      
       
		//panel渲染
	     var singlePanel=new Usp.SinglePanel();
	     singlePanel.main.add(gridDoubt.getGridPanel());
	     singlePanel.main.render('operate-opr_doubt-operate_doubt_list<%=owner%>');
	  
  
  
	   //handler处理，增加疑点
	    function add(){
	      addDigaoFrame();
	    }	
       //提示信息
	    function formatQtip(data,metadata){ 
	    	var title ="";
	    	var tip =data; 
	    	metadata.attr = 'ext:qtitle="' + title + '"' + ' ext:qtip="' + '双击查看' + '"';  
	    	return data;  
	   	}
	   	
       //双击查看疑点
	   gridDoubt.getGridPanel().addListener('rowdblclick', rowdblclickFn);  
	   function rowdblclickFn(grid, rowindex, e){  //双击事件   
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
	       
	        window.open("${contextPath}/operate/doubt/view.action?type=YD&doubt_id="+doubt_id,"","height=700px, width=800px, toolbar=no, menubar=no, scrollbars=yes,resizable=yes,location=no, status=no"); 
		});  
	    }
      
	     //渲染关联底稿为链接
	     function setYD(value, cellmeta, record, rowIndex, columnIndex,store) { 
	       
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
    
      
      
        //增加疑点
	    function addDoubtOwner(){
	        addDoubtFrameOwner();
	    }	
	    
	    //编辑疑点
	    function editDoubtOwner(){
	    	if(isSingle(gridDoubt.getGridPanel())){
	     		var doubt_author_code=gridDoubt.getFieldValue('doubt_author_code');
	      		var doubt_status=gridDoubt.getFieldValue('doubt_status');
	       		var doubt_id=gridDoubt.getFieldValue('doubt_id');
	     		if('${user.floginname}'==doubt_author_code){
			    }else{
			    	alert("没有权限修改！");
			    	return false;
			    }
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
	                  editDoubtFrameOwner(doubt_id,'YD');
	         }
	        }
         }
         
        
        //查看疑点
        function viewDoubtOwner(){
      		if(isSingle(gridDoubt.getGridPanel())){
       		var doubt_id=gridDoubt.getFieldValue('doubt_id');
       
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
	           alert("疑点已删除,请刷新数据后重新操作！");
		       return false;
	        }
       
      		window.open("${contextPath}/operate/doubt/view.action?type=YD&doubt_id="+doubt_id,"","height=700px, width=800px, toolbar=no, menubar=no, scrollbars=yes,resizable=yes,location=no, status=no");
	      }else{
	    	  //alert("请选择要查看的审计疑点!");
	      }
       }
     
      
 
         
         
      //批量删除疑点
      function piliangDelOwner(){
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
     			if('${user.floginname}'==doubt_author_code){
		    	}else{
		    		Ext.Msg.show({
	                    title: '', 
	                    msg: '所选取的疑点 ['+selectedRows[i].data.doubt_name+'] 没有权限删除！',
	                    icon: Ext.Msg.INFO,
	                    minWidth: 300,
	                    buttons: Ext.Msg.OK
                  	});
		    		return false;
				}
               
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
     			if('${user.floginname}'==doubt_author_code){
		          }else{
		            alert("没有权限删除！");
		        	return false;
		        }
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
        
        //恢复疑点
        function inDoubtOwner(){
     		if(isSingle(gridDoubt.getGridPanel())){
     			var doubt_author_code=gridDoubt.getFieldValue('doubt_author_code');
      			var doubt_status=gridDoubt.getFieldValue('doubt_status');
     			if('${user.floginname}'==doubt_author_code){
		       	  }else{
		          	alert("没有权限恢复！");
		          	return false;
		         }
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
    	
    	//处理底稿
     	function outDoubtOwner(){
     		if(isSingle(gridDoubt.getGridPanel())){
     
     
     		var doubt_author_code=gridDoubt.getFieldValue('doubt_author_code');
      		var doubt_status=gridDoubt.getFieldValue('doubt_status');
     		if('${user.floginname}'==doubt_author_code){
		                     
		     }else{
		      alert("没有权限处理！");
		      return false;
		     }
		                  
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
		           showPopWin('${contextPath}/operate/doubt/editDoubtReason.action?owner=true&chuli=1&doubt_id='+id,600,400,title);
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
    	 
    	 //--查询form-----开始-----
    
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
		  
		 {fieldLabel:'疑点名称',name:'audDoubt.doubt_name',value:'',columnWidth:'1',layout:'form'},
		 {fieldLabel:'审计事项',name:'audDoubt.task_name',value:'',columnWidth:'1',layout:'from'} ,
		 {fieldLabel:'开始日期',name:'audDoubt.start_search',xtype:'datefield',value:'',format: 'Y-m-d',editable:false,columnWidth:'.5',layout:'column'},
		 {fieldLabel:'结束日期',name:'audDoubt.end_search',xtype:'datefield',value:'',format: 'Y-m-d',editable:false,columnWidth:'.5',layout:'column'},
		 {fieldLabel:'撰写人',name:'audDoubt.doubt_author',value:'',columnWidth:'1',layout:'from'},
		 {fieldLabel:'疑点编码',name:'audDoubt.doubt_code',value:'',columnWidth:'1',layout:'from'} ,
		
		    {
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
            }
		 
		 ,{
		  
		        xtype:'combo',
                fieldLabel: '被审计单位',
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
                value:''
            
        },
           new Ext.form.Hidden({name:'audDoubt.task_id',value:'-1'}),
           new Ext.form.Hidden({name:'audDoubt.flushdata',value:'1'}),
		   new Ext.form.Hidden({name:'audDoubt.project_id',value:'<%=request.getParameter("project_id")%>'})
		   
		 
		 
		 ],
		 qbtn:Usp.regButton()};
		 
	     var qform=new Usp.QForm({formConfig:{collapsible :false,collapsed :false,title:'疑点查询'},viewModel:viewModelFrom});
		 function query(){
        	gridDoubt.getGridPanel().getStore().baseParams=Ext.decode(Ext.encode(qform.getFormPanel().getForm().getValues()));
        	gridDoubt.getGridPanel().getStore().baseParams['audDoubt.flushdata']='2';
			gridDoubt.getGridPanel().getStore().reload({params:{start:0,limit:${page.limit}}});

         }
      

    
        function searchOwner(){
          if(!winYidian){
            winYidian = new Ext.Window({
                applyTo:'doubt-hello-win<%=owner%>',
                layout:'form',
                width:500,
                height:245,
                closeAction:'hide',
                plain: true,

                items: qform.getFormPanel(),

                buttons: [
				{text:'查询',handler:query},
				{text:'重置',
				handler:function(){
				formReset(qform.getFormPanel().getForm()); 
				}},{
                    text: '关闭',
                    handler: function(){
                     gridDoubt.getGridPanel().getStore().baseParams['audDoubt.flushdata']='1';
                        winYidian.hide();
                    }
                }]
            });
        }  
        winYidian.show(this);
      }
    
       //--查询form-----结束----

	 });//--ext-----结束----
	 
	 
        //查看底稿
        function goDG(s){
	       window.open("/ais/operate/manu/viewAll.action?crudId="+s,"","height=700px, width=800px, toolbar=no, menubar=no, scrollbars=yes,resizable=yes,location=no, status=no");
	    }
 
	</script>
	</head>
		<body>
			<div id='operate-opr_doubt-operate_doubt_list<%=owner%>'></div>
	
			<div id="doubt-hello-win<%=owner%>">
	        
		        <div id="doubt-hello-tabs<%=owner%>">
		
				</div>
			</div>
	
		</body>
</html>