<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML>
<s:if test="msg.list.size!=0">
	<br>
	<br>
	<br>
	<br>
	<div align="center">
		<FIELDSET style="width:550">
			<LEGEND>
				<font color="blue">系统提示：</font>
			</LEGEND>
			<br>
			<div align="center">
				<div class="cfblk" style="width:300pt">

					<COLGROUP>
						<COL width="65">
						<COL width="*">

						<s:iterator value="msg.list">
							<li>
								<s:property value="info" />
							</li>
						</s:iterator>
						<br>
					</COLGROUP>
				</div>
			</div>
			<br>
		</FIELDSET>
	</div>
</s:if>
<script language="javascript">
function batchStarts2(myform)
{
	if(!hasSelectOnlyOne2(myform,'crudIdxxx'))
	{
		alert("请选择要操作的记录！");
		return false;
	}
	<s:if test="@ais.bpm.util.FormTypeConstant@MNG_PROJECT_ACTUALIZE==formType">
		if(!confirm("如果您已确认完成作业系统的相关操作，请点击确定！"))
		{
			return false;
		}
	</s:if>
	<s:else>
		if(!confirm("确认执行这项操作吗？"))
		{
			return false;
		}
	</s:else>
	else
	{
		var ob=document.getElementById("submitCommon");
		if(ob!=undefined&&ob!=null)
		{
			ob.style.display="none";
		}
		document.getElementById("returnCommon").style.display="none";
	}
	return true;
}
function batchStarts(myform)
{
	if(!hasSelect(myform))
	{
		alert("请选择要操作的记录！");
		return false;
	}
	<s:if test="isUseBpm=='true'">
	if(document.getElementById("definition_id").value=="")
	{
		window.alert("未设定流程，不能启动！");
		return false;
	}
	if(document.getElementById("group_id").value=="")
	{
		window.alert("未设定群组，不能启动！");
		return false;
	}
	</s:if>
	<s:if test="@ais.sysparam.util.SysParamUtil@getSysParam('ais.project.actualize.interact')">
		<s:if test="@ais.bpm.util.FormTypeConstant@MNG_PROJECT_ACTUALIZE==formType">
			vsp(myform);
			if(str!='')
			{
				window.alert(str);
				return false;
			}
			isInteract(myform);
			interact=interact.replace(/\s+$|^\s+/g,"");
			if(interact!="")
			{
				var s=interact.split(",");
				var detail="";
				for(var i=0;i<s.length;i++)
				{
					if(detail=="")
					{
						if(s[i]!="NONE")
							detail="项目编号为"+s[i];
					}
					else
					{
						if(s[i]!="NONE")
							detail=detail+"、"+s[i];
					}
				}
				if(detail!=""){
					window.alert(detail+"的项目管理与作业未完成交互，不能提交！");
					return false;
				}
			}
		</s:if>
	</s:if>
	var bool=true;
	var bool2=true;
	var bool3=true;
	<s:if test="@ais.bpm.util.FormTypeConstant@MNG_PROJECT_PREPARE==formType">
			bool3=checkAjaxNoBpm("ais.project.prepare.model.ProjectPrepareObject");
			var str="";
			for (var i = 0; i < myform.elements.length; i++) {
				var ec = myform.elements[i];
				if (ec.name=="crudIds"&&ec.type == "checkbox"&&ec.ops=="bs") {
					if (ec.checked) {
						if(str=="")
							str=ec.value;
						else
							str=str+","+ec.value;
					} 
				}
			}
			if(${varMap['isOperatorDCRequired']}&&str!="")
			{
				var check_bool = false;
				DWREngine.setAsync(false);
				DWREngine.setAsync(false);DWRActionUtil.execute(
				{ namespace:'/dcenter/data/apply', action:'checkedProHasDcenterData', executeResult:'false' }, 
				{'formId':str.replace(/\s+$|^\s+/g,"")},
				xxx1);
				function xxx1(data){
					check_bool = data['check_bool'];
				}
				if(check_bool!=null && check_bool==false)
				{
					alert("请申请数据！");
					return false;
				}
			}
			
			var sss="";
			for (var i = 0; i < myform.elements.length; i++) {
				var ec = myform.elements[i];
				if (ec.name=="crudIds"&&ec.type == "checkbox"&&ec.ops=="bs") {
					if (ec.checked) {
						sss=sss+","+ec.value;
					} 
				}
			}
			var msg="";
			if(sss!=""){
				DWREngine.setAsync(false);
				DWREngine.setAsync(false);DWRActionUtil.execute(
				{ namespace:'/project/prepare', action:'checkActualizeScheme', executeResult:'false' }, 
				{'project_id':sss},xxx);
				function xxx(data){
					msg=data['as'];
				};
				if(msg!=null&&msg!='')
				{
					window.alert(msg);
					return false;
				}
			}
	</s:if>
	<s:if test="@ais.bpm.util.FormTypeConstant@MNG_PROJECT_REPORT==formType">
			bool3=checkAjaxNoBpm("ais.project.report.model.ProjectReportObject");
	</s:if>
	if(bool&&bool2&&bool3)
	{	
		<s:if test="@ais.bpm.util.FormTypeConstant@MNG_PROJECT_ACTUALIZE==formType">
			if(!confirm("如果您已确认完成作业系统的相关操作，请点击确定！"))
			{
				return false;
			}
		</s:if>
		<s:else>
			if(!confirm("确认执行这项操作吗？"))
			{
				return false;
			}
		</s:else>
		else
		{
			var ob=document.getElementById("returnCommon");
			if(ob!=undefined&&ob!=null)
			{
				ob.style.display="none";
			}
			document.getElementById("submitCommon").style.display="none";
			return true;
		}
	}
	else
	{
		return false;
	}
	return true;
}
function checkAjaxNoBpm(po)
{
	/*var tbl_obj = document.getElementById("row");
	var pre_cell = null;
	var plan_code_cell = null;
	var plan_code_str="";
	var results="";
	var finalResults="";
	for (var i = 0; i <= parseInt(tbl_obj.cells.length) - 1; i++) {
		plan_code_cell = tbl_obj.cells(i);
		if(plan_code_cell.firstChild!=null&&plan_code_cell.firstChild.name=='crudIds'&&plan_code_cell.firstChild.type=="checkbox"&&plan_code_cell.firstChild.checked)
		{
			pre_cell = plan_code_cell.firstChild.value;
			if(plan_code_str=="")
				plan_code_str=pre_cell;
			else
				plan_code_str=plan_code_str+","+pre_cell;
		}
	}
	)*/
	//Ext
	var plan_code_str="";
	var results="";
	var finalResults="";
	var s=document.getElementsByName("crudIds");
	for(var i=0;i<s.length;i++)
	{
		if(s[i].checked)
		{
			if(plan_code_str=="")
				plan_code_str=s[i].value;
			else
				plan_code_str=plan_code_str+","+s[i].value;
		}
	}
	//Ext
	DWREngine.setAsync(false);
	DWREngine.setAsync(false);DWRActionUtil.execute(
	{ namespace:'/plan', action:'AjaxCheckNoBpm', executeResult:'false' }, 
	{'className':po,'myFormType':${formType},'crudId': plan_code_str},xxx);
	function xxx(data){
		results=data['results'];
	};
	if(results!="")
	{
		var regS1 = new RegExp("<li>","gi");
		var regS2 = new RegExp("</li>","gi");
		window.alert(results.replace(regS1,"").replace(regS2,"   \r\n"));
		return false;	
	}
	else
	{
		return true;
	}
}
//实施阶段一并提交校验---Add By LIHAIFENG 2008-04-08
function togetherAjaxCheck() {
	var tbl_obj = document.getElementById("row");
	var pre_cell = null;
	var plan_code_cell = null;
	var plan_code_str="";
	var results="";
	var finalResults="";
	for (var i = 0; i <= parseInt(tbl_obj.cells.length) - 1; i++) {
		plan_code_cell = tbl_obj.cells(i);
		if(plan_code_cell.firstChild.type=="checkbox"&&plan_code_cell.firstChild.checked)
		{
			pre_cell = tbl_obj.cells(parseInt(i) + 1).innerText;
			if(plan_code_str=="")
				plan_code_str=pre_cell;
			else
				plan_code_str=plan_code_str+","+pre_cell;
		}
	}
	DWREngine.setAsync(false);
	DWREngine.setAsync(false);DWRActionUtil.execute(
	{ namespace:'/project/start', action:'countProjectStartItem', executeResult:'false' }, 
	{'plan_code':plan_code_str},xxx);
	function xxx(data){
		results=data['results'];
	};
	var temp1=results.split("，");
	for(var i = 0; i < temp1.length; i++)
	{
		var temp2=temp1[i].split(",")[0];
		var temp3=temp1[i].split(",")[1];
		var count=0;
		for (var j = 0; j <= parseInt(tbl_obj.cells.length) - 1; j++) {
			plan_code_cell = tbl_obj.cells(j);
			if(plan_code_cell.innerText==temp2)
			{
				count++;
			}
		}
		if(temp3!=count)
		{
			finalResults=finalResults+"计划编号为"+temp2+"的计划有未完成的项目，暂不能提交！\r\n";
		}
		
	}
	if(finalResults!="")
	{
		window.alert(finalResults);
		return false;	
	}
	else
	{
		return true;
	}
}
//校验统管字段是否一致，防止作业系统修改影响结果
function togetherAjaxCheck2() {
	/*var tbl_obj = document.getElementById("row");
	var pre_cell = null;
	var plan_code_cell = null;
	var plan_code_str="";
	var results="";
	var finalResults="";
	for (var i = 0; i <= parseInt(tbl_obj.cells.length) - 1; i++) {
		plan_code_cell = tbl_obj.cells(i);
		if(plan_code_cell.firstChild!=null&&plan_code_cell.firstChild.name!=null&&plan_code_cell.firstChild.name=="crudIds"&&plan_code_cell.firstChild.type=="checkbox"&&plan_code_cell.firstChild.checked)
		{
			pre_cell = plan_code_cell.firstChild.plancode;
			if(plan_code_str=="")
				plan_code_str=pre_cell;
			else
				plan_code_str=plan_code_str+","+pre_cell;
		}
	}*/
	//Ext ---Add By LIHAIFENG 2008-05-19
	var s=document.getElementsByName("crudIdxxx");
	var plan_code_str="";
	var results="";
	var finalResults="";
	for(var i=0;i<s.length;i++)
	{
		if(s[i].checked)
		{
			plan_code_str=s[i].value.replace("计划编号: ","");
		}
	}
	//Ext
	
	DWREngine.setAsync(false);
	DWREngine.setAsync(false);DWRActionUtil.execute(
	{ namespace:'/project/start', action:'checkTogether', executeResult:'false' }, 
	{'plan_code':plan_code_str},xxx);
	function xxx(data){
		results=data['results'];
	};
	var temp1=results.split("，");
	for(var i = 0; i < temp1.length; i++)
	{
		var temp2=temp1[i].split(",")[0];
		var temp3=temp1[i].split(",")[1];
		if(temp3!=null&&temp3!="")
		{
			finalResults=finalResults+"计划编号为"+temp2+"的计划："+temp3+"\r\n";
		}
		
	}
	if(finalResults!="")
	{
		window.alert(finalResults);
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
				str=str+","+csValue;
		}
	}
	var e=document.getElementById("togetherCrudIds");
	e.value=str;
	document.forms['batch_start_form'].appendChild(e);
}

