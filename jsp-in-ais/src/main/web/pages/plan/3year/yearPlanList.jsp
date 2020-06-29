<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML >
<html>
<title>三年计划列表</title>
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
	var isView = "${view}" == true ||  "${view}" == 'true' ? true : false;
	var currentUser = "${user.floginname}";
	var auditDept = "${user.fdepid}";
	var hql= "${hql}";
	var editUrl = '${contextPath}/plan/3year/edit.action';
	var tabTitle = isView ? "查看" : "编辑";
    var gridTableId = "yearPlanList";

	var addBtn = {   
            text:'新增',
            iconCls:'icon-add',
            handler:function(){
            	aud$openNewTab('新增三年计划', editUrl, false);
            }
        };

    var delBtn = {
        text:'删除',
        iconCls:'icon-delete',
        handler:function(){
            delYearPlan();
        }
    };

    var expWordBtn = {
        text:'导出word',
        iconCls:'icon-export',
        handler:function(){
            showExportTemplate();
        }
    };

	var cusToolbar = [];
    cusToolbar = isView ? ['search','reload','-',expWordBtn,'-','export','-'] :
        ['search','-',addBtn,'-',delBtn,'-','reload','-',expWordBtn,'-','export'];
    
    var bodyW = $('body').width();
    var g1 = new createQDatagrid({
        // 表格dom对象，必填
        gridObject:$('#'+gridTableId)[0],
        // 要进行检索的表对象(hibernate bean)名称， 进行拼接hql时使用; 必填
        boName:'WorkPlan3Year',
        // 对象主键,删除数据时使用-默认为“id”；必填
        pkName:'formId',
        order :'desc',
        sort  :'planYearStart',
        whereSql:hql == '1' ? '' : ""+hql+" ",
        myToolbar:[],
		winWidth:800,
	    winHeight:250,
    	// 删除前的校验，如果返回true可以删除，否则为false
    	beforeRemoveRowsFn:function(rows, datagridObj){
    		/*
    		if(rows){			
    			for(var i=0; i<rows.length; i++){
    				var row = rows[i];
    				alert(row.attachmentId)
    			}
    		}*/
    		return true;
    	},
        // 表格控件dataGrid配置参数; 必填
        gridJson:{
            pageSize:20,
        	checkOnSelect:false,
        	selectOnCheck:false,
            toolbar:cusToolbar,
            onClickCell:function(rowIndex, field, value){
                if(field == 'planName'){
                    var rows = $(this).datagrid('getRows');
                    var row = rows[rowIndex];
                    $(this).datagrid('unselectRow',rowIndex);
                    $(this).datagrid('uncheckRow',rowIndex);
                    var eview = row["planStatus"] == '1000' ? false : true;
                    aud$openNewTab(row['planName']+(eview ? "查看":"编辑"), editUrl+"?crudId="+row['formId']+(eview ? "&view=true" : ""), false);
                }
            },	
            frozenColumns:[[           	
                {field:'formId', title:'选择',checkbox:!isView,  align:'center', halign:'center', show:'false', hidden:isView},
                {field:'planStatusName',title:'计划状态', width:bodyW * 0.1 + 'px',align:'left',   halign:'center',  sortable:true	,type:'custom', target:$('#queryCond1')[0]},
                {field:'planCode',title:'计划编号', width:0.2*bodyW + 'px',align:'left',   halign:'center',  sortable:true, oper:'like'},
                {field:'planName', title:'计划名称', width:0.2*bodyW+'px',align:'left', halign:'center',  sortable:true, oper:'like',
                	formatter:formatterClick
                }
            ]],
    		columns:[[
                {field:'planYearStart',title:'计划期间', width:0.15*bodyW + 'px',align:'center', halign:'center',  sortable:false,
                    type:'custom', target:$('#queryCond2')[0],
                formatter:function(value,row,index){
                    return value+'-'+row['planYearEnd'];
                }},
                {field:'auditDeptName',  title:'审计单位', width:0.17*bodyW+'px',align:'left', halign:'center',  sortable:true, oper:'like'},
                {field:'creator',title:'计划编制人', width:0.1*bodyW+'px',align:'center', halign:'center',  sortable:true, oper:'like'}
          ]]
        }


    });

    window.yearPlanList = g1;
    
    
	//单元格tooltip提示
	$('#yearPlanList').datagrid('doCellTip', {
		position : 'bottom',
		maxWidth : '200px',
		tipStyler : {
			'backgroundColor' : '#EFF5FF',
			borderColor : '#95B8E7',
			boxShadow : '1px 1px 3px #292929'
		}
	
	});
    // 按钮权限
    isView ? $('.editElement').hide() : $('.viewElement').hide();
    // 删除按钮权限
    isView? g1.batchSetBtn([ {'id':gridTableId+'_remove','remove':true} ]) : null;
      
    function formatterClick(value, row){
    	 var title = row["planStatus"] == '1002' ? "查看" : "编辑";
    	return  ["<label title='单击"+title+"' style='cursor:pointer;color:blue;'>",value,"</label>"].join('') ;
    }

    function delYearPlan() {
        var rows = $('#' + gridTableId).datagrid('getChecked');
        if(rows && rows.length){
            var flag = false;
            for(var i = 0;i < rows.length;i++){
                var row = rows[i];
                if(row['planStatus'] != '1000'){
                   flag = true;
                   break;
                }
            }
            if(flag){
                showMessage1('非草稿状态的三年计划不可删除！');
                return;
            }
            top.$.messager.confirm('确认','删除三年计划将删除其下的所有审计项目，确认删除吗？',function (r) {
                if(r){
                    var yearPlanIds = [];
                    for(var i = 0;i < rows.length;i++){
                        var row = rows[i];
                        if(row['formId'] != null&&row['formId'] != ''){
                            yearPlanIds.push(row['formId']);
                        }
                    }
                    if(yearPlanIds.length > 0){
                        $.ajax({
                            url:'${contextPath}/plan/3year/delete3YearPlan.action',
                            type:'post',
                            cache:false,
                            dataType:'json',
                            data:{
                                'yearPlanIds':yearPlanIds.join(',')
                            },
                            success:function(data){
                                showMessage1(data.msg);
                                yearPlanList.refresh();
                            }
                        });
                    }
                }
            });
        }else{
            showMessage1('请选择要删除的三年计划！');
        }
    }

    function showExportTemplate(){
        var rows = $('#yearPlanList').datagrid('getChecked');
        var yearPlanId = '',planName = '';
        if(rows && rows.length){
            if(rows.length > 1){
                showMessage1('请选择一条计划导出！');
                return;
            }else{
                yearPlanId = rows[0].formId;
                planName = rows[0].planName;
            }
        }else{
            showMessage1('请选择要导出的计划！');
            return;
        }
        $('#exportTemplateList').datagrid({
            url : "<%=request.getContextPath()%>/unitary/nc/autoreport/reportTemplateList.action?fromType=3yearplan",
            method:'post',
            showFooter:false,
            rownumbers:true,
            striped:true,
            autoRowHeight:false,
            fit: true,
            fitColumns:true,
            idField:'id',
            border:false,
            singleSelect:true,
            remoteSort: false,
            columns:[[
                {field:'name',
                    title:'模板名称',
                    width:200,
                    halign:'center',
                    align:'left',
                    sortable:true
                },
                {field:'operate',
                    title:'操作',
                    halign:'center',
                    align:'center',
                    width:100,
                    sortable:false,
                    formatter:function(value,row,index){
                        var link = '<a href=\"javascript:void(0);\" onclick=\"exportWord(\''+planName+'\',\''+row.templateId+'\',\''+yearPlanId+'\')\">导出</a>';
                        return link;
                    }
                }
            ]]
        });

        $('#template').dialog({
           title:'三年计划导出模板选择',
           width:500,
           height:300,
           closed:false,
           modal:true
        });
    }

    var currentYear = "${curYear}";
    var offsetYear = 5;
    var yearArr = [];
    for(var i=currentYear-offsetYear; i<parseInt(currentYear)+offsetYear; i++){
        yearArr.push({
            'code':i,
            'name':i
        });
    }
    $('#planYearStart').val('');
    $('#planYearEnd').val('');
    aud$genSelectOption('planYear', yearArr, '', {
        onChange:function(newValue,oldValue){
            $('#planYearStart').val(newValue);
            $('#planYearEnd').val(newValue);
        }
    });

    aud$genSelectOptionCustom('planStatus', ${planStatusArr},'planStatus','planStatusName','', {

    });
});

