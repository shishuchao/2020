<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE HTML>
<html>
	<head>
		<base target="_self">
		<title>取证记录信息</title>
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
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
		$(document).ready(function(){
	  		$('#task_name').attr('maxlength',30000);
	  		$('#evidence_source').attr('maxlength',30000);
	  		$("#myForm").find("textarea").each(function(){
     			autoTextarea(this);
     		});
	  	});
			//审计事项开始
		
	  		
				/*  $('#atTreeWrap').window({   
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
			}); */
			
	<%-- 	function loadSjsxTree(){
	    	var contion_taskName=$("#contion_taskName").val();
            $.ajax({
                url : "<%=request.getContextPath()%>/adl/getAuditTaskTree.action",
                dataType:'json',
                cache:false,
                type:"POST",
                data:{'showmanusum':'1','projectId':'${project_id}','contion_taskName':contion_taskName,'isdigao':''},
                success:function(data){
                    if(data.type == 'success'){
                        var treeData = data.atTreeJson;
                        $('#atTree').tree({
                            lines:true,
                            data:treeData,
                            onlyLeafCheck:true,
                            onDblClick:function(node){
                                $('#sureAtTree').trigger('click');
                            }
                        }); 
                    }else{
                        $.messager.alert('提示信息',data.msg, 'error');
                    }
                }
            });
	    } --%>
		/* 	function loadTask(){
 				loadSjsxTree();
 			} */
         //重新设置事项名称1
        /*  function doTaskName(){
         	var task_id = $("#task_id").val();
         	var projectid = "${project_id}";
         	if(task_id != ""){
         		$.ajax({
         			   type: "POST",
         			   url: "${contextPath}/proledger/problem/save!resetTaskName.action",
         			   data: {"task_id":task_id,"projectid":projectid},
         			   success: function(msg){
         			      $("#task_name").val(msg);
         			   }
         			});
         	}
         } 		 */	
 			//添加回车查询审计事项
 			/* $(document).keydown(function(event){
 				if(event.keyCode == 13){
 					loadTask();
 				} */
 		
 			
     </script>
	</head>
	<s:if test="taskInstanceId!=null&&taskInstanceId!=''">
		<body onload="end();sucFun();">
	</s:if>
	<s:else>
		<body onload="sucFun();">
	</s:else>
  	<s:form id="myForm" action="save" namespace="/project/evidence"> 
  	  	<s:hidden name="crudObject.formId"/>
  	  	<s:hidden name="crudObject.creator_code"/>
  	  	<s:hidden name="crudObject.creator_name"/>
  	  	<s:hidden name="crudObject.project_id"/>
  	  	<s:hidden name="project_id" /> 
  	  	<s:hidden name="processName" />
  	  	<s:hidden name="project_name" />
  	  	<s:hidden name="formNameDetail" />
  	  	<input type="hidden" name="sucFlag" id="sucFlag" value="${sucFlag}"/>
		<table id="evidenceTable" cellpadding="0" cellspacing="1" border="0"  class="ListTable" align="center" style="overflow: hidden;">
			<tr >
				<td colspan="4"class="EditHead" style="text-align:center">&nbsp;审计取证记录编辑</td>
			</tr>		
			<tr>
				<td class="EditHead" style="width:15%;">
					取证记录状态
				</td>
				<td class="editTd" style="width:35%;">
					${crudObject.status_name}
					<s:hidden name="crudObject.status_code"/>
					<s:hidden name="crudObject.status_name"/>
				</td>
				<td class="EditHead" style="width:15%;">
					取证记录编号
				</td>
				<td class="editTd" style="width:35%;">
					${crudObject.evidence_code}
					<s:hidden name="crudObject.evidence_code"/>
				</td>				
			</tr>
			<tr>
			     <td align="left" class="EditHead" ><FONT color=red>*</FONT>
						取证记录名称
					</td>
					<td align="left" class="editTd" >
						<s:textfield id="evidence_name" cssStyle="width:70%" name="crudObject.evidence_name" cssClass="noborder"   maxlength="50"/>
					</td>
					<td class="EditHead">
					<font color="red">*</font> 被审计单位
				</td>
			
				<td  class="editTd">
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
					证据来源<div><font color=DarkGray>(限30000字)</font></div>
				</td>
				<td class="editTd" colspan="3">
						<s:textarea  id="evidence_source" cssClass="noborder" title="证据来源"  name="crudObject.evidence_source" rows="6"  cssStyle="width:100%;overflow-y:visible;line-height:150%;" />
						<input type="hidden" id="crudObject.evidence_source.maxlength" value="30000">	
				</td>
			</tr>
			<tr>
				<td class="EditHead">
					<font color="red">*</font> 审计事项内容<div><font color=DarkGray>(限30000字)</font></div>
				</td>
				<td class="editTd"  colspan="3">
				<s:textarea title="审计事项内容" id="task_name" cssClass="noborder"  name="crudObject.task_name" rows="6" cssStyle="width:100%;overflow-y:visible;line-height:150%;" />
						<input type="hidden" id="crudObject.task_name.maxlength" value="30000">	
				</td>
				<%-- <td class="editTd">
							<input type="text" name="crudObject.task_name" value="${crudObject.task_name}" id="task_name" readonly="readonly" class="noborder" style="width:350px;">
							<a href="javascript:;" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-search'" onclick="$('#atTreeWrap').window('open')"></a>
							<s:hidden name="crudObject.task_id" id="task_id" />
							<s:hidden name="crudObject.task_code" />
				</td> --%>
			</tr>		
		</table>
			<s:if test="${taskInstanceId ne -1}">
			<div align="center">
				<jsp:include flush="true" page="/pages/bpm/list_transition.jsp" />
			</div>		
			</s:if>
				
		<div align="right" style="width: 96%; margin-top:15px;">
			<a class="easyui-linkbutton" data-options="iconCls:'icon-save'" 
			onclick="this.style.disabled='disabled';return toSave();">保存</a>
			<s:if test="${ param.todoback ne '1' }">
			<a class="easyui-linkbutton" data-options="iconCls:'icon-undo'" 
			onclick="this.style.disabled='disabled';window.location.href='${contextPath}/project/evidence/listEvidence.action?project_id=${crudObject.project_id}'">返回</a>
			</s:if>
		 	<s:else>
			<s:if test="${taskInstanceId!=null&&taskInstanceId>0} && ${todoback == '1' }">
				<a class="easyui-linkbutton" data-options="iconCls:'icon-undo'" 
			 onclick="this.style.disabled='disabled';window.location.href='${contextPath}/bpm/taskinstance/pending.action?processName=${processName}&project_name=${project_name}&formNameDetail=${formNameDetail}'">返回</a>
			</s:if>
			</s:else> 
			<s:if test="crudObject.formId!=null">
			<jsp:include flush="true"
					page="/pages/bpm/list_toBeStart.jsp" /> &nbsp;&nbsp;&nbsp;&nbsp;	
			</s:if>	
			
