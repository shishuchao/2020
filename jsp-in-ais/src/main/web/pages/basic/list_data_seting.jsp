<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<jsp:directive.page import="ais.framework.util.UUID"/>
<!DOCTYPE HTML>
<html>
	<title>数据采集设置</title>
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
			var statusArr = eval('${statusArr}');
			var bodyW = $('body').width();    
			var bodyH = $('body').height();   
		 
			frloadOpen();
			var g1 = new createQDatagrid({
				// 表格dom对象，必填
				gridObject:$('#sapsystemsetTabel')[0],
				// 要进行检索的表对象(hibernate bean)名称， 进行拼接hql时使用; 必填
				boName:'SapSystemSetForm',
				// 对象主键,删除数据时使用-默认为“id”；必填
				pkName:'id',
				order:'asc',
				winWidth:800,
				winHeight:250,
				gridJson:{    
					checkOnSelect:false,
					selectOnCheck:false,
					singleSelect:false,
					onLoadSuccess:function(data){
						frloadClose();
						resetRowNum();
					},
					toolbar:[{
						text:'新增',
						iconCls:'icon-add',
						handler:function () {
							$("#sapsystemsetTabel").datagrid('appendRow', {//在指定行添加数据，appendRow是在最后一行添加数据
								id: '',
								systemName: '',
								serviceIp: '',
								instanceNumber: '',
								client: '',
								userName: '',
								password: '',
								codePage: '',
								status: ''
							});
							resetRowNum();
						}
					}, '-', {  
						text: '保存',
						iconCls: 'icon-save',
						handler: function () {  
							var scGridTableId = "sapsystemsetTabel";
							if(aud$validRows(scGridTableId) && endEditing()){
								$("#sapsystemsetTabel").datagrid('endEdit', editFlag);  
								//使用JSON序列化datarow对象，发送到后台。  
								var rows = $("#sapsystemsetTabel").datagrid('getChanges');
								var s= "1";
								if ( rows.length == 0){
									s = "2";
								}else{
									for(var i=0;i<rows.length;i++){
										var systemName = rows[i].systemName;
										if (systemName && systemName != ""){
											
										}else{
											s = "3";
										}
									}
								}
								if (s=="2"){
									top.$.messager.show({title:'提示消息',msg:'请添加一条记录'});
									return false;
								}
								if (s=="3"){
									top.$.messager.show({title:'提示消息',msg:'请添加系统名称'});
									return false;
								}
								var rowstr = JSON.stringify(rows);  
								$.ajax({
									url:'${contextPath}/basic/codename/saveSapSystemSeting.action',
									async:false,
									type:'POST',
									data:{'rowstr':rowstr},
									success:function(data) {
										if(data == '1') {
											$("#sapsystemsetTabel").datagrid('reload');
											showMessage1('保存成功！');
										}
									}
								});
							}else{
								$('#sapsystemsetTabel').datagrid('selectRow', editFlag);
								showMessage1('表格数据校验未通过', function(){
									var gridY = QUtil.getElementPos($('#sapsystemsetTabel').parent().get(0)).y;
									if(gridY){
										$('#layoutCenter').scrollTop(gridY - 150);
									}
								});
								return false;
							}
							
						}  
					}, '-', {  
						text: '删除',
						iconCls: 'icon-delete',
						handler: function () {  
							var rows = $("#sapsystemsetTabel").datagrid('getChecked');
							 //倒序，删除时候，先删除前边的，导致rownum发生变化，删除后边数据时串行
							var rowsdb = [];
				            var rowsdel = [];
				            var index =-1;
				            var i = 0;
				    		for(i=rows.length;i>0;i--){
				    			index = $('#sapsystemsetTabel').datagrid('getRowIndex',rows[i-1]);
				    			rowsdel.push(index);
				    			if(rows[i-1]["id"]!=''){
				    				rowsdb.push(rows[i-1]);
				    			}
				    		}
							//使用JSON序列化datarow对象，发送到后台。  
							var ids = [];
							for(var i=0;i<rows.length;i++){
								ids.push(rows[i].id);
							}
							if(ids == '') {
								showMessage1('请选择数据！');
							} else {
								$.messager.confirm('提示信息','确认删除吗？',function(data){
									if(data){
										$.ajax({
											url:'${contextPath}/basic/codename/deleteSapSysSeting.action',
											async:false,
											type:'POST',
											data:{'ids':ids.join(",")},
											success:function(data) {
												if(data == '1') {
													$("#sapsystemsetTabel").datagrid('reload');
													showMessage1('删除成功！');
												}
											}
										});
									}
								});
							}
						}  
					}] ,
					columns:[[
						{field:'id', title:'选择', checkbox:true, align:'center', show:'false'},      
						{field:'systemName', title:'系统名称', width:bodyW*0.12 + 'px', align:'center', sortable:true, show:'false',
							editor: {//设置其为可编辑
								type: 'text',//设置编辑样式 自带样式有：text，textarea，checkbox，numberbox，validatebox，datebox，combobox，combotree 可自行扩展
								options: { required: true}
							}
						},
						{field:'serviceIp', title:'应用程序服务器ip', width:bodyW*0.12 + 'px', align:'center', sortable:true, 
							editor: {//设置其为可编辑
								type: 'text'
							
							}
						},
						{field:'systemNumber', title:'系统编号', width:bodyW*0.16 + 'px', align:'center', sortable:true, show:'false',
							editor: {//设置其为可编辑
								type: 'text'
							}
						},
						{field:'client', title:'集团号', width:bodyW*0.16 + 'px', align:'center', sortable:true, show:'false',
							editor: {//设置其为可编辑
								type: 'text'
							}
						},
						{field:'userName', title:'用户名', width:bodyW*0.16 + 'px', align:'center', sortable:true, show:'false',
							editor: {//设置其为可编辑
								type: 'text'
							}
						},
						 {field:'password', title:'密码', width:bodyW*0.16 + 'px', align:'center', sortable:true, show:'false', 
							editor: {//设置其为可编辑
								type: 'text'
							},
							formatter:function(value, rowData, rowIndex) {
								if(value!=null){
									return "**********";
								}
							}
						}, 
						{field:'codePage', title:'字符集', width:bodyW*0.16 + 'px', align:'center', sortable:true, show:'false',
							editor: {//设置其为可编辑
								type: 'text'
							}
						},
						{field:'status', title:'状态', width:bodyW*0.16 + 'px', align:'center', sortable:true,
							editor: {//设置其为可编辑
								type: 'combobox',
								options:  { data: statusArr, valueField: "code", textField: "name"}
							},
							formatter:function(value, rowData, rowIndex) {
								var name = "";
								for(i in statusArr) {
									if(statusArr[i].code == value) {
										name = statusArr[i].name;
										break;
									}
								}
								return name;
							}
						}
						
					]],
					onAfterEdit: function (rowIndex, rowData, changes) {//在添加完毕endEdit，保存时触发
						editFlag = undefined;//重置
						
					}, 
					onDblClickCell: function (rowIndex, field, value) {//双击该行修改内容
						if (editFlag != undefined) {
							$("#sapsystemsetTabel").datagrid('endEdit', editFlag);//结束编辑，传入之前编辑的行
						}
						if (editFlag == undefined) {
							$("#sapsystemsetTabel").datagrid('beginEdit', rowIndex);//开启编辑并传入要编辑的行
							editFlag = rowIndex;
						}
					},
				}
			});	
			g1.batchSetBtn([
				{'index':1, 'display':true},
				{'index':2, 'display':true},
				{'index':3, 'display':true},
				{'index':4, 'display':false},
				{'index':5, 'display':false},
				{'index':6, 'display':false},
				{'index':7, 'display':false},
				{'index':8, 'display':false}
			]);
			// 生成下拉选择
			function genSelectOption(selectObjId, arr, defaultVal){
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
			}
			
			function resetRowNum(){
				//重新排序行号
				var rowNumbers = $('#container .datagrid-cell-rownumber');
				for(i=0;i<rowNumbers.length;i++){
			        $(rowNumbers[i]).html("");
			        $(rowNumbers[i]).html(i+1);
				}
			 }
		});

		// 结束编辑
	    function endEditing(){
	        if(editFlag == undefined){return true}
	        if($('#sapsystemsetTabel').datagrid('validateRow', editFlag)){
	            $('#sapsystemsetTabel').datagrid('endEdit', editFlag);
	            editFlag = undefined;
	            return true;
	        }else{
	            return false;
	        }
	    }
	  //曾删行保存时校验数据是否完整
	    function aud$validRows(gridId){
	        var rt = true;
	        if(gridId){
	            var rows = $('#'+gridId).datagrid('getRows');
	            var rowLen = rows.length;
	            for(var i = 0; i < rowLen; i++){
	                var ed = $('#'+gridId).datagrid('selectRow', i).datagrid('beginEdit', i);
	                if(ed){
	                    $(ed.target).select().focus();
	                }
	                if(!$('#'+gridId).datagrid('validateRow', i)){
	                	editFlag = i;
	                    rt = false;
	                    break;
	                }
	                $('#'+gridId).datagrid('endEdit', i);
	            }
	        }
	        return rt;
	    }
	  
		function edit(id) {
			var url = "${contextPath}/riskManagement/knowledgeBase/riskTemplate/main.action?templateId="+id;
        	window.parent.parent.addTab('tabs','修改风险库','editWin',url,true);
        	return false;
		}

		function copy(templateId) {
			$.post('${contextPath}/riskManagement/knowledgeBase/riskTemplate/copy.action',{'templateId':templateId},function(data){
				if(data == '1') {
					showMessage1('复制成功！');
					$('#sapsystemsetTabel').datagrid('reload');
				}
			});
		}

	</script>
	</head>
	<body>
		<div id="container" class='easyui-layout' fit='true'>	
			<div region="center">   	 	
				<table id='sapsystemsetTabel'></table>
			</div>
		</div>
		<!-- ajax请求前后提示 -->
		<jsp:include flush="true" page="/pages/frReportFlow/ajaxloading.jsp" />
	</body>
</html>
