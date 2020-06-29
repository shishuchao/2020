<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>审计问题查询列表</title>
	<link href="${contextPath}/resources/css/common.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
	<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
	<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
	<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
	<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
	<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
</head>
<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout">
<div id="list_decide_seac" class="searchWindow">
	<div class="search_head">
		<s:form name="myform"  id ="myform" action="listSjProblem" namespace="/archives/workprogram/pigeonhole" method="post">
			<table id="searchTable" cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
				<tr>
					<td class="EditHead" style="width:15%">项目名称</td>
					<td class="editTd" style="width:35%">
						<s:textfield cssClass="noborder" name="middleLedgerProblem.project_name" maxlength="50" cssStyle="width:80%"/>
					</td>

					<td class="EditHead">审计单位</td>
					<td class="editTd">
						<s:buttonText2 name="middleLedgerProblem.audit_dept_name" cssClass="noborder" cssStyle="width:71.5%"
									   hiddenName="middleLedgerProblem.audit_dept"
									   doubleOnclick="showSysTree(this,
								{url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action',
								  title:'请选择审计单位',
                                  param:{
                                    'p_item':3
                                  },
                                   checkbox:true
								})"
								doubleSrc="${contextPath }/easyui/1.4/themes/icons/search.png"
								doubleCssStyle="cursor:hand;border:0" readonly="true" />
					</td>
				</tr>
				<tr>
					<td class="EditHead">被审计单位</td>
					<td class="editTd">
						<s:textfield cssClass="noborder" name="middleLedgerProblem.audit_object_name"  id="audit_object_name" cssStyle="width:71.5%" readonly="true" maxlength="100"/>
						<input type="hidden" id="audit_object" name="middleLedgerProblem.audit_object">
						<!--完善信息操作不可修改-->
							<img style="cursor:pointer;border:0" src="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png"
								 onclick="showSysTree(this,
										 { url:'${pageContext.request.contextPath}/mng/audobj/object/getAuditedDeptChildByDeptId.action',
										 param:{
										 'departmentId':'${magOrganization.fid}'
										 },
										 cache:false,
										 checkbox:true,
										 title:'请选择被审计单位'
										 })"/>
					</td>
					<td class="EditHead">项目类别</td>
					<td class="editTd">
						<s:buttonText name="middleLedgerProblem.pro_type_name" cssClass="noborder"
									  hiddenName="middleLedgerProblem.pro_type" cssStyle="width:71.5%"
									  doubleOnclick="getItem('/pages/basic/code_name_tree_select.jsp','&nbsp;请选择项目类别',500,400)"
									  doubleSrc="/easyui/1.4/themes/icons/search.png"
									  doubleCssStyle="cursor:hand;border:0" readonly="true"
									  doubleDisabled="false" />
						<input type="hidden" name="middleLedgerProblem.pro_type_child" value=""/>

					</td>
				</tr>
				<tr>
					<td class="EditHead">问题类别</td>
					<td class="editTd">
						<input id="sort_big_name" style="width:71.5%" class="noborder" name="middleLedgerProblem.sort_big_name" type="text" readonly/>
						<input id="sort_big_code"  name="middleLedgerProblem.sort_big_code" type="hidden"/>
						<img style="cursor: pointer;" onclick="showSysTree(this,{
					    				url:'/ais/plan/detail/problemTreeViewByAsyn.action',
					    				title:'请选择问题一级分类',
					    				param:{
					    					'oneLevel':1
					    				},
					    				 checkbox:true
									})" src="${contextPath }/easyui/1.4/themes/icons/search.png"></img>
					</td>
					<td class="EditHead">问题点</td>
					<td class="editTd">
						<input id="problem_name" class="noborder" name="middleLedgerProblem.problem_name" style="width:71.5%" type="text" readonly/>
						<input id="problem_code"  name="middleLedgerProblem.problem_code" type="hidden"/>
						<img style="cursor: pointer;" onclick="showSysTree(this,{
					    				url:'/ais/plan/detail/problemTreeViewByAsyn.action',
					    				title:'请选择问题点',
					    				checkbox:true,
					    				onlyLeafCheck : true
									})" src="${contextPath }/easyui/1.4/themes/icons/search.png"></img>
					</td>
				</tr>
				<tr>
					<td class="EditHead">项目年度</td>
					<td class="editTd">
						<select editable="false" id="w_plan_year" class="easyui-combobox" name="middleLedgerProblem.pro_year" style="width:80%" >
							<option value="">请选择</option>
							<s:iterator value="@ais.project.ProjectUtil@getIncrementSearchYearList(10,9)" id="entry">
								<option value="<s:property value="key"/>"><s:property value="value"/></option>
							</s:iterator>
						</select>
					</td>
				</tr>
			</table>
			<s:hidden id="crudIdStrings" name="crudIdStrings"/>
		</s:form>
	</div>
	<div class="serch_foot">
		<div class="search_btn">
			<a class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>
			<a class="easyui-linkbutton" data-options="iconCls:'icon-reload'" onclick="restal()">重置</a>
			<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="$('#list_decide_seac').window('close')">取消</a>
		</div>
	</div>
