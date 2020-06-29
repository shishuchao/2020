<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<jsp:directive.page import="ais.framework.util.UUID"/>
<html>
	<title>质量抽检项维护</title>
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
			var bodyH = $('body').height();   
			frloadOpen();
			var g1 = new createQDatagrid({
				// 表格dom对象，必填
				gridObject:$('#templateTable')[0],
				// 要进行检索的表对象(hibernate bean)名称， 进行拼接hql时使用; 必填
				boName:'QualitySampling',
				// 对象主键,删除数据时使用-默认为“formId”；必填
				pkName:'formId',
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
					fit: false,
					fitColumns: true,
					onLoadSuccess:frloadClose,
					<s:if test="${view != 'view'}">
					toolbar:[{
						text:'新增',
						iconCls:'icon-add',
						handler:function () {
                            var rows = $("#templateTable").datagrid("getRows");
							var max= rows.length;
							$("#templateTable").datagrid('insertRow', {//在指定行添加数据，appendRow是在最后一行添加数据
								index: max+1, // 行数从maxIndex+1开始计算
								row: {
								 //   formId:getGuid(),
                                    orderNumber: max+1,
									check_point: '',
									follow: '',
									full_marks:'0.0'
								}
							});
						}
					}, '-', {  
						text: '保存',
						iconCls: 'icon-save',
						handler: function () {
							$("#templateTable").datagrid('endEdit', editFlag);  
							//使用JSON序列化datarow对象，发送到后台。  
							var rows = $("#templateTable").datagrid('getChanges');
							var flag = true;
							if(rows.length > 0) {
								for(var i=0; i<rows.length; i++) {
									var row = rows[i];
									if(row.check_point == '' || row.check_point == null || typeof row.check_point == 'undefined') {
										flag = false;
										editFlag = $("#templateTable").datagrid('getRowIndex', row);
										$("#templateTable").datagrid('beginEdit', editFlag);
										showMessage1("检查要点不能为空！");
										break;
									}
								}
							}
							if(flag) {
								var rowsall = $("#templateTable").datagrid('getRows');
								var rowstr = JSON.stringify(rows);
								if (rowsall) {
									for (var i=0;i < rowsall.length-1;i++){
										if ( rowsall[i].orderNumber == rowsall[rowsall.length-1].orderNumber){
											showMessage1('序号重复，请重新输入！');
											return false;
										}
									}
									$.ajax({
										url:'<%=request.getContextPath()%>/quality/sampling/saveQualitySampling.action',
										async:false,
										type:'POST',
										data:{'rowstr':rowstr},
										success:function(data) {
											if(data == '1') {
												showMessage1('保存成功！');
												location.reload();
											}
										}
									});
								}
							}
						}
					}, '-', {  
						text: '删除',
						iconCls: 'icon-delete',
						handler: function () {  
							var rows = $("#templateTable").datagrid('getSelections');
							if(rows.length<1){
								showMessage1('请至少选中的一条数据！');
								return false;
							}
							var str = "";
							for(var k = 0 ; k < rows.length ; k++){
								str += rows[k].formId + ",";
							}
							top.$.messager.confirm('提示信息','您选择了【'+rows.length+'】条记录，是否删除?<br>单击【确定】删除记录',function(flag){
								if(flag){
									 $.ajax({
											url:'<%=request.getContextPath()%>/quality/sampling/deleteQualitySampling.action',
											async:false,
											type:'POST',
											data:{'str':str},
											success:function(data) {
												if(data == '1') {
													showMessage1('删除成功！');
													location.reload();
												}
											}
										}); 
								}
							});			
							
						}  
					}] ,
					</s:if>
					<s:if test="${view != 'view'}">
					columns:[[
								{field:'formId', title:'选择', checkbox:true, align:'center', show:'false'},      
								{field:'orderNumber', title:'序号', width:bodyW*0.1 + 'px', align:'center', sortable:true, show:'false', oper:'eq',
									editor: {//设置其为可编辑
										type: 'text'
									}
								},
								{field:'check_point', title:'检查要点(*)', width:bodyW*0.2 + 'px', halign:'center',align:'left', sortable:true, oper:'like',
									editor: {//设置其为可编辑
										type: 'text'
									}
								},
								{field:'follow', title:'关注项', width:bodyW*0.2 + 'px', halign:'center',align:'left', sortable:true, oper:'like',
									editor: {//设置其为可编辑
										type: 'text'
									}
								},
								{field:'full_marks', title:'评分项满分分值', width:bodyW*0.2 + 'px', align:'center', sortable:true, show:'false', oper:'eq',
									editor: {//设置其为可编辑
										type:'numberbox',options:{
											precision:1,
											min:0,
											max:100,
											missingMessage:'0-100数字',
											onChange:function(newValue,oldValue){
											},
											inputEvents:{
									            blur: function(e) {
									            	var tg = e.data.target;
									                $(tg).numberbox("setValue", $(tg).numberbox("getText"));
									            }
											}
											
										
										}
									}
								
								}
							]],
					
					</s:if>
					<s:else>
					columns:[[
								{field:'orderNumber', title:'序号', width:bodyW*0.1 + 'px', align:'center', sortable:true, oper:'like'},
								{field:'check_point', title:'检查要点', width:bodyW*0.2 + 'px', halign:'center',align:'left', sortable:true, oper:'like'},
								{field:'follow', title:'关注项', width:bodyW*0.2 + 'px', halign:'center',align:'left', sortable:true, oper:'like'},
								{field:'full_marks', title:'评分项满分分值', width:bodyW*0.2 + 'px', align:'center', sortable:true, show:'false', oper:'eq'}

							]],
					
					</s:else>
	
			        onLoadSuccess:function(data){ 

			            frloadClose();
			        	heji();
			        }, 
			        onAfterEdit: function (rowIndex, rowData, changes) {//在添加完毕endEdit，保存时触发
						editFlag = undefined;//重置
						heji();
					}, 
					
					onDblClickCell: function (rowIndex, field, value) {//双击该行修改内容
						if ('view' != "${view}"){
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
			});	
			g1.batchSetBtn([
                <s:if test="${view == 'view'}">           
                {'index':1, 'display':false},
                {'index':2, 'display':false},
                {'index':3, 'display':false},
				</s:if>
                <s:else>
            	{'index':2, 'display':true},
            	{'index':3, 'display':true},
                </s:else>
				{'index':4, 'display':false},
				{'index':5, 'display':false},
				{'index':6, 'display':false},
				{'index':7, 'display':false},
				{'index':8, 'display':false}
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
	 		 			if ( typeof(rows[i].full_marks ) == 'number'){
	 		 				if (rows[i].full_marks != 0 ){
	 		 						k += rows[i].full_marks;	
	 		 				}
	 		 			}
	 		 			if (typeof(rows[i].full_marks ) == 'string'){
	 		 				   var fullMark = ((rows[i].full_marks)*1 );
	 			 				k += fullMark;	
	 		 			}
	 				} 
	 			}
	     	 $('#templateTable').datagrid('reloadFooter',[{orderNumber: '合计',full_marks:k}]);
	     	 $('#templateTable').datagrid('reloadFooter');
	     	 return k;
	     }
	</script>
	</head>
	<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout"> 
			<div region="center">   	 	
				<table id='templateTable'></table>
			</div>
		<!-- </div> -->
		<!-- ajax请求前后提示 -->
		<jsp:include flush="true" page="/pages/frReportFlow/ajaxloading.jsp" /> 
	</body>
</html>
