<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<html>
<base target="_self">
	<head>
	    <meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
		<title><s:property value="processName" />
		</title>

		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet"
			type="text/css">
		<link rel="stylesheet" type="text/css"
			href="<%=request.getContextPath()%>/resources/csswin/subModal.css" />
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/resources/csswin/common.js"></script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/resources/csswin/subModal.js"></script>

		<SCRIPT type="text/javascript"
			src="${contextPath}/scripts/calendar.js"></SCRIPT>
		<script type='text/javascript' src='${pageContext.request.contextPath}/scripts/turnPage.js'></script>
		

<script type="text/javascript">
 //添加文书档案
 	function add_pages(path){
	var pages_type = '<s:property value="pages_type" />';
 	var url = path+"/archives/pages/editPages.action?pages_type="+pages_type;
    window.location = url;
 	}
 	
 	
 	function view_pages(pages_id,path){
 	//view
 	var pages_type = '<s:property value="pages_type" />';
 	 var url = path+"/archives/pages/viewPages.action?pages_id="+pages_id+"&&pages_type="+pages_type;
    window.location = url;
 	}
 	
 	function edit_pages(pages_id,path){
 	//view
 	var pages_type = '<s:property value="pages_type" />';
 	 var url = path+"/archives/pages/updatePages.action?pages_id="+pages_id+"&&pages_type="+pages_type;
    window.location = url;
 	}
 	
 	function delete_pages(pages_id,path){
 	//view
 	var pages_type = '<s:property value="pages_type" />';
 	 var url = path+"/archives/pages/deletePages.action?pages_id="+pages_id+"&&pages_type="+pages_type;
    window.location = url;
 	}
 	
 	function return_pages(pages_id,path){
 	//return
 	var pages_type = '<s:property value="pages_type" />';
 	var url = path+"/archives/pages/returnPages.action?pages_id="+pages_id+"&&pages_type="+pages_type;
    window.location = url;
 	}	
 	
 	
 	
 	
 	
 	
 	
 	
 	
 	
 	
 	
 	
 	
function ref(){
var num=Math.random();
var rnm=Math.round(num*9000000000+1000000000);//随机参数清除模态窗口缓存
var url = '${contextPath}/dcenter/data/listDcenterData.action';
document.all.form.action=url;
document.all.form.submit();
}

function restal(){
	document.getElementsByName("archivesPagesObject.pages_name")[0].value="";
	document.getElementsByName("archivesPagesObject.pages_code")[0].value="";
	document.getElementsByName("archivesPagesObject.pages_depName")[0].value="";
	document.getElementsByName("archivesPagesObject.pages_depId")[0].value="";
}

</script>



	</head>
	<body>
		<center>


			<s:form action="listPages"
				namespace="/archives/pages"  name="form">
				<table cellpadding=0 cellspacing=1 border=0 bgcolor="#409cce"
					class="ListTable">
					<tr class="listtablehead">
						<td colspan="4" align="left" class="edithead">
						&nbsp;
						收文列表
						</td>
					</tr>
				</table>
		<table cellpadding=0 cellspacing=1 border=0 bgcolor="#409cce"
					class="ListTable">
					<tr class="listtablehead">
						<td align="right" class="listtabletr1">
							文书名称:
						</td>
						<td align="left" class="listtabletr1">
							<s:textfield name="archivesPagesObject.pages_name" size="25" />
						</td>
						<td align="right" class="listtabletr1">
							文书文号:
						</td>
						<td align="left" class="listtabletr1">
							<s:textfield name="archivesPagesObject.pages_code" size="25" />
						</td>
						</tr>
					<tr class="listtablehead">

						<td align="right" class="listtabletr1">
							文书类别:
						</td>
						<td align="left" class="listtabletr1">
										<s:select id="pages_kind" name="archivesPagesObject.pages_kind"
							list="basicUtil.writTypeList" listKey="code" listValue="name"
							display="true" theme="ufaud_simple" templateDir="/strutsTemplate" />
						</td>

						<td align="right" class="listtabletr1">
							所属部门:
						</td>
						<td align="left" class="listtabletr1">
						<s:buttonText name="archivesPagesObject.pages_depName" size="25"
							hiddenName="archivesPagesObject.pages_depId"
							doubleOnclick="showPopWin('/pages/system/search/searchdata.jsp?url=/systemnew/orgList.action&paraname=archivesPagesObject.pages_depName&paraid=archivesPagesObject.pages_depId&p_item=0&orgtype=1',600,450,'所属部门')"
							doubleSrc="/resources/images/s_search.gif"
							doubleCssStyle="cursor:hand;border:0" readonly="true"
							display="true" doubleDisabled="false" />
								
						</td>
					</tr>
					
					<tr class="listtablehead" align="right">
						<td colspan="6" align="right" class="listtabletr1">
							<div align="right">
								<s:submit action="listPages"   title="查询档案列表"
									value="查 询" />
								&nbsp;&nbsp;
								<s:button onclick="restal()" title="重置查询条件" value="重 置" />
								
							</div>
						</td>
					</tr>
				</table>
				<s:hidden name="pages_type" />	
			</s:form>
				<display:table name="archivesPagesList" id="row" 
					requestURI="/archives/pages/listPages.action"
					pagesize="${baseHelper.pageSize}" partialList="true" 
					size="${baseHelper.totalRows}" sort="external" class="its">  
					<display:column title="序号" headerClass="center" class="center" value="${row_rowNum}"></display:column>
					<display:column  style="WHITE-SPACE: nowrap" title="文书文号" property="pages_code" headerClass="center" class="center" sortable="true" sortName="pages_code"></display:column>
					<display:column  style="WHITE-SPACE: nowrap" title="文书名称" property="pages_name" headerClass="center" class="center" sortable="true" sortName="pages_name"></display:column>
				    <display:column  style="WHITE-SPACE: nowrap" title="文书类别" property="pages_kind_name" headerClass="center" class="center" sortable="true" sortName="pages_kind_name"></display:column>
				    <display:column  style="WHITE-SPACE: nowrap" title="所属部门" property="pages_depName" headerClass="center" class="center" sortable="true" sortName="pages_depName"></display:column>
				    <display:column  style="WHITE-SPACE: nowrap" title="归档人" property="pages_user_name" headerClass="center" class="center" sortable="true" sortName="pages_user_name"></display:column>
				    <display:column  style="WHITE-SPACE: nowrap" title="归档时间" property="pages_time" headerClass="center" class="center" sortable="true" sortName="pages_time"></display:column>
				    <display:column title="操作" headerClass="center" class="center">
					<s:a href="javascript:;" onclick="view_pages('${row.pages_id }','${pageContext.request.contextPath}');">查看</s:a>
					
					<s:if test="${row.pages_return=='0'} && ${row.pages_user==user.floginname}">
					<s:a href="javascript:;" onclick="edit_pages('${row.pages_id }','${pageContext.request.contextPath}');">编辑</s:a>
					<s:a href="javascript:;" onclick="delete_pages('${row.pages_id }','${pageContext.request.contextPath}');">删除</s:a>
					<s:a href="javascript:;" onclick="return_pages('${row.pages_id }','${pageContext.request.contextPath}');">归档确认</s:a>
					</s:if>
				    </display:column>
				    <display:setProperty name="paging.banner.placement" value="bottom" />
				</display:table>

		<center>
			<br>
			<s:button  value="添加收文档案" onclick="add_pages('${pageContext.request.contextPath}');" />
		</center>
	</body>
</html>
