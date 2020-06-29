<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<head>
<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>	
<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
<script type="text/javascript" src="${contextPath}/scripts/calendar.js"></script>

<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
</head>
<s:if test="id == 0">
	<s:text id="title" name="'添加'"></s:text>
</s:if>
<s:else>
	<s:text id="title" name="'修改'"></s:text>
</s:else>

<html>
	<script language="javascript">       
		$(function(){
			$("#p_group").blur(function(){
				var reg = new RegExp("^[0-9]*$");
				var group_val = $("#p_group").val();
				 if(null==group_val || group_val=='' || !reg.test($("#p_group").val())){
				 	alert("请输入小于20数字！");
				 }					
			});
		});      
		function backList(){
			 window.location.href='${pageContext.request.contextPath}/pages/ledger/custom/list_proledger_custom.jsp'; 
		}		
	
		function saveForm(){
			var zt = jQuery("#customLedger_zt").val();
			var sbt = jQuery("#customLedger_sbt").val();
			if(zt == "" || zt == null) {
				alert("专题不能为空！");
				return;
			}
			if(sbt == "" || sbt == null) {
				alert("上标题不能为空！");
				return;
			}
			var url = "${pageContext.request.contextPath}/proledger/custom/save.action";
			myform.action = url;
			myform.submit();
		}

	</script>

	<script type="text/javascript"
		src="${contextPath}/resources/csswin/common.js"></script>
	<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
	<head>
		<title><s:property value="#title" /></title>
		<s:head />
	</head>
