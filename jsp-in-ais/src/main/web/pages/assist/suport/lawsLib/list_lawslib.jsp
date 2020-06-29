<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE HTML>
<html>
<head><meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <title>法律法规</title>
    <script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
    <script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>


    <SCRIPT type="text/javascript"  src="${contextPath}/scripts/calendar.js"></SCRIPT>
    <script type="text/javascript" src="${contextPath}/scripts/checkboxsoperation.js"></script>
    <script type='text/javascript' src='${pageContext.request.contextPath}/scripts/dwr/DWRActionUtil.js'></script>
    <script type='text/javascript' src='${pageContext.request.contextPath}/dwr/interface/DWRAction.js'></script>
    <script type='text/javascript' src='${pageContext.request.contextPath}/dwr/engine.js'></script>
    <script type='text/javascript' src='${pageContext.request.contextPath}/scripts/turnPage.js'></script>
    <script type="text/javascript" src="${contextPath}/resources/csswin/subModal.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/pages/introcontrol/util/jquery-1.7.1.min.js"></script>
    <link href="${contextPath}/resources/css/common.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        div.datagrid-cell {
            text-overflow:ellipsis;
        }
    </style>
</head>
<body onload="messageinit()" style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout" border='0'>
<div id="dlgSearch" class="searchWindow">
    <div class="search_head">
        <s:form action="delete" namespace="/pages/assist/suport/lawsLib" method="post" name="lawsForm" id="lawsForm">
            ${message}
            <%@include file="/pages/assist/suport/lawsLib/include_search3.jsp"%>
        </s:form>
    </div>
    <div class="serch_foot">
        <div class="search_btn">
            <a class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>&nbsp;
            <a class="easyui-linkbutton" data-options="iconCls:'icon-reload'" onclick="restal()">重置</a>&nbsp;
            <a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="doCancel()">取消</a>
        </div>
    </div>
</div>
<div id="qwjs" <%--style="display: none"--%>>
    <table>
        <tr>
            全文检索&nbsp;&nbsp;&nbsp;
            <s:form action="search" namespace="/pages/assist/suport/lawsLib" method="post" id="fulltextForm">
                <s:hidden name="fulltext" id="fulltext1"></s:hidden>
                <s:hidden name="querySource" value="grid"></s:hidden>
                <s:hidden name="m_view" value="edit"></s:hidden>
                <s:hidden name="nodeid" value="${nodeid}"></s:hidden>
                <s:hidden name="marked" value="0"></s:hidden>
                <s:if test="m_view!=null&&m_view=='view'">
                    <a class="easyui-linkbutton" data-options="iconCls:'icon-edit'"  name="assistSuportLawslib.pub_state" >Y</a>
                </s:if>
            </s:form>
        </tr>
    </table>
</div>
<div id="layerCenter" region="center" border='0'>
    <table id="objectList" ></table>
</div>
<div id="layer" style="display: none" align="center">
    <img src="${contextPath}/images/uploading.gif">
    <br>
    正在读取，请稍候......
</div>
<div id="query_div" title="法规文件导入" style='overflow:hidden;padding:3px;'>
    <s:form action="importFlfg" namespace="/pages/assist/suport/lawsLib" method="POST" name="uploadForm" id="uploadForm" enctype="multipart/form-data" onsubmit="return validateSubmit()">
        <s:hidden name="nodeid" id="nodeid"/>
        <table cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
            <tr>
                <td align="left" class="EditHead" style="width:55%;text-align: left">
                    上传文件
                </td>
            </tr>
            <tr>
                <td class="editTd" align="left" style="width:55%;">
                    <s:file name="upload" cssStyle="font-size:15px;width: 570px;height:20px"/>&nbsp;&nbsp;&nbsp;&nbsp;
                    <a href="javascript:" class="easyui-linkbutton" data-options="iconCls:'icon-import'" onclick="saveLib()">上传</a>
                </td>
            </tr>
            <tr>
                <td><font style="color: red">*允许导入html/txt/word文件类型的zip包，其中文件夹名称为依据类别名</font></td>
            </tr>
        </table>
    </s:form>
    <div align="left" id="errorInfo1">
        <s:if test="%{#tipList.size != 0}">
            <s:iterator value="%{#tipList}">
                <font color="#FF0000">&nbsp;&nbsp;&nbsp;●<s:property value="%{position}"/>：<s:property value="%{errorInfo}"/></font><br>
            </s:iterator>
        </s:if>
    </div>
    <div align="left" id="errorInfo2">
        <s:if test="%{#tipMessage != null}">
            <font color="#FF0000">&nbsp;&nbsp;&nbsp;●<s:property value="%{#tipMessage.errorInfo}"/></font>
        </s:if>
    </div>
