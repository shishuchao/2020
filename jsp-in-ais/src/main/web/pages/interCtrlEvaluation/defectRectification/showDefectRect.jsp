<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE HTML >
<html>
<title>整改文书及缺陷(项目内整改)列表</title>
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
	var isView = "${view}" == 'true' ? true : false;
	var formId="${param.formId}";
	var parentTabId = '${parentTabId}';
	var curTabId = aud$getActiveTabId();
	var editUrl = '${contextPath}/intctet/defectRectification/editDefectRect.action';
	var tabTitle = isView ? "查看" : "处理";	
	var gridTableId = "defectRectList";
	// 显示工程项目表单
    var g1 = new createQDatagrid({
        // 表格dom对象，必填
        gridObject:$('#'+gridTableId)[0],
        // 要进行检索的表对象(hibernate bean)名称， 进行拼接hql时使用; 必填
        boName:'InterCtrlProblem',
        // 对象主键,删除数据时使用-默认为“id”；必填
        pkName:'id',       
        order :'desc',
        sort  :'defectCode',
        whereSql:'proId=\'${param.formId}\'',
		winWidth:800,
	    winHeight:250,
        // 表格控件dataGrid配置参数; 必填
        gridJson:{
			border:'0',
			fit:true,
            onClickCell:function(rowIndex, field, value){
            	if(field == 'manuscriptIndex'){		
            		var rows = $(this).datagrid('getRows');
                    var row = rows[rowIndex];
                    $(this).datagrid('unselectRow',rowIndex);
                    $(this).datagrid('uncheckRow',rowIndex);
                    var manuEditUrl = "${contextPath}/intctet/evaluationActualize/editManu.action?view=true&manuId="+row['manuId'];
                    aud$openNewTab("底稿查看", manuEditUrl, true)
                }
            },
            frozenColumns:[[ {field:'id', show:false,'show':false, hidden:true},
                             {field:'defectCode',title:'内控缺陷编号', width:'120px',align:'center', halign:'center',sortable:true, oper:'like'},
                             {field:'defectName',title:'内控缺陷名称', width:'120px',align:'center',   halign:'center',  sortable:true, oper:'like'	},                                
                             {field:'manuscriptIndex', title:'底稿索引', width:'180px',align:'center', halign:'center',sortable:true, show:false,
                             	formatter:formatterClick},                
                             {field:'controlName',  title:'所属控制点', width:'150px',align:'center',   halign:'center',sortable:true, show:false},
                             {field:'circuitName',  title:'所属主流程', width:'150px',align:'center',   halign:'center',sortable:true, show:false}]],
    		columns:[[
                {field:'accountabilityUnit',title:'被评价单位', width:'150px',align:'center',   halign:'center',sortable:true, show:false},
                {field:'defectTypeName', title:'缺陷类型',    width:'150px',align:'center',   halign:'center',sortable:true, show:false},
                {field:'relateLoss',  title:'涉及到损失/错报的金额', width:'200px',align:'center',   halign:'right',sortable:true, show:false},
                {field:'initialIdentify',title:'认定结果', width:'150px',align:'center',   halign:'center',sortable:true, show:false},
                {field:'mendAdvice', title:'整改建议', width:'150px',align:'center', halign:'center',sortable:true, show:false},                
                {field:'mendDeadline',  title:'整改期限', width:'150px',align:'center',   halign:'center',sortable:true, show:false},
                {field:'mendMeasureDescription',  title:'整改措施', width:'150px',align:'center',   halign:'center',sortable:true, show:false},
                {field:'mendProgress',title:'整改进度', width:'150px',align:'center',   halign:'center',sortable:true, show:false},
                {field:'lastFeedbackTime', title:'最近反馈时间',    width:'150px',align:'center',   halign:'center',sortable:true, show:false},
                {field:'xxx',
					 title:'操作',
					 halign:'center',
					 width:'80px',
					 align:'center', 
					 sortable:false,
					 show:false,
					 'show':false,
					 formatter:function(value,row,index){
						 var btn2 = '';
						 if('${view}' == 'true') {
							btn2 ='&nbsp;<a href="javascript:void(0)" style="color:blue" onclick="view(\''+row.id+'\',\''+row.proId+'\',\''+row.manuId+'\')">查看</a>';
						 	parent.$('#flowBtns').hide();
						 }else {
							  
							 if(row.lastFeedbackId == '' || row.lastFeedbackId == null){
								 btn2 ='&nbsp;<a href="javascript:void(0)" style="color:blue" onclick="view(\''+row.id+'\',\''+row.proId+'\',\''+row.manuId+'\')">查看</a>';
								 parent.$('#flowBtns').hide();
							 }else{
							 	btn2 ='&nbsp;<a href="javascript:void(0)" style="color:blue" onclick="operation(\''+row.id+'\',\''+row.proId+'\',\''+row.manuId+'\')">处理</a>';
							 	parent.$('#flowBtns').show();
							 }
						 }
						 return btn2;
					 }
				}
          ]]
        }
    });
    window.defectRectList = g1;

    // 按钮权限
    isView ? $('.editElement').hide() : $('.viewElement').hide();
    // 删除按钮权限
    g1.batchSetBtn([ {'id':gridTableId+'_remove','remove':true} ]);
    //导出按钮权限
    g1.batchSetBtn([ {'id':gridTableId+'_export','remove':true} ]);
    // 查询按钮权限
    g1.batchSetBtn([ {'id':gridTableId+'_search','remove':true} ]);
    //刷新按钮权限
    g1.batchSetBtn([ {'id':gridTableId+'_reload','remove':true} ]);
    
    $('#defectRectList').datagrid('doCellTip', {
		position : 'bottom',
		maxWidth : '200px',
		tipStyler : {
			'backgroundColor' : '#EFF5FF',
			borderColor : '#95B8E7',
			boxShadow : '1px 1px 3px #292929'
		}
	});
    
    
    
    function formatterClick(value){
    	return  ["<label title='单击编辑或查看' style='cursor:pointer;color:blue;'>",value,"</label>"].join('') ;
    }
    /* 工作方案模板文件 */
    var size="${size}";
	var templateId=$("#templateId").val();
	var fileGuid =templateId;
	$('#templateFile').fileUpload({
    	fileGuid:fileGuid,
    	isAdd:false,
    	uploadFace:1,
    	echoType:2,    	
	});
	/* 上传附件 */
	//生成上传附件按钮
   	var size = "${size}";
	for(var i=1;i<=size;i++) {
		var fileListDiv = "attachFile_"+i;
		var uploadBtnDiv = "fileBtn_"+i;
		var fileId="projectDtailId_"+i;
		var fileGuid =$("#"+fileId).val();
		$('#'+fileListDiv).fileUpload({
	    	fileGuid:fileGuid,
	    	<s:if test="view != 'true'">
	    		triggerId:uploadBtnDiv,
	    		isAdd:false,
	    	</s:if>
			<s:else>
				triggerId:false,
				isAdd:false,
				isEdit:false,
				isDel:false,
			</s:else>
	    	uploadFace:1,
	    	echoType:2,
	    	onFileSubmitSuccess:function(data){
	    		/* 保存uploadFileId */
	    		var fileId=data.fileId;
	    		$.ajax({
	    			url:"${contextPath}/intctet/defectRectification/saveFileId.action",
	    			dataType:"json",
	    			type:"post",
	    			data:{
	    				fileId:fileId
	    			},
	    		}) 
	    	}
		});	
	}
	
	
});
/* 处理 */
function operation(id,proId,manuId){
	var directionUrl="${contextPath}/intctet/defectRectification/initDefectEvaPage.action";
	aud$openNewTab("整改检查评价", directionUrl+"?manuId="+manuId+"&id="+id+"&proId="+proId, false);
}

