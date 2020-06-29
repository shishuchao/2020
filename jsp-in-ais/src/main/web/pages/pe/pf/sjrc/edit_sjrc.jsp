<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>绩效考核-审计人才考核</title>
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet" type="text/css" />
		<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/csswin/subModal.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/calendar.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
		<script type='text/javascript' src='${contextPath}/pages/pe/validateCommon.js'></script>
		<script type='text/javascript' src='${contextPath}/pages/pe/validate/feng.js'></script>
		<s:head theme="ajax" />
	</head>

	<s:if test="taskInstanceId!=null&&taskInstanceId!=''">
		<body onload="end();">
	</s:if>
		<script type="text/javascript">			
			function toSubmit(act){

				  var  bool  = true;//非空校验				
				  if(bool){				
				   var url = "${contextPath}/pe/pf/sjrc/submit.action"; 				   
				   <s:if test="isUseBpm=='true'">
				   //有jbpm流程的才添加
				if(document.getElementsByName('isAutoAssign')[0].value=='false'||document.getElementsByName('formInfo.toActorId')[0]!=undefined)
				{
										var actor_name=document.getElementsByName('formInfo.toActorId_name')[0].value;
										if(actor_name==''){
											window.alert('下一步处理人不能为空！');
											return false;
										}
								}
					</s:if>
				     var flag =  confirm('确认提交吗?');
				     if(flag){//确认提交
				     		 document.getElementById('submitButton').disabled=true;//禁止重复提交
				             <s:if test="isUseBpm=='true'">
								myform.action="<s:url action="submit" includeParams="none"/>";//有流程提交
							 </s:if>
							 <s:else>
								myform.action="<s:url action="directSubmit" includeParams="none"/>";//没流程提交
							 </s:else>					                  
				                   myform.submit();
				             }else{//不提交
				                  return false;
				                   }
				         }
				}
		</script>
		<body>
		<s:form id="batch_start_form" name="myform" action="save" namespace="/pe/pf/sjrc">
			<table id="planTable" cellpadding=0 cellspacing=1 border=0
				bgcolor="#409cce" class="ListTable" align="center">
				<tr class="listtablehead">
					<td colspan="4" align="left" class="edithead">
						&nbsp;审计人才信息
					</td>
				</tr>
				<tr>
					<td class="ListTableTr11">
						考核对象：
					</td>
					<td class="ListTableTr22">
						<s:textfield  readonly="true" name="o_" value="审计人才"></s:textfield>
					</td>
					<td class="ListTableTr11">
						考核主体：
					</td>
					<td class="ListTableTr22">
						<s:textfield readonly="true" name="m_" value="所在部门"></s:textfield>						
					</td>
				</tr>
				<tr>
					<td class="ListTableTr11">
						考核方式：
					</td>
					<td class="ListTableTr22">
						<s:textfield readonly="true" name="crudObject.peTypeName"></s:textfield>
					</td>
					<td class="ListTableTr11">
						考核周期：
					</td>
					<td class="ListTableTr22">
						<s:textfield readonly="true"  name="crudObject.peRangeValue" ></s:textfield>						
					</td>
				</tr>								
				<tr>
					<td class="ListTableTr11">
						考核体系：
					</td>
					<td class="ListTableTr22">
						<s:textfield readonly="true" name="crudObject.peSytem_name"></s:textfield>
					</td>
					<td class="ListTableTr11">
						人员姓名：
					</td>
					<td class="ListTableTr22">
						<s:textfield readonly="true" name="crudObject.name"></s:textfield>						
					</td>
				</tr>
				<tr>
					<td class="ListTableTr11">
						人才类别：
					</td>
					<td class="ListTableTr22">
						<s:textfield name="crudObject.type"></s:textfield>
					</td>
					<td class="ListTableTr11">
						性别：
					</td>
					<td class="ListTableTr22">
						<s:textfield readonly="true" name="crudObject.sex"></s:textfield>						
					</td>
				</tr>				
				<tr>
					<td class="ListTableTr11">
						所在部门：
					</td>
					<td class="ListTableTr22">
						<s:textfield readonly="true" name="crudObject.department"></s:textfield>
					</td>
					<td class="ListTableTr11">
						现任职务：
					</td>
					<td class="ListTableTr22">
						<s:textfield readonly="true" name="crudObject.duty"></s:textfield>						
					</td>
				</tr>
				<tr>
						<td class="ListTableTr11">
							
							<s:button  
								onclick="Upload()"
								value="上传附件"></s:button>							
						</td>
						<td class="ListTableTr22" colspan="3">
							<div id="projectAnnexList" align="center">
								<s:property escape="false" value="projectAnnexList"/>
							</div>

						</td>
				</tr>												
			</table>
			

	
