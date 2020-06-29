<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML >
<html>
<title>中介机构</title>
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
	//是否从项目送审窗口打开
	var winSelect = "${winSelect}";
	var editUrl = '${contextPath}/ea/agency/editAgency.action';
	var tabTitle = winSelect || isView ? "查看" : "编辑";
	var fdepid = "${user.fdepid}";
	function getParentWin(){
		var frameWin = aud$parentDialogWin();
		return frameWin.$('#dvAudProject').get(0).contentWindow;
	}
	
	
	
	var addBtn = {   
            text:'添加',
            iconCls:'icon-add',
            handler:function(){
            	aud$openNewTab('中介机构添加', editUrl + "?winSelect=${winSelect}", true);
            }
        };
	var selectBtn = {   
            text:'选择',
            iconCls:'icon-ok',
            handler:function(){
            	var gridObj = $('#agencyList');
            	var rows = gridObj.datagrid('getChecked');
            	if(rows != null && rows.length > 0){
            		var agencyIds = []; 
            		var agencyNames = [];
            		for(var i=0; i<rows.length; i++){
            			var row = rows[i];
            			agencyIds.push(row['agencyId']);
            			agencyNames.push(row['agencyName']);
            		}            		
            		var parentWin = getParentWin();
            		parentWin.$('#ap_agencyId').val('');
            		agencyIds.length ? parentWin.$('#ap_agencyIds').val(agencyIds.join(',')) : null;
            		agencyIds.length ? parentWin.$('#ap_agencyId').val(agencyIds.join(',')) : null;  
            		agencyNames.length ? parentWin.$('#ap_agencyNames').val(agencyNames.join(',')) : null;
            		parentWin.$('#ap_agMemberIds').val('');
            		parentWin.$('#ap_agMemberNames').val('');
            		aud$closeTopDialog();
            	}else{
            		showMessage1('请选择记录');
            	}
            }
		};
	var emptyBtn = {   
            text:'清空',
            iconCls:'icon-empty',
            handler:function(){
            	var parentWin = getParentWin();
            	parentWin.$('#ap_agencyIds').val('');
            	parentWin.$('#ap_agencyId').val('');
            	parentWin.$('#ap_agencyNames').val('');
            	parentWin.$('#ap_agMemberNames').val('');
        		aud$closeTopDialog();
            }
        };
	var closeSelectWinBtn = {   
            text:'关闭',
            iconCls:'icon-cancel',
            handler:function(){
            	aud$closeTopDialog();
            }
        };
            	 
	var cusToolbar = [];
	if(winSelect){
		cusToolbar.push(selectBtn);
		cusToolbar.push('-');
		cusToolbar.push(emptyBtn);
		cusToolbar.push('-');
		cusToolbar.push(closeSelectWinBtn);
		cusToolbar.push('-');
	}else if(!isView){
		cusToolbar.push(addBtn);
		cusToolbar.push('-');
	}
	var gridTableId = "agencyList";
    var g1 = new createQDatagrid({
        // 表格dom对象，必填
        gridObject:$('#agencyList')[0],
        // 要进行检索的表对象(hibernate bean)名称， 进行拼接hql时使用; 必填
        boName:'Agency',
        // 对象主键,删除数据时使用-默认为“id”；必填
        pkName:'agencyId',
		winWidth:800,
	    winHeight:250,
        whereSql: winSelect?'deptId=\''+ fdepid +'\'':fdepid=='1'?'1=1':'(select fpid from UOrganization where fid=\''+fdepid+'\')==1'?'deptId in (select fid from UOrganization where fpid=\''+fdepid+'\') or deptId=\''+fdepid+'\'':
            'deptId in (select fid from UOrganization where fpid=(select fpid from UOrganization where fid=\''+fdepid+'\')) or deptId=(select fpid from UOrganization where fid=\''+fdepid+'\')',
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
        	singleSelect:false,
            checkOnSelect:winSelect ? true : false,
            selectOnCheck:winSelect ? true : false,
        	toolbar:cusToolbar,
            onClickCell:function(rowIndex, field, value){
                if(field == 'agencyName'){		
                    var rows = $(this).datagrid('getRows');
                    var row = rows[rowIndex];
                    $(this).datagrid('unselectRow',rowIndex);
                    $(this).datagrid('uncheckRow',rowIndex);
                    if(winSelect){
        				aud$openNewTab("中介机构信息"+tabTitle, editUrl+"?winSelect=${winSelect}&agencyId="+row['agencyId']+"&view=true", true);
        			}else{
        				aud$openNewTab("中介机构信息"+tabTitle, editUrl+"?agencyId="+row['agencyId']+(isView ? "&view=true" : ""), true);
        			}
                }
            },	
    		columns:[[
    			{field:'agencyId', title:'选择', checkbox:!isView,  align:'center', halign:'center', show:'false', hidden:isView},
                {field:'agencyName',    title:'公司名称', width:'30%',align:'left',  halign:'center',  sortable:true, oper:'like',
    				formatter:formatterClick},
                {field:'deptName',    title:'所属审计单位', width:'200px',align:'center',  halign:'center',  sortable:true},
                {field:'companyProperty',    title:'公司性质', width:'100px',align:'center',  halign:'center',  sortable:true,show:false},
                {field:'secretQualification',    title:'涉密资质', width:'75px',align:'center',  halign:'center',  sortable:true,show:false},
                {field:'manager',    title:'公司经理', width:'75px',align:'center',  halign:'center',  sortable:true,show:false},
                {field:'xxx',
					 title:'操作',
					 halign:'center',
					 width:'80px',
					 align:'center', 
					 sortable:false,
					 show:false,
					 hidden:winSelect,
					 formatter:function(value,row,index){
						 var btn2 ='&nbsp;<a href="javascript:void(0)" style="color:blue" onclick="empManage(\''+row.agencyId+'\',\''+winSelect+'\',\''+isView+'\')">人员管理</a>';
						 return btn2;
					 }
				}
          ]]
        }
    });    
    window.agencyList = g1;
    
    // 按钮权限
    isView ? $('.editElement').hide() : $('.viewElement').hide();
    isView || winSelect ? g1.batchSetBtn([ {'id':gridTableId+'_remove','remove':true} ]) : null;    
    
    function formatterClick(value){
    	return  ["<label title='单击"+tabTitle+"' style='cursor:pointer;color:blue;'>",value,"</label>"].join('') ;
    }
});
	function empManage (agencyId,winSelect,isView) {
		var url = '${contextPath}/ea/agency/showEmployee.action?agencyId='+agencyId;
		var tabTitle = winSelect == 'true' || isView == 'true'? "查看" : "维护";
		if(winSelect){
			url=url+'&view=${view}&winSelect='+winSelect;
			window.location=url
		}else{
			aud$openNewTab("人员信息"+tabTitle, url+"&view=${view}", true);
		}		
	}
	
	function refresh() {
		$('#agencyList').datagrid('reload');
	}
</script>
</head>
<body class="easyui-layout" style='padding:0px;margin:0px;overflow:hidden;' fit="true" border="0">
	<div region="center" style='margin:0px;overflow:hidden;' title="中介机构" border="0" split="true">
		<table id='agencyList'></table>
	</div>
	<!--  中介结构信息查看、编辑里面已经有项目的信息，在这没有必要显示
	<s:if test="${winSelect!=true }">
		<div region="south" style='height:200px;width:100%;overflow:auto;' title="项目情况" border="0" split="true">
			<div title='项目情况'  border="0" style='height:300px;width:100%;overflow:hidden;'>
		           <iframe id='projectDetail' name='projectDetail'
		           	width="100%" height="100%" marginheight="0" src="${contextPath}/ea/agency/getProjectDetail.action?" marginwidth="0"  frameborder="0"></iframe>
		       </div>
		</div>
	</s:if>
	-->
	<!-- 引入公共文件 -->
   <jsp:include flush="true" page="/pages/frReportFlow/ajaxloading.jsp" />
</body>
</html>