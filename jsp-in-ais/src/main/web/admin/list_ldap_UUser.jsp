<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML >
<html>
<title>ldap用户信息</title>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<script type="text/javascript" src="${contextPath}/easyui/boot.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/jquery-parseExcel.js"></script>
<script type="text/javascript" src="${contextPath}/easyui/contextmenu.js"></script>  
<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
<script type="text/javascript" src="${contextPath}/pages/tlInteractive/tlInteractiveCommon.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/autosize.js"></script>
<script type="text/javascript">
var fdepid = "${fdepid}";
$(function(){
    var g1 = new createQDatagrid({
        // 表格dom对象，必填
        gridObject:$('#objectList')[0],
        // 要进行检索的表对象(hibernate bean)名称， 进行拼接hql时使用; 必填
        boName:'LdapUUser',
        // 对象主键,删除数据时使用-默认为“id”；必填
        pkName:'id',
		winWidth:800,
	    winHeight:250,
   	    //删除前执行
   	    beforeRemoveRowsFn:function(rows, gridObject){ 
   	    	return true;
   	    },
	    myToolbar: [],
        // 表格控件dataGrid配置参数; 必填
        gridJson:{	
        	singleSelect:true,
        	checkOnSelect:false,
        	selectOnCheck:false,
            toolbar: ['query','-',{   
	                text:'添加',
	                iconCls:'icon-add',
	                handler:function(){
                    	synUser();
	                }
	            }
	        ],
            onClickCell:function(rowIndex, field, value){
               
            },	
            frozenColumns:[[	        	
                            {field:'id',width:'50px', checkbox:true, halign:'center',align:'center',show:'false'},
    				        {field:'fuid',title:'登录名称', width:'160px',align:'center',halign:'center',sortable:true,oper:'like'},
    				        {field:'cn',title:'姓名', width:'140px',align:'center', halign:'center',sortable:true,oper:'like'},
    				        {field:'ou', title:'所属部门名称', width:'120px',align:'center', halign:'center',sortable:true, oper:'like'}
    				        /* {field:'departmentnumber', title:'部门编号', width:'120px',align:'center', halign:'center',sortable:true, show:'false'} */
    		               
            	        ]],
	    	columns:[[
	    	            {field:'personstatus',title:'在职状态', width:'100px',align:'center',halign:'center',sortable:false, show:'false',
	    	            	formatter:function(value,row,index){
								 if(value=='0'){
									return '在职';			
								 }
								 if(value=='1'){
									 return '离职';
								}
							 }},
						{field:'mail',title:'邮箱', width:'150px',align:'center', halign:'center',sortable:true,oper:'like'},
						//{field:'employeenumber',title:'员工编码', width:'120px',align:'center',halign:'center',sortable:true,oper:'like'},
		                {field:'cugender',  title:'性别', width:'120px',align:'center', halign:'center',sortable:true, show:'false'},
		               
		                //{field:'cucompanynumber',title:'公司编号', width:'120px',align:'center', halign:'center',sortable:true, show:'false'}
		          ]]
        }
    });
	window.objectList = g1;

	//单元格tooltip提示
	$('#objectList').datagrid('doCellTip', {
		position : 'bottom',
		maxWidth : '200px',
		tipStyler : {
			'backgroundColor' : '#EFF5FF',
			borderColor : '#95B8E7',
			boxShadow : '1px 1px 3px #292929'
		}
	
	});
	
	
	
});
function synUser(){
		var ids = $('#objectList').datagrid('getChecked');
		if (ids.length == 0) {
			showMessage1('请选择要同步的数据！');
			return false;
		}
		if(fdepid == null || fdepid == '' || fdepid == undefined){
			showMessage1('请选择要同步数据的所属单位！');
			return false;
		}
		var idString = '';
		for(var i=0;i<ids.length;i++){
			idString = idString + ',' + ids[i].id;
		}
		if(idString != '' && fdepid != ''){
			$.messager.confirm("确认",'确定要同步这些数据吗？',function(flag){
				if(flag){
					   $.ajax({
                           url:"/ais/admin/synLdapUserToUser.action",
                           type:'post',
                           cache:false,
                           dataType:'json',
                           data:{
                               'id':idString,'fdepid':fdepid
                           },
                           success:function(data){
                               showMessage1(data.msg);
                           }
                       });
				}
			})
			
		}
  }
</script>
<style type="text/css">
input[class~=editElement]{
	width:85% !important;
}
</style>
</head>
<body style='padding:0px;margin:0px;overflow:hidden;' class='easyui-layout' fit='true' border='0'>
	<div region='center' border='0' style='padding:0px; margin:0px; overflow:hidden;'>	
		<table id='objectList'></table>
	</div> 	
	
	
	<!-- 引入公共文件 -->
   <jsp:include flush="true" page="/pages/frReportFlow/ajaxloading.jsp" /> 
  
</body>
</html>