<!DOCTYPE HTML>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%
 String s = (String)request.getAttribute("success");
 System.out.print(s);
 %>
<html>
<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<title><s:property value="#title" /></title>
	<!-- 引入dwr的js文件 -->
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
	<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
	<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
	<script language="javascript">
		//生成
		function generate(s){
			d_id=document.getElementsByName("doubt_id")[0].value;
			n_type=s;
			d_type=document.getElementsByName("type")[0].value;
			window.paramw = "模态窗口";
			      window.showModalDialog('${contextPath}/operate/doubt/genDoubt.action?doubt_id='+d_id+'&&newDoubt_type='+n_type+'&&type='+d_type, window, 'dialogWidth:700px;dialogHeight:450px;status:yes');
			var num=Math.random();
			var rnm=Math.round(num*9000000000+1000000000);//随机参数清除模态窗口缓存
		} 
		//删除
		function deleteRecord() {
			if(confirm("确认删除这条记录?")){
				myform.action = "${contextPath}/operate/doubt/delete.action";
				myform.submit();
			}
		} 
		function exe(){
			if (confirm("是否设置为已处理状态?")) {
				document.getElementsByName("audTemplate.doubt_status")[0].value="050"
				//audTemplate.doubt_status
		         saveForm();
	         }else{
		 
	         } 
		}
		function law(){
			window.open('${contextPath}/pages/assist/suport/comsys/view_lawslibFrame.jsp?zuoye=bs','law','height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no');
		}
		
		function regu(){
			win=window.open('${contextPath}/pages/operate/manu/law_redirect.jsp','regu','height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no');if(win && win.open && !win.closed) win.focus();
		}
	             
		function backList(){
			myform.action = "${contextPath}/operate/doubt/search.action?type=${type}&pro_id=${pro_id}";
			myform.submit();
		}
		function closeWindow(){
		   parent.closeWin('editWin');
		}

        //校验
		function check(){
			var v_3 = "audTemplate.templateName";  // field
			var title_3 = '方案名称';// field name
			var notNull = 'true'; // notnull
			var t=document.getElementsByName(v_3)[0].value;
			if(t.length>200){
				showMessage1("方案名称的长度不能大于200字！");
				document.getElementById(v_3).focus();
				return false;
			} 
			var v_4 = "audTemplate.proVer";  // field
			var title_4 = '方案版本';// field name
			var notNull = 'true'; // notnull
			t=document.getElementsByName(v_4)[0].value;
			if(t.length>200){
				showMessage1("方案版本的长度不能大于200字！");
				document.getElementById(v_4).focus();
				return false;
			} 
			return true;
		}
		 //----------保存表单
		function saveFormRoot(){
			var v_3 = "audTemplate.templateName";  // field
			var title_3 = '方案名称';// field name
			var notNull = 'true'; // notnull
			if(document.getElementsByName(v_3)[0].value=="" && notNull=="true"　&& notNull != ""){
				showMessage1(title_3+"不能为空!");
				bool = false;
				return false;
			}
			if(document.getElementsByName(v_3)[0].value.replace(/\s+$|^\s+/g,"")==""){
				showMessage1(title_3+"不能为空!");
				bool = false;
				document.getElementById(v_3).focus();
				return false;
			}
			if(!check()){
				return false;
			}
			$.ajax({
				type:"post",
				data:$('#myform').serialize(),
				url:"${contextPath}/operate/template/saveTemplate.action",
				async:false,
				success:function(){
			    	parent.$('#editWin').window('close');
			    	parent.datagridReload('its');
			    	showMessage1('保存成功！');
				}
			});
			//var url = "${contextPath}/operate/template/saveTemplate.action";
			//$('#myform').attr('action',url);
			//$('#myform').submit();
		 }
		 //-------保存并增加表单
		 function saveFormRootAgain(){
			var v_3 = "audTemplate.templateName";  // field
			var title_3 = '方案名称';// field name
			var notNull = 'true'; // notnull
			if(document.getElementsByName(v_3)[0].value=="" && notNull=="true"　&& notNull != ""){
				showMessage1(title_3+"不能为空!");
				bool = false;
				return false;
			}
			
			if(document.getElementsByName(v_3)[0].value.replace(/\s+$|^\s+/g,"")==""){
				showMessage1(title_3+"不能为空!");
				bool = false;
				document.getElementById(v_3).focus();
				return false;
			}
			
			var v_4 = "audTemplate.typeCode";  // field
			var title_4 = '项目类别';// field name
			var notNull = 'true'; // notnull
			if(document.getElementsByName(v_4)[0].value=="" && notNull=="true"　&& notNull != ""){
				showMessage1(title_4+"不能为空!");
				bool = false;
				return false;
			}
			
			if(document.getElementsByName(v_4)[0].value.replace(/\s+$|^\s+/g,"")==""){
				showMessage1(title_4+"不能为空!");
				bool = false;
				document.getElementById(v_4).focus();
				return false;
			}
			
			var v_5 = "audTemplate.atCompanyCode";  // field
			var title_5 = '所属单位';// field name
			var notNull = 'true'; // notnull
			if(document.getElementsByName(v_5)[0].value=="" && notNull=="true"　&& notNull != ""){
				showMessage1(title_5+"不能为空!");
				bool = false;
				return false;
			}
			
			if(document.getElementsByName(v_5)[0].value.replace(/\s+$|^\s+/g,"")==""){
				showMessage1(title_5+"不能为空!");
				bool = false;
				document.getElementById(v_5).focus();
				return false;
			}
			
			if(!check()){
				return false;
			}
		/* 	var url = "${contextPath}/operate/template/saveTemplateAgain.action";
			myform.action = url;
			myform.submit(); */
			$.ajax({
				type:"post",
				data:$('#myform').serialize(),
				url:"${contextPath}/operate/template/saveTemplateAgain.action",
				async:false,
				success:function(){
			    	parent.$('#editWin').window('close');
			    	parent.datagridReload('its');
			    	showMessage1('保存成功！');
				}
			});
		}
   		//上传附件
		function Upload(id,filelist,delete_flag,edit_flag) {
			var guid=document.getElementById(id).value;
			var num=Math.random();
			var rnm=Math.round(num*9000000000+1000000000);//随机参数清除模态窗口缓存
			window.showModalDialog('${contextPath}/commons/file/welcome.action?guid='+guid+'&param='+rnm+'&deletePermission='+delete_flag+'&isEdit='+edit_flag,filelist,'dialogWidth:700px;dialogHeight:450px;status:yes');
		}
 		//删除方法
 		/*
 			1.第一个参数是附件表的主键ID，第二个参数是该类附件的删除权限，第三个参数是附件的应用类型
 			2.该方法的参数由ais.file.service.imp.FileServiceImpl中的
 				getDownloadListString(String contextPath, String guid,String bool, String appType)生成的HTML产生
 		*/
     	function deleteFile(fileId,guid,isDelete,isEdit,appType,title){
			var boolFlag=window.confirm("确认删除吗?");
			if(boolFlag==true){
				DWREngine.setAsync(false);DWRActionUtil.execute({
					namespace:'/commons/file', action:'delFile', executeResult:'false' }, 
					{'fileId':fileId, 'deletePermission':isDelete, 'isEdit':isEdit, 'guid':guid, 'appType':appType,'title':title},
					xxx);
					function xxx(data){
			  			document.getElementById(guid).parentElement.innerHTML=data['accessoryList'];
					} 
			}
		}
	
		//显示成功信息
		function test(s){
			if(s == true){
				showMessage1('保存成功！');
				parent.datagridReload('its');
			}else{
			}
		}
		
	$(function(){
		var isInterCtrl = '${interCtrl}' == 'true';
		$('#audTemplate_belongTo').val(isInterCtrl ? 'interCtrl' : 'audit');
	});
