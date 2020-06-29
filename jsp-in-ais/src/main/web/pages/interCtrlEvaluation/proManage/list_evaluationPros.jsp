<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<jsp:directive.page import="ais.framework.util.UUID"/>

<html>
<title>评价项目进度</title>
<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
	<link href="<%=request.getContextPath()%>/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
	<link href="<%=request.getContextPath()%>/resources/css/common.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/createOrgTree.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>  
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/common.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/pages/tlInteractive/tlInteractiveCommon.js"></script> 
<script type="text/javascript">
var editFlag = undefined;
var g1;
$(function(){
	var bodyW = $('body').width();
    var bodyH = $('body').height(); 
    $('#query_year').show();
    $('#query_status').show();
    $('#query_category').show();
    var currentUser = "${currentUser}";
 
    frloadOpen();
    g1 = new createQDatagrid({
        // 表格dom对象，必填
        gridObject:$('#sDTable')[0],
        // 要进行检索的表对象(hibernate bean)名称， 进行拼接hql时使用; 必填
        boName:'EvaluationPlan',
        // 对象主键,删除数据时使用-默认为“id”；必填
        pkName:'formId',
      	whereSql: "formId in(select projectFormId from InterMember where userId='"+currentUser+"')",
        order:'desc',
        sort:'createTime',
        winWidth:800,
        winHeight:250,
        gridJson:{    
            checkOnSelect:false,
            selectOnCheck:false,
            singleSelect:false,
            onLoadSuccess:frloadClose,
            frozenColumns:[[ {field:'proCode',title:'编号', width:'160px',align:'center', sortable:true, oper:'eq', show:'false'},
                             {field:'epStatusName',title:'状态', width:'70px',align:'center', sortable:true, type:'custom', target:$('#query_status')[0]},
                             {field:'epName',title:'项目名称', width:'250px',align:'left', halign:'center', sortable:true, oper:'like', 
                            	formatter:function(value,rowData,rowIndex){
                            		var stage;
                                	if(rowData.prepareClosed=="0"){
                                    	stage = "<a href=\"javascript:void(0);\" style=\"font: bolder;\"onclick=\"openTarget('"+rowData.formId+"','prepare');\">"+value+"</a>";
                                	}else if(rowData.actualizeClosed=="0"){
                                    	stage = "<a href=\"javascript:void(0);\" style=\"font: bolder;\" onclick=\"openTarget('"+rowData.formId+"','actualize');\">"+value+"</a> | <a href=\"javascript:void(0);\" style=\"font: bolder;\" onclick=\"openTarget('"+rowData.formId+"','report');\">"+value+"</a>";
                                	}else if(rowData.archivesClosed=="0"){
                                    	stage = "<a href=\"javascript:void(0);\" style=\"font: bolder;\" onclick=\"openTarget('"+rowData.formId+"','archives');\">"+value+"</a>";
                                	}else{
                                    	stage = "<a href=\"javascript:void(0);\" style=\"font: bolder;\" onclick=\"openTarget('"+rowData.formId+"','rework');\">"+value+"</a>";
                                	}
                                return stage;
                            }}]],
            columns:[[
               {field:'epYear',title:'项目年度', width:'70px',align:'center', sortable:true, type:'custom', target:$('#query_year')[0]},
               {field:'proCategory',width:'70px',title:'项目类别', align:'center', sortable:true, type:'custom', target:$('#query_category')[0]},
               {field:'principal',width:'120px',title:'评价专岗负责人', align:'center', sortable:true,type:'custom', target:$('#queryCond2')[0]},
               {field:'evaOrgan',width:'180px',title:'内控评价组织者', align:'left', halign:'center',sortable:true, type:'custom', target:$('#queryCond1')[0]},
               {field:'prepareClosed',width:'60px',title:'准备', align:'center', sortable:true, show:'false',
            	   formatter: function(value, rowData, rowIndex) {
            		   if(value == '' || value == null) 
            			   return '未执行';
            		   else if(value == '0')
            			   return '进行中';
            		   else if(value == '1')
            			   return '已完成';
            	   }
               },
               {field:'actualizeClosed',width:'60px',title:'实施', align:'center', sortable:true, show:'false',
            	   formatter: function(value, rowData, rowIndex) {
            		   if(value == '' || value == null) 
            			   return '未执行';
            		   else if(value == '0')
            			   return '进行中';
            		   else if(value == '1')
            			   return '已完成';
            	   }
               },
               {field:'reportClosed',width:'60px',title:'报告', align:'center', sortable:true, show:'false',
            	   formatter: function(value, rowData, rowIndex) {
            		   if(value == '' || value == null) 
            			   return '未执行';
            		   else if(value == '0')
            			   return '进行中';
            		   else if(value == '1')
            			   return '已完成';
            	   }
               },
               {field:'archivesClosed',width:'60px',title:'档案', align:'center', sortable:true, show:'false',
            	   formatter: function(value, rowData, rowIndex) {
            		   if(value == '' || value == null) 
            			   return '未执行';
            		   else if(value == '0')
            			   return '进行中';
            		   else if(value == '1')
            			   return '已完成';
            	   }
               },
               {field:'reworkClosed',width:'60px',title:'整改', align:'center', sortable:true, show:'false',
            	   formatter: function(value, rowData, rowIndex) {
            		   if(value == '' || value == null) 
            			   return '未执行';
            		   else if(value == '0')
            			   return '进行中';
            		   else if(value == '1')
            			   return '已完成';
            	   }
               }
        	]]
        }
    });	
    g1.batchSetBtn([
		{'index':1, 'display':false},
		{'index':2, 'display':false},
		{'index':3, 'display':true},
		{'index':4, 'display':false},
		{'index':5, 'display':false},
		{'index':6, 'display':false},
        {'index':7, 'display':false},
        {'index':8, 'display':false}
    ]);
    
    var currentYear = "${currentYear}";
    var offsetYear = 5;
    var yearArr = [];
    for(var i=currentYear-offsetYear; i<parseInt(currentYear)+offsetYear; i++){
        yearArr.push({
            'code':i,
            'name':i
        });
    }
    genSelectOption("query_year", yearArr, currentYear);
    
    var query_status = [{"code":"0","name":"计划草稿"},{"code":"1","name":"等待执行"},{"code":"2","name":"正在执行"},{"code":"3","name":"已完成"}];
    genSelectOption("query_status",query_status);
    
    genSelectOption("query_category", eval('${proCategoryArr}'));

    // 生成下拉选择
    function genSelectOption(selectObjId, arr, defaultVal){
        try{
            var selectObj = $('#'+selectObjId);
            if(selectObj && selectObj.length && arr && arr.length){
                selectObj.append("<option value=''></option>");
                for(var i=0; i<arr.length; i++){
                    var  ele = arr[i];
                    //alert(ele)
                    if(defaultVal != null && defaultVal == ele.code){
                        selectObj.append("<option value='"+ele.code+"' selected>"+ele.name+"</option>");
                    }else{
                        selectObj.append("<option value='"+ele.code+"'>"+ele.name+"</option>");
                    }
                    
                }
            }
        }catch(e){
            isdebug ? alert('genSelectOption:\n'+e.message) : null;
        }
    } 
});

	function edit(url) {
		aud$openNewTab('新增任务-编辑',url);
	}

	/* 项目阶段入口 */
	function openTarget(formId,status){
	    var udswin = window.open('${contextPath}/intctet/evaProject/evaPlan/projectIndexInter.action?crudId='
	        + formId + '&stage=' + status, '',
	        'height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no');
	    udswin.moveTo(0, 0);
	    udswin.resizeTo(window.screen.availWidth,window.screen.availHeight);
	}
