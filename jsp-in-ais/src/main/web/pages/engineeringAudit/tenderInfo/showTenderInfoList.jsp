<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML >
<html>
<title>招标信息添加、编辑、查看</title>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<script type="text/javascript" src="${contextPath}/easyui/boot.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/jquery-fileUpload.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/autosize.js"></script>
<script type="text/javascript" src="${contextPath}/easyui/contextmenu.js"></script>  
<script type="text/javascript" src="${contextPath}/pages/tlInteractive/tlInteractiveCommon.js"></script>
<script type="text/javascript">
$(function(){
	var isView = "${view}" == "true" || "${view}" == true ? true : false;
	var pid='${pid}';
	//是否从项目送审窗口打开
	var winSelect = "${winSelect}";
	var editUrl = '${contextPath}/ea/tenderInfo/editTender.action';
	var tabTitle = winSelect || isView ? "查看" : "编辑";
	
	function getParentWin(){
		var frameWin = aud$parentDialogWin();
		return frameWin.$('#dvAudProject').get(0).contentWindow;
	}
	
	var addBtn = {   
            text:'添加',
            iconCls:'icon-add',
            handler:function(){
            	aud$openNewTab('招标信息添加', editUrl + "?winSelect=${winSelect}&pid="+pid, true);
            }
        };
	var selectBtn = {   
            text:'选择',
            iconCls:'icon-ok',
            handler:function(){
            	var gridObj = $('#tenderInfoList');
            	var rows = gridObj.datagrid('getChecked');
            	if(rows != null && rows.length > 0){
            		var row = rows[0];
            		var tdId = row['tdId'];
            		var tdProjectNumber = row['tdProjectNumber'];
            		var tdProjectName = row['tdProjectName'];
            		//alert(tdId+"\n"+tdProjectNumber+"\n"+tdProjectName)
            		var parentWin = getParentWin();
            		parentWin.$('#select_tender_id').val(tdId);
            		parentWin.$('#ap_tdProjectNumber').val(tdProjectNumber);
            		parentWin.$('#ap_tdProjectName').val(tdProjectName);
            		aud$closeTopDialog();
            	}else{
            		showMessage1('请选择记录');
            	}
            }
		};
	var emptyBtn = {   
            text:'清空',
            iconCls:'icon-empty',
            handler:function(){
            	var parentWin = getParentWin();
            	parentWin.$('#select_tender_id').val('');
            	parentWin.$('#ap_tdProjectNumber').val('');
            	parentWin.$('#ap_tdProjectName').val('');
            	aud$closeTopDialog();
            }
        };
	var closeSelectWinBtn = {   
            text:'关闭',
            iconCls:'icon-cancel',
            handler:function(){
            	aud$closeTopDialog();
            }
        };
            	 
	var cusToolbar = [];
	if(winSelect){
		cusToolbar.push(selectBtn);
		cusToolbar.push('-');
		cusToolbar.push(emptyBtn);
		cusToolbar.push('-');
		cusToolbar.push(closeSelectWinBtn);
		cusToolbar.push('-');
	}else if(!isView){
		cusToolbar.push(addBtn);
		cusToolbar.push('-');
	}
	var gridTableId = "tenderInfoList";
    var g1 = new createQDatagrid({
        // 表格dom对象，必填
        gridObject:$('#'+gridTableId)[0],
        // 要进行检索的表对象(hibernate bean)名称， 进行拼接hql时使用; 必填
        boName:'TenderInfo',
        // 对象主键,删除数据时使用-默认为“id”；必填
        pkName:'tdId',
        whereSql:'pid=\'${pid}\'',
        order :'desc',
        sort  :'createTime',
		winWidth:800,
	    winHeight:250,
    	// 删除前的校验，如果返回true可以删除，否则为false
    	beforeRemoveRowsFn:function(rows, datagridObj){
    		return true;
    	},
	    //自定义显示哪些按钮：myToolbar:['delete', 'export', 'search', 'reload'],
	    myToolbar:isView || winSelect ? [ 'export', 'search', 'reload'] : [ 'delete', 'export', 'search', 'reload'],
        // 表格控件dataGrid配置参数; 必填
        gridJson:{	
        	singleSelect: winSelect ? true : false,
        	checkOnSelect:winSelect ? true : false,
        	selectOnCheck:winSelect ? true : false,
            toolbar:cusToolbar,
            onClickCell:function(rowIndex, field, value){
                if(field == 'tdProjectName'){		
                    var rows = $(this).datagrid('getRows');
                    var row = rows[rowIndex];
                    $(this).datagrid('unselectRow',rowIndex);
                    $(this).datagrid('uncheckRow',rowIndex);
					if(winSelect){
						aud$openNewTab("招标信息"+tabTitle, editUrl+"?winSelect=${winSelect}&tdId="+row['tdId']+"&view=true", true);
					}else{
                    	aud$openNewTab("招标信息"+tabTitle, editUrl+"?tdId="+row['tdId']+(isView ? "&view=true" : ""), true);
					}
                }
            },	
    		columns:[[
                {field:'tdId',  title:'选择',       width:'10px', checkbox:!isView,  align:'center', halign:'center', show:'false', hidden:isView},
                {field:'tdProjectName',title:'招标项目名称', width:'220px',align:'left',   halign:'center',  sortable:true, oper:'like',
                	formatter:formatterClick},
                {field:'tdProjectNumber',title:'招标项目编号', width:'150px',align:'left',   halign:'center',  sortable:true, oper:'like'},   
                {field:'inviteTdTime', title:'招标时间', width:'100px',align:'center', halign:'center',  sortable:true, show:false},
                {field:'publishTdTime',title:'发标时间', width:'100px',align:'center', halign:'center',  sortable:true, show:false},
                {field:'startTdTime',  title:'开标时间', width:'100px',align:'center', halign:'center',  sortable:true, show:false},
                {field:'tdControlCost',title:'招标控制价金额', width:'170px',align:'right', halign:'center',  sortable:true, show:false,formatter:aud$gridFormatMoney},
                {field:'acceptanceCost',title:'中标金额', width:'170px',align:'right',   halign:'center',  sortable:true, show:false,formatter:aud$gridFormatMoney},
                {field:'bidUnit',   title:'中标单位', width:'200px',align:'left',   halign:'center',  sortable:true,show:false},
                {field:'creator',   title:'创建人',   width:'110px', align:'center',  sortable:true, show:false},
                {field:'createTime',title:'创建日期', width:'100px',align:'center', halign:'center',sortable:true, show:false,
					formatter:formatterTime2Date},
                {field:'modifier',  title:'修改人',   width:'110px', align:'center',sortable:true, show:false},
                {field:'modifyTime',title:'修改日期', width:'100px',align:'center', halign:'center',sortable:true, show:false,
					formatter:formatterTime2Date}
          ]]
        }
    });
    
    window.tenderInfoList = g1;
    
    // 按钮权限
    isView ? $('.editElement').hide() : $('.viewElement').hide();

    function formatterTime2Date(value){
    	var rt = value;
    	if(value && value.length > 10){
    		rt = value.substr(0,10);
    	}	
    	return rt;
    }
    
    function formatterClick(value){
    	return  ["<label title='单击"+tabTitle+"' style='cursor:pointer;color:blue;'>",value,"</label>"].join('') ;
    }
    
    //把frame页面窗口ID赋给里面iframe，用于iframe里面的页面打开新窗口后，访问iframe
	setTimeout(function(){
		var topDialogTargetId = parent.aud$getActiveDialogTargetId();
		$('body').attr("topDialogTargetId", topDialogTargetId);
	},0)

});
</script>
</head>
<body style='padding:0px;margin:0px;overflow:hidden;' >
	<table id='tenderInfoList'></table>

	<!-- 引入公共文件 -->
   <jsp:include flush="true" page="/pages/frReportFlow/ajaxloading.jsp" />
</body>
</html>