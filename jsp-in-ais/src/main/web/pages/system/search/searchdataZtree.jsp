<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<HTML>
<HEAD>
	<TITLE> </TITLE>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/JqueryZtree/css/demo.css" type="text/css">
	<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/JqueryZtree/css/zTreeStyle/zTreeStyle.css" type="text/css">
	<script type="text/javascript" src="<%=request.getContextPath()%>/pages/introcontrol/util/jquery-1.7.1.min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/JqueryZtree/js/jquery.ztree.all-3.1.js"></script>
	<SCRIPT type="text/javascript"><!--
		
		var setting = {
			check: {
				enable: true,
				chkboxType: {"Y":"s", "N":"s"}
			},
			data: {
				key: {
					title: "t"
				},
				simpleData: {
					enable: true,
					idKey: "id",   
                    pIdKey: "pId",   
                    rootPId: 0 
				}				
			},
			view: {
				fontCss: getFontCss
			},
			callback: {
				//onCheck: onCheck
				
			}
		};


		function focusKey(e) {
			if (key.hasClass("empty")) {
				key.removeClass("empty");
			}
		}
		function blurKey(e) {
			if (key.get(0).value === "") {
				key.addClass("empty");
			}
		}
		var lastValue = "", nodeList = [], fontCss = {};
		function clickRadio(e) {
			lastValue = "";
			searchNode(e);
		}
		function searchNode(e) {
			var zTree = $.fn.zTree.getZTreeObj("treeDemo");
			var value = $.trim(key.get(0).value);
			var keyType = "";
				keyType = "name";
			if (key.hasClass("empty")) {
				value = "";
			}
			if (lastValue === value) return;

			updateNodes(false);
			lastValue = value;
			if (value === "") return;
			//处理键入关键字时，自动展开匹配的数据且以红色字体显示（第一次默认展开第1个节点,即:level 为0）
				zTree.expandAll(false);
				var nodeFirst = zTree.getNodeByParam("level", "0");
				zTree.expandNode(nodeFirst,true,null,true,true);
				
			var result = "";
				nodeList = zTree.getNodesByParamFuzzy(keyType, value);
			updateNodes(true);

		}
		function updateNodes(highlight) {
			var zTree = $.fn.zTree.getZTreeObj("treeDemo");
			for( var i=0, l=nodeList.length; i<l; i++) {
				nodeList[i].highlight = highlight;
				//处理键入关键字时，自动展开匹配的数据且以红色字体显示
				if(nodeList[i].getParentNode()!=null){
							var nodeParent = nodeList[i].getParentNode();
							zTree.expandNode(nodeParent,true,null,true,true);
				}
				zTree.updateNode(nodeList[i]);
			}
		}
		function getFontCss(treeId, treeNode) {
			return (!!treeNode.highlight) ? {color:"#A60000", "font-weight":"bold"} : {color:"#333", "font-weight":"normal"};
		}
		
		function onCheck(e, treeId, treeNode) {
			var zTree = $.fn.zTree.getZTreeObj("treeDemo");
			var nodes = zTree.getCheckedNodes(true);
			//按要求只显示选中节点的二级单位 （仅用于显示）
			vId = "";
			//按要求只显示选中节点的二级单位 （仅用于显示）
			vname = "" ;
			//选中的全部单位ids 
			allIds = "";
			//选中的全部单位names 
			allNames = "" ;
			for (var i=0, l=nodes.length; i<l; i++) {
				//if(nodes[0].id=='1'){ //选中的节点是根结点时,只显示根节点
				//	allIds += nodes[i].id + ",";
				//	allNames += nodes[i].name + ",";
				//	vId += nodes[i].id + ",";
				//	vname+=nodes[i].name + ",";
				//	break ;
				//}else{
					//如果当前选中节点，包含有子节点,则读取该节点名称,不显示子节点名称
					var nodesChildren = nodes[i].children; 
					if(nodesChildren!=null && nodesChildren){
							if(nodes[i].getParentNode()!=null&&nodes[i].getParentNode().checked!=true){
								vname += nodes[i].name + ",";    //nodes[i]为当前选中节点名称
								vId += nodes[i].id + ",";    //nodes[i]为当前选中节点id
							}else if(nodes[i].getParentNode()==null&&nodes[i].checked==true){
								vname += nodes[i].name + ",";    //nodes[i]为当前选中节点名称
								vId += nodes[i].id + ",";    //nodes[i]为当前选中节点id
							}
					//单支结点的判断，1级和2级子叶子结点
					}else 	{
						if(nodes[i].getParentNode()!=null&& nodes[i].getParentNode().checked!=true&&nodes[i].getParentNode().getParentNode()!=null &&nodes[i].getParentNode().getParentNode().checked!=true){
									vname += nodes[i].name + ",";    //nodes[i]为当前选中节点名称
									vId += nodes[i].id + ",";    //nodes[i]为当前选中节点id
						}else if(nodes[i].getParentNode()!=null&& nodes[i].getParentNode().checked!=true){
									vname += nodes[i].name + ",";    //nodes[i]为当前选中节点名称
									vId += nodes[i].id + ",";    //nodes[i]为当前选中节点id
						}else if(nodes[i].getParentNode()==null&&nodes[i].checked==true){
								vname += nodes[i].name + ",";    //nodes[i]为当前选中节点名称
								vId += nodes[i].id + ",";    //nodes[i]为当前选中节点id
						}
					}
					//保存所有的选中节点id
						allIds += nodes[i].id + ","; 
						allNames += nodes[i].name + ","; 
				//}
			}
			if (vname.length > 0 ) vname = vname.substring(0, vname.length-1);
			var nameObj = $("#displayNameSel");
			nameObj.attr("value", vname);
			
			if (vId.length > 0 ) vId = vId.substring(0,vId.length-1);
			var idObj = $("#displayIdSel");
			idObj.attr("value", vId);
			
			if (allIds.length > 0 ) allIds = allIds.substring(0, allIds.length-1);
			var allIdsObj = $("#idSel");
			allIdsObj.attr("value", allIds);
			
			if (allNames.length > 0 ) allNames = allNames.substring(0, allNames.length-1);
			var allNamesObj = $("#nameSel");
			allNamesObj.attr("value", allNames);
		}
		var key;
		var zNodes;
		$(document).ready(function(){
		var params0=$("#searchKey").serialize();
		var params1=$("#where").serialize(); 
		var params=params0+"&"+params1; 
		//var params = $("div").text($("form").serialize()); 
			$.ajax({   
		        async :false,   
		        cache:false,   
		        type: 'POST',   
		        data: params,
		        dataType : "json",   
		        url: "<%=request.getContextPath()%>/mng/audobj/object/doGetPrivilegeTree.action",//请求的action路径   
		        //data:{searchKey:["s"],
		        error: function () {//请求失败处理函数   
		            alert('请求失败');   
		        },   
		        success:function(data){ //请求成功后处理函数。     
		            zNodes = data;   //把后台封装好的简单Json格式赋给treeNodes
		        }   
		    });  
		    
			$.fn.zTree.init($("#treeDemo"), setting, zNodes);
			
			//初始化之前对已选择的节点设置checked属性
		    var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
		    // var ids = '${audit_ids}' ;
		  	var ids = document.getElementById("audit_ids").value ;
		  	if(ids!=null && ids!=''&&ids!='1'){
		  		var arraIds = ids.split(",");
			    for( var i = 0; i < arraIds.length; i++){
			    	var node = treeObj.getNodeByParam("id", arraIds[i], null);
			    	//通过选择的树节点id查询到选择的节点并置为"已选中状态"
			    		if(node!=null && node!=''){
			    			 node.checked = true;
							 treeObj.updateNode(node);
			    		}
			    }
		  	}else{
			    for( var i = 0; i < zNodes.length; i++){
			    		if(zNodes[i]!=null && zNodes[i]!=''){
			    			 zNodes[i].checked = true;
							 treeObj.updateNode(zNodes[i]);
			    		}
			    }
		  	}
		  	var sNodes = treeObj.getSelectedNodes();
			key = $("#key");
			key.bind("focus", focusKey)
			.bind("blur", blurKey)
			.bind("propertychange", searchNode)
			.bind("input", searchNode);
			
		});
		//
	--></SCRIPT>
	<script type="text/javascript">
		function searchAudit(){
			document.getElementById("searchKey").value = document.getElementById("key").value ;
			var flowForm = document.getElementById('permissionform');
			flowForm.action="<%=request.getContextPath()%>/mng/audobj/object/auditedDeptListByZtree.action" ;
			flowForm.submit();
		}
		function resetKey(){
		document.getElementById("searchKey").value = '' ;
		var wherepa = document.getElementById("where").value;
			window.location = "<%=request.getContextPath()%>/mng/audobj/object/auditedDeptListByZtree.action?where="+wherepa ;
		}
		function getSelectedValue(){
			onCheck();
			document.all("paranamevalue").value=window.document.all("nameSel").value;
			document.all("displayparanamevalue").value=window.document.all("displayNameSel").value;
			document.all("displayparaidvalue").value=window.document.all("displayIdSel").value;
			document.all("paraidvalue").value=window.document.all("idSel").value;
		}
	</script>
