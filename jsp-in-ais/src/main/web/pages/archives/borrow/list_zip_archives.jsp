<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%
	response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1 
	response.setHeader("Pragma", "no-cache"); //HTTP 1.0 
	response.setDateHeader("Expires", 0); //prevents caching at the proxy server
%>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<title><s:property value="processName" /></title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">

<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
<link href="${contextPath}/resources/css/common.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
<script type="text/javascript" src="${contextPath}/resources/csswin/subModal.js"></script>
<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
<%--<STYLE type="text/css">
	.datagrid-row {
	  	height: 30px;
	}
	.datagrid-cell {
		height:10%;
		padding:1px;
	}
</STYLE>--%>
<script type="text/javascript">
	/*
	 * 导出档案文件成zip下载
	 */
	function exportZip(project_id){
		DWREngine.setAsync(false);
		DWREngine.setAsync(false);DWRActionUtil.execute({ namespace:'/archives/workprogram/pigeonhole', action:'outZip', executeResult:'false' },
		{'project_id':project_id},xxx);
		function xxx(data){
			var tempZipName = data["tempZipName"];
			if(tempZipName!='NO'){
				var url="${contextPath}/archives/workprogram/pigeonhole/exportFileZip.action?project_id=" + project_id + "&tempZipName=" +　tempZipName;
				document.location.href=url;
			}else{
				$.messager.show({
					title:'提示信息',
					msg:'文件压缩失败!',
					timeout:5000,
					showType:'slide'
				});
				DWREngine.setAsync(false);
				DWREngine.setAsync(false);DWRActionUtil.execute({ namespace:'/archives/workprogram/pigeonhole', action:'deleteTempZip', executeResult:'false' },
				{'tempZipName':tempZipName},xx);
			}
		} 
	}
