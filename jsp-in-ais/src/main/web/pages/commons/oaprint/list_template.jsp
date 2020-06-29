<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE HTML>
<s:text id="title" name="'模板列表'"></s:text>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title><s:property value="#title" /></title>
		<link rel="stylesheet" type="text/css"
				href="${contextPath}/resources/csswin/subModal.css" />
		<script type="text/javascript"
			src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript"
			src="${contextPath}/resources/csswin/subModal.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>  
		<link href="${contextPath}/resources/css/common.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
		<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
		<STYLE type="text/css">
			.datagrid-row {
			  	height: 30px;
			}
			.datagrid-cell {
				height:10%;
				padding:1px;
			}
		</STYLE>
		<script language="javascript">
		/*
			*  打开或关闭查询面板
			*/
		function triggerSearchTable(){
			var isDisplay = document.getElementById('planTable').style.display;
			if(isDisplay==''){
				document.getElementById('planTable').style.display='none';
			}else{
				document.getElementById('planTable').style.display='';
			}
		}		
		function deleteTemplate(tpid){
			$.messager.confirm("确认","确认删除该模板吗？",function(r){
				if(r){
					window.location="${contextPath}/commons/oaprint/deleteTemplate.action?tid="+tpid;
				}
			});
		}
		</script>
	</head>
