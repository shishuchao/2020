<%@ page language="java" import="java.util.*" pageEncoding="GB18030"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<script type='text/javascript' src='/ais/scripts/dwr/DWRActionUtil.js'></script>
<script type='text/javascript' src='/ais/dwr/interface/DWRAction.js'></script>
<script type='text/javascript' src='/ais/dwr/engine.js'></script>
<script type='text/javascript' src='/ais/dwr/util.js'></script>
<s:if test="status=='add'">
	<s:text id="title" name="'绩效考核--新建体系'"></s:text>
</s:if>
<s:if test="status=='update'">
	<s:text id="title" name="'绩效考核--修改体系'"></s:text>
</s:if>

<html>
	<head>
		<title><s:property value="#title" /></title>
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet"
			type="text/css">
		<link rel="stylesheet" type="text/css"
			href="${contextPath}/resources/csswin/subModal.css" />
		<script type="text/javascript"
			src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript"
			src="${contextPath}/resources/csswin/subModal.js"></script>
		<SCRIPT type="text/javascript"
			src="${contextPath}/scripts/calendar.js"></SCRIPT>
		<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/pages/pe/validate/checkboxSelected.js"></script>
					<script type="text/javascript"
			src="<%=request.getContextPath()%>/pages/pe/validate/validateCommon.js"></script>				

		<s:head />
	</head>

	<body>
		<center>
			<table>
				<tr class="listtablehead">
					<td colspan="5" align="left" class="edithead">
						&nbsp;
						<s:property value="#title" />
					</td>
				</tr>
			</table>
			<s:form name="myform" action="save" namespace="/pe/pesystem">
				<s:hidden name="peSystem.id"></s:hidden>
				<s:hidden name="status"></s:hidden>
				<s:hidden name="peSystem.cts"></s:hidden>
				<s:hidden name="peSystem.creator"></s:hidden>
				<table cellpadding=1 cellspacing=1 border=0 bgcolor="#409cce"
					class="ListTable" id="project_table">
					<tr>
						<td class="ListTableTr11">
							<font color=red>*</font>体系名称:
						</td>
						<td class="ListTableTr22" colspan="3">
							<s:textfield name="peSystem.name" cssStyle="width:100%" onblur="testName()"
								 />
						</td>
					</tr>

					<tr>
						<td class="ListTableTr11">
							<font color=red>*</font>体系状态:
						</td>
						<td class="ListTableTr22">
							<s:select name="peSystem.status" list="#@java.util.LinkedHashMap@{'0':'草稿'}"
								cssStyle="width:150px"></s:select>
						</td>
						<td class="ListTableTr11">
							<font color=red>*</font>体系版本:
						</td>
						<td class="ListTableTr22">
							<s:textfield name="peSystem.edition" />
						</td>
					</tr>
					<tr>
						<td class="ListTableTr11">
							<font color=red>*</font>考核对象:
						</td>
						<td class="ListTableTr22">
							<s:select name="peSystem.peObjectCode" headerKey=""
								headerValue="请选择考核对象类型" list="basicUtil.peObjectList"
								listKey="code" listValue="name" onchange="autoInput1(this)" />
						</td>
						<td class="ListTableTr11">
							<font color=red>*</font>考核主体:
						</td>
						<td class="ListTableTr22">
							<s:select name="peSystem.peMainCode" headerKey=""
								headerValue="请选择考核主体类型" list="basicUtil.peMainList"
								listKey="code" listValue="name" onchange="autoInput2(this)" />

						</td>
					</tr>

					<tr>
						<td class="ListTableTr11">
							<font color=red>*</font>考核对象单位范围:
						</td>
						<td class="ListTableTr22">
							<s:buttonText2 id="object_unit_name" hiddenId="object_unit_id"
								name="peSystem.object_unit_name"
								hiddenName="peSystem.object_unit_id" cssStyle="width:90%"
	
								
								doubleOnclick="showPopWin('/ais/pages/system/search/searchdatamuti.jsp?url=/ais/system/uSystemAction!orgList4muti.action&paraname=peSystem.object_unit_name&paraid=peSystem.object_unit_id',600,450)"
			
								doubleSrc="${pageContext.request.contextPath}/resources/images/s_search.gif"
								doubleCssStyle="cursor:hand;border:0" readonly="true" />
						</td>
						<td class="ListTableTr11">
							考核对象人员范围:
						</td>
						<td class="ListTableTr22">
							<s:buttonText2 id="object_sjrc_name" hiddenId="object_sjrc_id"
								name="peSystem.object_sjrc_name"
								hiddenName="peSystem.object_sjrc_id" cssStyle="width:90%"
								doubleOnclick="showPopWin('${pageContext.request.contextPath}/pages/system/search/mutiselect.jsp?url=${pageContext.request.contextPath}/pages/system/userindex.jsp&paraname=peSystem.object_sjrc_name&paraid=peSystem.object_sjrc_id',600,450)"
								doubleSrc="${pageContext.request.contextPath}/resources/images/s_search.gif"
								doubleCssStyle="cursor:hand;border:0" readonly="true" />
						</td>
					</tr>


					<tr>
						<td class="ListTableTr11">
							<font color=red>*</font>考核方式:
						</td>
						<td class="ListTableTr22" colspan="3">
							<s:select id="m" name="peSystem.peTypeCode" headerKey="" 
								headerValue="请选择考核方式" list="basicUtil.peTypeList" listKey="code"
								listValue="name" />
						</td>

					</tr>
					<tr>
						<td class="ListTableTr11">
							考核指标:
						</td>
						<td class="ListTableTr22">
							<s:if test="${peSystem.ys_id=='no'}">							
									<s:div cssStyle="text-align:center; color:red">未定义</s:div>							
							</s:if>
							<s:elseif test="${peSystem.ys_id=='yes'}">								
									<s:div cssStyle="text-align:center; color:green">已定义</s:div>							
							</s:elseif>	
						</td>
						<td class="ListTableTr11">
							考核流程:
						</td>
						<td class="ListTableTr22">
							<s:if test="${peSystem.flow_id=='no'}">								
									<s:div cssStyle="text-align:center; color:red">未定义</s:div>								
							</s:if>
							<s:elseif test="${peSystem.flow_id=='yes'}">								
									<s:div cssStyle="text-align:center; color:green">已定义</s:div>							
							</s:elseif>
						</td>
					</tr>


					<tr>
						<td class="ListTableTr11">
							备注:
						</td>
						<td class="ListTableTr22" colspan="3">
							<s:textarea name="peSystem.beizhu"
								cssStyle="width:100%;height:100px"></s:textarea>
						</td>

					</tr>
				</table>
				<s:if test="status=='add'">
					<s:button value="保存" onclick="saveForm(0);" />&nbsp;&nbsp;
				</s:if>
				<s:else>
					<s:button value="保存" onclick="saveForm(1);" />&nbsp;&nbsp;
                </s:else>

				&nbsp;&nbsp;	
				<input type="button" name="back" value="返回"
					onclick="javascript:window.location='<s:url action="listAll"></s:url>'">
			</s:form>

		</center>

	</body>


	<script language="javascript"> 
     function check(){
       return (frmCheck(document.forms[0],'project_table'));  
    }
	
