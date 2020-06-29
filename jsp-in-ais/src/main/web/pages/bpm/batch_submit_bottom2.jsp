<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<jsp:directive.page import="ais.bpm.util.BpmConstants" />
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML>
<script language="javascript">
var selectName1=document.getElementsByName("toNode")[0];
var optionValue1=selectName1.value;
var optionLabel1="";
var optionChild1=selectName1.getElementsByTagName("option");
for(var i=0;i<optionChild1.length;i++)
{
	if(optionChild1[i].getAttribute("value")==optionValue1)
	{
		optionLabel1=optionChild1[i].firstChild.nodeValue;
	}
}
var task_strategy=0;
DWREngine.setAsync(false);
DWREngine.setAsync(false);DWRActionUtil.execute(
{ namespace:'/plan', action:'loadBpmTask', executeResult:'false' }, 
{'group_id':document.getElementsByName('group_id')[0].value,'formInfo.toNodeId':document.getElementsByName("toNode")[0].value},
xxx);
function xxx(data){
	task_strategy = data['bpmTask']['task_assign_policy'];
	//window.alert(task_strategy);
} 
		function batchSubmit(myform)
		{
			<s:if test="autoAssignment==null||autoAssignment==''">
			if(document.getElementsByName('toNode')[0].value!='<s:property value="@ais.bpm.util.BpmConstants@END_NAME"/>'&&document.getElementsByName("formInfo.toActorId")[0].value=='')
			{
				window.alert("下一步处理人不能为空!");
				return false;
			}
			</s:if>
			if(!hasSelect(myform))
			{
				alert("请选择要操作的记录！");
				return false;
			}
			<s:if test="@ais.bpm.util.FormTypeConstant@MNG_ARCHIVES_PIGEONHOLE==formType">
          //预归档流程添加js校验
		   var archives_bool = true;
	      // archives_bool  = checkBatchSubmit_fun(); //校验暂时不加了！
	       if(!archives_bool){
	       return false;
	       }
			</s:if>
			if((task_strategy==<s:property value="@ais.bpm.model.BpmTask@ASSIGN_POLICY_BYTABLEFIELD"/>||task_strategy==<s:property value="@ais.bpm.model.BpmTask@ASSIGN_POLICY_ADDIN"/>)&&!isActorDisplay4CheckFormTableField())
			{
				return false;
			}
			if(new RegExp("[<%=ais.bpm.util.BpmConstants.RETURN_STEP%>]$").test(optionLabel1)&&!checkReturnStep())
			{
				return false;
			}
			if(!confirm("确认执行这项操作吗？"))
			{
				return false;
			}
			else
			{
				document.getElementById("batchSubmitButton").style.display="none";
			}
			return true;
		}
		function changeCondition(toNode)
		{
			document.getElementsByName('toNodeStatus')[0].value=toNode;
			end();
			batch_submit_form.submit();
		}
		function end()
		{
			<s:if test="formInfoList.size!=0">
			var selectName=document.getElementsByName("toNode")[0];
			var optionValue=selectName.value;
			var contextPath='${pageContext.request.contextPath}';
			var optionLabel="";
			var optionChild=selectName.getElementsByTagName("option");
			for(var i=0;i<optionChild.length;i++)
			{
				if(optionChild[i].getAttribute("value")==optionValue)
				{
					optionLabel=optionChild[i].firstChild.nodeValue;
				}
			}
			if(optionValue.indexOf('<s:property value="@ais.bpm.util.BpmConstants@END_NAME"/>')!=-1||optionValue.indexOf('<s:property value="@ais.bpm.util.BpmConstants@END_NAME2"/>')!=-1)
			{
				document.getElementById("hiddenArea1").innerHTML="";
				document.getElementById("hiddenArea2").innerHTML="";
				document.getElementsByName("isAutoAssign")[0].value='true';
			}
			else if(new RegExp("[<%=ais.bpm.util.BpmConstants.RETURN_STEP%>]$").test(optionLabel))
			{
				document.getElementById("hiddenArea2").innerHTML="<input type=\"hidden\" name=\"formInfo.toActorId\" value=\"回退\"><font size=\"2pt\">"+optionValue+"环节的处理人</font>";
				document.getElementsByName("isAutoAssign")[0].value='true';
			}
			else
			{
				//调用验证是否自动分配任务的Ajax函数 LIHAIFENG 2007-11-01
				isActorDisplay();
				if(isAutoAssign!='')
				{
					document.getElementById("hiddenArea2").innerHTML=isAutoAssign;
					document.getElementsByName("isAutoAssign")[0].value='true';
				}
				else
				{
					document.getElementById("hiddenArea2").innerHTML="<input type=text id=\"toActorId_name\" name=\"formInfo.toActorId_name\" readonly=readonly id=\"actualizeForm_formInfo_toActorId_name\" style=\"width:95%\"/>"+
	    "<input id=\"toActorId\" type=hidden name=\"formInfo.toActorId\"/><img  style=\"cursor:hand;border:0\" src=\""+contextPath+"/resources/images/s_search.gif\" onclick=\"showPopWin('"+contextPath+"/pages/system/search/frameselect4s.jsp?url=/ais/pages/system/userindex.jsp&paraname=formInfo.toActorId_name&paraid=formInfo.toActorId',600,350)\"></img>";
					document.getElementsByName("isAutoAssign")[0].value='false';
				}
			}
			</s:if>
		}
		var isAutoAssign="";
		//是否自动分配任务的函数
		function isActorDisplay()
		{
			var selectName=document.getElementsByName("toNode")[0];
			var optionValue=selectName.value;
			var crudIdss=document.getElementsByName("crudIds");
			var formIds="";
			for(var i=0;i<crudIdss.length;i++)
			{
				if(crudIdss[i].checked)
				{
					formIds=crudIdss[i].value;
					formIds=formIds.split(",")[0];
					break;
				}
			}
			DWREngine.setAsync(false);
			DWREngine.setAsync(false);DWRActionUtil.execute(
			{ namespace:'/plan', action:'getAutoAssignedTask', executeResult:'false' }, 
			{'group_id':document.getElementsByName('group_id')[0].value,'formInfo.toNodeId':optionValue,'crudId':formIds,'formClassName':'<%=request.getAttribute("crudObject").getClass().getName()%>'},
			xxx);
			function xxx(data){
				isAutoAssign = data['autoAssignment'];
			} 
		}
		
		function isActorDisplay4CheckFormTableField()
		{
			var selectName=document.getElementsByName("toNode")[0];
			var optionValue=selectName.value;
			var crudIdss=document.getElementsByName("crudIds");
			var formIds="";
			var info="";
			for(var i=0;i<crudIdss.length;i++)
			{
				if(crudIdss[i].checked)
				{
					formIds=crudIdss[i].value;
					formIds=formIds.split(",")[0];
					DWREngine.setAsync(false);
					DWREngine.setAsync(false);DWRActionUtil.execute(
					{ namespace:'/plan', action:'getAutoAssignedTask', executeResult:'false' }, 
					{'group_id':document.getElementsByName('group_id')[0].value,'formInfo.toNodeId':optionValue,'crudId':formIds,'formClassName':'<%=request.getAttribute("crudObject").getClass().getName()%>'},
					xxx);
					function xxx(data){
						var str = data['autoAssignment'];
						//window.alert(str);
						var ddiivv=document.getElementById("myCheck");
						ddiivv.innerHTML=str;
						if(str!=""){
							ddiivv.firstChild.name="myFormInfo.toActorId";
							var num=ddiivv.firstChild.options.length;
							if(num==0||num>1)
							{
								info=info+"\r\n"+crudIdss[i].parentNode.parentNode.parentNode.childNodes[1].innerText+"：处理人未指定或者存在多个待指定的处理人！";
							}
						}
					} 
				}
			}
			if(info!=""){
				window.alert(info);
				document.getElementById("myCheck").innerHTML="";
				return false;
			}
			else
			{
				return true;
			}
		}
		
		function checkReturnStep()
		{
			var selectName=document.getElementsByName("toNode")[0];
			var optionValue=selectName.value;
			var crudIdss=document.getElementsByName("crudIds");
			var formIds="";
			var info="";
			for(var i=0;i<crudIdss.length;i++)
			{
				if(crudIdss[i].checked)
				{
					formIds=crudIdss[i].value;
					formIds=formIds.split(",")[0];
					DWREngine.setAsync(false);
					DWREngine.setAsync(false);DWRActionUtil.execute(
					{ namespace:'/plan', action:'checkReturnStep', executeResult:'false' }, 
					{'formInfo.toNodeId':optionValue,'crudId':formIds},
					xxx);
					function xxx(data){
						var str = data['checkReturnStep'];
						//window.alert(str);
						if(!str){
							info=info+"\r\n"+crudIdss[i].parentNode.parentNode.parentNode.childNodes[2].innerText+"不能回退到“"+optionValue+"”节点！";
						}
					} 
				}
			}
			if(info!=""){
				window.alert(info);
				return false;
			}
			else
			{
				return true;
			}
		}
		
function togethers(){
	var cs=document.getElementsByName("crudIds");
	var str="";
	for(var i=0;i<cs.length;i++)
	{
		if(cs[i].checked){
			var csValue=cs[i].value;
			if(str=="")
				str=csValue;
			else
				str=str+"，"+csValue;
		}
	}
	var e=document.getElementById("togetherCrudIds");
	e.value=str;
	document.forms['batch_submit_form'].appendChild(e);
}
</script>
<input type="hidden" name="isAutoAssign" />
<input type="hidden" name="togetherCrudIds" />
<div id="myCheck" style="visibility: hidden"></div>
