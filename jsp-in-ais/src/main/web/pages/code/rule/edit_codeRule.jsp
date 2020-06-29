<!DOCTYPE HTML>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<s:if test="id == 0"> 
	<s:text id="title" name="'添加编号规则定义表'"></s:text>
</s:if>
<s:else>
    <s:text id="title" name="'修改编号规则定义表'"></s:text>
</s:else>



<html>
<script language="javascript">
             
function backList(){
	myform.action = "${contextPath}/code/rule/codeRule/list.action";
	myform.submit();
}



//模板生成----------保存表单
function saveForm(){
var bool = true;//提交表单判断参数
//非空校验
 
	
	//保存表单
	if(bool){
		$.messager.confirm('提示信息', '您确定操作吗?', function(isFlag){
			if(isFlag){
				var url = "${contextPath}/code/rule/codeRule/save.action";
				myform.action = url;
				myform.submit();
			}
		});
	}else{
	 	return false;
	}
}




			
				
				
   //上传附件
	function Upload(id,filelist,delete_flag,edit_flag)
		{
			var guid=document.getElementById(id).value;
			var num=Math.random();
			var rnm=Math.round(num*9000000000+1000000000);//随机参数清除模态窗口缓存
			window.showModalDialog('${contextPath}/commons/file/welcome.action?guid='+guid+'&param='+rnm+'&deletePermission='+delete_flag+'&isEdit='+edit_flag,filelist,'dialogWidth:700px;dialogHeight:450px;status:yes');
		}

</script>
<script>
var XMLHttpReq=false;
 		//创建一个XMLHttpRequest对象
 		function createXMLHttpRequest(){
 				if(window.XMLHttpRequest){ //Mozilla 浏览器
 					XMLHttpReq=new XMLHttpRequest();
 					}
 					else if(window.ActiveXObject){ //微软IE 浏览器
 						try{
 							XMLHttpReq=new ActiveXObject("Msxml2.XMLHTTP");//IE 6.0及6.0以上版本
 							}catch(e){
 								try{
 									XMLHttpReq=new ActiveXObject("Microsoft.XMLHTTP");
									//IE 5.0版本
 									}catch(e){}
 									}
 								}
 		}
 		var layerName="";//指定删除之后回显的DIV标签对的id属性
 		//发送请求函数
 		function send(url,guid){
 			createXMLHttpRequest();
 			XMLHttpReq.open("GET",url,true);
 			
 			this.layerName=document.getElementById(guid).parentElement.id;
 			
 			XMLHttpReq.onreadystatechange=proce;//指定响应的函数
 			XMLHttpReq.send(null);  //发送请求
 			};
 		function proce(layerName){
 			if(XMLHttpReq.readyState==4){ //对象状态
 				if(XMLHttpReq.status==200){//信息已成功返回，开始处理信息
 				var resText = XMLHttpReq.responseText;
 				document.getElementById(this.layerName).innerHTML=resText;
 				window.alert("删除成功");
 				}else{
 					window.alert("所请求的页面有异常");
 					}
 					}
 		}
 		
 		//删除方法
 		/*
 			1.第一个参数是附件表的主键ID，第二个参数是该类附件的删除权限，第三个参数是附件的应用类型
 			2.该方法的参数由ais.file.service.imp.FileServiceImpl中的
 				getDownloadListString(String contextPath, String guid,String bool, String appType)生成的HTML产生
 		*/
          function deleteFile(fileId,guid,isDelete,isEdit,appType){		
 			var boolFlag=window.confirm("确认删除吗?");
 			if(boolFlag==true)
 			{
 				//alert(guid);	
 				send('${contextPath}/commons/file/delFile.action?fileId='+fileId+'&&deletePermission='+isDelete+'&&isEdit='+isEdit+'&&guid='+guid+'&&appType=0',guid);
 			}
 		}

</script>
<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
<script type="text/javascript" src="${contextPath}/resources/csswin/subModal.js"></script>
<SCRIPT type="text/javascript" src="${contextPath}/scripts/calendar.js"></SCRIPT>
<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
<head>
<title><s:property value="#title"/></title>
<s:head/>
</head>



<body>
<center>
<s:form id="myform"  action="save" namespace="/code/rule/codeRule" >
	
<table cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
	


<tr  >
<td class="EditHead">

业务表名:</td><!--标题栏-->
<td class="editTd">
<s:textfield  cssClass="noborder" name="codeRule.rule_table_name" cssStyle="width:90%"/><!--一般文本框-->

</td>
</tr>



	


<tr  >
<td class="EditHead">


业务字段描述:</td><!--标题栏-->
<td>
<s:textfield   cssClass="noborder" name="codeRule.rule_field_desc" cssStyle="width:90%"/><!--一般文本框-->

</td>
</tr>



	


<tr >
<td class="EditHead">

字段名:</td><!--标题栏-->
<td class="editTd">
<s:textfield  cssClass="noborder"  name="codeRule.rule_field_name" cssStyle="width:90%"/><!--一般文本框-->

</td>
</tr>



	


<tr  >
<td class="EditHead">

字段类型:</td><!--标题栏-->
<td class="editTd">
<s:textfield    cssClass="noborder" name="codeRule.rule_field_type" cssStyle="width:90%"/><!--一般文本框-->

</td>
</tr>



	


<tr>
<td class="EditHead">

字段宽度:</td><!--标题栏-->
<td class="editTd">
<s:textfield   cssClass="noborder"  name="codeRule.rule_field_length" cssStyle="width:90%"/><!--一般文本框-->

</td>
</tr>



	


<tr >
<td class="EditHead">

公式:</td><!--标题栏-->
<td class="editTd">
<s:textfield  cssClass="noborder"  name="codeRule.rule_formula" cssStyle="width:90%"/><!--一般文本框-->

</td>
</tr>



	
</table>


<s:hidden name="codeRule.id"/> 
<a class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="saveForm();">保存</a>&nbsp;&nbsp;
<a class="easyui-linkbutton" data-options="iconCls:'icon-undo'" onclick="backList();">返回列表</a>&nbsp;&nbsp;

</s:form>

</center>
</body>
</html>
