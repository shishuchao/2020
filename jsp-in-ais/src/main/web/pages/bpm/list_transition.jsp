<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<s:if test="taskInstanceId!=null&&taskInstanceId!=''&&taskInstanceId!=-1">
	<table  cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable" style="width:98%">
		<tr >
			<td  class="EditHead" colspan="2">
				<font style="float: left;">处理信息</font>
			</td>
		</tr>
		<tr>
			<td class="EditHead">
				处理意见
				<br/><font color="DarkGray" style="text-align:right;">(限500字)</font>
			</td>
			<td class="editTd">
			<%-- 	<s:select list="basicUtil.approveOpinion" listKey="name" name="taskInstanceInfo.commentId" listValue="name" id="commentSelect" cssStyle="width:200px;" ></s:select>（预置处理意见） --%>
					<s:textarea id="comments" name="taskInstanceInfo.comments" onkeyup="doWhith(this)"
					cssStyle="height:35px;width:100%;overflow-y:visible;line-height:150%;"/>
			</td>
		</tr>
		<tr>
			<td class="EditHead">
				催办时间
			</td>
			<td class="editTd">
				<s:radio name="times"  value="taskInstanceInfo.reminderstime"
					list="#@java.util.LinkedHashMap@{'6':'6小时','12':'12小时','24':'24小时','36':'36小时','48':'48小时','60':'60小时'}"></s:radio>
			</td>
		</tr>
		<tr >
			<td class="EditHead">
				处理环节
			</td>
			<td class="editTd" >
				<select id="toNodeIds"  name="formInfo.toNodeId" style="width:200px;" data-options="panelHeight:'auto'" editable="false">
					<s:iterator value="trans">
						<option value="<s:property value="to"/>"><s:property value="name"/></option>
					</s:iterator>
				</select>
				<s:iterator value="trans" status="st" id="tr">
					<s:if test="${st.index eq 0}"><s:hidden id="firstNode" value="${tr.name}"/></s:if>
				</s:iterator>
			</td>
		</tr>
		<tr>
			<td class="EditHead">
				处理人员
			</td>
			<td class="editTd">
				<div id="transitionDiv">
					<s:buttonText id="toActorId" hiddenId="toActorId_name"   cssClass="noborder"
						name="formInfo.toActorId_name" cssStyle="width:30%"
						hiddenName="formInfo.toActorId"
						doubleOnclick="showSysTree(this,{
							  url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action',
							  param:{
							  	'beanName':'UOrganizationTree'
							  },
							  singleSelect:true,
							  title:'请选择下一步处理人',
							  type:'treeAndUser'
						   })"
						doubleSrc='/ais/easyui/1.4/themes/icons/search.png'
						doubleCssStyle="cursor:pointer;border:0" readonly="true"
						display="true" doubleDisabled="false" />
				</div>
			</td>
		</tr>
	</table>
