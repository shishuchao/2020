<!DOCTYPE HTML>
<%@ page contentType="text/html; charset=utf-8" %>
<%@taglib prefix="s" uri="/struts-tags" %>
<HTML>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	</head>	
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>  
<script type="text/javascript">
  $(function(){
	  $('#zcfgTreeSelect').tree({   
			url:'<%=request.getContextPath()%>/admin/asyUorg4User.action?querySource=tree',
		    checkbox:false,
		    animate:false,
		    lines:true,
		    dnd:false,
		    onClick:function(node){
				 var id=node.id;
				 var src='ais/admin/editUOrg.action?view=${view}&uOrganization.fid='+id;
				 childBasefrm.location.href=src;
		    },
			onLoadSuccess:function(node, data){
				var rootNode = $("#zcfgTreeSelect").tree('getRoot');
				$("#zcfgTreeSelect").tree('expand',rootNode.target);
			}
		});
  });
  function treeFreshFun(){
  	$('#zcfgTreeSelect').tree("reload");
	var rootNode = $("#zcfgTreeSelect").tree('getRoot');
	$("#zcfgTreeSelect").tree('expand',rootNode.target);
  }
  //传入节点code,可校验是否包含
  function getNodeByCode(code) {
  	bol = true
  	var rootNode = $("#zcfgTreeSelect").tree('getRoot');
  	var rootNode1 = $("#zcfgTreeSelect").tree('getChildren',rootNode.target);
  	if(rootNode1) {
        for (var i = 0; i < rootNode1.length; i++) {
            if (rootNode1[i].attributes == code) {
                bol = false;
            }
        }
    }
  	return bol;
  }
	function compareTreeCode(id,code){
		var bol = true;
  		if (id != '0' && id != '') {
	  		var rootNode = $("#zcfgTreeSelect").tree('find',id);
	  		if (rootNode.attributes == code) {
	  			bol = false;
	  		}
  		}
  		return bol;
	}
</script>
	<body class="easyui-layout">
		<div style='display:none;'>
		<s:property escape="false" value="@ais.framework.util.NavigationUtil@getNavigation('/ais/admin/orgindex.jsp')"/>
		</div>
		<div region='west' split='true' title="<%--<img  style='vertical-align: middle; cursor: hand;' onclick=$('img[alt=操作帮助]').trigger('click') src='/ais/images/portal/default/window/icon-question-new.gif' />&nbsp;--%>组织机构管理" style='width:280px;height:500px;'>
			 <div id="content" style="overflow: auto;">
			    <br>
		    	<ul id='zcfgTreeSelect' class='easyui-tree'></ul>
		    	<br>
			</div> 
  		</div>     
	    <div region="center" style="overflow:hidden">
	    	<iframe name="childBasefrm"  width="100%" height="100%"  frameborder="0">main</iframe>
	    </div>
	</body>
</HTML>
