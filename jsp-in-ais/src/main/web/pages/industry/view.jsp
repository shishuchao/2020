<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<!DOCTYPE HTML>
<html>
	<head>
		<title>查看行业性质</title>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1" />
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
		<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script> 
		<script type="text/javascript" src="<%=request.getContextPath()%>/scripts/calendar.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/scripts/check.js"></script>
		<link rel="stylesheet" type="text/css" href="${contextPath}/resources/csswin/subModal.css" />
		<link rel="stylesheet" type="text/css" href="${contextPath}/styles/main/aisCommon.css" />
		<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/csswin/subModal.js"></script>
		<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<s:head theme="simple" />
		<script type="text/javascript">
		function loadForm(){
			var operateResult = document.getElementById("operateResult").value;
			if(operateResult=='true'){
				//alert("保存成功！");
				parent.$('#zcfgTreeSelect').tree('reload');
			}else if(operateResult=='false'){
				showMessage1("删除失败！");
			}
			parent.zcfgTreeSelect.location.reload();
		}
		function delIndustry(code){
			$.messager.confirm('提示信息','确认删除吗？',function(isDel){
				if(isDel){
					if(validateRepeat(code)){
						window.location='${contextPath}/industry/delete.action?code='+code;
						showMessage1('删除成功！');
						return true;
					}else{
						$.messager.confirm('提示信息','存在下级行业性质，点击确定全部删除？',function(isDel){
							if(isDel){
								window.location='${contextPath}/industry/delete.action?code='+code;
								showMessage1('删除成功！');
								return true;
							}
						});
					}
				}
			});
		}
		function deleteasd(id){
			$.messager.confirm('提示信息','确认删除吗？',function(isDel){
				if(isDel){
					window.location.href='${contextPath}/industry/delete.action?code='+id;
					parent.$('#zcfgTreeSelect').tree('reload');
					showMessage1('删除成功！');
					return true;
				}
			});
		}
		function validateRepeat(code){
			var flag = false;
			DWREngine.setAsync(false);
			DWRActionUtil.execute(
			{ namespace:'/industry', action:'validateChild', executeResult:'false' }, 
			{ 'code':code },callbackFun);
		    function callbackFun(data){
		     	var result = data['message'];
		     	if( result!= null && result >1){
		     		flag = false;
		     	}else{
		     		flag = true;
		     	}
			}
			return flag;
		}
		</script>
	</head>
	<body onload="loadForm()" style="overflow:hidden">
		<s:hidden name="operateResult" id="operateResult"></s:hidden>
		<table id="tableTitle" class="ListTable" width="100%" border=0 cellPadding=0 cellSpacing=1 align="center">
			<tr >
				<td colspan="4" align="left" class=editTd bgcolor="#FAFAFA">
					行业性质
				</td>
			</tr>
		</table>
		<TABLE id="tab1" width="100%" border=0 cellPadding=0 cellSpacing=1 class=ListTable align="center">
			<TR>
				<TD class=EditHead width="10%" >
					行业编码
				</TD>
				<TD class=editTd width="35%" align="left">
					<s:property id="ss" value="industry.code"/>
				</TD>
				<TD class=EditHead width="10%" >
					行业名称
				</TD>
				<TD class="editTd" width="35%" align="left">
					<s:property value="industry.name"/>
				</TD>
			</TR>
			<TR>
				<TD class=EditHead width="10%" >
					上级编码
				</TD>
				<TD class="editTd" width="35%" align="left">
					<s:property value="industry.parentCode"/>
				</TD>
				<TD class=EditHead width="10%" >
					上级名称
				</TD>
				<TD class="editTd" width="35%" align="left">
					<s:property value="industry.parentName"/>
				</TD>
			</tr>
			<tr>
				<!-- <TD class=ListTableTr1 width="10%" >
					创建人
				</TD>
				<TD class="ListTableTr22" width="34%" align="left">
					<s:property value="industry.creator"/>
				</TD>  -->
				<TD class=EditHead width="10%" >
					创建时间
				</TD>
				<TD class="editTd" width="35%" align="left">
					<s:property value="viewTime"/>
				</TD>
				<td class="editTd" colspan="2"></td>
			</TR>
<!--			<tr style="padding-top: 10px;" >-->
<!--				<td class="editTd" colspan="10" align="right">-->
<!--					<div align="center" style="padding: 10px 0;" >-->
<!--						<a  href="javascript:void(0)" class="easyui-linkbutton " data-options="iconCls:'icon-add'" -->
<!--				 onclick="window.location='${contextPath}/industry/edit.action?parentCode=${industry.parentCode}'" >增加本级</a>&nbsp;&nbsp;-->
<!--				<s:if test="${industry.level+1<5}">-->
<!--					<a href="javascript:void(0)" class="easyui-linkbutton " data-options="iconCls:'icon-add'" -->
<!--					onclick="window.location='${contextPath}/industry/edit.action?parentCode=${industry.code}'" >增加下级</a>&nbsp;&nbsp;-->
<!--				</s:if>-->
<!--					<a href="javascript:void(0)" class="easyui-linkbutton " data-options="iconCls:'icon-edit'" -->
<!--					onclick="window.location='${contextPath}/industry/edit.action?id=${industry.id}'">修改</a>&nbsp;&nbsp;-->
<!--					<a href="javascript:void(0)" class="easyui-linkbutton " data-options="iconCls:'icon-remove'" -->
<!--					onclick="window.location='${contextPath}/industry/delete.action?code=${industry.code}'" >删除</a>-->
<!--					</div>-->
<!--				</td>-->
<!--			</tr>-->
		</TABLE>
		<br>
		<div align="center" style="overflow:hidden" >
			<a href="javascript:void(0)" class="easyui-linkbutton "data-options="iconCls:'icon-add'" 
			 onclick="window.location='${contextPath}/industry/edit.action?parentCode=${industry.parentCode}'" >增加本级</a>
<!--			<input type="button" value="增加本级" onclick="window.location='${contextPath}/industry/edit.action?parentCode=${industry.parentCode}'">-->
			<s:if test="${industry.level+1<5}">
				<a href="javascript:void(0)" class="easyui-linkbutton " data-options="iconCls:'icon-add'" 
				onclick="window.location='${contextPath}/industry/edit.action?parentCode=${industry.code}'" >增加下级</a>
<!--			<input type="button" value="增加下级" onclick="window.location='${contextPath}/industry/edit.action?parentCode=${industry.code}'">-->
			</s:if>
				<a href="javascript:void(0)" class="easyui-linkbutton " data-options="iconCls:'icon-edit'" 
				onclick="window.location='${contextPath}/industry/edit.action?id=${industry.id}'">修改</a>
				<a class="easyui-linkbutton " data-options="iconCls:'icon-delete'" 
				onclick="deleteasd('${industry.code}')" >删除</a>
<!--			<input type="button" value="删除" onclick="window.location='${contextPath}/industry/delete.action?code=${industry.code}'">-->
<!--			<input type="button" value="修改" onclick="window.location='${contextPath}/industry/edit.action?id=${industry.id}'">-->
		</div>
	</body>
</html>
