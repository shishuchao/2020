<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<jsp:directive.page import="ais.framework.util.UUID"/>

<html>
<title>可能性标准</title>
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

$(function(){
	var rrs_id = '${rrs_id}';
	var bodyW = $('body').width();    
    var bodyH = $('body').height(); 
    
    var probabilityScaleList = eval('${probabilityScaleList}');
    var frozenColumnFix = [{field:'id', title:'选择', checkbox:true, align:'center', show:'false'},      
                           {field:'sn',title:'编号', width:bodyW*0.1 + 'px',align:'center', sortable:true, show:'true', oper:'eq',
   	   editor: {//设置其为可编辑
   		   type: 'text',//设置编辑样式 自带样式有：text，textarea，checkbox，numberbox，validatebox，datebox，combobox，combotree 可自行扩展
   		   options: { required: true}
   	   }
      },
      {field:'pType',title:'可能性种类', width:bodyW*0.14 + 'px',align:'center', sortable:true, type:'custom', target:$('#query_sdYear')[0],
   	   editor: {//设置其为可编辑
   		   type: 'textarea',
   		   options:{ required : true }
   	   }
      }];
    var columnFix = [];
    for(i in probabilityScaleList) {
    	var column = {field:'probability' + i,title:probabilityScaleList[i].name, width:bodyW*0.14 + 'px',align:'center', sortable:true,
           	   editor: {//设置其为可编辑
          		   type: 'textarea',
          		   options:{ required : true }
          	   }
             };
    	columnFix.push(column);
    }
 
    frloadOpen();
    var g1 = new createQDatagrid({
        // 表格dom对象，必填
        gridObject:$('#sDTable')[0],
        // 要进行检索的表对象(hibernate bean)名称， 进行拼接hql时使用; 必填
        boName:'ProbabilitySD',
        // 对象主键,删除数据时使用-默认为“id”；必填
        pkName:'id',
        whereSql: 'rrs_id=\''+ rrs_id +'\'',
        order:'asc',
        sort:'sn',
        gridJson:{    
            checkOnSelect:false,
            selectOnCheck:false,
            singleSelect:false,
            onLoadSuccess:frloadClose,
            toolbar:[{
            	text:'新增',
            	iconCls:'icon-add',
            	handler:function () {
            		var uuid;
            		$.ajax({
            			url:'${contextPath}/riskManagement/management/riskHandle/getUuid.action',
            			type:'POST',
            			async:false,
            			success:function(data) {
            				uuid = data;
            			}
            		});
            		$("#sDTable").datagrid('insertRow', {//在指定行添加数据，appendRow是在最后一行添加数据
            			index: 0, // 行数从0开始计算
            			row: {
            			id: uuid,
            			sn: '',
            			pType: ''
            			}
            			});
            	}
            }, '-', {  
                text: '保存', iconCls: 'icon-save', handler: function () {  
                    $("#sDTable").datagrid('endEdit', editFlag);  
       
                    //使用JSON序列化datarow对象，发送到后台。  
                    var rows = $("#sDTable").datagrid('getChanges');
       
                    var rowstr = JSON.stringify(rows);  
                    $.ajax({
                    	url:'${contextPath}/riskManagement/knowledgeBase/riskRating/saveProbabilitySD.action',
                    	async:false,
                    	type:'POST',
                    	data:{'rowstr':rowstr,'rrs_id':rrs_id},
                    	success:function(data) {
                    		if(data == '1') {
                    			showMessage1('保存成功！');
                    		}
                    	}
                    });
                }  
            }] ,
            frozenColumns:[frozenColumnFix],
            columns:[columnFix],
        	onAfterEdit: function (rowIndex, rowData, changes) {//在添加完毕endEdit，保存时触发
        		editFlag = undefined;//重置
        	}, 
        	onDblClickCell: function (rowIndex, field, value) {//双击该行修改内容
            	if (editFlag != undefined) {
            		$("#sDTable").datagrid('endEdit', editFlag);//结束编辑，传入之前编辑的行
            	}
            	if (editFlag == undefined) {
            		$("#sDTable").datagrid('beginEdit', rowIndex);//开启编辑并传入要编辑的行
            		editFlag = rowIndex;
            	}
            },
        }
    });	
    g1.batchSetBtn([
		{'index':1, 'display':true},
		{'index':2, 'display':true},
		{'index':3, 'display':true},
		{'index':4, 'display':false},
		{'index':5, 'display':false},
		{'index':6, 'display':false},
        {'index':7, 'display':false},
        {'index':8, 'display':false}
    ]);
    
  //单元格tooltip提示
	$('#sDTable').datagrid('doCellTip', {
		position : 'bottom',
		maxWidth : '200px',
		tipStyler : {
			'backgroundColor' : '#EFF5FF',
			borderColor : '#95B8E7',
			boxShadow : '1px 1px 3px #292929'
		}
	});
});

</script>
</head>
<body>
    <div id="container" class='easyui-layout' fit='true'>	
        <div region="center">   	 	
            <table id='sDTable'></table>
        </div>
    </div> 
   <!-- ajax请求前后提示 -->
   <jsp:include flush="true" page="/pages/frReportFlow/ajaxloading.jsp" />
</body>
</html>
