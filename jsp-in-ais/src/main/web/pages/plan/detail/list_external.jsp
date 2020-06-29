<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE HTML>
<html>
	<title>项目外计划</title>
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
		var editFlag = undefined;
		var g1;
		$(function(){
			$('#query_year').show();
			var bodyW = $('body').width();    
			var fid = '${magOrganization.fid}';
			var list = '${list}';
			var sql = ' (status=\'1\' or (status=\'0\' and fid=\'${user.fdepid}\'))';
			if("1000" != fid) {
				sql += ' and fid in (\''+list.replaceAll(",", "\',\'")+'\')';
			}
			frloadOpen();
			g1 = new createQDatagrid({
				// 表格dom对象，必填
				gridObject:$('#sortTable')[0],
				// 要进行检索的表对象(hibernate bean)名称， 进行拼接hql时使用; 必填
				boName:'WorkPlanExternal',
				// 对象主键,删除数据时使用-默认为“id”；必填
				pkName:'formId',
				whereSql: sql,
				winWidth:800,
				winHeight:250,
				order:'desc',
				sort:'pro_starttime',
				gridJson:{    
					checkOnSelect:true,
					selectOnCheck:false,
					singleSelect:false,
					onLoadSuccess:frloadClose,
					toolbar:[{   
						text:'新增',
					    iconCls:'icon-add',
					    handler:function(){
					    	var url = '${contextPath}/plan/detail/editExternal.action';
					    	window.location.href=url;
					    }
					},'-',{
						text:'删除',
						iconCls:'icon-delete',
						handler:function(){
							var formIds = new Array();
							var rows = $("#sortTable").datagrid('getSelections');
							var flag = true;
							for(i in rows) {
								if(rows[i].status == '1') {
									flag = false;
									break;
								} else {
									formIds.push(rows[i].formId);
								}
							}
							
							if(flag) {
								if(formIds.length > 0) {
									$.ajax({
										url:'${contextPath}/plan/detail/deleteExternal.action',
										data:{'formIds':formIds.join(',')},
										type:'post',
										async:false,
										success:function(data){
											if(data == '1') {
												showMessage1('删除成功！');
												$("#sortTable").datagrid('reload');
											}
										}
									});
								}else{
									showMessage1('请选择数据！');
								}
							} else {
								showMessage1('只能选择草稿状态的记录！');
							}
							
						}
					},'-',], 
					columns:[[{field:'formId', title:'选择', hidden:true, align:'center', show:'false'}, 
									{field:'status', title:'状态', align:'center', show:'false',width:bodyW*0.08 + 'px',
										formatter:function(value,rowData,rowIndex){
											if(value == '0') {
												return '草稿';
											} else if(value == '1') {
												return '已提交';
											}
										}
									}, 
									{field:'year', title:'年度', align:'center', show:'true',hidden:true,type:'custom',target:$('#query_year')[0]},
									{field:'w_plan_name', title:'项目名称', width:bodyW*0.1 + 'px', align:'left',halign:'center', sortable:true, show:'true' ,oper:'like'},
									{field:'audit_dept_name', title:'审计单位', width:bodyW*0.1 + 'px', align:'left',halign:'center', sortable:true, show:'true', oper:'like'},
									{field:'audit_object_name', title:'被审计单位', width:bodyW*0.15 + 'px', align:'left',halign:'center', type:'custom',target:$('#queryCond1')[0]},
									{field:'pro_starttime', title:'项目开始日期', width:bodyW*0.08 + 'px', align:'center', show:'false',
										formatter:function(value,rowData,rowIndex) {
											if(value != '' && value != null){
							   			        return value.substring(0,10);
						   			        }
										}
									},
									{field:'pro_endtime', title:'项目结束日期', width:bodyW*0.08 + 'px', align:'center', show:'false',
										formatter:function(value,rowData,rowIndex) {
											if(value != '' && value != null){
							   			        return value.substring(0,10);
						   			        }
										}
									},
									{field:'audit_start_time', title:'审计期间开始', width:bodyW*0.08 + 'px', align:'center', show:'false',
										formatter:function(value,rowData,rowIndex) {
											if(value != '' && value != null){
							   			        return value.substring(0,10);
						   			        }
										}
									},
									{field:'audit_end_time', title:'审计期间结束', width:bodyW*0.08 + 'px', align:'center', show:'false',
										formatter:function(value,rowData,rowIndex) {
											if(value != '' && value != null){
							   			        return value.substring(0,10);
						   			        }
										}
									},
									{field:'operation',width:bodyW*0.075 + 'px',title:'操作', align:'center', sortable:false, show:'false', oper:'eq',
						            	   formatter: function(value, rowData, rowIndex) {
						            		   if(rowData.status == '0' && rowData.fid == '${user.fdepid}') 
					            			  	   return '<a href=\'#\' onclick="edit(\'' + rowData.formId + '\')">修改</a>';
					            			   else{
					            				   return '<a href=\'#\' onclick="view(\'' + rowData.formId + '\')">查看</a>';
					            			  }
						            	   }
						             }
						]]
				}
			});	
			g1.batchSetBtn([
				{'index':1, 'display':true},  
				{'index':2, 'display':true}, 
				{'index':3, 'display':false}, //导出到excel
				{'index':4, 'display':true}, //查询
				{'index':5, 'display':false},
				{'index':6, 'display':false}, 
				{'index':7, 'display':false},
				{'index':8, 'display':false}  //刷新
			]);
			
			//单元格tooltip提示
			$('#sortTable').datagrid('doCellTip', {
				position : 'bottom',
				maxWidth : '200px',
				tipStyler : {
					'backgroundColor' : '#EFF5FF',
					borderColor : '#95B8E7',
					boxShadow : '1px 1px 3px #292929'
				}
			});
			
			    var currentYear = "${currentYear}";
			    var offsetYear = 5;
			    var yearArr = [];
			    for(var i=currentYear-offsetYear; i<parseInt(currentYear)+offsetYear; i++){
			        yearArr.push({
			            'code':i,
			            'name':i
			        });
			    }
			    genSelectOption("query_year", yearArr, currentYear);
			    
			 // 生成下拉选择
			    function genSelectOption(selectObjId, arr, defaultVal){
			        try{
			            var selectObj = $('#'+selectObjId);
			            if(selectObj && selectObj.length && arr && arr.length){
			                selectObj.append("<option value=''></option>");
			                for(var i=0; i<arr.length; i++){
			                    var  ele = arr[i];
			                    //alert(ele)
			                    if(defaultVal != null && defaultVal == ele.code){
			                        selectObj.append("<option value='"+ele.code+"' selected>"+ele.name+"</option>");
			                    }else{
			                        selectObj.append("<option value='"+ele.code+"'>"+ele.name+"</option>");
			                    }
			                    
			                }
			            }
			        }catch(e){
			            isdebug ? alert('genSelectOption:\n'+e.message) : null;
			        }
			    }
		});

		function edit(formId) {
			var url = '${contextPath}/plan/detail/editExternal.action?formId=' + formId;
			window.location.href=url;
		}
		
		function view(formId) {
			var url = '${contextPath}/plan/detail/editExternal.action?view=view&formId=' + formId;
			aud$openNewTab('外部项目查看',url,false);
		}

	</script>
	</head>
	<body>
		<div id="container" class='easyui-layout' fit='true'>	
			<div region="center">   	 	
				<table id='sortTable'></table>
			</div>
		</div>
		<!-- 自定义查询条件  -->
		<select id="query_year" name="query_year" style='width:130px; display:none;'></select>
		<div id='queryCond1'>
			<input type='text'  class="noborder editElement clear" readonly/>
			<input type='hidden' name='query_in_audit_object_name' class="noborder editElement clear" readonly/> 
			<a class="easyui-linkbutton  editElement" iconCls="icon-search"
			style='border-width:0px;'
			onclick="showSysTree(this,
					 { url:'${contextPath}/mng/audobj/object/getAuditedDeptChildByDeptId.action',
				 		param:{
				 			'departmentId':'${magOrganization.fid}'
				 		},
				 		cache:false,
				 		checkbox:true,
				 		title:'请选择被审计单位'

					})">
			</a>
   		</div>
		<!-- ajax请求前后提示 -->
		<jsp:include flush="true" page="/pages/frReportFlow/ajaxloading.jsp" />
	</body>
</html>
