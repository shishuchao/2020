<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML >
<html>
<title>样本参照列表</title>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<script type="text/javascript" src="${contextPath}/easyui/boot.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/jquery-fileUpload.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/autosize.js"></script>
<script type="text/javascript" src="${contextPath}/easyui/contextmenu.js"></script>  
<script type="text/javascript" src="${contextPath}/pages/tlInteractive/tlInteractiveCommon.js"></script>
<script type="text/javascript">
$(function(){
	var isView = "${view}";
	autoTextarea($('#ts_remarks')[0]);
	
	if(isView){
		$('body').layout('collapse', 'west');
		$('#uploadPhoto').remove();
		$('#saveSample').parent().remove();
	}
	
	function setPic(isShow){		
		if(isShow || "${isHavePic}"){
			$('#picMsg').hide();
			var readPicSrc = "${contextPath}/intctet/sysManage/testSample/readTestPic.action?guid=${ts.attachmentId}";
			$('#picShow').append("<img borer='0' width='100%' height='100%' src='"+readPicSrc+"'></img>");
		}else{
			$('#picMsg').show();
			$('#picShow').empty();
		}
	}
	
	setPic();
	
	$('#photoDiv').fileUpload({
    	fileGuid:"${ts.attachmentId}",
    	triggerId:"uploadPhoto",
    	multiple:false,
    	uploadFace:1,
    	echoType:2,
    	isAdd:!isView,
    	isEdit:!isView,
    	isDel:!isView,
    	onDeleteFileSuccess:function(data, fileIdList, options){
    		if(data){   			
				$.ajax({
					url:"${contextPath}/commonPlug/deleteBeans.action",
					dataType:'json',
					type: "post",
					data: {
						"beanName":"TestSample",
						"query_eq_sampleId":"${ts.sampleId}"
					},
					success: function(data){
						data.msg ? showMessage1(data.msg) : null;
						window.location.reload();
					},
					error:function(data){
						top.$.messager.show({title:'提示信息',msg:'请求失败！请检查网络配置或者与管理员联系！'});
					}
				});
    		}
    	},
    	onFileSubmitSuccess:function(data, options){
    		setPic(true);
    	}
	});	
	
	$('#saveSample').bind('click', function(){
		saveSample();
	});
	function saveSample(){
		if($('#photoDiv').children().length == 0){
			top.$.messager.alert("提示信息", "请选择要上传的测试样本量参照表图片", "warning", function(){
				$('#uploadPhoto').trigger('click');
			});
		}else{			
			aud$saveForm('sampleForm', "${contextPath}/intctet/sysManage/testSample/saveSample.action", function(data){
				if(data){
					data.msg ? showMessage1(data.msg) : null;
				}
			});
		}
	}
});
</script>
</head>
<body style='padding:0px;margin:0px;overflow:hidden;'  border='0' fit='true' class='easyui-layout'>
	<div region='west'  style='padding:0px;margin:0px;width:400px;overflow:hidden;' title='测试样本量参照表' split="true">
		<div style='padding:5px 10px 5px 5px;height:30px;text-align:right;border-bottom:1px solid #cccccc;'>
			<button id="saveSample" class="easyui-linkbutton" data-options="iconCls:'icon-save'">保存</button>
		</div>
		<div style="overflow:auto;">
			<form id="sampleForm" name="sampleForm">
				<input type='hidden' id="ts_sampleId"     name="ts.sampleId" value="${ts.sampleId}" class="noborder editElement clear" />
				<input type='hidden' id='ts_attachmentId' name='ts.attachmentId' value="${ts.attachmentId }" class="noborder editElement"/>
				<table class="ListTable" align="center" style='table-layout:fixed;'>
					<tr>
						<td class="EditHead" style="width:10%;text-align:center;">图片上传</td>
						<td class="editTd" style="width:40%;">
							<div style="float:left;width:60%;"><a id="photoDiv"></a></div>
						</td>
					</tr>
					<tr>
						<td class="EditHead" style="width:10%;text-align:center;">备注</td>
						<td class="editTd" style="width:40%;">
							<textarea id='ts_remarks' name='ts.remarks' class="noborder editElement clear"
							 style='border-width:0px;height:250px;width:99%;'>${ts.remarks}</textarea>
						</td>
					</tr>
				</table>
			</form>
		</div>
	</div>
	<div region='center' title='图片预览' style='padding:0px;margin:0px;text-align:center;'>
		<div id="picMsg" style="padding:10px;margin:10px;width:90%;height:50px;line-height:40px;border:1px solid #cccccc;">
			<div id="uploadPhoto" style="text-align:center;float:right;"></div>
			<div style="color:red;"><strong>提示：【测试样本量参照表】图片还未添加！</strong></div>
		</div>
		<div id="picShow"></div>
	</div>
   <jsp:include flush="true" page="/pages/frReportFlow/ajaxloading.jsp" />
</body>
</html>