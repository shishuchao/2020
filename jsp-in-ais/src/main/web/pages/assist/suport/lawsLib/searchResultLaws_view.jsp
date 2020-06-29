<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
<title>法律法规</title>
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
	<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
	<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
</head>
	<body class="easyui-layout" style="overflow:hidden;" fit="true">
		<div style="display:none;">
			<form id="formPara">
			<s:hidden name="assistSuportLawslib.title"/>
			<s:hidden name="assistSuportLawslib.codification"/>
			<s:hidden name="assistSuportLawslib.promulgationDate"/>
			<s:hidden name="assistSuportLawslib.effctiveDate"/>
			<s:hidden name="assistSuportLawslib.invalidationDate"/>
			<s:hidden name="assistSuportLawslib.promulgationDept"/>
			<s:hidden name="assistSuportLawslib.effective"/>
			<s:hidden name="assistSuportLawslib.content"/>
			</form>	
		</div>	
		<div region="center" >
			<table id="objectList"></table>
		</div>
<SCRIPT type="text/javascript">
	function viewInfo(curId,nodeid){
		var myurl = '${contextPath}/pages/assist/suport/lawsLib/edit.action?m_view=true&assistSuportLawslib.id='+curId+'&nodeid='+nodeid+'&m_str=${m_str}&marked=1&queryt=querytitle'
		$("#myFrame").attr("src",myurl);
		$('#myView').window('open');			
	}
	$(function(){
		$('#objectList').datagrid({
			url : "<%=request.getContextPath()%>/pages/assist/suport/lawsLib/indexSearch_flfg_view.action?querySource=grid&"+$("#formPara").serialize(),
			method:'post',
			showFooter:false,
			rownumbers:true,
			pagination:true,
			striped:true,
			autoRowHeight:false,
			fit: true,
			pageSize: 20,
			fitColumns:true,
			idField:'id',	
			border:false,
			singleSelect:true,
			remoteSort: false,
			columns:[[  
				{field:'articleTitle',
						title:'名称',
						align:'left',
						fitColumns:true, 
						sortable:true,
						 formatter:function(value,row,index){
							 return  '<a href=\"javascript:void(0)\" onclick=\"viewInfo(\''+row.id+'\',\''+row.categoryPk+'\');\">'+row.articleTitle+'</a>'
						 }						
				},
				{field:'displayContent',
					title:'检索内容',
					fitColumns:true,
					sortable:true, 
					align:'left'
				},
				{field:'pageshowFileStr',
					 title:'附件',
					 fitColumns:true,
					 align:'left',
					 sortable:true
				},
				{field:'createDate',
					 title:'创建日期',
					 fitColumns:true,
					 align:'center',
					 sortable:true
				}
			]]   
		}); 
	
		    $('#myView').window({
				modal:true,
				fit:true,
				collapsible:false,
				maximizable:true,
				minimizable:false,
				resizable:true,
				closed:true  
		    }); 	
	
	});	
	
</SCRIPT>		
	      <div id="myView" title="法律法规信息查看" style='overflow:hidden;margin:0px;padding:0px;'> 	  		
				<iframe id="myFrame" name="myFrame" title="法律法规信息查看" src="" width="100%" height="100%" frameborder="0"></iframe>				
	      </div>
</body>
</html>