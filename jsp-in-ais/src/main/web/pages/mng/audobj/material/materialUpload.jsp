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
		<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/js/jquery-fileUpload.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/pages/tlInteractive/tlInteractiveCommon.js"></script>
	</head>
	<script type="text/javascript">
        var isView = "${view}" == true || "${view}" == "true" ? true : false;
        var gridTableId = "materialTable";
        var en = '${en}' == 'en'?true:false;
		var datagrid;
		$(function () {

		    function submitMaterial() {
				$.ajax({
					url:'${contextPath}/auditobject/material/submitMaterial.action',
					type:'post',
					data:{
					    'auditObject':'${auditObject}'
					},
					cache:false,
					dataType:'json',
					success:function (ret) {
						showMessage1(ret.msg);
						window.location.reload();
                    }
				});
            }

            var submitBtn = {
                text:en ? 'Submit':'提交资料',
                iconCls:'icon-ok',
                handler:function(){
                    submitMaterial();
                }
            };

            var cusToolbar = isView ? [] : [submitBtn];
			var bodyW = $('body').width();
			if (bodyW == 0){
			    bodyW = window.parent.$('body').width();
            }
			window.scGridObj = new createQDatagrid({
                // 表格dom对象，必填
                gridObject:$('#'+gridTableId)[0],
                // 要进行检索的表对象(hibernate bean)名称， 进行拼接hql时使用; 必填
                boName:'AuditObjectMaterial',
                // 对象主键,删除数据时使用-默认为“id”；必填
                pkName:'mid',
                order :'asc',
                sort  :'categoryCode',
                winWidth:500,
                winHeight:250,
                myToolbar:[],
                associate:true,
                //定制查询
                whereSql: " auditObject='${auditObject}' and status=0",
                gridJson:{
                    title:en ? 'Data List':'资料清单',
                    pageSize:50,
                    singleSelect:true,
                    checkOnSelect:false,
                    selectOnCheck:false,
                    border:0,
                    fit:true,
                    toolbar:cusToolbar,
                    frozenColumns:[[

                    ]],
                    columns:[[
						// {field: 'mid', title: "选择", width: '5px', align: 'center', halign: 'center', show: 'false', hidden: true},
						{field: 'categoryCNName', title: en ? 'Type' : "资料类别", width: bodyW * 0.1 + 'px', align: 'center', halign: 'center', sortable: true},
						{field: 'cnName', title: en ? 'Name' : "资料名称", width: bodyW * 0.15 + 'px', align: 'left', halign: 'center', sortable: false},
						/*						{field:'cnTemplate', title:en ? 'Reference Template':'参考模板', width:'240px',align:'left', halign:'center',  sortable:true, show:'false',
                                                    formatter:function(value,row,index){
                                                        window.setTimeout(function(){
                                                            initFileUploadPlug('fileItem',index, row['cnTemplate']);
                                                        },50)
                                                        return "<div id='fileItem"+index+"'></div>";
                                                    }
                                                },*/
						{
							field: 'cnTemplate', title: en ? 'Reference Template' : '参考模板', width: bodyW * 0.2 + 'px', align: 'left', halign: 'center', sortable: true, show: 'false',
							formatter: function (value, row, index) {
								window.setTimeout(function () {
									initCnTemplateItem('cnTemplateItem', index, row['cnTemplate']);
								}, 50);
								return "<div id='cnTemplateItem" + index + "'></div>";
							}
						},
						<s:if test="!${view == 'true'}">
						{
							field: 'materialFile', title: en ? 'Latest Doc.' : '最近资料', width: bodyW * 0.1 + 'px', align: 'left', halign: 'center', sortable: false, show: 'false',
							formatter: function (value, row, index) {
								return "<div id='materialItem" + index + "'></div>";
							}
						},
						{field: 'fileTime', title: en ? 'Uploaded Time' : "最近上传时间", width: bodyW * 0.1 + 'px', align: 'center', halign: 'center', sortable: true},
						{field: 'uploaderName', title: en ? 'Operator' : "最近上传人", width: bodyW * 0.1 + 'px', align: 'center', halign: 'center', sortable: true},
						{field: 'uploaderDepName', title: en ? 'Department' : "上传人所在部门", width: bodyW * 0.1 + 'px', align: 'center', halign: 'center', sortable: true},
						{
							field: 'operation', title: en ? 'Operation' : '操作', width: bodyW * 0.1 + 'px', align: 'center', halign: 'center', sortable: false, show: 'false',
							formatter: function (value, row, index) {
								window.setTimeout(function () {
									$('#material' + index).linkbutton({
										iconCls: 'icon-upload',
										text: en ? 'Upload Data' : '上传附件'
									});
									initFileUploadPlug('materialItem', index, row['materialFile'], 'material');
									$('#datagrid-row-r1-1-' + index).height($('#datagrid-row-r1-2-' + index).height());
								}, 50);
								return "<span id='material" + index + "' style='border-width:0;'></span>";
							}
						},
						</s:if>
						{
							field: 'historyVersion', title: en ? 'Previous Versions' : "历史版本", width: bodyW * 0.05 + 'px', align: 'center', halign: 'center',
							formatter: function (value, row, index) {
								var title = en ? '【' + row['enName'] + '】Previous Versions' : '【' + row['cnName'] + '】历史版本列表';
								return '<a href="javascript:;" onclick="aud$openNewTab(\'' + title + '\',\'${contextPath}/pages/mng/audobj/material/historyVersions.jsp?auditObject=' + row['auditObject'] + '&en=${en}&templateId=' + row['templateId'] + '\',true)">' + value + '</a>';
							}
						}
                    ]],
                    onLoadSuccess:function(data){
                        aud$mergeGridCells(gridTableId, data);
                    }
                }
            });

			//初始化上传文件控件
			function initCnTemplateItem(prefix,index, attachmentId){
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

            //初始化上传文件控件
            function initFileUploadPlug(prefix,index, attachmentId,triggerPrefix){
                if(triggerPrefix) {
                    var rows = $('#'+gridTableId).datagrid('getRows');
                    var row = undefined;
                    if(rows && rows.length > 0){
                        row = rows[index];
                    }
                    $('#' + prefix + index).fileUpload({
                        fileGuid: attachmentId,
                        /*
                           文件上传后，回显方式选择， 默认：1
                        1：在当前容器下生成datagrid表格，提供“添加、修改、删除、查看、下载”等功能，可以通过参数对按钮权限进行配置。
                        2：以文件名列表形式展示，一个文件名称就是一行
                        3：不回显，根据控件提供的方法（getUploadFiles详见使用手册），自己定义回显样式
                        */
                        echoType: 2,
                        // 上传界面类型， 0：（默认）弹出dialog窗口和表格 1：直接选择上传文件
                        //uploadFace:1,
                        triggerId: triggerPrefix + index,
                        isDel: !${EDIT_DISABLED} && !isView,
                        isEdit: !${EDIT_DISABLED} && !isView,
                        onFileSubmitSuccess:function (data,options) {
                            if(data.fileId) {
                                //回显最近上传时间/人
								var qFile = $('#' + prefix + index).fileUpload('getUploadFiles');
								if(qFile && qFile.rows && qFile.rows.length){
								    var files = qFile.rows;
								    var file = files[0];
								    row['fileTime'] = file.fileTime;
								    row['uploaderName'] = file.uploader_name;
								    row['uploaderDepName'] = '${user.fdepname}';

								    $('#'+gridTableId).datagrid('updateRow',{
								        index:index,
										row:row
									});
								}

								//增加附件后，隐藏当前操作行的‘资料类别’列，避免因合并此列造成的显示错位
/*								if (index>0) {
									var tdobj = $('#datagrid-row-r1-2-' + index).find('td:eq(1)')[0];
									if (tdobj != null){
										$(tdobj).css('display', 'none');
									}
								}*/
								//增加附件后，再合并一次单元格，避免因合并此列造成的显示错位
								var gridData = $('#'+gridTableId).datagrid('getData');
								aud$mergeGridCells(gridTableId, gridData);

                                $.ajax({
									url:'${contextPath}/auditobject/material/refreshMaterial.action',
									type:'get',
									data:{
									    'fileId':data.fileId,
										'mid':row['mid']
									},
									dataType:'json',
									success:function (ret) {

                                    }
								});
                            }
                        },
						onDeleteFileSuccess:function(data, fileIdList, options){
                        	var materialId = row['mid'];
                        	if (materialId){
								$.ajax({
									url: '${contextPath}/auditobject/material/getFileNumByMaterialId.action',
									async: false,
									cache: false,
									type: 'get',
									data: {
										'materialId': materialId
									},
									success: function(data){
										if (data.num == '0'){
											row['fileTime'] = "";
											row['uploaderName'] = "";
											row['uploaderDepName'] = "";

											$('#'+gridTableId).datagrid('updateRow',{
												index:index,
												row:row
											});

											//删除附件刷新数据后，再合并一次单元格，避免显示错位
											var gridData = $('#'+gridTableId).datagrid('getData');
											aud$mergeGridCells(gridTableId, gridData);
										}
									}
								});
                            }
                        }
                    });
                }else{
                    $('#' + prefix + index).fileUpload({

                        fileGuid: attachmentId,
                        /*
                           文件上传后，回显方式选择， 默认：1
                        1：在当前容器下生成datagrid表格，提供“添加、修改、删除、查看、下载”等功能，可以通过参数对按钮权限进行配置。
                        2：以文件名列表形式展示，一个文件名称就是一行
                        3：不回显，根据控件提供的方法（getUploadFiles详见使用手册），自己定义回显样式
                        */
                        echoType: 2,
                        // 上传界面类型， 0：（默认）弹出dialog窗口和表格 1：直接选择上传文件
                        isDel: false,
						isAdd:false,
                        isEdit: false
                    });
                }
            }

            // 合并datagrid的单元格
            function aud$mergeGridCells(gridId, data){
                try{
                    if(gridId, data){
                        var rows = data.rows;
                        if(rows && rows.length){
                            var len = rows.length;
                            var preVal = "";
                            var samecount = 1;
                            var beginIndex = 0;
                            var isStart = true;
                            $.each(rows, function(j, row){
                                var val = row[en ? 'categoryENName':'categoryCNName'];
                                if(isStart){
                                    preVal = val;
                                    isStart = false;
                                    return true;
                                }else if(val == preVal){
                                    samecount++;
                                    preVal = val;
                                }

                                if((val != preVal || j == len - 1) && samecount){
                                    $('#'+gridId).datagrid('mergeCells',{
                                        index  : beginIndex,
                                        field  : en ? 'categoryENName':'categoryCNName',
                                        rowspan: samecount,
                                        colspan: 1
                                    });
                                    beginIndex = j;
                                    samecount = 1;
                                    preVal= val;
                                }

                            });
                        }
                    }
                }catch(e){
                    alert('aud$mergeGridCells:\n'+e.message);
                }
            }

            if (${EDIT_DISABLED}) {
                $('#' + gridTableId).datagrid('hideColumn','operation');
                $('div.datagrid-toolbar').hide();
            }
        });

	</script>
	<body style='padding:0px;margin:0px;overflow:hidden;' class="easyui-layout" fit="true" border='false'>
		<div region="center" data-options="border:false">
			<table id="materialTable"></table>
		</div>
	</body>
</html>