<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<!DOCTYPE HTML>
<html>
<head>
<title>审计查询书</title>
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
		<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/autosize.js"></script>
   		<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/js/jquery-fileUpload.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ufaudTextLengthValidator.js"></script>
		
<script type="text/javascript">
$(function(){
		$('#query_item').attr('maxlength',30000);
		$('#query_requirements').attr('maxlength',30000);
		
     });
	function toSave() {
		
		var auditObject = document.getElementsByName("crudObject.audit_object")[0].value;
		if(auditObject==''||auditObject==null){
			top.$.messager.show({title:'提示信息',msg:'请选择被审计单位!'});
			return false;
		}	
		
		var tempBook_name=document.getElementById('book_name').value;
		if(tempBook_name == ''||tempBook_name == null){
			$.messager.show({title:'提示信息',msg:'查询书名称不能为空！'});
			return false;
		}
		
		var memberForm = document.getElementById('bookForm');
		memberForm.submit();
	
	}
	function auditObjectFun(){
		$("#audit_object").val($("#auditObjectV").val());
		$("#audit_object_name").val($("#auditObjectV option:selected").text());	
	}	

</script>
</head>
<s:if test="taskInstanceId!=null&&taskInstanceId!=''">
		<body onload="end();sucFun();"  >
	</s:if>
	<s:else>
		<body onload="sucFun();"  >
	</s:else>
	<div region="center" style="overflow-x:hidden ">
	<s:form id="bookForm" action="saveAudBook"
		namespace="/operate/audBook">
		<table id="audBookTable" cellpadding=0 cellspacing=1 border=0  class="ListTable" align="center">
				<s:hidden name="crudObject.formId"/>
  	  			<s:hidden name="crudObject.fname"/>
  	  			<s:hidden name="crudObject.floginname"/>
  	  			<s:hidden name="crudObject.project_id"/>
  	  			<s:hidden name="crudObject.project_name"/>
  	  			<s:hidden name="crudObject.audit_object_name"/>
  	  			<s:hidden name="project_id"  />
  	  			<s:hidden name="processName" />
  	  			<s:hidden name="project_name" />
  	  			<s:hidden name="formNameDetail" />
				<input type="hidden" name="sucFlag" id="sucFlag" value="${sucFlag}"/>
				<tr >
					<td colspan="4" class=EditHead style="text-align:center" >&nbsp;审计查询书信息</td>
				</tr>
				<tr>
					<td class="EditHead" style="width:10%;">查询书状态</td>
					<td class="editTd" style="width:40%;">
						<s:property value="crudObject.book_statusName"/> 
						<s:hidden name="crudObject.book_statusName" /> 
						<s:hidden name="crudObject.book_status" /></td>
					<td class="EditHead" style="width:10%;">查询书编号</td>
						<td class="editTd" style="width:40%;">
						<s:property value="crudObject.book_code" id="book_code"/> 
						<s:hidden name="crudObject.book_code" /></td>
				</tr>
				<tr>
					<td class="EditHead" nowrap><font color="red">*</font>
						查询书名称
						<br/><div style="text-align:right"></div>
					</td>
					<td class=editTd >
						<s:textfield name="crudObject.book_name" title="查询书名称"  maxlength="50" id="book_name" cssClass="noborder"/>
					</td>
					<td class="EditHead" nowrap>
						<font color="red">*</font> 被审计单位
				    </td>
						<td class="editTd">
							<select id="audit_object" class="easyui-combobox" panelHeight="auto" name="crudObject.audit_object" style="width:165px;" editable="false" >
								<option value="">　</option>
						     	<s:iterator value="auditObjectMap" id="entry">
							      	 <s:if test="${crudObject.audit_object==key}">
						       			<option selected="selected" value="<s:property value="key"/>"><s:property value="value"/></option>
	 				       		 	</s:if>
						       		 <s:else> 
								        <option value="<s:property value="key"/>"><s:property value="value"/></option>
						       		 </s:else> 
						       	</s:iterator>  
					    </select>
 						</td>
			</tr>
				<tr>
					<td class="EditHead" nowrap>
					查询事项<div><font color=DarkGray>(限30000字)</font></div>
					<br/><div style="text-align:right"></div>
					</td>
					<td class=editTd colspan="3">
					<s:textarea  id="query_item" title="查询事项" cssClass="noborder" name="crudObject.query_item" rows="6" cssStyle="width:100%;overflow-y:visible;line-height:150%;" />
					<input type="hidden" id="crudObject.query_item.maxlength" value="30000">
					</td>
				</tr>
				<tr>
					<td class="EditHead" nowrap>查询要求<div><font color=DarkGray>(限30000字)</font></div>
					<br/><div style="text-align:right"></div>
					</td>
					<td class=editTd colspan="3">
						<s:textarea cssClass="noborder" title="查询要求" id="query_requirements" name="crudObject.query_requirements"   rows="6" cssStyle="width:100%;overflow-y:visible;line-height:150%;" />
				   	<input type="hidden" id="crudObject.query_requirements.maxlength" value="30000">
					</td>
				</tr>
			</table>
			<%@include file="/pages/bpm/list_transition.jsp"%>
			
			<div region="south" border="false" style="text-align:right;padding-right:20px;">
			<a class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="this.style.disabled='disabled';toSave()">保存</a>&nbsp;&nbsp;
			<s:if test="${ param.todoback ne '1' }">
			<a class="easyui-linkbutton" data-options="iconCls:'icon-undo'" onclick="window.location.href='${contextPath}/operate/audBook/getlistBooks.action?project_id=${project_id}'">返回</a>
			
			</s:if>
			<s:else>
			<s:if test="${taskInstanceId!=null&&taskInstanceId>0} || ${todoback == '1' }">
			<a class="easyui-linkbutton" data-options="iconCls:'icon-undo'" 
			 onclick="this.style.disabled='disabled';window.location.href='${contextPath}/bpm/taskinstance/pending.action?processName=${processName}&project_name=${project_name}&formNameDetail=${formNameDetail}'">返回</a>		 
			</s:if>
			</s:else> 
			
			
			
