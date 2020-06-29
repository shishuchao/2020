<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<jsp:directive.page import="java.net.URLEncoder"/>
<jsp:directive.page import="java.net.URLDecoder"/>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page import="ais.auth.model.AuthAuthority,java.util.List,ais.auth.model.AuthBizFunction"%>
<!DOCTYPE HTML >
<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <title>操作授权</title>
<script language="javascript">
function CheckShow(str)
{
  if (document.all(str).style.display=="")
  {
    document.all(str).style.display="none";
  }
  else
    document.all(str).style.display="";
}

function checkSubmit()
{
  
   document.all.functions.value=pertree.GetSelectedValue4Auth();
   document.forms[0].submit();
}
function doClose(){
window.close();
//window.parent.hidePopWin(false);
}
</script>
</head>
<body class="easyui-layout" fit="true" border='0' style='padding:0px;margin:0px;overflow:hidden;'>
<div region="north" border='0' style="overflow:hidden;" collapsible='false' title="当前角色: 【${p_frolename}】">
    <s:if test="${param.view ne 'view'}">
        <div style="text-align:left;overflow:hidden;position:absolute;top:2px;right:3px;">
            <a class="easyui-linkbutton" onclick="saveAuthority()" iconCls="icon-save">保存</a>
            <a class="easyui-linkbutton" onclick="selectAll()" iconCls="icon-ok">全选</a>
        </div>
    </s:if>
    
</div>
<div region='center' border='0' >
	<ul id="tt" style='padding:10px;'></ul>
</div>
<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/createOrgTree.js"></script>
<script type="text/javascript">
    $(function(){
       $('#tt').tree({
           url:'${contextPath}/system/authAuthorityAction!authRolePerSet.action?p_froleid=${p_froleid}&source=tree&fparentId=1',
           method:'post',
           animate:true,
           checkbox:true,
           lines:true,
           /* onBeforeExpand:function(node){
				$('#tt').tree('options').url='${contextPath}/system/authAuthorityAction!authRolePerSet.action?p_froleid=${p_froleid}&source=tree&fparentId='+node.id;
           }, */
           onLoadSuccess:function(node, data){
        	   //node && node.target ? $('#tt').tree('expandAll', node.target) : null;
        	   $('#tt').tree('expandAll');
           }
       });
       window.setTimeout(function(){
    	   var roots = $('#tt').tree('getRoots');
    	   $.each(roots, function(i, root){
    		   //root && root.target ? $('#tt').tree('expand', root.target) : null;
    		   $('#tt').tree('expand');
    	   }); 	   
       }, 500);
    });
    function expandAll(){
        var roots = $('#tt').tree('getRoots');
        $.each(roots,function(i,ele){
            $('#tt').tree('expandAll',roots[i].target);
        });

    }
    function selectAll(){
        var roots = $('#tt').tree('getRoots');
        $.each(roots,function(i,ele){
           $('#tt').tree('check',ele.target);
        });
    }
    function saveAuthority(){
        var nodes = $('#tt').tree('getChecked', ['checked','indeterminate']);
        // var nodes = $('#tt').getNodes();
        if(nodes.length > 0){
            var functions = '';
            for(var i = 0;i<nodes.length;i++){
                var nd = nodes[i];
                var json = $.parseJSON(nd.attributes);
                functions = functions + json.ffvalue + ",";
            }
            $.ajax({
                url:'${contextPath}/system/authAuthorityAction!authRolePerSave.action',
                type:'post',
                cache:false,
                data:{
                    'functions':functions,
                    'froleid':'${p_froleid}'
                },
                success:function(data){
                    if(data=='1'){
                        top.$.messager.show({
                            title:'提示消息',
                            msg:"授权成功！",
                            timeout:5000,
                            showType:'slide'
                        });
                    }else{
                        top.$.messager.show({
                            title:'提示消息',
                            msg:"授权失败！",
                            timeout:5000,
                            showType:'slide'
                        });
                    }
                }
            });
        }else{
            top.$.messager.show({
                title:'提示消息',
                msg:"请先选择要授权的菜单！",
                timeout:5000,
                showType:'slide'
            });
        }
    }
</script>
</body>
</html>