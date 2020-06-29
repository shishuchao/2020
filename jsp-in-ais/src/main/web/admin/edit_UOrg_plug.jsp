<%@ page language="java"  pageEncoding="UTF-8" contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<html>
	<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<jsp:include flush="true" page="/admin/group/aisUrl.jsp"></jsp:include>
	
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/pages/introcontrol/util/themes/default/easyui.css">
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/css.css">
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/pages/introcontrol/util/themes/icon.css">
		<script type="text/javascript" src="/ais/scripts/calendar.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/pages/introcontrol/util/jquery-1.7.1.min.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/pages/introcontrol/util/jquery.easyui.min.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/pages/introcontrol/util/easyui-lang-zh_CN.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
	
	<script type="text/javascript">
		${refresh}
		/**
		*	保存并新增11
		*/
		function addTypett(){
			myForm.fpid.value='${uOrganization.fid}';
			myForm.action='editUOrg.action';
			myForm.submit();
		}
		
		function addTypett2(){
			document.getElementsByName('message')[0].value="saveAndEdit";
			if(!myCheck()) return;
			myForm.submit();
		}
		
		function goToPage(s){
			if(s.indexOf("delUOrg")!=-1){
				if(!window.confirm("确定删除?")){
					return false;
				}
			}
			myForm.action=s;
			myForm.submit();
		}
	 	
	 	/**
	 	*	提交表单前的校验
	 	*/
		function myCheck(){
	 		
			if(document.getElementsByName("uOrganization.fname")[0].value==""){//判断种类是否为空
				alert("单位/部门名称不能为空！")
				document.getElementsByName('uOrganization.fname')[0].focus();
				return false;
			}
			
			ftype=$_name("uOrganization.ftype");
			if(ftype.value==""){
				alert("是否作为管理层级 不能为空!");ftype.focus();
				return false;
			}
			
			orgType=$_name("uOrganization.orgType");
			if(empty(orgType,'单位性质 不能为空!')){
				return false;
			}
	
			m1=$_name("uOrganization.fcode");//编码
			if(m1.value==''){
				alert("编码 不能为空!");
				return false;
			}
			
			m2=$_name("uOrganization.fname");//单位/部门名称
			m3=$_name("uOrganization.flogogram");//简称
			m4=$_name("uOrganization.alias");//别名
			m5=$_name("uOrganization.fleader");//负责人
			m6=$_name("uOrganization.fphone");//电话
			m7=$_name("uOrganization.fmobile");//手机
			m8=$_name("uOrganization.ffax");//传真
			if(comBig(m1.value,20,'编码 长度超长!')||comBig(m2.value,80,'单位/部门名称 长度超长!')
					||comBig(m3.value,30,'简称 长度超长!')||comBig(m4.value,40,'别名 长度超长!')
					||comBig(m5.value,8,'负责人 长度超长!')||comBig(m6.value,12,'电话 长度超长!')
					||comBig(m7.value,11,'手机 长度超长!')||comBig(m8.value,20,'传真 长度超长!')){
				return false;
			}
			city=$_name("uOrganization.cityCode");
			if(city.value==""){
				alert("所在城市 不能为空!");
				city.focus();
				return false;
			}
			if(chkFormBlank()){
				return false;
			}
			return true;
		}
		
		function mychg(obj,name){//onchange事件
			var index=obj.selectedIndex;// 取得选择的序列号
			var optName=obj.options[index].text;// 取得结果
			document.getElementsByName(name)[0].value=optName;
		}
		
		function empty(obj,msg){if(obj.value==''){if(typeof msg != 'undefined'){alert(msg)};obj.focus();return true;}return false;}
		function $_name(name){return document.getElementsByName(name)[0];	}
		function $_id(name){return document.getElementById(name);}
		function show(){var s=$_id("audit_show_0");s.style.display="block";s=$_id("audit_show_1");s.style.visibility="visible";var s2=$_id("audit_show_2");s2.style.visibility="visible";s.innerHTML='上级职能单位<font color="red">*</font>';}
		function hidd(){var s=$_id("audit_show_0");s.style.display="none";s=$_id("audit_show_1");s.style.visibility="hidden";var s2=$_id("audit_show_2");s2.style.visibility="hidden";s.innerHTML='上级职能单位';}
		function cascadeSpan(obj){var t=obj.options[obj.selectedIndex].value;if(t){if(t=="1"){show();return;}}hidd();}
		function init(){
			<s:if test="${not empty (uOrganization.orgType)}">
				<s:if test="${uOrganization.orgType=='1'}">
					show();
				</s:if><s:else>
					hidd();
				</s:else>
			</s:if>
		}
		
		function myback(id){
			window.location="<%=request.getContextPath()%>/admin/editUOrg.action?view=view&uOrganization.fid="+id;
		}
		function isMail(str) {return (new RegExp(/^[\w-]+@[\w-]+(\.[\w-]+)+$/).test(str));}
		function isIP(str) {return (new RegExp(/^(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])(\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])){3}$/).test(str));}
		String.prototype.gblen = function() {var len = 0;for (var i=0; i<this.length; i++){if(this.charCodeAt(i)>127 || this.charCodeAt(i)==94) {len+= 2;} else {len ++;}}return len;}
		function comBig(m,n,msg){if(m.gblen()>n){if(typeof msg != 'undefined'){alert(msg)}return true};return false;}
		function chkJianCheng(obj){
			v=obj.value;
			if(v.length==0){return ;}
			var html = $.ajax({
	 		url: "<%=request.getContextPath()%>/admin/chkFlogogram.action?uOrganization.fid=${uOrganization.fid}&uOrganization.flogogram="+v,
	 		async: false   
			}).responseText; 
			if(html=='true'){
				alert('该简称已经存在,请重新输入!');
				obj.focus();
				return;
			}
		}
	
		function chkFormBlank(){
			inputs=document.getElementsByTagName('table')[0].getElementsByTagName('input');
			for(i=0;i<inputs.length;i++){
				if(inputs[i].type=='text'){
					b=checkBank(inputs[i]);
					if(b==true){return true;}
				}
			}
			return false;
		}
		
		function checkBank(obj){
			b=obj.value.lastIndexOf(' ');
			b=b>=0;
			if(b){
				obj.focus();
				obj.select();
				alert('不能存在空格!');
			} 
			return b;
		}		
	</script>
	<title></title>
	<link href="/ais/styles/main/ais.css" rel="stylesheet" type="text/css">
	<link href="${contextPath}/css/main.css" rel="stylesheet" type="text/css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/pages/introcontrol/util/themes/default/easyui.css">		
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/pages/introcontrol/util/themes/icon.css">
	<script type="text/javascript" src="<%=request.getContextPath()%>/pages/introcontrol/util/jquery-1.7.1.min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/pages/introcontrol/util/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/pages/introcontrol/util/easyui-lang-zh_CN.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/aisui.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/scripts/validate.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/scripts/check.js"></script>
	</head>
	<body >
	<div class="easyui-panel" title="${name}" fit=true style="overflow: visibility ;">
		${ncError}
		<s:form id="myForm" action="saveUOrg" namespace="/admin" method="post" theme="simple" onsubmit="return myCheck()">
			<s:hidden name="m_type"></s:hidden>
			<s:hidden name="fpid"></s:hidden>
			<s:hidden name="message" value=""></s:hidden>
			<s:hidden name="uOrganization.fid" value="%{uOrganization.fid}"></s:hidden>
			<s:hidden name="uOrganization.fpid" value="%{uOrganization.fpid}"></s:hidden>
			<s:hidden name="uOrganization.fstatus" value="Y"></s:hidden>
			<s:hidden name="uOrganization.unitaryAisId" />
			 <s:hidden name="uOrganization.forder"></s:hidden> 
			<br>
			<table id='mytable' cellpadding=1 cellspacing=1 border=0  class="ListTable">
				<tr class="listtablehead">
					<td class="listtabletr2">
						编码<font color="red">*</font>
					</td>
					<td class="listtabletr2">
						<s:textfield   name="uOrganization.fcode" value="%{uOrganization.fcode}"></s:textfield>
					</td>
					<td class="listtabletr2">
						单位/部门名称<font color="red">*</font>
					</td>
					<td class="listtabletr2">
						<s:textfield name="uOrganization.fname" value="%{uOrganization.fname}" ></s:textfield>
					</td>
				</tr>
				<tr class="listtablehead">
					<td class="listtabletr2">
						简称<font color="red">*</font>
					</td>
					<td class="listtabletr2">
						<s:textfield name="uOrganization.flogogram" value="%{uOrganization.flogogram}"></s:textfield>
					</td>
					<td class="listtabletr2">
						别名
					</td>
					<td class="listtabletr2">
						<s:textfield name="uOrganization.alias" value="%{uOrganization.alias}"></s:textfield>
					</td>
					
				</tr>
				<tr class="listtablehead">
				<td class="listtabletr2">
						部门经理
					</td>
					<td class="listtabletr2">
						<s:textfield   name="uOrganization.fleader" value="%{uOrganization.fleader}"></s:textfield>
					</td>
					<td class="listtabletr2">
						电话
					</td>
					<td class="listtabletr2">
						<s:textfield   name="uOrganization.fphone" value="%{uOrganization.fphone}"></s:textfield>
					</td>
					
				</tr>
				<tr class="listtablehead">
				<td class="listtabletr2">
						手机
					</td>
					<td class="listtabletr2">
						<s:textfield   name="uOrganization.fmobile" value="%{uOrganization.fmobile}"></s:textfield>
					</td>
					<td class="listtabletr2">
						传真
					</td>
					<td class="listtabletr2">
						<s:textfield   name="uOrganization.ffax" value="%{uOrganization.ffax}"></s:textfield>
					</td>
					
				</tr>
				<tr class="listtablehead">
					<td class="listtabletr2">
						单位性质<font color="red">*</font>
					</td>
					<td class="listtabletr2">
						<s:select list="#@java.util.LinkedHashMap@{'1':'审计部门','2':'非审计部门'}" name="uOrganization.orgType" listValue="value" listKey="key" emptyOption="true" ></s:select><!-- onchange="cascadeSpan(this);" -->
					</td>
					<td class="listtabletr2">
						是否作为管理层级<font color="red">*</font>
					</td>
					<td class="listtabletr2">
						<s:if test="${empty (uOrganization.fpid) or uOrganization.fpid=='0' or not empty (disChgType) }">
							<s:hidden name="uOrganization.ftype"/>
							<s:select list="#@java.util.LinkedHashMap@{'C':'是','D':'否'}" name="uOrganization.ftype" listValue="value" listKey="key" emptyOption="true" disabled="true" ></s:select>
						</s:if>
						<s:elseif test="${parentIsDept}">
							<s:select list="#@java.util.LinkedHashMap@{'D':'否'}" name="uOrganization.ftype" listValue="value" listKey="key" emptyOption="true"></s:select>
						</s:elseif>
						<s:else>
						<s:select list="#@java.util.LinkedHashMap@{'C':'是','D':'否'}" name="uOrganization.ftype" listValue="value" listKey="key" emptyOption="true" ></s:select>
						</s:else>
					</td>
				</tr>
				<tr>
					<td  class="listtabletr2" colspan="1">
						所在城市<font color="red">*</font>			
					</td>
					<td  class="listtabletr2" colspan="3">
					
                        <input type="text"   name="uOrganization.cityName"  value='${uOrganization.cityName}' readOnly/>
                        <input type="hidden" name="uOrganization.cityCode"  value='${uOrganization.cityCode}'/><img  
                            style="cursor:hand;border:0"
                            src="/ais/resources/images/s_search.gif" 
                            onclick="showSysTree(this,{
                                              title:'请选择城市',
                                              param:{
                                                'rootParentId':'0',
                                                'beanName':'CodeAndNameTree',
                                                'whereHql':'type=\'58\' and status=\'1\'',
                                                'treeId'  :'code',
                                                'treeText':'name',
                                                'treeParentId':'pid',
                                                'treeOrder':'name',
                                                'lazy'     :false
                                              }
                                            })"></img>
					
                        <!--
						<s:select name="uOrganization.cityCode"
							list="basicUtil.cityList" listKey="code" listValue="name"
							headerKey="" headerValue="" required="true"/>
                         -->
					</td>
				</tr>
			</table>
			<table style="width:97%;border:0" > 
				<tr>
					<td>
						<span style="float:right;">
							<s:if test="${uOrganization.fid!=null}">
								<s:if test="${not empty (uOrganization.fid) and uOrganization.fid!='0'}">
									<input type="button" value="增加" onclick="addTypett();">
									<s:if test="!${isEditOrg}">
										<input type="button" value="修改" onclick="goToPage('editUOrg.action')">
									</s:if>
									<input type="button" value="删除" onclick="goToPage('delUOrg.action')">
								</s:if>
							</s:if> 
							<s:if test="${not empty (uOrganization.fpid) and uOrganization.fpid!='0'}">
							<input type="button" value="保存并增加" onclick="addTypett2();">
							</s:if>
							<s:submit value="保存" align="center"></s:submit>
							<s:if test="${not empty(uOrganization.fid) and uOrganization.fid!='0'}">
								<input type="button" value="返回" onclick="myback('${uOrganization.fid}');"/>
							</s:if>
							<s:else>
								<input type="button" value="返回" onclick="myback('${uOrganization.fpid}');"/>
							</s:else>
						</span>
					</td>
				</tr>
			</table>
		</s:form> 
		</div> 
	</body>
</html>
