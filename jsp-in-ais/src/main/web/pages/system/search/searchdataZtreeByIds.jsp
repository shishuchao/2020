<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<HTML>
<HEAD>
	<TITLE> 审计范围</TITLE>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/JQuery zTree v3.1/css/demo.css" type="text/css">
	<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/JQuery zTree v3.1/css/zTreeStyle/zTreeStyle.css" type="text/css">
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/JQuery zTree v3.1/api/apiCss/jquery-1.6.2.min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/JQuery zTree v3.1/js/jquery.ztree.all-3.1.js"></script>
	<SCRIPT type="text/javascript"><!--
		
		var setting = {
			check: {
				enable: true,
				chkboxType: {"Y":"ps", "N":"s"}
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
			v = "";
			vId = "";
			for (var i=0, l=nodes.length; i<l; i++) {
					v += nodes[i].name + ","; 
					vId += nodes[i].id + ","; 
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
		var params2=$("#audit_ids").serialize(); 
		var params=params0+"&"+params1+"&"+params2; 
		//var params = $("div").text($("form").serialize()); 
			$.ajax({   
		        async :false,   
		        cache:false,   
		        type: 'POST',   
		        data: params,
		        dataType : "json",   
		        url: "${pageContext.request.contextPath}/testRange/doGetPrivilegeTreeByIds.action",//请求的action路径   
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
		  	var ids = document.getElementById("audit_idsScope").value ;
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
			flowForm.action="<%=request.getContextPath()%>/mng/audobj/object/auditedDeptListByZtreeByIds.action" ;
			flowForm.submit();
		}
		function resetKey(){
		document.getElementById("searchKey").value = '' ;
		var wherepa = document.getElementById("where").value;
			window.location = "<%=request.getContextPath()%>/mng/audobj/object/auditedDeptListByZtreeByIds.action?where="+wherepa ;
		}
		function getSelectedValue(){
		onCheck();
			document.all("paranamevalue").value=window.document.all("citySel").value;
			document.all("paraidvalue").value=window.document.all("cityIdSel").value;
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
				<li class="title">&nbsp;&nbsp;<input id="citySel" type="hidden" readonly value="" />
				<li class="title">&nbsp;&nbsp;<input id="cityIdSel" type="hidden" readonly value="" />
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
		                    	<s:hidden name="audit_idsScope" value="${audit_idsScope}"></s:hidden>
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
<input type=hidden id="paraidvalue">
</BODY>
</HTML>