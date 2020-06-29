<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML>
<html>
<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<title>审计方案库回传方案查看</title>
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
	<script language="javascript">
		function searchList(){
		    //匹配查询
			var url = "${contextPath}/operate/template/searchRet.action";
			searchForm.action = url;
			searchForm.submit();
			
		}
		function searchrecal(){
			var url = "${contextPath}/operate/template/searchRet.action";
		    window.location = url;
		}
		//编辑
        function viewRecord(s){
        	var url = "${contextPath}/operate/template/mainView.action?audTemplateId="+s;
        	showWinIf('winPage',url,'查看审计方案内容',1000);
        	/*
	        win = window.open("${contextPath}/operate/template/mainView.action?audTemplateId="+s,"","height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no");
	        var h = window.screen.availHeight;
	        var w = window.screen.width; 
	    	win.moveTo(0,0),
	        win.resizeTo(w,h) 
	    	if(win && win.open && !win.closed) {
	           win.focus();
	    	}
	    	*/
		} 
	    function doSearch(){
        	$('#cunlist').datagrid({
    			queryParams:form2Json('searchForm')
    		});
    		$('#templateReSearch').dialog('close');
	    }
    </script>
</head>
<body class="easyui-layout" fit='true' border='0'>
	<div id="templateReSearch" class="searchWindow">
		<div class="search_head">
			<form id="searchForm" name="searchForm" action="/ais/operate/template/searchRet.action" method="post">
				<table cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
					<tr >
						<td class="EditHead" style="width:15%">方案名称</td>
						<!--标题栏-->
						<td class="editTd" style="width:35%">
							<!--一般文本框-->
							<s:textfield  cssClass="noborder" name="audTemplate.templateName" cssStyle="width:80%;" />
						</td>
	
						<td class="EditHead" style="width:15%">编制人</td>
						<!--标题栏-->
						<%-- onclick="showPopWin('/ais/pages/system/search/frameselect4s.jsp?url=../userindex.jsp&paraname=audTemplate.proAuthorName&paraid=audTemplate.proAuthorCode',600,450)" --%>
						<td class="editTd" style="width:35%">
							<s:textfield cssClass="noborder" cssStyle="width:80%;" name="audTemplate.proAuthorName"></s:textfield>
							<s:hidden name="audTemplate.proAuthorCode" />
							<img src="<%=request.getContextPath()%>/resources/images/s_search.gif"
								onclick="showSysTree(this,
									{ url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action',
										param:{
											'p_item':1,
											'orgtype':1
										},
									      title:'请选择编制人',
									      // 审计人员选择模式
									      type:'treeAndEmployee'
									})"
								border=0 style="cursor: hand">
							<!-- 
						扩展的时候,需要增加参数如下
						eg.
							search/frameselect4s.jsp?url=../userindex.jsp&paraname=users&paraid=usersid&extend=5
					 -->
						</td>
					</tr>
					<tr >
						<td class="EditHead">编制日期</td>
						<td class="editTd" colspan="3">
							<input type="text" name="audTemplate.proDate1" title="单击选择日期" editable="false" class="easyui-datebox" style="width:28%;" />
							-
							<input type="text" class="easyui-datebox" editable="false" name="audTemplate.proDate2" title="单击选择日期" style="width:28%;" />
						</td>
					</tr>
				</table>
				<s:hidden name="type" />
			</form>
		</div>
		<div class="serch_foot">
	        <div class="search_btn">
				<a class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>
				<a class="easyui-linkbutton" data-options="iconCls:'icon-reload'" onclick="searchrecal()">重置</a>
				<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="$('#templateReSearch').window('close')">取消</a>
			</div>
		</div>
	</div>
	<div region="center" border='0'>
		<table id="cunlist"></table>
	</div>
	<div id="winPage"></div>
	<script type="text/javascript">
		$(function(){
			showWin('templateReSearch');
			showWin('winPage','弹框共用页面');
			$('#cunlist').datagrid({
				url : "<%=request.getContextPath()%>/operate/template/searchRet.action?querySource=grid",
				method:'post',
				showFooter:false,
				rownumbers:true,
				pagination:true,
				striped:true,
				autoRowHeight:false,
				fit: true,
				pageSize: 20,
				fitColumns: true,
				idField:'id',	
				border:false,
				singleSelect:true,
				remoteSort: false,
				toolbar:[{
						id:'searchObj',
						text:'查询',
						iconCls:'icon-search',
						handler:function(){
							searchWindShow('templateReSearch');
						}
					}],
				columns:[[  
					{field:'templateName',
	       			 title:'方案名称',
	       			 width:200,
	       			 halign:'center',
	       			 align:'left',
	       			 sortable:true,
	       			 formatter:function(value,row,index){
							 return '<a href="javascript:void(0);" onclick=\"viewRecord(\''+row.audTemplateId+'\'); return false;\">'+row.templateName+'</a>&nbsp;&nbsp';
						 }
	       			},
	       			{field:'proVer',title:'方案版本',sortable:true,width:100,halign:'center',align:'left'},
					{field:'typeName',
							title:'类别名称',
							width:150,
							halign:'center',
							align:'left', 
							sortable:true
						},
					{field:'typeName2',
						title:'子类别名称',
						width:150,
						halign:'center',
						sortable:true, 
						align:'left'
					},
					{field:'proAuthorName',
						 title:'编制人',
						 width:100,
						 halign:'center',
						 align:'left', 
						 sortable:true
					},
					{field:'proDate',
						 title:'编制日期',
						 width:100,
						 halign:'center',
						 align:'center', 
						 sortable:true,
						 formatter:function(value,row,index){
					 		if(value!=null){
					 			return value.substring(0,10);
					 		}
						 }
					}
				]]   
			}); 
		});
	</script>
</body>
</html>

