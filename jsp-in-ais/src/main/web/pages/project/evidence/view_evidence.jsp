<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
	<head>
		<base target="_self">
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>
		<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/csswin/subModal.js"></script>
		<!-- 引入dwr的js文件 -->
		<script type='text/javascript' src='/ais/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='/ais/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='/ais/dwr/engine.js'></script>
		<script type='text/javascript' src='/ais/dwr/util.js'></script>
		<script type="text/javascript" src="${contextPath}/resources/js/jquery-fileUpload.js"></script>
     <script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/autosize.js"></script>
     <script type="text/javascript">

			//审计事项开始
			jQuery(document).ready(function(){
				
				<%--  $('#atTreeWrap').window({   
						width:700,   
						height:460,   
						modal:true,
						collapsible:false,
						maximizable:false,
						minimizable:false,
						closed:true
					}); 
	 				$('#sureAtTree').bind('click',function(){
	                    var node =  $('#atTree').tree('getSelected');
	                    if(node && $('#atTree').tree('isLeaf',node.target)){
	                    	var arr = node.text.split("<font style=\"color:red;\">");
	                		var wtlbMc = node.text;
	                		for(var i=0; i<arr.length; i++){
	                			wtlbMc = wtlbMc.replace("<font style=\"color:red;\">","").replace("</font>","");
	                		}
	                        $('#task_id').val(node.id);
	                       // $('#task_name').val(wtlbMc);
	                        doTaskName();
	                        $('#atTreeWrap').window('close');
	                    }else{
	                        $.messager.alert('提示信息','只能选择末级节点','error');
	                    }					
	 				});
	 				$('#clearAtTree').bind('click',function(){
	 					$('#task_id,#task_name').val('');
	                    $('#atTreeWrap').window('close');
	 				});
	 				$('#exitAtTree').bind('click',function(){
	 					$('#atTreeWrap').window('close');
	 				});
	 				$('#searchAtTree').bind('click',loadSjsxTree);
	 				loadSjsxTree();
			});
			
			function loadSjsxTree(){	
	          	  var contion_taskName=$("#contion_taskName").val();
	              $.ajax({
	                  url : "<%=request.getContextPath()%>/adl/getAuditTaskTree.action",
	                  dataType:'json',
	                  cache:false,
	                  type:"POST",
	                  data:{'showmanusum':'1','projectId':'${project_id}','contion_taskName':contion_taskName},
	                  success:function(data){
	                      //alert(object2string(data.atTreeJson) +',  type='+data.type)
	                      if(data.type=='success'){
	                          var treeData = data.atTreeJson;
	                          $('#atTree').tree({
	                              lines:true,
	                              data:treeData,
	                              onlyLeafCheck:true,
	                              formatter:function(node){
	                              },
	                              onDblClick:function(node){
	                                  $('#sureAtTree').trigger('click');
	                              }
	                          }); 
	                      }else{
	                          $.messager.alert('提示信息',data.msg, 'error');
	                      }
	                  }
	              });
	          }
			function loadTask(){
 				loadSjsxTree();
 			} --%>
         //重新设置事项名称1
       /*   function doTaskName(){
         	var task_id = $("#task_id").val();
         	var projectid = "${project_id}";
         	if(task_id != ""){
         		$.ajax({
         			   type: "POST",
         			   url: "${contextPath}/proledger/problem/save!resetTaskName.action",
         			   data: {"task_id":task_id,"projectid":projectid},
         			   success: function(msg){
         				  // alert(msg);
         			      $("#task_name").val(msg);
         			   }
         			});
         	}
         } 			
 			//添加回车查询审计事项
 			$(document).keydown(function(event){
 				if(event.keyCode == 13){
 					loadTask();
 				} */
 			});	
     </script>
	</head>
	
  <body onload="sucFun();">
  	<s:form id="myForm" action="save" namespace="/project/evidence"> 
  	  	<s:hidden name="project_id"/>
  	  	<s:hidden name="crudObject.formId"/>
  	  	<s:hidden name="crudObject.creator_code"/>
  	  	<s:hidden name="crudObject.creator_name"/>
  	  	<s:hidden name="crudObject.project_id"/>
  	  	<input type="hidden" name="sucFlag" id="sucFlag" value="${sucFlag}"/>
  	  	<input type="hidden" name="crudId" value="${crudId}"/>
		<table id="evidenceTable" cellpadding="0" cellspacing="1" border="0"  class="ListTable" align="center">
			<tr>
				<td colspan="4" class=EditHead style="text-align:center">&nbsp;审计取证记录查看</td>
			</tr>		
			<tr>
				<td class="EditHead">
					取证记录状态
				</td>
				<td class="editTd">
					${crudObject.status_name}
					<s:hidden name="crudObject.status_code"/>
					<s:hidden name="crudObject.status_name"/>
				</td>
				<td class="EditHead" nowrap>
					取证记录编号
				</td>
				<td class="editTd">
						${crudObject.evidence_code}
						<s:hidden name="crudObject.evidence_code"/>
				</td>				
			</tr>
			<tr>
				<td class="EditHead" style="width:10%;">
						取证记录名称
				</td>
				<td class="editTd" style="width:39%;">
					${crudObject.evidence_name}	
				</td>
				<td class="EditHead" style="width:10%;">
					被审计单位
				</td>
				<td class="editTd" style="width:39%;">
						${crudObject.audit_object_name}	
						<input type="hidden" id="audit_object" name="crudObject.audit_object" value="${crudObject.audit_object}"/>	
						<input type="hidden" id="audit_object_name" name="crudObject.audit_object_name" value="${crudObject.audit_object_name}"/>
				</td>		
			</tr>		
			<tr>
				<td class="EditHead" nowrap>
					证据来源
				</td>
				<td class="editTd" colspan="3">
			<s:textarea cssClass="noborder"  name="crudObject.evidence_source"   readonly="true" rows="6" cssStyle="width:100%;overflow-y:visible;line-height:150%;" />
				</td>
			</tr>
			
			<tr>
				<td class="EditHead">
				审计事项内容
				</td>
				<td class="editTd" colspan="3">
		<s:textarea cssClass="noborder"  name="crudObject.task_name"  readonly="true" rows="6" cssStyle="width:100%;overflow-y:visible;line-height:150%;" />
				</td>
			</tr>
			<tr>
			
			</tr>				
			
		</table>
			<s:if test="${param.winview == 'benpage'}">	
		<div align="right" style="width: 96%; margin-top:15px;">
			<a class="easyui-linkbutton" data-options="iconCls:'icon-undo'" onclick="this.style.disabled='disabled';window.location.href='${contextPath}/project/evidence/listEvidence.action?projectview=${param.projectview}&view=${param.view}&project_id=${crudObject.project_id}'">返回</a>
