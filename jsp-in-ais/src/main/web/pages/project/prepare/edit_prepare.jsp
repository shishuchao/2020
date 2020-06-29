<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>准备阶段</title>
		<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script> 
		<script type="text/javascript" src="${contextPath}/resources/csswin/subModal.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
		<script type="text/javascript" src="${contextPath}/scripts/base64_Encode_Decode.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>
		<s:head theme="ajax" />
	</head>
	<script type="text/javascript">
	$(document).ready(function(){
		var taskInstanceId="${taskInstanceId}";
		 $('#sendBack_div').window({   
				width:400,   
				height:150,   
				modal:true,
				collapsible:false,
				maximizable:false,
				minimizable:false,
				closed:true
			});
		 if('${param.projectview}' == 'view'){
			 document.getElementById("justButton").style.display = "none";
			 document.getElementById("exportWord").style.display = "";
			 document.getElementById("exportExcel").style.display = "";
			 document.getElementById("exportAssign").style.display = "";
			 document.getElementById("exportZIP").style.display = "";
			
		 }else{
			 if('${projectStartObject.prepare_closed}' == 1){
					jQuery("#buttonDiv").hide();
				} 
		 }
		jQuery.ajax({
			url:'${contextPath}/project/prepare/isMyProjectEdit.action',
			type:'POST',
			data:{"crudId":'${crudObject.project_id}'},
			dataType:'json',
			async:false,
			success:function(data){
				 if(data.role == 0) {
					 if('${param.view}' != 'view' ){
						 document.getElementById("auditlabor").style.display = "none";
						 document.getElementById("generation").style.display = "none";
						 document.getElementById("editprogramme").style.display = "none";
						 document.getElementById("saveGenerate").style.display = "none";
						 document.getElementById("flowBtnsWrap").style.display = "none";
						 if('${param.todoback}' == '1'){
                             document.getElementById("flowBtnsWrap").style.display = "";
                         }
					 }
				 
		         jQuery("#isMyproject_fromAdjust").hide(); 
				}	
				 if(data.formState == 1){
					 document.getElementById("auditlabor").style.display = "none";
					 document.getElementById("generation").style.display = "none";
					 document.getElementById("editprogramme").style.display = "none";
					 jQuery("#isMyproject_fromAdjust").hide();
				}else if(data.formState == 2||data.formState == 4 ){
					jQuery("#isMyproject_fromAdjust").hide(); 
				}else if(data.formState == 6 && '${param.view}' != 'view'){
					 document.getElementById("saveGenerate").style.display = "";
					 document.getElementById("auditlabor").style.display = "";
					 document.getElementById("generation").style.display = "";
					 document.getElementById("editprogramme").style.display = "";
					 document.getElementById("flowBtnsWrap").style.display = ""; 
					 jQuery("#isMyproject_fromAdjust").hide(); 
				}else if (data.formState == 5 ){
					if(data.role == 0){
						jQuery("#isMyproject_fromAdjust").hide(); 
						jQuery("#buttonDiv").hide();
					}	
				}else if(data.role == 1 && data.formState == 3) {
					jQuery("#buttonDiv").hide();
				  	jQuery("#isMyproject_fromAdjust").show(); 
				}
				
			},
			error:function(){
				//alert("3333")
			}
		});
		
		if('${projectStartObject.report_closed}' == 1){
			jQuery("#isMyproject_fromAdjust").hide();
		}
		var tjsp_style = jQuery("#submitButton2Start").css("DISPLAY");
		if(tjsp_style == 'none'){
			jQuery("#isMyproject_zuzhang").hide();
		}
	});

	  /**
	  * 保存方案 
	  * by wk
	  */
	  $(function(){    

		  if ('${firstManu}' == "1"){
			  top.$('#menuList').html("") ;
		      top.ProjectIndex.initSteps(top.$('#menuList'),'-11');
		  }
	      
		  $('#saveGenerate').bind('click',function(){
				$('#sendBack_div').window('open');
			});
		// 关闭录入窗口
			$('#closeWinSjyd').bind('click',function(){
				$('#sendBack_div').window('close');
			})	
			
			// 保存方案库 
		$('#sendId').bind('click',function(){
			if(document.getElementById("title").value.replace(/\s+$|^\s+/g,"")==""){
                top.$.messager.alert('警告',"请输入保存方案名称!","error");
                return false;
            }
			$.ajax({
				dataType:'json',
				url : "<%=request.getContextPath()%>/operate/task/generateTemplate.action",
				data:{
                    "project_id":'${project_id}',
                    "taskInstanceId":'${taskInstanceId}',
                    "ppFormId":'${crudId}',
                    "title"   :$('#title').val()
                },
				type: "POST",
				success: function(data){
					if(data.type == 'success'){
						$('#sendBack_div').window('close');
						$.messager.show({
							msg:'保存成功!',
							title:'提示信息',
							showType:'slide'
						});
					}
				},
				error:function(data){
					$('#sendBack_div').window('close');
					$.messager.alert('提示信息','保存失败！','error');
				}
			});
		})
			
			
		}); 
			
		/**
    	 * 在线审计
    	 */
    	function zxsj(){
    		var host = '<s:property value="@ais.project.ProjectSysParamUtil@getZXSJHostPort()" />';
			var projectCode = '${projectStartObject.project_code}';  //document.getElementsByName("projectStartObject.project_code")[0].value;
			var auditStartTime = '${projectStartObject.audit_start_time}'; //document.getElementsByName("projectStartObject.audit_start_time")[0].value;
			if(auditStartTime==''){
				alert('审计期间没有定义,无法在线作业!');
				return false;
			}
			var start_1=auditStartTime.split("-")[0];
			var start_2=auditStartTime.split("-")[1];
			var start_3=auditStartTime.split("-")[2];
			
			if(start_2.length==1){
				start_2 = '0' + start_2;
			}
			if(start_3.length==1){
				start_3 = '0' + start_3;
			}
			
			var start=start_1+start_2+start_3;
			
			var auditEndTime = '${projectStartObject.audit_end_time}'; //document.getElementsByName("projectStartObject.audit_end_time")[0].value;
			if(auditEndTime==''){
				alert('审计期间没有定义,无法在线作业!');
				return false;
			}
			var end_1=auditEndTime.split("-")[0];
			var end_2=auditEndTime.split("-")[1];
			var end_3=auditEndTime.split("-")[2];
			
			if(end_2.length==1){
				end_2 = '0' + end_2;
			}
			if(end_3.length==1){
				end_3 = '0' + end_3;
			}
			
			var end=end_1+end_2+end_3;
			
			//var queryString = encode64(encodeURI(""+projectCode+","+start+","+end+",${user.floginname}"));
			//window.open("http://"+host+"/login.jsp?p="+queryString,'','');
			//var url ="http://"+host+"/login.jsp?p="+queryString;
            var host = '<s:property value="@ais.project.ProjectSysParamUtil@getZXSJHostPort()" />';
            var queryString = encodeURIComponent(RSAEncode("${user.floginname}"));
            var url ="http://"+host+"/vision/Login-YY.jsp?audit="+queryString + "&vision=A6";
			var udswin=window.open(url,'','toolbar=no,location=no,status=yes,resizable=yes');
		    udswin.moveTo(0,0);
		    udswin.resizeTo(window.screen.availWidth,window.screen.availHeight);
			//上面联网窗口打开后会修改一些本机管理的cookie信息,需要重新让管理系统用户自动认证一下才行
			var crudId = document.getElementById('project_id').value;
			window.location.href="/ais/project/prepare/edit.action?crudId="+crudId;
			
    	}
        
        // add by qfucee, 2014.11.6, 导出实施方案到word
        function export2word(){
        	location.href='${contextPath}/commons/oaprint/exportEnforeTemplate.action?moduleid=EnforceTemplate&projectId=${crudObject.project_id}';
        }
        
        //导出ZIP包里面包括导出实施方案的word(export2word())和excel(goedit4())
        function zip1(){
        	export2word();
    		$.ajax({
    			url:"${contextPath}/operate/doubt/outZip.action",
    			data:{"project_id":'${crudObject.project_id}',"moduleid":"EnforceTemplate"},
    			type: "post",
				async:false,
				success:function(data){
					if(data != 'NO'){
						var url="${contextPath}/operate/doubt/exportFileZip.action?project_id=" + '${crudObject.project_id}' + "&tempZipName=" +data;
	    				document.location.href=url;
					}else{
						var url = "${contextPath}/operate/doubt/deleteTempZip.action";
						document.location.href=url;
					}
				}
    		});
        }
        
        //审计实施方案调整
        function editRecord() {
        	$.messager.confirm('方案调整','是否进行审计实施方案调整?\n点‘确定’按钮必须进行调整，请慎重选择！',function(r){    
        	    if (r){    
        	    	window.location.href = "${contextPath}/project/prepare/ajustEdit.action?project_id=${crudObject.project_id}&fromAdjust=yes";
        	    }    
        	});  
		 }	
			  
     // 根据实施方案模板导出实施方案
        function zip(){        	
        	//判断模板数量
	        jQuery.ajax({
					url:'${contextPath}/operate/manuExt/pandManuTem.action?type=enforceTemplate&project_id=${crudObject.project_id}',
					type:'POST',
					dataType:'text',
					async:false,
					success:function(data){
						if(data == '2') {
							// 初始化生成表格
							$('#templateList').datagrid({
								url : "<%=request.getContextPath()%>/operate/manuExt/reportTemplateList.action?type=enforceTemplate&project_id=${crudObject.project_id}",
								method:'post',
								showFooter:false,
								rownumbers:true,
								striped:true,
								autoRowHeight:false,
								fit: true,
								fitColumns:true,
								idField:'id',
								border:false,
								singleSelect:true,
								remoteSort: false,
								columns:[[
									{field:'name',
										title:'模板名称',
										width:200,
										halign:'center',
										align:'left',
										sortable:true
									},
									{field:'operate',
										title:'操作',
										width:100,
										align:'center',
									    formatter:function(value,row,index){
									    	var link = '<a href=\"javascript:void(0);\" onclick=\"expManu(\''+row.templateId+'\',2)">导出</a>';
											return link;
										}
									}
								]]
							});
							$('#templateWindow').window({
								title:'选择实施方案模板',
								width:600,
								height:400,
								modal:true,
								collapsible:false,
								maximizable:true,
								minimizable:false
							});
						}else if(data == '0'){
							showMessage1('请维护对应的模板！');
						}else{
							expManu(data,1);
						}
					},
					error:function(){
						showMessage1('出错啦！');
					}
		});
        }

        function expManu(templateId, shu) {
			if (shu != "1") {
				$("#templateWindow").window('close');
			}
			$.ajax({
				url: "${contextPath}/operate/doubt/outZip.action",
				data: {"project_id": '${crudObject.project_id}', "templateId": templateId},
				type: "post",
				async: false,
				success: function (data) {
					if (data != 'NO') {
						var url = "${contextPath}/operate/doubt/exportFileZip.action?project_id=" + '${crudObject.project_id}' + "&tempZipName=" + data;
						document.location.href = url;
					} else {
						var url = "${contextPath}/operate/doubt/deleteTempZip.action";
						document.location.href = url;
					}
				},
				error: function () {
				}
			});
		}
        <%--function expManu(templateId,shu){--%>
		<%--	frloadOpen();--%>
		<%--	$("#dx").attr("src", "");--%>
		<%--	//var uniterm_url = "${contextPath}/project/prepare/exportEnforeTemplate.action?&crudId=${crudId}&project_name=${crudObject.project_name}&project_id=${crudObject.project_id}&templateId="+templateId;--%>
		<%--	var uniterm_url = "${contextPath}/project/prepare/exportEnforeTemplate.action?&crudId=${crudId}&project_id=${crudObject.project_id}&templateId=" + templateId;--%>
		<%--	debugger;--%>
		<%--	$("#dx").attr("src", uniterm_url);--%>
		<%--	var obj = document.getElementById("dx").contentWindow;--%>
		<%--	var intervalTime = 400;--%>
		<%--	var intervalCount = 0;--%>
		<%--	var intervalMaxCount = 50;--%>
		<%--	var intervalObj = window.setInterval(function () {--%>
		<%--		try {--%>
		<%--			//alert("intervalCount = "+intervalCount+","+intervalMaxCount);--%>
		<%--			var msg = "";--%>
		<%--			var isSuccess = false;--%>
		<%--			var sucFlag = obj.document.getElementById("sucFlag");--%>
		<%--			//alert('sucFlag='+sucFlag);--%>
		<%--			if (sucFlag && sucFlag.value.toLowerCase() == "success_save") {--%>
		<%--				frloadClose();--%>
		<%--				clearInterval(intervalObj);--%>
		<%--				msg = "success_save";--%>
		<%--				isSuccess = true;--%>
		<%--				//alert(msg);--%>
		<%--				intervalCount = null;--%>
		<%--			}--%>

		<%--			if (intervalCount > intervalMaxCount) {--%>
		<%--				frloadClose();--%>
		<%--				clear(intervalObj);--%>
		<%--				msg = "导出文件等待超时！";--%>
		<%--				//alert(msg)--%>
		<%--				intervalCount = null;--%>
		<%--			}--%>

		<%--			if (isSuccess) {--%>
		<%--				//alert(msg)--%>
		<%--				frloadClose();--%>
		<%--				exportZipFile(shu);--%>
		<%--			} else {--%>
		<%--				if (null != msg && "" != msg) {--%>
		<%--					frloadClose();--%>
		<%--					alert(msg);--%>
		<%--				}--%>
		<%--			}--%>

		<%--			intervalCount++;--%>
		<%--		} catch (e) {--%>
		<%--			frloadClose();--%>
		<%--			clear(intervalObj);--%>
		<%--			//alert('interval:'+e.message);--%>
		<%--		}--%>
		<%--	}, intervalTime);--%>

		<%--	function clear(intervalObj) {--%>
		<%--		intervalObj ? clearInterval(intervalObj) : null;--%>
		<%--	}--%>

		<%--	function exportZipFile(shu) {--%>
		<%--		if (shu != "1") {--%>
		<%--			$("#templateWindow").window('close');--%>
		<%--		}--%>
		<%--		$.ajax({--%>
		<%--			url: "${contextPath}/operate/doubt/outZip.action",--%>
		<%--			data: {"project_id": '${crudObject.project_id}', "templateId": templateId},--%>
		<%--			type: "post",--%>
		<%--			async: false,--%>
		<%--			success: function (data) {--%>
		<%--				if (data != 'NO') {--%>
		<%--					var url = "${contextPath}/operate/doubt/exportFileZip.action?project_id=" + '${crudObject.project_id}' + "&tempZipName=" + data;--%>
		<%--					document.location.href = url;--%>
		<%--				} else {--%>
		<%--					var url = "${contextPath}/operate/doubt/deleteTempZip.action";--%>
		<%--					document.location.href = url;--%>
		<%--				}--%>
		<%--			},--%>
		<%--			error: function () {--%>
		<%--			}--%>
		<%--		});--%>
		<%--	}--%>
		<%--}--%>
	</script>
	<s:if test="taskInstanceId!=null&&taskInstanceId!=''">
		<body onload="end();" style="overflow-x:auto;" class="easyui-layout">
	</s:if>
	<s:else>
		<body style="overflow-x:auto;"  class="easyui-layout">
	</s:else>
			 <div id="isMyproject_zuzhang">
				<center>
					<s:form id="projectPrepareForm" action="save" namespace="/project/prepare">
						<s:hidden name="processName" />
  	  					<s:hidden name="project_name" />
  	  					<s:hidden name="formNameDetail" />
						<s:hidden name="projectStartObject.project_code"></s:hidden>
						<div id="proInfoDiv" style="display: none;">
							<jsp:include page="/pages/project/start/edit_start_include.jsp" />
						</div>
						<s:if test="${ param.view ne 'view'}">
							<div align="left" style="width: 97%;padding-top:10px;padding-left:5px;" id="buttonDiv">