</div>

<div region="center">
	<table id="list"></table>
</div>
<div id="subwindow" class="easyui-window" title="" style="width:500px;height:500px;padding:5px;" closed="true">
	<div class="easyui-layout" fit="true">
		<div region="center" border="false" style="padding:10px;background:#fff;border:1px solid #ccc;">
			<iframe id="item_ifr" name="item_ifr" src="" frameborder="0" width="100%" height="100%" scrolling="auto" ></iframe>
		</div>
		<div region="south" border="false" style="text-align:right;padding:5px 0;">
			<div style="display: inline;" align="right">
				<a class="easyui-linkbutton" iconCls="icon-ok" href="javascript:void(0)" onclick="saveF()">确定</a>
				<a class="easyui-linkbutton" iconCls="icon-remove" href="javascript:void(0)" onclick="cleanF()">清空</a>
				<a class="easyui-linkbutton" iconCls="icon-cancel" href="javascript:void(0)" onclick="closeWin()">关闭</a>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
	//查询
	showWin('list_decide_seac');
	var bodyW = $('body').width();
	$(function(){

		//$('body').layout('collapse','north');
		$('#list').datagrid({
			url : "<%=request.getContextPath()%>/archives/workprogram/pigeonhole/listSjProblem.action?querySource=grid",
			method:'post',
			queryParams: form2Json('myform'),
			showFooter:true,
			rownumbers:true,
			pagination:true,
			striped:true,
			autoRowHeight:false,
			//width:'100%',
			//height:'70%',
			fit:true,
			idField:'id',
			border:false,
			singleSelect:true,
			pageSize: 20,
			remoteSort: true,
			toolbar:[{
				id:'searchObj',
				text:'查询',
				iconCls:'icon-search',
				handler:function(){
					searchWindShow('list_decide_seac');
				}
			}],
			onLoadSuccess:function(){
				doCellTipShow('list');
			},
			frozenColumns:[[
				{field:'crudIds',title:'序号',width:bodyW * 0.05 + 'px', hidden:true, align:'center'},

				{field:'project_name',title:'项目名称',width:bodyW * 0.2 + 'px',sortable:true,align:'left',halign:'center'

				},

				{field:'audit_con',title:'问题标题',width:bodyW * 0.1 + 'px',sortable:true,halign:'center',align:'left',

				}
			]],
			columns:[[
				{field:'pro_year',
					title:'项目年度',
					width:bodyW * 0.08 + 'px',
					halign:'center',
					align:'center',
					sortable:true,
				},
				{field:'pro_type_name',
					title:'项目类别',
					width:bodyW * 0.08 + 'px',
					halign:'center',
					sortable:true,
					align:'center',
					formatter:function(value,rowData,rowIndex){
						if(rowData.pro_type_child_name != null && rowData.pro_type_child_name != '') {
							return rowData.pro_type_child_name;
						} else {
							return value;
						}
					}
				},
				{field:'audit_dept_name',
					title:'审计单位',
					width:bodyW * 0.1 + 'px',
					halign:'center',
					align:'center',
					sortable:true
				},
				{field:'audit_object_name',
					title:'被审计单位',
					width:bodyW * 0.1 + 'px',
					halign:'center',
					align:'left',
					sortable:true
				},
				{field:'sort_big_name',
					title:'问题类别',
					width:bodyW * 0.08 + 'px',
					halign:'center',
					align:'center',
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
					title:'涉及金额（万元）',
					width:bodyW * 0.1 + 'px',
					halign:'center',
					align:'right',
					sortable:true,
					formatter:function(val,rowData,rowIndex){
						if(val!=null)
							return val.toFixed(2);
					}
				},
				{field:'problemCount',
					title:'问题数量（个）',
					width:bodyW * 0.08 + 'px',
					halign:'center',
					align:'center',
					sortable:true,
					formatter:function(val,rowData,rowIndex){
						if (val==null||val==''){
							val='0';
						}
						return val;
					}
				},
/*				{field:'creater_startdate',
					title:'问题所属开始日期',
					sortable:true,
					width:bodyW * 0.08 + 'px',
					halign:'center',
					align:'center',
					formatter : function(value){
						if(value!=null&value!=" "){
							var date = new Date(value);
							var y = date.getFullYear();
							var m = date.getMonth() + 1;
							var d = date.getDate();
							return y + '-' +m + '-' + d;
						}

					}
				},
				{field:'creater_enddate',
					title:'问题所属结束日期',
					sortable:true,
					width:bodyW * 0.08 + 'px',
					halign:'center',
					align:'center',
					formatter : function(value){
						if(value!=null&value!=" "){
							var date = new Date(value);
							var y = date.getFullYear();
							var m = date.getMonth() + 1;
							var d = date.getDate();
							return y + '-' +m + '-' + d;
						}

					}
				},*/
				{field:'problem_grade_name',
					title:'审计发现类型',
					width:bodyW*0.14 + 'px',
					align:'center',
					sortable:true
				},
/*				{field:'tacticRelevancy',
					title:'与本单位经营战略相关度',
					width:bodyW*0.14 + 'px',
					align:'center',
					sortable:true
				},*/
				{field:'ofsDetail',
					title:'严重程度',
					width:bodyW*0.14 + 'px',
					align:'center',
					sortable:true
				},

				{field:'zeren',
					title:'责任',
					width:bodyW * 0.08 + 'px',
					halign:'center',
					align:'center',
					sortable:true
				},
/*				{field:'occurrence',
					title:'发生频率',
					width:bodyW*0.14 + 'px',
					align:'center',
					sortable:true
				},*/
				{field:'creater_name',
					title:'问题录入人',
					width:bodyW*0.14 + 'px',
					align:'center',
					sortable:true
				},
				{field:'lp_owner',
					title:'问题发现人',
					width:bodyW*0.14 + 'px',
					align:'center',
					sortable:true
				},
				{field:'problem_date',
					title:'问题发生日期',
					width:bodyW*0.14 + 'px',
					align:'center',
					sortable:true,
					formatter : function(value){
						if(value!=null&value!=" "){
							var date = new Date(value);
							var y = date.getFullYear();
							var m = date.getMonth() + 1;
							var d = date.getDate();
							return y + '-' +m + '-' + d;
						}

					}
				},
				{field:'tracker_name',
					title:'整改跟踪人',
					width:bodyW*0.14 + 'px',
					align:'center',
					sortable:true
				},
				{field:'mend_term_date',
					title:'整改期限',
					width:bodyW*0.14 + 'px',
					align:'center',
					sortable:true
				},
				{field:'mend_result',
					title:'整改措施',
					width:bodyW*0.14 + 'px',
					align:'center',
					sortable:true
				},

				{field:'zeren_person',
					title:'整改负责人',
					width:bodyW * 0.08 + 'px',
					halign:'center',
					align:'left',
					sortable:true
				},
				{field:'f_mend_opinion_name',
					title:'整改状态',
					width:bodyW * 0.1 + 'px',
					sortable:true,
					halign:'center',
					align:'center',
					formatter:function(value,rowData,rowIndex){
						if(value == '未整改'){
							return  ["<label style='cursor:hand;color:red;'>",value,"</label>"].join('') ;
						}else if(value == '部分整改'){
							return  ["<label style='cursor:hand;color:blue;'>",value,"</label>"].join('') ;
						}else{
							return value;
						}
					}
				},
				{field:'is_closed',
					title:'是否关闭',
					width:'80px',
					halign:'center',
					align:'center',
					sortable:false,
					formatter:function(value ,rowData,rowIndex){
						if(rowData.is_closed=='是'){
							return '是';
						}else{
							return '否';
						}
					}
				}

			]]
		});
		
	
	});
	function doSearch(){
		$('#list').datagrid({
			queryParams:form2Json('myform')
		});
		$('#list_decide_seac').dialog('close');
	}
	function restal(){
		resetForm('myform');
		/*doSearch();*/
	}

	function getItem(url,title,width,height){
		$('#item_ifr').attr('src',url);
		$('#subwindow').window({
			title: title,
			width: width,
			height:height,
			modal: true,
			shadow: true,
			closed: false,
			collapsible:false,
			maximizable:false,
			minimizable:false
		});
	}
	function saveF(){
		var ayy = $('#item_ifr')[0].contentWindow.saveF();
		var ay = ayy[0].split(',');
		if(ay.length == 1){
			document.all('middleLedgerProblem.pro_type').value=ayy[0];
		}else if(ay.length == 2){
			document.all('middleLedgerProblem.pro_type_child').value=ay[0];
			document.all('middleLedgerProblem.pro_type').value=ay[1];
		}
		document.all('middleLedgerProblem.pro_type_name').value=ayy[1];
		closeWin();
	}
	function cleanF(){
		document.all('middleLedgerProblem.pro_type').value='';
		document.all('middleLedgerProblem.pro_type_name').value='';
		document.all('middleLedgerProblem.pro_type_child').value='';
		closeWin();
	}
	function closeWin(){
		$('#subwindow').window('close');
	}