<!--			&nbsp;&nbsp;-->
<!--			<input type="button" value="返回" onclick="this.style.disabled='disabled';window.location.href='${contextPath}/project/evidence/listEvidence.action?project_id=${project_id}'"/>-->
		</div>
		</s:if>
		<div align="center">
			<jsp:include flush="true"
				page="/pages/bpm/list_taskinstanceinfo.jsp" />
		</div>		
	</s:form>
	<div region="south"  border="0">
		<s:if test="${ isEnableFlag != 'Y' || isArchives =='1' }">
			<div id="evidence_file" class="easyui-fileUpload"  data-options="fileGuid:'${crudObject.formId}' ,isAdd:false,isDel:false,callbackGridHeight:200"></div>
		</s:if>
		<s:else>
			<div id="evidence_file" class="easyui-fileUpload"  data-options="fileGuid:'${crudObject.formId}' ,callbackGridHeight:200"></div>
		</s:else>
	</div>
	
	<script type="text/javascript">
	
		function toSave(){
			var task_id = document.getElementById('task_id').value;
			if(task_id==''||task_id==null){
				alert('请选择审计事项!');
				return false;
			}
			myForm.submit();
			
		}
	
		$("#myForm").find("textarea").each(function(){
			autoTextarea(this);
		});
	
	</script>
		 	<!-- 审计事项树(单选,双击选择） -->
		<%--  <div id='atTreeWrap' title='审计事项' style='text-align:center;overflow:hidden;padding:5px; border:1px solid #cccccc;'>
		 	<div style="text-align:left;padding:0 0 2px 5px;">搜索:&nbsp;&nbsp;
		 	    <s:textfield id="contion_taskName"  maxLength="100" cssStyle="width:180px;height:24px;padding-top:5px;" ></s:textfield>&nbsp;&nbsp;
		 	    <button id='searchAtTree'  class="easyui-linkbutton" iconCls="icon-search">搜索</button>&nbsp;&nbsp;
		 	    <button id='sureAtTree'  class="easyui-linkbutton" iconCls="icon-save">确定</button>&nbsp;&nbsp;
		 		<button id='clearAtTree'  class="easyui-linkbutton" iconCls="icon-remove">清空</button>&nbsp;&nbsp;
		 		<button id='exitAtTree' class="easyui-linkbutton" iconCls="icon-cancel">退出</button> 
		 	</div>
		 	<ul id='atTree' style='height:350px; width:670px;text-align:left;border:1px solid #cccccc; border-bottom:0px;padding:5px;overflow:auto;'></ul>
		 </div>	  --%>
		<%--  <script type="text/javascript">
     		function sucFun(){
	     		if($("#sucFlag").val()=='1'){
	     			$("#sucFlag").val('');
	     			alert('保存成功!');
	     		}        		
     		}
		 </script>	 --%>
  </body>
</html>
