
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>


<s:if test="status=='add'">
	<s:text id="title" name="'添加评分标准明细信息'"></s:text>
</s:if>
<s:if test="status=='update'" >
	<s:text id="title" name="'修改评分标准明细信息'"></s:text>
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
	

	
		<s:head />
	</head>
<base target="_self"/>
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

			<s:form name="myform" action="save" namespace="/pe/pfbz_inner">
				<s:hidden name="pfbz_inner.id"></s:hidden>
				<s:hidden name="pfbz_inner.pfbz_id"></s:hidden>
				<s:hidden name="status"></s:hidden>
				<s:hidden name="pfbz_inner.creator"></s:hidden>
				<s:hidden name="pfbz_inner.cts"></s:hidden>
				<table cellpadding=1 cellspacing=1 border=0 bgcolor="#409cce"
					class="ListTable" id="project_table">

					<tr>
						<td class="ListTableTr11">
							<font color=red>*</font>名称:
						</td>
						<td class="ListTableTr22">	
							<s:textfield name="pfbz_inner.name" />																	
			
						</td>
						<td class="ListTableTr11">
							<font color=red>*</font> 分值区间:
						</td>
						<td style=" background-color: white" >
							<s:textfield name="pfbz_inner.score" />
								-
							<s:textfield name="pfbz_inner.score1" />	
						</td>

					</tr>
					
					
				</table>

				<s:if test="status=='add'">
					<s:button value="保存" onclick="saveForm(0);" />&nbsp;&nbsp;
				</s:if>
				<s:if test="status=='update'">
					<s:button value="保存" onclick="saveForm(1);" />&nbsp;&nbsp;
                </s:if>                
				
				&nbsp;&nbsp;	

				
				<input type="button" name="back" value="返回"
					onclick="history.back()">
		
								
			
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
	
	var url='';
      if(type==0){
         if(window.confirm("确定执行添加项目操作吗?")){
	   url="${contextPath}/pe/pfbz_inner/save.action";
	   myform.action = url;
	   myform.submit();//提交表单
	   }      
      }
      else{
         if(window.confirm("确定执行修改项目操作吗?")){
	   url="${contextPath}/pe/pfbz_inner/update.action";
	   myform.action = url;
	   myform.submit();//提交表单
	   }
      
      }	
      
     // reWin()
}



function toOtherUrl(){
window.location="${contextPath}/pe/pfbz_inner/listAll.action";
}
function reWin(){
//window.opener.parent.location.reload();window.close()
//window.returnValue="这里存放返回的结果";
var arg=window.dialogArguments;
arg.win.refreshWindow();
window.close();
}
</script>
</html>
