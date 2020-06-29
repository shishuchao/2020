<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML>
<html>
<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<title>项目档案归档流程</title>
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>  
	<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/jquery-fileUpload.js"></script>
	<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
	<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
	<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
	<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
	<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/common.js"></script>
</head>
	<s:if test="taskInstanceId!=null&&taskInstanceId!=''">
		<body onload="end();">
	</s:if>
	<s:else>
		<body >
	</s:else>
	<!-- <div style="margin-bottom: 50px;"> -->
<div class="easyui-layout" fit="true" id="layout">
    <s:form action="save" namespace="/archives/pigeonhole" id="myform" name="myform" method="post">
    
          	<div style="width: 60%;position:absolute;top:0px;right:10px;text-align: right;z-index: 1000;">
			    <s:if test="taskInstanceId!='-1' && isUseBpm == 'true'">	
                      <a class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="return saveForm()">保 存</a>
                </s:if>
                <s:if  test="isUseBpm == 'false'">	
                     <a class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="return saveForm()">保 存</a>
                </s:if>
                     <jsp:include flush="true" page="/pages/bpm/list_toBeStart.jsp" />&nbsp;&nbsp;
                     <a class="easyui-linkbutton" data-options="iconCls:'icon-undo'" onclick="backURLFun();">返回</a>
			</div>
			
