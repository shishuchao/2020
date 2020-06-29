<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<jsp:directive.page import="ais.framework.util.UUID"/>
<html>
	<title>风险库模板</title>
	<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
	<link href="<%=request.getContextPath()%>/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
	<link href="<%=request.getContextPath()%>/resources/css/common.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/createOrgTree.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>  
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/common.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/pages/tlInteractive/tlInteractiveCommon.js"></script> 
	<script type="text/javascript" src="${contextPath}/resources/js/jquery-fileUpload.js"></script>
	<script type="text/javascript">
	 	var editFlag = undefined;
		$(function(){
			var risk_reportTypeArr = eval('${risk_reportTypeArr}');
		
			var bodyW = $('body').width();    
			var bodyH = $('body').height();   
			$('#query_year').show();
			$('#query_reportType').show();
			frloadOpen();
			
		
			var g1 = new createQDatagrid({
				// 表格dom对象，必填
				gridObject:$('#templateTable')[0],
				// 要进行检索的表对象(hibernate bean)名称， 进行拼接hql时使用; 必填
				boName:'RiskReportTemplate',
				// 对象主键,删除数据时使用-默认为“id”；必填
				pkName:'id',
			   // whereSql: 'od_id in (select odInfo.od_id from OdSuggestion where handle_person=\''+fname+'\') or od_creater=\''+fname+'\'',
				order:'asc',
				sort:'createDate',
				winWidth:800,
				winHeight:250,
				gridJson:{    
					checkOnSelect:true,
					rownumbers:false,
					selectOnCheck:true,
					singleSelect:false,
					onLoadSuccess:frloadClose,
					<s:if test="${param.view != 'view'}">
					toolbar:[{
						text:'新增',
						iconCls:'icon-add',
						handler:function () {
							$("#templateTable").datagrid('insertRow', {//在指定行添加数据，appendRow是在最后一行添加数据
								index: 0, // 行数从0开始计算
								row: {
									templateId: '<%=new UUID().toString()%>',
									id: '<%=new UUID().toString()%>',
									file_id:'<%=new UUID().toString()%>',
									templateCode: '',
									year: '${currentYear}',
									templateName: '',
									version: '',
									addReportTemp:'addReport'
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
							var rowstr = JSON.stringify(rows);  
							 $.ajax({
								url:'${contextPath}/riskManagement/knowledgeBase/riskReportTemplate/saveRiskReportTemplate.action',
								async:false,
								type:'POST',
								data:{'rowstr':rowstr},
								success:function(data) {
									if(data == '1') {
										showMessage1('保存成功！');
										 g1.refresh();
									}
								}
							}); 
						}  
					}] ,
					</s:if>
					<s:if test="${param.view != 'view'}">
					columns:[[
								{field:'templateId', title:'选择', checkbox:true, align:'center', show:'false'},      
								{field:'templateCode', title:'编号', width:bodyW*0.16 + 'px', align:'center', sortable:true,  oper:'like'
									/* editor: {//设置其为可编辑
										type: 'text',//设置编辑样式 自带样式有：text，textarea，checkbox，numberbox，validatebox，datebox，combobox，combotree 可自行扩展
										options: { required: true}
									} */
								},
								{field:'year', title:'年度', width:bodyW*0.06 + 'px', align:'center', sortable:true, type:'custom', target:$('#query_year')[0],
									editor: {//设置其为可编辑
										type: 'text',
										options:{ required : true}
									}
								},
								{field:'templateName', title:'报告模板名称', width:bodyW*0.1 + 'px', align:'center', sortable:true, oper:'like',
									editor: {//设置其为可编辑
										type: 'text'
									}
								},
							 	{field:'reportType', title:'适用报告类型', width:bodyW*0.1 + 'px', align:'center', sortable:true, type:'custom', show:'false',target:$('#query_reportType')[0],
									editor: {//设置其为可编辑
										type: 'combobox',
										options:  { data: risk_reportTypeArr, valueField: "code", textField: "name",multiple:true}
									},
									formatter:function(value, row) {
										return row.reportTypeName;
									}
								}, 
								{field:'version', title:'版本', width:bodyW*0.05 + 'px', align:'center', sortable:true, show:'false', oper:'eq',
									editor: {//设置其为可编辑
										type: 'text'
									}
								
								},
								
								{field:'endDate', title:'最后修改时间', width:bodyW*0.13 + 'px', align:'center', sortable:true, show:'false', oper:'eq',
									
								},
								{field:'file_id', title:'报告模板附件', width:bodyW*0.16 + 'px', align:'center', sortable:true, show:'false', oper:'eq',
									 formatter:function(value, row) {
										 var t = "attachFile_";
										 t = t+ row.file_id;
										 var c = "<div  id=\""+t+"\" ></div>"; 
									    return c;
										 }
								},
								{field:'createfile', title:'报告模板附件操作', width:bodyW*0.13 + 'px', align:'center', sortable:true, show:'false', oper:'eq',
							
									 formatter:function(value, row) {
										 var c = "";
										 if('view' != "${param.view}"){
											 var t = "fileBtn_";
											 t = t+ row.file_id;
											  c = "<a href='javascript:void(0);'  id=\""+t+"\" ></a>";
										 }
										
									     return c; 
										 }
								}
							]],
					
					</s:if>
					<s:else>
					columns:[[
								{field:'templateCode', title:'编号', width:bodyW*0.16 + 'px', align:'center', sortable:true,  oper:'like'
								},
								{field:'year', title:'年度', width:bodyW*0.06 + 'px', align:'center', sortable:true, type:'custom', target:$('#query_year')[0],
									editor: {//设置其为可编辑
										type: 'text',
										options:{ required : true}
									}
								},
								{field:'templateName', title:'报告模板名称', width:bodyW*0.2 + 'px', align:'center', sortable:true, oper:'like',
									editor: {//设置其为可编辑
										type: 'text'
									}
								},
							 	{field:'reportType', title:'适用报告类型', width:bodyW*0.12 + 'px', align:'center', sortable:true, type:'custom', show:'false',target:$('#query_reportType')[0],
									editor: {//设置其为可编辑
										type: 'combobox',
										options:  { data: risk_reportTypeArr, valueField: "code", textField: "name",multiple:true}
									},
									formatter:function(value, row) {
										return row.reportTypeName;
									}
								}, 
								{field:'version', title:'版本', width:bodyW*0.07 + 'px', align:'center', sortable:true, show:'false', oper:'eq',
									editor: {//设置其为可编辑
										type: 'text'
									}
								
								},
								
								{field:'endDate', title:'最后修改时间', width:bodyW*0.13 + 'px', align:'center', sortable:true, show:'false', oper:'eq',
									
								},
								{field:'file_id', title:'报告模板附件', width:bodyW*0.19 + 'px', align:'center', sortable:true, show:'false', oper:'eq',
									 formatter:function(value, row) {
										 var t = "attachFile_";
										 t = t+ row.file_id;
										 var c = "<div  id=\""+t+"\" ></div>"; 
									    return c;
										 }
								}
							]],
					
					</s:else>
			

			        onLoadSuccess:function(data){   
			            findFile();
			            frloadClose();
			        }, 
			        onAfterEdit: function (rowIndex, rowData, changes) {//在添加完毕endEdit，保存时触发
						editFlag = undefined;//重置
					}, 
					
					onDblClickCell: function (rowIndex, field, value) {//双击该行修改内容
						if ('view' != "${param.view}"){
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
                <s:if test="${param.view == 'view'}">           
                {'index':1, 'display':false},
                {'index':2, 'display':true},
                {'index':3, 'display':false},
				</s:if>
                <s:else>
            	{'index':2, 'display':true},
            	{'index':3, 'display':true},
                </s:else>
				{'index':4, 'display':false},
				{'index':5, 'display':true},
				{'index':6, 'display':false},
				{'index':7, 'display':false},
				{'index':8, 'display':false}
			]);
		   
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
			
			genSelectOption("query_reportType", risk_reportTypeArr);

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
	
  function  findFile(){
       var rows=$('#templateTable').datagrid("getRows");
      if (rows.length > 0) {
      	for(var t=0;t<rows.length;t++){
      	    var file_id = 	rows[t].file_id;
      	    var fileListDiv = "attachFile_"+file_id;
  	    	var uploadBtnDiv = "fileBtn_"+file_id;
  		  $('#'+fileListDiv).fileUpload({
  	    	fileGuid:file_id,
  	    	triggerId:uploadBtnDiv,
  	    	<s:if test="${param.view}!='view'">
			isDel:false,
			isEdit:false,							
		   </s:if>
  	    	uploadFace:1,
  	    	echoType:2,
  	    	onFileSubmitSuccess:function(data){
  	    		//上传成功后获取文件名称
  	    		var rtData = $('#'+fileListDiv).fileUpload('getUploadFiles');
  	    		var fileName = rtData.rows[0].fileName;

  	    	}
  		  });			
      	}
      }
  }
	</script>
	</head>
	<body> 
		<div id="container" class='easyui-layout' fit='true'>	
			<div region="center">   	 	
				<table id='templateTable'></table>
			</div>
		</div>
		<!-- 自定义查询条件  -->
		<select id="query_year" name="query_year" style='width:130px; display:none;'></select>
		 <select id="query_reportType" name="query_reportType" style='width:130px; display:none;'></select> 
		<!-- ajax请求前后提示 -->
		<jsp:include flush="true" page="/pages/frReportFlow/ajaxloading.jsp" /> 
	</body>
</html>
