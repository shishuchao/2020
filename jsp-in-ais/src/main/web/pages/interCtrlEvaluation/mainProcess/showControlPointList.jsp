<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML >
<html>
<title>内控评价-控制点</title>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<script type="text/javascript" src="${contextPath}/easyui/boot.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/jquery-fileUpload.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/jquery-parseExcel.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/autosize.js"></script>
<script type="text/javascript" src="${contextPath}/pages/tlInteractive/tlInteractiveCommon.js"></script>
<script type="text/javascript">
var gridTableId = "controlPoint";
$(function(){
	var selectNode = {}, nodeAttrJson = {};
	if("${mpInfo}"){
		selectNode = {
			'id'  :"${mpInfo.nodeCode}",
			'text':"${mpInfo.nodeName}"
		};
		nodeAttrJson = {
			'remark':"${mpInfo.remark}",
			'mainProcess':"${mpInfo.mainProcess}",
			'levelCode':"${mpInfo.levelCode}",
			'levelName':"${mpInfo.levelName}",
			'subLevelCode':"${mpInfo.subLevelCode}",
			'subLevelName':"${mpInfo.subLevelName}",
			'attachmentId':"${mpInfo.attachmentId}"
		};
	}else{
		selectNode = parent.$(parent.left$tree).tree('getSelected');
		if(selectNode == null){
			showMessage1("无法查询到控制点，请检查记录是否存在！");
			setTimeout(aud$closeTopDialog,0);
			return; 
		}
		nodeAttrJson = parent.parseNodeAttributes(selectNode);
	}

	//初始化上级节点流程的信息
	if(nodeAttrJson){
		$('#parent_nodeCode').text(selectNode.id);
		$('#parent_nodeName').text(selectNode.text);
		$('#parent_nodeRemark').text(nodeAttrJson.remark);
	}
	var mainProcess = nodeAttrJson.mainProcess;
	var selectNodeCode = selectNode.id;
	var levelCode = nodeAttrJson.levelCode;
	var levelName = nodeAttrJson.levelName;
	var subLevelCode = nodeAttrJson.subLevelCode;
	var subLevelName = nodeAttrJson.subLevelName;
	var colum_nodeCode = "编码",  colum_nodeName = "子流程";
	if(mainProcess == '1'){
		colum_nodeCode = subLevelName + colum_nodeCode;
		colum_nodeName = subLevelName;
	}else if(mainProcess == '0'){
		colum_nodeCode = subLevelName + colum_nodeCode;
		colum_nodeName = subLevelName;
	}
	
	//设置layout的panel的title
	var northTitle = "当前所属【" + levelName +"】信息查看";
	var centerTitle = subLevelName + "列表";
	$('body').layout('panel','north').panel('setTitle', northTitle);
	$('body').layout('panel','center').panel('setTitle', centerTitle);
	$('#parent_nodeCode2').text(levelName+"编号");
	$('#parent_nodeName2').text(levelName);
	
	var isView = "${view}" == true || "${view}" == "true" ? true : false;	
	var tabTitle = isView ? "查看" : "编辑";
	autoTextarea($('#parent_nodeRemark')[0]);
	var editIndex = undefined;	  
	
	var ctrlPointEditUrl = "${contextPath}/intctet/mainProcess/editControlPoint.action?view=${view}";
	var addRowBtn = {   
         text:'新增',
         iconCls:'icon-add',
         handler:function(){
        	 aud$openNewTab('控制点添加', ctrlPointEditUrl+"&riskCode="+selectNodeCode, true);
         }
     };
	
	var downloadTemplateBtn = {   
        text:'下载模板',
        iconCls:'icon-download',
        handler:function(){
        	$('#parseExcelContainer').parseExcel('downloadTemplate');
        }
    };
	
	var importExcelBtn = {   
        text:'导入文件',
        iconCls:'icon-upload',
        id:'importExcelBtn'
    }
	
	var cusToolbar = isView ? [] : [addRowBtn,"-",'delete','-', downloadTemplateBtn,'-',importExcelBtn,'-'];
	
    var g1 = new createQDatagrid({
        // 表格dom对象，必填
        gridObject:$('#'+gridTableId)[0],
        // 要进行检索的表对象(hibernate bean)名称， 进行拼接hql时使用; 必填
        boName:'ControlPoint',
        // 对象主键,删除数据时使用-默认为“id”；必填
        pkName:'cpId',
        order :'asc',
        sort  :'createTime',
		winWidth:500,
	    winHeight:250,
	    //自定义显示哪些按钮：myToolbar:['delete', 'export', 'search', 'reload'],
	    myToolbar:['export', 'reload'],
	    //删除前执行
	    beforeRemoveRowsFn:function(rows, gridObject){ 
	    	return true;
	    },
        //删除方法removeDatagridRows，删除数据成功后调用 afterRemoveRowsFn(rows, gridObject)
        afterRemoveRowsFn:function(rows, gridObject){
        	aud$reloadParentTree(selectNode);
        },
		//定制查询
		whereSql: "riskCode = '"+selectNodeCode+"'",
        // 表格控件dataGrid配置参数; 必填
        gridJson:{
        	singleSelect:true,
        	checkOnSelect:false,
        	selectOnCheck:false,
        	toolbar:cusToolbar,
            onClickCell:function(rowIndex, field, value){
                if(field == 'cpCode'){		
                    var rows = $(this).datagrid('getRows');
                    var row = rows[rowIndex];
                    $(this).datagrid('unselectRow',rowIndex);
                    $(this).datagrid('uncheckRow',rowIndex);
                    aud$openNewTab(colum_nodeName + tabTitle, ctrlPointEditUrl+"&cpId="+row['cpId'], true);
                }
            },	
            frozenColumns:[[ 
    			{field:'cpId',   title:'选择', width:'10px', halign:'center', sortable:true, show:'false', checkbox:!isView, hidden:isView}, 
                {field:'cpCode', title:colum_nodeCode, width:'180px',align:'center', halign:'center', sortable:true, show:false, formatter:formatterClick} 
            ]],
    		columns:[[
                {field:'cpName', title:colum_nodeName, width:'90%',align:'left', halign:'center', sortable:true, oper:'like'}
          ]]
        }
    });
	window.ctrlPointList = g1;
	
    function formatterClick(value){
    	var t = tabTitle || "查看";
    	return  ["<label title='单击"+t+"' style='cursor:pointer;color:blue;'>",value,"</label>"].join('') ;
    }
    
    //初始化流程的附件列表
    $('#parent_processAttachment').fileUpload({
    	fileGuid:nodeAttrJson.attachmentId,
    	echoType:2,
    	isDel:false,
    	isEdit:false,
    	isAdd:false
    });
    
	//excel文件导入
    $('#parseExcelContainer').parseExcel({ 
		triggerId:'importExcelBtn',
		title:'导入'+subLevelName,
		beanName:'ControlPoint',
		boPk:'cpId',
        //上传成功后，要刷新的datagrid id
        datagridId:gridTableId,
        //下载模板的名字
        templateFileName:'controlPoint.xlsx',
        //下载模板的路径
        templateFilePath:'interCtrlEvaluation&template',
        //除了要导入的excel外，其它要提交的数据, json格式
        data:{
        	'riskCode':selectNodeCode,
        	//多选时，数据是否保存到多选表
        	'relation':true
        },
		//导入成功后调用
		onImportSuccess:function(target, options){
			aud$reloadParentTree(selectNode);
		}
	});

});

