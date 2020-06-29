<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<!DOCTYPE HTML>
<html>
	<head>
		<title>被审计单位资料维护</title>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/common.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/createOrgTree.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jquery-fileUpload.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/pages/tlInteractive/tlInteractiveCommon.js"></script>
	</head>
	<script type="text/javascript">
        var gridTableId = "historyTable";
        var en = '${param.en}' == 'en'?true:false;
		$(function () {
            window.scGridObj = new createQDatagrid({
                // 表格dom对象，必填
                gridObject:$('#'+gridTableId)[0],
                // 要进行检索的表对象(hibernate bean)名称， 进行拼接hql时使用; 必填
                boName:'AuditObjectMaterial',
                // 对象主键,删除数据时使用-默认为“id”；必填
                pkName:'mid',
                order :'desc',
                sort  :'historyVersion',
                winWidth:500,
                winHeight:250,
                myToolbar:[],
                associate:true,
                //定制查询
                whereSql: " auditObject='${param.auditObject}' and templateId='${param.templateId}' and status=1",
                gridJson:{
                    title:en ? 'Data List':'资料清单',
                    pageSize:10,
                    singleSelect:true,
                    checkOnSelect:false,
                    selectOnCheck:false,
                    border:0,
                    fit:true,
					rownumbers:false,
                    toolbar:[],
                    columns:[[
						{field:'serialnum', title:"序号",  width:'150px', align:'center', halign:'center',sortable:false,
							formatter:function (value,row,index) {
								return index + 1;
							}
						},
                        {field:'materialFile', title:en ? 'Documents Name':'附件', width:'400px',align:'left', halign:'center',  sortable:true, show:'false',
                            formatter:function(value,row,index){
                                window.setTimeout(function(){
                                    initFileUploadPlug('fileLatestItem',index, row['materialFile']);
                                },50);
                                return "<div id='fileLatestItem"+index+"'></div>";
                            }
                        },
                        {field:'fileTime',    title:en ? 'Uploaded Time':"最近上传时间",  width:'200px', align:'center', halign:'center',sortable:true},
                        {field:'uploaderName',    title:en ? 'Operator':"最近上传人",  width:'100px', align:'center', halign:'center',sortable:true},
                        {field:'uploaderDepName',    title:en ? 'Department':"上传人所在部门",  width:'150px', align:'center', halign:'center',sortable:true}
                    ]]
                }
            });
            //初始化上传文件控件
            function initFileUploadPlug(prefix,index, attachmentId){
                $('#'+prefix+index).fileUpload({
                    fileGuid:attachmentId,
                    /*
                       文件上传后，回显方式选择， 默认：1
                    1：在当前容器下生成datagrid表格，提供“添加、修改、删除、查看、下载”等功能，可以通过参数对按钮权限进行配置。
                    2：以文件名列表形式展示，一个文件名称就是一行
                    3：不回显，根据控件提供的方法（getUploadFiles详见使用手册），自己定义回显样式
                    */
                    echoType:2,
                    // 上传界面类型， 0：（默认）弹出dialog窗口和表格 1：直接选择上传文件
                    //uploadFace:1,
                    isDel:false,
					isAdd:false,
                    isEdit:false
                });
            }

        });

	</script>
	<body style='padding:0px;margin:0px;overflow:hidden;' class="easyui-layout" fit="true" border='false'>
		<div region="center" data-options="border:false">
			<table id="historyTable"></table>
		</div>
	</body>
</html>