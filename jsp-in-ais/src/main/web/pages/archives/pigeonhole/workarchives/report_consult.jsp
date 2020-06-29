<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE HTML >
<html>
	<head>
		<meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1" />
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>审计报告查阅</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<link href="<%=request.getContextPath()%>/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
		<link href="<%=request.getContextPath()%>/resources/css/common.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/createOrgTree.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>  
		<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/common.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/pages/tlInteractive/tlInteractiveCommon.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/scripts/check.js"></script> 
		<script type="text/javascript" src="${contextPath}/resources/js/jquery-fileUpload.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
		<link href="<%=request.getContextPath()%>/styles/jquery.multiSelect.css" rel="stylesheet" type="text/css">
		<script type='text/javascript' src='<%=request.getContextPath()%>/scripts/jquery.multiSelect.js'></script>
	</head>
	<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout">
		<div id="dlgSearch" class="searchWindow">
		<div class="search_head">
		<s:form action="reportConsult" namespace="/archives/workprogram/pigeonhole" method="post" id="reportForm">
				<table id="searchTable" cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
					<tr>
						<td align="left" class="EditHead" style="width:15%">
							报告名称
						</td>
						<td align="left" class="editTd" style="width:35%">
							<s:textfield name="reportFile" cssStyle="width:87%" cssClass="noborder" maxlength="50" />
						</td>
						<td align="left" class="EditHead" style="width:15%">
							项目编号
						</td>
						<td align="left" class="editTd" style="width:35%">
							<s:textfield name="project_code" cssStyle="width:87%" cssClass="noborder" maxlength="50" />
						</td>
					</tr>
					<tr>
						<td align="left" class="EditHead" style="width:15%">
							项目名称
						</td>
						<td align="left" class="editTd"  style="width:35%">
						   <s:textfield name="project_name2" cssStyle="width:87%" cssClass="noborder" maxlength="50" />
						</td>
						<td align="left" class="EditHead" style="width:15%">
							项目年度
						</td>
						<td align="left" class="editTd" style="width:35%">
							<select id="w_plan_year" class="easyui-combobox" name="project_year" editable="false" style="width: 87%">
								<option value="">&nbsp;</option>
								<s:iterator value="@ais.project.ProjectUtil@getIncrementSearchYearList(10,10)" id="entry">
									<option value="<s:property value='key'/>"><s:property value='value'/></option>
								</s:iterator>
							</select>
						</td>
					</tr>
					<tr>
						<td class="EditHead">审计单位</td>
						<td class="editTd" >
						<s:buttonText cssClass="noborder" id="audit_dept_name" hiddenId="audit_dept" name="audit_dept_name" cssStyle="width: 77%"
							hiddenName="audit_dept"
							doubleOnclick="showSysTree(this,
								{ url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action',
							   	param:{
										'p_item':3
								    
								},
								defaultDeptId:'${user.fdepid}',
							  	title:'请选择审计单位'
								})"
							doubleSrc="/easyui/1.4/themes/icons/search.png"
							doubleCssStyle="cursor:hand;border:0"  readonly="true"
							display="true" doubleDisabled="false" />
						</td>
						<td class="EditHead">被审计单位</td>
						<td class="editTd" >
							<s:buttonText2 cssClass="noborder" id="audit_object_name" hiddenId="audit_object" cssStyle="width: 77%"
								name="audit_object_name"
								hiddenName="audit_object"
								doubleOnclick="showSysTree(this,
								{ url:'${pageContext.request.contextPath}/mng/audobj/object/getAuditedDeptChildByDeptId.action',
								  param:{
									'departmentId':$('#audit_dept').val() == '' ?  '${user.fdepid}' :  $('#audit_dept').val()
								  },
								  cache:false,
								  checkbox:true,
								  title:'请选择被审计单位'
								})"
								doubleSrc="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png" readonly="true"
								doubleCssStyle="cursor:hand;border:0" />
						</td>
					</tr>
					<tr>
						<td class="EditHead">项目类别</td>
						<td class="editTd" colspan="3">
							<s:buttonText name="pro_type_name" cssClass="noborder"
										  hiddenName="pro_type" cssStyle="width:30.5%"
										  doubleOnclick="getItem('/pages/basic/code_name_tree_select.jsp?check=1','&nbsp;请选择项目类别',500,400)"
										  doubleSrc="/easyui/1.4/themes/icons/search.png"
										  doubleCssStyle="cursor:hand;border:0" readonly="true"
										  doubleDisabled="false" />
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
		<div region="center" >
			<table id="resultList"></table>
		</div>
	    <div id="reportAuthoritySetting_div" title="设置报告查看权限" style='overflow:hidden;padding:0px;'> 	  		
	     		<form id='set_form' name='set_form' method="POST" style='height:180px;overflow-y:auto;padding:10px;margin:0px;border:1px solid #cccccc;' >
			        <table id="set_table" class="ListTable" align="center" >
			        	<tr>
			        		<td class='EditHead' style="width: 25%"><font style='color:red'>*</font>&nbsp;授予用户</td>
			        		<td class='editTd' style="width: 75%;">
			        			<s:buttonText2 id="authorizedName" hiddenId="authorized"  cssClass="noborder"
									name="reportConsult.authorizedName" 
									hiddenName="reportConsult.authorized"
									doubleOnclick="showSysTree(this,
										{ url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action',
		                                  param:{
		                                     'p_item':1,
		                                     'orgtype':1
		                                  },
		                                  title:'请选择被授权人',
		                                  type:'treeAndEmployee',
		                                  defaultDeptId:'1'
										})"  
									doubleSrc="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png"
									doubleCssStyle="cursor:hand;border:0"
									readonly="true"
									maxlength="500" title="被授权人"/>
			        		</td>
			        	</tr>
			        	<tr>
			        		<td class='EditHead' ><font style='color:red'>*</font>&nbsp;查看期限</td>
			        		<td class='editTd'>
			        			<input type="text" id="consult_startTime" name="reportConsult.consult_startTime"
								class="easyui-datebox" editable="false" style="width: 150px"/>	
								——
								<input type="text" id="consult_endTime" name="reportConsult.consult_endTime"
								class="easyui-datebox" editable="false" style="width: 150px"/>	
			        		</td>
			        	</tr>
				        <tr>
			        		<td class='EditHead' ><font style='color:red'>*</font>&nbsp;文件授权</td>
			        		<td class='editTd' id="selectHTML">
			        			
			        		</td>
			        	</tr>
			        	<tr>
			        		<td class='EditHead' >授权人</td>
			        		<td class='editTd'>
			        			${user.fname }
			        		</td>
			        	</tr>
			        	<tr>
		        		<td class='EditHead' >授权时间</td>
			        		<td class='editTd'>
			        			<s:textfield id="createTime" readonly="true" cssClass="noborder"/>
			        		</td>
			        	</tr>
			        </table>
			        <s:hidden id="project_id"></s:hidden>
			        <s:hidden id="projdetailid"></s:hidden>
	     		</form>
	    		<div style='text-align:center;' id='closeBtnDiv' style='padding:15px;'>
	    		<br>
	       		<button  id='saveSetting'     class="easyui-linkbutton"  iconCls="icon-save">提交</button>&nbsp;&nbsp;&nbsp;&nbsp;
	       		<button  id='closeWin' class="easyui-linkbutton"  iconCls="icon-cancel">关闭</button>							        
		    </div>
			<div id="planName1" title="授权记录查看" style="overflow:hidden;padding:0px">
          		<iframe id="showPlanName" src="" width="100%" title="" height="100%" frameborder="0" ></iframe>
			</div>
	   </div>

		<div id="subwindow" class="easyui-window" title="" style="width:500px;height:500px;padding:5px;" closed="true">
			<div class="easyui-layout" fit="true">
				<div region="center" border="false" style="padding:10px;background:#fff;border:1px solid #ccc;">
					<iframe id="item_ifr" name="item_ifr" src="" frameborder="0" width="100%" height="100%" scrolling="auto" ></iframe>
				</div>
				<div region="south" border="false" style="text-align:right;padding:5px 0;">
					<div style="display: inline;" align="right">
						<a class="easyui-linkbutton" iconCls="icon-ok" href="javascript:void(0)" onclick="saveF()">确定</a>
						<a class="easyui-linkbutton" iconCls="icon-empty" href="javascript:void(0)" onclick="cleanF()">清空</a>
						<a class="easyui-linkbutton" iconCls="icon-cancel" href="javascript:void(0)" onclick="closeWin()">取消</a>
					</div>
				</div>
			</div>
		</div>
		<script type="text/javascript">
		function viewUrl(id){
            var viewUrl = '<%=request.getContextPath()%>/archives/workprogram/pigeonhole/viewReportAuthority.action?projdetailid='+id;
            $('#showPlanName').attr("src",viewUrl);
            $('#planName1').window('open');
        }
		function closeWin(){
			$('#subwindow').window('close');
		}
        function freshGrid(){
			$('#dlgSearch').dialog('open');
		}
        
		function viewPlan(formId){
			var url = "${contextPath}/project/report/viewHistoryReport.action?id="+formId;
			aud$openNewTab('Audit Report',url,true);
		}
		
		function downloadFile(fileId){
			window.location.href="${contextPath}/commons/file/downloadFile.action?fileId="+fileId;
		}
		
		function reportSetting(){
			var ids = $('#resultList').datagrid('getChecked');
		    if (ids.length   <= 0 ) {
				$.messager.show({title:'提示信息',msg:'请选择一条信息！'});
				return false;
			}
		    var date = new Date();
	        var seperator1 = "-";
	        var year = date.getFullYear();
	        var month = date.getMonth() + 1;
	        var strDate = date.getDate();
	        if (month >= 1 && month <= 9) {
	            month = "0" + month;
	        }
	        if (strDate >= 0 && strDate <= 9) {
	            strDate = "0" + strDate;
	        }
	        var currentdate = year + seperator1 + month + seperator1 + strDate;
	        $('#createTime').val(currentdate);
			$('#createTime2').val(currentdate);
			$('#project_id').val(ids[0].project_id);
			$('#projdetailid').val(ids[0].id);
			
			$.ajax({
                type: "POST",
                url: "${contextPath}/archives/workprogram/pigeonhole/getFileNameAndId.action",
                data: {"projdetailid":ids[0].id},
                dataType:"json",
                success: function(data){
					$('#selectHTML').html(data.multiSelect);
                }
            });
			$('#reportAuthoritySetting_div').window('open');
			$("#reportAuthoritySetting_div").window('center');
		}
		/*
		* 查询
		*/
		function doSearch(){
		
        	$('#resultList').datagrid({
    			queryParams:form2Json('reportForm')
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
			resetForm("dlgSearch");
			//doSearch();
		}

		
		$(function(){
			$('#closeWin').bind('click',function(){
				document.getElementById("authorizedName").value = "";
				document.getElementById("authorized").value = "";
				$('#consult_startTime').datebox('setValue', '');
				$('#consult_endTime').datebox('setValue', '');
				$('#project_id').val("");
				$('#projdetailid').val("");
				$('#reportAuthoritySetting_div').window('close');
			});
			$('#saveSetting').bind('click',function(){
				var authorizedName = document.getElementById("authorizedName").value;
				var authorized = document.getElementById("authorized").value;
				if(authorizedName == null || authorizedName == ''){
					showMessage1("请选择授予用户！");
					return false;
				}
				var consult_startTime =  $('#consult_startTime').datebox('getValue');
				if(consult_startTime == null || consult_startTime == ''){
					showMessage1("请填写查看期限！");
					return false;
				}
				var consult_endTime = $('#consult_endTime').datebox('getValue');
				if(consult_endTime == null || consult_endTime == ''){
					showMessage1("请填写查看期限！");
					return false;
				}
		  		if (!validateDate('consult_startTime','consult_endTime','查看期限')){
		  			return false;
		  		}
				var fileIds = document.getElementsByName("fileIds");
				var fileIdsString ="";
				if(fileIds != null && fileIds.length > 0){
					for(var i=0;i<fileIds.length;i++){
						if(fileIds[i].checked){
							fileIdsString += fileIds[i].value+",";
						}
					}
				}
				if(fileIdsString == null || fileIdsString == ''){
					showMessage1("请选择授权文件！");
					return false;
				}
				var createTime = document.getElementById("createTime").value;
				var project_id = document.getElementById("project_id").value;
				var projdetailid = document.getElementById("projdetailid").value;
				$.ajax({
	                type: "POST",
	                url: "${contextPath}/archives/workprogram/pigeonhole/reportAuthoritySetting.action",
	                data: {
	                	"projdetailid":projdetailid,
	                	"project_id":project_id,
	                	"authorized":authorized,
	                	"authorizedName":authorizedName,
	                	"consult_startTime":consult_startTime,
	                	"consult_endTime":consult_endTime,
	                	"fileIdsString":fileIdsString,
	                	"createTime":createTime
	                	},
	                dataType:"json",
	                success: function(data){
	                	if(data.msg == '1'){
	                		document.getElementById("authorizedName").value = "";
		    				document.getElementById("authorized").value = "";
		    				$('#consult_startTime').datebox('setValue', '');
		    				$('#consult_endTime').datebox('setValue', '');
		    				$('#project_id').val("");
		    				$('#reportAuthoritySetting_div').window('close');
		    				showMessage1("授权成功！");
							$('#resultList').datagrid('reload');
	                	}
	                }
	            });
			});
	        showWin('dlgSearch');
	        doSearch();
	        var isLeader = '${isLeader}';
	        var bodyW = $('body').width();
			$('#resultList').datagrid({
				url : "<%=request.getContextPath()%>/archives/workprogram/pigeonhole/reportConsult.action?querySource=grid&isLeader="+isLeader,
	            method:'post',
	            showFooter:false,
	            rownumbers:true,
	            pagination:true,
	            striped:true,
	            autoRowHeight:true,
	            fit: true,
	            pageSize: 20,
	            fitColumns:true,
	            idField:'id',
	            singleSelect:true,
	            border:false,
			    onLoadSuccess:function(){
			    	 doCellTipShow('resultList');
			    },
				toolbar:[{
						id:'search',
						text:'查询',
						iconCls:'icon-search',
						handler:function(){
							searchWindShow('dlgSearch');
						}
					}
				 <s:if test="${isLeader == 'y'}">
				 ,'-',
					{
						id:'edit',
						text:'设置报告查看权限',
						iconCls:'icon-edit',
						handler:function(){
							reportSetting();
						}
					}
					</s:if> 
				],
				
				frozenColumns:[[
					{field:'reportFile',title:'报告名称',halign:'center',width:bodyW*0.17+'px',align:'left'
					},
					{field:'project_name',
						title:'项目名称',
						width:bodyW*0.17+'px',
						halign:'center',
						align:'left',
						sortable:true
					}
				]],
				columns:[[
					{field:'project_code',
						title:'项目编码',
						width:bodyW*0.12+'px',
						halign:'center',
						align:'left',
						sortable:true
					},
 					{field:'pro_type_name',
						 title:'项目类型',
						width:bodyW*0.08+'px',
						 halign:'center',
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
 					{field:'pro_year',
						 title:'项目年度',
						width:bodyW*0.07+'px',
						 halign:'center',
						 align:'center', 
						 sortable:true
					}, 
		 			{field:'audit_dept_name',
						 title:'审计单位',
						 width:bodyW*0.15+'px',
						 halign:'center',
						 align:'left', 
						 sortable:true
					},
					{field:'audit_object_name',
						 title:'被审计单位',
						 width:bodyW*0.15+'px',
						 halign:'center',
						 align:'left', 
						 sortable:true
					}
					<s:if test="${isLeader == 'y'}">
					,
					{field:'num',
						title:'授权记录',
						width:bodyW*0.06+'px',
						align:'center',
						formatter:function(value,rowData,rowIndex){
								return '<a href=\"javascript:void(0)\" onclick=\"viewUrl(\''+rowData.id+'\');\">'+value+'</a>';
						},
						halign:'center'
					}
					</s:if>
				]]   
			}); 
				
			
			$('#reportAuthoritySetting_div').window({   
				width:600,
				height:290,   
				modal:true,
				collapsible:false,
				maximizable:false,
				minimizable:false,
				closed:true
			});
			$('#planName1').window({
				width:950,
				height:450,
				modal:true,
				collapsible:false,
				maximizable:true,
				minimizable:false,
				closed:true,
				maximized:true
			});
		});
		 function validateDate(beginDateId,endDateId,msg){
				var s1 = $('#'+beginDateId);
				var e1 = $('#'+endDateId);
				if(s1 && e1){
					var s = s1.datebox('getValue');
					var e = e1.datebox('getValue');
					if(s!='' && e!=''){
						var s_date=new Date(s.replace("-","/"));
						var e_date=new Date(e.replace("-","/"));
						if(s_date.getTime()>e_date.getTime()){
							$.messager.alert("错误",msg+"开始必须小于等于结束!");
							return false;
						}
					}
				}
				return true;
			}

		function getItem(url,title,width,height){
		 	var codes = document.getElementsByName('pro_type');
		 	if (codes){
		 		url += "&typevalue=" + codes[0].value;
			}
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

			document.all('pro_type').value = ayy[0];
			document.all('pro_type_name').value = ayy[1];

			closeWin();
		}
		function cleanF(){
			$('#item_ifr')[0].contentWindow.unCheck();
			document.all('pro_type').value = '';
			document.all('pro_type_name').value = '';
			closeWin();
		}
		function closeWin(){
			$('#subwindow').window('close');
		}
		</script>	
	</body>
</html>
