<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE HTML>
<html>
<title>报表模板管理</title>
<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/createOrgTree.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/common.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/pages/tlInteractive/tlInteractiveCommon.js"></script>
<script type="text/javascript">
$(function(){
    //  模板数据源
    $('#dbconfigDg').datagrid({    
        url:'<%=request.getContextPath()%>/commonPlug/getReportConfigInfo.action', 
		rownumbers:true,
		pagination:true,
		striped:true,
		border:0,
		loadMsg:'数据源加载中，请稍后......',
		fit:true,
		//height:350,
		toolbar:[{   
	            text:'关闭',
			    iconCls:'icon-cancel',
			    handler:function(){
	                $('#viewReportDbconfig').window('close');			    	
			    }
			},'-'
		],
        columns:[[    
            {field:'name',title:'数据源名称', width:'100px',align:'left'},    
            {field:'user',title:'用户名',     width:'100px', align:'left'},    
            {field:'url' ,title:'URL',       width:'280px',align:'left',
				formatter:function(value,rowData,rowIndex){
					return "<label title=\"双击\" onDblclick=\"showInfo('',this)\">"+value+"</label>";
				}	
            },
            {field:'driver',title:'驱动',     width:'280px',align:'left',
				formatter:function(value,rowData,rowIndex){
					return "<label title=\"双击\" onDblclick=\"showInfo('',this)\">"+value+"</label>";
				}	
            },    
            {field:'serverSet',title:'服务器数据集',width:'350px',align:'left',
				formatter:function(value,rowData,rowIndex){
					return "<label title=\"双击\" onDblclick=\"showInfo('',this)\">"+value+"</label>";
				}	
            }
        ]]    
    });
         
	// 报表模板-显示表格
	var rpTemplateDg = new createQDatagrid({
		// 查询form窗口的高度和宽度，插件会根据宽度自动确定一行放几列查询条件; 可选， 默认为：600,390，放两组查询条件
		winWidth:900,
	    winHeight:500,
		// 表格dom对象，必填
	    gridObject:$('#templateTable')[0],
		// 要进行检索的表对象(hibernate bean)名称， 进行拼接hql时使用; 必填
		boName:'ReportTemplateInfo',
	   	queryColumn:[
			{field:'templateName',       title:'模板名称',     oper:'like'},
			{field:'templateFileName',   title:'模板文件名称',  oper:'like'},
			{field:'uploadUserCode',     title:'上传人',    type:'custom', target:$('#myTargetTest2')[0]}
	   	],
	 	// 表格控件dataGrid配置对象; 必填
	    gridJson:{
	    	queryParams:{ 'sort':'uploadTime'},
			onClickCell:function(rowIndex, field, value){
				if(field == 'url'){			
					var rows = $('#templateTable').datagrid('getRows');
					viewRp(rows[rowIndex]);
					$('#templateTable').datagrid('unSlectRow',rowIndex);
				}
			},	
			onRowContextMenu:function(){
			},
			// 自定义按钮，初始化时会和插件自带的按钮合并在一起
			toolbar:[{   
	                text:'数据源查看',
				    iconCls:'icon-edit2',
				    handler:function(){
                        $('#viewReportDbconfig').dialog('open');			    	
				    }
				},'-',{
	                text:'报表预览',
				    iconCls:'icon-view',
				    handler:function(){
				    	viewRp();
				    }
				},'-',{
	                text:'报表发布',
				    iconCls:'icon-go',
				    handler:function(){
				    	togglePublish('1','templateTable','<%=request.getContextPath()%>/commonPlug/togglePublish.action');
				    }
				},'-',{   
	                text:'取消发布',
				    iconCls:'icon-undo',
				    handler:function(){
				    	togglePublish('0','templateTable','<%=request.getContextPath()%>/commonPlug/togglePublish.action');
				    }
				},'-',{   
	                text:'模板同步',
				    iconCls:'icon-config',
				    handler:function(){synchronizeTemplate(true);}
				},'-',{   
	                text:'上传报表模板',
				    iconCls:'icon-folderGo',
				    handler:function(){
				    	$('#uploadFrTemplate').dialog('open');
				    	clearUpload();
				    	$('#rp_uploadType').val('0').removeAttr('checked');
			   			$('#rp_template_desc').show();
			   			$('#rp_template').show();
			   			$('#rp_dbconfig').hide();  
				    }
				},'-',{   
	                text:'上传数据源文件',
				    iconCls:'icon-folderGo',
				    handler:function(){
				    	$('#uploadFrTemplate').dialog('open');
				    	clearUpload();
				       	$('#rp_uploadType').val('1').attr('checked',true);
		       			$('#rp_template_desc').hide();
		       			$('#rp_template').hide();
		       			$('#rp_dbconfig').show();
				    }
				},'-',{   
	                text:'编辑',
				    iconCls:'icon-edit',
				    handler:function(){
				    	$('#updateFrTemplate').dialog('open');
				    }
				},'-'
			],
			//title:'模板列表',
			columns:[[ 
				{field:'id'  ,            title:'选择',       width:'50', checkbox:true, align:'center', show:'false'},      
				{field:'templateName',    title:'模板名称',    width:'200',align:'left', sortable:true},
				{field:'templateFileName',title:'模板文件名称', width:'200',align:'left', sortable:true},
				{field:'url',             title:'访问路径',    width:'450',align:'left',
					formatter:function(value,rowData,rowIndex){
						return "<a href='javascript:void(0);' style='cursor:hand;color:blue;border-bottom:1px solid blue;'>"+value+"</a>";
					}
				},
				{field:'status',          title:'状态',        width:'100',align:'center', hidden:true},
				{field:'statusName',      title:'状态',        width:'100',align:'center',
					formatter:function(value,rowData,rowIndex){
						return rowData['status']=='0' ? "<font color='red'>"+value+"</font>":value;
					}
				},
				/* {field:'uploadUserName',  title:'上传人名称',   width:'150',align:'center', sortable:true},
				{field:'uploadUserCode',  title:'上传人账号',   width:'150',align:'center', sortable:true}, */
                {field:'uploadTime',      title:'上传时间',     width:'150',align:'center', sortable:true}
			]]
		}
	});
	//设置按钮状态
    rpTemplateDg.batchSetBtn([{'index':18, 'display':false},{'index':11, 'display':false}] );

   	$('#viewReportDbconfig').dialog({
        closed  :true,
        closable:true,
        modal:true,
        draggable:true,
        resizable:true,
        shadow:true,
        fit:true,
        onOpen:function(){
        	 audEvd$resizeWin('viewReportDbconfig');
        }
   	});
    
    
   	$('#uploadFrTemplate').dialog({
        closed  :true,
        closable:true,
        modal:true,
        draggable:true,
        resizable:true,
        shadow:true,
        fit:true,
        onOpen:function(){
        	clearUpload();
        	audEvd$resizeWin('uploadFrTemplate');
        },
        buttons:[{
       	 	text:"上传文件",
	        iconCls:'icon-folderGo',
	        handler:uploadRpFile
	    },{
		   text:"清空",
	       iconCls:'icon-reload',
	       handler:clearUpload
	    },{
		   text:"关闭",
	       iconCls:'icon-cancel',
	       handler:function(){
	    	   $('#uploadFrTemplate').dialog('close');
	       }
	    }]
	});
    
   $('#updateFrTemplate').dialog({
        closed  :true,
        closable:true,
        modal:true,
        draggable:true,
        resizable:true,
        shadow:true,
        fit:true,
        onOpen:function(){
        	audEvd$resizeWin('updateFrTemplate');
        },
        onBeforeOpen:function(){
            var rows = $('#templateTable').datagrid('getChecked');
            if(rows == null || rows.length == 0){
            	showMessage1("请选择一条记录进行编辑");
                return false;
            }
            if(rows.length > 1){
            	showMessage1("编辑时只能选择一条记录");
                return false;
            }else{
                var row = rows[0];
                $('#updateFrTemplateForm').find('#u_templateName').val('').val(row['templateName']);
                $('#updateFrTemplateForm').find('#u_url').val('').val(row['url']);
                $('#updateFrTemplateForm').find('#u_id').val('').val(row['id']);
                var sval = '0';
                var arr = row['url'].split('&');
                var last = arr[arr.length-1];
                if(last == 'op=view'){
                    sval = '1';
                }else if(last == 'op=write'){
                    sval = '2';
                }else if(last == '__bypagesize__=false'){
                    sval ='3';
                }
                $('#templateShowSelect').val(sval);
            }
            return true;
        },
        buttons:[{
		   text:"保存",
	       iconCls:'icon-save',
	       handler:function(){
              $.post('<%=request.getContextPath()%>/commonPlug/updateRpTemplate.action',$('#updateFrTemplateForm').serialize(), function(data){
                    if(data.msg){
                    	showMessage1(data.msg);
                    }		
                    if(data.type == 'info'){
                        loadGrid("templateTable");
                    }
                });
           
           }
	    },{
		   text:"关闭",
	       iconCls:'icon-cancel',
	       handler:function(){
	    	   $('#updateFrTemplate').dialog('close');
	       }
	    }]
	});   

   	
   	$('#rp_uploadType').bind('click',function(){
   		clearUpload();
   		if($(this).attr('checked')){
   			$(this).val('1');
   			$('#rp_template_desc').hide();
   			$('#rp_template').hide();
   			$('#rp_dbconfig').show();
   		}else{
   			$(this).val('0');
   			$('#rp_template_desc').show();
   			$('#rp_template').show();
   			$('#rp_dbconfig').hide();  			
   		}  		
   	});

    // 报表预览
    function viewRp(row){
        var rows = (row ? [row] : null)||$('#templateTable').datagrid("getChecked");
        if(rows == null || rows.length == 0){
        	showMessage1('请选择预览记录');
            return;
        }						
        if(rows && rows.length > 1){
        	showMessage1('预览时只能选择一条记录！');
        }else{
            var row = rows[0];	
            $.post('<%=request.getContextPath()%>/commonPlug/isHaveTemplate.action','templateFileName='+row['templateFileName'], function(data){
                if(data.type == 'error'){
                	showMessage1(data.msg);
                }else{
                    var url = row['url'];
                    window.open(url);
                }							
            });
        }				    	
    }

    // 上传模板  数据库配置文件
    function uploadRpFile(){
        $('#importToDb').form('submit',{
            url:'<%=request.getContextPath()%>/commonPlug/uploadReportTemplate.action',
            onSubmit:function(){
                var uploadType = $('#rp_uploadType').attr('checked');          
                if(!$('#templateName').val() && !uploadType){
                	showMessage1('模板名称不能为空！','警告','error',function(){
                       $('#templateName').focus();
                   });
                    return false;
                }     	  	
                var path = uploadType ? $('#fileUploadReportDbconfig').val() : $('#fileUploadReportTemplate').val();
                var arr = path.split('.');
                var suffix = arr[arr.length - 1];
                var f2 = path.split('\\');
                var fileName = f2[f2.length-1];
                //alert(fileName+',datasource.xml'+','+uploadType);
                if(suffix != 'cpt' && !uploadType){
                    clearUpload();
                    showMessage1('导入文件后缀名错误，请导入 cpt文件！');
                    return false;
                }else if(fileName != 'datasource.xml' && uploadType){
                    clearUpload();
                    showMessage1('请导入[datasource.xml]文件！');
                    return false;
                }
                return true;
            },
            success:function(data){
                if(data){
                    var json = (new Function("return " + data))();
                    json.type != 'error' ? loadGrid('templateTable'): '';
                    showMessage1( json.msg);
                    // 如果为上传数据源文件，则重新加载数据源表格
                    var type = $('#rp_uploadType').val();
                    if(type == '1'){
                        $.ajax({
                            url:'<%=request.getContextPath()%>/commonPlug/getReportConfigInfo.action',
                            type:'post',
                            success:function(data){
                                $('#dbconfigDg').datagrid('loadData',data);                              
                            },
                            error:function(){
                            	showMessage1('请求失败，请检查网络设置或者与管理员联系！');
                            }
                        });	
                    }
                }
            }
        });
    }

    // 同步模板
    function synchronizeTemplate(flag){
        $.post('<%=request.getContextPath()%>/commonPlug/synchronizeTemplate.action', function(data){
            if(data.msg && flag){
            	showMessage1(data.msg);
            }
            if(data.type == 'info'){	
               $('#templateTable').datagrid('loadData',{'total':0,'rows':[]});
               loadGrid('templateTable');
            }															
        });
    }

    // 发布或者取消发布
    function togglePublish(flag,tableId,url){
        var ids = getCheckedRows(tableId);
        if(ids != ''){
            $.post(url,{'ids':ids,'status':flag},function(data){
                if(data.msg){
                    showMessage1(data.msg);
                }
                if(data.type == 'info'){
                    loadGrid(tableId);
                }		
            });
        }
    }
    
    // 获得选中记录的id
    function getCheckedRows(id){
        var ids = [];
        var rows = $('#'+id).datagrid("getChecked");
        if(rows == null || rows.length == 0){
            //showMessage1('警告','请选择记录','error');
            showMessage1("请选择记录");
            return false;
            /* return null; */
            /* $.messager.show({
        		title:'提示信息',
        		msg:'请选择记录',
        		timeout:2000,
        		showType:'slide'
        	}); */
        }						
        if(rows && rows.length > 0){
            for(var i=0; i<rows.length; i++){
                var row = rows[i];
                ids.push(row['id']);
            }
        }
        return "'"+ids.join("','")+"'";
    }
    
    // 清空模板form
    function clearUpload(){
         $('#templateName').val('');
         document.all.fileUploadReportTemplate.outerHTML = document.all.fileUploadReportTemplate.outerHTML;
         document.all.fileUploadReportDbconfig.outerHTML = document.all.fileUploadReportDbconfig.outerHTML;   
         $('#uploadfilepath').html("");
    }

    // 模板参数列表
	var rpParamDg = new createQDatagrid({
		// 查询form窗口的高度和宽度，插件会根据宽度自动确定一行放几列查询条件; 可选， 默认为：600,390，放两组查询条件
		winWidth:900,
	    winHeight:500,
		// 表格dom对象，必填
	    gridObject:$('#templateParamTable')[0],
		// 要进行检索的表对象(hibernate bean)名称， 进行拼接hql时使用; 必填
		boName:'ReportParameter',
		
	   	queryColumn:[
            {field:'pname',      title:'参数名称',     oper:'like'},
            {field:'pcode',      title:'参数代码',  oper:'like'},
            {field:'status',     title:'状态',    type:'custom', target:$('#myTargetTest2')[0]},
            {field:'createUserCode',     title:'添加人',    type:'custom', target:$('#myTargetTest3')[0]}
        ],
	 	// 表格控件dataGrid配置对象; 必填
	    gridJson:{
	    	queryParams:{'sort':'createTime','order':'desc'},		
	    	onLoadSuccess:function(data){},
			// 自定义按钮，初始化时会和插件自带的按钮合并在一起
			toolbar:[{   
	                text:'参数发布',
				    iconCls:'icon-go',
				    handler:function(){
				    	togglePublish('1','templateParamTable','<%=request.getContextPath()%>/commonPlug/templateParamTogglePublish.action');
				    }
				},'-',{   
	                text:'取消发布',
				    iconCls:'icon-undo',
				    handler:function(){
				    	togglePublish('0','templateParamTable','<%=request.getContextPath()%>/commonPlug/templateParamTogglePublish.action');
				    }
				},'-',{   
	                text:'添加',
				    iconCls:'icon-add',
				    handler:function(){
				    	clearTemplateParameterWin();
				    	$('#templateParamterWin').dialog('open');
				    }
				},'-',{   
	                text:'编辑',
				    iconCls:'icon-edit',
				    handler:function(){
                        var rows = $('#templateParamTable').datagrid("getChecked");
                        if(rows != null && rows.length > 0 ){
                            if(rows.length > 1){
                            	showMessage1('一次只能选择一条记录');
                                return;
                            }else{
                                try{
                                	clearTemplateParameterWin();
                                    var row = rows[0];
                                    if(row){
                                    	assignForm(row, 'templateParamterForm', 'rptemplatep_');
                                        $('#templateParamterWin').dialog('open');
                                    }
                                }catch(e){
                                    alert(e.message);
                                }
                            }
                        }else{
                        	showMessage1('请选择要编辑的记录');
                            return;
                        }
				    }
				},'-'
			],
			//title:'模板参数列表',
			columns:[[ 
				{field:'id'  ,   title:'选择',    width:'50', checkbox:true, align:'center', show:false},      
				{field:'pname',  title:'参数名称', width:'150',align:'left', sortable:true},
				{field:'pcode',  title:'参数代码', width:'150',align:'left', sortable:true},
				{field:'pvaluetype', title:'参数值类型',   width:'100',align:'center', sortable:true,
					formatter:function(value,rowData,rowIndex){
						return value =='0' ? "数值型":(value =='1' ? "SQL型" : "未知类型");
					}},
				{field:'pvalue', title:'参数值',   width:'100',align:'left', sortable:true,
					formatter:function(value,rowData,rowIndex){
						return "<label title=\"双击："+value+"\" onDblclick=\"showInfo('',this)\">"+value+"</label>";
					}				
				},
				{field:'presult', title:'结果值',   width:'150',align:'left', sortable:true,
					formatter:function(value,rowData,rowIndex){
						return "<label title=\"双击："+value+"\" onDblclick=\"showInfo('',this)\">"+value+"</label>";
					}
				},
				{field:'pdesc',  title:'参数描述', width:'150',align:'left',
					formatter:function(value,rowData,rowIndex){
						return "<label title=\"双击："+value+"\" onDblclick=\"showInfo('',this)\">"+value+"</label>";
					}					
				},
				{field:'status', title:'状态',    width:'100', align:'center', hidden:true},
				{field:'statusName', title:'状态', width:'100',align:'center', sortable:true,
					formatter:function(value,rowData,rowIndex){
						return rowData['status']=='0' ? "<font color='red'>"+value+"</font>":value;
					}
				},
				{field:'createUserName',  title:'创建人名称',   width:'100',align:'center', sortable:true},
				{field:'createUserCode',  title:'创建人账号',   width:'100',align:'center', sortable:true},
                {field:'createTime',      title:'创建时间',     width:'100',align:'center', sortable:true},
				{field:'modifyUserName',  title:'修改人名称',   width:'100',align:'center', sortable:true},
				{field:'modifyUserCode',  title:'修改人账号',   width:'100',align:'center', sortable:true},
                {field:'modifyTime',      title:'修改时间',     width:'100',align:'center', sortable:true}
			]]
		}
	});
    
	rpParamDg.batchSetBtn([{'index':17, 'display':false},{'index':8, 'display':false}] );
    
    //  参数模板窗口
   	$('#templateParamterWin').dialog({
        closed  :true,
        closable:true,
        modal:true,
        draggable:true,
        resizable:true,
        shadow:true,
        fit:true,
        onOpen:function(){
        	 //alert($('#templateParamterForm').serialize())
        	 //alert($('input[name=rptemplatep.pvaluetype]:checked').val());
       	 	audEvd$resizeWin('templateParamterWin');
        }, 
        buttons:[{
       	 	text:"保存",
	        iconCls:'icon-save',
	        handler:function(){  	
	        	$.ajax({
	        		url :'<%=request.getContextPath()%>/commonPlug/saveRpTemplateParamter.action',
	        		data:$('#templateParamterForm').serialize(),
	        		type:"POST",
	        		beforeSend:function(){
	        			var idArr = ['rptemplatep_pname','rptemplatep_pcode','rptemplatep_pvalue','rptemplatep_pdesc'];
	        			for(var i=0; i<idArr.length; i++){
	        				var id = idArr[i];
	        				var obj = $('#'+id);
	        				if(obj.length>0){
	        					if(obj.val() == ""){
	        						obj.focus();
	        						showMessage1(obj.attr('title')+'不能为空!');
	        						return false;
	        					}
	        				}
	        			}
                        // 判断sql是否有效
                        if(!isValidSql(false) && $("input:radio[name=rptemplatep.pvaluetype]:checked").val() == '1'){
                        	showMessage1('参数值为非法sql或者为sql无返回值');
    						return false;
                        }
	        			return true;
	        		},
	        		success: function(data){
	        			if(data.msg){
	        				top.$.messager.alert('提示信息', data.msg, data.type, function(){
	        					if(data.type != 'info') return;
                                loadGrid('templateParamTable');
	        				});
	        			}
	        		},
	        		error:function(){
	        			showMessage1('请求失败，请检查网络设置或者与管理员联系！');
	        		}
	        	});
	        }
	    },{
		   text:"清空",
	       iconCls:'icon-reload',
	       handler:clearTemplateParameterWin
	    },{
		   text:"帮助",
		   iconCls:'icon-help',
		   handler:function(){
			   $('#rptpHelpWin').dialog('open');
		   }
		},{
		   text:"关闭",
	       iconCls:'icon-cancel',
	       handler:function(){
	    	   $('#templateParamterWin').dialog('close');
	       }
	    }]
	});

    // 加载数据表格
    function loadGrid(tableId){
    	var json = {
    			'sort':'uploadTime',
    			'order':'desc'	
    	};
    	if(tableId == 'templateParamTable'){
    		json = {
    			'sort':'createTime',
    			'order':'desc'	
    		};
    	}
        QUtil.loadGrid({
        	param:json,
            type:'post',
            // 表格对象
            gridObject:$('#'+tableId)[0]
        });
    }
    
    // 清空报表参数form
    function clearTemplateParameterWin(){
    	$('#templateParamterForm').find('input:text').val('');
        $('#templateParamterForm').find('#rptemplatep_id').val('');
    	$('#templateParamterForm').find('textarea').val('');
    	$('input:radio[value=0]').attr('checked','checked');
    	$('#sqlTestDiv').hide();
    }
    
    // 根据数据表格的row初始化表单form
    function assignForm(row, formId, idPrefix){
    	if(row){
	    	idPrefix = idPrefix ? idPrefix : '';
	        for(var p in row){
	            var jid = idPrefix+p;
	            var obj = $('#'+formId).find('#'+jid);
	            var value = row[p];
	            if(obj.length){
	            	obj.val(value);        	
	            }else if(p == 'pvaluetype'){
            		$('input:radio[value='+value+']').attr('checked','checked');
            		var showOrHide =  value=='0' ? false : true;
            		$('#sqlTestDiv').toggle(showOrHide);
            	}
	        }
    	}
    }
    
    // 测试sql是否能执行
    $('#sqlTestBtn').bind('click',function(){
        isValidSql(true);
    });
    function isValidSql(flag){
    	var rt = false;
        var sqlstr = $('#rptemplatep_pvalue').val();
    	if(sqlstr){
    		$.ajax({
    			url :'<%=request.getContextPath()%>/commonPlug/executeSql.action',
    			data:{'testsql':sqlstr},
    			type:'post',
                cache:false,
                async:false,
    			success:function(data){
    				if(data.msg && flag){
    					//$.messager.alert('提示信息',data.msg, data.type);
        				showInfo(data.msg);
    				}
                    rt = data.type == 'error' ? false : true;
    			},
    			error:function(){
    				showMessage1('请求失败，请检查网络设置或者与管理员联系！');
    			}
    		});
    	}else{
    		showMessage1('参数值为空','提示信息','error',function(){
    			$('#rptemplatep_pvalue').focus();
    		});
    	}
    	return rt;
    };
    

    $('#rpInfoWinCloseBtn').bind('click',function(){
    	$('#rpInfoWin').window('close');
    });
    
    $('#rptpHelpWin').dialog({
        closed  :true,
        closable:true,
        modal:true,
        draggable:true,
        resizable:true,
        shadow:true,
        fit:true,
        onOpen:function(){
        	 audEvd$resizeWin('rptpHelpWin');
        }, 
        buttons:[{
		   text:"关闭",
	       iconCls:'icon-cancel',
	       handler:function(){
	    	   $('#rptpHelpWin').dialog('close');
	       }
	    }]
    });

});
function showInfo(content, obj){
	content = content  ? content : obj.innerHTML;
	$('#rpInfoWincontent').html(content);
	$('#rpInfoWin').window('open');
}
function setUplodFileInfo(value, flag){
    var path = "文件路径："+value;
    $('#uploadfilepath').html(path);
    if(flag == '0'){
        // var arr = path.split('.');
        //var suffix = arr[arr.length - 1];
        var f2 = path.split('\\');
        var fileName = f2[f2.length-1];
        $('#templateName').val(fileName.split('.cpt')[0]);
        var url = cjkEncode("<%=request.getContextPath()%>/ReportServer?reportlet=aisreport/"+fileName+"&__bypagesize__=false");
        $('#templateViewUrl').val(url);
    }
};
// 报表预览方式
function changeTemplateUrl(value){
    var obj = $('#u_url');
    //alert(value+' '+obj.val())
    var arr = obj.val().split('&');
    var baseUrl = arr[0];
    if(value == '0'){
        obj.val(baseUrl);
    }else if(value == '1'){
        obj.val(baseUrl+'&op=view');
    }else if(value == '2'){
        obj.val(baseUrl+'&op=write');
    }else if(value == '3'){
        obj.val(baseUrl+'&__bypagesize__=false');
    }
}
// 报表参数编码
function cjkEncode(text) {                                                                             
   if (text == null) {          
     return "";          
   }          
   var newText = [];          
   for(var i = 0; i < text.length; i++) {          
      var code = text.charCodeAt (i);   
      if(code >= 128 || code == 91 || code == 93) {          
        newText.push("[");
        newText.push(code.toString(16));
        newText.push("]");
      }else{          
        newText.push(text.charAt(i));          
      }          
   }          
   return newText.join('');          
}  
</script>

