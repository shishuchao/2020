<!DOCTYPE HTML>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<jsp:include flush="true" page="/admin/group/aisUrl.jsp"></jsp:include>
<title></title>
<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
<script type="text/javascript">
		${refresh}
		$(function(){
			if ('${saveError}' != '') {
				showMessage1('${saveError}');
			}
		});
		//显示信息
	  	if ('' != '${ncError}') {
	  		showMessage1('${ncError}');
	  	}
		/**
		*	新增
		*/
		function addTypett(){
			myForm.fpid.value='${uOrganization.fid}';
			myForm.action='editUOrg.action';
			myForm.submit();
			
		}
		
		function addTypett2(){
			//获取编码
			var code = document.getElementsByName("uOrganization.fcode")[0].value;
			var bol = parent.getNodeByCode(code);
			//校验原来的code与现在的code是否相等
			document.getElementsByName('message')[0].value="add";
			var editbol = parent.compareTreeCode('${uOrganization.fid}',code);
			if (editbol) {
				if (!bol) {
					showMessage1('组织机构编码重复，请修改后保存！');
					return;
				}
			}
			if(!myCheck()) return;
			myForm.submit();
			
		}
		
		function goToPage(s){
			if(s.indexOf("delUOrg") != -1){
                if('${uOrganization.orgstate}' == 'Y'){
                    showMessage1("组织机构状态为启用状态,请修改状态后再删除")
					return;
                }
				$.messager.confirm("确认","确定要删除？",function(result){
					if(result){
						myForm.action = s;
                        myForm.submit();
					}
				})
			}else if(s.indexOf("editUOrg") != -1){
				myForm.action=s;
				myForm.submit();
			}
		}
	 	
	 	/**
	 	*	提交表单前的校验
	 	*/
		function myCheck(){
			if(document.getElementsByName("uOrganization.fname")[0].value==""){//判断种类是否为空
				showMessage1("单位/部门名称不能为空！")
				document.getElementsByName('uOrganization.fname')[0].focus();
				return false;
			}
			
			ftype=$_name("uOrganization.ftype");
			if(ftype.value==""){
				showMessage1("是否作为管理层级 不能为空!");ftype.focus();
				return false;
			}
			
			orgType=$_name("uOrganization.orgType");
			if(empty(orgType,'单位性质 不能为空!')){
				return false;
			}
	
			m1=$_name("uOrganization.fcode");//编码
			if(m1.value==''){
				showMessage1("编码 不能为空!");
				return false;
			}
			
			m2=$_name("uOrganization.fname");//单位/部门名称
			m3=$_name("uOrganization.flogogram");//简称
			m4=$_name("uOrganization.alias");//英文名称
			m5=$_name("uOrganization.fleader");//负责人
			m6=$_name("uOrganization.fphone");//电话
			m7=$_name("uOrganization.fmobile");//手机
			m8=$_name("uOrganization.ffax");//传真
			if(comBig(m1.value,20,'编码 长度超长!')||comBig(m2.value,80,'单位/部门名称 长度超长!')
					||comBig(m3.value,30,'简称 长度超长!')||comBig(m4.value,40,'英文名称 长度超长!')
					||comBig(m5.value,8,'负责人 长度超长!')||comBig(m6.value,12,'电话 长度超长!')
					||comBig(m7.value,11,'手机 长度超长!')||comBig(m8.value,20,'传真 长度超长!')){
				return false;
			}
			
			var re1 = /^[0-9]*$/;
			var re2 = /^(\(\d{3,4}\)|\d{3,4}-)?\d{7,8}$/;
			/*
			if(m6.value != ""){
				if (!re2.test(m6.value)){
			        showMessage1("电话格式不正确!(如：XXXX-XXXXXXX)");
			        return false;
			     }
			}*/
			/*
			if(m8.value != ""){
			 if (!re2.test(m8.value)){
			        showMessage1("传真格式不正确!(如：XXXX-XXXXXXX)");
			        return false;
			     }
			}*/
			if(m7.value != ""){
			 if (!re1.test(m7.value)){
			        showMessage1("手机请输入数字!");
			        return false;
			     }
			}
			
			
			
			audCity =$("#audCity").combobox('getValue');
			if(audCity == ""){
				showMessage1("所在城市 不能为空!");
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
		
		function empty(obj,msg){if(obj.value==''){if(typeof msg != 'undefined'){showMessage1(msg)};obj.focus();return true;}return false;}
		function $_name(name){return document.getElementsByName(name)[0];	}
		function $_id(name){return document.getElementById(name);}
		function show(){var s=$_id("audit_show_0");s.style.display="block";s=$_id("audit_show_1");s.style.visibility="visible";var s2=$_id("audit_show_2");s2.style.visibility="visible";s.innerHTML='上级职能单位<font color="red">*</font>';}
		function hidd(){var s=$_id("audit_show_0");s.style.display="none";s=$_id("audit_show_1");s.style.visibility="hidden";var s2=$_id("audit_show_2");s2.style.visibility="hidden";s.innerHTML='上级职能单位';}
		function cascadeSpan(obj){var t=obj.options[obj.selectedIndex].value;if(t){if(t=="1"){show();return;}}hidd();}
		function myback(id){
			window.location="<%=request.getContextPath()%>/admin/editUOrg.action?back=back&view=view&uOrganization.fid="+id;
		}
		function isMail(str) {return (new RegExp(/^[\w-]+@[\w-]+(\.[\w-]+)+$/).test(str));}
		function isIP(str) {return (new RegExp(/^(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])(\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])){3}$/).test(str));}
		String.prototype.gblen = function() {var len = 0;for (var i=0; i<this.length; i++){if(this.charCodeAt(i)>127 || this.charCodeAt(i)==94) {len+= 2;} else {len ++;}}return len;}
		function comBig(m,n,msg){if(m.gblen()>n){if(typeof msg != 'undefined'){showMessage1(msg)}return true};return false;}
		function chkJianCheng(obj){
			v=obj.value;
			if(v.length==0){return ;}
			var html = $.ajax({
	 		url: "<%=request.getContextPath()%>/admin/chkFlogogram.action?uOrganization.fid=${uOrganization.fid}&uOrganization.flogogram="+v,
	 		async: false   
			}).responseText; 
			if(html=='true'){
				showMessage1('该简称已经存在,请重新输入!');
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
				showMessage1('不能存在空格!');
			} 
			return b;
		}
		
		function showSearchCity(){
			$('#city').show();
			$("#citys").html("");
			$.ajax({
				   type: "POST",
				   dataType:"json",
				   url: "<%=request.getContextPath()%>/admin/editUOrg!getAudCitys.action",
				   success: function(msg){
					   $.each(msg, function(i, n){
						   $("#citys").append("&nbsp;<span ondblclick='doGetAudCity(\"" + n.code + "\",\"" + n.name + "\")' style='cursor: pointer;'>"+n.name+"</span>&nbsp;");
						 });
				   }
				});
			$('#city').window('open');
		}
		
		function doSearchCity(){
	         var cityName = $("#cityName").val();
	         $("#citys").html("");
	         $.ajax({
				   type: "POST",
				   dataType:"json",
				   data:{"cityName":cityName},
				   url: "<%=request.getContextPath()%>/admin/editUOrg!getNewCitys.action",
				   success: function(msg){
					   $.each(msg, function(i, n){
						   $("#citys").append("&nbsp;<span ondblclick='doGetAudCity(\"" + n.code + "\",\"" + n.name + "\")' style='cursor: pointer;'>"+n.name+"</span>&nbsp;");
						 });
				   }
				});
		}
		
		function doGetAudCity(code, name){
			//$("#audCity").val(code);
			var audCityComb = $("#audCity");
			var data = audCityComb.combobox('getData');
			if ($.grep(data, function(n){return n.text==name;}).length == 0) {
				data[data.length] = {value:code,text:code}
			}
			audCityComb.combobox('loadData', data);
			audCityComb.combobox('setValue',code);
			$('#city').window('close');
		}
		
	</script>