function view(id,proId,manuId) {
	var directionUrl="${contextPath}/intctet/defectRectification/initDefectEvaPage.action";
	aud$openNewTab("整改检查评价", directionUrl+"?manuId="+manuId+"&id="+id+"&proId="+proId+"&view=true",false);
}

function setIframeHeight(id){
    try{
        var iframe = document.getElementById(id);
        var fla = false ;
        if(iframe.attachEvent){
            iframe.attachEvent("onload", function(){
            	fla = true;
                iframe.height =  iframe.contentWindow.document.documentElement.scrollHeight +  300;
            });
            //IE8
            if(!fla && iframe ){
               var iframeWin = iframe.contentWindow || iframe.contentDocument.parentWindow; 
                 if (iframeWin.document.body) {
                    iframe.height = (iframeWin.document.documentElement.scrollHeight || iframeWin.document.body.scrollHeight) + 300 ;
                   }
            }
            return;
        }else{
            iframe.onload = function(){
               iframe.height = iframe.contentDocument.body.scrollHeight +  300;
            };
            return;                 
        }     
    }catch(e){
        throw new Error('setIframeHeight Error');
    }
	} 
</script>
</head>
<body style='padding:0px;margin:0px;overflow:hidden' class='easyui-layout' fit="true" border="0">
	<div region='center'  style='padding:0px;margin:0px;overflow:hidden;' title='整改文书' border="0" split="true">
		<table  class="table table-striped"id="mTable" style="width:100%;border-collapse:collapse;" >					
			<thead>					
			    <tr>
			      <th class="EditHead" style="width:100px;text-align:center;border-top-width:0px;">阶段</th>
			      <th class="EditHead" style="width:120px;text-align:center;border-top-width:0px;">节点</th>
			      <th class="EditHead" style="width:80px;text-align:center;border-top-width:0px;">是否必做</th>
			      <th class="EditHead" style="width:25%;text-align:center;border-top-width:0px;">对应模板</th>
			      <th class="EditHead" style="width:25%;text-align:center;border-top-width:0px;">上传附件</th>
			       <th class="EditHead" style="width:80px;text-align:center;border-top-width:0px;">操作</th>
			    </tr>
  			</thead>
  			<tbody>
  				<c:forEach items="${resultList}" var="wp" varStatus="num">
  					<tr>
  						<td class="editTd" style="text-align:center" >整改跟踪</td>
  						<td class="editTd" style="text-align:left">${wp.workprogramdetailname}</td>
  						<td class="editTd" style="text-align:center">${wp.needdo}	</td>
	  					<td class="editTd" style="text-align:center"><div id="templateFile"></div>
	  						<input type="hidden" id="templateId" value="${wp.templateid}"/>
	  					</td>
	  					<td class="editTd" style="text-align:center">
	  						<div id="attachFile_${num.count}"></div>
	  						<input type="hidden" id="projectDtailId_${num.count}" value="${wp.projdetailid }"/>
	  					</td>
	  					<td class="editTd" style="text-align:center"><a  id="fileBtn_${num.count}"></a></td>
  					</tr>	
  				</c:forEach>
  			</tbody>
		</table>
	</div>	
	<div region='south' style='padding:0px;overflow:hidden;height:60%;' title="整改缺陷列表" border="0" split="true">	
		<table id='defectRectList'></table>
	</div>	
	<!-- 引入公共文件 -->
   <jsp:include flush="true" page="/pages/frReportFlow/ajaxloading.jsp" />   
</body>
</html>