<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<jsp:directive.page import="ais.framework.util.UUID"/>

<html>
<title>公文查询</title>
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
var colorArray = [{"value":"#00FF00","text":"绿色"},{"value":"#FFFF00","text":"黄色"},{"value":"#FF0000","text":"红色"},{"value":"#FFFFFF","text":"白色"}];
$(function(){
	var rrs_id = '${rrs_id}';
	var bodyW = $('body').width();    
    var bodyH = $('body').height();   
 
    frloadOpen();
    var g1 = new createQDatagrid({
        // 表格dom对象，必填
        gridObject:$('#sDTable')[0],
        // 要进行检索的表对象(hibernate bean)名称， 进行拼接hql时使用; 必填
        boName:'RiskGrade',
        // 对象主键,删除数据时使用-默认为“id”；必填
        pkName:'id',
        whereSql: 'rrs_id=\'' + rrs_id + '\'',
        order:'asc',
        sort:'startValue',
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
            			rlName: '',
            			startValue: '',
            			endValue: '',
            			color: '',
            			backup: ''
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
                    	url:'${contextPath}/riskManagement/knowledgeBase/riskRating/saveRiskGrade.action',
                    	async:false,
                    	type:'POST',
                    	data:{'rowstr':rowstr,'rrs_id':rrs_id},
                    	success:function(data) {
                    		if(data == '1') {
                    			window.location.reload();
                    			showMessage1('保存成功！');
                    		}else if(data == '0') {
                    			showMessage1('起始分值和结束分值必须为数字！');
                    		}
                    	}
                    });
                }  
            }] ,
            columns:[[
               {field:'id', title:'选择', checkbox:true, align:'center', show:'false'},      
               {field:'sn',title:'编号', width:bodyW*0.12 + 'px',align:'center', sortable:true, show:'true', oper:'eq',
            	   editor: {//设置其为可编辑
            		   type: 'text',//设置编辑样式 自带样式有：text，textarea，checkbox，numberbox，validatebox，datebox，combobox，combotree 可自行扩展
            		   options: { required: true}
            	   }
               },
               {field:'rlName',title:'风险等级名称', width:bodyW*0.12 + 'px',align:'center', sortable:true, type:'custom', target:$('#query_sdYear')[0],
            	   editor: {//设置其为可编辑
            		   type: 'text',
            		   options:{ required : true}
            	   }
               },
               {field:'startValue',title:'起始分值', width:bodyW*0.16 + 'px',align:'center', sortable:true, show:'true', oper:'like',
            	   editor: {//设置其为可编辑
            		   type: 'text'
            	   }
               },
               {field:'endValue',title:'终止分值', width:bodyW*0.16 + 'px',align:'center', sortable:true, show:'true', oper:'like',
            	   editor: {//设置其为可编辑
            		   type: 'text'
            	   }
               },
               {field:'color',width:bodyW*0.16 + 'px',title:'颜色', align:'center', sortable:true, type:'custom', target:$('#query_tradePlate')[0],
            	   editor: {//设置其为可编辑
            		   type: 'combobox',
            		   options:  { data: colorArray, valueField: "value", textField: "text"}
            		   },
            	   formatter:function(value, rowData, rowIndex) {
            		   var color = "";
            		   for(i in colorArray) {
            			   if(colorArray[i].value == value) {
            				   color = colorArray[i].text;
            				   break;
            			   }
            		   }
            		   	return color;
            	   }
               },
               {field:'backup',width:bodyW*0.16 + 'px',title:'备注', align:'center', sortable:true, show:'true', oper:'eq',
            	   editor: {//设置其为可编辑
            		   type: 'text'
            		   }
               }
        	]],
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
}); 
</script>

<style type="text/css">
			#MatrixTable {
				border-collapse:collapse;
				border:solid black; 
				border-width:0 0 0 1px;
				width: 700px;
			}
			#MatrixTable td {border:solid black;border-width:0 1px 1px 0;padding:2px;text-align: center;}
			#MatrixTable .xType{
				background-color: #F2DDDC;
				font-weight: bold;
				border-width:1px 1px 1px 0;
				height: 50;
				cursor: pointer;
			}
			#MatrixTable .yType{
				background-color: #FEFE9A;
				font-weight: bold;
				border-width:1px 1px 1px 0;
				height: 50;
				cursor: pointer;
			}
			#MatrixTable .autoValue{
				cursor: pointer;
				border-width:1px 1px 1px 1px;
			}
		</style>
</head>
<body>
    <div id="container" class='easyui-layout' fit='true'>
    	<div region="center" id="createtable" align="center">
    		<br>
    		<table id="matrixTable">
					<tr>
						<td style="border-width:1 1 1 0;text-align: center;font-size: 16px;font: bolder;">风险等级矩阵</td>
						<s:iterator value="idList">
							<td class="xType"><s:property value="name"></s:property></td>
						</s:iterator>
					</tr>
					
					<s:iterator value="psList" status="knxStatus">
						<tr>
							<td class="yType" title="${psList[knxStatus.index].code}"><s:property value="name" /></td>
							<s:iterator value="idList" status="yxdjStatus">
								<s:iterator value="riskGrades" status="fxdjStatus">
								<s:if
									test="psList[#knxStatus.index].code*idList[#yxdjStatus.index].code>riskGrades[#fxdjStatus.index].startValue&&psList[#knxStatus.index].code*idList[#yxdjStatus.index].code<=riskGrades[#fxdjStatus.index].endValue">
									<td class="autoValue"
										bgcolor="${riskGrades[fxdjStatus.index].color}">${riskGrades[fxdjStatus.index].rlName}</td>
								</s:if>
							</s:iterator>
							</s:iterator>
						</tr>
					</s:iterator>
			</table>
			<br>
			<div style="height: 400px">
				<table id='sDTable'></table>
			</div>
    	</div>
    </div> 
   <jsp:include flush="true" page="/pages/frReportFlow/ajaxloading.jsp" />
</body>
</html>