<fieldset>
			<legend>
				考核信息
			</legend>
<s:div id="div2">
${html}
</s:div>
</fieldset>	
	
			
			
		        <div align="center">
		             <%@include file="/pages/bpm/list_transition.jsp"%>
				</div>
<!-- 要暂存的属性***************************************************begin -->	
    <s:hidden name="crudObject.status"></s:hidden>			
    <s:hidden name="crudObject.formId"></s:hidden>
	<s:hidden name="crudObject.peSytem_id"></s:hidden>
	<s:hidden name="crudObject.peTypeCode"></s:hidden>
	<s:hidden name="crudObject.id"></s:hidden>
	
	

<s:hidden name="crudObject.typeCode"></s:hidden>

<s:hidden name="crudObject.departmentCode"></s:hidden>
<s:hidden name="crudObject.dutyCode"></s:hidden>
<s:hidden name="crudObject.agency"></s:hidden>
<s:hidden name="crudObject.agencyCode"></s:hidden>
	
<s:hidden name="crudObject.year"></s:hidden>
<s:hidden name="crudObject.halfYear"></s:hidden>
<s:hidden name="crudObject.jidu"></s:hidden>
<s:hidden name="crudObject.month"></s:hidden>
<s:hidden name="crudObject.doc_id"></s:hidden>

<!-- 要暂存的属性***************************************************end -->				
				<div align="right" style="width:97%">				
				    <%@include file="/pages/bpm/list_toBeStart.jsp"%>
				    &nbsp;&nbsp;&nbsp;&nbsp;
					<s:submit action="save" value="保 存" title="该操作将保存任务到您的待办列表中，稍后的时间你可以再提交!" />
					&nbsp;&nbsp;&nbsp;&nbsp;
					<!--<s:if test="taskInstanceId!=null&&taskInstanceId!=''">
					<s:button  id="submitButton" title="提交" value="提 交" 	onclick="return toSubmit('toSave')" />
				    &nbsp;&nbsp;&nbsp;&nbsp;
		            </s:if>-->
					<input type="button" value="返回" onclick="javascript:history.go(-1);">
				</div>
		</s:form>
	</body>
	<script type="text/javascript">
  function Upload(){		
		var num=Math.random();
		var rnm=Math.round(num*9000000000+1000000000);//随机参数清除模态窗口缓存		
		window.showModalDialog('${contextPath}/commons/file/welcome.action?table_name=pe_sjrc&table_guid=doc_id&guid=<s:property value="crudObject.doc_id"/>&&param='+rnm+'&&deletePermission=true',projectAnnexList,'dialogWidth:700px;dialogHeight:450px;status:yes');
	    //parent.setAutoHeight();
	}
		
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
 		function deleteFile(fileId,guid,bool,appType){		
 			var boolFlag=window.confirm("确认删除吗?");
 			if(boolFlag==true)
 			{
 				//alert(guid);	
 				send('${contextPath}/commons/file/delFile.action?fileId='+fileId+'&&deletePermission='+bool+'&&guid='+guid+'&&appType='+appType,guid);
 			}
 		}	
	</script>
</html>
