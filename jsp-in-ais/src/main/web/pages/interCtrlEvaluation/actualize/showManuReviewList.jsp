<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML >
<html>
<title>内控评价-底稿复核</title>
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
	var tabTitle = "查看";
	var gridTableId = "totalProcessTable";
	var matrixLevelNames = '${matrixLevelNames}';
	
    //显示底稿复核窗口
    function showReviewInfoWindow(){
    	try{
    		var manuIds = getCheckRows();
    		//alert('manuIds.length='+manuIds.length)
    		if(manuIds && manuIds.length){    			
				var param = "manuId="+manuIds[0]+"&projectId=${projectId}&groupId=${groupId}&batchPost=1";	
				//alert(param)
				new aud$createTopDialog({
					title:'底稿复核',
					width:800,
					height:370,
					url:'${contextPath}/intctet/evaluationActualize/showReviewInfo.action?'+param,
					onClose:function(){},
					onOpen:function(){}
				}).open();	
				firstManuStatusCode = "";
				firstManuGroupId = "";
				firstManuRvLevel = "";
    		}
    	}catch(e){
    		alert("showReviewInfoWindow:\n"+e.message);
    	}
    }
    
    var firstManuStatusCode = "", firstManuGroupId = "", firstManuRvLevel = "";
    function getCheckRows(){
    	var manuIds = [];
		var rows = $('#'+gridTableId).datagrid("getChecked");
		if(rows != null && rows.length){
			var errMsg = "";
			$.each(rows, function(i, row){
				if(row['rvEnd'] != '1'){				
					var manuStatusCode = row['manuStatusCode'];
					var manuGroupId = row['groupId'];
					var manuRvLevel = row['rvLevel'];
					//alert(manuGroupId +"\n"+firstManuGroupId)
					if(i == 0){
						firstManuStatusCode = manuStatusCode;
						firstManuGroupId = manuGroupId;
						firstManuRvLevel = manuRvLevel;
						manuIds.push(row['manuId']);
					}else if(manuStatusCode == firstManuStatusCode 
							&& manuGroupId == firstManuGroupId
							&& manuRvLevel == firstManuRvLevel){					
						manuIds.push(row['manuId']);
					}else{
						$('#'+gridTableId).datagrid("uncheckAll");
						errMsg = "同一分组下且相同底稿状态的记录才能批量复核";
						return false;
					}				
				}else{
					errMsg = "此底稿已经复核完成，不能重复复核";
					$('#'+gridTableId).datagrid("uncheckAll");
					return false;
				}
			});
			//alert('manuIds='+manuIds)
			if(errMsg){
				showMessage1(errMsg);
			}else if(manuIds && manuIds.length){
				return manuIds;
			}
		}else{
			showMessage1("请选要复核的记录");
			return null;
		}
    }
    window.aud$getCheckRows = getCheckRows;

	var batchPostBtn = {
        text:'底稿复核',
        iconCls:'icon-ok',
        handler:showReviewInfoWindow	
	};
	var cusToolbar = isView ? [] : [batchPostBtn,'-'];
    var rvManuGrid = new createQDatagrid({
        // 表格dom对象，必填
        gridObject:$('#'+gridTableId)[0],
        // 要进行检索的表对象(hibernate bean)名称， 进行拼接hql时使用; 必填
        boName:'EvaManuscript',
        // 对象主键,删除数据时使用-默认为“id”；必填
        pkName:'manuId',
        order :'asc',
        sort  :'manuIndex',
		winWidth:780,
	    winHeight:300,
	    //自定义显示哪些按钮：myToolbar:['delete', 'export', 'search', 'reload'],
	    myToolbar:['search', 'reload'],
	    associate:true,
		// 默认删除按钮单击前执行, return ture:继续； false：停止；可选
		'beforeRemoveRowsFn':function(rows, gridObj){
			return true;
		},
		//定制查询条件
		whereSql: "projectId='${projectId}' and rvEnd != '1' and reviewerId='${user.floginname}' and manuStatusCode not in ('0','-1') ",
        gridJson:{
		    pageSize:20,
        	singleSelect:true,
        	checkOnSelect:false,
        	selectOnCheck:false,
    		border:0,
    		toolbar:cusToolbar,
    		onCheck:function(index, row){
    			getCheckRows();
    		},
    		loadFilter:function(data){
    			return data;
    		},
            onClickCell:function(rowIndex, field, value){
                var rows = $(this).datagrid('getRows');
                var row = rows[rowIndex];
                $(this).datagrid('unselectRow',rowIndex);
                $(this).datagrid('uncheckRow',rowIndex);
                if(field == 'cpCode'){
   					var cpUrl= "${contextPath}/intctet/mainProcess/editControlPoint.action?proCp=true&view=${view}&projectId=${projectId}&cpId="+row['cpId'];
   					//alert('cpUrl='+cpUrl);
   					aud$openNewTab("项目${lastlevelName}"+tabTitle, cpUrl, true);
   					
                }else if(field == 'manuIndex'){
					var manuEditUrl = "${contextPath}/intctet/evaluationActualize/editManu.action?view=${view}&manuId="+row['manuId'];
   					aud$openNewTab(row['projectName']+"-底稿" + tabTitle, manuEditUrl, true);
                }else if(field == "projectName"){
                	var projectId = row['projectId'];
					var manuEditUrl = "${contextPath}/intctet/evaProject/evaPlan/editEvaPlan.action?view=true&formId="+row['projectId'];
   					aud$openNewTab(row['projectName']+"-查看", manuEditUrl, true);
                }  
            },
            frozenColumns:[[           	
    			{field:'manuId',  title:'选择',   width:'0px', checkbox:true, align:'center', halign:'center', show:'false'},
				{field:'manuIndex',title:"底稿索引", width:'180px',align:'center',halign:'center', sortable:true, oper:'like',
	   				formatter:function(value,row,index){
	   					return ["<label title='单击"+tabTitle+"["+row['manuStatus']+"]' style='cursor:pointer;color:blue;'>",value,"</label>"].join('') ;
	   				}
				}
            ]],
    		columns:[[
				{field:'curRvLevel', title:"已复核级次",width:'80px',align:'center', halign:'center', sortable:false, show:false,
	   				formatter:function(value,row,index){
	   					return value ? (value == '0' ? '未复核' : value+"级") : "";
	   				}
				},			
				{field:'projectName', title:"所属项目",width:'180px',align:'left', halign:'center', sortable:false, show:false,
	   				formatter:function(value,row,index){
	   					return ["<label title='单击查看' style='cursor:pointer;color:blue;'>",value,"</label>"].join('') ;
	   				}
				},
				{field:'manuStatus', title:"底稿状态",width:'110px',align:'center', halign:'center', sortable:true, oper:'like'},				
				{field:'rvExplain',  title:"复核意见",width:'130px',align:'center', halign:'center', sortable:true, show:false},
				{field:'rvEnd',   title:"是否复核完成",width:'100px',align:'center', halign:'center', sortable:false,
					type:'custom', target:$('#queryCond1')[0],
	   				formatter:function(value,row,index){
	   					return value == '0' ? '进行中' : value == '1' ? "<strong><font color='red'>已完成</font></strong>" : '未开始';
	   				}
				},
				{field:'preRvPerson',title:"上一步提交人", width:'100px',align:'center',halign:'center', show:false},		
				{field:'preRvDate',  title:"上一步提交时间", width:'120px',align:'center',halign:'center', show:false},
				{field:'nextRvPerson',title:"下一步处理人", width:'100px',align:'center',halign:'center', show:false},
    			{field:'mpName',title:"${firstlevelName}", queryText:'${firstlevelName}名称', width:'120px',align:'center',halign:'center', oper:'like'},
    			{field:'cpCode',title:"${lastlevelName}", width:'150px',align:'center',halign:'center', show:false,
    				type:'custom', target:$('#queryCond2')[0],
	   				formatter:function(value,row,index){
	   					return ["<label title='单击"+tabTitle+"' style='cursor:pointer;color:blue;'>",value,"</label>"].join('') ;
	   				}
    			},
    			{field:'cpName',title:"${lastlevelName}名称", width:'40%',align:'left',halign:'center', oper:'like',
    				formatter:function(value,row,index){
    					return value ? "<label title='"+value+"'>"+value+"</label>" : "";
    				}	
    			},
    			{field:'groupName',title:"所属分组",  width:'80px', align:'center', halign:'center', show:false},
    			{field:'evaluatedUnit',title:"被评价单位", width:'180px',align:'left',halign:'center', 
    				type:'custom', target:$('#queryCond4')[0],
    				formatter:function(value,row,index){
    					return value ? "<label title='"+value+"'>"+value+"</label>" : "";
    				}	
    			},
				{field:'tester',title:"测试人",  width:'80px', align:'center', halign:'center', sortable:true,
    				type:'custom', target:$('#queryCond3')[0]},
				{field:'testTime',title:"测试时间", width:'90px',align:'center',halign:'center', show:false},
          ]]
        }
    });
    window.aud$manuGrid = rvManuGrid;
    
    //被评价单位下拉选择
    var evUnitIds = $.trim('${evaluatedUnitId}'.replace('[','').replace(']','').replace(" ","")).split(',');
    var evUnitNames = $.trim('${evaluatedUnitName}'.replace('[','').replace(']','').replace(" ","")).split(',');
    var evUnitIdParam = [];
	if(evUnitIds != null && evUnitIds.length && evUnitNames != null && evUnitIds.length == evUnitNames.length ){
		$.each(evUnitIds, function(i, evUnitId){
			$('#queryEvaluatedUnit').append("<option value='"+$.trim(evUnitId)+"'>"+$.trim(evUnitNames[i])+"</option>");
			evUnitIdParam.push($.trim(evUnitId));
		});
		$('#queryEvaluatedUnit').combobox({
			editable:false,
			multiple:false,
			panelHeight:'auto'
		});
	};
});

