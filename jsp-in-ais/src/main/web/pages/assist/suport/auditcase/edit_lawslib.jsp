<!DOCTYPE HTML>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://fckeditor.net/tags-fckeditor" prefix="FCK"%>
<s:if test="${assistSuportLawslib.id}=='0'">
	<s:text id="title" name="'添加审计案例'"></s:text>
</s:if>
<s:else>
	<s:text id="title" name="'修改审计案例'"></s:text>
</s:else>
<html>
<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
 	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
	<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
	<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
	<script type="text/javascript" src="${contextPath}/resources/js/jquery-fileUpload.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/ueditor/ueditor.config.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/ueditor/ueditor.all.js"></script>
	<title>审计案例</title>
	<!-- <s:property value="#title" /> -->
	<script type="text/javascript">
		$(function(){
			showWin('commonPage','公用弹窗页面');
			$('#assistFile').fileUpload('reloadFile');
		});
		function openDialog() {
			var num=Math.random();
			var rnm=Math.round(num*9000000000+1000000000);//随机参数清除模态窗口缓存
			window.showModalDialog('${contextPath}/commons/file/welcome.action?table_name=assist_suport_lawslib&table_guid=muuid&guid=${assistSuportLawslib.muuid}&&param='+rnm+'&&isEdit=false&&deletePermission=<s:property value="true"/>',accelerys,'dialogWidth:700px;dialogHeight:450px;status:yes');
		}
	
		function deleteFile(fileId,guid,isDelete,isEdit,appType){
			$.message.confirm('提示信息','确认删除吗?',function(isDel){
	 			if(isDel){
	 				DWREngine.setAsync(false);
					DWREngine.setAsync(false);DWRActionUtil.execute(
					{ namespace:'/commons/file', action:'delFile', executeResult:'false' }, 
					{'fileId':fileId, 'deletePermission':isDelete, 'isEdit':isEdit, 'guid':guid, 'appType':appType},
					xxx);
					function xxx(data){
					  	document.getElementById("accelerys").innerHTML=data['accessoryList'];
					} 
	 			}
	 		});
		}
		function publish2(){
	 		top.$.messager.confirm('提示信息','确认发布吗？',function(isPublish){
	 			if(isPublish){
	 				var url = "<%=request.getContextPath()%>/pages/assist/suport/lawsLib/publish.action?ids=${assistSuportLawslib.id}&nodeid=${assistSuportLawslib.categoryFk}&mCodeType=${mCodeType}&listpub=Y";
		 			$.ajax({
		 				url:url,
		 				type:"POST",
		 				async:false,
		 				success:function(){
		 					showMessage1('发布成功！');
		 					window.location.href='<%=request.getContextPath()%>/pages/assist/suport/lawsLib/search.action?nodeid=${assistSuportLawslib.categoryFk}&mCodeType=${mCodeType}&isLeader=${isLeader}';
		 				},
		 				error:function(){
		 					showMessage1('可能是网络原因，请联系系统管理员或刷新重试！');
		 				}
		 			});
	 			}
	 		});
	 	}
	 	
		function check(){
			if(frmCheck(document.forms[0],"mytable")==false) return false;
		}
		function getUrlParam(){
			return "&mCodeType=${mCodeType}";
		}
		function openSearch(){
			var url = "<%=request.getContextPath()%>/pages/system/search/searchdata.jsp"
			         +"?url=<%=request.getContextPath()%>/pages/assist/suport/lawsLib/allLawsLibMenus.action&urlpara=getUrlParam&paraname=assistSuportLawslib.category&paraid=assistSuportLawslib.categoryFk&isLeader=${isLeader}";
			showWinIf('commonPage',url,'类别',500,400);
		}
		function setValue(node) {
			document.getElementsByName('assistSuportLawslib.category')[0].value = node.text;
			document.getElementsByName('assistSuportLawslib.categoryFk')[0].value = node.id;
			closeWin('commonPage');
		}
