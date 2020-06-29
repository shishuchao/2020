<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML >
<html>
<title>材料价格-添加、编辑、查看</title>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<script type="text/javascript" src="${contextPath}/easyui/boot.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
<script type="text/javascript" src="${contextPath}/pages/tlInteractive/tlInteractiveCommon.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/autosize.js"></script>
<script type="text/javascript">
$(function(){
	var isView = "${view}" == "true" || "${view}" == true ? true : false;
	autoTextarea(isView ?  $('#view_remarks')[0] : $('#mp_remarks')[0]);
	autoTextarea(isView ?  $('#view_priceExplain')[0] : $('#mp_priceExplain')[0]);

    // 按钮权限
    isView ? $('.editElement').remove() : $('.viewElement').remove();

	$('#mpSaveBtn').css('display', isView ? 'none' : '').bind('click', function(){
	   	 aud$saveForm('mpTemplateForm', "${contextPath}/ea/materialsPrice/saveMP.action", function(data){
			 if(data){
				 data.msg ? showMessage1(data.msg) : null;	 
				 if(data.type == 'info'){
					var parentWin = aud$parentDialogWin();
					parentWin ? parentWin.refresh() : null; 
   			 		$('#mpCloseBtn').trigger('click');
				 }
			 }
		 });
	});
	$('#mpCloseBtn').bind('click', function(){
		aud$closeTopDialog();
	});
	
	//处理double金额显示的科学计数法, 并转换成千分位显示
	aud$handleMoneyEFormat("mp",["unitPrice"], true);
});
</script>
<style type="text/css">
input[class~=editElement]{
	width:85% !important;
}
</style>
</head>
<body style='padding:0px;margin:0px;overflow:hidden;' class='easyui-layout' fit='true' border='0'>
	<div region='north' border='0' style='overflow:hidden;'>
		<div style='text-align:right;padding-right:10px;border-bottom:1px solid #cccccc;width:100%;'>
			<a id='mpSaveBtn'   class="easyui-linkbutton" iconCls="icon-save"   style='border-width:0px;'>保存</a>
		    <a id='mpCloseBtn'  class="easyui-linkbutton" iconCls="icon-cancel" style='border-width:0px;'>关闭</a>				
		</div>
	</div>
	<div region="center"  border='0' >
		<form  id='mpTemplateForm' name='mpTemplateForm' method="POST" style='border:0px;'>
			<input type='hidden' id="mp_mid" name="mp.mid"  class="noborder editElement clear" value="${mp.mid}"/>    			
			<table class="ListTable" align="center" style='table-layout:fixed;'>
				<tr>
					<td class="EditHead" style="width:15%;"><font color=red>*</font>材料设备类型</td>
					<td class="editTd" style="width:35%;">
						<input type='text' id='mp_mtype' name='mp.mtype' title='材料设备类型' 
						class="noborder editElement clear required" value="${mp.mtype}"/>
						<span id='view_mtype' class="noborder viewElement clear">${mp.mtype}</span>
					</td>
					<td class="EditHead" style="width:15%;"><font color=red>*</font>材料设备名称</td>
					<td class="editTd" style="width:35%;">
						<input type='text' id='mp_mname' name='mp.mname' title='材料设备名称' 
						class="noborder editElement clear required" value="${mp.mname}"/>
						<span id='view_mname' class="noborder viewElement clear" >${mp.mname}</span>
					</td>
				</tr>
				<tr>
					<td class="EditHead" style="width:15%;">材料品牌</td>
					<td class="editTd" style="width:35%;">
						<input type='text' id='mp_brand' name='mp.brand' 
						class="noborder editElement clear" value="${mp.brand}"/>
						<span id='view_brand' class="noborder viewElement clear" >${mp.brand}</span>
					</td>
					<td class="EditHead" style="width:15%;">材料型号</td>
					<td class="editTd" style="width:35%;">
						<input type='text' id='mp_modelNumber' name='mp.modelNumber' 
						class="noborder editElement clear" value="${mp.modelNumber}"/>
						<span id='view_modelNumber' class="noborder viewElement clear" >${mp.modelNumber}</span>
					</td>
				</tr>
				<tr>
					<td class="EditHead" style="width:15%;">材料规格</td>
					<td class="editTd" style="width:35%;">
						<input type='text' id='mp_standard' name='mp.standard' 
						class="noborder editElement clear" value="${mp.standard}"/>
						<span id='view_standard' class="noborder viewElement clear" >${mp.standard}</span>
					</td>
					<td class="EditHead" style="width:15%;">材料材质</td>
					<td class="editTd" style="width:35%;">
						<input type='text' id='mp_property' name='mp.property' 
						class="noborder editElement clear" value="${mp.property}"/>
						<span id='view_property' class="noborder viewElement clear" >${mp.property}</span>
					</td>
				</tr>
				<tr>
					<td class="EditHead" style="width:15%;">计价单位</td>
					<td class="editTd" style="width:35%;">
						<input type='text' id='mp_chargeUnit' name='mp.chargeUnit'
						 class="noborder editElement clear" value="${mp.chargeUnit}"/>
						<span id='view_chargeUnit' class="noborder viewElement clear" >${mp.chargeUnit}</span>
					</td>
					<td class="EditHead" style="width:15%;">单价</td>
					<td class="editTd" style="width:35%;">
						<input type='text' id='mp_unitPrice' name='mp.unitPrice' 
						class="noborder editElement clear" value="${mp.unitPrice}"/>
						<span id='view_unitPrice' class="noborder viewElement clear" >${mp.unitPrice}</span>
					</td>
				</tr>
				<tr>
					<td class="EditHead" style="width:15%;">单价说明<font color=DarkGray>(限50字)</font></td>
					<td class="editTd" colspan='3'>
						<textarea type='text' id='mp_priceExplain' name='mp.priceExplain'
						 class="noborder editElement clear len50" style='border-width:0px;height:50px;width:99%;overflow:hidden;' >${mp.priceExplain}</textarea>
						<textarea id='view_priceExplain' 
						class="noborder viewElement clear" style='border-width:0px;width:100%; height:50px;overflow:auto;;display:inline;overflow:hidden;' readonly>${mp.priceExplain}</textarea>
					</td>
				</tr>
				<tr>
					<td class="EditHead" style="width:15%;">供应商、代理商</td>
					<td class="editTd" style="width:35%;">
						<input type='text' id='mp_supplier' name='mp.supplier' 
						class="noborder editElement clear" value="${mp.supplier}"/>
						<span id='view_supplier' class="noborder viewElement clear" >${mp.supplier}</span>
					</td>
					<td class="EditHead" style="width:15%;">供应商代理电话</td>
					<td class="editTd" style="width:35%;">
						<input type='text' id='mp_supplierPhone' name='mp.supplierPhone'
						 class="noborder editElement clear" value="${mp.supplierPhone}"/>
						<span id='view_supplierPhone' class="noborder viewElement clear" >${mp.supplierPhone}</span>
					</td>
				</tr>
				<tr>
					<td class="EditHead" style="width:15%;">市调时间</td>
					<td class="editTd" style="width:35%;">
						<div class='editElement'>
							<input type='text' id='mp_surveyTime' name='mp.surveyTime' class="easyui-datebox noborder  clear" 
							editable="false" value="${mp.surveyTime}"/>
						</div>
						<span id='view_surveyTime' class="noborder viewElement clear" >${mp.surveyTime}</span>
					</td>
					<td class="EditHead" style="width:15%;">市调地点</td>
					<td class="editTd" style="width:35%;">
						<input type='text' id='mp_surveyPlace' name='mp.surveyPlace'
						 class="noborder editElement clear" value="${mp.surveyPlace}"/>
						<span id='view_surveyPlace' class="noborder viewElement clear" >${mp.surveyPlace}</span>
					</td>
				</tr>
				<tr>
					<td class="EditHead" style="width:15%;">材料价格来源</td>
					<td class="editTd" style="width:35%;">
						<input type='text' id='mp_priceSource' name='mp.priceSource' 
						class="noborder  editElement clear" value="${mp.priceSource}"/>
						<span id='view_priceSource' class="noborder viewElement clear" >${mp.priceSource}</span>
					</td>
					<td class="EditHead" style="width:15%;">材料价格时间</td>
					<td class="editTd" style="width:35%;">
						<div class='editElement'>
							<input type='text' id='mp_priceTime' name='mp.priceTime' class="easyui-datebox noborder clear" 
							editable="false" value="${mp.priceTime}"/>
						</div>
						<span id='view_priceTime' class="noborder viewElement clear" >${mp.priceTime}</span>
					</td>
				</tr>
				<tr>
					<td class="EditHead" style="width:15%;" >备注<font color=DarkGray>(限200字)</font></td>
					<td class="editTd"  colspan='3'>
						<textarea id='mp_remarks' name='mp.remarks' 
						class="noborder editElement clear len200"
						style='border-width:0px;height:50px;width:99%;overflow:hidden;'>${mp.remarks}</textarea>
						<textarea id='view_remarks' class="noborder viewElement clear"
						style='border-width:0px;width:100%;height:50px; overflow:auto;display:inline;overflow:hidden;' 
						readonly>${mp.remarks}</textarea>
					</td>
				</tr>
				<s:if test="${view == true}">
					<tr>
						<td class="EditHead" style="width:15%;">创建人</td>
						<td class="editTd" style="width:35%;">
							<span id='view_creator' class="noborder viewElement clear" >${mp.creator}</span>
						</td>
						<td class="EditHead" style="width:15%;">创建时间</td>
						<td class="editTd" style="width:35%;">
							<span id='view_createTime' class="noborder viewElement clear" >${mp.createTimeFormat}</span>
						</td>
					</tr>
					<tr>
						<td class="EditHead" style="width:15%;">修改人</td>
						<td class="editTd" style="width:35%;">
							<span id='view_modifier' class="noborder viewElement clear" >${mp.modifier}</span>
						</td>
						<td class="EditHead" style="width:15%;">修改时间</td>
						<td class="editTd" style="width:35%;">
							<span id='view_modifyTime' class="noborder viewElement clear" >${mp.modifyTimeFormat}</span>
						</td>
					<tr>
				</s:if>
			</table>
		</form>
	</div>

	<!-- 引入公共文件 -->
   <jsp:include flush="true" page="/pages/frReportFlow/ajaxloading.jsp" />

</body>
</html>