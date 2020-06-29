<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
<base target="_self">
<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<title>项目档案借阅流程</title>
	<style>
		textarea {
			border: 1px double #7F9DB9;
		}
	</style>
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/autosize.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ufaudTextLengthValidator.js"></script>
		<script type="text/javascript">
		$(function(){
			showWin('fileSQ','项目档案授权');
		});	
		$(document).ready(function(){
			$('#borrow_reason').attr('maxlength',300);
			$("#myform").find("textarea").each(function(){
				autoTextarea(this);
			});
		
		});	
		/*
		 * 进入项目档案授权页面
		 */
		function powerInit(){
			var project_id =  '<s:property value="crudObject.project_id" />'; //档案的详细信息
			var borrowFormId = '<s:property value="crudId" />';//借阅表单的详细信息
			//var archives_id = '<s:property value="pigeonholeObject.formId" />';//档案内容表中记录的archives_id
			var archive_name='${crudObject.archive_name}';
			var num=Math.random();
		    var rnm=Math.round(num*9000000000+1000000000);//随机参数清除模态窗口缓存
			var url = "${contextPath}/archives/workprogram/pigeonhole/powerArchivesList.action?project_id="+project_id
									+"&borrowFormId="+borrowFormId
									//+"&archives_id="+archives_id
									+"&archive_name=" + encodeURI(encodeURI(archive_name))
									+"&rnm="+rnm;
			 showWinIf('fileSQ',url,'项目档案授权');
		}
		
	
		/*
		 * 执行保存表单的操作,同时添加输入框的表单校验
		 */ 		
		function saveForm(){
			var url = "${contextPath}/archives/borrow/save.action";//设置url
			myform.action = url;
		    myform.submit();
		}
		/*
		 * 启动前校验
		 */
		function beforStartProcess(){
			if(!checkForm())
				return false;
				
			return true;
		}
	
		/*
		 *提交表单时校验表单数据
		 */
		function checkForm(){
			var startTime = document.getElementsByName("crudObject.start_borrow_time")[0].value;
			var endTime   = document.getElementsByName("crudObject.end_borrow_time")[0].value;
			
			var project_id =  '<s:property value="crudObject.project_id" />'; //项目的id
			var inBorrowMen=document.getElementsByName("crudObject.in_borrow_man")[0].value;//内部借阅人
			var borrow_reason = document.getElementsByName("crudObject.borrow_reason")[0].value; //借阅理由
			
			//字段校验信息
			var startTimeRequired = "<s:property value="varMap['start_borrow_timeRequired']"  />";  
			var endTimeRequired = "<s:property value="varMap['end_borrow_timeRequired']"  />"; 
			var in_borrow_manRequired = "<s:property value="varMap['in_borrow_manRequired']"  />"; 
			var in_borrow_manWrite = "<s:property value="varMap['in_borrow_manWrite']"  />"; 
			var borrow_reasonRequired = "<s:property value="varMap['borrow_reasonRequired']"  />";
			var powerInitRead = "<s:property value="varMap['powerInitRead']"  />";
			/*校验借阅理由*/
			if(borrow_reasonRequired!=null && borrow_reasonRequired=="true"){
				if(borrow_reason==null || borrow_reason=="" ){
			        showMessage1("请填写档案借阅理由!");
			        return false;
				}
			}
			
			
			/*校验借阅的开始时间*/
			if(startTimeRequired!=null && startTimeRequired=="true"){
				if(startTime.length<=0 ){
			        showMessage1("请选择档案借阅开始时间!");
			        return false;
				}
			}
			/*校验借阅的结束时间（注意！因为实施人员不会配置，这里就写死在这里，我也不想这么做。嘿嘿）*/
			if(endTime.length<=0 ){
		        showMessage1("请选择档案借阅结束时间!");
		        return false;
			}
			
			/*校验借阅的结束时间应该大于开始时间*/
			if(startTime!=null && startTime!=""
			   && endTime!=null && endTime!=""){
			   
		   	    var reg=new RegExp("-","g"); //创建正则RegExp对象
		        var tempBeginTime=(startTime).replace(reg,"\/");
		        var tempEndTime=(endTime).replace(reg,"\/");
		        var today   =   new   Date();    //获得当前时间
		         
		        var date=today.getDate();//格式化拼接获得正确的当前时间
		        month=today.getMonth();
		        month=month+1;
		        if(month<=9)
		        month="0"+month;
		        year = today.getYear() + 1900;
		        var nowDate=year+'-'+month+'-'+date;
		        var tempDate=(nowDate).replace(reg,"\/");
		        
		         if(Date.parse(new Date(tempBeginTime))>Date.parse(new Date(tempEndTime))){
		             showMessage1("借阅的开始时间不能晚于借阅的结束时间!");
		             return false;
		        }else if(Date.parse(new Date(tempDate))>Date.parse(new Date(tempBeginTime))){
		             showMessage1("借阅的开始时间不能早于当前时间!");
		             return false;
		        }
			}
			if(in_borrow_manRequired!=null && in_borrow_manRequired=="true"){
				if(inBorrowMen==null || inBorrowMen=="" ){
					showMessage1("请选择内部借阅人！");
					return false;
				}
			}
		    //判断当前表单的内部用户在当前的借阅时间段是否借阅过档案【没有授权，和已经借阅过两种状态】
		    var flag = true;
		    var setPower = "<s:property value="varMap['powerInitWrite']"  />";  //定义授权状态
		    if(setPower!=null && setPower!="" && setPower=="true"){ //必须添加档案文件授权
		    	var power_status="false"; //设置借阅权限
				DWREngine.setAsync(false);
				DWREngine.setAsync(false);DWRActionUtil.execute(
				{ namespace:'/archives/borrow', action:'isPower', executeResult:'false' }, 
				{'in_borrow_man_name':inBorrowMen.replace(/\s+$|^\s+/g,""),'crudId':'<s:property value="crudId"/>','project_id':project_id.replace(/\s+$|^\s+/g,""),'startTime':startTime,'endTime':endTime},
				xxx);
				function xxx(data){
					power_status = data['power_status'];
					if(power_status=="true"){
						//已经授权
					    document.getElementById("borrowTimes").innerHTML=data['borrowTimes']; 
						flag = true;
					}else{
						//未授权
						showMessage1("档案借阅未授权，请先授权再提交!");
						flag = false;
					}
				}	
			}
		    return flag;
		}
		/*
		* 流程启动
		*/
		
		function doStart(){
			document.getElementById('myform').action = "start.action";
			document.getElementById('myform').submit();
		}
		
		/*
		 *执行保存表单的操作,同时添加输入框的表单校验 
		 */		
		function toSubmit(act){
		  	var bool = checkForm();
		  	if(bool){
				var url = "${contextPath}/archives/borrow/submit.action";//设置url
				<s:if test="isUseBpm=='true'">
	 				if(document.getElementsByName('isAutoAssign')[0].value=='false'){
						var actor_name=document.getElementsByName('formInfo.toActorId_name')[0].value;
						if(actor_name==''){
							showMessage1('下一步处理人不能为空！');
							return false;
						}
					}
				</s:if>
				$.messager.confirm('提示信息','确认提交吗?',function(isSubmit){
					if(isSubmit){
						document.getElementById("borrowTimes").innerHTML='';
		            <s:if test="isUseBpm=='true'">
						myform.action="<s:url action="submit" includeParams="none"/>";
					</s:if>
					<s:else>
						myform.action="<s:url action="directSubmit" includeParams="none"/>";
					</s:else>
	                myform.submit();
					}else{
	             		return false;
	             	}
				});
	        }
	 	}		
	 		
		/*
		 * 获得近期的借阅记录
		 */ 		
		function viewPowerRecord(){
			var in_borrow_man_name=document.getElementsByName("crudObject.in_borrow_man")[0].value;
			var startTime  = document.getElementsByName("crudObject.start_borrow_time")[0].value;
			var endTime    = document.getElementsByName("crudObject.end_borrow_time")[0].value;
			var project_id =  '<s:property value="crudObject.project_id" />'; //项目的id
			var crudId     ='<s:property value="crudId"/>';
			var url = "${contextPath}/archives/borrow/viewPowerRecord.action?in_borrow_man_name="+in_borrow_man_name+"&&startTime="+startTime+"&&endTime="+endTime+"&&project_id="+project_id+"&&crudId="+crudId;
			window.open(url,'','resizable=yes,menubar=no,directories=no,status=no,location=no,toolbar=no,scrollbars=no,width=950,height=575,left=0,top=0');
		}
		                            
		 /*
		  * 选择内部借阅人填写单位
		  */
		function selBorrowMan(){
			//内部借阅人
			var inBorrowMen=document.getElementsByName("crudObject.in_borrow_man")[0].value;
			if(inBorrowMen!=null && inBorrowMen!=''){
				//填写内部借阅人单位
				DWREngine.setAsync(false);
				DWREngine.setAsync(false);DWRActionUtil.execute(
				{ namespace:'/archives/borrow', action:'checkInBorrowUnit', executeResult:'false' }, 
				{'in_borrow_man_name':inBorrowMen.replace(/\s+$|^\s+/g,"")},
				xxx1);
				
				function xxx1(data){
					document.getElementById("crudObject.in_borrow_unit_name").value = data['inBorrowUnitName'];	
					document.getElementById("crudObject.in_borrow_unit").value = data['inBorrowUnit'];	
				}
			}else{
				document.getElementById("crudObject.in_borrow_unit_name").value = '';	
				document.getElementById("crudObject.in_borrow_unit").value = '';
			}
			
		}
		//关闭项目档案授权窗口
		function close_win(){
			$('#fileSQ').window('close');  
		}
	</script>
