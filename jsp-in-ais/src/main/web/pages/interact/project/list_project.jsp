<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>项目列表-项目浏览页</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
		<link href="${contextPath}/resources/css/common.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/createOrgTree.js"></script>
		<script type='text/javascript' src='<%=request.getContextPath()%>/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/engine.js'></script>
	
		<script type="text/javascript" src="<%=request.getContextPath()%>/resources/csswin/common.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/resources/csswin/subModal.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/scripts/ais_functions.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/pages/tlInteractive/tlInteractiveCommon.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/common.js"></script>
	</head>
	<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout">
	 <div id="dlgSearch" class="searchWindow">
			<div class="search_head">
			<s:form id="myform" name="myform" action="getProjectList.action" namespace="/syBasicsParse" method="post">
	         <table id="searchTable" cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
				<tr >
					<td class="EditHead" style="width:15%">
						项目名称
					</td>
					<td class="editTd" style="width:32%">
						<s:textfield cssClass="noborder" name="projectStartObject.project_name" cssStyle="width:80%" maxlength="50"/>
					</td>
					<td class="EditHead">
						被审计单位
					</td>
					<td class="editTd">
						<s:buttonText2 name="projectStartObject.audit_object_name" cssClass="noborder"
							hiddenName="projectStartObject.audit_object" cssStyle="width:80%"
							doubleOnclick="showSysTree(this,
							{ url:'${pageContext.request.contextPath}/mng/audobj/object/getAuditedDeptChildByDeptId.action',
							  param:{
							  	'departmentId':'${magOrganization.fid}'
							  },
                              cache:false,
							  checkbox:true,
							  title:'请选择被审计单位'
							})"
							doubleSrc="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png"
							doubleCssStyle="cursor:pointer;border:0" readonly="true" />
					</td>
				</tr>
			
				<tr >
					<td class="EditHead">
						项目年度
					</td>
					<td class="editTd">
						<select class="easyui-combobox" name="projectStartObject.pro_year" id="pro_year" style="width:80%"  editable="false">
							<option value="">请选择</option>
							<s:iterator value="@ais.project.ProjectUtil@getIncrementSearchYearList(10,9)" id="entry">
								<option value="<s:property value="key"/>"><s:property value="value"/></option>
							</s:iterator>
						</select>
					</td>
					<td class="EditHead">
						项目类别
					</td>
					<td class="editTd">
							<select class="easyui-combobox" data-options="panelHeight:'auto'" name="projectStartObject.pro_type" style="width:80%"  editable="false">
						       <option value="">请选择</option>
						       <s:iterator value="basicUtil.PlanProjectTypeMap4Zhongjian.keySet()" id="entry">
						         <option value="<s:property value="code"/>"><s:property value="name"/></option>
						       </s:iterator>
						    </select>	
					</td>
				</tr>
			<!-- 	<input type="hidden" name="condition" value="yes" reload="false"/> -->
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
			<table id="projectList"></table>
		</div>
		
			<div id="exportSyZipWin">
		
		<form id="exportForm"  method="post">
		  <iframe id="tmpIframe" name="tmpIframe" style='display:none'></iframe>	
			<table cellpadding=0 cellspacing=0 border=0 class="ListTable" align="center">
				<tr>
					<td align="left" class="EditHead">系统用户</td>
					<td class="editTd" align="left" colspan="3">
					 <s:buttonText2 id="pro_auditleader_name"
							hiddenId="pro_auditleader" cssClass="noborder" cssStyle="width:80%"
							name="crudObject.pro_auditleader_name" hiddenName="crudObject.pro_auditleader"
							doubleOnclick="showSysTree(this,
				          { url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action',
                            param:{
                      	   'p_item':3,
                           'orgtype':1
                                  },
                            title:'请选择系统用户',
                                  type:'treeAndEmployee'
                                  
								})"
							doubleSrc="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png"
							doubleCssStyle="cursor:pointer;border:0" readonly="true" maxlength="500" title="系统用户" /></td>
				</tr>
			</table>
		</form>
	</div>
			<!-- 审易zip压缩包导入 -->
	<div id="importSyZipWin">
		<iframe id="tmpIframe" name="tmpIframe" style='display:none'></iframe>	
		<form id="importForm"  method="post"  enctype="multipart/form-data" target='tmpIframe'>
			<table cellpadding=0 cellspacing=0 border=0 class="ListTable" align="center">
				<input type='hidden' name='fileSuffix' id='fileSuffix' value=''/>
				<tr>
					<td align="left" class="EditHead" style="vertical-align: middle;">选择文件</td>
					<td class="editTd" align="left">
						<s:file name="myfile" id='syZipFile' size="66%" cssStyle="font-size:15px" accept=".aow" />
					</td>
				</tr>
			</table>
		</form>
	</div>
		<script type="text/javascript">
	        function freshGrid(){
				$('#dlgSearch').dialog('open');
			}
			/*
			* 查询
			*/
			function doSearch(){
	        	datagrid.datagrid('options').queryParams = form2Json('myform');
				datagrid.datagrid('reload');
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
				resetForm('myform');
			}
            //导出勾选项目 
			function downloadZIP(){
            	
				var rows = datagrid.datagrid("getSelections");
				var ids = [];
				if (rows.length > 0) {
					for (var i = 0; i < rows.length; i++) {
						ids.push(rows[i].formId);
					}
					var url="${contextPath}/interact/interactProxyToWork/mutualToWork.action?loginname=${user.floginname}&downtyp=3&project_id="+encodeURI(ids);
					document.getElementById('myform').action = url;
					//frloadOpen();
                    $('#myform').submit();
				}else{
					showMessage1('请先勾选需要导出的项目');
				}
				
/* 				$.messager.confirm("提示","确定下发离线数据包？",function(r){
					if(r){
						var url="${contextPath}/interact/interactProxyToWork/mutualToWork.action?loginname=${user.floginname}&projectCode="+encodeURI(projectCode)+"&projectName="+encodeURI(projectName);
						download.action=url;
						download.submit();
					}
				}); */
			}
			var datagrid;
			$(function(){
				var bodyW = $('body').width();
				showWin('dlgSearch');
				var d = new Date();
				//$('#pro_year').combobox('setValue',d.getFullYear());
			    // 初始化生成表格
				datagrid = $('#projectList').datagrid({
				    url:"<%=request.getContextPath()%>/syBasicsParse/getProjectList.action?querySource=grid",
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
					remoteSort: false,
					toolbar:[{
							id:'search',
							text:'查询',
							iconCls:'icon-search',
							handler:function(){
								searchWindShow('dlgSearch');
							}
						},/* '-',
						{
							id:'toBase',
							text:'下载基础信息',
							iconCls:'icon-export',
							handler:function(){
								exportBase();
							}
						}, */'-',
                        {
                            id:'toExcel',
                            text:'下载项目离线包',
                            iconCls:'icon-export',
                            handler:function(){
                            	//downloadZIP();
				              var rows = datagrid.datagrid("getSelections");
              				  if (rows.length == 0) {
              					showMessage1('请先勾选需要导出的项目');
              					return false;
				               }
                            	$('#exportSyZipWin').window('open');
                            }
                        },'-',
                        {
                            id:'toExcel',
                            text:'回传项目成果',
                            iconCls:'icon-export',
                            handler:function(){
                                //exportAllProject();
                            	$('#importSyZipWin').window('open');
                            }
                        },'-',helpBtn
					],
					onLoadSuccess:function(){
						initHelpBtn();
					},
					onClickCell:function(rowIndex, field, value) {
						if(field == 'project_name') {
							var rows = $('#projectList').datagrid('getRows');
							var row = rows[rowIndex];
							goProjectMenu(row.formId,row.project_name);
						}
					},
					frozenColumns:[[
									{field:'formId',width:0.01*bodyW+'px', checkbox:true,halign:'center', align:'center'},
					       			{field:'interactStatusName',title:'交互状态',halign:'center',align:'center',sortable:true, width:0.1*bodyW+'px',},
						{field:'project_name',
							title:'项目名称',
							width:0.25*bodyW+'px',
							halign:'center',
							align:'left',
							sortable:true,
							formatter:function(value,rowData,rowIndex){
								result = ["<label title='单击查看' style='cursor:pointer;color:blue;'>",value,"</label>"].join('') ;
								return result;
							   }},
						{field:'project_code',title:'项目编号',width:'10%',sortable:true,halign:'center',align:'left'}
					    		]],
					columns:[[
						{field:'pro_year',
							title:'项目年度',
							halign:'center',
							width:0.1*bodyW+'px',
							sortable:true, 
							align:'center'
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
						{field:'audit_dept_name',
							 title:'所属单位',
							 width:0.1*bodyW+'px',
							 halign:'center',
							 align:'left', 
							 sortable:true
						},
						{field:'audit_object_name',
							title:'被审计单位',
							width:0.1*bodyW+'px',
							halign:'center',
							align:'left',
							sortable:true
						},
						{field:'pro_teamleader_name',
							title:'组长',
							width:0.1*bodyW+'px',
							halign:'center',
							align:'center',
							sortable:true
						},
						{field:'pro_auditleader_name',
							title:'主审',
							width:0.1*bodyW+'px',
							halign:'center',
							align:'center',
							sortable:true
						},
						{field:'interactDownTime',
							title:'下载时间',
							width:0.15*bodyW+'px',
							halign:'center',
							align:'center',
							sortable:true
						},
						{field:'interactUpTime',
							title:'被回传时间',
							width:0.15*bodyW+'px',
							halign:'center',
							align:'center',
							sortable:true
						}
					]]
				});
				//单元格tooltip提示
				$('#projectList').datagrid('doCellTip', {
					onlyShowInterrupt : true,
					position : 'bottom',
					maxWidth : '200px',
					tipStyler : {
						'backgroundColor' : '#EFF5FF',
						borderColor : '#95B8E7',
						boxShadow : '1px 1px 3px #292929'
					}
				
				});
				
				
				$('#exportSyZipWin').dialog({
				    title: "下载项目离线包",    
				    width:  "700px",
				    height: "150px",
				    closed: true,    
				    cache:  false, 
				    shadow: false, 
				    modal: true,
				    resizable:true,
				    minimizable:false,
				    maximizable:true,
				    iconCls:'icon-export',
				    buttons:[{
						text:'下载离线包',
						iconCls:'icon-export',
						handler:function(){
							exportZipFile();
						}
					}, {
						text:'清空',
						iconCls:'icon-empty',
						handler:function(){
							clearEmployee();
						}
					}, {
						text:'关闭',
						iconCls:'icon-cancel',
						handler:function(){
							clearEmployee();
							$('#exportSyZipWin').dialog('close');
						}
					}]
				});
				
				$('#importSyZipWin').dialog({
				    title: "回传项目成果",    
				    width:  "700px",    
				    height: "150px",    
				    closed: true,    
				    cache:  false, 
				    shadow: false, 
				    modal: true,
				    resizable:true,
				    minimizable:false,
				    maximizable:true,
				    iconCls:'icon-import',
				    onOpen:function(){
				    	clearTemplateFile();
				    },
				    buttons:[/* {
						text:'覆盖导入文件',
						iconCls:'icon-import',
						handler:function(){
							importZipFile(true);
						}
					}, */{
						text:'导入文件',
						iconCls:'icon-import',
						handler:function(){
							importZipFile(false);
						}
					},{
						text:'清空',
						iconCls:'icon-empty',
						handler:function(){
							clearTemplateFile();
						}
					},{
						text:'关闭',
						iconCls:'icon-cancel',
						handler:function(){
							clearTemplateFile();
							$('#importSyZipWin').dialog('close');
						}
					}]
				});
				
			});
			function goProjectMenu(projectId,project_name){
				var addSjwtUrl  = '${contextPath}/syBasicsParse/projectDetail.action?project_id=' + projectId ;
				aud$openNewTab(project_name+'-查看',addSjwtUrl,false);
				//window.parent.addTab('tabs','查看项目','tempframe',addSjwtUrl,true);
			}

			function exportBase() {
				var addSjwtUrl  = '${contextPath}/syBasicsParse/showExportBaseInfo.action';
				aud$openNewTab('基础信息',addSjwtUrl,true);
			}
			
			

			// 清空文件选择框
			function clearTemplateFile(){
				$('#fileSuffix').val('');
				var syZipFile = $('#syZipFile')[0];
				syZipFile.outerHTML = syZipFile.outerHTML;
				$('#syZipFile').unbind('change').bind('change', function(){
					 aud$checkFile();
				});
			}
			
			// 上传文件检查
			function aud$checkFile(){
				var filePath = $('#syZipFile').val();
		    	var arr = filePath.split('.');
		    	var suffix = arr[arr.length - 1];
		    	if(suffix && suffix.toLowerCase() != 'aow'){
		    		top.$.messager.alert('系统提示','导入文件后缀名错误，请导入 后缀为aow的文件！','warning');		
		    		return false;
		    	}else{
		    		$('#fileSuffix').val(suffix);
		    		return true;
		    	}
			}
			
			// zip文件导入响应事件
			function importZipFile(flag){
				var syZipFile = $('#syZipFile').val();
				if(syZipFile == ''){
					top.$.messager.alert('系统提示',"请先选择要导入的文件",'warning');			
					return;
				}
				if(!aud$checkFile()){
					return;
				}
				if (flag){
					top.$.messager.confirm('提示','确定覆盖原上传文件吗？',function(r){
					      if ( r ){
					    	  importZipFileSubmit("cover")
					      }
					   })
				}else{
					importZipFileSubmit("");
				}

			}
			
			function importZipFileSubmit(parseSyCover){
				$("#importForm").form('submit',{
					//url:'${contextPath}/syProjectParse/parseSyZip.action',
					url:'${contextPath}/interact/interactProxyToWork/mutualToManage.action?parseSyZip=zip&parseSyCover='+parseSyCover,
					onSubmit:function(){
						try{
							aud$loadOpen();	
						}catch(e){}
					},
					success:function(data){
						try{
							$('#projectList').datagrid("reload");
							aud$loadClose();
						}catch(e){}
					}
				});
			}
			
			function clickCell(index, field){
				var subView = parent.isView;
				subView = subView != null ? subView : isView;
				isView = subView;
				if(!isView){
					if(endEditing()){
						editAndSelect(index, field);				
					}else{
						$('#'+busGridTableId).datagrid('selectRow', editIndex);
					}
				}
			}
			function clearEmployee(){
				$('#pro_auditleader').val('');
				$('#pro_auditleader_name').val('');
			}
			function exportZipFile(){
				var varEmployee =$('#pro_auditleader').val();
				var rows = datagrid.datagrid("getSelections");
				var ids = [];
				var projectName = "";
				if (rows.length > 0) {
					for (var i = 0; i < rows.length; i++) {
						ids.push(rows[i].formId);
						
					}
					if ( rows.length > 1){
						projectName = rows[0].project_name+"等项目";
					}else{
						projectName = rows[0].project_name;
					}
					$('#exportSyZipWin').dialog('close');
					 var vurl="${contextPath}/interact/interactProxyToWork/mutualToWork.action?loginname=${user.floginname}&downtype=3&strEmployee="+varEmployee+"&projectName="+encodeURI(projectName)+"&project_id="+encodeURI(ids);

			         $.ajax({
                         url : "<%=request.getContextPath()%>/syBasicsParse/updateProject.action?ids="+ids,
                         type: "post",
                         async:false,
                         success: function(data){	
                        	 $('#projectList').datagrid("reload");
                        	//datagrid.datagrid("reload");
                     		$("#myform").form('submit',{
        						url:vurl,
        						onSubmit:function(){
        							try{
        							//	aud$loadOpen();	
        							}catch(e){}
        						},
        						success:function(data){
        							try{
        								/* alert(123)
        								aud$loadClose(); */
        							}catch(e){}
        						}
        					});
                         }
                     });
					
					 /*	document.getElementById('myform').action = url;
                    $('#myform').submit(); */
			
				}else{
					showMessage1('请先勾选需要导出的项目');
				}
			}
 		</script>
	</body>
</html>
