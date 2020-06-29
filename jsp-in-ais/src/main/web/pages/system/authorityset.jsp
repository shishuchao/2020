<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page import="ais.auth.model.AuthAuthority,java.util.List,ais.auth.model.AuthBizFunction"%>
<!DOCTYPE HTML>
<html>
<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
	<title> 操作授权 </title>
	<link href="<%=request.getContextPath()%>/resources/css/site.css" rel="stylesheet" type="text/css">
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
	<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/resources/js/normal.js"></script>
	<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/resources/js/common.js"></script>

	<script language="javascript">
		function CheckShow(str){
			if (document.all(str).style.display==""){
		    	document.all(str).style.display="none";
			}else{
				document.all(str).style.display="";
			} 	
		}
		
		function checkSubmit(){
			//document.all.functions.value=pertree.GetSelectedValue4Auth();
			var all = "";
			$("#s2 option").each(function() {
				all += $(this).attr("value")+",";
			});
			$.ajax({
				url:'<%=request.getContextPath()%>/system/authAuthorityAction!authupdate.action',
				cache:false,
				type:'post',
				data:{
					'roles':all,
					'depid':'${depid}',
					'functions':'${functions}',
					'floginname':'${param.p_floginname}'
				},
				success:function(data){
					if(data == 'success'){
						top.$.messager.show({
							title:'提示消息',
							msg:'用户授权保存成功!',
							timeout:5000,
							showType:'slide'
						});
					}else{
						top.$.messager.show({
							title:'提示消息',
							msg:'用户授权保存失败!',
							timeout:5000,
							showType:'slide'
						});
					}
				}
			});
		}
		$(function(){
			$('#b1').click(function(){
				$obj = $('select option:selected').clone(true);
				if($obj.size() == 0){
					$.messager.show({title:'提示信息',msg:'请至少选择一条！'});
				}
				$('#s2').append($obj);
				$('select option:selected').remove();
			});
			
			$('#b2').click(function(){
				$('#s2').append($('#s1 option'));
			});
			
			$('#b3').click(function(){
				$obj = $('select option:selected').clone(true);
				if($obj.size() == 0){
					$.messager.show({title:'提示信息',msg:'请至少选择一条！'});
				}
				$('#s1').append($obj);
				$('select option:selected').remove();
			});
			
			$('#b4').click(function(){
				$('#s1').append($('#s2 option'));
			});
			
			$('option').dblclick(function(){
				var flag = $(this).parent().attr('id');
				if(flag == "s1"){
					var $obj = $(this).clone(true);
					$('#s2').append($obj);
					$(this).remove();
				} else {
					var $obj = $(this).clone(true);
					$('#s1').append($obj);
					$(this).remove();
				}
			});
			
		});
	</script>
</head>
<body class="easyui-layout" style="overflow: hidden;" fit="true">
	<div region="center" style="overflow: hidden;">
		<div align="left" style="margin: 10px;">
			<a class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="checkSubmit()">保存</a>
		</div>
		<div>
			<img src="<%=request.getContextPath()%>/resources/images/tip.gif" border=0>&nbsp;<font color="21498C"><b>被赋权人:${roleUser.fname}(${roleUser.floginname})</font></b>
		</div>
		<div>
		<b><img src="<%=request.getContextPath()%>/resources/images/tip.gif" border=0>&nbsp;<font color="21498C">用户角色选取</font></b>
		</div>
			<div style="float: left;width:45%" >
				<select id="s1" name="s1" size="15" name="uOrganization.orgType" style="width:100%">
			       <s:iterator value="#request.authRoleL" id="froleid">
					 <option value="<s:property value="froleid"/>"><s:property value="fname"/>(<s:property value="fscopename"/>)</option>
			       </s:iterator>
			    </select>
			</div>
			<div align="center" style="float: left;width:10%" >
				<p><input id="b1" type="button" class="s1" value="&nbsp;&gt;&nbsp;" /></p>
				<p><input type="button" id="b2" class="s1" value="&gt;&gt;" /></p>
				<p><input type="button" id="b3" class="s1" value="&nbsp;&lt;&nbsp;" /></p>
				<p><input type="button" id="b4" class="s1" value="&lt;&lt;" /></p>
			</div>
			<div style="float: left;width:45%">
				<select id="s2" name="s2" size="15" name="uOrganization.orgType" style="width:100%">
			       <s:iterator value="#request.authRoleR" id="froleid">
					 <option value="<s:property value="froleid"/>"><s:property value="fname"/>(<s:property value="fscopename"/>)</option>
			       </s:iterator>
			    </select>
			</div>
	</div>
	<form action="../system/authAuthorityAction!authupdate.action" method="POST">
		<input type="hidden" name="roles">
		<input type="hidden" name="depid">
		<input type="hidden" name="functions">
		<input type="hidden" name="floginname" value="<%=request.getParameter("p_floginname")%>">
	</form>
</body>
</html>
