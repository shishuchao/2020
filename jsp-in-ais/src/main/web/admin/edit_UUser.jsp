<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE HTML>
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
				if(s=='' || s.length>60){
					showMessage1('系统帐号长度应小于60位！');
					return false;
				}
				if(s.indexOf(",") > 0 || s.indexOf("，") > 0) {
					showMessage1('系统帐号禁止包含字符“，”！');
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
			String.prototype.gblen = function() {var len = 0;for (var i=0; i<this.length; i++){if(this.charCodeAt(i)>127 || this.charCodeAt(i)==94) {len+= 2;} else {len ++;}}return len;}
			function comBig(m,n,msg){if(m.gblen()>n){if(typeof msg != 'undefined'){alert(msg)}return true};return false;}
			function isCharAndNum(str) {return (new RegExp(/^[a-zA-Z0-9-]+$/).test(str));}
			function checkBank(obj){ b=obj.value.lastIndexOf(' ');b=b>=0; if(b){obj.focus();obj.select();alert('不能存在空格！');} return b;} 
			<s:if test="!${empty(message)}">
				alert('${message}');
			</s:if>
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
				/* if(comBig(obj.value,15,'用户名称 长度超长!')) 
					return false; */
				if(checkBank(obj)){
					return false;
				}
				
				
				obj=$_name('uUser.floginname');
				if(obj.value==""){
					showMessage2("系统帐号不能为空！");
					obj.focus();
					return false;
				}
				if(comBig(obj.value,60,'系统帐号 长度超长!')) 
					return false;
				/* if(!isCharAndNum(obj.value)){
					showMessage2('系统帐号 只能包含字母和数字!');
					obj.focus();
					return false;
				} */
				
				obj=$_name('uUser.fpassword');
				if(obj.value==""){
					showMessage2("密码不能为空！");
					obj.focus();
					return false;
				}

				if(comBig($_name('uUser.fmobile').value,11,'手机 长度超长!')){
					return false;
				}
				
				if(!myRegexp(document.getElementsByName("uUser.floginname")[0].value)){return false;}
				 if(document.getElementsByName("uUser.fstate")[0].value=='离职'&&document.getElementsByName("uUser.flivestate")[0].value=='qy'){
					 showMessage2('离职人员不能使用启用状态!');
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
				<s:if test="${not empty(isFcard)}">
					if($_name("uUser.fcard").value.length<1){
						showMessage2("身份证 不能为空!");
						return false;
					}
				</s:if>
					if(!isIdCardNo($_name("uUser.fcard").value)) 
						return false;
				<s:if test="${empty(uUser.fuserid)}">
					var tmp=$_name("uUser.fpassword").value;
					<s:if test="${not empty(isPass) and isPass=='c'}">
						var temp = chk(tmp);
						if(temp!=''){
							showMessage2('密码'+temp);
							return false;
						}
					</s:if>
					$_name("uUser.fpassword").value=encode64(tmp);
				</s:if>
				<s:else>
					if(hasChgPass){
				 		var tmp=$_name("uUser.fpassword").value;
				 		<s:if test="${not empty(isPass) and isPass=='c'}">
							var temp = chk(tmp);
							if(temp!=''){
								showMessage2('密码'+temp);
								return false;
							}
				 		</s:if>
				 		 $_name("uUser.fpassword").value=encode64(tmp);
				 	}else{
				 		var tmp=$_name("uUser.fpassword").value;
				 		$_name("uUser.fpassword").value=encode64(tmp);
				 	}
				</s:else>
				var flowForm = document.getElementById('myForm');
				flowForm.action = "${contextPath}/admin/saveUUser.action";
				flowForm.submit();
			}

			function myGoListSubmit(){
				window.location.href='listUUser.action?fdepid=${fdepid}';
			}
		</script>
	</head>
	<body>
	<s:if test="${empty(name)}">
		<div class="easyui-panel" title="新增用户" fit=true style="overflow: visibility ;">
	</s:if>
	<s:else>
	<div class="easyui-panel" title="修改用户-${name}" fit=true style="overflow: visibility ;">
	</s:else>
		<s:form action="saveUUser" namespace="/admin" method="post" id="myForm" theme="simple">
			<s:token/>
			<s:hidden name="fdepid" value="%{fdepid}"></s:hidden>
			<!-- 用于保存开始点击节点的id -->

			<s:hidden name="uUser.fuserid" value="%{uUser.fuserid}"></s:hidden>
			<s:hidden name="uUser.fdepid" value="%{uUser.fdepid}"></s:hidden>
			<s:hidden name="uUser.fdepname" value="%{uUser.fdepname}"></s:hidden>
			<s:hidden name="uUser.last_mpt" value="%{uUser.last_mpt}"></s:hidden>
			<s:hidden name="uUser.failtimes"></s:hidden>
			<s:hidden name="uUser.creator"></s:hidden>
			<s:hidden name="uUser.createTime"></s:hidden>
			<s:hidden name="uUser.lastUpdator"></s:hidden>
			<s:hidden name="uUser.lastUpdateTime"></s:hidden>
			<input type="hidden" name="lastpass" value="%{uUser.fpassword}">
			<table style="width:100%;border:0" >
				<tr>
					<td class="EditHead">
						<span style="float:right;">
								<a class="easyui-linkbutton" data-options="iconCls:'icon-save'"  onclick="addUser();" />保存</a>
								<a class="easyui-linkbutton" data-options="iconCls:'icon-undo'"  onclick="myGoListSubmit();" />返回</a>
						</span>
					</td>
				</tr>
			</table>
			<table cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
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
							showPassword="true" onchange="chgGlobalStatus();" cssClass="noborder"></s:password>
					</td>
				</tr>
				<tr >
				<td class="EditHead">
					<s:if test="${not empty(isFcard)}"><font color="red">*</font></s:if>身份证
				</td>
				<td class="editTd">
					<s:textfield name="uUser.fcard" value="%{uUser.fcard}" cssClass="noborder"></s:textfield>
				</td>
				<td class="EditHead">
					出生日期
				</td>
				<td class="editTd">
					<input type='text' editable="false" name='uUser.fborn' value="${uUser.fborn}" class="easyui-datebox"/>
				</td>
				</tr>
				<tr >
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
				<tr >
					<td class="EditHead">
						Email
					</td>
					<td class="editTd">
						<s:textfield name="uUser.femail" value="%{uUser.femail}" cssClass="noborder"></s:textfield>
					</td>
					<td class="EditHead">
						性别
					</td>
					<td class="editTd">
						<s:select list="{'男','女'}" id='cbb' name="uUser.fsex" cssStyle="width:160px;" cssClass="easyui-combobox"></s:select>
					</td>
				</tr>
				
				<tr >
					<td class="EditHead">
						在职状态
					</td>
					<td class="editTd">
						<s:select list="basicUtil.incumbencyStateList" id='cbb' name="uUser.fstate" cssStyle="width:160px;" cssClass="easyui-combobox" listKey="code" listValue="name"></s:select>
					</td>
					<td class="EditHead">
						启用状态
					</td>
					<td class="editTd">
						<s:select list="#@java.util.LinkedHashMap@{'qy':'启用','zx':'注销','dj':'冻结'}" id='cbb' listValue="value" name="uUser.flivestate"
							listKey="key" value="%{uUser.flivestate}" cssStyle="width:160px;" cssClass="easyui-combobox"></s:select>
					</td>
				</tr>
				<tr >
					<td class="EditHead">
						角色类型
					</td>
					<td class="editTd">
						<s:select list="#@java.util.LinkedHashMap@{'general':'业务角色','admin':'管理角色'}" id='cbb' listValue="value" name="uUser.flevel"
							listKey="key" value="%{uUser.flevel}" cssStyle="width:160px;" cssClass="easyui-combobox"></s:select>
					</td>
					<td class="EditHead">
					顺序号
					</td>
					<td class="editTd">
						<s:if test="${uUser.forder==null}">
						<s:select name="uUser.forder" id='cbb' list="#@java.util.LinkedHashMap@{'0':'0','1':'1','2':'2','3':'3','4':'4','5':'5','6':'6','7':'7','8':'8','9':'9','10':'10'}" value="0" cssStyle="width:160px;" cssClass="easyui-combobox">
							
						</s:select>
                        </s:if>
                        <s:else>
                        <s:select name="uUser.forder" id='cbb' list="#@java.util.LinkedHashMap@{'0':'0','1':'1','2':'2','3':'3','4':'4','5':'5','6':'6','7':'7','8':'8','9':'9','10':'10'}" value="${uUser.forder}" cssStyle="width:160px;" cssClass="easyui-combobox">
                            
                        </s:select>
                        </s:else>
					</td>
				</tr>
				<tr>
					<td class="EditHead">
						是否审计人才
					</td>
					<td class="editTd" colspan="3">
						<s:select list="#@java.util.LinkedHashMap@{'':'','否':'否','是':'是'}" id='isAudit' listValue="value" name="uUser.isAudit"
								  listKey="key" value="%{uUser.isAudit}" cssStyle="width:160px;" cssClass="easyui-combobox"></s:select>
					</td>
				</tr>
			</table>
		</s:form>
	</div>
	</body>
</html>
