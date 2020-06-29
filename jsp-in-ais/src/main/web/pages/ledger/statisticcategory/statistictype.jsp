<!DOCTYPE HTML>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<html>
<head>
	<meta http-equiv="X-UA-Compatible" content="IE=5">
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>统计类别分类</title>
	<link href="${contextPath}/styles/main/aisCommon.css" rel="stylesheet" type="text/css">
	<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
	<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
	<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
	<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
	<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
	<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
	<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/csswin/subModal.js"></script>
	<%-- <script type='text/javascript' src='${pageContext.request.contextPath}/scripts/turnPage.js'></script> --%>
	<script type="text/javascript" src="<%=request.getContextPath()%>/scripts/check.js"></script>
	
	
	<script language="javascript">
		var tip = "${tip}";
		if(tip == "1"){
			window.parent.$.messager.show({
				title:'消息',
				msg:'保存成功！'
			});
		}
     function addCategory(id){
       	if(id == ""){
       		$.messager.show({
    			title:'消息',
    			msg:'请先保存，再增加类别！'
    		});
       	}else{
           	window.location.href='<%=request.getContextPath()%>/ledger/problemledger/add_type_node.action?view=&&id='+id;
       	}
       }
       function deleteCategory(id){
			    	$.ajax({
						dataType:'json',
						url: "/ais/ledger/problemledger/getValidateStatisticcategory.action",
						data: {id:id},
						type: "post",
						success: function(data){
							if(data.state == 'fail'){
								$.messager.confirm('提示信息','确定删除吗?',function(flag){
									if(flag){
										window.location.href='<%=request.getContextPath()%>/ledger/problemledger/deleteCategory.action?statisticCategory.id='+id;
									}
								});
							}else{
								showMessage1('只有当前节点下无子节点才可以删除');
							}
						},
						error:function(data){
							showMessage1('请求失败！');
						}
					});
       }
       function addStatisticCategory(id){
     	 if(id == ""){
     		top.$.messager.show({
    			title:'消息',
    			msg:'请先保存，再增加统计类别！'
    		});
       	}else{
       		window.location.href='<%=request.getContextPath()%>/ledger/problemledger/add_statisticcategory.action?statisticCategory.id='+id;
       	}        

       }

       /*
   	判断问题点编号是否存在
   	*/
   	function isCodeExist(code){
   	  var isCategoryExist=false;
   	  DWREngine.setAsync(false);
   			DWREngine.setAsync(false);DWRActionUtil.execute(
   				{ namespace:'/ledger/problemledger', action:'isCategoryCodeExist', executeResult:'false' }, 
   				{'categoryCode':code,'currentId':'${statisticCategory.id}'},
   				xxx);
   			function xxx(data){
   				isCategoryExist = data['isCategoryExist'];
   			} 
   			return isCategoryExist;
   	}

   	function save(){
   		 var code=document.getElementsByName('statisticCategory.code')[0].value;
   		 var name=document.getElementsByName('statisticCategory.name')[0].value;
   		 if(code==null||code==''){
   			top.$.messager.show({
   		 		title:'消息',
   		 		msg:'请输入类别编号'
			});
   		 	return;
   		 }
   		 if(name==null||name==''){
   		 	top.$.messager.show({
		 		title:'消息',
		 		msg:'请输入类别分类'
			});
   		 	return;
   		 }
		 if(isCodeExist(code)=='true'){
		 	top.$.messager.show({
		 		title:'消息',
		 		msg:'该问题类别编号已经存在!'
			});
		    return false;
		 }
		 $.ajax({
			type:"post",
			data:$('#myform').serialize(),
			url:"${contextPath}/ledger/problemledger/save_category.action?isAdd=true",
			async:false,
			success:function(){
				 parent.parent.reloadSelectedNode();
				 showMessage1('保存成功！');
			}
		 });
		 //document.forms[0].submit();
	}
			
	<s:if test="${refresh=='Y'}">
			window.parent.parent.frames[0].location.reload();
	</s:if>
	<s:if test="${message=='error'}">
		$.messager.show({
	 		title:'消息',
	 		msg:'删除失败，该类别存在子节点!'
		});
	</s:if>
</script>
</head>
<body>
	<div class="easyui-panel" title="问题类别" fit=true
		style="overflow: visibility;">
		<s:form id="myform" name="problemtype" action="/ledger/problemledger/save_category.action"
			namespace="/ledger/problemledger">
			<s:if test="${param.view!='yes'}">
				<table  id="tab1" cellpadding=1 cellspacing=1 border=0 class="ListTable">
					<tr>
						<td class="EditHead" style="border-right-width:0; ">
							<FONT color=red>*</FONT>&nbsp;统计类别分类编号:
						</td>
						<td class="editTd" style="border-right-width:0; ">
							<s:textfield id="bianhao" cssClass="noborder" cssStyle="width:160px;" name="statisticCategory.code" maxlength="50"></s:textfield>
						</td>
						<td class="EditHead" style="border-right-width:0; ">
							<FONT style="color: red;">*</FONT>&nbsp;统计类别分类:
						</td>
						<td class="editTd">
							<s:textfield id="fenlei" cssClass="noborder" cssStyle="width:160px;" name="statisticCategory.name" maxlength="50"></s:textfield>
						</td>
					</tr>
					<s:hidden name="statisticCategory.id"></s:hidden>
					<s:hidden name="statisticCategory.fid"></s:hidden>
					<s:hidden name="statisticCategory.fname"></s:hidden>
					<s:hidden name="statisticCategory.isSort"></s:hidden>
					<s:hidden name="id"></s:hidden>
				</table>
			</s:if>
			<s:else>
				<table  id="tab1" cellpadding=1 cellspacing=1 border=0 class="ListTable">
					<tr>
						<td class="EditHead" style="border-right-width:0; ">
							&nbsp;统计类别分类编号:
						</td>
						<td class="editTd" style="border-right-width:0; ">
							${statisticCategory.code}
						</td>
						<td class="EditHead" style="border-right-width:0; ">
							&nbsp;统计类别分类:
						</td>
						<td class="editTd">
							${statisticCategory.name}
						</td>
					</tr>
					<s:hidden name="statisticCategory.id"></s:hidden>
					<s:hidden name="statisticCategory.fid"></s:hidden>
					<s:hidden name="statisticCategory.fname"></s:hidden>
					<s:hidden name="statisticCategory.isSort"></s:hidden>
					<s:hidden name="id"></s:hidden>
				</table>
			</s:else>
			<div style="height: 10px;"></div>
			<div style="text-align:right;padding-right:5px;" >
				<s:if test="${param.view!='yes'}">
					<a class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="addCategory('${statisticCategory.id}');">增加分类</a>&nbsp;&nbsp;
					<s:if test="${not empty (statisticCategory.fid) and statisticCategory.fid!='0' and statisticCategory.isSort=='Y'}">
						<a class="easyui-linkbutton" data-options="iconCls:'icon-delete'" onclick="deleteCategory('${statisticCategory.id}');">删除分类</a>&nbsp;&nbsp;
						<a class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="addStatisticCategory('${statisticCategory.id}');">增加统计类别</a>&nbsp;&nbsp;
					</s:if>
					<a class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="save();">保存</a>
				</s:if>
			</div>
		</s:form>
	</div>
</body>
</html>