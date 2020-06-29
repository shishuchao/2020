<!DOCTYPE HTML >
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<html>
	<head>
		<title>修改审计人员基本信息</title>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">	
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>  	
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
		<link href="${contextPath}/styles/jquery.multiSelect.css" rel="stylesheet" type="text/css">
		<script type='text/javascript' src='${contextPath}/scripts/jquery.multiSelect.js'></script>
		<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ufaudTextLengthValidator.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/autosize.js"></script> 
		<script type="text/javascript" src="${contextPath}/resources/js/jquery-fileUpload.js"></script>
		<link href="${contextPath}/styles/jquery.searchableSelect.css" rel="stylesheet" type="text/css">
		<script type="text/javascript" src="${contextPath}/scripts/jquery.searchableSelect.js"></script>
		<s:head theme="simple" />
		<script type="text/javascript">
		$(document).ready(function(){	
			 $('#nativePlace').searchableSelect();     
			 
			$('#workingAbroad').attr('maxlength',500);
			$('#encourageMessage').attr('maxlength',500);
			$("#myform").find("textarea").each(function(){
				autoTextarea(this);
			});
			$('#employeeInfo_file').fileUpload({
				fileGridTitle:'资质文件',
				fileGuid:'${employeeInfo.uuid}',
				isDel:true,
				isEdit:true
			});
			$('#employeeInfo_file').fileUpload('reloadFile');
			// 设置多选框的默认选中项。
			$("#strongPointCode1").attr("value","");//清空选中项。
			var ids = '${crudObject.strongPoint}';//选中框ID。
			var id_Ojbect = ids.split(",");//分割为Ojbect数组。
			var count = $("#strongPointCode1 option").length;//获取下拉框的长度。
			//alert(ids +"\n" + id_Ojbect + '\n' + count);
			for(var c = 0; c < id_Ojbect.length; c++){
				for(var c_i = 0; c_i < count; c_i++) { 
					//alert($("#strongPointCode1").get(0).options[c_i].text+"\n"+id_Ojbect[c]);
			    	if($("#strongPointCode1").get(0).options[c_i].text == id_Ojbect[c]) {  
			            $("#strongPointCode1").get(0).options[c_i].selected = true;//设置为选中。
			        }  
			    } 
			}
			
			$("#strongPointCode1").multiSelect({ 
					selectAll: false,
					oneOrMoreSelected: '*',
					selectAllText: '全选',
					noneSelected: ''
				}, function(){   //回调函数
					//alert(1+'${basicUtil.specialityList}');
					//alert($("#strongPointCode").selectedValuesString());
					$('#strongPointCode').attr('name','crudObject.strongPointCode').val($("#strongPointCode1").selectedValuesString());
					//alert($('#strongPointCode').val());
					//alert($('#strongPointCode').attr('name','crudObject.strongPointCode').val());
				});
			
			
				$('#employeeInfoSex').combobox({
					panelHeight:'auto',
					editable:false
				});
			});

			function save(isOnlySave){
				/*var beginWorkDate = document.getElementsByName("crudObject.beginWorkDate")[0].value;
				var outDate = document.getElementsByName("crudObject.outDate")[0].value;
				var dimissionDate = document.getElementsByName("crudObject.dimissionDate")[0].value;*/
				document.getElementsByName("isOnlySave")[0].value = isOnlySave;
				var value = document.getElementsByName('crudObject.encouragemessage')[0].value;
				if(value.length > 500){
					showMessage1('请输入不超过500字的内容！');
					return false;
				}
				var value = document.getElementsByName('crudObject.workingAbroad')[0].value;
				if(value.length > 500){
					showMessage1('请输入不超过500字的内容！');
					return false;
				}
				//if(frmCheck(document.forms[0], 'tab1') 
					//	&& personCodeValidate()				//校验人员编码是否重复
						//&& emailValidate('email')&& phoneValidate('mobileTelephone')){
					/*if(beginWorkDate!=null && beginWorkDate!='' && outDate!=null && outDate!='' && !compareDate(beginWorkDate,outDate)){
						alert("调出时间 要大于 入职时间!");
						return false;
					}
					if(beginWorkDate!=null && beginWorkDate!='' && dimissionDate!=null && dimissionDate!='' && !compareDate(beginWorkDate,dimissionDate)){
						alert("离职时间 要大于 入职时间!");
						return false;
					}*/
					/*
					if($('#strongPointCode').attr('name','crudObject.strongPointCode').val() == ''){
						alert("请选择人员特长");
						return false;
					}*/
					document.forms[0].action="employeeInfoUpdate.action";
					document.forms[0].submit();
				//}			
			}
			
			function backDataList(){
					document.forms[0].action="backDataList.action";
					document.forms[0].submit();
			}		
			
			//清空离职时间后执行该方法
			function afterClear(){
				if(WebCalendar.objExport.name == 'crudObject.dimissionDate')
					document.getElementsByName('crudObject.incumbencyStateCode')[0].value = '801710';
			}
			
			//选择离职时间后执行该方法
			function afterClick(){
				if(WebCalendar.objExport.name == 'crudObject.dimissionDate')
					document.getElementsByName('crudObject.incumbencyStateCode')[0].value = '801720';
			}
			//验证系统用户是否被锁定
			function validateSysAcc(loginname, id){
					var flag = false;
					//系统账号必填
						if(loginname==null || loginname==''){
							alert("请选择系统账号！");
							return false;
						}else{
							DWREngine.setAsync(false);
							DWREngine.setAsync(false);DWRActionUtil.execute(
							{ namespace:'/mng/employee', action:'validateSysAccounts', executeResult:'false' }, 
							{ 'ln':loginname, 'poid':id },
							xxx);
						    function xxx(data){
						     	if(data['message'] != null && data['message'] != ""){
						     		alert(data['message']);
						     		flag = false;
						     	}else{
						     		flag = true;
						     	}
							}
							return flag;
						}
					return flag;
			}			
			
			function changeISA(vle){
				var sysacc = document.getElementById('sysacc').children;
				for(var i=0;i<sysacc.length;i++){
					if(vle=='否'){
						document.getElementById('sysacc').style.display='';
						document.getElementById('color_sign1').style.display='';
						document.getElementById('msg1').style.display='';
						document.getElementById('msg2').style.display='';
						document.getElementById('msg3').style.display='';
						document.getElementById('color_sign2').style.display='none';
						document.getElementById('color_sign3').style.display='none';
						document.getElementById('color_sign4').style.display='none';
						sysacc[i].style.display='';
					}else {
						document.getElementById('color_sign1').style.display='none';
						document.getElementById('msg1').style.display='none';
						document.getElementById('msg2').style.display='none';
						document.getElementById('msg3').style.display='none';
						document.getElementById('color_sign2').style.display='';
						document.getElementById('color_sign3').style.display='';
						document.getElementById('color_sign4').style.display='';
						sysacc[i].style.display='none';
						if(sysacc[i].id=='sysAccounts'){
							sysacc[i].value='';
						}
					}
				}
			}
			
			function toSubmit(){
				<s:if test="isUseBpm=='true'">
					if(confirm("确认提交吗？")){
						document.forms[0].action="<s:url action="submit" includeParams="none"/>";
						document.forms[0].submit();
					}
				</s:if>
				<s:else>
					save();
				</s:else>
				
			}
			function beforStartProcess(){
				return true;
			}
		
		/*选择系统账号自动填充姓名和人员编码*/
		function nameAndCode(){
			var sysName = document.getElementsByName("crudObject.sysAccounts")[0].value
			//填写姓名 和人员编码
			DWREngine.setAsync(false);
    		DWREngine.setAsync(false);DWRActionUtil.execute(
    				{ namespace:'/mng/employee', action:'findNameAndCode', executeResult:'false' }, 
    				{'sysAccounts':sysName},
    				xxx1);
   			function xxx1(data){
   				if(data['name'] != null && data['name'] != ''){
        			document.getElementsByName("crudObject.name")[0].value=data['name'];
       			}
       			if(data['personnelCode'] != null && data['personnelCode'] != ''){
        			document.getElementsByName("crudObject.personnelCode")[0].value=data['personnelCode'];
       			}
		       			
		   	}
		}
		//验证人员编码是否重复
		function personCodeValidate(){
					var flag = false;
					var personnelCode = document.getElementsByName("crudObject.personnelCode")[0].value;
					if(personnelCode !='${crudObject.personnelCode}'){
						DWREngine.setAsync(false);
						DWREngine.setAsync(false);DWRActionUtil.execute(
						{ namespace:'/mng/employee', action:'validatePersonCode', executeResult:'false' }, 
						{ 'personnelCode':personnelCode},
						xxx);
					    function xxx(data){
					     	if(data['message'] != null && data['message'] != ""){
					     		alert(data['message']);
					     		flag = false;
					     	}else{
					     		flag = true;
					     	}
						}
					}else{
						flag = true;
					}
					return flag;
		}
		/*
		上传附件
	 */
	function Upload(id, filelist) {
		var guid = document.getElementById(id).value;
		var num = Math.random();
		var rnm = Math.round(num * 9000000000 + 1000000000);//随机参数清除模态窗口缓存
		window.showModalDialog('${contextPath}/commons/file/welcome.action?table_name=mng_employee_info&talbe_guid=uuid&guid=' + guid + '&&param=' + rnm + '&&deletePermission=true', filelist, 'dialogWidth:700px;dialogHeight:450px;status:yes');
		//parent.setAutoHeight();
	}
	function deleteFile(fileId, guid, isDelete, isEdit, appType, title) {
		var boolFlag = window.confirm("确认删除吗?");
		if (boolFlag == true) {
			DWREngine.setAsync(false);
			DWRActionUtil.execute({
				namespace : '/commons/file',
				action : 'delFile',
				executeResult : 'false'
			}, {
				'fileId' : fileId,
				'deletePermission' : isDelete,
				'isEdit' : isEdit,
				'guid' : guid,
				'appType' : appType,
				'title' : title
			}, xxx);
			function xxx(data) {
				document.getElementById(guid).parentElement.innerHTML = data['accessoryList'];
			}
		}
	}
	
	
	function getUserMsgById(id){
		$.ajax({
   			url:'${pageContext.request.contextPath}/mng/employee/getUserMsgById.action',
   			type:'POST',
   			data:{'userId':id[0]},
   			async:false,
   			success:function(data){
   				if(data != null || data != ""){
   					var str = data.split("#");
   	   				var birthdate = str[0];//出生日期
   	   				var nationalityname = str[1]; //民族名称
   	   				var nationalitycode = str[2];//民族code
   	   				var nativeplacename = str[3];//籍贯
   	   				
   	   				var officephone = str[4];//办公电话
   	   				var mobile = str[5];//手机
   	   				var joinworkdate = str[6];//参加工作日期
   	   				var polityname = str[7];//政治面貌名称
   	   				var politycode = str[8];
   	   				var educationcode = str[9];//全日制学历
   	   				var educationname = str[10];
   	   				var dutyname = str[11];//职务名称
   	   				var dutycode = str[12];
   	   				var joinsysdate = str[13];//入司时间
   	   				var nativeplacecode = str[14];//籍贯code
   	   			
   	   				$('#employeeInfoBorn').datebox('setValue', birthdate != null ? getDate(birthdate) : '');
   	   				document.getElementById('officePhone').value=officephone!= null ? officephone : '';
   	   				document.getElementById('mobileTelephone').value=mobile!= null ? mobile : '';
   	   				$('#graduateDate').datebox('setValue',joinworkdate != null ? getDate(joinworkdate) : '');//参见工作时间
   	   				$('#entryTime').datebox('setValue', joinsysdate != null ? getDate(joinsysdate) : '');
   	   			
   	   				$('#nationCode').combobox('setValue', nationalityname != null ? nationalityname : '');//名族
   	   				document.getElementsByName("crudObject.nationCode")[0].value = nationalitycode;
   	   				
   	   				$('#duty').val(dutyname);
   	   				$('#dutyCode').val(dutycode);
   	   				
   	   				$('#polityVisageCode').combobox('setValue', polityname != null ? polityname : '');//政治面貌
   	   				document.getElementsByName("crudObject.polityVisageCode")[0].value = politycode;
   	   				
   	   				$('#diplomaCode').combobox('setValue', educationname != null ? educationname : '');//学历
   	   				document.getElementsByName("crudObject.diplomaCode")[0].value = educationcode;
   	   				
   	   				$('#nativePlace').combobox('setValue', nativeplacename != null ? nativeplacename : '');//籍贯名称
	   				document.getElementsByName("crudObject.nativePlace")[0].value = nativeplacecode;
   				}
   				
   			}
   		})
	}
		</script>
	</head>
	<body>
		<s:form id="myform" action="start" namespace="/mng/employee">
		<s:token/>		
			<% java.util.List list = (java.util.List)request.getAttribute("modifyHistors");
				if(list!=null&&!list.isEmpty()){
			 %>
			<table cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
                <tr >
                    <td colspan="4" align="left" class="EditHead">
               			       审计人员基本信息修改
                    </td>
                </tr>
				<tr>				
					<td colspan="5" align="left" class="EditHead">
						&nbsp;修改内容
					</td>
				</tr>
				<tr style="font-weight: bold;">
					<td>修改属性</td><td>原值</td>
					<td>新值</td><td>修改人</td>
				</tr>
			<s:iterator id="mh" value="modifyHistors">
			<tr>
				<td class="editTd">${mh.columnCnName }</td><td class="ListTableTr2">${mh.oldValue }</td>
				<td class="editTd" style="color: red">${mh.newValue }</td><td class="ListTableTr2">${mh.userName }</td>
			</tr>
			</s:iterator>
			</table>
			<%} %>
				<table id="tab1" cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
					<s:hidden name="crudObject.uuid"></s:hidden>
                    <tr>
                        <td colspan="4" align="left" class="EditHead">
                           	<font style="float: left;"> 审计人员基本信息修改</font>
                           	<div align="right" style="padding-right:5px;">
								<a class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="save('yes');">保存并返回</a>&nbsp;&nbsp;
								<s:hidden name="isOnlySave" value="no"></s:hidden>
								<a class="easyui-linkbutton" data-options="iconCls:'icon-undo'" onclick="window.history.go(-1);">返回</a>&nbsp;&nbsp;
							</div>
                        </td>
                    </tr>
					<TR>
						<TD  nowrap  class=EditHead style="width: 15%" >
							<FONT color=red>*</FONT>&nbsp;是否为外部审计人才
						</TD>
						<TD class=editTd  align="left" style="width: 400px">
							<select editable="false" name="crudObject.isSysAccounts" style="width:165px"  class="easyui-combobox" PanelHeight="auto" >
								<s:iterator value='#@java.util.LinkedHashMap@{"是":"是", "否":"否"}'>
									<s:if test="${crudObject.isSysAccounts eq key}">
									<option selected="selected"  value="<s:property value="key"/>"><s:property value="value"/></option>
									</s:if>
									<s:else>
										<option value="<s:property value="key"/>"><s:property value="value"/></option>
									</s:else>
								</s:iterator>
							</select>
						</TD>
					<TD  nowrap  class=EditHead >
						<FONT color=red id="color_sign1" >*</FONT>&nbsp;系统账号
							
					</TD>
					<TD class=editTd>
						<div id="sysacc" >
							<%--<s:buttonText name="crudObject.sysAccounts" id="sysAccounts" readonly="true"
							cssStyle="color:gray;"
							doubleOnclick="showPopWin('/pages/system/search/frameselect4s.jsp?url=/pages/searchsystem/userindex.jsp&paraname=crudObject.sysAccounts&paraname2=crudObject.company&paraid=crudObject.sysAccounts&paraid2=crudObject.companyCode&p_item=1&orgtype=1&funname=nameAndCode()',600,350,'人员选择')"
							doubleSrc="/resources/images/s_search.gif"
							doubleCssStyle="cursor:hand;border:0;color:Gray;" doubleDisabled="false" />--%>
							<s:buttonText2 name="crudObject.sysAccounts" id="sysAccounts"
										   cssClass="noborder"
										   cssStyle="color:gray;width:35%;"
										   readonly="true"
										   maxlength="500"
										   title="系统账号"
										   doubleOnclick="showSysTree(
												this,
												{
													url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action',
													param:{
														'p_item':1,
														'orgtype':1
													},
													singleSelect:true,
													title:'请选择系统账号',
													type:'treeAndUser',
													onAfterSure:function(id,name,personnelCode,company,companyCode){
														$.ajax({
															url:'${pageContext.request.contextPath}/mng/employee/getUserById.action',
															type:'POST',
															data:{'userId':id[0]},
															async:false,
															success:function(data){
																data = eval('(' + data + ')');
																//性别 employeeInfo.sex，手机 mobileTelephone 、邮箱email，出生日期 employeeInfoBorn
																$('#employeeInfoSex').combobox('setValue', data.fsex != null ? data.fsex : '');
																$('#mobileTelephone').val(data.fmobile!= null ? data.fmobile : '');
																$('#email').val(data.femail != null ? data.femail : '');
																$('#employeeInfoBorn').datebox('setValue', getDate(data.fborn));
																$('#identityCard').val(data.fcard != null ? data.fcard : '');
															}
														});
														document.getElementsByName('crudObject.sysAccounts')[0].value = id;
														document.getElementsByName('crudObject.name')[0].value = name;
														document.getElementsByName('crudObject.company')[0].value = company;
														document.getElementsByName('crudObject.companyCode')[0].value = companyCode;
														document.getElementsByName('crudObject.personnelCode')[0].value = personnelCode;
														// getUserMsgById(personnelCode);
													}
												}
											)"
										   doubleSrc="${pageContext.request.contextPath}/resources/images/s_search.gif"
										   doubleCssStyle="cursor:hand;border:0;color:Gray;" doubleDisabled="false"/>
						</div>
					</TD>					
				</TR>
				<TR>
					<TD  nowrap  class=EditHead >
						<FONT color=red>*</FONT>&nbsp;姓名
					</TD>
					<TD class=editTd style='width:40%;'>
						<s:textfield cssClass="noborder" readonly="true"  cssStyle="color:Gray;width:40%;" name="crudObject.name" size="37" title="姓名" maxlength="16"/>
						<FONT id="msg1" color="gray">选择系统账号后，自动关联生成</FONT>
					</TD>
					<TD  nowrap  class=EditHead>
						<FONT color=red>*</FONT>&nbsp;性别
					</TD>
					<TD class="editTd" >
							<s:select  id="employeeInfoSex"  name="crudObject.sex" 
								   list="#@java.util.LinkedHashMap@{'男':'男', '女':'女'}" 
								   onchange="changVle();" 
								   listValue="value" 
								   listKey="key" />
					</TD>
				</tr>
				<tr>
					<TD  nowrap  class=EditHead>
						<FONT color=red id="color_sign3" >*</FONT>&nbsp;人员编码
					</TD>
					<TD class="editTd" >
						<s:textfield readonly="true" cssClass="noborder" cssStyle="color:Gray;width:40%;" name="crudObject.personnelCode" size="37" maxlength="16" />
						<FONT id="msg2" color="gray">选择系统账号后，自动关联生成</FONT>
					</TD>
					<TD  nowrap  class=EditHead>
						 出生日期
					</TD>
					<TD class="editTd" >
					<input type="text"  id='employeeInfoBorn' editable="false" class="easyui-datebox noborder" name="crudObject.birthday" value="${crudObject.birthday }" title="单击选择日期" />	
					
					</TD>
				</TR>
				<TR>
					<TD  nowrap  class=EditHead >
						民族
					</TD>
					<TD class=editTd >
						<select editable="false" name="crudObject.nationCode" id = "nationCode" style="width:165px"  class="easyui-combobox" PanelHeight="auto" >
									<option value="">&nbsp;</option>
									<s:iterator value="basicUtil.nationList">
										<s:if test="${crudObject.nationCode==code}">
										<option selected="selected" value=${code}>${name }</option>
										</s:if>
										<s:else>
										<option value=${code}>${name }</option>
										</s:else>
									</s:iterator>
						</select>
					</TD>
						<TD  nowrap  class=EditHead>
						籍贯
					</TD>
					<TD class=editTd  align="left">
						<%-- <s:textfield cssClass="noborder" cssStyle="width:40%;" name="crudObject.nativePlace" size="60" maxlength="100"></s:textfield> --%>
						<select editable="false" id = "nativePlace" name="crudObject.nativePlace"  >
							<option value="">&nbsp;</option>
							<s:iterator value="basicUtil.nativeplacList">
								<s:if test="${crudObject.nativePlace == code}">
									<option selected="selected" value=${code}>${name }</option>
								</s:if>
								<s:else>
									<option value=${code}>${name}</option>
								</s:else>
							</s:iterator>
						</select>
					</TD>
				</TR>
				<TR>
					<TD   nowrap  class="EditHead">
						身份证号
					</TD>
					<TD class="editTd"  align="left">
						<s:textfield cssClass="noborder" cssStyle="width:40%;" id="identityCard" name="crudObject.identityCard" size="37" maxlength="18" />
					</TD>
					<TD nowrap  class="EditHead">
						政治面貌
					</TD>
					<TD class="editTd" >
						<select editable="false" name="crudObject.polityVisageCode"  class="easyui-combobox" PanelHeight="auto" >
									<option value="">&nbsp;</option>
									<s:iterator value="basicUtil.polityVisageList">
										<s:if test="${crudObject.polityVisageCode==code}">
										<option selected="selected" value=${code}>${name }</option>
										</s:if>
										<s:else>
										<option value=${code}>${name }</option>
										</s:else>
									</s:iterator>
						</select>
					</TD>					
				</TR>
				<tr>
					<td nowrap class=EditHead>排序编号</td>
					<td class="editTd">
						<s:textfield cssClass="noborder" id="orderNo" name="crudObject.orderNo" cssStyle="width:40%;"
							size="37" maxlength="18" />
					</td>
					<td nowrap class=EditHead></td>
					<td class="editTd"></td>
				</tr>
				<tr>
					<td nowrap   colspan="4" align="left" class="EditHead">
						<font style="float: left;">教育经历</font>
					</td>
				</tr>
				<tr>
				<TD nowrap  class=EditHead>
						全日制学历
					</TD>
					<TD class=editTd >
						<select editable="false" id = "diplomaCode" name="crudObject.diplomaCode"  style="width:165px"  class="easyui-combobox" PanelHeight="auto" >
									<option value="">&nbsp;</option>
									<s:iterator value="basicUtil.diplomaList">
										<s:if test="${crudObject.diplomaCode==code}">
											<option selected="selected" value="${code}">${name}</option>
										</s:if>
										<s:else>
											<option value="${code}">${name}</option>
										</s:else>
									</s:iterator>
							</select>
					</TD>
					<TD  nowrap class=EditHead>
						全日制专业
					</TD>
					<TD class=editTd  >
						<select editable="false" name="crudObject.specialityCode"  class="easyui-combobox" PanelHeight="auto" >
									<option value="">&nbsp;</option>
									<s:iterator value="basicUtil.specialtyList">
									<s:if test="${crudObject.specialityCode==code}">
										 <option selected="selected" value="<s:property value="code"/>"><s:property value="name"/></option>
									</s:if>
									<s:else>
										 <option value="<s:property value="code"/>"><s:property value="name"/></option>
									</s:else>	
									</s:iterator>
							</select>
				
					</TD>
					
				</TR>
				<TR>
					<TD  nowrap class=EditHead>
						全日制毕业院校
					</TD>
					<TD class=editTd >
						<s:textfield cssClass="noborder" cssStyle="width:40%;" name="crudObject.graduateAcademy" size="60" maxlength="50"></s:textfield>
					</TD>
					<TD nowrap  class=EditHead >
						最高学位
					</TD>
					<TD class=editTd  align="left">
							<select editable="false" name="crudObject.degreeCode"  class="easyui-combobox" PanelHeight="auto" >
									<option value="">&nbsp;</option>
									<s:iterator value="basicUtil.degreeList">
									<s:if test="${crudObject.degreeCode==code}">
										<option selected="selected" value="<s:property value="code"/>"><s:property value="name"/></option>
									</s:if>
									<s:else>
										<option value="<s:property value="code"/>"><s:property value="name"/></option>
									</s:else>
									</s:iterator>
							</select>
					</TD>
					
				</TR>
				<TR>
					<TD  nowrap class=EditHead>
						最高学位毕业院校
					</TD>
					<TD class=editTd >
						<s:textfield cssClass="noborder" cssStyle="width:40%;" name="crudObject.graduateAcademy_high" size="60" maxlength="50"></s:textfield>
					</TD>
					<TD  nowrap class=EditHead>
						最高学位专业
					</TD>
					<TD class=editTd  >
							<select editable="false" name="crudObject.specialityCode_high"  class="easyui-combobox" PanelHeight="auto" >
									<option value="">&nbsp;</option>
									<s:iterator value="basicUtil.specialtyList">
										<s:if test="${crudObject.specialityCode_high==code}">
											<option selected="selected" value="<s:property value="code"/>"><s:property value="name"/></option>
										</s:if>
										<s:else>
										<option value="<s:property value="code"/>"><s:property value="name"/></option>
										</s:else>
									</s:iterator>
							</select>
					
					</TD>
					
				</TR>
				<tr >
					<td  nowrap colspan="4" align="left" class="EditHead">
						<font style="float: left;">工作经历</font>
					</td>
				</tr>
				<tr>
					<TD  nowrap class=EditHead>
						<FONT id="color_sign4" ></FONT>&nbsp;所属单位
					</TD>
					<TD class=editTd >
					<s:textfield cssClass="noborder" cssStyle="color:Gray;width:40%;" readonly="true" name="crudObject.company"></s:textfield><FONT id="msg3" color="gray">选择系统账号后，自动关联生成</FONT>
					<s:hidden name="crudObject.companyCode"></s:hidden>
					</TD>										
					<TD  nowrap class=EditHead>
						职称级别
					</TD>
					<TD class=editTd >
					
					     <s:buttonText2 id="technicalPost" name="crudObject.technicalPost" 
					         hiddenId="technicalPostCode" hiddenName="crudObject.technicalPostCode"
					         cssClass="noborder"
							 doubleOnclick="queryData('/ais/mng/employee/quertTechnicalPost.action','职称级别',440,410,'technicalPostCode','technicalPost')"
							 doubleSrc="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png"
							 doubleCssStyle="cursor:hand;border:0" readonly="true" />
					</TD>
				</TR>
				
				<tr>
					<TD nowrap  class=EditHead>
						职称名称
					</TD>
					<TD class=editTd>
					<s:textfield cssClass="noborder" cssStyle="color:Gray;width:40%;color:black" maxlength="50" name="crudObject.technicalPost_name"></s:textfield>
					</TD>										
					<TD  nowrap class=EditHead>
						职务级别
					</TD>
					<TD class=editTd >
							
						<s:buttonText2 id="duty" name="crudObject.duty" 
				         hiddenId="dutyCode" hiddenName="crudObject.dutyCode"
				         cssClass="noborder"
						 doubleOnclick="queryData('/ais/mng/employee/queryDuty.action','职务级别',440,410,'dutyCode','duty')"
						 doubleSrc="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png"
						 doubleCssStyle="cursor:hand;border:0" readonly="true" />
					</TD>
				</TR>
				
				<TR>
					<TD nowrap  class=EditHead>
						职务名称
					</TD>
					<TD class=editTd >
						<s:textfield cssClass="noborder" cssStyle="color:Gray;width:40%;color:black" maxlength="50" name="crudObject.duty_name"></s:textfield>
					</TD>
					<TD  nowrap class=EditHead> 
						职业资格证书
					</TD>
					<TD class=editTd >
					    <s:buttonText2 id="competence" name="crudObject.competence" 
				         hiddenId="competenceCode" hiddenName="crudObject.competenceCode"
				         cssClass="noborder"
						 doubleOnclick="queryData('/ais/mng/employee/queryCompetence.action','职业资格证书',440,410,'competenceCode','competence')"
						 doubleSrc="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png"
						 doubleCssStyle="cursor:hand;border:0" readonly="true" />
					</TD>
				</TR>

                <TR>
                    <TD nowrap  class=EditHead >
                 		       从事审计日期
                    </TD>
                    <TD class=editTd  align="left">
                          <input type="text" style="width:165px"  editable="false" name="crudObject.beginWorkDate"  value='<s:property value="crudObject.beginWorkDate"/>' Class="easyui-datebox noborder"  title="单击选择日期"/>
                    </TD>
					<TD  nowrap class=EditHead>
						参加工作时间
					</TD>
					<TD class=editTd >
					  <input type="text" name="crudObject.graduateDate" id = "graduateDate" editable="false" value='<s:property value="crudObject.graduateDate"/>' Class="easyui-datebox noborder"   title="单击选择日期"/>
					</TD>
                </TR>
                <tr>
                    <TD nowrap  class=EditHead >
                    		   审计经历</br>
                    	<span style="color: DarkGray;">(限500字)</span>
                    </TD>
                    <TD colspan="4" class=editTd  align="left">
                        <s:textarea cssClass="noborder" id="workingAbroad" name="crudObject.workingAbroad" cssStyle="width:100%;overflow-y:visible;" title="审计经历" />
                        <input type="hidden" id="crudObject.workingAbroad.maxlength" value="500">
                    </TD>
                </tr>
				<TR>
					<TD  nowrap class=EditHead>
						人员类型
					</TD>
					<TD class="editTd" >
							<select style="width:165px"  editable="false" name="crudObject.typeCode"  class="easyui-combobox" PanelHeight="auto" >
									<option value="">&nbsp;</option>
									<s:iterator value="basicUtil.typeList">
									<s:if test="${crudObject.typeCode==code}">
										<option selected="selected" value=${code}>${name }</option>
									</s:if>
									<s:else>
										<option value=${code}>${name }</option>
									</s:else>
									</s:iterator>
							</select>
					</TD>
					<TD nowrap  class=EditHead>
						手机
					</TD>
					<TD class=editTd width="35%" align="left">
						<s:textfield cssClass="noborder" cssStyle="width:40%;" id="mobileTelephone" name="crudObject.mobileTelephone" size="37" maxlength="20" />
					</TD>
				</TR>
				<TR>
					<TD  nowrap class=EditHead>
						办公电话
					</TD>
					<TD nowrap class=editTd width="36%" align="left">
						<s:textfield cssClass="noborder"  cssStyle="width:42%;" id="officePhone" name="crudObject.officePhone" size="37" maxlength="25" />
						<span style="color:gray;">(区号+电话号码) 如：010-88888888-888</span>
					</TD>
					<TD nowrap  class=EditHead >
						电子邮箱
					</TD>
					<TD class=editTd  align="left">
						<s:textfield cssClass="noborder"  cssStyle="width:40%;" id="email" name="crudObject.email" size="37" maxlength="155" />
					</TD>
				</tr>
				<TR>
					<TD nowrap  class=EditHead >
						人员特长
					</TD>
					<TD class=editTd  align="left">
					<select multiple="multiple" id="strongPointCode1" editable="false" name="crudObject.strongPointCode1" style="width:35%;" >
						<c:forEach items="${basicUtil.specialityList}" var="s">
							<option value='${s.code }'>${s.name }</option>
						</c:forEach>
				  	</select>
				  	<input type="hidden" id="strongPointCode" name="crudObject.strongPointCode" value="${crudObject.strongPointCode}"/>
					</TD>
					<TD nowrap  class=EditHead >
						专业序列等级
					</TD>
					<TD class=editTd  align="left">
						<select class="easyui-combobox" name="crudObject.psLevel" id="psLevel" editable="false">
								<option value="">&nbsp;</option>
								<s:iterator value="basicUtil.pSLList">
									<s:if test="${crudObject.psLevel == code}">
										<option selected="selected" value="${code}">${name}</option>
									</s:if>
									<s:else>
										<option value="${code}">${name}</option>
									</s:else>
								</s:iterator>
						</select>
						<s:hidden name="crudObject.score"></s:hidden>
					</TD>
				</tr>
				<tr>
					<td class="EditHead">
						入司时间
					</td>
					<td class="editTd" colspan="3">
						<input type="text" id = "entryTime" editable="false" class="easyui-datebox noborder" title="单击选择日期" style="width:150px;" name="crudObject.entryTime" value="${crudObject.entryTime}">
					</td>
				</tr>
				<tr>
					<TD  nowrap class="EditHead" nowrap>
							奖励信息</br>
                    	<span style="color: DarkGray;">(限500字)</span>
					</TD>
					<TD class=editTd colspan="3">
						<s:textarea cssClass="noborder" id="encourageMessage" name="crudObject.encouragemessage" cssStyle="width:100%;overflow-y:visible;"  title="奖励信息" />
					    <input type="hidden" id="crudObject.encouragemessage.maxlength" value="500">
					</TD>
				</TR>
				<tr>
					<td class="editTd" colspan="10" >
						<div id="employeeInfo_file"></div>
						<s:hidden id="employeeInfo.uuid" name="employeeInfo.uuid" />
					</td>
				</tr>
				<input type="hidden" name="listStatus" value="edit"/>
				<s:hidden name="crudObject.id"/>
				<s:hidden name="crudObject.creator" value="${user.floginname}"/>
			</TABLE>
		</s:form>
		<div id="subwindow" class="easyui-window" title="" style="width:500px;height:500px;padding:5px;" closed="true">
			<div class="easyui-layout" fit="true">
				<div region="center" border="false" style="padding:10px;background:#fff;border:1px solid #ccc;">
					<iframe id="item_ifr" name="item_ifr" src="" frameborder="0" width="100%" height="100%" scrolling="auto" title=""></iframe>
				</div>
				<div region="south" border="false" style="text-align:right;padding:5px 0;">
				    <div style="display: inline;" align="right">
				        <input type="hidden" id="para1" value="">
				        <input type="hidden" id="para2" value="">
						<a class="easyui-linkbutton" iconCls="icon-ok" href="javascript:void(0)" onclick="saveF()">确定</a>
						<a class="easyui-linkbutton" iconCls="icon-empty" href="javascript:void(0)" onclick="cleanF()">清空</a>
						<a class="easyui-linkbutton" iconCls="icon-cancel" href="javascript:void(0)" onclick="closeWin()">关闭</a>
				    </div>
				</div>
			</div>
		</div>
		<script type="text/javascript">
			function queryData(url,title,width,height,para1,para2){
				if($('#item_ifr').attr('title') == title){
					if($('#item_ifr').attr('src') == ''){
						$('#item_ifr').attr('src',url);
					}
				}else{
					$('#item_ifr').attr('title',title);
					$('#item_ifr').attr('src',url);
				}
				$('#para1').attr('value',para1);
				$('#para2').attr('value',para2);
				$('#subwindow').window({
					title: title,
					width: width,
					height:height,
					modal: true,
					shadow: true,
					closed: false,
					collapsible:false,
					maximizable:false,
					minimizable:false
				});
			}
			function saveF(){
				var ayy = $('#item_ifr')[0].contentWindow.saveF();
				var p1 = $('#para1').attr('value');
				var p2 = $('#para2').attr('value');
				document.all(p1).value=ayy[0];
	    		document.all(p2).value=ayy[1];
	    		closeWin();
			}
			function cleanF(){
				var p1 = $('#para1').attr('value');
				var p2 = $('#para2').attr('value');
				document.all(p1).value='';
	    		document.all(p2).value='';
	    		closeWin();
			}
			function closeWin(){
				$('#subwindow').window('close');
			}
		</script>
	</body>
</html>
