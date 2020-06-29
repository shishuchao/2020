
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://fckeditor.net/tags-fckeditor" prefix="FCK"%>
<s:if test="id == 0"> 
	<s:text id="title" name="'添加培训'"></s:text>
</s:if>
<s:else>
    <s:text id="title" name="'修改培训'"></s:text>
</s:else>



<html>
<script language="javascript">
             
function backList(){
	myform.action = "${contextPath}/mng/train/list.action";
	myform.submit();
}



//模板生成----------保存表单
function saveForm(){
var bool = true;//提交表单判断参数
//非空校验
 

	
 
	
 
	
var v_3 = "train.course_title";  // field
var title_3 = '课程名称';// field name
var notNull = 'true'; // notnull
	           if(document.getElementsByName(v_3)[0].value=="" && notNull=="true"　&& notNull != "")
		           {
				         window.alert(title_3+"不能为空!");
				         bool = false;
				         return false;
		           }


var v_3 = "train.trained_staff";  // field
var title_3 = '适用人员';// field name
var notNull = 'true'; // notnull
	           if(document.getElementsByName(v_3)[0].value=="" && notNull=="true"　&& notNull != "")
		           {
				         window.alert(title_3+"不能为空!");
				         bool = false;
				         return false;
		           }

var v_3 = "train.staff_str";  // field
var title_3 = '适用人员描述';// field name
var notNull = 'true'; // notnull
	           if(document.getElementsByName(v_3)[0].value=="" && notNull=="true"　&& notNull != "")
		           {
				         window.alert(title_3+"不能为空!");
				         bool = false;
				         return false;
		           }

	
	//保存表单
	if(bool){
	var flag=window.confirm('确认操作吗?');//isSubmit
	if(flag==true){
	var url = "${contextPath}/mng/train/save.action";
	myform.action = url;
	myform.submit();
	}else{
		 	return false;
		 }
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
     function deleteFile(fileId,guid,isDelete,isEdit,appType,title){
		var boolFlag=window.confirm("确认删除吗?");
		if(boolFlag==true)
		{
			DWREngine.setAsync(false);DWRActionUtil.execute(
		{ namespace:'/commons/file', action:'delFile', executeResult:'false' }, 
		{'fileId':fileId, 'deletePermission':isDelete, 'isEdit':isEdit, 'guid':guid, 'appType':appType,'title':title},
		xxx);
		function xxx(data){
		  	document.getElementById(guid).parentElement.innerHTML=data['accessoryList'];
		} 
		}
	}
</script>
<link href="${contextPath}/styles/main/ais.css" rel="stylesheet" type="text/css">
<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css"/>
           <!-- 引入dwr的js文件 -->
		<script type='text/javascript' src='/ais/js/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='/ais/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='/ais/dwr/engine.js'></script>
		<script type='text/javascript' src='/ais/dwr/util.js'></script>
<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
<script type="text/javascript" src="${contextPath}/resources/csswin/subModal.js"></script>
<SCRIPT type="text/javascript" src="${contextPath}/scripts/calendar.js"></SCRIPT>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
<title><s:property value="#title"/></title>
<s:head/>
</head>



<body>
<center>

<table>
	<tr class="listtablehead"><td colspan="5" align="left" class="edithead"><s:property value="#title"/></td></tr>
</table>

<s:form id="myform"  action="save" namespace="/mng/train" >
	
<table cellpadding=1 cellspacing=1 border=0 bgcolor="#409cce" class="ListTable">
	




	


<tr  class="titletable1">
<td style="width:20%">

 

&nbsp;&nbsp;&nbsp;发布人:</td><!--标题栏-->
 

<td style="width:30%">&nbsp;&nbsp;&nbsp;<s:property value="train.train_publisher"/>
<s:hidden name="train.train_publisher_id"/>
<s:hidden name="train.train_publisher"/>
</td>

<td style="width:20%">

 

&nbsp;&nbsp;&nbsp;发布单位:</td><!--标题栏-->



<td style="width:30%">&nbsp;&nbsp;&nbsp;

<s:property value="train.train_dept"/>
<s:hidden name="train.train_dept_id"/>
<s:hidden name="train.train_dept"/>
                 
</td>
</tr>



	


<tr  class="titletable1">
<td>

<font color="red">*</font>

课程名称:</td><!--标题栏-->
<td>
<s:textfield  name="train.course_title" cssStyle="width:80%"/><!--一般文本框-->

</td>

<td>

<font color="red">*</font>


 

适用人员:</td>
<td>


 <s:buttonText name="train.trained_staff"
							cssStyle="width:80%" hiddenName="train.trained_staff_id"
							doubleOnclick="showPopWin('/pages/system/search/searchdatamuti.jsp?url=/system/uSystemAction!orgList4muti.action&paraname=train.trained_staff&paraid=train.trained_staff_id',600,450)"
							doubleSrc="/resources/images/s_search.gif"
							doubleCssStyle="cursor:hand;border:0"
							readonly="true"
							display="true"
							doubleDisabled="false" /><!--人员多选-->
</td></tr>
	


<tr  class="titletable1">


<td>

<font color="red">*</font>

发布日期:</td>
<td>
<s:property  value="train.release_date" />
<s:hidden  name="train.release_date" />
</td>

<td>

<font color="red">*</font>

适用人员描述:</td><!--标题栏-->
<td>
<s:textfield  name="train.staff_str" cssStyle="width:80%"/><!--一般文本框-->

</td>

</tr>



               <!--空的数据,不显示在页面-->			
							


     <!--正文-->
      <tr>
						<td  class="titletable1">									
							&nbsp;&nbsp;&nbsp;正文
						</td>
						<td  class="titletable1" colspan="3">
							 
						</td>
						 
		   </tr>	
           <tr>
						 
						<td class="ListTableTr22" colspan="4">
						
						    <FCK:editor id="train.content" basePath="/ais/resources/fckedit/" height="300" toolbarSet="myDefault">
									${train.content}
								</FCK:editor>
						
							 <!-- s:textarea name="train.content" cssStyle="width:100%;height:90;"/> -->
						 
						</td>
		   </tr>	
           

	


            <!--是否启用附件列表和按钮,这里提供的是一般附件上传,如果有特殊的附件上传,单独添加-->
           <tr>
						<td class="ListTableTr11">									
							<s:button onclick="Upload('train.file_id',file_idList,'true','true')" value="上传附件" ></s:button>						
							<s:hidden name="train.file_id"/>
						</td>
						<td class="ListTableTr22" colspan="3">
							<div id="file_idList" align="center">
								<s:property escape="false" value="file_idList" />
							</div>
							
						</td>
		   </tr>	
           

         


	
</table>


<s:hidden name="train.id"/> 
<s:button  value="保存" onclick="saveForm();"/>&nbsp;&nbsp;

<s:button  value="返回" onclick="backList();"/> 
</s:form>

</center>
</body>
</html>
