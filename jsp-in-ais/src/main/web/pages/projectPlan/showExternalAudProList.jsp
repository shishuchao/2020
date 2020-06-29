<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<title>外部监督作业项目</title>
<link href="${contextPath}/resources/css/common.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${contextPath}/easyui/boot.js"></script>
<script type="text/javascript" src="${contextPath}/easyui/contextmenu.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>   
<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
<script type="text/javascript" src="${contextPath}/pages/tlInteractive/tlInteractiveCommon.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/jquery-fileUpload.js"></script>
</head>
	<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout">
		<div id="dlgSearch" class="searchWindow">
			<div class="search_head">
				<s:form id="searchForm" name="searchForm" action="statisView" namespace="/plan/year">
					<input type='hidden' name="crudObject.proSource"  value="external" reload='false'/>
					<s:hidden name="crudObject.formId" />
					<s:hidden id="auditDeptId" name="crudObject.audit_dept" />
					<table cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
						<tr>
							<td align="left" class="EditHead" nowrap="nowrap">监督项目名称</td>
							<td align="left" class="editTd"><s:textfield cssClass="noborder" name="searchCondition.w_plan_name" /></td>
							<td align="left" class="EditHead">监督实施单位</td>
							<td align="left" class="editTd" colspan="3">
								<s:buttonText2 cssClass="noborder" id="searchCondition.audit_dept_name"
											   name="searchCondition.audit_dept_name" readonly="true"
											   hiddenName="searchCondition.audit_dept"
											   hiddenId="searchCondition.audit_dept"
											   doubleOnclick="showSysTree(this,{
									  url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action?p_item=3',
									  title:'请选择监督实施单位'
									})"
											   doubleSrc="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png"
											   doubleCssStyle="cursor:hand;border:0" />
							</td>
						</tr>
						<%--<tr>--%>
							<%--<td align="left" class="EditHead">计划月度</td>--%>
							<%--<td align="left" class="editTd">--%>
								 <%--<select class="easyui-combobox" name="searchCondition.w_plan_month" style="width:150px;"  id="searchConditionid" editable="false">--%>
									<%--<option value="">&nbsp;</option>--%>
								   <%--<s:iterator value="{'1','2','3','4','5','6','7','8','9','10','11','12'}" id="entry">--%>
									 <%--<option value="${entry }">${entry }</option>--%>
								   <%--</s:iterator>--%>
								<%--</select>--%>
							<%--</td>--%>
							<%--<td align="left" class="EditHead">计划编号</td>--%>
							<%--<td align="left" class="editTd"><s:textfield cssClass="noborder" name="searchCondition.w_plan_code" /></td>--%>
						<%--</tr>--%>
					</table>
				</s:form>
			</div>
			<div class="serch_foot">
				<div class="search_btn">
					<a class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="doSearch();">查询</a>&nbsp;
					<a class="easyui-linkbutton" data-options="iconCls:'icon-reload'" onclick="resetQuery();">重置</a>&nbsp;
					<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="doCancel()">取消</a>
				</div>
			</div>
	    </div>
		<div region="center" border='0'>
			<table id="yearDetailList"></table>
			<div id="audSearch" style="overflow: hidden;"></div>
		</div>
		<%--<s:if test="${(crudObject.status_name=='正在执行'||crudObject.status_name == '计划草稿'||crudObject.status_name == '正被审批')&&crudObject.formId!=null&&crudObject.formId!=''}">--%>
			<div id="importProjects" class="easyui-window" closed="true">
				<iframe id="tmpIframe" name="tmpIframe" style='display:none'></iframe>	
				<form id="importForm"  method="post"  enctype="multipart/form-data" target='tmpIframe'>
					<s:hidden name="crudId" />
					<s:hidden name="taskInstanceId" />
					<input type='hidden' name='prosource' value='external'/>
					<table cellpadding=0 cellspacing=0 border=0 class="ListTable" align="center">
						<tr>
							<td align="left" class="EditHead" style="vertical-align: middle;">选择文件</td>
							<td class="editTd" align="left"><s:file name="template" id='proTemplate' size="66%" cssStyle="font-size:15px" accept="application/vnd.ms-excel"/></td>
							<td class="editTd" align="center"><a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-import'" id="importButton" onclick="submit_dr();">导入</a>
							&nbsp;<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-download'" id="download" onclick="templateDownload()">下载模板</a></td>
						</tr>
					</table>
					<s:hidden name="listStatus" />
				</form>
			</div>
		<%--</s:if>		--%>