</script>
</head>
<body>
	<div style="width:100%;height:100%;">
		<s:form id="searchForm" onsubmit="return check();">
				<s:token/>
				<s:hidden name="nodeid" value="${nodeid}" />
				<s:hidden name="editType" value="${editType}" />
				<s:hidden name="assistSuportLawslib.categoryFk"
					value="${assistSuportLawslib.categoryFk}" />
				<s:hidden name="assistSuportLawslib.id"
					value="${assistSuportLawslib.id}" />
				<s:hidden name="assistSuportLawslib.muuid"
					value="${assistSuportLawslib.muuid}" />
	
				<s:hidden name="assistSuportLawslib.classification"
					value="${assistSuportLawslib.classification}" />
				<s:hidden name="mCodeType" value="${mCodeType}" />
				<%-- 发布状态 --%>
				<s:if test="${empty(assistSuportLawslib.pub_state)}">
					<s:hidden name="assistSuportLawslib.pub_state" value="N" />
				</s:if>
				<s:else>
					<s:hidden name="assistSuportLawslib.pub_state" />
				</s:else>
				<%-- 发布人 --%>
				<s:hidden name="assistSuportLawslib.pub_man" />
				<%-- 创建人 --%>
				<s:if test="${empty(assistSuportLawslib.upman)}">
					<s:hidden name="assistSuportLawslib.upman"
						value="${user.floginname}" />
				</s:if>
				<s:else>
					<s:hidden name="assistSuportLawslib.upman" />
				</s:else>
				<s:hidden name="assistSuportLawslib.effective" />


				<div style="height:30px">
					<div style="width:100%;position:fixed;top:0;z-index:1000" align="center">
						<table class="ListTable" style="width:100%;border:0;margin:0">
							<tr class="EditHead">
								<td>
										<span style="float: right;"> <s:hidden name="m_message" value="${m_message}"/>
											<s:if test="${not empty(assistSuportLawslib.id) && assistSuportLawslib.id!='0'}">
												<s:if test="${empty(assistSuportLawslib.pub_state)}||${assistSuportLawslib.pub_state=='N'}">
													<a class="easyui-linkbutton" data-options="iconCls:'icon-publish'" onclick="publish2()">发布</a>&nbsp;
												</s:if>
											</s:if>
											<a class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="doSearch();">保存</a>&nbsp;
											<a class="easyui-linkbutton" data-options="iconCls:'icon-undo'" onclick="javascript:window.location.href='../lawsLib/search.action?nodeid=${assistSuportLawslib.categoryFk}&mCodeType=${mCodeType}&isLeader=${isLeader}'">返回</a>&nbsp;
										</span>
								</td>
							</tr>
						</table>
					</div>
				</div>

				<table id="mytable" cellpadding=0 cellspacing=0 border=0 class="" align="center" style="width:100%;">
					<tr>
						<td class="EditHead" nowrap="nowrap" style="width:15%;">
							<font color="red">*</font>&nbsp;名称

						</td>
						<td class="editTd" style="width:35%;">
							<s:textfield cssClass="noborder" title="名称(题目/条目)" name="assistSuportLawslib.title"
								maxlength="127" />
						</td>
						<td class="EditHead" style="width:15%;">
							<font color="red">*</font>&nbsp;案例编号
						</td>
						<td class="editTd" style="width:35%;">
							<s:textfield label="%{'文号'}" cssClass="noborder"
								name="assistSuportLawslib.codification" maxlength="20" />
						</td>

					</tr>
					<tr>
						<td class="EditHead">
							<font color="red">*</font>&nbsp;类别
						</td>
						<td class="editTd" nowrap="nowrap">
							<div>
								<s:textfield cssClass="noborder" name="assistSuportLawslib.category" readonly="true" />
								<a href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-search'" onclick="openSearch()"></a>
							</div>
						</td>
						<td class="EditHead">
							创建人
						</td>
						<td class="editTd">
							<s:property value="assistSuportLawslib.summan" />
							<s:hidden name="assistSuportLawslib.summan" />
						</td>

					</tr>
					<tr>
						<td class="EditHead">
							<font color="red">*</font>&nbsp;创建单位
							
						</td>
						<td class="editTd">
							<s:property value="assistSuportLawslib.sundept" />
							<s:hidden name="assistSuportLawslib.sundept" />
							<s:hidden name="assistSuportLawslib.sundeptId" />
						</td>
						<%@include file="/pages/assist/suport/pub_state2.jsp"%>
					</tr>
					<tr>
						<td class="EditHead">
							<font color="red">*</font>&nbsp;创建日期
							
						</td>
						<td class="editTd" colspan="3">

							${fn:substring(assistSuportLawslib.createDate,0,10)}

							<s:hidden name="assistSuportLawslib.createDate" />
						</td>
					</tr>
					<tr>
						<td class="EditHead">正文</td>
						<td class="editTd" colspan="3">
