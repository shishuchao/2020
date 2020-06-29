<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML >
<html>
<title>审计报告模板列表-工程审计</title>
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
	var gridTableId = "tenderInfoList";
    var g1 = new createQDatagrid({
        // 表格dom对象，必填
        gridObject:$('#'+gridTableId)[0],
        // 要进行检索的表对象(hibernate bean)名称， 进行拼接hql时使用; 必填
        boName:'CodeName',
        // 对象主键,删除数据时使用-默认为“id”；必填
        pkName:'tdId',
        whereSql:'type=\'6001\'',
        'plugId':'6001',
        order :'desc',
        sort  :'code',
		winWidth:800,
	    winHeight:250,
    	// 删除前的校验，如果返回true可以删除，否则为false
    	beforeRemoveRowsFn:function(rows, datagridObj){
    		/*
    		if(rows){			
    			for(var i=0; i<rows.length; i++){
    				var row = rows[i];
    				alert(row.attachmentId)
    			}
    		}*/
    		return true;
    	},
        // 表格控件dataGrid配置参数; 必填
        gridJson:{            
    		columns:[[
                {field:'code',title:'项目编码', width:'20%',align:'center',   halign:'center',  sortable:true, oper:'like'  },
                {field:'name',title:'项目类型', width:'40%',align:'center',   halign:'center',  sortable:true, oper:'like'},
                {field:'xxx',  title:'操作', width:'35%',align:'center',   halign:'center',sortable:true, show:false,
                	formatter:function(value,row,index){
                		var link = '<a href=\"javascript:void(0);\" onclick=\"reportList(\''+row.code+'\',\'report\')\">模板列表</a>';
						return link;
					 }
                }
          ]]
        }
    });
    
    window.tenderInfoList = g1;
    
    // 删除按钮权限
    g1.batchSetBtn([ {'id':gridTableId+'_remove','remove':true} ]);
    // 查询按钮权限
    g1.batchSetBtn([ {'id':gridTableId+'_search','remove':true} ]);
});
//模板列表
function reportList(projectTypeCode,fromType) {
	var url = "<%=request.getContextPath()%>/pages/unitary/nc/report/reportTemplateList.jsp?projectTypeCode="+projectTypeCode+"&fromType="+fromType;
	aud$openNewTab('审计报告-模板列表',url);
}
</script>
</head>
<body style='padding:0px;margin:0px;overflow:hidden;' >
	<table id='tenderInfoList'></table>

	<!-- 引入公共文件 -->
   <jsp:include flush="true" page="/pages/frReportFlow/ajaxloading.jsp" />
</body>
</html>