function refresh() {
	$('#totalProcessTable').datagrid('reload');
}
</script>
</head>
<body style='padding:0px;margin:0px;overflow:hidden;' class="easyui-layout" fit="true" border="0">
	<div region="center"  border="0">	
		<table id="totalProcessTable"></table>
	</div>
	
	<!-- 自定义查询条件 -->
	<div id="queryCond1">
		<select name='query_eq_rvEnd' style='background: transparent;border: 1px solid #ccc;' 
			panelHeight="auto" editable=false class="easyui-combobox">
			<option value='' selected>全部</option>
			<option value='-1'>复核未开始</option>
			<option value='0'>复核进行中</option>
			<option value='1'>复核完毕</option>
		</select>
	</div>
	<div id="queryCond2">
		<input type='text' name="query_like_cpName"/>
	</div>
	<div id="queryCond3">
		<input type='text' class="noborder editElement clear " readonly/>
		<input type='hidden'  name='query_eq_testerId' class="noborder editElement clear" readonly/>
		<a class="easyui-linkbutton  editElement " iconCls="icon-search" style='border-width:0px;'
			onclick="showSysTree(this,{
                  title:'测试人选择',
				  param:{
				  	'rootParentId':'0',
                    'beanName':'UOrganizationTree',
                    'treeId'  :'fid',
                    'treeText':'fname',
                    'treeParentId':'fpid',
                    'treeOrder':'fcode'
                 },
                 type:'treeAndUser',
                 singleSelect:true
		})"></a>
	</div>
	<div id="queryCond4">			
		<select  id="queryEvaluatedUnit" name='query_in_evaluatedUnitId' 
			style='background: transparent;border: 1px solid #ccc;' >
			<option value="">全部</option>
		</select>
	</div>
</body>
</html>