</head>
<s:if test="taskInstanceId!=null&&taskInstanceId!=''">
	<body onload="end();" style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout" border="0">
</s:if>
<s:else>
	<body  style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout" border="0">
</s:else>
	<div region="center" border="0">
	<s:form action="save" namespace="/archives/borrow" id="myform">
		<!--  <table cellpadding="0" cellspacing="1" border="0" 
			class="ListTable" width="100%" align="center">
			<tr >
				<td colspan="4" class="edithead"
					style="text-align: left; width: 100%;">
					<s:property escape="false"
						value="@ais.framework.util.NavigationUtil@getNavigation('/ais/archives/borrow/archivesOverList.action')" />
					==&gt;
					<a href="javascript:;" onclick="hidden();"> <s:property
							value="projectStartObject.project_name" /> </a>
				</td>
			</tr>
		</table>  -->
		<%@include file="/pages/archives/pigeonhole/view_archivesAll.jsp"%>
		<div style="height:1px;"></div>
		<table cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable" width="100%" >
			<tr>
				<td class="EditHead" nowrap="nowrap">
					<%--<s:if test="varMap['in_borrow_manRequired']">
						<font color="red">*</font>
					</s:if>--%>
					<font color="red">*</font>
					档案内部借阅人
				</td>
				<td class="editTd" colspan="3">
					<s:buttonText2 name="crudObject.in_borrow_man_name"
						hiddenName="crudObject.in_borrow_man" cssClass="noborder"
						doubleOnclick="showSysTree(this,
								{ url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action',
							param:{
							'p_item':1,
							'orgtype':1
							},
							      title:'请选择档案内部借阅人',
							      // 审计人员选择模式
							      type:'treeAndEmployee'
								})"
						doubleSrc="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png"
						doubleCssStyle="cursor:hand;border:0" readonly="true" id="in_borrow_man_name" />
						<%--display="${varMap['in_borrow_manRead']}"
						doubleDisabled="!varMap['in_borrow_manRead']"
						id="in_borrow_man_name" />--%>
					<span id="borrowTimes"></span>
				</td>
				<!-- <td class="EditHead" nowrap="nowrap">
					档案内部借阅人单位
				</td>
				<td class="editTd">
					<s:textfield name="crudObject.in_borrow_unit_name" readonly="true" />
					<s:hidden name="crudObject.in_borrow_unit"/>
				</td> -->
			</tr>
			<tr>
				<td class="EditHead" nowrap="nowrap" style="width:15%;">
					借阅发起人
				</td>
				<td class="editTd" style="width:35%;">
					<s:property value="crudObject.start_borrow_man_name" />
				</td>
				<td class="EditHead" nowrap="nowrap" style="width:15%;">
					借阅发起人单位
				</td>
				<td class="editTd" style="width:35%;">
					<s:property value="crudObject.start_borrow_unit_name" />
				</td>
			</tr>
			<tr>
				<td class="EditHead" nowrap="nowrap">
