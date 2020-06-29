<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="fmt"%>

<s:text id="title" name="'查看详情'"></s:text>

<html>
<head><title><s:property value="#title"/></title>
<link href="${contextPath}/styles/main/ais.css" rel="stylesheet" type="text/css">
		<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
</head>
<body>
<center>
<s:form>
				<table id='tab1' cellpadding=0 cellspacing=1 border=0 bgcolor="#409cce" class="ListTable">
					<tr>
						<td class="ListTableTr11">
							项目名称
						</td>
						<td class="ListTableTr22">
							<s:property  value="outsideHistory.projectName"/>
						</td>
						<td class="ListTableTr11">
							审计单位
						</td>
						<td class="ListTableTr22">
							<s:property  value="outsideHistory.department"/>
						</td>
					</tr>
					<tr>
						<td class="ListTableTr11">
							审计开始日期
						</td>
						<td class="ListTableTr22">
							${outsideHistory.startDate}
						</td>
						<td class="ListTableTr11">
							审计终止日期
						</td>
						<td class="ListTableTr22">
							${outsideHistory.endDate}
						</td>						
					</tr>
					<tr>
						<td class="ListTableTr11" nowrap="nowrap">
							查出违纪违规行为金额
						</td>
						<td class="ListTableTr22">
							<fmt:formatNumber value="${outsideHistory.wjwgje}" pattern="###,###.##" type="currency" minFractionDigits="2"/>（万元）
						</td>
						<td class="ListTableTr11" nowrap="nowrap">
							应上缴金额
						</td>
						<td class="ListTableTr22">
							<fmt:formatNumber value="${outsideHistory.ysjje}" pattern="###,###.##" type="currency" minFractionDigits="2"/>（万元）
						</td>						
					</tr>
					<tr>
						<td class="ListTableTr11" nowrap="nowrap">
							调账金额
						</td>
						<td class="ListTableTr22">
							<fmt:formatNumber value="${outsideHistory.tzje}" pattern="###,###.##" type="currency" minFractionDigits="2"/>（万元）
						</td>
						<td class="ListTableTr11" nowrap="nowrap">
							纠正损失浪费金额
						</td>
						<td class="ListTableTr22">
							<fmt:formatNumber value="${outsideHistory.jzsslfje}" pattern="###,###.##" type="currency" minFractionDigits="2"/>（万元）
						</td>						
					</tr>
					<tr>
						<td class="ListTableTr11" nowrap="nowrap">
							促进增收节支金额
						</td>
						<td class="ListTableTr22">
							<fmt:formatNumber value="${outsideHistory.cjzsjzje}" pattern="###,###.##" type="currency" minFractionDigits="2"/>（万元）
						</td>
						<td class="ListTableTr11" nowrap="nowrap">
							罚款金额
						</td>
						<td class="ListTableTr22">
							<fmt:formatNumber value="${outsideHistory.fkje}" pattern="###,###.##" type="currency" minFractionDigits="2"/>（万元）
						</td>						
					</tr>
					<tr>
						<td class="ListTableTr11" nowrap="nowrap">
							提出建议意见被采纳
						</td>
						<td class="ListTableTr22">
							${outsideHistory.tcjyyj}
						</td>
						<td class="ListTableTr11" nowrap="nowrap">
							项目负责人
						</td>
						<td class="ListTableTr22">
							${outsideHistory.projectDirector}
						</td>						
					</tr>
					<tr>
						<td class="ListTableTr11" nowrap="nowrap">
							备注
						</td>
						<td class="ListTableTr22" colspan="3">
							${outsideHistory.remark}
						</td>
					</tr>
					<tr>
						<td class="ListTableTr11">
							附件
						</td>
						<td class="ListTableTr22" colspan="3">
							<div id="otherResourceFileList" align="center">
								<s:property escape="false" value="otherResourceFileList" />
							</div>							
						</td>
					</tr>
				</table>
<s:hidden name="outsideHistory.id"/>  
<s:hidden name="outsideHistory.objectId"/>
<input type="button" name="back" value="返回" onclick="javascript:window.location='<s:url action="list"><s:param name="outsideHistory.objectId" value="%{outsideHistory.objectId}"/></s:url>'">
 </s:form>

</center>
</body>
</html>