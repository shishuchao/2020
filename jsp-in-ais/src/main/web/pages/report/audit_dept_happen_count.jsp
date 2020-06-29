<%@ page language="java" pageEncoding="UTF-8"
	contentType="text/html; charset=utf-8" import="java.util.*"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
	<head>
		<meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1" />
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<title></title>
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
		<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script> 
		<script type="text/javascript" src="<%=request.getContextPath()%>/scripts/calendar.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/scripts/check.js"></script>
		<link rel="stylesheet" type="text/css" href="${contextPath}/resources/csswin/subModal.css" />
		<link rel="stylesheet" type="text/css" href="${contextPath}/styles/main/aisCommon.css" />
		<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/csswin/subModal.js"></script>
		<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />


		
		<script language="javascript">
		
			function CheckSubmit(){
<%--				if(!frmCheck(document.forms[0], "tab1"))--%>
<%--					return false;--%>
				if(document.getElementsByName('auditDeptName')[0].value==""){
					showMessage1("请选择审计单位!");
					return false;
				}if(document.getElementsByName('year')[0].value==""){
					showMessage1("请选择统计年度!");
					return false;
				}if(document.getElementsByName('season')[0].value==""){
					showMessage1("请选择统计期间!");
					return false;
				}
				
				document.forms[0].action = "${contextPath}/report/jasper!auditDeptHappenCount.action";	
<%--				if(document.all.ismax.checked){--%>
<%--					showreport.location.href = "${contextPath}/blank.jsp";--%>
<%--					document.forms[0].target = "_blank";--%>
<%--					document.forms[0].submit();--%>
<%--       			}else{--%>
					document.forms[0].target = "showreport";
					document.forms[0].submit();
<%--				}--%>
			}
			 var num=Math.random();
		     var rnm=Math.round(num*9000000000+1000000000);//随机参数清除模态窗口缓存
		     /*
		     $(document).ready(function(){
		    	 CheckSubmit();
		     });
		     */
		</script>
	</head>
	<body style="overflow:hidden">
<%--		<table class="ListTable">--%>
<%--			<tr class="listtablehead">--%>
<%--				<td align="left" class="edithead">--%>
<%--					<s:property escape="false"--%>
<%--						value="@ais.framework.util.NavigationUtil@getNavigation('/ais/report/jasper!enterAuditDeptHappenCount.action')" />--%>
<%--				</td>--%>
<%--			</tr>--%>
<%--		</table>--%>
		
			<s:form name="form">
				<table id="tab1" class="ListTable">
				<tr >
					<td align="left" class="EditHead">
						<font color=red>*</font>&nbsp;审计单位
					</td>
					<td align="left" class="editTd">
						
						<s:buttonText2 cssClass="noborder"
								name="auditDeptName" cssStyle="width:80%;"
								hiddenName="auditDeptCode" 
								doubleOnclick="showSysTree(this,
									{ url:'${contextPath}/systemnew/orgListByAsyn.action',
									  title:'请选择审计单位',
									  param:{
	                                    'p_item':1,
	                                    'orgtype':1
	                                  },
	                                  checkbox:true,
									})"
								doubleSrc="${contextPath}/resources/images/s_search.gif"
								doubleCssStyle="cursor:hand;border:0" readonly="true"
								doubleDisabled="false" maxlength="100" />
					</td>
					<td align="left" class="EditHead">
		            	<font color=red>*</font>&nbsp;统计年度
		            </td>
		            	<%
		            		Calendar cal = Calendar.getInstance() ;
		            		int year = cal.get(Calendar.YEAR) ;
		            	%>
					<td align="left" class="editTd" >
						<select name="year" class="easyui-combobox"  style="width:160px;">
							<option value="<%=year-5 %>"><%=year-5 %></option>
							<option value="<%=year-4 %>"><%=year-4 %></option>
							<option value="<%=year-3 %>"><%=year-3 %></option>
							<option value="<%=year-2 %>"><%=year-2 %></option>
							<option value="<%=year-1 %>"><%=year-1 %></option>
							<option selected value="<%=year %>"><%=year %></option>
							<option value="<%=year+1 %>"><%=year+1 %></option>
							<option value="<%=year+2 %>"><%=year+2 %></option>
							<option value="<%=year+3 %>"><%=year+3 %></option>
							<option value="<%=year+4 %>"><%=year+4 %></option>
							<option value="<%=year+5 %>"><%=year+5 %></option>
						</select>
<%--						<s:select cssClass="easyui-combobox" cssStyle="width:160px;" name="season"--%>
<%--							list="#@java.util.LinkedHashMap@{'':'','1':'第一季度','2':'第二季度','3':'第三季度','4':'第四季度','6':'前二季度','7':'前三季度','8':'全年'}"--%>
<%--							required="true"></s:select>--%>
					</td>
<%--					<td class="ListTableTr11">--%>
<%--						新窗口显示--%>
<%--					</td>--%>
<%--					<td class="ListTableTr22">--%>
<%--						<input type="checkbox" name="ismax">--%>
<%--					</td>--%>
				</tr>
				<tr >
		            
					 <td align="left" class="EditHead">
		            	<font color=red>*</font>&nbsp;统计期间
		            </td>
					<td align="left" class="editTd" >
						<s:select cssClass="easyui-combobox" cssStyle="width:160px;" name="season"
							list="#@java.util.LinkedHashMap@{'':'','1':'第一季度','2':'第二季度','3':'第三季度','4':'第四季度','6':'前二季度','7':'前三季度','8':'全年'}"
							required="true"></s:select>
						<!--<s:select cssStyle="width:160px;" name="season"
							list="#@java.util.LinkedHashMap@{'':'','1':'第一季度','2':'第二季度','3':'第三季度','4':'第四季度','6':'前二季度','7':'前三季度','8':'全年'}"
							required="true"></s:select>-->
					</td>
					<td align="left" class="EditHead">
						输出格式
					</td>
					<td align="left" class="editTd">
						<s:select cssClass="easyui-combobox" name="reportType" cssStyle="width:160px;"
							list="#@java.util.LinkedHashMap@{'htm':'HTML','xls':'EXCEL'}"
							required="true"></s:select>
					</td>
				</tr>
				<tr>
					<td align="right" colspan="4" align="left" class="editTd">
						<div align="right">
							<a class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="CheckSubmit()">明细查询</a>
						</div>

					</td>
				</tr>
				</table>
			</s:form>
		
		<table class="its" width="100%">
			<tr>
				<td>
					<iframe allowtransparency="true" style="z-Index: 1"
						name="showreport" src="<%=request.getContextPath()%>/blank.jsp"
						frameborder="0" scrolling="auto" width="100%" height="400"></iframe>
				</td>
			</tr>
		</table>
	</body>
</html>
