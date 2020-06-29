<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<html>
<head>
	<title>中介机构评分项维护</title>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
	<link href="<%=request.getContextPath()%>/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
	<link href="<%=request.getContextPath()%>/resources/css/common.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/createOrgTree.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>  
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
				boName:'AgencyScoringItem',
				// 对象主键,删除数据时使用-默认为“formId”；必填
				pkName:'formId',
				delRefresh: false,
				// whereSql: 'od_id in (select odInfo.od_id from OdSuggestion where handle_person=\''+fname+'\') or od_creater=\''+fname+'\'',
				order:'asc',
				sort:'orderNumber',
				winWidth:800,
				winHeight:250,
				gridJson:{
					checkOnSelect:true,
					rownumbers:false,
					selectOnCheck:true,
					singleSelect:false,
					pagination:false,
					showFooter:true,
					<s:if test="${param.status != 'view'}">
					toolbar:[{
						text:'新增',
						iconCls:'icon-add',
						handler:function () {
							var templateTable = $("#templateTable");

							var rows = templateTable.datagrid('getRows');
							var max = 0;
							$.each(rows, function (i, row) {
								var x = row.orderNumber;
								try {
									if (parseInt(x) > max) {
										max = parseInt(x);
									}
								} catch(e) {}
							});

							templateTable.datagrid('appendRow', {
								score: '',
								fullMarks:100.0,
								describe: '',
								orderNumber: max + 1
							});
							heji();
						}
					}, '-', {
						text: '保存',
						iconCls: 'icon-save',
						handler: function () {
							var templateTable = $("#templateTable");
							templateTable.datagrid('endEdit', editFlag);

							heji();

							var rows = templateTable.datagrid('getRows');
							for (var i = 0; i < rows.length; i++) {
								var orderNumber = rows[i].orderNumber;
								if (orderNumber || orderNumber == 0) {
									for (var j = i + 1; j < rows.length; j++) {
										var orderNumber2 = rows[j].orderNumber;
										if (orderNumber == orderNumber2) {
											showMessage1('序号【' + orderNumber + '】重复！');
											return;
										}
									}
								}
							}

							var rowstr = JSON.stringify(rows);
							$.ajax({
								url: '<%=request.getContextPath()%>/agency/scoringItem/saveScoringItem.action',
								async: false,
								type: 'POST',
								data: {'rowstr': rowstr},
								success: function (data) {
									if (data == '1') {
										showMessage1('保存成功！');
										//g1.refresh();
										window.location.reload(); // 刷新
									}
								}
							});
						}
					},'-',helpBtn,'-',] ,
					</s:if>
					columns:[[
						<s:if test="${param.status != 'view'}">
						{field: 'templateId', title: '选择', checkbox: true, align: 'center', show: 'false'},
						{
							field: 'orderNumber', title: '序号', width: bodyW * 0.1 + 'px', align: 'center', sortable: true, show: 'false', oper: 'eq',
							editor: {//设置其为可编辑
								type: 'numberbox',
								options: {
									precision: 0
								}
							}
						},
						{
							field: 'score', title: '评分项', width: bodyW * 0.1 + 'px', halign: 'center', align: 'left', sortable: true, oper: 'like',
							editor: {//设置其为可编辑
								type: 'text'
							}
						},
						{
							field: 'describe', title: '评分标准说明', width: bodyW * 0.4 + 'px', halign: 'center', align: 'left', sortable: true, show: 'false', oper: 'eq',
							editor: {//设置其为可编辑
								type: 'text'
							}

						},
						{
							field: 'fullMarks', title: '评分项满分分值', width: bodyW * 0.1 + 'px', align: 'center', sortable: true, show: 'false', oper: 'eq',
							editor: {//设置其为可编辑
								type: 'numberbox', options: {precision: 1}
							}

						}
						</s:if>
						<s:else>
						{field: 'orderNumber', title: '序号', width: bodyW * 0.1 + 'px', align: 'center', sortable: true, oper: 'like'},
						{field: 'score', title: '评分项', width: bodyW * 0.1 + 'px', halign: 'center', align: 'left', sortable: true, oper: 'like'},
						{field: 'describe', title: '评分标准说明', width: bodyW * 0.4 + 'px', halign: 'center', align: 'left', sortable: true, show: 'false', oper: 'eq'},
						{field: 'fullMarks', title: '评分项满分分值', width: bodyW * 0.1 + 'px', align: 'center', sortable: true, show: 'false', oper: 'eq'}
						</s:else>
					]],

					onLoadSuccess:function(data){
						heji();
						initHelpBtn();
					},
					onAfterEdit: function (rowIndex, rowData, changes) {//在添加完毕endEdit，保存时触发
						editFlag = undefined;//重置
					},

					onDblClickCell: function (rowIndex, field, value) {//双击该行修改内容
						if ('status' != "${param.view}"){
							$('#templateTable').datagrid('reloadFooter',[{orderNumber: '合计',fullMarks:''}]);

							if (editFlag != undefined) {
								$("#templateTable").datagrid('endEdit', editFlag);//结束编辑，传入之前编辑的行
							}
							if (editFlag == undefined) {
								$("#templateTable").datagrid('beginEdit', rowIndex);//开启编辑并传入要编辑的行
								editFlag = rowIndex;
							}
						}
					},
				}
			}).batchSetBtn([
				{'index':1, 'display':${param.status != 'view'}},
				{'index':2, 'display':${param.status != 'view'}},
				{'index':3, 'display':${param.status != 'view'}},
				{'index':4, 'display':${param.status != 'view'}},
				{'index':5, 'display':false},
				{'index':6, 'display':false},
				{'index':7, 'display':false},
				{'index':8, 'display':false},
				{'index':9, 'display':false}
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

			$('#templateTable').datagrid('doCellTip', {
				position : 'bottom',
				maxWidth : '350px',
				tipStyler : {
					'backgroundColor' : '#EFF5FF',
					borderColor : '#95B8E7',
					boxShadow : '1px 1px 3px #292929'
				}
			});
		});


		/* 修改统计数据	 */
		function heji(){
			var rows = $('#templateTable').datagrid('getRows');
			var k =0.0;
			var s = "";
			if (rows) {
				for (var i=0;i < rows.length;i++){
					if ( typeof(rows[i].fullMarks ) == 'number'){
						if (rows[i].fullMarks != 0 ){
							k += rows[i].fullMarks;
						}
					}
					if (typeof(rows[i].fullMarks ) == 'string'){
						var fullMark = ((rows[i].fullMarks)*1 );
						k += fullMark;
					}

				}
			}
			$('#templateTable').datagrid('reloadFooter',[{orderNumber: '合计',fullMarks:k}]);
			$('#templateTable').datagrid('reloadFooter');
		}
	</script>
</head>
	<body>
	<div id="container" class="easyui-layout" fit="true">
		<div region="center">
			<table id='templateTable'></table>
		</div>
	</div>
</body>
</html>
