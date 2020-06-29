<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/csswin/subModal.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/csswin/subModal.js"></script>
<script type="text/javascript">
	function setNull(name){document.getElementsByName(name)[0].value="";}
	function getUrlParam(){
		return "&mCodeType=${mCodeType}";
	}
	function freshGrid(){
		$('#dlgSearch').dialog('open');
	}
	function doSearch(){
		$('#objectList').datagrid({
			queryParams:form2Json('lawsForm')
		});
		$('#dlgSearch').dialog('close');
	}
	function restal(){
		resetForm('lawsForm');
		doSearch();
	}
	function doCancel(){
		$('#dlgSearch').dialog('close');
	}
	function getItem(url,title,width,height){
		generateWin('subwindow');
		$('#item_ifr').attr('src',url);
		openWin('subwindow',title,width,height);
	}
	function saveF(){
		var ayy = $('#item_ifr')[0].contentWindow.saveF();
		/*var res = ayy[0].split(',');
		var name = ayy[1].split(',');*/
   			document.all('pro_type_name').value=ayy;
   		closeWin()
	}
	function cleanF(){
		document.all('pro_type_name').value='';
   		closeWin();
	}
	function closeWin(){
		$('#subwindow').window('close');
	}
</script>
	 	<table id="searchTable" cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
			<tr >
				<td class="EditHead" sytle="width:15%">
					名称
				</td>
				<td class="editTd" sytle="width:35%">
					<s:textfield cssClass="noborder" name="assistSuportLawslib.title" cssStyle="width:160px;" />
				</td>
		
				<td class="EditHead" sytle="width:15%">
					文号
				</td>
				<td class="editTd" sytle="width:35%">
					<s:textfield cssClass="noborder" name="assistSuportLawslib.codification"
						cssStyle="width:160px;" />
				</td>
			</tr>
		
			<tr >
				<td class="EditHead">
					颁布日期
				</td>
				<td class="editTd">
					<input type="text" editable="false" Class="easyui-datebox noborder"  value="${assistSuportLawslib.promulgationDate}"  name="assistSuportLawslib.promulgationDate"  title="单击选择日期"  Style="width:160px;"/>
				</td>
				<td class="EditHead">
					生效日期
				</td>
				<td class="editTd">
					<input type="text"  Class="easyui-datebox noborder" value="${assistSuportLawslib.promulgationDate}"   name="assistSuportLawslib.effctiveDate"  title="单击选择日期"  editable="false" Style="width:160px;"/>
				</td>
			</tr>
			<tr >
				<td class="EditHead">
					失效日期
				</td>
				<td class="editTd">
					<input  Class="easyui-datebox noborder" value="${assistSuportLawslib.invalidationDate}"  name="assistSuportLawslib.invalidationDate"  title="单击选择日期"  editable="false" Style="width:160px;"/>
				</td>
				<td class="EditHead">
					颁布单位
				</td>
				<td class="editTd">
					<s:textfield cssClass="noborder" cssStyle="width:160px;"
						name="assistSuportLawslib.promulgationDept" />
				</td>
			</tr>
			<tr >
				<td class="EditHead">
					类别
				</td>
				<td class="editTd">
					<div>
						<!--<s:textfield cssClass="noborder" cssStyle="width:160px;" label="类别"
							name="assistSuportLawslib.category"  />
		
						&nbsp;
						<img
							src="<%=request.getContextPath()%>/resources/images/s_search.gif"
							onclick="showPopWin('<%=request.getContextPath()%>/pages/system/search/searchdata.jsp?url=<%=request.getContextPath()%>/pages/assist/suport/lawsLib/allLawsLibMenus.action&urlpara=getUrlParam&paraname=assistSuportLawslib.category&paraid=assistSuportLawslib.categoryFk',500,350)"
							border=0 style="cursor: hand"> -->
						<s:textfield cssClass="noborder" readonly="true" name="assistSuportLawslib.category"  id="pro_type_name" cssStyle="width:150px" />
						<img style="cursor:hand;border:0" src="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png" 
							 onclick="getItem('/ais/pages/assist/suport/lawsLib/searchdate_flfg.jsp','选择类别',500,400)"></img>
					</div>
				</td>
				<td class="EditHead">
					有效性
				</td>
				<td class="editTd">
					<!--<s:select list="#@java.util.LinkedHashMap@{'有效':'有效','无效':'无效'}"
						emptyOption="true" name="assistSuportLawslib.effective" cssClass="easyui-combobox"
						cssStyle="width:160px" />
					-->	
					 <select class="easyui-combobox" editable="false" name="assistSuportLawslib.effective" style="width:80%;" editable="false" data-options="panelHeight:75">
				       <option value="">&nbsp;</option>
				       <s:iterator value="#@java.util.LinkedHashMap@{'有效':'有效','无效':'无效'}" id="entry">
				         <option value="<s:property value="key"/>"><s:property value="value"/></option>
			       	   </s:iterator>
			       </select>
				</td>
			</tr>
			<tr >
				<td class="EditHead">
					发布状态
				</td>
				<td class="editTd">
					<!--<s:select list="#@java.util.LinkedHashMap@{'Y':'是','N':'否'}"
						emptyOption="true" name="assistSuportLawslib.pub_state"
						cssStyle="width:160px" />-->
					<select class="easyui-combobox" name="assistSuportLawslib.pub_state" style="width:80%;" editable="false" data-options="panelHeight:75">
				       <option value="">&nbsp;</option>
				       <s:iterator value="#@java.util.LinkedHashMap@{'Y':'是','N':'否'}" id="entry">
				         <option value="<s:property value="key"/>"><s:property value="value"/></option>
				       </s:iterator>
				    </select>	
				</td>
				<td class="EditHead">
					创建日期
				</td>
				<td class="editTd">
					<input name="assistSuportLawslib.createDateStart"
						type="text" editable="false" class="easyui-datebox" style="width: 110px"/>到
					<input name="assistSuportLawslib.createDateEnd"
						type="text" editable="false" class="easyui-datebox" style="width: 110px"	/>				
				</td>		
			</tr>
			<s:hidden name="mCodeType" value="${mCodeType}"></s:hidden>
			<s:hidden name="nodeid" value="${nodeid}"></s:hidden>
			<s:hidden name="marked" value="0"></s:hidden>
			<s:hidden name="ids" id="ids"></s:hidden>
			<s:hidden name="assistSuportLawslib.id" id="assistSuportLawslib.id"></s:hidden>
			<s:hidden name="assistSuportLawslib.categoryFk"></s:hidden>
			<s:if test="m_view!=null&&m_view=='view'">
				<a class="easyui-linkbutton" data-options="iconCls:'icon-edit'"  name="assistSuportLawslib.pub_state" >Y</a>
			</s:if>
		</table>
		<div id="subwindow" class="easyui-window" title="类别" style="width:500px;height:500px;padding:5px;" closed="true">
			<div class="easyui-layout" fit="true" border="false" style="overflow:hidden;">
				<div region="center" border="false" style="overflow:hidden;">
					<iframe id="item_ifr" name="item_ifr" src="" frameborder="0" width="100%" height="100%" scrolling="auto" ></iframe>
				</div>
				<div region="south" border="false" style="text-align:right;padding:5px 0;">
				    <div style="display: inline;" align="right">
						<a class="easyui-linkbutton" data-options="iconCls:'icon-ok'"   onclick="saveF()">确定</a>
						<a class="easyui-linkbutton" data-options="iconCls:'icon-tip'"  onclick="cleanF()">清空</a>
						<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'"   onclick="closeWin()">关闭</a>
				    </div>
				</div>
			</div>
		</div>