</script>
</head>
<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout" onload="setWorkProgramId();">
	<div id="exportFileSearch" class="searchWindow">
		<div class="search_head">
		<s:form action="exportFileZip" namespace="/archives/borrow" name="form" id="form">
			<table  id="searchTable"  cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
				<tr>
					<td class="EditHead" style="width:15%">档案名称</td>
					<td class="editTd" style="width:35%">
						<s:textfield cssClass="noborder" 
							name="pigeonholeObject.archives_name" size="15" />
					</td>
					<td class="EditHead" style="width:15%">档案年度</td>
					<td class="editTd" style="width:35%">
						<select class="easyui-combobox" name="pigeonholeObject.archives_year"  editable="false">
					       <option value="">&nbsp;</option>
					       <s:iterator value="@ais.project.ProjectUtil@getIncrementSearchYearList(10,9)" id="entry">
				             <option value="<s:property value='key'/>"><s:property value='value'/></option>
					       </s:iterator>
					    </select>
					</td>
				</tr>
				<tr>
					<td class="EditHead">被审计单位</td>
					<td class="editTd">
						<s:buttonText2 cssClass="noborder"
							id="pigeonholeObject.audit_object_name"
							hiddenId="pigeonholeObject.audit_object"
							name="pigeonholeObject.audit_object_name"
							hiddenName="pigeonholeObject.audit_object"
							doubleOnclick="showSysTree(this,
								{ url:'${pageContext.request.contextPath}/mng/audobj/object/getAuditedDeptChildByDeptId.action',
								  param:{
								    'departmentId':$('#pigeonholeObject.archives_unit').val()
								  },
								  cache:false,
								  checkbox:true,
								  title:'请选择被审计单位</div>',
								})"
							doubleSrc="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png"
							doubleCssStyle="cursor:hand;border:0" readonly="true"
							display="${varMap['audit_objectRead']}"
							doubleDisabled="!( varMap['audit_object_buttonWrite']==null ? true : varMap['audit_object_buttonWrite'] )" />
					</td>
					<td class="EditHead">项目类别</td>
					<td class="editTd">
						<!-- 
						<s:doubleselect cssStyle="width:160px;" id="pro_type" 
							doubleId="pro_type_child" 
							doubleList="basicUtil.planProjectTypeMap[top]"
							doubleListKey="code" doubleListValue="name" listKey="code"
							listValue="name" name="pigeonholeObject.pro_type"
							list="basicUtil.planProjectTypeMap.keySet()"
							doubleName="pigeonholeObject.pro_type_child"
							theme="ufaud_simple" templateDir="/strutsTemplate"
							display="${varMap['pro_typeRead']}" emptyOption="true" />
							-->
						<div style="float: left;">
							<s:textfield cssClass="noborder" name="pigeonholeObject.pro_type_name"  id="pro_type_name" readonly="true"/>
							<s:textfield cssClass="noborder" name="pigeonholeObject.pro_type_child_name"  id="pro_type_child_name" cssStyle="width:80%;" readonly="true"/>
							<img style="cursor:hand;border:0" src="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png" 
						    	onclick="getItem('/ais/pages/basic/code_name_tree_select.jsp','&nbsp;请选择项目类别',500,400)"></img>
								<input type="hidden" id="pro_type" name="pigeonholeObject.pro_type" value="<s:property value='pigeonholeObject.pro_type'/>">
								<input type="hidden" id="pro_type_child" name="pigeonholeObject.pro_type_child" value="<s:property value='pigeonholeObject.pro_type_child'/>">
						</div>
                        <div id="showWorkProgram" style="float: left;"></div>	
					</td>
				</tr>
				<tr >
					<td class="EditHead">审计单位</td>
					<td class="editTd" colspan="3">
						<s:buttonText  cssClass="noborder"
							name="pigeonholeObject.archives_unit_name" size="15"
							hiddenName="pigeonholeObject.archives_unit"
							doubleOnclick="showSysTree(this,
							{ url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action',
							   param:{
									'p_item':0,
								     'orgtype':1
							},
							  title:'请选择审计单位'
							})"
							doubleSrc="/easyui/1.4/themes/icons/search.png"
							doubleCssStyle="cursor:hand;border:0" readonly="true"
							display="true" doubleDisabled="false" />
					</td>
				</tr>
			</table>
		</s:form>
		</div>
		<div class="serch_foot">
	        <div class="search_btn">
				<a class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>
				<a class="easyui-linkbutton" data-options="iconCls:'icon-reload'" onclick="restal()">重置</a>
				<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="$('#exportFileSearch').window('close')">取消</a>
			</div>
		</div>
	</div>
	<div region="center" >
		<table id="allArchivesList"></table>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<div id="layer" style="display: none" align="center">
			<img src="${contextPath}/images/uploading.gif">
			<br>
			<br>
			正在压缩档案文件，请稍候......
		</div>
	</div>
	<div id="subwindow" class="easyui-window" title="项目类别">
		<div class="easyui-layout" fit="true">
			<div region="center" border="false" style="padding:10px;background:#fff;border:1px solid #ccc;">
				<iframe id="item_ifr" name="item_ifr" src="" frameborder="0" width="100%" height="100%" scrolling="auto" ></iframe>
			</div>
			<div region="south" border="false" style="text-align:right;padding:5px 0;">
			    <div style="display: inline;" align="right">
					<a class="easyui-linkbutton" iconCls="icon-ok" href="javascript:void(0)" onclick="saveF()">确定</a>
					<a class="easyui-linkbutton" iconCls="icon-empty" href="javascript:void(0)" onclick="cleanF()">清空</a>
					<a class="easyui-linkbutton" iconCls="icon-cancel" href="javascript:void(0)" onclick="closeWin()">关闭</a>
			    </div>
			</div>
		</div>
	</div>			
