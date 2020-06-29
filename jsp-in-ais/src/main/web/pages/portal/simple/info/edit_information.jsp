<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://fckeditor.net/tags-fckeditor" prefix="FCK"%>
<html>
	
	<head><meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
	<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
	<script type="text/javascript" src="${contextPath}/scripts/validate.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/csswin/subModal.js"></script>
	<script type='text/javascript' src='${pageContext.request.contextPath}/scripts/dwr/DWRActionUtil.js'></script>
	<script type='text/javascript' src='${pageContext.request.contextPath}/dwr/interface/DWRAction.js'></script>
	<script type='text/javascript' src='${pageContext.request.contextPath}/dwr/engine.js'></script>
	<script type="text/javascript" src="${contextPath}/scripts/swfload/uploadFile.js"></script>
	
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
	
	<title></title>
		<script language="javascript">
		String.prototype.gblen = function() {  
		    var len = 0;  
		    for (var i=0; i<this.length; i++) {  
		         if (this.charCodeAt(i)>127 || this.charCodeAt(i)==94) {  
		             len += 2;  
		         } else {  
		             len ++;  
		         }  
		     }  
		     return len;  
		 }
		function saveForm(){
			//var bool = true;//提交表单判断参数
			//非空校验
		 	//bool=frmCheck(document.forms[0],'portalTab');
		 	var tit = document.getElementsByName("information.title")[0].value;
		 	var infk = document.getElementsByName("information.infkey")[0].value;
		 	if(tit == null || tit == ''){
		 		showMessage1('标题不能为空！');
		 		return false;
		 	}
		 	if(infk == null || infk == ''){
		 		showMessage1('关键字不能为空！');
		 		return false;
		 	}
			//提交表单
			//if(bool){
			num2=document.getElementsByName("information.customSort")[0].value;
			if(!isDigit(num2)){
				showMessage1("优先级 只能是数字!");
				return false;
			}
			<s:if test="information.type==@ais.portal.simple.model.Information@HOTLINK">
				if(!isURL(document.getElementsByName('information.infkey')[0].value)){showMessage1("请输入正确的网址,例如 http(ftp)://www.xxx.com");return false;}
			</s:if>
			<s:elseif test="information.type==@ais.portal.simple.model.Information@FEEDBACK">
				if(!isMail(document.getElementsByName('information.infkey')[0].value)){showMessage1("email 地址格式不正确,请重新输入");return false;}
			</s:elseif>
			if(document.getElementsByName('information.infkey')[0].value.length>200){
				<s:if test="information.type==@ais.portal.simple.model.Information@HOTLINK">
					showMessage1("网址长度超长");
				</s:if>
				<s:elseif test="information.type==@ais.portal.simple.model.Information@FEEDBACK">
					showMessage1("Email长度超长");
				</s:elseif>
				<s:else>
					showMessage1("关键字长度超长");
				</s:else>
				return false;
			}
			try{
				if(document.getElementsByName('information.title')[0].value.length>100){showMessage1("标题过长!");return false;}
				var oEditor = FCKeditorAPI.GetInstance('information.content'); 
				var msg = oEditor.GetXHTML( true );
				if(msg.gblen()>8000){
					showMessage1("内容不能超过8000字！请考虑将内容存为word或者文本文件当做附件上传。");
					return false;
				}
			}catch(e){}
			$.messager.confirm('提示信息','确认提交吗？',function(isSave){
				if(isSave){
					var url = "${contextPath}/portal/simple/information/saveByType.action";
					myform.action = url;
					myform.submit();
				}
			});
			//}
		}
		function isDigit(s) { var patrn=/^[0-9]{1,4}$/; if (!patrn.exec(s)) return false; return true; }
		function isURL(str) {
			return (new RegExp(/^http|ftp:\/\/[\w-]+(\.[\w-]+)+([\w-\.\/?%&=]*)?$/).test(str));
		}
		
		function m_publish(message){
			$.messager.confirm('提示信息',message,function(isSave){
				if(isSave){
					url="<%=request.getContextPath()%>/portal/simple/information/publishByType.action?information.id=${information.id}&information.type=${information.type}";
					window.location=url;
				}
			});
		}
		/*DWR2删除附件回传附件列表---LIHAIFENG 2007-12-20*/
	function deleteFile(fileId,guid,isDelete,isEdit,appType){
		$.messager.confirm('提示信息','确认删除吗?',function(isSave){
			if(isSave){
				DWREngine.setAsync(false);DWRActionUtil.execute(
				{ namespace:'/commons/file', action:'delFile', executeResult:'false' }, 
				{'fileId':fileId, 'deletePermission':isDelete, 'isEdit':isEdit, 'guid':guid, 'appType':appType},
				xxx);
				function xxx(data){
					if(guid=='${information.uuid2}'){
				  	document.getElementById("accelerys2").innerHTML=data['accessoryList'];
					}else{
				  	document.getElementById("accelerys").innerHTML=data['accessoryList'];
					}
				} 
			}
		});
	}
	function openDialog(){
		//alert("image");
	    //定义只能上传的附件格式"image/pjpeg";
	    var checkFileType = "image";
	    var sideRemark = "提示:图片大小：width = 174px;height = 175px;";
	    var title="新闻图片";
		var num=Math.random();
		var rnm=Math.round(num*9000000000+1000000000);//随机参数清除模态窗口缓存
		window.showModalDialog('${contextPath}/commons/file/welcome.action?table_name=portal_information&table_guid=uuid&guid=${information.uuid}&&param='+rnm+'&&title='+encodeURIComponent(encodeURIComponent(title))+'&&isEdit=false&&deletePermission=<s:property value="true"/>&&sideRemark='+encodeURIComponent(encodeURIComponent(sideRemark))+'&&checkFileType='+encodeURIComponent(encodeURIComponent(checkFileType)),accelerys,'dialogWidth:700px;dialogHeight:450px;status:yes');
	}
	function openDialog2(){
	    //定义只能上传的附件格式"image/pjpeg";
	    var checkFileType = "image";
	    var sideRemark = "提示:图片大小：width = 174px;height = 175px;";
	    var title="友情链接";
		var num=Math.random();
		var rnm=Math.round(num*9000000000+1000000000);//随机参数清除模态窗口缓存
		window.showModalDialog('${contextPath}/commons/file/welcome.action?table_name=portal_information&table_guid=uuid&guid=${information.uuid}&&param='+rnm+'&&title='+encodeURIComponent(encodeURIComponent(title))+'&&isEdit=false&&deletePermission=<s:property value="true"/>',accelerys,'dialogWidth:700px;dialogHeight:450px;status:yes');
	}
	function openDialog3(){
	    //定义只能上传的附件格式"image/pjpeg";
	    var checkFileType = "image";
	    var sideRemark = "提示:图片大小：width = 174px;height = 175px;";
	    var title="意见反馈";
		var num=Math.random();
		var rnm=Math.round(num*9000000000+1000000000);//随机参数清除模态窗口缓存
		window.showModalDialog('${contextPath}/commons/file/welcome.action?table_name=portal_information&table_guid=uuid&guid=${information.uuid}&&param='+rnm+'&&title='+encodeURIComponent(encodeURIComponent(title))+'&&isEdit=false&&deletePermission=<s:property value="true"/>',accelerys,'dialogWidth:700px;dialogHeight:450px;status:yes');
	}
	function openDialog_file(){//审计新闻附件上传
	    //定义只能上传的附件格式"image/pjpeg";
		var contextPath = '${contextPath}';
		var table_name = 'portal_information';
		var table_guid = 'uuid';
		var guid = '${information.uuid2}';
		var deletePermission = 'true';
		var isEdit = 'true';
		var divIdName = 'accelerys2';
		var title = '附件信息'
		var width = 500;
		var height = 450;
		uploadFile(contextPath,table_name,table_guid,guid,deletePermission,isEdit,divIdName,title,width,height);
	}
	function changeIsAppoint(){
		try{
			var isAppoint = document.getElementsByName('information.isAppoint')[0].checked;
			var pae1 = document.getElementById('appointTD1');
			var pae2 = document.getElementById('appointTD2');
			
			changeDisabledStatus(pae1,isAppoint);
			changeDisabledStatus(pae2,isAppoint);
			if(isAppoint){
				pae1.parentElement.style.display = '';
				pae2.parentElement.style.display = '';
			}else{
				pae1.parentElement.style.display = 'none';
				pae2.parentElement.style.display = 'none';
			}
		}catch(e){}
	}
	function changeDisabledStatus(pae,isAppoint){
		for(var i=0;i<pae.childNodes.length;i++){
			if(pae.childNodes[i].nodeName=='IMG'||pae.childNodes[i].nodeName=='INPUT'){
				if(isAppoint){
					pae.childNodes[i].disabled = false;
				}else{
					pae.childNodes[i].disabled = true;
				}
			}
		}
	}
	</script>
	</head>
	<body onload="changeIsAppoint()"  class="easyui-layout">
		<center>

			<table cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
				<tr >
					<td colspan="5" class="EditHead">
						<% 
							request.setAttribute("mytitle","");
						%>
		<font style="float: left;">
	<s:property escape="false" value="@ais.framework.util.NavigationUtil@getNavigation('/ais/portal/simple/information/listByType.action?information.type=${information.type}','维护${mytitle}')"/>
		</font>
					</td>
				</tr>
			</table>
			<s:form id="myform" name="myform" action="/portal/simple/information/saveByType.action" enctype="multipart/form-data" method="post">
				<table id="portalTab" cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable" >
					<tr >
						<td class="EditHead">
							<font color="red">*</font>&nbsp;标题
						</td>
						<td class="editTd" style="width:30%" nowrap="nowrap" colspan='3'>
							<s:textfield cssClass="noborder" maxlength="60" size="71" name="information.title" />
						</td>
						
					</tr>
					<tr >
						<td class="EditHead">
							<s:if test="information.type==@ais.portal.simple.model.Information@HOTLINK">
								网址				
							</s:if>
							<s:elseif test="information.type==@ais.portal.simple.model.Information@FEEDBACK">
								Email
							</s:elseif>
							<s:else>
								<font color="red">*</font>&nbsp;关键字
							</s:else>
							
						</td>
						<td class="editTd" style="width:30%" nowrap="nowrap">
							<s:textfield cssClass="noborder" name="information.infkey" size="35"/>
							<!--一般文本框-->
						</td>
						<td class="EditHead">
						<s:if test="${information.type!='7' and information.type!='11'}">
							优先级
						</s:if>
						</td>
						<td class="editTd" style="width:30%" nowrap="nowrap">
						<s:if test="${information.type!='7' and information.type!='11'}">
							<s:textfield cssClass="noborder" name="information.customSort" />
						</s:if>
						<s:else>
							<s:hidden name="information.customSort" />
						</s:else>
						</td>
					</tr>
					<s:if test="information.type!=@ais.portal.simple.model.Information@HOTLINK && information.type!=@ais.portal.simple.model.Information@DEPTDES">
					<tr >
						<td class="EditHead">限定受众
						</td>
						<td class="editTd" colspan="3">
							<s:checkbox name="information.isAppoint" onclick="changeIsAppoint()"></s:checkbox>
							<font color="blue">选中限定受众，使发布的信息只能被选择的对象浏览！</font>
						</td>
					</tr>	
					<tr >
						<td class="EditHead">
							限定受众-个人
						</td>
						<td class="editTd" style="width:30%" id="appointTD1" valign="center" colspan="3">
							<s:buttonText cssClass="noborder"
								name="information.acceptorString.userNames"
								doubleOnclick="showPopWin('/pages/system/search/mutiselect.jsp?url=/pages/system/userindex.jsp&paraname=information.acceptorString.userNames&paraid=information.acceptorString.users&p_issel=1',600,350)" 
								doubleSrc="/easyui/1.4/themes/icons/search.png"
								doubleCssStyle="cursor:hand;border:0" 
								readonly="true" 
								doubleDisabled="false" size="60"/>
							<s:hidden name="information.acceptorString.users"></s:hidden>
						</td>
					</tr>				
					<tr >
						<td class="EditHead">
							限定受众-部门
						</td>
						<td class="editTd" style="width:30%" id="appointTD2" valign="center" colspan="3">
							
							<s:buttonText  cssClass="noborder"
								name="information.acceptorString.orgNames" 
								doubleOnclick="showPopWin('/pages/system/search/searchdatamuti.jsp?url=/system/uSystemAction!orgList4muti.action&paraname=information.acceptorString.orgNames&paraid=information.acceptorString.orgs',600,350)" 
								doubleSrc="/easyui/1.4/themes/icons/search.png"
								doubleCssStyle="cursor:hand;border:0" 
								readonly="true" 
								doubleDisabled="false" size="60"/>
							<s:hidden name="information.acceptorString.orgs"></s:hidden>
						</td>
					</tr>
					<tr >
						<td class="EditHead">
							发布状态
						</td>
						<td style="width:30%" id="td_pub" class="editTd" valign="center" colspan="3">
							${information.infstatus}
						</td>
					</tr>
					</s:if>
					<s:if test="information.type!=@ais.portal.simple.model.Information@HOTLINK">
					<tr >
						<td colspan="4" class="EditHead" style='text-align:center;'>
						<font style='text-align:center;'>
							内容
						</font>	
						</td>
					</tr>
						<tr >
							<td class="editTd" colspan="4" style="width:100%">
							<s:if test="information.type!=@ais.portal.simple.model.Information@DEPTDES && information.type!=@ais.portal.simple.model.Information@FEEDBACK">
							<FCK:editor id="information.content" basePath="/ais/resources/fckedit/" height="300" toolbarSet="cnn2" tabSpaces="1"
								imageBrowserURL=" /ais/resources/fckedit/editor/filemanager/browser/default/browser.html?Type=Image&Connector=/ais/editor/filemanager/browser/default/connectors/jsp/connector" 
								linkBrowserURL=" /ais/resources/fckedit/editor/filemanager/browser/default/browser.html?Connector=/ais/editor/filemanager/browser/default/connectors/jsp/connector" 
								linkUploadURL=" /ais/editor/filemanager/upload/simpleuploader?Type=Image"
								imageUploadURL=" /ais/editor/filemanager/upload/simpleuploader?Type=Image">
										${information.content}
								</FCK:editor>
							</s:if>
							<s:else>
								<textarea class="noborder" rows="30" cols="60" name="information.content" style="width: 100%">${information.content}</textarea>
							</s:else>
							
							</td>
						</tr>
					</s:if>
				</table>
				<div id="accelerys" align="center">
					<s:property escape="false" value="accessoryList"/>
				</div>
				<div id="accelerys2" align="center">
					<s:property escape="false" value="filesList" />
				</div>
				<s:hidden name="information.id" />
				<s:hidden name="information.category2_name" value="${information.category2_name}"/>
                <s:hidden name="information.category2_code" value="${information.category2_code}"/>
				<s:hidden name="information.type" value="${information.type}"/>
				<s:hidden name="information.createdate" value="${information.createdate}"/>
				<s:hidden name="information.fcompanyid" value="${information.fcompanyid}"/>
				<s:hidden name="information.fcompanyname" value="${information.fcompanyname}"/>
				<s:hidden name="information.infstatus"/>
				<s:hidden name="information.create_man" />	
				<s:hidden name="information.createManName" />	
				<s:if test="${empty(information.is_pub)}">
					<s:hidden name="information.is_pub" value="N"/>
				</s:if>
				<s:else>
					<s:hidden name="information.is_pub" />				
				</s:else>
					
				<s:hidden name="information.publisher_name" />	
				<s:hidden name="information.publisher_code" />
				<s:hidden name="information.uuid2"/>
				<s:if test="information.type==@ais.portal.simple.model.Information@DEPINF">
					<s:if test="${information.is_pub=='N'}">
						<a class="easyui-linkbutton" data-options="iconCls:'icon-edit'" name="fabu"  onclick="m_publish('确定审批?');">审批</a>&nbsp;&nbsp;
					</s:if>
					<s:elseif test="information.is_pub==@ais.portal.simple.util.Constant@APPROVAL">
						<a class="easyui-linkbutton" data-options="iconCls:'icon-save'" name="fabu"  onclick="m_publish('确定发布?');">发布</a>&nbsp;&nbsp;
					</s:elseif>	
				</s:if>
				<s:else>	
					<s:if test="${information.is_pub!='N'}">
						<s:if test="information.type==@ais.portal.simple.model.Information@HOTLINK">
						<%--<s:button name="fabu" value="发布" onclick="m_publish('确定发布?');"/>--%>&nbsp;&nbsp;
						</s:if>
					</s:if>	
				</s:else>	
				<%--<s:if test="information.type==@ais.portal.simple.model.Information@NEWS or information.type==@ais.portal.simple.model.Information@TRENDS or information.type==@ais.portal.simple.model.Information@HOTLINK or information.type==@ais.portal.simple.model.Information@FEEDBACK">--%>
					<%--<s:hidden name="information.uuid"/>--%>
					<%--<s:if test="information.type==@ais.portal.simple.model.Information@TRENDS">--%>
						<%--<s:button  onclick="openDialog()" value="添加动态图片"></s:button>&nbsp;--%>
					<%--</s:if>--%>
					<%--<s:elseif test="information.type==@ais.portal.simple.model.Information@HOTLINK">--%>
					<%--<!-- --%>
						<%--<s:button  onclick="openDialog2()" value="添加友情链接图片"></s:button>&nbsp; -->--%>
					<%--</s:elseif>--%>
					<%--<s:elseif test="information.type==@ais.portal.simple.model.Information@FEEDBACK">--%>
						<%--<s:button  onclick="openDialog3()" value="添加意见反馈图片"></s:button>&nbsp;--%>
					<%--</s:elseif>--%>
					<%--<s:elseif  test="information.type==@ais.portal.simple.model.Information@NEWS">--%>
						<%--<s:button  onclick="openDialog()" value="添加新闻图片"></s:button>&nbsp;--%>
					<%--</s:elseif>--%>
				<%--</s:if>--%>
<%--
				<a  onclick="openDialog_file()" class="easyui-linkbutton" data-options="iconCls:'icon-upload'" value="上传附件">上传附件</a>&nbsp;
--%>
				<a  onclick="saveForm();" class="easyui-linkbutton" data-options="iconCls:'icon-save'" >保存</a>
				<a class="easyui-linkbutton" data-options="iconCls:'icon-undo'" onclick="javascript:window.location='${contextPath}/portal/simple/information/listByType.action?information.type=${information.type}';">返回</a>
			</s:form>

		</center>
	</body>
</html>
