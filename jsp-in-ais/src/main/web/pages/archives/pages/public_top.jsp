<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<jsp:directive.page import="ais.framework.util.NavigationUtil" />
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>

		<script type="text/javascript">

		</script>



		<center>
			<table id="planTable" cellpadding=0 cellspacing=1 border=0
				bgcolor="#409cce" class="ListTable">
				<tr class="listtablehead">
					<td colspan="4" align="left" class="edithead">
						文书信息
					</td>
				</tr>

				<tr>
					<td class="listtabletr1">
						<font color="red">*</font>文书名称：
					</td>
					<td class="listtabletr22" colspan="3">
						<s:textfield name="archivesPagesObject.pages_name"
							cssStyle="width:100%" maxlength="250"></s:textfield>
					</td>
				</tr>
				
				<tr>
					<td class="listtabletr1">
						<font color="red">*</font>文号：
					</td>
					<td class="listtabletr22">
						<s:textfield name="archivesPagesObject.pages_code"
							cssStyle="width:100%" maxlength="32"></s:textfield>
					</td>

					<td class="listtabletr1">
						<font color="red">*</font>保存年限（年）：
					</td>
					<td class="listtabletr22">
						<s:textfield name="archivesPagesObject.pages_year"
							cssStyle="width:100%" maxlength="4"></s:textfield>
					</td>
				</tr>

				<tr>

					<td class="listtabletr1">
						<font color="red">*</font>文书类别：
					</td>
					<td class="listtabletr22">
						<s:select id="pages_kind" name="archivesPagesObject.pages_kind"
							list="basicUtil.writTypeList" listKey="code" listValue="name"
							display="true" theme="ufaud_simple" templateDir="/strutsTemplate" />
					</td>

					<td class="listtabletr1">
						<font color="red">*</font>归档时间：
					</td>
					<td class="listtabletr22">
						<s:textfield id="pages_time" name="archivesPagesObject.pages_time"
							readonly="true" cssStyle="width:100%" maxlength="20"
							title="单击选择日期" onclick="calendar()" theme="ufaud_simple"
							templateDir="/strutsTemplate"></s:textfield>
					</td>
				</tr>



				<tr>


					<td class="listtabletr1">
						<font color="red">*</font>归档人：
					</td>
					<td class="listtabletr22">
						<s:textfield name="archivesPagesObject.pages_user_name"
							readonly="true" />
						<s:hidden name="archivesPagesObject.pages_user" />
					</td>


					<td class="listtabletr1">
						<font color="red">*</font>归档部门：
					</td>
					<td class="listtabletr22">
						<s:textfield name="archivesPagesObject.pages_depName"
							readonly="true" />
						<s:hidden name="archivesPagesObject.pages_depId" />
					</td>
				</tr>

				<tr>
					<td class="listtabletr1">
					收发文类型：
					</td>
					
					<s:if test="${pages_type=='0'}">
					<td class="listtabletr22">
					收文
					</td>
					
					<td class="listtabletr1">
						<font color="red">*</font>发文部门：
					</td>
					<td class="listtabletr22"><%--
						<s:buttonText2 id="send_depName" hiddenId="send_depId"
							name="archivesPagesObject.send_depName" cssStyle="width:90%"
							hiddenName="archivesPagesObject.send_depId"
							doubleOnclick="showPopWin('${pageContext.request.contextPath}/pages/system/search/searchdata.jsp?url=${pageContext.request.contextPath}/systemnew/orgList.action&p_item=1&orgtype=1&paraname=archivesPagesObject.send_depName&paraid=archivesPagesObject.send_depId',600,450,'组织机构选择')"
							doubleSrc="${pageContext.request.contextPath}/resources/images/s_search.gif"
							doubleCssStyle="cursor:hand;border:0" readonly="true" />
						--%><s:buttonText2 id="archivesPagesObject.send_depName" hiddenId="archivesPagesObject.send_depId"
							name="archivesPagesObject.send_depName" cssStyle="width:90%"
							hiddenName="archivesPagesObject.send_depId"
							doubleOnclick="showPopWin('${pageContext.request.contextPath}/pages/system/search/searchdata.jsp?url=${pageContext.request.contextPath}/mng/audobj/object/objselecttree.action&paraname=archivesPagesObject.send_depName&paraid=archivesPagesObject.send_depId',600,450)"
							doubleSrc="${pageContext.request.contextPath}/resources/images/s_search.gif"
							doubleCssStyle="cursor:hand;border:0"
							readonly="true"
							 />
					</td>
					
					</s:if>
					<s:else>
					<td class="listtabletr22" colspan="3">
					发文
					</td>
					</s:else>
					<s:hidden name="archivesPagesObject.pages_type" />
				</tr>
			</table>
		</center>





