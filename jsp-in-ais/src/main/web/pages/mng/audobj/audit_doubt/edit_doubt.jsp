<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<html>
<head><title>审计疑点</title>
<link href="${contextPath}/styles/main/ais.css" rel="stylesheet" type="text/css">
		<link rel="stylesheet" type="text/css"
			href="${contextPath}/resources/csswin/subModal.css" />
		<script type="text/javascript"
			src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript"
			src="${contextPath}/resources/csswin/subModal.js"></script>
		<SCRIPT type="text/javascript"
			src="${contextPath}/scripts/calendar.js"></SCRIPT>
		<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>					
		<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
</head>
<script>
function Upload(id,filelist)
	{
		var guid=document.getElementById(id).value;
		var num=Math.random();
		var rnm=Math.round(num*9000000000+1000000000);//随机参数清除模态窗口缓存
		window.showModalDialog('${contextPath}/commons/file/welcome.action?table_name=mng_audit_doubt&table_guid=doubt_file&guid='+guid+'&&param='+rnm+'&&deletePermission=true',filelist,'dialogWidth:700px;dialogHeight:450px;status:yes');
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
 				window.alert("删除成功！");
 				}else{
 					window.alert("所请求的页面有异常！");
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
 		
 		function verifyContent(){
 			if('<s:property value="auditDoubt.is_verify"/>'=='否'){
 				document.getElementById('auditDoubt.verify_man').value='<s:property value="user.fname"/>';
 				document.getElementById('auditDoubt.verify_man_dept').value='<s:property value="org.fname"/>';
 			}
 				document.getElementById('verify').style.display="block";

 		}
 		function hideVerify(){
 				document.getElementById('verify').style.display="none";
 		}
 		function initForm(){
 			if('<s:property value="auditDoubt.is_verify"/>'=='是'){
 				document.getElementById('verify').style.display="block";
 				document.getElementsByName('auditDoubt.is_verify')[0].checked="true";		
 			}
 		} 	
</script>
<style>

</style>
<body onload="initForm()">
<center>
<s:form action="save" onsubmit="return frmCheck(document.forms[0],'tab1');" >
<s:hidden name="addOrEdit" />
				<table id='tab1' cellpadding=0 cellspacing=1 border=0 bgcolor="#409cce" class="ListTable">
					<tbody>
					<tr>
						<td class="ListTableTr11">
							疑点名称
							<font color=red>*</font>
						</td>
						<td class="ListTableTr22" colspan="3">
							<s:textfield cssStyle="width:100%" name="auditDoubt.doubt_name" maxlength="50"></s:textfield>
						</td>
			
					</tr>
					<tr>
						<td class="ListTableTr11">
							<s:button onclick="Upload('auditDoubt.doubt_file',doubtFileList)" value="疑点附件"></s:button>
							<s:hidden name="auditDoubt.doubt_file"/>
						</td>
						<td class="ListTableTr22" colspan="3">
							<div id="doubtFileList" align="center">
								<s:property escape="false" value="doubtFileList" />
							</div>
							
						</td>
					</tr>
					<tr>
						<td class="ListTableTr11">
							发现人
						</td>
						<td class="ListTableTr22">
							<s:textfield cssStyle="width:100%" name="auditDoubt.founder" readonly="true"></s:textfield>
						</td>
						<td class="ListTableTr11">
							发现单位
						</td>
						<td class="ListTableTr22">
							<s:textfield cssStyle="width:100%" name="auditDoubt.founder_dept" readonly="true"></s:textfield>
						</td>						
					</tr>
					<tr>
						<td class="ListTableTr11">
							发现日期
						</td>
						<td class="ListTableTr22">
							<s:textfield name="auditDoubt.founder_date" readonly="true"
								cssStyle="width:100%" maxlength="20" title="单击选择日期"
							onclick="calendar()"></s:textfield>
						</td>
						<td class="ListTableTr11" colspan="2">
						</td>						
					</tr>
					<s:if test="addOrEdit!='add'">
					<tr>
						<td class="ListTableTr11" colspan="4">
							是否核实 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<input type="radio" name="auditDoubt.is_verify" onclick="verifyContent()" value="是" />是
							<input type="radio" name="auditDoubt.is_verify" onclick="hideVerify()" value="否" checked="true"/>否					
						</td>						
					</tr>
					</s:if>					
					</tbody>
					<tbody style="display:none" id="verify">
					<tr>
						<td class="ListTableTr11">
							核实日期
						</td>
						<td class="ListTableTr22">
							<s:textfield name="auditDoubt.verify_date" readonly="true"
								cssStyle="width:100%" maxlength="20" title="单击选择日期"
							onclick="calendar()"></s:textfield>
						</td>
						<td class="ListTableTr11">
							核实人
						</td>
						<td class="ListTableTr22">	
						<s:textfield cssStyle="width:100%" name="auditDoubt.verify_man" readonly="true"></s:textfield>				
						</td>						
					</tr>	
					<tr>
						<td class="ListTableTr11">
							核实人单位
						</td>
						<td class="ListTableTr22" colspan="3">
						<s:textfield cssStyle="width:100%" name="auditDoubt.verify_man_dept" readonly="true"></s:textfield>							
						</td>
					</tr>
					<tr>
						<td class="ListTableTr11">
							核实所在项目
						</td>
						<td class="ListTableTr22" colspan="3">
						<s:buttonText name="auditDoubt.verify_man_join_project"
								cssStyle="width:90%"
								hiddenName="auditDoubt.verify_man_join_project_id"
								doubleOnclick="window.parent.showPopWin('/pages/system/search/mutiselectForIframe.jsp?url=/mng/audobj/doubt/searchProject.action&paraname=auditDoubt.verify_man_join_project&paraid=auditDoubt.verify_man_join_project_id&iframe=doubt',620,470)"
								doubleSrc="/resources/images/s_search.gif"
								doubleCssStyle="cursor:hand;border:0"
								readonly="true" doubleDisabled="false"/>
						</td>
												
					</tr>
					<tr>
						<td class="ListTableTr11">
							<s:button onclick="Upload('auditDoubt.doubt_verify_file',doubtVerifyList)" value="审核附件"></s:button>
							<s:hidden name="auditDoubt.doubt_verify_file"/>
						</td>
						<td class="ListTableTr22" colspan="3">
							<div id="doubtVerifyList" align="center">
								<s:property escape="false" value="doubtVerifyList" />
							</div>
							
						</td>
					</tr>
					</tbody>
																																										
				</table>
				
	
				
				
<s:hidden name="auditDoubt.doubt_id"/>  
<s:hidden name="auditDoubt.object_id"/>
<s:submit value="保存"/>&nbsp&nbsp&nbsp&nbsp
<input type="button" name="back" value="返回" onclick="javascript:window.location='<s:url action="list"><s:param name="auditDoubt.object_id" value="%{auditDoubt.object_id}"/></s:url>'">
</s:form>

</center>
</body>
</html>