<script type="text/javascript">
	// 导入成功后，回调函数
	function aud$ImportExcelCallbackFn(resultType){
		//alert('resultType='+resultType)
		if(resultType && resultType == 'success'){
			doSearch();
		}
	}

	function doCancel(){
		$('#dlgSearch').dialog('close');
	}
	function submit_dr(){
		var template = document.all('template').value;
		if(template == ''){
			top.$.messager.alert('系统提示',"请先选择要导入的文件",'warning');			
			return;
		}
		
		$("#importForm").form('submit',{
			url:'${contextPath}/plan/year/importExternalAudPro.action',
			onSubmit:function(){
				try{
					aud$loadOpen();
					$('#importProjects').window('close');		
				}catch(e){}
			},
			success:function(data){
				try{
					aud$loadClose();
					
				}catch(e){}
			}
		});
	}
  
	function templateDownload() {
		$('#download').linkbutton('disable');
		var auditDeptId = document.getElementById('auditDeptId').value;
		window.location.href = "${contextPath}/templatedownload?file=externalAudPro.xls&type=externalAudPro&auditDeptId="+auditDeptId;
	}
	/*
	修改选中的单条计划
	 */
	function update() {
		var row = $('#yearDetailList').datagrid('getSelected');//document.getElementsByName("detail_plan_id");
		var selectedOne = false;
		var selectedValue = '';
		if(row!=null){
			if(row.status_name != '草稿'){
				top.$.messager.alert('错误',"只能修改草稿状态的记录",'warning');
				return;
			}
			var detailId = row.formId;
			<%--var turl = "${contextPath}/plan/detail/edit.action?prosource=external&planUpdate=yes&fromAdjust=${fromAdjust}&crudId=" + detailId + "&option=edityuxuan&yearFormId=${crudId}";--%>
            var turl = "${contextPath}/plan/detail/edit.action?prosource=external&planUpdate=yes&crudId=" + detailId + "&option=edityuxuan&showProblem=true&projectId="+detailId;
			//window.location.href = turl;
			
			new aud$createTopDialog({
	            title:'外部监督项目',
	            url  :turl,
				onClose:function(){//问题列表关闭时，刷新上报进度列表
					updateProProblemCount(detailId);
				}
			}).open();
		
		}else{
			top.$.messager.alert('错误',"请先选择需要修改的记录！",'error');
		}
	}
	
	function viewData(row){
		var detailId = row.formId;
		var turl = "${contextPath}/projectPlan/viewData.action?view=true&resultName=externalAudPro&showProblem=true&busId="+detailId+"&projectId="+detailId;
		new aud$createTopDialog({
           title:'外部监督项目查看',
           url  :turl
      	}).open();
	}
	
	
	/*
		删除选中的单条计划
	 */
	function deleteDetail() {
		var row = $('#yearDetailList').datagrid('getSelected');
		if(row){
			top.$.messager.confirm('确认','您确定要删除选中的记录吗？',function(r){
				if(r){
					var detailId = row.formId;
					var state=row.status_name;
					if(state=='草稿'){
						$.ajax({
							type:'post',
							url:'/ais/plan/year/deleteYuxuan.action?fromAdjust=${fromAdjust}&prosource=${prosource}&crudId=' + detailId,
							dataType:'json',
							async:false,
							success:function(json){
							}
						});
						$('#yearDetailList').datagrid("reload");
					}else{
						top.$.messager.alert('提示信息','只能删除状态为【草稿】的记录！','error');
					}
				}
			});
		}else{
			top.$.messager.alert('提示信息','请先选择要删除的记录！','warning');
		}
	}
	
	// 终止项目
	function abortProject(){
		var row = $('#yearDetailList').datagrid('getSelected');
		if(row){
			var status = row['status'];
			if(status == '8500'){				
				top.$.messager.confirm('提示信息','您确定要终止选中的项目吗？',function(r){
					if(r){
						var detailId = row['formId'];
						new aud$createTopDialog({
				            title:'项目终止',
				            url  :"${contextPath}/projectPlan/showAbortDetailPlan.action?ifmId=externalAudPro&busId="+detailId,
				            width:800,
				            height:450
				      	}).open();
					}
				});
			}else{
				top.$.messager.alert('提示信息','只能终止状态为【年度已审批】的项目！','warning');
			}
		}else{
			top.$.messager.alert('提示信息','请先选择要终止的记录！','warning');
		}
	}
	
	/*
	增加计划明细
	 */
	function addPlanItem(year_form_id, year) {
		var ids = document.getElementsByName("detail_plan_id");
		for ( var i = 0; i < ids.length; i++) {
			if (ids[i].checked == true) {
				alert('新增操作请不要选择明细信息!');
				return false;
			}
		}
		//删除立项，在创建预选项目计划时同时创建一条项目计划
		//window.location.href = '${contextPath}/plan/detail/edit.action?fromAdjust=${fromAdjust}&option=addyuxuan&yearFormId=${crudId}';
        //var turl = '${contextPath}/plan/detail/edit.action?prosource=external&fromAdjust=${fromAdjust}&option=addyuxuan&yearFormId=${crudId}';
        var turl = '${contextPath}/plan/detail/edit.action?prosource=external&option=addyuxuan';
		new aud$createTopDialog({
            title:'外部监督项目',
            url  :turl,
            onClose:function(){
				window.location.reload();
			}
      	}).open();
	
	}

    // 问题录入或导入
    function problemImport(){
        var checkedRows = $('#yearDetailList').datagrid("getChecked");
        if(checkedRows != null && checkedRows.length){
            if(checkedRows.length > 1){
                showMessage1("只能选择一条记录");
            }else{
                var row = checkedRows[0];
                // 已完成才能导入问题
                // var statusCode = row['implStatusCode'];
                // if(statusCode != '2000'){
                //     showMessage1("只有实施状态为【已完成】的项目才能录入或者导入问题");
                //     return;
                // }

				var onlyView = "false";
                if(row.status_name == '已提交'){
                    onlyView = "true";
                }

                var projectId = row['formId'];
                var turl = "${contextPath}/projectPlan/showProPgrsProblemList.action?view="+onlyView+"&projectId="+projectId;
                new aud$createTopDialog({
                    title:row.w_plan_name +'-监督问题列表',
                    url  :turl ,
                    onClose:function(){//问题列表关闭时，刷新上报进度列表
                        updateProProblemCount(projectId);
                    }
                }).open();
            }
        }else{
            showMessage1("请选择要导入或者录入问题的项目");
        }
    }

    // 更新外部监督项目列表中问题个数 updateProProblemCount
    function updateProProblemCount(projectId){
        $.ajax({
            url : "${contextPath}/projectPlan/updateProProblemCount.action",
            dataType:'json',
            type: "post",
            data: {
                'projectId':projectId
            },
            beforeSend:function(){
                var checked = projectId ? true : false;
                checked ? aud$loadOpen() : null;
                return checked;
            },
            success: function(data){
                aud$loadClose();
                if(data && data.type == 'info'){
                    // busGrid.refresh();
                    $('#yearDetailList').datagrid('reload');
					$('#yearDetailList').datagrid('clearSelections');
                }
            },
            error:function(data){
                aud$loadClose();
                top.$.messager.show({title:'提示信息',msg:'请求失败！请检查网络配置或者与管理员联系！'});
            }
        });
    }

    //提交项目
    function postAndApproved(){
		var checkedRows = $('#yearDetailList').datagrid("getChecked");
        if(checkedRows != null && checkedRows.length){
            var projectIds = [];
            $.each(checkedRows, function(i, row){
                var busId = row.formId;

                if(row.status_name == '已提交'){
                    projectIds = [];
                    showMessage1("已提交状态的项目不能再次提交！");
                    return false;
				}else{
                    projectIds.push(busId);
				}

                // var implStatusCode = row['implStatusCode'];
                // if(implStatusCode == '2000'){
                //     projectIds.push(busId);
                // }else{
                //     projectIds = [];
                //     showMessage1("只有实施状态为【已完成】的项目才能提交审批");
                //     return false;
                // }
            });
            if(projectIds != null && projectIds.length > 0){
				top.$.messager.confirm('提示信息','请确保该项目的问题已经录入，提交后将不可再录入问题。您确定要提交该项目吗？',function(r){
					if(r){
						var sendData = projectIds.join(",");
						$.ajax({
							url : "${contextPath}/projectPlan/postAndApproved.action",
							dataType:'json',
							type: "post",
							data: {
								'projectId':sendData
							},
							beforeSend:function(){
								aud$loadOpen();
								return true;
							},
							success: function(data){
								aud$loadClose();
								data && data.msg ? showMessage1(data.msg) : null;
								if(data && data.type == 'info'){
									$('#yearDetailList').datagrid('reload');
								}
							},
							error:function(data){
								aud$loadClose();
								top.$.messager.show({title:'提示信息',msg:'请求失败！请检查网络配置或者与管理员联系！'});
							}
						});
					}
				});
            }
        }else{
            showMessage1("请选择要提交的项目！");
        }
    }

	$(function(){
		var bodyW = $('body').width();
		var isView = "${view}" == true || "${view}" == "true" ? true : false;
		var tabTitle = isView ? "查看" : "编辑";
		showWin('dlgSearch');
		// 初始化生成表格
		$('#yearDetailList').datagrid({
			url : "${contextPath}/plan/year/statisView.action?prosource=external&crudId=${crudId}&querySource=grid",
			method:'post',
			showFooter:false,
			rownumbers:true,
			pagination:true,
			striped:true,
			//autoRowHeight:false,
			fit: true,
			fitColumns:false,
			idField:'id',	
			border:false,
			singleSelect:true,
			pageSize:20,
			remoteSort: false,
			toolbar:[{
				id:'search',
				text:'查询',
				iconCls:'icon-search',
				handler:function(){
					searchWindShow('dlgSearch',750);
				}
			},'-',{
				text:'新增',
				id:'add',
				iconCls:'icon-add',
				handler:function(){
					addPlanItem('${crudObject.formId}','${crudObject.w_plan_year}');
				}
			},'-',{
				text:'删除',
				id:'delete',
				iconCls:'icon-delete',
				handler:function(){
					deleteDetail();
				}
			},'-',{
				text:'导入项目',
				id:'export',
				iconCls:'icon-import',
				handler:function(){
					$('#download').linkbutton('enable');
					$('#importProjects').window('open');
					setTimeout(function(){
						$('#importProjects').window('center');
						$('#proTemplate').val('');
					},0);
				}
			},'-',{
				text:'提交项目',
				id:'submitProblem',
				iconCls:'icon-ok',
				handler:function(){
					postAndApproved();
				}
			},'-',helpBtn
			],
			onClickCell:function(rowIndex, field, value){
				try{
					if(field == 'w_plan_name'){
						$(this).datagrid('selectRow',rowIndex);
		                var rows = $(this).datagrid('getRows');
		                var row = rows[rowIndex];
						row.status_name == '已提交' ? viewData(row) : update();
					}
				}catch(e){
				}
			},
            onLoadSuccess:function(data){
				initHelpBtn();
                aud$resetGridRowHeight("yearDetailList");
            },
			frozenColumns:[[
       			{field:'status_name',title:'状态',width:'100',align:'center',halign:'center',sortable:true},
       			{field:'w_plan_name',title:'监督项目名称',width:'200', align:'left',halign:'center',sortable:true,
					formatter:function(val,rowData,index){
       					if(rowData.status_name == '已提交') {
							return "<label title='单击进行查看' style='cursor:pointer;color:blue;'>"+val+"</label>";
						} else {
							return "<label title='单击进行编辑' style='cursor:pointer;color:blue;'>"+val+"</label>";
						}

					}
       			},
                {field:'w_plan_code',title:'项目编号',width:'170',align:'left',halign:'center',sortable:true}
    		]],
			columns:[[  
				{field:'audit_object_name',title:'接受监督检查单位',width:'180',align:'left',sortable:true,halign:'center'},
				{field:'externalMainName',title:'外部监督主体名称',width:'150',align:'left',sortable:true,halign:'center'},
				{field:'audit_dept_name',title:'牵头监督实施单位',width:'180',align:'left',sortable:true,halign:'center'},
				{field:'mainContent',title:'主要内容',width:'350',align:'left',sortable:true,halign:'center',hidden:true},
				{field:'pro_type_name',title:'监督类型',width:'130',align:'center',sortable:true,halign:'center'},
				{field:'handle_modusname',title:'监督方式',width:'100',align:'center',sortable:true,halign:'center',hidden:true},
				{field:'pro_starttime',title:'项目开始日期',width:'120',align:'center',sortable:true,halign:'center',
					formatter:function(val){
						return val && val.length > 10 ? val.substr(0,10) : val;
					}
				},
				{field:'pro_endtime',title:'项目结束日期',width:'120',align:'center',sortable:true,halign:'center',
					formatter:function(val){
						return val && val.length > 10 ? val.substr(0,10) : val;
					}
				}
				,{field:'problemCount',title:"问题数量", width:'80px',align:'center',halign:'center',sortable:true}
				,{field:'w_writer_person_name',title:"计划管理员", width:'80px',align:'center',halign:'center',sortable:true,hidden:true}
                /*{field:'w_file', title:'附件', width:'30%',align:'left', halign:'center',  sortable:true, show:'false',
                    formatter:function(value,row,index){
                        return "<div id='fileItem"+index+"'></div>";
                    }
                }
                ,{field:'operation', title:'操作', width:'90px',align:'center',halign:'center',  sortable:true, show:'false',
                    hidden:isView,
                    formatter:function(value,row,index){
                        window.setTimeout(function(){
                            $('#fileTigger'+index).linkbutton({
                                iconCls: 'icon-upload',
                                text:'上传附件'
                            });
                            initFileUploadPlug(index, row['w_file']);
                        },0)
                        return "<span id='fileTigger"+index+"' style='border-width:0px;'></span>";
                    }
                }*/
			]]   
		});

        //初始化上传文件控件
        function initFileUploadPlug(index, attachmentId){
            $('#fileItem'+index).fileUpload({
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
                triggerId:'fileTigger'+index,
                isDel:!isView,
                isEdit:!isView,
                onFileSubmitSuccess:function(data, options){
                    aud$resetGridRowHeight("yearDetailList");
                },
                onDeleteFileSuccess:function(data, fileIdList, options){
                    aud$resetGridRowHeight("yearDetailList");
                }
            })
        }

		//单元格tooltip提示
		$('#yearDetailList').datagrid('doCellTip', {
			onlyShowInterrupt:true,
			position : 'bottom',
			maxWidth : '200px',
			tipStyler : {
				'backgroundColor' : '#EFF5FF',
				borderColor : '#95B8E7',
				boxShadow : '1px 1px 3px #292929'
			}
		});
		$('#importProjects').window({
			title:'外部监督项目导入',
			modal:true,
			inline:true,
			width:900,
			height:85,
			minimizable: false,
			maximizable: false,
			collapsible: false,
			closed:true
		});
	});
	function doSearch(){
		$('#yearDetailList').datagrid({
			queryParams:form2Json('searchForm')
	    });
	    $('#yearDetailList').datagrid('clearSelections');
		$('#dlgSearch').dialog('close');
    }
	function resetQuery(){
		resetForm('searchForm');
	}
	</script>
	<iframe style="display: none;" id="exportIframe"></iframe>	
</body>
</html>
