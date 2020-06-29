<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML >
<html>
<title>内控评价-缺陷一览表</title>
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
$(function(){
	if("${errorMsg}"){
		top.$.messager.alert("提示信息","${errorMsg}", function(){			
			aud$closeTab();
		});
		setTimeout(aud$closeTab,0);
	}
	
	var isView = "${view}" == true || "${view}" == "true" ? true : false;
	var tabTitle = isView ? "查看" : "编辑";
	var curTabId = aud$getActiveTabId();
	var parentTabId = '${parentTabId}';
	var defectViewTableId = "defectViewTable";
	
	var defectToReportConfig = {   
         text:'入报告设定',
         iconCls:'icon-config',
         handler:defectToReportConfig
     };	
	var cusToolbar = isView ? [] : [defectToReportConfig, "-"];

	var defectGrid = new createQDatagrid({
        // 表格dom对象，必填
        gridObject:$('#'+defectViewTableId)[0],
        // 要进行检索的表对象(hibernate bean)名称， 进行拼接hql时使用; 必填
        boName:'ConfirmCtrlDefect',
        // 对象主键,删除数据时使用-默认为“id”；必填
        pkName:'cdId',
        order :'asc',
        sort  :'createTime',
		winWidth:780,
	    winHeight:250,
	    //自定义显示哪些按钮：myToolbar:['delete', 'export', 'search', 'reload'],
	    myToolbar:['search', 'export', 'reload'],
		//定制查询, 底稿复核完毕的
		whereSql: "projectId='${projectId}' ",
		associate:true,
        gridJson:{
			//title:'缺陷一览表',
		    pageSize:10,
        	singleSelect:true,
        	checkOnSelect:false,
        	selectOnCheck:false,
    		border:0,
    		fit:true,
    		toolbar:cusToolbar,
    		loadFilter:function(data){
    			var rows = data.rows;
    			var newRows = []; 
    			$.each(rows, function(i, row){
    				if(row['rvEnd'] == '1'){
    					newRows.push(row);
    				}
    			});
    			data.total = newRows.length;
    			data.rows = newRows;
    			return data;
    		},
            onClickCell:function(rowIndex, field, value){
                var rows = $(this).datagrid('getRows');
                var row = rows[rowIndex];
                $(this).datagrid('unselectRow',rowIndex);
                $(this).datagrid('uncheckRow',rowIndex);
                if(field == 'defectCode'){		
                	var defectParam = "&manuId=${manu.manuId}&projectId=${manu.projectId}&groupId=${groupId}";
                	var defectEditUrl = "${contextPath}/intctet/evaluationActualize/editConfirmCtrlDefect.action?view=true"+defectParam;
                    aud$openNewTab("认定控制缺陷查看", defectEditUrl+"&cdId="+row['cdId'], true);
                }else if(field == 'manuIndex'){	
					var manuEditUrl = "${contextPath}/intctet/evaluationActualize/editManu.action?view=true&manuId="+row['manuId'];
   					aud$openNewTab("底稿查看", manuEditUrl, true)
                }
            },	
            frozenColumns:[[
            	
				{field:'cdId',       title:"选择",        width:'1px', align:'center',  halign:'center',  checkbox:true, show:'false'},
    			{field:'defectCode', title:"缺陷编号",  width:'70px', align:'center', halign:'center',  sortable:true,show:false,
					formatter:formatterClick},
				{field:'defectName', title:"缺陷简述",  width:'250px', align:'left',halign:'center', sortable:true, oper:'like',
					formatter:function(value, row, index){
						return "<label title='"+value+"'>" + ( row['inReportCode'] == '1' ? "<font color='green'>"+value+"</font>" : value)+"</label>";
					}
				},
				{field:'manuIndex',  title:"底稿索引",  width:'200px', align:'center',   halign:'center', show:false,
					formatter:formatterClick},
				{field:'inReport', title:"是否入报告",  width:'80px', align:'center',   halign:'center',  sortable:true, 
					type:'custom', target:$('#queryCond5')[0]}
            ]],
    		columns:[[
				{field:'mpName', title:"所属${firstlevelName}", width:'150px', align:'center',   halign:'center', oper:'like',
					formatter:function(value,row,index){
						return value ? "<label title='"+value+"'>"+value+"</label>" : "";
					}	
				},
				{field:'cpName', title:"所属${lastlevelName}",  width:'35%', align:'center',   halign:'center', oper:'like',
					formatter:function(value,row,index){
						return value ? "<label title='"+value+"'>"+value+"</label>" : "";
					}	
				},
				{field:'accountabilityUnit', title:"被评价单位",  width:'180px', align:'left',   halign:'center',  sortable:true,
					type:'custom', target:$('#queryCond1')[0],
					formatter:function(value,row,index){
						return value ? "<label title='"+value+"'>"+value+"</label>" : "";
					}		
				},
				{field:'defectTypeName', title:"缺陷类型",  width:'80px', align:'center',   halign:'center',  sortable:true,
					type:'custom', target:$('#queryCond2')[0],
					formatter:function(value,row,index){
						return value ? "<label title='"+value+"'>"+value+"</label>" : "";
					}		
				},
				{field:'relateLoss', title:"涉及到损失/错报的金额(万元)",  width:'210px', align:'right',   halign:'center',  sortable:true, oper:'like',
					formatter: aud$formatMoney
				},
				{field:'initialIdentify', title:"初步认定结果",  width:'100px', align:'center',   halign:'center',  sortable:true,
					type:'custom', target:$('#queryCond3')[0]},
				{field:'mendAdvice', title:"整改建议",  width:'80px', align:'center',   halign:'center',  sortable:true, 
						type:'custom', target:$('#queryCond4')[0]},
				{field:'remark', title:"备注",  width:'150px', align:'left',   halign:'center',  sortable:true, oper:'like',
					formatter:function(value,row,index){
						return value ? "<label title='"+value+"'>"+value+"</label>" : "";
					}	
				}
          ]]
        }
    });
	window.aud$defectGrid = defectGrid;
	
    function formatterClick(value){
    	var t = "查看";
    	return  ["<label title='单击"+t+"' style='cursor:pointer;color:blue;'>",value,"</label>"].join('') ;
    }
    
    function getCheckRows(rtval){
    	var cdIds = [];
		var rows = $('#'+defectViewTableId).datagrid("getChecked");
		if(rows != null && rows.length){
			if(rtval){
				$.each(rows, function(i, row){
					cdIds.push(row['cdId']);
				});
				if(cdIds && cdIds.length){
					return cdIds;
				}else{
					showMessage1("无法获得选择记录的ID");
					return false;
				}
			}else{
				return true;
			}
		}else{
			showMessage1("请选择入报告记录");
			return false;
		}
    }
    
    window.aud$getCheckRows = getCheckRows;
    
	function defectToReportConfig(){
		if(getCheckRows()){			
			var topDialog = new aud$createTopDialog({
				title:'入报告设定',
				width:600,
				height:230,
				url:'${contextPath}/intctet/evaluationActualize/showDefectToReportConfig.action?projectId=${projectId}'
			});
			topDialog.open();
		}
	}
	
    //被评价单位下拉选择
    var evUnitIds = $.trim('${evaluatedUnitId}'.replace('[','').replace(']','').replace(" ","")).split(',');
    var evUnitNames = $.trim('${evaluatedUnitName}'.replace('[','').replace(']','').replace(" ","")).split(',');
	if(evUnitIds != null && evUnitIds.length && evUnitNames != null && evUnitIds.length == evUnitNames.length ){
		$.each(evUnitIds, function(i, evUnitId){
			$('#queryUnitSelect').append("<option value='"+$.trim(evUnitId)+"'>"+$.trim(evUnitNames[i])+"</option>");
		});
		$('#queryUnitSelect').combobox({
			editable:false,
			multiple:false,
			panelHeight:'auto',
			panelWidth:150
		});
	};
	
});