<%--					<s:if--%>
<%--						test="varMap['start_borrow_timeRequired'] == null ?true:varMap['start_borrow_timeRequired']">--%>
<%--						<font color="red">*</font>&nbsp;--%>
<%--					</s:if>--%>
					<font color="red">*</font>&nbsp;借阅起始时间
				</td>
				<td class="editTd">
					<%-- <s:textfield id="start_borrow_time" cssClass="easyui-datebox noborder"
						name="crudObject.start_borrow_time"
						maxlength="20" title="单击选择日期" 
						disabled="!(varMap['start_borrow_timeWrite']==null?true:varMap['start_borrow_timeWrite'])"
						display="${varMap['start_borrow_timeRead']}"
						theme="ufaud_simple" templateDir="/strutsTemplate"></s:textfield> --%>
					<input value="${crudObject.start_borrow_time }" id="start_borrow_time" name="crudObject.start_borrow_time" type="text" class="easyui-datebox noborder" editable="false"></input>  

				</td>
				<td class="EditHead">
					<font color="red">*</font>&nbsp;借阅结束时间
				</td>
				<td class="editTd">
					<%-- <s:textfield id="end_borrow_time"
						name="crudObject.end_borrow_time"  maxlength="20"
						title="单击选择日期"  cssClass="easyui-datebox noborder"
						disabled="!(varMap['end_borrow_timeWrite']==null?true:varMap['end_borrow_timeWrite'])"
						display="${varMap['end_borrow_timeRead']}" 
						theme="ufaud_simple" templateDir="/strutsTemplate"></s:textfield> --%>
					<input value="${crudObject.end_borrow_time }" id="end_borrow_time" name="crudObject.end_borrow_time" type="text" class="easyui-datebox noborder" editable="false"></input>
				</td>
			</tr>
			<tr>
				<td class="EditHead" >
					<s:if
						test="varMap['borrow_reasonRequired']==null?true:varMap['borrow_reasonRequired']">
						<font color="red">*</font>
					</s:if>
					借阅理由</br>
					<span style="color: DarkGray;">(限300字)</span>
				</td>
				<td class="editTd" colspan="3" >
					<%--<s:textarea name="crudObject.borrow_reason"
						cssStyle="overflow-y:visible;width:100%;"  cssClass="noborder"
						readonly="!(varMap['borrow_reasonWrite']==null?true:varMap['borrow_reasonWrite'])"
						display="${varMap['borrow_reasonRead']}"/>--%>
					<s:textarea cssClass="noborder" name="crudObject.borrow_reason" id="borrow_reason" cssStyle="width:100%;overflow-y:hidden;" title="借阅理由" />
				</td>
			</tr>
		</table>
		<%@include file="/pages/bpm/list_transition.jsp"%>
		<div align="right" style="margin-right: 15px;margin-top: 5px">
			<s:if test="(taskInstanceId!=null && taskInstanceId!='') || isUseBpm == 'false'">
				<s:if test="${varMap['powerInitRead']}">
					<a class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="powerInit()">项目档案授权</a>&nbsp;&nbsp;&nbsp;
				</s:if>
			</s:if>
			<s:else>
				<a class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="powerInit()">项目档案授权</a>&nbsp;&nbsp;&nbsp;
			</s:else>
			<s:if test="(taskInstanceId!=null && taskInstanceId!='')">
				<a class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="saveForm()">保存</a>
				&nbsp;&nbsp;&nbsp;
			</s:if>
			<s:if test="${taskInstanceId!=null&&taskInstanceId>0}">
				<a onclick="this.style.disabled='disabled';window.location.href='${contextPath}/bpm/taskinstance/pending.action?processName=${processName}&project_name=${project_name}&formNameDetail=${formNameDetail}'" class="easyui-linkbutton" data-options="iconCls:'icon-undo'" >返回</a>
			</s:if>
			<s:else>
				<a class="easyui-linkbutton" data-options="iconCls:'icon-undo'"  onclick="window.location.href='${contextPath}/archives/borrow/archivesOverList.action';">返回</a>	
			</s:else>
			<jsp:include flush="true" page="/pages/bpm/list_toBeStart.jsp" />
		</div>
		<div align="center">
			<jsp:include flush="true" page="/pages/bpm/list_taskinstanceinfo.jsp" />
		</div>
		<div id="fileSQ" style="overflow:hidden;padding:0px"></div>
		<s:hidden name="crudObject.project_id" />
		<s:hidden name="project_id" value="${crudObject.project_id}" />
		<s:hidden name="crudObject.project_name" />
		<s:hidden name="crudObject.project_code" />
		<s:hidden name="crudObject.archive_id" />
		<s:hidden name="crudObject.archive_name" />
		<s:hidden name="borrowFormId" value="${crudId}" />
		<s:hidden name="crudObject.formId" />
		<s:hidden name="crudObject.plan_code" value="${projectStartObject.plan_code}" />
		<s:hidden name="module" />
		<s:hidden name="crudObject.start_borrow_man" />
		<s:hidden name="crudObject.start_borrow_man_name" />
		<s:hidden name="crudObject.start_borrow_unit" />
		<s:hidden name="crudObject.start_borrow_unit_name" />
		<s:hidden name="crudObject.borrow_status" />
		<s:hidden name="crudObject.operateSystemType" />
		<s:hidden name="processName" />
  	  	<s:hidden name="project_name" />
  	  	<s:hidden name="formNameDetail" />
	</s:form>
	</div>
</body>
</html>
