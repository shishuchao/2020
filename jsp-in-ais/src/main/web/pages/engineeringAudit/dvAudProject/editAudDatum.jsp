<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE HTML >
<html>
<title>送审项目资料清单</title>
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
	var isView = "${view}" == "true" || "${view}" == true ? true : false;
	var curDate = "${curDate}";
	isView ?  $('.editElement').hide() : $('.viewElement').hide();
	autoTextarea(isView ?  $('#ar_remarks')[0] : $('#ar_remarks')[0]);
	var parentTabId = '${parentTabId}';
	//获取操作权限
	var operation="${operation}";
	var curTabId = aud$getActiveTabId();	
	var apStatusCode= "${param.apStatusCode}";
	isView = apStatusCode > 2 ? true : isView;
	
	var addMarkBtn = {   
            text:'添加',
            iconCls:'icon-add',
            handler:function(){
            	$('#remarksWin').dialog('open');	                	
            }
	};
	var cusToolbar = isView ? [] : [addMarkBtn,'-'];

	//备注表格
	var g1 = new createQDatagrid({
	        // 表格dom对象，必填
	        gridObject:$('#remarksList')[0],
	        // 要进行检索的表对象(hibernate bean)名称， 进行拼接hql时使用; 必填
	        boName:'AudRemarks',
	        // 对象主键,删除数据时使用-默认为“id”；必填
	        pkName:'arId',
	        whereSql:'apId=\'${param.apId}\'',
			winWidth:780,
		    winHeight:330,
		    //自定义显示哪些按钮：myToolbar:['delete', 'export', 'search', 'reload'],
		    myToolbar:isView ? ['export',  'reload'] : ['delete', 'export', 'reload'],
	        // 表格控件dataGrid配置参数; 必填
	        gridJson:{	
	        	singleSelect:true,
	        	checkOnSelect:false,
	        	selectOnCheck:false,
	        	fit: true,
	        	toolbar:cusToolbar,
	            onClickCell:function(rowIndex, field, value){
	                if(field == 'remarks'){		
	                    var rows = $(this).datagrid('getRows');
	                    var row = rows[rowIndex];
	                    $(this).datagrid('unselectRow',rowIndex);
	                    $(this).datagrid('uncheckRow',rowIndex);
	                    if(!isView){                    	
	                    	aud$editRow(row, 'remarksForm', 'remarksWin', 'ar');
	                    }else{
	                    	$('.editElement').hide();
	                    	aud$viewRow(row, 'remarksForm', 'remarksWin', 'view');
	                    }
	                }
	            },
	         // 删除前的校验，如果返回true可以删除，否则为false
	        	beforeRemoveRowsFn:function(rows, datagridObj){
	        		if(rows){			
	        			for(var i=0; i<rows.length; i++){
	        				var row = rows[i];
	        				var creator=row.creator;
	        				if("${loginName}"==creator){
	        					return true;
	        				}else{
	        					showMessage1("只能删除当前用户增加的备注");
	        					return false;
	        				}
	        			}
	        		}
	        		return true;
	        	},
	    		columns:[[
	                {field:'arId',  title:'选择', checkbox:true,  align:'center', halign:'center', show:'false', hidden:isView},
	                {field:'remarks',title:'备注',    width:'70%',align:'left', halign:'center',sortable:true, oper:'like',
	                	formatter:formatterClick},
	                {field:'creator',title:'备注人', width:'80px',align:'center', halign:'center',sortable:true, show:false},
	                {field:'createTime',title:'备注时间', width:'120px',align:'center',   halign:'center',  sortable:true, oper:'like',
	                	formatter:formatterTime2Date}                             
	          ]]
	        }
    });
	$('#remarksWin').show();
	// 新增备注窗口
    $('#remarksWin').dialog({
        title:'新增备注',
        closed:true,
        collapsible:true,
        modal:true,
        fit:true,
		onOpen:function(){
			audEvd$resizeWin('remarksWin');
			audEvd$clearform('remarksForm');
		},
		buttons:isView ? [{
                text:'关闭',
                iconCls:'icon-cancel',
                handler:function(){
                    $('#remarksWin').dialog('close');
                }
            }   	
        ] : [{
             text:'保存',
             id:'arSaveBtn',
             iconCls:'icon-save',
             handler:function(){
            	 aud$saveForm('remarksForm', "${contextPath}/ea/dvAudProject/saveRemarks.action?apId=${param.apId}", function(data){
            		 if(data){
            			 data.type == 'info' ? (g1.refresh(),$('#remarksWin').dialog('close')) : null;
            			 data.msg ? showMessage1(data.msg) : null;
            		 }
            	 });
             }
         },{
             text:'清空',
             id:'arClearBtn',
             iconCls:'icon-empty',
             handler:function(){
            	 audEvd$clearform('remarksForm');
             }
         },{
             text:'关闭',
             iconCls:'icon-cancel',
             handler:function(){
                 $('#remarksWin').dialog('close');
             }
         }]
    });
	function formatterClick(value){
    	return  ["<label title='单击编辑或查看' style='cursor:pointer;color:blue;'>",value,"</label>"].join('') ;
    }
	//格式化日期
	function formatterTime2Date(value){
    	var rt = value;
    	if(value && value.length > 10){
    		rt = value.substr(0,10);
    	}	
    	return rt;
    }
    
    // 按钮权限
    if(isView){ 	
    	 $('.editElement').hide();
    }else{
	    $('.viewElement').hide();
    }

    //生成上传附件按钮
	for(var i=1;i<="${size}";i++) {
		$('#attachFile_'+i).fileUpload({
	    	fileGuid:$("#adId_"+i).val(),
	    	triggerId:"fileBtn_"+i,
	    	isDel:apStatusCode==1?true:false,
	    	isEdit:apStatusCode==1?true:false,
	    	isAdd:false,
	    	uploadFace:1,
	    	echoType:2,
	    	onFileSubmitSuccess:function(data){
	    		
	    	}
		});	
	}
    
	if(!(operation =="true" && apStatusCode ==1) || isView){
		$('.operView').remove();
	}
	
});	
</script>
</head>
<body style='padding:0px;margin:0px;overflow:hidden;'  border='0' fit='true' class='easyui-layout' >
	<div region='center'  style='padding:0px;margin:0px;overflow-x:hidden;' title='送审资料列表' border="0">
		<form id="AudDatumForm" name="AudDatumForm" style="border-width:0px;">
			<table  class="table table-striped"id="mTable" style="width:100%;border-collapse:collapse;border-width:0px;" >					
				<thead>					
				    <tr>
				      <th class="EditHead" style="width:5%;text-align:center;border-width:0px 1px 1px 0px;">序号</th>
				      <th class="EditHead" style="width:25%;text-align:center;border-width:0px 1px 1px 0px;">资料名称</th>
				      <th class="EditHead" style="width:60%;text-align:center;border-width:0px 1px 1px 0px;">附件名称</th>
				      <th class="EditHead editElement operView" style="width:8%;text-align:center;border-width:0px 0px 1px 0px;">操作</th>
				    </tr>
	  			</thead>
	  			<tbody>
	  				<c:forEach items="${resultList}" var="adList" varStatus="num">
		  				<input type='hidden' id="ad_adId" name="ad.adId" value="${ad.adId}" class="noborder editElement clear" />
						<input type='hidden' id='ad_attachmentId' name='ad.attachmentId' value="${ad.attachmentId}"
						class="noborder editElement" style='width:500px;'/> 
	  					<tr>
	  						<td class="editTd" style='text-align:center;border-width:0px 1px 1px 0px;'>${num.count}</td>
	  						<td class="editTd" style="border-width:0px 1px 1px 0px;">
		  						<span>${adList.materialsName}</span>
		  						<input id="adId_${num.count}" type="hidden" value="${adList.adId}"/>  						
	  						</td>
	  						<td class="editTd" style="border-width:0px 1px 1px 0px;">
	  							<div id="attachFile_${num.count}"></div>
	  						</td>
		  					<td class="editTd editElement operView" style="border-width:0px 0px 1px 0px;">
								<a  id="fileBtn_${num.count}"></a>
		  					</td>
	  					</tr>	
	  				</c:forEach>
	  			</tbody>
			</table>		
		</form>
	</div>
	<div id="remarks" style="height:250px;overflow:hidden;" region='south' title='备注信息'>		
		<table id='remarksList'></table>
	</div>
	<div id='remarksWin' name='remarksWin' style='display:none;'>
		<div class='easyui-layout' border='0' fit='true'>			
			<div region='center' border='0'>
				<form  id='remarksForm' name='remarksForm' method="POST" >
					<input type='hidden' id="ar_arId" name="ar.arId"  value="${ar.arId}" class="noborder editElement clear"/>
					<input type='hidden' id="ar_apId" name="ar.apId" value="${ar.apId}" class="noborder editElement clear"/>
					<table class="ListTable" align="center" style='table-layout:fixed;'>
						<tr>
							<td class="EditHead" style="width:15%;text-align:left"><font color='red'>*</font>备注</td>
						</tr>
						<tr>
							<td class="editTd" style="width:35%;">
								<textarea title='备注' id='ar_remarks' name='ar.remarks' 
								class="noborder editElement clear required" 
								style='border-width:0px;height:150px;width:99%;overflow:hidden;padding:5px;'>${ar.remarks}</textarea>
								<span id='view_remarks' class="noborder viewElement clear " style='width:100%; height:150px;overflow:auto;;display:inline;'>${ar.remarks}</span>
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