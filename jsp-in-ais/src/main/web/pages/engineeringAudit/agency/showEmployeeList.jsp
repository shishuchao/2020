<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML >
<html>
<title>人员维护</title>
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
	var display= "${param.display}";
	var arr = "${param.agencyId}";
	var agencyIds = "'"+arr.split(',').join("','")+"'";
	//是否从项目送审窗口打开
	var winSelect = "${winSelect}";
	var editUrl = '${contextPath}/ea/agency/editEmp.action?agencyId=${param.agencyId}';
	var tabTitle = winSelect || isView ? "查看" : "编辑";
	
	function getParentWin(){
		var frameWin = aud$parentDialogWin();
		return frameWin.$('#dvAudProject').get(0).contentWindow;
	}
	
	
	var addBtn = {   
            text:'添加',
            iconCls:'icon-add',
            handler:function(){
            	aud$openNewTab('人员信息添加', editUrl + "&winSelect=${winSelect}", true);
            }
        };
	var selectBtn = {   
            text:'选择',
            iconCls:'icon-ok',
            handler:function(){
            	var gridObj = $('#employeeList');
            	var rows = gridObj.datagrid('getChecked');
            	if(rows != null && rows.length > 0){
            		var empIds = []; 
            		var empNames = [];
            		for(var i=0; i<rows.length; i++){
            			var row = rows[i];
            			empIds.push(row['floginname']);
            			empNames.push(row['empName']);
            		}
            		var parentWin = getParentWin();
            		empIds.length ? parentWin.$('#ap_agMemberIds').val(empIds.join(',')) : null;
            		empNames.length ? parentWin.$('#ap_agMemberNames').val(empNames.join(',')) : null;
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
            	parentWin.$('#ap_agMemberIds').val('');
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
	var backBtn = {   
            text:'返回',
            iconCls:'icon-back',
            handler:function(){
            	window.history.go(-1);
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
		/* cusToolbar.push(addBtn);
		cusToolbar.push('-'); */
		if(isView){
			cusToolbar.push(backBtn);
			cusToolbar.push('-');	
		}		
	}else if(!isView){
		cusToolbar.push(addBtn);
		cusToolbar.push('-');
	}
	var gridTableId = "employeeList";
    var g1 = new createQDatagrid({
        // 表格dom对象，必填
        gridObject:$('#employeeList')[0],
        // 要进行检索的表对象(hibernate bean)名称， 进行拼接hql时使用; 必填
        boName:'Employee',
        // 对象主键,删除数据时使用-默认为“id”；必填
        pkName:'empId',
        whereSql:'a.agencyId in('+agencyIds+')',
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
        	singleSelect: false,
            checkOnSelect:display ? true : false,
            selectOnCheck:display ? true : false,
        	toolbar:cusToolbar,
            onClickCell:function(rowIndex, field, value){
                if(field == 'empName'){		
                    var rows = $(this).datagrid('getRows');
                    var row = rows[rowIndex];
                    $(this).datagrid('unselectRow',rowIndex);
                    $(this).datagrid('uncheckRow',rowIndex);
                    if(winSelect){
						aud$openNewTab("人员信息"+tabTitle, editUrl+"&winSelect=${winSelect}&empId="+row['empId']+"&view=true", true);
					}else{
                    	aud$openNewTab("人员信息"+tabTitle, editUrl+"&empId="+row['empId']+(isView ? "&view=true" : ""), true);
					}
                }
            },
            onCheck:function(index,row) {
            	if(display&&isView) {
            		var length = $('#employeeList').datagrid('getChecked').length;
            		if(length>1) {
            			showMessage1("只能选择一个人员！");
            			return false;
            		}
            		var empId =row.empId;
                	parent.empId=empId;
                	parent.showProjectByEmp();
            	}            	      	
            },
            onUncheck:function(index,row) {
            	if(display&isView){
            		parent.empId='';
                	parent.showProjectByEmp();
            	}
            },
            columns:[[
    			{field:'empId',width:'10px', checkbox:true,  align:'center', halign:'center', show:'false',show:false,hidden:display?false:isView},
                {field:'empName',title:'姓名', width:'85px',align:'center',   halign:'center',  sortable:true, oper:'like',
                	formatter:formatterClick},
                {field:'sex',title:'性别', width:'40px',align:'center', halign:'center',sortable:true, show:false},
                {field:'education',title:'学历', width:'100px',align:'center', halign:'center',sortable:true, show:false},
                {field:'major',title:'专业', width:'120px',align:'center', halign:'center',sortable:true, show:false},
                {field:'proQualification',title:'职业资格', width:'180px',align:'center', halign:'center',sortable:true, show:false},
                {field:'telephone',title:'座机', width:'110px',align:'center', halign:'center',sortable:true, show:false},
                {field:'mobilephone',title:'手机', width:'110px',align:'center', halign:'center',sortable:true, show:false},
                {field:'speciality',title:'擅长',    width:'150px',align:'center', halign:'center',sortable:true, oper:'like'},
          ]]
        }
    });
    window.employeeList = g1;
    
 // 按钮权限
    isView ? $('.editElement').hide() : $('.viewElement').hide();
    isView || winSelect ? g1.batchSetBtn([ {'id':gridTableId+'_remove','remove':true} ]) : null;    
    
    function formatterClick(value){
    	return  ["<label title='单击"+tabTitle+"' style='cursor:pointer;color:blue;'>",value,"</label>"].join('') ;
    } 
});
</script>
</head>
<body style='padding:0px;margin:0px;overflow:hidden;' >
	<table id='employeeList'></table>

	<!-- 引入公共文件 -->
   <jsp:include flush="true" page="/pages/frReportFlow/ajaxloading.jsp" />
</body>
</html>