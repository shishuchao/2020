<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE HTML>
<html>
	<head>
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>		
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<title>自定义台账</title>
	<style type="text/css">
		.EditHead{
			padding-top:17px;
			padding-right:30px;
			padding-bottom:17px;
			padding-left:30px;
			background:#e6e6e6;
		}
		.editTd{
			padding-right:6px;
			padding-bottom:3px;
			padding-left:6px;
		}
		.textBorder{
			text-indent:15px;
			padding-top:15px;
			padding-bottom:12px;
			border-top-style: none;
			border-left-style: none;
			border-right-style: none;
			width: 150px;
		}
	</style>
	<script type="text/javascript">
		function sucFun(){
    		if($("#sucFlag").val()=='1'){
    			$("#sucFlag").val('');
    			//alert('保存成功！');
    			showMessage1('保存成功！');
    		}        		
   		}
		function JHshNumberText(){
			/* if ( !(((window.event.keyCode >= 48) && (window.event.keyCode <= 57)) 
			|| (window.event.keyCode == 13) || (window.event.keyCode == 46) 
			|| (window.event.keyCode == 45))){
				window.event.keyCode = 0 ;
				showMessage1('只能输入数字！');
			} */
		} 
		
		function validate(key,name){
			var value=document.getElementsByName("ledger_"+key)[0].value;
			if(name.indexOf('万元') != -1) {
				if(!isMoneyNum(value)){
					alert(name+" 输入错误！");
					document.getElementsByName("ledger_"+key)[0].value='';
					document.getElementsByName("ledger_"+key)[0].focus();
					return false;
				}
			} else {
				if(!isPositiveInteger(value)) {
					alert(name+" 输入错误！");
					document.getElementsByName("ledger_"+key)[0].value='';
					document.getElementsByName("ledger_"+key)[0].focus();
					return false;
				}
			}
		}
		function hideBut(){
			var flag="<%=request.getParameter("pstatus")%>"
			if(flag=="audit_ok"){
				document.getElementById("buttonSave").style.display="none";
			}
		}
		function isMoneyNum(str){
			return (new RegExp(/^\d+(?=\.{0,1}\d+$|$)/).test(str));
        }
		function isPositiveInteger(str){
			return (new RegExp(/^([1-9]\d*|[0]{1,1})$/).test(str));
		}
		function backList(){
			var url = "${pageContext.request.contextPath}/ledger/prjledger/projectLedgerNew/createLedgerExcel.action";
			myform.action = url;
			myform.submit();
		}
		function toSave() {
			if(isNotNull()) {
				$('#myform').form('submit', {
					url:"${pageContext.request.contextPath}/ledger/customledger/save.action",
	            	success:function(data){
					    if(data == '1'){
	                        showMessage1('保存成功！');
	                    }
	            	}
	        	});
			} else {
				showMessage1('保存不成功，台账字段不能为空！');
			}
		}
		
		function isNotNull() {
			var flag = true;
			// var fields = $(":input").serializeArray();
			// $.each(fields, function(i, field){
			// 	if(field.value == '' && field.name.indexOf('ledger_') != -1) {
			// 		flag = false;
			// 	}
			// });
			return flag;
		}
		
		function backList1(){
			window.history.go(-1);

		}
	</script>
	<s:property value="javaScript" escape="false" />
	</head>
	<body onload="hideBut();sucFun();">
		<s:form id="myform" name="form" action="save"
			namespace="/ledger/customledger">
			<div>
				<s:if test="${isView ne 'true' }">
				<% 
					String view = request.getParameter("view");
					if(!"view".equals(view)){
						
				%>
					<a id="btn" href="javascript:void(0);" class="easyui-linkbutton" onclick="toSave();" data-options="iconCls:'icon-save'">保存台帐</a>
				<% }%>
				</s:if>
				<a id="btn" href="javascript:void(0);" class="easyui-linkbutton" onclick="backList();" data-options="iconCls:'icon-export'">导出</a>
				<!--  
				<a id="btn" href="javascript:void(0);" class="easyui-linkbutton" onclick="backList1();" data-options="iconCls:'icon-undo'">返回</a>
	            -->		
			</div>
			<s:hidden name="project_id" />
			<input type="hidden" name="sucFlag" id="sucFlag" value="${tip}"/>
			<s:hidden name="p_subject" id="p_subject" />
			<s:property value="str" escape="false" />
		</s:form>
	</body>
</html>