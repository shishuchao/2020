<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>问题已整改穿透页面</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
		<link href="${contextPath}/resources/css/common.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
		<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
		<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/csswin/subModal.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type="text/javascript" src="${contextPath}/pages/tlInteractive/tlInteractiveCommon.js"></script>
	</head>
	<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout">
	<div id="dlgSearch" class="searchWindow">
		<div class="search_head">
			<s:form id="searchForm" name="searchForm" action="problemRectifyCountByFwAndNd" namespace="/Leadershipinquiry" method="post">
				<s:token/>
				<table cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
					<tr >
						<td class="EditHead">
							项目名称
						</td>
						<td class="editTd">
							<s:textfield cssClass="noborder" cssStyle="width:160px;" id="fname" name="project_name"  />
						</td>
						<td class="EditHead">问题标题</td>
						<td class="editTd">
							<s:textfield cssClass="noborder" cssStyle="width:160px;"  name="problem_title"  />
						</td>
					</tr>
				</table>
			</s:form>
		</div>
		<div class="serch_foot">
			<div class="search_btn">
				<a class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>&nbsp;
				<a class="easyui-linkbutton" data-options="iconCls:'icon-reload'" onclick="restal()">重置</a>&nbsp;
				<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="doCancel()">取消</a>
			</div>
		</div>
	</div>

	<div region="center" border='0'>
			<table id="yearList"></table>
		</div>
		<div id="planName" title="项目基本信息" style="overflow:hidden;padding:0px">
			<iframe id="showPlanName" src="" width="100%" title="" height="100%" frameborder="0" ></iframe>
		</div>
		<div id="viewMiddle" title="定稿问题查看" style="overflow:hidden;padding:0px">
			<iframe id="openViewMiddle" src="" width="100%" title="" height="100%" frameborder="0" ></iframe>
		</div>
		<script type="text/javascript">

            function openMsg(projectid){
                var viewUrl = "${contextPath}/plan/detail/view.action?startId="+projectid;
                $('#showPlanName').attr("src",viewUrl);
                $('#planName').window('open');
            }

            $('#planName').window({
                width:950,
                height:450,
                modal:true,
                collapsible:false,
                maximizable:true,
                minimizable:false,
                closed:true
            });

            function openViewMiddle(id){
                var openViewUrl = "${contextPath}/proledger/problem/viewMiddle.action?id="+id;
                $('#openViewMiddle').attr("src",openViewUrl);
                $('#viewMiddle').window('open');
            }
            $('#viewMiddle').window({
                width:950,
                height:450,
                modal:true,
                collapsible:false,
                maximizable:true,
                minimizable:false,
                closed:true
            });

            function doSearch(){
                $('#yearList').datagrid({
                    queryParams:form2Json('searchForm')
                });
                $('#dlgSearch').dialog('close');
            }
            /*
            * 取消
            */
            function doCancel(){
                $('#dlgSearch').dialog('close');
            }
            /**
             重置
             */
            function restal(){
                resetForm('searchForm');
                // doSearch();
            }

			function freshGrid(){
				$('#dlgSearch').dialog('open');
			}

			function planName(id, w_plan_name){
				var viewUrl = "${contextPath}/plan/year/viewBU.action?selectedTab=yearDetailListDiv&crudId="+id;
				aud$openNewTab( w_plan_name,viewUrl,false);
			}

            function planNameSyOff(title, id, startId, processCode) {
                var url = "${contextPath}/plan/detail/viewProcess.action?projectId=" + id + "&startId=" + startId + "&processCode=" + processCode;
                aud$openNewTab("离线-" + title, url, true);
            }

            function goProjectMenu(projectid,prepare_closed,actualize_closed,report_closed,archives_closed,planProcess){
                var stage = "";
                if(planProcess == 'simplified'){
                    stage = 'simplified';
                }else {
                    if (prepare_closed && prepare_closed == '0') {
                        stage = "prepare";
                    } else if (actualize_closed && actualize_closed == '0') {
                        stage = "actualize";
                    } else if (report_closed && report_closed == '0') {
                        stage = "report";
                    } else if (archives_closed && archives_closed == '0') {
                        stage = "archives";
                    }else{
                        stage = "prepare";
                    }
                }
                var isMyProject = null;
                jQuery.ajax({
                    url:'${contextPath}/project/prepare/isMyProject.action',
                    type:'POST',
                    data:{"crudId":projectid},
                    dataType:'json',
                    async:'false',
                    success:function(data){
                        var udswin = window.open(
                            '${contextPath}/project/prepare/projectIndex.action?crudId='
                            + projectid + '&stage=' + stage + '&source=view&projectview=view&isView=2&view=view', '',
                            'height=700px, width=1300px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no');
                        udswin.moveTo(0, 0);
                        udswin.resizeTo(window.screen.availWidth, window.screen.availHeight);
                    },
                    error:function(){
                    }
                });
            }
			
			$(function(){
				var bodyW = $('body').width();
				//查询
				showWin('dlgSearch');
				loadSelectH();
				// 初始化生成表格
				$('#yearList').datagrid({
					url : "<%=request.getContextPath()%>/Leadershipinquiry/problemRectifyCountByFwAndNd.action?querySource=grid&proyear=${param.proyear}&sjdw=${param.sjdw}&t="+new Date().getTime() ,
					method:'post',
					showFooter:false,
					rownumbers:true,
					pagination:true,
					striped:true,
					autoRowHeight:false,
					fit: true,
					pageSize: 20,
					fitColumns:true,
					idField:'formId',
					border:false,
					singleSelect:true,
					remoteSort: true,
                    toolbar:[{
                        id:'search',
                        text:'查询',
                        iconCls:'icon-search',
                        handler:function(){
                            searchWindShow('dlgSearch',750);
                        }
                    }
                    ],
					onLoadSuccess:function(){
						initHelpBtn();
					},
                    frozenColumns:[[
                        {field:'is_closed',title:'是否关闭',width:'80px',align:'center',sortable:true,
                            formatter:function(value ,rowData,rowIndex){
                                if(rowData.is_closed=='是'){
                                    return '是';
                                }else{
                                    return '否';
                                }
                            }
                        },
                        {field:'project_name',title:'项目名称',width:bodyW * 0.1 + 'px',sortable:true,halign:'center',align:'left',
                            formatter:function(value,row,index){
                                return '<a href=\"javascript:void(0)\" onclick=\"openMsg(\''+row.project_id+'\');\">'+value+'</a>';
                            }
                        },
                        {field:'f_mend_opinion_name',title:'整改状态评价',width:bodyW * 0.1 + 'px',sortable:true,halign:'center',align:'center',

                            formatter:function(value,rowData,rowIndex){
                                if(value == '未整改'){
                                    return  ["<label style='cursor:hand;color:red;'>",value,"</label>"].join('') ;
                                }else if(value == '部分整改'){
                                    return  ["<label style='cursor:hand;color:blue;'>",value,"</label>"].join('') ;
                                }else{
                                    return value;
                                }
                            }
                        }
                    ]],
                    columns:[[
                        {field:'serial_num',
                            title:'审计问题编号',
                            width:bodyW * 0.08 + 'px',
                            halign:'center',
                            align:'left',
                            sortable:true,
                            formatter:function(value,rowData,rowIndex){
                                return '<a href=\"javascript:void(0)\" onclick=\"openViewMiddle(\''+rowData.id+'\');\">'+value+'</a>';
                            }},
                        {field:'audit_con',
                            title:'问题标题',
                            sortable:true,
                            width:bodyW * 0.08 + 'px',
                            halign:'center',
                            align:'left'
                        },
                        {field:'describe',
                            title:'问题描述',
                            sortable:true,
                            width:bodyW * 0.08 + 'px',
                            halign:'center',
                            align:'left'
                        },
                        {field:'sort_big_name',
                            title:'问题类别',
                            width:bodyW * 0.08 + 'px',
                            halign:'center',
                            align:'left',
                            sortable:true
                        },
                        {field:'problem_name',
                            title:'问题点',
                            width:bodyW * 0.08 + 'px',
                            halign:'center',
                            align:'left',
                            sortable:true
                        },
                        {field:'problem_money',
                            title:'发生金额（万元）',
                            width:bodyW * 0.08 + 'px',
                            halign:'center',
                            align:'right',
                            sortable:true,
							formatter:aud$gridFormatMoney
                        },
                        {field:'problemCount',
                            title:'发生数量（个）',
                            width:bodyW * 0.08 + 'px',
                            halign:'center',
                            align:'right',
                            sortable:true
                            ,formatter:function (value,rowData,rowIndex) {
                                if (value == null){
                                    return '0';
                                }else{
                                    return value;
                                }
                            }
                        },
                        {field:'audit_object_name',
                            title:'被审计单位',
                            width:bodyW * 0.08 + 'px',
                            halign:'center',
                            align:'left',
                            sortable:true
                        },
                        {field:'audit_dept_name',
                            title:'审计单位',
                            width:bodyW * 0.08 + 'px',
                            halign:'center',
                            align:'left',
                            sortable:true
                        },
                      /*   {field:'zeren_dept',
                            title:'整改责任部门',
                            width:bodyW * 0.08 + 'px',
                            halign:'center',
                            align:'left',
                            sortable:true
                        }, */
                        {field:'zeren_company',
                            title:'责任单位',
                            width:bodyW * 0.08 + 'px',
                            halign:'center',
                            align:'left',
                            sortable:true
                        },
             /*            {field:'zeren_person',
                            title:'整改负责人',
                            width:bodyW * 0.08 + 'px',
                            halign:'center',
                            align:'left',
                            sortable:true
                        },
                        {field:'mend_method',
                            title:'整改方式',
                            width:bodyW * 0.08 + 'px',
                            halign:'center',
                            align:'left',
                            sortable:true
                        },
                        {field:'examine_method',
                            title:'检查方式',
                            width:bodyW * 0.08 + 'px',
                            halign:'center',
                            align:'left',
                            sortable:true
                        }, */
                        {field:'tracker_name',
                            title:'跟踪人',
                            width:bodyW * 0.08 + 'px',
                            halign:'center',
                            align:'left',
                            sortable:true
                        },
                        {field:'closer_name',
                            title:'关闭人',
                            width:bodyW * 0.08 + 'px',
                            halign:'center',
                            align:'left',
                            sortable:true
                        }
                    ]]
                });
				//单元格tooltip提示
				$('#yearList').datagrid('doCellTip', {
					onlyShowInterrupt:true,
					position : 'bottom',
					maxWidth : '200px',
					tipStyler : {
						'backgroundColor' : '#EFF5FF',
						borderColor : '#95B8E7',
						boxShadow : '1px 1px 3px #292929'
					}
				});
            });
		</script>

	</body>
</html>