<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML >
<html>
<title>送审资料清单设置</title>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/createOrgTree.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>  
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/common.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jquery-fileUpload.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/autosize.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/pages/tlInteractive/tlInteractiveCommon.js"></script>
<script type="text/javascript">
$(function(){
	var isView = "${view}" == "true" || "${view}" == true ? true : false;
	var curDate = "${curDate}";	
	// 显示送审资料清单表单
    var g1 = new createQDatagrid({
        // 表格dom对象，必填
        gridObject:$('#materialsList')[0],
        // 要进行检索的表对象(hibernate bean)名称， 进行拼接hql时使用; 必填
        boName:'MaterialsList',
        // 对象主键,删除数据时使用-默认为“id”；必填
        pkName:'mId',
        whereSql:'listId=\'${param.listId}\'',
		winWidth:800,
	    winHeight:250,
        // 表格控件dataGrid配置参数; 必填
        gridJson:{	
        	singleSelect:true,
        	checkOnSelect:false,
        	selectOnCheck:false,
            toolbar:[{   
	                text:'添加',
	                iconCls:'icon-add',
	                handler:function(){
	                	$('#materialsListWin').dialog('open');	                	
	                }
	            },'-',{   
	                text:'返回',
	                iconCls:'icon-back',
	                handler:function(){
	                	window.history.go(-1);	                	
	                }
	            },'-',
	        ],
            onClickCell:function(rowIndex, field, value){
                if(field == 'materialsName'){		
                    var rows = $(this).datagrid('getRows');
                    var row = rows[rowIndex];
                    $(this).datagrid('unselectRow',rowIndex);
                    $(this).datagrid('uncheckRow',rowIndex);
                    if(!isView){                    	
                    	aud$editRow(row, 'materialsListForm', 'materialsListWin', 'materialsList');
                    }else{
                    	$('.editElement').hide();
                    	aud$viewRow(row, 'materialsListForm', 'materialsListWin', 'view');
                    }
                }
            },	
    		columns:[[
                {field:'mId',  title:'选择',       width:'100px', checkbox:true,  align:'center', halign:'center', show:'false'},
                {field:'materialsName',title:'模板名称', width:'90%',align:'left',   halign:'center',  sortable:true, oper:'like',
                	formatter:formatterClick	},                             
          ]]
        }
    });
    
    // 按钮权限
    if(isView){ 	
	    g1.batchSetBtn([{'index':1, 'display':false},
	                    {'index':2, 'display':false},
	                    {'index':3, 'display':false},
	                    {'index':4, 'display':false}
	    			   ]);
    	 $('.editElement').hide();
    }else{
	    $('.viewElement').hide();
    }   
    
    function formatterClick(value){
    	return  ["<label title='单击编辑或查看' style='cursor:pointer;color:blue;'>",value,"</label>"].join('') ;
    }
    
    $('#materialsListWin').show();
	// 资料清单表单窗口
    $('#materialsListWin').dialog({
        title:'资料清单',
        closed:true,
        collapsible:true,
        modal:true,
        fit:true,
		onOpen:function(){
			audEvd$resizeWin('materialsListWin');
			audEvd$clearform('materialsListForm');
		},
        toolbar:isView ? [{
                text:'关闭',
                iconCls:'icon-cancel',
                handler:function(){
                    $('#materialsListWin').dialog('close');
                }
            }   	
        ] : [{
             text:'保存',
             id:'materialsListSaveBtn',
             iconCls:'icon-save',
             handler:function(){
            	 aud$saveForm('materialsListForm', "${contextPath}/ea/systemManage/saveMaterials.action?listId=${param.listId}&sortCode=${param.sortCode}", function(data){
            		 if(data){
            			 data.type == 'info' ? (g1.refresh(),$('#materialsListWin').dialog('close')) : null;
            			 data.msg ? showMessage1(data.msg) : null;	 
            		 }
            	 });
             }
         },{
             text:'清空',
             id:'materialsClearBtn',
             iconCls:'icon-empty',
             handler:function(){
            	 audEvd$clearform('materialsListForm');
             }
         },{
             text:'关闭',
             iconCls:'icon-cancel',
             handler:function(){
                 $('#materialsListWin').dialog('close');
             }
         }]
    });
});
</script>
</head>
<body style='padding:0px;margin:0px;overflow:hidden;' class='easyui-layout' fit='true' border='0'>
	<div region='center' border='0' style='padding:10px; overflow:hidden;'>	
		<table id='materialsList'></table>
	</div>	
	<!-- 材料价格表单窗口 -->
	<div id='materialsListWin' name='materialsListWin' style='display:none;'>
		<div class='easyui-layout' border='0' fit='true'>
			<div region='center' border='0'>
				<form  id='materialsListForm' name='materialsListForm' method="POST" >
					<input type='hidden' id="materialsList_mId" name="materialsList.mId"  class="noborder editElement clear"/>
					<input type='hidden' id="materialsList_listId" name="materialsList.listId"  value='${param.listId}' class="noborder editElement clear"/>
					<input type='hidden' id="materialsList_sortCode" name="materialsList.sortCode"  value="${param.sortCode}"class="noborder editElement clear"/>
					<table class="ListTable" align="center" style='table-layout:fixed;'>
						<tr>
							<td class="EditHead" style="width:15%;">资料名称</td>
							<td class="editTd" style="width:35%;">
								<input type='text' id='materialsList_materialsName' name='materialsList.materialsName' title='资料名称' class="noborder editElement clear"/>
							</td>							
						</tr>										
					</table>
				</form>
			</div>			
		</div>
	</div>
	<!-- 引入公共文件 -->
   <jsp:include flush="true" page="/pages/frReportFlow/ajaxloading.jsp" />   
</body>
</html>