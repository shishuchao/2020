<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE HTML >
<html>
<title>审计结论</title>
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
	var isView = "${view}" == "true" || "${view}" == true ? true : false;
	isView ? $('#conTools').remove() : "";
	var apStatusCode = "${apStatusCode}";
	var apId= "${apId}";
	var clsAttachId = "${clsAttachId}";

	var parentTabId = "${parentTabId}";
	if(parentTabId!=''){
		$("#parentTabId").val(parentTabId);
		var curTabIdac = aud$getActiveTabId();//当前台账选项卡的id
	}	
	
	var adviceUrl = '${contextPath}/ea/audAccount/adviceList.action';
	var editUrl = '${contextPath}/ea/audAccount/editAccount.action';
	var tabTitle = isView ? "查看" : "编辑";
	var fileContainer = isView ? 'view_attachFile' : 'edit_attachFile';

	
	
	//审计报告文件
	var reportFileGuid = $('#guid').val();
    $('#ReportFile').fileUpload({
    	fileGuid:reportFileGuid,
    	isDel:false,
    	isEdit:"${conclusionState}" == '0' ? true : false,
    	isAdd:false,
    	uploadFace:1,
    	echoType:2,
    	onFileSubmitSuccess:function(data){
    		
    	}
	});	
    //创建审计报告
	$('#createBtn').bind('click',function(){		
		// 初始化生成表格
		$('#templateList').datagrid({
			url : "<%=request.getContextPath()%>/unitary/nc/autoreport/reportTemplateList.action?template.projectTypeCode=${code}&crudId=${apId}&fromType=report",
			method:'post',
			showFooter:false,
			rownumbers:true,
			striped:true,
			autoRowHeight:false,
			fit: true,
			fitColumns:true,
			idField:'id',
			border:false,
			singleSelect:true,
			remoteSort: false,
			columns:[[
				{field:'name',
					title:'模板名称',
					width:200,
					halign:'center',
					align:'left',
					sortable:true
				},
				{field:'operate',
					title:'操作',
					width:100,
					align:'center',
					formatter:function(value,row,index){
						var link = '<a href=\"javascript:void(0);\" onclick=\"createReportFile(\''+row.templateId+'\');\">创建报告</a>';
						return link;
					}
				}
			]]
		});

		$('#templateWindow').window({
			title:'审计结论模板选择',
			width:600,
			height:400,
			modal:true,
			collapsible:false,
			maximizable:true,
			minimizable:false
		});
	});
	//审批
	$('#approveBtn').bind('click',function(){
		new aud$createTopDialog({
			title:'审计结论审批',
			width:800,
			height:450,
			zIndex:9011,
			url:'${contextPath}/ea/audAccount/spAccount.action?fromtodo=${fromtodo}&oldSaid=${oldSaid}&apId='+apId+'&parentTabId='+curTabIdac+'&type=audConclusion',
			onClose:function(){},
			onOpen:function(){}
		}).open();
	});
	
    //把frame页面窗口ID赋给里面iframe，用于iframe里面的页面打开新窗口后，访问iframe
	setTimeout(function(){
		var topDialogTargetId = parent.aud$getActiveDialogTargetId();
		$('body').attr("topDialogTargetId", topDialogTargetId);
	},0)
    
    
	var gridTableId = "mTable";
    var g1 = new createQDatagrid({
        // 表格dom对象，必填
        gridObject:$('#'+gridTableId)[0],
        // 要进行检索的表对象(hibernate bean)名称， 进行拼接hql时使用; 必填
        boName:'SpAccount',
        // 对象主键,删除数据时使用-默认为“id”；必填
        pkName:'said',
        order :'desc',
        sort  :'doTime',
	    whereSql:"type='audConclusion' and apId='${apId}'",
	    myToolbar:['export', 'reload'],
        // 表格控件dataGrid配置参数; 必填
        gridJson:{	
        	singleSelect:true,
        	checkOnSelect:false,
        	selectOnCheck:false,
    		columns:[[
    			{field:'state',title:'状态', width:'90px',align:'center',   halign:'center',  sortable:true, show:'false',
					formatter:function(value){
						//0-待处理，1-已审批, 2-已完成
						var rtval = "";
						if(value == "0"){
							rtval = "待处理";
						}else if(value == "1"){
							rtval = "已处理";
						}else if(value == "2"){
							rtval = "<font color='green'>已完成</font>";
						}
						return rtval;
					}
    			},
                {field:'currentUser',title:'处理人', width:'100px',align:'center',   halign:'center',  sortable:true},
                {field:'deptName',   title:'处理人所在部门', width:'15%',align:'center',   halign:'center',  sortable:true},
                {field:'spcontent',  title:'处理意见', width:'25%',align:'center', halign:'center',  sortable:true},
                {field:'doTime',     title:'处理时间', width:'180px',align:'center',   halign:'center',  sortable:true},
                {field:'nextPeople', title:'下一步处理人', width:'100px',align:'center',   halign:'center',  sortable:true}
			]]
        }
    });
	window.conInfoList = g1;
    
    
	setTimeout(function(){
		var isFromtodo = "${fromtodo}" == "true" || "${fromtodo}" == true;
		//alert('isFromtodo='+isFromtodo)
		if(isFromtodo){
			$('#approveBtn').show();
		}else{		
			var conclusionState = "${conclusionState}";
			//alert('conclusionState='+conclusionState)
			if(conclusionState == '1' || conclusionState == '2'){
				$('#createBtn,#approveBtn').remove();
			}else{
				$('#createBtn,#approveBtn').show();
				if(!"${reportFile.fileTime}"){
					$('#approveBtn').hide();
				}else{
					$('#createBtn').hide();
				}	
			}
		}
		$('body, #conlayout').layout('resize');
	},0);
	
	// 审计结论附件 - 附件上传初始化
    $('#'+fileContainer).fileUpload({
    	//fileGridTitle:'审计结论列表',
    	fileGuid:clsAttachId,
        isAdd:!isView,
        isEdit:!isView,
        isDel:!isView,
        isView:true,
        isDownload:true,
        isdebug:false,
        collapseList:true,
        callbackGridHeight:170,
        multiple:false,
        //单次上传的最大文件数
        maxFileCount:1,
        //上传文件文件总数（包括已上传的）
        totalFileCount:1
    });
});
/*
 * 创建审计报告
 */
