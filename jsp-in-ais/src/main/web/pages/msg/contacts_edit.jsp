<!DOCTYPE HTML >
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
	<head>
		<title>添加审计人员基本信息</title>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/common.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/employeeValidate/checkboxSelected.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>	
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css">
		<script type="text/javascript" src="${contextPath}/scripts/base64_Encode_Decode.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/employeeValidate/validate.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ufaudTextLengthValidator.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/autosize.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/js/jquery-fileUpload.js"></script>
		<s:head theme="simple" />
		<script type="text/javascript">


		function save(){
			var sysAccount = document.getElementsByName("contacts.sysAccount")[0].value;
			if(sysAccount==''||sysAccount==null){
				top.$.messager.show({title:'提示信息',msg:'请填写系统账号!'});
				return false;
			}	
			var userName = document.getElementsByName("contacts.userName")[0].value;
			if(userName==''||userName==null){
				top.$.messager.show({title:'提示信息',msg:'请填写姓名!'});
				return false;
			}	
			var email = document.getElementsByName("contacts.email")[0].value;
			if(email==''||email==null){
				top.$.messager.show({title:'提示信息',msg:'请填写邮件!'});
				return false;
			}	
			myform.submit();
		}
		function getUserById(id){
			$.ajax({
       			url:'${pageContext.request.contextPath}/mng/employee/getUserById.action',
       			type:'POST',
       			data:{'userId':id[0]},
       			async:false,
       			success:function(data){
       				data = eval('(' + data + ')');
       				document.getElementById('email').value=data.femail != null ? data.femail : '';
       			}
       		})
		} 
 		function sucFun(){
    		if($("#sucFlag").val()=='1'){
    			$("#sucFlag").val('');
    			showMessage2('保存成功！');
    		}        		
   		}
		</script>
	</head>
	<body onload="sucFun();">
		<div style="width:100%; height:100%; overflow:scroll;" align="center">
			<s:form action="contactsSave" namespace="/admin" id="myform">
				<s:token/>
				<table id="tab1" cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
				<input type="hidden" name="sucFlag" id="sucFlag" value="${sucFlag}"/>
		        <input type="hidden" name="contacts.id"  value="${contacts.id}"/>
	                <tr >
	                    <td colspan="4" align="left" class="EditHead">
	                    		<font style="float: left;">审计人员基本信息</font>
	                    </td>
	                </tr>
					<tr>
						<td  nowrap class=EditHead >
							<FONT color=red>*</FONT>&nbsp;系统账号
						</td>
						<td class=editTd  align="left">
							<div id="sysacc">
								<s:buttonText2 name="contacts.sysAccount" id="sysAccount"
									cssStyle="color:gray;width:40%;" cssClass="noborder"
									doubleOnclick="showSysTree(this,
										{ url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action?org=local',
		                                  param:{
		                                    'p_item':1,
		                                     'orgtype':1
		                                  },
		                                  cache:false,
		                                  singleSelect:true,
		                                  title:'请选择系统账号',
		                                  type:'treeAndUser',
		                                  onAfterSure:function(id,name,personnelCode,company,companyCode){
		                                  		getUserById(id);
		                                  		if(name != undefined) {
			                                  		document.getElementsByName('contacts.userName')[0].value = name;
			                                  		document.getElementsByName('contacts.sysAccount')[0].value = id;
			                                	} else{
			                                		document.getElementsByName('contacts.sysAccount')[0].value = '';
			                                		document.getElementsByName('contacts.userName')[0].value = '';		
			                                	}	
		                                  }
										})"
									doubleSrc="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png"
									readonly="true"
									doubleCssStyle="cursor:hand;border:0;color:Gray;"
									doubleDisabled="false" maxlength="500" title="系统账号" />
							</div>
						</td>
						<td nowrap class=EditHead >
							<FONT color=red>*</FONT>&nbsp;姓名
						</td>
						<td class=editTd  align="left">
							<s:textfield cssClass="noborder" readonly="true" cssStyle="color:Gray;width:40%;" name="contacts.userName"
								size="37" maxlength="16" />
							<FONT id="msg1" color="gray">选择系统账号后，自动关联生成</FONT>
						</td>
	
					</tr>
					<tr>
						<td nowrap class=EditHead >
								<FONT color=red>*</FONT>&nbsp;电子邮箱 
						</td>
						<td class=editTd  align="left">
							<s:textfield cssClass="noborder" id="email" name="contacts.email" size="37" cssStyle="width:40%;"
								maxlength="127" />
						</td>
					</tr>
					<s:head name="consave" value="1"/>
				</TABLE>
				<br>
				<div align="right">
					<a class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="save()">保存</a>&nbsp;&nbsp;
					<a class="easyui-linkbutton" data-options="iconCls:'icon-reload'" onclick="clearAll()">重置</a>&nbsp;&nbsp;
						<a class="easyui-linkbutton" data-options="iconCls:'icon-undo'" onclick="window.location='contactsList.action'">返回</a>
				</div>
			</s:form>
		</div>
		 <div id="subwindow" class="easyui-window" title="" style="width:500px;height:500px;padding:5px;" closed="true" fit="true">
		
		</div> 
	</body>
</html>
