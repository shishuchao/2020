<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %> 
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<html>
<head>
		<title>风险管理报告</title>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<link href="<%=request.getContextPath()%>/styles/main/ais.css" rel="stylesheet" type="text/css">
		<style type="text/css"> 
			#container{
				width:100%;height: 100%;
			}
			#content2{
				width: 1.5%;text-align: left;float: left;height: 100%;
			}
			#content{
				width: 18%;text-align: left;float: left;height: 100%;
			}
			#sidebar{
				width: 80%;text-align: left;float: right;height: 100%;
			}
		</style>
		<script type="text/javascript"	src="${contextPath}/scripts/treepanel/common.js"></script>
		<script type="text/javascript"	src="${contextPath}/scripts/treepanel/TreePanel.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/checkboxsoperation.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/validate.js"></script>
		<script type='text/javascript' src='${pageContext.request.contextPath}/scripts/turnPage.js'></script>
		<script type="text/javascript">
			function mydelSubmit(){
				if(mydelCheck()){
					if(confirm("确认删除吗？")){
						riskForm.submit();
					}else{
						return false;
					}
				}else
				{
					return false;	
				}
			}
			function myeditSubmit(){
				var riskIdTemp = myeditCheck(); 
				if(!riskIdTemp){
					return false; 
				}
				url="${contextPath}/resmngt/risk/edit.action?riskTypeId="+riskTypeId.value+"&riskId="+riskIdTemp;
				window.location=url;
			}
			function myaddSubmit(){
				url="${contextPath}/resmngt/risk/edit.action?riskTypeId="+riskTypeId.value;
				window.location=url;
			}
			function mySearchSubmit(){
				if(document.getElementById("helper.risk.year").value!=''){
							if(!isPlusInteger(document.getElementById("helper.risk.year").value)){
							alert("年度 只能输入正整数,请重新输入");
							document.getElementById("helper.risk.year").focus();
							return false;
							}
						}
				riskSearchForm.submit();
			}
			function mydelCheck(){
				s=document.getElementsByName("riskIds");
				j=0;
				for(i=0;i<s.length;i++){
					if(s[i].checked){
						j=j+1;
					}
				}
				if(j<1){
					alert('请先选中记录再进行删除操作！');
					return  false;
				}
				return true;
			}
			function myeditCheck(){
				s=document.getElementsByName("riskIds");
				j=0;
				var tempid ='' ;
				for(i=0;i<s.length;i++){
					if(s[i].checked){
						j=j+1;
						tempid = s[i].value ;
					}
				}
				if(j<1){
					alert('请先选择一条记录再进行修改！');
					return false;
				}
				if(j>1){
					alert('修改操作只能选择一条记录进行修改！');
					return false;
				}
				return tempid;
			}
			function RightGo(node){
				document.location="${contextPath}/resmngt/risk/index.action?helper.risk.riskType="+node.id;
			}
			function myReset(){
				document.getElementsByName("helper.risk.title")[0].value = "";
				document.getElementsByName("helper.risk.year")[0].value = "";
				document.getElementsByName("helper.risk.uploaderName")[0].value = "";
				document.getElementsByName("helper.risk.uploadDeptName")[0].value = "";
				document.getElementsByName("helper.risk.uploadDept")[0].value = "";
				window.location ="${pageContext.request.contextPath}/resmngt/risk/index.action" 
			}
			/*
			*  打开或关闭查询面板
			*/
			function triggerSearchTable(){
				var isDisplay = document.getElementById('searchTable').style.display;
				if(isDisplay==''){
					document.getElementById('searchTable').style.display='none';
				}else{
					document.getElementById('searchTable').style.display='';
				}
			}
			<s:if test="${!empty(riskTypeJson)}">
				TreeNode.prototype.paintChildren=function(){
					if(!this.childrenRendered){
						this['html-element']['child'].innerHTML = '';
						this.childrenRendered = true;
						var childNodes = this.childNodes;
						for(var i=0;i < childNodes.length;i++){
							childNodes[i].render();
							childNodes[i].expand();
						}
					};
				}
				var tree = new TreePanel({
					'root' : ${riskTypeJson}
				});
				function drawTree(){
					tree.container = document.getElementById('content');
					tree.addListener('click',RightGo);
					tree.iconPath='${contextPath}/scripts/treepanel/img/';
					tree.showSelectBox = false;
					tree.checkChild=false;
					tree.isExpand=false;
					tree.render();
					tree.getRootNode()['html-element']['checkbox'].style.display='none';
					tree.getRootNode().expand();
				}
			</s:if>
			<s:else>
				function drawTree(){}
			</s:else>
		</script>
