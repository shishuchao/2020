<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@ taglib prefix="s" uri="/struts-tags"%>

<!DOCTYPE HTML>
<html>
  <head>
    <title>�¶ȼƻ�--Ԥѡ��Ŀ��Ϣ</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
	<link href="${contextPath}/styles/main/ais.css" rel="stylesheet" type="text/css">
  </head>
  
  <body>
		<table cellpadding=0 cellspacing=1 border=0 bgcolor="#409cce" class="ListTable" align="center">
			<tr class="listtablehead">
				<td colspan="4" align="left" class="edithead">
					&nbsp;Ԥѡ��Ŀ��Ϣ
				</td>
			</tr>
			<tr>
				<td class="ListTableTr11">
					�ƻ�״̬��
				</td>
				<td class="ListTableTr22">
					<s:property value="workPlanDetail.status_name" />
				</td>
				<td class="ListTableTr11" nowrap>
					��ȼƻ���ţ�
				</td>
				<td class="ListTableTr22">
					<s:property value="workPlanDetail.w_plan_code" />
				</td>
			</tr>
			<tr>
				<td class="ListTableTr11">
					�ƻ���ȣ�
				</td>
				<td class="ListTableTr22">
					<s:property value="workPlanDetail.w_plan_year" />
				</td>
				<td class="ListTableTr11">
					�ƻ��¶ȣ�
				</td>
				<td class="ListTableTr22">
					<s:property value="workPlanDetail.w_plan_month" />
				</td>
			</tr>
			<tr>
				<td class="ListTableTr11">
					Ԥѡ��Ŀ���ƣ�
				</td>
				<td class="ListTableTr22">
					<s:property value="workPlanDetail.w_plan_name" />
				</td>
				<td class="ListTableTr11">
					�����ˣ�
				</td>
				<td class="ListTableTr22">
					<s:property value="workPlanDetail.pro_teamleader_name"/>
				</td>
			</tr>
			<tr>
				<td class="ListTableTr11">
					�ƻ����
				</td>
				<td class="ListTableTr22">
					<s:property value="workPlanDetail.w_plan_type_name"/>
				</td>
				<td class="ListTableTr11">
					��Ŀ���
				</td>
				<td class="ListTableTr22">
					<s:property value="workPlanDetail.pro_type_name" />
					&nbsp;&nbsp;
					<s:property value="workPlanDetail.pro_type_child_name" />
				</td>
			</tr>
			<tr>
				<td class="ListTableTr11">
					���ʵʩ��λ��
				</td>
				<td class="ListTableTr22" colspan="3">
					<s:property value="workPlanDetail.audit_dept_name"/>
				</td>
			</tr>
			<tr>
				<td class="ListTableTr11">
					����λ��
				</td>
				<td class="ListTableTr22" colspan="3">
					<s:property value="workPlanDetail.audit_object_name" />
				</td>
			</tr>
			<s:if test="workPlanDetail.jjzrr">
				<tr>
					<td class="ListTableTr11">
						���������ˣ�
					</td>
					<td class="ListTableTr22" colspan="3">
						<s:property value="workPlanDetail.jjzrrname"/>
					</td>
				</tr>
			</s:if>
			<s:if test="workPlanDetail.rework">
				<tr>
					<td class="ListTableTr11">
						���������Ŀ��
					</td>
					<td class="ListTableTr22" colspan="3">
						<s:property value="workPlanDetail.reworkProjectNames"/>
					</td>
				</tr>
			</s:if>
			<tr>
				<td class="ListTableTr11">
					Ԥ�ƿ�ʼ���ڣ�
				</td>
				<td class="ListTableTr22">
					<s:property value="workPlanDetail.pro_starttime"/>
				</td>
				<td class="ListTableTr11">
					Ԥ�ƽ������ڣ�
				</td>
				<td class="ListTableTr22">
					<s:property value="workPlanDetail.pro_endtime"/>
				</td>
			</tr>
			<tr>
				<td class="ListTableTr11" nowrap>
					��ƶ������ݿ�ʼ��
				</td>
				<td class="ListTableTr22">
					<s:property value="workPlanDetail.audit_start_time"/>
				</td>
				<td class="ListTableTr11" nowrap>
					��ƶ������ݽ�����
				</td>
				<td class="ListTableTr22">
					<s:property value="workPlanDetail.audit_end_time"/>
				</td>
			</tr>
			<tr>
				<td class="ListTableTr11">
					�������ݣ�
				</td>
				<td class="ListTableTr22" colspan="3">
					<s:textarea name="workPlanDetail.content" readonly="true"
						cssStyle="width:100%;height:20;overflow-y:visible;border:0"/>
				</td>
			</tr>
			<tr>
				<td class="ListTableTr11">
					�����ʽ��
				</td>
				<td class="ListTableTr22" colspan="3">
					<s:textarea name="workPlanDetail.handle_modus" readonly="true"
						cssStyle="width:100%;height:20;overflow-y:visible;border:0"/>
				</td>
			</tr>
			<tr>
				<td class="ListTableTr11">
					���Ŀ�ģ�
				</td>
				<td class="ListTableTr22" colspan="3">
					<s:property value="workPlanDetail.audit_purpose"/>
				</td>
			</tr>
			<tr>
				<td class="ListTableTr11">
					��Ʒ�Χ��
				</td>
				<td class="ListTableTr22" colspan="3">
					<s:property value="workPlanDetail.audit_scope"/>
				</td>
			</tr>
			<tr>
				<td class="ListTableTr11">
					������ݣ�
				</td>
				<td class="ListTableTr22" colspan="3">
					<s:property value="workPlanDetail.audit_basis"/>
				</td>
			</tr>
			<tr>
				<td class="ListTableTr11">
					��ע��
				</td>
				<td class="ListTableTr22" colspan="3">
					<s:property value="workPlanDetail.plan_remark"/>
				</td>
			</tr>
			<tr>
				<td class="ListTableTr11">
					��    ����
				</td>
				<td class="ListTableTr22" colspan="3">
					<div id="accelerys" align="center">
						<s:property escape="false" value="accessoryList" />
					</div>
				</td>
			</tr>
		</table>
  </body>
</html>
