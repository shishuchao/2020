<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<jsp:directive.page import="ais.framework.util.UUID"/>
<!DOCTYPE HTML>
<html>
	<title>数据采集</title>
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
	   
	    var projectId = "${projectId}";
	    var flag = "${flag}";
	    var isView = "${view}" == true ||  "${view}" == 'true' ? true : false;
	    var editUrl = '${contextPath}/project/prepare/editDataGather.action';
		var tabTitle = isView ? "查看" : "编辑";
		var curTabId = aud$getActiveTabId();
		$(function(){
			var systemNameArr = eval('${systemNameArr}');
			var bodyW = $('body').width();    
			var bodyH = $('body').height();   
			frloadOpen();
			var g1 = new createQDatagrid({
				// 表格dom对象，必填
				gridObject:$('#dataGatherTable')[0],
				// 要进行检索的表对象(hibernate bean)名称， 进行拼接hql时使用; 必填
				boName:'DataGatherForm',
				whereSql: " projectId='"+projectId+"' ",
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
							window.location.href = editUrl+'?view='+isView+'&projectId='+projectId+'&activeTabId='+curTabId+'&flag='+flag;
						
						}
					}, '-', {  
						text: '删除',
						iconCls: 'icon-delete',
						handler: function () {  
							var rows = $("#dataGatherTable").datagrid('getChecked');
							 //倒序，删除时候，先删除前边的，导致rownum发生变化，删除后边数据时串行
							var rowsdb = [];
				            var rowsdel = [];
				            var index =-1;
				            var i = 0;
				    		for(i=rows.length;i>0;i--){
				    			index = $('#dataGatherTable').datagrid('getRowIndex',rows[i-1]);
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
											url:'${contextPath}/project/prepare/deleteDataGather.action',
											async:false,
											type:'POST',
											data:{'ids':ids.join(","),'flag':flag,'projectId':projectId},
											success:function(data) {
												if(data == '1') {
													$("#dataGatherTable").datagrid('reload');
													showMessage1('删除成功！');
												}
											}
										});
									}
								});
							}
						}  
					},'-', {  
						text: '下载',
						iconCls: 'icon-download',
						handler: function () {  
							downLoadFile();
						}  
					},'-',{  
						text: '发起采集',
						iconCls: 'icon-edit',
						handler: function () {
							updateStatic();
						}  
					}
					],
					onClickCell:function(rowIndex, field, value){
		                if(field == 'sapName'){
		                    var rows = $(this).datagrid('getRows');
		                    var row = rows[rowIndex];
		                    $(this).datagrid('unselectRow',rowIndex);
		                    $(this).datagrid('uncheckRow',rowIndex);
		                    var eview = row["statusCode"] == '0' ? false : true;
		                    if ("${view}" == 'view'){
		                    	eview = true;
		                    }
		                    //aud$openNewTab("采集任务"+(eview ? "查看":"编辑"), editUrl+"?id="+row['id']+(eview ? "&view=true" : "")+"&cruProId="+projectId+"&isEdit=1", true);
		                    window.location.href = editUrl+'?id='+row['id']+'&projectId='+projectId+'&isEdit=1&'+(eview ? '&view=true' : '');
		                }
			        },
					columns:[[
						{field:'id', title:'选择', checkbox:true, align:'center',sortable:true},  
						{field:'account_year', title:'账套年度', width:'10%', align:'center', halign:'center', sortable:true},
						{field:'auditObject', title:'被审计单位code',align:'center', halign:'center', sortable:false, hidden:true},
						{field:'auditObjectName', title:'被审计单位', width:'10%', align:'center', halign:'center', sortable:true}, 
						{field:'auditStartTime', title:'采集开始年度', width:bodyW*0.10 + 'px', align:'center', sortable:true,show:'false'},
						{field:'auditEndTime', title:'采集结束年度', width:bodyW*0.10 + 'px', align:'center', sortable:true,show:'false'},
						{field:'sapName', title:'SAP系统名称', width:bodyW*0.10 + 'px', align:'center', sortable:true,
							formatter:function(value, rowData, rowIndex) {
								var sapName = "";
								$.ajax({
									url:'${contextPath}/project/prepare/getSapNameValue.action?sapId=' + value,
									async:false,
									type:'POST',
									success:function(data){
										sapName = data.sapName;
									}
								});
								var title = rowData["statusCode"] == '1' ? "查看" : "编辑";
								return ["<label title='单击"+title+"' style='cursor:pointer;color:blue;'>",sapName,"</label>"].join('');
							}
						},
						{field:'sapNameValue', sortable:false, hidden:true},
						{field:'creater', title:'发起人', width:bodyW*0.10 + 'px', align:'center', sortable:true,show:'false'},
						{field:'createTime', title:'发起时间', width:bodyW*0.10 + 'px', align:'center', sortable:true,show:'false'},
						{field:'statusCode', title:'采集状态', width:bodyW*0.10 + 'px', align:'center', sortable:true, show:'false',
							formatter:function(value,row,index){
					 			if(value == '0'){
					 				return "未发起" ;
					 			 }else if(value == '1'){
					 				return "已发起";
					 			 }else if(value == '2'){
					 				return "采集完成";
					 			 }else if(value == '3'){
					 				return "采集失败";
					 			 }
					 		}
						},
						{field:'statusExplain', title:'采集状态说明', width:bodyW*0.10 + 'px', align:'center', sortable:true},
						{field:'sapUrl', title:'url',sortable:false, hidden:true},
						{field:'finishFileName', title:'已采集数据', width:bodyW*0.10 + 'px', align:'center', sortable:true,
							formatter:function(value,row,index){
								var finishFileName;
								if(row.finishFileName == null){
									finishFileName = "";
								}else{
									finishFileName = row.finishFileName;
								}
								return ["<label style='cursor:pointer;color:blue;'>","<a onclick= \"getherData('"+row.id+"')\">"+finishFileName+"</a>","</label>"].join('');
							}	
						}
						
					]]
				}
			});	
			g1.batchSetBtn([
				{'index':1, 'display':true},
				{'index':2, 'display':true},
				//{'index':3, 'display':true},
				{'index':4, 'display':true},
				{'index':5, 'display':false},
				{'index':6, 'display':false},
				{'index':7, 'display':false},
				{'index':8, 'display':false}
			]);
			
			if(flag == "enabled"){ //开启
				g1.batchSetBtn([{'index':3, 'display':true}]);
			 }else{
				g1.batchSetBtn([{'index':3, 'display':false}]);
			} 
			if ("${view}" == "view"){
				g1.batchSetBtn([{'index':1, 'display':false}]);
				g1.batchSetBtn([{'index':2, 'display':false}]);
			}
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
		
		//下载
		function downLoadFile(){
			//采集状态为 已经采集的就不能进行下载附件，给予提示
			var rows = $("#dataGatherTable").datagrid('getChecked');
			var ids = [];
		    if(rows && rows.length){
	        	for(var i=0;i<rows.length;i++){
	 				ids.push(rows[i].id);
	 				var row = rows[i];
		        	var statusCode = row["statusCode"];
		        	
		        	if(statusCode == "1" || statusCode == "2"){//1已发起；2采集完成
		        		showMessage1('选择中的采集任务有重复下载任务！');
		        		return false;
		        	}
	 			}
	        	window.location.href = "${contextPath}/project/prepare/downLoadDataGather.action?ids="+ids.join(',')+"&flag="+flag;
		    }else{
	            showMessage1('请选择要下载的任务！');
	            return;
		    }
			
		}
		
		//发起采集
		function updateStatic(){
			var rows = $("#dataGatherTable").datagrid('getChecked');
			var ids = [];
		    if(rows && rows.length){
	       		for(var i=0;i<rows.length;i++){
					ids.push(rows[i].id);
				}
       	 	 $.ajax({
                  url:'${contextPath}/project/prepare/updateStatic.action',
                  type:'post',
                  cache:false,
                  dataType:'json',
                  data:{
                      'ids':ids.join(',')
                  },
                  success:function(data){
                      showMessage1(data.msg);
                      $("#dataGatherTable").datagrid('reload');
                  }
              });
		    }else{
	            showMessage1('请选择要采集的任务！');
	            return;
		    }
		}
		
		//获取已经采集文件
		function getherData(id){
			window.location.href = "${contextPath}/project/prepare/getFinishFile.action?id="+id;
		}
	</script>
	</head>
	<body class="easyui-layout" style='padding:0px;margin:0px;overflow:hidden;' fit="true" border="0">
			<div id="container" class='easyui-layout' fit='true'>	
				<div region="center">   	 	
					<table id='dataGatherTable'></table>
				</div>
			</div>
		<jsp:include flush="true" page="/pages/frReportFlow/ajaxloading.jsp" />
	</body>
</html>
