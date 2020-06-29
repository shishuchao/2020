<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<jsp:directive.page import="ais.framework.util.UUID"/>
<!DOCTYPE HTML>
<html>
	<title>被审计单位历史信息</title>
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
		    var en = '${en}' == 'en' ? true:false;
			var bodyW = $('body').width();    
			var bodyH = $('body').height();   
			frloadOpen();
			var aoId = '${aoId}';
			var g1 = new createQDatagrid({
				// 表格dom对象，必填
				gridObject:$('#templateTable')[0],
				// 要进行检索的表对象(hibernate bean)名称， 进行拼接hql时使用; 必填
				boName:'AuditingObjectHistory',
				// 对象主键,删除数据时使用-默认为“id”；必填
				pkName:'id',
			    whereSql: 'aoId=\''+aoId+'\'',
				order:'asc',
				sort:'createDate',
				winWidth:800,
				winHeight:250,
				gridJson:{    
					checkOnSelect:false,
					selectOnCheck:false,
					singleSelect:false,
					onLoadSuccess:frloadClose,
					columns:[[
						{field:'generalAssetsA', title:en ? 'The Company And Subcompany\'s<br> Total Assets(Ten Thousand RMB)':'本级及以下单位资产总额（万元）', width:bodyW*0.15 + 'px', align:'left',halign:'center', show:'false'},
						{field:'generalAssetsO', title:en ? 'The Company\'s Total Assets<br>(Ten Thousand RMB)':'本单位资产总额（万元）', width:bodyW*0.13 + 'px', align:'left',halign:'center', sortable:true},
						{field:'officeAddress', title:en ? 'Office Address':'总部办公地址', width:bodyW*0.12 + 'px', align:'left',halign:'center', sortable:true},
						{field:'director', title:en ? 'General Manager':'单位负责人', width:bodyW*0.12 + 'px', align:'left',halign:'center', sortable:true},
						{field:'financialDirector', title:en ? 'Chief Financial Officer':'财务负责人', width:bodyW*0.12 + 'px', align:'left',halign:'center', show:'false'},
						{field:'financialLinkman', title:en ? 'Financial Contact Person':'财务联系人', width:bodyW*0.12 + 'px',align:'left',halign:'center', sortable:true},
						{field:'comTypeName', title:en ? 'Type':'单位性质', width:bodyW*0.1 + 'px', align:'left',halign:'center', sortable:true},
						{field:'officePhone', title:en ? 'Telephone':'单位电话', width:bodyW*0.1 + 'px', align:'left',halign:'center', sortable:true},
						{field:'faxCode', title:en ? 'Fax':'单位传真', width:bodyW*0.1 + 'px', align:'left',halign:'center', sortable:true},
						{field:'employeesNum', title:en ? 'Staff Number':'人员数量', width:bodyW*0.1 + 'px', align:'left',halign:'center', sortable:true},
						{field:'updatePersonName', title:en ? 'Reviser':'最近更新人', width:bodyW*0.1 + 'px', align:'left',halign:'center', sortable:true},
						{field:'updateDate', title:en ? 'Revise Time':'最近更新时间', width:bodyW*0.1 + 'px', align:'left',halign:'center', sortable:true}
					]],
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
		});
	</script>
	</head>
	<body>
		<div id="container" class='easyui-layout' fit='true'>	
			<div region="center">   	 	
				<table id='templateTable'></table>
			</div>
		</div>
		<!-- ajax请求前后提示 -->
		<jsp:include flush="true" page="/pages/frReportFlow/ajaxloading.jsp" />
	</body>
</html>