<%--							<FCK:editor id="assistSuportLawslib.content" --%>
<%--								basePath="/ais/resources/fckedit/" height="250"--%>
<%--								toolbarSet="cnn2">--%>
<%--								${assistSuportLawslib.content}--%>
<%--						</FCK:editor>--%>
							<!-- 加载编辑器的容器 -->
							<script id="container" name="content" type="text/plain" style="width: 100%;">
							</script>
						</td>
					</tr>
					<tr>
						<td class="EditHead">附件</td>
						<td class="editTd" colspan="3">
							<div id="assistFile" class="easyui-fileUpload" 
								 data-options="fileGuid:'${assistSuportLawslib.muuid}',isDownload:false,"></div>
						</td>
					</tr>
				</table>
				<s:hidden name="assistSuportLawslib.content" id="infoContent"/>
		</s:form>
	</div>
	<div id='commonPage'></div>
	<script type="text/javascript">
		var ue = UE.getEditor('container', {elementPathEnabled:false});
		ue.ready(function() {
			ue.setContent('${assistSuportLawslib.content}');
		});
	   function doSearch(){
	    	var submit = document.getElementById("searchForm");
	    	var name =document.getElementsByName('assistSuportLawslib.title')[0].value;
	    	var codification =document.getElementsByName('assistSuportLawslib.codification')[0].value;
	    	var category =document.getElementsByName('assistSuportLawslib.category')[0].value;
	    	if(name == null || name == ""){
	    		showMessage1('名称不能为空 ！');
	    		return false;
	    	}
	    	if(codification == null || codification == ""){
	    		showMessage1('案例编号不能为空 ！');
	    		return false;
	    	}
	    	if(category == null || category == ""){
	    		showMessage1('类别不能为空 ！');
	    		return false;
	    	}
		   $('#infoContent').val(ue.getContent());
	    	<%--var url = "${contextPath}/pages/assist/suport/lawsLib/saveLawEdit.action?isLeader=${isLeader}";--%>
	    	<%--submit.action=url;--%>
	    	<%--submit.submit();--%>
	    	<%--showMessage1('保存成功！');--%>

		   $.ajax({
			   url : "${contextPath}/pages/assist/suport/lawsLib/saveLawEdit.action?isLeader=${isLeader}",
			   dataType:'json',
			   type: "post",
			   async:false,
			   data: $('#searchForm').serialize(),
			   success: function(data){
				   if(data.type=="success"){
					   showMessage1("保存成功");
					   window.location.href = '../lawsLib/search.action?nodeid=${assistSuportLawslib.categoryFk}&mCodeType=${mCodeType}&isLeader=${isLeader}';
				   }else{
					   showMessage1("保存失败！" + data.msg);
				   }
			   },
			   error:function(data){
				   showMessage1("请求失败！请检查网络配置或者与管理员联系");
			   }
		   });
	    }
	</script>
</body>
</html>