<!--			<input type="button" value="保存"-->
<!--				onclick="this.style.disabled='disabled';toSave()" /> &nbsp;&nbsp; <input-->
<!--				type="button" value="返回"-->
<!--				onclick="window.location.href='${contextPath}/operate/audBook/getlistBooks.action?project_id=${crudObject.project_id}'"/>-->
			<s:if test="crudObject.formId!=null">
				<td>
				<%@include file="/pages/bpm/list_toBeStart.jsp"%>
				</td>
			</s:if>
		</div>
		<s:hidden name="back"/>
			<div align="center">
				<jsp:include flush="true" page="/pages/bpm/list_taskinstanceinfo.jsp" />
			</div>
	</s:form>
	</div>
	<s:if test="${ isEnableFlag == 'Y'}">
			<div id="aud_book_file" class="easyui-fileUpload"  data-options="fileGuid:'${crudId}' ,callbackGridHeight:200"></div>
		</s:if>
		<s:else>
			<div id="aud_book_file" class="easyui-fileUpload"  data-options="fileGuid:'${crudId}' ,isAdd:false,isDel:false,callbackGridHeight:200"></div>
		</s:else>
	<script type="text/javascript">
   		function sucFun(){
   			//$('#audit_object').combobox('setValue','${crudObject.audit_object}');
    		if($("#sucFlag").val()=='1'){
    			$("#sucFlag").val('');
    			showMessage2('保存成功！');
    		}        		
   		}
   		/*
		提交表单
	*/
	function toSubmit(option){		
		var flowForm = document.getElementById('bookForm');
			<s:if test="isUseBpm=='true'">
				if(document.getElementsByName('isAutoAssign')[0].value=='false'||document.getElementsByName('formInfo.toActorId')[0]!=undefined)
				{
					var actor_name=document.getElementsByName('formInfo.toActorId')[0].value;
					if(actor_name==null||actor_name=='')
					{	
						$.messager.show({title:'提示信息',msg:'下一步处理人不能为空！'});
//						window.alert('下一步处理人不能为空！');
						return false;
					}
				}
			</s:if>
			parent.$.messager.confirm('确认', '确认提交流程吗？请确认!', function(flag){
				if (flag){
					document.getElementById('submitButton').disabled=true;
					<s:if test="isUseBpm=='true'">
					flowForm.action="<s:url action="submit" includeParams="none"/>";
					</s:if>
					<s:else>
					flowForm.action="<s:url action="directSubmit" includeParams="none"/>";
					</s:else>
					flowForm.submit();
				}else{
					return false;
				}
			});
	}
	$(function(){
		$("#auditObjectV option[value=${crudObject.audit_object}]").attr("selected",true);
	});
	/*
		启动前校验，如果没有明细信息提醒用户
	 */
	function beforStartProcess() {
			
		var auditObjectV = document.getElementById('audit_object').value;
		if (auditObjectV == ''||auditObjectV == null ) {
			$.messager.show({title:'提示信息',msg:'被审计单位不能为空！'});
			return false;
		}
		var tempBook_name=document.getElementById('book_name').value;
		if(tempBook_name == ''||tempBook_name == null){
			$.messager.show({title:'提示信息',msg:'查询书名称不能为空！'});
			return false;
		}
		
		$('#submitButton2Start').linkbutton('disable');
		document.getElementById('bookForm').action =  "<s:url action="start" includeParams="none"/>";
		
		return true;
	}
	function doStart(){
		document.getElementById('bookForm').action = "start.action";
		document.getElementById('bookForm').submit();
	}
	
	</script>	
</body>
<script type="text/javascript">
	$("#bookForm").find("textarea").each(function(){
		autoTextarea(this);
	});
</script>
</html>