</script>
</head>
<body onload="test(<%=s%>)" style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout" border="0" fit="true">
	<div region="center" border="0">
		<s:form id="myform" action="view" method="post">
			<input type='hidden' id='audTemplate_belongTo' name="audTemplate.belongTo" value="${audTemplate.belongTo}"/>
			<table class="ListTable">
				<tr>
					<td style="width: 15%" class="EditHead">
						<font color="red">*</font>方案名称
					</td>
					<!--标题栏-->
					<td style="width: 35%" class="editTd">
						<s:textfield  cssClass="noborder" name="audTemplate.templateName" />
					</td>
					<td style="width: 15%"  class="EditHead">方案版本</td>
					<td style="width: 35%" class="editTd">
						<s:textfield  cssClass="noborder" name="audTemplate.proVer" />
					</td>
				</tr>
				<s:hidden name="audTemplate.audTemplateId" />
				<s:hidden name="audTemplateId" />
				<tr>
					<td class="EditHead">
						<font color="red" ></font>编制人
					</td>
					<td class="editTd">
						<s:property value="audTemplate.proAuthorName" />
						<s:hidden name="audTemplate.proAuthorCode" />
						<s:hidden name="audTemplate.proAuthorName" />
					</td>
					<td  class="EditHead">
						<font color="red"></font>编制日期:
					</td>
					<td class="editTd">
						<s:property value="audTemplate.proDate" />
						<s:hidden name="audTemplate.proDate" />
					</td>
				</tr>
				<tr>
					<td class="EditHead"><font color="red" >*</font>项目类别</td>
					<td class="editTd">
						<s:doubleselect cssStyle="width:120px;"
							doubleList="projectTypeMap[top]" doubleListKey="code"
							doubleListValue="name" listKey="code" listValue="name"
							name="audTemplate.typeCode" list="projectTypeMap.keySet()"
							doubleName="audTemplate.typeCode2" theme="ufaud_simple"
							templateDir="/strutsTemplate" emptyOption="true"></s:doubleselect>
					</td>
					<td class="EditHead"><font color="red" >*</font>所属单位</td>
					<td class="editTd">
						<s:textfield cssClass="noborder" name="audTemplate.atCompany"  id="atCompany" cssStyle="width:150px" readonly="true" maxlength="100"/>
						<input type="hidden" id="atCompanyCode" name="audTemplate.atCompanyCode">
						<img style="cursor:pointer;border:0" src="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png"
										 onclick="showSysTree(this,
											 { url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action',
											 title:'请选择所属单位',
											 param:{
											 'p_item':3
											 },
											 defaultDeptId:'${magOrganization.fpid}'
						})"/>
					</td>
				</tr>
			</table>
			<s:hidden name="newDoubt_type"/>
			<s:hidden name="audTemplate.doubt_id"/>
			<s:hidden name="doubt_id"/>
			<s:hidden name="type"/>
			<s:hidden name="pro_id"/>
			<div style="margin-top:20px;text-align:center">
				<!-- <a class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="saveFormRoot();">保存</a> -->
				<a class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="saveFormRootAgain();">保存并增加</a>
				<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="closeWindow();">关闭</a>
			</div>
		</s:form>
	</div>
</body>
</html>
