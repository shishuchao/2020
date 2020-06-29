<!DOCTYPE HTML>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
<title>审计案例</title>
<link href="${contextPath}/resources/css/common.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
<script type="text/javascript">
function setNull(name){document.getElementsByName(name)[0].value="";}
function reset2(){
	setNull("assistSuportLawslib.title");
	setNull("assistSuportLawslib.codification");
	setNull("assistSuportLawslib.promulgationDate");
	setNull("assistSuportLawslib.effctiveDate");
	setNull("assistSuportLawslib.invalidationDate");
	setNull("assistSuportLawslib.promulgationDept");
	setNull("assistSuportLawslib.category");
	setNull("assistSuportLawslib.effective");
	setNull("assistSuportLawslib.content");
	setNull("assistSuportLawslib.categoryFk");
	
	//提交重置
	document.forms[0].submit();
}
function mchk(){
	var obj=document.getElementsByName("assistSuportLawslib.title")[0];
	if(obj.value.length>20){
		$.messager.show({title:'消息',msg:'名称长度大于20,请重新输入!'});
		return false;
	}
	return true;
}
function freshGrid(){
	$('#dlgSearch').dialog('open');
}
function doSearch(){
	var code = document.getElementById('lbCode').value
	var obj = form2Json('searchForm');
	if (code != '' && code != null) {
		obj.nodeid = code;
	}
    $('#objectList').datagrid({
		queryParams:obj
	});
	$('#dlgSearch').dialog('close');
}
function restal(){
	resetForm('searchForm');
	$('#pro_type_name').val('');
	//doSearch();
}
function doCancel(){
	$('#dlgSearch').dialog('close');
}
</script>			
</head>
<body style="margin: 0;padding: 0;overflow:hidden;" border="0" class="easyui-layout">
	<div id="dlgSearch" class="searchWindow">
		<div class="search_head">
		<s:form action="../lawsLib/search.action" method="post" onsubmit="return mchk();" id="searchForm">
			<table id="searchTable" cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
			<tr >
				<td class="EditHead" style="width: 15%">
					名称
				</td>
				<td class="editTd" style="width: 35%">
					<s:textfield cssClass="noborder" name="assistSuportLawslib.title" />
				</td>
				<td class="EditHead" style="width: 15%">
					案例编号
				</td>
				<td class="editTd" style="width: 35%">
					<s:textfield cssClass="noborder" name="assistSuportLawslib.codification" />
				</td>
				
			</tr>
			<tr >
				<td class="EditHead">
					类别
				</td>
				<td class="editTd">
					<div>
						<s:textfield readonly="true" cssClass="noborder" name="assistSuportLawslib.category"  id="pro_type_name" />
						<input id="lbCode" name="" type="hidden" value="" />
						<img style="cursor:hand;border:0" src="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png" 
								    	onclick="getItem('/ais/pages/assist/suport/auditcase/searchdate_ajal.jsp','选择类别',500,400)"></img>
					</div>
				</td>
				<td class="EditHead">
					创建日期
				</td>
				<td class="editTd">
						<input type="text" class="easyui-datebox" name="assistSuportLawslib.createDateStart" style="width: 45%"
							editable="false"/>至
						<input class="easyui-datebox"  name="assistSuportLawslib.createDateEnd"  style="width:45%"
							type="text" editable="false" />	
				</td>	
			</tr>
			<tr >
				<td class="EditHead">
					创建单位
				</td>
				<td class="editTd">
					<s:textfield cssClass="noborder" name="assistSuportLawslib.sundept" />
				</td>
				<td class="EditHead">
					正文
				</td>
				<td class="editTd">
					<s:textfield cssClass="noborder" name="assistSuportLawslib.content" />
				</td>
			</tr>
			<s:hidden name="assistSuportLawslib.categoryFk" />
			<s:hidden name="mCodeType" value="${mCodeType}"></s:hidden>
			<s:hidden name="nodeid" value="${nodeid}"></s:hidden>
		</table>
		</s:form>
	</div>
	<div class="serch_foot">
		    <div class="search_btn">
			<a class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>
			<a class="easyui-linkbutton" data-options="iconCls:'icon-reload'" onclick="restal()">重置</a>
			<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="doCancel()">取消</a>
		</div>
	</div>
