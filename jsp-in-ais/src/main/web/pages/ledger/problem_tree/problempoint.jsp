<!DOCTYPE HTML>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>问题点</title>

   	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>  
   			<script type="text/javascript" src="${contextPath}/scripts/employeeValidate/checkboxSelected.js"></script>
			<link href="${contextPath}/styles/jquery.multiSelect.css" rel="stylesheet" type="text/css"> 
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
	<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
	<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
	<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
	<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
	<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/autosize.js"></script>
	<script type="text/javascript" src="${contextPath}/scripts/ufaudTextLengthValidator.js"></script>
	<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
	<script type='text/javascript' src='${contextPath}/scripts/jquery.multiSelect.js'></script>
	<s:head theme="simple" />
	<script type="text/javascript">
	/* 	$(function(){
			
		}); */
	 	 $(document).ready(function(){	
	 		$('#bewrite').attr('maxlength',1500);
	 		// 设置多选框的默认选中项。
				$("#belong_pro_type_name").attr("value","");//清空选中项。
				var ids = '${ledgerTemplateNew.belong_pro_type_name}';//选中框ID。
				
				var id_Ojbect = ids.split(",");//分割为Ojbect数组。
				var count = $("#belong_pro_type_name option").length;//获取下拉框的长度。
				for(var c = 0; c < id_Ojbect.length; c++){
					for(var c_i = 0; c_i < count; c_i++) { 
				    	 if($("#belong_pro_type_name").get(0).options[c_i].text == id_Ojbect[c]) { 
				         	$("#belong_pro_type_name").get(0).options[c_i].selected = true;//设置为选中。
				        }  
				    } 
				}
				$("#belong_pro_type_name").multiSelect({ 
					selectAll: false,
					oneOrMoreSelected: '*',
					selectAllText: '全选',
					noneSelected: ''
				}, function(){   //回调函数
					$('#belong_pro_type').attr('name','ledgerTemplateNew.belong_pro_type').val($("#belong_pro_type_name").selectedValuesString());
				}
			);
		 }); 
	</script>
	</head>
	<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout">
	<div region="center" border="0">
		<div class="easyui-panel" title="问题点" style="margin:0;padding:0;width:100%;height:100%;border:0;overflow:scroll;">
			<s:form id="ledgerForm" name="form2" action="save_problempoint.action" namespace="/ledger/problemledger">
				<s:hidden name="ledgerTemplateNew.id"/>
				<s:hidden name="ledgerTemplateNew.fid"/>
				<s:hidden name="ledgerTemplateNew.fname"/>
				<s:hidden name="ledgerTemplateNew.isSort" value="N"/>
				<s:hidden name="id"/>
				<div style="position:fixed;width:100%;top:25px;">
					<table class="ListTable" style="margin:0">
						<tr class="EditHead">
							<td>
								<s:if test="${param.view!='yes'}">
									<a class="easyui-linkbutton" href="javascript:void(0);" iconCls="icon-save" onclick="save()">保存</a>
									<a class="easyui-linkbutton" href="javascript:void(0);" iconCls="icon-delete" onclick="deleteProblemPoint('${ledgerTemplateNew.id}')">删除问题</a>
								</s:if>
							</td>
						</tr>
					</table>
				</div>
				<div style="height: 30px;"></div>
				<s:if test="${param.view!='yes'}">
					<table cellpadding=1 cellspacing=1 border=0 
						class="ListTable" id="tab1" name="tab1" width="100%">
						<tr>
							<td class="EditHead" style="width: 15%">
								<font color=red>*</font>
								&nbsp;问题点编号
	
							</td>
							<td class="editTd">
								<s:textfield cssStyle="width:160px;" cssClass="noborder"
									name="ledgerTemplateNew.code" maxlength="50"></s:textfield>
							</td>
						</tr>
						<tr>
							<td class="EditHead">
								<font color=red>*</font>
								&nbsp;问题点
	
							</td>
							<td class="editTd">
								<s:textfield name="ledgerTemplateNew.name" cssClass="noborder"
									cssStyle="width:400px;" maxlength="50"></s:textfield>
							</td>
						</tr>
						<tr>
						
						<%-- <td class="EditHead" style="border-right-width:0;">
						所属项目类别
						</td>
						<td class="editTd" align="left">
						<select multiple="multiple" id="belong_pro_type_name" name="ledgerTemplateNew.belong_pro_type_name" style="width:35%;">
							<c:forEach items="${spList}" var="s">
								<option value='${s.code }'>
									${s.name }
								</option>
							</c:forEach>
						</select>
						
						<input type="hidden" name="ledgerTemplateNew.belong_pro_type"  id="belong_pro_type"/>
						
						</td> --%>
					</tr> 
						<tr>
							<td class="EditHead" style="border-right-width:0;">
								政策法规依据
								<br/>
								<a id="lr_openZcfgTree" mc='bewrite' href="javascript:void(0);" class="easyui-linkbutton"
								   data-options="iconCls:'icon-search'"  >引用法规制度</a>
								<br/>
								<div style="text-align:right"><font color=DarkGray>(请限1500字)</font></div>
							</td>
							<td class="editTd">
								<s:textarea name="ledgerTemplateNew.bewrite" cssClass="noborder" id="bewrite"
								cssStyle="width:100%;height:100px;overflow-y:visible" title="政策法规依据" />
								<input type="hidden" id="ledgerTemplateNew.bewrite.maxlength"
									value="1500">
							</td>
						</tr>
					</table>
				</s:if>
				<s:else>
					<table cellpadding=1 cellspacing=1 border=0 
					class="ListTable" id="tab1" name="tab1" width="100%">
					<tr>
						<td class="EditHead" style="width: 15%">
							&nbsp;问题点编号
						</td>
						<td class="editTd">
							<s:textfield cssStyle="width:160px;" readonly="true" cssClass="noborder"
								name="ledgerTemplateNew.code" maxlength="50"></s:textfield>
						</td>
					</tr>
					<tr>
						<td class="EditHead">
							&nbsp;问题点
						</td>
						<td class="editTd">
							<s:textfield name="ledgerTemplateNew.name" readonly="true" cssClass="noborder"
								cssStyle="width:400px;" maxlength="50"></s:textfield>
						</td>
					</tr>
						<%-- 		<tr>
						
						<td class="EditHead" style="border-right-width:0;">
						所属项目类别
						</td>
						<td class="editTd" align="left">
							<s:textarea name="ledgerTemplateNew.belong_pro_type_name" rows="3" disabled="true" cssClass="noborder" id="bewrite"
							cssStyle="width:100%;overflow-y:visible;outline:none;background-color:#fff;color:#000;" title="所属项目类别" />
						</td>
					</tr>  --%>
					<tr>
						<td class="EditHead" style="border-right-width:0;">
							政策法规依据
						</td>
						<td class="editTd">
							<s:textarea name="ledgerTemplateNew.bewrite" disabled="true" cssClass="noborder" id="bewrite"
							cssStyle="width:100%;height:100px;overflow-y:visible;outline:none;background-color:#fff;color:#000;" title="政策法规依据" />
							<input type="hidden" readonly="true" id="ledgerTemplateNew.bewrite.maxlength"
								value="1500">
						</td>
					</tr>
				</table>
				</s:else>
			</s:form>
			<jsp:include flush="true" page="/pages/adl/zcfgTree.jsp" />
		</div>
	</div>
	</body>
	<SCRIPT type="text/javascript">
	var tip = "${tip}";
	if(tip == "1"){
		$.messager.show({title:'消息',msg:'保存成功！'});
	}
	/*
	判断问题点编号是否存在
	*/
	function isCodeExist(code){
	  var isProblemExist=false;
	  DWREngine.setAsync(false);
			DWREngine.setAsync(false);DWRActionUtil.execute(
				{ namespace:'/ledger/problemledger', action:'isProblemCodeExist', executeResult:'false' }, 
				{'problemCode':code,'currentId':'${ledgerTemplateNew.id}'},
				xxx);
			function xxx(data){
				isProblemExist = data['isProblemExist'];
			} 
			return isProblemExist;
	}
	function deleteProblemPoint(id){
        top.$.messager.confirm('确认', '确定删除该问题点吗?', function(r){
			if (r){
				 $.ajax({
					type:"post",
					url:"${contextPath}/ledger/problemledger/delete.action?ledgerTemplateNew.id="+id,
					success:function(data){
				    	showMessage1('删除成功！');
				    	parent.parent.reloadSelectedNode('delete');
					}
				});
        	}
        });
	}
	function save(){
		 var type = '${type}';
	     var code=document.getElementsByName('ledgerTemplateNew.code')[0].value;
	     var name=document.getElementsByName('ledgerTemplateNew.name')[0].value;
	     if(code==null||code==''){
	    	 $.messager.show({title:'消息',msg:'问题点编号不能为空!'});
		     return false;
		 }
	     if(name==null||name==''){
	    	 $.messager.show({title:'消息',msg:'问题点不能为空!'});
		     return false;
		 }
	     if(isCodeExist(code)=='true'){
	        $.messager.show({title:'消息',msg:'该问题点编号已经存在!'});
	        return false;
	    }
	    $.ajax({
			type:"post",
			data:$('#ledgerForm').serialize(),
			url:"${contextPath}/ledger/problemledger/save_problempoint.action",
			async:false,
			success:function(){
		    	showMessage1('保存成功！');
		    	parent.parent.reloadSelectedNode(type);
			}
		});
		//document.forms[0].submit();
	}		
	</SCRIPT>
	<script type="text/javascript">
	$("#ledgerForm").find("textarea").each(function(){
		autoTextarea(this);
	});
	</script>
</html>