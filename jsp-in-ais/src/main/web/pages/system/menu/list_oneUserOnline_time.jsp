<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<jsp:directive.page import="ais.framework.util.UUID"/>

<html>
<title>在线时间详情</title>
<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
	<link href="<%=request.getContextPath()%>/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
	<link href="<%=request.getContextPath()%>/resources/css/common.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/createOrgTree.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>  
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/common.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/pages/tlInteractive/tlInteractiveCommon.js"></script> 
<script type="text/javascript">

$(function(){
	var bodyW = $('body').width();    
    var startTime = '${startTime}';
	var endTime = '${endTime}';
	var isOracle = '${isOracle}';
	var sql = "(logouttime is not null or logouttime != '') and loginName='${floginname}'";
	if(startTime != null && startTime != '') {
		if(isOracle == '1') {
			sql += " and to_char(logintime,'yyyy-MM-dd') >= '"+startTime+"'";
		} else {
			sql += " and date_format(logintime.time,'%Y-%m-%d') >= '"+startTime+"'";
		}
	}
	if(endTime != null && endTime != '') {
		if(isOracle == '1') {
			sql += " and to_char(logintime,'yyyy-MM-dd') <= '"+endTime+"'"
		} else {
			sql += " and date_format(logintime.time,'%Y-%m-%d') <= '"+endTime+"'";
		}
	}
    frloadOpen();
    var g1 = new createQDatagrid({
        // 表格dom对象，必填
        gridObject:$('#sDTable')[0],
        // 要进行检索的表对象(hibernate bean)名称， 进行拼接hql时使用; 必填
        boName:'OnLineUserRecord',
        // 对象主键,删除数据时使用-默认为“id”；必填
        pkName:'sessionId',
        whereSql: sql,
        order:'desc',
        sort:'loginTime',
        winWidth:800,
        winHeight:250,
        gridJson:{    
            checkOnSelect:false,
            selectOnCheck:false,
            singleSelect:false,
            onLoadSuccess:frloadClose,
            columns:[[
				{field:'loginName',title:'用户账号', width:bodyW*0.1 + 'px',align:'left',halign:'center',sortable:true},
				{field:'loginTime',title:'登录时间', width:bodyW*0.2 + 'px',align:'center', sortable:true,
				    formatter:function(value,rowData,rowIndex) {
						return dateformate(value);
					}
				},
				{field:'logoutTime',title:'下线时间', width:bodyW*0.2 + 'px',align:'center', halign:'center',sortable:true,
					formatter:function(value,rowData,rowIndex) {
						return dateformate(value);
					}
				},
        	]]
        }
    });	
    g1.batchSetBtn([
		{'index':1, 'display':false},
		{'index':2, 'display':false},
		{'index':3, 'display':false},
		{'index':4, 'display':false},
		{'index':5, 'display':false},
		{'index':6, 'display':false},
        {'index':7, 'display':false},
        {'index':8, 'display':false}
    ]);
    
    $('#sDTable').datagrid('doCellTip', {
		position : 'bottom',
		maxWidth : '200px',
		tipStyler : {
			'backgroundColor' : '#EFF5FF',
			borderColor : '#95B8E7',
			boxShadow : '1px 1px 3px #292929'
		}
	});

    function dateformate(value) {
		var date = new Date(value);
	   var y = date.getFullYear();
	   var m = (date.getMonth() + 1).length() == 2 ? (date.getMonth() + 1) : '0' + (date.getMonth() + 1);
	   var d = date.getDate().length() == 2 ? date.getDate():'0'+date.getDate();
	   var h = date.getHours().length() == 2 ? date.getHours():'0'+date.getHours();
	   var M = date.getMinutes().length() == 2 ? date.getMinutes():'0'+date.getMinutes();
	   var s = date.getSeconds().length() == 2 ? date.getSeconds():'0'+date.getSeconds();
	   return y + '-' +m + '-' + d + ' ' + h + ':' + M + ':' + s;
	}
});
</script>
</head>
<body>
    <div id="container" class='easyui-layout' fit='true'>	
        <div region="center">   	 	
            <table id='sDTable'></table>
        </div>
    </div>
   <!-- ajax请求前后提示 -->
   <jsp:include flush="true" page="/pages/frReportFlow/ajaxloading.jsp" />
</body>
</html>
