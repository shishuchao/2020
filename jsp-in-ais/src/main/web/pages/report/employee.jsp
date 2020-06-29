<%@ page language="java" pageEncoding="UTF-8"
	contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
	<head>
		<title></title>
		<link href="<%=request.getContextPath()%>/styles/main/ais.css" rel="stylesheet" type="text/css">
		<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css">
		<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/csswin/subModal.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/scripts/calendar.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/scripts/check.js"></script>
		
	 <link rel="stylesheet" href="<%=request.getContextPath()%>/pages/introcontrol/util/themes/default/easyui.css" type="text/css"></link>
	 <link rel="stylesheet" href="<%=request.getContextPath()%>/pages/introcontrol/util/themes/icon.css" type="text/css"></link>
     <script type="text/javascript" src="<%=request.getContextPath()%>/pages/introcontrol/util/jquery-1.7.1.min.js"></script>
	 <script type="text/javascript" src="<%=request.getContextPath()%>/pages/introcontrol/util/jquery.easyui.min.js"></script>
	 <script type="text/javascript" src="<%=request.getContextPath()%>/pages/introcontrol/util/easyui-lang-zh_CN.js"></script>   
     <script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
		<script language="javascript">
		
			function CheckSubmit(){
				if(!frmCheck(document.forms[0], "tab1"))
					return false;
				document.forms[0].action = "${contextPath}/report/jasper!employee.action";	
				if(document.all.ismax.checked){
					showreport.location.href = "${contextPath}/blank.jsp";
					document.forms[0].target = "_blank";
					document.forms[0].submit();
       			}else{
					document.forms[0].target = "showreport";
					document.forms[0].submit();
				}
			}
			 var num=Math.random();
		     var rnm=Math.round(num*9000000000+1000000000);//随机参数清除模态窗口缓存
		     $(document).ready(function(){
		    	 CheckSubmit();
		     });
		</script>
	</head>
	<body>
		<table cellpadding=0 cellspacing=1 border=0 bgcolor="#409cce" class="ListTable">
			<tr class="listtablehead">
				<td  align="left" class="edithead">
					<s:property escape="false" value="@ais.framework.util.NavigationUtil@getNavigation('/ais/report/jasper!enterEmp.action')"/>
				</td>
			</tr>
		</table>
		<table id="tab1"  class="ListTable">
			<s:form name="form">

				<tr class="listtablehead">
		            <td class="ListTableTr11">
		            	统计单位<font color=red>*</font>
		            </td>
					<td class="ListTableTr22">
						<s:buttonText2 
								name="tjdw" hiddenName="tjdwCode" 
								cssStyle="width:400px" 
								doubleOnclick="showSysTree(this,
								{ url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action',
								  title:'统计单位',
                                  checkbox:true
								})"
								doubleSrc="${pageContext.request.contextPath}/resources/images/s_search.gif"
								doubleCssStyle="cursor:hand;border:0" readonly="true" 
								doubleDisabled="false"
								maxlength="100"/>
					</td>
					<td class="ListTableTr11">
						输出格式：
					</td>
					<td class="ListTableTr22">
						<s:select name="reportType" list="#@java.util.LinkedHashMap@{'htm':'HTML','xls':'EXCEL'}" required="true"></s:select>
					</td>
					<td class="ListTableTr11">
						新窗口显示
					</td>
					<td class="ListTableTr22" style='width:10%;'>
						<input type="checkbox" name="ismax">
					</td>
				</tr>
				<tr class="listtablehead" align="right">
					<td colspan="6" align="right" class="ListTableTr22">
						<div align="right">
							<s:button  value="明细查询" onclick="return CheckSubmit();"></s:button>													
						</div>
						
					</td>
				</tr>
			</s:form>
		</table>
		<table class="its">
			<tr>
				<td>
					<iframe allowtransparency="true" style="z-Index: 1" name="showreport" src="<%=request.getContextPath()%>/blank.jsp" frameborder="0" scrolling="auto" width="100%" height="400"></iframe>
				</td>
			</tr>
		</table>
	</body>
</html>
