<!DOCTYPE HTML>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<html>
	<head>
	<!-- <meta http-equiv="X-UA-Compatible" content="IE=5"> -->
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
	<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
	<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
	<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
	<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
	<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
	<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
	<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
	</head>
	<body class="easyui-layout">
	<s:if test="${type==4002}">
		<font color="red">温馨提示：</font><br/>
		编码必须是阿拉伯数字；名称和编码中数字必须保持一致；他们的关系：编码表示年份或期限长度，名称是表现形式。例: 编码 10  名称 10年
	</s:if>
	<table id="codeNameList"></table>
	<div id="newwindowDiv" title="添加扩展选项" style='overflow:hidden;'> 	  		
			<iframe id="myFrame" name="myFrame" src="" width="100%" height="100%" frameborder="0" scrolling="no"></iframe>				
    </div>
	<script type="text/javascript">
		var sd="${codeHead.type}";
		$(function(){
			//初始化增加窗口
		    $('#newwindowDiv').window({
				width:800, 
				height:400,  
				modal:true,
				collapsible:false,
				maximizable:false,
				minimizable:false,
				closed:true    
		    });   
			// 初始化生成表格
			$('#codeNameList').datagrid({
				url : "<%=request.getContextPath()%>/basic/codename/list.action?codeHead.level=${codeHead.level}&codeName.pid=${codeName.pid}&codeName.level=${codeName.level}&codeName.status=${codeName.status}&type=${type}&expand=${expand}&codeHead.pid=${codeHead.pid}&codeHead.id=${codeHead.id}&querySource=grid",
				method:'post',
				showFooter:false,
				rownumbers:true,
				pagination:true,
				striped:true,
				autoRowHeight:false,
				fit: true,
				fitColumns:true,
				idField:'id',	
				border:false,
				singleSelect:true,
				remoteSort: false,
				toolbar:[{
					id:'add',
					text:'增加',
					iconCls:'icon-add',
					handler:function(){
						if("${codeNameList[0].pid=='0'}"){
						window.location='<%=request.getContextPath()%>/basic/codename/edit.action?id=0&type=${type}&expand=${expand}&codeHead.pid=${codeHead.pid}&codeHead.id=${codeHead.id}&codeHead.level=${codeHead.level}&codeHead.type=${codeHead.type}&codeName.level=${codeName.level}&codeName.pid=${codeName.pid}';
						}else{
						window.location='<%=request.getContextPath()%>/basic/codename/edit.action?id=0&type=${type}&expand=${expand}&codeHead.pid=${codeHead.pid}&codeHead.id=${codeHead.id}&codeHead.level=${codeHead.level}&codeHead.type=${codeHead.type}&codeName.level=${codeName.level}&codeName.pid=${codeName.pid}';
						}						
					}
				}
			],
				frozenColumns:[[
				            	{field:'code',title:'编码',width:'250',sortable:true,align:'center'},
				       			{field:'name',title:'名称',width:'300',sortable:true,align:'center'}
				]],
				columns:[[  
				
					{field:'status',
						title:'状态',
						width:250,
						align:'center', 
						sortable:true,
						formatter:function(value,rowData,rowIndex){
							if(value==1){
								return "正常";
							}
							else if(value==2){
								return "注销";
							}else if(value==3){
								return "删除";
							}else{
								return " ";
							}
						}
				},	
				{field:'option',
					title:'操作',
					width:300,
					align:'center', 
					sortable:true,
					formatter:function(value,rowData,rowIndex){
						var menue="";
						if(rowData.sys_type=='C'){
							if("${codeHead.type=='C'}"){
									menue+='<a href="<%=request.getContextPath()%>/basic/codename/edit.action?id='+rowData.id+'&type='+rowData.type+'&expand=${expand}&codeHead.pid=${codeHead.pid}&codeHead.id=${codeHead.id}&codeHead.level=${codeHead.level}&codeHead.type=${codeHead.type}">修改</a>&nbsp&nbsp';
									if("${not empty(codeHead.level)}" && "${codeHead.level}"> rowData.level){
										menue+='<a href="javascript:void(0);" onclick="return delchk(\''+rowData.status+'\',\''+rowData.id+'\',\''+rowData.type+'\');">删除</a>&nbsp&nbsp';
										if(rowData.hasChild){
											menue+='<a href="javascript:void(0);"  onclick="newwindow(\'list.action?codeHead.level=${codeHead.level}&codeName.pid='+rowData.id+'&type='+rowData.type+'\')"><font color="blue">扩展选项</font></a>&nbsp&nbsp';
										}else{
											
											menue+='<a href="javascript:void(0);"  onclick="newwindow(\'list.action?codeHead.level=${codeHead.level}&codeName.pid='+rowData.id+'&type='+rowData.type+'\')">扩展选项</a>&nbsp&nbsp';
										}
									}else{
										menue+='<a href="javascript:void(0);" onclick="return delchk2(\''+rowData.status+'\',\''+rowData.id+'\',\''+rowData.type+'\');">删除</a>&nbsp&nbsp';
									}								
							}else{
								if("${not empty(codeHead.level)}" ){
										
									if(rowData.hasChild){
										
										menue+='<a href="javascript:void(0);"  onclick="newwindow(\'list.action?codeName.pid='+rowData.id+'&type='+rowData.type+'\')"><font color="blue">扩展选项</font></a>&nbsp&nbsp';
									}else{
										
										menue+='<a href="javascript:void(0);"  onclick="newwindow(\'list.action?codeName.pid='+rowData.id+'&type='+rowData+'\')">扩展选项</a>&nbsp&nbsp';
									}
								}
								
							}
						}
						return menue;
					}
				}
				]]   
			}); 
		});
		function delchk(status,id,type){
			var bln=true;
			$.messager.confirm('提示信息', '删除时将会把相关扩展项一同删除\n\r并且可能影响其它业务的正常执行!\n\r确定删除?', function(r){
				bln = r;
				if(status == 3){
					//查看下级是否删除状态
			 $.ajax({
				  type: "POST",
				  url: '<%=request.getContextPath()%>/basic/codename/chkStatus.action',
				  dataType:"text",
				  data:{id:id},
				  async: false,
				  success: function(data){
					  if(data=="true"){
						  }else{
							 
						  showMessage1("扩展项中存在非删除状态,请改为删除状态在操作!");
							bln=false;
								
						  }
				    }
			   });
					
				} else {
					showMessage1('只有"删除"状态才可以删除!');
					bln=false;
				}
				if(bln){
					$.ajax({
						  type: "POST",
						  url: '<%=request.getContextPath()%>/basic/codename/delete.action',
						  dataType:"text",
						  data:{id:id,type:type},
						  async: false,
						  success: function(data){
							  if(data == 'ok'){
								  showMessage1('删除成功!');
								  gback();
							  }
							 showMessage1('删除成功！');
						  	 $('#codeNameList').datagrid('reload');
						  }
					});
				}
			});
		}
		
		function gback(){
			window.location.href='<%=request.getContextPath()%>/basic/codename/list.action?type=${type}&expand=${expand}&codeHead.pid=${codeHead.pid}&codeHead.id=${codeHead.id}&codeHead.level=${codeHead.level}&codeHead.type=${codeHead.type}';
		}
		function delchk2(status,id, type){
			var bln=true;
			if(status!=3){
				showMessage1('只有"删除"状态才可以删除!');
				return false;
			}
			$.messager.confirm('提示信息', '删除后可能影响其它业务的正常执行!  确定删除?', function(r){
				if(r){
					$.ajax({
					  type: "POST",
					  url: '<%=request.getContextPath()%>/basic/codename/delete.action',
					  dataType:"text",
					  data:{id:id,type:type},
					  success: function(data){
						  if(data == 'ok'){
							  gback();
						  }
						  showMessage1('删除成功！');
						  $('#codeNameList').datagrid('reload');
					  }
					});
				}
			});
		}
		function newwindow(url){
			$("#myFrame").attr("src",url);
			openWin('newwindowDiv');
			//window.open(url,"_blank","height=400px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no");
		}
	</script>	
	</body>
</html>
