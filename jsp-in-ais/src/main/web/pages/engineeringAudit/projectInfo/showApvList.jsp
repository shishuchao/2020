<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML >
<html>
<title>工程项目批复信息</title>
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
	var editUrl = '${contextPath}/ea/project/editApv.action';
	var tabTitle = isView ? "查看" : "编辑";
	var adjustBtn = {   
            text:'调整',
            iconCls:'icon-edit',
            handler:function(){
            	var row =$('#projectApvList').datagrid('getChecked')[0];
            	if(row){            		
	            	if(row.apvType=="原始"){
	            		aud$openNewTab("批复调整", editUrl+"?apvId="+row['apvId']+(isView ? "&view=true" : "")+"&display=true",true);
	            	}else{
	            		showMessage1("只能调整原始批复！");
	            	}
            	}else{
            		showMessage1("请选择原始批复进行调整！");
            	}
            }
        };
	var cusToolbar = [];
	if(!isView){
		cusToolbar.push(adjustBtn);
		cusToolbar.push("-");
	}
	var gridTableId = "projectApvList";
    var g1 = new createQDatagrid({
        // 表格dom对象，必填
        gridObject:$('#'+gridTableId)[0],
        // 要进行检索的表对象(hibernate bean)名称， 进行拼接hql时使用; 必填
        boName:'ProjectApv',
        // 对象主键,删除数据时使用-默认为“id”；必填
        pkName:'apvId',
        whereSql:'pid=\'${param.pid}\'',
        order :'asc',
        sort  :'apvType',
		winWidth:800,
	    winHeight:250,
    	// 删除前的校验，如果返回true可以删除，否则为false
    	beforeRemoveRowsFn:function(rows, datagridObj){
    		var result = true;
    		if(rows){			
    			for(var i=0; i<rows.length; i++){
    				var row = rows[i];
    				if(row.apvType=="原始"){
    					showMessage1("不能删除原始批复！");
    					result = false;
    				}
    			}
    		}
    		return result;
    	},
	    //自定义显示哪些按钮：myToolbar:['delete', 'export', 'search', 'reload'],
	    myToolbar:isView ? ['export', 'search', 'reload'] : ['delete', 'export', 'search', 'reload'],
        // 表格控件dataGrid配置参数; 必填
        gridJson:{
        	toolbar:cusToolbar,
            onClickCell:function(rowIndex, field, value){
                if(field == 'initApvFileName'){		
                    var rows = $(this).datagrid('getRows');
                    var row = rows[rowIndex];
                    $(this).datagrid('unselectRow',rowIndex);
                    $(this).datagrid('uncheckRow',rowIndex);
						aud$openNewTab("批复信息", editUrl+"?apvId="+row['apvId']+"&view=${view}", true);
                }
            },	
    		columns:[[
    			{field:'apvId',  title:'选择',checkbox:true,  align:'center', halign:'center', show:'false', hidden:isView},
                {field:'initApvNum',title:'初始批复文号',    width:'120px',align:'center', halign:'center',sortable:true, oper:'like'},
                {field:'initApvFileName',title:'初始批复文件名称', width:'150px',align:'center', halign:'center',sortable:true,
                	formatter:formatterClick},
                {field:'apvType',title:'批复类型', width:'70px',align:'center', halign:'center',  sortable:true, show:false},                                
                {field:'apvYear',title:'批复年度', width:'70px',align:'center', halign:'center',sortable:true, show:false,
                	formatter:function(value){
                		return value + "年";
                	}
                },                
                {field:'initApvAmount',title:'批复金额(元)', width:'170px',align:'right',   halign:'center',sortable:true, show:false,formatter:aud$gridFormatMoney},
                {field:'apvAmountAdd',title:'追加批复金额(元)', width:'170px',align:'right',   halign:'center',sortable:true, show:false,formatter:aud$gridFormatMoney},
                {field:'apvAmountAll',title:'批复总金额(元)', width:'170px',align:'right',   halign:'center',sortable:true, show:false,formatter:aud$gridFormatMoney},                                
                {field:'constUnit',   title:'建设单位',  width:'25%',align:'left',   halign:'center',sortable:true, show:false}
          ]]
        }
    });    
    window.projectApvList = g1;
    
    // 按钮权限
    isView ? $('.editElement').hide() : $('.viewElement').hide();
    
    function formatterClick(value){
    	return  ["<label  style='cursor:pointer;color:blue;'>",value,"</label>"].join('') ;
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
	<table id='projectApvList'></table>

	<!-- 引入公共文件 -->
   <jsp:include flush="true" page="/pages/frReportFlow/ajaxloading.jsp" />
</body>
</html>