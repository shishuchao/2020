<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML >
<html>
<title>内控评价-流程框架</title>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<script type="text/javascript" src="${contextPath}/easyui/boot.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/autosize.js"></script>
<script type="text/javascript" src="${contextPath}/pages/tlInteractive/tlInteractiveCommon.js"></script>
<script type="text/javascript">
$(function(){  
	var isView = "${view}" == true || "${view}" == "true" ? true : false;
	var defaultUrl = "${contextPath}/intctet/mainProcess/showTotalProcess.action?view=${view}";
	$('#rightIfm').attr('src', defaultUrl);
	var treeObj = $('#processTree')[0];
	var winJson = showSysTree(treeObj,{
		container:treeObj, 
        treeTabTitle1:'业务流程',
        //treeTabTitle2:'搜索结果',
        noMsg:true,
        queryBox:false,
		param:{
			'customRoot':'业务流程',
			'rootParentId':'null',
            'beanName':'MainProcess',
            'treeId'  :'nodeCode',
            'treeText':'nodeName',
            'treeParentId':'parentCode',
            'treeOrder':'nodeCode',
            'serverCache':false,
            //'isOracle':false,
            // 在node的atrributes中添加想要得到业务对象
            'treeAtrributes':'nodeId,levelCode, levelName,subLevelCode,subLevelName,subLastCtrlPoint,mainProcess,attachmentId,remark'
        },
        onLoadSuccess:aud$expandAll,
		onTreeClick:function(node, treeDom){
			var rightIfmUrl = null;
			var attrJson = parseNodeAttributes(node);
			var subLastCtrlPoint = attrJson.subLastCtrlPoint;
			
			//alert('subLastCtrlPoint='+subLastCtrlPoint)
			if(subLastCtrlPoint == "0"){
				rightIfmUrl = "${contextPath}/intctet/mainProcess/showSubProcessList.action?view=${view}";				
			}else if(subLastCtrlPoint == "1"){
				rightIfmUrl = "${contextPath}/intctet/mainProcess/showControlPointList.action?view=${view}";		
			}else if(subLastCtrlPoint == undefined){
				rightIfmUrl = "${contextPath}/intctet/mainProcess/showMainProcessList.action?view=${view}";
			}else{
				var ctrlPointEditUrl = "${contextPath}/intctet/mainProcess/editControlPoint.action?view=${view}";
				aud$openNewTab("${lastlevelName}" + (isView ? "查看" : "编辑"), ctrlPointEditUrl+"&cpId="+attrJson.nodeId, true);
				//showMessage1("根据【内控矩阵层级】这个已经是最末级，无法对此级进行扩展"); 
			}
			if(rightIfmUrl){				
				$('#rightIfm').attr('src', rightIfmUrl);
			}
		}
	});
	var winOption = winJson.win.param;
	var jqtree = winOption.jqtree;
	window.left$tree = jqtree;
	//展开全部节点	
	var maxInterCount = 20;
	var interCount = 1;
	var interval = setInterval(function(){
		if(interCount > maxInterCount){
			interval ? clearInterval(interval) : null;
		}else{
			var children = null;
			try{
				var root = $(jqtree).tree('getRoot');
				if(root){
					children = $(jqtree).tree('getChildren', root.target);
				}
			}catch(e){}
			if(children){
				QUtil.expandOrCollapseAllNodes(jqtree,$(jqtree).tree('getRoot'));
				interCount = maxInterCount;
				interval ? clearInterval(interval) : null;
			}
		}
		interCount++
	}, 50);
	
});

function aud$expandAll(){
	var roots = $(left$tree).tree('getRoots');
	$.each(roots, function(i, root){
		$(left$tree).tree('expandAll', root.target);
	});
}


function parseNodeAttributes(node){
	var json = {};
	if(node){			
		var attributes = node.attributes;
		if(attributes){
			json = $.parseJSON(attributes);
		}
	}
	return json;
}

//定位树形节点
function aud$locationLeftTreeNode(nodeId){
	$(left$tree).tree('reload');
	if(nodeId){		
		window.setTimeout(function(){
			aud$expandAll();
			var snode = $(left$tree).tree('find', nodeId);
			if(snode){
				QUtil.selectedSpecifiedNode(window.left$tree, snode, snode.text );	
				$(left$tree).tree('expand', snode.target);				
			}
		},100);
	}
}

function aud$ImportExcelCallbackFn(importExcelSuccess, plugId){
	$('#rightIfm').get(0).contentWindow.aud$ImportExcelCallbackFn(importExcelSuccess, plugId);
}

</script>
</head>
<body style='padding:0px;margin:0px;overflow:hidden;' class="easyui-layout" fit=true border='0'>	
	<div title="内部控制矩阵" region='west' style='overflow:hidden;' split='true' border='0' collapsible='true'>
		<div id='processTree'></div>
	</div>
	<div region='center' style='overflow:hidden;' collapsible='true'>	
		<iframe id="rightIfm"  name="rightIfm" 
		width="100%" height="100%" marginheight="0"  marginwidth="0"  frameborder="0" scrolling="hidden"></iframe>
	</div>
</body>
</html>