<body class="easyui-layout">
		<center>
			<s:form id="myform" action="save"
				namespace="/ledger/ledgerAnalyseSon">

				<table cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">

					<tr>
						<td class="EditHead">
							<font style="color: red;">*</font>&nbsp;专题
						</td>
						<td class="editTd">
							<s:textfield cssClass="noborder" name="customLedger.p_subject" id="customLedger_zt" cssStyle="width:160px" />
						</td>
						<td class="EditHead">
							组
						</td>
						<td class="editTd">
							<s:textfield cssClass="noborder" id="p_group" name="customLedger.p_group" cssStyle="width:160px" />
						</td>
					</tr>
						<tr>
							<td class="EditHead">
							项目类别
						</td>
						<td class="editTd" colspan="3">
						<s:textfield cssClass="noborder" name="customLedger.name"  id="name" cssStyle="width:760px" />
						<input type="hidden" name="customLedger.code" value="${customLedger.code}"/><img  style="cursor:hand;border:0"
		        src="/ais/resources/images/s_search.gif" 
		    	onclick="showSysTree(this,{
                                  title:'请选择',
                                  checkbox:true,
								  param:{
								  'whereHql':'type=\'1003\'',
								  	'rootParentId':'0',
				                    'beanName':'CodeName',
				                    'plugId':'1003',
				                    'treeId'  :'id',
				                    'treeText':'name',
				                    'treeParentId':'pid',
				                    'treeOrder':'name'
				                  },
                                  defaultDeptId:'${user.fdepid}',
                                  defaultUserId:'${user.floginname}'
								})"></img>
								<font style="color:red;">(公用属性不选择类别)</font>
								</td>
					</tr>
					
					<tr>
						<td class="EditHead">
							<font style="color: red;">*</font>&nbsp; 上标题
						</td>
						<td class="editTd" >
							<s:textfield cssClass="noborder" name="customLedger.p_headtitle" id="customLedger_sbt"
								cssStyle="width:160px" />
						</td>
						<td class="EditHead">
							上标题序列
						</td>
						<td class="editTd" >
							<s:textfield cssClass="noborder" name="customLedger.p_headtitle_order"
								cssStyle="width:160px" />
						</td>
					</tr>
					<tr>
						<td class="EditHead">
							下标题
						</td>
						<td class="editTd" >
							<s:textfield  cssClass="noborder" name="customLedger.p_undertitle"
								cssStyle="width:160px" />
						</td>
						<td class="EditHead">
							下标题序列
						</td>
						<td class="editTd" >
							<s:textfield cssClass="noborder" name="customLedger.p_undertitle_order"
								cssStyle="width:160px" />
						</td>
					</tr>
					<tr>
						<td class="EditHead">
							下标题对应的键值
						</td>
						<td class="editTd" >
							<s:textfield cssClass="noborder" name="customLedger.p_key" cssStyle="width:160px" />
						</td>
						<td class="EditHead">
							下标题对应数据类型
						</td>
						<td class="editTd" >
								
								<select class="easyui-combobox" name="customLedger.p_datatype" style="width:150px;" >
						   			
						   	    <option value="">&nbsp;</option>
						      	 <s:iterator value="#@java.util.LinkedHashMap@{'String':'文本类型','double':'金额类型','date':'日期类型','boolean':'布尔类型','int':'整数类型'}" id="status">
								<s:if test="${customLedger.p_datatype==key}">
						       	 <option selected="selected" value="<s:property value="key"/>"><s:property value="value"/></option>
						       	</s:if>
						       	<s:else>
						         <option value="<s:property value="key"/>"><s:property value="value"/></option>
								</s:else>
								
							      </s:iterator>
						    <select>
						</td>
					</tr>
					
					<tr>
						<td class="EditHead">
							实施阶段
						</td>
						<td class="editTd" >
								<select class="easyui-combobox" name="customLedger.actualize_closed" style="width:150px;" >
						   			
						   	    <option value="">&nbsp;</option>
						      	 <s:iterator value="#@java.util.LinkedHashMap@{0:'否',1:'是'}" id="status">
								<s:if test="${customLedger.actualize_closed==key}">
						       	 <option selected="selected" value="<s:property value="key"/>"><s:property value="value"/></option>
						       	</s:if>
						       	<s:else>
						         <option value="<s:property value="key"/>"><s:property value="value"/></option>
								</s:else>
								
							      </s:iterator>

						    <select>
								
						</td>
						<td class="EditHead">
							终结阶段
						</td>
						<td class="editTd" >
							<select class="easyui-combobox" name="customLedger.report_closed" style="width:150px;" >
						   			
						   	    <option value="">&nbsp;</option>
						      	 <s:iterator value="#@java.util.LinkedHashMap@{0:'否',1:'是'}" id="status">
								<s:if test="${customLedger.report_closed==key}">
						       	 <option selected="selected" value="<s:property value="key"/>"><s:property value="value"/></option>
						       	</s:if>
						       	<s:else>
						         <option value="<s:property value="key"/>"><s:property value="value"/></option>
								</s:else>
								
							      </s:iterator>

						    <select>
						</td>
					</tr>
					<tr>
						<td class="EditHead">
							整改跟踪阶段
						</td>
						<td class="editTd" >
			
								
							<select class="easyui-combobox" name="customLedger.rework_closed" style="width:150px;" >
						   			
						   	    <option value="">&nbsp;</option>
						      	 <s:iterator value="#@java.util.LinkedHashMap@{0:'否',1:'是'}" id="status">
								<s:if test="${customLedger.rework_closed==key}">
						       	 <option selected="selected" value="<s:property value="key"/>"><s:property value="value"/></option>
						       	</s:if>
						       	<s:else>
						         <option value="<s:property value="key"/>"><s:property value="value"/></option>
								</s:else>
								
							      </s:iterator>

						    <select>
						</td>
					</tr>
					<tr>
						<td class="EditHead">
							公式
						</td>
						<td class="editTd"  colspan="4">
							<s:textarea cssClass="noborder" name="customLedger.p_sum" cols="4" rows="5"
								cssStyle="width:100%"></s:textarea>
						</td>
					</tr>
					<tr>
						<td class="EditHead">
							外部数据
						</td>
						<td class="editTd" colspan="4">
							<s:textarea cssClass="noborder" name="customLedger.p_outdata" cols="4" rows="5"
								cssStyle="width:100%"></s:textarea>
						</td>
					</tr><%--
					<tr style="display: none;" id="tr1">
						<td class="ListTableTr11">
							 建设管理机构名称
						</td>
						<td class="ListTableTr22">
							<s:textfield name="customLedger.build_organization_name" id="customLedger_sbt"
								cssStyle="width:160px" />
						</td>
						<td class="ListTableTr11">
							建设项目名称
						</td>
						<td class="ListTableTr22">
							<s:textfield name="customLedger.build_pro_name"
								cssStyle="width:160px" />
						</td>
					</tr>
					<tr id="tr2" style="display: none;">
						<td class="ListTableTr11">
							开工日期
						</td>
						<td class="ListTableTr22">
							<s:textfield id="startProDate" name="customLedger.open_work_date"
							readonly="true" maxlength="15"
							title="单击选择日期" onclick="calendar()"
							theme="ufaud_simple" templateDir="/strutsTemplate"></s:textfield>
						</td>
						<td class="ListTableTr11">
							总投资额
						</td>
						<td class="ListTableTr22">
							<s:textfield cssStyle="width:80%" name="customLedger.invest_sum" maxlength="10"></s:textfield>（万元）
						</td>
					</tr>
					<tr id="tr3" style="display: none;">
						<td class="ListTableTr11">
							至本次审计时已完成的投资金额 
						</td>
						<td class="ListTableTr22">
							<s:textfield cssStyle="width:80%" name="customLedger.now_done_sum" maxlength="10"></s:textfield>（万元）
						</td>
						<td class="ListTableTr11">
							本次审计时间范围内已完成的投资额 
						</td>
						<td class="ListTableTr22">
							<s:textfield cssStyle="width:80%" name="customLedger.now_timeframedone_sum" maxlength="10"></s:textfield>（万元）
						</td>
					</tr>
					
				--%></table>
				<div style="text-align: right; padding-right: 5px;">
					<s:hidden name="customLedger.id" />
				<a class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="saveForm();">保存</a>&nbsp;&nbsp;
				<a class="easyui-linkbutton" data-options="iconCls:'icon-undo'" onclick="backList();">返回</a>
				</div>
			</s:form>
		</center>
	</body>
</html>
