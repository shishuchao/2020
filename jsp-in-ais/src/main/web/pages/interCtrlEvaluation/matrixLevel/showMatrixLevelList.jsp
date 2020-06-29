<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML >
<html>
<title>矩阵层级</title>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<script type="text/javascript" src="${contextPath}/easyui/boot.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
<script type="text/javascript" src="${contextPath}/pages/tlInteractive/tlInteractiveCommon.js"></script>

<script type="text/javascript">
var gridTableId = "matrixLevelTable";
$(function(){
	var isView = "${view}" == true || "${view}" == "true" ? true : false;	
	var editIndex = undefined;
	  
	var saveChangeBtn = {   
            text:'保存',
            iconCls:'icon-save',
            handler:function(){
            	saveRows();
            }
        };
	
	function saveRows(noMsg){
    	if(endEditing() && checkAllRows('levelName')){            		
        	var rows = $('#'+gridTableId).datagrid('getChanges','updated');
        	if(rows && rows.length){
        		updateRow(rows);
        		return true;
        	}else{
        		noMsg ? "" : showMessage1("数据没有改变！不需保存！");
        		return false;
        	}
    	}else{
			$('#'+gridTableId).datagrid('selectRow', editIndex);
			noMsg ? "" : showMessage1('数据校验未通过');
			return false;
		}
	}
	
	var rejectBtn = {   
            text:'撤销',
            iconCls:'icon-undo',
            handler:function(){
    			$('#'+gridTableId).datagrid('rejectChanges');
    			editIndex = undefined;
            }
        };
	
	var cusToolbar = isView ? [] : [saveChangeBtn,"-",rejectBtn,"-"];
    var g1 = new createQDatagrid({
        // 表格dom对象，必填
        gridObject:$('#'+gridTableId)[0],
        // 要进行检索的表对象(hibernate bean)名称， 进行拼接hql时使用; 必填
        boName:'MatrixLevel',
        // 对象主键,删除数据时使用-默认为“id”；必填
        pkName:'mtlId',
        order :'asc',
        sort  :'levelCode',
		winWidth:800,
	    winHeight:250,
	    //自定义显示哪些按钮：myToolbar:['delete', 'export', 'search', 'reload'],
	    myToolbar:['export', 'reload'],
        // 表格控件dataGrid配置参数; 必填
        gridJson:{
        	pageSize:20,
        	singleSelect: true,
        	toolbar:cusToolbar,
        	onLoadSuccess:function(data){
        		//新添加的记录，编辑and选中要编辑的列
        		checkSuccessData(data, "levelName");
        	},
        	onClickCell:function(index, field){
        		if(!isView && (field == 'levelName')){    
        			if(endEditing()){
        				editAndSelect(index, field);     				
        			}else{
        				$('#'+gridTableId).datagrid('selectRow', editIndex);
        			}
        		}
    		},
    		onEndEdit:function(index, row){
    			//alert(row.levelName)
    		},
    		columns:[[
                {field:'levelName',    title:'<strong><font color=red>*</font></strong>内控矩阵层级名称', width:'50%',align:'left',   halign:'center',  sortable:true,
					formatter:formateNodes, 
					editor:{type:'validatebox',options:{required:true, validType:'length[1,100]'}}}, 
                {field:'lastCtrlPointName',title:'是否末级控制点',  width:'120px', align:'center', halign:'center',  sortable:true},   
                {field:'levelCode',    title:'编码', width:'200px',align:'left', halign:'center',  sortable:true},
                {field:'operation',    title:'操作', width:'100px',align:'center', hidden:isView, 
					halign:'center',  sortable:true, show:'false', formatter:addOperHtml }
          ]]
        }
    });
    
   
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
    
    //编辑and选中
    function editAndSelect(index, field){
    	try{
			$('#'+gridTableId).datagrid('selectRow', index).datagrid('beginEdit', index);	       				
			var ed = $('#'+gridTableId).datagrid('getEditor', {index:index,field:field});
			if(ed){
				($(ed.target).data('textbox') ? $(ed.target).textbox('textbox') : $(ed.target)).select().focus();
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
    
    // 缩进
    function formateNodes(value,row,index){
    	var arr = [];
    	arr.push("<span>")
    	for(var i=0; i<index; i++){
    		arr.push("<img class='icon-blank'></img>");
    	}
    	arr.push(value)
    	arr.push('</span>');
    	return arr.join('');
    }
    
    // 添加操作按钮
    function addOperHtml(value,row,index){
    	var arr = [];
    	arr.push("<a href='javascript:void(0);' onclick=aud$editRow("+index+") class='l-btn-left l-btn-icon-left' title='编辑'>");
    	arr.push("<span class='l-btn-text l-btn-empty'></span><span class='l-btn-icon icon-edit'></span></a>");
    	if(row['lastCtrlPoint'] == '0'){   		
	    	arr.push("<a href='javascript:void(0);' onclick=aud$addRow("+index+") class='l-btn-left l-btn-icon-left' title='增行'>");
	    	arr.push("<span class='l-btn-text l-btn-empty'></span><span class='l-btn-icon icon-add'></span></a>");
	    	if(row['parentId']){	    		
		    	arr.push("<a href='javascript:void(0);' onclick=aud$delRow("+index+") class='l-btn-left l-btn-icon-left' title='删行'>");
		    	arr.push("<span class='l-btn-text l-btn-empty'></span><span class='l-btn-icon icon-remove'></span></a>");
	    	}
    	}
    	return arr.join("");
    }
    
    // 增行、删行
    function addOrDelRow(rowIndex, isDel){
    	var rows = $('#'+gridTableId).datagrid('getRows');
    	var row = rows[rowIndex];
    	var url = "${contextPath}/intctet/matrixLevel/" + (isDel ? "deleteRow" : "insertRow") + ".action";
    	//保存、删除前保存一下
    	saveRows(true)
    	
    	if(isDel){
    		top.$.messager.confirm('提示信息','是否删除选中记录?',function(r){
    			r ? maction() : null;
    		});
    	}else{
    		maction();
    	}
    	
    	function maction(){  		
	    	setTimeout(function(){		
				$.ajax({
					url : url,
					dataType:'json',
					type: "post",
					data: {
						'mtlId':row.mtlId,
						'parentId':row.parentId
					},
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
	    	},200);
    	}
    }
    window.aud$addRow = function(rowIndex){
    	addOrDelRow(rowIndex);
    }
    window.aud$delRow = function(rowIndex){
    	addOrDelRow(rowIndex, true);
    }
	
    
    
    //保存修改数据
    function updateRow(rows){
    	var sendData = aud$rows2Json("mtlList", rows);   
		$.ajax({
			url : "${contextPath}/intctet/matrixLevel/updateRow.action",
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
       			}
			},
			error:function(data){
				top.$.messager.show({title:'提示信息',msg:'请求失败！请检查网络配置或者与管理员联系！'});
			}
		});
    }
});
</script>
</head>
<body style='padding:0px;margin:0px;overflow:hidden;' >
	<table id="matrixLevelTable"></table>
	<!-- 引入公共文件 -->
   <jsp:include flush="true" page="/pages/frReportFlow/ajaxloading.jsp" />
</body>
</html>