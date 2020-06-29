<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML >
<html>
<title>合同信息</title>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/createOrgTree.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>  
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/common.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jquery-fileUpload.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/autosize.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/pages/tlInteractive/tlInteractiveCommon.js"></script>
<script type="text/javascript">
$(function(){
	var isView = "${view}" == "true" || "${view}" == true ? true : false;
	var pid='${pid}';
	//是否从项目送审窗口打开
	var winSelect = "${winSelect}";
	var editUrl = '${contextPath}/ea/contractInfo/editContractInfo.action';
	
	var tabTitle = winSelect || isView ? "查看" : "编辑";
	
	function getParentWin(){
		var frameWin = aud$parentDialogWin();
		return frameWin.$('#dvAudProject').get(0).contentWindow;
	}
	
	var addBtn = {   
            text:'添加',
            iconCls:'icon-add',
            handler:function(){
            	aud$openNewTab('合同信息添加', editUrl + "?winSelect=${winSelect}&pid="+pid, true);
            }
        };
	
	var selectBtn = {   
            text:'选择',
            iconCls:'icon-ok',
            handler:function(){
            	var gridObj = $('#contractInfoList');
            	var rows = gridObj.datagrid('getChecked');
            	if(rows != null && rows.length > 0){
            		var row = rows[0];
            		var ctId = row['ctId'];
            		var ctNumber = row['ctNumber'];
            		var ctName = row['ctName'];
            		var parentWin = getParentWin();
            		parentWin.$('#select_contract_id').val(ctId);
            		parentWin.$('#ap_ctNumber').val(ctNumber);
            		parentWin.$('#ap_ctName').val(ctName);
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
            	parentWin.$('#select_constract_id').val('');
            	parentWin.$('#ap_ctNumber').val('');
            	parentWin.$('#ap_ctName').val('');
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
	var gridTableId = "contractInfoList";
	// 显示工程项目表单
    var g1 = new createQDatagrid({
        // 表格dom对象，必填
        gridObject:$('#'+gridTableId)[0],
        // 要进行检索的表对象(hibernate bean)名称， 进行拼接hql时使用; 必填
        boName:'ContractInfo',
        // 对象主键,删除数据时使用-默认为“id”；必填
        pkName:'ctId',
        whereSql:'pid=\'${pid}\'',
        order :'desc',
        sort  :'createTime',
		winWidth:800,
	    winHeight:250,
        // 表格控件dataGrid配置参数; 必填
        gridJson:{	
        	singleSelect: winSelect ? true : false,
            checkOnSelect:winSelect ? true : false,
            selectOnCheck:winSelect ? true : false,
            toolbar:cusToolbar,
            onClickCell:function(rowIndex, field, value){
            	if(field == 'ctName'){		
            		var rows = $(this).datagrid('getRows');
                    var row = rows[rowIndex];
                    $(this).datagrid('unselectRow',rowIndex);
                    $(this).datagrid('uncheckRow',rowIndex);
        			if(winSelect){
        				aud$openNewTab("合同信息"+tabTitle, editUrl+"?winSelect=${winSelect}&ctId="+row['ctId']+"&view=true", true);
        			}else{
        				aud$openNewTab("合同信息"+tabTitle, editUrl+"?ctId="+row['ctId']+(isView ? "&view=true" : ""), true);
        			}
                }
            },	            	
    		columns:[[
                {field:'ctId',  title:'选择',width:'10px', checkbox:!isView,  align:'center', halign:'center', show:'false', hidden:isView},
                {field:'ctNumber',title:'合同编号',    width:'100px',align:'center', halign:'center',sortable:true, oper:'like'},
                {field:'ctName',title:'合同名称', width:'150px',align:'left',   halign:'center',  sortable:true, oper:'like',
                	formatter:formatterClick	},                                
                {field:'ctType', title:'合同类型', width:'100px',align:'center', halign:'center',sortable:true, show:false},                
                {field:'ctAttr', title:'合同属性', width:'100px',align:'center', halign:'center',sortable:true, show:false},
                {field:'ctPartA',title:'合同甲方', width:'100px',align:'left',   halign:'center',sortable:true, show:false},
                {field:'ctPartB',title:'合同乙方', width:'80px', align:'center', halign:'center',sortable:true, show:false},
                {field:'ctSigningAmount', title:'合同签订金额',    width:'170px',align:'right',   halign:'center',sortable:true, show:false,formatter:aud$gridFormatMoney},
                {field:'acceptanceCost',  title:'中标金额', width:'170px',align:'right',   halign:'center',sortable:true, show:false,formatter:aud$gridFormatMoney}
          ]]
        }
    });
    window.contractInfoList = g1;

    // 按钮权限
    isView ? $('.editElement').hide() : $('.viewElement').hide();
    // 删除按钮权限
    isView || winSelect ? g1.batchSetBtn([ {'id':gridTableId+'_remove','remove':true} ]) : null;    
    
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
<body style='padding:0px;margin:0px;overflow:hidden;' class='easyui-layout' fit='true' border='0'>
	<table id='contractInfoList'></table>
	<!-- 引入公共文件 -->
   <jsp:include flush="true" page="/pages/frReportFlow/ajaxloading.jsp" />   
</body>
</html>