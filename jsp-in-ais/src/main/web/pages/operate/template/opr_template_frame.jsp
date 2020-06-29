<!DOCTYPE HTML>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
<head>
    <title>审计方案编辑</title>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
	<script type="text/javascript">
		$(function(){
			generateWin('importSjsx');
			// 导入审计事项（树初始化）
		    var importTaskTree = $('#importTaskTree');		
		    showSysTree(importTaskTree,{
		       container:importTaskTree,
		       checkbox:true,
		       cascadePrior:true,
		       cascadeJunior:true,
		       queryBox:false,
		       noMsg:true,
		       param:{
   					//禁用oracle特性（加载会变慢），因为AuditMatter没有具体的父ID，只有parent对象，无法赋值
					'isOracle':false,
		            'rootParentId':'null',
		            'beanName':'AuditMatter',
		            'treeId'  :'id',
		            'treeText':'name',
		            'treeParentId':'parent.id',
		            'treeOrder':'id'
		        }
		    });
		    
		    $('#closeTaskWinBtn').bind('click',function(){
				closeWin('importSjsx');
			});
		    
		    $('#importTaskBtn').bind('click',function(){
		    	saveNodes();
		    });
		    
		});
		
		//保存导入的审计事项
		function saveNodes(){
			var node = treeIframe.window.getCheckNode();
			var audTemplateId = '${audTemplateId}';
			var nodes = $('#importTaskTree').tree('getChecked');
			if (nodes == null || nodes == '') {
				showMessage1("请选择要导入的事项！");
				return false;
			}
			var nodeString = '';
			for (var i=0; i<nodes.length;i++) {
				var isLeaf = $('#importTaskTree').tree('isLeaf',nodes[i].target);
				if(nodes[i].id.toLowerCase() == '10'){
                	continue;
             	}
				var parentNode = $('#importTaskTree').tree('getParent',nodes[i].target);
				if(parentNode)
					nodeString += "{'id':'"+nodes[i].id+"','pId':'"+parentNode.id+"','name':'"+nodes[i].text+"','leaf':'"+isLeaf+"'},";
			}
			nodeString = nodeString.substring(0,nodeString.lastIndexOf(','));
			nodeString = "["+nodeString+"]";
			$.ajax({
				 type:"Post",
				 url:"/ais/operate/template/saveAuditMatterTemplate.action",
				 data:{
					'nodeString':nodeString,
					'audTemplateId':audTemplateId,
					'taskTemplateId':node.id
				 },
				 success:function(ret){
					if(ret == 'true'){
						treeIframe.window.reloadSelectedNode(node);
						showMessage1("保存成功！");
						closeWin('importSjsx');
					}else{
						showMessage1("保存失败！" + ret);
					}
				}
			});
	    }
	    
	    //重新加载子页面树方法，必须有选中节点
	    function reloadChildTreeNode(editType,node){
	    	treeIframe.window.reloadSelectedNode(editType,node);
	    }
	    
		function openWindow() {
			$('#importTaskTree').tree('reload');
		    openWin('importSjsx','导入审计事项','600');
		}
		
	</script>
</head>
<body class="easyui-layout" fit="true" style="overflow:hidden;" border='0'>
	<div region="west" border="0" split="true" title="" style="overflow:hidden;width:300px;">
		<iframe name="treeIframe" src="showTreeList.action?interCtrl=${interCtrl}&audTemplateId=<%=request.getParameter("audTemplateId")%>" frameborder="0"
		        style="height:100%;width:100%;overflow:hidden;"></iframe>
	</div>
	<div region="center" border="0"  style="overflow:hidden;">
		<iframe name="childBasefrm" src="showContent.action?interCtrl=${interCtrl}&selectedTab=main&taskPid=<%=request.getParameter("taskPid")%>&audTemplateId=<%=request.getParameter("audTemplateId")%>" 
		        frameborder="0" style="height:100%;width:100%;overflow:hidden;"></iframe>
	</div>
	
	<div id="importSjsx">
		<div class="easyui-layout" data-options="fit:true, border:false" >
			<div  region="center"  border="0"  style='overflow:hidden; padding:0px;margin:0px;'>
				<ul id="importTaskTree" class="easyui-tree"></ul>
			</div>
			<div region="south"  border="0" style='text-align:right;overflow:hidden; padding:10px;'>
				<button id='importTaskBtn' class="easyui-linkbutton" data-options="iconCls:'icon-import'" href="javascript:void(0)">导入</button>&nbsp;
				<button id='closeTaskWinBtn' class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" href="javascript:void(0)" >关闭</button>
            </div>
		</div>
	</div>
</body>
</html>