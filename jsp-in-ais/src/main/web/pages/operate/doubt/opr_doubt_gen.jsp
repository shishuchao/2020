
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://fckeditor.net/tags-fckeditor" prefix="FCK"%>
<s:if test="newDoubt_type == 'BW'">
	<s:if test="doubt_id == null">
		<s:text id="title" name="'生成备忘'"></s:text>
	</s:if>
	<s:else>
		<s:text id="title" name="'生成备忘'"></s:text>
	</s:else>
</s:if>

<s:if test="newDoubt_type == 'YD'">
	<s:if test="doubt_id == null">
		<s:text id="title" name="'生成疑点'"></s:text>
	</s:if>
	<s:else>
		<s:text id="title" name="'生成疑点'"></s:text>
	</s:else>
</s:if>

<s:if test="newDoubt_type == 'FX'">
	<s:if test="doubt_id == null">
		<s:text id="title" name="'生成发现'"></s:text>
	</s:if>
	<s:else>
		<s:text id="title" name="'生成发现'"></s:text>
	</s:else>
</s:if>

<s:if test="newDoubt_type == 'DS'">
	<s:if test="doubt_id == null">
		<s:text id="title" name="'生成重大事项'"></s:text>
	</s:if>
	<s:else>
		<s:text id="title" name="'生成重大事项'"></s:text>
	</s:else>
</s:if>



<html>
	<script language="javascript">
	function regu(){
	   window.open('${contextPath}/pages/assist/suport/comsys/view_lawslibFrame.jsp?zuoye=bs','law','height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no');
	}
	
	function law(){
	   win=window.open('${contextPath}/pages/operate/manu/law_redirect.jsp','regu','height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no');if(win && win.open && !win.closed) win.focus();
	}
             
function backList(){
	myform.action = "${contextPath}/operate/doubt/search.action?type=${type}&pro_id=${pro_id}";
	myform.submit();
}



//模板生成----------保存表单
function saveGen(){

  var v_3 = "audDoubt.doubt_name";  // field
var title_3 = '名称';// field name 
var notNull = 'true'; // notnull
	           if(document.getElementsByName(v_3)[0].value=="" && notNull=="true"　&& notNull != "")
		           {
				         window.alert(title_3+"不能为空!");
				         bool = false;
				         document.getElementById(v_3).focus();
				         return false;
		           }
                 if(document.getElementsByName(v_3)[0].value.replace(/\s+$|^\s+/g,"")==""){
                        window.alert(title_3+"不能为空!");
				         bool = false;
				         document.getElementById(v_3).focus();
				         return false;
                   }

var url = "${contextPath}/operate/doubt/saveGen.action";
myform.action = url;
	myform.submit();
	//closeGenM();
	 //window.top.frames['childBasefrm'].location.href="/ais/operate/task/showContent.action?&type="+type+"&taskPid="+taskPid+"&taskId="+id+"&pro_id=<%=request.getParameter("pro_id")%>";
}

//删除
 function deleteGen()
 
		  {
		  	if(confirm("确认删除这条记录?")){
				myform.action = "${contextPath}/operate/doubt/deleteGen.action";
	            myform.submit();
	            closeGenM();
	      }
	                    
	} 

function closeGenM(){
 //alert("123");
 //var dd = window.dialogArguments;
 
 //dd.closeGenW();
 window.parent.closeGenW('${newDoubt_type}');
 window.close()
}

