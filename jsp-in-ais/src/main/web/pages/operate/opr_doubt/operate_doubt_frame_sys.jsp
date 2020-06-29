
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>审计疑点列表</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
		<link href="${contextPath}/resources/css/common.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
		<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
		<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/csswin/subModal.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<STYLE type="text/css">
			.datagrid-row {
			  	height: 30px;
			}
			.datagrid-cell {
				height:10%;
				padding:1px;
			}
		</STYLE>
	</head>
	<body class="easyui-layout">
		<div id="searchDoubt" class="searchWindow">
			<div class="search_head">
				<s:form id="searchForm" name="searchForm" action="listAll" namespace="/plan/year" method="post">
					<table cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
						<tr>
					   <td class="EditHead">项目编号</td>
						<td class="editTd">
						    <s:textfield cssClass="noborder" name="projectStartObject.project_code" maxlength="50" cssStyle="width:80%"/>
						</td>
						<td align="left" class="EditHead">
							项目名称
						</td>
						<td align="left" class="editTd" >
							<s:textfield name="projectStartObject.project_name" title="项目名称" id="project_name" cssClass="noborder"/>
						</td>
						
					</tr>
						<tr>
							<td align="left" class="EditHead" width="15%">疑点名称</td>
							<td align="left" class="editTd" width="35%">
								<s:textfield cssClass="noborder" name="audDoubt.doubt_name" maxlength="50" cssStyle='width:80%'/>
							</td>
							<td align="left" class="EditHead" width="15%">审计事项</td>
							<td align="left" class="editTd" width="35%">
								<s:textfield cssClass="noborder" name="audDoubt.task_name" maxlength="50" cssStyle='width:80%'/>
							</td>
						</tr>
						<tr>
							<td align="left" class="EditHead">撰写人</td>
							<td align="left" class="editTd">
								<s:textfield cssClass="noborder" name="audDoubt.doubt_author" maxlength="50" cssStyle='width:80%'/>
							</td>
							<td align="left" class="EditHead">疑点编码</td>
							<td align="left" class="editTd">
								<s:textfield cssClass="noborder" name="audDoubt.doubt_code" maxlength="50" cssStyle='width:80%'/>
							</td>
						</tr>
						<tr>
							<td align="left" class="EditHead">被审计单位</td>
							<td align="left" class="editTd">
								<s:textfield cssClass="noborder" name="audDoubt.audit_object_name" maxlength="50" cssStyle='width:80%'/>
							</td>
							<td class="EditHead">		
						                 项目年度
					        </td>
						<td class="editTd">
						<select class="easyui-combobox" name="projectStartObject.pro_year" id="pro_year" style="width:80%"  editable="false">
					       <option value="">请选择</option>
					       <s:iterator value="@ais.project.ProjectUtil@getIncrementSearchYearList(10,5)" id="entry">
					         <option value="<s:property value="key"/>"><s:property value="value"/></option>
					       </s:iterator>
					    </select>
					    </td>
						</tr>
					</table>
					<s:hidden name="ifFirstQuery" value="no"/>
				</s:form>
			</div>
			<div class="serch_foot">
		        <div class="search_btn">
					<a class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="query()">查询</a>
					<a class="easyui-linkbutton" data-options="iconCls:'icon-reload'" onclick="resetDoubtList()">重置</a>
					<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="$('#searchDoubt').window('close')">取消</a>
				</div>
			</div>
		</div>
		<div region="center" border='0'>
			<table id="doubtList"></table>
		</div>
		<script type="text/javascript">
			$(function(){
				
				//查询
				showWin('searchDoubt');
				var d = new Date();
				loadSelectH();
				$('#pro_year').combobox('setValue',d.getFullYear());
				//taskPid不同，显示的数据不同，taskPid=-1，显示全部的数据，taskPid为树节点的id 显示的是本级和下级的数据
		        var isView = '<%=request.getParameter("isView")%>';
		        var view = '<%=request.getParameter("view")%>';
		        //是否为查看疑点
		        if (isView == 'true' || view == 'view') {
		        	isViewDoubt(0);
		        } else {
		        	isViewDoubt(1);
		        }
				$('#doubtList').datagrid({
					url:'${pageContext.request.contextPath}'+"/operate/doubtExt/mainUisys.action?querySource=grid&sys=1",
					method:'post',
					showFooter:true,
					rownumbers:true,
					pagination:false,
					striped:true,
					autoRowHeight:false,
					fit:true,
					pageSize: 20,
					idField:'doubt_id',
					fitColumns: true,
					border:false,
					remoteSort: false,
					frozenColumns:[[
						{field:'doubt_id', halign:'center',checkbox:true, align:'center'},
					    {field:'project_code',
							title:'项目编码',
							width: 180,
							halign: 'center',
							align:'left', 
							sortable:true,
						},	
					    {field:'project_name',
							title:'项目名称',
							width: 180,
							halign: 'center',
							align:'left', 
							sortable:true,
						},	
						
					    {field:'doubt_name',
							title:'疑点名称',
							width: 180,
							halign: 'center',
							align:'left', 
							sortable:true,
						}		
					    		]],
					columns:[[
						
						{field:'doubt_code',
							title:'疑点编码',
							width: 100,
							halign: 'center',
							align:'center', 
							sortable:true,
							},
						{field:'audit_dept_name',
							title:'被审计单位',
							width: 100,
							halign: 'center',
							align:'left', 
							sortable:true
						},
						{field:'task_name',
							title:'审计事项',
							width:250,
							halign: 'center',
							align:'left', 
							sortable:true,
							},
						{field:'doubt_author',
							title:'撰写人',
							width: 60,
							halign: 'center',
							align:'left', 
							sortable:true,
							},
					
						/* {field:'doubt_manu_name',
							title:'关联底稿',
							width:180,
							halign: 'center',
							align:'center',
							sortable:true,
							formatter:function(value,row,rowIndex){
								var doubt_manu = row.doubt_manu;
								if (row.doubt_manu_name != '' && row.doubt_manu_name != null) {
									var manuId = doubt_manu.split(',');
									
									return "<a href=\"javascript:void(0)\" onclick=\"viewManu('"+manuId[0]+"')\">"+row.doubt_manu_name+"</a>";
								} else {
									return "";
								}
						}}, */
						{field:'doubt_date',
							title:'创建日期',
							width: 90,
							halign: 'center',
							align:'center',
							sortable:true
						}
					]],
					
				});
				//单元格tooltip提示
				$('#doubtList').datagrid('doCellTip', {
					position : 'bottom',
					maxWidth : '200px',
					tipStyler : {
						'backgroundColor' : '#EFF5FF',
						borderColor : '#95B8E7',
						boxShadow : '1px 1px 3px #292929'
					}
				
				});
			
			});
			var isViewDoubt = function(flag) {
				if (flag) {
					$('#doubtList').datagrid({
						toolbar:[{
								id:'searchObj',
								text:'查询',
								iconCls:'icon-search',
								handler:function(){
									searchWindShow('searchDoubt',800);
								}
							},
						/* 	{
								id:'addDoubt',
								text:'新增',
								iconCls:'icon-add',
								handler:function(){
									addDoubtFrame();
								}
							},	 */			
							{
								id:'batchSubmitObj',
								text:'删除',
								iconCls:'icon-delete',
								handler:function(){
									piliangDel();
								}
							}/* , 
							{
								id:'outManuOwner',
								text:'消除疑点',
								iconCls:'icon-cancel',
								handler:function(){
									outDoubt();
								}
							}, {
								id:'inManuOwner',
								text:'恢复',
								iconCls:'icon-recover',
								handler:function(){
									inDoubt();
								}
							} */
						]
					});
				} 
				
			};
			function query(){
				$('#doubtList').datagrid({
    				queryParams:form2Json('searchForm')
    			});
    			$('#searchDoubt').window('close');
			}
			
			//重置查询条件
			function resetDoubtList(){
				/* document.getElementsByName("audDoubt.audit_dept")[0].value = "";
				document.getElementsByName("audDoubt.doubt_status")[0].value = ""; */
				resetForm('searchForm');
				query();
			}
			//增加疑点
       		function addDoubtFrame(){
       			if(isGoOn()){
      			  return false;
      		  }	
         		if('<%=request.getParameter("taskId")%>'=='-1'){//从“我的疑点”进入的，先建疑点后选择审计事项
					window.location.href="/ais/operate/doubt/editDoubt.action?type=FX&project_id=<%=request.getParameter("project_id")%>"
								 	+"&taskId=<%=request.getParameter("taskId")%>&taskPid=<%=request.getParameter("taskPid")%>";
         		}else{//从审计事项进入，需要判断是否有权增加
            		var auth='0';
					$.ajax({
						url:"${pageContext.request.contextPath}/operate/task/checkTaskAssign.action",
						type:"POST",
						data:{"project_id":"<%=request.getParameter("project_id")%>","taskTemplateId":"<%=request.getParameter("taskId")%>","taskPid":"<%=request.getParameter("taskPid")%>"},
						async:false,
						success:function(data){
							auth = data;
						}
					});

// 		  			if('<%=request.getParameter("taskPid")%>'=='-1'||'<%=request.getParameter("taskPid")%>'=='null'){
// 		  			}
					window.location.href="/ais/operate/doubt/editDoubt.action?type=FX&project_id=<%=request.getParameter("project_id")%>"
								 	+"&taskId=<%=request.getParameter("taskId")%>&taskPid=<%=request.getParameter("taskPid")%>";
		  		}              
			}
			//chankan yidian
       		function doubtView(){
       			var rows = $('#doubtList').datagrid('getChecked');//返回是个数组
    			if(rows!=null && rows.length>0){
    				if(rows.length==1){
    					var row = rows[0];
    					var doubt_id=row.doubt_id;
    					$.ajax({
    			        	url:"${pageContext.request.contextPath}/operate/doubt/checkStatus.action",
    			        	type:"POST",
    			        	data:{'checkStatus':'000','doubt_id':doubt_id},
    			        	async:false,
    			        	success:function(data){
    			        		checkCode = data;
    			        	}
    			        });
    			        if(checkCode=='1' || checkCode=='2'){
    			        	
    			        }else{
    			            showMessage1("疑点已删除,请刷新数据后重新操作！");
    				        $("#doubtList").datagrid('reload');
    				        return false;
    			        }
    			        var width = ($(window).width()-1200)*0.5;
    			        var height = ($(window).height()-550)*0.2;
    			        var myurl = "${contextPath}/operate/doubt/view.action?type=YD&doubt_id="+doubt_id;
    			        parent.addTab("tabs","审计疑点查看","doubtViewTab",myurl,false);
    				}else{
    					$.messager.show({title:'提示信息',msg:'请选择一条记录!'});
    				}
    			}else{
    				$.messager.show({title:'提示信息',msg:'请选择一条记录!'});
    			}  
			}
			//编辑疑点
    		function editDoubt(doubt_id,doubt_author_code,doubt_status){
    			if(isGoOn()){
    				return false;
    			}
    			var rows = $('#doubtList').datagrid('getChecked');
    			if (doubt_id == '' || doubt_id == null) {
    				showMessage1('请选择数据');
			    	return false;
    			}else {
		       		if('${user.floginname}' == doubt_author_code){
		       			
		       		} else {
		       			showMessage1('没有权限修改！');
						return false;
		       		}
		       		if ('010' == doubt_status) {
		       			var checkCode='0';
	       		 		$.ajax({
				        	url:"${pageContext.request.contextPath}/operate/doubt/checkStatus.action",
				        	type:"POST",
				        	async:false,
				        	data:{"checkStatus":"010","doubt_id":doubt_id},
				        	success:function(data){
				        		checkCode = data;
				        	}
				        });
				        if(checkCode=='1'){
	       
				        }else{
				            showMessage1('不能修改,疑点已处理或已删除,请刷新数据后重新操作！');
				           	$("#doubtList").datagrid('reload');
					        return false;
				        }
		       		} else {
		       			showMessage1('不能修改,疑点已处理或已删除,请刷新数据后重新操作！');
		 				return false;
		       		}
		       		window.location.href="/ais/operate/doubt/editDoubt.action?type=FX&doubt_id="+doubt_id+"&project_id=<%=request.getParameter("project_id")%>"
		       		                      +"&taskId=<%=request.getParameter("taskId")%>&taskPid=<%=request.getParameter("taskPid")%>";
    			}
    		}
			
			function isGoOn(){
		    	var flag = false;
		    	$.ajax({
					url:'${contextPath}/operate/manuExt/isGoOn.action',
					type:'POST',
					data:{"project_id":'${project_id}'},
					dataType:'json',
					async:false,
					success:function(data){
						if(data == 2) {
							showMessage1('实施方案正在调整，暂不允许登记疑点！');
							flag = true;
						}else{
							flag = false;
						}
					},
					error:function(){
						$.messager.alert("系统错误，请联系系统管理员！",'info');
						flag = true;
					}
				});
		    	return flag;
	    	}
	    	
	    	//批量删除疑点
    	 function piliangDel(){
    		 var rows = $('#doubtList').datagrid("getChecked");
    	        var str = "";
    	 		//一条数据，走单独删除
    	 		if(rows.length < 1){
    	 			showMessage1('请选择一条记录!');
    	 			return false;
    	 		}		
    	        if(rows && rows.length==1){
    	        	delDoubt();
    	        }else{
           	 $.messager.confirm('确认对话框', "确认删除这 "+rows.length+" 条数据吗？", function(r){
          	   if (r){
          		   for(i=0;i <rows.length;i++){
                  	   str += rows[i].doubt_id + ","; 
                   }
     			   jQuery.ajax({
     				  url:"${pageContext.request.contextPath}/operate/doubtExt/doubtDel.action",
						type:"POST",
						data:{'audDoubt.doubt_id':str},
     					success:function(data){
     						showMessage1("删除成功！");
							window.location.reload();
     					},
     					error:function(){
     						showMessage1("删除疑点出错了！");
     					}
             	   });	
     			}
             });
            }
    	}
    	//删除疑点
    function delDoubt(){
    	var rows = $("#doubtList").datagrid("getChecked");
    	if(isSingle(rows)){
    		var row = rows[0];
    		var doubt_id=row.doubt_id;
	        var doubt_author_code=row.doubt_author_code;
	        var doubt_status=row.doubt_status;
	        if (doubt_id == null || doubt_id == '') {
	    		showMessage1("数据错误，请刷新后重试！");
	    		return;
	    	}
			top.$.messager.confirm('确认','确认删除疑点吗?', function(flag){
				if (flag) {
					//上面条件都不满足，进行删除 
			  		$.ajax({
			  			url:"${pageContext.request.contextPath}/operate/doubtExt/doubtDel.action",
			  			type:"POST",
			  			async:false,
			  			data:{"audDoubt.doubt_id":doubt_id},
			  			success:function(data){
			  				showMessage1('删除成功！');
			  				window.location.reload();
			  			}
			  		});
				}
			});
    	}
    }
    	//是否选中一条记录
		function isSingle(rows){
			if(rows!=null && rows.length>0){
				if(rows.length==1){
					return true;
     			}else{
					showMessage1('请选择一条记录!');
					return false;	     			
     			}				
			}else{
				showMessage1('请选择一条记录!');
				return false;
			}	
		}	
      //查看疑点  
      function viewDoubt(doubt_id){
       		var checkCode = '0';
	        $.ajax({
	        	url:"${pageContext.request.contextPath}/operate/doubt/checkStatus.action",
	        	type:"POST",
	        	data:{'checkStatus':'000','doubt_id':doubt_id},
	        	async:false,
	        	success:function(data){
	        		checkCode = data;
	        	}
	        });
	        if(checkCode=='1' || checkCode=='2'){
	        	
	        }else{
	            showMessage1("疑点已删除,请刷新数据后重新操作！");
		        $("#doubtList").datagrid('reload');
		        return false;
	        }
	        var width = ($(window).width()-1200)*0.5;
	        var height = ($(window).height()-550)*0.2;
	        var myurl = "${contextPath}/operate/doubt/view.action?type=YD&doubt_id="+doubt_id;
	        parent.addTab("tabs","审计疑点查看","doubtViewTab",myurl,false);
      }
      
       //处理审计疑点
     function outDoubt(){
    	 if(isGoOn()){
 			  return false;
 		  }	
    	 var rows = $('#doubtList').datagrid('getChecked');//返回是个数组
			if(rows!=null && rows.length>0){
				if(rows.length==1){
					var row = rows[0];
					var doubt_author_code=row.doubt_author_code;
					var doubt_status=row.doubt_status;
					var doubt_id=row.doubt_id;
					if('${user.floginname}' == doubt_author_code){
						
					}else{
						showMessage1("没有权限处理！");
						return false;
					}
				   	var checkCode='0';
				 	$.ajax({
			        	url:"${pageContext.request.contextPath}/operate/doubt/checkStatus.action",
			        	type:"POST",
			        	async:false,
			        	data:{"checkStatus":"010","doubt_id":doubt_id},
			        	success:function(data){
			        		checkCode = data;
			        	}
			        });
					if ('010' == doubt_status) {
				        if (checkCode == '1') {
				        
				        } else {
				            showMessage1("不能处理,疑点已处理或已删除,请刷新数据后重新操作！");
					        return false;
				        }
				                  
				   	} else {
					 	showMessage1("已经是已处理状态！");
				  	 	return false;
				   	}       
				    var title = "录入处理无问题原因";
					window.location.href = '${contextPath}/operate/doubt/editDoubtReason.action?chuli=1&doubt_id='+doubt_id;
				}else{
					$.messager.show({title:'提示信息',msg:'请选择一条记录!'});
				}
			}else{
				$.messager.show({title:'提示信息',msg:'请选择一条记录!'});
			}
      }
      
      //恢复疑点状态为未处理
     function inDoubt(s){
//    	 if(isGoOn()){
// 			  return false;
// 		  }
     	var rows = $("#doubtList").datagrid("getChecked");
		if(rows!=null && rows.length>0){
			if(rows.length==1){
				var row = rows[0];
				var doubt_author_code=row.doubt_author_code;
				var doubt_status=row.doubt_status;
				var doubt_id=row.doubt_id;
				if('${user.floginname}' == doubt_author_code){
	      			
			    }else{
			   		showMessage1("没有权限恢复！");
			    	return false;
			   	}
			   	var checkCode='0';
			 	$.ajax({
		        	url:"${pageContext.request.contextPath}/operate/doubt/checkStatus.action",
		        	type:"POST",
		        	async:false,
		        	data:{"checkStatus":"050","doubt_id":doubt_id},
		        	success:function(data){
		        		checkCode = data;
		        	}
		        });
		        if(checkCode=='1'){
		    	   
		        }else if(checkCode=='2'){
		    	    showMessage1("该疑点已经生成底稿，不可恢复！");
		    	    return false;
		        }else{
		            showMessage1("不能恢复,疑点未处理或已删除,请刷新数据后重新操作！");
			        return false;
		        }
		        top.$.messager.confirm('确认','确认恢复疑点吗?', function(flag){
					if (flag){
						$.ajax({
							url:"${pageContext.request.contextPath}/operate/doubtExt/doubtIn.action",
							type:"post",
							data:{'audDoubt.doubt_id':doubt_id,'audDoubt.doubt_status':'010'},
							success:function(){
								showMessage1('恢复成功！');
								window.location.reload();
							}
						});
					}
				});
			}else{
				$.messager.show({title:'提示信息',msg:'请选择一条记录!'});
			}
		}else{
			$.messager.show({title:'提示信息',msg:'请选择一条记录!'});
		}
      }
      
      function viewManu(id){
      	 var width = ($(window).width()-1200)*0.5;
	     var height = ($(window).height()-550)*0.2;
	     var myurl = "${pageContext.request.contextPath}/operate/manu/viewAll.action?view=${param.view}&crudId="+id;
	     parent.addTab("tabs","查看关联底稿","manuViewTab",myurl,false);
      }
</script>		
</body>
</html>