<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE HTML >
<html>
<title>parseExcel</title>
<head> 
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">	
<script type="text/javascript" src="${contextPath}/easyui/boot.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/jquery-parseExcel.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
</head>
<body style='padding:0px;margin:0px;overflow:hidden;' class='easyui-layout' fit='true' border='0'>
<div region='center' border='0' style='padding:0px; margin:0px; overflow:hidden;'>	
	<table id='materialsPriceList'></table>
</div> 

<!-- 文件导入解析 -->
<div id="parseExcelContainer"></div>
<!-- 自定义查询条件 -->
<div id='queryCond1'>
	<input type='text'  name='query_mtq_surveyTime' class="easyui-datebox noborder clear" editable="false"/> 至 
	<input type='text'  name='query_ltq_surveyTime' class="easyui-datebox noborder clear" editable="false"/>
</div>
	
<script type="text/javascript">
$(function(){
    var g1 = new createQDatagrid({
        // 表格dom对象，必填
        gridObject:$('#materialsPriceList')[0],
        // 要进行检索的表对象(hibernate bean)名称， 进行拼接hql时使用; 必填
        boName:'MaterialsPrice',
        // 对象主键,删除数据时使用-默认为“id”；必填
        pkName:'mid',
        order :'desc',
        sort  :'createTime',
		winWidth:800,
	    winHeight:250,
	    myToolbar: ['export', 'reload'],
        // 表格控件dataGrid配置参数; 必填
        gridJson:{	
        	singleSelect:true,
        	checkOnSelect:false,
        	selectOnCheck:false,
            toolbar: ['query','-','delete','-',{   
	                text:'下载模板',
	                iconCls:'icon-download',
	                handler:function(){
	                	$('#parseExcelContainer').parseExcel('downloadTemplate');
	                }
	            },'-',{   
	                text:'导入文件',
	                iconCls:'icon-upload',
	                id:'mpImportExcelBtn'
	            },'-'
	        ],
	        frozenColumns:[[	        	
    			{field:'mid',  title:'选择',       width:'10px', checkbox:true,  align:'center', halign:'center', show:'false'},
                {field:'mname',title:'材料设备名称', width:'150px',align:'left',   halign:'center',  sortable:true, oper:'like'},
                {field:'mtype',title:'材料设备类型', width:'150px',align:'center', halign:'center',sortable:true, show:false},
                {field:'brand',title:'材料品牌',    width:'100px',align:'center', halign:'center',sortable:true, oper:'like'}
	        ]],
    		columns:[[
                {field:'modelNumber', title:'材料型号', width:'100px',align:'left', halign:'center',sortable:true, show:false},                
                {field:'standard',  title:'材料规格', width:'100px',align:'left',   halign:'center',sortable:true, show:false},
                {field:'property',  title:'材料材质', width:'100px',align:'left',   halign:'center',sortable:true, show:false},
                {field:'chargeUnit',title:'计价单位', width:'80px',align:'center',   halign:'center',sortable:true, show:false},
                {field:'unitPrice', title:'单价',    width:'100px',align:'right',   halign:'center',sortable:true, show:false},
                {field:'priceExplain',  title:'单价说明', width:'100px',align:'left',   halign:'center',sortable:true, show:false},
                {field:'supplier',      title:'供应商、代理商', width:'150px',align:'left',   halign:'center',sortable:true, oper:'like'},
                {field:'supplierPhone', title:'供应商代理电话', width:'150px',align:'left',   halign:'center',sortable:true, show:false},
                {field:'surveyTime',  title:'市调时间', width:'150px',align:'center',   halign:'center',sortable:true, type:'custom', target:$('#queryCond1')[0]},
                {field:'surveyPlace', title:'市调地点', width:'100px',align:'center',   halign:'center',sortable:true, show:false},
                {field:'priceSource', title:'材料价格来源', width:'100px',align:'left',   halign:'center',sortable:true, show:false},
                {field:'priceTime', title:'材料价格时间', width:'150px',align:'center',   halign:'center',sortable:true, show:false},
                {field:'remarks',   title:'备注', width:'100px',align:'left',   halign:'center',sortable:true, show:false},               
                {field:'creator',   title:'创建人',   width:'110px', align:'center',  sortable:true, show:false},
                {field:'createTimeFormat',title:'创建时间', width:'150px',align:'center', halign:'center',sortable:true, show:false},
                {field:'modifier',  title:'修改人',   width:'110px', align:'center',sortable:true, show:false},
                {field:'modifyTimeFormat',title:'修改时间', width:'150px',align:'center', halign:'center',sortable:true, show:false}
          ]]
        }
    });
    
    
    
    $('#parseExcelContainer').parseExcel({
		//是否在最外层显示窗口，默认为true 
		//topWin:false,
		triggerId:'mpImportExcelBtn',
		title:'导入材料价格',
		beanName:'MaterialsPrice',
		boPk:'mid',
        //弹出窗口：是否显示配置参数
        //showParam:true,
        //上传成功后，要刷新的datagrid id
        datagridId:'materialsPriceList',
        //下载模板的名字
        templateFileName:'cljgwhxzmb.xlsx', // modified by suuny 材料价格维护下载模板
        //下载模板的路径
        templateFilePath:'engineeringAudit&materialsPrice',
        //除了要导入的excel外，其它要提交的数据, json格式
        data:{
			//'parentCode':selectNodeCode,
			//'levelCode' :subLevelCode
        },
        // 导入前调用, 返回boolean，可以用来导入前校验
        onBeforeImport:function(target, options){
        	//alert('onBeforeImport')
        	return true;
        },
        // 导入后调用
        onAfterImport:function(target, options){
        	//alert('onAfterImport')
        },
        // 导入成功调用
        onSuccessImport:function(target, options){
        	//alert('onSuccessImport')
        },
        // 清空
        onClear:function(target, options){
        	//alert('onClear')
        },
        // 打开窗口时调用
        onOpen :function(target, options){
        	//alert('onOpen')
        },
        // 关闭时调用
        onClose:function(target, options){
        	//alert('onClose')
        },
        // 选择文件改变时调用
        onFileChange:function(target, options){
        	//alert('onFileChange\n'+target.outerHTML)
        }
	});
});

</script>
</html>