function saveForm(type){
	if(!check()){//前端验证
	   return false;
	}
    if(!numberValidate_out('peSystem.name',50,'体系')){
      return false;
      }
 
    if(!numberValidate_out('peSystem.beizhu',200,'备注')){
      return false;
      }
         
	var url='';
      if(type==0){
         if(window.confirm("执行添加考核体系操作吗?")){
	   url="${contextPath}/pe/pesystem/save.action";
	   myform.action = url;
	
	   myform.submit();//提交表单
	   }
      
      }
      else{
         if(window.confirm("执行修改考核体系操作吗?")){
	   url="${contextPath}/pe/pesystem/update.action";
	   myform.action = url;
	   myform.submit();//提交表单
	   }
      
      }
	
}



</script>

	<script language="javascript">
function testName(){//ajax验证不能重名
var name_value=document.getElementsByName('peSystem.name')[0].value;
DWREngine.setAsync(false);DWRActionUtil.execute(
{ namespace:'/pe/pesystem', action:'testSameName', executeResult:'false' },{'status':name_value},xxx1);}
function xxx1(data){

if(data['status']=='yes'){
	window.alert("体系名称已经存在，请换一个试试!");
	document.getElementsByName('peSystem.name')[0].value="";
	document.getElementsByName('peSystem.name')[0].focus();
	return false;
}
  
} 
//根据审计对象类型编号，审计主题跟着变化
function autoInput1(src){

var peMainCode=document.getElementsByName('peSystem.peMainCode')[0];
if(src.value==''){
peMainCode.value='';
}
if(src.value=='1000201'){
peMainCode.value='1000301';
}
if(src.value=='1000202'){
peMainCode.value='1000302';
}
if(src.value=='1000203'){
peMainCode.value='1000303';
}
if(src.value=='1000204'){
peMainCode.value='1000304';
}
if(src.value=='1000205'){
peMainCode.value='1000305';
}

//同步处理考核方式
if(src.value=='1000201'||src.value=='1000202'){
document.getElementById('m').options[1].selected='true';
SetReadOnly(document.getElementById('m'));
}else{
reSetReadOnly(document.getElementById('m'));
}
}


function autoInput2(src){
var peObjectCode=document.getElementsByName('peSystem.peObjectCode')[0];
if(src.value==''){
peObjectCode.value='';
}
if(src.value=='1000301'){
peObjectCode.value='1000201';
}
if(src.value=='1000302'){
peObjectCode.value='1000202';
}
if(src.value=='1000303'){
peObjectCode.value='1000203';
}
if(src.value=='1000304'){
peObjectCode.value='1000204';
}
if(src.value=='1000305'){
peObjectCode.value='1000205';
}
}
</script>



<script type="text/javascript">
function SetReadOnly(obj){
    if(obj){
        obj.onbeforeactivate = function(){return false;};
        obj.onfocus = function(){obj.blur();};
        obj.onmouseover = function(){obj.setCapture();};
        obj.onmouseout = function(){obj.releaseCapture();};
    }
}
function reSetReadOnly(obj){
    if(obj){
       obj.onbeforeactivate = null;
       obj.onfocus = null;
       obj.onmouseover = null;
       obj.onmouseout = null;
     }
}

function jsRemoveItemFromSelect(objSelect,objItemValue){    //判断是否存在
    if(jsSelectIsExitItem(objSelect,objItemValue)){
        for(var i=0;i<objSelect.options.length;i++){
            if(objSelect.options[i].value == objItemValue){
                objSelect.options.remove(i);
                break;
            }
        }        
        //alert("成功删除");            
    }
    else{
        alert("该select中 不存在该项");
    }    
}
//是否存在这个option值
function jsSelectIsExitItem(objSelect,objItemValue){
    var isExit = false;
    for(var i=0;i<objSelect.options.length;i++){
        if(objSelect.options[i].value == objItemValue){
            isExit = true;
            break;
        }
    }      
    return isExit;
} 

</script>

</script>
</html>