<body class="easyui-layout">	
	<div id="dlgSearch" class="searchWindow">
		<div class="search_head">	
			<s:form action="listTemplate" namespace="/commons/oaprint" id="searchForm" method="post">
					<table cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
					<tr>
						<td class="EditHead" align="left" >
							模板名称
						</td>
						<td class="editTd" align="left">
							<s:textfield name="filename" cssClass="noborder" cssStyle="160px" />
						</td>
						<td class="EditHead" align="left">
							模块列表
						</td>
						<td class="editTd" align="left">
								<select class="easyui-combobox" name="modulename" style="width:150px;" >
							   			
							   	    <option value="">&nbsp;</option>
							      	 <s:iterator value="bpmtableMap" id="status">
							         <option value="<s:property value="key"/>"><s:property value="value"/></option>
							       </s:iterator>
							    </select>
						</td>
						
					</tr>
				</table>
				</s:form>
			</div>
			<div class="serch_foot">
		        <div class="search_btn">
					<a class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>&nbsp;
					<a class="easyui-linkbutton" data-options="iconCls:'icon-reload'" onclick="window.location.href='${pageContext.request.contextPath}/commons/oaprint/listTemplate.action'">重置</a>&nbsp;
					<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="doCancel()">取消</a>
				</div>
		    </div>	
	</div>
	<div region="center" >
		<table id="its"></table>
	</div>
		<div id="listBookMarks"></div>
		<div id="editBookMarks">
			
		</div>
		
		
		
		
	<script type="text/javascript">
	    /*
		* 查询
		*/
		function doSearch(){
        	$('#its').datagrid({
		  		queryParams:form2Json('searchForm')
		  	});
			$('#dlgSearch').dialog('close');
        }
        /*
		* 取消
		*/
		function doCancel(){
			$('#dlgSearch').dialog('close');
		}
		/**
			重置
		*/
		$(function(){
		    //$('body').layout('collapse','north');
		    //$(document).bind("contextmenu",function(e){return false;});//禁用右键菜单
			showWin('dlgSearch');
			// 初始化生成表格
			$('#its').datagrid({
				url : "<%=request.getContextPath()%>/commons/oaprint/listTemplate.action?querySource=grid",
				method:'post',
				showFooter:false,
				rownumbers:true,
				pagination:true,
				striped:true,
				autoRowHeight:true,
				fit: true,
				pageSize: 20,
				fitColumns:true,
				idField:'id',	
				border:false,
				singleSelect:false,
				remoteSort: false,
				toolbar:[{
						id:'search',
						text:'查询',
						iconCls:'icon-search',
						handler:function(){
							searchWindShow('dlgSearch');
						}
					},
					{
						id:'add',
						text:'添加模板',
						iconCls:'icon-add',
						handler:function(){
							window.location='${pageContext.request.contextPath}/commons/oaprint/addTemplate.action?FileType=.doc';
						}
					}
				],
				columns:[[  
					{field:'modulename',title:'对应模块名称',width:200,halign:'center',align:'left',sortable:true},
				       			{field:'filename',title:'模板名称',width:200,sortable:true,halign:'center',align:'left'},
					{field:'descript',
							title:'模块描述',
							width:200,
							halign:'center',
							align:'left', 
							sortable:true
							},
					{field:'optaion',
								title:'操作',
								width:150,
								halign:'center',
								align:'center', 
								sortable:true,
								formatter:function(value,rowData,rowIndex){
									var param = [rowData.templateid];
									var btn2 = "修改,editoption,"+param.join(',')+"-btnrule-删除,deleteTemplate,"+param.join(',')+"-btnrule-标签,listBookMarks,"+param.join(',');
									return ganerateBtn(btn2);
									//return '<a href="javascript:void(0)" onclick="editoption(\''+rowData.templateid+'\')" target="_self" >编辑</a>&nbsp&nbsp<a href="javascript:void(0)" onclick="javascript:deleteTemplate(\''+rowData.templateid+'\')" target="_self">删除</a>&nbsp&nbsp<a href="javascript:void(0);" onclick="listBookMarks(\''+rowData.templateid+'\')">标签</a>';
								}
					}
				]]   
			}); 
		});
	</script>
		
		<script type="text/javascript">
		
		//编辑
		function editoption(value){
			window.location='${contextPath}/commons/oaprint/editTemplate.action?tid='+value;
		}
		
		
		
		function listBookMarks(tid){
			$("#listBookMarks").dialog({
				title: '标签列表',
				width: 700,
				height: 400,
				cache: false,
				resizable:true,
				href: '${contextPath}/commons/oaprint/listTempBookMarks.action?tid='+tid,
				modal: true
			});
		}
		function editTempBookMarks(tbmid,tid){
			$("#editBookMarks").dialog({
				title: '标签维护',
				width: 600,
				height: 300,
				cache: false,
				resizable:true,
				href: '${contextPath}/commons/oaprint/editTempBookMarks.action?tid='+tid+'&bookMarks.tbmid='+tbmid,
				modal: true
			});
		}
		function saveTempBookMarks(tid){
			$("#ff").form({
				url:'${contextPath}/commons/oaprint/saveTempBookMarks.action',
				onSubmit:function(){
					if($('#bookmarkid').val()==null||$('#bookmarkid').val()==''||$('#bookmarktext').val()==null||$('#bookmarktext').val()==null){
						showMessage1('标签编码及标签文字均不能为空！');
						return false;
					}
				},
				success:function(data){
					if(data=='true'){
						showMessage2('保存成功！');
						$("#editBookMarks").dialog('close',false);
						$("#listBookMarks").dialog('refresh','${contextPath}/commons/oaprint/listTempBookMarks.action?tid='+tid);
					}else{
						showMessage1('保存失败，请重试！');
						return false;
					}
				}
			});
			$("#ff").submit();
		}
		function deleteTempBookMarks(tbmid,tid){
			$.messager.confirm("确认","确认要删除此标签吗，删除后模板中将无法引用？",function(r){
				if(r){
						$.ajax({
							type:'get',
							cache:false,
							url:'${contextPath}/commons/oaprint/deleteTempBookMarks.action?bookMarks.tbmid='+tbmid,
							success:function(data){
								if(data=='true'){
									showMessage2('删除成功！');
									$("#listBookMarks").dialog('refresh','${contextPath}/commons/oaprint/listTempBookMarks.action?tid='+tid);
								}else{
									showMessage1('删除失败，请重试！');
									return false;
								}
							}
						});
					}
				});
		}
		</script>
	</body>
</html>
