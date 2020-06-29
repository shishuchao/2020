<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib prefix="authz" uri="http://acegisecurity.org/authz" %>
<HTML>
<HEAD>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
	<TITLE> user </TITLE>
	<META HTTP-EQUIV="Pragma" CONTENT="no-cache"> 
	<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
	<META HTTP-EQUIV="Expires" CONTENT="0"> 
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/csswin/style.css" />
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/csswin/subModal.css" />
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
	<link href="<%=request.getContextPath()%>/styles/main/ais.css" rel="stylesheet" type="text/css">
	<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/resources/js/normal.js"></script>
	<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/resources/js/common.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/csswin/common.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/csswin/subModal.js"></script>
	<script language="Javascript">
	
		$(function(){
			showWin('winPage','弹框公用页面');
		});
		function RightGo(url){
			parent.mainFrame.location.href=url;
		}
		function getCheckValue(){var checknode=document.getElementsByName("checkvalue");
			var i=checknode.length;
			var vs="";
			if(i=="0" || i==""){
				return vs;
			} else{
				for(var j=0;j<i;j++){
					if(checknode[j].checked){
						if(vs==""){
							vs=checknode[j].value;
						} else{
							vs=vs+";"+checknode[j].value;
						}
					}
				}
			}
			return vs;
		}
		function doPermission(loginname){
			var url = "../system/authAuthorityAction!authoritySet.action?num="+rnm+"&p_floginname="+loginname;
			var num=Math.random();
			var rnm=Math.round(num*9000000000+1000000000);//随机参数清除模态窗口缓存
			showWinIf('winPage',url,'权限设置',900,450);
			//showPopWin("../system/authAuthorityAction!authoritySet.action?num="+rnm+"&p_floginname="+loginname,650,400,'权限设置');
		}
	
		function showOwnAllRoles(loginname){
			showPopWin("../system/authAuthorityAction!authAllRoleSet.action?p_floginname="+loginname,650,400,'用户角色');
		}
		function selDept(){
			var url='<%=request.getContextPath()%>/pages/system/search/searchdata.jsp?url='+window.parent.document.getElementsByName('left')[0].src+'&paraname=p_deptname&paraid=p_deptid&p_item=2';
			showPopWin(url,300,250,'组织机构选择');
		}
		function setfmid(obj,otherName){
			var str;
			str = obj.options[obj.selectedIndex].text;
			document.getElementsByName(otherName)[0].value=str;
		}
	</script>
</HEAD>
<BODY topmargin=0 leftmargin=0> 
	<div id="ais_divselect"></div>
	<div align="center">
	<display:table name="userlist" id="row" class="its" pagesize="10" requestURI="uSystemAction!getUserList.action?p_deptid=${p_deptid}&p_deptname='${p_deptname}'&p_issel=${p_issel}&p_item=${p_item}&noMenu4User=${noMenu4User}" excludedParams="*">
			<%-- 
			<display:column title="选择"  style="width:30" headerClass="center" class="center">
			<s:if test="${not empty (requestScope.p_deptname)}">
			<input type="checkbox" id="node${row_rowNum}" name="checkvalue" isnode="true" loginname="${row.floginname}" value="${row.fuserid},${row.floginname},${row.fname},${requestScope.p_deptname}"/>
			</s:if><s:else>
			<input type="checkbox" id="node${row_rowNum}" name="checkvalue" isnode="true" loginname="${row.floginname}" value="${row.fuserid},${row.floginname},${row.fname},${row.fdepname}"/>
			</s:else>
    		</display:column> 
			--%>
			<display:column  title ="系统账号" property ="floginname" sortable="true" headerClass="center" class="center"></display:column>
			<display:column  title ="真实姓名" property ="fname" sortable="true" headerClass="center" class="center"></display:column>  
			<display:column  title ="角色类型"  sortable="true"  headerClass="center" class="center">
				<s:if test="${row.flevel=='general'}">
					业务角色
				</s:if>
				<s:else>
					管理角色
				</s:else>
			</display:column> 
			<display:column  title ="所属单位" property ="fdepname" sortable="true"  headerClass="center" class="center"></display:column> 
			<display:column  title ="操作"   headerClass="center" class="center">
				<a href="javascript:;" onclick="showOwnAllRoles('${row.floginname}')">用户角色</a>
				<s:if test="${row.floginname!=user.floginname}">
				<a href="javascript:;" onclick="doPermission('${row.floginname}')">用户授权</a>
				</s:if>
			</display:column> 
			</display:table>
	</div>
	<input type="hidden" name="rowcount" value="${row_rowNum}">
	<table cellpadding="0" cellspacing="0"></table>
	
	<div id="winPage"></div>
</BODY>
</HTML>