</script>
<script type="text/javascript">
	// 初始化
	$(function(){
		//document.getElementsByName("audit_dept_name")[0].value = "${user.fdepname}";
		//document.getElementsByName("audit_dept")[0].value = "${user.fdepid}";
		$('#lrsjyd_div').window({
			width:500,
			height:250,
			modal:true,
			collapsible:false,
			maximizable:false,
			minimizable:false,
			closed:true
		});
		// 打开录入窗口时，清空录入框
		$('#assign_tracker').bind('click',function(){
			if(assignTracker()){
				$('#lrsjyd_div').window('open');
				clearTrackerDiv();
			}
		});
		// 关闭录入窗口
		$('#closeWinSjyd').bind('click',function(){
			$('#lrsjyd_div').window('close');
		});




		/*
        // 清空分配跟踪人表单
        function clearTrackerDiv(){
            var arr = ['tracker_name','tracker_code','tracker_date'];
            $.each(arr, function(i, ele){
                $('#'+ele).val('');
            });
            var num=Math.random();
            var rnm=Math.round(num*9000000000+1000000000);
        } */

		/* // 保存跟踪人
        $('#saveSjyd').bind('click',function(){
            var crudIdStrings = $('#crudIdStrings').val();
            $.ajax({
                dataType:'json',
                url : "${contextPath}/proledger/problem/saveTracker.action?crudIdStrings="+crudIdStrings,
						data: $('#lrsjyd_form').serialize(),
						type: "POST",
						success: function(data){
							$.messager.alert('提示信息','保存成功！','info');
						},
						error:function(data){
							$.messager.alert('提示信息','请求失败！','error');
						}
					});
				}); */

		$('#closer_div').window({
			width:500,
			height:250,
			modal:true,
			collapsible:false,
			maximizable:false,
			minimizable:false,
			closed:true
		});
		// 打开录入窗口时，清空录入框
		$('#assign_closer').bind('click',function(){
			if(assignTracker()){
				$('#closer_div').window('open');
				clearCloserDiv();
			}
		});

		/* // 清空分配关闭人表单
        function clearCloserDiv(){
            var arr = ['closer_name','closer_code'];
            $.each(arr, function(i, ele){
                $('#'+ele).val('');
            });
            var num=Math.random();
            var rnm=Math.round(num*9000000000+1000000000);
        } */
		// 关闭录入窗口
		$('#closeWinCloser').bind('click',function(){
			$('#closer_div').window('close');
		});
		$('#saveCloser').bind('click',function(){
			var crudIdStrings = $('#crudIdStrings').val();
			$.ajax({
				dataType:'json',
				url : "${contextPath}/proledger/problem/saveCloser.action?crudIdStrings="+crudIdStrings,
				data: $('#closer_form').serialize(),
				type: "POST",
				success: function(data){
					$.messager.alert('提示信息','保存成功！','info');
				},
				error:function(data){
					$.messager.alert('提示信息','请求失败！','error');
				}
			});
		});
	});

	/*
     *  打开或关闭查询面板
     */
	function triggerSearchTable(){
		var isDisplay = document.getElementById('searchTable').style.display;
		if(isDisplay==''){
			document.getElementById('searchTable').style.display='none';
		}else{
			document.getElementById('searchTable').style.display='';
		}
	}
	function assignTracker(){
		if($("input[name='crudIds']:checkbox:checked").length>0){
			var crudIdStrings = '';
			$("input[name='crudIds']:checkbox:checked").each(function(){
				crudIdStrings += $(this).val()+',';
			})
			$('#crudIdStrings').val(crudIdStrings);
			return true;
		}else{
			alert('没有选择审计问题');
			return false;
		}
	}
	function cleanForm(){
		document.getElementsByName("middleLedgerProblem.project_name")[0].value = "";
		document.getElementsByName("middleLedgerProblem.audit_dept_name")[0].value = "";
		document.getElementsByName("middleLedgerProblem.pro_type_name")[0].value = "";
		document.getElementsByName("middleLedgerProblem.pro_year")[0].value = "";
		/* 	document.getElementsByName("middleLedgerProblem.audit_dept_name")[0].value = "";
            document.getElementsByName("middleLedgerProblem.audit_dept")[0].value = "";
            document.getElementsByName("middleLedgerProblem.problem_name")[0].value = "";
            document.getElementsByName("middleLedgerProblem.problem_code")[0].value = ""; */
	}
	function openMsg(projectid){
		var viewUrl = "${contextPath}/proledger/problem/viewPro.action?crudId="+projectid;
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
	function openTrackList(id){
		var openViewUrl = "${contextPath}/proledger/problem/trackList.action?crudIdStrings="+id+"&onlyView=true";
		$('#openTrackList').attr("src",openViewUrl);
		$('#trackList').window('open');
	}
	$('#trackList').window({
		width:950,
		height:450,
		modal:true,
		collapsible:false,
		maximizable:true,
		minimizable:false,
		closed:true
	});
</script>
</body>
</html>
