<%@page import="ais.framework.util.MyProperty"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<jsp:directive.page import="java.util.Map" />
<jsp:directive.page import="java.util.Set" />
<jsp:directive.page import="java.util.Iterator" />
<jsp:directive.page import="java.util.List" />
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML>
<s:if test="formInfoList.size!=0">
	<%
		Boolean boolDefinitionMap = Boolean.FALSE;
		Map map = (Map) request.getAttribute("definitionGroupMap");
		Set set = map.keySet();
		Iterator it = set.iterator();
		int count = 0;
		while (it.hasNext()) {
			List list = (List) map.get(it.next());
			if (list.size() > 1) {
				boolDefinitionMap = Boolean.TRUE;
				break;
			}
			count++;
			if (count > 1) {
				boolDefinitionMap = Boolean.TRUE;
				break;
			}
		}
		pageContext.setAttribute("displayFlag", boolDefinitionMap);
	%>
										&nbsp;<s:if test="isUseBpm=='true'">
		<s:doubleselect id="definition_id" doubleId="group_id"
			doubleList="definitionGroupMap[top]" doubleListKey="id"
			firstName="选择流程：" secondName="选择群组：" doubleListValue="name"
			listKey="id" listValue="name2Display" name="definition_id"
			list="definitionGroupMap.keySet()" doubleName="group_id"
			theme="ufaud_simple" templateDir="/strutsTemplate"
			display="${pageScope.displayFlag}" firstNameCssStyle="border:0"></s:doubleselect>
	</s:if>
	<s:if test="isUseBpm=='true'">
		<s:submit id="submitCommon" value="启动"
			onclick="return batchStarts(batch_start_form);"></s:submit>
	</s:if>
	<s:else>
		<s:submit id="submitCommon" action="batchDirectSubmit" value="提交"
			onclick="return batchStarts(batch_start_form);"></s:submit>
	</s:else>
	<s:if
		test="@ais.bpm.util.FormTypeConstant@MNG_PROJECT_ACTUALIZE==formType">
		<input type="button" value="实施作业" onclick="ops()" />
		<script language="javascript">
		function ops()
		{
			if(!hasSelectOnlyOne2(document.getElementsByName("batch_start_form")[0],'crudIds'))
			{
				alert("该操作只能选择一条记录！");
				return false;
			}
			else
			{
				var cs=document.getElementsByName("crudIds");
				for(var i=0;i<cs.length;i++)
				{
					if(cs[i].checked&&cs[i].ops=="bs")
					{
						var num=Math.random();
						var rnm=Math.round(num*9000000000+1000000000);
						window.open('/<%=MyProperty.getProperties("gap.context")%>/gap/initproject.jsp?pro_id='+cs[i].pro_code,'cw','height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no');
						break;
						
					}
					if(cs[i].checked&&cs[i].ops=="cs")
					{
						var num=Math.random();
						var rnm=Math.round(num*9000000000+1000000000);
						window.open('<%=request.getContextPath()%>/pages/operate/oprtools.jsp?pro_id='+cs[i].pro_code+'&ops=cs','cw','height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no');
						break;
						
					}
				}
			}
		}
		</script>
	</s:if>
</s:if>