<div region="center">
    <div class="easyui-tabs" fit="true" id="yearTabs" border='0'>
        <div title="基本信息">
         

            <s:if test="isUseTableName!='noUse'">
                <table cellpadding="0" cellspacing="1" border="0" class="ListTable" width="100%" align="center">
                    <tr>
                        <td colspan="4" class="EditHead" style="text-align: left; width: 90%;"><%-- <s:property value="crudObject.project_name" /> --%>
                            <!--  </a> -->
                        </td>
                        <td class="EditHead" style="text-align: right; width: 10%; border-left: 0px" nowrap="nowrap">	<a href="javascript:void(0);" onclick="triggerProjectInfoDiv();" title="项目信息">
								展开项目信息 </a>
                        </td>
                    </tr>
                </table>
            </s:if><s:token/>
            <div id="proInfoDiv" style="display: none;">
                <%@include file="/pages/project/start/edit_start_include_readonly.jsp" %>
            </div>
            <table cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
                <tr>
                    <td align="left" class="EditHead" style="width:20%;">项目名称</td>
                    <td class="editTd" align="right" style="width:30%;"><s:property value="crudObject.archives_name" /><s:hidden name="crudObject.archives_name" />
                    </td>
                    <td align="left" class="EditHead" style="width:20%;">档案号</td>
                    <td class="editTd" align="right" style="width:30%;"><s:textfield name="crudObject.archives_code" id="crudObject_archives_code" maxlength="100" readonly="true" cssClass="noborder" display="${varMap['archives_codeRead']}" />
                    </td>
                </tr>
                <tr>
                    <td align="left" class="EditHead">档案类型</td>
                    <td class="editTd" align="right"><s:property value="crudObject.archives_type_name" /><s:hidden name="crudObject.archives_type_name" /><s:hidden name="crudObject.archives_type" />
                    </td>
                    <td align="left" class="EditHead">档案状态</td>
                    <td class="editTd" align="right"><s:property value="crudObject.archives_status_name" /><s:hidden name="crudObject.archives_status_name" />
                    </td>
                </tr>
                <tr>
                    <td align="left" class="EditHead">所属年度</td>
                    <td class="editTd" align="right">
                        <!--<s:property value="crudObject.archives_year" />
						<s:hidden name="crudObject.archives_year"/>--><s:property value="crudObject.audit_start_time" />
                        <s:if test="crudObject.audit_start_time != null && crudObject.audit_end_time != null">&nbsp;至&nbsp;</s:if><s:property value="crudObject.audit_end_time" /><s:hidden name="crudObject.audit_end_time" /><s:hidden name="crudObject.audit_start_time" />
                    </td>
                    <td align="left" class="EditHead">
                        <%-- <s:if test="varMap['basic_save_yearRequired']">	<font color=red>*</font>
                            </s:if>保管期限 --%></td>
                    <td class="editTd" align="right">
                        <%-- <s:if test="varMap['basic_save_yearWrite']==null || crudObject.basic_save_year==null || crudObject.basic_save_year==''"><s:select name="crudObject.basic_save_year" id="basic_save_year" cssClass="easyui-combobox" list="basicUtil.archivesSaveYearList" listKey="code" listValue="name" disabled="!(varMap['basic_save_yearWrite']==null?true:(varMap['basic_save_yearWrite']))"
                            display="${varMap['basic_save_yearRead']}" /></s:if>
                            <s:else><s:property value="crudObject.basic_save_year_name" /><s:hidden name="crudObject.basic_save_year" /><s:hidden name="crudObject.basic_save_year_name" /></s:else>--%>
                            <!--基础数据选择 档案保存期限-->
                    </td>
                </tr>
                <tr>
                    <td align="left" class="EditHead">工作组负责人</td>
                    <td class="editTd"><s:property value="crudObject.principal" /><s:hidden name="crudObject.principal" />
                    </td>
                    <td align="left" class="EditHead">立档单位</td>
                    <td class="editTd" align="right"><s:buttonText2 cssClass="noborder" id="crudObject.archives_unit_name" readonly="true" name="crudObject.archives_unit_name" hiddenName="crudObject.archives_unit" hiddenId="crudObject.audit_dept" doubleOnclick="showSysTree(this,
										{ url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action?p_item=1&orgtype=1',
										  title:'请选择审计单位'
										})" doubleSrc="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png" doubleCssStyle="cursor:pointer;border:0" maxlength="50" />
                    </td>
                </tr>
                <tr>
                    <td align="left" class="EditHead">归档人</td>
                    <td class="editTd" align="right"><s:property value="crudObject.archives_start_man_name" /><s:hidden value="crudObject.archives_start_man_name" /><s:hidden name="crudObject.archives_start_man" />
                    </td>
                    <td align="left" class="EditHead">归档时间</td>
                    <td class="editTd" align="left"><s:property value="crudObject.archives_time" /><s:hidden name="crudObject.archives_time" />
                    </td>
                </tr>
                <tr>
                    <td align="left" class="EditHead">项目时间</td>
                    <td class="editTd" align="right"><s:property value="crudObject.start_time" />
                        <s:if test="crudObject.start_time != null && crudObject.end_time != null">&nbsp;至&nbsp;</s:if><s:property value="crudObject.end_time" /><s:hidden name="crudObject.end_time" /><s:hidden name="crudObject.start_time" />
                    </td>
                    <td align="left" class="EditHead">被审计单位</td>
                    <td class="editTd"><s:property value="crudObject.audit_object_name" /><s:hidden name="crudObject.audit_object_or_jjzrrname" />
                    </td>
                </tr>
                <tr>
                    <td align="left" class="EditHead">备注说明
                        <div><font color=DarkGray>(限1000字)</font>
                        </div>
                    </td>
                    <td class="editTd" colspan="3"><s:textarea id="archivers_comment" name="crudObject.archivers_comment" cssStyle="width:98%" cssClass="noborder" rows="10" onchange="doWhithOne(this)" />
                        <input type="hidden" id="crudObject.archivers_comment.maxlength" value="1000" />
                        <s:hidden name="crudObject.archives_secrecy"></s:hidden>
                    </td>
                </tr>
            </table>

            <div region="south" style="height: 200px;">
                <div align="center">
                    <jsp:include flush="false" page="/pages/bpm/list_transition.jsp" />
                    <jsp:include flush="true" page="/pages/bpm/list_taskinstanceinfo.jsp" />
                </div>
            </div>
            <!-- 隐藏字段 -->
            <s:hidden name="crudObject.project_id" />
            <s:hidden name="crudObject.project_code" />
            <s:hidden name="crudObject.project_name" />
            <s:hidden name="crudObject.plan_code" />
            <s:hidden name="crudObject.plan_id" />
            <s:hidden name="project_id" value="${projectStartObject.formId}"
            /><s:hidden name="crudObject.formId" />
            <s:hidden name="crudObject.archives_status" />
            <s:hidden name="isUseTableName" />
            <s:hidden name="crudObject.operateSystemType" />
            <s:hidden name="crudObject.pro_type" />
            <s:hidden name="crudObject.pro_type_name"
            /><s:hidden name="crudObject.audit_object" />
            <s:hidden name="crudObject.audit_object_name" />
            <s:hidden name="backURL"></s:hidden>
            <!-- </div>  -->
        </div>
        <div title="审计文书" style="overflow: hidden;">
            <iframe id="editFile" width="100%" height="100%" marginheight="0" marginwidth="0" frameborder="0" scrolling="hidden"></iframe>
        </div>
        <div title="审计问题" style="overflow: hidden;">
            <iframe id="problemId"  width="100%" height="100%" marginheight="0" marginwidth="0" frameborder="0" scrolling="hidden"></iframe>
         </div>
          <div title="项目台帐" style="overflow: hidden;">
            <iframe id="customledgerId"  width="100%" height="100%" marginheight="0" marginwidth="0" frameborder="0" scrolling="hidden"></iframe>
         </div>