</div>

<div id="syyZip" title="审友云Zip包导入" style='overflow:hidden;padding:3px;'>
    <s:hidden name="nodeid" id="nodeid" value="${nodeid}"/>
    <s:form action="importSyyZip.action" namespace="/pages/assist/suport/lawsLib" method="POST" name="uploadSyyZipForm" id="uploadSyyZipForm" enctype="multipart/form-data" onsubmit="return validateSyyZipSubmit()">
        <table cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
            <tr>
                <td align="left" class="EditHead" style="width:55%;text-align: left">
                    上传文件
                </td>
            </tr>
            <tr>
                <td class="editTd" align="left" style="width:55%;">
                    <s:file name="upload" cssStyle="font-size:15px;width: 570px;height:20px"/>&nbsp;&nbsp;&nbsp;&nbsp;
                    <a href="javascript:" class="easyui-linkbutton" data-options="iconCls:'icon-import'" onclick="saveSyyZip()">上传</a>
                </td>
            </tr>
            <tr>
                <td><font style="color: red">*允许导入审友云下载的zip包</font></td>
            </tr>
        </table>
    </s:form>
</div>


<div id="viewContext" title="法律法规查看" style='overflow:hidden;margin:0px;padding:0px;'>
    <iframe id="contextFrame" name="contextFrame" title="法律法规查看" src="" width="100%" height="100%" frameborder="0"></iframe>
</div>
<div id="editLawslib" title="编辑法律法规" style='overflow:hidden;margin:0px;padding:0px;'>
    <iframe id="editLawslibFrame" name="editLawslibFrame" title="编辑法律法规" src="" width="100%" height="100%" frameborder="0"></iframe>
</div>
<div id="attributeSetting" title="批量属性设置" style='overflow:hidden;padding:0px;'>
    <div id="item1" >
        <form id ="attributeSettingForm" method="POST">
            <table>
                <tr>
                    <td class="EditHead" style="width: 130px;">
                        发文单位
                    </td>
                    <td class="editTd" style="width: 400px;">
                        <input class="noborder" type="text" id = "promulgationDept" name="assistSuportLawslib.promulgationDept" style="width: 310px;"/>
                    </td>
                </tr>
                <tr>
                    <td class="EditHead" style="width: 130px;">
                        效力级别
                    </td>
                    <td class="editTd" style="width: 400px;">
                        <select  id="summary" class="easyui-combobox" editable="false" name="assistSuportLawslib.summary" style="width:80%;"  data-options="panelHeight:75">
                            <option value="">&nbsp;</option>
                            <s:iterator value="basicUtil.effectiveLevelList" id="entry">
                                <s:if test="${assistSuportLawslib.summary==name}">
                                    <option selected="selected" value="${name }">${name}</option>
                                </s:if>
                                <s:else>
                                    <option value="${name }">${name }</option>
                                </s:else>
                            </s:iterator>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td class="EditHead" style="width: 130px;">
                        时效性
                    </td>
                    <td class="editTd"   style="width: 400px;" >
                        <select id = "effective" class="easyui-combobox" editable="false" name="assistSuportLawslib.effective" style="width:80%;" editable="false" data-options="panelHeight:75">
                            <option value="">&nbsp;</option>
                            <s:iterator value="#@java.util.LinkedHashMap@{'有效':'有效','无效':'无效'}" id="entry">
                                <option value="<s:property value="key"/>"><s:property value="value"/></option>
                            </s:iterator>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td class="EditHead" style="width: 130px;">
                        <font color="red">*</font>类别
                    </td>
                    <td class="editTd" style="width: 400px">
                        <s:buttonText2 id="category" hiddenId="category" cssClass="noborder"
                                       name="assistSuportLawslib.category"
                                       hiddenName="assistSuportLawslib.categoryFk"
                                       doubleOnclick="showSysTree(this,{
		                                  title:'请选择法律法规类别',
		                                  type:'tree',
		                                  onlyLeafClick:true,
										  param:{
										    'serverCache':false,
										  	'rootId':'3',
						                    'beanName':'AssistSuportLawslibMenu',
						                    'treeId'  :'id',
						                    'treeText':'category_name',
						                    'treeParentId':'parent_id',
						                    'treeOrder':'priority'
						                 }
									})"
                                       doubleSrc="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png"
                                       doubleCssStyle="cursor:pointer;border:0"
                                       readonly="true"
                                       title="法规类别" maxlength="1500"/>
                    </td>
                </tr>
            </table>
        </form>
    </div>
    <div style='text-align:center;' id='shareBtnDiv' style='padding: 20px;'>
        <a  id='saveId'  class="easyui-linkbutton"  iconCls="icon-save">保存</a>&nbsp;&nbsp;&nbsp;&nbsp;
        <a  id='closeAttributeSetting' class="easyui-linkbutton"  iconCls="icon-cancel">关闭</a>
    </div>
