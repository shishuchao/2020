<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE HTML>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<script type="text/javascript" src="<%=request.getContextPath()%>/scripts/base64_Encode_Decode.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
		<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
		<script type="text/javascript">
			$(function(){
				$("#saveFun").removeAttr("disabled");
			});
			var hasChgPass=false;
			function chgGlobalStatus(){
				hasChgPass=true;
			};
			function myCheck(){
				obj=$_name('uUser.fcode');
				if(obj.value==""){alert("用户编码不能为空！");obj.focus();return false;}
				if(comBig(obj.value,20,'用户编码 长度超长!')) return false;
				if(!isCharAndNum(obj.value)){alert('用户编码 只能包含字母和数字!');obj.focus();return false;}
				
				
				obj=$_name('uUser.fname');
				if(obj.value==""){alert("用户名称不能为空！");obj.focus();return false;}
				if(comBig(obj.value,15,'用户名称 长度超长!')) return false;
				if(checkBank(obj)){return false;}
				
				
				obj=$_name('uUser.floginname');
				if(obj.value==""){alert("系统帐号不能为空！");obj.focus();return false;}
				if(comBig(obj.value,20,'系统帐号 长度超长!')) return false;
				if(!isCharAndNum(obj.value)){alert('系统帐号 只能包含字母和数字!');obj.focus();return false;}
				
				obj=$_name('uUser.fpassword');
				if(obj.value==""){alert("密码不能为空！");obj.focus();return false;}
				var temp = chk(obj.value);
				if(temp!=''){
					//alert(temp);
					showMessage2('密码'+temp);
					return false;
				}
				if(comBig($_name('uUser.fmobile').value,11,'手机 长度超长!')){return false;}
				
				if(!myRegexp(document.getElementsByName("uUser.floginname")[0].value)){return false;}
				 if(document.getElementsByName("uUser.fstate")[0].value=='离职'&&document.getElementsByName("uUser.flivestate")[0].value=='qy'){
					 alert('离职人员不能使用启用状态!');
					 return false;
				 }
				 
				 var re1 = /^[0-9]*$/;
				 var re2 = /^(\(\d{3,4}\)|\d{3,4}-)?\d{7,8}$/;
				 var fphone = $("#fphone").val();
				 var fmobile = $("#fmobile").val();
				 /*
				 if(fphone != ""){
					 if (!re2.test(fphone)){
					        alert("电话格式不正确!(如：XXXX-XXXXXXX)");
					        return false;
					     }
				 }*/
				 if(fmobile != ""){
					 if (!re1.test(fmobile)){
					        alert("手机请输入数字!");
					        return false;
					     }
				 }
				 
				 
				 var v=$_name("uUser.femail").value;
				if(v.length>0&&!isMail(v)){alert("email地址格式不正确,请重新输入!");return false;}
				if(v.length>50){alert("email地址长度过长!请重新输入!");return false;}
				<s:if test="${not empty(isFcard)}">
					if($_name("uUser.fcard").value.length<1){alert("身份证 不能为空!");return false;}
				</s:if>
					if(!isIdCardNo($_name("uUser.fcard").value)) return false;
				<s:if test="${empty(uUser.fuserid)}">
					var tmp=$_name("uUser.fpassword").value;
					<s:if test="${not empty(isPass) and isPass=='c'}">
						if(tmp.length<10||tmp.length>30){alert("密码长度要在10~30位之间!");return false;}
						if(!isRightPass("uUser.fpassword",10)) return false;
					</s:if>
					$_name("uUser.fpassword").value=encode64(tmp);
				</s:if>
				<s:else>
					if(hasChgPass){
				 		var tmp=$_name("uUser.fpassword").value;
				 		<s:if test="${not empty(isPass) and isPass=='c'}">
					 		if(tmp.length<10||tmp.length>30){alert("密码长度要在10~30位之间!");return false;}
					 		if(!isRightPass("uUser.fpassword",10)) return false;
				 		</s:if>
				 		 $_name("uUser.fpassword").value=encode64(tmp);
				 	}else{
				 		var tmp=$_name("uUser.fpassword").value;
				 		$_name("uUser.fpassword").value=encode64(tmp);
				 	}
				</s:else>
				$("#saveFun").attr("disabled","true");
				return true;
			}
			
			function chk(s){
			if (s.length<8) return '长度小于8位';
			//else if (s.length>15) return '长度大于15位';
			else if (! s.match(/[0-9]/)) return '没有数字';
			else if (! s.match(/[a-zA-Z]/)) return '没有字母';
			//返回空串表示合格
			else return '';
			}			
			
			function $_name(name){return document.getElementsByName(name)[0];}
			function isMail(str) {return (new RegExp(/^[\w-]+@[\w-]+(\.[\w-]+)+$/).test(str));}
			function myRegexp(s){
			/*
				var patrn=/^[a-zA-Z]{1}[a-zA-Z0-9]{0,14}$/;
				if(!patrn.exec(s)){
					alert('登录名称必须以字母开头并且只能是字母和数字，长度不大于15');
					//document.getElementsByName('uUser.floginname')[0].focus();
					return false;
				}
				*/
				s=trim(s);
				document.getElementsByName('uUser.floginname')[0].value=s;
				if(s=='' || s.length>15){
				alert('系统帐号长度应小于15位！');
					return false;
				}
				return true;
			}
			function trim(inputString) {
				try {
					var strValue = inputString;
					var ch = strValue.substring(0, 1);
					while (ch == " ") {
						strValue = strValue.substring(1, strValue.length);
						ch = strValue.substring(0, 1);
					}
					ch = strValue.substring(strValue.length - 1, strValue.length);
					while (ch == " ") {
						strValue = strValue.substring(0, strValue.length - 1);
						ch = strValue.substring(strValue.length - 1, strValue.length);
					}
					return strValue;
				}
				catch (e) {
				}
			}
			
			function isIdCardNo(num){
				if(num!=null && num!=''){
					num = num.toUpperCase();
					if (!(/(^\d{15}$)|(^\d{17}([0-9]|X)$)/.test(num))){
						alert('输入的身份证号长度不对，或者号码不符合规定！\n15位号码应全为数字，18位号码末位可以为数字或X！');
						return false;
					}
					return true;
				}
				return true;
			}
			function isRightPass(name,len){
				var str=document.getElementsByName(name)[0].value;
				var tip="密码中必须是 字母 数字 和 '@-_$#' 中的2种以上组合!";
				if(str.length<len){alert("密码长度至少"+len+"位!");return false;}
				if(str.length>30){alert("密码长度限制在30位以内!");return false;}
				var reg=/^[a-zA-Z\d@-_$#]*$/;
				var bb=new RegExp(reg).test(str);
				if(bb){
					var reg1=/^.*[a-zA-Z]+.*$/;
					var reg2=/^.*\d+.*$/;
					var reg3=/^.*[@-_$#]+.*$/;
					var num=0;
					if(new RegExp(reg1).test(str)){num+=1;}
					if(new RegExp(reg2).test(str)){num+=1;}
					if(new RegExp(reg3).test(str)){num+=1;}
					if(num>=2)return true;
				}
				alert(tip);return false;
			}
			String.prototype.gblen = function() {var len = 0;for (var i=0; i<this.length; i++){if(this.charCodeAt(i)>127 || this.charCodeAt(i)==94) {len+= 2;} else {len ++;}}return len;}
			function comBig(m,n,msg){if(m.gblen()>n){if(typeof msg != 'undefined'){alert(msg)}return true};return false;}
			function isCharAndNum(str) {return (new RegExp(/^[a-zA-Z0-9-]+$/).test(str));}
			function checkBank(obj){ b=obj.value.lastIndexOf(' ');b=b>=0; if(b){obj.focus();obj.select();alert('不能存在空格！');} return b;} 
			<s:if test="!${empty(message)}">
				alert('${message}');
			</s:if>
		</script>
	</head>
	<body>
		<div class='easyui-layout' border='0' fit='true'>
			<div region='north' style="height:32px;overflow:hidden;" border='0'>
			</div>
			<div region='center' border='0'>					
				<s:form action="saveAuditUUser" namespace="/admin" method="post" id="myForm" theme="simple">
					<s:token/>
					<s:textfield name="fdepid" value="%{fdepid}"></s:textfield>
					<!-- 用于保存开始点击节点的id -->
					<s:hidden name="uUser.fuserid" value="%{uUser.fuserid}"></s:hidden>
					<s:hidden name="uUser.fdepid" value="%{uUser.fdepid}"></s:hidden>
					<s:hidden name="uUser.fdepname" value="%{uUser.fdepname}"></s:hidden>
					<s:hidden name="uUser.last_mpt" value="%{uUser.last_mpt}"></s:hidden>
					<s:hidden name="uUser.failtimes"></s:hidden>
					<input type="hidden" name="lastpass" value="%{uUser.fpassword}">
					<div style="text-align:left;padding-top:5px;">
						<a class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="addUser()" id="save_id">保存</a>&nbsp;&nbsp;
					</div>
					<table style="width:100%;height:100%;" cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
						<tr>
							<td class="EditHead" nowrap="nowrap" style="width: 15%">
								<font color="red">*</font>&nbsp;用户编码
							</td>
							<td class="editTd" nowrap="nowrap" style="width: 35%">
								<s:if test="${empty(uUser.fuserid) or uUser.fuserid=='0'}">
									<s:textfield name="uUser.fcode" value="%{uUser.fcode}" cssClass="noborder"></s:textfield>
								</s:if>
								<s:else>
								<s:textfield name="uUser.fcode" readonly="true" disabled="true" cssClass="noborder"
											value="%{uUser.fcode}"></s:textfield>
											<s:hidden name="uUser.fcode" value="${uUser.fcode}"></s:hidden>
								</s:else>	
							</td>
							<td class="EditHead" nowrap="nowrap" style="width: 15%">
								<font color="red">*</font>&nbsp;用户名称
							</td>
							<td class="editTd" nowrap="nowrap" style="width: 35%">
								<s:textfield name="uUser.fname" value="%{uUser.fname}" cssClass="noborder"></s:textfield>
							</td>
						</tr>
						<tr >
							<td class="EditHead">
								<font color="red">*</font>&nbsp;系统帐号
							</td>
							<td class="editTd">
								<s:if test="${empty(uUser.fuserid) or uUser.fuserid=='0'}">
									<s:textfield name="uUser.floginname" value="%{uUser.floginname}" cssClass="noborder"></s:textfield>
								</s:if>
								<s:else>
									<s:textfield name="uUser.floginname" readonly="true" disabled="true" cssClass="noborder"
										value="%{uUser.floginname}"></s:textfield>
										<s:hidden name="uUser.floginname" value="${uUser.floginname}"></s:hidden>
								</s:else>
							</td>
							<td class="EditHead">
								<font color="red">*</font>&nbsp;密码
							</td>
							<td class="editTd">
								<s:password name="uUser.fpassword" value="%{uUser.fpassword}"
									showPassword="true" onchange="chgGlobalStatus();" cssClass="noborder"></s:password><font color="red" size="2">须同时含有数字和字母长度8-15</font>
							</td>
						</tr>
						<tr>
							<td class="EditHead">
								电话
							</td>
							<td class="editTd">
								<s:textfield name="uUser.fphone" id="fphone" value="%{uUser.fphone}" cssClass="noborder"></s:textfield>
							</td>
							<td class="EditHead">
								手机
							</td>
							<td class="editTd">
								<s:textfield name="uUser.fmobile" id="fmobile" value="%{uUser.fmobile}" cssClass="noborder"></s:textfield>
							</td>
						</tr>
						<tr>
							<td class="EditHead">
								Email
							</td>
							<td class="editTd">
								<s:textfield name="uUser.femail" value="%{uUser.femail}" cssClass="noborder"></s:textfield>
							</td>
							<td class="EditHead">
								
							</td>
							<td class="editTd">
							
							</td>
						</tr>
					</table>
				</s:form>
			</div>
		</div>	
	<script type="text/javascript">
		function addUser(){
			obj=$_name('uUser.fcode');
			if(obj.value==""){
				showMessage2("用户编码不能为空！");
				obj.focus();
				return false;
			}
			if(comBig(obj.value,20,'用户编码 长度超长!')) 
				return false;
			if(!isCharAndNum(obj.value)){
				showMessage2('用户编码 只能包含字母和数字!');
				obj.focus();
				return false;
			}
			obj=$_name('uUser.fname');
			if(obj.value==""){
				showMessage2("用户名称不能为空！");
				obj.focus();
				return false;
			}
			if(comBig(obj.value,15,'用户名称 长度超长!')) 
				return false;
			if(checkBank(obj)){
				return false;
			}
			obj=$_name('uUser.floginname');
			if(obj.value==""){
				showMessage2("系统帐号不能为空！");
				obj.focus();
				return false;
			}
			if(comBig(obj.value,20,'系统帐号 长度超长!')) 
				return false;
			if(!isCharAndNum(obj.value)){
				showMessage2('系统帐号 只能包含字母和数字!');
				obj.focus();
				return false;
			}
			obj=$_name('uUser.fpassword');
			if(obj.value==""){
				showMessage2("密码不能为空！");
				obj.focus();
				return false;
			}
			var temp = chk(obj.value);
			if(temp!=''){
				//alert(temp);
				showMessage2('密码'+temp);
				return false;
			}
			if(comBig($_name('uUser.fmobile').value,11,'手机 长度超长!')){
				return false;
			}
			
			if(!myRegexp(document.getElementsByName("uUser.floginname")[0].value)){
				return false;
			}
		
		 	var re1 = /^[0-9]*$/;
		 	var re2 = /^(\(\d{3,4}\)|\d{3,4}-)?\d{7,8}$/;
			var fphone = $("#fphone").val();
		 	var fmobile = $("#fmobile").val();
		 	if(fmobile != ""){
				if (!re1.test(fmobile)){
		        	showMessage2("手机请输入数字!");
		        	return false;
				}
		 	}
		 	var v=$_name("uUser.femail").value;
		 	if(v.length>0&&!isMail(v)){
				showMessage2("email地址格式不正确,请重新输入!");
				return false;
		 	}
		 	if(v.length>50){
				showMessage2("email地址长度过长!请重新输入!");
				return false;
		 	}
		
			<s:if test="${empty(uUser.fuserid)}">
				var tmp=$_name("uUser.fpassword").value;
				<s:if test="${not empty(isPass) and isPass=='c'}">
					if(tmp.length<10||tmp.length>30){
						showMessage2("密码长度要在10~30位之间!");
						return false;
					}
					if(!isRightPass("uUser.fpassword",10)) 
						return false;
				</s:if>
				$_name("uUser.fpassword").value=encode64(tmp);
			</s:if>
			<s:else>
				if(hasChgPass){
		 			var tmp=$_name("uUser.fpassword").value;
		 			<s:if test="${not empty(isPass) and isPass=='c'}">
			 			if(tmp.length<10||tmp.length>30){
			 				showMessage2("密码长度要在10~30位之间!");
			 				return false;
			 			}
			 			if(!isRightPass("uUser.fpassword",10)) 
			 				return false;
		 			</s:if>
		 		 	$_name("uUser.fpassword").value=encode64(tmp);
		 		}else{
		 			var tmp=$_name("uUser.fpassword").value;
		 			$_name("uUser.fpassword").value=encode64(tmp);
		 		}
			</s:else>
			var flowForm = document.getElementById('myForm');
			flowForm.action = "${contextPath}/admin/saveAuditUUser.action";
			flowForm.submit();
		}
	</script>
	</body>
</html>