</head>
<body>
	<div class="easyui-panel" title="${name}" style="overflow: visibility;border:0px;">
		<table style="width:100%;border:0">
				<tr>
					<td class="EditHead"><span style="float:right;">
							<s:if test="${uOrganization.fid != null}">
								<s:if test="${not empty (uOrganization.fid) and uOrganization.fid != '0'}">
									<a class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="addTypett();">增加</a>
									<s:if test="!${isEditOrg}">
										<a class="easyui-linkbutton" data-options="iconCls:'icon-edit'" onclick="goToPage('editUOrg.action')">修改</a>
									</s:if>
									<s:if test="${uOrganization.fid != '1'}">
										<a class="easyui-linkbutton" data-options="iconCls:'icon-delete'" onclick="goToPage('delUOrg.action')">删除</a>
									</s:if>
								</s:if>
							</s:if>
							<s:if test="${not empty (uOrganization.fpid) and uOrganization.fpid != '0'}">
								<a class="easyui-linkbutton" data-options="iconCls:'icon-add'"  onclick="addTypett2();">保存并增加</a>
							</s:if> 
								<a class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="toAdd()" align="center">保存</a> 
							<s:if test="${not empty(uOrganization.fid) and uOrganization.fid!='0'}">
								<a class="easyui-linkbutton" data-options="iconCls:'icon-undo'" onclick="myback('${uOrganization.fid}');" />返回</a>
							</s:if> 
							<s:else>
								<a class="easyui-linkbutton" data-options="iconCls:'icon-undo'" onclick="myback('${uOrganization.fpid}');" />返回</a>
							</s:else>
					</span></td>
				</tr>
			</table>
		<!--  ${ncError} -->
		<s:form id="myForm" action="saveUOrg" namespace="/admin" method="post" theme="simple" onsubmit="return myCheck()">
			<s:hidden name="m_type"></s:hidden>
			<s:hidden name="fpid"></s:hidden>
			<s:hidden name="message" value=""></s:hidden>
			<s:hidden name="uOrganization.fid" value="%{uOrganization.fid}"></s:hidden>
			<s:hidden name="uOrganization.fpid" value="%{uOrganization.fpid}"></s:hidden>
			<s:hidden name="uOrganization.fstatus" value="Y"></s:hidden>
			<s:hidden name="uOrganization.unitaryAisId" />
			<s:hidden name="uOrganization.forder"></s:hidden>
			<s:hidden name="name" value="${name}"></s:hidden>
			<table id='mytable' cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
				<tr >
					<td class="EditHead"  style="width:15%;">
						<font color="red">*</font>&nbsp;编码
					</td>
					<td class="editTd"  style="width:32%" >
						<s:textfield cssClass="noborder" name="uOrganization.fcode" value="%{uOrganization.fcode}"></s:textfield>
					</td>
					<td class="EditHead" style="width:20%">
						<font color="red">*</font>&nbsp;单位/部门名称
					</td>
					<td class="editTd"  style="width:33%">
						<s:textfield cssClass="noborder" name="uOrganization.fname" value="%{uOrganization.fname}"></s:textfield>
					</td>
				</tr>
				<tr >
					<td class="EditHead" >
					<font color="red">*</font>&nbsp;简称
					</td>
					<td class="editTd" >
						<s:textfield cssClass="noborder" name="uOrganization.flogogram" value="%{uOrganization.flogogram}"></s:textfield>
					</td>
					<td class="EditHead">英文名称</td>
					<td class="editTd" >
						<s:textfield cssClass="noborder" name="uOrganization.alias" value="%{uOrganization.alias}"></s:textfield>
					</td>
				</tr>
				<tr >
					<td class="EditHead" >部门负责人</td>
					<td class="editTd"  ><s:textfield cssClass="noborder" name="uOrganization.fleader" value="%{uOrganization.fleader}"></s:textfield></td>
					<td class="EditHead"  >电话</td>
					<td class="editTd"  ><s:textfield cssClass="noborder" name="uOrganization.fphone" value="%{uOrganization.fphone}"></s:textfield></td>

				</tr>
				<tr >
					<td class="EditHead" >手机</td>
					<td class="editTd" ><s:textfield cssClass="noborder" name="uOrganization.fmobile" value="%{uOrganization.fmobile}"></s:textfield></td>
					<td class="EditHead" >传真</td>
					<td class="editTd" ><s:textfield cssClass="noborder" name="uOrganization.ffax" value="%{uOrganization.ffax}"></s:textfield></td>

				</tr>
				<tr>
					<td class="EditHead" style="width:100px;">
					<font color="red">*</font>&nbsp;单位性质
					</td>
					<td class="editTd" >
							<select class="easyui-combobox" name="uOrganization.orgType" style="width:150px;"  panelHeight="auto">
						       <s:iterator value="#@java.util.LinkedHashMap@{1:'审计部门',2:'非审计部门'}" id="entry">
						       <s:if test="${uOrganization.orgType eq key}">
						       	 <option selected="selected" value="<s:property value="key"/>"><s:property value="value"/></option>
						       </s:if>
						       <s:else>
						         <option value="<s:property value="key"/>"><s:property value="value"/></option>
						         </s:else>
						       </s:iterator>
						    </select>
					</td>
					<td class="EditHead" >
					<font color="red">*</font>&nbsp;是否作为管理层级
					</td>
					<td class="editTd" >
					<s:if test="${empty (uOrganization.fpid) || uOrganization.fpid=='0' || not empty (disChgType) }">
							<select class="easyui-combobox" name="uOrganization.ftype" style="width:150px;" panelHeight="auto">
						       <s:iterator value='#@java.util.LinkedHashMap@{"C":"是","D":"否"}' id="entry">
						       <s:if test="${uOrganization.ftype==key}">
						       	 <option selected="selected" value="<s:property value="key"/>"><s:property value="value"/></option>
						       </s:if>
						       <s:else>
						         <option value="<s:property value="key"/>"><s:property value="value"/></option>
						         </s:else>
						       </s:iterator>
						    </select>
						</s:if>
				 		<s:elseif test="${parentIsDept}">
						<select class="easyui-combobox" name="uOrganization.ftype" panelHeight="auto" >
						       <s:iterator value='#@java.util.LinkedHashMap@{"C":"是","D":"否"}' id="entry">
						          <s:if test="${uOrganization.ftype==key}">
						       	 <option selected="selected" value="<s:property value="key"/>"><s:property value="value"/></option>
						       </s:if>
						       <s:else>
						         <option value="<s:property value="key"/>"><s:property value="value"/></option>
						       </s:else>
						       </s:iterator>
						    </select>
							
						</s:elseif> <s:else>
						
						<select class="easyui-combobox" name="uOrganization.ftype"  panelHeight="auto">
						       <s:iterator value='#@java.util.LinkedHashMap@{"C":"是","D":"否"}' id="entry">
						        <s:if test="${uOrganization.ftype==key}">
						       	 <option selected="selected" value="<s:property value="key"/>"><s:property value="value"/></option>
						       </s:if>
						       <s:else>
						         <option value="<s:property value="key"/>"><s:property value="value"/></option>
						       </s:else>
						       </s:iterator>
						    </select>
						</s:else> 
					
					</td>
				</tr>
				<tr>
					<td class="EditHead"  colspan="1">
					<font color="red">*</font>&nbsp;所在城市
					</td>
					<td class="editTd"  style="width:200px" colspan="1">
					
					<select class="easyui-combobox" name="uOrganization.cityCode" style="width:150px;" id="audCity" panelHeight="300px">
						       <s:iterator value="basicUtil.cityList" id="entry">
						        <s:if test="${uOrganization.cityCode==code}">
						       	 <option selected="selected" value="<s:property value="code"/>"><s:property value="name"/></option>
						       </s:if>
						       <s:else>
						         <option value="<s:property value="code"/>"><s:property value="name"/></option>
						       </s:else>
						       </s:iterator>
				    </select>
					<a class="easyui-linkbutton" data-options="iconCls:'icon-search'"   onclick="showSearchCity()">模糊查询</a>
						<div id="city" class="easyui-window" title="所在城市模糊查询" style="width:700px;height:400px;display: none;" data-options="collapsible:false,maximizable:false,minimizable:false,modal:true,closed:true">
							<table class="ListTable">
								<tr class="listtablehead">
									<td class="editTd"><input class="noborder" id="cityName" type="text">&nbsp; <a class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="doSearchCity()">查询</a>&nbsp;(点击按钮模糊查询,双击选中)</td>
								</tr>
								<tr>
								    <td> <div id="citys"></div></td>
								</tr>
							</table>
						</div>
					</td>
					
					<td class="EditHead">
						<font color="red">*</font>&nbsp;所属行业板块
					</td>
					<td class="editTd" style="width:200px">
						<input type='hidden' id='uOrganization_tradePlateName' name='uOrganization.tradePlateName' value="${uOrganization.tradePlateName}" class="noborder editElement clear"/>
						<select class="easyui-combobox" name="uOrganization.tradePlateCode" style="width:150px;" id="audTradePlate" panelHeight="300px">
							<s:iterator value="basicUtil.trade_PlateList" id="entry">
								<s:if test="${uOrganization.tradePlateCode == code}">
									<option selected="selected" value="<s:property value="code"/>"><s:property value="name"/></option>
								</s:if>
								<s:else>
									<option value="<s:property value="code"/>"><s:property value="name"/></option>
								</s:else>
							</s:iterator>
						</select>					
					</td>
				</tr>
				<tr>
					<td class="EditHead" style="width:15%;" nowrap><font color=red>*</font>机构级次</td>
					<td class="editTd" style="width:35%;">
						<input type='hidden' id='uOrganization_levelName' name='uOrganization.levelName' value="${uOrganization.levelName}" class="noborder editElement clear"/>
						<select class="easyui-combobox" name="uOrganization.levelCode" style="width:150px;" id="orgLeve" panelHeight="300px">
							<s:iterator value="basicUtil.org_LevelList" id="entry">
								<s:if test="${uOrganization.levelCode == code}">
									<option selected="selected" value="<s:property value="code"/>"><s:property value="name"/></option>
								</s:if>
								<s:else>
                                    <s:if test="${uOrganization.levelCode <= code}">
									<option value="<s:property value="code"/>"><s:property value="name"/></option>
                                    </s:if>
									<s:else>
										<s:if test="${uOrganization.levelCode < code}">
										<option value="<s:property value="code"/>"><s:property value="name"/></option>
										</s:if>
									</s:else>
								</s:else>
							</s:iterator>
						</select>			
					</td>
					<td class="EditHead">
						状态
					</td>
					<td class="editTd">
						<s:select list="#@java.util.LinkedHashMap@{'Y':'启用','D':'已删除'}"  listValue="value" name="uOrganization.orgstate"
							listKey="key" value="%{uOrganization.orgstate}" cssStyle="width:150px;" cssClass="easyui-combobox"></s:select>
					</td>
				</tr>
				<s:if test="${uOrganization.fid != null && uOrganization.fid != ''}">
				<tr>
					<td class="EditHead">
						联系人
					</td>
					<td class="editTd" colspan="3">
						<input type='hidden' id='uOrganization_contactName' name='uOrganization.contactName' value="${uOrganization.contactName}"
							   class="noborder editElement clear"/>
						<select id="contact" editable="false" name="uOrganization.contact"  PanelHeight="auto" class="easyui-combobox" style="width:150px;">
							<option value="">&nbsp;</option>
							<s:iterator value="map">
								<s:if test="${uOrganization.contact ==key}">
									<option selected="selected" value="<s:property value="key"/>"><s:property value="value"/></option>
								</s:if>
								<s:else>
									<option value="<s:property value="key"/>"><s:property value="value"/></option>
								</s:else>
							</s:iterator>
					</td>
				</tr>
				</s:if>
			</table>

		</s:form>
	</div>
	<script type="text/javascript">
	//保存
	function toAdd(){
		//获取编码
		var code = document.getElementsByName("uOrganization.fcode")[0].value;
		//校验现在的code是否重复
		var bol = parent.getNodeByCode(code);
		//校验原来的code与现在的code是否相等
		var editbol = parent.compareTreeCode('${uOrganization.fid}',code);
		if (editbol) {
			if (!bol) {
				showMessage1('组织机构编码重复，请修改后保存！');
				return;
			}
		}
		 var tradePlateValue = $('#audTradePlate').combobox('getText');//行业板块
    	 $("#uOrganization_tradePlateName").val(tradePlateValue);
    	 var orgLeveValue = $('#orgLeve').combobox('getText');//机构级次
    	 $("#uOrganization_levelName").val(orgLeveValue);
		//document.getElementsByName('message')[0].value="${uOrganization.fid}";
		if(!myCheck()) return;
		document.getElementById("myForm").submit();
	}
	</script>
</body>
</html>
