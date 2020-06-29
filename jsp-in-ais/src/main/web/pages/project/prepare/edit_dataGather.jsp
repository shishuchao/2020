<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>

<!DOCTYPE HTML >
<html>
<title>Sap集成</title>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<script type="text/javascript" src="${contextPath}/easyui/boot.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/jquery-fileUpload.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/autosize.js"></script>
<script type="text/javascript" src="${contextPath}/easyui/contextmenu.js"></script>  
<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
<script type="text/javascript" src="${contextPath}/pages/tlInteractive/tlInteractiveCommon.js"></script>
<script type="text/javascript">
	var isView = "${view}" == "true" || "${view}" == true ? true : false;
	isView ?  $('.editElement').hide() : $('.viewElement').hide();
	var projectId = "${projectId}";
	var parentTabId = "${parentTabId}";
	var flag = "${flag}";
	var curTabId = aud$getActiveTabId();
	var isEdit = "${isEdit}";
$(function(){	
	if(!isView){
		$("#saveBtn").bind('click', function(){
			var myform = document.getElementById("dGatherForm");
			
			if(isEdit != "1"){
				var audit_objectName= $("#auditObjectName").val();
				if (audit_objectName == null || audit_objectName == ""){
					top.$.messager.show({
						title:'提示消息',
						msg:'被审计单位不能为空！',
						timeout:5000,
						showType:'slide'
					});
				}
			}
			
			/*  if(!sapNameValidate()){
				return false;
			} */
				
			if(frmCheck(myform,"planTable")){
				myform.action="${contextPath}/project/prepare/saveDataGathers.action?projectId="+projectId+"&flag="+flag;
				top.$.messager.show({
					title:'提示消息',
					msg:'保存成功！',
					timeout:5000,
					showType:'slide'
				});
				myform.submit();
			}
			
		
		});
	}else{
		$("#saveBtn").remove();
	}
	
	$('#auditObjectTrigger').bind('click', function(){
		var treeTarget = $('#auditObjectTrigger')[0];
		var audittree = showSysTree(treeTarget,{
		    title:'请选择被审计单位',
		    checkbox:true,
		    cache:false,
			param:{
				'serverCache':false,
		   	    "whereHql":"${audIds}",
			  	"rootParentId":"auditingObjectnull",
                "beanName":"AuditingObject",
                "treeId"  :"id",
                "treeText":"name",
                "treeParentId":"parentId",
               "treeOrder":"currentCode"
		   },
		   onAfterSure:function(){
		 		var jqTree = audittree.win.param.jqtree;
				var nodes = $(jqTree).tree('getChecked');
				var ids ="";
				var texts = "";
				
				for(var i= 0;i<nodes.length;i++){
					ids += nodes[i].id+",";
					texts+= nodes[i].text+",";
				}
				if(ids){
					ids = ids.substr(0,ids.length-1);
				}
				if(texts){
					texts = texts.substr(0,texts.length-1);
				}
			    $('#auditObject').val(ids);
				$('#auditObjectName').val(texts);  
		   }                                  
		})
	});
 });	
 
 
 function aud$back(){
	 window.location.href = "${contextPath}/project/prepare/initPageDataGather.action?projectId="+projectId+"&flag="+flag;
 }
 
	//验证sap名称是否重复
 /* function sapNameValidate(){
		var flag = false;
		var sapname = document.getElementsByName("dGatherForm.sapName")[0].value;
		$.ajax({
			url:'${contextPath}/project/prepare/sapNameValidate.action',
			async:false,
			type:'POST',
			data:{'sapname':sapname,'projectId':projectId},
			success:function(data) {
				if(data['msg'] != null && data['msg'] != ""){
					if(data['msg'] == "Y"){
						showMessage1("此SAP名称已经存在！");
						flag = false;
					}
					if(data['msg'] == "N"){
						flag = true;
					}
		     	}
			}
		});
		return flag;
	} */