</script>
</head>
<body>
    <div id="container" class='easyui-layout' fit='true'>	
        <div region="center">   	 	
            <table id='sDTable'></table>
        </div>
    </div>
    <!-- 自定义查询条件  -->
   <select id="query_year" name="query_year" style='width:130px; display:none;'></select>
   <select id="query_status" name="query_status" style="width:130px;display:none;"></select>
   <select id="query_tradePlate" name="query_tradePlate" style='width:130px; display:none;'></select>
   <select id="query_category" name="query_category" style="width:130px; display:none"></select>
   
   <div id='queryCond1'>
		<input type='text'  class="noborder editElement clear" readonly/>
		<input type='hidden' name='query_eq_acceptingUnit' class="noborder editElement clear" readonly/> 
		<a class="easyui-linkbutton  editElement" iconCls="icon-search"
			style='border-width:0px;'
			onclick="showSysTree(this,{
				title:'内控评价组织者',
				 param:{
				'rootParentId':'0',
				'beanName':'UOrganizationTree',
				'treeId':'fid',
				'treeText':'fname',
				'treeParentId':'fpid',
				'treeOrder':'fcode'
				 }
			})"></a>
   </div>
   
   <div id='queryCond2'>
		<input type='text'  class="noborder editElement clear" readonly/>
		<input type='hidden' name='query_eq_acceptingDep' class="noborder editElement clear" readonly/> 
		<a class="easyui-linkbutton  editElement" iconCls="icon-search"
			style='border-width:0px;'
			onclick="showSysTree(this,{
                title:'请选择财务负责人',
                type:'treeAndUser',
                checkbox:false,
				  param:{
				  'rootParentId':'0',
                  'beanName':'UOrganizationTree',
                  'treeId'  :'fid',
                  'treeText':'fname',
                  'treeParentId':'fpid',
                  'treeOrder':'fcode'
               }                                  
		})"></a>
   </div>
   
   <div id='queryCond3'>
 		<input type='text'  name='query_eq_collectStartTime' class="easyui-datebox noborder clear" editable="false"/>
   </div>
   
   <div id='queryCond4'>
 		<input type='text'  name='query_eq_collectEndTime' class="easyui-datebox noborder clear" editable="false"/>
   </div>
   <!-- ajax请求前后提示 -->
   <jsp:include flush="true" page="/pages/frReportFlow/ajaxloading.jsp" />
</body>
</html>
