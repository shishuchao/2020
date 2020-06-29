<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<HTML>
<HEAD>
	<TITLE> 被审计单位</TITLE>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/JQuery zTree v3.1/css/audit_demo.css" type="text/css">
	<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/JQuery zTree v3.1/css/zTreeStyle/zTreeStyle.css" type="text/css">
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/JQuery zTree v3.1/api/apiCss/jquery-1.6.2.min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/JQuery zTree v3.1/js/jquery.ztree.all-3.1.js"></script>
	<SCRIPT type="text/javascript"><!--
		
		var setting = {
			check: {
				enable: false,
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
				onClick: zTreeOnClick
				
			}
		};
		function zTreeOnClick(event, treeId, treeNode){
			//parent.frames["childBasefrm"].location.href = "www.baidu.com" ;
			var status = 'view' ;
			if('${status}'!=null&&'${status}'!=''){
				status = '${status}' ;
			}else{
				status = treeNode.status
			}
			if(treeNode.superiorCode=='0'||treeNode.superiorCode==null){
				parent.frames["childBasefrm"].location.href = "${contextPath}/mng/audobj/object/"+status+".action?auditingObject.id="+treeNode.id+"&superiorCode="+treeNode.currentCode+"&status="+status ;
			}else{
				parent.frames["childBasefrm"].location.href = "${contextPath}/mng/audobj/object/"+status+".action?auditingObject.id="+treeNode.id+"&superiorCode="+treeNode.currentCode+"&status="+status ;
			}
		}
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
			v = "";
			vId = "";
			for (var i=0, l=nodes.length; i<l; i++) {
				if(nodes[0].id=='1'){ //选中的节点是根结点时,只显示根节点
					v += nodes[i].name + ",";
					vId += nodes[i].id + ",";
					break ;
				}else{
					//如果当前选中节点，包含有子节点,则读取该节点名称,不显示子节点名称
					var nodesChildren = nodes[i].children; 
					if(nodesChildren!=null && nodesChildren!=undefined){
						v += nodes[i].name + ",";    //nodes[i]为当前选中节点
					}else{
						//选中的节点不包含子节点时则直接显示所有被选中的节点(注:父结点未被选中)
						if(nodes[i].getParentNode().checked!=true){
							v += nodes[i].name + ","; 
						}
					}
					//保存所有的选中节点id
					vId += nodes[i].id + ","; 
				}
			}
			if (v.length > 0 ) v = v.substring(0, v.length-1);
			var cityObj = $("#citySel");
			cityObj.attr("value", v);
			if (vId.length > 0 ) vId = vId.substring(0, vId.length-1);
			var cityIdObj = $("#cityIdSel");
			cityIdObj.attr("value", vId);
		}
		var key;
		var zNodes;
		$(document).ready(function(){
		var params0=$("#searchKey").serialize();
		var params1=$("#where").serialize(); 
		var params2=$("#status").serialize(); 
		var params=params0+"&"+params1+"&"+params2; 
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
		  	if(ids!=null && ids!=''){
		  		var arraIds = ids.split(",");
			    for( var i = 0; i < arraIds.length; i++){
			    	var node = treeObj.getNodeByParam("id", arraIds[i], null);
			    	//通过选择的树节点id查询到选择的节点并置为"已选中状态"
			    		if(node!=null && node!=''){
			    			 node.checked = true;
							 treeObj.updateNode(node);
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
			flowForm.action="<%=request.getContextPath()%>/mng/audobj/object/adminAuditedDeptListByZtree.action" ;
			flowForm.submit();
		}
		function resetKey(){
		document.getElementById("searchKey").value = '' ;
		var wherepa = document.getElementById("where").value;
			window.location = "<%=request.getContextPath()%>/mng/audobj/object/adminAuditedDeptListByZtree.action?where="+wherepa ;
		}
		function getSelectedValue(){
		onCheck();
			document.all("paranamevalue").value=window.document.all("citySel").value;
			document.all("paraidvalue").value=window.document.all("cityIdSel").value;
		}
	</script>
</HEAD>

<BODY>
 <form id="permissionform" method="post">
						<!-- 提交授权操作表单 -->    
	            	<ul class="list">
								<s:hidden name="searchKey"></s:hidden>
		                    	<s:hidden name="where" value="${where}"></s:hidden>
		                    	<s:hidden name="audit_ids" value="${audit_ids}"></s:hidden>
		                    	<s:hidden name="status" value="${status}"></s:hidden>
		                    	
								<s:textfield id="key" value="${searchKey}" cssStyle="width:120px"></s:textfield>
								<input type="button"  style="width:50px;" value="搜索" onclick="searchAudit()"/>
								&nbsp;
								<input type="button"  style="width:50px;"  class="btn" value="重置" onclick="resetKey()"/>
								<input id="citySel" type="hidden" readonly value=""/>
								<input id="cityIdSel" type="hidden" readonly value=""/>
								<input type=hidden id="paranamevalue">
								<input type=hidden id="paraidvalue">
					</ul>
        		</form> 
<div>
	<div>
		<ul id="treeDemo" class="ztree"></ul>
	</div>
</div>
</BODY>
</HTML>