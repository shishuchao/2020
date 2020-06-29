<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
<title> 可控角色设置</title>
    <link href="<%=request.getContextPath()%>/resources/css/site.css" rel="stylesheet" type="text/css">
    <script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
    <script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/resources/js/normal.js"></script>
    <script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/resources/js/common.js"></script>
<script language="javascript">
function checkSubmit(){
    var all = "";
    $("#s2 option").each(function() {
        all += $(this).attr("value")+",";
    });
    $.ajax({
        url:'<%=request.getContextPath()%>/system/authAuthorityAction!authCtrlRoleUpdate.action',
        cache:false,
        type:'post',
        data:{
            'roles':all,
            'froleid':'${param.p_froleid}'
        },
        success:function(data){
            if(data == 'success'){
                top.$.messager.show({
                    title:'提示消息',
                    msg:'可控角色保存成功!',
                    timeout:5000,
                    showType:'slide'
                });
            }else{
                top.$.messager.show({
                    title:'提示消息',
                    msg:'可控角色保存失败!',
                    timeout:5000,
                    showType:'slide'
                });
            }
        }
    });
}

$(function(){
    $('#b1').click(function(){
        $obj = $('select option:selected').clone(true);
        if($obj.size() == 0){
            $.messager.show({title:'提示信息',msg:'请至少选择一条！'});
        }
        $('#s2').append($obj);
        $('select option:selected').remove();
    });

    $('#b2').click(function(){
        $('#s2').append($('#s1 option'));
    });

    $('#b3').click(function(){
        $obj = $('select option:selected').clone(true);
        if($obj.size() == 0){
            $.messager.show({title:'提示信息',msg:'请至少选择一条！'});
        }
        $('#s1').append($obj);
        $('select option:selected').remove();
    });

    $('#b4').click(function(){
        $('#s1').append($('#s2 option'));
    });

    $('option').dblclick(function(){
        var flag = $(this).parent().attr('id');
        if(flag == "s1"){
            var $obj = $(this).clone(true);
            $('#s2').append($obj);
            $(this).remove();
        } else {
            var $obj = $(this).clone(true);
            $('#s1').append($obj);
            $(this).remove();
        }
    });

});
</script>
</head>
<body class="easyui-layout" style="overflow: hidden;" fit="true">
<div region="center" style="overflow: hidden;">
    <div align="left" style="margin: 10px;">
        <a class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="checkSubmit()">保存</a>
    </div>
    <div>
        <img src="<%=request.getContextPath()%>/resources/images/tip.gif" border=0>&nbsp;<b>当前角色：&nbsp;${requestScope.p_frolename}</b>
    </div>
    <div style="float: left;width:45%" >
        <select id="s1" name="s1" size="15" style="width:100%">
            <s:iterator value="#request.authCtrlRoleL" id="froleid">
                <option value="<s:property value="froleid"/>"><s:property value="fname"/></option>
            </s:iterator>
        </select>
    </div>
    <div align="center" style="float: left;width:10%" >
        <p><input id="b1" type="button" class="s1" value="&nbsp;&gt;&nbsp;" /></p>
        <p><input type="button" id="b2" class="s1" value="&gt;&gt;" /></p>
        <p><input type="button" id="b3" class="s1" value="&nbsp;&lt;&nbsp;" /></p>
        <p><input type="button" id="b4" class="s1" value="&lt;&lt;" /></p>
    </div>
    <div style="float: left;width:45%">
        <select id="s2" name="s2" size="15" style="width:100%">
            <s:iterator value="#request.authCtrlRoleR" id="froleid">
                <option value="<s:property value="froleid"/>"><s:property value="fname"/></option>
            </s:iterator>
        </select>
    </div>
</div>
</body>
</html>