function refresh() {
	$('#defectViewTable').datagrid('reload');
}
</script>
</head>
<body style='padding:0px;margin:0px;overflow:hidden;' class="easyui-layout" fit="true" border="0">
	<div region="center"  border="0">	
		<table id="defectViewTable"></table>
	</div>
	
	
	<!-- 自定义查询条件 -->
	<div id="queryCond1">			
		<select  id="queryUnitSelect" name='query_eq_accountabilityUnitCode' style='width:150px;background: transparent;border: 1px solid #ccc;' >
			<option value="">全部</option>
		</select>
	</div>
	
	<div id="queryCond2">
		<input type='text'  class="noborder editElement clear " readonly/>
		<input type='hidden'  name='query_eq_defectTypeCode' class="noborder editElement clear " readonly/>
		<a  class="easyui-linkbutton  editElement" iconCls="icon-search" style='border-width:0px;'
			onclick="showSysTree(this,{
				  title:'缺陷类型选择',
	              onlyLeafClick:true,
				  param:{
					'plugId':'710020',
				    'whereHql':'type=\'710020\'',
				    'customRoot':'缺陷类型',
				  	'rootParentId':'0',
                    'beanName':'CodeName',
                    'treeId'  :'id',
                    'treeText':'name',
                    'treeParentId':'pid',
                    'treeOrder':'name'
                 }
		})"></a>
	</div>
	
	<div id="queryCond3">
		<input type='text'  class="noborder editElement clear " readonly/>
		<input type='hidden' name='query_eq_initialIdentifyCode' class="noborder editElement clear " readonly/>
		<a  class="easyui-linkbutton  editElement" iconCls="icon-search" style='border-width:0px;'
			onclick="showSysTree(this,{
				  title:'初步认定结果选择',
                  onlyLeafClick:true,
				  param:{
					'plugId':'DefectLevel',
				    'customRoot':'初步认定结果',
				  	'rootParentId':'notnull',
                    'beanName':'DefectLevel',
                    'treeId'  :'code',
                    'treeText':'dlLevel',
                    'treeParentId':'dlId',
                    'treeOrder':'code'
                  }
		})"></a>
	</div>
	
	<div id="queryCond4">
		<input type='text' class="noborder editElement clear" readonly/>
		<input type='hidden'  name='query_eq_mendAdviceCode' class="noborder editElement clear" readonly/>
		<a  class="easyui-linkbutton  editElement" iconCls="icon-search" style='border-width:0px;'
			onclick="showSysTree(this,{
				  title:'整改建议选择',
                  onlyLeafClick:true,
				  param:{
					'plugId':'710030',
				    'whereHql':'type=\'710030\'',
				    'customRoot':'整改建议',
				  	'rootParentId':'0',
                    'beanName':'CodeName',
                    'treeId'  :'id',
                    'treeText':'name',
                    'treeParentId':'pid',
                    'treeOrder':'name'
                  }
		})"></a>
	</div>
	
	<div id="queryCond5">
		<select  name='query_eq_inReportCode' style='background: transparent;border: 1px solid #ccc;' 
			panelHeight="auto" editable=false class="easyui-combobox">
			<option value="">全部</option>
			<option value="1">是</option>
			<option value="0">否</option>
		</select>
	</div>
</body>
</html>