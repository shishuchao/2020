<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!-- 此处会导致审计报告画面初始化时，样式变化时会展现给客户 暂时注释-->
<%-- <script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script> --%>
<script type="text/javascript">
jQuery(function(){
	jQuery.ajax({
		   type: "POST",
		   url: "/ais/project/prepare/audAdvice/doSomeAction!isProcessAlready.action",
		   data: {"formId":"${crudObject.formId}"},
		   success: function(msg){
		       if(msg == 1){
		    	   jQuery("#submitButton2Start").css("display","none");
		    	   if(jQuery("#definition_div1").length >0){
						jQuery("#definition_div1").css({display:"none"});
						jQuery("#bpmGroupDiv").css({display:"none"});
					};
		       }
		   }
		});
});

	/**
	* 流程选择框改变的时候抓取对应的群组信息并更新到群组选择框中
	*/
	function fetchBpmGroup(bpmDefinitionId){

		if(bpmDefinitionId == ''){
			//alert('没有流程ID,无法获取群组信息!');
			top.$.messager.alert("错误","没有流程ID,无法获取群组信息!",'warning');
			return false;
		}
		//判断是不是督导项目，并判断是否选择了督导项目的流程
		if(typeof window.isSupervisionProject != 'undefined' && isSupervisionProject()){
			//函数未定义不用判断是否是督导项目选择流程
			var obj = document.getElementById("definition_id"); 
			var index = obj.selectedIndex; // 选中索引
			var content = obj.options[index].text; // 选中文本
			if(content.indexOf("督导")==-1){
				//alert("此项为督导项目，必须选择督导项目的流程");
				top.$.messager.alert("错误","此项为督导项目，必须选择督导项目的流程",'warning');
				return false;
			}
		}
		
		DWREngine.setAsync(false);
		DWREngine.setAsync(false);DWRActionUtil.execute(
			{ namespace:'/bpm/pageGenerate', action:'generateBpmGroupDiv', executeResult:'false' }, 
			{'bpmDefinitionId':bpmDefinitionId},
			xxx);
		function xxx(data){
			bpmGroupDivHtml = data['pageSnippet'];
			document.getElementById('bpmGroupDiv').innerHTML = bpmGroupDivHtml;
		} 

	}
	
	/**
	*  更新流程选择项目
	*/
	function updateProcessDiv(bpmDeptId){
		//判断提交审批按钮在保存之后，再出现
		if("<%=request.getAttribute("flag_tjsp") %>" != 1 && ("<%=request.getParameter("name") %>" =="" || "<%=request.getParameter("name") %>" == null)){
			bpmDeptId = "";
		}
		var formType = '${formType}';
		if(formType==''){
			//alert('无法获取表单类型!');
			top.$.messager.alert("错误","无法获取表单类型！",'warning');
			return false;
		}
		
		DWREngine.setAsync(false);
		DWREngine.setAsync(false);DWRActionUtil.execute(
			{ namespace:'/bpm/pageGenerate', action:'generateProcessDiv', executeResult:'false' }, 
			{'bpmDeptId':bpmDeptId,'formType':formType},
			xxx);
		function xxx(data){
			processDivHtml = data['pageSnippet'];
			document.getElementById('processListDiv').innerHTML = processDivHtml;
			$('.easyui-linkbutton').linkbutton();
/*            if('${yearPlan}' == '1'){
                if(jQuery("#definition_div1").length >0){
                    jQuery("#definition_div1").css({display:"none"});
                    jQuery("#bpmGroupDiv").css({display:"none"});
                };
                var opts = $('#definition_id option');
                if(opts && opts.length){
                    for(var i in opts){
                        if('${importantPlanAdjusted}' == '1'){
							if($(opts[i]).text().indexOf('集团审批') > -1){
								$("#definition_id").val($(opts[i]).val());
								$("#definition_id").change();
								break;
							}
                        }else{
                            if($(opts[i]).text().indexOf('事业部审批') > -1){
                                $("#definition_id").val($(opts[i]).val());
                                $("#definition_id").change();
                                break;
                            }
                        }
                    }
                }
            }*/
		}
	}

	/**
	* 流程启动前校验,业务模块添加校验可以覆盖beforStartProcess()方法
	*/
	function startProcess(){
		var processName=document.getElementById("definition_id").value.replace(/\s+$|^\s+/g,"");
		var groupName=document.getElementById("group_id").value.replace(/\s+$|^\s+/g,"");
		if(processName==""){
			top.$.messager.alert("错误","未设定流程，不能启动！");
			return false;
		}else if(groupName==""){
			top.$.messager.alert("错误","未设定群组，不能启动！");
			return false;
		}
		top.$.messager.confirm('确认对话框', '确认启动审批流程吗？', function(r) {
			if (r) {
				if(null!=$('#submitButton2Start')&&$('#submitButton2Start').length>0){
					$('#submitButton2Start').linkbutton('disable');
				}
				if(typeof window.beforStartProcess != 'undefined' && !beforStartProcess()){
					$('#submitButton2Start').linkbutton('enable');
					return false;
				}
				if(typeof window.doStart != 'undefined'){
					doStart();
				}
				reloadHomeByFlow();
			}else{
				return false;
			}
		});
	}
	/*
	* add by qfucee, 2015.10.26
	* 流程提交时，刷新首页的待办
	*/
	function reloadHomeByFlow(){
		//try{
	    	// 是否来自审计作业页面
	   		var isJobPage = false;
	     	var bodyId = $(top.document).find('body').attr('id');
	    	if(bodyId == 'projectLayout'){
	        	isJobPage = true;
	      	}else if(bodyId == 'mainLayout'){
	          	isJobPage = false;
	      	}
	     	var pageWin = isJobPage ? window.top.opener.parent : window.top; 
			if(pageWin && pageWin.reloadHomePage){
	       		pageWin.reloadHomePage();
			}
		//}catch(e){
			//alert('reloadHomeByFlow()\nmsg:'+e.message);
		//}
	}
	// 单项底稿或者综合底稿审批流程
	/* function manuTypefun(manuType){
		if(typeof(manuType) != "undefined" && manuType != null && manuType != "" && manuType.length > 1){
		 var obj = document.getElementById("definition_id");
		 if(null!=obj){
			 var definition=obj.options;
			 if(typeof(manuType) != "undefined" && manuType != null){
				   if( typeof(definition) != "undefined" && definition != null && definition.length >0 ){
					   if( manuType == "COMPREHENSIVE" && definition.length > 0){
							for(var i=definition.length-1;i >= 0;i--){
								if( definition[i] !=null && definition[i].text != null){
									if(definition[i].text.indexOf("单项") != -1){
										definition.remove(i);
									}
								}
							}
							if( definition.length > 0 ){
								fetchBpmGroup(definition[0].value);
							}else{
								alert("请维护综合底稿流程");
							}
							
					   }else if( manuType == "UNITERM" && definition.length > 0){ 
							for(var i=definition.length;i >=0  ;i--){
								if( definition[i] !=null && definition[i].text != null){
									if(definition[i].text.indexOf("综合") != -1){
										definition.remove(i);
									}
								}
							}
							if( definition.length > 0 ){
								fetchBpmGroup(definition[0].value);
							}else{
								alert("请维护单项底稿流程");
							}
					   }
				   }
			   }
		 }
	}
	} */
</script>

<span id="processListDiv">
	<s:if test="${taskInstanceId==0 or taskInstanceId==-1}">
		<script type="text/javascript">
			//页面第一次加载的时候根据Action中提供的bpmDeptId初始化processListDiv
			updateProcessDiv('${bpmDept}');
		</script>
	</s:if>
	<s:if test="${taskInstanceId!=0 and taskInstanceId ne -1}">
		<a id="submitButton" href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" onclick="this.style.disabled='disabled';toSubmit('toSave');">提交</a>
	<input type="hidden" name="todoback"  value="${todoback}">
	</s:if>
</span>