function createReportFile(templateId){
	top.$.messager.confirm('确认对话框','确定要使用此模板创建报告吗？之前创建的报告内容将全部丢失!',function(r){
		if(r){
			var h = window.screen.availHeight;
			var w = window.screen.width;
			window.showModalDialog("${contextPath}/ea/audAccount/createReportFile.action?templateId="+templateId+"&apId=${apId}&apName=${apName}",window,'dialogWidth:'+w+'px;dialogHeight:'+h+'px;status:no;resizable:yes;minimize:yes;maximize:yes;');
		}
	});		
}	
</script>
</head>
<body style='padding:0px;margin:0px;overflow:hidden;' id='dvlayout' class='easyui-layout' border='0' fit='true' >
	<input type="hidden" id="parentTabId"   name="parentTabId"/>
	<div id="templateWindow">
		<table id="templateList"></table>
	</div>
	<div region='center' border='0' >
		<div id="conlayout" class="easyui-layout" border="0" fit="true" style='padding:0px;margin:0px;overflow:hidden;'>
			<div region="center" border="0" title="审计结论" style='padding:0px;margin:0px;overflow:hidden;'>
				<div style="background:#eee;text-align:right;position:absolute;top:0px;right:2px;" id="conTools">
					<span id='createBtn'   class="easyui-linkbutton" data-options="iconCls:'icon-add'" style="display:none;">创建</span>
					<span id='approveBtn'  class="easyui-linkbutton" data-options="iconCls:'icon-ok'"  style="display:none;">审批</span>
				</div>	
				<table id="conInfoTable" class="easyui-datagrid" style="height:130px;width:100%" 
					data-options="fit:true,fitColumns:true,nowrap:false,striped:true,border:0">
					<thead>
						<tr>
							<th data-options="field:'operate',width:'40%',halign:'center',align:'center'">文件名称</th>
							<th data-options="field:'createDate',width:'120px',halign:'center',align:'center'">创建日期</th>
							<th data-options="field:'creator',width:'80px',halign:'center',align:'center'">创建人</th>
							<th data-options="field:'updated',width:'120px',halign:'center',align:'center'">最后编辑日期</th>
							<th data-options="field:'updator',width:'80px',halign:'center',align:'center'">最后编辑人</th>
						</tr>
					</thead>
					<tbody>
						<td>
							<input type="hidden" id="guid" name="reportFile.guid" value="${reportFile.guid}"/>
							<div id="ReportFile"></div>
						</td>
						<td><s:property value="reportFile.fileTime" /></td>
						<td><s:property value="reportFile.uploader_name" /></td>
						<td><s:property value="reportFile.fileEditTime" /></td>
						<td><s:property value="reportFile.remark_name" /></td>
					</tbody>
				</table>							
			</div>
			<div region="south" border="0"  title="审批信息" split="true" style='padding:0px;margin:0px;overflow:hidden;height:200px;'>
				<table id="mTable" ></table>
			</div>
		</div>	
	</div>
	<div region="south" style="overflow:hidden;" border='0' title="">
	    <div id="edit_attachFile" class=" editElement "></div>
	    <div id="view_attachFile" class=" viewElement "></div>
	</div>	
	<!-- 引入公共文件 -->
    <jsp:include flush="true" page="/pages/frReportFlow/ajaxloading.jsp" />
</body>
</html>