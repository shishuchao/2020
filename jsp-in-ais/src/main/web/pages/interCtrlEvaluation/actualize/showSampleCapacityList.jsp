<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>

<script type="text/javascript">

//自定义datagrid行editor
$.extend($.fn.datagrid.defaults.editors, {    
    qtree: {    
        init: function(container, options){
        	var wrap = $('<div></div>').appendTo(container);
            var input = $('<input type="text" style="width:80%" readonly>').appendTo(wrap[0]).bind('click', function(){
            	trigger.trigger('click');
            }); 
            input.validatebox(options);
            
            $('<input type="hidden" readonly>').appendTo(wrap[0]);
            var trigger = $("<label></label>")
            .appendTo(wrap[0]).bind('click', function(){
            	aud$editorQtree(this);
            });
            return input;    
        },    
        getValue: function(target){    
            return $(target).val();    
        },    
        setValue: function(target, value){    
            $(target).val(value);    
        },    
        resize: function(target, width){    
            var input = $(target);    
            if ($.boxModel == true){    
                input.width(width - (input.outerWidth() - input.width()));    
            } else {    
                input.width(width);    
            }    
        }
    }    
}); 

function aud$editorQtree(target){
	showSysTree(target,{
		title:'测试结果选择',
		noMsg:true,
		queryBox:false,
	    onlyLeafClick:true,
		param:{
			'plugId':'710015',
		    'whereHql':'type=\'710015\'',
		    'customRoot':'测试结果',
		  	'rootParentId':'0',
	        'beanName':'CodeName',
	        'treeId'  :'id',
	        'treeText':'name',
	        'treeParentId':'pid',
	        'treeOrder':'name'
	    },
	    onAfterSure:function(dms, mcs){
	    	$(scGridObj).data('sampleResultCode', dms[0]);
	    }
	});
}