//保存 修改控制点后，回调此函数
function aud$cpCallbackFn(selectNode){
	ctrlPointList.refresh();
	aud$reloadParentTree(selectNode);
}
//刷新父页面树形
function aud$reloadParentTree(selectNode){
	selectNode = selectNode ? selectNode : parent.$(parent.left$tree).tree('getSelected');
	if(parent.left$tree && selectNode){
		parent.aud$locationLeftTreeNode(selectNode.id);
	}
}
</script>
</head>
<body style='padding:0px;margin:0px;overflow:hidden;' class="easyui-layout" fit=true border='0'>
	<div title="当前流程信息查看" region='north' style='overflow:auto; height:170px;' border='0' split='true'>
		<table class="ListTable" align="center" style='table-layout:fixed;'>
			<tr>
				<td class="EditHead" style="width:15%;" nowrap id='parent_nodeCode2'>风险点编号</td>
				<td class="editTd" style="width:38%;">
					<label id='parent_nodeCode'></label>
				</td>
				<td class="EditHead" style="width:15%;" nowrap  id='parent_nodeName2'>风险点</td>
				<td class="editTd" style="width:38%;">
					<label id='parent_nodeName'></label>
				</td>
			</tr>
			<tr>
				<td class="EditHead" style="width:15%;" nowrap>备注</td>
				<td class="editTd" colspan='3'>			
					<textarea id='parent_nodeRemark' class="noborder viewElement clear" 
					style='border-width:0px;height:20px;width:99%;overflow:hidden;padding:5px;' readonly></textarea>
				</td>
			</tr>
			<tr>
				<td class="EditHead" style="width:15%;" nowrap>附件</td>
				<td class="editTd" colspan='3' >
					<div id="parent_processAttachment" name="parent_processAttachment" 
					style='height:55px;overflow:auto;'></div>
				</td>
			</tr>
		</table>
	</div>
	<div title="流程列表" region='center' style='overflow:hidden;' split='true' border='0' collapsible='true'>
		<table id="controlPoint"></table>
	</div>
	<!-- 引入公共文件 -->
   <jsp:include flush="true" page="/pages/frReportFlow/ajaxloading.jsp" />
    <!-- 文件导入解析 -->
	<div id="parseExcelContainer"></div>
</body>
</html>