var interact="";
function isInteract(myform) 
{
	var str="";
	for (var i = 0; i < myform.elements.length; i++) {
		var ec = myform.elements[i];
		if (ec.name=="crudIds"&&ec.type == "checkbox") {
			if (ec.checked) {
				if(str=="")
					str=ec.value;
				else
					str=str+","+ec.value;
			} 
		}
	}
	DWREngine.setAsync(false);
	DWREngine.setAsync(false);DWRActionUtil.execute(
	{ namespace:'/project/actualize', action:'is_Interact', executeResult:'false' }, 
	{'crudId':str},xxx);
	function xxx(data){
		interact=data['interact'];
	};
}
var str="";
function vsp(myform) 
{
	for (var i = 0; i < myform.elements.length; i++) {
		var ec = myform.elements[i];
		if (ec.name=="crudIds"&&ec.type == "checkbox") {
			if (ec.checked) {
				DWREngine.setAsync(false);
				DWREngine.setAsync(false);DWRActionUtil.execute(
				{ namespace:'/project/actualize', action:'vsp', executeResult:'false' }, 
				{'crudId':ec.value},xxx);
				function xxx(data){
					if(data['permission']==false){
						if(str=="")
							str=ec.parentNode.parentNode.parentNode.childNodes[1].innerText+" 的项目，你没有权限提交！\r\n";
						else
							str=str+ec.parentNode.parentNode.parentNode.childNodes[1].innerText+" 的项目，你没有权限提交！\r\n";
					}
				};
			} 
		}
	}
		
}		
</script>
<input type="hidden" name="togetherCrudIds" />