<script language="javascript">
	var isAutoAssign="";
	var returnStepPerson="";
	//是否自动分配任务的函数
	function isActorDisplay(){
		if($('#toNodeIds').length > 0){
			var optionValue=$('#toNodeIds').combobox('getValue');
			var externalString="";
			//针对于档案借阅流程，获得档案所属单位id，为的是下一步处理人应该是档案所属单位的人。任务分配策略是选的按角色模板。lihao add 2009-12-03
			var _obj = document.getElementsByName("pigeonholeObject.archives_unit");
			if(_obj){
				if(_obj.length){
					externalString = _obj[0].value;
				}
			}
			//针对于绩效考核的部门考核。获得考核部门的ID。为的是下一步处理人应该是被考核单位的人。任务分配策略是选的按角色模板。lihao add 2009-12-04
			var _objkh = document.getElementsByName("crudObject.orgId");
			if(_objkh){
				if(_objkh.length){
					externalString = _objkh[0].value;
				}
			}
			DWREngine.setAsync(false);
			DWREngine.setAsync(false);DWRActionUtil.execute(
			{ namespace:'/plan', action:'getAutoAssignedTask', executeResult:'false' },
			{'taskInstanceId':'<s:property value="taskInstanceId"/>', 'definition_id':'<s:property value="formInfo.processId"/>',
			'group_id':'<s:property value="formInfo.group_id"/>','externalString':externalString,'formInfo.toNodeId':optionValue,'crudId':'${crudId}','formClassName':'<%=request.getAttribute("crudObject").getClass()
									.getName()%>'},
			xxx);
			function xxx(data){
				isAutoAssign = data['autoAssignment'];
			}
		}
	}

	//如果是回退，获取上一步处理人
	function returnStep(selectValue){
		DWREngine.setAsync(false);
		DWREngine.setAsync(false);
		DWRActionUtil.execute(
		{ namespace:'/plan', action:'getReturnPersons', executeResult:'false' }, 
		{'crudId':'${param.crudId}','taskName':selectValue},
		xxx);
		function xxx(data){
			returnStepPerson = data['returnStepPerson'];
		} 
	}
    
    
	function end(){
			var selectName=$('#toNodeIds');
		if(null!=selectName&&selectName.length>0){
			var optionValue=selectName.combobox('getValue');
			var contextPath='${pageContext.request.contextPath}';
			var optionLabel=selectName.combobox('getText');
			var backFlag = document.getElementsByName("taskInstanceInfo.node_back");
			backFlag[0].value="0";
			if(optionValue.indexOf('<s:property value="@ais.bpm.util.BpmConstants@END_NAME"/>')!=-1||optionValue.indexOf('<s:property value="@ais.bpm.util.BpmConstants@END_NAME2"/>')!=-1){
				document.getElementById("transitionDiv").innerHTML="";
				document.getElementsByName("isAutoAssign")[0].value='true';
			}else if(null!=optionLabel && optionLabel.indexOf('<s:property value="@ais.bpm.util.BpmConstants@RETURN_STEP"/>')!=-1){
				backFlag[0].value="1";
				returnStep(optionValue);
				if(returnStepPerson!='' && returnStepPerson!=null){
					document.getElementById("transitionDiv").innerHTML=returnStepPerson;
					document.getElementsByName("isAutoAssign")[0].value='true';
				}else{
					//调用验证是否自动分配任务的Ajax函数 LIHAIFENG 2007-11-01
					isActorDisplay();
					if(isAutoAssign!=''){
						document.getElementById("transitionDiv").innerHTML=isAutoAssign;
						document.getElementsByName("isAutoAssign")[0].value='true';
						var node = $('select[id=toActorId]');
						if(node.length>0){
							node.combobox();
						}
					}else{
						document.getElementById("transitionDiv").innerHTML="<input type=text id=\"toActorId_name\" name=\"formInfo.toActorId_name\" readonly=readonly style=\"width:30%\"/>"+
			//"<input id=\"toActorId\" type=hidden name=\"formInfo.toActorId\"/><img  style=\"cursor:hand;border:0\" src=\""+contextPath+"/resources/images/s_search.gif\" onclick=\"showPopWin('"+contextPath+"/pages/system/search/mutiselect.jsp?url="+contextPath+"/pages/system/userindex.jsp&paraname=formInfo.toActorId_name&paraid=formInfo.toActorId&p_item=3',600,450)\"></img>";
			"<input id=\"toActorId\" type=hidden name=\"formInfo.toActorId\"/><img  style=\"cursor:pointer;border:0\" src=\"/ais/easyui/1.4/themes/icons/search.png\" onclick=\"getNextStepPerson(this)\"/>";
						document.getElementsByName("isAutoAssign")[0].value='false';
					}
				}
			}else{//调用验证是否自动分配任务的Ajax函数 LIHAIFENG 2007-11-01
				isActorDisplay();
				if(isAutoAssign!=''){
					document.getElementById("transitionDiv").innerHTML=isAutoAssign;
					document.getElementsByName("isAutoAssign")[0].value='true';
					var node = $('select[id=toActorId]');
					if(node.length>0){
						node.combobox();
					}
				}else{
					document.getElementById("transitionDiv").innerHTML="<input type=text id=\"toActorId_name\" name=\"formInfo.toActorId_name\" readonly=readonly style=\"width:20%\" class=\"noborder\"/>"+
					"<input id=\"toActorId\" type=hidden name=\"formInfo.toActorId\" /><img  style=\"cursor:pointer;border:0\" src=\"/ais/easyui/1.4/themes/icons/search.png\" onclick=\"getNextStepPerson(this)\"></img>";
					document.getElementsByName("isAutoAssign")[0].value='false';
				}
			}
		}
	}
	
    // add by qfucee, 2013.4.22, 下一步处理人
    function getNextStepPerson(element){
        showSysTree(element,{ 
                  url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action',
                  singleSelect:true,
                  param:{
                	  'beanName':'UOrganizationTree'
                  },
                  title:'请选择下一步处理人',
                  type:'treeAndUser'
               })
    }
    
	/**
	*	判定当前选择的走向是否是到流程结束节点的
	*/
	function isToEndNode(){	
		var selectName=document.getElementsByName("formInfo.toNodeId")[0];
		var optionValue=selectName.value;
		if(optionValue.indexOf('<s:property value="@ais.bpm.util.BpmConstants@END_NAME"/>')!=-1||optionValue.indexOf('<s:property value="@ais.bpm.util.BpmConstants@END_NAME2"/>')!=-1){
			return true;
		}
		return false;		
	}
	
</script>
	<input type="hidden" name="isAutoAssign" />

	<!-- 表单提交验证 LIHAIFENG 2007-08-25 -->
</s:if>
<!-- 流程所需公共字段 LIHAIFENG 2007-12-03 -->
<s:hidden id="crudId" name="crudId" />
<s:hidden id="taskInstanceId" name="taskInstanceId" />
<s:if test="taskInstanceId!=null&&taskInstanceId!=''">
	<s:hidden name="formInfo.group_id" />
</s:if>
<s:hidden id="taskInstanceInfo.node_back"
	name="taskInstanceInfo.node_back" />
<s:hidden name="returnBatch" value="${param.returnBatch}" />

<script type="text/javascript">

//document.onpaste=function(){
//    return   false;
//}
function doWhith(src){
    var tmp=src.value.length;
    if(tmp/1>500){
        showMessage1('处理意见输入不能大于500字！');
        src.value = src.value.substring(0, 500);
        src.focus();
    }
}
$(function(){
	  var taskInstanceId=document.getElementById('taskInstanceId').value
	if($('#toNodeIds').length > 0) {
		$('#toNodeIds').combobox({
			onSelect: function (row) {
				end();
			}
		});
		$('#toNodeIds').combo('setText', $('#firstNode').val());
	}
/* 	if($('#commentSelect').length>0) {
		$('#commentSelect').combobox({
			panelHeight: 'auto',
			editable:false,
			onChange: function (newVal, oldVal) {
				$('#comments').val(newVal);
			}
		});
	} */

	if($('#comments').length > 0){
		$('#comments').attr('maxlength',500);
	    if($('#comments').val() == "" && taskInstanceId >0)
		   // $('#comments').val($('#commentSelect').combobox('getValue'));
	    	$('#comments').val("同意");
	}

//	if($('#toActorId').length > 0) {
//		var data = $('#toActorId').combobox('getValues');
//		if (data.length > 0&&$('#type').length > 0) {
//			$('#type').combobox('select', data[0].name);
//		}
//	}
});
<%--<s:if test="taskInstanceId!=null&&taskInstanceId!=''">--%>
<%--beforeinfo();--%>
<%--</s:if>--%>
</script>