</div>

<script type="text/javascript">
    function messageinit(){
        ${malert};
    }
    function reset2(){
        setNull("assistSuportLawslib.title");
        setNull("assistSuportLawslib.codification");
        setNull("assistSuportLawslib.promulgationDate");
        setNull("assistSuportLawslib.effctiveDate");
        setNull("assistSuportLawslib.invalidationDate");
        setNull("assistSuportLawslib.promulgationDept");
        setNull("assistSuportLawslib.category");
        setNull("assistSuportLawslib.effective");
        setNull("assistSuportLawslib.categoryFk");
    }

    function mydelSubmit(){
        if(mydelCheck()){
            $.messager.confirm('确认', '确认删除吗？', function(r){
                if (r){
                    lawsForm.submit();
                }else{
                    return false;
                }
            });
        }else{
            return false;
        }
    }

    function downloadFlfg(){
        if(mydelCheck()){
            $.messager.confirm('确认', '确认下载吗？', function(r){
                if (r){
                    lawsForm.action="downloadFlfg.action";
                    lawsForm.submit();
                }else{
                    return false;
                }
            });
        }else{
            return false;
        }
    }

    function downloadFlfgSort(){
        $.messager.confirm('确认', '确认下载吗？', function(r){
            if (r){
                lawsForm.action="downloadFlfgSort.action";
                lawsForm.submit();
            }else{
                return false;
            }
        });
    }

    function downloadFlfgAll(){
        $.messager.confirm('确认', '确认下载吗？', function(r){
            if (r){
                lawsForm.action="downloadFlfgAll.action";
                lawsForm.submit();
            }else{
                return false;
            }
        });
    }

    function myeditSubmit(){
        if(myeditCheck()){
            var sd=document.getElementsByName("assistSuportLawslib.id");
            /*lawsForm.action="edit.action?assistSuportLawslib.id="+sd.value;
            lawsForm.submit();*/
            url="../lawsLib/edit.action?assistSuportLawslib.id="+sd.value;
            $("#editLawslibFrame").attr("src",url);
            /*$('#objectList').datagrid("reload");*/
            $("#editLawslib").window('open');
        }else{
            return false;
        }
    }
    function editRow(id) {
        var url="../lawsLib/edit.action?assistSuportLawslib.id=" + id;
        $("#editLawslibFrame").attr("src",url);
        $("#editLawslib").window('open');
    }
    function myaddSubmit(){
        var treeObj = parent.$('#zcfgTreeSelect');
        var node = treeObj.tree('find', '${nodeid}');
        if(node == null) {
            showMessage1('只有选择左侧树才能添加法规！','提示信息','4000');
        } else {
            var isleaf = treeObj.tree("isLeaf", node.target);
            if(isleaf){
                url="../lawsLib/add.action?mCodeType=${mCodeType}&nodeid=${nodeid}&marked=0";
                window.location=url;
            }else{
                showMessage1('左侧树只有末级类别才能添加法规！','提示信息','4000');
            }
        }
    }
    function mydelCheck(){
        var rows=$('#objectList').datagrid('getSelections');
        var j=0;
        var ids="";
        for(var i=0,size=rows.length;i<size;i++){
            ids = ids + rows[i].id+",";
            j=j+1;
        }
        if(j<1){
            showMessage1('请先选中记录再进行操作！','消息','4000');
            return  false;
        }
        document.getElementById("ids").value=ids;
        return true;
    }
    function myeditCheck(){
        var rows2=$('#objectList').datagrid('getSelections');
        var j=0;
        var id=document.getElementsByName("assistSuportLawslib.id");
        for(var i=0;i<rows2.length;i++){
            //alert(rows2[i].upman +"\n"+ "${user.floginname}")
            id.value=rows2[i].id+",";
            //同级别的用户可以进行修改
            j++
        }
        if(j<1){
            showMessage1('请先选择一条记录在进行修改！','提示信息','4000');
            return false;
        }
        if(j>1){
            showMessage1('修改操作只能选择一条记录进行修改！','提示信息','4000');
            return false;
        }
        return true;
    }
    //批量发布  撤销批量发布
    function mypub(status){
        if(status=="Y"){
            url="../lawsLib/publish.action?mCodeType=${mCodeType}&nodeid=${nodeid}&listpub=Y&marked=0";
        }
        else{
            url="../lawsLib/publish.action?mCodeType=${mCodeType}&nodeid=${nodeid}&listpub=N&marked=0";
        }
        var chkboxs=$('#objectList').datagrid('getSelections');
        var counter=0;
        var ids ="";

        for(var i=0;i<chkboxs.length;i++){
            if(chkboxs[i].pub_state!=status){
                ids=ids+chkboxs[i].id+",";
                counter++;
            }
        }

        if(counter<1){
            if(status==="Y"){
                showMessage1('请至少选择一条未发布记录进行发布！','提示信息','0');
            }else{
                showMessage1('请至少选择一条已发布记录进行撤销发布！','提示信息','0');
            }
            return false;
        }

        //window.location= url + "&ids=" + ids + "&backUrl=${backUrl}";
        $.ajax({
            url : url + "&ids=" + ids + "&backUrl=${backUrl}",
            type: "post",
            success: function(data){
                showMessage1('发布成功!');
                $('#objectList').datagrid('reload');
            },
            error:function(data){
                $.messager.alert('提示信息','请求失败,请检查网络是否通畅或者与管理员联系！','error');
            }
        });

    }
    //查询
    function mSearchSub(){
        document.forms[0].action="search.action";
        document.forms[0].submit();
    }

    function createindex(){
        DWREngine.setAsync(true);
        DWRActionUtil.execute(
            { namespace:'/pages/assist/suport/lawsLib', action:'createIndex', executeResult:'false' },
            {  },
            xxx);
        function xxx(data){
            if(data['createStatus'] != null && data['createStatus'] == '1'){
                showMessage1('索引创建成功','消息','4000');
            }
        }
    }

    function attributeSetting() {
        var chkboxs=$('#objectList').datagrid('getSelections');
        if(chkboxs.length>0){
            $('#attributeSetting').window('open');
        }else{
            showMessage2("请至少选择一条记录进行属性设定");
        }
    }
    function validateSubmit(){
        var filePath = document.uploadForm.upload.value;
        if(filePath==""){
            alert("请选择上传的文件！");
            return false;
        }
        if(filePath.lastIndexOf('.zip') == -1){
            alert('请上传.zip压缩文件');
            return false;
        }
        return true;
    }

    function validateSyyZipSubmit(){
        var filePath = document.uploadSyyZipForm.upload.value;
        if(filePath==""){
            alert("请选择上传的文件！");
            return false;
        }
        if(filePath.lastIndexOf('.zip') == -1){
            alert('请上传.zip压缩文件');
            return false;
        }
        return true;

    }
    function impDate(){
        var treeObj = parent.$('#zcfgTreeSelect');
        var node = treeObj.tree('find', '${nodeid}');
        if(node == null) {
            showMessage1('只有选择左侧树才能导入法规！','提示信息');
        } else {
            // var isleaf = treeObj.tree("isLeaf", node.target);
            // if(isleaf){
            //     $("#nodeid").val(nodeid);
            //     $('#query_div').window('open');
            // }else{
            //     showMessage1('左侧树只有末级类别才能导入法规！','我的消息');
            // }
            $("#nodeid").val(nodeid);
            $('#query_div').window('open');
        }
    }


    function importSYYZip() {
        $('#syyZip').window('open');
    }
    
    
    function importAllLaws() {
        if(!window.confirm("请确认导入审有云所有的法律法规吗?如果确认,公共的法规将被删除重新导入"))
            return false;

        var lawsUrl = '${contextPath}/pages/assist/suport/lawsLib/importAllLaws.action';
        window.location = lawsUrl;


    }

    function saveSyyZip(){
        $("#uploadSyyZipForm").submit();
        $('#syyZip').window('close');
    }

    function saveLib(){
        $("#uploadForm").submit();
        $('#query_div').window('close');
    }

    function fulltextSearch(){
        var fulltext = $("#fullText").searchbox('getValue');
        $('#fulltext1').val(fulltext);
        $('#objectList').datagrid({
            queryParams:form2Json('fulltextForm')
        });
        $('#fullText').searchbox('setValue',fulltext);
    }

    function viewContext (curId){
        $(".tooltip").remove();
        var keywords = encodeURI($("#fulltext1").val());
        var url = '${contextPath}/pages/assist/suport/lawsLib/viewContext.action?id='+curId+'&content='+searchParam+'&keywords='+keywords+'';
        $("#contextFrame").attr("src",url);
        $('#objectList').datagrid("reload");
        $("#viewContext").window('open');
    }

    function generateZIP(){
        $.messager.confirm('确认','生成压缩包需要较长时间，可能会影响系统的使用，建议在非使用高峰期运行，是否继续？',function(r){
            if (r){
                $('#layerCenter').hide();
                $('#layer').show();
                $.ajax({
                    dataType:'JSON',
                    type:'POST',
                    url:'${contextPath}/pages/assist/suport/lawsLib/generateZIP.action',
                    async:true,
                    success:function(data){
                        $('#layerCenter').show();
                        $('#layer').hide();
                        if(data == '1') {
                            $.messager.alert('提示信息','法律法规压缩成功！','info');
                        } else {
                            $.messager.alert('提示信息','法律法规压缩失败！','info');
                        }
                    }
                });
            }else{
                return false;
            }
        });
    }
