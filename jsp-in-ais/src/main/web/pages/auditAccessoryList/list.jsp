<!DOCTYPE HTML >
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>添加资料</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>
		<!--<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/datagrid-detailview.js"></script>--> 
		<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
		<script type="text/javascript" src="${contextPath}/resources/js/jquery-fileUpload.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
		<!-- 
		<script type="text/javascript"
			src="${contextPath}/scripts/swfload/uploadFile.js"></script>
		<script type="text/javascript"
			src="${pageContext.request.contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript"
			src="${pageContext.request.contextPath}/resources/csswin/subModal.js"></script>
		<script type="text/javascript"
			src="${contextPath}/scripts/ufaudTextLengthValidator.js"></script>
		<script type="text/javascript"
			src="${contextPath}/scripts/swfload/uploadFile.js"></script>
		 -->
	</head>
	<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout" fit='true' border='0'>
		<div region="center" border='0'>
			<div  id='aaUploadWin' style='padding:10px;overflow:hidden;'>
				<div id="filebtn" align='center'></div>
				<div id="filelst"></div>
				<div id="filebtnAcc" align='center'></div>
				<div id="filelstAcc"></div>
			</div>
			<table id="resultList" class="easyui-datagrid" data-options="nowrap:false">
				<thead>
				<tr>
					<th data-options="field:'auditProgram',halign:'center',align:'left',sortable:false,width:'30%'" rowspan="2">资料清单</th>
					<th data-options="field:'needDo',align:'center',sortable:false,width:'4%'" rowspan="2">必传</th>
					<!-- <th data-options="field:'checkOption',width:35,align:'center',sortable:false" rowspan="2">审核</th> -->
					<s:if test="${uploadRole!=3 and operateAuth!=3}">
						<th data-options="field:'aaid',align:'center',formatter:operateFormatter,width:'10%'" rowspan="2">操作</th>
					</s:if>
					<th colspan="2">资料列表</th>
				</tr>
				<tr>
					<th data-options="field:'template',halign:'center',formatter:templateFormatter,width:'25%'">模板列表</th>
					<th data-options="field:'acc',halign:'center',formatter:accFormatter,width:'25%'">附件列表</th>
				</tr>
				</thead>
			</table>
		</div>
		<!-- <div id="dlgbase" class="easyui-dialog" title="基础资料" closed="true" modal="true" maximizable="false" resizable="false" draggable="true" style="width:500px;height:220px;overflow:hidden">
			<iframe scrolling="auto" frameborder="0"  src="" style="width:100%;height:100%;"></iframe>
		</div>
		<div id="dlgmodal" class="easyui-dialog" title="模板管理" closed="true" modal="true" maximizable="false" resizable="false" draggable="true" style="width:1000px;height:506px;overflow:hidden">
			<iframe scrolling="auto" frameborder="0"  src="" style="width:100%;height:100%;"></iframe>
		</div>
		<div id="dlgaccs" class="easyui-dialog" title="附件管理" closed="true" modal="true" maximizable="false" resizable="false" draggable="true" style="width:1000px;height:506px;overflow:hidden">
			<iframe scrolling="auto" frameborder="0"  src="" style="width:100%;height:100%;"></iframe>
		</div>
		<div id="dlgauth" class="easyui-dialog" title="被审计单位资料授权" closed="true" modal="true" maximizable="false" resizable="false" draggable="true" style="width:600px;height:354px;overflow:hidden">
			<iframe scrolling="auto" frameborder="0"  src="" style="width:100%;height:100%;"></iframe>
		</div> -->
		<div id="dlgperson" class="easyui-dialog" title="人员信息" closed="true" modal="true" maximizable="true" resizable="true" draggable="true" style="width:800px;height:450px;overflow:hidden">
			<iframe scrolling="auto" frameborder="0"  src="" style="width:100%;height:100%;"></iframe>
		</div>
		<script type="text/javascript">
			var CurAction,CurGuid,CurAaid;
			var _curbase,_curauth;
			function closerow(index,flag) {
				if(!flag)
					$('#resultList').datagrid('reload');
		        else
		        	$('#resultList').datagrid('collapseRow',index);
			}
			function closedlg(flag) {
				$(_curbase).dialog('destroy');
				$(_curauth).dialog('destroy');
				//$('#dlgbase').dialog('close');
				//$('#dlgmodal').dialog('close');
				//$('#dlgaccs').dialog('close');
				//$('#dlg').dialog('destroy');
				if(!flag) $('#resultList').datagrid('reload');
			}
			function operateFormatter(value,row,index){
				var s='';
				<s:if test="${param.view != 'view' }">
				<s:if test="${operateAuth!=3}">
				s += '&nbsp;<a href="javascript:void(0);" style="color:blue" onclick="editAuditList(\''+row.aaid+'\',\'base\',1)">修改</a>'; //editAuditList('${aaBean.aaid}')
				</s:if>
				<s:if test="${uploadRole==1&&operateAuth==1}">
				s += '&nbsp;<a href="javascript:void(0);" style="color:blue" onclick="deleteAuditList(\''+row.aaid+'\',\'${cruProId}\')">删除</a>';
				</s:if>
				<s:if test="${operateAuth!=3}">
				<s:if test="${uploadRole==1}">
				s += '&nbsp;<a href="javascript:void(0);" style="color:blue" title=""'
						+' onclick="editAuditList(\''+row.aaid+'\',\'modal\',2)">模板上传</a>'; //editAuditList('${aaBean.aaid}')
				//s += '<div id="mobanbtn'+index+'"></div><div id="mobanlst'+index+'" class="easyui-fileUpload"  data-options="fileGuid:\''+row.aaid+'\',uploadFace:1,triggerId:\'mobanbtn'+index+'\',echoType:2"></div>'
				s += '<br>'
				</s:if>
				</s:if>
				</s:if>
				return s;
			}
			function templateFormatter(value,row,index){
				var files = row.templateList;
				if (files.length==0) {
					return '';
				}
				var s='';
				var f,a,s0;
				for (var i=0;i<files.length;i++) {
					s += '<br>';
					f = files[i];
					s += '<a title="[上传人]'+f.uploader_name+'\n[上传时间]'+f.fileTime+'\n[最后修改人]'+f.remark_name+'\n[修改时间]'+f.fileEditTime+'"'
							+' href="${contextPath}/commons/file/downloadFile.action?fileId='+f.fileId+'">'+f.fileName+'</a>';
					s0 = '';
					<s:if test="${uploadRole==1 and operateAuth!=3 and view!='view'}">
					s0+=';&nbsp;[<a href="javascript:void(0);" style="color:blue;" onclick="deleteFile(\'模板\',\''+f.fileId+'\',\''+f.guid+'\',\''+row.aaid+'\')">删除</a>]';
					</s:if>
					<s:if test="${view != 'view'}">
					<s:if test="${uploadRole==1||uploadRole==3}">//&&operateAuth==1
					<s:if test="${operateAuth!=3 and pro_stage!=1}">
					//s += '&nbsp;<a href="javascript:void(0);" style="color:blue" onclick="editAuditList(\''+row.aaid+'\',\'accs\',3,\''+f.fileId+'\')">附件</a>'; //editAuditList('${aaBean.aaid}')
					//20200106
					//s0+= '&nbsp;[<a href="javascript:void(0);" style="color:blue" title="*温馨提示：\n仅支持03版excel文件汇总；excel模板只能包含标题行（其他空白单元格不能有边框等格式）。"'
					//		+' onclick="editAuditList(\''+row.aaid+'\',\'accs\',3,\''+f.fileId+'\')">附件上传</a>]'; //editAuditList('${aaBean.aaid}')
					</s:if>
					<s:if test="${uploadRole!=3 and operateAuth!=3}">
					</s:if>
					</s:if>
					</s:if>
					//if (s0!='') s += '<br>&nbsp;&nbsp;&nbsp'+s0;
					if (s0!='') s += '&nbsp;&nbsp;&nbsp'+s0;
					/* s0 = '<br>';
					<s:if test="${operateAuth==1}">
					if (f.mergerBean!=null) {
						<s:if test="${view!='view'}">
						</s:if>
					} else
						
					</s:if>
					if (s0!='') s += '&nbsp;&nbsp;&nbsp'+s0+''; */
					//if (s0!='') s += '<br>&nbsp;&nbsp;&nbsp'+s0+'<br>';
				}
				return s;
			}
			function accFormatter(value,row,index){
				//20200106
				/* var files = row.templateList;
				if (files.length==0) {
					return '';
				} */
				var s='';
				var accs = row.accessoryList;
				var f,a,s0;
				//20200106
				<s:if test="${view != 'view'}">
				<s:if test="${uploadRole==1||uploadRole==3}">
				<s:if test="${operateAuth!=3 and pro_stage!=1}">
					s+= '[<a href="javascript:void(0);" style="color:blue" title=""'
							+' onclick="editAuditListAcc(\''+row.aaid+'\',\'accs\',3,\'\')">附件上传</a>]<br>';
				</s:if>
				</s:if>
				</s:if>
				/* for (var i=0;i<files.length;i++) {
					f = files[i]; */
					if (accs.length>0) {
						for (var j=0;j<accs.length;j++) {
							a = accs[j];
							//20200106
							//if (a.templateId==f.fileId) {
								<s:if test="${param.view !='view' }">
								</s:if>
								s += '<a title="[上传人]'+a.uploader_name+'\n[上传时间]'+a.fileTime+'\n[最后修改人]'+a.remark_name+'\n[修改时间]'+a.fileEditTime+'"'
										+' href="${contextPath}/commons/file/downloadFile.action?fileId='+a.fileId+'">'+a.fileName+'</a>';
								//20200206  s += '<br>';
								<s:if test="${operateAuth!=3 and param.view !='view'}">
								if (a.commit_status!="Y"){
									s += '&nbsp;&nbsp;&nbsp;&nbsp;[<a href="javascript:void(0);" style="color:blue;" onclick="deleteFile(\'附件\',\'' + a.fileId + '\',\'' + a.guid + '\',\'' + row.aaid + '\')">删除</a>]';
								}
								//s += '<br>';
								</s:if>
								<s:if test="${uploadRole==1 and operateAuth!=3 and param.view !='view'}">
								//20200206  s += '&nbsp;[<a href="javascript:void(0);" style="color:blue;" onclick="auth(\''+a.fileId+'\')">资料授权</a>]<br>';
								s += '&nbsp;[<a href="javascript:void(0);" style="color:blue;" onclick="auth(\''+a.fileId+'\')">资料授权</a>]';
								</s:if>
								s += '</br>';
							//}
						}
					}
				//}
				return s;
			}
			var ieVersion = $.browser.version;
			$(function(){
				if(parseInt(ieVersion) < 10){
					// 文件上传窗口
					$('#aaUploadWin').dialog({
						'title':'文件上传',
						'closed': true,
						'width' : 200,
						'height': 100,
						'modal' : true   
					});
					
				}else{
					$('#aaUploadWin').css({
						'height':'0px',
						'display':'none'
					});
				}
				
				$('#resultList').datagrid({
					url : "${pageContext.request.contextPath}/auditAccessoryList/list.action?querySource=grid&cruProId=${cruProId}&pro_type=${pro_type}",
					method:'post',
					showFooter:false,
					rownumbers:true,
					pagination:true,
					pageSize: 20,
					striped:true,
					//autoRowHeight:true,
					fit: true,
					//fitColumns:true,
					border:false,
					singleSelect:true,
					remoteSort: false,
					onLoadSuccess:function(){
						initHelpBtn();
					},
					toolbar:[
						<s:if test="${param.view != 'view' && uploadRole==3}">
						{
							text:'提交',
							iconCls:'icon-ok',
							handler:function(){
								commitFile('${cruProId}');
							}
						},'-',
						</s:if>
						{
							text:'刷新',
							iconCls:'icon-reload',
							handler:function(){
								$('#resultList').datagrid('reload');
							}
						},'-'
						<s:if test="${param.view == 'list'}">
							,{
								text:'返回',
								iconCls:'icon-undo',
								handler:function(){
									window.location.href="${contextPath}/project/rework/listAllForAuditObjectUp.action";
								}
							},'-'
						</s:if>
				<s:if test="${param.view != 'view'}">
					<s:if test="${uploadRole==1 and operateAuth!=3 and pro_stage!=1}">
						,{
							text:'增加',
							iconCls:'icon-add',
							handler:function(){
								var url = '${contextPath}/auditAccessoryList/addAccessoryList.action?cruProId=${cruProId}&uploadRole=${uploadRole}&editIndex=0';
								var arg = {width:500,height:150,closed:true,modal:true,maximizable:false,resizable:false,draggable:false,title: '基础资料'};
								_curbase = _showDlg(arg,url);
								/*var url = '${contextPath}/auditAccessoryList/addAccessoryList.action?cruProId=${cruProId}&uploadRole=${uploadRole}&editIndex=0';
								var o=$('#dlgbase');
								//o.dialog({width:1000,height:500,maximizable:true,resizable:true,draggable:true,title: '增加被审计单位资料'});
								o[0].children[0].src=url;
								o.dialog('open');*/
							}
						},'-'
					</s:if>
					<s:if test="${uploadRole==2}">
						,{
							text:'提交审核',
							iconCls:'icon-ok',
							handler:function(){
								jQuery.ajax({
									url:'${contextPath}/auditAccessoryList/submit.action?cruProId=${cruProId}',
									type:'POST',
									async:'false',
									success:function(data){
										$('#resultList').datagrid('reload');
										$.messager.show({
											title:'消息',
											msg:'审核成功！'
										});
									}
								});
							}
						},'-'
					</s:if>
					<s:if test="${uploadRole==1 and operateAuth!=3}">
						,{
							text:'反馈账号',
							iconCls:'icon-edit',
							handler:function(){
						    	var myurl = '${contextPath}/auditAccessoryList/listSysAccount.action?projectId=${cruProId}';
						    	parent.addTab('tabs','反馈账号','tempAccount',myurl,true);
								/*var url = '${contextPath}/auditAccessoryList/listSysAccount.action?projectId=${cruProId}';
								var o=$('#dlg');
								o.dialog({width:800,height:500,maximizable:false,resizable:false,draggable:false,title: '临时账号信息'});
								o[0].children[0].src=url;
								o.dialog('open');*/
							}
						},'-'
					</s:if>
				</s:if>
					,helpBtn
					]
					,loadFilter:function(data){
						if (typeof data.length == 'number' && typeof data.splice == 'function'){	// is array
							data = {
								total: data.length,
								rows: data
							}
						}
						var dg = $(this);
						var opts = dg.datagrid('options');
						var pager = dg.datagrid('getPager');
						pager.pagination({
							onSelectPage:function(pageNum, pageSize){
								opts.pageNumber = pageNum;
								opts.pageSize = pageSize;
								pager.pagination('refresh',{
									pageNumber:pageNum,
									pageSize:pageSize
								});
								dg.datagrid('loadData',data);
							}
						});
						if (!data.originalRows){
							data.originalRows = (data.rows);
						}
						var start = (opts.pageNumber-1)*parseInt(opts.pageSize);
						var end = start + parseInt(opts.pageSize);
						data.rows = (data.originalRows.slice(start, end));
						return data;
					}
				    /*,view: detailview*/
				    ,detailFormatter: function(index,row){    
				        return '<div id="ddv-' + index + '" style="padding:5px 0"></div>';    
				    }    
				    /*,onExpandRow: function(index,row){
						var dg = $(this);
				        $('#ddv-'+index).panel({
				            border:false,
				            cache:false,
				            href:'${contextPath}/auditAccessoryList/editAccessoryList.action?auditUuid='+row.aaid+'&eidtIndex='+index,
				            onLoad:function(){
				                dg.datagrid('fixDetailRowHeight',index);
				            }
				        });
				        dg.datagrid('fixDetailRowHeight',index);
				    }*/
				}); 
				$('#dlgmodal').dialog({
					onClose:function(){
						$('#resultList').datagrid('reload');
					}
				});
				$('#dlgaccs').dialog({
					onClose:function(){
						$('#resultList').datagrid('reload');
					}
				});
				$('#filelst').fileUpload({
					fileGuid:'-1',
					uploadFace:1,
					isDel:false,
					isEdit:false,
					isDownload:false,
					isView:false,
					triggerId:'filebtn',
					echoType:3,
					callbackGridHeight:1,
					onFileSubmitSuccess:function(data,options){
						if(parseInt(ieVersion) < 10){
							// 文件上传窗口
							$('#aaUploadWin').dialog('close');								
						}
						jQuery.ajax({
							url:'${contextPath}/auditAccessoryList/'+CurAction,
							type:'POST',
							data:{"savetype":"new","guid":CurGuid,"aaid":CurAaid},
							dataType:'json',
							async:'false',
							success:function(data){
								//$.messager.show({
								//	title:'提示信息',
								//	msg:'上传成功！'
								//});
								
								$('#resultList').datagrid('reload');
							},
							error:function(){
								$('#resultList').datagrid('reload');
							}
						});
					}
				});
				$('#filelstAcc').fileUpload({
					fileGuid:'-2',
					uploadFace:1,
					isDel:false,
					isEdit:false,
					isDownload:false,
					isView:false,
					triggerId:'filebtnAcc',
					echoType:3,
					callbackGridHeight:1,
					onFileSubmitSuccess:function(data,options){
						if(parseInt(ieVersion) < 10){
							// 文件上传窗口
							$('#aaUploadWin').dialog('close');
						}
						jQuery.ajax({
							url:'${contextPath}/auditAccessoryList/'+CurAction,
							type:'POST',
							data:{"savetype":"new","guid":CurGuid,"aaid":CurAaid},
							dataType:'json',
							async:'false',
							success:function(data){
								$('#resultList').datagrid('reload');
							},
							error:function(){
								$('#resultList').datagrid('reload');
							}
						});
					}
				});
				
			});

		    /*function editAuditList(index) {
				var dg = $('#resultList');
				if (dg.datagrid('isExpandRow',index))
			        dg.datagrid('collapseRow',index);
				else {
					for (var i=0;i<dg.datagrid('getRows').length;i++)
						if (dg.datagrid('isExpandRow',i))
			        		dg.datagrid('collapseRow',i);
			        dg.datagrid('expandRow',index);
			    }
		    }*/
		    
		    
		    function editAuditList(aaid,showtype,editIndex,mid) {
		    	if(!mid) mid=aaid;
		    	if(editIndex==0||editIndex==1){
		    	}else{
		    		//editIndex=editIndex+mid;
					if (editIndex==2)
						CurAction='saveTemplate.action';
					else
						CurAction='saveAccessory.action';
		    		CurGuid = mid;
		    		CurAaid=aaid;
		    		$('#filelst').fileUpload('property','fileGuid',CurGuid);
		    		if(parseInt(ieVersion) < 10){
		    			$('#aaUploadWin').dialog('open');
		    		}else{
		    			$('#filebtn').find(".icon-addFile").trigger("click");
		    		}
		    		toolbar:[
								{
									text:'刷新',
									iconCls:'icon-reload',
									handler:function(){
										$('#resultList').datagrid('reload');
									}
								},'-',helpBtn
							]
		    		return;
		    	}
				var url = '${contextPath}/auditAccessoryList/editAccessoryList.action?auditUuid='+aaid+'&editIndex='+editIndex;
				var arg = {width:500,height:150,closed:true,modal:true,maximizable:false,resizable:false,draggable:false,title: '基础资料'};
				_curbase = _showDlg(arg,url);
				/*var url = '${contextPath}/auditAccessoryList/editAccessoryList.action?auditUuid='+aaid+'&editIndex='+editIndex;
				var o=$('#dlg'+showtype);
				//o.dialog({width:550,height:300});
				o[0].children[0].src=url;
				o.dialog('open');*/
				
		    }
		    function editAuditListAcc(aaid,showtype,editIndex,mid) {
		    	if(!mid) mid=aaid;
		    	if(editIndex==0||editIndex==1){
		    	}else{
		    		CurAction='saveAccessory.action';
		    		CurGuid = mid;
		    		CurAaid=aaid;
		    		$('#filelstAcc').fileUpload('property','fileGuid',CurGuid);
		    		if(parseInt(ieVersion) < 10){
		    			$('#aaUploadWin').dialog('open');
		    		}else{
						$('#filebtnAcc').find(".icon-addFile").trigger("click");
		    		}
		    		toolbar:[
								{
									text:'刷新',
									iconCls:'icon-reload',
									handler:function(){
										$('#resultList').datagrid('reload');
									}
								},'-',helpBtn
							]
		    		return;
		    	}
				var url = '${contextPath}/auditAccessoryList/editAccessoryList.action?auditUuid='+aaid+'&editIndex='+editIndex;
				var arg = {width:500,height:150,closed:true,modal:true,maximizable:false,resizable:false,draggable:false,title: '基础资料'};
				_curbase = _showDlg(arg,url);

		    }

		    function deleteAuditList(uuid,cruProId) {
				$.messager.confirm('确认', '确认删除资料清单吗（将同时删除对应的模板和附件）？', function(r){
					if (!r) return;
					jQuery.ajax({
						url:'${contextPath}/auditAccessoryList/deleteAccessoryList.action?auditUuid=' + uuid+'&cruProId='+cruProId,
						type:'POST',
						async:'false',
						success:function(data){
							$('#resultList').datagrid('reload');
						}
					});
				});
		    }
	    function merge(fileId){
	    	var arr = new Array();
	    	var checked=false;//判断是否勾选资料
	    	var checkbox = document.getElementsByName("fileIds");
			for(var i=0;i<checkbox.length;i++){
				if(checkbox[i].checked){			   
			   		checked=true;
					if(checkbox[i].value.indexOf(fileId)==-1){
						$.messager.show({
							title:'消息',
							msg:'汇总的附件必须来自同一模板！'
						});
						return false;
					}
					arr.push(checkbox[i].value);
				}
			}
			if(!checked){
				$.messager.show({
					title:'消息',
					msg:'请选择要汇总的附件！'
				});
				return false;
			}
			var json = arr.join("#");
			//s += '<form action="mergeAccessory.action" namespace="/auditAccessoryList">';
			//s += '<input type="hidden" name="totalFiles" id="totalFiles" value="${totalFiles}"/>';
			//s += '<input type="hidden" name="cruProId" id="cruProId" value="${cruProId}"/>';
			//fileIds:838A6C3C-3373-CE41-C142-61BDF59107E6,DFA70757-AD64-0516-9584-C69DA350F964,Chrysanthemum.jpg
			//s += '</form>';
			//document.getElementsByName("totalFiles")[0].value=json;
			$.messager.confirm('确认', "确定要汇总吗？", function(r){
				if (r){
					jQuery.ajax({
						url:'${contextPath}/auditAccessoryList/mergeAccessory.action',
						type:'POST',
						data:{"totalFiles":json,"cruProId":'${cruProId}'},
						dataType:'json',
						async:'false',
						success:function(data){
							$.messager.show({
								title:'消息',
								msg:'汇总成功！'
							});
						},
						error:function(e){
							$.messager.show({
								title:'消息',
								msg:'汇总失败：仅支持03版的excel文件汇总；excel模板只能包含标题行，不能有边框等格式！'
							});
						}
					});
					/*$(document.forms[0]).form('submit',{
		        		onSubmit:function(){
		            		return true; //当表单验证不通过的时候 必须要return false 
		            	},
				        success:function(result){
							$.messager.show({
								title:'消息',
								msg:'汇总成功！'
							});
				        }
				    });*/
				}
			});
	    }
		function auth(accessoryId){
			var url = '${contextPath}/project/memberList.action?crudId=${cruProId}&accessoryId='+accessoryId;
			var arg = {width:600,height:354,closed:true,modal:true,maximizable:false,resizable:false,draggable:true,title: '被审计单位资料授权'};
			_curauth = _showDlg(arg,url);
			/*var url = '${contextPath}/project/memberList.action?crudId=${cruProId}&accessoryId='+accessoryId;
			var o=$('#dlgauth');
			o[0].children[0].src=url;
			o.dialog('open');*/
			//showPopWin('${pageContext.request.contextPath}/pages/auditAccessoryList/searchdatamuti.jsp?url=${contextPath}/project/memberList.action&crudId=${cruProId}&accessoryId='+accessoryId,600,350,'被审计单位资料授权');
		}
		function deleteFile(title,fileId,guid,auditUuid){
			var msg,action;
			var isDelete="${uploadRole==1}";
			if(title=="模板") {
				msg="确认删除模板吗（将同时删除对应的附件）？";
				action="deleteTemplate.action";
			}else{
				msg="确认删除附件吗？";
				action="deleteAccessory.action";
			}
		    $.messager.confirm('确认', msg, function(r){
		    	if (r){
					jQuery.ajax({
						url:'${contextPath}/auditAccessoryList/'+action,
						type:'POST',
						data:{'fileId':fileId,'auditUuid':auditUuid,'accessoryId':fileId,'deletePermission':isDelete,'isEdit':'false','guid':guid,'appType':'0','title':title},
						dataType:'json',
						async:'false',
						success:function(data){
							if(title == '模板'){
								var uploadFiles = $('#filelst').data('uploadFiles');
								var newFiles = [];
								if(uploadFiles && uploadFiles.length > 0){
									$.each(uploadFiles,function (i,f) {
										if(fileId != f.fileId){
											newFiles.push({
												'fileId':f.fileId,
												'fileName':f.fileName
											});
										}
									});
									$('#filelst').data('uploadFiles', newFiles);
								}
							}else{
								var uploadFiles = $('#filelstAcc').data('uploadFiles');
								var newFiles = [];
								if(uploadFiles && uploadFiles.length > 0){
									$.each(uploadFiles,function (i,f) {
										if(fileId != f.fileId){
											newFiles.push({
												'fileId':f.fileId,
												'fileName':f.fileName
											});
										}
									});
									$('#filelstAcc').data('uploadFiles', newFiles);
								}
							}
							//$.messager.show({
							//	title:'提示信息',
							//	msg:'上传成功！'
							//});
							$('#resultList').datagrid('reload');
						},
						error:function(){
							$('#resultList').datagrid('reload');
						}
					});
		    	}
		    });
		}

		function commitFile(cruProId) {
			$.messager.confirm('确认', "提交后已上传的资料不可编辑和删除，确定要提交吗？", function(r){
				if (r){
					jQuery.ajax({
						url:'${contextPath}/auditAccessoryList/commitFile.action',
						type:'POST',
						data:{"cruProId":'${cruProId}'},
						dataType:'json',
						async:'false',
						success:function(data){
							$.messager.show({
								title:'消息',
								msg:'提交成功！'
							});
							$('#resultList').datagrid('reload');
						},
						error:function(e){
							$.messager.show({
								title:'消息',
								msg:'提交失败！'
							});
						}
					});
				}
			});
		}
	</script>
	</body>
</html>
