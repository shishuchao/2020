<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML>
<html>
<%-- <script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script> --%>
<script type="text/javascript">


// 初始化
$(function(){
	// 清空剪切板
//	window.clipboardData.setData('Text','');
	$("#zcfgDetailWrap").find("textarea").each(function(){
        autoTextarea ? autoTextarea(this) : null;
	});

    var clientW = document.documentElement.clientWidth  || document.body.clientWidth;
    var clientH =document.documentElement.clientHeight || document.body.clientHeight;
    var zcfgWin_w = clientW; 
    //zcfgWin_w = zcfgWin_w > 1000 ? 1000 : zcfgWin_w;
    var zcfgWin_h = clientH;
    
    var isFixed = true;


	// 打开政策法规树窗口
    $('#zcfgTreeSelectWrap').dialog({   
		width:zcfgWin_w,   
		height:zcfgWin_h,   
		modal:true,
		collapsible:true,
		maximizable:false,
		minimizable:false,
		closed:true,
        resizable:true,
		//fit:true,
        buttons: [{
            id:'clearSelectZcfgTreeNode',
            text:'清空',
            iconCls:'icon-empty'
        },{
           id:'closeSelectZcfgTreeNode',
           text:'关闭',
           iconCls:'icon-cancel'
        }]
	});
    $('#indexView').window({
        modal:true,
        fit:true,
        collapsible:false,
        maximizable:true,
        minimizable:false,
        resizable:true,
        closed:true
    });
    // 打开政策法规详细内容窗口
    $('#zcfgDetailWrap').dialog({   
		width:zcfgWin_w,   
		height:zcfgWin_h,   
		modal:true,
		collapsible:true,
		maximizable:false,
		minimizable:false,
        resizable:true,
		closed:true,
		fit:true,
        border:0,
        onOpen:function(){
            //alert(clientH/2 +'\n'+ zcfgWin_h/2   +'\n'+ $('body').scrollTop())
            /**/
            $('#zcfgDetailWrap').dialog('resize',{
                'left'  :clientW/2 - zcfgWin_w/2  + (isFixed ? 0 : $('body').scrollLeft()),
                'top'   :clientH/2 - zcfgWin_h/2  + (isFixed ? 0 : $('body').scrollTop())
            });
        },
        buttons: [{
            id:'sureAndCloseSelectZcfgTreeNode',
            text:'添加法规',
            iconCls:'icon-add'
        }/*,{
            id:'sureSelectZcfgTreeNode',
            text:'添加',
            iconCls:'icon-add'
        }*/,{
           id:'closeZcfgDetailWin',
           text:'关闭',
           iconCls:'icon-cancel'
        }]
	});
    // 查看 按钮调用
    function viewZcfgDetail(row){
        console.log(row);
		$('#zcfgDetailWrap').dialog('open');
        if(row){
            for(var p in row){
                $('#view_'+p).html(row[p]);
            }

        }
        //window.clipboardData.setData('Text','');
	};
	
	var projectId = $('#curProjectId').val();
    // 加载政策法规树
    $('#zcfgTreeSelect').tree({   
		url:"${contextPath}/adl/getZcfgTree.action?projectId="+projectId,
		lines:true,
        onClick:function(node){
            window.curNodeid = node.id;
			var nodeid = node.id;
			$("#nodeid").val(nodeid);
            reset2();
            fulltextSearch('1');
		}
	});
	
    function getSelectedNodeId(){
    	try{
	    	var node = $('#zcfgTreeSelect').tree('getSelected');
	    	if(!node){
	    		var roots = $('#zcfgTreeSelect').tree('getRoots');
	    		if(roots && roots.length){
		    		node = roots[0];   			
	    		}
	    	}
	    	return node ? node.id : "3"; // 如果为空查询根节点下面的全部法规		
    	}catch(e){
    		alert('getSelectedNodeId:\n'+e.message);
    	}
    }

    
    $('#nodeid').val(getSelectedNodeId());
	//查询
	showWin('dlgSearch');
	// 政策法规详细信息表格
	$('#zcfgDetailTab').datagrid({ 
        url:"${contextPath}/adl/getZcfgDetailList.action",
		queryParams:{
			"nodeid": $('#nodeid').val()
		},
        method:'post',
        border:false,
		rownumbers:true,
		pagination:true,
		striped:true,
        nowrap :true,
        singleSelect:true,
		fitColumns:true,
		remoteSort:true,
        fit:true,
		// 翻页选择后，能保留已经选的记录
		idField:'id',
        onClickCell:function(rowIndex, field, value){
            if(field == 'title'){
                var rows = $('#zcfgDetailTab').datagrid('getRows');
                var row = rows[rowIndex];
                row ? viewZcfgDetail(row) : '';
            }
        },
        onLoadSuccess: function() {
            /* var value = $('#fullText').val();
            if(typeof(value) == 'undefined') {
                $("<table><tr><td style='padding:0 8px'><label>全文检索:</label></td><td><input id='fullText' name='fullText'></td></tr></table>").prependTo($(this).datagrid('getPanel').find(".datagrid-toolbar"));
                $('#fullText').searchbox({
                    width : 180,
                    searcher : fulltextSearch,
                    prompt : '请输入内容'
                });
            } */
        },
		toolbar:[
           /* {
			id:'search',
			text:'查询',
			iconCls:'icon-search',
			handler:function(){
				searchWindShow('dlgSearch',750);
			},
		},*/
        ],
        frozenColumns:[[
            {field:'title',title:'名称',width:'250',sortable:true,halign:'center',align:'left',
                formatter:function(value,row,rowIndex){
                    return '<a href="javascript:void(0)" >'+row.title+'</a>';
                }
            },
            {field:'codification',
                title:'文号',
                halign:'center',
                align:'left',
                sortable:true,
                formatter:function(value,row,index){
                    return row.codification;
                }
            }
        ]],
        columns:[[
            {field:'category',
                title:'类别',
                halign:'center',
                align:'left',
                sortable:true,
                formatter:function(value,row,index){
                    return row.category;
                }
            },
            {field:'promulgationDept',
                title:'发文单位',
                halign:'center',
                align:'left',
                sortable:true,
                formatter:function(value,row,rowIndex){
                    return row.promulgationDept;
                }
            },
            {field:'promulgationDate',
                title:'发文时间',
                width:80,
                sortable:true,
                halign:'center',
                align:'right',
                formatter:function(value,row,rowIndex){
                    if(row.promulgationDate!=null){
                        return row.promulgationDate.substring(0, 10);
                    }
                }
            },
            {field:'summary',title:'效力级别',width:'60px',sortable:true,align:'center',
                formatter:function(value,row,index){
                    return row.summary;
                }
            },
            {field:'effective',title:'有效性',width:'50',sortable:true,align:'center',
                formatter:function(value,row,rowIndex){
                    return row.effective;
                }
            },
            {field:'sundept',
                title:'创建单位',
                width:80,
                halign:'center',
                align:'right',
                sortable:true,
                formatter:function(value,row,index){
                    return row.sundept;
                }
            },
            {field:'createDate',
                title:'创建时间',
                width:80,
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
	
	var value = $('#fullText').val();
    if(typeof(value) == 'undefined') {
        $("<table><tr><td style='padding:0 8px'><label>全文检索:</label></td><td><input id='fullText' name='fullText'></td></tr></table>").prependTo($('#zcfgTreeSelectWrap').find(".datagrid-toolbar"));
        //$("<table><tr><td style='padding:0 8px'><label>全文检索:</label></td><td><input id='fullText' name='fullText'></td></tr></table>").prependTo($(".datagrid-toolbar")[4]);
        $('#fullText').searchbox({
            width : 180,
            searcher : fulltextSearch,
            prompt : '请输入内容'
        });
    }
    
    // 注册按钮事件
	$('#clearSelectZcfgTreeNode').bind('click',function(){
		$('#zcfgTreeSelectWrap').dialog('close');
		var mcid = $('#lr_openZcfgTree').attr('mc');
		var dmid = $('#lr_openZcfgTree').attr('dm');
		$('#'+dmid+',#'+mcid).val('');	
		// add by qfucee, 2013.11.11, 把光标移动到文本内容的末尾
        var mcid = $('#lr_openZcfgTree').attr('mc');
		textMoveToEnd($('#'+mcid)[0]);
	});	
    
	$('#closeSelectZcfgTreeNode').bind('click',function(){
		$('#zcfgTreeSelectWrap').dialog('close');	
		// add by qfucee, 2013.11.11, 把光标移动到文本内容的末尾
        var mcid = $('#lr_openZcfgTree').attr('mc');
		textMoveToEnd($('#'+mcid)[0]);
	});	
	
	$('#closeZcfgDetailWin').bind('click',function(){
		$('#zcfgDetailWrap').dialog('close');
	});	
    
	
	$('#copySelectZcfgTreeNode').bind('click',function(){
		var txt = getSelectedWords();
		window.clipboardData.setData('Text',txt ? txt : '');
	});	
	
	$('#sureSelectZcfgTreeNode').bind('click',sureSelectZcfgTreeNodeFn);
    $('#sureAndCloseSelectZcfgTreeNode').bind('click',addFgAndClose);
    //添加法规并关闭详细页面
    function addFgAndClose(){
        sureSelectZcfgTreeNodeFn();
        $('#zcfgTreeSelectWrap').dialog('close');
        $('#zcfgDetailWrap').dialog('close');
    }
    window.addFgAndClose = addFgAndClose;

    // 将引用法规内容添加到问题定性依据中
    function sureSelectZcfgTreeNodeFn(){
        var rows = $('#zcfgDetailTab').datagrid('getSelections');
        /*alert(rows+' '+rows.length);*/
        if (rows && rows.length > 0) {
            // 获得剪切板的内容
            /*var clip = window.clipboardData;
            var txt = clip.getData("Text");*/
            //获取选中内容
            var clipTxt = window.getSelection().toString();
            clipTxt = clipTxt.replace(/<.*?>/g, "");
            if (clipTxt == null || clipTxt == '') {
                window.top.$.messager.show({
                    title: "提示信息",
                    msg: "请先选择要引用的法规，并【选中】，再【添加】！",
                    timeout: 5000,
                    showType: 'slide'
                });
                return;
            }
            var mcArr = [];
            $.each(rows, function (i, row) {
                var content = row.content;
                content = html2Txt(clipTxt ? clipTxt : (content ? content.substr(0, 30) : ''));
                var textArr = [];
                textArr.push('该问题违反<<');
                textArr.push(row.title.replace(/<.*?>/g, ""));
                textArr.push('>>[');
                textArr.push(row.codification.replace(/<.*?>/g, ""));
                textArr.push(']');
                textArr.push(row.promulgationDate.substr(0, 10));
                textArr.push('，关于"');
                textArr.push(content);
                textArr.push('"的规定。\n');
                mcArr.push(textArr.join(''));
            });
            var mcid = $('#lr_openZcfgTree').attr('mc');
            //var dmid = $('#lr_openZcfgTree').attr('dm');
            //$('#'+dmid).val($('#'+dmid).val()+row.id);
            //$.messager.alert('提示信息','成功添加法规：\n'+mcArr.join(''),'info');
            $('#' + mcid).val(mcArr.join('') + $('#' + mcid).val());
            //$('#zcfgTreeSelectWrap').dialog('close');
            // 清空剪切板
            /*clip.setData('Text','');*/
            // add by qfucee, 2013.11.8
            textMoveToEnd($('#' + mcid)[0]);
        } else {
            window.top.$.messager.alert('提示信息', '请选择记录!', 'error');
            return false;
        }
    }
    
	$('#lr_openZcfgTree').bind('click',function(){     
		// 清空剪切板
		//window.clipboardData.setData('Text','');
		$('#zcfgTreeSelectWrap').dialog('open');
		$('#zcfgDetailTab').datagrid('unselectAll');
		$('#zcfgDetailTab').datagrid('uncheckAll');

		/**/
		$('#zcfgTreeSelectWrap').dialog('resize',{
            'left'  :clientW/2 - zcfgWin_w/2  + (isFixed ? 0 : $('body').scrollLeft()),
            'top'   :clientH/2 - zcfgWin_h/2  + (isFixed ? 0 : $('body').scrollTop())
		});
        $('#zcfgTreeSelect').tree('expand', $('#zcfgTreeSelect').tree('getRoot').target);
	});

});
/**
desc: 返回页面选择的文本并返回
      跨浏览器，适合IE，Firefox等
date: 2013.11.6
author: qfucee
*/
function getSelectedWords(){
   try{
      //alert(window.getSelection());
      var appName = navigator.appName;
      if(appName && appName.toLowerCase().indexOf('microsoft') != -1){//只适用于Microsoft IE
        return document.selection.createRange().text;
      }else{//适合于非IE浏览器
        return window.getSelection().toString();
      }
   }catch(e){
      alert('getWords - '+e.message);
   }
}


// 把光标移动到obj.value的末尾， add by qfucee, 2013.11.8
function textMoveToEnd(obj,pos){
	if(obj){
	    try{
	        obj.focus();
	        var len = pos ? parseInt(pos) : obj.value.length;
	        if (document.selection){
	            var sel = obj.createTextRange();
	            sel.moveStart('character',len);
	            sel.collapse();
	            sel.select();
	        } else if (typeof obj.selectionStart == 'number' && typeof obj.selectionEnd == 'number') {
	            obj.selectionStart = obj.selectionEnd = len;
	        }
	    }catch(e){
	        //alert(e.message);
	    }
	}
}

//用s2替换掉字符串中所有的s1
String.prototype.replaceAll = function (s1,s2){
	s1 = s1+"";
	s2 = s2+"";
	var reg = new RegExp(s1,"gi");
	return this.replace(reg,s2);
}

function html2Txt(txt){
	if(txt){
		return  txt.replaceAll(' ','').replaceAll('<p>','').replaceAll('</p>','').replaceAll('<br/>','');
	}
	return "";
}
function mSearchSub(){
	getZcfgDetailList('');
}

function reset2(){
	setNull("assistSuportLawslib.title");
	setNull("assistSuportLawslib.codification");
	$('#promulgationDate').combo('setText',''); 
	$('#effctiveDate').combo('setText','');
	$('#invalidationDate').combo('setText','');
	setNull("assistSuportLawslib.promulgationDept");
	setNull("assistSuportLawslib.effective");
	setNull("assistSuportLawslib.content");
	
}
function setNull(name){document.getElementsByName(name)[0].value="";}
// end

function doSearch(){
	getZcfgDetailList('');
	$('#dlgSearch').dialog('close');
}

//全文检索查询
    function fulltextSearch(type){
        if(type == '1') {
            $("#zcfgDetailTab").datagrid('options').queryParams =
                {"nodeid": $('#nodeid').val()};
            $('#zcfgDetailTab').datagrid('reload');
        } else {
            var fullText = $("#fullText").val();
            if(fullText != null &&fullText != "") {
                $("#zcfgDetailTab").datagrid('options').queryParams =
                    {"nodeid": $('#nodeid').val(),
                        "fulltext": fullText};
                $('#zcfgDetailTab').datagrid('reload');
                $('#fullText').searchbox('setValue',fullText);
            } else {
                $("#zcfgDetailTab").datagrid('options').queryParams =
                    {"nodeid": $('#nodeid').val()};
                $('#zcfgDetailTab').datagrid('reload');
            }
        }
    }
//根据法律法规类别id查询法律法规
function getZcfgDetailList(param){
	var pageSize = $("#zcfgDetailTab").datagrid('getPager').pagination("options").pageSize;
	var pageNumber = $("#zcfgDetailTab").datagrid('getPager').pagination("options").pageNumber;
    // 每次重新查询时，默认从第一页开始
    //$("#zcfgDetailTab").datagrid('getPager').pagination('options').pageNumber = 1;
	//var contion = jQuery("#searchForm").serialize()+param+"&rows="+pageSize+"&page="+pageNumber;
	var arr = $("#searchForm").serializeArray();
    var jsonStr = "";

    jsonStr += '{';
    for (var i = 0; i < arr.length; i++) {
        jsonStr += '"' + arr[i].name + '":"' + arr[i].value + '",'
    }
    if(param != null&&param!='')
   	 jsonStr += param;
    else
    	jsonStr = jsonStr.substring(0, (jsonStr.length - 1));
    jsonStr += '}';
    var json = eval("("+jsonStr+")");
    var _content = document.getElementsByName("assistSuportLawslib.content")[0].value;
   /* if(_content != null && _content != ""){
        var myurl = '${contextPath}/pages/assist/suport/lawsLib/indexSearch_flfg_view.action?'+$("#searchForm").serialize()+'&t='+new Date().getTime()
        $("#indexFrame").attr("src",myurl);
        $('#indexView').window('open');

    }else{*/
        $('#zcfgDetailTab').datagrid({
            queryParams:json
        });

	<%--$.ajax({
        dataType:'json',
        url : "<%=request.getContextPath()%>/adl/getZcfgDetailList.action",
        data: contion,
        type: "POST",
        beforeSend: function(){ },
        success: function(data){
            // 加载返回的数据，生成table					
            $('#zcfgDetailTab').datagrid('loadData',data);
            if(data.type != 'success' && data.msg){
                //$.messager.alert('提示',data.msg, 'info');
            }
            // 更新查询条件
            $("#zcfgDetailTab").datagrid('options').queryParams = {
                "nodeid": $('#nodeid').val()
            };
        },
        error:function(data){
            top.$.messager.alert('提示信息','请求失败！','error');
        }
    });--%>
}
/**
重置
*/	
function restal(){
	resetForm('searchForm');
	//doSearch();
}
    function saveF(){
        var ayy = $('#item_ifr')[0].contentWindow.saveF();
        /*var res = ayy[0].split(',');
        var name = ayy[1].split(',');*/
        document.all('pro_type_name').value=ayy;
        closeWin()
    }
    function cleanF(){
        document.all('pro_type_name').value='';
        closeWin();
    }
    function closeWin(){
        $('#subwindow').window('close');
    }
    function getItem(url,title,width,height){
        generateWin('subwindow');
        $('#item_ifr').attr('src',url);
        openWin('subwindow',title,width,height);
    }
/*
* 取消
*/
function doCancel(){
	$('#dlgSearch').dialog('close');
}

</script>
<body class="easyui-layout" style="overflow:hidden;" fit="true" border='0'>
    <!-- 政策法规树 -->
	<div id='zcfgTreeSelectWrap' title='引用法规制度' style='overflow:hidden;' >
        <div id="zcfgTreeSelectWrap_layout" class="easyui-layout" fit="true" border="0">
            <div region='west' split="true" border="false" title="法规类别" style="width:330px;overflow:hidden;">
                <ul id='zcfgTreeSelect' class='easyui-tree' style='padding:10px;overflow:auto;height:480px;'></ul>
            </div>
            <div region='center' split="true" border="false"  style="overflow:hidden;">
                <div class="easyui-layout" fit="true" border="false" style="margin: 0;padding: 0;overflow:hidden;">
                    <div id="dlgSearch" class="searchWindow">
                        <div class="search_head">
                            <s:form id="searchForm" name="searchForm">
                                <s:token/>
                                <table id="searchTable" class="ListTable" style="overflow:hidden;padding:0px;margin:0px;">
                                    <tr>
                                        <td class="EditHead">名称</td>
                                        <td class="editTd">
                                            <s:textfield cssStyle="width:160px;" cssClass="noborder"
                                                         name="assistSuportLawslib.title" maxlength="100"/>
                                        </td>
                                        <td class="EditHead">文号</td>
                                        <td class="editTd">
                                            <s:textfield cssStyle="width:160px;" cssClass="noborder"
                                                         name="assistSuportLawslib.codification" maxlength="100" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="EditHead">正文</td>
                                        <td class="editTd"><s:textfield cssStyle="width:160px;" cssClass="noborder"
                                                                        name="assistSuportLawslib.content" maxlength="100"/>
                                        </td>
                                        <td class="EditHead">
                                            类别
                                        </td>
                                        <td class="editTd">
                                            <div>
                                                <s:textfield cssClass="noborder" readonly="true" name="assistSuportLawslib.category"  id="pro_type_name" cssStyle="width:150px" />
                                                <img style="cursor:hand;border:0" src="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png"
                                                     onclick="getItem('/ais/pages/assist/suport/lawsLib/searchdate_flfg.jsp','选择类别',500,400)"></img>
                                            </div>
                                        </td>

                                    </tr>
                                    <tr>

                                        <td class="EditHead">发文单位</td>
                                        <td class="editTd"><s:textfield cssStyle="width:160px;" cssClass="noborder"
                                                                        name="assistSuportLawslib.promulgationDept"  maxlength="100"/>
                                        </td>
                                        <td class="EditHead">
                                            发文时间
                                        </td>
                                        <td class="editTd">
                                            <input name="assistSuportLawslib.promulgationDateStart"
                                                   type="text" editable="false" class="easyui-datebox" style="width: 110px"/>到
                                            <input name="assistSuportLawslib.promulgationDateEnd"
                                                   type="text" editable="false" class="easyui-datebox" style="width: 110px"	/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="EditHead">
                                            效力级别
                                        </td>
                                        <td class="editTd">
                                            <select class="easyui-combobox" editable="false" name="assistSuportLawslib.summary" style="width:80%;"  data-options="panelHeight:75">
                                                <option value="">&nbsp;</option>
                                                <s:iterator value="basicUtil.effectiveLevelList" id="entry">
                                                    <s:if test="${assistSuportLawslib.summary==name}">
                                                        <option selected="selected" value="${name }">${name}</option>
                                                    </s:if>
                                                    <s:else>
                                                        <option value="<s:property value="name"/>"><s:property value="name"/></option>
                                                    </s:else>
                                                </s:iterator>
                                            </select>
                                        </td>
                                        <td class="EditHead">时效性</td>
                                        <td class="editTd">
                                            <select id="" class="easyui-combobox" name="assistSuportLawslib.effective" style="width:160px;" editable="false" panelHeight="auto">
                                                <option value="">&nbsp;</option>
                                                <option value="有效">有效</option>
                                                <option value="无效">无效</option>
                                            </select>
                                        </td>
                                    </tr>
                                    <s:hidden name="nodeid" id="nodeid"></s:hidden>
                                </table>
                            </s:form>
                        </div>
                        <div class="serch_foot" >
                            <div class="search_btn" style="text-align:right">
                                <a class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="doSearch()"> 查询</a>&nbsp;
                                <a class="easyui-linkbutton" data-options="iconCls:'icon-reload'" onclick="restal()">重置</a>&nbsp;
                                <a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="doCancel()">取消</a>
                            </div>
                        </div>
                    </div>
                    <div region='center' border="false">
                        <table id='zcfgDetailTab'>
                        </table>
                    </div>
                    <div id="indexView" title="法律法规正文查询" style='overflow:hidden;margin:0px;padding:0px;'>
                        <iframe id="indexFrame" name="indexFrame" title="法律法规正文查询结果" src="" width="100%" height="100%" frameborder="0"></iframe>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- 政策法规详细信息 -->
    <div id='zcfgDetailWrap' name='zcfgDetailWrap' title='政策法规详细内容' style='margin:0px;text-align:center;'>
        <div class="easyui-layout" border='0'  style='height:100%'>
            <div region='center' border='0'>
                <table class="ListTable"  align='center' style="border:0;" >
                    <tr>
                        <td class="editTd" style="border: none;"><div style="float:left;">文号：</div><div id='view_codification'></div></td>
                        <td class="editTd" style="border: none;"><div style="float:left;">发文单位：</div><div id='view_promulgationDept'></div></td>
                        <td class="editTd" style="width:25%;border: none; "><div style="float:left;">发文时间：</div><div id='view_promulgationDate'></div></td>

                        <td class="editTd" style="width:15%;border: none; "><div style="float:left;">效力级别：</div><div id='view_effective'></div></td>

                    </tr>
                    <tr>
                        <td colspan="4"><hr style="height:1px;border:none;border-top:1px solid #ccc;" /></td>
                    </tr>
                    <tr>
                        <td colspan="4"><br><h3 align="center"><div id='view_title'></div></h3></td>
                    </tr>
                    <tr>
                        <td colspan="4" >
                            <div id='view_content' style="height:100%;overflow:auto;"></div>
                        </td>
                    </tr>
                </table>
            </div>
	    </div>
    </div>

    <div id="subwindow" class="easyui-window" title="类别" style="width:500px;height:500px;padding:5px;" closed="true">
        <div class="easyui-layout" fit="true" border="false" style="overflow:hidden;">
            <div region="center" border="false" style="overflow:hidden;">
                <iframe id="item_ifr" name="item_ifr" src="" frameborder="0" width="100%" height="100%" scrolling="auto" ></iframe>
            </div>
            <div region="south" border="false" style="text-align:right;padding:5px 0;">
                <div style="display: inline;" align="right">
                    <a class="easyui-linkbutton" data-options="iconCls:'icon-ok'"   onclick="saveF()">确定</a>
                    <a class="easyui-linkbutton" data-options="iconCls:'icon-tip'"  onclick="cleanF()">清空</a>
                    <a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'"   onclick="closeWin()">关闭</a>
                </div>
            </div>
        </div>
    </div>
</body>
</html>