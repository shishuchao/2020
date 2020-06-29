<!DOCTYPE HTML>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
    <base href="<%=basePath%>">

    <title>My JSP 'code_name_tree.jsp' starting page</title>

    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="This is my page">
    <script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
    <script type="text/javascript">
        var proType = '<%=request.getParameter("proType")%>';
        $(function(){
            var type = '<%=request.getParameter("type")%>';
            $('#tree').tree({
                animate:true,
                method:'post',
                lines:true,
                dnd:false,
                cascadeCheck:true,
                //url: '/ais/basic/codename/queryCodeNameTree.action?type=' + type,
                onClick:function(node){
                }
                <s:if test="${param.check ne 1}">
                ,url: '/ais/basic/codename/queryCodeNameTree.action?type=' + type
                ,checkbox:false
                ,onDblClick:function(node){
                    if(node.leaf == '1') {
                        window.parent.saveF();
                    } else {
                        $.messager.alert('系统提示',"该类别下存在子类别,请选择子类别",'warning');
                        return;
                    }
                }
                </s:if>
                <s:else>
                ,url: '/ais/basic/codename/queryCodeNameTree.action?type=' + type + '&typevalue=${param.typevalue}'
                ,checkbox:true
                </s:else>
            });
        });
        function saveF(){
            var code_value = '';
            var name_value = '';
            var ayy = [];

            <s:if test="${param.check ne 1}">
            var node = $('#tree').tree('getSelected');
            if (node) {
                var leaf = node.leaf;
                if(leaf == '0'){
                    $.messager.alert('系统提示',"该类别下存在子类别,请选择子类别",'warning');
                    return;
                }
                var code = node.attributes;
                var name = node.text;
                code_value = code;
                name_value = name;
                var pnode = $("#tree").tree('getParent',node.target);
                if(pnode){
                    code_value+=','+pnode.attributes;
                    name_value=pnode.text+','+name_value;
                }
                ayy.push(code_value);
                ayy.push(name_value);
                return ayy;
            }else{
                $.messager.alert('系统提示',"请选择一个节点",'warning');
                return;
            }
            </s:if>
            <s:else>
            var checkedNodes = $('#tree').tree('getChecked');
            if (checkedNodes && checkedNodes.length>0) {
                for(var i=0; i<checkedNodes.length; i++) {
                    var node = checkedNodes[i];
                    var code = node.attributes;
                    var name = node.text;

                    code_value += (code_value==''?'':',') + code;
                    name_value += (name_value==''?'':',') + name;
                }
                ayy.push(code_value);
                ayy.push(name_value);
                return ayy;
            }else{
                $.messager.alert('系统提示',"请选择项目类别",'warning');
                return;
            }
            </s:else>
        }

        function unCheck(){
            var checkedNodes = $('#tree').tree('getChecked');
            if (checkedNodes && checkedNodes.length>0) {
                for(var i=0; i<checkedNodes.length; i++) {
                    $('#tree').tree('uncheck', checkedNodes[i].target);
                }
            }
        }
    </script>
</head>
  
<body class="easyui-layout">
    <div region="center" style="overflow:auto;">
        <br>
        <div fit="true" border="false">
            <ul id="tree"></ul>
        </div>
        <br>
    </div>
</body>
</html>
