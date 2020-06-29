<!DOCTYPE HTML>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<html>
	<head>
		<title>基础信息</title>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">	
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
		<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
		<script language="javascript">
			$(function(){
				if('${sucFlag}'=='1'){
					$.messager.alert('提示信息','编码在本类中已存在，请重新输入!','warning');			
				}else if('${sucFlag}'=='2'){
					$.messager.alert('提示信息','名称在本类中已存在，请重新输入!','warning');
				}		
			});	
			function myCheck(){
				c=$_name('codeName.code');
				n=$_name('codeName.name');
				s=$_name('codeName.status');
				var s = document.getElementsByName("codeName.status")[0].value;
				//liululu
				co=$_name('codeName.note');
				if(empty(c)){
					$.messager.show({title:'提示信息',msg:'编码是必填项!'});
					return false;
				}
				if(empty(n)){
					$.messager.show({title:'提示信息',msg:'名称是必填项!'});
					return false;
				}
				/* liululu */
				if(("undefined"  != typeof co) &&   empty(co)){
					$.messager.show({title:'提示信息',msg:'关联提示语是必填项!'});
					return false;
				}
				if(s = null || s == ''  ){
					$.messager.show({title:'提示信息',msg:'状态是必填项!'});
					return false;
				}
				if(!isNum(c)){
					$.messager.show({title:'提示信息',msg:'编码 只能包含数字!'});
					return false;}
				return true;
			}
			function gback(){  
				window.history.back();
				//window.location.href='<%=request.getContextPath()%>/basic/codename/list.action?type=${type}&expand=${expand}&codeHead.pid=${codeHead.pid}&codeHead.id=${codeHead.id}&codeHead.level=${codeHead.level}&codeHead.type=${codeHead.type}';
			}
			function $_name(n){return document.getElementsByName(n)[0];}
			function empty(n){if(n.value==''){n.focus();n.select(); return true;}return false;}
			function empty2(n){if(n.value==''){n.focus(); return true;}return false;}
			function isNum(obj) {b=(new RegExp(/^[0-9]+$/).test(obj.value)); if(!b){obj.focus();obj.select();}return b;}
			
			function doSearch(){
				if(!myCheck()){
					return false;
				}
				document.getElementById("myform").submit();
			}
		</script>
	</head>
<body >
		<div class="easyui-panel" title="${name}" fit=true style="overflow: visibility ;">
		<s:if test="${not empty(expand)}">
				<table cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
				<tr >
					<td colspan="5" align="left" class="EditHead">
						<s:property escape="false" value="@ais.framework.util.NavigationUtil@getNavigation('/ais/basic/codename/list.action?type=${type}&expand=${expand}','修改')"/>
					</td>
				</tr>
			</table>
		</s:if>
		<s:if test="${type==4002}">
			<font color="red">温馨提示：</font><br/>
				编码必须是阿拉伯数字；名称和编码中数字必须保持一致；他们的关系：编码表示年份或期限长度，名称是表现形式。例: 编码 10  名称 10年
		</s:if>
		<s:form id="myform" name="myform"  namespace="/basic/codename" action="save"  onsubmit="return myCheck();" theme="simple">
			<input name="expand" value="${expand}" type="hidden"/>
			<input name="codeHead.pid" value="${codeHead.pid}" type="hidden"/>
			<input name="codeHead.id" value="${codeHead.id}" type="hidden"/>
			<input name="codeHead.level" value="${codeHead.level}" type="hidden"/>
			<input name="codeHead.type" value="${codeHead.type}" type="hidden"/>
			<table cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
				<tr>
					<td class="EditHead">
					<font color="red">*</font>&nbsp;编码
					</td>
					<td class="editTd">
						<s:textfield cssClass="noborder" name="codeName.code" />
					</td>
				</tr>
				<tr>
					<td class="EditHead">
						<font color="red">*</font>&nbsp;名称
					</td>
					<td class="editTd">
						<s:textfield cssClass="noborder"  name="codeName.name" />
					</td>
					
				</tr>
				<s:if test="${type==3014 || type==3015}">
				<tr>
					<td class="EditHead">
						<font color="red">*</font>&nbsp;关联提示语(限500字)
					</td>
					<td class="editTd">
					<!-- liululu -->
					<%-- <s:textarea name="codeName.note" cssStyle="width:100%;overflow-y:visible;" title="审计对象及范围" /> --%>
					<s:textarea name="codeName.note" cssStyle="width:100%;overflow-y:visible;" title="风险评估结果" />
					<input type="hidden" id="codeName.note.maxlength" value="500">
					</td>
				</tr>				
				</s:if>				
				<tr>
				
					<td class="EditHead">
						<font color="red">*</font>&nbsp;状态
					</td>
					<td class="editTd">
						<!--<s:select list="#@java.util.LinkedHashMap@{'1':'正常','2':'注销','3':'删除'}"
							 emptyOption="true" listValue="value" listKey="key" name="codeName.status"></s:select>-->
						 <select class="easyui-combobox" name="codeName.status" id="status"   editable="false">
						 <!-- liululu -->
						       <option value="">请选择</option>
						       <s:iterator value="#@java.util.LinkedHashMap@{'1':'正常','2':'注销','3':'删除'}" >
						       		<s:if test="${codeName.status==key}">
						       			<option value="<s:property value="key"/>"  selected="selected"><s:property value="value"/></option>
						       		</s:if>
						       		<s:else>
						         		<option value="<s:property value="key"/>"><s:property value="value"/></option>
						         	</s:else>	
						       </s:iterator>
						    </select>	 
					</td>
				</tr>
			</table>

			<s:hidden name="type" label="类型" />
			<s:hidden name="id" />
			<s:hidden name="codeName.pid" />
			<s:hidden name="codeName.level" />
			<s:hidden name="codeName.sys_type" />
			<s:if test="${not empty(expand)}">
				<s:hidden name="expand" value="${expand}" />
			</s:if>
			<br>
				<span style="float: right;"> 
							<a class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="doSearch()">保存</a>&nbsp;&nbsp;
							<a class="easyui-linkbutton" data-options="iconCls:'icon-undo'" onclick="gback()">返回</a>&nbsp;&nbsp;
						</span>
		</s:form>
		<s:if test="${not empty(expand)}">
		</s:if>
	</div>
	</body>
	<script type="text/javascript">
		$(function(){
			var key="${codeName.status}";
			if(key != "0"){
				$('#status').combobox('select','${codeName.status}');
			}
		 	
		});
	</script>
</html>