</div>
</s:form>
</div>

	</body>
	<script type="text/javascript">
	/*
	 * 查看档案文件
	 */
	function fnOpenModal(project_id,archive_name){ 
		var num=Math.random();
		var rnm=Math.round(num*9000000000+1000000000);//随机参数清除模态窗口缓存
		var url = "${contextPath}/archives/workprogram/pigeonhole/editArchivesFile.action?project_id="+project_id 
					+ "&archive_name=" + encodeURI(encodeURI(archive_name));
		//window.showModalDialog(url,window,"dialogWidth=950px;dialogHeight=600px") ;//"打开了一个新模态窗口" 
		window.location = url;
		/* $('#viewInfo').attr("src",url);
		$('#viewFileInfo').window('open'); */
		
	}
	function doWhithOne(src){
		var tmp=src.value.length;
		if(tmp>1000){
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
	$(function(){
		$('#viewFileInfo').window({
			width:1000, 
			height:400,  
			modal:true,
			collapsible:false,
			maximizable:true,
			minimizable:false,
			closed:true
		});

		$('#yearTabs').tabs({
            onSelect:function(title){
                if(title == '审计文书') {
                	var editFileSrc = document.getElementById("editFile").src;
                	if ( editFileSrc ==  null || editFileSrc ==""){
                		   var url = "<%=request.getContextPath()%>/archives/workprogram/pigeonhole/editArchivesFile.action?editFile=edit&project_id=${project_id}";
                           $('#editFile').attr('src', url);
                	}
                } else if(title == '审计问题') {
                	var problemIdSrc = document.getElementById("problemId").src;
                	if ( problemIdSrc ==  null || problemIdSrc ==""){
                        var url = "<%=request.getContextPath()%>/proledger/problem/decideLedgerProblemMain.action?sourceSite=syEdit&editFile=edit&view=process&project_id=${project_id}";
                        $('#problemId').attr('src', url);
                	}
                   
                }else if(title == '项目台帐') {
                	var customledgerIdSrc = document.getElementById("customledgerId").src;
                	if ( customledgerIdSrc ==  null || customledgerIdSrc ==""){
            			var url = "<%=request.getContextPath()%>/proledger/custom/createLedgerTabs.action?sourceSite=syEdit&permission=full&view=process&project_id=${project_id}";
                        $('#customledgerId').attr('src', url);
                	}
                   
                }
            }
        })
	});
	
	
	if('${sucFlag}' == '1') {
		showMessage1('保存成功');
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
	function doStart(){
		document.getElementById('myform').action = "start.action";
		document.getElementById('myform').submit();
	}

	/*
	 *非空校验
	 */
	function isNull(){
		var archives_name = document.getElementsByName('crudObject.archives_name')[0].value;//档案名称
		var archives_code = document.getElementsByName('crudObject.archives_code')[0].value;//档案编号
		var archives_nameRequired = "<s:property value="varMap['archives_nameRequired']"  />";  //varMap['archives_nameRequired']
		var archives_codeRequired = "<s:property value="varMap['archives_codeRequired']"  />";//获得档案编号必填属性
		var archives_nameWrite = "<s:property value="varMap['archives_nameWrite']"  />";//可写
		var archives_codeWrite = "<s:property value="varMap['archives_codeWrite']"  />";//可写
		var project_id = document.getElementsByName('crudObject.project_id')[0].value;
		var buttonRemark = "true";
		
		/* if(archives_code==null || archives_code==""){
			alert("档案编号不能为空!");
			return false;
		} */
		
		//档案名称必填校验
		/* if(archives_nameRequired =="true" && (archives_name == null || archives_name =="")){
			alert("请填写档案名称!");
			document.getElementsByName('crudObject.archives_name')[0].focus();
			return false;
		}
		 */
		//DWR校验档案名称不重复
		/* if((archives_nameWrite=="true" || archives_nameRequired =="true")
		          && (archives_name != null || archives_name !="")){
			DWREngine.setAsync(false);
			DWREngine.setAsync(false);DWRActionUtil.execute(
					{ namespace:'/archives/pigeonhole', action:'archivesNameIsOnly', executeResult:'false' }, 
					{'archivesName':archives_name,'project_id':project_id},
					xxx);
					function xxx(data){
					 buttonRemark = data['buttonRemark'];
					}
					if(buttonRemark == "false"){
					alert("档案名称重复，请重新命名!");
					document.getElementsByName('crudObject.archives_name')[0].focus();
					return false;
					}
		} */
		
		//档案编号必填校验
	/* 	if(archives_codeRequired =="true" && (archives_code == null || archives_code =="")){
			alert("请填写档案编号!");
			document.getElementsByName('crudObject.archives_code')[0].focus();
			return false;
		} */
		
		//DWR校验档案编号不重复
/* 		if((archives_codeWrite=="true" || archives_codeRequired =="true")
		          && (archives_code != null || archives_code !="")){
			buttonRemark = "true";
			DWREngine.setAsync(false);
			DWREngine.setAsync(false);DWRActionUtil.execute(
					{ namespace:'/archives/pigeonhole', action:'archivesCodeIsOnly', executeResult:'false' }, 
					{'archivesCode':archives_code,'project_id':project_id},
					xxx);
					function xxx(data){
					 	buttonRemark = data['buttonRemark'];
					}
					if(buttonRemark == "false"){
						// alert("档案编号重复，请重新填写档案编号!");
						// document.getElementsByName('crudObject.archives_code')[0].focus();
						$.messager.confirm('提示信息', '档案编号重复，是否重新生成？', function(r){
							if(r){
								updateArchivesCode();
							}
						});
						return false;
					}
		}
 */
		if ($("#archivers_comment").val().length > 1000) {
			showMessage1('备注说明限1000字');
			return false;
		}

		return true;
	}

	function updateArchivesCode(){
		var project_id = document.getElementsByName('crudObject.project_id')[0].value;
		$.ajax({
			type: "GET",
			url: '<%=request.getContextPath()%>/archives/workprogram/pigeonhole/getNewArchivesCode.action?project_id='+project_id,
			cache: false,
			dataType: "text",
			success: function(data){
				var newCode = data;
				if(newCode != null && newCode != ''){
					$("#crudObject_archives_code").val(newCode);
				}
			}
		});
	}

	/*
	 *保存流程表单
	 */
	function saveForm(){
		var bool  = isNull();//非空校验
		if(bool){
			myform.action="<s:url action="saveFile" includeParams="none"/>";
			myform.submit();
		}
			
	}
	
	/* 
	 *表单提交校验
	 */
	function isCloseTaizhangJ(){//台账是否关闭
	    var flag = false;
		var project_id = document.getElementsByName('crudObject.project_id')[0].value;
		DWREngine.setAsync(false);
		DWREngine.setAsync(false);DWRActionUtil.execute(
				{ namespace:'/archives/pigeonhole', action:'isCloseTaizhang', executeResult:'false' }, 
				{'project_id':project_id},
				xxx);
		function xxx(data){
		 	isClose = data['isClose'];
		 	if(isClose=='true'){
		 		flag = true;
		 	}
		}
		return flag;	
	}
	function toSubmit(act){
		 //var isCloseTaizhang = isCloseTaizhangJ();
		 var myform = document.getElementById('myform');
		  var  bool  = isNull();//非空校验
		  if(bool){
			   var taizhang = '<s:property value="@ais.project.ProjectSysParamUtil@isXMTZEnabled()" />';
			   var zhenggai = '<s:property value="@ais.project.ProjectSysParamUtil@isReworkStageEnabled()" />';
			   <s:if test="isUseBpm=='true'">
				   //有jbpm流程的才添加
				   if(document.getElementsByName('isAutoAssign')[0].value=='false'){
						var actor_name=document.getElementsByName('formInfo.toActorId_name')[0].value;
						if(actor_name==''){
							showMessage1('下一步处理人不能为空！');
							return false;
						}
					}
			/* 	  <s:if test="taskInstanceId!=null&&taskInstanceId!=''">
						if(taizhang && !isCloseTaizhang && !zhenggai){//校验台账是否完成,无整改阶段校验191127
							alert("台账未完成请完成台账后继续归档！");
							return;
						}
				  </s:if> */
			  </s:if>
			  <s:else>
			  	/* 	if(taizhang && !isCloseTaizhang && !zhenggai){//校验台账是否完成,无整改阶段校验191127
			  			alert("台账未提交请完成台账后继续归档！");
			  			return;
					} */
			  </s:else>
				   if (!archivesPigeonholeEdit("${project_id}")){
						  return false;
					  }
					  
					  var titleMsg= "";
					  var flag = checkMidprNum('${project_id}');
					  if ( flag == '1'){
						  titleMsg= "还没有录任何审计问题，";
					  }else if( flag == '2'){
							showMessage1('违规违纪金额不能为空！');
				  			return false;
					  }
					  
						 top.$.messager.confirm("提示信息",titleMsg+'确认提交归档吗？提交归档后不可再上传文书（或录入问题）',function(r){
								if(r){
								    <s:if test="isUseBpm=='true'">
									myform.action="<s:url action="submit" includeParams="none"/>";
								</s:if>
								<s:else>
									myform.action="<s:url action="directSubmit" includeParams="none"/>";
								</s:else>			
					            myform.submit();
								}
						 });
		  }
	}
	
	/*
	 * 处理
	 */
	function archivesPigeonholeEdit(project_id){
		var flag = "";
		jQuery.ajax({
			url:"${contextPath}/archives/workprogram/pigeonhole/checkArchivesFile.action",
			type:"post",
			data:{"project_id":project_id,"archives_name":'${pigeonholeObject.project_name}'},
			async:false,
			success:function(data){
				flag = data;
			}
			
		});
		if(flag == "1"){
			showMessage1('请将审计文书的必做节点完成后再提交！');
			return false;
		}	
		return true;
	}
	
	function checkMidprNum(project_id){
		var flag = "";
		jQuery.ajax({
			url:"${contextPath}/proledger/problem/getMiddleLedgerProblemNum.action?project_id="+project_id,
			type:"post",
			async:false,
			success:function(data){
				flag = data;
			}
			
		});
		/* if(flag == "0"){
			return false;
		}	 */
		return flag;
	}
	/*
	 * 返回
	 */
	function backURLFun(){
		if ("${taskInstanceId}" > 0 ){
			window.location.href='${contextPath}/archives/pigeonhole/listTobeStarted.action?projectId=${project_id}&isUseTableName=${isUseTableName}&view=${view}';

		}else{
			window.location.href="${contextPath}/archives/pigeonhole/archivesDataFileList.action";
		}
	}
	</script>
</html>
