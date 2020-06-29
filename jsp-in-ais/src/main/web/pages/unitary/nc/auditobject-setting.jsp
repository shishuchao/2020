<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ page import="ais.webservice.ais.ws.usermanager.SmartBiUtil"%>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>被审计单位设置</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ufaudTextLengthValidator.js"></script>
	</head>
	<body>
		<table cellpadding=0 cellspacing=1 border=0 
			class="ListTable" width="100%" align="center">
			<tr class="">
				<td colspan="4" class="EditHead" style="text-align: left;width: 100%;">
					<s:property escape="false" value="@ais.framework.util.NavigationUtil@getNavigation('/ais/unitary/nc/auditObjectSeting.action')"/>
				</td>
			</tr>
		</table>
		
		<s:form id="auditObjectSetForm" action="saveAuditObjectSet" name="auditObjectSetForm">
			<table cellpadding=0 cellspacing=1 border=0  class="ListTable" align="center" style="width: 50%;">
				
				<tr>
					<td class="EditHead">
						被审计单位是否集中存储
					</td>
					<td class="editTd">
						是<input type="radio" name="bDataAuditObjectSet.status"  checked="checked" value="Y"  onclick="changeType(this.value)" />
						
						否<input type="radio" name="bDataAuditObjectSet.status" value="N" onclick="changeType(this.value)" />
						
					</td>
					<td class="editTd" id = "sjylb">
					    <select class="easyui-combobox" name="bDataAuditObjectSet.c_datasrcid" style="width:150px;"  data-options="panelHeight:'auto'">
					       		<option value="">&nbsp;</option>
					       		<c:forEach items="${auditList}" var="country">
					       		 <s:if test= "${bDataAuditObjectSet.c_datasrcid eq country.key}">
					       			 <option value="${country.key}" selected="selected" >${country.value}</option>
					       		 </s:if>
					       		 <s:else>
					       			<option value="${country.key}">${country.value}</option>
					       		 </s:else>
								</c:forEach>
						 </select> 		
					</td>
				</tr>
				<tr>
					<td class="EditHead" style="text-align: center;" colspan="4" >
						  <a class="easyui-linkbutton" iconCls="icon-save" href="javascript:void(0)" onclick="toSave()">保存</a>
						  <a class="easyui-linkbutton" iconCls="icon-cancel" href="javascript:void(0)" onclick="toCancel()">取消</a>
					</td>
				</tr>
				
			</table>
		</s:form>
		
		<script type="text/javascript">
			$(function(){
				if('${bDataAuditObjectSet.status}' != ''){
                    var status = '${bDataAuditObjectSet.status}';
                    $('input[name="bDataAuditObjectSet.status"]').each(function(index,ele){
                        if(status.indexOf($(this).val()) != -1){
                            $(this).attr("checked",true);
                        }
                    });
                   
                }
				 changeType('${bDataAuditObjectSet.status}');
			});
		 

			function toSave(){
				document.getElementById('auditObjectSetForm').submit();
			}
			
			function changeType(vle){
				if(vle=='N'){
					sjylb.style.display='none';
				}else{
					sjylb.style.display='block';
				}
			}
			
			function toCancel(){
				window.location.href="/ais/unitary/nc/auditObjectSeting.action";
			}
		</script>
		
	</body>
</html>