function saveForm1(){
var bool = true;//提交表单判断参数
//非空校验
 

	
 
	
 
	
var v_3 = "doubt.course_title";  // field
var title_3 = '课程名称';// field name
var notNull = 'true'; // notnull
	           if(document.getElementsByName(v_3)[0].value=="" && notNull=="true"　&& notNull != "")
		           {
				         window.alert(title_3+"不能为空!");
				         bool = false;
				         return false;
		           }


var v_3 = "doubt.doubted_staff";  // field
var title_3 = '适用人员';// field name
var notNull = 'true'; // notnull
	           if(document.getElementsByName(v_3)[0].value=="" && notNull=="true"　&& notNull != "")
		           {
				         window.alert(title_3+"不能为空!");
				         bool = false;
				         return false;
		           }

var v_3 = "doubt.staff_str";  // field
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
	var url = "${contextPath}/mng/doubt/save.action";
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
			window.showModalDialog('${contextPath}/commons/file/welcome.action?table_name=aud_doubt_operate&table_guid=file_id&guid='+guid+'&param='+rnm+'&deletePermission='+delete_flag+'&isEdit='+edit_flag,filelist,'dialogWidth:700px;dialogHeight:450px;status:yes');
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
	<link href="${contextPath}/styles/main/ais.css" rel="stylesheet"
		type="text/css">
	<link href="${contextPath}/resources/csswin/subModal.css"
		rel="stylesheet" type="text/css" />
	<!-- 引入dwr的js文件 -->
	<script type='text/javascript' src='/ais/js/dwr/DWRActionUtil.js'></script>
	<script type='text/javascript' src='/ais/dwr/interface/DWRAction.js'></script>
	<script type='text/javascript' src='/ais/dwr/engine.js'></script>
	<script type='text/javascript' src='/ais/dwr/util.js'></script>
	<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
	<script type="text/javascript"
		src="${contextPath}/resources/csswin/common.js"></script>
	<script type="text/javascript"
		src="${contextPath}/resources/csswin/subModal.js"></script>
	<SCRIPT type="text/javascript" src="${contextPath}/scripts/calendar.js"></SCRIPT>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title><s:property value="#title" />
		</title>
		<s:head />
	</head>



<body>
		<center>


			<s:form id="myform" onsubmit="return true;" action="/ais/operate/doubt" method="post" >

				<table cellpadding=1 cellspacing=1 border=0 bgcolor="#409cce"
					class="ListTable">








					<tr class="titletable1">
						<td style="width: 20%">

							<font color="red">*</font> 名称:
						</td>
						<!--标题栏-->
						<td>
							<s:textfield name="audDoubt.doubt_name" cssStyle="width:80%" />
							<!--一般文本框-->

						</td>

						<td style="width: 20%">&nbsp;&nbsp;&nbsp;状态:
						</td>
						<!--标题栏-->



						<td style="width: 30%">
<s:if test="audDoubt.doubt_status == '010'">
	未处理
</s:if>
<s:if test="audDoubt.doubt_status == '020'">
	等待批示
</s:if>
<s:if test="audDoubt.doubt_status == '030'">
	正在审批
</s:if>
<s:if test="audDoubt.doubt_status == '040'">
	审批完毕
</s:if>
<s:if test="audDoubt.doubt_status == '050'">
	已处理
</s:if>

 					<!--  s:property value="audDoubt.doubt_status" /-->
							<s:hidden name="audDoubt.doubt_status" />
						</td>
					</tr>






					<tr class="titletable1">
						<td>

							<font color="red"></font>&nbsp;&nbsp;&nbsp;编码:
						</td>
						<!--标题栏-->
						<td>
						    <s:property value="audDoubt.doubt_code" />
						    <s:hidden name="audDoubt.doubt_code" />
							<!--  s:textfield name="audDoubt.doubt_code" cssStyle="width:80%"/>-->
							<!--一般文本框-->

						</td>

						<td>

							<font color="red"></font>&nbsp;&nbsp;&nbsp;提交人:
						</td>
						<td>
							<s:property value="audDoubt.doubt_author" />
							<s:hidden name="audDoubt.doubt_author_code" />
							<s:hidden name="audDoubt.doubt_author" />
						</td>
					</tr>



					<tr class="titletable1">


						<td>

							<font color="red"></font>&nbsp;&nbsp;&nbsp;所属事项编码:
						</td>
						<td>
							<s:property value="audDoubt.task_code"/>
							<s:hidden name="audDoubt.task_id" />
							<s:hidden name="audDoubt.task_code" />
						</td>

						<td>

							<font color="red"></font>&nbsp;&nbsp;&nbsp;提交日期:
						</td>
						<!--标题栏-->
						<td>
							<s:property value="audDoubt.doubt_date" />
							<s:hidden name="audDoubt.doubt_date" />
							<!--一般文本框-->

						</td>

					</tr>
					<tr class="titletable1">


						<td>

							<font color="red"></font>&nbsp;&nbsp;&nbsp;所属事项名称:
						</td>
						<td>
						    <s:property value="audDoubt.task_name"/>
							<s:hidden name="audDoubt.task_name" />
							<s:hidden name="audDoubt.t_id" />
							<s:hidden name="audDoubt.doubt_type" />
							
								<s:hidden name="audDoubt.doubt_memorandum"/>
	                            <s:hidden name="audDoubt.doubt_found"/>
	                             <s:hidden name="audDoubt.doubt_matters"/>
	                             <s:hidden name="audDoubt.doubt_doubt"/>
	                             <s:hidden name="audDoubt.doubt_manu"/>
						</td>

						<td>

							<font color="red"> </font>

						</td>
						<!--标题栏-->
						<td>

						</td>

					</tr>
					<tr>
						<td class="ListTableTr11" colspan="4">

						</td>

					</tr>
<tr>
						<td class="titletable1">
							&nbsp;&nbsp;&nbsp;关联索引
						</td>
						<td class="titletable1" colspan="3">

						</td>

					</tr>
					<tr>

						<td class="ListTableTr22" colspan="4">

							<!--   <FCK:editor id="doubt.content" basePath="/ais/resources/fckedit/" height="300" toolbarSet="myDefault">
									${doubt.content}
								</FCK:editor> -->

							<table>
								<tr>
								</tr>
							</table>

						</td>
					</tr>
					<tr>
						<td class="titletable1">
							&nbsp;&nbsp;&nbsp;
<s:if test="newDoubt_type == 'BW'">
		 备忘内容 
</s:if>
	 

<s:if test="newDoubt_type == 'YD'">
		 疑点内容 
</s:if>

<s:if test="newDoubt_type == 'FX'">
		 发现内容
	 
</s:if>

<s:if test="newDoubt_type == 'DS'">
	 重大事项内容 
</s:if>

						</td>
						<td class="titletable1" colspan="3">
						</td>

					</tr>
					<tr>

						<td class="ListTableTr22" colspan="4">

						 

							<s:textarea name="audDoubt.doubt_content"
								cssStyle="width:100%;height:70;" />

						</td>
					</tr>
					
										<tr>
						<td class="titletable1">
							&nbsp;&nbsp;&nbsp;疑点描述:
						</td>
						<td class="titletable1" colspan="3">
							 
						</td>

					</tr>
					<tr>

						<td class="ListTableTr22" colspan="4">

							<s:textarea name="audDoubt.describe"
								cssStyle="width:100%;height:70;" />

						</td>
					</tr>
					<tr>
						<td class="titletable1">
							&nbsp;&nbsp;&nbsp;法规制度
						</td>
						<td class="titletable1" colspan="3">
							<input type="button" value="查看法规制度" onclick="law()" />
						</td>

					</tr>
					<tr>

						<td class="ListTableTr22" colspan="4">

							<!--   <FCK:editor id="doubt.content" basePath="/ais/resources/fckedit/" height="300" toolbarSet="myDefault">
									${doubt.content}
								</FCK:editor> -->

							<s:textarea name="audDoubt.audit_law"
								cssStyle="width:100%;height:70;" />

						</td>
					</tr>
					 
					 
				 

					<s:hidden name="audDoubt.audit_regulation" />
 

					<!--是否启用附件列表和按钮,这里提供的是一般附件上传,如果有特殊的附件上传,单独添加-->
					<tr>
						<td class="ListTableTr11">
							<s:button
								onclick="Upload('audDoubt.file_id',file_idList,'true','true')"
								value="上传附件"></s:button>
							<s:hidden name="audDoubt.file_id" />
						</td>
						<td class="ListTableTr22" colspan="3">
							<div id="file_idList" align="center">
								<s:property escape="false" value="file_idList" />
							</div>

						</td>
					</tr>






				</table>

              <s:hidden name="newDoubt_type"/>
				<s:hidden name="audDoubt.doubt_id" />
				<s:hidden name="doubt_id" />
				<s:hidden name="type" />
				<s:hidden name="pro_id" />
			<s:hidden name="taskPid" />
			<s:hidden name="taskId" />
				<s:button value="保存" onclick="saveGen();" />&nbsp;&nbsp;
                <s:button value="删除" onclick="deleteGen();"/>&nbsp;&nbsp;
                <s:button value="关闭" onclick="closeGenM();"/>
			</s:form>

		</center>
	</body>
</html>
