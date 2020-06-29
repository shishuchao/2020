<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE HTML>
<html>
	<head>
		<title>审计人员基本信息列表2</title>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
		<link href="${contextPath}/resources/css/common.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type="text/javascript" src="${contextPath}/dwr/engine.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/pages/tlInteractive/tlInteractiveCommon.js"></script>
		<script type="text/javascript">

		$(function(){
			$('#query_div').window({
					width:800,
					height:400,
					modal:true,
					collapsible:false,
					maximizable:false,
					minimizable:false,
					closed:true
			});

		});


		function queryF(){
  		  $('#query_div').window('close');
		}

		function wait(){
			document.getElementById("submitButton").disabled = true;
			document.getElementById("layer").style.display = "";
			document.getElementById("errorInfo1").style.display = "none";
			document.getElementById("errorInfo2").style.display = "none";
			importForm.submit();
		}

		function load(){
			window.location.href="${contextPath}/templatedownload?file=employee_template.xls&&type=employee";
		}
        /*
		* 查询
		*/
		function doSearch(){
       		$('#list').datagrid({
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
			//liululu
		   /*  document.getElementsByName("employeeInfo.company")[0].value = '';
			$("#birthday1").datebox("setValue","");
			$("#birthday2").datebox("setValue","");
			$("#beginWorkDate1").datebox("setValue","");
			$("#beginWorkDate2").datebox("setValue","");
			resetForm('searchForm');
			doSearch();    */
			//document.getElementById("searchForm").reset();
			resetForm('searchForm');

		}
		function employeeInfoEditVal(id){
			$("#employeeInfo_ids").val(id);
			document.forms[0].action="employeeInfoAdd.action?id="+id;
			document.forms[0].submit();
		}

		function viewEmployeeInfo(id,listStatus){
				/* document.forms[0].action="employeeInfoView.action?employeeInfo.id="+id;
				document.forms[0].submit(); */

				var viewUrl = "${contextPath}/mng/employee/employeeInfoView.action?employeeInfo.id="+id;
			    aud$openNewTab('审计人员查看',viewUrl,true);
               /*  $('#showPlanName').attr("src",viewUrl);
                $('#planName').window('open');  */
		}
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

		function delVal(id){
			$.messager.confirm('删除','确认删除吗？',function(r){
				if (r){
					$("#employeeInfo_ids").val(id);
					document.forms[0].action="employeeInfoDelete.action?employeeInfo_ids="+id;
					document.forms[0].submit();
				}
			});
		}

		function exportEmp(){
			/*
			var rows = datagrid.datagrid("getSelections");
			var cbx_count = 0;
			var cbx_no = -1;
			for(var i=0;i<rows.length;i++){
					cbx_count++;
					cbx_no = i;
			}
			if(cbx_no==-1){
				alert("没有选择要导出的人员信息!");
				return false;
			}*/
			document.forms[1].action="exportEmp.action";
			document.forms[1].submit();
		}
		</script>
		<%String isbiz=request.getParameter("isbiz");
			if("".equals(isbiz)||isbiz==null){
				isbiz="";
			}
		 %>
	</head>
	<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout">


		<div region="center" >
			<table id="list"></table>

		</div>

		<div id="dlgSearch" class="searchWindow">
			<div class="search_head">
				<input type="hidden" name="listStatus" value="${listStatus}" id="listStatus"/>
				<s:form namespace="/mng/employee" action="employeeInfoList" id="searchForm" name="searchForm">
					<table cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
						<tr >
							<td class="EditHead" style="width:120px;">
								姓名
							</td>
							<td class="editTd" style="width:auto">
								<s:textfield  cssClass="noborder" name="employeeInfo.name" />
							</td>
							<td class="EditHead" style="width:120px;">
								最高学历
							</td>
							<td class="editTd" style="width:auto">
								<select editable="false" name="employeeInfo.diplomaCode" PanelHeight="auto">
									<option value="">&nbsp;</option>
									<s:iterator value="basicUtil.diplomaList4Search" id="enitty">
										<option value="${code}">${name }</option>
									</s:iterator>
								</select>
							</td>
						</tr>
						<tr>
							<td class="EditHead">
								职业资格
							</td>
							<td class="editTd">
								<select editable="false" name="employeeInfo.competenceCode" PanelHeight="auto">
									<option value="">&nbsp;</option>
									<s:iterator value="basicUtil.competenceList4Search" id="enitty">
										<option value="${code}">${name }</option>
									</s:iterator>
								</select>
							</td>

							<td class="EditHead">
								最高学历所学专业
							</td>
							<td class="editTd">
								<select editable="false" name="employeeInfo.specialityCode_high" PanelHeight="auto">
									<option value="">&nbsp;</option>
									<s:iterator value="basicUtil.specialtyList4Search" >
							        	<option value="${code}">${name }</option>
							       </s:iterator>
								</select>
							</td>
						</tr>
						<tr>
							<td class="EditHead">
								职称级别
							</td>
							<td class="editTd">
								<select editable="false" name="employeeInfo.technicalPostCode" class="easyui-combobox" PanelHeight="auto">
									<option value="">&nbsp;</option>
									<s:iterator value="basicUtil.technicalPostList4Search" id="enitty">
										<option value="${code}">${name }</option>
									</s:iterator>
								</select>
							</td>
							<td class="EditHead">
								职位
							</td>
							<td class="editTd">
								<select editable="false" name="employeeInfo.dutyCode" PanelHeight="auto">
									<option value="">&nbsp;</option>
									<s:iterator value="basicUtil.dutyList4Search">
										<option value="${code}">${name}</option>
									</s:iterator>
								</select>
							</td>
						</tr>
						<!--<tr class="listtablehead">

							 <TD class=listtabletr11>
								人员类型
							</TD>
							<TD class=listtabletr22>
								<s:select name="employeeInfo.typeCode" id="typeCode" headerKey="" headerValue="" list="basicUtil.typeList4Search" listKey="code" listValue="name"/>
							</TD>

						</TR>-->
						<tr>
							<td class="EditHead">
								所属单位
							</td>
							<td class="editTd">
								<s:if test="${listStatus == 'edit'}">
									<s:buttonText cssClass="noborder"  name="employeeInfo.company" id="company" hiddenId="companyCode" hiddenName="employeeInfo.companyCode"
												  doubleOnclick="showSysTree(this,
										{ url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action',
										   // json格式，url使用的参数
										   param:{
												'p_item':3,
										   },
										  checkbox:true,
										  title:'请选择所属单位',
										  // 单击确定按钮后执行清空被审计单位（根据实际业务逻辑编写相关代码）
										  onAfterSure:function(){
										    $('#companyCode').val('');
										    $('#company').val('');
										  }
										})"
												  doubleSrc="/resources/images/s_search.gif" doubleCssStyle="cursor:hand;border:0" readonly="true" doubleDisabled="false"/>
								</s:if>
								<s:else>
									<s:buttonText  cssClass="noborder"   name="employeeInfo.company" id="company" hiddenId="companyCode" hiddenName="employeeInfo.companyCode"
												   doubleOnclick="showSysTree(this,
										{ url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action',
										   // json格式，url使用的参数
										   param:{
												'p_item':3,
										  },
										  checkbox:true,
										  title:'&nbsp;&nbsp;&nbsp;请选择所属单位',
										  // 单击确定按钮后执行清空被审计单位（根据实际业务逻辑编写相关代码）
										  onAfterSure:function(){
										    $('#companyCode').val('');
										    $('#company').val('');
										  }
										})"
												   doubleSrc="/easyui/1.4/themes/icons/search.png" doubleCssStyle="cursor:hand;border:0" readonly="true" doubleDisabled="false"/>
								</s:else>
							</td>
							<td class="EditHead">
								人员状态
							</td>
							<td class="editTd">
								<select editable="false" name="employeeInfo.incumbencyStateCode" class="easyui-combobox" PanelHeight="auto">
									<option value="">&nbsp;</option>
									<s:iterator value='basicUtil.incumbencyStateList'>
										<option value="<s:property value="code"/>"> <s:property value="name"/></option>
									</s:iterator>
								</select>
							</td>
						</tr>
						<tr>
							<td class="EditHead" style="width:15%">
								出生日期
							</td>
							<td class="editTd" style="width:85%" colspan="3">
								<input type="text" editable="false" class="easyui-datebox noborder" name="employeeInfo.birthday1" id="birthday1" title="单击选择日期" />
								-
								<input type="text" editable="false" class="easyui-datebox noborder" name="employeeInfo.birthday2" id="birthday2" title="单击选择日期" />
							</td>
						</tr>
						<tr>
							<td class="EditHead">
								从事审计日期
							</td>
							<td class="editTd" colspan="3">
								<input type="text" editable="false" class="easyui-datebox noborder" name="employeeInfo.beginWorkDate1" id="beginWorkDate1" title="单击选择日期"/>
								-
								<input type="text" editable="false" class="easyui-datebox noborder" name="employeeInfo.beginWorkDate2" id="beginWorkDate2" title="单击选择日期" />
							</td>
						</tr>
					</TABLE>
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

			<div id="query_div" title="导入功能" style='overflow:hidden;padding:3px;'>
				<s:if test="${listStatus == 'edit'}">
					<s:form id="importForm" action="importEmployee.action?listStatus=${listStatus}&operate1=imoprtEmployees"	namespace="/mng/employee" method="post"	enctype="multipart/form-data" onsubmit="wait();">
							<table cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
							<tr >
								<td align="left" class="EditHead" colspan="4">
									<font style="float: left;">批量人员导入</font>
								</td>
							</tr>
							<tr>
								<td align="left" class="EditHead">
									选择文件
								</td>
								<td class="editTd" align="left" style="width:55%;">
									<s:file name="template"  cssStyle="font-size:15px;width:200px;height=6px"/>&nbsp;&nbsp;&nbsp;&nbsp;
									<!--<s:submit id="submitButton" value="导入审计人员"/>-->
									<a href="javascript:;" class="easyui-linkbutton" data-options="iconCls:'icon-import'" onclick="SaveLoadMoBan()">导入审计人员</a>
								</td>
								<td class="editTd" align="right">
									<!-- <input type="button" value="下载模板" onclick="load()"/> -->
									<a href="javascript:;" class="easyui-linkbutton" data-options="iconCls:'icon-download'"  onclick="load();">下载模板</a>

								</td>
							</tr>
						</table>
					</s:form>
					<div id="layer" style="display: none" align="center">
						<img src="${contextPath}/images/uploading.gif">
						<br>
						正在读取，请稍候......
					</div>
					<div align="left" id="errorInfo1">
						<s:if test="%{#tipList.size != 0}">
							<s:iterator value="%{#tipList}">
								<font color="#FF0000">&nbsp;&nbsp;&nbsp;●<s:property value="%{position}"/>：<s:property value="%{errorInfo}"/></font><br>
							</s:iterator>
						</s:if>
					</div>
					<div align="left" id="errorInfo2">
						<s:if test="%{#tipMessage != null}">
							<font color="#FF0000">&nbsp;&nbsp;&nbsp;●<s:property value="%{#tipMessage.errorInfo}"/></font>
						</s:if>
					</div>
				</s:if>
			</div>
			<div id="planName" title="审计人员基本信息" style="overflow:hidden;padding:0px">
            	<iframe id="showPlanName" src="" width="100%" title="" height="100%" frameborder="0" ></iframe>
  			</div>
	<script type="text/javascript">
		$(function(){
				<s:if test="${operate1 == 'imoprtEmployees'}">
					$('#query_div').window('open');
				</s:if>
				var bodyW = $('body').width();
				var listStatus = document.getElementById("listStatus");
				loadSelectH();
				// 初始化生成表格
				$('#list').datagrid({
					url : "<%=request.getContextPath()%>/mng/employee/employeeInfoList.action?listStatus=${listStatus}&querySource=grid",
					method:'post',
					showFooter:false,
					rownumbers:true,
					pagination:true,
					striped:true,
					autoRowHeight:false,
					fit: true,
					pageSize:10,
					pageList: [10,15,20],
					fitColumns: true,
					idField:'id',
					border:false,
					singleSelect:true,
					toolbar:[{
						id:'search',
						text:'查询',
						iconCls:'icon-search',
						handler:function(){
							searchWindShow('dlgSearch',750,350);
						}
					}
					<s:if test="${listStatus == 'edit'}">
						,'-',
					{
						id:'zj',
						text:'新增',
						iconCls:'icon-add',
						handler:function(){
							$(function(){
							window.location.href='${contextPath}/mng/employee/employeeInfoAdd.action?listStatus=${listStatus}';
							});
						}
					},'-',{
							id:'delete',
							text:'删除',
							iconCls:'icon-delete',
							handler:function(){
								var rows = $('#list').datagrid('getChecked');
								if(rows.length > 0) {
									var ids = [];
									$.each(rows, function (i) {
										ids.push(rows[i].id);
									});
									delVal(ids.join(","));
								} else {
									showMessage1("请选择数据！");
								}

							}
					},'-',
					{
						id:'toinput',
						text:'导入',
						iconCls:'icon-import',
						handler:function(){
							$('#query_div').window('open');
						}
					},'-',
					{
						id:'toExcel',
						text:'导出Excel',
						iconCls:'icon-export',
						handler:function(){
							exportEmp();
						}
					}

				</s:if>
						,'-',helpBtn
				],
					onLoadSuccess:function(){
						initHelpBtn();
					},
					onClickCell:function(rowIndex, field, value) {
						if(field == 'name') {
							var rows = $('#list').datagrid('getRows');
							var row = rows[rowIndex];
							if("${listStatus}" == 'edit') {
								employeeInfoEditVal(row.id);
							} else {
								viewEmployeeInfo(row.id,listStatus.value);
							}
						}
					},
					frozenColumns:[[
						<s:if test="${listStatus == 'edit'}">
					       			{field:'id',checkbox:true, align:'center',title:'选择'},
						</s:if>
					       			{field:'name',title:'姓名',width:bodyW*0.08+'px',halign:'center',align:'left',sortable:true,
					       				formatter:function(value,row,rowIndex){
											var result = '';
					       					if("${listStatus}" == 'edit') {
												result = ["<label title='单击编辑' style='cursor:pointer;color:blue;'>",value,"</label>"].join('');
											} else {
												result = ["<label title='单击查看' style='cursor:pointer;color:blue;'>",value,"</label>"].join('');
											}
											return result;
					       				}
									}
					    		]],
					columns:[[

						{
							field: 'personnelCode',
							title: '工号',
							width: bodyW * 0.08 + 'px',
							halign: 'center',
							align: 'center',
							sortable: true
						},
						{
							field: 'sex',
							title: '性别',
							width: 50,
							halign: 'center',
							align: 'center',
							sortable: true
						},
						{
							field: 'company',
							title: '所属单位',
							width: bodyW * 0.1 + 'px',
							halign: 'center',
							align: 'left',
							sortable: true
						},
						{
							field: 'technicalPost',
							title: '职称级别',
							width: bodyW * 0.05 + 'px',
							halign: 'center',
							align: 'center',
							sortable: true
						},
						{
							field: 'duty',
							title: '职位',
							width: bodyW * 0.05 + 'px',
							halign: 'center',
							align: 'center'
						},
						{
							field: 'birthday',
							title: '出生日期',
							width: bodyW * 0.08 + 'px',
							halign: 'center',
							align: 'center'
						},
						{
							field: 'diploma',
							title: '最高学历',
							width: bodyW * 0.07 + 'px',
							halign: 'center',
							align: 'left'
						},
						{
							field: 'speciality_high',
							title: '最高学历所学专业',
							width: bodyW * 0.1 + 'px',
							halign: 'center',
							align: 'left'
						},
						{
							field: 'graduateAcademy_high',
							title: '最高学历毕业学校',
							width: bodyW * 0.1 + 'px',
							halign: 'center',
							align: 'left'
						},
						{
							field: 'year_from_joinCorpDate',
							title: '内审从事年数',
							width: 100,
							halign: 'center',
							align: 'center',
							formatter: function (value, rowData) {
								value = rowData.joinCorpDate;
								if (value) {
									var now = new Date();
									var joinCorpDate = new Date(value);
									if (now.getTime() - joinCorpDate.getTime() > 1000 * 60 * 60 * 24) {
										var diff = diffDate(joinCorpDate, now);
										var text = '';
                                        if (diff.y && diff.y > 0) {
                                            text += diff.y + '年';
                                        }
                                        if (diff.m && diff.m > 0) {
                                            text += diff.m + '月'
                                        }
                                        if (diff.d && diff.d > 0) {
                                            text += diff.d + '天'
                                        }
										return text;
									}
								}
								return '';
							}
						},
						{
							field: 'year_from_beginWorkDate',
							title: '司龄',
							width: 100,
							halign: 'center',
							align: 'center',
							formatter: function (value, rowData) {
								value = rowData.beginWorkDate;
								if (value) {
									var now = new Date();
									var beginWorkDate = new Date(value);
									if (now.getTime() - beginWorkDate.getTime() > 1000 * 60 * 60 * 24) {
										var diff = diffDate(beginWorkDate, now);
										var text = '';
										if (diff.y && diff.y > 0) {
											text += diff.y + '年';
										}
										if (diff.m && diff.m > 0) {
											text += diff.m + '月'
										}
										if (diff.d && diff.d > 0) {
											text += diff.d + '天'
										}
										return text;
									}
								}
								return '';
							}
						},
						{
							field: 'masterfield',
							title: '精通领域',
							width: 150,
							halign: 'center',
							align: 'center'
						},
						{
							field: 'honours',
							title: '所获荣誉',
							width: 150,
							halign: 'center',
							align: 'center'
						},
						{
							field: 'qualification_names',
							title: '职业资质',
							width: 150,
							halign: 'center',
							align: 'center'
						}
						<%--<s:if test="${listStatus == 'edit'}">
						,
						{field:'operate',
							 title:'操作',
							 halign:'center',
							 align:'center',
							 sortable:false,
							 width:bodyW*0.1+'px',
							 formatter:function(value,row,index){
							 	 var param = [row.id];
								 var btn2 = "修改,employeeInfoEditVal,"+param.join(',')+"-btnrule-删除,delVal,"+param.join(',');
								 return ganerateBtn(btn2);
							 }
						}
						</s:if>--%>
					]]
				});
				showWin('dlgSearch');

			//单元格tooltip提示
			$('#list').datagrid('doCellTip', {
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
			function SaveLoadMoBan(){
				//window.location.href="${contextPath}/mng/employee/importEmployee.action?listStatus=${listStatus}";
				//document.forms[0].action="importEmployee.action?listStatus=${listStatus}";
				importForm.submit();
			}
			$(function(){
				$('#planName').window({
                    width:950,
                    height:450,
                    modal:true,
                    collapsible:false,
                    maximizable:true,
                    minimizable:false,
                    closed:true
                });
			});

		function diffDate(sDate1,sDate2){
            var result = {};
		    var days1 = (sDate1.getTime() / 3600000 / 24).toFixed();
		    var days2 = (sDate2.getTime() / 3600000 / 24).toFixed();
            var diff = days2 - days1;

            if (diff > 0) {
                result.y = (diff / 365).toFixed();
                result.m = (diff % 365 / 30).toFixed();
                result.d = diff % 365 % 30;
            }
            return result;
		}
	</script>
	</body>
</html>
