<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>实施阶段_审计方案_审计事项new</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<!-- <link href="${contextPath}/styles/main/ais.css" rel="stylesheet" type="text/css" />
		<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css" /> -->
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
		<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
		<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
	<%-- 	<script type="text/javascript" src="${contextPath}/pages/tlInteractive/tlInteractiveCommon.js"></script> --%>
		<style type="text/css">
		.datagrid-cell-c1-taskName {
        	height: 25px !important;
       }
       .datagrid-header td, .datagrid-body td, .datagrid-footer td {
       		padding: 0px !important;
       }
		</style>
	</head>	
 
	<body style="margin: 0;padding: 0;overflow:hidden;height: 100%" class="easyui-layout" >
	    <div region="west" split="true"  border="0" style="width:300px;padding:0px;margin:0px;overflow:hidden;">
			<!-- <div style="width: 100%;position:absolute;top:0px;" id="div1" align="center" > -->
			<div region="north" >
				<table class="ListTable" align="center" style='width:100%; padding: 0px; margin: 0px;'>
					<tr class="EditHead">
						<td>
							<span style='float: left; text-align: left;'>被审计单位</span>
						</td>
					</tr>
				</table>
			</div>
			<div region="center">
				<ul id="groupTree"></ul>
			</div>
		</div>
		<div region="center" >
			<table id="resultList"></table>
		</div>
		<div id="dlg" class="easyui-dialog" title="对话框" closed="true" style="width:800px;height:500px;overflow:hidden">
			<iframe scrolling="auto" frameborder="0"  src="" style="width:100%;height:100%;"></iframe>
		</div>
		<script type="text/javascript"> 
		  var groupId = "";
		  var auditObject = "";
			function close_win() {
				closedlg();
			}
			function closedlg() {
				$('#dlg').dialog('close');//('destroy');//('close');
				//doSearch();
			}
  
  			var isAllExpand = false;
   		    $(function() {
   				$("#groupTree").tree({
   					url:'${contextPath}/operate/taskExt/mainTaskUiLeft.action?project_id=${project_id}',
   					onClick: function(node){
   						groupId = node.parentId;
   						auditObject = node.id;
   						$('#resultList').treegrid('load',{'project_id':'${project_id}','groupId':node.parentId,'auditObject':node.id,'queryType':'tree'});
   					},
   					onLoadSuccess:function(node, data){
   						$('#groupTree').tree("expandAll", null);
   						data[0].target.click();
   					}
   				});
		        $('#resultList').treegrid({
		            url : '${pageContext.request.contextPath}/operate/taskExt/mainTaskUi.action',
		            queryParams : {'project_id':'${project_id}','queryType':'tree'},
		            idField : 'taskId',
		            treeField : 'taskName',
		            animate : true,
					showFooter:false,
		            rownumbers : true,
		            parentField : 'taskPid',
					striped:true,
					fit:true,
					autoRowHeight:true,
		            fitColumns : false,
		            border : false,
					cache:false,
					singleSelect:false,
					toolbar:[
					<s:if test="${interaction==null || interaction==''}">
						{
							id:'MYDIGAO',
							text:'我的底稿',
							/* liululu 解决方案：将我的底稿图标变为蓝色 */
							iconCls:'icon-user',
							handler:function(){
								digao11(false);
							}
						},
// 						{
// 							id:'MYYIDIAN',
// 							text:'我的疑点',
// 							iconCls:'icon-user1',
// 							handler:function(){
// 								yidian11(false);
// 							}
// 						},
    					</s:if>
    					// add by qfucee, 2014.2.13, 只能由组长或主审进行操作
//     					<s:if test="${viewAllDgYd == '1'}">
// 						{
// 							id:'AllDIGAO',
// 							text:'全部底稿',
// 							iconCls:'icon-allToMe',
// 							handler:function(){
// 								digao11(true);
// 							}
// 						},
// 						{
// 							id:'AllYIDIAN',
// 							text:'全部疑点',
// 							iconCls:'icon-allToMe',
// 							handler:function(){
// 								yidian11(true);
// 							}
// 						},
//     					</s:if>
    					// end
    					<s:if test="${isView != 'true' and false}">
      					<s:if test="${digaofankui=='enabled'}">
						{
							id:'COMMENT',
							text:'底稿反馈',
							iconCls:'icon-redo',
							handler:function(){
								feedback();
							}
						},
      					</s:if>
						{
							id:'EDIT',
							text:'修改方案',
							iconCls:'icon-edit',
							handler:function(){
								edit();
							}
						},
						{
							id:'MYYIDIAN',
							text:'回传方案',
							iconCls:'icon-redo',
							handler:function(){
								goedit3();
							}
						},
    					</s:if>
						/* {
							id:'export',
							text:'导出方案',
							iconCls:'icon-export',
							handler:function(){
								goedit4();
							}
						}, */
						{    //add by maotao 增加全部展开按钮
							id:'expand',
							text:'展开全部',
							iconCls:'icon-expand',
							handler:function(){
								allExpand();
							}
						},
						{    //add by wangqian 导出所选择的底稿模板
							id:'expand',
							text:'导出所选事项底稿模板',
							iconCls:'icon-export',
							handler:function(){
								ExportTemplate();
							}
						},'-',helpBtn
					],
					frozenColumns:[[
						{field:'taskName',
						title:'事项名称<s:if test="${taskSum!=0}"><p style="color: red;display: inline;">(已分配的审计事项还有${taskSum}个未完成)</p></s:if>',
						width:"400",
						halign:'center',
						align:'left'}
					]],
					columns:[[
						{field:'dgsum',title:'底稿(已复核/已创建)',width:150,align:'center'},
						{field:'ydsum',title:'疑点(已处理/已创建)',width:150,align:'center'},
						{field:'wtsum',title:'问题(入报告/已登记)',width:150,align:'center'},
						/* {field:'group',title:'审计小组',halign:'center',width:100,align:'center'}, */
						{field:'taskAssignName',title:'执行人',width:100,halign:'center',align:'left'},
						{field:'taskStartTime',title:'执行开始时间',halign:'center',width:100,align:'right'},
						{field:'taskEndTime',title:'执行结束时间',halign:'center',width:100,align:'right'}
					]],
					onExpand:function(row){
						if (!isAllExpand) return;
						var children = $("#resultList").treegrid('getChildren',row.taskId);
						if(children.length>0){
							var c;
							for (var i=0;i<children.length;i++) {
								c  = children[i];
								if (c.state=='closed' && c.type=='1')
									$('#resultList').treegrid("expand", c.taskId);
							}
						}
					},
					onLoadSuccess:function(row, data){
						//allExpand();
						initHelpBtn();
						if(data.rows!=null)
							$('#resultList').treegrid("expand", data.rows[0].taskTemplateId);
					}
    		    });
		    });

			//审计事项table上的超链接，1是审计事项的类型分为1和2（末级）
			function task(s,q){
				var url,ttl;
		 		if(s=='1'){
			   		url = '${contextPath}/operate/task/showContentTypeView.action?node='+q+'&type=1&taskTemplateId='+q+'&project_id=<%=request.getParameter("project_id")%>';
			   		ttl = '审计事项查看';
				}else{
			  		url = '${contextPath}/operate/task/showContentLeafView.action?node='+q+'&type=1&taskTemplateId='+q+'&project_id=<%=request.getParameter("project_id")%>';
			  		ttl = '审计事项查看';
				}
				var o=$('#dlg');
				o.dialog({width:'90%',height:'80%',maximizable:true,resizable:true,draggable:true,title: ttl});
				o[0].children[0].src=url;
				o.dialog('open');
			}

			//全部展开
			function allExpand(){
				isAllExpand = true;
				$('#resultList').treegrid("expandAll", null);
				window.setTimeout("isAllExpand = false;", 10000);
			}
			
			//点“底稿执行“的事件	
			function digao11(isAll){
				var taskId = "-1";
				var taskPid = "-1";
				var sq='sq';
				var isView = ${isView};//是否查看 true是
				var isPem='<%=request.getParameter("permission")%>';//权限 full 不走小组授权
				var isOwner='<%=request.getParameter("owner")%>';//是否在 “我的任务”页签打开
				var groupCode='<%=request.getParameter("groupCode")%>';//小组
				isOwner = "true";
				if(isOwner=='true'){//打开的是我的任务页签
				   	digao(taskId,taskPid,sq,isView,isPem,isOwner,groupCode,isAll);
				}else{//打开的是实施方案页签
					var row = $('#resultList').treegrid("getSelected");
					if (!row) {
						$.messager.show({
							title:'消息',
							msg:'没有选中行！'
						});
						return;
					}
					taskId = row.taskId;
					taskPid = row.taskPid;
				   	digao(taskId,taskPid,sq,isView,isPem,isOwner);
				}          
			}
	    	//执行，打开底稿
          	//审计事项下“执行”链接对应的方法，点击打开底稿页签
           	//左侧我的任务页签下使用的方法 
           	//审计事项下“执行”链接对应的方法，点击打开底稿页签
			function digao(taskId,taskPid,sq,isView,isPem,isOwner,groupCode,isAll){
  				var url = '${pageContext.request.contextPath}/operate/manuExt/mainUi.action?view=view&'
  					+'project_id=${project_id}&projectType==${projectType}&taskId='+taskId+'&taskPid='
  					+taskPid+'&sq='+sq+'&isView='+isView+'&permission='+isPem;
  				if (isOwner) url += '&owner='+isOwner;
  				if (groupCode) url += '&groupCode='+groupCode;
  				if (isAll) url += '&isAll=isAll';
				window.parent.addTab('tabs','方案执行(底稿)','tempframeManuList',url,true);
           	}
          	//点“疑点执行“的事件
          	function yidian11(isAll){
				var taskId = "-1";
				var taskPid = "-1";
			  	var sq='sq';
			  	var isView = '${isView}';
			  	var isPem='<%=request.getParameter("permission")%>';
			  	var isOwner='<%=request.getParameter("owner")%>';
			  	var groupCode='<%=request.getParameter("groupCode")%>';
			  	//var taskId='<%=request.getParameter("taskId")%>';
			  	//var taskPid='<%=request.getParameter("taskPid")%>';
			  	isOwner='true';
	          	if(isOwner=='true'){
			     	yidian(taskId,taskPid,sq,isView,isPem,isOwner,groupCode,isAll);
			  	}else{
					var row = $('#resultList').treegrid("getSelected");
					if (!row) {
						$.messager.show({
							title:'消息',
							msg:'没有选中行！'
						});
						return;
					}
					taskId = row.taskId;
					taskPid = row.taskPid;
			    	yidian(taskId,taskPid,sq,isView,isPem);
			  	}
          	}
			//点“疑点执行“的事件
			function yidian12(taskId,taskPid){
				var sq='sq';
				var isView = '${isView}';
				var isPem='<%=request.getParameter("permission")%>';
				var isOwner='<%=request.getParameter("owner")%>';
				var groupCode='<%=request.getParameter("groupCode")%>';
 	           yidianOwner(taskId,taskPid,sq,isView,isPem,isOwner,groupCode);
			}
            //左侧实施方案页签下使用的方法 
            //审计事项下“执行”链接对应的方法，点击打开疑点页签
			//左侧我的任务页签下使用的方法 
            //审计事项下“执行”链接对应的方法，点击打开审计问题页签
			function yidian(taskId,taskPid,sq,isView,isPem,isOwner,groupCode,isAll){
  				var url = '${pageContext.request.contextPath}/operate/doubtExt/mainUi.action?view=view&'
  					+'project_id=${project_id}&taskId='+taskId+'&taskPid='
  					/*+'project_id=${audTask.project_id}&taskId='+taskId+'&taskPid='*/
  					+taskPid+'&sq='+sq+'&isView='+isView+'&permission='+isPem;
  					
  				url += '&audDoubt.flushdata=1&audDoubt.doubt_type=YD&audDoubt.project_id=${project_id}&audDoubt.task_id='+taskPid;

  				if (isOwner) url += '&owner='+isOwner;
  				if (groupCode) url += '&groupCode='+groupCode;
  				if (isAll) url += '&isAll=isAll';
				window.parent.addTab('tabs','方案执行(疑点)','tempframeTaskDoubtList',url,true);
      			//if(isOwner=='true'){var ownerStr='-owner';id:'common-data-dataframe-tab4'+ownerStr,pid:'common-data-dataframe-tab'+ownerStr,}
      		}

			function hasAuth(auth) {
				var resullt=''; 
				var s='${project_id}';
				DWREngine.setAsync(false);
				DWRActionUtil.execute(
					{ namespace:'/operate/task', action:'select', executeResult:'false' }, 
					{'project_id':s},
				    function(data){result =data['auth'];}
				);
				if(result=='1'){
					return true;
			 	}else{
					//msgbox('提示信息','只有组长、副组长和主审有权'+auth+'！');
					$.messager.show({
						title:'消息',
						msg:'只有组长、副组长和主审有权'+auth+'！'
					});
					return false;
				}
			}
      		//底稿反馈
			function feedback(){
				if (!hasAuth('设置底稿反馈')) return;
				var url = "${contextPath}/operate/manu/feedback.action?project_id=<%=request.getParameter("project_id")%>&taskPid=-1";
				window.parent.addTab('tabs','方案执行(反馈)','tempframeTaskFeedback',url,true);
			}
			//修改方案
		  	function edit(){
				if (!hasAuth('修改方案')) return;
				var url = '${contextPath}/operate/task/mainReadyEdit.action?project_id=${project_id}';
				window.parent.addTab('tabs','方案执行(修改)','tempframeTaskMainReadyEdit',url,true);
		  	}
			//修改审计分工
			function goedit6(){
				if (!hasAuth('修改审计分工')) return;
				var url = '${contextPath}/operate/task/project/mainTaskMember.action?project_id=${project_id}';
				window.parent.addTab('tabs','方案执行(分工)','tempframeTaskFengong',url,true);
			}
		   	//回传方案
			function goedit3(){
 				if (!hasAuth('回传改方案')) return;
				var url = '${contextPath}/operate/task/generate.action?project_id=${project_id}';
				var ttl = '回传方案';
				var o=$('#dlg');
				o.dialog({width:500,height:300,maximizable:false,resizable:false,draggable:true,title: ttl});
				o[0].children[0].src=url;
				o.dialog('open');
		   	}
	       //导出方案
			function goedit4(){
				//var url = "${contextPath}/commons/oaprint/manuTemplateList.action?moduleid=EnforceTemplate&projectId=${project_id}";
				//var url = "${contextPath}/commons/oaprint/manuTemplateList.action?moduleid=EnforceTemplate&projectId=${project_id}";
				window.location.href='${contextPath}/commons/oaprint/exportEnforeTemplate.action?moduleid=EnforceTemplate&projectId=${project_id}';
			//	aud$openNewTab("项目控制点查看", cpUrl, true);
				//var ttl = '导出方案';
				//var o=$('#dlg');
				//o.dialog({width:500,height:300,maximizable:false,resizable:false,draggable:true,title: ttl});
				//o[0].children[0].src=url;
				//o.dialog('open');
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
          
		
		
		
	   //分项小结的导出
	   function subExport(){
	      location.href='${contextPath}/operate/doubt/exportSubTask.action?project_id=<%=request.getParameter("project_id")%>&taskId=<%=request.getParameter("taskId")%>';//
	   }
     //批量导出到底稿
     function baogao(){
     
        var selectedRows = (gridDigao.getGridPanel()).getSelectionModel().getSelections(); 
        if(selectedRows.length==0){
			$.messager.show({
				title:'消息',
				msg:'请选择要导出的底稿！'
			});
            return;
        }                     
        var str = "";
        for(i=0;i <selectedRows.length;i++){
               str += selectedRows[i].data.formId + ","; 
        }                                     
        document.getElementsByName('manuIds')[0].value=str;
        myform2.submit();
	 }
    
     /*    导出所选底稿模板 */
     function ExportTemplate(){
         var selectedRows = $("#resultList").treegrid("getChecked");   
         var str = "";
         for(i=0;i <selectedRows.length;i++){
                if (selectedRows[i].template_type == 2 ){
                	 str += selectedRows[i].taskId + ","; 
                }
               
         } 
         if(str.length == 0){
  			top.$.messager.show({
  				title:'消息',
  				msg:'请选择要导出的审计事项！'
  			});
              return;
          }  
/*   		 $.ajax({
			url:"${contextPath}/operate/doubt/exportManuWork.action",
			data:{"project_id":'${project_id}',"flag":"flag","taskIds":str},
			type: "post",
			async:false,
			success:function(data){
				if(data != 'NO'){
					var url="${contextPath}/operate/doubt/exportFileZip.action?expTitle=exportDXExcelTem&project_id=" + '${project_id}' + "&tempZipName=" +data;
    				document.location.href=url;
				}else{
				    var url = "${contextPath}/operate/doubt/deleteTempZip.action";
					document.location.href=url;
				}
			}
		});  */
		if ( "${groups}".indexOf(groupId) == -1 &&  groupId != 'all'){
			$.messager.show({
				title:'消息',
				msg:'用户不在该小组下，请重新选择！'
			});
			return false;
		}
		window.location.href = "${contextPath}/templatedownload?file=audManuscript.xls&&type=audManuscript&&project_id=${project_id}&flag=flag&taskIds="+str+"&beanName=LedgerTemplateNew&treeId=id&treeText=code&treeParentId=fid&groupId="+groupId+"&auditObject="+auditObject;

     //	document.location.href="${contextPath}/operate/manuExt/exporManuWorkExcel.action?project_id=${project_id}&flag=flag&taskIds="+str+"&beanName=LedgerTemplateNew&treeId=id&treeText=code&treeParentId=fid";
     }


		</script>
	</body>
</html>


 