//样本量初始化
var scGridTableId = "sampleTable";
$(function(){
	var curTabId = aud$getActiveTabId();
	var parentTabId = '${parentTabId}';
	var editIndex = undefined;	

	function saveSampleCapacity(noMsg){
        if(aud$validRows(scGridTableId) && endEditing()){       
        	//inserted,deleted,updated
        	var rows = $('#'+scGridTableId).datagrid('getChanges','updated');
        	if(rows && rows.length){
        		updateRow(rows);
        		$('#'+scGridTableId).datagrid('acceptChanges');
        	}else{
        		noMsg ? "" : showMessage1("数据没有改变！不需保存！");
        	}
        	return true;
        }else{
			$('#'+scGridTableId).datagrid('selectRow', editIndex);
			showMessage1('【样本量】表格数据校验未通过', function(){
				var gridY = QUtil.getElementPos($('#'+scGridTableId).parent().get(0)).y;
				if(gridY){
					$('#layoutCenter').scrollTop(gridY - 150);
				}
			});
			return false;
		}
	} 
	
	window.aud$saveSampleCapacity = saveSampleCapacity;
	
	var saveBtn = {   
	        text:'保存',
	        iconCls:'icon-save',
	        handler:function(){
	        	saveSampleCapacity(false);
	        }
	    };
	
	var addBtn = {
	        text:'新增',
	        iconCls:'icon-add',
	        handler:function(){
	        	aud$batchAppendSample(1, "${manu.projectId}", "${manu.manuId}", true); 
	        }	
	}
	
	var cusToolbar = isView ? [] : [saveBtn,'-',addBtn,'-'];
	
	
	window.scGridObj = new createQDatagrid({
        // 表格dom对象，必填
        gridObject:$('#'+scGridTableId)[0],
        // 要进行检索的表对象(hibernate bean)名称， 进行拼接hql时使用; 必填
        boName:'SampleCapacity',
        // 对象主键,删除数据时使用-默认为“id”；必填
        pkName:'scId',
        order :'asc',
        sort  :'createTime',
		winWidth:500,
	    winHeight:250,
	    //自定义显示哪些按钮：myToolbar:['delete', 'export', 'search', 'reload'],
	    myToolbar:isView ? ['export', 'reload'] : ['delete', 'export', 'reload'],
	    associate:true,
		//定制查询
		whereSql: " manuId='${manu.manuId}' and projectId='${manu.projectId}' ",
        gridJson:{
			title:'样本测试结果',
		    pageSize:10,
        	singleSelect:true,
        	checkOnSelect:false,
        	selectOnCheck:false,
    		border:0,
    		fit:true,
    		toolbar:cusToolbar,
        	onClickCell:function(index, field){
        		if(!isView && (field != 'scId')){    
        			if(endEditing()){
        				editAndSelect(index, field);     				
        			}else{
        				$('#'+scGridTableId).datagrid('selectRow', editIndex);
        			}
        		}
    		},
    		onLoadSuccess:function(data){
    			var isNewAdd = $('#'+scGridTableId).data('isNewAdd');
    			//alert('isNewAdd='+isNewAdd)
    			if(isNewAdd){
       				window.setTimeout(function(){
       					editAndSelect(data.rows.length-1, "sampleName");
       					$('#'+scGridTableId).removeData('isNewAdd');
       				},500);
    			}
    			$('#manu_sampleSize').val(data.total);
    		},
    		columns:[[
				{field:'scId',    	   title:"选择",     width:'5px', align:'center', halign:'center', checkbox:true, show:'false', hidden:isView},
    			{field:'sampleNum',    title:"样本序号",  width:'100px', align:'center', halign:'center',sortable:true},
				{field:'sampleName',   title:"样本名称",  width:'150px', align:'left', halign:'center',sortable:true,
    				editor:{type:'validatebox', options:{required:true, validType:'length[1,100]'}} },				
				{field:'sampleResult', title:"测试结果",  width:'80px', align:'center', halign:'center',
    				editor:{type:'qtree', options:{required:true}},
					formatter:function(value,row,index){
						var v = $(scGridObj).data('sampleResultCode');
						if(v){
							row['sampleResultCode'] = v;
							$(scGridObj).removeData('sampleResultCode')
						}
						return value;
					}},
				{field:'remark',title:"备注",width:'200px', align:'left', halign:'center',
					editor:{type:'textarea',options:{validType:'length[1,2000]'}}},
                {field:'attachmentId', title:'附件', width:'30%',align:'left', halign:'center',  sortable:true, show:'false',
					formatter:function(value,row,index){
						return "<div id='fileItem"+index+"'></div>";
					}
                },
                {field:'operation', title:'操作', width:'100px',align:'center',halign:'center',  sortable:true, show:'false',
                	hidden:isView,
					formatter:function(value,row,index){
						window.setTimeout(function(){
							$('#fileTigger'+index).linkbutton({    
							    iconCls: 'icon-upload',
							    text:'上传附件'
							}); 
							initFileUploadPlug(index, row['attachmentId']);
						},0)
						return "<span id='fileTigger"+index+"' style='border-width:0px;'></span>";
					}
                }
          ]]
        }
    });
	
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
        	//uploadFace:1,
            triggerId:'fileTigger'+index,
            isDel:!isView,
            isEdit:!isView
        })
    }
	
    // 结束编辑
	function endEditing(){
		if(editIndex == undefined){return true}
		if($('#'+scGridTableId).datagrid('validateRow', editIndex)){
			$('#'+scGridTableId).datagrid('endEdit', editIndex);
			editIndex = undefined;
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
    				editIndex = i;
    				rt = false;
    				break;
    			}
    			$('#'+gridId).datagrid('endEdit', i);
    		}
    	}
    	return rt;
    }
    
    //编辑and选中
    function editAndSelect(index, field){
    	try{
			$('#'+scGridTableId).datagrid('selectRow', index).datagrid('beginEdit', index);	       				
			var ed = $('#'+scGridTableId).datagrid('getEditor', {index:index,field:field});
			if(ed){
				$(ed.target).select().focus();
			}	       				
			//记录上一次的编辑的行，用于endEditing点击一个新行时，结束上次行的编辑
			editIndex = index;       		
    	}catch(e){
    		alert('editAndSelect:\n'+e.message);
    	}
    }
    
	//批量增加行
	function batchAppendSample(count, projectId, manuId, onlyAddOne){
		try{
			if(count > 0 && projectId && manuId){
				var offset = 0;
				count = parseInt(count);
				var gridData = $('#'+scGridTableId).datagrid("getData");
				if(gridData && gridData.total){
					var total = parseInt(gridData.total);
					//从表格单独增加一行
					if(onlyAddOne){
						offset = 1;
						$('#manu_sampleSize').val(total + 1);
					}else{						
						if(total > count){
							$('#manu_sampleSize').val(total);
							showMessage1("现有缺陷数目大于要添加的数目["+count+"]");
						}else{
							offset = count - total;
						}
					}
				}else{
					if(onlyAddOne){
						offset = 1;
						$('#manu_sampleSize').val(1);
					}else{						
						offset = count;
					}
				}
				if(offset){
					addRows(offset, projectId, manuId);
				}
			}else{
				showMessage1("增行时部分参数错误");
			}
		}catch(e){
			alert("batchAddSample:\n"+e.message);
		}
	}
	window.aud$batchAppendSample = batchAppendSample;
 
    function addRows(count, projectId, manuId){
    	var url = "${contextPath}/intctet/evaluationActualize/addSample.action";
		$.ajax({
			url : url,
			dataType:'json',
			type: "post",
			data:{
				'count':count ? count : 1,
				'projectId':projectId,
				'manuId':manuId
			},
			success: function(data){
				data.msg ? showMessage1(data.msg) : null;
       			if(data.type = 'info'){
       				$('#'+scGridTableId).data('isNewAdd', true);
       				scGridObj.refresh();
       			}
			},
			error:function(data){
				top.$.messager.show({title:'提示信息',msg:'请求失败！请检查网络配置或者与管理员联系！'});
			}
		});
    }
    
    //保存修改数据
    function updateRow(rows){
    	var sendData = aud$rows2Json("updateRow", rows);   
		$.ajax({
			url : "${contextPath}/intctet/evaluationActualize/saveSample.action",
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
       				scGridObj.refresh();
       			}
			},
			error:function(data){
				top.$.messager.show({title:'提示信息',msg:'请求失败！请检查网络配置或者与管理员联系！'});
			}
		});
    }
	
});



</script>

<div style="height:300px;padding:0px;margin:0px;">
	<table id="sampleTable"></table>
</div>
