<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/resources/csswin/style.css" />
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/resources/csswin/subModal.css" />
<script type="text/javascript"
	src="<%=request.getContextPath()%>/resources/csswin/common.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/resources/csswin/subModal.js"></script>
<script type="text/javascript">
	function reset2(){
		document.getElementsByName("assistSuportLawslib.title")[0].value="";	
		document.getElementsByName("assistSuportLawslib.promulgationDate")[0].value="";	
		document.getElementsByName("assistSuportLawslib.promulgationDept")[0].value="";	
		document.getElementsByName("assistSuportLawslib.category")[0].value="";	
		document.getElementsByName("assistSuportLawslib.summan")[0].value="";	
		document.getElementsByName("assistSuportLawslib.sundept")[0].value="";	
		document.getElementsByName("assistSuportLawslib.content")[0].value="";	
		document.getElementsByName("assistSuportLawslib.categoryFk")[0].value="";
	}
	function getUrlParam(){
		return "&mCodeType=${mCodeType}";
	}
	</script>
<table id="searchTable" style="display: none;" 
	class="ListTable">

	<tr class="titletable1">
		<td class="ListTableTr11">
			名称
		</td>
		<td>
			<s:textfield name="assistSuportLawslib.title" />
		</td>
		<td class="ListTableTr11">
			发布单位
		</td>
		<td>
			<s:textfield name="assistSuportLawslib.promulgationDept" />
		</td>
	</tr>

	<tr class="titletable1">
		<td class="ListTableTr11">
			颁布日期
		</td>
		<td>
			<s:textfield name="assistSuportLawslib.promulgationDate"
				value="${assistSuportLawslib.promulgationDate}"
				onclick="calendar();" readonly="true" />
		</td>
		<td class="ListTableTr11">
			经验类别
		</td>
		<td>
			<div>
				<s:textfield name="assistSuportLawslib.category" />

				&nbsp;
				<img
					src="<%=request.getContextPath()%>/resources/images/s_search.gif"
					onclick="showPopWin('<%=request.getContextPath()%>/pages/system/search/searchdata.jsp?url=<%=request.getContextPath()%>/pages/assist/suport/lawsLib/allLawsLibMenus.action&urlpara=getUrlParam&paraname=assistSuportLawslib.category&paraid=assistSuportLawslib.categoryFk',500,460)"
					border=0 style="cursor: hand">
			</div>
		</td>
	</tr>
	<tr class="titletable1">
		<td class="ListTableTr11">
			创建人
		</td>
		<td>
			<s:textfield name="assistSuportLawslib.summan" />
		</td>
		<td class="ListTableTr11">
			创建单位
		</td>
		<td>
			<s:textfield name="assistSuportLawslib.sundept" />
		</td>
	</tr>
	<tr class="titletable1">
		<td class="ListTableTr11">
			正文
		</td>
		<td>
			<s:textfield name="assistSuportLawslib.content" />
		</td>
		<td></td>
		<td style="text-align: right;" class="ListTableTr11">
			<input type="button" value="查询" onclick="mSearchSub();">
			&nbsp;&nbsp;
			<input type="button" value="重置" onclick="reset2();">
		</td>
	</tr>
	<s:if test="m_view!=null&&m_view=='view'">
		<input type="hidden" name="assistSuportLawslib.pub_state" value="Y">
	</s:if>
	<s:hidden name="assistSuportLawslib.categoryFk" />
</table>