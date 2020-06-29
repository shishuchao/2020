<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML >
<html>
<title>内控-评价项目计划列表</title>
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
	var currentUser = "${currentUser}";
	var deptId = "${deptId}";
	var editUrl = '${contextPath}/intctet/evaProject/evaPlan/editEvaPlan.action';
	var tabTitle = isView ? "查看" : "编辑";
	var addBtn = {   
            text:'新增',
            iconCls:'icon-add',
            handler:function(){
            	aud$openNewTab('新增评价项目计划', editUrl, true);
            }
        };           	 
	var cusToolbar = [];	
	if(!isView){
		cusToolbar.push(addBtn);
		cusToolbar.push('-');
	}
	var gridTableId = "evaluationPlanList";
	var bodyW = $('body').width();
    var g1 = new createQDatagrid({
        // 表格dom对象，必填
        gridObject:$('#'+gridTableId)[0],
        // 要进行检索的表对象(hibernate bean)名称， 进行拼接hql时使用; 必填
        boName:'EvaluationPlan',
        // 对象主键,删除数据时使用-默认为“id”；必填
        pkName:'formId',
        order :'desc',
        sort  :'proCode',
        whereSql:isView ? "epStatus<>'0' and ((principalCode = '"+currentUser+"') or  creatorId = '"+currentUser+"'  or formId in (select projectFormId from InterMember where userId='"+currentUser+"') )":
            "evaOrganCode='"+deptId+"' or creatorId = '"+currentUser+"' ",
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
        	checkOnSelect:false,
        	selectOnCheck:false,
            toolbar:cusToolbar,
            onClickCell:function(rowIndex, field, value){
                if(field == 'epName'){		
                    var rows = $(this).datagrid('getRows');
                    var row = rows[rowIndex];
                    $(this).datagrid('unselectRow',rowIndex);
                    $(this).datagrid('uncheckRow',rowIndex);
                    var eview = row["epStatus"] >= 2 ? true : false;
                    aud$openNewTab("评价项目计划"+(eview ? "查看":"编辑"), editUrl+"?formId="+row['formId']+(eview ? "&view=true" : ""), true);
                }
            },	
            frozenColumns:[[           	
                {field:'formId', title:'选择', width:'10px', checkbox:!isView,  align:'center', halign:'center', show:'false', hidden:isView},
                {field:'proCode',title:'编号', width:bodyW*0.1+'px',align:'center',   halign:'center',  sortable:true, oper:'like'	},             
                {field:'epName', title:'项目名称', width:bodyW*0.2+'px',align:'left', halign:'center',  sortable:true, oper:'like',
                	formatter:formatterClick}
            ]],
    		columns:[[
                {field:'epYear',title:'计划年度', width:bodyW*0.1+'px',align:'center', halign:'center',  sortable:true, show:false},
                {field:'proCategory',  title:'项目类别', width:bodyW*0.1+'px',align:'center', halign:'center',  sortable:true, show:false},
                {field:'principal',title:'评价专岗负责人', width:bodyW*0.1+'px',align:'center', halign:'center',  sortable:true, show:false},
                {field:'evaOrgan', title:'内控评价组织者', width:bodyW*0.1+'px',align:'left',   halign:'center',  sortable:true, show:false},
	            {field:'operation',title:'当前阶段', width:bodyW*0.1+'px',align:'center',   halign:'center',  sortable:true, show:false,hidden:!isView,
                	formatter:function(value,row,rowindex){
                		var arr = [];
					    var formId = row.formId;
			    		if(row.prepareClosed == "0"){/* 准备阶段 */
							arr.push("<a href=\"javascript:void(0);\" style=\"font: bolder;\"onclick=\"openTarget('"+formId+"','prepare');\">准备</a>");
						}else if(row.actualizeClosed == "0"){/* 实施阶段 */
							arr.push("<a href=\"javascript:void(0);\" style=\"font: bolder;\" onclick=\"openTarget('"+formId+"','actualize');\">实施</a>");
							arr.push("<a href=\"javascript:void(0);\" style=\"font: bolder;\" onclick=\"openTarget('"+formId+"','report');\">报告</a>");
						}else if(row.reportClosed == "0"){/* 报告阶段 */
							arr.push("<a href=\"javascript:void(0);\" style=\"font: bolder;\" onclick=\"openTarget('"+formId+"','report');\">报告</a>");
						}else if(row.archivesClosed == "0"){/* 归档阶段 */
							arr.push("<a href=\"javascript:void(0);\" style=\"font: bolder;\" onclick=\"openTarget('"+formId+"','archives');\">归档</a>");
						}else if(row.reworkClosed == null || row.reworkClosed == "0"){/* 整改阶段 */
							arr.push("<a href=\"javascript:void(0);\" style=\"font: bolder;\" onclick=\"openTarget('"+formId+"','rework');\">整改</a>");
						}
			    		if(arr.length == 0
			    				&& row.prepareClosed == "1"
			    				&& row.actualizeClosed == "1"
			    				&& row.reportClosed == "1"
			    				&& row.archivesClosed == "1"
			    				&& row.reworkClosed == "1"){
			    			arr.push("<a href=\"javascript:void(0);\" style=\"font: bolder;\"onclick=\"openTarget('"+formId+"','prepare', true);\">项目查看</a>");
			    		}
			    		
						return arr.join(" | ");
					}
	            }
          ]]
        }
    });
    
    window.evaluationPlanList = g1;
    
    // 按钮权限
    isView ? $('.editElement').hide() : $('.viewElement').hide();
    // 删除按钮权限
    isView? g1.batchSetBtn([ {'id':gridTableId+'_remove','remove':true} ]) : null;
      
    function formatterClick(value, row){
    	 var title = row["epStatus"] >= 2 ? "查看" : "编辑";
    	return  ["<label title='单击"+title+"' style='cursor:pointer;color:blue;'>",value,"</label>"].join('') ;
    }

});
/* 项目阶段入口 */
function openTarget(formId,status, isEnd){
    var udswin = window.open(
        '${contextPath}/intctet/evaProject/evaPlan/projectIndexInter.action?isEnd='+isEnd+'&crudId='
        + formId + '&stage=' + status, '',
        'height='+window.screen.availHeight+'px, width='+window.screen.availWidth+'px, fullscreen=yes, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no');
    udswin.moveTo(0, 0);
    udswin.resizeTo(window.screen.availWidth,window.screen.availHeight);
}

function refresh() {
	$('#evaluationPlanList').datagrid('reload');
}
</script>
</head>
<body style='padding:0px;margin:0px;overflow:hidden;' >
	<table id='evaluationPlanList'></table>

	<!-- 引入公共文件 -->
   <jsp:include flush="true" page="/pages/frReportFlow/ajaxloading.jsp" />
</body>
</html>