function exportWord(planName,templateId,yearPlanId){
    var h = window.screen.availHeight;
    var w = window.screen.width;
    //window.showModalDialog('${contextPath}/plan/3year/exportWord.action?templateId='+templateId+'&yearPlanId='+yearPlanId,window,'dialogWidth:'+w+'px;dialogHeight:'+h+'px;status:no;resizable:yes;minimize:yes;maximize:yes;');
    aud$openNewTab(planName+'导出','${contextPath}/plan/3year/exportWord.action?templateId='+templateId+'&yearPlanId='+yearPlanId);
}

function refresh(){
	$('#yearPlanList').datagrid('reload');
}
</script>
</head>
<body style='padding:0px;margin:0px;overflow:hidden;' >
	<table id='yearPlanList'></table>
    <div id="template">
        <table id="exportTemplateList"></table>
    </div>
    <div id="queryCond1">
        <select id="planStatus" name="query_eq_planStatus"></select>
    </div>
    <div id="queryCond2">
        <select id="planYear"></select>
        <input type="hidden" name="query_lte_planYearStart" id="planYearStart"/>
        <input type="hidden" name="query_gtq_planYearEnd" id="planYearEnd"/>
    </div>
	<!-- 引入公共文件 -->
   <jsp:include flush="true" page="/pages/frReportFlow/ajaxloading.jsp" />
</body>
</html>