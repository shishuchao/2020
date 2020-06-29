<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML >
<html>
<title>内控评价-主流程</title>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<script type="text/javascript" src="${contextPath}/easyui/boot.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/jquery-fileUpload.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/jquery-parseExcel.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/autosize.js"></script>
<script type="text/javascript" src="${contextPath}/pages/tlInteractive/tlInteractiveCommon.js"></script>
<script type="text/javascript">
var gridTableId = "mainProcessTable";
$(function(){
	var isView = "${view}" == true || "${view}" == "true" ? true : false;	
	var editIndex = undefined;	  
	var totalView = {   
	         text:'总览',
	         iconCls:'icon-view',
	         handler:function(){
	 			window.location.href = "${contextPath}/intctet/mainProcess/showTotalProcess.action?view=${view}"; 
	         }
	     };	
	var saveChangeBtn = {   
            text:'保存',
            iconCls:'icon-save',
            handler:function(){       		
	            if(endEditing() && checkAllRows(['nodeName'])){            	
	            	var rows = $('#'+gridTableId).datagrid('getChanges','updated');
	            	if(rows && rows.length){
	            		updateRow(rows);
	            		$('#'+gridTableId).datagrid('acceptChanges');
	            	}else{
	            		showMessage1("数据没有改变！不需保存！");
	            	}
	            }else{
    				$('#'+gridTableId).datagrid('selectRow', editIndex);
    				showMessage1('数据校验未通过')
    			}
            }
        };
	var rejectBtn = {   
         text:'撤销',
         iconCls:'icon-undo',
         handler:function(){
 			$('#'+gridTableId).datagrid('rejectChanges');
 			editIndex = undefined;
         }
     };	
	var addRowBtn = {   
         text:'新增',
         iconCls:'icon-add',
         handler:addRow
     };
	
	var downloadTemplateBtn = {   
        text:'下载模板',
        iconCls:'icon-download',
        handler:function(){
        	$('#parseExcelContainer').parseExcel('downloadTemplate');
        }
    };
	var importExcelBtn = {   
        text:'导入文件',
        iconCls:'icon-upload',
        id:'importExcelBtn'
    }
	
	var cusToolbar = isView ? [totalView,"-"] : [
		 totalView,"-",saveChangeBtn,"-",addRowBtn,"-", 'delete','-',rejectBtn,"-",downloadTemplateBtn,'-',importExcelBtn,'-'];
	
    var g1 = new createQDatagrid({
        // 表格dom对象，必填
        gridObject:$('#'+gridTableId)[0],
        // 要进行检索的表对象(hibernate bean)名称， 进行拼接hql时使用; 必填
        boName:'MainProcess',
        // 对象主键,删除数据时使用-默认为“id”；必填
        pkName:'nodeId',
        order :'asc',
        sort  :'createTime',
		winWidth:500,
	    winHeight:250,
	    //自定义显示哪些按钮：myToolbar:['delete', 'export', 'search', 'reload'],
	    myToolbar:['export', 'reload'],
	    //删除前执行
	    beforeRemoveRowsFn:function(rows, gridObject){
	    	return true;
	    },
	    //删除数据成功后调用 afterRemoveRowsFn(rows, gridObject) 
	    afterRemoveRowsFn:function(rows, gridObject){
	    	reloadParentTree();
	    },
		//定制查询
		whereSql: "parentCode is null ",
        // 表格控件dataGrid配置参数; 必填
        gridJson:{
        	rownumbers:false,
        	singleSelect:true,
        	checkOnSelect:false,
        	selectOnCheck:false,
        	toolbar:cusToolbar,
        	onLoadSuccess:function(data){
        		//新添加的记录，编辑and选中要编辑的列
        		checkSuccessData(data, "nodeName");
        	},
        	onClickCell:function(index, field){
        		if(!isView && (field == 'nodeName' || field == 'remark')){    
        			if(endEditing()){
        				editAndSelect(index, field);     				
        			}else{
        				$('#'+gridTableId).datagrid('selectRow', editIndex);
        			}
        		}
    		},
    		columns:[[
    			{field:'nodeId',   title:'选择', width:'10px', halign:'center', sortable:true, show:'false', checkbox:!isView, hidden:isView}, 
                {field:'nodeCode', title:'编码', 
					width:'100px',align:'center', halign:'center', sortable:true, show:false}, 
                {field:'nodeName', title:'主流程',
					width:'180px',align:'center', halign:'center', sortable:true, 
					editor:{type:'validatebox',options:{required:true, validType:'length[1,100]'}}, oper:'like'},   
                {field:'remark', title:'备注', width:'250px',align:'left', halign:'center',
					 editor:{type:'textarea',options:{validType:'length[1,2000]'}},  
					 sortable:true, oper:'like'},
                {field:'attachmentId', title:'附件', width:'280px',align:'left', halign:'center',  sortable:true, show:'false',
					formatter:function(value,row,index){
						return "<div id='fileItem"+index+"'></div>";
					}
                },
                {field:'operation', title:'操作', width:'120px',align:'center',halign:'center',  sortable:true, show:'false',
                	hidden:isView,
					formatter:function(value,row,index){
						window.setTimeout(function(){
							/*
							$('#fileTigger'+index).linkbutton({    
							    iconCls: 'icon-upload',
							    text:'上传附件'
							}); */
							initFileUploadPlug(index, row['attachmentId']);
						},0)
						return "<span id='fileTigger"+index+"' style='border-width:0px;'></span>";
					}
                }
          ]]
        }
    });
    
    //编辑and选中
    function editAndSelect(index, field){
    	try{
			$('#'+gridTableId).datagrid('selectRow', index).datagrid('beginEdit', index);	       				
			var ed = $('#'+gridTableId).datagrid('getEditor', {index:index,field:field});
			if(ed){
				$(ed.target).select().focus();
			}	       				
				//记录上一次的编辑的行，用于endEditing点击一个新行时，结束上次行的编辑
			editIndex = index;   
    		
    	}catch(e){
    		alert('editAndSelect:\n'+e.message);
    	}
    }
    
    //检查加载的数据，必填项是否有空值，有的话，选中
    function checkSuccessData(data, field){
    	window.setTimeout(function(){    		
    		checkRows(data, field);
    	}, 50);
    }
    
    function checkRows(data, field){
    	var rt = true;
    	if(data && data.rows && data.rows.length){    		
    		var fields = [];
    		if($.type(field) === "string"){
    			fields.push(field);
    		}else{
    			fields = field;
    		}
    		var rows = data.rows;
    		var len = rows.length;
    		for(var index = 0; index < len; index++){
				for(var i=0; i<fields.length; i++){	
					var field = fields[i];	
					//alert('index='+index+"\nfield="+field+"\nvalue="+rows[index][field])
	        		if(!rows[index][field]){      									
						editAndSelect(index, field);
						rt = false;
						break;
	        		}
				}
				if(!rt)break;
    		}
    	}
    	return rt;
    }
    //检查所有行是否校验通过
    function checkAllRows(field){
    	var rows = $('#'+gridTableId).datagrid('getRows');
    	return checkRows({'rows':rows}, field);
    }
    
    
    //初始化上传文件控件
    function initFileUploadPlug(index, attachmentId){
        $('#fileItem'+index).fileUpload({
        	fileGuid:attachmentId,
            /*
           	文件上传后，回显方式选择， 默认：1
            1：在当前容器下生成datagrid表格，提供“添加、修改、删除、查看、下载”等功能，可以通过参数对按钮权限进行配置。
            2：以文件名列表形式展示，一个文件名称就是一行
            3：不回显，根据控件提供的方法（getUploadFiles详见使用手册），自己定义回显样式
            */
        	echoType:2,
        	// 上传界面类型， 0：（默认）弹出dialog窗口和表格 1：直接选择上传文件
        	uploadFace:1,
            triggerId:'fileTigger'+index,
            isDel:!isView,
            isEdit:!isView
        })
    }
   
    // 结束编辑
	function endEditing(){
		if(editIndex == undefined){return true}
		if($('#'+gridTableId).datagrid('validateRow', editIndex)){
			$('#'+gridTableId).datagrid('endEdit', editIndex);
			editIndex = undefined;
			return true;
		}else{
			return false;
		}
	}

    // 增行、删行
    function addRow(){
    	var url = "${contextPath}/intctet/mainProcess/insertRow.action";
		$.ajax({
			url : url,
			dataType:'json',
			type: "post",
			success: function(data){
				data.msg ? showMessage1(data.msg) : null;
       			if(data.type = 'info'){
       				g1.refresh();
       			}
			},
			error:function(data){
				top.$.messager.show({title:'提示信息',msg:'请求失败！请检查网络配置或者与管理员联系！'});
			}
		});
    }
    window.aud$addRow = function(rowIndex){
    	addOrDelRow(rowIndex);
    }
    window.aud$delRow = function(rowIndex){
    	addOrDelRow(rowIndex, true);
    }
	
    //保存修改数据
    function updateRow(rows){
    	var sendData = aud$rows2Json("updateRow", rows);   
		$.ajax({
			url : "${contextPath}/intctet/mainProcess/updateRow.action",
			dataType:'json',
			type: "post",
			data: sendData,
			beforeSend:function(){
				 var check = sendData != null ? true : false;
				 if(!check){
					 showMessage1("没有数据发生变化，不需保存");
				 }
				 return check;
			},
			success: function(data){
				data.msg ? showMessage1(data.msg) : null;
       			if(data.type = 'info'){
       				g1.refresh();
       				reloadParentTree();
       			}
			},
			error:function(data){
				top.$.messager.show({title:'提示信息',msg:'请求失败！请检查网络配置或者与管理员联系！'});
			}
		});
    }
    
    //刷新父页面树形
    function reloadParentTree(selectNode){
		if(parent.left$tree){
			parent.aud$locationLeftTreeNode(selectNode ? selectNode.id : null);
		}
    }
    
	//excel文件导入
    $('#parseExcelContainer').parseExcel({ 
		triggerId:'importExcelBtn',
		title:'导入主流程',
		beanName:'MainProcess',
		boPk:'nodeId',
        //上传成功后，要刷新的datagrid id
        datagridId:gridTableId,
        //下载模板的名字
        templateFileName:'mainProcess.xlsx',
        //下载模板的路径
        templateFilePath:'interCtrlEvaluation&template',
		//导入成功后调用
		onImportSuccess:function(target, options){
			reloadParentTree();
		}
	});
});
</script>
</head>
<body style='padding:0px;margin:0px;overflow:hidden;' class="easyui-layout" fit='true' border='0'>
	<div title="主流程" region='center' style='overflow:hidden;' border='0' split='true' collapsible='true'>
		<table id="mainProcessTable"></table>
	</div>
	<!-- 引入公共文件 -->
    <jsp:include flush="true" page="/pages/frReportFlow/ajaxloading.jsp" />
    <!-- 文件导入解析 -->
	<div id="parseExcelContainer"></div>
</body>
</html>