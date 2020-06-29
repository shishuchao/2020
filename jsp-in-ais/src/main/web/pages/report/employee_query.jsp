<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=utf-8" import="java.util.*" %>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
<head>
	<title></title>
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
	<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
	<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css">
	<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/csswin/subModal.js"></script>
	<script language="javascript">
		function CheckSubmit(){
			var years = document.getElementsByName('year')[0].value;
			var tjdwCode = document.getElementsByName('tjdwCode')[0].value;
			var reportTypes = document.getElementsByName('reportType')[0].value;
			if(document.getElementsByName('tjdw')[0].value==""){
				alert("请选择审计单位");
				return false;
			}if(document.getElementsByName('year')[0].value==""){
				alert("请选择年度");
				return false;
			}
			document.forms[0].action = "${contextPath}/report/jasper!employee_work.action?year="+years+"&reportType="+reportTypes+"&tjdwCode="+tjdwCode;	
//				if(document.all.ismax.checked){
//					showreport.location.href = "${contextPath}/blank.jsp";
//					document.forms[0].target = "_blank";
//					document.forms[0].submit();
//       			}else{
					document.forms[0].target = "showreport";
					document.forms[0].submit();
//				}
		}
		 var num=Math.random();
	     var rnm=Math.round(num*9000000000+1000000000);//随机参数清除模态窗口缓存
	     $(document).ready(function(){
	    	 CheckSubmit();
	     });
	</script>
</head>
<body class="easyui-layout">
	<div data-options="region:'north',border:false" style="heigth:100%;overflow:hidden;">
		<!-- <table cellpadding=0 cellspacing=1 border=0  class="ListTable">
			<tr >
				<td  align="left" class="EditHead" style="text-align: center">
					<s:property escape="false" value="@ais.framework.util.NavigationUtil@getNavigation('/ais/report/jasper!enterEmployee_work.action')"/>
				</td>
			</tr>
		</table> -->
		<table id="tab1" cellpadding=0 cellspacing=1 border=0  class="ListTable">
			<s:form name="form">
				<tr >
		            <td class="EditHead" nowrap>
		            	<font color=red>*</font>&nbsp;统计单位
		            </td>
					<td  align="left" class="editTd">
						<s:buttonText2 cssClass="noborder" 
								name="tjdw" hiddenName="tjdwCode" 
								doubleOnclick="showSysTree(this,
									{ url:'${contextPath}/systemnew/orgListByAsyn.action',
									  title:'请选择审计单位',
									  param:{
	                                    'p_item':1,
	                                    'orgtype':1
	                                  },
	                                  checkbox:true
									})"
								doubleSrc="${contextPath}/resources/images/s_search.gif"
								doubleCssStyle="cursor:hand;border:0" readonly="true"
								doubleDisabled="false" maxlength="100" />
					
						</td>
					<td class="EditHead">
		            	<font color=red>*</font>&nbsp;年度
		            </td>
		            <% 	
						Calendar cal = Calendar.getInstance();
					    int year = cal.get(Calendar.YEAR) ;
					%>
					<td class="editTd">
						<select name="year" class="easyui-combobox" >
							<option value="">　</option>
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
					</td>
				</tr>
				<tr>
					<td class="EditHead">输出格式</td>
					<td class="editTd">
						<select class="easyui-combobox" id="qwe" name="reportType" editable="false" panelHeight="auto">
							<option value="">　</option>
							<option value="htm">HTML</option>
							<option value="xsl">EXCEL</option>
						</select>
					</td>
					<td class="editTd" colspan="4"></td>
				</tr>
				<tr>
					<td colspan="8" align="right" class="editTd">
						<div align="right">
							<a class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="return CheckSubmit();">查询</a>
						</div>
					</td>
				</tr>
			</s:form>
		</table>
	</div>
	<div data-options="region:'center',border:false" style="height:100%;width:100%;overflow:hidden;">
		<iframe name="showreport" src="<%=request.getContextPath()%>/blank.jsp"
		        frameborder="0" width="100%" height="100%"></iframe>
	</div>
</body>
</html>