</head>
<body onload="drawTree()">
	<table cellpadding=0 cellspacing=1 border=0 bgcolor="#409cce"
		class="ListTable" width="100%" align="center">
		<tr class="listtablehead">
			<td colspan="4" class="edithead"
				style="text-align: left; width: 100%;">
				<div style="display: inline; width: 80%;">
					<s:property escape="false"
						value="@ais.framework.util.NavigationUtil@getNavigation('/ais/resmngt/risk/index.action')" />
				</div>
				<div style="display: inline; width: 20%; text-align: right;">
					<a href="javascript:;" onclick="triggerSearchTable();">查询条件</a>
				</div>
			</td>
		</tr>
	</table>
	<s:hidden name="helper.risk.riskType" id="riskTypeId" />
	<div id="container">
	<div id="content2">
	  </div>
	  <div id="content">
	  </div>
	  <div id="sidebar">
	  	<center>
	  	<s:form action="index" namespace="/resmngt/risk" method="post" name="riskSearchForm" id="riskSearchForm"> 
	  	<s:hidden name="helper.risk.riskType"/>
	  		<table id="searchTable" style="display: none;" cellpadding="0" cellspacing="1" border="0" bgcolor="#409cce" class="ListTable" align="center">
				<tr class="listtablehead">
					<td align="left" class="listtabletr1">
						风险报告名称
					</td>
					<TD class="listtabletr1">
						<s:textfield name="helper.risk.title" />
					</TD>
					<TD align="center" class="listtabletr1">
						年度
					</TD>
					<TD class="listtabletr1">
						<s:textfield name="helper.risk.year" />
					</TD>
				</tr>
				<tr class="listtablehead">
					<TD class="listtabletr1">
						上传人
					</TD>
					<TD class="listtabletr1">
						<s:textfield name="helper.risk.uploaderName" />
					</TD>
					<TD align="center" class="listtabletr1" id="company1">
						上传单位
					</TD>
					<TD class="listtabletr1" id="company2">
							<s:buttonText name="helper.risk.uploadDeptName" id="uploadDeptName" hiddenId="uploadDept" hiddenName="helper.risk.uploadDept" cssStyle="width:80%"
							doubleOnclick="showPopWin('/pages/system/search/searchdata.jsp?url=/systemnew/orgList.action&paraname=helper.risk.uploadDeptName&paraid=helper.risk.uploadDept&p_item=0&orgtype=1',600,350,'所属单位')"
							doubleSrc="/resources/images/s_search.gif" doubleCssStyle="cursor:hand;border:0" readonly="true" doubleDisabled="false"/>
					</TD>
				</tr>
				<tr class="listtablehead" align="right">
					<td colspan="6" align="right" class="listtabletr1">
						<div align="right">
							<s:button value="查询" onclick="mySearchSubmit()"></s:button>
							&nbsp;&nbsp;&nbsp;&nbsp;
							<s:button value="重置" onclick="myReset()"></s:button>
							&nbsp;&nbsp;&nbsp;&nbsp;
						</div>
					</td>
				</tr>
			</TABLE>
		</s:form>
	  		<s:form action="delete" namespace="/resmngt/risk" method="post" name="riskForm" id="riskForm"> 
				<display:table name="result" id="rows" class="its"
					requestURI="/resmngt/risk/index.action"
					pagesize="${helper.pageSize}" partialList="true" 
					size="${helper.totalRows}">
					<s:if test="${helper.risk.riskType!='root'&&helper.risk.riskType!=null}">
					<display:column headerClass="center" class="center" style="width:30px">
						<input type="checkbox" name="riskIds" value="${rows.riskId}">
					</display:column>
					</s:if>
					<display:column title="风险报告名称" property="title" headerClass="center" sortable="true" 
						style="word-break : break-all " sortName="title"/>
					<display:column title="年度" property="year" headerClass="center" sortable="true" 
						style="width:80px;word-break : break-all " sortName="year"/>
					<display:column title="上传人" property="uploaderName" headerClass="center" sortable="true" 
						style="width:80px;word-break : break-all " sortName="uploaderName"/>
					<display:column title="上传单位" property="uploadDeptName" headerClass="center" sortable="true" 
						style="width:20%;" sortName="uploadDeptName" />
					<display:column title="上传时间" property="uploadTime" headerClass="center" sortable="true" 
						style="width:20%;word-break : break-all " sortName="uploadTime"/>
				</display:table>
				
					<table style="width: 98%; border: 0">
					<tr>
						<td>
							<span style="float: right;"> 
							<s:if test="${helper.risk.riskType!='root'&&helper.risk.riskType!=null}">
									<s:button value="全选" onclick="checkall('riskIds');"></s:button> 
									<s:button value="反选" onclick="checkback('riskIds');"></s:button> 
									<s:button value="删除" onclick="mydelSubmit();"></s:button> 
									<s:button value="修改" onclick="myeditSubmit();"></s:button> 
									<s:button value="增加" onclick="myaddSubmit();"></s:button>
							</s:if>
									<input type="button" onclick="javascript:showPopWin('${contextPath}/resmngt/riskType/listType.action',480,350,'风险分类管理')" value="分类管理">
							</span>
						</td>
					</tr>
					</table>
			</s:form>
	  	</center>
	  </div>
	</div>
</body>
</html>