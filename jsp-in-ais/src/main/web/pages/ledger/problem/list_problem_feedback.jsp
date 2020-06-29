 <%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<html>
	<head>
		<title>整改反馈列表</title>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
		<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
	</head>
	<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout">
	<div region="center">
		<table id='trackList'></table>
	</div>
	<input type="hidden" id="view" value="${view }">
	<script type="text/javascript">
			$(function(){
				var bodyW = $('body').width();
			    var en = '${en}' == 'en' ? true:false;
				$('#trackList').datagrid({
					url : "/ais/proledger/problem/feedbackListForAuditObject.action?querySource=grid&middleLedgerProblem_id=${middleLedgerProblem_id}",
					method:'post',
					showFooter:false,
					rownumbers:true,
					pagination:true,
					striped:true,
					autoRowHeight:false,
					fit: true,
					fitColumns: true,
					resizeHandle:'right',
					idField:'formId',	
					border:false,
					singleSelect:false,
					pageSize:20,
					remoteSort: false,
					<s:if test="${view != 'view'}">
					toolbar:[{
							id:'add',
							text:en ? 'Add':'新增',
							iconCls:'icon-add',
							handler:function(){
								window.location.href="${contextPath}/proledger/problem/editAudTrackingLedgerRework.action?en=${en}&middleLedgerProblem_id=${middleLedgerProblem_id}&project_id=${project_id}&wpd_stagecode=rework";
							}
						},
						{
							id:'back',
							text:en ? 'Back':'返回',
							iconCls:'icon-undo',
							handler:function(){
								window.location.href="/ais/workprogram/auditDeptTabFile.action?projectid=${project_id}&wpd_stagecode=rework&en=${en}";
							}
						}
					],
					</s:if>
					onClickCell:function(rowIndex, field, value) {
						if(field == 'mend_date') {
							var rows = $('#trackList').datagrid('getRows');
							var row = rows[rowIndex];
							if(row.f_mend_opinion_code == '1' || row.f_mend_opinion_code == '2' || row.f_mend_opinion_code == '3' || row.commit_status=='Y'){
								trackInfoByView(row.middleLedgerProblem_id, row.formId);
							} else {
								var view = $("#view").val();
								if(view != 'view'){
									trackInfo(row.middleLedgerProblem_id, row.formId);
								}else{
									trackInfoByView(row.middleLedgerProblem_id, row.formId);
								}
							}
						}
					},
					columns:[[
						{field:'formId',width:'50', hidden:true, align:'center'},
						{field:'mend_date',title:en ? 'Feedback Date':'反馈日期',width:bodyW * 0.1 + 'px',align:'center', sortable:true,
							formatter:function(value,row, rowIndex) {
								var result;
								var view = $("#view").val();
								if (view == 'view' || row.f_mend_opinion_code == '1' || row.f_mend_opinion_code == '2' || row.f_mend_opinion_code == '3' || row.commit_status == 'Y') {
									if(en) {
										result = ["<label title='click view' style='cursor:pointer;color:blue;'>", value, "</label>"].join('');
									} else {
										result = ["<label title='单击查看' style='cursor:pointer;color:blue;'>", value, "</label>"].join('');
									}
								} else {
									if(en) {
										result = ["<label title='click edit' style='cursor:pointer;color:blue;'>", value, "</label>"].join('');
									} else {
										result = ["<label title='单击编辑' style='cursor:pointer;color:blue;'>", value, "</label>"].join('');
									}
								}
								return result;
							}
						},
						{field:'mend_result',title:en ? 'Actions':'整改跟踪措施',width:bodyW * 0.1 + 'px',align:'left',halign:'center',sortable:true,
                            formatter:function(value,row){   //指定行显示tip
                                var text= '<span title="' + value + '" class="tip">' + value + '</span>';
                                return text;

                            }},
						{field:'mend_state',title:en ? 'Status':'整改状态', width:bodyW * 0.1 + 'px',align:'center',sortable:true},
						{field:'examine_startdate',title:en ? 'Actual Starting Time':'实际整改开始日期', width:bodyW * 0.1 + 'px',align:'center',sortable:true,
							formatter:function(value,rowData,rowIndex){
								if(value!=null){
									 return value.substring(0,10);
								}
							}
						},
						{field:'examine_enddate',title:en ? 'Actual Finishing Time':'实际整改结束日期', width:bodyW * 0.1 + 'px',align:'center',sortable:true,
							formatter:function(value,rowData,rowIndex){
								if(value!=null){
									 return value.substring(0,10);
								}
							}
						},
						{field:'no_rectification_reason',title:en ? 'Unrectification Reason':'到期未整改原因',width:bodyW * 0.1 + 'px',align:'center',sortable:true,
                            formatter:function(value,row) {
                                if(value == null){
                                    value = '';
                                }


                                //指定行显示tip
                                var text = '<span title="' + value + '" class="tip">' + value + '</span>';
                                return text;

                            }},
						{field:'feedback_date',title:en ? 'Check Time':'跟踪检查时间',width:bodyW * 0.1 + 'px',sortable:true,align:'center',
                            formatter:function(value,rowData,rowIndex){
                                if(value!=null){
                                    return value.substring(0,10);
                                }
                            }

                        },
						{field:'examine_result',title:en ? 'Check Results':'审计单位跟踪检查结果', width:bodyW * 0.1 + 'px',align:'center',sortable:true,
                            formatter:function(value,row) {
                                if(value == null){
                                    value = '';
                                }


                                //指定行显示tip
                                var text = '<span title="' + value + '" class="tip">' + value + '</span>';
                                return text;

                            }
						},
						{field:'f_mend_opinion_name',title:en ? 'Status Check':'整改状态评价', width:bodyW * 0.1 + 'px',align:'center',sortable:true,
                            formatter:function(value,row){
                                if(value == null){
                                    value = '';
                                }
						    //指定行显示tip
                                var text= '<span title="' + value + '" class="tip">' + value + '</span>';
                                return text;

                            }}/*,
						{field:'operate',title:en ? 'Operation':'操作',align:'center', width:bodyW * 0.1 + 'px',
							formatter:function(value,rowData,rowIndex){
								if(rowData.f_mend_opinion_code == '1' || rowData.f_mend_opinion_code == '2' || rowData.f_mend_opinion_code == '3' || rowData.commit_status=='Y') {
									return '<a href=\"javascript:void(0)\" onclick=\"trackInfoByView(\''+rowData.middleLedgerProblem_id+'\',\''+rowData.formId+'\');\">'+(en ? 'Edit</a>':'查看</a>');
								} else {
									var view = $("#view").val();
									if(view != 'view'){
										return '<a href=\"javascript:void(0)\" onclick=\"trackInfo(\''+rowData.middleLedgerProblem_id+'\',\''+rowData.formId+'\');\">'+(en ? 'Edit</a>':'修改</a>');
									}else{

										return '<a href=\"javascript:void(0)\" onclick=\"trackInfoByView(\''+rowData.middleLedgerProblem_id+'\',\''+rowData.formId+'\');\">'+(en ? 'Edit</a>':'查看</a>');
									}
								}

							}	
						}*/
					]]   
				}); 
			});
			function trackInfo(middleLedgerProblem_id,formId){
				var row = $('#trackList').datagrid("getSelections");
				var project_id = '${project_id}';
				var permission = '${permission}';
				var interaction = '${interaction}';
				var idEdit = '${isEdit}';
				//var trackUrl = "${contextPath}/proledger/problem/editAudTrackingLedgerRework.action?id="+row[0].id+"&project_id=${project_id}&isEdit=${isEdit}&permission=${permission}&interaction=${interaction}&view=${view}";
				trackUrl = "${contextPath}/proledger/problem/editAudTrackingLedgerRework.action?en=${en}&middleLedgerProblem_id="+middleLedgerProblem_id+"&project_id=${project_id}&isEdit=isEdit&id="+formId;
				window.location.href= trackUrl; 
			}


            function trackInfoByView(middleLedgerProblem_id,formId){
                var row = $('#trackList').datagrid("getSelections");
                var project_id = '${project_id}';
                var permission = '${permission}';
                var interaction = '${interaction}';
                var idEdit = '${isEdit}';
                trackUrl = "${contextPath}/proledger/problem/editAudTrackingLedgerReworkByView.action?en=${en}&middleLedgerProblem_id="+middleLedgerProblem_id+"&project_id=${project_id}&isEdit=isEdit&view=${view}&id="+formId;
                window.location.href= trackUrl;
            }
			
		</script>
	</body>
</html>
 