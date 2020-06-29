<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<title>项目计划</title>
     	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
		<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/autosize.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ufaudTextLengthValidator.js"></script>
   		<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/js/jquery-fileUpload.js"></script>
		<script type="text/javascript" src="${contextPath}/easyui/contextmenu.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/pages/tlInteractive/tlInteractiveCommon.js"></script>
    <script type="text/javascript">
	    $(function(){
	    		
	    		//增预选项目信息时给计划管理中的审计期间开始和审计期间结束的值进行初始化显示默认前一年1月1日到12月31日
				var option =document.getElementsByName("option")[0].value;
	    		if(option=="addyuxuan"){
	    			var now = new Date();
	    	        var year = now.getFullYear();   
	    	        var valueYear=year-1;
	    	        var xstrstart=valueYear+"-"+"1"+"-"+"1";
	    	        var xstrend=valueYear+"-"+"12"+"-"+"31";
	    	       // document.getElementsByName("crudObject.audit_start_time")[0].value=xstrstart;
	    	       //取消默认值
	    	       //$("#audit_start_time").datebox("setValue",xstrstart);
	    	       // $("#audit_end_time").datebox("setValue",xstrend);
	    	       // document.getElementsByName("crudObject.audit_end_time")[0].value=xstrend;
	    		}   
	    });
        function chkIt(){
        	var contractAmount = document.getElementById("contractAmount");
        	if (isNaN(contractAmount.value)) {
        		alert('只能是数字和小数点!');
        		contractAmount.value = "";
				contractAmount.focus();
			}
		}
            function showWorkProgram(){
            	setWorkProgramId();
                var wpid = document.getElementsByName("workprogramid");
                //如果有子项
                if(wpid){
                    if(wpid.length){
                        var wpidobj = wpid[0];
                        var wpvalue = wpidobj.value;
                        if(wpvalue!=""){
                        	var viewUrl = "${contextPath}/workprogram/viewWorkProgram.action?wpid="+wpvalue;
                        	$("#viewWorkFile").attr("src",viewUrl);
                    		$('#viewWork').window('open');
                        	//window.open("${contextPath}/workprogram/viewWorkProgram.action?wpid="+wpvalue,"","height=700px, width=800px, toolbar=no, menubar=no, scrollbars=yes,resizable=yes,location=no, status=no");
                        }else{
                        	alert("没有定义该项目类别的工作方案模板，请去工作方案模块中进行维护!");
                        }
                    }
                }
            }
            
            function validateProgram(){
            	setWorkProgramId();
                var programidobj = document.getElementsByName("workprogramid");
                try{
                    if(programidobj[0].value==""){
                        top.$.messager.show({
							title:'提示消息',
							msg:"该计划选定的项目类别没有定义对应的工作方案模板，请去工作方案模块中进行维护!",
							timeout:5000,
							showType:'slide'
						});
                        return false;
                    }else{
                        return true;
                    }
                }catch(e){
					top.$.messager.show({
						title:'提示消息',
						msg:"获取该计划对应的工作方案模板出错，请刷新页面后重试！",
						timeout:5000,
						showType:'slide'
					});
                    return false;
                }
            }
            function setWorkProgramId(){
                var projtype = document.getElementsByName("crudObject.pro_type");
                var childprojtype = document.getElementsByName("crudObject.pro_type_child")[0];
                var pvalue="";
                var cpvalue="";
                if(projtype){
                    //针对如果projtypedisable，struts就会产生一个hiden的input
                    if(projtype.length==1){
                    	projtype = projtype[0];
                    }else if(projtype.length==2){
                    	projtype = projtype[1];
                    }
                    if(projtype){
                    	pvalue=projtype.value;
                    }
                }
              
                if(childprojtype){
                	if(childprojtype){
                		cpvalue=childprojtype.value;
                	}
                }
                if(cpvalue == ''){
                	document.getElementById('pro_type_child_name').style.display='none';
                }else{
                    document.getElementById('pro_type_child_name').style.display='';
                }
                var retmessage="";
                DWREngine.setAsync(false);
                DWREngine.setAsync(false);DWRActionUtil.execute(
                { namespace:'/workprogram', action:'getWorkProgramByProjType', executeResult:'false' }, 
                {'wp_projtypeid':pvalue,'wp_childprojtypeid':cpvalue},
                xxx);
                function xxx(data){
                    retmessage=data['ret_message'];
                } 
                if(retmessage!=""){
                	document.getElementById("workprogramid").value=retmessage;
                }else{
                	document.getElementById("workprogramid").value="";
                }
            }
            function setOnchange2sedSelect(){
                var sedSelect = document.getElementsByName("crudObject.pro_type_child")[0];
               sedSelect.onchange = function(){
            	   var projtype = document.getElementsByName("crudObject.pro_type")[0];
                   var childprojtype = document.getElementsByName("crudObject.pro_type_child")[0];
                   var pvalue="";
                   var cpvalue="";
                   if(projtype){
                       	pvalue=projtype.value;
                   }
                   if(childprojtype){//合同金额
                		cpvalue=childprojtype.value;
                   		
                   }
                   var retmessage="";
                   DWREngine.setAsync(false);
                   DWREngine.setAsync(false);DWRActionUtil.execute(
                   { namespace:'/workprogram', action:'getWorkProgramByProjType', executeResult:'false' }, 
                   {'wp_projtypeid':pvalue,'wp_childprojtypeid':cpvalue},
                   xxx);
                   function xxx(data){
                       retmessage=data['ret_message'];
                   } 
                   if(retmessage!=""){
                   	document.getElementsByName("workprogramid")[0].value=retmessage;
                   }else{
                   	document.getElementsByName("workprogramid")[0].value="";
                   }
               }
            }
            function changSubmit(){
            	
            	if($('input[title="提交审批"]').length>0){
            		showMessage1("修改审计单位后会影响审批流程，需保存后才能提交！")
            		$('input[title="提交审批"]').attr("disabled",true);
            	}
            	
            	if($('input[title="提交"]').length>0){
                    showMessage1("修改审计单位后会影响审批流程，需保存后才能提交！")
            		$('input[title="提交"]').attr("disabled",true);
            	}
            }
            $(function(){
            	var date=new Date;
            	var month=date.getMonth()+1;
				$('#w_plan_month').combobox({
					url:'${contextPath}/pages/plan/detail/planmonth.json',
					valueField:'pkey',
					textField:'ptext',
					editable:false,
					onLoadSuccess:function(){
						$('#w_plan_month').combobox('setValue','${crudObject.w_plan_month}');
					},
					onChange:function(n,o){
						//autoProName();
					}
				});

				var pro_type_child_name = '${crudObject.pro_type_child_name}';
				if(pro_type_child_name != null && pro_type_child_name != '') {
					$('#pro_type_child_name').show();
					$('#pro_type_name').hide();
				} else {
					$('#pro_type_child_name').hide();
					$('#pro_type_name').show();
				}
            });
        </script>
	</head>

	<s:if test="taskInstanceId!=null&&taskInstanceId!=''">
		<body onload="end();setWorkProgramId();setOnchange2sedSelect();">
	</s:if>
	<s:else>
		<body onload="setWorkProgramId();setOnchange2sedSelect();">
	</s:else>

	<div class="easyui-layout" fit="true">
	<div style="width: 100%;position:absolute;top:0px;right:15px;text-align: right;z-index: 9999;" class="EditHead">
		<s:if test="${!(defer||adjust||cancel||carryforward)}">
			<a id="saveButton"  class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="this.style.disabled='disabled';save('planForm','planTable')"/>保存</a>&nbsp;&nbsp;&nbsp;
			<s:if test="${option!='addyuxuan'} && ${option!='edityuxuan'}">
				<jsp:include flush="true" page="/pages/bpm/list_toBeStart.jsp" />
			</s:if>
		</s:if>
	</div>

	<div region="center" style="padding-top: 30px">
		<s:form id="planForm" action="submit" namespace="/plan/detail">
			<s:token/>
			<s:hidden name="crudObject.byYearShenPi"></s:hidden>
			<s:hidden name="crudObject.fid" />
			<s:hidden name="crudObject.w_writer_person" />
			<s:hidden name="crudObject.w_writer_person_name" />
			<s:hidden name="crudObject.w_write_date" />
			<s:hidden name="crudObject.formId" />
			<s:hidden id="yearPlanId" name="crudObject.year_id" />
			<s:hidden name="crudObject.year_detail_id" />
			<s:hidden id="monthPlanId" name="crudObject.month_id" />
			<s:hidden name="crudObject.month_detail_id" />
			<s:hidden name="crudObject.detail_form_id" />
			<s:hidden name="crudObject.detail_plan_name" />
			<s:hidden name="crudObject.source_plan_form_id" />
			<s:hidden name="crudObject.code" />
			<s:hidden id="detail_id" name="crudObject.detail_id" />
			<s:hidden name="crudObject.isFJ" />
			<s:hidden name="crudObject.operateflag" />
			<s:hidden name="crudObject.isAddByMonth" />
			<s:hidden name="crudObject.isAddByYear" />
			<s:hidden name="monthDetailId" />
			<s:hidden name="monthFormId" />
			<s:hidden name="yearDetailId" />
			<s:hidden name="yearFormId" />
			<s:hidden name="option" />
			<s:hidden name="defer" />
			<s:hidden name="adjust" />
			<s:hidden name="cancel" />
			<s:hidden name="carryforward" />
            <s:hidden name="workprogramid" id="workprogramid"/>
           	<s:hidden name="processName" />
  	  		<s:hidden name="project_name" />
  	  		<s:hidden name="formNameDetail" />
  	  		<s:hidden name="isStart" value="${isStart}"/>
  	  		<s:hidden name="crudObject.adjustedDetailId"></s:hidden>
  	  		<s:hidden name="crudObject.isApproval"></s:hidden>
			<s:hidden name="crudObject.version" id="verison"></s:hidden>
			<s:hidden name="crudObject.w_plan_code" id="w_plan_code"></s:hidden>
			<table id="planTable" name="planTable"  cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable" style="width: 98%">
				<tr>
					<td class="EditHead" style="width:15%">
						计划状态
					</td>
					<td class="editTd" style="width:35%">
							<s:if test="'${crudObject.byYearShenPi}'=='1' && '${crudObject.status_name }'=='计划草稿'">
								年度已审批
							</s:if>
							<s:else>
								<s:property value="crudObject.status_name" />
							</s:else>
							<s:hidden name="crudObject.status" />
							<s:hidden name="crudObject.status_name" />
					</td>
					<td class="EditHead" style="width:15%">
						计划编号
					</td>
					<td class="editTd" style="width:35%" id="w_plan_code_td">
						  <s:property value="crudObject.w_plan_code" />
					</td>
				</tr>
				<tr>
					<td class="EditHead" style="width:15%">
						<font color=red>*</font>
						计划年度
					</td>
					<td class="editTd" style="width:35%">
						<s:property value="crudObject.w_plan_year"/>
						<s:hidden name="crudObject.w_plan_year" id="crudObject_w_plan_year"/>
					</td>
					<td class="EditHead" style="width:15%">
						<font color=red>*</font>
						计划月度
					</td>
					<td class="editTd" style="width:35%">
						<s:if test="${yearFormId!=''}">
							<input id="w_plan_month"name="crudObject.w_plan_month" value="${crudObject.w_plan_month}">
						</s:if>
						<s:else>
							<s:property value="crudObject.w_plan_month" />
							<s:hidden name="crudObject.w_plan_month" />
						</s:else>
					</td>
				</tr>
				<tr>
					<td class="EditHead" style="width:15%" id="aditDeptTd">
						<font color=red>*</font>&nbsp;
						审计单位
					</td>
					<td class="editTd" style="width:35%">
						<s:if test="${monthFormId!=null||yearFormId!=''}">
							<s:textfield cssClass="noborder" name="crudObject.audit_dept_name"  id="audit_dept_name" cssStyle="width:80%" readonly="true" maxlength="100"/>
							<input type="hidden" id="audit_dept" name="crudObject.audit_dept" value="<s:property value='crudObject.audit_dept'/>">
							<!--完善信息操作不可修改-->
							<s:if test="${fillInfo ne 'yes'}">
								<img style="cursor:pointer;border:0" src="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png"
									 onclick="showSysTree(this,
											 { url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action',
											 title:'请选择审计单位',
											 param:{
											 'p_item':3
											 },
											 defaultDeptId:'${user.fdepid}',
											 onAfterSure:function(){
											 changSubmit();
											 $('#audit_object').val('');
											 $('#audit_object_name').val('');
											 }
											 })"/>
							</s:if>
						</s:if>
						<s:else>
							<s:property value="crudObject.audit_dept_name"/>
							<s:hidden name="crudObject.audit_dept_name" />
							<s:hidden id="audit_dept" name="crudObject.audit_dept" />
						</s:else>
					</td>
					<td class="EditHead" style="width:15%">
						<font color=red>*</font>
						项目类别
					</td>
					<td class="editTd" style="width:35%">
						<div style="float: left;">
							<s:textfield cssClass="noborder" name="crudObject.pro_type_name"  id="pro_type_name" cssStyle="width:80%" readonly="true" maxlength="100"/>
							<s:textfield cssClass="noborder" name="crudObject.pro_type_child_name"  id="pro_type_child_name" cssStyle="width:80%" readonly="true" maxlength="100"/>
							<img style="cursor:pointer;border:0" src="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png"
									 onclick="getItem('/ais/pages/basic/code_name_tree_select.jsp?type=add','&nbsp;请选择项目类别',500,400)"/>

							<input type="hidden" id="pro_type" name="crudObject.pro_type" value="<s:property value='crudObject.pro_type'/>">
							<input type="hidden" id="pro_type_child" name="crudObject.pro_type_child" value="<s:property value='crudObject.pro_type_child'/>">
						</div>
						<div id="showWorkProgram" style="float: left;">

						</div>
					</td>
				</tr>
				<tr>
					<td class="EditHead" style="width:15%"  nowrap="nowrap" id="auditObjtTd">
						<font color=red>*</font>
						被审计单位
					</td>
					<td class="editTd" style="width:35%" id="auditObjtContTd" colspan="3">
						<s:textfield cssClass="noborder" name="crudObject.audit_object_name"  id="audit_object_name" cssStyle="width:71.5%" readonly="true" maxlength="100"/>
						<input type="hidden" id="audit_object" name="crudObject.audit_object" value="<s:property value='crudObject.audit_object'/>">
						<!--完善信息操作不可修改-->
						<s:if test="${fillInfo ne 'yes'}">
							<img style="cursor:pointer;border:0" src="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png"
								 onclick="showSysTree(this,
										 { url:'${pageContext.request.contextPath}/mng/audobj/object/getAuditedDeptChildByDeptId.action',
										 param:{
										 'departmentId':$('#audit_dept').val()
										 },
										 cache:false,
										 checkbox:true,
										 title:'请选择被审计单位',

										 onAfterSure:resetJjzrr
										 })"/>
						</s:if>
					</td>
				</tr>
				<!-- 经济责任审计 -->
				<tr id="jjzrrTr"  style="display: none;">
					<td class="EditHead" style="width:15%" id="jjzrrTd">
						&nbsp;
					</td>
					<td class="editTd" style="width:35%" colspan="3">
						<s:buttonText2 id="jjzrr" name="crudObject.jjzrrname" hiddenId="jjzrrName" cssClass="noborder"
									   cssStyle="width:71.5%" hiddenName="crudObject.jjzrrid"
									   doubleOnclick="showSysTree(this,
							{ type:'economyDuty',
                              cache:false,
                              treeData:{
                                'dms':$('#audit_object').val().split(','),
                                'mcs':$('#audit_object_name').val().split(',')
                              },
                              onBeforeLoad:function(){
                                    var auditObj = $('#audit_object');
                                    if(!auditObj.val()){
                                        $.messager.alert('提示信息','请先选择被审计单位!','info',function(){
                                            auditObj.focus();
                                        });
                                        // 返回false，跳出程序，就继续执行； true：继续执行
                                        return false;
                                    }
                                    return true;
                                  },
							  title:'请选择经济责任人',
                                  defaultDeptId:'${user.fdepid}',
                                  defaultUserId:'${user.floginname}',
                                  onAfterSure:autoProName
							})"
									   doubleSrc="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png"
									   doubleCssStyle="cursor:pointer;border:0"
									   readonly="true"/>
					</td>
				</tr>
				<tr>
					<td class="EditHead" style="width:15%">
						<font color=red>*</font>
						项目名称(自动生成可修改)
					</td>
					<td class="editTd" style="width:35%" colspan="3">
						<s:textfield name="crudObject.w_plan_name"  id="w_plan_name" cssClass="noborder"
									 readonly="!(varMap['w_plan_nameWrite']==null?true:varMap['w_plan_nameWrite'])"
									 title="项目名称"   maxlength="255" cssStyle="width: 71.5%"/>
						<input type="hidden" id="crudObject.w_plan_name.length" value="100"/>
					</td>
				</tr>
				<tr>
					<td class="EditHead" style="width:15%">
						计划类别
					</td>
					<td class="editTd" style="width:35%">
						<s:property value="crudObject.w_plan_type_name"/>
						<s:hidden name="crudObject.w_plan_type" />
						<s:hidden name="crudObject.w_plan_type_name" />
						<s:hidden name="crudObject.proSource" />
					</td>
					<td class="EditHead" style="width:15%">
						计划等级
					</td>
					<td class="editTd" style="width:35%">
						<select id="plan_grade" class="easyui-combobox" name="crudObject.plan_grade" style="width:150px;" data-options="panelHeight:'auto'" editable="false">
							<option value="">&nbsp;</option>
							<s:iterator value="basicUtil.planLevelList" id="entry">
								<s:if test="${crudObject.plan_grade==code}">
									<option selected="selected" value="<s:property value="code"/>"><s:property value="name"/></option>
								</s:if>
								<s:else>
									<option value="<s:property value="code"/>"><s:property value="name"/></option>
								</s:else>
							</s:iterator>
						</select>
					</td>
				</tr>
				<tr>
					<td class="EditHead" style="width:15%">
						计划管理员
					</td>
					<td class="editTd" style="width:35%">
						<s:property value="crudObject.w_writer_person_name"/>
					</td>
					<td class="EditHead" style="width:15%">
						编写时间
					</td>
					<td class="editTd" style="width:35%">
						<s:date name="crudObject.w_write_date"  format="yyyy-MM-dd"/>
					</td>
				</tr>

				<!-- 工程项目审计 -->
				<tr id="gcxmTr1"  style="display: none;">
					<td class="EditHead" style="width:15%" id="gcxmTd1">
						&nbsp;
					</td>
					<td class="editTd" style="width:35%" >
					    <s:textfield name="crudObject.contractAmount" id="contractAmount" onkeyup="chkIt()" maxlength="50" cssClass="noborder">
					    </s:textfield>万元
					</td>
					<td class="EditHead" style="width:15%" id="gcxmTd2">
						&nbsp;
					</td>
					<td class="editTd" style="width:35%" >
					    <s:textfield cssClass="noborder" name="crudObject.managerType" id="managerType" maxlength="50"></s:textfield>
					</td>
				</tr>
				<tr id="gcxmTr2"  style="display: none;">
					<td class="EditHead" style="width:15%" id="gcxmTd3">
						&nbsp;
					</td>
					<td class="editTd" style="width:35%" >
					    <s:textfield cssClass="noborder" id="startProDate" name="crudObject.startProDate"
							readonly="true" maxlength="15"
							title="单击选择日期" onclick="calendar()"
							theme="ufaud_simple" templateDir="/strutsTemplate"></s:textfield>
					</td>
					<td class="EditHead" style="width:15%" id="gcxmTd4">
						&nbsp;
					</td>
					<td class="editTd" style="width:35%" >
						<s:textfield id="finishProDate" cssClass="noborder" name="crudObject.finishProDate"
							readonly="true"  maxlength="15"
							title="单击选择日期" onclick="calendar()"
							theme="ufaud_simple" templateDir="/strutsTemplate"></s:textfield>
					</td>
				</tr>
				<tr id="gcxmTr3"  style="display: none;">
					<td class="EditHead" style="width:15%" id="gcxmTd5">
						&nbsp;
					</td>
					<td class="editTd" style="width:35%">
					   <s:textfield name="crudObject.proStatus" cssClass="noborder" id="proStatus" maxlength="25"></s:textfield>
					</td>
				</tr>
				<tr id="reworkTr"  style="display: none;">
					<s:if test="@ais.plan.util.PlanSysParamUtil@isReworkByProblem()">
						<td class="EditHead" style="width:15%">
							后续问题点
						</td>
						<td class="editTd" style="width:35%">
							<s:buttonText2 id="reworkProProblemName" hiddenId="reworkProProblemCode" cssClass="noborder"
								name="crudObject.reworkProjectProblemName" cssStyle="width:160px"
								hiddenName="crudObject.reworkProjectProblemCode"
								doubleOnclick="showSysTree(this,{
									url:'${contextPath}/plan/detail/problemTreeViewByAsyn.action',
									title:'请选择后续问题点',
									checkbox:true,
									onAfterSure:problemChange
								})"
								doubleSrc="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png"
								doubleCssStyle="cursor:pointer;border:0"
								readonly="true" />
						</td>
					</s:if>
					<td class="EditHead" style="width:15%" id="reworkTd">
						&nbsp;
					</td>
					<s:if test="@ais.plan.util.PlanSysParamUtil@isReworkByProblem()">
						<td class="editTd" style="width:35%" colspan="1">
					</s:if>
					<s:else>
						<td class="editTd" style="width:35%">
					</s:else>
						<s:buttonText2 id="reworkProName" hiddenId="reworkProId" cssClass="noborder"
							name="crudObject.reworkProjectNames" cssStyle="width:160px"
							hiddenName="crudObject.reworkProjectIds"
							doubleOnclick="selectReworkProject()"
							doubleSrc="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png"
							doubleCssStyle="cursor:pointer;border:0"
							readonly="true" />
					</td>
				</tr>
				<tr id="wcxs">
					<td class="EditHead" style="width:15%">
						<s:if test="varMap['handle_modusRequired']">
							<font color=red>*</font>
						</s:if>
						审计方式
					</td>
					<td class="editTd" style="width:35%" >
						<input id="handle_modus"name="crudObject.handle_modus" value="${crudObject.handle_modus}" editable="false">
					</td>
					<td class="EditHead" style="width:15%;" id="td_agency01">
						中介机构
					</td>
					<td class="editTd"  style="width:30%;" id="td_agency02">
						<s:if test="${isUseAgency == 'Y'}">
						<s:buttonText2 id="agencyName" hiddenId="agencyId" cssClass="noborder"
									   name="crudObject.agencyName"
									   hiddenName="crudObject.agencyId"
									   doubleOnclick="showSysTree(this,
							{ url:'${pageContext.request.contextPath}/agency/maintain/getMaintainByType.action',
                              cache:false,
							  checkbox:false,
							  title:'请选择中介机构'
							})"
									   doubleSrc="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png"
									   doubleCssStyle="cursor:pointer;border:0"
									   readonly="true"
									   title="中介机构" maxlength="500"/>
						</s:if>
						<s:else>
							<s:textfield name="crudObject.agencyName" cssClass="noborder" id="agencyName" maxlength="25"></s:textfield>
						</s:else>
					</td>
				</tr>
				<tr>
					<td class="EditHead" style="width:15%">
						项目领导
					</td>
					<td class="editTd" style="width:35%">
						<s:buttonText2 id="pro_teamcharge_name" hiddenId="pro_teamcharge" cssClass="noborder"
									   name="crudObject.pro_teamcharge_name"
									   hiddenName="crudObject.pro_teamcharge"
									   cssStyle="width:80%"
									   doubleOnclick="showSysTree(this,
								{ url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action',
                                  param:{
                                     'p_item':1,
                                     'orgtype':1
                                  },
                                    cache:false,
                                  title:'请选择项目领导',
                                  type:'treeAndEmployee',
                                  defaultDeptId:'${user.fdepid}',
                                  onAfterSure:function(){
								  	uniqueJudgement('1');
								  }
								})"
									   doubleSrc="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png"
									   doubleCssStyle="cursor:pointer;border:0"
									   readonly="true"
									   doubleDisabled="!(varMap['pro_teamleaderWrite']==null?true:varMap['pro_teamleaderWrite'])" maxlength="500"/>

					</td>
                    <td class="EditHead" style="width:15%" id="zuzhangTd">
                        项目组长
                    </td>
                    <td class="editTd" style="width:35%">
                        <s:buttonText2 id="pro_teamleader_name" hiddenId="pro_teamleader" cssClass="noborder"
                                       name="crudObject.pro_teamleader_name"
                                       hiddenName="crudObject.pro_teamleader"
									   cssStyle="width:80%"
                                       doubleOnclick="showSysTree(this,
								{ url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action',
                                  param:{
                                     'p_item':1,
                                     'orgtype':1
                                  },
                                  title:'请选择项目组长',
                                  type:'treeAndEmployee',
                                  onAfterSure:function(){
								  	uniqueJudgement('2');
								  }
                                  /*singleSelect:true*/
								})"
                                       doubleSrc="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png"
                                       doubleCssStyle="cursor:pointer;border:0"
                                       readonly="true"
                                       doubleDisabled="!(varMap['pro_teamleaderWrite']==null?true:varMap['pro_teamleaderWrite'])" maxlength="500"/>
                        <s:hidden name="crudObject.isSupervise"></s:hidden>
                    </td>
				</tr>
				<tr>
					<td class="EditHead" style="width:15%" id="zhushenTd">
     					 项目主审
					</td>
					<td class="editTd" style="width:35%" id="zhushenContTd">						
						<s:buttonText2 id="pro_auditleader_name" hiddenId="pro_auditleader" cssClass="noborder"
							name="crudObject.pro_auditleader_name" 
							hiddenName="crudObject.pro_auditleader"
							cssStyle="width:80%"
							doubleOnclick="showSysTree(this,
								{ url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action',
                                  param:{
                                     'p_item':1,
                                     'orgtype':1
                                  },
                                  title:'请选择项目主审',
                                  type:'treeAndEmployee',
                                  singleSelect:true,
                                  onAfterSure:function(){
								  	uniqueJudgement('3');
								  }
								})"  
							doubleSrc="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png"
							doubleCssStyle="cursor:pointer;border:0"
							readonly="true"
							doubleDisabled="!(varMap['pro_teamleaderWrite']==null?true:varMap['pro_teamleaderWrite'])" maxlength="500"/>
                    	<%--<s:hidden name="crudObject.isSupervise"></s:hidden>--%>
                    </td>
					<td class="EditHead" style="width:15%">
						项目参审
					</td>
					<td class="editTd" style="width:35%">
						<s:buttonText2 id="pro_teammember_name" hiddenId="pro_teammember" cssClass="noborder"
									   name="crudObject.pro_teammember_name"
									   hiddenName="crudObject.pro_teammember"
									   cssStyle="width:80%"
									   doubleOnclick="showSysTree(this,
								{ url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action',
                                  param:{
                                     'p_item':1,
                                     'orgtype':1
                                  },
                                  title:'请选择项目参审',
                                  type:'treeAndEmployee',
								  onAfterSure:function(){
								  	uniqueJudgement('4');
								  }
								})"
									   doubleSrc="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png"
									   doubleCssStyle="cursor:pointer;border:0"
									   readonly="true"
									   maxlength="1000"/>

					</td>
				</tr>
				<tr>
					<td class="EditHead" style="width:15%">
						项目维护人
					</td>
					<td class="editTd" style="width:35%">
						<s:buttonText2 id="pro_maintainer_name" hiddenId="pro_maintainer" cssClass="noborder"
									   name="crudObject.pro_maintainer_name"
									   hiddenName="crudObject.pro_maintainer"
									   cssStyle="width:80%"
									   doubleOnclick="showSysTree(this,
								{ url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action',
                                  param:{
                                     'p_item':1,
                                     'orgtype':1
                                  },
                                  title:'请选择项目维护人',
                                  type:'treeAndEmployee'

								})"
									   doubleSrc="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png"
									   doubleCssStyle="cursor:pointer;border:0"
									   readonly="true"
									   maxlength="1000" title="项目维护人"/>

					</td>
				</tr>
				<tr id="riqi">
					<td class="EditHead" style="width:15%" id="pro_starttimeTd">
						项目开始日期
					</td>
					<td class="editTd" style="width:35%">
						<input type="text" id="pro_starttime" name="crudObject.pro_starttime" value="${crudObject.pro_starttime }"
								class="easyui-datebox" editable="false" style="width: 150px"/>	
					</td>
					<td class="EditHead" style="width:15%" id="pro_endtimeTd">
						项目结束日期
					</td>
					<td class="editTd" style="width:35%">
						<input type="text"  id="pro_endtime" name="crudObject.pro_endtime" class="easyui-datebox" style="width: 150px"
							value="${crudObject.pro_endtime }" editable="false"/>	
					</td>
				</tr>
				
				<tr id="shenjiriqi">
					<td class="EditHead" style="width:15%" nowrap>
						审计期间开始
					</td>
					<td class="editTd" style="width:35%" >
						<input type="text" id="audit_start_time" name="crudObject.audit_start_time"  editable="false"
								value="${crudObject.audit_start_time }" class="easyui-datebox" style="width: 150px"/>		
					</td>
					<td class="EditHead" style="width:15%" nowrap>
						审计期间结束
					</td>
					<td class="editTd" style="width:35%">
						<input type="text" id="audit_end_time" value="${crudObject.audit_end_time }" 
							name="crudObject.audit_end_time" class="easyui-datebox" editable="false" style="width: 150px">	    
					</td>
				</tr>
				
				<s:if test="varMap['contentRead']">
				<tr id="lixiang">
					<td class="EditHead" style="width:15%" nowrap id="lixingTd">
						<s:if test="varMap['contentRequired']">
							<font color=red>*</font>
						</s:if>
						审计内容
						<br/><div style="float: right;"><font color=DarkGray>(请限3000字)</font></div>
					</td>
					<td class="editTd" style="width:35%" colspan="3">
						<s:textarea name="crudObject.content" rows="5" id="content" cssClass="noborder" onblur="doWhithOne(this);"
							readonly="!(varMap['contentWrite']==null?true:varMap['contentWrite'])"
							display="${varMap['contentRead']}" 
							cssStyle="width:100%;height:100px;overflow-y:visible;line-height:150%;"/>
						<input type="hidden" id="crudObject.content.maxlength" value="3000"/>
					</td>
				</tr>
				</s:if>

				<tr>
					<td class="EditHead" style="width:15%">
						<s:if test="varMap['audit_purposeRequired']">
							<font color=red>*</font>
						</s:if>
						审计目的
						<br/><div style="text-align:right"><font color=DarkGray>(限1000字)</font></div>
					</td>
					<td class="editTd" style="width:35%" colspan="3">
						<s:textarea id="audit_purpose" name="crudObject.audit_purpose" cssClass="noborder" onblur="doWhithTwo(this);"
							cssStyle="width:100%;height:100px;overflow-y:visible;line-height:150%;"/>
						<input type="hidden" id="crudObject.audit_purpose.maxlength" value="1000"/>
					</td>
				</tr>
				<tr >
					<td class="EditHead" style="width:15%">
						<s:if test="varMap['audArrangeRequired']">
							<font color=red>*</font>
						</s:if>
						审计安排
						<br/><div style="text-align:right"><font color=DarkGray>(限1000字)</font></div>
					</td>
					<td class="editTd" style="width:35%" colspan="3">
						<s:textarea id="audArrange" name="crudObject.audArrange" cssClass="noborder" onblur="doWhithTwo(this);"
							cssStyle="width:100%;height:100px;overflow-y:visible;line-height:150%;"/>
							<input type="hidden" id="crudObject.audArrange.maxlength" value="1000"/>
					</td>
				</tr>
				<tr >
					<td class="EditHead" style="width:15%">
						<s:if test="varMap['audEmphasisRequired']">
							<font color=red>*</font>
						</s:if>
						审计重点
						<br/><div style="text-align:right"><font color=DarkGray>(限1000字)</font></div>
					</td>
					<td class="editTd" style="width:35%" colspan="3">
						<s:textarea id="audEmphasis" name="crudObject.audEmphasis" cssClass="noborder" onblur="doWhithTwo(this);"
							cssStyle="width:100%;height:100px;overflow-y:visible;line-height:150%;"/>
							<input type="hidden" id="crudObject.audEmphasis.maxlength" value="1000"/>
					</td>
				</tr>
				
				<tr id="beizhu">
					<td class="EditHead" style="width:15%">
						<s:if test="varMap['plan_remarkRequired']">
							<font color=red>*</font>
						</s:if>
						备注
						<br/><div style="text-align:right"><font color=DarkGray>(限1000字)</font></div>
					</td>
					<td class="editTd" style="width:35%" colspan="3">
						<s:textarea id="plan_remark" name="crudObject.plan_remark" cssClass="noborder" onblur="doWhithTwo(this);"
							cssStyle="width:100%;height:100px;overflow-y:visible;line-height:150%;"
							readonly="!(varMap['plan_remarkWrite']==null?true:varMap['plan_remarkWrite'])"
							/>
						<input type="hidden" id="crudObject.plan_remark.maxlength" value="1000"/>
					</td>
				</tr>
				<tr id="fujian">
					<td class="EditHead" style="width:15%">附件
						<s:hidden id="w_file" name="crudObject.w_file" />
					</td>
					<td class="editTd" style="width:35%" colspan="3">
						<div data-options="fileGuid:'${crudObject.w_file}'"  class="easyui-fileUpload"></div>
					</td>
				</tr>
			</table>
			<br>
			<div align="center">
				<jsp:include flush="true" page="/pages/bpm/list_transition.jsp" />
			</div>
			<div  style="overflow: auto;">
				<jsp:include flush="true" page="/pages/bpm/list_taskinstanceinfo.jsp" />
			</div>
			<br/>
		</s:form>
	</div>
	</div>
	<div id="subwindow" class="easyui-window" title="项目类别" style="width:500px;height:500px;padding:5px;" closed="true">
		<div class="easyui-layout" fit="true">
			<div region="center" border="false" style="padding:10px;background:#fff;border:1px solid #ccc;">
				<iframe id="item_ifr" name="item_ifr" src="" frameborder="0" width="100%" height="100%" scrolling="auto" ></iframe>
			</div>
			<div region="south" border="false" style="text-align:right;padding:5px 0;">
			    <div style="display: inline;" align="right">
					<a class="easyui-linkbutton" iconCls="icon-ok" href="javascript:void(0)" onclick="saveF()">确定</a>
					<a class="easyui-linkbutton" iconCls="icon-empty" href="javascript:void(0)" onclick="cleanF()">清空</a>
					<a class="easyui-linkbutton" iconCls="icon-delete" href="javascript:void(0)" onclick="closeWin()">关闭</a>
			    </div>
			</div>
		</div>
	</div>	
	<div id="viewWork" title="工作方案" style='overflow:hidden;padding:0px;'>
		<iframe id="viewWorkFile" name="viewWorkFile" title="viewWork" src="" width="100%" height="100%" frameborder="0"></iframe>
	</div>
	<script language="javascript">
	  	var fromAdjust = "${fromAdjust}"; //是否从计划调整模块中过来 
	  	$(function(){
	  		$('#content').attr('maxlength',3000);
	  		$('#audit_purpose').attr('maxlength',1000);
	  		$('#audArrange').attr('maxlength',1000);
	  		$('#audEmphasis').attr('maxlength',1000);
	  		$('#plan_remark').attr('maxlength',1000);

			$("#planForm").find("textarea").each(function(){
				autoTextarea(this);
			});
			
			$('#viewWork').window({
				width:900, 
				height:400,  
				modal:true,
				collapsible:false,
				maximizable:true,
				minimizable:false,
				closed:true    
		    });
	  	});
		/*
		* 	选择后续审计项目问题类别
		*/
		function selectReworkProjectProblem(){
	
			showPopWin('${contextPath}/pages/system/search/searchdatamuti.jsp?url=${contextPath}/plan/detail/problemTreeView.action&paraname=crudObject.reworkProjectProblemName&paraid=crudObject.reworkProjectProblemCode&funname=problemChange()',600,450,'审计问题点选择');
	
		}

		function uniqueJudgement(type) {
			var pro_teamcharge = $('#pro_teamcharge').val();
			var pro_teamleader = $('#pro_teamleader').val();
			var pro_auditleader = $('#pro_auditleader').val();
			var pro_teammember = $('#pro_teammember').val();
			var r;
			if(type == '1') {
				r = uniqueJudgementDetail(pro_teamcharge,pro_teamleader,pro_auditleader,pro_teammember);
				if(r != 0) {
					$('#pro_teamcharge').val('');
					$('#pro_teamcharge_name').val('');
					if(r == 1) {
						showMessage1("项目领导所选成员与项目组长所选人员重复！");
					}else if(r == 2) {
						showMessage1("项目领导所选成员与项目主审所选人员重复！");
					}else if(r == 3) {
						showMessage1("项目领导所选成员与项目参审所选人员重复！");
					}
				}
			}else if(type == '2') {
				r = uniqueJudgementDetail(pro_teamleader,pro_teamcharge,pro_auditleader,pro_teammember);
				if(r != 0) {
					$('#pro_teamleader').val('');
					$('#pro_teamleader_name').val('');
					if(r == 1) {
						showMessage1("项目组长所选成员与项目领导所选人员重复！");
					}else if(r == 2) {
						showMessage1("项目组长所选成员与项目主审所选人员重复！");
					}else if(r == 3) {
						showMessage1("项目组长所选成员与项目参审所选人员重复！");
					}
				}
			}else if(type == '3')  {
				r = uniqueJudgementDetail(pro_auditleader,pro_teamleader,pro_teamcharge,pro_teammember);
				if(r != 0) {
					$('#pro_auditleader').val('');
					$('#pro_auditleader_name').val('');
					if(r == 1) {
						showMessage1("项目主审所选成员与项目组长所选人员重复！");
					}else if(r == 2) {
						showMessage1("项目主审所选成员与项目领导所选人员重复！");
					}else if(r == 3) {
						showMessage1("项目主审所选成员与项目参审所选人员重复！");
					}
				}
			}else{
				r = uniqueJudgementDetail(pro_teammember,pro_teamleader,pro_auditleader,pro_teamcharge);
				if(r != 0) {
					$('#pro_teammember').val('');
					$('#pro_teammember_name').val('');
					if(r == 1) {
						showMessage1("项目参审所选成员与项目组长所选人员重复！");
					}else if(r == 2) {
						showMessage1("项目参审所选成员与项目主审所选人员重复！");
					}else if(r == 3) {
						showMessage1("项目参审所选成员与项目领导所选人员重复！");
					}
				}
			}
		}

		function uniqueJudgementDetail(pa1,pa2,pa3,pa4) {
			var result = 0;
			if(pa1 != null && pa1 != '') {
				var pa1Arr = new String(pa1).split(",");
				for(i in pa1Arr) {
					if(pa2 != null && pa2 != '') {
						if(pa2.toString().indexOf(pa1Arr[i]) != -1) {
							result = 1;
							break;
						}
					}
					if(pa3 != null && pa3 != '') {
						if(pa3.toString().indexOf(pa1Arr[i]) != -1) {
							result = 2;
							break;
						}
					}
					if(pa4 != null && pa4 != '') {
						if(pa4.toString().indexOf(pa1Arr[i]) != -1) {
							result = 3;
							break;
						}
					}
				}
			}
			return result;
		}

		/**
		* 后续问题更改后的动作
		*/
		function problemChange(){
			document.getElementById('reworkProName').value=='';
			document.getElementById('reworkProId').value=='';
		}
		
		/**
		* 审计单位变更的后置动作
		*/
		function auditDeptChange(){
			updateProcessSelection();
		}
	
		/*
		* 更新流程选择框
		*/
		function updateProcessSelection(){
			var auditDeptId = document.getElementById('audit_dept').value;
			updateProcessDiv(auditDeptId);
		}
		
		/*
		* 项目类别变更时候更新表单项目
		*/
		function projectTypeChangeHandler(){
			var isReworkEnable = <s:property value="@ais.project.ProjectSysParamUtil@isReworkProTypeEnabled()" />;
			var isJJZRREnable = <s:property value="@ais.project.ProjectSysParamUtil@isJjzrrProTypeEnabled()" />;
			var reworkProjectTypeCode = '<s:property value="@ais.project.ProjectContant@ZXHXSJ" />';	//后续审计
			var jjzrrProjectTypeCode = '<s:property value="@ais.project.ProjectContant@JJZRR" />';   //经济责任审计
			var nkzwpgProjectTypeCode = '<s:property value="@ais.project.ProjectContant@NBZWPG" />' //内控自我评估 --by zhangxingli 2012.10.09
			var gcsjProjectTypeCode = '<s:property value="@ais.project.ProjectContant@GCSJ" />' //工程审计项目 --by zhangxingli 2012.10.09
			
			var currentProjectCode = document.getElementById('pro_type').value;
			
			if (currentProjectCode!=null && currentProjectCode != ""){
				document.getElementById('showWorkProgram').innerHTML='&nbsp;<a href="javascript:;" onclick="showWorkProgram()">查看对应工作方案</a>';
			}else{
				document.getElementById('showWorkProgram').innerHTML='';
			}
			if(isReworkEnable && currentProjectCode==reworkProjectTypeCode){
				innerTest(false);//内控测试
				proAudit(false); //工程审计
				continuAduit(true); //后续项目
				ecnomicAduit(false); //经济责任审计
			}else if(isJJZRREnable && currentProjectCode==jjzrrProjectTypeCode){//经济责任审计
				innerTest(false);//内控测试
				proAudit(false); //工程审计
				continuAduit(false); //后续项目
				ecnomicAduit(true); //经济责任审计
			}else if(currentProjectCode == nkzwpgProjectTypeCode){//内控测试
				innerTest(true);//内控测试
				proAudit(false); //工程审计
				continuAduit(false); //后续项目
				ecnomicAduit(false); //经济责任审计
			}else if(currentProjectCode == gcsjProjectTypeCode){//工程项目审计
				innerTest(false);//内控测试
				proAudit(true); //工程审计
				continuAduit(false); //后续项目
				ecnomicAduit(false); //经济责任审计
			}else{
				//切换后的项目类别不是经济责任人审计也不是专项后续审计也不是工程项目审计也不是内控测试
				innerTest(false);//内控测试
				proAudit(false); //工程审计
				continuAduit(false); //后续项目
				ecnomicAduit(false); //经济责任审计
			}
			
		}
		projectTypeChangeHandler();//页面加载完成先调用一次初始化页面
	   /**
	     * 后续专项审计
	     */
	    function continuAduit(flag){
	    	if(flag){
	    		document.getElementById('reworkTr').style.display='';
	    		document.getElementById('reworkTd').innerHTML='<font color=red>*</font>&nbsp;后续项目';
	    	}else{
	    		document.getElementById('reworkTr').style.display='none';
	    		document.getElementById('reworkTd').innerHTML='';//清空*,否则校验不通过
	    		
	    		document.getElementById('reworkProName').value='';
				document.getElementById('reworkProId').value='';
	    	}
	    }
	   /**
		 * 经济责任审计
		 */
		function ecnomicAduit(flag){
			if(flag){
				document.getElementById('jjzrrTr').style.display='';
				document.getElementById('jjzrrTd').innerHTML='<font color=red>*</font>&nbsp;经济责任人';
			}else{
				document.getElementById('jjzrrTr').style.display='none';
				document.getElementById('jjzrrTd').innerHTML='';//清空*,否则校验不通过
				document.getElementById('jjzrr').value='';
				document.getElementById('jjzrrName').value='';
			}
		}
	/**
        * 内控测是控制字段
        */ 
        function innerTest(flag){
        	if(flag){
				document.getElementById('shenjiriqi').style.display='none';
				document.getElementById('lixiang').style.display='none';
				document.getElementById('wcxs').style.display='none';
				//document.getElementById('sjfw').style.display='none';
				document.getElementById('beizhu').style.display='none';
				document.getElementById('fujian').style.display='none';
				
				document.getElementById('audit_start_time').value='';
				document.getElementById('audit_end_time').value='';
				document.getElementById('content').value='';
				document.getElementById('handle_modus').value='';
			//	document.getElementById('audit_scope').value='';
				document.getElementById('plan_remark').value='';
				
				document.getElementById('aditDeptTd').innerHTML='<font color=red>*</font>&nbsp;测试组织者';
				/* if('${option}'!='addyuxuan'&&'${option}'!='edityuxuan'){
					document.getElementById('zuzhangTd').innerHTML='<font color=red>*</font>内控专岗负责人';
				}else{
					document.getElementById('zuzhangTd').innerHTML='内控专岗负责人';
				} */
				document.getElementById('lixingTd').innerHTML='';
				
				document.getElementById('auditObjtTd').innerHTML='';	
				document.getElementById('auditObjtTd').style.display='none';
				
				document.getElementById('auditObjtContTd').style.display='none';
				document.getElementById('zhushenTd').style.display='none';
				document.getElementById('zhushenContTd').style.display='none';
				
			}else{
				document.getElementById('shenjiriqi').style.display='';
				document.getElementById('lixiang').style.display='';
				document.getElementById('wcxs').style.display='';
				//document.getElementById('sjfw').style.display='';
				document.getElementById('beizhu').style.display='';
				document.getElementById('fujian').style.display='';
				
				document.getElementById('aditDeptTd').innerHTML='<font color=red>*</font>&nbsp;审计单位';
				/* if('${option}'!='addyuxuan'&&'${option}'!='edityuxuan')
					document.getElementById('zuzhangTd').innerHTML='<font color=red>*</font>&nbsp;项目组长';
				else if('${isStart}'!='start')
					document.getElementById('zuzhangTd').innerHTML='项目组长';
				else
				 	document.getElementById('zuzhangTd').innerHTML='<font color=red>*</font>&nbsp;项目组长'; */
				 	
				document.getElementById('auditObjtTd').innerHTML='<font color=red>*</font>&nbsp;被审计单位';
				if('${isStart}'!='start')
					document.getElementById('lixingTd').innerHTML='立项依据 <br/><div style="text-align:right"><font color=DarkGray>(限3000字)</font></div>';
				else
					document.getElementById('lixingTd').innerHTML='<font color=red>*</font>&nbsp;立项依据 <br/><div style="text-align:right"><font color=DarkGray>(请限3000字)</font></div>';
						
				document.getElementById('auditObjtTd').style.display='';
				document.getElementById('auditObjtContTd').style.display='';
				document.getElementById('zhushenTd').style.display='';
				document.getElementById('zhushenContTd').style.display='';
			}
        }
        
       
        /**
         * 工程项目审计控制字段 
         */
        function proAudit(flag){
        	if(flag){
        		document.getElementById('gcxmTr1').style.display='';
				document.getElementById('gcxmTr2').style.display='';
				document.getElementById('gcxmTr3').style.display='';
				
				document.getElementById('gcxmTd1').innerHTML='<font color=red>*</font>&nbsp;合同金额';
				document.getElementById('gcxmTd2').innerHTML='<font color=red>*</font>&nbsp;项目管理模式';
				document.getElementById('gcxmTd3').innerHTML='<font color=red>*</font>&nbsp;开工日期';
				document.getElementById('gcxmTd4').innerHTML='<font color=red>*</font>&nbsp;竣工日期';
				document.getElementById('gcxmTd5').innerHTML='<font color=red>*</font>&nbsp;项目状态';
			}else{
				document.getElementById('gcxmTr1').style.display='none';
				document.getElementById('gcxmTr2').style.display='none';
				document.getElementById('gcxmTr3').style.display='none';
				
				document.getElementById('gcxmTd1').innerHTML='';
				document.getElementById('gcxmTd2').innerHTML='';
				document.getElementById('gcxmTd3').innerHTML='';
				document.getElementById('gcxmTd4').innerHTML='';
				document.getElementById('gcxmTd5').innerHTML='';
				
				document.getElementById("contractAmount").value='';
				document.getElementById("managerType").value='';
				document.getElementById("startProDate").value='';
				document.getElementById("finishProDate").value='';
				document.getElementById("proStatus").value='';
			}
        }
		/*
		* 被审计单位改变的时候需要重置经济责任人的值
		*/
		function resetJjzrr(){
			document.getElementById('jjzrr').value='';
			document.getElementById('jjzrrName').value='';
			
			//获取该审计单位上次被审计的时间和审计类型
			var audit_object = $("#audit_object").val();
			/*$.ajax({
                type: "POST",
                url: "${contextPath}/plan/detail/save!searchLastPro.action",
                data: {"auditObjectId":audit_object},
                dataType:"json",
                success: function(msg){
                      $("#lastAudYearTemp").val(msg[0].lastAudYear);
                      $("#lastProTypeNameTemp").val(msg[0].lastProTypeName);
                      $("#lastProType").val(msg[0].lastProType);
                   }
			});*/
			autoProName();
		}
		
		/*
			判断计划是否已经存在
		*/
		function isDetailPlanExist(planCode){
			<s:if test="defer||adjust||carryforward||cancel">
				return true;
			</s:if>
			var isHave = false;
			DWREngine.setAsync(false);
			DWREngine.setAsync(false);DWRActionUtil.execute(
				{ namespace:'/plan/detail', action:'isDetailPlanExist', executeResult:'false' }, 
				{'planCode':planCode,'currentDetailFormId':'${crudObject.formId}'},
				xxx);
			function xxx(data){
				isHave = data['isHavePlan'];
			} 
			return isHave;
		}
		
		/*
		* 选择经纪人
		*/
		function selectJJZRR(){
			var auditObj = document.getElementById('audit_object').value;
			if(auditObj==''){
				top.$.messager.show({
					title:'提示消息',
					msg:'请先选择被审计单位！',
					timeout:5000,
					showType:'slide'
				});
				return false;
			}
			
			showPopWin('${pageContext.request.contextPath}/pages/mng/economyduty/mutiselect.jsp?url=${pageContext.request.contextPath}/pages/mng/economyduty/econduty_sel.jsp&paraname=crudObject.jjzrrname&paraid=crudObject.jjzrrid&audobjid='+auditObj,600,450,'经济责任人');

		}

		/**
		* 校验经济责任人长度
		*/
		function validateJjzrr(){
			var jjzrrName = document.getElementById('jjzrr').value;
			if(jjzrrName.length > 640){
				top.$.messager.show({
					title:'提示消息',
					msg:'经济责任人名称输入超长,请重新选择!',
					timeout:5000,
					showType:'slide'
				});
				return false;
			}
			return true;
		}
		
		/*
			选择后续审计的项目
		*/
		function selectReworkProject(){
			var isReworkByProblem = <s:property value="@ais.plan.util.PlanSysParamUtil@isReworkByProblem()" />;
			if(isReworkByProblem){
				var problemCode = document.getElementById('reworkProProblemCode').value;
				if(problemCode==''){
					top.$.messager.show({
						title:'提示消息',
						msg:'请先选择后续问题点!',
						timeout:5000,
						showType:'slide'
					});
					return false;
				}
			  	var url = '${contextPath}/plan/detail/selectReworkProject.action?problemCodes='+problemCode;
			  	window.showModelessDialog(url,window,'dialogWidth:800px;dialogHeight:600px;status:no');
			}else{
			  	var url = '${contextPath}/plan/detail/selectReworkProject.action';
			  	window.showModelessDialog(url,window,'dialogWidth:800px;dialogHeight:600px;status:no');
			}
		}
		/*
			启动前校验
		*/
		function beforStartProcess(){
			//进入启动阶段，校验不能进行回退操作 end
			if('${WorkProgramStatus}' != 'false'){
	          	if(!validateProgram()){//校验工作模板方案
	                return false;
	            }
           	}
			var planCode = document.getElementById('w_plan_code').value;
			if(isDetailPlanExist(planCode)=='true'){
				top.$.messager.show({
					title:'提示消息',
					msg:'已经存在编号为：'+planCode+'的项目计划,不能再次创建!',
					timeout:5000,
					showType:'slide'
				});
				return false;
			}
			if(!validateDate('pro_starttime','pro_endtime')){
				return false;
			}
			if(!validateJjzrr()){
				return false;
			}
			if(!validateDate('audit_start_time','audit_end_time')){
				return false;
			}
			if(!validateDate2()){
				return false;
			}
			<s:if test="defer">
				if(!validateDefer()){
					return false;//延期校验未通过
				}
			</s:if>
			<s:if test="carryforward">
				if(!validateCarryforward()){
					return false;//结转校验未通过
				}
			</s:if>
			var flowForm = document.getElementById('planForm');
			if(frmCheck(flowForm,'planTable')==false){
				return false;
			}
			flowForm.submit();
			return true;
		}
		
		/*
			校验两个日期大小顺序
		*/
		function validateDate(beginDateId,endDateId){
			var s1 = $('#'+beginDateId);
			var e1 = $('#'+endDateId);
			if(s1 && e1){
				var s = s1.datebox('getValue');
				var e = e1.datebox('getValue');
				if(s!='' && e!=''){
					var s_date=new Date(s.replace("-","/"));
					var e_date=new Date(e.replace("-","/"));
					if(s_date.getTime()>e_date.getTime()){
						$.messager.alert("错误","日期区间开始必须小于等于结束!");
						return false;
					}
				}
			}
			return true;
		}
		
	/*
		校验审计期间要小于项目时间
	*/
	function validateDate2(){
		var e1 = $('#pro_endtime').datebox('getValue');
		var e2 = $('#audit_end_time').datebox('getValue');
			if(e1!=''&& e2!=''){
				var e1_date=new Date(e1.replace("-","/"));
				var e2_date=new Date(e2.replace("-","/"));
				if(e2_date.getTime()>e1_date.getTime()){
					$.messager.alert("错误","审计期间结束必须小于等于项目结束时间!");
					return false;
				}
			}
		return true;
	}
		
		/*
			延期校验
		*/
		function validateDefer(){
			var userInputProStartTime = document.getElementById('pro_starttime').value;//新日期
			var detailPlanId = document.getElementById('detail_id').value;//原项目计划的form_id
			var auditDept = document.getElementById("audit_dept").value;//计划单位
			var errorMessage = '';
			var isDeferCanDo = '';
			DWREngine.setAsync(false);
			DWREngine.setAsync(false);DWRActionUtil.execute(
				{ namespace:'/plan/detail', action:'validateDefer', executeResult:'false' }, 
				{'userInputProStartTime':userInputProStartTime,'detailPlanId':detailPlanId,'auditDept':auditDept},
				xxx);
			function xxx(data){
				isDeferCanDo = data['isDeferCanDo'];
				errorMessage = data['errorMessage'];
			} 

			if(isDeferCanDo!='true'){
				$.messager.alert("错误",errorMessage);
				return false;
			}
			return true;
		}

		/*
			结转校验
		*/
		function validateCarryforward(){
			var userInputProStartTime = document.getElementById('pro_starttime').value;//新日期
			var detailPlanId = document.getElementById('detail_id').value;//原项目计划的form_id
			var auditDept = document.getElementById("audit_dept").value;//计划单位
			var errorMessage = '';
			var isCarryForwardCanDo = false;
			DWREngine.setAsync(false);
			DWREngine.setAsync(false);DWRActionUtil.execute(
				{ namespace:'/plan/detail', action:'validateCarryforward', executeResult:'false' }, 
				{'userInputProStartTime':userInputProStartTime,'detailPlanId':detailPlanId,'auditDept':auditDept},
				xxx);
			function xxx(data){
				isCarryForwardCanDo = data['isCarryForwardCanDo'];
				errorMessage = data['errorMessage'];
			} 
			if(isCarryForwardCanDo!='true'){
				alert(errorMessage);
				return false;
			}
			return true;
		}
		
		/*
			提交表单
		*/
		function toSubmit(option){		
			if('${WorkProgramStatus}' != 'false'){
	          	if(!validateProgram()){//校验工作模板方案
	                return false;
	            }
           	}
			var planCode = document.getElementById('w_plan_code').value;
		
			if(isDetailPlanExist(planCode)=='true'){
				top.$.messager.show({
					title:'提示消息',
					msg:'已经存在编号为：'+planCode+'的项目计划,不能再次创建!',
					timeout:5000,
					showType:'slide'
				});
				return false;
			}
			
			if(!validateDate('pro_starttime','pro_endtime')){
				return false;
			}
			if(!validateDate('audit_start_time','audit_end_time')){
				return false;
			}
			if(!validateDate2()){
				return false;
			}
			if(!validateJjzrr()){
				return false;
			}
			
			<s:if test="defer">
				if(!validateDefer()){
					return false;//延期校验未通过
				}
			</s:if>
			<s:if test="carryforward">
				if(!validateCarryforward()){
					return false;//结转校验未通过
				}
			</s:if>
	
		    //校验项目组长
		    /* var teamleader = document.getElementById("pro_teamleader").value;
		    if(teamleader==null || teamleader==''){
		   		top.$.messager.show({
					title:'提示消息',
					msg:"项目组长不能为空！",
					timeout:5000,
					showType:'slide'
				});
		   		document.getElementById("pro_teamleader_name").focus();
		   		return;
		    } */
		   
		   var contentmyid=document.getElementById("content");
		    //校验立项依据
		   if(typeof(contentmyid) != "undefined"&&contentmyid !=null){
			   var contentVal = $('#content').val();
			   if(contentVal==null || contentVal==''){
				   top.$.messager.show({
						title:'提示消息',
						msg:"立项依据不能为空！",
						timeout:5000,
						showType:'slide'
					});
			   		document.getElementById("content").focus();
			   		return;
			    }  
		   }
			
		    //校验项目主审
		    var auditleader = document.getElementById("pro_auditleader_name").value;
		    if(auditleader==null || auditleader==''){
				top.$.messager.show({
					title:'提示消息',
					msg:"项目主审不能为空！",
					timeout:5000,
					showType:'slide'
				});
		   		document.getElementById("pro_auditleader_name").focus();
		   		return;
		    }

			var flowForm = document.getElementById('planForm');
			
				<s:if test="isUseBpm=='true'">
					if(document.getElementsByName('isAutoAssign')[0].value=='false'||document.getElementsByName('formInfo.toActorId')[0]!=undefined)
					{
						var actor_name=document.getElementsByName('formInfo.toActorId')[0].value;
						if(actor_name==null||actor_name=='')
						{
							top.$.messager.alert("错误",'下一步处理人不能为空！');
							return false;
						}
					}
				</s:if>
				/* var flag=window.confirm('确认提交流程吗？请确认!');
				if(flag==true){
					$('#submitButton').linkbutton('disable');
					<s:if test="isUseBpm=='true'">
					flowForm.action="<s:url action="submit" includeParams="none"/>";
					</s:if>
					<s:else>
					flowForm.action="<s:url action="directSubmit" includeParams="none"/>";
					</s:else>
					flowForm.submit();
				}else{
					$('#submitButton').linkbutton('enable');
					return false;
				} */

			top.$.messager.confirm('确认对话框', '确认提交流程吗？请确认!', function(r){
					if (r){
						$('#submitButton').linkbutton('disable');
						<s:if test="isUseBpm=='true'">
						flowForm.action="<s:url action="submit" includeParams="none"/>";
						</s:if>
						<s:else>
						flowForm.action="<s:url action="directSubmit" includeParams="none"/>";
						</s:else>
						flowForm.submit();
					}
				}); 


		}

		/*
		 *上传附件
		*/
		function Upload(id,filelist){
			var guid=id;
			var num=Math.random();
			var rnm=Math.round(num*9000000000+1000000000);//随机参数清除模态窗口缓存
			window.showModalDialog('${contextPath}/commons/file/welcome.action?table_name=mng_aud_workplan_detail&table_guid=w_file&guid='+guid+'&&param='+rnm+'&&deletePermission=true',filelist,'dialogWidth:700px;dialogHeight:450px;status:yes');
		}
		
		/*
		* 删除附件
		*/
		function deleteFile(fileId,guid,isDelete,isEdit,appType,title){
			var boolFlag=window.confirm("确认删除吗?");
			if(boolFlag==true){
				DWREngine.setAsync(false);DWRActionUtil.execute(
					{ namespace:'/commons/file', action:'delFile', executeResult:'false' }, 
					{'fileId':fileId, 'deletePermission':isDelete, 'isEdit':isEdit, 'guid':guid, 'appType':appType,'title':title},
					xxx);
				function xxx(data){
				  	document.getElementById(guid).parentElement.innerHTML=data['accessoryList'];
				} 
			}
		}
		
		/*
		*非空验证
		*/
		function validateWorkPlanInput() {
			var flag = true;
			var arr = [];
			arr.push({
				id : 'w_plan_name',
				text : '项目名称'
			});
			arr.push({
				id:'pro_type',
				text:'项目类别'
			});
			arr.push({
				id:'audit_object_name',
				text:'被审计单位'
			});
			//isStart判断是否是启动页面传过来的数据，如果是启动页面就看到以下属性
			var  isStart='${isStart}'
			if(null!=isStart&&isStart=='start'){
				arr.push({
					id : 'pro_auditleader_name',
					text : '项目主审'
				});
				 var contentmyids=document.getElementById("content");
				    //校验立项依据
				if(typeof(contentmyids) != "undefined"&&contentmyids != null){
					arr.push({
						id : 'content',
						text : '立项依据'
					});
				}
				arr.push({
					id : 'audit_start_time',
					text : '审计期间开始'
				});
				arr.push({
					id:'audit_end_time',
					text:'审计期间结束'
				});
				arr.push({
					id:'pro_starttime',
					text:'项目开始日期'
				});
				arr.push({
					id:'pro_endtime',
					text:'项目结束日期'
				});
			}

			var w_plan_month = $('#w_plan_month').combobox('getValue');
			if(w_plan_month == null || w_plan_month == '') {
				top.$.messager.show({title:'消息',msg:'【计划月度】必填！'});
				$('#w_plan_month').focus();
				return false;
			}

			$.each(arr, function(i, json) {
				var obj = $('#' + json.id);
				if(json.id == 'audit_start_time'||json.id=='pro_starttime'){
					var datev=obj.datebox('getValue');
					if(datev == ''){
						top.$.messager.show({title:'消息',msg:'【' + json.text + '】必填！'});
						obj.focus();
						flag = false;
					}
				}else if(json.id == 'audit_end_time'||json.id=='pro_endtime'){
					var datev=obj.datebox('getValue');
					if(datev == ''){
						top.$.messager.show({title:'消息',msg:'【' + json.text + '】必填！'});
						obj.focus();
						flag = false;
					}
				}else if(json.id == 'w_plan_name'){
					var content = obj.val();
					if (!content) {
						flag = false;
						top.$.messager.show({title:'消息',msg:'【' + json.text + '】必填！'});
						obj.focus();
						return false;
					} else {
						var regExp = new RegExp("[~`!！@#$%^&*./;；'<>\"“”\\\\ ]");
						if(regExp.test(content)) {
							flag = false;
							top.$.messager.show({title:'消息',msg:'【' + json.text + '】不可包含特殊字符【~`!@#$%^&*./;\'\\<>" 】！'});
							obj.focus();
							return false;
						}
					}
				}else{
					if (!obj.val()) {
						flag = false;
						top.$.messager.show({title:'消息',msg:'【' + json.text + '】必填！'});
						obj.focus();
						return false;
					}
				}
			});

			return flag;
		}
		/*
			保存表单
		*/
		function save(formId,tableId){
			if (!validateWorkPlanInput()){
				return;
			}
		    var contractAmount = document.getElementById("contractAmount")
		    if (isNaN(contractAmount.value)) {
				top.$.messager.show({
					title:'提示消息',
					msg:'合同金额只能是数字和小数点!',
					timeout:5000,
					showType:'slide'
				});
		        return false;
			}
            if(!validateYearPlan()){
            	return false;
            }
            if('${WorkProgramStatus}' != 'false'){
	          	if(!validateProgram()){//校验工作模板方案
	                return false;
	            }
           	}
            var currentProjectCode = document.getElementById('pro_type').value;
            if (currentProjectCode  == ""){
				top.$.messager.show({
					title:'提示消息',
					msg:'请选择项目类别！',
					timeout:5000,
					showType:'slide'
				});
           		return false;
            }
			var planCode = document.getElementById('w_plan_code').value;
			if(isDetailPlanExist(planCode)=='true'){
//				$.messager.alert('已经存在编号为：'+planCode+'的项目计划,不能再次创建!');
				top.$.messager.show({
						title:'提示消息',
						msg:'已经存在编号为：'+planCode+'的项目计划,不能再次创建!',
						timeout:5000,
						showType:'slide'
					});
				return false;
			}
			if(!validateDate('pro_starttime','pro_endtime')){
				return false;
			}
			if(!validateDate('audit_start_time','audit_end_time')){
				return false;
			}
			if(!validateDate2()) { 
				return false;
			}
			if(!validateJjzrr()){
				return false;
			}
			// 工程项目审计, add by qfucee, 2013.3.25
			if($('#pro_type').val() == '020316'){
				var a = $('#startProDate').val();
				var b = $('#finishProDate').val();
				if(a>b){
					top.$.messager.alert('提示信息','竣工日期  应大于 开工日期！','error',function(){
						$('#finishProDate').val('').focus();
					});
					return false;
				}
			}
			var flowForm = document.getElementById(formId);
			$('#saveButton').linkbutton('disable');
			if(frmCheck(flowForm,tableId)==false){
				$('#saveButton').linkbutton('enable');
				return false;
			}else{
				$.ajax({
					url:'${contextPath}/plan/detail/saveDetail.action?fromAdjust=${fromAdjust}',
					type:'post',
					async:false,
					data:$('#planForm').serialize(),
					success:function(result) {
						if(result.status == '1') {
							var data = result.w_plan_code;
							$('#saveButton').linkbutton('enable');
							$("#w_plan_code").val(data);
							$("#w_plan_code_td").html(data);
							showMessage1('保存成功！');
							var parentTabId = '${activeTabId}';
							var curTabId = aud$getActiveTabId();
							var frameWin = aud$getTabIframByTabId(parentTabId);
							if(result.needAudit == 'Y') {
								frameWin.refresh();
							} else {
								frameWin.$('#yuxuan').get(0).contentWindow.refresh();
							}
							//aud$closeTab(curTabId, parentTabId);
						} else {
							showMessage1('保存失败！');
						}
					}
				});
			}
		}
		/**
		*	校验直接填报项目计划的月度计划是否存在
		*/
		function validateMonthPlan(){
			
			var monthPlanId = document.getElementById("monthPlanId").value;//月度计划编号
			var isMonthPlanEnabled = <s:property value="@ais.plan.util.PlanSysParamUtil@isMonthPlanEnabled()" />;
			var isPlanAddReturnEnabled = <s:property value="@ais.plan.util.PlanSysParamUtil@isPlanAddReturnEnabled()" />;
			if(!isMonthPlanEnabled || monthPlanId!='' || !isPlanAddReturnEnabled){
				return true;//没有开启月度计划或者不需要回传或者月度计划编号已经存在的情况下就不用去校验指定月度是否存在月度计划了
			}
			
			var auditDept = document.getElementById("audit_dept").value;//计划单位
			var plan_year = document.getElementsByName('crudObject.w_plan_year')[0].value;
			var plan_month = document.getElementsByName('crudObject.w_plan_month')[0].value;
			var errorMessage = '';
			var isMonthPlanCanDo = '';
			DWREngine.setAsync(false);
			
			DWREngine.setAsync(false);DWRActionUtil.execute(
				{ namespace:'/plan/detail', action:'validateMonthPlan', executeResult:'false' }, 
				{'auditDept':auditDept,'plan_year':plan_year,'plan_month':plan_month},
				xxx);
			function xxx(data){
				isMonthPlanCanDo = data['isMonthPlanCanDo'];
				errorMessage = data['errorMessage'];
			} 
			if(isMonthPlanCanDo!='true'){
				top.$.messager.show({
					title:'提示消息',
					msg:errorMessage,
					timeout:5000,
					showType:'slide'
				});
				return false;
			}
			return true;
		}
		
		/**
		*	校验直接填报项目计划的年度计划是否存在
		*/
		function validateYearPlan(){
			
			var yearPlanId = document.getElementById("yearPlanId").value;//年度计划编号
			var isMonthPlanEnabled = <s:property value="@ais.plan.util.PlanSysParamUtil@isMonthPlanEnabled()" />;
			var isPlanAddReturnEnabled = <s:property value="@ais.plan.util.PlanSysParamUtil@isPlanAddReturnEnabled()" />;
			if(isMonthPlanEnabled){
				return true;//开启月度计划直接校验月度计划就OK了
			}
			if(!isPlanAddReturnEnabled){
				return true;//不需要回传就不用校验了
			}
			if(yearPlanId!=''){
				return true;//已经有年度计划编号就不用校验了
			}
			
			var auditDept = document.getElementById("audit_dept").value;//计划单位
			var plan_year = document.getElementsByName('crudObject.w_plan_year')[0].value;
			var errorMessage = '';
			var isYearPlanCanDo = '';
			DWREngine.setAsync(false);
			
			DWREngine.setAsync(false);DWRActionUtil.execute(
				{ namespace:'/plan/detail', action:'validateYearPlan', executeResult:'false' }, 
				{'auditDept':auditDept,'plan_year':plan_year},
				xxx);
			function xxx(data){
				isYearPlanCanDo = data['isYearPlanCanDo'];
				errorMessage = data['errorMessage'];
			} 
			if(isYearPlanCanDo!='true'){
				top.$.messager.show({
					title:'提示消息',
					msg:errorMessage,
					timeout:5000,
					showType:'slide'
				});
				return false;
			}
			return true;
		}
		function doWhith(src){
		    var tmp=src.value.length;
		    if(tmp/1>3000){
				top.$.messager.show({
					title:'提示消息',
					msg:'审计内容输入不能大于3000字！',
					timeout:5000,
					showType:'slide'
				});
		        src.value = src.value.substring(0, 3000);
		        src.focus();
		    }
		}
		function doWhithOne(src){
		    var tmp=src.value.length;
		    if(tmp/1>1000){
				top.$.messager.show({
					title:'提示消息',
					msg:'审计目的输入不能大于1000字！',
					timeout:5000,
					showType:'slide'
				});
		        src.value = src.value.substring(0, 1000);
		        src.focus();
		    }
		}
		function doWhithTwo(src){
		    var tmp=src.value.length;
		    if(tmp/1>1000){
				top.$.messager.show({
					title:'提示消息',
					msg:'审计安排输入不能大于1000字！',
					timeout:5000,
					showType:'slide'
				});
		        src.value = src.value.substring(0, 1000);
		        src.focus();
		    }
		}
		function doWhithThree(src){
		    var tmp=src.value.length;
		    if(tmp/1>1000){
				top.$.messager.show({
					title:'提示消息',
					msg:'审计重点输入不能大于1000字！',
					timeout:5000,
					showType:'slide'
				});
		        src.value = src.value.substring(0, 1000);
		        src.focus();
		    }
		}
		function doWhithFore(src){
		    var tmp=src.value.length;
		    if(tmp/1>1000){
				top.$.messager.show({
					title:'提示消息',
					msg:'备注输入不能大于1000字！',
					timeout:5000,
					showType:'slide'
				});
		        src.value = src.value.substring(0, 1000);
		        src.focus();
		    }
		}
		function getItem(url,title,width,height){
			$('#item_ifr').attr('src',url);
			$('#subwindow').window({
				title: title,
				top:'20px',
				width: width,
				height:height,
				modal: true,
				shadow: true,
				closed: false,
				collapsible:false,
				maximizable:false,
				minimizable:false
			});
		}

		function saveF(){
			var ayy = $('#item_ifr')[0].contentWindow.saveF();
			var res = ayy[0].split(',');
			var name = ayy[1].split(',');
			if(res.length != 1){
				document.all('crudObject.pro_type_child').value=res[0];
				document.all('crudObject.pro_type').value=res[1];
    			document.all('crudObject.pro_type_name').value=name[0];
				document.getElementById('pro_type_name').style.display='none';
    			document.all('crudObject.pro_type_child_name').value=name[1];
    			document.getElementById('pro_type_child_name').style.display='';
			}else{
				document.all('crudObject.pro_type_child').value='';
				document.all('crudObject.pro_type').value=ayy[0];
				document.all('crudObject.pro_type_name').value=name[0];
				document.getElementById('pro_type_name').style.display='';
    			document.all('crudObject.pro_type_child_name').value='';
    			document.getElementById('pro_type_child_name').style.display='none';
			}
			$('#audTemplateId').val('');
			$('#audTemplateName').val('');
    		closeWin();
    		projectTypeChangeHandler();
    		setWorkProgramId();
			autoProName();
		}
		function cleanF(){
			document.all('crudObject.pro_type').value='';
    		document.all('crudObject.pro_type_child').value='';
    		document.all('crudObject.pro_type_name').value='';
    		document.all('crudObject.pro_type_child_name').value='';
    		document.getElementById('pro_type_child_name').style.display='none';
			autoProName();
    		closeWin();
		}
		function closeWin(){
			$('#subwindow').window('close');
		}
		function doWhithOne(src){
		    var tmp=src.value.length;
		    if(tmp/1>3000){
				top.$.messager.show({
					title:'提示消息',
					msg:src.title+'输入不能大于3000字!',
					timeout:5000,
					showType:'slide'
				});
		        src.value = src.value.substring(0, 3000);
		        src.focus();
		        return;
		    }
		}

		function doWhithTwo(src){
		    var tmp=src.value.length;
		    if(tmp/1>1000){
				top.$.messager.show({
					title:'提示消息',
					msg:src.title+'输入不能大于1000字!',
					timeout:5000,
					showType:'slide'
				});
		        src.value = src.value.substring(0, 1000);
		        src.focus();
		        return;
		    }
		}

		function showAudTemplateTree(target){
		    var proType = $('#pro_type').val();
		    var proChildType = $('#pro_child_type').val();
		    if(proType == null||proType == ''){
		        showMessage1("请先选择项目类别!");
		        return;
			}
            showSysTree(target,
                { url:'${pageContext.request.contextPath}/operate/template/getAudTempleteByProjectType.action',
                    param:{
                        'proType':proType,
                        'proChildType':proChildType
                    },
                    cache:false,
                    title:'请选择参考方案'
                });
		}

        /**
		 * 如果是项目启动，指定字段不允许修改
         */
		$(function () {
			var components = [{
			   	id:'w_plan_name',
				type:'text'
			},{
                id:'w_plan_en_name',
                type:'text'
            },{
                id:'w_plan_month',
                type:'combobox'
            },{
                id:'pro_type_child_name',
                type:'tree'
            },{
                id:'audit_dept',
                type:'tree'
            },{
                id:'audit_object',
                type:'tree'
            }];

			if('${isStart}' == 'start'){
			    for(var i in components){
			        var component = components[i];
			        if(component.type == 'text'){
			            $('#'+component.id).attr("readonly","readonly");
                    }else if(component.type == 'combobox'){
                        $('#'+component.id).combobox('disable');
                    }else if(component.type == 'tree'){
                        $('#'+component.id).next('img').hide();
                    }
                }
            }

			var handle_modus = eval('${completed_FormList}');
			$('#handle_modus').combobox({
				data:handle_modus,
				valueField:'code',
				textField:'name',
				onLoadSuccess:function(data){
				    if('${crudObject.handle_modus}' != null && '${crudObject.handle_modus}' != '') {
                        $('#handle_modus').combobox('setValue','${crudObject.handle_modus}');
                    } else {
                        $('#handle_modus').combobox('setValue',data[0].code);
                    }
				},
				onChange:function(n,o){
					var name = gethandleModusName(n);
					changeAgency(name);
				}
			});
			var name = gethandleModusName('${crudObject.handle_modus}');
			changeAgency(name);
        });

		function gethandleModusName(n) {
			var handle_modus = eval('${completed_FormList}');
			var name = '';
			for(i in handle_modus) {
				if(handle_modus[i].code == n) {
					name = handle_modus[i].name;
					break;
				}
			}
			return name;
		}
		function changeAgency(value) {
			if(value.indexOf('外包') > 0) {
				$('#td_agency01').show();
				$('#td_agency02').show();
			} else {
				$('#td_agency01').hide();
				$('#td_agency02').hide();
			}
		}
		function autoProName(){
			//被审计单位 audit_object_name
			var auditObjectName = $('#audit_object_name').val();

			//没有选被审计单位不生成
			if (auditObjectName==null || auditObjectName==''){
				return;
			}
			//项目类别  pro_type_name pro_type_child_name
			var proTypeName = $('#pro_type_name').val();
			var proTypeChildName = $('#pro_type_child_name').val();

			var jjzrrName = '';
			var projectType = '';

			if(proTypeName=='经济责任审计'){
				jjzrrName = $('#jjzrr').val();
				if(jjzrrName!=null && jjzrrName!=''){
					jjzrrName = jjzrrName + '同志';
				}else{
					jjzrrName = '';
				}
				projectType = proTypeChildName;
			}else{
				if(proTypeChildName!=''&&proTypeChildName!=null){
					projectType = proTypeChildName;
				}else{
					projectType = proTypeName;
				}
			}

			var nd = $('#crudObject_w_plan_year').val();
			var yd = $('#w_plan_month').combobox('getValue');

			$.ajax({
				url:"${contextPath}/plan/detail/getProjectName.action",
				async:false,
				data:{nd: nd, yd: yd, auditObjectName: auditObjectName, projectType: projectType, jjzrrName: jjzrrName},
				type:"post",
				success:function(data) {
					var proName = data;
					if (proName!=null && proName!=''){
						//项目名称  w_plan_name
						$('#w_plan_name').val(proName);
					}
				}
			})
		}
	</script>
	</body>
</html>