<!-- 							    <a href="javascript:;" class="easyui-linkbutton" data-options="iconCls:'icon-export'" id="exportWord" onclick="export2word()">导出Word</a>&nbsp;&nbsp;
 -->							   <!--  <a href="javascript:;" class="easyui-linkbutton" data-options="iconCls:'icon-export'" id="exportExcel" onclick="goedit4()">导出Excel</a>&nbsp;&nbsp; -->
							    <a href="javascript:;" class="easyui-linkbutton" data-options="iconCls:'icon-export'" id="exportZIP" onclick="zip()">导出ZIP</a>&nbsp;&nbsp;
							    <a href="javascript:;" class="easyui-linkbutton"  data-options="iconCls:'icon-save'" id="saveGenerate">保存至方案模板库</a>&nbsp;&nbsp;
							    <a href="javascript:;" class="easyui-linkbutton" data-options="iconCls:'icon-group'" id="auditlabor" onclick="goedit6()">审计分工</a>&nbsp;&nbsp;
							    <a href="javascript:;" class="easyui-linkbutton" data-options="iconCls:'icon-edit'" id="editprogramme" onclick="goedit2()">修改方案</a>&nbsp;&nbsp;
							    <a href="javascript:;" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" id="generation" onclick="goedit()">重新生成</a>&nbsp;&nbsp;
								<span id='flowBtnsWrap'>
			                    	<s:hidden name="project_id"/>
									<jsp:include flush="true" page="/pages/bpm/list_toBeStart.jsp" /></br>
								</span>
							</div>
						</s:if>
						<div id="isMyproject_fromAdjust" align="left" style='padding-top:10px;padding-left:5px;'>
							<a href="javascript:;"  class="easyui-linkbutton" data-options="iconCls:'icon-edit'"  id="justButton" onclick="editRecord()">调整方案</a>&nbsp;&nbsp;
						</div>   
						<s:if test="${ param.view ne 'view' and taskInstanceId ne -1}">
                            <div align="center">
                                <jsp:include flush="true" page="/pages/bpm/list_transition.jsp" />
                            </div>
						</s:if>
						<div align="right">
							<jsp:include flush="true" page="/pages/bpm/list_taskinstanceinfo.jsp" />
						</div>
					</s:form>
					<form id="tempForm" style="display:none;">
					<input type="hidden" name="projectId" value="${crudObject.project_id}"/>
					<input type="hidden" name="moduleid" value="EnforceTemplate"/>
					</form>
				</center>
			</div>
			<s:form id="myform"  action="view" namespace="/mng/train/train" >
				<table cellpadding=0 cellspacing=0 border=0  class="ListTable" align="center" >
					<tr>
						<td class="EditHead" style="width:15%">方案名称</td>
						<td  class="editTd" style="width:85%" COLSPAN="3">
							<a href="javascript:;" onclick="goView2()">
								<s:property value="audProgramme.programmeName"/>
							</a>
						</td>
					</tr>				 
					<tr>
						<td style="width:15%" class="EditHead">方案类别</td><td  class="editTd" style="width:35%"><s:property value="audProgramme.typeName"/></td>				 
						<td style="width:15%" class="EditHead">方案版本</td><td  class="editTd" style="width:35%"><s:property value="audProgramme.proVer"/></td>
					</tr>
					<tr>
						<td class="EditHead">编制人</td><td class="editTd"><s:property value="audProgramme.proAuthorName"/></td>				 
						<td class="EditHead">编制日期</td><td class="editTd"><s:property value="audProgramme.proDate"/></td>
					</tr>
				</table>								
				<s:hidden name="audProgramme.project_id"/>  
			</s:form>
			<div id="sendBack_div" title="保存方案" style='overflow:hidden;padding:0px;'>
				<s:form id="sendBackForm" action="generateTemplate" namespace="/operate/task" method="post" >
					<table class="ListTable" align="center" >
						<tr>
							<td align="left" class="EditHead">
								方案名称
							</td>
							<td class="editTd">
								<s:textfield name="title" id ="title" cssStyle="width:160px;"/>
							</td>
							 <s:hidden name="project_id"/>
							 <s:hidden name="taskInstanceId"/>
							 <s:hidden name="ppFormId" value="${crudId}" />
						</tr>
					</table>
				</s:form>
				<input type="hidden" name="s" id="s" value="${s}"/>
				<div style='text-align:center;' id='exportBtnDiv' style='padding:10px;'>
	        		<button  id='sendId'  class="easyui-linkbutton"  iconCls="icon-save">保存</button>&nbsp;&nbsp;&nbsp;&nbsp;
	        		<button  id='closeWinSjyd' class="easyui-linkbutton"  iconCls="icon-cancel">关闭</button>							        
			    </div>
		</div>
		
		<div id="templateWindow">
			<table id="templateList"></table>
		</div>
		<iframe id="dx" src="" name="dx" style="display:none;width:900px;height:400px;"></iframe>


	<jsp:include flush="true" page="/pages/frReportFlow/ajaxloading.jsp" />
		<script type="text/javascript">
		/**
		  * 检查该项目是否是督导项目 
		  * by zhangxingli 
		  */
		function isSupervisionProject(){
			if ('${user.floginname}'!='null'&&'${user.floginname}'=='${projectStartObject.superviserId}')
				return true;
			else
				return false;
		}
		
		/*
		* 显示或隐藏项目基本信息
		*/
		function triggerProjectInfoDiv(){
				var evt = window.event;
				var eventSrc = evt.target || evt.srcElement;
				var proInfoDiv = document.getElementById('proInfoDiv');
				if(proInfoDiv.style.display=='none'){
					eventSrc.innerText="隐藏项目信息";
					proInfoDiv.style.display='';
				}else{
					eventSrc.innerText="展开项目信息";
					proInfoDiv.style.display='none';
				}
		}
		function wait(){   
		    if(document.getElementById("title").value.replace(/\s+$|^\s+/g,"")==""){
		      top.$.messager.alert('警告',"请输入保存方案名称!","error");
		      return false;
		    }
			document.getElementById("sendId").disabled=true;
			document.getElementById("layer").style.display="";
			sendBackForm.submit();
		}
			
		function doStart(){
			document.getElementById('projectPrepareForm').action = "start.action";
			document.getElementById('projectPrepareForm').submit();
		}
		/*
		* 流程启动前提示和检验
		*/
		function beforStartProcess(){
			if(!checkWorkprogram()){
			}
			return true;
		}
			/*
				提交表单
			*/
			function toSubmit(option){

				var tableId = 'projectStartTable';
				var formId = 'projectPrepareForm';
				
				if(!validateDate('audit_start_time','audit_end_time')){
					return false;
				}
				
				if(!fff1()){
					return false;
				}
				
				var flowForm = document.getElementById(formId);
				if(frmCheck(flowForm,tableId)==false){
					return false;
				}else{
					<s:if test="isUseBpm=='true'">
						if(document.getElementsByName('isAutoAssign')[0].value=='false'||document.getElementsByName('formInfo.toActorId')[0]!=undefined){
							var actor_name=document.getElementsByName('formInfo.toActorId')[0].value;
							if(actor_name==null||actor_name==''){
								//window.alert('下一步处理人不能为空！');
								top.$.messager.alert('提示信息',"下一步处理人不能为空!","error");
								return false;
							}
						}
					</s:if>
					top.$.messager.confirm("提示信息","确认提交吗?",function(r){
						if(r){
							/* 同步到大数据开始 */
						    var projectId = '${projectStartObject.formId}';
                            $.ajax({
                                type: "POST",
                                url: "<%=request.getContextPath()%>/project/prepare/synchronizeToBigData.action",
                                data : {
                                    "formId": projectId
                                }
                            });
							/* 同步到大数据结束 */
							document.getElementById('submitButton').disabled=true;
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
			}
			/*
				保存表单
			*/
			function toSave(formId,tableId){
				if(!validateDate('audit_start_time','audit_end_time')){
					return false;
				}
				var flowForm = document.getElementById(formId);
				document.getElementById('saveButton').disabled=true;
				if(frmCheck(flowForm,tableId)==false){
					document.getElementById('saveButton').disabled=false;
					return false;
				}else{	
					flowForm.action="${contextPath}/project/prepare/save.action";
					flowForm.submit();
				}
			}

			/*
				校验两个日期大小顺序
			*/
			function validateDate(beginDateId,endDateId){
				var s = document.getElementById(beginDateId);
				var e = document.getElementById(endDateId);
				if(s && e){
					var s = s1.value;
					var e = e1.value;
					if(s!='' && e!=''){
						var s_date=new Date(s.replace("-","/"));
						var e_date=new Date(e.replace("-","/"));
						if(s_date.getTime()>e_date.getTime()){
							window.alert("日期区间开始必须小于结束!");
							return false;
						}
					}
				}
					return true;
			}
		
			/*
			* 审计文书
			*/
			function Upload_auditAmanuensis(){
				var num=Math.random();
				var rnm=Math.round(num*9000000000+1000000000);
				window.showModalDialog('${contextPath}/commons/file/welcome.action?guid=<s:property value="crudObject.fileAuditAmanuensis"/>&&param='+rnm+'&&deletePermission=<s:property value="%{varMap.deletefileAuditAmanuensisRead}"/>&&isEdit=<s:property value="%{varMap.editfileAuditAmanuensisRead}"/>&&title='+encodeURI(encodeURI("审计文书")),fileAuditAmanuensis,'dialogWidth:700px;dialogHeight:500px;status:yes');
			}
			
			/*
			* 审前调查
			*/
			function Upload_auditBeforeInquire(){
				var num=Math.random();
				var rnm=Math.round(num*9000000000+1000000000);
				window.showModalDialog('${contextPath}/commons/file/welcome.action?guid=<s:property value="crudObject.fileAuditBeforeInquire"/>&&param='+rnm+'&&deletePermission=<s:property value="%{varMap.deletefileAuditBeforeInquireRead}"/>&&isEdit=<s:property value="%{varMap.editfileAuditBeforeInquireRead}"/>&&title='+encodeURI(encodeURI("审前调查")),fileAuditBeforeInquire,'dialogWidth:700px;dialogHeight:500px;status:yes');
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
			* 是否创建了审计方案
			*/
			function fff1(){
				var message="";
				DWREngine.setAsync(false);
				DWREngine.setAsync(false);DWRActionUtil.execute(
				{ namespace:'/operate/task', action:'checkActualizeScheme', executeResult:'false' }, 
				{'pro_form_id':'${crudObject.formId}','pro_id':'${crudObject.project_code}'},xxx);
				function xxx(data){
					message=data['as'];
				};
				if(message!=null&&message!=''){
					alert(message);
					return false;
				}else{
					return true;
				}
			}
			
			/*
			* 检查是否还有审计分工未分
			*/
			function checkWorkprogram(){
				$.ajax({
	                type: "POST",
	                url: "<%=request.getContextPath()%>/workprogram/checkWorkprogram.action",
	                data : {
						
						"project_id":"${crudObject.project_id}","wpd_stagecode":"prepare"
					},
	                success: function(data){
	                	if(data['success']!=false){
	                		//alert(data['success']);
							var text = data['success'];
							top.$.messager.show({
								'title':'提醒 (3分钟后关闭)',
								'msg':text,
								'height':'475px',
								'width':'500px',
								'timeout':1800000,
								'showType':'slide'
							});
	                	}
	                  }
	              });
			}
			
		 
		function goedit(){
		//返回上级list页面
		$.messager.confirm('重新生成','此操作会重置方案，确定重新生成？',function(r){    
        	    if (r){    
        			location.href='${contextPath}/operate/template/relistAll.action?project_id=${crudObject.project_id}&taskInstanceId=${taskInstanceId}&ppFormId=${crudId}';
        	    }    
        	}); 

		}
		//mainTaskEdit  mainReady
		function goedit2(){
			var flag='${flag}';
			var temp = '${contextPath}/operate/task/mainReadyEdit.action?project_id=${crudObject.project_id}';
			if(flag == 'yes'){
				parent.parent.goMenu('修改方案',temp,'2');
			}else{
				window.parent.addTab('tabs','修改方案 ','tempframe',temp,true);
			}

		}

		function goView2(){
			var flag='${flag}';
			var temp ='${contextPath}/operate/task/mainReadyView.action?project_id=${crudObject.project_id}';
				if(flag == 'yes'){
					parent.parent.goMenu('实施方案查看',temp,'2');
				}else{
					window.parent.addTab('tabs','实施方案查看 ','tempframe1',temp,true);
				}
		}
		
		
		function goedit3(){
		//返回上级list页面
			var title="保存至方案模板库";
		    showPopWin('${contextPath}/operate/task/generate.action?project_id=${crudObject.project_id}',500,300,title);
		}
		
		function goedit6(){
			var flag='${flag}';
			//var temp = '${contextPath}/operate/task/project/showContentTypeWorkView.action?project_id=${crudObject.project_id}&view=${view}';
			var temp = '${contextPath}/project/memberDivisionHome.action?project_id=${crudObject.project_id}&crudId=${crudObject.project_id}&view=${view}';
			if(flag == 'yes'){
				parent.parent.goMenu('审计分工',temp,'2');
			}else{
				window.parent.addTab('tabs','审计分工 ','tempframe2',temp,true);
			}
		}
		function goedit4(){
		//返回上级list页面
			location.href='${contextPath}/operate/doubt/exportTask.action?project_id=${crudObject.project_id}';//
		}
		</script>

		</body>
</html>