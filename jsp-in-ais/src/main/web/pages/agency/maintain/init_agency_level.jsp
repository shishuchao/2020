<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<html>
<head>
<title>中介机构等级维护</title>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/createOrgTree.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/common.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/pages/tlInteractive/tlInteractiveCommon.js"></script>
	<script type="text/javascript">
		var editFlag = undefined;
		$(function(){
			$.extend($.fn.datagrid.defaults.editors, {
				text: {
					init: function (container, options) {
						var input = $('<input type="text" class="datagrid-editable-input" style="width: 230px; height: 23px;">').appendTo(container);
						return input.validatebox(options);
					},
					getValue: function (target) {
						return $(target).val();
					},
					setValue: function (target, value) {
						$(target).val(value);
					},
					resize: function (target, width) {
						var input = $(target);
						if ($.boxModel == true) {
							input.width(width - (input.outerWidth() - input.width()));
						} else {
							input.width(width);
						}
					}
				}
			});

			var bodyW = $('body').width();
			var g1 = new createQDatagrid({
				// 表格dom对象，必填
				gridObject:$('#templateTable')[0],
				// 要进行检索的表对象(hibernate bean)名称， 进行拼接hql时使用; 必填
				boName:'AgencyLevel',
				// 对象主键,删除数据时使用-默认为“id”；必填
				pkName:'id',
			   // whereSql: 'od_id in (select odInfo.od_id from OdSuggestion where handle_person=\''+fname+'\') or od_creater=\''+fname+'\'',
				whereSql:' 1=1 ',
				order:'asc',
				sort:'agencyLevel',
				winWidth:800,
				winHeight:250,
				gridJson:{
					checkOnSelect:true,
					rownumbers:false,
					selectOnCheck:true,
					singleSelect:false,
					toolbar:[{
						text:'新增',
						iconCls:'icon-add',
						handler:function () {
							$('#templateTable').datagrid('appendRow', {
								id: '',
								agencyLevel:'',
								agencyLevelName: '',
								scoringRange:'',
								remarks:''
							});
						}
					}, '-', {
						text: '保存',
						iconCls: 'icon-save',
						handler: function () {
							$('#templateTable').datagrid('endEdit', editFlag);
							//使用JSON序列化datarow对象，发送到后台。
							var rows = $('#templateTable').datagrid('getChanges');
							var rowstr = JSON.stringify(rows);
							 $.ajax({
								url:'/ais/agency/maintain/saveAgencyLevel.action',
								async:false,
								type:'POST',
								data:{'rowstr':rowstr},
								success:function(data) {
									if(data == '1') {
										showMessage1('保存成功！');
										$('#templateTable').datagrid('reload');
									}
								}
							});
						}
					},'-',{
						text: '删除',
						iconCls: 'icon-delete',
						handler: function () {
							var ids = [];
							var rows = $('#templateTable').datagrid('getChecked');
							if (rows.length) {
								$.each(rows, function (i) {
									if(rows[i].id) {
										ids.push(rows[i].id);
									} else {
										$('#templateTable').datagrid('deleteRow', $('#templateTable').datagrid('getRowIndex', rows[i]));
									}
								});
								if(ids.length > 0) {
									$.ajax({
										url:'/ais/agency/maintain/deleteAgencyLevel.action',
										async:false,
										type:'POST',
										data:{'ids':ids.join(",")},
										success:function(data) {
											if(data == '1') {
												showMessage1('删除成功！');
												$('#templateTable').datagrid('reload');
											}
										}
									});
								}
							} else {
								showMessage1("请选择数据！");
							}
						}
					},'-',helpBtn] ,
					onBeforeLoad:function(data){
						initHelpBtn();
					},
					columns:[[
								{field:'id', title:'选择', checkbox:true, align:'center', show:'false'},
								{field:'agencyLevel', title:'等级标识', width:bodyW*0.15 + 'px', align:'center', sortable:true,
									editor: {//设置其为可编辑
										type: 'text'
									}
								},
								{field:'agencyLevelName', title:'等级名称', width:bodyW*0.15 + 'px', align:'center', sortable:true,
									editor: {//设置其为可编辑
										type: 'text'
									}
								},
								{field:'scoringRange', title:'得分范围(参数值必须为n，可使用运算符≤，<)', width:bodyW*0.35 + 'px', align:'center', sortable:true,
									editor: {//设置其为可编辑
										type: 'text'
									}
								},
								{field:'remarks', title:'备注', width:bodyW*0.25 + 'px', align:'center', sortable:true,
									editor: {//设置其为可编辑
										type: 'textarea'
									}
								}
							]],
					onLoadSuccess:function(data){
					},
					onAfterEdit: function (rowIndex, rowData, changes) {//在添加完毕endEdit，保存时触发
						editFlag = undefined;//重置
					},
					onDblClickCell: function (rowIndex, field, value) {//双击该行修改内容
						if ('view' != "${param.view}") {
							if (editFlag != undefined) {
								$('#templateTable').datagrid('endEdit', editFlag);//结束编辑，传入之前编辑的行
							}
							if (editFlag == undefined) {
								$('#templateTable').datagrid('beginEdit', rowIndex);//开启编辑并传入要编辑的行
								editFlag = rowIndex;
							}
						}
					},
				}
			}).batchSetBtn([
				{'index': 1, 'display':${param.view != 'view'}},
				{'index': 2, 'display':${param.view != 'view'}},
				{'index': 3, 'display':${param.view != 'view'}},
				{'index': 4, 'display':${param.view != 'view'}},
				{'index': 5, 'display': false},
				{'index': 6, 'display': false},
				{'index': 7, 'display': false},
				{'index': 8, 'display': false}
			]);


			//产生混合随机数
			function getGuid() {
				var chars = ['0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z','a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z'];
				var rtArr = [];
				var lens = [8,4,4,4,12];
				for(var a=0; a<lens.length; a++){
					var n = lens[a];
					for(var i = 0; i < n ; i ++) {
						var index = Math.ceil(Math.random()*61);
						rtArr.push(chars[index]);
					}
					if(a < lens.length - 1){
						rtArr.push("-");
					}
				}
				return rtArr.join('');
			}

		});
	</script>
</head>
<body>
	<div id="container" class='easyui-layout' fit='true'>
		<div region="center">
			<table id='templateTable'></table>
		</div>
	</div>
</body>
</html>
