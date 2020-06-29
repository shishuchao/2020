
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<s:text id="title" name="'日记查看'"></s:text>





<html>
<script language="javascript">
function searchList(){
//匹配查询

	var url = "${contextPath}/mng/train/search.action";
	myform.action = url;
	myform.submit();
	
}


function searchrecal(){
	var url = "${contextPath}/mng/train/search.action";
    window.location = url;
}
</script>
<link href="${contextPath}/styles/main/ais.css" rel="stylesheet" type="text/css">
<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
<script type="text/javascript" src="${contextPath}/resources/csswin/subModal.js"></script>
<SCRIPT type="text/javascript" src="${contextPath}/scripts/calendar.js"></SCRIPT>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
<title><s:property value="#title"/></title>
<s:head/>
</head>

<body>
<center>

<table>
	<tr class="listtablehead"><td colspan="5" align="left" class="edithead"><s:property escape="false" value="@ais.framework.util.NavigationUtil@getNavigation('/ais/mng/train/search.action')"/>
	</td></tr>
</table>

<s:form id="myform"   action="view.action"   namespace="/mng/train">



<table cellpadding=1 cellspacing=1 border=0 bgcolor="#409cce" class="ListTable">
	



	  

<tr  class="titletable1">
<td style="width:20%">
发布人:</td><!--标题栏-->
<td style="width:30%">

 <s:buttonText name="train.train_publisher"
							cssStyle="width:80%" hiddenName="train.train_publisher_id"
							doubleOnclick="showPopWin('/pages/system/search/mutiselect.jsp?url=/pages/system/userindex.jsp&paraname=train.train_publisher&paraid=train.train_publisher_id',600,450)"
							doubleSrc="/resources/images/s_search.gif"
							doubleCssStyle="cursor:hand;border:0"
							readonly="false"
							display="true"
							doubleDisabled="false" /><!--人员多选-->

</td>

<td style="width:20%">
发布单位:</td><!--标题栏-->
<td style="width:30%">

 <s:buttonText name="train.train_dept"
							cssStyle="width:80%" hiddenName="train.train_dept_id"
							doubleOnclick="showPopWin('/pages/system/search/searchdatamuti.jsp?url=/system/uSystemAction!orgList4muti.action&paraname=train.train_dept&paraid=train.train_dept_id',600,450)"
							doubleSrc="/resources/images/s_search.gif"
							doubleCssStyle="cursor:hand;border:0"
							readonly="false"
							display="true"
							doubleDisabled="false" /><!--组织结构多选-->

</td>
</tr>
                    
             	  

<tr  class="titletable1">
<td>
课程名称:</td><!--标题栏-->
<td>

<s:textfield  name="train.course_title" cssStyle="width:80%"/><!--一般文本框-->

</td>

<td>
适用人员:</td><!--标题栏-->
<td>

 <s:buttonText name="train.trained_staff"
							cssStyle="width:80%" hiddenName="train.trained_staff_id"
							doubleOnclick="showPopWin('/pages/system/search/searchdatamuti.jsp?url=/system/uSystemAction!orgList4muti.action&paraname=train.trained_staff&paraid=train.trained_staff_id',600,450)"
							doubleSrc="/resources/images/s_search.gif"
							doubleCssStyle="cursor:hand;border:0"
							readonly="true"
							display="true"
							doubleDisabled="false" /><!--人员多选-->

</td>
</tr>            	  


             	  
<tr  class="titletable1">
<td>
发布日期:</td>
<td>
<s:textfield  name="train.release_date1" title="单击选择日期"  onclick="calendar()"  readonly="true" cssStyle="width:37%"/>~
<s:textfield  name="train.release_date2" title="单击选择日期"  onclick="calendar()"  readonly="true" cssStyle="width:37%"/><td></td>
   <td></td>       </tr>   	  
</table>


<s:hidden name="train.id"/>  
<div align="right">
<s:button value="查询" onclick="javascript:searchList();"/>&nbsp;&nbsp;
<s:button value="重置" onclick="javascript:searchrecal();"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</div>
</s:form>
<display:table name="list" id="row" requestURI="${contextPath}/mng/train/search.action" class="its" 
	pagesize="10" partialList="true" size="resultSize">

		
		
		
	<display:column property="train_publisher" title="发布人" headerClass="center" maxLength="12" style="WHITE-SPACE: nowrap" class="center" sortable="true"></display:column>	
		
	<display:column property="train_dept" title="发布单位" headerClass="center" maxLength="12" style="WHITE-SPACE: nowrap" class="center" sortable="true"></display:column>	
		
	<display:column property="course_title" title="课程名称" headerClass="center" maxLength="12" style="WHITE-SPACE: nowrap" class="center" sortable="true"></display:column>	
	
	<display:column property="staff_str" title="适用人员" headerClass="center" maxLength="12" style="WHITE-SPACE: nowrap" class="center" sortable="true"></display:column>
	
	<display:column property="release_date" title="发布日期"headerClass="center" maxLength="10" style="WHITE-SPACE: nowrap" class="center" sortable="true"></display:column>
	

	<display:column title="操作" headerClass="center" maxLength="12" style="WHITE-SPACE: nowrap" class="center" sortable="true">
		<a href="<s:url action="view"><s:param name="id" value="${row.id}"/></s:url>" target="_blank">查看</a>
	</display:column>			
</display:table>
</center>
</body>
</html>
