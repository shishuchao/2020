<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE HTML>
<html>
	<title>风险评估人权重列表</title>
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
		$(function(){
			//var tradePlateArr = eval('${tradePlateArr}');
			var bodyW = $('body').width();   
			var serial_num = "${serial_num}";
			//var bodyH = $('body').height();   
		 
			//$('#query_year').show();
			//$('#query_tradePlate').show();
			frloadOpen();
			var g1 = new createQDatagrid({
				// 表格dom对象，必填
				gridObject:$('#modulusTable')[0],
				// 要进行检索的表对象(hibernate bean)名称， 进行拼接hql时使用; 必填
				boName:'RiskEvaluateModulus',
				// 对象主键,删除数据时使用-默认为“id”；必填
				pkName:'id',
				whereSql: 'evaluateSerialNum = \''+serial_num+'\'',
			    // whereSql: 'od_id in (select odInfo.od_id from OdSuggestion where handle_person=\''+fname+'\') or od_creater=\''+fname+'\'',
				//order:'desc',
				//sort:'year',
				winWidth:800,
				winHeight:250,
				gridJson:{    
					checkOnSelect:true,
					selectOnCheck:false,
					singleSelect:false,
					onLoadSuccess:frloadClose,
					toolbar:[
					/* {
						text:'新增',
						iconCls:'icon-add',
						handler:function () {
							$("#modulusTable").datagrid('insertRow', {//在指定行添加数据，appendRow是在最后一行添加数据
								index: 0, // 行数从0开始计算
								row: {
									templateId: '',
									templateCode: '',
									year: '${currentYear}',
									templateName: '',
									tradePlate: '',
									version: ''
								}
							});
						}
					}, '-',  */
					{  
						text: '保存',
						iconCls: 'icon-save',
						handler: function () {  
							$("#modulusTable").datagrid('endEdit', editFlag);  
							//使用JSON序列化datarow对象，发送到后台。  
							var rows = $("#modulusTable").datagrid('getChanges');
							for(i in rows) {
								if(isNaN(rows[i].evaluatePercentage)) {
									showMessage1('权重值必须为数字！');
									return false;
								}
							}
							var rowstr = JSON.stringify(rows);  
							$.ajax({
								url:'${contextPath}/riskManagement/management/riskEvaluate/saveRiskModulus.action',
								async:false,
								type:'POST',
								data:{'rowstr':rowstr},
								success:function(data) {
									if(data == '1') {
										showMessage1('保存成功！');
									}
								}
							});
						}  
					}] ,
					columns:[[
						{field:'id', title:'选择', checkbox:true, align:'center', show:'false'}, 
						{field:'evaluateSerialNum', title:'评估任务编号', width:bodyW*0.12 + 'px', align:'center', show:'false'}, 
						{field:'evaluateDepartment', title:'评估部门代码', width:bodyW*0.12 + 'px', align:'center', show:'false', hidden:true},
						{field:'evaluateDepartmentName', title:'评估部门', width:bodyW*0.16 + 'px', align:'center', sortable:true, show:'true', oper:'eq'},
						{field:'evaluatePerson', title:'评估人代码', width:bodyW*0.16 + 'px', align:'center', show:'false'},
						{field:'evaluatePersonName', title:'评估人', width:bodyW*0.16 + 'px', align:'center', sortable:true, show:'true', oper:'eq'
							/* editor: {//设置其为可编辑 
								type: 'text',//设置编辑样式 自带样式有：text，textarea，checkbox，numberbox，validatebox，datebox，combobox，combotree 可自行扩展
								options: { required: true}
							} */
						},
						{field:'evaluatePercentage', title:'权重', width:bodyW*0.16 + 'px', align:'center', sortable:true, type:'custom', target:$('#query_year')[0],
							editor: {//设置其为可编辑
								type: 'text',
								options:{ required : true}
							}
						}
						/* {field:'operation', title:'操作', width:bodyW*0.16 + 'px', align:'center', sortable:false, show:'false',
							formatter:function(value,rowData,rowIndex){
								if(rowData.id != '') {
									return "<a href='#' onclick=\"edit('" + rowData.templateId + "')\"></a>";
								} else {
									return '';
								}
							}   
						} */
					]],
					onAfterEdit: function (rowIndex, rowData, changes) {//在添加完毕endEdit，保存时触发
						editFlag = undefined;//重置
					}, 
					onDblClickCell: function (rowIndex, field, value) {//双击该行修改内容
						if (editFlag != undefined) {
							$("#modulusTable").datagrid('endEdit', editFlag);//结束编辑，传入之前编辑的行
						}
						if (editFlag == undefined) {
							$("#modulusTable").datagrid('beginEdit', rowIndex);//开启编辑并传入要编辑的行
							editFlag = rowIndex;
						}
					},
				}
			});	
			g1.batchSetBtn([
				{'index':1, 'display':true},
				{'index':2, 'display':true},
				{'index':3, 'display':false},
				{'index':4, 'display':false},
				{'index':5, 'display':false},
				{'index':6, 'display':false},
				{'index':7, 'display':false},
				{'index':8, 'display':false}
			]);
		   
			/* var currentYear = "${currentYear}";
			var offsetYear = 5;
			var yearArr = [];
			for(var i=currentYear-offsetYear; i<parseInt(currentYear)+offsetYear; i++){
				yearArr.push({
					'code':i,
					'name':i
				});
			}
			genSelectOption("query_year", yearArr, currentYear);
			
			genSelectOption("query_tradePlate", tradePlateArr); */

			// 生成下拉选择
			/* function genSelectOption(selectObjId, arr, defaultVal){
				try{
					var selectObj = $('#'+selectObjId);
					if(selectObj && selectObj.length && arr && arr.length){
						selectObj.append("<option value=''></option>");
						for(var i=0; i<arr.length; i++){
							var ele = arr[i];
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
			} */
		});

		function edit(id) {
			var url = "${contextPath}/riskManagement/knowledgeBase/riskTemplate/main.action?templateId="+id;
        	window.parent.parent.addTab('tabs','修改风险库','editWin',url,true);
        	return false;
		}

	</script>
	</head>
	<body>
		<div id="container" class='easyui-layout' fit='true'>	
			<div region="center">   	 	
				<table id='modulusTable'></table>
			</div>
		</div>
		<!-- 自定义查询条件  -->
		<select id="query_year" name="query_year" style='width:130px; display:none;'></select>
		<select id="query_tradePlate" name="query_tradePlate" style='width:130px; display:none;'></select>
		<!-- ajax请求前后提示 -->
		<jsp:include flush="true" page="/pages/frReportFlow/ajaxloading.jsp" />
	</body>
</html>
