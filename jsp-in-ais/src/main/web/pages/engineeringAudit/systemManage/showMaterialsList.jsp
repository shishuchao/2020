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
        gridObject:$('#templateList')[0],
        // 要进行检索的表对象(hibernate bean)名称， 进行拼接hql时使用; 必填
        boName:'TemplateList',
        // 对象主键,删除数据时使用-默认为“id”；必填
        pkName:'listId',
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
	                	$('#listWin').dialog('open');	                	
	                }
	            },'-',
	        ],
            onClickCell:function(rowIndex, field, value){
                if(field == 'listName'){		
                    var rows = $(this).datagrid('getRows');
                    var row = rows[rowIndex];
                    $(this).datagrid('unselectRow',rowIndex);
                    $(this).datagrid('uncheckRow',rowIndex);
                    if(!isView){                    	
                    	aud$editRow(row, 'listForm', 'listWin', 'templateList');
                    }else{
                    	$('.editElement').hide();
                    	aud$viewRow(row, 'listForm', 'listWin', 'view');
                    }
                }
            },	
    		columns:[[
                {field:'listId',  title:'选择',       width:'300px', checkbox:true,  align:'center', halign:'center', show:'false'},
                {field:'listName',title:'模板名称', width:'300px',align:'left',   halign:'center',  sortable:true, oper:'like',
                	formatter:formatterClick	},                                
                {field:'sortName', title:'可适用类别', width:'300px',align:'left', halign:'center',sortable:true},                
                {field:'xxx',  title:'操作', width:'450px',align:'left',   halign:'center',sortable:true, show:false,
                	formatter:function(value,row,index){
					 	var param = [row.listId,row.sortCode];
						var btn2 = "-btnrule-设置清单资料,detailWindow,"+param.join(',');
						return ganerateBtn(btn2);
					 }
                },
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
    
    $('#listWin').show();
	// 工程项目表单窗口
    $('#listWin').dialog({
        title:'送审资料清单',
        closed:true,
        collapsible:true,
        modal:true,
        fit:true,
		onOpen:function(){
			audEvd$resizeWin('listWin');
			audEvd$clearform('listForm');
		},
        toolbar:isView ? [{
                text:'关闭',
                iconCls:'icon-cancel',
                handler:function(){
                    $('#listWin').dialog('close');
                }
            }   	
        ] : [{
             text:'保存',
             id:'listSaveBtn',
             iconCls:'icon-save',
             handler:function(){
            	 aud$saveForm('listForm', "${contextPath}/ea/systemManage/saveList.action", function(data){
            		 if(data){
            			 data.type == 'info' ? (g1.refresh(),$('#listWin').dialog('close')) : null;
            			 data.msg ? showMessage1(data.msg) : null;	 
            		 }
            	 });
             }
         },{
             text:'清空',
             id:'proInfoClearBtn',
             iconCls:'icon-empty',
             handler:function(){
            	 audEvd$clearform('listForm');
            	 $('#sortCode').combobox('setValues', '');
             }
         },{
             text:'关闭',
             iconCls:'icon-cancel',
             handler:function(){
                 $('#listWin').dialog('close');
             }
         }]
    });
});
//设置资料清单
function detailWindow(id,code){
	var url = "<%=request.getContextPath()%>/ea/systemManage/showDetail.action?sortCode="+code+"&listId="+id;
	window.location = url;
}
</script>
</head>
<body style='padding:0px;margin:0px;overflow:hidden;' class='easyui-layout' fit='true' border='0'>
	<div region='center' border='0' style='padding:10px; overflow:hidden;'>	
		<table id='templateList'></table>
	</div>	
	<!-- 材料价格表单窗口 -->
	<div id='listWin' name='listWin' style='display:none;'>
		<div class='easyui-layout' border='0' fit='true'>
			<div region='center' border='0'>
				<form  id='listForm' name='listForm' method="POST" >
					<input type='hidden' id="templateList_listId" name="templateList.listId"  class="noborder editElement clear"/>
					<table class="ListTable" align="center" style='table-layout:fixed;'>
						<tr>
							<td class="EditHead" style="width:15%;">模板名称</td>
							<td class="editTd" style="width:35%;">
								<input type='text' id='templateList_listName' name='templateList.listName' title='模板名称' class="noborder editElement clear"/>
							</td>
							<td class="EditHead" style="width:15%;">适用项目类别</td>
							<td class="editTd" style="width:35%;">
								<input type="text" id="templateList_sortName" name="templateList.sortName" title="适用项目类别" 
								value="${templateList.sortName}" class="noborder editElement clear" readonly/> 
								<input type="hidden" id="templateList_sortCode" name="templateList.sortCode" value="${templateList.sortCode}" title="适用项目类别Code"/>
								 <img  style="cursor:hand;border:0" src="/ais/resources/images/s_search.gif" class=" editElement "
									onclick="showSysTree(this,{
		                                  title:'审计类型',
		                                  onlyLeafClick:true,
		                                  'serverCache':false,
										  param:{
										  	'rootParentId':'0',
						                    'beanName':'CodeName',
						                    'whereHql':'type=\'6001\'',
						                    'plugId':'6001',
						                    'treeId'  :'id',
						                    'treeText':'name',
						                    'treeParentId':'pid',
						                    'treeOrder':'code'
						                 }                                  
								})"></img>								
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