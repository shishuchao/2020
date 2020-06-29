<%@page import="ais.framework.util.StringUtil"%>
<%@page import="ais.sysparam.util.SysParamUtil"%>
<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<html>
<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" href="<%=request.getContextPath()%>/pages/introcontrol/util/themes/default/easyui.css" type="text/css"></link>
	<link rel="stylesheet" href="<%=request.getContextPath()%>/pages/introcontrol/util/themes/icon.css" type="text/css"></link>
    <script type="text/javascript" src="<%=request.getContextPath()%>/pages/introcontrol/util/jquery-1.7.1.min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/pages/introcontrol/util/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/pages/introcontrol/util/easyui-lang-zh_CN.js"></script>
	<script language="Javascript">
	$(function(){
		var where = '';
		// 是否显示复选框，默认不显示
		var isCheckbox = false;
		// 复选框是否级联选择
		var isCascadeCheck = true;
		var arr = window.location.href.split('&');
		for(var i=0; i<arr.length; i++){
			var str = arr[i];
			var arr2 = str.split("=");
			if(arr2[0].toLowerCase() == 'where'){
				where = arr2[1];
			}else if(arr2[0].toLowerCase() == 'checkbox'){
				isCheckbox = arr2[1] == 'true' ? true : false;
			}else if(arr2[0].toLowerCase() == 'cascadecheck'){
				isCascadeCheck = arr2[1] == 'true' ? true : false;
			}
		}
		//alert(window.location.href)
		//alert(isCascadeCheck)
		$('#auditObjectTree').tree({   
			url: "<%=request.getContextPath()%>/mng/audobj/object/getAuditedDeptChildByDeptId.action?where="+where,
			checkbox:isCheckbox,
			//animate:true,
			lines:true,
			cascadeCheck:isCascadeCheck,
			onLoadSuccess:function(node,data){
				if(data.length == 0){
					$.messager.alert('提示信息','没有对应的被审计单位！','error');
				}
			},
			loadFilter:function(data){
				/*
				//alert(data[0].parentId);
				var newData = [];
				for(var i=0; i<data.length; i++){
					var n1 = data[i];
					var flag = true;
					for(var j=0; j<data.length;j++){
						var n2 = data[j];
						if(n2.id === n1.parentId){
							flag = false;
						}
					}
					flag ? newData.push(n1) : null;
				}
				data = null;
				//alert(newData.toString())
				*/
				return data;
			},
			onClick:function(node){
				$(this).tree('toggle', node.target);
			},
			onDblClick:function(node){
				var node  = $('#auditObjectTree').tree('getSelected');
				$('#paranamevalue').val(node.text);
				$('#paraidvalue').val(node.id);
			}
		}); 
	});
	// 获得选中节点name和id
	function getSelectedValue(){
		// 多选
		var nodes =  $('#auditObjectTree').tree('getChecked');
		// 单选
		var node  = $('#auditObjectTree').tree('getSelected');
		if(nodes.length > 0){
			var dms = [];
			var mcs = [];
			$.each(nodes, function(i,node){
				dms.push(node.id);
				mcs.push(node.text);
			});
			$('#paranamevalue').val(mcs.join(','));
			$('#paraidvalue').val(dms.join(','));
		}else if(node){
			$('#paranamevalue').val(node.text);
			$('#paraidvalue').val(node.id);
		}
	}
	// 全部选中
	function chkall(){
		$('#auditObjectTree').tree('check',$('#auditObjectTree').tree('getRoot'));
		var roots = $('#auditObjectTree').tree('getRoots');
		$.each(roots, function(i,root){
			var childNodes = $('#auditObjectTree').tree('getChildren',root); 
			$.each(childNodes, function(j,childNode){
				$('#auditObjectTree').tree('check',childNode.target); 
			});
		});
	}
	// 选中取消
	function allNochk(){
		// 多选
		var nodes =  $('#auditObjectTree').tree('getChecked');
		if(nodes.length > 0){
			$.each(nodes, function(i,node){
				//alert(node)
				$('#auditObjectTree').tree('uncheck',node.target);
			});
		}
	} 
	//json 转化成 string 递归对象的各个属性，形成string串
	function object2string(o){
		 try {
		     var r = [];
		     // 如果为字符串string，则返回
		     if (typeof o == "string" || o == null) {
		         var tmpArr = new Array();
		         tmpArr.push("'");
		         tmpArr.push(o);
		         tmpArr.push("'");
		         return tmpArr.join("");
		     }else if (typeof o == "number" || typeof o == "boolean" || typeof o == "function" || o == null) {
		         var tmpArr = new Array();
		         tmpArr.push(o);
		         return tmpArr.join("");
		     }
		     //如果对object对象，则遍历object的元素
		     if (o) {
		         var objType = jQuery.type(o);
		         if (objType === "object") {
		             r[0] = "{"
		             for (var i in o) {
		                 r[r.length] = i;
		                 r[r.length] = ":";
		                 r[r.length] = object2string(o[i]);
		                 r[r.length] = ",";
		             }
		             r[r.length - 1] = "}";
		         } else if (objType === "array") {
		             r[0] = "["
		             for (var i = 0; i < o.length; i++) {
		                 r[r.length] = object2string(o[i]);
		                 r[r.length] = ",";
		             }
		             r[r.length - 1] = "]"
		         }
		         return r.join("");
		     }
		     return o.toString();
		 } catch (e) {
		     //oException.show("object2string()", e);
		 }
	}
	</script>
</head>
<body>
		<input type="hidden" id="paranamevalue" name="paranamevalue">
		<input type="hidden" id="paraidvalue"   name="paraidvalue">
		<ul id='auditObjectTree' class='easyui-tree'></ul>
</body>
</html>