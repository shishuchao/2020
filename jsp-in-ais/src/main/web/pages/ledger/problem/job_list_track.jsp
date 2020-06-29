<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>审计问题整改跟踪列表</title>
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
		<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
		<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
     	<%--<script type='text/javascript' src='${contextPath}/scripts/ufaudTextLengthValidator.js'></script>--%>
     	<script type="text/javascript">
		// 初始化
		$(function(){
			$('#problemTracking_div').window({   
				width:800,   
				height:500,   
				modal:true,
				collapsible:false,
				maximizable:false,
				minimizable:false,
				closed:true
			});
		});
		</script>	
	</head>
	<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout">
		<table cellpadding=0 cellspacing=0 border=0 bgcolor="#409cce" class="ListTable" width="100%" align="center">
			<tr>
				<td colspan="4" class="EditHead" style="text-align: left; width: 100%;">
					<span style="display: inline; width: 80%;float: left;">
					(${problemTracking.problem_name}-${problemTracking.serial_num})整改结果跟踪记录
					</span>
				</td>
			</tr>
		</table>
		<div region="center" >
			<table id="jobtrackList"></table>
		</div>
		<div id="viewMiddle" title="定稿问题查看" style="overflow:hidden;padding:0px">
	    	<iframe id="openViewMiddle" src="" width="100%" title="" height="100%" frameborder="0" ></iframe>
	  	</div>
		<s:hidden id="crudIdStrings" name="crudIdStrings" />
		<script type="text/javascript">
		$(function(){
			$('#jobtrackList').datagrid({
				url : "<%=request.getContextPath()%>/easyui/problem/jobtrackList.action?querySource=grid&crudIdStrings=${crudIdStrings}",
				method:'post',
				showFooter:false,
				rownumbers:true,
				pagination:true,
//				nowrap:false,
				striped:true,
				autoRowHeight:false,
				fit: true,
				fitColumns:true,
				border:false,
				singleSelect:false,
				pageSize:20,
				remoteSort: false,
				<s:if test="${onlyView!='true'}">
				toolbar:[
					{
						id:'add_track',
						text:'新增',
						iconCls:'icon-add'
					},
					{
						id:'edit_track',
						text:'修改',
						iconCls:'icon-edit'
					},
					{
						id:'delete_track',
						text:'删除',
						iconCls:'icon-delete'
					},
					{
						id:'view_track',
						text:'查看',
						iconCls:'icon-view'
					},
					{
						id:'back',
						text:'返回',
						iconCls:'icon-undo',
						handler:function(){back();}
					}
				],
				</s:if>
				frozenColumns:[[
					{field:'id',width:'50px', checkbox:true, align:'center',sortable:true},
					{field:'serial_num',title:'审计问题编号',halign:'center',align:'center',sortable:true,formatter:function(value,row,rowIndex){
						//return '<a href="${contextPath}/proledger/problem/viewMiddle.action?id='+row.middleLedgerProblem_id+'" target="_blank" >'+row.serial_num+'</a>';
						return '<a href=\"javascript:void(0)\" onclick=\"openViewMiddle(\''+row.middleLedgerProblem_id+'\');\">'+value+'</a>';
					}},
					{field:'mend_result',width:200,title:'被审计单位反馈整改结果',sortable:true,halign:'center',align:'left'}
				]],
				columns:[[  
					{field:'responsibility',
						title:'是否追责',
						width:'70px',
						sortable:true, 
						align:'center'
					},
					{field:'responsibility_Mode',
						 title:'追责方式',
						 halign:'center',
						 align:'left', 
						 sortable:true
					},
					{field:'mend_state',
						 title:'整改状态',
						 width:'70px', 
						 align:'center', 
						 sortable:true
					},
					{field:'examine_enddate',
						 title:'实际整改期限',
						 width:'100px',
						 align:'center',
						 sortable:true,
						 formatter:function(value,row,rowIndex){if(value!=null && value!=''){return value.substring(0,10);}}
					},
					{field:'no_rectification_reason',
						 title:'到期未整改原因',
						 halign:'center',
						 width:200,
						 align:'left', 
						 sortable:true
					},
					{field:'real_examine_creater',
						 title:'实际检查人',
						 halign:'center', 
						 align:'left', 
						 sortable:true
					},
					{field:'examine_result',
						 title:'审计单位跟踪检查结果',
						 halign:'center',
						 width:200,
						 align:'left', 
						 sortable:true
					},
					{field:'aud_track_result',
						 title:'整改跟踪结论',
						 halign:'center',
						 width:200,
						 align:'left', 
						 sortable:true
					},
					{field:'tracker_name',
						 title:'跟踪人',
						 halign:'center', 
						 align:'left', 
						 sortable:true
					},
					{field:'feedback_date',
						 title:'反馈日期',
						 width:80, 
						 halign:'center', 
						 align:'right', 
						 sortable:true,
						 formatter:function(value,row,rowIndex){ if(value!= null && value!=''){return value.substring(0,10);}}
					},
					{field:'stateName',
						 title:'状态',
						 width:'70px', 
						 align:'center', 
						 sortable:true
					}
				]]   
			});
			//单元格tooltip提示
//			$('#jobtrackList').datagrid('doCellTip', {
//				position : 'bottom',
//				maxWidth : '700px',
//				tipStyler : {
//					'backgroundColor' : '#EFF5FF',
//					borderColor : '#95B8E7',
//					boxShadow : '1px 1px 3px #292929'
//				}
//			});
			// 打开录入窗口时，清空录入框
			$('#add_track').bind('click',function(){
				/*
				$.ajax({
					dataType:'json',
					url : "${contextPath}/proledger/problem/findMyUUid.action",
					type: "POST",
					async:false,
					success: function(data){
						$('#fj').val(data.uuidString);
					},
					error:function(data){
						$.messager.alert('提示信息','请求失败！','error');
					}
				});
				$("#trackBtnDiv").show();
				$("#fj_div").show();
				$('#problemTracking_div').window('open');
				clearFormDiv();
				*/
				window.location.href="${contextPath}/proledger/problem/liucEdit.action?crudIdStrings=${crudIdStrings}&project_id=${project_id}";
			});
			// 清空表单
			function clearFormDiv(){
				var arr = ['responsibility','responsibility_Mode','mend_state_code','examine_enddate','feedback_date','real_examine_creater','mend_result','no_rectification_reason','examine_result','aud_track_result'];
				$.each(arr, function(i, ele){
					$('#'+ele).val('');
				});
				$("#fjlFileList").html("");
			}
			// 关闭录入窗口
			$('#closeWin').bind('click',function(){
				$('#problemTracking_div').window('close');
			});
			$('#saveProblemTracking').bind('click',function(){
				var crudIdStrings = $('#crudIdStrings').val();
				$.ajax({
					dataType:'json',
					url : "${contextPath}/proledger/problem/saveProblemTracking.action?crudIdStrings="+crudIdStrings,
					data: $('#problemTracking_form').serialize(),
					type: "POST",
					success: function(data){
						showMessage2("保存成功！");
					},
					error:function(data){
						showMessage2("请求失败！");
					}
				});
			});
			// 删除
			$('#delete_track').bind('click',function(){
				var rows=$('#jobtrackList').datagrid('getSelections');
				if(rows.length>0){
					$.messager.confirm('确认','确定删除么？', function(r){
						if (r) {
							var crudIdStrings = '';
							for( var i=0;i<rows.length;i++){
								crudIdStrings +=rows[i].formId+',';
							}
							$.ajax({
								dataType:'json',
								url : "${contextPath}/proledger/problem/deleteProblemTracking.action",
								data: {'crudIdStrings':crudIdStrings},
								type: "POST",
								async: true,
								success: function(data){
									showMessage2('删除成功！');
									window.location.reload();
								},
								error:function(data){
									showMessage2('请求失败！');
								}
							});
						}
					});
				}else{
					showMessage2('没有选择跟踪记录');
					return false;
				}
			});
			// 查看
			$('#view_track').bind('click',function(){
				var rows=$('#jobtrackList').datagrid('getSelections');
				if(rows.length==1){
					var crudIdStrings = '';
					var id = rows[0].formId;
					/*
					$.ajax({
						url:'${contextPath}/proledger/problem/getProblemTrackingById.action',
						data:{'problemTracking.id':id,'isView':'true'}, 
						type: "post",
						dataType:'json',
						cache:false,
						success:function(data){
							if(data.type === 'success'){
								var rowData = data.pt;
								for ( var p in rowData ){
									 var value = rowData[p] ;
									 if (p == 'mend_result' || p == 'no_rectification_reason' || p == 'examine_result' || p == 'aud_track_result'){//标签是< textarea
										 $ ('#' + p).text(value ? value : '');
									 } else if(p == 'responsibility' || p == 'mend_state_code'){// select控件
										 $("#"+p+"").attr("value",value);
									 } else if(p == 'examine_enddate' || p == 'feedback_date'){// 时间格式化
										 $('input[id='+p+']').val(value && value.length > 10 ? value.substring(0,10) :value);
									 } else{//< input type = 'text'							          
										 $('input[id='+p+']').val(value);
									 }                                     
								}
								$("#fjlFileList").html(data['fileList']);
								$("#trackBtnDiv").hide();
								$("#fj_div").hide();
								$('#problemTracking_div').window('open');
							}else{
								showMessage2(data.msg);
							}						
						},
						error:function(data){
							showMessage2('请求失败！');
						}
					});
				    */
				    window.location.href="${contextPath}/proledger/problem/liucEdit.action?crudId="+id+"&crudIdStrings=${crudIdStrings}&project_id=${project_id}&view=view";
				}else if(rows.length>1){
					showMessage1('只能选择一个跟踪记录查看');
					return false;
				}else {
					showMessage1('没有选择跟踪记录');
					return false;
				}
			});
			
			// 编辑跟踪记录
			$('#edit_track').bind('click',function(){
				var rows=$('#jobtrackList').datagrid('getSelections');
				if(rows.length==1){
					var crudIdStrings = '';
					var id = rows[0].formId;
					var flag = false;
					$.ajax({
					    url:'${contextPath}/proledger/problem/isProblemTrackingEdit.action',
						data:{'crudId':id}, 
						type: "post",
						dataType:'json',
						async:false,
						success:function(data){
							if(data == 0){
								showMessage1('该条记录正在复核，不能修改！');
							}else if(data == 1){
								showMessage1('该条记录已复核完毕，不能修改！');
							}else if(data == 2){
								flag = true;
							}
						}
					});
					if(flag){
						window.location.href="${contextPath}/proledger/problem/liucEdit.action?crudId="+id+"&crudIdStrings=${crudIdStrings}&project_id=${project_id}";
					}
					/*
					$.ajax({
						url:'${contextPath}/proledger/problem/getProblemTrackingById.action',
						data:{'problemTracking.id':id,'isView':'false'}, 
						type: "post",
						dataType:'json',
						cache:false,
						success:function(data){
							if(data.type === 'success'){
								var rowData = data.pt;
								for ( var p in rowData ){
									 var value = rowData[p] ;
									 if (p == 'mend_result' || p == 'no_rectification_reason' || p == 'examine_result' || p == 'aud_track_result'){//标签是< textarea
										 $ ('#' + p).text(value ? value : '');
									 } else if(p == 'responsibility' || p == 'mend_state_code'){// select控件
										 $("#"+p+"").attr("value",value);
									 } else if(p == 'examine_enddate' || p == 'feedback_date'){// 时间格式化
										 $('input[id='+p+']').val(value && value.length > 10 ? value.substring(0,10) :value);
									 } else{//< input type = 'text'							          
										 $('input[id='+p+']').val(value);
									 }                                     
								}
								$("#fjlFileList").html(data['fileList']);
								$("#trackBtnDiv").show();
								$("#fj_div").show();
								$('#problemTracking_div').window('open');
							}else{
								showMessage2(data.msg);
							}						
						},
						error:function(data){
							showMessage2('请求失败！');
						}
					});
					*/	 
				}else if(rows.length>1){
					showMessage1('只能选择一个跟踪记录进行编辑');
					return false;
				}else {
					showMessage1('没有选择跟踪记录');
					return false;
				}
			});
		});
		$('#viewMiddle').window({
			width:880, 
			height:380,  
			modal:true,
			collapsible:false,
			maximizable:true,
			minimizable:false,
			closed:true    
		});
		function openViewMiddle(id){
			var openViewUrl = "${contextPath}/proledger/problem/viewMiddle.action?id="+id;
			$('#openViewMiddle').attr("src",openViewUrl);
			$('#viewMiddle').window('open');
		}
		function back(){
			var url='${contextPath}/proledger/problem/jobdecideProblemList.action?project_id=${project_id}';
			window.location.href=url;
		}
		</script>
	</body>
</html>