</head>
<body style='margin:0px;padding:0px;overflow:hidden;'>
	<div id='rp_Tabs' class="easyui-tabs" fit="true" border='0'>   
		<div title='报表模板'  border='0'>
			<table id='templateTable'></table>
		</div>
		<div title='模板参数'  border='0'>
			<table id='templateParamTable'></table>
		</div> 
	</div>   
	
	<div style='display:none'>
	
	<!-- 报表模板上传界面 -->
    <div id='uploadFrTemplate' style='overflow:hidden;' title="报表文件上传">   		
      		<form id='importToDb' name='importToDb' method="POST"  enctype="multipart/form-data"> 
      			<table class="ListTable" align="center">  
		      		<tr style='text-align:left;padding:2px;height:25px;'>
		      			<td class="EditHead">
		      				<label style='width:130px;text-align:right;'>上传类型&nbsp;&nbsp;</label>
		      			</td>
		      			<td class="editTd">
		      				<input type='checkbox'   id='rp_uploadType'  name='rpuploadType'  value='0' />(默认为上传报表模板，选中则为上传数据源文件)
		      			</td>
		      		</tr>
		      		<tr id='rp_template' style='text-align:left;padding:2px;height:20px;'>	
		      			<td class="EditHead">
		      				<label style='width:140px;text-align:right;'><font color=red>*</font>模板文件(*.cpt)</label>
		      			</td>
		      			<td class="editTd">
			      			<input type='file' size=57  id='fileUploadReportTemplate' name='fileUploadReportTemplate' 
			      			onchange='setUplodFileInfo(this.value,0)' class="noborder" style='width:98%'/>
			      			<input type='hidden' id='templateViewUrl'	name='templateViewUrl' value='' size=57/>
		      			</td>
	      			</tr> 
		      		<tr id='rp_template_desc' style='text-align:left;padding-top:2px;height:20px;'><br>	
		      			<td class="EditHead">
		      				<label style='width:140px;text-align:left;'><font color=red>*</font>模板名称</label>
		      			</td>
		      			<td class="editTd">
		      			<div style='text-align:left;padding-top:0;padding-left:2px'>
		      				<input type='text' size=57   id='templateName'  name='templateName' class="noborder" style='width:98%'/>	
		      			</div>
		      			</td>	
	      			</tr>  
		      		<tr id='rp_dbconfig' style='text-align:left;padding:2px;height:20px;display:none;'>	
		      			<td class="EditHead">
			      			<label style='width:140px;text-align:right;'>数据源(.xml)<font color=red>*</font>&nbsp;&nbsp;</label>
			      		</td>
			      		<td class="editTd">
			      			<input type='file' size=57  id='fileUploadReportDbconfig' name='fileUploadReportDbconfig' 
			      			onchange='setUplodFileInfo(this.value, 1)' class="noborder" style='width:98%'/>		
	         			</td>
	         		</tr> 	 
				</table>
	    	</form>
    </div> 
 
 	<!-- 报表模板上传界面 -->
    <div id='updateFrTemplate' style='overflow:hidden;' title="报表模板修改">  		
      		<form id='updateFrTemplateForm' name='updateFrTemplateForm' method="POST" > 
      			<table class="ListTable" align="center">    				
		      		<tr id='rp_template_desc' style='text-align:left;padding:2px;height:20px;'>	
		      			<td class="EditHead">
		      				<label style='width:140px;text-align:right;'>模板名称<font color=red>*</font>&nbsp;&nbsp;</label>
		      			</td>
		      			<td class="editTd">
			      			<input type='text'  id='u_templateName'  name='u_templateName'  class="noborder" style='width:98%'/>		
		                    <input type='hidden' id='u_id' name='u_id'/>
		                </td>
	      			</tr>  
		      		<tr id='rp_template' style='text-align:left;padding:2px;height:20px;'>
		      			<td class="EditHead">	
			      			<label style='width:140px;text-align:right;'>访问路径<font color=red>*</font>&nbsp;&nbsp;</label>
			      		</td>
			      		<td class="editTd">
			      			<input type='text' size=57  id='u_url' name='u_url' class="noborder" style='width:98%'/>		
			      		</td>
	      			</tr>
	      			<tr>
	      				<td class="EditHead">
	      					<label style='width:140px;text-align:right;'>预览方式<font color=red>*</font>&nbsp;&nbsp;</label>
	      				</td>
	      				<td class="editTd">
		      				<select id='templateShowSelect' onchange='changeTemplateUrl(this.value)' style='border:1px solid #cccccc;height:20px;padding:2 2 1 2;'>
		      					<option value='0'>分页预览</option>
		      					<option value='1'>分析预览(不分页)</option>
		      					<option value='2'>填报预览(不分页)</option>
		      					<option value='3'>强制不分页</option>
		      				</select>
	      				</td>
	      			</tr> 	
      			</table>		
	    	</form>    
    </div>
 
 	<!-- 报表数据源预览 -->
    <div id='viewReportDbconfig' style='overflow:hidden;' title="报表数据源和服务器数据集">
		<table id='dbconfigDg'></table>    	
   </div>   
     
    <!-- 模板参数添加修改窗口 -->
    <div id='templateParamterWin' style='overflow:hidden;' title="模板参数">    		
      		<form id='templateParamterForm' name='templateParamterForm' method="POST" style='margin:0px;padding:0px;'> 
				<table class="ListTable"  align="center">
					<tr>
						<td class='EditHead' nowrap style='width:15%;'>参数名称<font color=red>*</font></td>	
		        		<td class='editTd'>
		        			<input type='text'   id='rptemplatep_pname' name='rptemplatep.pname'  title='参数名称' class="noborder" style='width:98%' value='${rptemplatep.pname}'>
		        			<input type='hidden' id='rptemplatep_id'    name='rptemplatep.id' value='${rptemplatep.id}'/>
		        			<input type='hidden' id='rptemplatep_status' name='rptemplatep.status' value='${rptemplatep.status}'/>
		        			<input type='hidden' id='rptemplatep_statusName' name='rptemplatep.statusName' value='${rptemplatep.statusName}'/>
		        			<input type='hidden' id='rptemplatep_createUserName' name='rptemplatep.createUserName' value='${rptemplatep.createUserName}'/>
		        			<input type='hidden' id='rptemplatep_createUserCode' name='rptemplatep.createUserCode' value='${rptemplatep.createUserCode}'/>
		        			<input type='hidden' id='rptemplatep_createTime'     name='rptemplatep.createTime'     value='${rptemplatep.createTime}'/>
		        			<input type='hidden' id='rptemplatep_modifyUserName' name='rptemplatep.modifyUserName' value='${rptemplatep.modifyUserName}'/>
		        			<input type='hidden' id='rptemplatep_modifyUserCode' name='rptemplatep.modifyUserCode' value='${rptemplatep.modifyUserCode}'/>
		        			<input type='hidden' id='rptemplatep_modifyTime'     name='rptemplatep.modifyTime'     value='${rptemplatep.modifyTime}'/>
		        		</td>
						<td class='EditHead' nowrap style='width:15%;'>参数代码<font color=red>*</font></td>	
		        		<td class='editTd'>
		        			<input type='text' id='rptemplatep_pcode' title='参数代码' name='rptemplatep.pcode' 
		        			class="noborder" style='width:98%' value='${rptemplatep.pcode}'>
		        		</td>	        		
					</tr>
					<tr>
						<td class='EditHead' nowrap>
							<div style='text-align:right'>参数类型<font color=red>*</font></div>
						</td>	
		        		<td class='editTd' colspan='3'>
		        			<span>
		        				数值型：<input type='radio'  name='rptemplatep.pvaluetype' value="0" checked onclick="$('#sqlTestDiv').hide();"/>&nbsp;&nbsp;&nbsp;&nbsp;
		        				SQL型：<input type='radio'  name='rptemplatep.pvaluetype' value="1"  onclick="$('#sqlTestDiv').show();"/>
		        			</span>
		        		</td>
		        	</tr>
					<tr>
						<td class='EditHead' nowrap>
							<div style='text-align:right'>参数值<font color=red>*</font></div>
							<div id='sqlTestDiv' style='display:none;'>
		        				<a href='javascript:void(0);' id='sqlTestBtn' class="easyui-linkbutton"  iconCls="icon-tip">SQL测试</a>
		        			</div>
						</td>	
		        		<td class='editTd' colspan='3'>
		        			<span>
			        			<textarea id='rptemplatep_pvalue' title='参数值' 
			        				name='rptemplatep.pvalue' class="noborder" 
			        				style='width:98%;height:120px;'>${rptemplatep.pvalue}</textarea>
		        			</span>
		        		</td>
		        	</tr>
		        	<tr>
						<td class='EditHead' nowrap>参数描述<font color=red>*</font></td>	
		        		<td class='editTd' colspan='3'>
		        			<textarea id='rptemplatep_pdesc' title='参数描述' 
		        				name='rptemplatep.pdesc' class="noborder" 
		        				style='width:98%;height:120px;'>${rptemplatep.pdesc}</textarea>
		        		</td>	        		
					</tr>
				</table>		
	    	</form>  
    </div> 
    
    <!-- 参数form帮助info -->
	<div id="rptpHelpWin"  title=" 模板参数说明"  style="padding:0px;overflow:hidden;"   
	        data-options="iconCls:'icon-help',modal:true,collapsible:false,minimizable:false,maximizable:false,closed:true">   
	   	<div style='height:430px;margin:0px;padding:5px;line-height:21px;overflow-y:auto;'>
	   		<ul style='padding-left:5px;'>
		   		<li><div style='font-size:15px;font-weight:bold;display:inline;'>1.内置参数</div>
		   			<div>用户登陆后默认已经内置了如下参数，可以直接使用：</div>
		   			<div><label class='helptxt1'>'deptid'</label> - 当前用户所在机构ID[${deptid}]</div>
		   			<div><label class='helptxt1'>'deptname'</label> - 当前用户所在机构名称[${deptname}]</div>
		   			<div><label class='helptxt1'>'userid'</label> - 当前用户ID[${userid}]</div>
		   			<div><label class='helptxt1'>'usercode'</label> - 当前用户编码[${usercode}]</div>
		   			<div><label class='helptxt1'>'username'</label> - 当前用户名称[${username}]</div>
		   			<div><label class='helptxt1'>'loginname'</label> - 当前用户登陆名[${loginname}]</div>
		   			<div><label class='helptxt1'>'rp_curDate'</label> - 当前日期[${rp_curDate}]</div>
		   			<div><label class='helptxt1'>'rp_curYear'</label> - 当前年份[${rp_curYear}]</div>
		   			<div><label class='helptxt1'>'rp_curMonth'</label> - 当前月份[${rp_curMonth}]</div>
		   			<div><label class='helptxt1'>'rp_curDay'</label> - 当前日[${rp_curDay}]</div>
		   			<div><label class='helptxt1'>'rp_curDay'</label> - 当前日[${rp_curDay}]</div>
		   			<div><label class='helptxt1'>'rp_halfyearName'</label> - 半年名称[${rp_halfyearName}]</div>
		   			<div><label class='helptxt1'>'rp_halfyear'</label> - 半年值[${rp_halfyear}]</div>
		   			<div><label class='helptxt1'>'rp_quarterName'</label> - 当前季度[${rp_quarterName}]</div>
		   			<div><label class='helptxt1'>'rp_quarter'</label> - 当前季度值[${rp_quarter}]</div>
		   		</li>
		   		<li></br><div style='font-size:15px;font-weight:bold;display:inline;'>2.自定义参数</div>
		   			<div>可以使用内置的参数或者已经发布的自定义参数进行参数的添加，参数分为【数值值】和【SQL型】，第二种提供测试功能，如果语法错误或者无法执行
		   			或者没有查询结果，不能保存;</div>
		   			eg：查询当前登陆用户有哪些角色</br>
		   			<div>select a.frolename from auth_user_role a where a.floginname='<font color=red>:loginname</font>'</div>
		   			<div>其中:loginname 为内置参数，如果为字符型则用单引号，如上例。</div>
		   		</li>
		   		<li></br><div style='font-size:15px;font-weight:bold;display:inline;'>3.关于结果集</div>
		   			<div>对于SQL类型的参数，参数值为"select * from tableName "这种形式，那么结果集如果只返回一行数据，则取第一列的数据值；</br>
		   			如果返回多行数据，则取每行的第一列数据，用单引号括起来，逗号隔开，如：'name1','name2','name3';</br>
		   			如果参数值为"select col1, col2 from tableName"这种形式，同理也是区每行的第一列数据，多行数据用单引号引用逗号隔开
		   			</div>
		   		</li>
		   	</ul>
	   	</div>
	</div> 
	
	<!-- 信息显示 -->
	<div id="rpInfoWin" class="easyui-window" title="信息显示"  style="width:500px;height:300px;padding:10px;overflow:hidden;"   
	        data-options="iconCls:'icon-help',modal:true,collapsible:false,minimizable:false,maximizable:false,closed:true">   
	   	<div id='rpInfoWincontent' style='word-break:break-all;width:450px;height:220px;margin:0px;padding:5px;border:1px solid #cccccc;line-height:21px;overflow:auto;'>

	   	</div>
	   	<div style='padding:5px;text-align:right;display:none;'>
	   		<a href='javascript:void(0);' id='rpInfoWinCloseBtn' class="easyui-linkbutton" data-options="iconCls:'icon-cancel'">关闭</a>
	   	</div>
	</div> 
	
	<!-- 人员选择 -->
    <div id='myTargetTest2'>
		<input type="text"   name="query_like_uploadUserName"  />
	    <input type="hidden"  /><img  style="cursor:hand;border:0"
	        src="/ais/resources/images/s_search.gif" 
	    	onclick="showSysTree(this,{url:'/ais/systemnew/orgListByAsyn.action?org=local',
                                 title:'人员选择',
                                 type:'treeAndUser',
                                 defaultDeptId:'${user.fdepid}',
                                 defaultUserId:'${user.floginname}'
							})"></img>
			
    </div>
    <div id='myTargetTest3'>
		<input type="text"   name="query_like_createUserName"  />
	    <input type="hidden"  /><img  style="cursor:hand;border:0"
	        src="/ais/resources/images/s_search.gif" 
	    	onclick="showSysTree(this,{url:'/ais/systemnew/orgListByAsyn.action?org=local',
                                 title:'人员选择',
                                 type:'treeAndUser',
                                 defaultDeptId:'${user.fdepid}',
                                 defaultUserId:'${user.floginname}'
							})"></img>
			
    </div>
    <div id='myTargetTest2'>
         <select name='query_in_status'>
         	<option value="">全部</option>
             <option value='0'>未发布</option>
             <option value='1'>已发布</option>
         </select>
     </div>
    </div>
</body>
</html>