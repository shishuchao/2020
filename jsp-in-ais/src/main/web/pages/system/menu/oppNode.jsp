<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
	<head>
		<title></title>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
		<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>

		<script type="text/javascript">
			function myback(id){
				//url="${contextPath}/pages/system/menu/oppNodeList.jsp?ffunid=${id}";
				//window.location.href=url;
				url="${contextPath}/system/omListNode.action?view=view&abf.ffunid="+id;
				window.location.href=url;
			}
			function myback2(id){
				url="${contextPath}/system/omListNode.action?abf.ffunid="+id;
				window.location.href=url;
			}
			function mycheckSave(){
				if(frmCheck(document.forms[0],'tablist')){
				var	qid=document.getElementById('ffunid').value;
				var	pid=document.getElementsByName("abf.fparentid").value;
					if(qid<=pid){
						showMessage1("功能序号要大于父功能序号!");
						return false;
					}
					document.getElementById('seacefrom').submit();
					//return true;
				}else
					return false;
			}
			
			function findOppName(pvalue,ptext){
				var str1 = ptext;
				str1=str1.substring(str1.lastIndexOf('[')+1,str1.lastIndexOf(']'));
				document.getElementsByName('abf.ffundisplay')[0].value=str1;
				var value = pvalue;
				if(value.indexOf(",")!=-1){
					value=value.substring(value.indexOf(",")+1,value.length);
					document.getElementsByName("abf.ffunvalue")[0].value=value;
				}else{
				
				}
			}
			function my_set_sel(){
				<s:if test="${not empty (abf.ffunid)}">
					<s:if test="${not empty (abf.ffunvalue)}">
						value='${abf.ffunvalue}';
						if(!isNaN(value)){
							value="";
						}
						name='${abf.ffunname}';
						//document.getElementsByName("abf.ffunname")[0].value=name+","+value;
						$('#ffunname').combobox('setValue',name+","+value);
					</s:if>
					<s:else>
						name='${abf.ffunname}';
						//document.getElementsByName("abf.ffunname")[0].value=name+",";
						$('#ffunname').combobox('setValue',name+",");
					</s:else>
				</s:if>
			}

			$(function(){
				$('#ffunname').combobox({
				    onSelect:function(param){
						findOppName(param.value,param.text);
				    }
				});
			});
		</script>
	</head>
	<body onload="my_set_sel();">
		<center>
			<s:form action="omSave" namespace="/system" id="seacefrom">
				<table cellpadding=0 id='tablist' cellspacing=0 border=0 align="center" class="ListTable">
					<tr>
						<td class="EditHead">
							<font color=red>*</font>&nbsp;功能序号
						</td>
						<td class="editTd">
							<s:if test="%{view!='view'}">
								<s:if test="${empty (abf.ffunid)}">
									<s:textfield  id="ffunid" cssClass="noborder" name="abf.ffunid" value="${abf.fparentid}"></s:textfield>
								</s:if>
								<s:else>
								${abf.ffunid}
								</s:else>

							</s:if>
							<s:else>
									${abf.ffunid}
							</s:else>
						</td>
						<td class="EditHead" nowrap="nowrap">
							<font color=red>*</font>&nbsp;功能名称
						</td>
						<td class="editTd">
							<s:if test="%{view!='view'}">
								<s:textfield   cssClass="noborder" name="abf.ffundisplay" readonly="true"></s:textfield>
							</s:if>
							<s:else>
								${abf.ffundisplay}
							</s:else>
						</td>
					</tr>
					<tr>
						<td class="EditHead" nowrap="nowrap">
							功能方法映射
						</td>
						<td class="editTd" colspan="3">
							<s:if test="%{view!='view'}">
							     <select id="ffunname" name="abf.ffunname" style="width:150px;"  editable="false"  panelHeight="auto">
							       <option value="">&nbsp;</option>
							       <s:iterator value="@ais.mainmenu.util.MenuUtil@findSuitMethod(turnTo)">
							         <s:if test="${abf.ffunname==code}">
						       			<option selected="selected" value="<s:property value="code"/>"><s:property value="name"/></option>
						       		 </s:if>
						       		 <s:else>
								        <option value="<s:property value="code"/>"><s:property value="name"/></option>
						       		 </s:else>
							       </s:iterator>
							    </select>
							</s:if>
							<s:else>
								${abf.ffunname}
								<s:hidden name="abf.ffunname" />
							</s:else>
							<br>
						</td>
					</tr>
				</table>
				<s:hidden name="abf.ffunvalue"></s:hidden>
				<s:if test="${empty (abf.fmoduleid)}">
					<input type="hidden" name="abf.fmoduleid" value="0">
				</s:if>
				<s:else>
					<input type="hidden" name="abf.fmoduleid" value="${abf.fmoduleid}">
				</s:else>
				<input type="hidden" name="abf.fparentid" value="${abf.fparentid}">
				<input type="hidden" name="abf.fismenu" value="N">
				<div style="text-align:right;padding-right:8px;margin-top:8px;">
					<s:if test="%{view!='view'}">
						<a class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="return mycheckSave();">保存</a>&nbsp;&nbsp;
						<s:if test="${empty (abf.ffunid)}">
							<a class="easyui-linkbutton" data-options="iconCls:'icon-undo'" onclick="javascript:history.back();">返回</a>&nbsp;&nbsp;
						</s:if>
						<s:else>
							<a class="easyui-linkbutton" data-options="iconCls:'icon-undo'" onclick="javascript:history.back();">返回</a>&nbsp;&nbsp;
						</s:else>
					</s:if>
					<s:else>
						<a class="easyui-linkbutton" data-options="iconCls:'icon-undo'" onclick="javascript:history.back();">返回</a>&nbsp;&nbsp;
					</s:else>
				</div>
			</s:form>
		</center>
	</body>
</html>