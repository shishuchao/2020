<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="fmt"%>
<s:form id="updateTrackingProblem" cssStyle="text-align: center" >
	<table cellpadding=1 cellspacing=1 border=0 
				class="ListTable" id="updateTrackingProblemTable">
				          <tr>
	       	<td colspan="4" style="font-size: 15px;font-weight: bold;color: #777;height: 16px;line-height: 16px;text-align: left;">
							问题整改要求
				</td>
			</tr>
      		        <tr>
						<td class="EditHead" style="width: 15%">整改期限开始</td>
						<td class="editTd" style="width: 35%">
							 <input type="text" class="easyui-datebox" name="middleLedgerProblem.mend_term" value="${middleLedgerProblem.mend_term }" id="mend_term" editable="false" />
						</td>
						<td class="EditHead" style="width: 15%">整改期限结束</td>
						<td class="editTd" style="width: 35%">
						   <input type="text" name="middleLedgerProblem.mend_term_enddate" class="easyui-datebox" value="${middleLedgerProblem.mend_term_enddate }" id ="mend_term_enddate" editable="false"/>
						</td>
					</tr>
			        <tr>
						<td class="EditHead" style="width: 15%">监督检查人</td>
						<td class="editTd" style="width: 35%">
							<s:property value="middleLedgerProblem.examine_creater_name"/>
						</td>
						<td class="EditHead" style="width: 15%"></td>
						<td class="editTd" style="width: 35%">
						</td>
		    </tr>
		  <s:if test="${sourceSite == 'historyedit' || sourceSite =='historyview' }">
	          <tr>
	       	<td colspan="4" style="font-size: 15px;font-weight: bold;color: #777;height: 16px;line-height: 16px;text-align: left;">
							问题整改结果
				</td>
			</tr>
		<%-- 	<tr>
						<td class="EditHead">
							<label style="color: red;">*</label>
							<c:choose>
								<c:when test="${en eq 'en'}">
									Actions
									<div style="text-align:right;"><label style="color: DarkGray;">(限2000字)</label></div>
								</c:when>
								<c:otherwise>
									整改措施
									<div style="text-align:right;"><label style="color: DarkGray;">(限2000字)</label></div>
								</c:otherwise>
							</c:choose>
						</td>
						<td class="editTd" colspan="3">
						<s:textarea name="middleLedgerProblem.mend_result" id="mend_result" cssClass='noborder editElement required' title="整改措施"
								rows="5" cssStyle="width:100%;overflow-y:visible;line-height:150%;" />
							<input type="hidden" id="middleLedgerProblem.mend_result.maxlength" value="2000"/>
						</td>
					</tr>
					<tr>
						<td class="EditHead">到期未整改原因
							<div style="text-align:right;"><font color=DarkGray>(限2000字)</font></div>
						</td>
						<td class="editTd" colspan="3">
							<s:textarea id="no_rectification_reason" name="middleLedgerProblem.no_rectification_reason" cssClass="noborder"
										cssStyle="width:100%;height:100px;overflow-y:visible;line-height:150%;" title="到期未整改原因"/>
							<input type="hidden" id="middleLedgerProblem.no_rectification_reason.maxlength" value="200"/>
						</td>
					</tr>
					<tr>
						<td class="EditHead" style="width: 15%">
							<c:choose>
								<c:when test="${en eq 'en'}">
									Planed Starting Date
								</c:when>
								<c:otherwise>
									计划整改开始日期
								</c:otherwise>
							</c:choose>
						</td>
						<td class="editTd" style="width: 35%">
							<input type="text" id="planStartDate" name="middleLedgerProblem.planStartDate" value="${middleLedgerProblem.planStartDate }" title="计划整改开始日期"
								   class="easyui-datebox" editable="false" style="width: 160px"/>
						</td>
						<td class="EditHead" style="width: 15%">
							<c:choose>
								<c:when test="${en eq 'en'}">
									Estimated Finishing Date
								</c:when>
								<c:otherwise>
									计划整改结束日期
								</c:otherwise>
							</c:choose>
						</td>
						<td class="editTd" style="width: 35%">
							<input type="text" id="planEndDate" name="middleLedgerProblem.planEndDate" value="${middleLedgerProblem.planEndDate }" title="计划整改结束日期"
								   class="easyui-datebox" editable="false" style="width: 160px"/>
						</td>
					</tr>
					<tr>
						<td class="EditHead">
							<c:choose>
								<c:when test="${en eq 'en'}">
									Actual Starting Date
								</c:when>
								<c:otherwise>
									实际整改开始日期
								</c:otherwise>
							</c:choose>
						</td>
						<td class="editTd">
							<input type="text" id="examine_startdate" name="middleLedgerProblem.examine_startdate" value="${middleLedgerProblem.examine_startdate }"
								class="easyui-datebox" editable="false" style="width: 160px"/>
						</td>
						<td class="EditHead">
							<c:choose>
								<c:when test="${en eq 'en'}">
									Actual Finishing Date
								</c:when>
								<c:otherwise>
									实际整改结束日期
								</c:otherwise>
							</c:choose>
						</td>
						<td class="editTd">
							<input type="text" id="examine_enddate" name="middleLedgerProblem.examine_enddate" value="${middleLedgerProblem.examine_enddate }"
							class="easyui-datebox" editable="false" style="width: 160px"/>
						</td>
					</tr>
					<tr>
						<td class="EditHead">
							<c:choose>
								<c:when test="${en eq 'en'}">
									<label style="color: red;">*</label>Status
								</c:when>
								<c:otherwise>
									<label style="color: red;">*</label>整改状态
								</c:otherwise>
							</c:choose>
						</td>
						<td class="editTd">
							<select id="mend_state_code" class="easyui-combobox editElement required" name="middleLedgerProblem.mend_state_code" editable="false" style="width:160px;" data-options="panelHeight:100">
						       <option value="">&nbsp;</option>
						       <s:iterator value="basicUtil.fllowOpinionList" id="entry">
							         <s:if test="${middleLedgerProblem.mend_state_code==code}">
						       			<option selected="selected" value="<s:property value="code"/>"><s:property value="name"/></option>
						       		 </s:if>
						       		 <s:else>
								        <option value="<s:property value="code"/>"><s:property value="name"/></option>
						       		 </s:else>
						       </s:iterator>
						    </select>	
						</td>
						<td class="EditHead">
							<c:choose>
								<c:when test="${en eq 'en'}">
									Responsible Department
								</c:when>
								<c:otherwise>
									整改责任部门
								</c:otherwise>
							</c:choose>
						</td>
						<td class="editTd">
							<input type="text" class="noborder" name="middleLedgerProblem.mendDept" value="${middleLedgerProblem.mendDept}" maxlength="100"/>
						</td>
					</tr>
					<tr>
						<td class="EditHead" nowrap>
							<c:choose>
								<c:when test="${en eq 'en'}">
									<label style="color: red;">*</label>Updated Policies After Audit(Quantity)
								</c:when>
								<c:otherwise>
									审计完善制度数量（修订数）
								</c:otherwise>
							</c:choose>

						</td>
						<td class="editTd">
							<input type="text" class="noborder naturalNumber editElement" name="middleLedgerProblem.improveRegulation" value="${middleLedgerProblem.improveRegulation}" maxlength="10"/>
						</td>
						<td class="EditHead">
							<c:choose>
								<c:when test="${en eq 'en'}">
									Revise Description
								</c:when>
								<c:otherwise>
									修订制度说明
								</c:otherwise>
							</c:choose>
						</td>
						<td class="editTd">
							<input type="text" class="noborder" name="middleLedgerProblem.impRegulationRemark" value="${middleLedgerProblem.impRegulationRemark}" maxlength="400"/>
						</td>
					</tr>
					<tr>
						<td class="EditHead" nowrap>
							<c:choose>
								<c:when test="${en eq 'en'}">
									<label style="color: red;">*</label>New Policies After Audit(Quantity)
								</c:when>
								<c:otherwise>
									审计完善制度数量（新制定数）
								</c:otherwise>
							</c:choose>
						</td>
						<td class="editTd">
							<input type="text" class="noborder naturalNumber editElement" name="middleLedgerProblem.newRegulation" value="${middleLedgerProblem.newRegulation}" maxlength="10"/>
						</td>
						<td class="EditHead">
							<c:choose>
								<c:when test="${en eq 'en'}">
									Increase Description
								</c:when>
								<c:otherwise>
									新增制度说明
								</c:otherwise>
							</c:choose>
						</td>
						<td class="editTd">
							<input type="text" class="noborder" name="middleLedgerProblem.newRegulationRemark" value="${middleLedgerProblem.newRegulationRemark}" maxlength="400"/>
						</td>
					</tr>
					<tr>
						<td class="EditHead" nowrap>
							<c:choose>
								<c:when test="${en eq 'en'}">
									<label style="color: red;">*</label>Audit Accountability(Economic Punishment)
								</c:when>
								<c:otherwise>
									审计问责处理人次（经济处罚）
								</c:otherwise>
							</c:choose>
						</td>
						<td class="editTd">
							<input type="text" class="noborder naturalNumber editElement" name="middleLedgerProblem.punishPersonEconomic" value="${middleLedgerProblem.punishPersonEconomic}" maxlength="10"/>
						</td>
						<td class="EditHead" nowrap>
							<c:choose>
								<c:when test="${en eq 'en'}">
									<label style="color: red;">*</label>Audit Accountability(Party Discipline And Government Discipline)
								</c:when>
								<c:otherwise>
									审计问责处理人次（党纪政纪处理）
								</c:otherwise>
							</c:choose>
						</td>
						<td class="editTd">
								<input type="text" class="noborder naturalNumber editElement" name="middleLedgerProblem.punishPersonLaw" value="${middleLedgerProblem.punishPersonLaw}" maxlength="10"/>
						</td>
					</tr>
					<tr>
						<td class="EditHead" nowrap>
							<c:choose>
								<c:when test="${en eq 'en'}">
									<label style="color: red;">*</label>Audit Accountability(Transfer To The Judiciary Authoritie)
								</c:when>
								<c:otherwise>
									审计问责处理人次（移送司法机关）
								</c:otherwise>
							</c:choose>
						</td>
						<td class="editTd">
								<input type="text" class="noborder naturalNumber editElement" name="middleLedgerProblem.punishPersonGov" value="${middleLedgerProblem.punishPersonGov}" maxlength="10"/>
						</td>
						<td class="EditHead" nowrap>已纠正违纪违规金额（万元）</td>
						<td class="editTd">
							<s:textfield cssClass="noborder money editElement" name="middleLedgerProblem.yjzwjwgje" value="%{formatMoney(middleLedgerProblem.yjzwjwgje)}"></s:textfield>
						</td>
					</tr>
					<tr>
						<td class="EditHead" nowrap>清退个人不当得利（万元）</td>
						<td class="editTd">
							<s:textfield cssClass="noborder money editElement" name="middleLedgerProblem.qtgrbddl" value="%{formatMoney(middleLedgerProblem.qtgrbddl)}"></s:textfield>
						</td>
						<td class="EditHead" nowrap>补缴各类税款（万元）</td>
						<td class="editTd">
							<s:textfield cssClass="noborder money editElement" name="middleLedgerProblem.bjglsk" value="%{formatMoney(middleLedgerProblem.bjglsk)}"></s:textfield>
						</td>
					</tr>
					<tr id="fujian">
						<td class="EditHead">
							<c:choose>
								<c:when test="${en eq 'en'}">
									Rectification Attachment
								</c:when>
								<c:otherwise>
									整改证据
								</c:otherwise>
							</c:choose>
						</td>
						<td class="editTd" colspan="3">
							<s:hidden id="file_id" name="middleLedgerProblem.file_id" />
							<s:if test="${param.view ne 'view' }">
								<div data-options="fileGuid:'${middleLedgerProblem.auditobj_file_id}'"  class="easyui-fileUpload"></div>
							</s:if>
							<s:else>
								<div data-options="fileGuid:'${middleLedgerProblem.auditobj_file_id}',isAdd:false,isEdit:false,isDel:false"  class="easyui-fileUpload"></div>
							</s:else>
						</td>
					</tr>
					<tr > --%>
					       <tr>
						<td class="EditHead">
							被审单位反馈整改结果
							<div style="text-align:right;"><font color=DarkGray>(限2000字)</font></div>
							<div>	<a class="easyui-linkbutton" iconCls="icon-view" href="javascript:void(0)" onclick="viewHistory()">查看历次反馈</a></div>
						</td>
						<td class="editTd" colspan="3">
						<s:textarea readonly="true" name="middleLedgerProblem.mend_result" id="mend_result" cssClass='noborder' title="被审计单位反馈整改结果"
								rows="5" cssStyle="width:100%;overflow-y:visible;line-height:150%;" />
							<input type="hidden" id="middleLedgerProblem.mend_result.maxlength" value="200"/>
						</td>
					</tr>
					<tr>
						<td class="EditHead" width="15%">
							计划整改开始日期
						</td>
						<td class="editTd"  width="35%">
							<s:property value="middleLedgerProblem.planStartDate" ></s:property>
						</td>
						<td class="EditHead" width="15%">
							计划整改结束日期
						</td>
						<td class="editTd"  width="35%">
							<s:property value="middleLedgerProblem.planEndDate"></s:property>
						</td>
					</tr>
					<tr>
						<td class="EditHead">
							实际整改开始日期
						</td>
						<td class="editTd">
							<s:property value="middleLedgerProblem.examine_startdate"></s:property>
						</td>
						<td class="EditHead">
							实际整改结束日期
						</td>
						<td class="editTd">
							<s:property value="middleLedgerProblem.examine_enddate"></s:property>
						</td>
					</tr>
					<tr>
						<td class="EditHead">
							整改状态
						</td>
						<td class="editTd">
							<select readonly="true" id="mend_state_code" class="easyui-combobox" name="middleLedgerProblem.mend_state_code" editable="false" style="width:160px;" data-options="panelHeight:100">
								<option value="">&nbsp;</option>
						       <s:iterator value="basicUtil.fllowOpinionList" id="entry">
							         <s:if test="${middleLedgerProblem.mend_state_code==code}">
						       			<option selected="selected" value="<s:property value="code"/>"><s:property value="name"/></option>
						       		 </s:if>
						       		 <s:else>
								        <option value="<s:property value="code"/>"><s:property value="name"/></option>
						       		 </s:else>
						       </s:iterator>
						    </select>
						</td>
						<td class="EditHead">
							整改责任部门
						</td>
						<td class="editTd">
							<s:property value="middleLedgerProblem.mendDept"></s:property>
						</td>
					</tr>
						<tr>
						<td class="EditHead" nowrap>
							审计完善制度数量（修订数）
						</td>
						<td class="editTd">
							<s:property value="middleLedgerProblem.improveRegulation"></s:property>
						</td>
						<td class="EditHead">
							修订制度说明
						</td>
						<td class="editTd">
							<s:property value="middleLedgerProblem.impRegulationRemark"></s:property>
						</td>
					</tr>
					<tr>
						<td class="EditHead" nowrap>
								审计完善制度数量（新制定数）
						</td>
						<td class="editTd">
							<s:property value="middleLedgerProblem.newRegulation"></s:property>
						</td>
						<td class="EditHead">
							新增制度说明
						</td>
						<td class="editTd">
							<s:property value="middleLedgerProblem.newRegulationRemark"></s:property>
						</td>
					</tr>
					<tr>
						<td class="EditHead" nowrap>
							审计问责处理人次（经济处罚）
						</td>
						<td class="editTd">
							<s:property value="middleLedgerProblem.punishPersonEconomic"></s:property>
						</td>
						<td class="EditHead" nowrap>
									审计问责处理人次（党纪政纪处理）

						</td>
						<td class="editTd">
							<s:property value="middleLedgerProblem.punishPersonLaw"></s:property>
						</td>
					</tr>
					<tr>
						<td class="EditHead" nowrap>
							审计问责处理人次（移送司法机关）
						</td>
						<td class="editTd">
							<s:property value="middleLedgerProblem.punishPersonGov"></s:property>
						</td>
						<td class="EditHead" nowrap>已纠正违纪违规金额（万元）</td>
						<td class="editTd">
							<fmt:formatNumber pattern="##################.##"  minFractionDigits="2" >${middleLedgerProblem.yjzwjwgje}</fmt:formatNumber>
						</td>
					</tr>
					<tr>
						<td class="EditHead" nowrap>清退个人不当得利（万元）</td>
						<td class="editTd">
							<fmt:formatNumber pattern="##################.##"  minFractionDigits="2" >${middleLedgerProblem.qtgrbddl}</fmt:formatNumber>
						</td>
						<td class="EditHead" nowrap>补缴各类税款（万元）</td>
						<td class="editTd">
							<fmt:formatNumber pattern="##################.##"  minFractionDigits="2" >${middleLedgerProblem.bjglsk}</fmt:formatNumber>
						</td>
					</tr>
					<s:if test="${dueTime}">
						<tr>
							<td class="EditHead">
										到期未整改原因
										<div style="text-align:right;"><label style="color: DarkGray;">(限2000字)</label></div>
							</td>
							<td class="editTd" colspan="3">
								<s:textarea  id="no_rectification_reason" name="middleLedgerProblem.no_rectification_reason" cssClass="noborder"
								cssStyle="width:100%;height:100px;overflow-y:visible;line-height:150%;" title="到期未整改原因"/>
								<input type="hidden" id="middleLedgerProblem.no_rectification_reason.maxlength" value="200"/>
							</td>
						</tr>
					</s:if>
					<tr id="fujian">
						<td class="EditHead">
						整改证据
						<s:hidden id="auditobj_file_id" name="middleLedgerProblem.auditobj_file_id" />
						<s:hidden id="file_id" name="middleLedgerProblem.file_id" />
						</td>
						<td class="editTd" colspan="3">
							<div data-options="fileGuid:'${middleLedgerProblem.auditobj_file_id}',isAdd:false,isEdit:false,isDel:false"  class="easyui-fileUpload"></div>
						</td>
					</tr>
							<tr >

			<td colspan="4" style="font-size: 15px;font-weight: bold;color: #777;height: 16px;line-height: 16px;text-align: left;">
			问题整改结果评价
							
				</td>
			
	       	</tr>
					<tr>
						<td class="EditHead">审计单位跟踪检查结果
						</td>
						<td class="editTd" colspan="3">
						<s:textarea name="middleLedgerProblem.examine_result" id="examine_result" cssClass='noborder' title="审计单位跟踪检查结果"
								rows="5" cssStyle="width:100%;overflow-y:visible;line-height:150%;"/>
							<input type="hidden" id="middleLedgerProblem.examine_result.maxlength" value="200"/>
						</td>
					</tr>
					<tr>
						<td class="EditHead"><font color="red">*</font>整改状态评价</td>
						<td class="editTd" colspan="3">
							<select id="f_mend_opinion_code" class="easyui-combobox" name="middleLedgerProblem.f_mend_opinion_code" editable="false" style="width:160px;" data-options="panelHeight:100">
						       <option value="">&nbsp;</option>
						       <s:iterator value="basicUtil.fllowOpinionList" id="entry">
							         <s:if test="${middleLedgerProblem.f_mend_opinion_code==code}">
						       			<option selected="selected" value="<s:property value="code"/>"><s:property value="name"/></option>
						       		 </s:if>
						       		 <s:else>
								        <option value="<s:property value="code"/>"><s:property value="name"/></option>
						       		 </s:else>
						       </s:iterator>
						    </select>
						    <s:hidden name="projectStartObject.supervisor_name" />
						    <s:hidden id="f_mend_opinion_name" name="middleLedgerProblem.f_mend_opinion_name"></s:hidden>
						</td>

					</tr>
					<tr>
						<td class="EditHead">跟踪检查人</td>
						<td class="editTd">
							<s:textfield id="tracker_name" name="middleLedgerProblem.tracker_name" readonly="true" cssClass="noborder"/>
							<s:hidden name="middleLedgerProblem.tracker_code" />
						</td>
						<td class="EditHead">跟踪检查时间</td>
						<td class="editTd">
							<s:textfield id="tracker_examine_date" name="middleLedgerProblem.tracker_examine_date" readonly="true" cssClass="noborder"/>
						</td>
					</tr>
					<tr>
						<td class="EditHead">增收节支类型</td>
						<td class="editTd">
							<select id="increase_type_code" class="easyui-combobox" name="middleLedgerProblem.increase_type_code" editable="false" style="width:160px;" data-options="panelHeight:100">
								<option value="">&nbsp;</option>
								<s:iterator value="basicUtil.increaseTypeList" id="entry">
									<s:if test="${middleLedgerProblem.increase_type_code==code}">
										<option selected="selected" value="<s:property value="code"/>"><s:property value="name"/></option>
									</s:if>
									<s:else>
										<option value="<s:property value="code"/>"><s:property value="name"/></option>
									</s:else>
								</s:iterator>
							</select>
							<s:hidden id="increase_type" name="middleLedgerProblem.increase_type"></s:hidden>
						</td>
						<td class="EditHead">增收节支金额（万元）</td>
						<td class="editTd">
							<s:textfield cssClass="noborder money editElement" name="middleLedgerProblem.increase_money" value="%{formatMoney(middleLedgerProblem.increase_money)}"></s:textfield>
						</td>
					</tr>
					<tr>
						<td class="EditHead">损失浪费类型</td>
						<td class="editTd">
							<select id="loss_type_code" class="easyui-combobox" name="middleLedgerProblem.loss_type_code" editable="false" style="width:160px;" data-options="panelHeight:100">
								<option value="">&nbsp;</option>
								<s:iterator value="basicUtil.lossTypeList" id="entry">
									<s:if test="${middleLedgerProblem.loss_type_code==code}">
										<option selected="selected" value="<s:property value="code"/>"><s:property value="name"/></option>
									</s:if>
									<s:else>
										<option value="<s:property value="code"/>"><s:property value="name"/></option>
									</s:else>
								</s:iterator>
							</select>
							<s:hidden id="loss_type" name="middleLedgerProblem.loss_type"></s:hidden>
						</td>
						<td class="EditHead">损失浪费金额（万元）</td>
						<td class="editTd">
							<s:textfield cssClass="noborder money editElement" name="middleLedgerProblem.loss_money" value="%{formatMoney(middleLedgerProblem.loss_money)}"></s:textfield>
						</td>
					</tr>
					<s:if test="interaction==null || interaction==''">
					<tr id="fujian">
						<td class="EditHead">
						附件
						<s:hidden id="f_mend_accessory" name="middleLedgerProblem.f_mend_accessory" />
						<s:hidden id="file_id" name="middleLedgerProblem.file_id" />
					</td>
					<td class="editTd" colspan="3">
						<div data-options="fileGuid:'${middleLedgerProblem.f_mend_accessory}'"  class="easyui-fileUpload"></div>
					</td>
					</tr>
					</s:if>    
			 <!--    </table>
			</div> -->
      </s:if> 
	</table>
		<div id="viewHistory"  title='历史反馈' style='width:100%;overflow: hidden;' >
	  			<iframe id="upload"  frameborder="0" scrolling="hidden" style="width:100%;height:100%;" src="" ></iframe>
	  		</div>
	</s:form>
	
			<script type="text/javascript">
			$(function(){
				$("#updateTrackingProblemTable").find("textarea").each(function(){
					autoTextarea(this);
				});
				$('#viewHistory').window({
					width: $('body').width()*0.95< 800 ? 800 : $('body').width()*0.95,
					height:450,
					top:$('body').height()*0.5< 500 ? 500 : $('body').height()*0.5,
					modal: true,
					shadow: true,
					closed: true,
					collapsible:false,
					maximizable:false,
					minimizable:false
				});
			});
			function viewHistory(){

				var middleLedgerProblem_id = "${middleLedgerProblem.id}";
				var trackUrl = "";
				trackUrl ="/ais/proledger/problem/feedbackListForAuditObject.action?view=view&middleLedgerProblem_id="+middleLedgerProblem_id;
				$('#upload').attr("src",trackUrl);
	            $('#viewHistory').window('open');
			}
		</script>
