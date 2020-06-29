<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<html>
<head><title></title>
<link href="${contextPath}/styles/main/ais.css" rel="stylesheet" type="text/css">
<s:head theme="ajax"/>
<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
</head>
<script>		
 		function initForm(){
 			if('<s:property value="auditDoubt.is_verify"/>'=='是'){
 				document.getElementById('verify').style.display="block";
 			}
 		} 	
</script>
<body onload="initForm()">
<center>
<s:form>
				<table id='tab1' cellpadding=0 cellspacing=1 border=0 bgcolor="#409cce" class="ListTable">
					<tbody>
					<tr>
						<td class="ListTableTr11">
							疑点名称
							<font color=red>*</font>
						</td>
						<td class="ListTableTr22" colspan="3">
							<s:property value="auditDoubt.doubt_name"/>
						</td>
			
					</tr>
					<tr>
						<td class="ListTableTr11">
							疑点附件
						</td>
						<td class="ListTableTr22" colspan="3">
							<div id="doubtFileList" align="center">
								<s:property escape="false" value="doubtFileList" />
							</div>
							
						</td>
					</tr>
					<tr>
						<td class="ListTableTr11">
							发现人
						</td>
						<td class="ListTableTr22">
							<s:property value="auditDoubt.founder"/>
						</td>
						<td class="ListTableTr11">
							发现单位
						</td>
						<td class="ListTableTr22">
							<s:property value="auditDoubt.founder_dept"/>
						</td>						
					</tr>
					<tr>
						<td class="ListTableTr11">
							发现日期
						</td>
						<td class="ListTableTr22">
							<s:property value="auditDoubt.founder_date" />
						</td>
						<td class="ListTableTr11" colspan="2">
						</td>						
					</tr>
					
					<tr>
						<td class="ListTableTr11">
							是否核实
						</td>
						<td class="ListTableTr22" colspan="3">
							<s:property value="auditDoubt.is_verify" />
						</td>												
					</tr>
									
					</tbody>
					<tbody style="display:none" id="verify">
					<tr>
						<td class="ListTableTr11">
							核实日期
						</td>
						<td class="ListTableTr22">
							<s:property value="auditDoubt.verify_date" />
						</td>
						<td class="ListTableTr11">
							核实人
						</td>
						<td class="ListTableTr22">
						<s:property value="auditDoubt.verify_man" />
						</td>						
					</tr>	
					<tr>
						<td class="ListTableTr11">
							核实人单位
						</td>
						<td class="ListTableTr22">
						<s:property value="auditDoubt.verify_man_dept" />	
						</td>
						<td class="ListTableTr11">
							核实所在项目
						<br></td>
						<td class="ListTableTr22">
						<s:property value="auditDoubt.verify_man_join_project" />
						</td>						
					</tr>
					</tbody>
																																										
				</table>
				
	
				
				
<s:hidden name="auditDoubt.doubt_id"/>  
<s:hidden name="auditDoubt.object_id"/>
<s:submit value="保存"/>&nbsp&nbsp&nbsp&nbsp
<input type="button" name="back" value="返回" onclick="javascript:window.location='<s:url action="list"><s:param name="auditDoubt.object_id" value="%{auditDoubt.object_id}"/></s:url>'">
</s:form>

</center>
</body>
</html>