<!--			<input type="button" value="保存" onclick="this.style.disabled='disabled';return toSave();"/>-->
<!--			&nbsp;&nbsp;-->
<!--			<input type="button" value="返回" onclick="this.style.disabled='disabled';window.location.href='${contextPath}/project/evidence/listEvidence.action?project_id=${project_id}'"/>-->
<!--		   &nbsp;&nbsp;-->
		    
		</div>
			<div align="center">
				<jsp:include flush="true"
					page="/pages/bpm/list_taskinstanceinfo.jsp" />
			</div>			
	</s:form>
	<div region="south"  border="0">
		<s:if test="${ isEnableFlag == 'Y'}">
			<div id="evidence_file" class="easyui-fileUpload"  data-options="fileGuid:'${crudId}' ,callbackGridHeight:200"></div>
		</s:if>
		<s:else>
			<div id="evidence_file" class="easyui-fileUpload"  data-options="fileGuid:'${crudId}' ,isAdd:false,isDel:false,callbackGridHeight:200"></div>
		</s:else>
	</div>
	<script type="text/javascript">
		function toSubmit(act){
			<s:if test="isUseBpm=='true'">
		 	if(document.getElementsByName('isAutoAssign')[0].value=='false'||document.getElementsByName('formInfo.toActorId')[0]!=undefined){
			 	var actor_name=document.getElementsByName('formInfo.toActorId')[0].value;
			 	if(actor_name==''){
			 		$.messager.show({title:'提示信息',msg:'下一步处理人不能为空！'});
					return false;
				}
			}
		  	</s:if>
			jQuery("#myForm").attr("action","submit.action");
			jQuery("#myForm").submit();			  	
		 } 		
	
		function toSave(){
			var auditObject = document.getElementsByName("crudObject.audit_object")[0].value;
			if(auditObject==''||auditObject==null){
				top.$.messager.show({title:'提示信息',msg:'请选择被审计单位!'});
				return false;
			}	
			
			var tempEvidence_name=$("#evidence_name").val();
			if(tempEvidence_name == ''||tempEvidence_name == null){
				window.parent.top.$.messager.show({
					title:"提示信息",
					msg:"取证记录名称不能为空！"
				});
				return false;
			}
			
			var task_name = $("#task_name").val();
			if(task_name==''||task_name==null){
				top.$.messager.show({title:'提示信息',msg:'审计事项内容不能为空!'});
				return false;
			}
			myForm.submit();
		//	$.messager.show({title:'提示信息',msg:'保存成功!'});
		}
	/*
		启动前校验，如果没有明细信息提醒用户
	 */
	function beforStartProcess() {
		
		
		var auditObject = document.getElementsByName("crudObject.audit_object")[0].value;
		if (auditObject == ''&& auditObject == null ) {
			top.$.messager.show({title:'提示信息',msg:'被审计单位不能为空!'});
			return false;
		}
		var task_name = document.getElementById('task_name').value;
		if (task_name == ''&& task_name == null ) {
			$.messager.show({title:'提示信息',msg:'审计事项内容不能为空!'});
			return false;
		}
		$('#submitButton2Start').linkbutton('disable');
		document.getElementById('myForm').action =  "<s:url action="start" includeParams="none"/>";
		
		return true;
	}
	
	
	function doStart(){
		document.getElementById('myForm').action = "start.action";
		document.getElementById('myForm').submit();
	}
	</script>
		 	<!-- 审计事项树(单选,双击选择） -->
		<%-- <div id='atTreeWrap' title='审计事项' style='text-align:center;overflow:hidden;padding:5px; border:1px solid #cccccc;'>
			<div style="text-align:left;padding:0 0 2px 5px;">搜索:
			    <s:textfield id="contion_taskName"  maxLength="100" cssStyle="width:180px;height:24px;padding-top:5px;" ></s:textfield>&nbsp;&nbsp;
			    <button id='searchAtTree'  class="easyui-linkbutton" iconCls="icon-search">搜索</button>&nbsp;&nbsp;
			    <button id='sureAtTree'  class="easyui-linkbutton" iconCls="icon-save">确定</button>&nbsp;&nbsp;
				<button id='clearAtTree'  class="easyui-linkbutton" iconCls="icon-remove">清空</button>&nbsp;&nbsp;
				<button id='exitAtTree' class="easyui-linkbutton" iconCls="icon-cancel">退出</button> 
			</div>
			<ul id='atTree' style='height:350px; width:99%;text-align:left;border:1px solid #cccccc; border-bottom:0px;padding:5px;overflow:auto;'></ul>
		</div> --%>
		 <script type="text/javascript">
     		function sucFun(){
     		//	$('#audit_object').combobox('setValue','${crudObject.audit_object}');
	     		if($("#sucFlag").val()=='1'){
	     			$("#sucFlag").val('');
	     			$.messager.show({title:'提示信息',msg:'保存成功!'});
	     		}        		
     		}
     		
     	
		 </script>	
  </body>
</html>
