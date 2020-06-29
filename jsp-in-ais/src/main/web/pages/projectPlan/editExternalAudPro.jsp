<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
<head>	
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<title>外部监督项目编辑</title>
<script type="text/javascript" src="${contextPath}/easyui/boot.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/jquery-fileUpload.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/autosize.js"></script>
<script type="text/javascript" src="${contextPath}/pages/tlInteractive/tlInteractiveCommon.js"></script>
<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
<script type="text/javascript">
$(function(){
	var isView = "${view}" == true || "${view}" == "true" ? true : false;
	isView ? $('.editElement').remove() : $('.viewElement').remove();	
	if(isView && '${crudObject.w_write_date}'.length > 10){
		$('#viewWriteDate').text('${crudObject.w_write_date}'.substr(0,10));
	}
	var fileContainer = isView ? 'view_attachFile' : 'edit_attachFile';
	var fileGuid = '${crudObject.w_file}';
	// 附件上传初始化
    $('#'+fileContainer).fileUpload({
        fileGuid:fileGuid,
        isAdd:!isView,
        isEdit:!isView,
        isDel:!isView,
        isView:true,
        isDownload:true,
        isdebug:false
    });	
	setTimeout(function(){	
		$('#'+fileContainer).fileUpload('toggleListStatus', true);
	},100)
	
	
   	var date=new Date;
   	var month=date.getMonth()+1;
   	var cc = $("#cc option:selected").text().trim();
   	var w_plan_month = '${crudObject.w_plan_month}';
   	if(w_plan_month != null && w_plan_month != '')
   		$('#cc').combobox('setValue', w_plan_month);
   	else if(cc == "" && (w_plan_month == null || w_plan_month=='')){
   		$('#cc').combobox('setValue', month);
   	}
   	
   	var fromAdjust = '${fromAdjust}';
   	if(fromAdjust == null || fromAdjust == '') {
   		var w_plan_type = '${crudObject.w_plan_type}';
   		if(w_plan_type == null || w_plan_type == '')
   			$('#plan_type').combobox('setValue', '020101');
   	}
	
	$("#planForm").find("textarea").each(function(){
		autoTextarea(this);
	});

	$('#gSaveBtn').bind('click', function(){
		saveProPlan('planForm','planTable', false);
	});
	
	$('#gPostBtn').bind('click', function(){
		saveProPlan('planForm','planTable', true);
	});
	
	$('#gCloseBtn').bind('click', function(){
		aud$closeTab();
	});
	
	$('#pro_type_child_name').hide();
	//监督类型选择
	$('#proTypeSelect').bind('click', function(){
		var winJson = showSysTree($('#proTypeSelect')[0],{
              title:'监督类型选择',
              onlyLeafClick:true,
              param:{
                'customRoot':'监督类型',
                'serverCache':false,
                'rootParentId':'0',
                'beanName':'CodeName',
                'whereHql':'type=\'1003\'',
                'plugId':'codename_1003',
                'treeId'  :'id',
                'treeText':'name',
                'treeParentId':'pid',
                'treeOrder':'code',
                'treeAtrributes':'code,pid,name'
             },
             onAfterSure:function(dms,mcs){
                	var pname = "", pval = "";
                	var jqtree = this;
                	//根据子节点是否有值来判断是否清空父节点值。
					if(mcs==null || mcs == '' || mcs == 'undefined' || mcs == undefined){
						$('#pro_type_child_name').val("");
						$('#pro_type_name').val("");
					} 
 	    		  	$.each(dms, function(i, dm){
	    				var selectNode = $(jqtree).tree("find", dm);
	    				var attributes = selectNode.attributes;
	    				if(attributes){
	    					var ajson = (new Function("return " + attributes))();
	    					//alert(ajson.code +"\n"+ajson.name)项目子类别
	    					$('#pro_type').val(ajson.code ? ajson.code : "");
	    					var pid = ajson.pid;
	    					if(pid != '0'){
	    						var parentNode = $(jqtree).tree("find", pid);
	    						var pattributes = parentNode.attributes;
	    						var pajson = (new Function("return " + pattributes))();
	    						//alert(pajson.code +"\n"+pajson.name)
	    						pname = pajson.name;
	    						pval = pajson.code;//项目类别
                                $('#pro_type_child').val(ajson.code ? ajson.code : "");
                                $('#pro_type').val(pval);
	    					}else{
                                $('#pro_type_child').val(pval);
                            }
	    					
	    				}
	    					
	    			});  
 	    			$('#pro_type_child_name').val(pname).css('display', pname ? '' : 'none');
	    				$('#viewFa').show();

	    		}
    	})

	});
	
    $('#crudObject_unionJdId').combobox({
   		'panelHeight':"auto",
   		'editable':false,
		'onSelect':function(rec){
    		$('#crudObject_unionJdName').val(rec.text);
    	},
    	'onChange':function(newval, oldval){
    		$('#cprtOrgSelect').css('display', newval == '2' ? '' : 'none');
    		newval == '1' ? $('#crudObject_cprtOrgId,#crudObject_cprtOrgName').val('') : null;
    	}
    });
    <%--if('${crudObject.unionJdId}'){//编辑--%>
        <%--$('#crudObject_unionJdId').combobox('setValue', '${crudObject.unionJdId}');--%>
    <%--}else{//添加，由于text没有默认值，所以要从combobox中读取默认值           --%>
        <%--$('#crudObject_unionJdName').val($('#crudObject_unionJdId').combobox('getText'));--%>
    <%--}--%>

/*   $('#externalMainName_code').combobox({
   		'panelHeight':"auto",
   		'editable':false,
		'onSelect':function(rec){
    		$('#externalMainName').val(rec.text);
    	}
    });*/
	if('${crudObject.externalMainName}'){//编辑
		$('#externalMainName_code').combobox('setValue', '${crudObject.externalMainName}');
		if(!$('#externalMainName').val()){
			var sText = $('#externalMainName_code').combobox('getText');
			$('#externalMainName').val(sText ? sText : '')
		}
	}

    $('#handle_modus').combobox({
   		'panelHeight':"auto",
   		'editable':false,
		'onSelect':function(rec){
    		$('#handle_modusname').val(rec.text);
    	}
    });
    if('${crudObject.handle_modus}'){//编辑
        $('#handle_modus').combobox('setValue', '${crudObject.handle_modus}');
    	if(!$('#handle_modusname').val()){
    		var sText = $('#handle_modus').combobox('getText');
    		$('#handle_modusname').val(sText ? sText : '')
    	}
    }

		
		//增预选项目信息时给计划管理中的监督期间开始和监督期间结束的值进行初始化显示默认前一年1月1日到12月31日
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
	                	//$("#viewWorkFile").attr("src",viewUrl);
	            		//$('#viewWork').window('open');
	                	//window.open("${contextPath}/workprogram/viewWorkProgram.action?wpid="+wpvalue,"","height=700px, width=800px, toolbar=no, menubar=no, scrollbars=yes,resizable=yes,location=no, status=no");
	            		new aud$createTopDialog({
	                        title:'工作方案查看',
	                        url  :viewUrl
	                  	}).open();
	                
	                }else{
	                	top.$.messager.alert("提示信息","没有定义该监督类型的工作方案模板，请去工作方案模块中进行维护!","warning");
	                	//alert("没有定义该监督类型的工作方案模板，请去工作方案模块中进行维护!");
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
						msg:"该计划选定的监督类型没有定义对应的工作方案模板，请去工作方案模块中进行维护!",
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
	
	    function changSubmit(){
	
	    }
	
		var fromAdjust = "${fromAdjust}"; //是否从计划调整模块中过来 
		/*
		* 被监督单位改变的时候需要重置经济责任人的值
		*/
		function resetJjzrr(){
			//获取该监督单位上次被监督的时间和监督类型
			var audit_object = $("#audit_object").val();
			$.ajax({
                type: "POST",
                url: "${contextPath}/plan/detail/save!searchLastPro.action",
                data: {"auditObjectId":audit_object},
                dataType:"json",
                success: function(msg){
                      $("#lastAudYearTemp").val(msg[0].lastAudYear);
                      $("#lastProTypeNameTemp").val(msg[0].lastProTypeName);
                      $("#lastProType").val(msg[0].lastProType);
					  $('#crudObject_seateTypeId').val(msg[0].seateTypeId);
					  $('#crudObject_seateTypeName').val(msg[0].seateTypeName);
                }
          	});
			
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

		/*
		保存表单
	*/
	function saveProPlan(formId,tableId,isPostForm){
		var sText = $('#externalMainName_code').combobox('getText');
		if ($('#externalMainName')){
			$('#externalMainName').val(sText ? sText : '')
		}
		if(!audEvd$validateform(formId)){
			return false;
		}	
        // if(!validateYearPlan()){
        // 	return false;
        // }
        <%--if('${WorkProgramStatus}' != 'false'){--%>
          	<%--if(!validateProgram()){//校验工作模板方案--%>
                <%--return false;--%>
            <%--}--%>
       	<%--}--%>
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
		var busUrl = "${contextPath}/plan/detail/save.action?fromAdjust=${fromAdjust}";
		if ("${option}" == "addyuxuan"){
			var flowForm = document.getElementById(formId);
			flowForm.action=busUrl;
			flowForm.submit();
		}else{
			busUrl = busUrl + (isPostForm ? "&externalPostPlan=1" : "");
			$('#'+formId).form('submit',{    
			    url:busUrl,    
			    onSubmit: function(){    
			    	try{
			    		aud$loadOpen(); 
			    	}catch(e){}
			    },    
			    success:function(data){ 
			    	try{
			    		aud$loadClose();
			    	}catch(e){}
			    	if(data && data.indexOf("class=\"cfblk\"") != -1){
						new aud$createTopDialog({
				        	title:'外部监督项目',
				            content:data,
				            width:650,
				            height:280
				      	}).open();
			    	}else{
			    		if(isPostForm){
			    			showMessage1("提交成功！");
			    		}else{		    			
			    			showMessage1("保存成功！");
			    		}
				    	setTimeout(function(){			    		
			                var tabWin = aud$parentDialogWin();
			                ///var sureWin = tabWin.$('#externalAudPro').get(0).contentWindow;
				            //sureWin.$('#yearDetailList').datagrid("reload");
	                        tabWin.$('#yearDetailList').datagrid("reload");
			               /* $('#gCloseBtn').trigger('click');			    		*/
				    	},0)   
			    	}
			    	
			    }    
			});
		}

	}
		
		
	// 接受监督检查单位树形选择
	function showAuditObjectTree(obj) {
	    var deptId = $('#audit_dept').val();
	    if (deptId == null || deptId == '') {
	        showMessage1('请先选择牵头监督实施单位(部门)');
	    } else {
	        var winJson = showSysTree(obj, {
	            url:'${contextPath}/mng/audobj/object/getAuditedDeptChildByDeptId.action',
	            title:'接受监督检查单位选择',
	            treeTabTitle1: '接受监督检查单位',
	            cache:false,
	            checkbox:true,
	            //cascadeJunior:true,
	            param: {
	                'departmentId': $.trim(deptId)
	            },
	            onAfterSure: resetJjzrr
	        });
	        // 展开全部节点
	        // setTimeout(function(){
		     //    var winOption = winJson.win.param;
		     //    var jqtree = winOption.jqtree;
		     //    var root = $(jqtree).tree('getRoot');
		     //    if(root){
		     //    	QUtil.expandOrCollapseAllNodes(jqtree, root);
		     //    }
	        // },200);
	    }
	}	
</script>
<style type="text/css">
input[class~=editElement]{
	width:90% !important;
}
</style>
</head>
<body style='padding:0px;margin:0px;overflow:hidden;' class='easyui-layout' border='0' fit='true'>
<%--	<div region='north' border='0' style='padding:0px;overflow:hidden;'>--%>
    <div region='center' border='0'>
		<div class="easyui-tabs" fit="true" id="externalTabs" border='0'>
			<div title="基本信息">
				<div style="width: 100%;position:absolute;padding-top:0px;text-align: right;z-index: 1000;" class="EditHead">
					<div id='btnBar' style='text-align:right;padding-right:15px;margin-bottom:5px;width:100%;'>
						<a id='gSaveBtn'  class="easyui-linkbutton editElement" iconCls="icon-save" style='margin-right:10px;margin-top: 2px;'>保存</a>
						<%--<a id='gPostBtn'  class="easyui-linkbutton editElement" iconCls="icon-ok" style='border-width:0px;'>提交</a>		--%>
						<%--<a id='gCloseBtn' class="easyui-linkbutton" iconCls="icon-cancel" style='border-width:0px;'>关闭</a>--%>
					</div>
				</div>
				<s:form id="planForm" name="planForm" action="submit" namespace="/plan/detail" cssStyle='margin:0px;padding:0px;padding-top: 30px'>
				<table id="planTable" name="planTable"  class="ListTable" align="center" style='width:100%;table-layout:fixed;margin:0px;'>
				<input type='hidden' id="w_plan_code" name="crudObject.w_plan_code" value="${crudObject.w_plan_code}"/>
				<s:hidden name="crudObject.status" />
				<s:hidden name="crudObject.status_name" />
				<s:hidden name="crudObject.proSource" value="external"/>
				<%--<tr>--%>
					<%--<td class="EditHead" style='width:15%;'>计划状态</td>--%>
					<%--<td class="editTd" style='width:35%;'>--%>
							<%--<s:if test="'${crudObject.byYearShenPi}'=='1' && '${crudObject.status_name }'=='计划草稿'">--%>
								<%--年度已审批--%>
							<%--</s:if>--%>
							<%--<s:else>--%>
								<%--<span>${crudObject.status_name}</span>--%>
							<%--</s:else>--%>
							<%--<s:hidden name="crudObject.status" />--%>
							<%--<s:hidden name="crudObject.status_name" />--%>
					<%--</td>--%>
					<%--<td class="EditHead" style='width:15%;'>计划编号</td>--%>
					<%--<td class="editTd" style='width:35%;'>--%>
						<%--<span>${crudObject.w_plan_code}</span>--%>
						<%--<s:hidden name="crudObject.w_plan_code" id="w_plan_code"></s:hidden>--%>
					<%--</td>--%>
				<%--</tr>--%>
				<tr>
					<td class="EditHead" style='width:15%;'><font color=red>*</font>监督项目名称</td>
					<td class="editTd" style='width:35%;'>
						<s:textfield name="crudObject.w_plan_name"  id="w_plan_name" cssClass="noborder editElement clear required"
									 readonly="!(varMap['w_plan_nameWrite']==null?true:varMap['w_plan_nameWrite'])"
									 title="监督项目名称"   maxlength="255"/>
						<input type="hidden" id="crudObject.w_plan_name.length" value="100" class="editElement"/>
						<span class="viewElement">${crudObject.w_plan_name}</span>

					</td>
					<td class="EditHead" style='width:15%;'><font color=red>*</font>项目年度</td>
					<td class="editTd" style='width:35%;'>
						<s:if test="${option=='add'||option=='addyuxuan'}">
						<s:if test="${fromAdjust == 'yes'}">
							<span>${crudObject.w_plan_year}</span>
							<s:hidden name="crudObject.w_plan_year" />
						</s:if>
						<s:else>
							<select class="easyui-combobox  clear editElement required" name="crudObject.w_plan_year" style="width:150px;"  data-options="panelHeight:'auto',editable:false" title="项目年度">
						       <option value="">&nbsp;</option>
						       <s:iterator value="@ais.framework.util.DateUtil@getIncrementYearList(10,9)" id="entry">
						       		<s:if test="${crudObject.w_plan_year==entry}">
						       			<option selected="selected" value="${entry }">${entry }</option>
						       		</s:if>
						       		<s:else>
						       			<option value="${entry }">${entry }</option>
						       		</s:else>
						       </s:iterator>
						    </select> 	
						</s:else>
							
						</s:if>
						<s:else>
							<span>${crudObject.w_plan_year}</span>
							<s:hidden name="crudObject.w_plan_year" />
						</s:else>
					</td>
				</tr>
				<tr>
					<td class="EditHead" ><font color=red>*</font>监督类型</td>
					<td class="editTd" >
                        <s:if test="${view == false}">
				        <input type='text' id='pro_type_child_name' name='crudObject.pro_type_child_namee'
				        	value="${crudObject.pro_type_child_name}"  class="noborder editElement clear " readonly/>
				        <input type="hidden" id="pro_type_child" name="crudObject.pro_type_child"
				        	value="${crudObject.pro_type_child}"  class="noborder editElement clear " readonly/>
				        <input type='text' id='pro_type_name' name='crudObject.pro_type_name' title="监督类型"
				        	value="${crudObject.pro_type_name}"  class="noborder editElement clear required" readonly/>
				        <input type='hidden' id='pro_type' name='crudObject.pro_type' title="监督类型"
				        	value="${crudObject.pro_type}"  class="noborder editElement clear" readonly/>
						<img id='proTypeSelect' style="cursor:pointer;border:0" src="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png"/>
                        </s:if>
                        <s:else>
                        <span id='view_pro_type_name' class="noborder viewElement clear" >
							${crudObject.pro_type_child_name}&nbsp;${crudObject.pro_type_name}
						</span>
                        </s:else>
					</td>
					<td class="EditHead" ><font color=red>*</font>外部监督主体名称</td>
					<td class="editTd" >
<%--						<input type='text' id='crudObject_externalMainName' name='crudObject.externalMainName' --%>
<%--							title='外部监督主体名称' value="${crudObject.externalMainName}"  --%>
<%--							class="noborder editElement clear required"/> --%>
<%--						<span class='viewElement'>${crudObject.externalMainName}</span>	--%>
						<s:if test="${view == false}">
							<select id="externalMainName_code" class="easyui-combobox" name="crudObject.externalMainName_code" style="width:150px;" data-options="panelHeight:'auto',editable:false">
								<s:iterator value="basicUtil.externalMainNameList" id="entry">
									<s:if test="${crudObject.externalMainName_code==code}">
										<option selected="selected" value="<s:property value="code"/>"><s:property value="name"/></option>
									</s:if>
									<s:else>
										<option value="<s:property value="code"/>"><s:property value="name"/></option>
									</s:else>
								</s:iterator>
							</select>
							<s:hidden id="externalMainName" name="crudObject.externalMainName"/>
						</s:if>
						<s:else>
							<span class="noborder viewElement clear" >${crudObject.externalMainName}</span>
						</s:else>
					</td>
				</tr>
				<tr>				
					<td  id="wcxs" class="EditHead" ><font color=red>*</font>监督方式</td>
					<td class="editTd"  colspan="3">
						<s:if test="${view == false}">
							<select id="handle_modus" name="crudObject.handle_modus"
							 class="easyui-combobox clear editElement required" title='监督方式'  style="width:150px;" 
							 	data-options="panelHeight:'auto',editable:false">
								<option value="">&nbsp;</option>
								<s:iterator value="basicUtil.completed_FormList" id="entry">
									<s:if test="${crudObject.handle_modus==code}">
										<option selected="selected" value="<s:property value="code"/>"><s:property value="name"/></option>
									</s:if>
									<s:else>
										<option value="<s:property value="code"/>"><s:property value="name"/></option>
									</s:else>
								</s:iterator>
							</select>
							<input type='hidden' id='handle_modusname' name='crudObject.handle_modusname' 
								value='${crudObject.handle_modusname}'/>
						</s:if>
						<s:else>
							<span id='view_handle_modusname' class="noborder viewElement clear" >${crudObject.handle_modusname}</span>
						</s:else>
					</td>
				</tr>
				<tr>
					<td class="EditHead" >计划管理员</td>
					<td class="editTd" >
					    <%--<input type='text' id='crudObject_w_writer_person_name' name='crudObject.w_writer_person_name' title="计划管理员" value="${crudObject.w_writer_person_name}"
					     class="noborder editElement clear required" readonly/>
					    <input type='hidden' id='crudObject_w_writer_person' name='crudObject.w_writer_person' title="计划管理员Code"  value="${crudObject.w_writer_person}"
					    class="noborder editElemecrudObjectnt clear"/>
						<img style="cursor:pointer;border:0" src="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png"
					        onclick="showSysTree(this,{
					              title:'请选择评价专岗负责人',
					              type:'treeAndUser',
					              defaultDeptId:'${user.fdepid}',
					              defaultUserId:'${user.floginname}',
					              singleSelect:true,
					              param:{
					                'rootParentId':'0',
					                'beanName':'UOrganizationTree',
					                'treeId'  :'fid',
					                'treeText':'fname',
					                'treeParentId':'fpid',
					                'treeOrder':'fcode'
					             }                                  
					    })">--%>
                        <s:if test="${view == false}">
						<s:buttonText2 id="crudObject_w_writer_person_name" hiddenId="crudObject_w_writer_person" cssClass="noborder editElement clear"
						    name="crudObject.w_writer_person_name"
						   	hiddenName="crudObject.w_writer_person"
						   	doubleOnclick="showSysTree(this,
								{ url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action',
									param:{
									 'p_item':1,
									 'orgtype':1
									},
									title:'请选择计划管理员',
									type:'treeAndEmployee',
									singleSelect:true
								})"
						   	doubleSrc="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png"
						   	doubleCssStyle="cursor:pointer;border:0"
						   	readonly="true"
						   	maxlength="1500" title="计划管理员"/>
                        </s:if>
                        <s:else>
					    <span id='view_w_writer_person_name' class="viewElement">${crudObject.w_writer_person_name}</span>
                        </s:else>
					</td>
					<td class="EditHead" ><font color=red>*</font>编写时间</td>
					<td class="editTd" >
						<span class='editElement'>
							<input type="text" id="crudObject_w_write_date" name="crudObject.w_write_date" 
								value="${crudObject.w_write_date }" class="easyui-datebox clear required" editable="false" style="width: 150px"/>
						</span>
						<span class='viewElement'>
							<span id='viewWriteDate'>${crudObject.w_write_date}</span>
						</span>
					 </td>
				</tr>
				<tr>
					<td class="EditHead"  id="aditDeptTd" nowrap><font color=red>*</font>牵头监督实施单位(部门)</td>
					<td class="editTd" >
						<s:if test="${(monthFormId!=null||yearFormId!='') && view == false}">
	        				<input type='text' id='audit_dept_name' name='crudObject.audit_dept_name' value="${crudObject.audit_dept_name}" 
	        				title='牵头监督实施单位(部门)' class="noborder editElement clear required" readonly/>
	        				<input type='hidden' id='audit_dept' name='crudObject.audit_dept' value="${crudObject.audit_dept}" 
	        				title='牵头监督实施单位(部门)ID' class="noborder editElement clear" readonly/>
	       					<%--<a  class="easyui-linkbutton  editElement " iconCls="icon-search" style='border-width:0px;' --%>
							<img style="cursor:pointer;border:0" src="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png"
	       						onclick="showSysTree(this,{
	                                title:'牵头监督实施单位(部门)选择',
									url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action',
	                                defaultDeptId:'${user.fdepid}',
	                            	param:{
										'p_item':'3',
	                               },
								   onAfterSure:function(){
										changSubmit();
									    $('#audit_object').val('');
									    $('#audit_object_name').val('');
								   }								   
	                        })">
							<%--</a>--%>
						</s:if>
						<s:else>
							<span class="viewElement">${crudObject.audit_dept_name}</span>
							<s:hidden name="crudObject.audit_dept_name" />
							<s:hidden id="audit_dept" name="crudObject.audit_dept" />
						</s:else>
					</td>
					<td class="EditHead"   nowrap="nowrap" id="auditObjtTd"><font color=red>*</font>接受监督检查单位</td>
					<td class="editTd"  id="auditObjtContTd">
						<s:if test="${view == false}">
							<s:buttonText2 id="audit_object_name" hiddenId="audit_object" cssClass="noborder editElement clear required"
										   name="crudObject.audit_object_name"
										   hiddenName="crudObject.audit_object"
										   doubleOnclick="showAuditObjectTree(this);"
										   doubleSrc="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png"
										   doubleCssStyle="cursor:pointer;border:0"
										   readonly="true"
										   doubleDisabled="!(varMap['audit_objectWrite']==null?true:varMap['audit_objectWrite'])" title="接受监督检查单位" maxlength="1500"/>
						</s:if>
						<s:else>
							<span>${crudObject.audit_object_name }</span>
						</s:else>
					</td>
				</tr>
				<tr id="riqi">
					<td class="EditHead"  id="pro_starttimeTd">项目开始日期</td>
					<td class="editTd" >
						<span class='editElement'>	
							<input type="text" id="pro_starttime" name="crudObject.pro_starttime" value="${crudObject.pro_starttime }"
								class="easyui-datebox" editable="false" style="width: 150px" title='项目开始日期'/>	
						</span>
						<span id='view_pro_starttime' class="viewElement">${crudObject.pro_starttime}</span>
					</td>
					<td class="EditHead"  id="pro_endtimeTd">项目结束日期</td>
					<td class="editTd" >
						<span class='editElement'>	
							<input type="text"  id="pro_endtime" name="crudObject.pro_endtime" class="easyui-datebox  clear"
								style="width: 150px" value="${crudObject.pro_endtime}" editable="false"
								compareval="gte&pro_starttime" title='项目结束日期'/>
						</span>	
						<span id='view_pro_endtime' class="viewElement">${crudObject.pro_endtime}</span>
					</td>
				</tr>
				<tr>
					<td class="EditHead" ><font color='red'>*</font>主要内容<br/><div style="text-align:right"><font color=DarkGray>(限1000字)</font></div></td>
					<td class="editTd"  colspan="3">
						<textarea  title="主要内容" id="mainContent" name="crudObject.mainContent"
						 class="noborder editElement clear required len1000"
						style='border-width:0px;height:60px;width:99%;overflow:hidden;padding:5px;'>${crudObject.mainContent}</textarea>
					
						<textarea readonly
						 class="noborder viewElement clear len1000" 
						style='border-width:0px;height:60px;width:99%;overflow:hidden;padding:5px;'>${crudObject.mainContent}</textarea>
					</td>
				</tr>
					<tr>
						<!-- fileUpload 组件文件上传 -->
						<td class="EditHead" nowrap>
							<div style='float:right;'>附件</div>
						</td>
						<td class="editTd" colspan="3" >
							<div id="edit_attachFile" class="editElement"></div>
							<div id="view_attachFile" class="viewElement"></div>
						</td>
					</tr>
			</table>
			
			<s:token/>		
			<s:hidden name="crudObject.byYearShenPi"></s:hidden>
			<s:hidden name="crudObject.fid" />
			<s:hidden name="crudObject.unlineProHistory" value="1"/>
			<s:hidden name="crudObject.formId" />
			<%--<s:hidden id="yearPlanId" name="crudObject.year_id" />--%>
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
  	  		
  	  		<s:hidden name="crudObject.w_file" id="crudObject_w_file"/>
  	  		<s:hidden name="crudId" id="crudId"/>
		</s:form>
			</div>
			<s:if test="${param.showProblem eq 'true'}">
				<div title="问题列表" style="overflow: hidden;">
					<iframe id="problemList" src="${contextPath}/projectPlan/showProPgrsProblemList.action?view=${param.view}&projectId=${param.projectId}" width="100%" height="100%" marginheight="0" marginwidth="0" frameborder="0" scrolling="hidden"></iframe>
				</div>
			</s:if>
		</div>
	</div>

<%--	<div region="south" style="overflow:hidden;" border='0' title="">--%>
<%--	     <div id="edit_attachFile" class="editElement"></div>--%>
<%--	     <div id="view_attachFile" class="viewElement"></div>--%>
<%--	</div>--%>
</body>
</html>