</script>
<script type="text/javascript">
    var nodeid=$("input[name=nodeid]").val();
    $(function(){
        var bodyW = $('body').width();
        var tempWidth = document.body.clientWidth;
        var tempHeight = document.body.clientHeight;
        showWin('dlgSearch');
        $('#query_div').window({
            width:800,
            height:150,
            modal:true,
            collapsible:false,
            maximizable:false,
            minimizable:false,
            closed:true
        });

        $('#syyZip').window({
            width:800,
            height:150,
            modal:true,
            collapsible:false,
            maximizable:false,
            minimizable:false,
            closed:true
        });
        $('#viewContext').window({
            width:tempWidth,
            height:tempHeight,
            modal:true,
            collapsible:false,
            maximizable:false,
            minimizable:false,
            resizable:true,
            maximized:true,
            closed:true
        });
        $('#editLawslib').window({
            width:tempWidth,
            height:tempHeight,
            modal:true,
            collapsible:false,
            maximizable:false,
            minimizable:false,
            resizable:true,
            maximized:true,
            closed:true
        });
        $('#attributeSetting').window({
            title:"批量属性设置",
            width:600,
            height:230,
            modal:true,
            border:0,
            collapsible:false,
            maximizable:true,
            minimizable:false,
            closed:true
        });

        $('body').show();

        // 初始化生成表格
        $('#objectList').datagrid({
            url : "<%=request.getContextPath()%>/pages/assist/suport/lawsLib/search.action?m_view=edit&querySource=grid&mCodeType=${mCodeType}&nodeid="+nodeid,
            method:'post',
            rownumbers:true,
            pagination:true,
            striped:true,
            autoRowHeight:false,
            fit: true,
            fitColumns:false,
            idField:'id',
            border:false,
            singleSelect:false,
            pageSize:50,
            pageList:[50,100,150,200],
            remoteSort: true,
            onBeforeLoad: function () {
                $(this).datagrid('rejectChanges');
            },
            onLoadSuccess: function() {
                var value = $('#fullText').val();
                if(typeof(value) == 'undefined') {
                    $("<table><tr><td style='padding:0 8px'><label>全文检索:</label></td><td><input id='fullText' name='fullText'></td></tr></table>")
                        .prependTo(
                            $(this).datagrid('getPanel').find(".datagrid-toolbar")
                        );
                    $('#fullText').searchbox({
                        width : 180,
                        searcher : fulltextSearch,
                        prompt : '请输入内容'
                    });
                }
            },
            toolbar:[
                {
                    id:'search',
                    text:'查询',
                    iconCls:'icon-search',
                    handler:function(){
                        searchWindShow('dlgSearch',750);
                    }
                },
                {
                    id:'toAdd',
                    text:'新增',
                    iconCls:'icon-add',
                    handler:function(){
                        myaddSubmit();
                    }
                },
                {
                    id:'toDelete',
                    text:'删除',
                    iconCls:'icon-delete',
                    handler:function(){
                        mydelSubmit();
                    }
                },
                {
                    id:'toFaBu',
                    text:'批量发布',
                    iconCls:'icon-recover',
                    handler:function(){
                        mypub('Y');
                    }
                },
                {
                    id:'toCheXiao',
                    text:'批量撤销发布',
                    iconCls:'icon-cancel',
                    handler:function(){
                        mypub('N');
                    }
                }
                ,{
                    id:'toSuoYin',
                    text:'生成索引',
                    iconCls:'icon-edit',
                    handler:function(){
                        createindex();
                    }
                }
                ,{
                    id:'toSetAttribute',
                    text:'批量属性设置',
                    iconCls:'icon-edit',
                    handler:function(){
                        attributeSetting();
                    }
                },
                {
                    id:'toImportDatePackage',
                    text:'文件导入',
                    iconCls:'icon-import',
                    handler:function(){
                        impDate();
                    }
                },
                {
                    id:'toImportSYYZip',
                    text:'审友云zip包导入',
                    iconCls:'icon-import',
                    handler:function(){
                        importSYYZip();
                    }
                },
                /*{
                    id:'SyyToManage',
                    text:'恢复默认法律法规',
                    iconCls:'icon-import',
                    handler:function(){
                        importAllLaws();
                    }
                }*/
                /* {
                    id:'toGenerateZIP',
                    text:'生成全部法规压缩包',
                    iconCls:'icon-edit',
                    handler:function(){
                        generateZIP();
                    }
                } */
            ],
            frozenColumns:[[
                {field:'id',width:'50', checkbox:true, align:'center'},
                {field:'title',title:'名称',width:bodyW*0.15+'px',sortable:true,halign:'center',align:'left',
                    formatter:function(value,row,rowIndex){
                        return '<a href="javascript:void(0)" onclick="editRow(\''+row.id+'\');">'+row.title+'</a>';
                    }
                },
                {field:'codification',
                    title:'文号',
                    halign:'center',
                    align:'left',
                    width:bodyW*0.12+'px',
                    sortable:true,
                    formatter:function(value,row,index){
                        return row.codification;
                    }
                },
                {field:'category',
                    title:'类别',
                    halign:'center',
                    align:'left',
                    width:bodyW*0.12+'px',
                    sortable:true,
                    formatter:function(value,row,index){
                        return row.category;
                    }
                }
            ]],
            columns:[[
                {field:'promulgationDept',
                    title:'发文单位',
                    halign:'center',
                    align:'left',
                    width:bodyW*0.1+'px',
                    sortable:true,
                    formatter:function(value,row,rowIndex){
                        return row.promulgationDept;
                    }
                },

                {field:'promulgationDate',
                    title:'发文时间',
                    width:bodyW*0.1+'px',
                    sortable:true,
                    halign:'center',
                    align:'center',
                    formatter:function(value,row,rowIndex){
                        if(row.promulgationDate!=null){
                            return row.promulgationDate.substring(0, 10);
                        }
                    }
                },
                {field:'effctiveDate',
                    title:'实施日期',
                    width:bodyW*0.1+'px',
                    sortable:true,
                    halign:'center',
                    align:'center',
                    formatter:function(value,row,rowIndex){
                        if(row.effctiveDate!=null){
                            return row.effctiveDate.substring(0, 10);
                        }
                    }
                },
                {field:'summary',title:'效力级别', width:bodyW*0.1+'px',sortable:true,align:'center',
                    formatter:function(value,row,index){
                        return row.summary;
                    }
                },
                {field:'effective',title:'时效性', width:bodyW*0.1+'px',sortable:true,align:'center',
                    formatter:function(value,row,rowIndex){
                        return row.effective;
                    }
                },
                {field:'pub_state',
                    title:'发布状态',
                    width:bodyW*0.1+'px',
                    align:'center',
                    sortable:true,
                    formatter:function(value,row,index){
                        if(row.pub_state=='Y'){
                            return '是';
                        }else{
                            return '否';
                        }
                    }
                },
                {field:'sundept',
                    title:'创建单位',
                    width:bodyW*0.1+'px',
                    halign:'center',
                    align:'left',
                    sortable:true,
                    formatter:function(value,row,index){
                        return row.sundept;
                    }
                },
                {field:'createDate',
                    title:'创建时间',
                    width:bodyW*0.1+'px',
                    halign:'center',
                    align:'center',
                    sortable:true,
                    formatter:function(value,row,index){
                        if(row.createDate!=null){
                            return row.createDate.substring(0, 10);
                        }
                    }
                }
            ]]
        });

        $('#objectList').datagrid('doCellTip', {
            onlyShowInterrupt: true,
            position: 'bottom',
            maxWidth: '200px',
            tipStyler: {
                'backgroundColor': '#EFF5FF',
                borderColor: '#95B8E7',
                boxShadow: '1px 1px 3px #292929'
            }
        });
        //保存事件
        $('#saveId').bind('click',function() {
            var chkboxs = $('#objectList').datagrid('getSelections');
            var ids = "";
            for (var i = 0; i < chkboxs.length; i++) {
                ids = ids + "," + chkboxs[i].id;
            }
            ids = ids.slice(1);
            var category = $("#category").val();
            var dept = $("#promulgationDept").val();
            var effective = $("#effective");
            var summary = $("#summary").val();
            if (category == "") {
                showMessage2("类别不能为空");
            } else {
                $.ajax({
                    dataType: 'json',
                    type: "POST",
                    url: "/ais/pages/assist/suport/lawsLib/attributeSetting.action?ids=" + ids + "",
                    data: $('#attributeSettingForm').serialize(),
                    success: function (data) {
                        if (data.status === "success") {
                            $('#attributeSetting').window('close');
                            showMessage2("设置成功！");
                            $('#objectList').datagrid('reload');
                        } else {
                            showMessage2("保存失败！");
                        }
                    },
                    error: function (data) {
                        showMessage2("请求失败！");
                    }
                });
            }

        });

        //关闭按钮
        $('#closeAttributeSetting').bind('click',function(){
            $('#attributeSetting').window('close');
        });
    });
</script>
</body>

</html>
