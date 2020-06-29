<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>整改跟踪分配列表</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
		<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>  
		<link href="${contextPath}/resources/css/common.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
		<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
		<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
		<link href="${contextPath}/styles/jquery.multiSelect.css" rel="stylesheet" type="text/css" />
		<script type='text/javascript' src='${contextPath}/scripts/jquery.multiSelect.js'></script>
		<script type="text/javascript">
		 	
			$(function(){
				showWin('dlgSearch');
				datagrid = $('#list').datagrid({
					<%-- url : '<%=request.getContextPath()%>/easyui/problem/listAll.action?querySource=grid', --%>
					url : '<%=request.getContextPath()%>/intctet/proManage/decideProblemList.action?querySource=grid',
					method:'post',
					showFooter:false,
					rownumbers:true,
					pagination:true,
					striped:true,
					autoRowHeight:false,
					//width:'100%',
					//height:'50%',
					fit:true,
					fitColumns:false,
					idField:'id',
					pageSize: 20,	
					border:false,
					singleSelect:true,
					remoteSort:false,
					onClickRow:function(index, row){
						changeButtonState(row.is_closed);
					},
					toolbar:[{
						id:'search',
						text:'查询',
						iconCls:'icon-search',
						handler:function(){
							searchWindShow('dlgSearch');
						}
					},
					{
						id:'assign_tracker',
						text:'分配跟踪人',
						iconCls:'icon-user',
						handler:function(){
							if(assignTracker()){
								//------默认为整改期限前1个月-------
								/* var rows=$('#list').datagrid('getSelected');
								var mendDeadline = rows.mendDeadline;
								var arry=mend_term_date.split('至');
								if(arry[1]!=null){
									var b = getPreMonth(arry[1]);
										$('#tracker_date').val(b);
								}else{
									clearTrackerDiv();
								} */
			                    $('#lrsjyd_div').window('open');
							}
						}
					},
					{
						id:'assign_closer',
						text:'分配关闭人',
						iconCls:'icon-user1',
						handler:function(){
							if(assignTracker()){
								$('#closer_div').window('open');
							}
						}
					}],
					frozenColumns:[[
		       			{field:'id',width:'50px', hidden:true,halign:'center',align:'center',sortable:true},
		       			{field:'isClosedOrNot',title:'是否关闭',align:'center',sortable:true,
	       					formatter:function(value ,rowData,rowIndex){
	       						if(rowData.isClosedOrNot=='是'){
		       						return '是';
		       					}else{
		       						return '否';
		       					}
	       					}	
	       				},
		       			{field:'proCode',title:'项目编号',width:'280px',sortable:true,halign:'center',align:'left'
		       				/* formatter:function(value,row,index){
								 return '<a href=\"javascript:void(0)\" onclick=\"openMsg(\''+row.proId+'\');\">'+value+'</a>';
							} */
		       			}
		    		]],
					columns:[[  
						{field:'defectCode',
								title:'内控缺陷编号',
								width:200,
								halign:'center',
								align:'left', 
								sortable:true
								/* formatter:function(value,rowData,rowIndex){
									return '<a href=\"javascript:void(0)\" onclick=\"openViewMiddle(\''+rowData.id+'\');\">'+value+'</a>';
								} */
						},
						{field:'defectName',
							title:'内控缺陷名称',
							sortable:true,
							halign:'center',
							align:'center'
						},
						{field:'manuscriptIndex',
							 title:'底稿索引',
							 halign:'center',
							 align:'left', 
							 sortable:true
						},
						{field:'controlName',
							 title:'所属控制点',
							 width:200,
							 halign:'center', 
							 align:'left', 
							 sortable:true
						},
						{field:'circuitName',
							 title:'所属主流程',
							 width:200,
							 halign:'center', 
							 align:'left', 
							 sortable:true
						},
						{field:'defectTypeName',
							 title:'缺陷类型',
							 width:200,
							 halign:'center', 
							 align:'left', 
							 sortable:true
						},
						{field:'relateLoss',
							 title:'涉及到损失/错报的金额',
							 halign:'center',
							 align:'right', 
							 sortable:true
							 },
						{field:'defineResult',
							 title:'认定结果',
							 halign:'center',
							 align:'right', 
							 sortable:true
						},
						{field:'mendAdvice',
							 title:'整改建议',
							 width:200,
							 halign:'center', 
							 align:'left', 
							 sortable:true
							 },
						{field:'mendDeadline',
							 title:'整改期限',
							 halign:'center', 
							 align:'left', 
							 sortable:true
							 },	 
						{field:'mendMethod',
							 title:'整改方式',
							 halign:'center',
							 align:'right', 
							 sortable:true
							 },
						{field:'mendStatus',
							 title:'整改状态',
							 width:100,
							 halign:'center', 
							 align:'left', 
							 sortable:true
						},
						{field:'lastFeedbackTime',
							 title:'最近反馈时间',
							 width:100,
							 halign:'center', 
							 align:'left', 
							 sortable:true,
							 formatter:function (value,row,rowIndex){return value;}
							 },
						{field:'mendStatusEvaluate',
							 title:'整改状态评价',
							 align:'left',
							 halign:'center', 
							 sortable:true,
							 formatter:function(value,row,rowIndex){return value;}
						 },
						{field:'lastEvaluateTime',
							 title:'最近评价时间',
							 width:100, 
							 halign:'center',
							 align:'left', 
							 sortable:true
						}
					]] 
				});
                $('#lrsjyd_div').show();
                $('#lrsjyd_div').dialog({
                    title:'分配跟踪人',
                    closed:true,
                    width:700,
                    height:350,
                    collapsible:true,
                    modal:true,
                    onOpen:function(){
                        var arr = ['tracker_name','tracker_code','tracker_date'];
                        $.each(arr, function(i, ele){
                            $('#'+ele).val('');
                        });
                    },
                    buttons:[{
                        text:'关闭',
                        iconCls:'icon-cancel',
                        handler:function(){
                            $('#lrsjyd_div').dialog('close');
                        }
                    },{
                        text:'保存',
                        id:'clearBtn',
                        iconCls:'icon-save',
                        handler:function(){
                            if(frmCheck(document.getElementById('lrsjyd_form'),'lrsjyd_table')==false){
                                return false;
                            }
                            var rows=$('#list').datagrid('getSelections');
                            if(rows.length>0){
                                var crudIdStringsTemp = '';
                                for( var i=0;i<rows.length;i++){
                                    crudIdStringsTemp +=rows[i].id+',';
                                }
                                $('#crudIdStrings').val(crudIdStringsTemp);
                            }
                            var crudIdStrings = $('#crudIdStrings').val();
                            $('#reply_frequencys').val("("+$('#reply_frequency_temp').val()+")"+$('#reply_frequency_day').val());
                            $.ajax({
                                dataType:'json',
                                url : "${contextPath}/intctet/proManage/saveTracker.action?crudIdStrings="+crudIdStrings,
                                data: $('#lrsjyd_form').serialize(),
                                type: "POST",
                                success: function(data){
                                    showMessage2('保存成功！');
                                    $('#lrsjyd_div').window('close');
                                    doSearch();
                                    //window.location.reload();
                                },
                                error:function(data){
                                    showMessage2('请求失败！');
                                }
                            });
                        }
                    }]
                });
                $('#closer_div').show();
                $('#closer_div').dialog({
                    title:'关闭分配人',
                    closed:true,
                    collapsible:true,
                    modal:true,
                    width:600,
                    height:200,
                    onOpen:function(){
                        var arr = ['closer_name','closer_code'];
                        $.each(arr, function(i, ele){
                            $('#'+ele).val('');
                        });
                        var num=Math.random();
                        var rnm=Math.round(num*9000000000+1000000000);
                    },
                    buttons:[{
                        text:'关闭',
                        iconCls:'icon-cancel',
                        handler:function(){
                            $('#closer_div').dialog('close');
                        }
                    },{
                        text:'保存',
                        id:'clearBtn',
                        iconCls:'icon-save',
                        handler:function(){
                            if(frmCheck(document.getElementById('closer_form'),'closer_table')==false){
                                return false;
                            }
                            var rows=$('#list').datagrid('getSelections');
                            if(rows.length>0){
                                var crudIdStringsTemp = '';
                                for( var i=0;i<rows.length;i++){
                                    crudIdStringsTemp +=rows[i].id+',';
                                }
                                $('#crudIdStrings').val(crudIdStringsTemp);
                            }
                            var crudIdStrings = $('#crudIdStrings').val();
                            $.ajax({
                                dataType:'json',
                                url : "${contextPath}/intctet/proManage/saveCloser.action?crudIdStrings="+crudIdStrings,
                                data: $('#closer_form').serialize(),
                                type: "POST",
                                success: function(data){
                                    showMessage2('保存成功！');
                                    window.location.reload();
                                },
                                error:function(data){
                                    showMessage2('请求失败！');
                                }
                            });
                        }
                    }]
                })
			});
		</script>		
	</head>
	<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout">
		<div id="dlgSearch" class="searchWindow">
		<div class="search_head">
		<s:form id="myform" name="myform" action="decideProblemList.action" namespace="/intctet/proManage" method="post">
			<table id="searchTable" cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
				<tr >
					<td  class="EditHead" style="width:15%">
						是否关闭
					</td>
					<td class="editTd" style="width:35%">
						<select editable="false" name="interCtrlProblem.isClosedOrNot" data-options="panelHeight:'auto'" class="easyui-combobox" style="width:80%" >
							<option value="">&nbsp;</option>
						       <s:iterator value="#@java.util.LinkedHashMap@{'是':'是','否':'否'}" id="entry">
						         <option value="<s:property value="key"/>"><s:property value="value"/></option>
						       </s:iterator>
						</select>
					</td>
					<td  class="EditHead" style="width:15%">
						项目编号
					</td>
					<td class="editTd" style="width:35%">
						<s:textfield cssClass="noborder" name="interCtrlProblem.proCode" cssStyle="width:80%" maxlength="50"/>
					</td>
				</tr>
				<tr >
					<td  class="EditHead">
						被评价单位
					</td>
					<td class="editTd">
						<s:buttonText2 name="interCtrlProblem.evaDept" cssClass="noborder"
							hiddenName="interCtrlProblem.evaDeptCode" cssStyle="width:80%"
							doubleOnclick="showSysTree(this,
							{ url:'${pageContext.request.contextPath}/mng/audobj/object/getAuditedDeptChildByDeptId.action',
                              cache:false,
							  checkbox:true,
							  title:'请选择被评价单位树'
							})"
							doubleSrc="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png"
							doubleCssStyle="cursor:hand;border:0" readonly="true" />
					</td>
					<td class="EditHead">
					</td>
					<td class="editTd">
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
    <div region="center">
		<table id="list"></table>
	</div>
	<div id="lrsjyd_div" title="分配跟踪人" style='overflow:hidden;padding:0px;display: none'>
		<form id='lrsjyd_form' name='sjsx_form' method="POST" style='height:150px;overflow-y:auto;padding:10px;margin:0px;border:1px solid #cccccc;' >
	        <table id='lrsjyd_table' class="ListTable" align="center" >
	        	<tr>
	        		<td class='EditHead' ><font style='color:red'>*</font>&nbsp;问题跟踪人</td>
	        		<td class='editTd' colspan=3>
	        			<s:buttonText2 id="tracker_name" hiddenId="tracker_code" cssClass="noborder"
							name="interCtrlProblem.tracker_name" 
							hiddenName="interCtrlProblem.tracker_code"
							doubleOnclick="showSysTree(this,
								{ url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action',
                                  param:{
                                     'p_item':1,
                                     'orgtype':1
                                  },
                                  singleSelect:true,
                                  title:'请选择问题跟踪人',
                                  type:'treeAndEmployee',
                                  defaultDeptId:'${user.fdepid}'
								})"  
							doubleSrc="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png"
							doubleCssStyle="cursor:hand;border:0"
							readonly="true"
							maxlength="500" title="问题跟踪人"/>
	        		</td>
	        	</tr>
	        	<tr>
					<td class="EditHead"><font style='color:red'>*</font>&nbsp;整改结果反馈频率设定</td>
					<td class="editTd">
						<select id="reply_frequency_month"
							style="width:25%;" multiple="multiple">
							<c:forEach items="${list}" var="m">
								<option value="${m.code}">
									${m.name}
								</option>
							</c:forEach>
						</select>
						<s:select id="reply_frequency_day"
							list="#@java.util.LinkedHashMap@{'1日':'1日','2日':'2日','3日':'3日','4日':'4日','5日':'5日','6日':'6日',
								'7日':'7日','8日':'8日','9日':'9日','10日':'10日','11日':'11日','12日':'12日','13日':'13日','14日':'14日',
								'15日':'15日','16日':'16日','17日':'17日','18日':'18日','19日':'19日','20日':'20日','21日':'21日','22日':'22日',
								'23日':'23日','24日':'24日','25日':'25日','26日':'26日','27日':'27日','28日':'28日','29日':'29日','30日':'30日','31日':'31日'}"
							emptyOption="true" cssStyle="width:25%;"/>
						<input type="hidden" id="reply_frequencys" name="interCtrlProblem.mend_progress_reply_frequency"/>
						<input type="hidden" id="reply_frequency_temp"/>
					</td>
				</tr>
				<tr>
	        		<td class='EditHead' ><font style='color:red'>*</font>&nbsp;提醒时间设置</td>
	        		<td class='editTd' colspan=3>
	        			提前&nbsp;<s:textfield cssClass="noborder" name="interCtrlProblem.mend_progress_reply_before" cssStyle="width:50px;"/>&nbsp;天，发提醒。
	        		</td>
	        	</tr>
	        </table>
    	</form>
	</div>
		    
    <div id="closer_div" title="分配关闭人" style='overflow:hidden;padding:0px;display: none'>
    	<form id='closer_form' name='closer_form' method="POST" style='overflow-y:auto;padding:10px;margin:0px;border:1px solid #cccccc;' >
			<table id="closer_table" class="ListTable" align="center" >
	        	<tr>
	        		<td class='EditHead' ><font style='color:red'>*</font>&nbsp;问题关闭人</td>
	        		<td class='editTd' colspan=3>
	        			<s:buttonText2 id="closer_name" hiddenId="closer_code"  cssClass="noborder"
							name="interCtrlProblem.closer_name" 
							hiddenName="interCtrlProblem.closer_code"
							doubleOnclick="showSysTree(this,
								{ url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action',
                                  param:{
                                     'p_item':1,
                                     'orgtype':1
                                  },
                                  title:'请选择问题关闭人',
                                  type:'treeAndEmployee',
                                  defaultDeptId:'${user.fdepid}'
								})"  
							doubleSrc="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png"
							doubleCssStyle="cursor:hand;border:0"
							readonly="true"
							maxlength="500" title="问题关闭人"/>
	        		</td>
	        	</tr>
	        </table>
      	</form>
    </div>
	<script type="text/javascript">
	
		$(document).ready(function(){
			// 设置多选框的默认选中项
			$("#reply_frequency_month").attr("value","");//清空选中项
			var ids = '${middleLedgerProblem.mend_progress_reply_frequency}';//选中框ID
			var index = ids.indexOf(")");
			$('#reply_frequency_temp').val(ids.substring(1,index));//月
			$('#reply_frequency_day').val(ids.substring(index+1));//日
			ids = ids.substring(1,index);
			var id_Object = (ids).split(",");//分割为Object数组
			var count = $("#reply_frequency_month option").length;//获取下拉框的长度
			for(var c = 0; c < id_Object.length; c++){
				for(var c_i = 0; c_i < count; c_i++) { 
			    	if($("#reply_frequency_month").get(0).options[c_i].value == id_Object[c]) {
			            $("#reply_frequency_month").get(0).options[c_i].selected = true;//设置为选中
			        }
			    }
			}
			$("#reply_frequency_month").multiSelect({ 
					selectAll: false,
					oneOrMoreSelected: '*',
					selectAllText: '全选',
					noneSelected: ''
				}, function(){
					//回调函数
					$('#reply_frequency_temp').val($("#reply_frequency_month").selectedValuesString());				
				});		
			$('.multiSelectOptions').css('width', '80px');
		});
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
			// doSearch();
		}
		// 初始化
		$(function(){
			document.getElementsByName("interCtrlProblem.evaAuditDept")[0].value = "${user.fdepname}";
			document.getElementsByName("interCtrlProblem.evaAuditDeptCode")[0].value = "${user.fdepid}";
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

			var rows=$('#list').datagrid('getSelections');

				if(rows.length>1){
					showMessage1('只能选择一条数据！');
					return false;
				}else if(rows.length>0){
				      var crudIdStrings = '';
				      for( var i=0;i<rows.length;i++){
				    	  crudIdStrings +=rows[i].id+',';
				      }
				      $('#crudIdStrings').val(crudIdStrings);
				      return true;
				}else{
				      showMessage1('请选择一条问题!');
				      return false;
				}
			
		}
		
		/**
         * 获取上一个月
         *
         * @date 格式为yyyy-mm-dd的日期，如：2014-01-25
         */
        function getPreMonth(date) {
            var arr = date.split('-');
            var year = arr[0]; //获取当前日期的年份
            var month = arr[1]; //获取当前日期的月份
            var day = arr[2]; //获取当前日期的日
            var days = new Date(year, month, 0);
            days = days.getDate(); //获取当前日期中月的天数
            var year2 = year;
            var month2 = parseInt(month) - 1;
            if (month2 == 0) {
                year2 = parseInt(year2) - 1;
                month2 = 12;
            }
            var day2 = day;
            var days2 = new Date(year2, month2, 0);
            days2 = days2.getDate();
            if (day2 > days2) {
                day2 = days2;
            }
            if (month2 < 10) {
                month2 = '0' + month2;
            }
            if(isNaN(month2)||month2==null||month2==""){
	            
	            return "";
            }
            var t2 = year2 + '-' + month2 + '-' + day2;
            return t2;
        }
		
		function cleanForm(){
			document.getElementsByName("middleLedgerProblem.project_code")[0].value = "";
			document.getElementsByName("middleLedgerProblem.audit_object")[0].value = "";
			document.getElementsByName("middleLedgerProblem.audit_object_name")[0].value = "";
			document.getElementsByName("middleLedgerProblem.is_closed")[0].value = "";
			document.getElementsByName("middleLedgerProblem.audit_dept_name")[0].value = "";
			document.getElementsByName("middleLedgerProblem.audit_dept")[0].value = "";
			document.getElementsByName("middleLedgerProblem.problem_name")[0].value = "";
			document.getElementsByName("middleLedgerProblem.problem_code")[0].value = "";
		}
			
		function changeButtonState(is_closed){
			var trackerButton = $('#assign_tracker');//分配跟踪人
			var closerButton = $('#assign_closer');//分配关闭人
			if(is_closed=='' || is_closed==null){
				trackerButton.linkbutton('enable');
				closerButton.linkbutton('enable');
			}else{
				trackerButton.linkbutton('disable');
				closerButton.linkbutton('disable');
				/* $('div.datagrid-toolbar a').eq(1).hide();
				$('div.datagrid-toolbar a').eq(2).hide(); */
			}
			return;
		}
		
		function openMsg(projectid){
			var viewUrl = "${contextPath}/proledger/problem/viewPro.action?crudId="+projectid;
            $('#showPlanName').attr("src",viewUrl);
            $('#planName').window('open');
			//window.open("${contextPath}/proledger/problem/viewPro.action?crudId="+projectid,"","height=700px, width=800px, toolbar=no, menubar=no, scrollbars=yes,resizable=yes,location=no, status=no");
		}
		$('#planName').window({
            width:950, 
            height:400,  
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
		<s:hidden id="crudIdStrings" name="crudIdStrings"/>
	</body>
</html>
