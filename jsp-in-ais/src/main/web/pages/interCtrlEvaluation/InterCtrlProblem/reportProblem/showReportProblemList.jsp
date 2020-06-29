<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML >
<html>
<title>评价项目计划列表</title>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<script type="text/javascript" src="${contextPath}/easyui/boot.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/jquery-fileUpload.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/autosize.js"></script>
<script type="text/javascript" src="${contextPath}/easyui/contextmenu.js"></script>  
<script type="text/javascript" src="${contextPath}/pages/tlInteractive/tlInteractiveCommon.js"></script>
<script type="text/javascript">
$(function(){
	var isView = "${view}" == "true" ? true : false;
	var editUrl = '${contextPath}/intctet/reportProblem/editRepoetProblem.action?project_id=${project_id}';
	var viewUrl = '${contextPath}/intctet/reportProblem/viewRepoetProblem.action?project_id=${project_id}';
	var tabTitle = isView ? "查看" : "编辑";
	var addBtn = {   
            text:'添加',
            iconCls:'icon-add',
            handler:function(){
            	aud$openNewTab('内控缺陷添加', editUrl, true);
            }
        };
	var viewBtn={
			text:'查看',
			iconCls:'icon-view',
			handler:function(){
				var h = window.screen.availHeight;
    			var w = window.screen.width;
    			var rows = $('#evaluationReportProblemList').datagrid('getChecked');
    			if(rows.length != 1 ){
    				top.$.messager.show({
    					title:'提示信息',
    					msg:'请选择一条信息！'
    				})
    				return false;
    			}
    			
    			var repoetProblemId = rows[0].id;
            	aud$openNewTab('查看内控缺陷', viewUrl+"&reportProblemId="+repoetProblemId);
			}
	};
	var editBtn ={
		text:'编辑',
	    iconCls:'icon-edit',
	    handler:function(){
	    	var h = window.screen.availHeight;
	    	var w = window.screen.width;
	    	var rows = $('#evaluationReportProblemList').datagrid('getChecked');
	    	if(rows.length != 1){
	    		top.$.messager.show({
	    			title:'提示信息',
	    			msg:'请 选择一条记录！'
	    		});
	    	}
	    	var repoetProblemId = rows[0].id;
        	aud$openNewTab('编辑内控缺陷', editUrl+"&reportProblem.id="+repoetProblemId);
	    }
		
	};
	var delBtn ={
			text:'删除',
		    iconCls:'icon-delete',
		    handler:function(){
		    	var h = window.screen.availHeight;
		    	var w = window.screen.width;
		    	var idAll = "";
		    	var rows = $('#evaluationReportProblemList').datagrid('getChecked');
		    	 if(rows.length == 0){
		    		top.$.messager.show({
		    			title:'提示信息',
		    			msg:'请 选择一条记录！'
		    		});
		    	}
		    	 for(var i =0;i< rows.length ;i++){
		    		 idAll =idAll + rows[i].id +",";
		    	 }
		    	
	        //	aud$openNewTab('编辑内控缺陷', editUrl+"&reportProblem.id="+repoetProblemId); 
	         $.ajax({
	        	url:'${contextPath}/intctet/reportProblem/delRepoetProblem.action?project_id=${project_id}&idAll='+idAll,
	        	type:'post',
	        	dataType:'json',
	        	success:function(data){
	        		
	        		if(data.successMsg == '1'){
	        	   		window.parent.$.messager.show({
							title:'提示信息',
							msg:"删除成功!",
							timeout:5000,
							showType:'slide'
						});
	        			window.aud$reportProblemGrid.refresh();
	        		}
	        		
	        	}
	         });
	        	
		    }
			
		};
	
	var cusToolbar = [];	
	if(!isView){
		cusToolbar.push(addBtn);
		cusToolbar.push('-');
		cusToolbar.push(delBtn);
		cusToolbar.push('-');		
	}


	var gridTableId = "evaluationReportProblemList";
    var reportProblemGrid = new createQDatagrid({
        // 表格dom对象，必填
        gridObject:$('#'+gridTableId)[0],
        // 要进行检索的表对象(hibernate bean)名称， 进行拼接hql时使用; 必填
        boName:'InterCtrlProblem',
        // 对象主键,删除数据时使用-默认为“id”；必填
        pkName:'id',
        order :'desc',
        sort  :'createTime',
        whereSql:" proId='${project_id}'",
		winWidth:800,
	    winHeight:250,
    	// 删除前的校验，如果返回true可以删除，否则为false
    	beforeRemoveRowsFn:function(rows, datagridObj){
    		return true;
    	},
        // 表格控件dataGrid配置参数; 必填
        gridJson:{	
        	singleSelect:true,
        	checkOnSelect:false,
        	selectOnCheck:false,
            toolbar:cusToolbar,
            onClickCell:function(rowIndex, field, value){
                var rows = $(this).datagrid('getRows');
                var row = rows[rowIndex];
                $(this).datagrid('unselectRow',rowIndex);
                $(this).datagrid('uncheckRow',rowIndex);
                if(field == 'defectCode'){	
                	var rurl = isView ? viewUrl+"&reportProblemId=" : editUrl+"&reportProblem.id=";
	            	aud$openNewTab('内控缺陷'+tabTitle, rurl+row['id'], true);
                }else if(field == 'manuscriptIndex' && row['defectCode'].indexOf("DFC") == -1){	
					var manuEditUrl = "${contextPath}/intctet/evaluationActualize/editManu.action?view=true&manuId="+row['manuId'];
   					aud$openNewTab("底稿查看", manuEditUrl, true)
                }
            },	
            frozenColumns:[[
                {field:'id',  title:'选择',checkbox:!isView,  align:'center', halign:'center', show:'false', hidden:isView},
                {field:'defectCode',title:'缺陷编号', width:'130px',align:'center',   halign:'center',  sortable:true, oper:'like'	,
                	formatter:formatterClick
                },
                {field:'defectName',title:'缺陷简述', width:'250px',align:'left',   halign:'center',  sortable:true, oper:'like',
                	formatter:function(value, row, index){
                		return "<label title='"+value+"'>"+value+"</label>";
                	}
                
                }
                           
            ]],
    		columns:[[
                {field:'manuscriptIndex',title:'底稿索引', width:'200px',align:'center',   halign:'center',  sortable:true,
                	formatter:function(value, row, index){
                		var rtval =  value;
                		if(row['defectCode'] && row['defectCode'].indexOf("DFC") == -1){
                			rtval = ["<label title='单击查看' style='cursor:pointer;color:blue;'>",value,"</label>"].join('') ;
                		}
                		return rtval;
                	}
                }, 
                {field:'circuitName',title:'所属${firstlevelName}', width:'100px',align:'center', halign:'center',  sortable:true, show:false,
					formatter:function(value,row,index){
						return value ? "<label title='"+value+"'>"+value+"</label>" : "";
					}	
                },
                {field:'controlName', title:'所属${lastlevelName}', width:'200px',align:'center', halign:'center',  sortable:true, oper:'like',
					formatter:function(value,row,index){
						return value ? "<label title='"+value+"'>"+value+"</label>" : "";
					}	
                }, 
                {field:'accountabilityUnit',  title:'被评价单位', width:'220px',align:'left', halign:'center',  sortable:true, show:false,
					formatter:function(value,row,index){
						return value ? "<label title='"+value+"'>"+value+"</label>" : "";
					}	
                },
                {field:'defectTypeName',title:'缺陷类型', width:'100px',align:'center', halign:'center',  sortable:true, show:false},
                {field:'relateLoss',title:'涉及到损失/错报的金额(万元)', width:'220px',align:'center',   halign:'center',  sortable:true, show:false,
                	formatter:aud$gridFormatMoney
                }, 	            
                {field:'defineResult',title:'认定结果', width:'100px',align:'center',   halign:'center',  sortable:true, show:false},              
                {field:'mendAdvice',title:'整改建议', width:'100px',align:'center',   halign:'center',  sortable:true, show:false}
                
          ]]
        }
    });
    

    function formatterClick(value){
    	return  ["<label title='单击"+tabTitle+"' style='cursor:pointer;color:blue;'>",value,"</label>"].join('') ;
    }
    
	window.aud$reportProblemGrid = reportProblemGrid;
    // 按钮权限
    isView ? $('.editElement').hide() : $('.viewElement').hide();
    // 删除按钮权限
    true? reportProblemGrid.batchSetBtn([ {'id':gridTableId+'_remove','remove':true} ]) : null;
    // 查询按钮权限
    /* g1.batchSetBtn([ {'id':gridTableId+'_search','remove':true} ]); */   
  
    


});
	function refresh() {
		$("#evaluationReportProblemList").datagrid('reload');
	}
</script>
</head>
<body style='padding:0px;margin:0px;overflow:hidden;' >
	<table id='evaluationReportProblemList'></table>

	<!-- 引入公共文件 -->
   <jsp:include flush="true" page="/pages/frReportFlow/ajaxloading.jsp" />
</body>
</html>