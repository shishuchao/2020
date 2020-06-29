<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<!DOCTYPE HTML >
<html>
<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<title></title>
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
	<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
	<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
	<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
	<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
	<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
	<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
	<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>

	<script language="javascript">       
		$(function(){
			$("#p_group").blur(function(){
				var reg = new RegExp("^[0-9]*$");
				var group_val = $("#p_group").val();
				 if(null==group_val || group_val=='' || !reg.test($("#p_group").val())){
				 	showMessage1("请输入小于20数字！");
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
				showMessage1("专题不能为空！");
				return;
			}
			if(sbt == "" || sbt == null) {
				showMessage1("上标题不能为空！");
				return;
			}
			
			if(!$('#cusPkey').val()) {
				showMessage1("下标题对应的键值   不能为空！");
				return;
			}
			var url = "${pageContext.request.contextPath}/proledger/custom/save.action";
			myform.action = url;
			myform.submit();
			showMessage1('保存成功！');
		}

	</script>
	<s:if test="id == 0">
		<s:text id="title" name="'添加台账定义'"></s:text>
	</s:if>
	<s:else>
		<s:text id="title" name="'编辑台账定义'"></s:text>
	</s:else>	
	</head>
	<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout">
		<div region="center">
			<table cellpadding=0 cellspacing=1 border=0 bgcolor=""
				class="ListTable" width="100%" align="center">
				<tr class="">
					<td colspan="5" align="left" class="topTd">
						&nbsp;
						<s:property value="#title" />
					</td>
				</tr>
			</table>
			<s:form id="myform" action="save" namespace="/ledger/ledgerAnalyseSon">
				<table cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
					<tr>
						<td class="EditHead" style="width:15%">
							<font style="color: red;">*</font>&nbsp;专题
						</td>
						<td class="editTd" style="width:35%">
							<s:textfield cssClass="noborder" name="customLedger.p_subject" id="customLedger_zt" cssStyle="width:160px" />
						</td>
						<td class="EditHead" style="width:15%">
							组
						</td>
						<td class="editTd" style="width:35%">
							<s:textfield cssClass="noborder" id="p_group" name="customLedger.p_group" cssStyle="width:160px" maxlength="20"/>
						</td>
					</tr>
						<tr>
							<td class="EditHead">
							项目类别
						</td>
						<td class="editTd" colspan="3">
							<s:textfield cssClass="noborder" name="customLedger.name"  id="name" cssStyle="width:720px" readonly="true"/>
 							<img style="cursor:pointer;border:0" src="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png"
 							onclick="getItem('/ais/pages/basic/code_name_tree_cascade.jsp','&nbsp;请选择项目类别',500,400)"/>
 							<input type="hidden" id="code" name="customLedger.code" value="<s:property value='customLedger.code'/>">
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
							<font style="color: red;">*</font>下标题对应的键值
						</td>
						<td class="editTd" >
							<s:textfield cssClass="noborder" name="customLedger.p_key"  id="cusPkey" cssStyle="width:160px" />
						</td>
						<td class="EditHead">
							下标题对应数据类型
						</td>
						<td class="editTd" >
								
								<select class="easyui-combobox" name="customLedger.p_datatype" editable="false" style="width:150px;" >
						   			
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
								<select editable="false" class="easyui-combobox" name="customLedger.actualize_closed" style="width:150px;" >
						   			
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
							<select editable="false" class="easyui-combobox" name="customLedger.report_closed" style="width:150px;" >
						   			
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
						<td class="editTd" colspan="3" >
			
								
							<select editable="false" class="easyui-combobox" name="customLedger.rework_closed" style="width:150px;" >
						   			
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
							显示
						</td>
						<td class="editTd" >
							<select editable="false"  panelHeight="auto"  class="easyui-combobox" name="customLedger.ledger_display" style="width:150px;" >
						      	<s:iterator value="#@java.util.LinkedHashMap@{1:'是',0:'否'}" id="status">
									<s:if test="${customLedger.ledger_display==key}">
							       		<option selected="selected" value="<s:property value="key"/>"><s:property value="value"/></option>
							       	</s:if>
							       	<s:else>
							        	<option value="<s:property value="key"/>"><s:property value="value"/></option>
									</s:else>
							    </s:iterator>
						    </select>
						</td>
						<td class="EditHead">
							导出
						</td>
						<td class="editTd" >
							<select editable="false" panelHeight="auto" class="easyui-combobox" name="customLedger.ledger_export" style="width:150px;" >
						      	<s:iterator value="#@java.util.LinkedHashMap@{1:'是',0:'否'}" id="status">
									<s:if test="${customLedger.ledger_export==key}">
							       		<option selected="selected" value="<s:property value="key"/>"><s:property value="value"/></option>
							       	</s:if>
							       	<s:else>
							        	<option value="<s:property value="key"/>"><s:property value="value"/></option>
									</s:else>
							    </s:iterator>
						    </select>
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
					</tr>
				</table>
				<div style="text-align: right; padding-right: 5px;">
					<s:hidden name="customLedger.id" />
					<a class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="saveForm();">保存</a>&nbsp;&nbsp;
					<a class="easyui-linkbutton" data-options="iconCls:'icon-undo'" onclick="backList();">返回</a>
				</div>
				<div id="subwindow" class="easyui-window" title="项目类别" iconCls="icon-search" style="width:500px;height:500px;padding:5px;" closed="true">
					<div class="easyui-layout" fit="true">
						<div region="center" border="false" style="padding:10px;background:#fff;border:1px solid #ccc;">
							<iframe id="item_ifr" name="item_ifr" src="" frameborder="0" width="100%" height="100%" scrolling="auto" ></iframe>
						</div>
						<div region="south" border="false" style="text-align:right;padding:5px 0;">
						    <div align="left">
							    <a class="easyui-linkbutton" iconCls="icon-add" href="javascript:void(0)" onclick="selectAllF(true)">全选</a>
								<a class="easyui-linkbutton" iconCls="icon-redo" href="javascript:void(0)" onclick="selectAllF(false)">全不选</a>
						    </div>
						    <div style="display: inline;" align="right">
								<a class="easyui-linkbutton" iconCls="icon-save" href="javascript:void(0)" onclick="saveF()">确定</a>
								<a class="easyui-linkbutton" iconCls="icon-remove" href="javascript:void(0)" onclick="cleanF()">清空</a>
								<a class="easyui-linkbutton" iconCls="icon-cancel" href="javascript:void(0)" onclick="closeWin()">关闭</a>
						    </div>
						</div>
					</div>
				</div>
			</s:form>
		</div>
		<script type="text/javascript">
			function getItem(url,title,width,height){
				if($('#item_ifr').attr('src') == ''){
					$('#item_ifr').attr('src',url);
				}
				$('#subwindow').window({
					title: title,
					width: width,
					height:height,
					modal: true,
					shadow: true,
					closed: false,
					collapsible:false,
					maximizable:false,
					minimizable:false
				});
			}
			function saveF(){
				var ayy = $('#item_ifr')[0].contentWindow.saveF();
				document.all('code').value=ayy[0];
	    		document.all('name').value=ayy[1];
	    		closeWin();
			}
			function cleanF(){
				document.all('customLedger.code').value='';
 	    		document.all('customLedger.name').value='';
	    		closeWin();
			}
			function closeWin(){
				$('#subwindow').window('close');
			}
			function selectAllF(boo){
				$('#item_ifr')[0].contentWindow.selectAllF(boo); 
			}
		</script>
	</body>
</html>
