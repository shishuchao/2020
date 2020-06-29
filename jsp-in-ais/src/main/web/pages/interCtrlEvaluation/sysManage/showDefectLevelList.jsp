<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML >
<html>
<title>内控缺陷等级</title>
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
var gridTableId = "defectLevelTable";
$(function(){
	var isView = "${view}";
	var curDate= "${curDate}";
	var addBtn = {   
            text:'新增',
            iconCls:'icon-add',
            handler:function(){
            	addRow();
            }
        };
	var saveChangeBtn = {   
            text:'保存',
            iconCls:'icon-save',
            handler:function(){
            	endEditing();
            	var rows = $('#'+gridTableId).datagrid('getChanges','updated');
            	if(rows && rows.length){
            		updateRow(rows);
            	}else{
            		showMessage1("数据没有改变！不需保存！");
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
	
	var cusToolbar = isView ? [] : [saveChangeBtn,"-",addBtn,"-",'delete','-',rejectBtn,"-",];
    var g1 = new createQDatagrid({
        // 表格dom对象，必填
        gridObject:$('#'+gridTableId)[0],
        // 要进行检索的表对象(hibernate bean)名称， 进行拼接hql时使用; 必填
        boName:'DefectLevel',
        // 对象主键,删除数据时使用-默认为“id”；必填
        pkName:'dlId',
        order :'asc',
        sort  :'code',
		winWidth:800,
	    winHeight:250,
	    //自定义显示哪些按钮：myToolbar:['delete', 'export', 'search', 'reload'],
	    myToolbar:['export', 'reload'],
        // 表格控件dataGrid配置参数; 必填
        gridJson:{
        	pageSize:20,
        	singleSelect: false,
        	toolbar:cusToolbar,
        	onClickCell:function(index, field){
        		if(!isView && editIndex != index){    
        			if(endEditing()){
        				$('#'+gridTableId).datagrid('selectRow', index).datagrid('beginEdit', index);
        				//记录上一次的编辑的行，用于endEditing点击一个新行时，结束上次行的编辑
        				editIndex = index;
        			}
        		}
    		},
    		onEndEdit:function(index, row){
    			//alert(row.levelName)
    		},
    		frozenColumns:[[
    			
    			{field:'dlId',align:'center',   halign:'center', checkbox:true, sortable:true,show:false}, 
                {field:'code',title:'编号', width:'170px',align:'center',   halign:'center',  sortable:true}, 
                {field:'dlLevel',title:'缺陷等级',  width:'100px', align:'center', halign:'center',  sortable:true,
                		editor:'text',
        				formatter:function(value,row,index){
        					return value ? "<label title='"+value+"'>"+value+"</label>" : "";
        				}		
                },   
                {field:'dlStandard', title:'缺陷认定标准', width:'35%',align:'left', halign:'center',  sortable:true,
                		editor:'text',
        				formatter:function(value,row,index){
        					return value ? "<label title='"+value+"'>"+value+"</label>" : "";
        				}		
                }
    		]],
    		columns:[[
                {field:'remarks', title:'备注', width:'45%',align:'left',halign:'center',  sortable:true, show:false,
                		editor:'text',
        				formatter:function(value,row,index){
        					return value ? "<label title='"+value+"'>"+value+"</label>" : "";
        				}	
                },   
          ]]
        }
    });
    
    isView ? $('#'+gridTableId).datagrid('hideColumn', 'dlId') : null;
    var editIndex = undefined;
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
	// 增行
    function addRow(){
    	var url = "${contextPath}/intctet/sysManage/defectLevel/insertDefectRow.action";
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
    //保存修改数据
    function updateRow(rows){
    	var sendData = aud$rows2Json("mtlList", rows);   
		$.ajax({
			url : "${contextPath}/intctet/sysManage/defectLevel/updateDefectRow.action",
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
	<table id="defectLevelTable"></table>
	<!-- 引入公共文件 -->
   <jsp:include flush="true" page="/pages/frReportFlow/ajaxloading.jsp" />
</body>
</html>