<script type="text/javascript">
	function setWorkProgramId(){
            var projtype = document.getElementsByName("pigeonholeObject.pro_type");
            var childprojtype = document.getElementsByName("pigeonholeObject.pro_type_child")[0];
            var pvalue="";
            var cpvalue="";
            if(projtype){
                //针对如果projtypedisable，struts就会产生一个hiden的input
                if(projtype.length==1){
                	projtype = projtype[0];
                }else if(projtype.length==2){
                	projtype = projtype[1];
                }
                if(projtype){
                	pvalue=projtype.value;
                }
            }
          
            if(childprojtype){
            	if(childprojtype){
            		cpvalue=childprojtype.value;
            	}
            }
            if(cpvalue == ''){
            	document.getElementById('pro_type_child_name').style.display='none';
            }else{
                document.getElementById('pro_type_child_name').style.display='';
            }
            var retmessage="";
            DWREngine.setAsync(false);
            DWREngine.setAsync(false);DWRActionUtil.execute(
            { namespace:'/workprogram', action:'getWorkProgramByProjType', executeResult:'false' }, 
            {'wp_projtypeid':pvalue,'wp_childprojtypeid':cpvalue},
            xxx);
            function xxx(data){
                retmessage=data['ret_message'];
            } 
            if(retmessage!=null&&retmessage!=""){
            	document.getElementById("workprogramid").value=retmessage;
            }else{
            	document.getElementById("workprogramid").value="";
            }
        }
	function getItem(url,title,width,height){
		$('#item_ifr').attr('src',url);
		openWin('subwindow','项目类别',500,400);
	}
	function saveF(){
		var ayy = $('#item_ifr')[0].contentWindow.saveF();
		var res = ayy[0].split(',');
		var name = ayy[1].split(',');
		if(res.length != 1){
			document.all('pigeonholeObject.pro_type_child').value=res[0];
			document.all('pigeonholeObject.pro_type').value=res[1];
   			document.all('pigeonholeObject.pro_type_name').value=name[0];
   			document.all('pigeonholeObject.pro_type_child_name').value=name[1];
   			document.getElementById('pro_type_child_name').style.display='';
		}else{
			document.all('pigeonholeObject.pro_type_child').value='';
			document.all('pigeonholeObject.pro_type').value=ayy[0];
			document.all('pigeonholeObject.pro_type_name').value=name[0];
   			document.all('pigeonholeObject.pro_type_child_name').value='';
   			document.getElementById('pro_type_child_name').style.display='none';
		}
   		closeWin();
   		projectTypeChangeHandler();
   		setWorkProgramId();
	}
	function cleanF(){
		document.all('pigeonholeObject.pro_type').value='';
   		document.all('pigeonholeObject.pro_type_child').value='';
   		document.all('pigeonholeObject.pro_type_name').value='';
   		document.all('pigeonholeObject.pro_type_child_name').value='';
   		document.getElementById('pro_type_child_name').style.display='none';
   		closeWin();
	}
	function closeWin(){
		$('#subwindow').window('close');
	}
	function doSearch(){
       	$('#allArchivesList').datagrid({
   			queryParams:form2Json('form')
   		});
   		$('#exportFileSearch').window('close');
    }
    //重置查询条件
	function restal(){
		document.getElementsByName("pigeonholeObject.audit_object_name")[0].value = '';
		document.getElementsByName("pigeonholeObject.archives_unit_name")[0].value = '';
		document.getElementsByName("pigeonholeObject.pro_type_name")[0].value = '';
		document.getElementsByName("pigeonholeObject.pro_type_child_name")[0].value = '';
		resetForm('form');
		document.getElementById('pro_type_child_name').style.display='none';
		/*doSearch();*/
	}
	/*
	* 批量导出档案为zip
	* */
	function batchExportToZip(projectIds){
	    $.ajax({
            url:'${contextPath}/archives/workprogram/pigeonhole/batchOutZip.action',
            dataType:'json',
            method:'post',
            async:false,
            data:{'projectIds':projectIds},
            success:function (data) {
                var tempZipName = data["tempZipName"];
                if(tempZipName!='NO'){
                    var url="${contextPath}/archives/workprogram/pigeonhole/batchExportFileZip.action?projectIds=" + projectIds + "&tempZipName=" +　tempZipName;
                    document.location.href=url;
                }else{
                    $.messager.show({
                        title:'提示信息',
                        msg:'文件压缩失败!',
                        timeout:5000,
                        showType:'slide'
                    });
                    DWREngine.setAsync(false);
                    DWREngine.setAsync(false);DWRActionUtil.execute({ namespace:'/archives/workprogram/pigeonhole', action:'deleteTempZip', executeResult:'false' },
                        {'tempZipName':tempZipName},xx);
                }
            }

        })
    }
	$(function(){
		generateWin('subwindow');
		showWin('exportFileSearch');
		var bodyW = $('body').width();
		// 初始化生成表格
		$('#allArchivesList').datagrid({
			url : "<%=request.getContextPath()%>/archives/borrow/exportFileZip.action?querySource=grid",
			method:'post',
			showFooter:false,
			rownumbers:true,
			pagination:true,
			striped:true,
			autoRowHeight:false,
			fit: true,
			pageSize: 20,
			fitColumns: true,
			idField:'formId',
			border:false,
			remoteSort: false,
			toolbar:[{
					id:'searchObj',
					text:'查询',
					iconCls:'icon-search',
					handler:function(){
						searchWindShow('exportFileSearch');
					}
				},'-',{
                id:'searchObj',
                text:'导出档案',
                iconCls:'icon-export',
                handler:function(){
                    var rows = $('#allArchivesList').datagrid('getChecked');
                    if(rows.length==0){
                        showMessage1("请选择一条记录进行导出！");
                    }else{
                        var idStr = [];
                        for(var i=0;i<rows.length;i++){
                            var row = rows[i];
                            var project_id = row['project_id'];
                            idStr.push(project_id);
                        }
                        var projectIds = idStr.join(',');
                        batchExportToZip(projectIds);
                    }
                }
            },'-',helpBtn],
			onLoadSuccess:function(){
				initHelpBtn();
				doCellTipShow('allArchivesList');
				frloadClose();
			},
			columns:[[
                {field:'formId',checkbox:true},
				{field:'archives_name',title:'档案名称',width:0.18*bodyW+'px',halign:'center',align:'left',sortable:true},
			    {field:'archives_type_name',title:'档案类型',width:0.1*bodyW+'px',sortable:true,halign:'center',align:'center'},
				{field:'pro_type_name',
						title:'项目类别',
						halign:'center',
						align:'left',
						width:0.1*bodyW+'px',
						sortable:true
				},
				{field:'audit_object_name',
					title:'被审计单位',
					width:0.18*bodyW+'px',
					sortable:true,
					halign:'center',
					align:'left'
				},
				{field:'archives_year',
					 title:'档案年度',
					 halign:'center',
					 align:'center', 
					 sortable:true,
					width:0.1*bodyW+'px'
				},
/*				{field:'archives_save_year',
					 title:'保存期限/年',
					 halign:'center',
					 align:'right',
					 sortable:true
				},
				{field:'archives_secrecy_name',
					 title:'秘密等级',
					 halign:'center',
					 align:'center',
					 sortable:true 
				},*/
				{field:'archives_unit_name',
					 title:'审计单位',
					 width:0.18*bodyW+'px',
					 halign:'center',
					 align:'left',
					 sortable:true 
				}/*,
				{field:'option',
					 title:'操作',
					 halign:'center',
					 align:'center',
					 sortable:false,
					 formatter:function(value,row,index){
					 	var param = [row.project_id];
					 	var btn2 = "导出档案,exportZip,"+param.join(',')
						var a = '<a href=\"javascript:void(0)\" onclick=\"exportZip(\''+row.project_id+'\');\">导出档案</a>';
						return ganerateBtn(btn2);
					 }
				}*/
			]]   
		});
		
	}); 		
</script>
</body>
</html>
