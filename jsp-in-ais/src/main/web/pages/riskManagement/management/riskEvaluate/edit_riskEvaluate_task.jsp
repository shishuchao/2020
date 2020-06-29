<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%-- <jsp:directive.page import="ais.framework.util.UUID"/> --%>

<html>
<title>风险评估任务下发-风险评估任务维护</title>
<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
	<link href="<%=request.getContextPath()%>/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
	<link href="<%=request.getContextPath()%>/resources/css/common.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/createOrgTree.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>  
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/common.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/pages/tlInteractive/tlInteractiveCommon.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/scripts/check.js"></script> 
	<script type="text/javascript" src="${contextPath}/resources/js/jquery-fileUpload.js"></script>
	<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
	<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
	<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
	<script type="text/javascript">
		
		$(function(){
			//选中的风险评估体系的值
			var risk_type = $('#risk_type option:selected') .val(); 
			$("#risk_type_selected").val(risk_type);
			//初始化人员评估权重列表
			var serial_num = "${crudObject.serial_num}";
			if(serial_num != null && serial_num != ''){
				$('#gridDepartmentDiv').show();
				getGridDepartment(serial_num);
				
				$('#gridRiskDiv').show();
				getGridRisk(serial_num);
			}
		});
		
		function toSubmit(act){
			var riskNum = '0';
			$.ajax({
				url:'${contextPath}/riskManagement/management/riskEvaluate/getRiskNum.action',
				type:'POST',
				data:{'serial_num':'${crudObject.serial_num}'},
				async:false,
				success:function(data){
					riskNum = data;
				}
			});
			if(riskNum == '0'){
				showMessage1('待评估风险不能为空！');
				return false;
			}
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
		
		function beforStartProcess() {
			var riskNum = '0';
			$.ajax({
				url:'${contextPath}/riskManagement/management/riskEvaluate/getRiskNum.action',
				type:'POST',
				data:{'serial_num':'${crudObject.serial_num}'},
				async:false,
				success:function(data){
					riskNum = data;
				}
			});
			if(riskNum == '0'){
				showMessage1('待评估风险不能为空！');
				return false;
			}else{
				if(audEvd$validateform('myForm')) {
					$('#submitButton2Start').linkbutton('disable');
					myForm.action =  "<s:url action="start" includeParams="none"/>";
				}
				return true;
			}
		}
		
		function saveform(){
			if(audEvd$validateform('myForm')) {
				myForm.action="${contextPath}/riskManagement/management/riskEvaluate/saveRiskEvaluateTask.action";
				myForm.submit();
			}
		}
		
		
		//返回
		function back(){
			window.location.href="${contextPath}/riskManagement/management/riskEvaluate/listRiskEvaluates.action";
		}
		
		function getGridDepartment(serial_num){
			//var serial_num = "${serial_num}";
			//alert(serial_num);
			if(serial_num == "" || serial_num == "null"){
		  		return true;
		 	}else{
		    	var iframe = document.getElementById("gridDepartment");
		    	iframe.src = "/ais/riskManagement/management/riskEvaluate/listRiskEvaluateModulus.action?serial_num="+serial_num;
			}
		}
		
		function getGridRisk(serial_num){
			if(serial_num == "" || serial_num == "null"){
		  		return true;
		 	}else{
		    	var iframe = document.getElementById("gridRisk");
		    	iframe.src = "${contextPath}/riskManagement/management/riskEvaluate/listRiskEvaluateWait.action?serial_num=" + serial_num;
			}
		}
		
		function saveRiskModulus(roleId,roleName,ele){
			$.ajax({
				url:'${pageContext.request.contextPath}/riskManagement/management/riskEvaluate/saveRiskModulusFromUsers.action',
				type:'post',
				cache:false,
				data:{
					'roleId':roleId,
					'roleName':roleName,
					'loginNames':String(ele)
				},
				success:function(data){
					if(data=='success'){
						showMessage1("保存人员权重成功!");
					}else{
						showMessage1("保存人员权重失败!");
					}
				}
			});
			//刷新iframe
			refreshFrame();
		}
		
		function refreshFrame(){
		    document.getElementById('gridDepartment').contentWindow.location.reload(true);
		}
		

		function sucFun(){
			if($("#sucFlag").val()=='1'){
				$("#sucFlag").val('');
				$.messager.show({title:'提示信息',msg:'保存成功!'});
			}        		
		}

	</script>
</head>
<s:if test="taskInstanceId!=null&&taskInstanceId!=''">
	<body onload="end();sucFun();">
</s:if>
<s:else>
	<body onload="sucFun();">
</s:else>
	<!-- <div region="center">
    	<table id='sDTable' cellpadding=1 cellspacing=1 border=0 class="ListTable"></table>
    </div>
    <br/> -->
    <div class="easyui-layout" title="" fit='true' style="overflow: auto; width: 100%;height: 100%;">
    <div region="center" border='0'>
    <s:form id="myForm">
    	<s:hidden name="crudObject.formId" id="id"></s:hidden>
    	<%-- <s:hidden name="crudObject.status"></s:hidden> --%>
    	<s:hidden name="crudObject.serialNumber" id="serialNumber"></s:hidden>
    	
    	<s:hidden name="crudObject.initiateUnit" id="initiateUnit"></s:hidden>
    	<s:hidden name="crudObject.initiateUnitName" id="initiateUnitName"></s:hidden>
    	<s:hidden name="crudObject.initiateDep" id="initiateDep"></s:hidden>
    	<s:hidden name="crudObject.initiateDepName" id="initiateDepName"></s:hidden>
    	<s:hidden name="crudObject.initiatePerson" id="initiatePerson"></s:hidden>
    	<s:hidden name="crudObject.initiatePersonName" id="initiatePersonName"></s:hidden>
    	<s:hidden name="crudObject.initiateTime" id="initiateTime"></s:hidden>
   	    <div style="width: 100%;position:absolute;top:0px;" id="div1" align="center" >
			<table class="ListTable" align="center" style='width: 100%; padding: 0px; margin: 0px;'>
				<tr class="EditHead">
					<td >
						<span style='float: left; text-align: left;'>
						<s:property value="#title" /></span>
				    </td> 
					<td>
						<span style='float: right; text-align: right;'>
							<s:if test="crudObject.formId!=null">
								<jsp:include flush="true"
									page="/pages/bpm/list_toBeStart.jsp" /> &nbsp;&nbsp;&nbsp;&nbsp;	
							</s:if>	
							<a href="javascript:void(0);" id="root" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="saveform();">保存</a>&nbsp; 
							<s:if test="${ param.todoback ne '1' }">
								<a class="easyui-linkbutton" data-options="iconCls:'icon-undo'" 
									onclick="this.style.disabled='disabled';back();">返回</a>
							</s:if>
		 					<s:else>
								<s:if test="${taskInstanceId!=null&&taskInstanceId>0} && ${todoback == '1' }">
									<a class="easyui-linkbutton" data-options="iconCls:'icon-undo'" 
			 							onclick="this.style.disabled='disabled';window.location.href='${contextPath}/bpm/taskinstance/pending.action?processName=${processName}&project_name=${project_name}&formNameDetail=${formNameDetail}'">返回</a>
								</s:if>
							</s:else> 
						</span>
					</td>
				</tr>
			</table>
		</div>
		<br>
	    <!-- 评估任务基本信息 -->
	    <div class="position:relative" title="评估任务基本信息" id="div2">
    		<%-- <s:hidden name="riskEvaluateTask.id" id="id"></s:hidden>
    		<s:hidden name="riskEvaluateTask.serialNumber" id="serialNumber"></s:hidden> --%>
    		<table id='myTable' align="center" class="ListTable" style='margin-top: 40px; overflow: auto;'>
    			<tr>
    				<td class="EditHead">编号(自动生成)</td>
    				<td class="editTd">
    					<%-- <s:property value="riskEvaluateTask.serial_num"/> --%>
    					<s:textfield id="serial_num" name="crudObject.serial_num" readonly="true" cssClass="noborder"/>
    				</td>
    				<td class="EditHead"><font color="red">*</font>评估任务</td>
    				<td class="editTd">
    					<s:textfield cssClass="noborder editElement required" name="crudObject.taskName" maxlength="100"></s:textfield>
    				</td>
    			</tr>
    			<tr>
    				<td class="EditHead"><font color="red">*</font>评估单位</td>
    				<td class="editTd">
    					<s:buttonText2 id="evaluateCompanyName" hiddenId="evaluateCompany" cssClass="noborder editElement required"
							name="crudObject.evaluateCompanyName" 
							hiddenName="crudObject.evaluateCompany"
							doubleOnclick="showSysTree(this,
							{ url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action',
								 title:'评估单位',
                                 param:{
                                   'p_item':1,
                                   'orgtype':1
                                 },
                                 onAfterSure:function(){
                                   $('#evaluateDepartmentName').val('');
                                   $('#evaluateDepartment').val('');
                                 }
							})"
							doubleSrc="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png"
							doubleCssStyle="cursor:pointer;border:0"
							readonly="true"
							title="评估单位" maxlength="100"/>
    				</td>
    				<td class="EditHead">评估状态</td>
    				<td class="editTd">
    					<s:if test="${crudObject.status == '0'}">
    						待评估
    					</s:if>
    					<s:elseif test="${crudObject.status == '1'}">
    						评估中
    					</s:elseif>
    					<s:else>
    						已评估
    					</s:else>
    					<s:hidden name="crudObject.status"></s:hidden>
    				</td>
    			</tr>
    			<tr>
    				<td class="EditHead"><font color="red">*</font>风险分类体系</td>
    				<td class="editTd">
    					<select class="easyui-combobox editElement required" name="crudObject.riskType" id="risk_type">
    						<s:iterator value="riskTemplates">
    							<s:if test="${crudObject.riskType == templateId }">
    								<option selected="selected" value="<s:property value="templateId"/>"><s:property value="templateName"/></option>
    							</s:if>
    							<s:else>
    								<option value="<s:property value="templateId"/>"><s:property value="templateName"/></option>
    							</s:else>
    						</s:iterator>
    					</select>
    				</td>
    				<td class="EditHead"><font color="red">*</font>风险评估体系</td>
    				<td class="editTd">
    					<select class="easyui-combobox editElement required" name="crudObject.riskEvaluate" id="risk_evaluate">
	    					<s:iterator value="riskRatingSDs">
	   							<s:if test="${crudObject.riskEvaluate == id }">
	   								<option selected="selected" value="<s:property value="id"/>"><s:property value="sdName"/></option>
	   							</s:if>
	   							<s:else>
	   								<option value="<s:property value="id"/>"><s:property value="sdName"/></option>
	   							</s:else>
	    					</s:iterator>
    					</select>
    				</td>
    			</tr>
    			<tr>
    				<td class="EditHead"><font color="red">*</font>评估开始时间</td>
    				<td class="editTd">
    					<input style="width: 150px;" type="text" id="evaluateStartTime" name="crudObject.evaluateStartTime" value="${riskEvaluateTask.evaluateStartTime}"
								class="easyui-datebox editElement required" editable="false"/>
    				</td>
    				<td class="EditHead"><font color="red">*</font>评估截止时间</td>
    				<td class="editTd">
    					<input style="width: 150px;" type="text" id="evaluateEndTime" name="crudObject.evaluateEndTime" value="${riskEvaluateTask.evaluateEndTime}"
								class="easyui-datebox editElement required" editable="false"/>
    				</td>
    			</tr>
    			<tr>
    				<td class="EditHead"><font color="red">*</font>评估部门</td>
    				<td class="editTd">
    					<s:buttonText2 id="evaluateDepartmentName" hiddenId="evaluateDepartment" cssClass="noborder editElement required"
							name="crudObject.evaluateDepartmentName" 
							hiddenName="crudObject.evaluateDepartment"
							doubleOnclick="showSysTree(this,
							{ url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action',
								 title:'请选择评估部门',
								 checkbox:true,
                                 param:{
                                   'p_item':2,
                                   'orgtype':1,
                                   'defaultDeptId':$('#evaluateCompany').val()
                                 },
                                 onAfterSure:function(){
                                    $('#audit_object').val('');
                                    $('#audit_object_name').val('');
                                 } 
							})"
							doubleSrc="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png"
							doubleCssStyle="cursor:pointer;border:0"
							readonly="true"
							title="评估部门" maxlength="100"/>
    				</td>
    				<td class="EditHead"><font color="red">*</font>评估年度</td>
    				<td class="editTd">
    					<%-- <s:select cssClass="easyui-combobox" list="@ais.framework.util.DateUtil@getIncrementYearList(10,5)" name="riskEvaluateTask.status" listValue="value" listKey="key" emptyOption="true"></s:select> --%>
    					<select class="easyui-combobox editElement required" name="crudObject.evaluateYear" id="pro_year" style="width:150px;"  editable="false">
					    	<option value="">请选择</option>
					       	<s:iterator value="@ais.project.ProjectUtil@getIncrementSearchYearList(10,5)" id="entry">
						       	<s:if test="${crudObject.evaluateYear == key}">
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
				   	<td class="EditHead" style="width:15%" id="aditDeptTd">
						<font color="red">*</font>评估人
					</td>
					<td class="editTd" style="width:35%"  colspan="3">
						<s:buttonText2 id="evaluatePersonName" hiddenId="evaluatePerson" cssClass="noborder editElement required"
							name="crudObject.evaluatePersonName" 
							hiddenName="crudObject.evaluatePerson"
							doubleOnclick="showSysTree(this,
								{ title:'评估人',
                                  type:'treeAndUser',
                                  defaultDeptId:$('#evaluateDepartment').val(),
                                  // 是否显示复选框
                                  checkbox:false,
                                  //singleSelect:true,
								  param:{
								  	'rootParentId':'0',
				                    'beanName':'UOrganizationTree',
				                    'treeId'  :'fid',
				                    'treeText':'fname',
				                    'treeParentId':'fpid',
				                    'treeOrder':'fcode'
				                 }
								})"  
							doubleSrc="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png"
							doubleCssStyle="cursor:pointer;border:0"
							readonly="true"
							maxlength="500" title="评估人"/>
                    </td>
				</tr>
    		</table>
	    </div>
	    <br/>
	    <!-- <input type="text" name="riskEvaluateTask.riskEvaluate" id="risk_evaluate_selected"> -->
	    <input type="hidden" id="risk_type_selected">
	    <!-- 评估部门列表 -->
	 	<div id="gridDepartmentDiv" style="width:100%;padding:0px; display:none;" title="评估部门列表" >
			<!-- <table id="gridDepartmentList" class="ListTable"  ></table> -->
			<iframe width=100% height=300 frameborder=0 scrolling="no" id="gridDepartment" 
				src="${contextPath}/riskManagement/management/riskEvaluate/listRiskEvaluateModulus.action?serial_num=${crudObject.serial_num}">
			</iframe>
		</div>
		<br/>
		<!-- 待评估风险列表 -->
		<div id="gridRiskDiv" style="width:100%;padding:0px; display:none;" title="待评估风险列表">
			<!-- <table id="gridRiskList" class="ListTable"  ></table> -->
			<iframe width=100% height=400 frameborder=0 scrolling="no" id="gridRisk"
				src="${contextPath}/riskManagement/management/riskEvaluate/listRiskEvaluateWait.action?serial_num=${crudObject.serial_num}"></iframe>
		</div>
		
		<s:if test="${taskInstanceId ne -1}">
			<div align="center">
				<jsp:include flush="true" page="/pages/bpm/list_transition.jsp" />
			</div>		
		</s:if>
			
		<div align="center">
			<jsp:include flush="true"
				page="/pages/bpm/list_taskinstanceinfo.jsp" />
		</div>
    </s:form>
    </div>
    </div>
</body>
</html>