</script>
<style type="text/css">
input[class~=editElement]{
	width:75% !important;
}
</style>
</head>
<body style='padding:0px;margin:0px;overflow:hidden;'  class='easyui-layout' border='0' fit='true'>
	<div region='north' border='0' style='padding:0px;overflow:hidden;'>
		<div style='text-align:right;padding-right:10px;border-bottom:1px solid #cccccc;width:100%;'>
		    <a id='saveBtn'  class="easyui-linkbutton" iconCls="icon-save"   style='border-width:0px;'>保存</a>
 			<a id='closeBtn' class="easyui-linkbutton" iconCls="icon-undo" style='border-width:0px;' onclick="aud$back()">返回</a>				
		</div>
	</div>
	<div region='center' border='0'>
		<s:form action="initPageDataGather" namespace="/project/prepare" method="post" name="dGatherForm" id="dGatherForm">
			<input type='hidden' id="dGatherForm_id" name="dGatherForm.id"  class="noborder editElement clear" value="${dGatherForm.id}"/>  
			<table class="ListTable" align="center" style='table-layout:fixed;'  id="planTable" name="planTable" >
				<tr>
					<td class="EditHead" style="width:15%;"><font class="editElement"  color=red>*</font>被审计单位</td>
					<td class="editTd" style="width:35%;">
						<s:if test="${view !=true && isEdit ne '1'}">
					   		<input type='hidden' id='auditObjectsIds' value='${auditObjectsIds}'/>
			           		<input type='text'  class="noborder" id='auditObjectName' value="${dGatherForm.auditObjectName}" name='dGatherForm.auditObjectName' style="width:180px;" readonly="true"/>
			           		<input type='hidden' id='auditObject' name='dGatherForm.auditObject'/>
			           		<img style="cursor:hand;border:0" src="/ais/resources/images/s_search.gif" id="auditObjectTrigger"></img>
						</s:if>
						<s:if test="${isEdit eq '1'}">
							${dGatherForm.auditObjectName}
						</s:if>
					</td>
					
					<td class="EditHead" style="width:15%;"><font class="editElement"  color=red>*</font>采集年度区间</td>
					<td class="editTd" style="width:35%;">
						<s:if test="${view !=true && isEdit ne '1'}">
							<s:textfield cssClass="noborder" title='采集开始年度' id='dGatherForm_auditStartTime' name='dGatherForm.auditStartTime' value="${dGatherForm.auditStartTime}" cssStyle="width:20%;"  size="10" maxlength="10"></s:textfield>
							-
							<s:textfield cssClass="noborder" title='采集结束年度' id='dGatherForm_auditEndTime' name='dGatherForm.auditEndTime' value="${dGatherForm.auditEndTime}" cssStyle="width:20%;"  size="10" maxlength="10"></s:textfield>
						</s:if>
						<%-- <s:else>
							<span id='view_auditStartTime'
							 class="noborder viewElement clear" style='width:10%;display:inline;'>${dGatherForm.auditStartTime}</span>
							 -
							<span id='view_auditEndTime'
							 class="noborder viewElement clear" style='width:10%;display:inline;'>${dGatherForm.auditEndTime}</span>
						</s:else> --%>
						<s:if test="${isEdit eq '1'}">
							${dGatherForm.auditStartTime}-${dGatherForm.auditEndTime}
							<s:hidden name='dGatherForm.auditStartTime' value="${dGatherForm.auditStartTime}"></s:hidden>
							<s:hidden name='dGatherForm.auditEndTime' value="${dGatherForm.auditEndTime}"></s:hidden>
						</s:if>
					</td>
				</tr>
				<tr>
					<td class="EditHead" style="width:15%;"><font class="editElement"  color=red>*</font>sap系统名称</td>
					<td class="editTd" style="width:35%;">
						<s:if test="${view !=true}">
						   <select  class="easyui-combobox" id = "sapName" name="dGatherForm.sapName" style="width:150px;" data-options= "panelHeight:'auto'">
                               <option value= "">&nbsp; </option>
                               <c:forEach items= "${sapNamelist}" var="country">
                                      <s:if test= "${dGatherForm.sapName eq country.key}">
                                            <option value="${country.key}" selected="selected">${country.value}</option>
                                      </s:if>
                                      <s:else>
                                           <option value="${country.key}">${country.value}</option >
                                      </s:else>
                                  </c:forEach>  
                             </select>  
						</s:if>
						<s:else>
							<span id='view_sapNameValue' class="noborder viewElement clear" style='width:50%;display:inline;'>${dGatherForm.sapNameValue}</span>
						</s:else>
					</td>
					<td class="EditHead" style="width:15%;"></td>
					<td class="editTd" style="width:35%;">
					</td>
				</tr>
				<tr>
					<td class="EditHead" style="width:15%;">发起人</td>
					<td class="editTd" style="width:35%;">
					<s:if test="${view !=true}">
						<span id='dGatherForm_creater'  class="noborder editElement clear" >${dGatherForm.creater}</span>
					</s:if>
					<s:else>
						${dGatherForm.creater}
					</s:else>
					</td>
					<td class="EditHead" style="width:15%;">发起时间</td>
					<td class="editTd" style="width:35%;">
					    <s:if test="${view !=true}">
							<span id='dGatherForm_createTime'  class="noborder editElement clear" >${dGatherForm.createTime}</span>
						</s:if>
						<s:else>
							${dGatherForm.createTime}
						</s:else>
					</td>
				</tr>
			</table>
			</s:form>
	</div>		
	<!-- 引入公共文件 -->
   <jsp:include flush="true" page="/pages/frReportFlow/ajaxloading.jsp" />
</body>
</html>