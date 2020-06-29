<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
	<s:text id="title" name="'工程台账查看'"></s:text>
<html>
<link href="${contextPath}/styles/main/ais.css" rel="stylesheet" type="text/css">
<head>
<title><s:property value="#title"/></title>
<s:head/>
</head>

<body>
<center>
<table>
	<tr class="listtablehead"><td colspan="5" align="left" class="edithead">&nbsp;<s:property value="#title"/></td></tr>
</table>

<table id="tab1" cellpadding=1 cellspacing=1 border=0 bgcolor="#409cce"
		class="ListTable">

		<tr>
			<td class="ListTableTr11">审计项目编号:</td>
			<td class="ListTableTr22"><s:property
				value="ledgerEngineer.a_project_code"  /></td>
			<td class="ListTableTr11">送审日期:</td>
			<td class="ListTableTr22"><s:property
				value="ledgerEngineer.deliver_time"  /></td>
		
		</tr>
		<tr>
			<td class="ListTableTr11">审计单位编号:</td>
			<td class="ListTableTr22"><s:property
				value="ledgerEngineer.auditedDeptCode"  /></td>
			<td class="ListTableTr11">审计单位:</td>
			<td class="ListTableTr22"><s:property
				value="ledgerEngineer.auditedDept"  /></td>
		</tr>

		<tr>
			<td class="ListTableTr11">审计单位性质编号:</td>
			<td class="ListTableTr22"><s:property
				value="ledgerEngineer.auditedKindCode"  /></td>
			<td class="ListTableTr11">施工承包单位:</td>
			<td class="ListTableTr22"><s:property
				value="ledgerEngineer.contract_company"  /></td>
		</tr>

		<tr>
			<td class="ListTableTr11">工程项目编号:</td>
			<td class="ListTableTr22"><s:property
				value="ledgerEngineer.w_project_code"  /></td>
			<td class="ListTableTr11">工程项目名称:</td>
			<td class="ListTableTr22"><s:property
				value="ledgerEngineer.w_project_name"  /></td>
		</tr>


		<tr>
			<td class="ListTableTr11">审计项目投资总额:</td>
			<td class="ListTableTr22"><s:property
				value="ledgerEngineer.w_invest_sum"  doubles="true"/></td>
			<td class="ListTableTr11">项目期间:</td>
			<td class="ListTableTr22"><s:property
				value="ledgerEngineer.w_starttime" />至 <s:property
				value="ledgerEngineer.w_endtime" /></td>
		</tr>


		<tr>
			<td class="ListTableTr11">送审金额:</td>
			<td class="ListTableTr22"><s:property
				value="ledgerEngineer.deliver_money" doubles="true" /></td>
			<td class="ListTableTr11">审定金额:</td>
			<td class="ListTableTr22"><s:property
				value="ledgerEngineer.shending_money" doubles="true" /></td>
		</tr>
		<tr>
			<td class="ListTableTr11">核减率:</td>
			<td class="ListTableTr22"><s:property
				value="ledgerEngineer.hejian_ratio"  /></td>
			<td class="ListTableTr11">核减金额:</td>
			<td class="ListTableTr22"><s:property
				value="ledgerEngineer.hejian_jine" doubles="true" /></td>
		</tr>
	</table><!--
	<table id="tab2" cellpadding=1 cellspacing=1 border=0 bgcolor="#409cce"
		class="ListTable">
		<tr>
			<td class="ListTableTr11" colspan="4"><p align="center">查处问题</p></td>
		</tr>
		<tr>
			<td class="ListTableTr11">超规模超标准金额:</td>
			<td class="ListTableTr22"><s:property
				value="ledgerEngineer.cgmcbz_money" doubles="true" /></td>
			<td class="ListTableTr11">资金不落实金额:</td>
			<td class="ListTableTr22"><s:property
				value="ledgerEngineer.zjbls_money" doubles="true" /></td>
		</tr>

		<tr>
			<td class="ListTableTr11">多列概算金额:</td>
			<td class="ListTableTr22"><s:property
				value="ledgerEngineer.dlgs_money" doubles="true" /></td>
			<td class="ListTableTr11">投资完成额不实:</td>
			<td class="ListTableTr22"><s:property
				value="ledgerEngineer.tzwcebz_money" doubles="true" /></td>
		</tr>

		<tr>
			<td class="ListTableTr11">交付资产不实:</td>
			<td class="ListTableTr22"><s:property
				value="ledgerEngineer.jfzcbs_money" doubles="true" /></td>
			<td class="ListTableTr11">损失浪费:</td>
			<td class="ListTableTr22"><s:property
				value="ledgerEngineer.sslf_money" doubles="true" /></td>
		</tr>

		<tr>
			<td class="ListTableTr11">转移侵占挪用资金:</td>
			<td class="ListTableTr22"><s:property
				value="ledgerEngineer.zyqzny_money" doubles="true" /></td>
			<td class="ListTableTr11">挤占建设成本金额:</td>
			<td class="ListTableTr22"><s:property
				value="ledgerEngineer.jzjszb_money" doubles="true" /></td>
		</tr>

		<tr>
			<td class="ListTableTr11">多结工程款:</td>
			<td class="ListTableTr22"><s:property
				value="ledgerEngineer.djgc_money" doubles="true" /></td>
			<td class="ListTableTr11">截留基本建设收入:</td>
			<td class="ListTableTr22"><s:property
				value="ledgerEngineer.jljbjc_money" doubles="true" /></td>
		</tr>

		<tr>
			<td class="ListTableTr11">偷漏税金:</td>
			<td class="ListTableTr22"><s:property
				value="ledgerEngineer.tshlsh_money" doubles="true" /></td>
			<td class="ListTableTr11">其他:</td>
			<td class="ListTableTr22"><s:property
				value="ledgerEngineer.other_money" doubles="true" /></td>
		</tr>
	</table>

	<table id="tab3" cellpadding=1 cellspacing=1 border=0 bgcolor="#409cce"
		class="ListTable">
		<tr>
			<td class="ListTableTr11">核减工程结算资金:</td>
			<td class="ListTableTr22"><s:property
				value="ledgerEngineer.hjgcjs_money" doubles="true" /></td>
			<td class="ListTableTr11">审计意见建议:</td>
			<td class="ListTableTr22"><s:property
				value="ledgerEngineer.a_audit_idea"  /></td>
		</tr>
		<tr>
			<td class="ListTableTr11">审计意见意见条数:</td>
			<td class="ListTableTr22"><s:property
				value="ledgerEngineer.a_audit_idea_num"  />
			</td>
			<td class="ListTableTr11">应补交各项税费:</td>
			<td class="ListTableTr22"><s:property
				value="ledgerEngineer.ybjgxsf_money" doubles="true" /></td>
		</tr>
		<tr>
			<td class="ListTableTr11">应归还原渠道资金:</td>
			<td class="ListTableTr22"><s:property
				value="ledgerEngineer.yghyqd_money" doubles="true" /></td>
			<td class="ListTableTr11">减少项目投资:</td>
			<td class="ListTableTr22"><s:property
				value="ledgerEngineer.jshxmtz_money" doubles="true" /></td>
		</tr>

		<tr>
			<td class="ListTableTr11">审计项目性质:</td>
			<td class="ListTableTr22"><s:property
				value="ledgerEngineer.audited_kind"  /></td>
			<td class="ListTableTr11">审计时间:</td>
			<td class="ListTableTr22"><s:property
				value="ledgerEngineer.audit_start"/>至<s:property
				value="ledgerEngineer.audit_end" /></td>

		</tr>
		<tr>
			<td class="ListTableTr11">内部审计实施单位:</td>
			<td class="ListTableTr22"><s:property
				value="ledgerEngineer.inside_company"  /></td>
			<td class="ListTableTr11">外部审计单位:</td>
			<td class="ListTableTr22"><s:property
				value="ledgerEngineer.outside_company"  /></td>
		</tr>

		<tr>
			<td class="ListTableTr11">录入人员:</td>
			<td class="ListTableTr22"><s:property
				value="ledgerEngineer.creator" 
				value="%{user.floginname}" /></td>
			<td class="ListTableTr11">录入时间:</td>
			<td class="ListTableTr22"><s:property
				value="ledgerEngineer.creat_date"/></td>
		</tr>
		<tr>
			<td class="ListTableTr11">
              附件:
            </td>
			<td class="ListTableTr22" colspan="3">
			<div id="fjList" align="center"><s:property escape="false"
				value="accessoryList" /></div>
			</td>

		</tr>


	</table>

--><s:button  value="关闭" onclick="javascript:window.close();"/> 

</center>
</body>
</html>
