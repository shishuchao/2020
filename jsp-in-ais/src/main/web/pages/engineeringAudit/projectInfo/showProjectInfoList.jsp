<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML >
<html>
<title>工程项目信息</title>
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
	//是否从项目送审窗口打开
	var winSelect = "${winSelect}";
	//var editUrl = '${contextPath}/ea/project/editProInfo.action';
	var frameUrl = '${contextPath}/ea/project/showFrame.action';
	var tabTitle = winSelect || isView ? "查看" : "编辑";
	var addBtn = {   
            text:'添加',
            iconCls:'icon-add',
            handler:function(){
            	if(winSelect) {
            		aud$openNewTab('工程项目信息添加', frameUrl + "?winSelect=${winSelect}", true);
            	}else {
            		aud$openNewTab('工程项目信息添加', frameUrl, true);
            	}
            }
        };
	
	function getParentWin(){
		var frameWin = aud$parentDialogWin();
		return frameWin.$('#dvAudProject').get(0).contentWindow;
	}
	
	function clearParent(){
    	var parentWin = getParentWin();
		parentWin.$('#select_proInfo_id').val('');
		parentWin.$('#ap_eaProjectNum').val('');
		parentWin.$('#ap_eaProjectName').val('');
		/* 清空招标信息 */
		parentWin.$('#ap_tdProjectNumber').val('');
		parentWin.$('#select_tender_id').val('');
		parentWin.$('#ap_tdProjectName').val('');
		/* 清空合同信息 */
		parentWin.$('#ap_ctNumber').val('');
		parentWin.$('#select_contract_id').val('');
		parentWin.$('#ap_ctName').val('');
		return parentWin;
	}
	
	var selectBtn = {   
           text:'选择',
           iconCls:'icon-ok',
           handler:function(){
	           	var gridObj = $('#proInfoList');
	           	var rows = gridObj.datagrid('getChecked');
	           	if(rows != null && rows.length > 0){
	           		var row = rows[0];
	           		var pid = row['pid'];
	           		var eaProjectNum = row['eaProjectNum'];
	           		var eaProjectName = row['eaProjectName'];
	           		var parentWin = clearParent();
	           		parentWin.$('#select_proInfo_id').val(pid);
	           		parentWin.$('#select_proInfo_ids').val(pid);
	           		parentWin.$('#ap_eaProjectNum').val(eaProjectNum);
	           		parentWin.$('#ap_eaProjectName').val(eaProjectName);

	           		queryApvForAuditProject(row['pid'], parentWin);
	           		aud$closeTopDialog();
	           	}else{
	           		showMessage1('请选择记录');
	           	}
       	  }
	};
	
	//查询批复信息, 填充到审计项目中
	function queryApvForAuditProject(projectId, parentWin){
		$.ajax({
			url : "${contextPath}/commonPlug/queryBeans.action",
			dataType:'json',
			type: "post",
			async:false,
			data:{
				'beanName':'ProjectApv',
				'query_eq_pid':projectId
			},
			success: function(data){
				var boList = data.boList;
				if(boList != null && boList.length){
					var bolen = boList.length;
					if(bolen == 1){
						var bo = boList[0];
		           		parentWin.$('#ap_audCost').val(bo.initApvAmount);
		           		parentWin.$('#ap_approvalCost').val(bo.apvAmountAll);
					}else{						
						for(var i = 0; i < bolen; i++){
							var bo = boList[i];
							if(bo.apvType == '原始'){
				           		parentWin.$('#ap_audCost').val(bo.initApvAmount);
				           		parentWin.$('#ap_approvalCost').val(bo.apvAmountAll);
				           		break;
							}
						}
					}
				}
			},
			error:function(data){
				top.$.messager.show({title:'提示信息',msg:'请求失败！请检查网络配置或者与管理员联系！'});
			}
		});
		
	}
	
	var emptyBtn = {   
            text:'清空',
            iconCls:'icon-empty',
            handler:function(){
            	clearParent();
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
		cusToolbar.push(addBtn);
		cusToolbar.push('-');
	}else if(!isView){
		cusToolbar.push(addBtn);
		cusToolbar.push('-');
	}
	var gridTableId = "proInfoList";
    var g1 = new createQDatagrid({
        // 表格dom对象，必填
        gridObject:$('#'+gridTableId)[0],
        // 要进行检索的表对象(hibernate bean)名称， 进行拼接hql时使用; 必填
        boName:'ProjectInfo',
        // 对象主键,删除数据时使用-默认为“id”；必填
        pkName:'pid',
        order :'desc',
        sort  :'createTime',
		winWidth:800,
	    winHeight:250,
    	// 删除前的校验，如果返回true可以删除，否则为false
    	beforeRemoveRowsFn:function(rows, datagridObj){
    		var result=true;
    		if(rows){			
    			for(var i=0; i<rows.length; i++){
    				var row = rows[i];
    				if(row.auditStatus=="已审"){
    					showMessage1("只能删除未审状态的工程项目！","提示");
    					result=false;
    				}
    			}
    		}
    		return result;
    	},
        // 表格控件dataGrid配置参数; 必填
        gridJson:{	
        	singleSelect: winSelect ? true : false,
        	checkOnSelect:winSelect ? true : false,
        	selectOnCheck:winSelect ? true : false,
            toolbar:cusToolbar,
            onClickCell:function(rowIndex, field, value){
                if(field == 'eaProjectName'){		
                    var rows = $(this).datagrid('getRows');
                    var row = rows[rowIndex];
                    $(this).datagrid('unselectRow',rowIndex);
                    $(this).datagrid('uncheckRow',rowIndex);
					if(winSelect){
						aud$openNewTab("工程项目信息"+tabTitle, frameUrl+"?winSelect=${winSelect}&pid="+row['pid']+"&view=true", true);
					}else{
						aud$openNewTab("工程项目信息"+tabTitle, frameUrl+"?pid="+row['pid']+(isView ? "&view=true" : ""), true);
					}
                }
            },	
            frozenColumns:[[
            	
    			{field:'pid',title:'选择',width:'10px', checkbox:!isView,  align:'center', halign:'center', show:'false', hidden:isView},
                {field:'eaProjectName',title:'工程项目名称', width:'180px',align:'left',   halign:'center',  sortable:true, oper:'like',
                	formatter:formatterClick},                                
                {field:'eaProjectNum',title:'工程项目编号', width:'150px',align:'center', halign:'center',sortable:true},
                {field:'auditStatus',title:'审计状态',    width:'70px',align:'center', halign:'center',sortable:true, show:false}
            ]],
    		columns:[[
                {field:'eaType', title:'工程类型', width:'100px',align:'center', halign:'center',sortable:true, show:false},                
                {field:'eaProperty',   title:'工程性质', width:'100px',align:'center',  halign:'center',sortable:true, show:false},
                {field:'initApvAmount',title:'批复金额', width:'180px',align:'right',   halign:'center',sortable:true, show:false, exportType:"AMOUNT",
					formatter:aud$gridFormatMoney},
                {field:'constUnit',title:'建设单位', width:'180px',align:'left',   halign:'center',sortable:true, show:false},
                {field:'buildUnit',title:'施工单位', width:'180px',align:'left',   halign:'center',sortable:true, show:false},
                {field:'designUnit',title:'设计单位',width:'180px',align:'left',   halign:'center',sortable:true, show:false},
                {field:'superUnit',title:'监理单位', width:'180px',align:'left',   halign:'center',sortable:true, show:false}                
          ]]
        }
    });    
    window.proInfoList = g1;
    
    // 按钮权限
    isView ? $('.editElement').hide() : $('.viewElement').hide();
    // 删除按钮权限
    isView || winSelect ? g1.batchSetBtn([ {'id':gridTableId+'_remove','remove':true} ]) : null;
    // 查询按钮权限
    //g1.batchSetBtn([ {'id':gridTableId+'_search','remove':true} ]);

    
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
});
</script>
</head>
<body style='padding:0px;margin:0px;overflow:hidden;' >
	<table id='proInfoList'></table>

	<!-- 引入公共文件 -->
   <jsp:include flush="true" page="/pages/frReportFlow/ajaxloading.jsp" />
</body>
</html>