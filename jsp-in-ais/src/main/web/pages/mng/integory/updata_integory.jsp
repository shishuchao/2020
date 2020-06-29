<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>

<html>
	<head>
		<s:text id="title" name="'修改中介机构库'"></s:text>
		<title><s:property value="#title" />
		</title>
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet" type="text/css">
		<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css">
		<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/csswin/subModal.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
		<SCRIPT type="text/javascript" src="${pageContext.request.contextPath}/scripts/calendar.js"></SCRIPT>
		<!-- 校验字符长度 -->
		<script type="text/javascript" src="${contextPath}/scripts/ufaudTextLengthValidator.js"></script>
		
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
		
	 <link rel="stylesheet" href="${contextPath}/pages/introcontrol/util/themes/default/easyui.css" type="text/css"></link>
	 <link rel="stylesheet" href="${contextPath}/pages/introcontrol/util/themes/icon.css" type="text/css"></link>
     <script type="text/javascript" src="${contextPath}/pages/introcontrol/util/jquery-1.7.1.min.js"></script>
	 <script type="text/javascript" src="${contextPath}/pages/introcontrol/util/jquery.easyui.min.js"></script>
	 <script type="text/javascript" src="${contextPath}/pages/introcontrol/util/easyui-lang-zh_CN.js"></script>   
     <script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
			
		<script type="text/javascript">
			function tijiao(){
				var unitname = document.getElementById('unitname').value;
				var auditunitname = document.getElementsByName('integoryinfoW.auditunitname')[0].value;
				var auditunitid = document.getElementsByName('integoryinfoW.auditunitid')[0].value;
				
				if(auditunitname == ''){
					alert('所属审计单位不能为空,请返回选择！');
					return;
				}				
				if(unitname == ''){
					alert("中介机构名称不能为空,请返回检查！");
					return;
				}
				//校验联系电话
				if(!isPostalCode("integoryinfoW.post"))
					return;
				//邮政编码
				if(!telephoneValidate("integoryinfoW.phone"))
					return;
				
				if(validateUnitname(unitname,auditunitid)){
					document.forms[0].submit();
					alert("修改成功！");
					
				}
			}
		/*
		 * 校验是否该审计单位存在相同中介机构名称
		 */
		function validateUnitname(unitname,auditunitid){
			var flag = false;
			if(unitname!='${integoryinfoW.unitname}'){
				DWREngine.setAsync(false);
				DWREngine.setAsync(false);DWRActionUtil.execute(
				{ namespace:'/resmngt/integory', action:'validateUnitname', executeResult:'false' }, 
				{ 'auditunitid':auditunitid,'unitname':unitname},
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
		</script>
	</head>
<body >
		<center>
			<table  class="ListTable">
				<tr class="listtablehead">
					<td colspan="4" class="edithead" style="text-align: left;width: 100%;">
						<div style="display: inline;width:80%;">
							中介机构信息修改
						</div>
					</td>
				</tr>
			</table>
			<s:form action="update_Integoryinfo" namespace="/resmngt/integory">
				<s:hidden name="integoryinfoW.interoryId" value="${integoryinfoW.interoryId }"></s:hidden>
				<s:hidden name="integoryinfoW.islogout" value="N"></s:hidden>

				<table id="tab1"  class=ListTable align="center">
					<tr>
						<td width="23%" align="right" class="ListTableTr11">
							机构名称<FONT color=red>*</FONT>
						</td>
						<td class="ListTableTr22">
							<s:textfield name="integoryinfoW.unitname" id="unitname"
								value="${integoryinfoW.unitname }" maxlength="50"></s:textfield>
						</td>
						<td width="23%" align="right" class="ListTableTr11">
							所属审计单位<FONT color=red>*</FONT>
						</td>
						<td class="ListTableTr22" >
							<%--<s:buttonText name="integoryinfoW.auditunitname" 
								hiddenName="integoryinfoW.auditunitid" 
								doubleOnclick="showPopWin('/pages/system/search/searchdata.jsp?url=/systemnew/orgList.action&paraname=integoryinfoW.auditunitname&paraid=integoryinfoW.auditunitid&p_item=1&orgtype=1',600,350,'所属审计单位')"
								doubleSrc="/resources/images/s_search.gif"
								doubleCssStyle="cursor:hand;border:0" readonly="true"
								doubleDisabled="false" value="${integoryinfoW.auditunitname }"/>--%>
							<s:buttonText2 name="integoryinfoW.auditunitname" 
								hiddenName="integoryinfoW.auditunitid" 
								cssStyle="width:230px"
								doubleOnclick="showSysTree(this,
								{ url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action',
								  title:'审计单位',
                                  param:{
                                    'p_item':1,
                                    'orgtype':1
                                  }
								})"
								doubleSrc="${pageContext.request.contextPath}/resources/images/s_search.gif"
								doubleCssStyle="cursor:hand;border:0" readonly="true"
								doubleDisabled="false" value="${integoryinfoW.auditunitname }" maxlength="100"/>
						</td>
					</tr>
					<tr>
						<td width="23%" align="right" class="ListTableTr11">
							公司地址
						</td>
						<td class="ListTableTr22">
							<s:textfield name="integoryinfoW.address" value="${integoryinfoW.address }"  maxlength="50"></s:textfield>
						</td>
						<td width="23%" align="right" class="ListTableTr11">
							邮政编码
						</td>
						<td class="ListTableTr22">
							<s:textfield id="integoryinfoW.post" name="integoryinfoW.post" value="${integoryinfoW.post }" 
								 maxlength="6"></s:textfield>
						</td>
					</tr>
					<tr>
						
						<td width="23%" align="right" class="ListTableTr11">
							联系电话
						</td>
						<td class="ListTableTr22">
							<s:textfield id="integoryinfoW.phone" name="integoryinfoW.phone" value="${integoryinfoW.phone }" 
								 maxlength="20"></s:textfield>
							型如：(010-88888888-888)
						</td>
						<td width="23%" align="right" class="ListTableTr11">
							联系人
						</td>
						<td class="ListTableTr22">
							<s:textfield name="integoryinfoW.linkman" value="${integoryinfoW.linkman }"  maxlength="50"></s:textfield>
						</td>
					</tr>
					<tr>
						<td width="23%" align="right" class="ListTableTr11">
							资质等级
						</td>
						<td class="ListTableTr22">
							<s:select name="integoryinfoW.zzdjCode" list="basicUtil.prjZzdjList" required="true" listKey="code" listValue="name"></s:select>
						</td>
						<td width="23%" align="right" class="ListTableTr11">
							资质有效期限
						</td>
						<td class="ListTableTr22">
							<s:textfield id="zzyxqx" name="integoryinfoW.zzyxqx"
								readonly="true"  maxlength="20"
								title="单击选择日期"
								disabled="!(varMap['pro_starttimeWrite']==null?true:varMap['pro_starttimeWrite'])"
								display="${varMap['pro_starttimeRead']}" onclick="calendar()"
								theme="ufaud_simple" templateDir="/strutsTemplate"  value="${integoryinfoW.zzyxqx }"></s:textfield>
						</td>
					</tr>
				</table>
				<div align="right">
					<input type="button"  value="保存并返回" onclick="tijiao();">
					&nbsp;&nbsp;&nbsp;&nbsp;
					<!-- <input type="reset" value="重置" />  -->
					&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="button" onclick="window.location='searchIntegory.action'" value="返回">
				</div>
			</s:form>
		</center>
	</body>
</html>

