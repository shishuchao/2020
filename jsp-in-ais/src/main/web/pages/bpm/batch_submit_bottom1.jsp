<%@page import="ais.framework.util.MyProperty"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML>
<div align="center">
	<s:if test="formInfoList.size!=0">
		<table width="=100%">
			<tr>
				<td width="5%">
					<font size="2pt">意见</font>
				</td>
				<td width="50%">
					<s:textarea name="taskInstanceInfo.comments"
						cssStyle="width:100%;height:20;overflow-y:visible" />
				</td>
				<td id="hiddenArea1">
					<font size="2pt">下一步处理人</font>
				</td>
				<td id="hiddenArea2" width="20%">
					<s:buttonText name="formInfo.toActorId_name"
						hiddenName="formInfo.toActorId"
						doubleOnclick="showPopWin('/pages/system/search/frameselect4s.jsp?url=/pages/system/userindex.jsp&paraname=formInfo.toActorId_name&paraid=formInfo.toActorId',600,350)"
						doubleSrc="/resources/images/s_search.gif"
						doubleCssStyle="cursor:hand;border:0" readonly="true"
						display="true" doubleDisabled="false" />
				</td>
				<td>
					<s:submit id="batchSubmitButton" action="batchSubmit" value="批量提交"
						onclick="return batchSubmit(batch_submit_form)"></s:submit>
				</td>
				<td>
					<s:if
						test="@ais.bpm.util.FormTypeConstant@MNG_PROJECT_ACTUALIZE==formType">
						<input type="button" value="实施作业" onclick="ops()" />
						<script language="javascript">
						function ops()
						{
							if(!hasSelectOnlyOne2(document.getElementsByName("batch_submit_form")[0],'crudIds'))
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
										window.open('/<%=MyProperty.getProperties("gap.context")%>/gap/initproject.jsp?pro_id='+cs[i].pro_code,'','height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no');
										break;
										
									}
								}
							}
						}
						</script>
					</s:if>
				</td>
			</tr>
		</table>
		<table width="=100%">
			<tr>
				<td width="20%">
					<font size="2pt">催办时间</font>
				</td>
				<td width="80%">
					<font size="2pt"><s:checkboxlist name="times"
							list="#@java.util.LinkedHashMap@{'24':'24小时','48':'48小时','72':'72小时','96':'96小时','120':'120小时'}"></s:checkboxlist>
					</font>
				</td>
			</tr>
		</table>
	</s:if>
</div>
