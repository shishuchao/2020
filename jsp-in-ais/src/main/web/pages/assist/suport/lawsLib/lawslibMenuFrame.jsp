<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/createOrgTree.js"></script>  
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/csswin/common.js"></script>
<script type="text/javascript">
  var zcfgtree = null;
  $(function(){
		var treeTarget = $('#zcfgTreeSelect')[0];
		var winJson = showSysTree(treeTarget,{
			container:treeTarget,
			noMsg:true,
			//queryBox:false,
			treeTabTitle1:'审计依据',
			param:{
				'rootParentId':'null',
                'beanName':'AssistSuportLawslibMenu',
                'treeId'  :'id',
                'treeText':'category_name',
                'treeParentId':'parent_id',
                'treeOrder':'priority',
                'serverCache':false,
                'treeAtrributes':'parentDeptId',
                'whereHql' :'classification=\'flfg\''
            },
			onTreeClick:function(node, treeDom){
				var isLeaf = false;
				if(node.attributes){
					var njson = $.parseJSON(node.attributes);
					if(njson){
						isLeaf = njson.isLeaf;
					}
				}
		    	var id = node.id;
		    	var src ='<%=request.getContextPath()%>/pages/assist/suport/lawsLib/editMenu.action?m_view=view&nodeid=' + id + '&isLeaf=' + isLeaf;
                $('#childBasefrm').attr('src',src);
			}
		});
		zcfgtree = winJson.win.param.jqtree;
  });
  
  
  function loadParentTree(nodeId,text){
		try{
			//alert("loadParentTree: nodeId="+nodeId+", text="+text)
			/*
			if(nodeId){
				var node = $(zcfgtree).tree('find', nodeId);
				alert('node:'+node)
				if(node){
					$(zcfgtree).tree('reload', node.target);
				}
			}
			*/
	        $(zcfgtree).tree('reload');
	        var timeout = window.setTimeout(function(){
	            //alert('nodeId='+nodeId)
	            if(nodeId){
	                var url = "<%=request.getContextPath()%>/commonPlug/getPriorNodeIdsById.action?rootParentId=null&whereHql=classification='flfg'&beanName=AssistSuportLawslibMenu&treeId=id&treeText=category_name&treeParentId=parent_id&treeOrder=priority";
	                QUtil.expandPriorNodeByIds(nodeId, url, $(zcfgtree), text, false);
	            }
	            timeout ? clearTimeout(timeout) : null;
	        }, 200);
		}catch(e){
			alert("loadParentTree:\n"+e.message);
		}
  }
  
</script>

</head>
<div id="container" class='easyui-layout' border='0' fit='true'>
  <div id="content" region='west' split='true' border='0' style='width:320px;' >	    
    	<ul id='zcfgTreeSelect'></ul>
  </div>
  <div id="sidebar" region='center' title='详细信息' border='0'>
	<iframe id="childBasefrm" width="100%" frameborder="0" height="98%" src="<%=request.getContextPath()%>/pages/assist/suport/lawsLib/tishi.jsp" ></iframe>
  </div>
</div>
</html>