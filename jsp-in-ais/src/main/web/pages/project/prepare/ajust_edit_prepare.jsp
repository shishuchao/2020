<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>准备阶段11</title>
		<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />

		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/csswin/subModal.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
	</head>
	<script type="text/javascript">
	var multiTemplate = false;
	$(document).ready(function(){
		var fromAdjust="${fromAdjust}";
		var taskInstanceId="${taskInstanceId}";
		jQuery.ajax({
			url:'${contextPath}/project/prepare/isMyProjectEdit.action',
			type:'POST',
			data:{"crudId":'${crudObject.project_id}'},
			dataType:'json',
			async:false,
			success:function(data){
				 if(data.role == 0) {
					 document.getElementById("auditlabor").style.display = "none";
					 document.getElementById("editprogramme").style.display = "none";
					 document.getElementById("saveGenerate").style.display = "none";
			}	
			 	 if(data.formState == 1){
				 document.getElementById("auditlabor").style.display = "none";
				 document.getElementById("editprogramme").style.display = "none";
			}else if(data.formState == 4 && data.myformState ==7 && taskInstanceId >0){
				 document.getElementById("auditlabor").style.display = "";
				 document.getElementById("editprogramme").style.display = "";
				 document.getElementById("saveGenerate").style.display = "";
			}else if(data.formState == 4 && data.myformState ==8){
					 document.getElementById("auditlabor").style.display = "none";
					 document.getElementById("editprogramme").style.display = "none";
					 document.getElementById("saveGenerate").style.display = "none";
				}else if(data.formState == 6){
				 document.getElementById("saveGenerate").style.display = "";
				 document.getElementById("auditlabor").style.display = "";
				 document.getElementById("editprogramme").style.display = "";
			}else if (data.formState == 5 ){
				if(data.role == 0){
					 document.getElementById("auditlabor").style.display = "none";
					 document.getElementById("editprogramme").style.display = "none";
					 document.getElementById("saveGenerate").style.display = "none";
					 document.getElementById("flowBtnsWrap").style.display = "none"; 
				}	
			} 
			},
			error:function(){
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

	
	
	
        // add by qfucee, 2014.11.6, 导出实施方案到word
        function export2word(){
        	location.href='${contextPath}/commons/oaprint/exportEnforeTemplate.action?moduleid=EnforceTemplate&projectId=${crudObject.project_id}';
        }

		 /*
		 * 根据选定的模板创建实施方案初稿
		 */

	        function expManu(templateId){
	      	 	$("#dx").attr("src","");
		 	 	//var uniterm_url = "${contextPath}/project/prepare/exportEnforeTemplate.action?&crudId=${crudId}&project_name=${crudObject.project_name}&project_id=${crudObject.project_id}&templateId="+templateId;
		 	 	var uniterm_url = "${contextPath}/project/prepare/exportEnforeTemplate.action?&crudId=${crudId}&project_id=${crudObject.project_id}&templateId="+templateId;
		 	 	$("#dx").attr("src",uniterm_url); 
		 	 	var obj = document.getElementById("dx").contentWindow;
		   		var intervalTime = 100;
		   		var intervalCount = 0;
		   		var intervalMaxCount = 50;
		   		var intervalObj = window.setInterval(function(){
		   			try{	   				
			   			//alert("intervalCount = "+intervalCount+","+intervalMaxCount);
			   			var msg = "";
			   			var isSuccess = false;
			   			var sucFlag = obj.document.getElementById("sucFlag");
			   			//alert('sucFlag='+sucFlag);
			   			if(sucFlag && sucFlag.value.toLowerCase() == "成功将文档保存到服务器"){
			   				clearInterval(intervalObj);
			   				msg = "success_save";
			   				isSuccess = true;
			   				//alert(msg);
			   				intervalCount = null;
			   			}
			   			
			   			if(intervalCount > intervalMaxCount){
			   				clear(intervalObj);
			   				msg = "导出文件等待超时！";
			   				//alert(msg)
			   				intervalCount = null;
			   			}
			   			
			   			if(isSuccess){
			   				//alert(msg)
			   				exportZipFile();
			   			}else{
			   				if(null!=msg&&""!=msg){
			   					alert(msg);
			   				}
			   			}
			   			
			   			intervalCount++;
		   			}catch(e){
		   				clear(intervalObj)
		   				//alert('interval:'+e.message);
		   			}
		   		}, intervalTime);
		   		
		   		function clear(intervalObj){
		   			intervalObj ? clearInterval(intervalObj) : null;
		   		}
		   		
		   		function exportZipFile(){
		   			if(multiTemplate){
						$("#templateWindow").window('close');
					}
					 $.ajax({
		    			url:"${contextPath}/operate/doubt/outZip.action",
		    			data:{"project_id":'${crudObject.project_id}'},
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
						},
						error:function(){
						}
		    		});
		   		}
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
						if(data == 2) {
							multiTemplate = true;
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
									    	var link = '<a href=\"javascript:void(0);\" onclick=\"expManu(\''+row.templateId+'\')">导出</a>';
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
						}else if(data == 0){
							showMessage1('请维护对应的模板！');
						}else{
							multiTemplate = false;
							expManu(data);
						}
					},
					error:function(){
						showMessage1('出错啦！');
					}
		});
        }
        $(document).ready(function(){
   		 $('#sendBack_div').window({   
   				width:400,   
   				height:150,   
   				modal:true,
   				collapsible:false,
   				maximizable:false,
   				minimizable:false,
   				closed:true
   			});
   		});
   	  /**
   	  * 保存方案 
   	  * by wk
   	  */
   	  $(function(){    
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
   			  	  $.messager.show({
   			  		  title:"提示信息",
   			  		  msg:"请输入回传方案名称！",
   			  		  timeout:5000
   			  	  });
   			      $.messager.alert('警告',"请输入保存方案名称!","error");
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
   							title:'提示信息',
   							msg:'保存成功',
   							timeout:5000,
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
			  
        
	</script>
	<s:if test="taskInstanceId!=null&&taskInstanceId!=''">
		<body onload="end();" tyle="overflow-x:auto;" class="easyui-layout">
	</s:if>
	<s:else>
		<body tyle="overflow-x:auto;" class="easyui-layout">
	</s:else>
			<div id="isMyproject_zuzhang">
				<center>
				
					<s:form id="projectPrepareForm" action="save" namespace="/project/prepare">
						<s:hidden name="projectStartObject.project_code"></s:hidden>
						<div style='padding:10px 5px 0px 0px;'>
						<div id="proInfoDiv" style="display: none;">
							<jsp:include page="/pages/project/start/edit_start_include.jsp" />
						</div>
						<s:if test="${ param.view ne 'view'}">
							<div align="left" style="width: 97%" id="buttonDiv">
                              	<!-- <a href="javascript:;" class="easyui-linkbutton" data-options="iconCls:'icon-export'" onclick="export2word()">导出Word</a>&nbsp;
							    <a href="javascript:;" class="easyui-linkbutton" data-options="iconCls:'icon-export'" onclick="goedit4()">导出Excel</a>&nbsp; -->
							    <a href="javascript:;" class="easyui-linkbutton" data-options="iconCls:'icon-export'" id="exportZIP" onclick="zip()">导出ZIP</a>&nbsp;
							<s:if test="${ param.projectview ne 'view'}">
							   <a href="javascript:;" class="easyui-linkbutton"  data-options="iconCls:'icon-save'" id="saveGenerate">保存至方案模板库</a>&nbsp;
							    <a href="javascript:;" class="easyui-linkbutton" data-options="iconCls:'icon-group'" id="auditlabor" onclick="goedit6()">审计分工</a>&nbsp;
							    <a href="javascript:;" class="easyui-linkbutton" data-options="iconCls:'icon-edit'"  id="editprogramme" onclick="goedit2()">修改方案</a>&nbsp;
							   <!--  <a href="javascript:;" class="easyui-linkbutton" data-options="iconCls:'icon-export'"  id="editprogramme" onclick="exportTemplate()">导出方案</a>&nbsp; -->
			                    <span id='flowBtnsWrap'>
			                   		<s:hidden name="fromAdjust"></s:hidden>
									<jsp:include flush="true" page="/pages/bpm/list_toBeStart.jsp" /></br>
								</span>
							</div>
						</s:if>
						</s:if>
						</div>
						<s:if test="${ param.view ne 'view' and taskInstanceId ne -1 and  param.projectview ne 'view'}">
						<div align="center">
							<jsp:include flush="true" page="/pages/bpm/list_transition.jsp" />
						</div>
						</s:if>
						<div align="right">
							<s:hidden name="fromAdjust"></s:hidden>
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
				<table cellpadding=0 cellspacing=0 border=0  class="ListTable" align="center">
					<tr>
						<td class="EditHead" style="width:15%">方案名称</td><td class="editTd" style="width:85%" COLSPAN="3"><a href="javascript:;" onclick="goView2()"><s:property value="audProgramme.programmeName"/></a></td>
					</tr>				 
					<tr>
						<td style="width:15%" class="EditHead">方案类别</td><td class="editTd" style="width:35%"><s:property value="audProgramme.typeName"/></td>				 
						<td style="width:15%" class="EditHead">方案版本</td><td class="editTd" style="width:35%"><s:property value="audProgramme.proVer"/></td>
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
					<s:hidden name="flag"/>
				</s:form>
				<input type="hidden" name="s" id="s" value="${s}"/>
				<div style='text-align:center;' id='exportBtnDiv' style='padding:10px;'>
				<s:if test="${ param.projectview ne 'view'}">
	        		<button  id='sendId'  class="easyui-linkbutton"  iconCls="icon-save">保存</button>&nbsp;&nbsp;&nbsp;&nbsp;
	      
	        		<button  id='closeWinSjyd' class="easyui-linkbutton"  iconCls="icon-cancel">关闭</button>		
	        		  	</s:if>					        
			    </div>
		</div>
		<div id="templateWindow">
			<table id="templateList"></table>
		</div>
		<!-- <iframe id="dx" src="" style="display:none;"></iframe> -->
	    <iframe id="dx" height="1" width="1" src="" ></iframe>	
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
			
		/*
		* 流程启动前提示和检验
		*/
		function beforStartProcess(){
			if(!checkWorkprogram()){
				
			}
			return true;
		}
		/*
		* 流程启动
		*/
		
		function doStart(){
			document.getElementById('projectPrepareForm').action = "start.action";
			document.getElementById('projectPrepareForm').submit();
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
								top.$.messager.show({
									title:"提示信息",
									msg:"下一步处理人不能为空！",
									timeout:5000
								});
								return false;
							}
						}
					</s:if>
					
					top.$.messager.confirm("提示信息","确认提交吗?",function(r){
						if(r){
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
					
					
					/*
					if(confirm('确认提交吗?')){
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
					}*/
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
							$.messager.show({
								title:"提示信息",
								msg:"日期区间开始必须小于结束!",
								timeout:5000
							});
							return false;
						}
					}
				}
					return true;
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
								'title':'提醒(60s关闭)',
								'msg':text,
								'height':'475px',
								'width':'500px',
								'timeout':60000,
								'showType':'slide'
							});
	                	}
	                  }
	              });
			}
			
			
		 
		function goedit(){
		//返回上级list页面
			location.href='${contextPath}/operate/template/relistAll.action?project_id=${crudObject.project_id}&taskInstanceId=${taskInstanceId}&ppFormId=${crudId}';

		}
		function goedit2(){
			var flag='${flag}';
			var temp = '${contextPath}/operate/task/mainReadyEdit.action?fromAdjust=yes&project_id=${crudObject.project_id}';
			if(flag == 'yes'){
				window.parent.addTab('tabs','修改方案(调整)','tempframeAdjust',temp,true);
			}else{
				window.parent.addTab('tabs','修改方案(调整)','tempframeAdjust',temp,true);
			}
		}

		function goView2(){
			var flag='${flag}';
			var temp ='${contextPath}/operate/task/mainReadyView.action?fromAdjust=yes&project_id=${crudObject.project_id}'
				if(flag == 'yes'){
					window.parent.addTab('tabs','实施方案查看(调整)','tempframeAdjust',temp,true);
				}else{
					window.parent.addTab('tabs','实施方案查看(调整)','tempframeAdjust',temp,true);
				}
		}
		function goedit3(){
		//返回上级list页面
			var title="保存方案";
		    showPopWin('${contextPath}/operate/task/generate.action?project_id=${crudObject.project_id}',500,300,title);
		    
		    
		}
			function goedit6(){
				var flag='${flag}';
				//var temp ='${contextPath}/operate/task/project/showContentTypeWorkView.action?project_id=${crudObject.project_id}&view=view';
				var temp = '${contextPath}/project/memberDivisionHome.action?project_id=${crudObject.project_id}&crudId=${crudObject.project_id}&view=${view}';
				if(flag == 'yes'){
					window.parent.addTab('tabs','审计分工(调整)','tempframeAdjust',temp,true);
				}else{
					window.parent.addTab('tabs','审计分工(调整)','tempframeAdjust',temp,true);
				}
			}
		function goedit4(){
		//返回上级list页面
			location.href='${contextPath}/operate/doubt/exportTask.action?project_id=${crudObject.project_id}';//

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
		</script>
		
		</body>
</html>