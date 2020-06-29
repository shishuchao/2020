<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
		<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
		
		<script type="text/javascript" src="${contextPath}/scripts/calendar.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/turnPage.js'></script>
		<s:head theme="ajax" />

		<script type="text/javascript">
		${malert}
	function deleteOne(fileId){
		if(confirm("确认删除该文件？")){
			document.location = "${contextPath}/pages/assist/suport/lawsLib/deleteFile.action?fileId="+fileId;
		}else{
			return false;
		}
	}
	function deleteAll(){
		if(confirm("确认删除所有上传文件？")){
			document.location = "${contextPath}/pages/assist/suport/lawsLib/deleteAllFile.action";
		}else{
			return false;
		}
	}
	var theFileId;
	function enterImp(fileId){
		document.getElementById("impConfig").style.display = '';
		theFileId = fileId;
	}
	function imp(){
		var impConfigs = document.getElementsByName("impConfig");
		var impConfig = "";
		for(var i=0;i<impConfigs.length;i++){
			if(impConfigs[i].checked){
				impConfig = impConfigs[i].value;
				break;
			}
		}
		if(impConfig==""){
			alert("请设置导入策略！");
			return false;
		}
		if(impConfig==4&&!confirm("\"导入前清空\"策略将删除现有的所有法律法规，仍确认执行？")){
			return false;
		}
		document.location = "${contextPath}/pages/assist/suport/lawsLib/imp.action?fileId="+theFileId+"&impConfig="+impConfig;
	}
	function cancel(){
		theFileId = "";
		document.getElementById("impConfig").style.display = 'none';
	}
	function validateSubmit(){
		var filePath = document.uploadForm.upload.value;
		if(filePath==""){
			alert("选择要上传的文件！");
			return false;
		}
		if(filePath.lastIndexOf('.zip') == -1){
			alert('请上传.zip压缩文件');
			return false;
		}
		return true;
	}
	function download(){
		window.location.href="${contextPath}/templatedownload?file=lawslib_template.xls&&type=lawslib";
	}
</script>

		<title>法规制度导入管理</title>
	</head>
	<body  style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout">	
			
				<table id="fileList"></table>
		<br/>
		<table style="width: 100%;padding: 0;border-spacing: 0;border-collapse: 0;" id="impConfig">
			<tr >
				<td class="EditHead"  colspan="20" >
					<span style="float:left">设置导入策略</span>
				</td>
			</tr>
			<tr>
				<td class="editTd"   >
					<span style="float:right">
					<!-- 应刘爽要求取消4:'导入前清空'    by wk 2016 10 .30 -->
					<s:radio  name="impConfig" list="#@java.util.LinkedHashMap@{0:'跳过重复',2:'追加导入',3:'发现重复取消导入'}"></s:radio>
					</span>
				</td>
				<td  width="20%"  class="editTd" >
					<span style="float:right">
						<a class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="imp()">执行导入</a>&nbsp;&nbsp;
						<a class="easyui-linkbutton" data-options="iconCls:'icon-undo'" onclick="cancel()">取消</a>&nbsp;&nbsp;
					</span>
				</td>
			</tr>
		</table>
		<br/>
		<br/>
		<s:form action="upload.action" namespace="/pages/assist/suport/lawsLib" id="searchForm"
			method="post" name="uploadForm" enctype="multipart/form-data" onsubmit="">
		<table  style="padding: 0;border-spacing: 0;border-collapse: 0;width: 100%;">
			<tr >
				<td align="left" class="EditHead" style="width: 10%" colspan="1">
					上传文件 
				</td>
				<td class="editTd" colspan="2" align="left">
					<font color="#000000" style="font-weight: normal">在模板中填写名称、文号等基础信息，并在所在目录和文件列表列填写附件信息，并将模板和法律法规文件压缩成ZIP包上传
					</font>
				</td>
			</tr>
			<tr>
				<td class="EditHead" align="right">
							选择文件：
				</td>
				<td class="editTd" align="left" >
					<s:file  label="上传压缩包" size="80%" name="upload" cssStyle="align:center"></s:file>
				</td>
				<td class="editTd" style="">
					<a class="easyui-linkbutton" data-options="iconCls:'icon-upload'" onclick="shangchuan()">上传</a>&nbsp;&nbsp;
					<a class="easyui-linkbutton" data-options="iconCls:'icon-download'" onclick="download()">下载模板</a>&nbsp;&nbsp;
					
				</td>
			</tr>
		</table>
		</s:form>
	<script type="text/javascript">
		function shangchuan(){
			var boo = validateSubmit();
			if(!boo){
				return;
			}
			var submit=document.getElementById("searchForm");
	    	submit.submit();
		}
		$(function(){
			document.getElementById("impConfig").style.display = 'none';
			$('#fileList').datagrid({
				url : "<%=request.getContextPath()%>/pages/assist/suport/lawsLib/enterUpload.action?querySource=grid",
				method:'post',
				showFooter:false,
				rownumbers:true,
				pagination:true,
				striped:true,
				autoRowHeight:false,
				width:'100%',
				height:'50%',
				fit: false,
				fitColumns:false,
				border:false,
				singleSelect:true,
				remoteSort: false,
				toolbar:[{
					id:'remove',
					text:'删除全部',
					iconCls:'icon-delete',
					handler:function(){
						deleteAll();
					}
				}],
				frozenColumns:[[
				       			{field:'fileName',title:'文件名称',width:'200px',align:'center'},
				       			{field:'fileSize',title:'文件大小',width:'100px',sortable:true,align:'center',
				       				formatter:function(value,rowData,rowIndex){
				       					return rowData.fileSize+'K';
				       				}
					       		}
				    		]],
				columns:[[  
					{field:'uploader',
							title:'上传人',
							width:250,
							align:'center', 
							sortable:true
					},
					{field:'uploadTime',
						title:'上传日期',
						width:250,
						sortable:true, 
						align:'center',
						formatter:function(value,row,rowIndex){
							if(row.uploadTime!=null){
								return row.uploadTime.substring(0,10);
							}
						}
					},
					{field:'operate',
						 title:'操作',
						 width:200, 
						 align:'center', 
						 sortable:true,
						 formatter:function(value,row,index){
							 return '<a href=\"javascript:void(0)\" onclick=\"enterImp(\''+row.id +'\');\">导入</a>|<a href=\"javascript:void(0)\" onclick=\"deleteOne(\''+row.id+'\');\">删除</a>';
						 }
					}
				]]   
			}); 
		});
	</script>
	</body>
</html>