<%@page language="java" pageEncoding="UTF-8"
	contentType="text/html; charset=utf-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<script type="text/javascript" src="<%=request.getContextPath()%>/pages/introcontrol/util/jquery-1.7.1.min.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/pages/introcontrol/util/jquery.easyui.min.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/pages/introcontrol/util/easyui-lang-zh_CN.js"></script>
		
		<title>实施方案-审计疑点</title>

		<script type="text/javascript">	
 
       //增加疑点
       function addDoubtFrame(){
         if('<%=request.getParameter("taskId")%>'=='-1'){//从“我的疑点”进入的，先建疑点后选择审计事项
           Usp.doTabLoad({url:'/ais/operate/doubt/editDoubt.action?type=FX&project_id=<%=request.getParameter("project_id")%>&taskId=<%=request.getParameter("taskId")%>&taskPid=<%=request.getParameter("taskPid")%>',
		   isFrame:true,
		   tabId:'common-data-dataframe-tab',//tab容器id
           pid:'common-data-dataframe-tab4'});//父id
         }else{//从审计事项进入，需要判断是否有权增加
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

		  Usp.doTabLoad({url:'/ais/operate/doubt/editDoubt.action?type=FX&project_id=<%=request.getParameter("project_id")%>&taskId=<%=request.getParameter("taskId")%>&taskPid=<%=request.getParameter("taskPid")%>',
						isFrame:true,
						tabId:'common-data-dataframe-tab',//tab容器id
		                pid:'common-data-dataframe-tab4'});//父id
		                
		  }              
		}

        //编辑疑点
		function editDoubtFrame(id){
			Usp.doTabLoad({url:"/ais/operate/doubt/editDoubt.action?type=FX&doubt_id="+id+"&project_id=<%=request.getParameter("project_id")%>&taskId=<%=request.getParameter("taskId")%>&taskPid=<%=request.getParameter("taskPid")%>",
		    isFrame:true,
			tabId:'common-data-dataframe-tab',
			pid:'common-data-dataframe-tab4'});
		}

	 

	 
		
		//---------------ext开始----------------
		//-------------------------------------
		Ext.onReady(function(){

			Ext.BLANK_IMAGE_URL = '/ais/cloud/styles/extjs/resources/images/default/s.gif'; 
   			var win;//查询窗口
			//----------toolbar审计疑点工具栏-------开始----------
			//按钮的图片样式见/WebRoot/cloud/styles/js/main.js文件
			var toolbarDoubt=new Usp.ToolBar();
			toolbarDoubt.addBtn({btnType:'-'});
	
			<%
			String right=request.getParameter("isView");//查看权限
			String left=request.getParameter("view");
			%>
			
			//alert('${view}');
      		if('<%=right%>' == 'true' || '<%=left %>'=='view'){
          		toolbarDoubt.addBtn({btnType:'VIEW',btnStyle:'visible',handler:viewDoubt});
      		}else{
	          toolbarDoubt.addBtn({btnType:'ADD',btnStyle:'visible',handler:addDoubt});
		      toolbarDoubt.addSeparator(); 
		      toolbarDoubt.addBtn({btnType:'EDIT',btnStyle:'visible',handler:editDoubt});
		      toolbarDoubt.addSeparator(); 
		      toolbarDoubt.addBtn({btnType:'VIEW',btnStyle:'visible',handler:viewDoubt});
		      toolbarDoubt.addSeparator(); 
		      toolbarDoubt.addBtn({btnType:'DEL',btnStyle:'visible',handler:piliangDel});  
		      toolbarDoubt.addSeparator(); 
		      toolbarDoubt.addBtn({btnType:'CHECK',btnStyle:'visible',handler:outDoubt});
		      toolbarDoubt.addSeparator(); 
		      toolbarDoubt.addBtn({btnType:'IN',btnStyle:'visible',handler:inDoubt});
		      toolbarDoubt.addSeparator(); 
		      toolbarDoubt.addBtn({btnType:'SEARCH',btnStyle:'visible',handler:search});
			}
	     //----------toolbar审计疑点工具栏-------结束----------
	     
	     
	     
	     
         //----------审计疑点grid-------开始------------------
         var dataModelDoubt={url:'${pageContext.request.contextPath}/operate/doubtExt/doubtListJson.action?flushdata=true&taskId=<%=request.getParameter("taskId")%>&permission=<%=request.getParameter("permission")%>&isView=<%=request.getParameter("isView")%>&project_id=<%=request.getParameter("project_id")%>&interaction=${interaction}',
             cells:['doubt_id','doubt_status','task_code',,'audit_dept_name','task_name','doubt_statusName','fileCount','doubt_code','doubt_name','doubt_author','doubt_author_code','doubt_date','doubt_manu','doubt_manu_name']
		};
        
        var viewModelDoubt=[{header:'doubt_id',dataIndex:'doubt_id',hidden:true,sortable:true},
         {header:'<div style="text-align:center">疑点名称</div>',dataIndex:'doubt_name',width:150,renderer: formatQtip},
    	 {header:'疑点状态',dataIndex:'doubt_statusName',width:100,sortable:true,align:'center'},
         {header:'疑点编码',dataIndex:'doubt_code',sortable:true,width:120,align:'center'},
         {header:'被审计单位',dataIndex:'audit_dept_name',sortable:true,width:150,align:'center'},
         {header:'审计事项',dataIndex:'task_name',width:130,sortable:true,align:'center'},
         {header:'撰写人',dataIndex:'doubt_author',sortable:true,width:100,align:'center'},
         {header:'附件',dataIndex:'fileCount',sortable:true,width:50,align:'center'},
         {header:'关联底稿',dataIndex:'doubt_manu_name',renderer:setYD,width:80,sortable:true,align:'center'},
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
         
        var gridDoubt =new Usp.Grid({
          gridConfig:{id:'common-data-datadetaillist-g2',collapsible:true,autoHeight:false,height:Ext.getBody().getHeight()-panleHeight,collapsed:
           false,
           tbar:toolbarDoubt.getToolPanel()},
		   isSelect:'2',
		   isRowNo:'1',
		   dataModel:dataModelDoubt,
		   viewModel:viewModelDoubt,
		   limit:${page.limit1000}
		});
		
		//taskPid不同，显示的数据不同，taskPid=-1，显示全部的数据，taskPid为树节点的id 显示的是本级和下级的数据
       <%String s=request.getParameter("taskPid");%>
         <% if("-1".equals(s)||s==null){%>
           gridDoubt.getGridPanel().loadData({'audDoubt.flushdata':'1','audDoubt.doubt_type':'YD','audDoubt.project_id':'<%=request.getParameter("project_id")%>','audDoubt.task_id':'-1'});
        <%}else{%>
           gridDoubt.getGridPanel().loadData({'audDoubt.flushdata':'1','audDoubt.doubt_type':'YD','audDoubt.project_id':'<%=request.getParameter("project_id")%>','audDoubt.task_id':'<%=request.getParameter("taskId")%>'});
        <%}%>
        
       //----------审计疑点grid-------结束------------------
       
	  //panel
      var singlePanel=new Usp.SinglePanel();
      singlePanel.main.add(gridDoubt.getGridPanel());
      singlePanel.main.render('operate-opr_doubt-operate_doubt_list');
  
  
  
   
   //----------ext的handler方法-------开始------------------
   
    //增加疑点
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
    //单击事件 
    gridDoubt.getGridPanel().addListener('rowdblclick', rowdblclickFn);  
    function rowdblclickFn(grid, rowindex, e){  //单击事件    
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
      
    
     //渲染关联疑点为一个链接
     function setYD(value, cellmeta, record, rowIndex, columnIndex,store) { 
       
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
    
      
      
      
   	//增加疑点
   	function addDoubt(){
   	 if(isGoOn()){
		   return false;
	   }
      addDoubtFrame();
      
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
    
    //编辑疑点
    function editDoubt(){
    	 if(isGoOn()){
  		   return false;
  	   }
    	if(isSingle(gridDoubt.getGridPanel())){
     		var doubt_author=gridDoubt.getFieldValue('doubt_author');
     		var doubt_author_code = gridDoubt.getFieldValue('doubt_author_code');
      		var doubt_status=gridDoubt.getFieldValue('doubt_status');
       		var doubt_id=gridDoubt.getFieldValue('doubt_id');
       		//alert("${user.floginname}***"+doubt_author_code+"^^^^");
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
        	editDoubtFrame(doubt_id,'YD');
        }
      }
    }
      
      
      //查看疑点  
      function viewDoubt(){
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
	
	       if(checkCode=='1' || checkCode=='2'){
	       
	       }else{
	           alert("疑点已删除,请刷新数据后重新操作！");
		       return false;
	       }
      		window.open("${contextPath}/operate/doubt/view.action?type=YD&doubt_id="+doubt_id,"","height=700px, width=800px, toolbar=no, menubar=no, scrollbars=yes,resizable=yes,location=no, status=no");
      	}else{
      	}
      }
   
 



     //批量删除疑点
     function piliangDel(){
        var selectedRows = (gridDoubt.getGridPanel()).getSelectionModel().getSelections(); 
          if(selectedRows.length == 0){
        	Ext.Msg.show({
                    title: '', 
                    msg: '请选择要删除的记录!',
                    icon: Ext.Msg.INFO,
                    minWidth: 300,
                    buttons: Ext.Msg.OK
                  	});
        }   
        var str = "";
        var myDoubt=new Array()
 
        if(selectedRows.length==1){//一条数据，走单独删除
           delDoubt();
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
    function delDoubt(){
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
	       { namespace:'/operate/doubt', action:'checkStatus', executeResult:'false' }, 
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
    
     
     
     //恢复疑点状态为未处理
     function inDoubt(){
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
	    	   
	       }else if(checkCode=='2'){
	    	   alert("该疑点已经生成底稿，不可恢复！");
	    	   return false;
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
      
       //处理审计疑点
     function outDoubt(){
     	if(isSingle(gridDoubt.getGridPanel())){//是否是单选一条
        var doubt_author_code = gridDoubt.getFieldValue('doubt_author_code');
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
		  
		    var title = "录入处理无问题原因";
           	showPopWin('${contextPath}/operate/doubt/editDoubtReason.action?chuli=1&doubt_id='+id,600,400,title);           
     
          /*if(confirm("是否录入处理无问题原因?\n点‘确定’按钮录入处理无问题原因，点‘取消’按钮直接处理疑点。")){
           
           	var title = "录入处理无问题原因";
           	showPopWin('${contextPath}/operate/doubt/editDoubtReason.action?chuli=1&doubt_id='+id,600,400,title);
          }else{
         	Usp.doPost({
       				component:gridDoubt,
       				msg:'确认处理疑点吗?',
       				url:'${pageContext.request.contextPath}/operate/doubtExt/doubtIn.action',
       				params:{'audDoubt.doubt_id':id,'audDoubt.doubt_status':'050'}
       				});
         	}*/
      	 }
      }
    
       //----------ext的handler方法-------开始------------------
    
      
      
      //-------------ext疑点查询form开始------------------
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
      

    
      function search(){
          if(!win){
            win = new Ext.Window({
                applyTo:'doubt-hello-win',
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
                        win.hide();
                    }
                }]
            });
        }  
        win.show(this);
     }
    

     //-------------ext疑点查询form结束------------------
    
    
    
 
	});
    //-------------ext用到的handler方法结束------------------
    
    
     //查看底稿
    function goDG(s){
	      window.open("/ais/operate/manu/viewAll.action?crudId="+s,"","height=700px, width=800px, toolbar=no, menubar=no, scrollbars=yes,resizable=yes,location=no, status=no");
	    }
 
	</script>
	</head>
	<body>
		<div id='operate-opr_doubt-operate_doubt_list'>
		</div>

		<div id="doubt-hello-win">

			<div id="doubt-hello-tabs">

			</div>
		</div>

	</body>
</html>