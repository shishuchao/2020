<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>项目穿透页面</title>
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
			<s:form id="searchForm" name="searchForm" action="projectCountByFwAndNd" namespace="/Leadershipinquiry" method="post">
				<s:token/>
				<table cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
					<tr >
						<td class="EditHead">
							当前阶段
						</td>
						<td class="editTd" >
							<select class="easyui-combobox" data-options="panelHeight:'auto'" name="status"  editable="false">
								<option value="">请选择</option>
								<s:if test="${projectStep == ''}">
									<s:iterator value="#@java.util.LinkedHashMap@{'准备':'准备','实施':'实施','归档':'归档','整改':'整改','完结':'完结'}" id="entry">
										<option value="<s:property value="key"/>"><s:property value="value"/></option>
									</s:iterator>
								</s:if>
								<s:elseif test="${projectStep == '1'}">
									<s:iterator value="#@java.util.LinkedHashMap@{'准备':'准备','实施':'实施','归档':'归档'}" id="entry">
										<option value="<s:property value="key"/>"><s:property value="value"/></option>
									</s:iterator>
								</s:elseif>
								<s:else>
									<s:iterator value="#@java.util.LinkedHashMap@{'${projectStep}':'${projectStep}'}" id="entry">
										<option value="<s:property value="key"/>"><s:property value="value"/></option>
									</s:iterator>
								</s:else>
							</select>
						</td>
						<td class="EditHead">审计单位</td>
						<td class="editTd" colspan="3">
							<s:buttonText cssClass="noborder"
										  name="searchSjdw" size="15"
										  hiddenName="hidenSjdw"
										  doubleOnclick="showSysTree(this,
									{url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action',
           											title:'请选择审计单位',
                             						param:{
                               							'p_item':3
                             								},
                              						checkbox:false
         											})"
										  doubleSrc="/easyui/1.4/themes/icons/search.png"
										  doubleCssStyle="cursor:hand;border:0" readonly="true" />
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
		<script type="text/javascript">
			function freshGrid(){
				$('#dlgSearch').dialog('open');
			}

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

			function planName(id, w_plan_name){
				var viewUrl = "${contextPath}/plan/year/viewBU.action?selectedTab=yearDetailListDiv&crudId="+id;
				aud$openNewTab( w_plan_name,viewUrl,false);
			}

            function planNameSyOff(title, id, startId, processCode) {
                //var url = "${contextPath}/plan/detail/view.action?crudId=" + id;
                var url = "${contextPath}/plan/detail/viewProcess.action?projectId=" + id + "&startId=" + startId + "&processCode=" + processCode;
                aud$openNewTab("离线-" + title, url, true);
            }
            function planNameHistory(title, id, project_id) {
              //  var url = "${contextPath}/plan/detail/viewProcess.action?projectId=" + id + "&startId=" + startId + "&processCode=" + processCode;
               var url = '${contextPath}/archives/pigeonhole/editHistoryProject.action?noBack=1&project_id='+project_id;
                aud$openNewTab("补录-" + title, url, true);
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
					url : "<%=request.getContextPath()%>/Leadershipinquiry/projectCountByFwAndNd.action?querySource=grid&xmslpm=${param.xmslpm}&zsxm=${param.zsxm}&proyear=${param.proyear}&sjdw=${param.sjdw}&step=${param.step}&type=${type}&busJtbb=${busJtbb}&ssxmjdtj=${ssxmjdtj}&t="+new Date().getTime() ,
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
					columns:[[
                        {field:'is_closed',title:'状态',halign:'center',align:'center',sortable:true, width:0.06*bodyW+'px',
                            formatter:function(value,rowData,rowIndex){

                            if(rowData.xmType == 'syOff'){
                                if(rowData.processName == '已完成'){
                                    return "已完结";
								}
							}else{
                                if(rowData.rework_closed == '1') {
                                    return "已完结";
                                } else {
                                    if(rowData.is_closed == 'closed'){
                                        return '已关闭';
                                    }else if(rowData.is_closed == 'running'){
                                        return '进行中';
                                    }
                                }
							}
                                return '进行中';
                            }
                        },
                        {field:'project_name',
                            title:'项目名称',
                            width:0.25*bodyW+'px',
                            halign:'center',
                            align:'left',
                            sortable:true,
                            formatter:function(value,rowData,rowIndex){
                                if(rowData.xmType == 'syOff') {
                                    return '<a href=\"javascript:void(0)\" onclick=\"planNameSyOff(\''+rowData.project_name+'\',\''+rowData.plan_form_id+'\',\''+rowData.formId+'\',\''+rowData.processCode+'\');\">'+rowData.project_name+'</a>';
                                }else if (rowData.xmType == 'history'){
                                    return '<a href=\"javascript:void(0)\" onclick=\"planNameHistory(\''+rowData.project_name+'\',\''+rowData.plan_form_id+'\',\''+rowData.formId+'\');\">'+rowData.project_name+'</a>';
                                } else {
                                    return '<a href=\"javascript:void(0);\" onclick=\"goProjectMenu(\''+rowData.formId+'\',\''+rowData.prepare_closed+'\',\''+rowData.actualize_closed+'\',\''+rowData.report_closed+'\',\''+rowData.archives_closed+'\',\''+rowData.planProcess+'\');\" >'+value+'</a>';
                                }

                            }
                        },
                        {field:'project_code',title:'项目编号',width:0.1*bodyW+'px',sortable:true,halign:'center',align:'left'},
                        {field:'pro_year',
                            title:'项目年度',
                            halign:'center',
                            width:0.1*bodyW+'px',
                            sortable:true,
                            align:'center',
                            hidden:false,
                            formatter:function (value,rowData,rowIndex) {
                                if(value!=null)
                                    return value.substr(0,10);
                                else
                                    return "";
                            }
                        },
                        /*{field:'pro_starttime',
                            title:'开始日期',
                            halign:'center',
                            width:0.1*bodyW+'px',
                            sortable:true,
                            align:'center',
							formatter:function (value,rowData,rowIndex) {
                                if(value!=null)
                                    return value.substr(0,10);
                                else
                                    return "";
                            }
                        },*/
                        {field:'audit_dept_name',
                            title:'所属单位',
                            width:0.15*bodyW+'px',
                            halign:'center',
                            align:'left',
                            sortable:true
                        },
                        {field:'pro_type_name',
                            title:'项目类别',
                            halign:'center',
                            width:0.1*bodyW+'px',
                            align:'left',
                            sortable:true,
                            formatter:function(value,rowData,rowIndex){
                                if(rowData.pro_type_child_name != null && rowData.pro_type_child_name != '') {
                                    return rowData.pro_type_child_name;
                                } else {
                                    return value;
                                }
                            }
                        },
                        {field:'xmType',
                            title:'作业模式',
                            halign:'center',
                            width:0.06*bodyW+'px',
                            align:'center',
                            sortable:true,
                            formatter:function(value,rowData,rowIndex){
                                if(value == 'syOff') {
                                    return "离线";
                                } else if (value == 'history'){
                                	 return "补录";
                                }else{
                                	 return "在线";
                                }
                            }
                        },
                        {field:'curStep',
                            title:'当前阶段',
                            halign:'center',
                            align:'center',
                            sortable:false,
                            width:0.06*bodyW+'px',
                            formatter:function(value, rowData, rowIndex){
                                if(rowData.xmType == 'syOff') {
                                    var stagename = rowData.processName;
                                    if(stagename == null || stagename == '') {
                                        stagename = '准备';
                                    }
                                    if(stagename == '实施' || stagename == '终结') {
                                        stagename = '实施';
                                    }
                                    return stagename;
                                } else {
                                    if(rowData.prepare_closed==null || rowData.prepare_closed == '' || rowData.prepare_closed=='0'){
                                        return '准备'
                                    }
                                    if (rowData.report_closed==null || rowData.report_closed == '' || rowData.report_closed=='0'){
                                        return '实施'
                                    }
                                    if (rowData.archives_closed==null || rowData.archives_closed == '' || rowData.archives_closed=='0'){
                                        return '归档'
                                    }
                                    if (rowData.rework_closed==null || rowData.rework_closed== ''|| rowData.rework_closed=='0'){
                                        return '整改'
                                    } else {
                                        return '完结'
                                    }
                                }
                            }
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