</div>
	<div region="center" border="0">
		<table id="objectList"></table>
	</div>
	<div id="showLawslibDlg" title="审计案例详细信息" style="overflow:hidden;padding:0">
		<iframe id="showLawslibDlgFrame" src="" width="100%" title="" height="100%" frameborder="0"></iframe>
	</div>
	<div id="subwindow" class="easyui-window" title="类别" style="width:500px;height:500px;padding:5px;" closed="true">
		<div class="easyui-layout" fit="true">
			<div region="center" border="false" style="background:#fff;border:1px solid #ccc;overflow:hidden;">
				<iframe id="item_ifr" name="item_ifr" src="" frameborder="0" width="100%" height="100%" style="overflow:hidden;" ></iframe>
			</div>
			<div region="south" border="false" style="text-align:right;padding:5px 0;">
			    <div style="display: inline;" align="right">
					<a class="easyui-linkbutton" data-options="iconCls:'icon-ok'"  onclick="saveF()">确定</a>
					<a class="easyui-linkbutton" data-options="iconCls:'icon-empty'"  onclick="cleanF()">清空</a>
					<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'"   onclick="closeWin()">关闭</a>
			    </div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		var nodeid=$("input[name=nodeid]").val();
		$(function(){
			showWin('dlgSearch');
			generateWin('subwindow');
			$('#showLawslibDlg').window({
				width: 800,
				height: 450,
				modal: true,
				collapsible: false,
				maximizable: true,
				minimizable: false,
				closed: true
			});
			$('#objectList').datagrid({
				url : "<%=request.getContextPath()%>/pages/assist/suport/lawsLib/search.action?m_view=view&mCodeType=${mCodeType}&querySource=grid&nodeid="+nodeid,
				method:'post',
				rownumbers:true,
				pagination:true,
				striped:true,
				autoRowHeight:false,
				fit: true,
				fitColumns: true,
				idField:'id',	
				border:false,
				singleSelect:true,
				pageSize:20,
				remoteSort: true,
				toolbar:[
					{
						id:'search',
						text:'查询',
						iconCls:'icon-search',
						handler:function(){
							searchWindShow('dlgSearch',800);
						}
					}				
				],
				columns:[[  
	       			{field:'title',title:'名称',width:250,halign:'center',align:'left',sortable:true,
						formatter:function(value,row,rowIndex){
							return row.title;
						}
		       		},
	       			{field:'createDate',title:'创建日期',width:100,sortable:true,halign:'center',align:'right',
		       			formatter:function(value,row,rowIndex){
	       					if(value != null && value != ''){
								return row.createDate.substring(0,10);
		       				}
						}
	       			},
					{field:'sundept',
						title:'创建单位',
						width:200,
						halign:'center',
						align:'left', 
						sortable:true
					},
					{field:'codification',
						title:'案例编号',
						width:80,
						sortable:true, 
						halign:'center',
						align:'right',
						formatter:function(value,row,rowIndex){
							return row.codification;
						}
					},
					{field:'category',
						 title:'类别',
						 width:200,
						 halign:'center',
						 align:'left', 
						 sortable:true,
						 formatter:function(value,row,rowIndex){
						 	return row.category;
						 }
					},
					{field:'operate',
						 title:'操作',
						 width:80, 
						 align:'center', 
						 sortable:false,
						 formatter:function(value,row,index){
								return '<a href="javascript:showLawslib(\''+ row.id +'\')" >详细信息</a>';
						 }
					}
				]]   
			}); 
		});
	function getItem(url,title,width,height){
		$('#item_ifr').attr('src',url);
		openWin('subwindow',title,width,height);
	}
	function saveF(){
		var ayy = $('#item_ifr')[0].contentWindow.saveF();
   		document.all('pro_type_name').value=ayy[0];
   		document.getElementById('lbCode').value = ayy[1];
   		closeWin()
	}
	function cleanF(){
		document.all('pro_type_name').value='';
   		closeWin();
	}
	function closeWin(){
		$('#subwindow').window('close');
	}
	function showLawslib(id) {
		var url = '${contextPath}/pages/assist/suport/lawsLib/edit.action?m_view=true&assistSuportLawslib.id=' + id + '&nodeid=${nodeid}&m_str=${m_str}';
		$('#showLawslibDlgFrame').attr('src', url);
		$('#showLawslibDlg').window('open');
	}
	</script>
</body>
</html>