</HEAD>

<BODY>
<div class="content_wrap">
	<div class="zTreeDemoBackground left">
		<ul id="treeDemo" class="ztree"></ul>
	</div>
	<div class="right">
		<ul class="info">
			<li class="title">
				<ul class="list">
				<li class="title">&nbsp;&nbsp;<input id="displayNameSel" type="hidden" readonly value="" style="width:120px;"/>
				<li class="title">&nbsp;&nbsp;<input id="displayIdSel" type="hidden" readonly value="" style="width:120px;"/>
				<li class="title">&nbsp;&nbsp;<input id="nameSel" type="hidden" readonly value="" style="width:120px;"/>
				<li class="title">&nbsp;&nbsp;<input id="idSel" type="hidden" readonly value="" style="width:120px;"/>
				</ul>
			</li>
			 <form id="permissionform" method="post">
						<!-- 提交授权操作表单 -->    
	            	<ul class="list">
						<li class="highlight_red">模糊查询</li>
						<li>
								<s:hidden name="searchKey"></s:hidden>
		                    	<s:hidden name="where" value="${where}"></s:hidden>
		                    	<s:hidden name="audit_ids" value="${audit_ids}"></s:hidden>
		                    	关键字：
								<s:textfield id="key" value="${searchKey}"></s:textfield><br/><br/>
								<input type="button"  style="width:50px;"  class="btn" value="搜索" onclick="searchAudit()"/>
								&nbsp;
								<input type="button"  style="width:50px;"  class="btn" value="重置" onclick="resetKey()"/>
						</li>
					</ul>
        	</form>   
		</ul>
	</div>
</div>
<input type=hidden id="paranamevalue">
<input type=hidden id="displayparanamevalue">
<input type=hidden id="displayparaidvalue">
<input type=hidden id="paraidvalue">
</BODY>
</HTML>