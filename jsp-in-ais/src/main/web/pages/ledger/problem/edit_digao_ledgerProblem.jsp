<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE HTML>
<html>
<s:if test="ledgerProblem.id!=null">
	<s:text id="title" name="'修改问题'"></s:text>
</s:if>
<s:else>
	<s:text id="title" name="'增加问题'"></s:text>
</s:else>
<head>
<%-- <title><s:property value="#title" /></title> --%>

<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>  
<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
<script type="text/javascript" src="${contextPath}/scripts/util/DateUtil.js"></script>
<script type="text/javascript" src="${contextPath}/scripts/validate.js"></script>
<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>  
<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/autosize.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/jquery-fileUpload.js"></script>
<%-- <script type="text/javascript" src="${contextPath}/scripts/ufaudTextLengthValidator.js"></script> --%>
<script type="text/javascript" src="<%=request.getContextPath()%>/pages/tlInteractive/tlInteractiveCommon.js"></script>
	<script type="text/javascript">
        $(function() {
            $("#audit_con").focus();
        });
	</script>
	<style type="text/css">
/* 浮动最上层 */
#div1 {
	z-index: 9;
}

#div2 {
	z_index: 1;
}
</style>
<script type="text/javascript">
var parentTabId = '${parentTabId}';
var curTabId = aud$getActiveTabId();
//var problemDuty2Arr = eval('${problemDuty2Arr}');
$(function(){
/* 	$("#zeren").combobox({
		onChange: function (n,o) {
			var zeren = $('#zeren').combobox('getValue');
			if(zeren == '') {
				$("#audit_law").val('');
			} else {
				for(i in problemDuty2Arr) {
					var codeName = problemDuty2Arr[i];
					if(codeName.code == zeren) {
						$("#audit_law").val(codeName.note);
						break;
					}
				} 
			}
		}
	}); */
	/* $('#orderOfSeverity').combobox({
		url:'${contextPath}/pages/ledger/problem/edit_digao_level.json',
		valueField:'id',
  	    textField:'text',
		onChange: function(n,o){
			if(n == '高') {
				$('#ofsDetail').combobox('reload','${contextPath}/pages/ledger/problem/edit_digao_detail.json');
			}else{
				$('#ofsDetail').combobox('setValue', '')
				$('#ofsDetail').combobox('reload','${contextPath}/pages/ledger/problem/edit_digao_empty.json');
			}
		}
	}); */
	
	/* $('#ofsDetail').combobox({
		url:'${contextPath}/pages/ledger/problem/edit_digao_detail.json',
		valueField:'id',
  	    textField:'text',
		onChange:function(n,o){
		}
	}); */
	 /* 
	var orderOfSeverity = '${ledgerProblem.orderOfSeverity}';
	if(orderOfSeverity != '') {
		$('#orderOfSeverity').combobox('setValue', orderOfSeverity);
		if(orderOfSeverity == '高') {
			$('ofsDetail').combobox('reload','${contextPath}/pages/ledger/problem/edit_digao_detail.json');
		} else {
			$('#ofsDetail').combobox('reload','${contextPath}/pages/ledger/problem/edit_digao_empty.json');
		}
	} else {
		$('#ofsDetail').combobox('reload','${contextPath}/pages/ledger/problem/edit_digao_empty.json');
	}
	$('#ofsDetail').combobox('setValue', '${ledgerProblem.ofsDetail}') */
	
	
	
	//是否量化下拉框不管选择的是还是否，发生数量都为1
	$("#audit_con").attr("maxlength",300);
	//$("#describe").attr("maxlength",6000);
	//$("#audit_law").attr("maxlength",2000);
	//$("#audit_advice").attr("maxlength",2000);
	accountantSystemTypeFun();
    var problemComment = $("#problemComment").val();
    if(problemComment != ""){
       $("#problemComment").css("display","block");
    }

    $('#searchAtTree').bind('click',loadSjsxTree);
	$('#clearAtTree').bind('click',function(){
		$('#contion_taskName').val('');
		loadSjsxTree();
	});
    loadSjsxTree();
    function loadSjsxTree(){
    	$.ajax({
    		url: '${contextPath}/ledger/problemledger/treeExpandNew.action',
			dataType:'json',
			cache:false,
			type:"POST",
			data:{'contion_taskName':$('#contion_taskName').val(),'pid':'0'},
			success:function(data){
				if(data.type=='success'){
					$('#auditObjectTreeId').tree({
						data: data.atTreeJson,
						checkbox: false,
						animate: false,
						lines: true,
						onClick:function(node, treeDom){
							genAuditCaseTabs('qtab', node);
						},
						onDblClick:function(node){
							$('#sureSelectWtlbTreeNode').trigger('click');
						}
					});
				}else{
					showMessage1(data.msg);
				}
			}
    	});
    }
   
   			/*var obj = $('#auditObjectTreeId')[0];
			var dpetId = '${user.fdepid}';

    $('#auditObjectTreeId').tree({
        url: '/ais/ledger/problemledger/treeExpand.action',
        checkbox: false,
        animate: false,
        lines: true
});

/*
    genAuditCaseTabs('qtab', node.id);
*/


   /* // 自定义 - 组织机构树
			showSysTree(obj,{
				container:obj,
				defaultDeptId:dpetId,
				param:{
                    /!*
					   数据授权模块id, 12:组织机构树授权; 如果是组织机构树,这个参数可选; 如果是其它树,如果想用数据授权限制查询范围,则必填;
					   如果想显示全部的节点，可以为authModuleId赋一个特殊值authModuleId=-1，使sql查询不到；
					*!/
					//'authModuleId':'12',// 按数据授权过滤
					//'authModuleId':'-1',// 显示全部节点
					'rootParentId':'0',
                    'beanName':'LedgerTemplateNew',
                    'treeId'  :'id',
                    'treeText':'name',
                    'treeParentId':'fid',
                    'treeOrder':'code'
                },

                 onDblClick:function(node){
        
				//	$('#sureSelectWtlbTreeNode').trigger('click');
				
			    }, 
                onTreeClick:function(node, treeDom){
                		
                		/!*
			        	var gridObject = $('#orgTable');
			        	// 缓存查询参数，供分页刷新等功能使用
			        	var gridQueryParamJson = {'query_eq_problemId':node.id,'sort':'case_name'};
			        	g1.setGridQueryParams(gridQueryParamJson);
			        	// datagrid加载通用方法
						QUtil.loadGrid({
					        // 请求的url, 可选如果没有，则使用表格默认的url； 可选
					        //url:xx,
					        // 传入的查询参数； 可选
					        param:gridQueryParamJson,
					        // 请求类型post or get， 默认为post请求; 可选
					        type:'post',
					        // 表格对象
					        gridObject:gridObject[0],
					        // 查询前和加载后执行的function
					        beforeSend:function(){},
					        afterSuccess:function(){}
						});
			        	*!/

                   genAuditCaseTabs('qtab', node.id);    
			        	
			    }
			   
			});*!/
            */
			
            // 创建审计案例tabs, add by qfucee, 2015.1.19
            function genAuditCaseTabs(tabsId, node, max_query_count){
                try{
                   max_query_count = !max_query_count ? 30 : max_query_count;
			       $.ajax({
						type: "POST",
						dataType:'json',
						url : "<%=request.getContextPath()%>/commonPlug/getCustomDatagrid.action",
						data:{
							'boName':'ProblemCase',
							'sort'  :'case_name',
							'query_eq_problemId':node.id,
							'number':max_query_count//最大查询记录
						},
						success: function(data){
							var rows = data.rows;
							var total = data.total;
							var qtabDiv = document.getElementById("qtab");
							var qtabDivHeight = qtabDiv.clientHeight||qtabDiv.offsetHeight;
							qtabDivHeight = qtabDivHeight - 90;
                            
                            var tabs_interval = window.setInterval(function(){
                                var tabs = $('#'+tabsId).tabs('tabs');
                                if(tabs && tabs.length > 0){
                                    for(var j=0; j<tabs.length; j++){
                                        $('#'+tabsId).tabs('close', j);
                                    }
                                }else{
                                    if(tabs_interval){
                                        clearInterval(tabs_interval);

                                        var content = [];
                                        content.push("<div style='overflow:hidden;'><table class='ListTable'>");
                                        content.push("<tr><td style='text-align:center;' class='EditHead'>政策法规依据</td></tr>");
                                        content.push("<tr><td style='width:100%;' class='editTd'>");
                                        content.push("<textarea class='mytabcontent' readonly style='border-width:0px;word-break:break-all;word-wrap:break-word;overflow:auto;padding:5px;color:gray;width:90%;height:"+qtabDivHeight+"px;'>");
                                        content.push(node.desc);
                                        content.push("</textarea></td></tr></table></div>");
                                    	$('#'+tabsId).tabs('add',{
                                            'title':'基本信息',
                                            'content':content.join('')
                                        });
                                        
                                        if(total){
                                            $.each(rows, function(index, row){
                                                var fjStr="";
                                                $.ajax({
                                                    dataType:'json',
                                                    url : "<%=request.getContextPath()%>/ledger/problemledger/getFujianUrl.action",
                                                    data: {id:row['id']},
                                                    type: "post",
                                                    async:false,
                                                    success: function(data){						
                                                        fjStr = data.fjUrl;
                                                    },
                                                    error:function(data){
                                                        top.$.messager.alert('提示信息','请求失败，请检查网络连接或与管理员联系','error');
                                                    }
                                                });
                                                var content = [];
                                                content.push("<div style='overflow:hidden;'><table class='ListTable'>");
                                                content.push("<tr><td style='text-align:center;' class='EditHead'>正文</td></tr>");
                                                content.push("<tr><td style='width:100%;' class='editTd'>");
                                                content.push("<textarea class='mytabcontent' readonly style='border-width:0px;word-break:break-all;word-wrap:break-word;height:140px;overflow:auto;width:590px;padding:5px;color:gray;'>");
                                                content.push(row.case_content);
                                                content.push("</textarea></td></tr>");
                                                content.push("<tr><td class='EditHead'><span style='float:left;'>附件信息</span><span style='float:right;color:gray;'>文件总数："+(fjStr.split('<li').length-1)+"</span></td></tr>");
                                                content.push("<tr><td style='width:100%;' class='editTd'><div style='color:gray;padding:5px 5px 5px 1px;height:105px;overflow:auto;'>");
                                                content.push(fjStr);
                                                content.push("</div></td></tr></table></div>");
                                                
                                                var tabTitle = row.case_name;
                                                if(tabTitle && tabTitle.length > 10){
                                                	tabTitle = tabTitle.substring(0,10)+'...';
                                                }
                                                $('#'+tabsId).tabs('add',{
                                                    'title':tabTitle,
                                                    'content':content.join('')
                                                });         
                                                var curTab = $('#'+tabsId).tabs('getTab', tabTitle);
                                                curTab.css('overflow','hidden');
                                            });
                                        }else{
                                            $('#'+tabsId).tabs('add',{
                                                'title':'案例信息',
                                                'content':"<div style='font-size:16px;text-align:center;padding:10px;'><strong><label style='text-align:center;'>该问题点下无问题案例!</label></strong></div>"
                                            });
                                        }
                                        $('#'+tabsId).tabs('select',0);
                                    }
                                }
                            },100);
						},
						error:function(data){
							top.$.messager.alert('提示信息','请求失败，请检查网络连接或与管理员联系','error');
						}
			       });
                }catch(e){
                    alert('genAuditCaseTabs:\n'+e.message);
                }
            }
			   
		// 打开问题类别树窗口
		var wtWidth = $('body').width()*0.8;
		wtWidth = wtWidth < 780 ? 780 : wtWidth;
		
		var wtHeight = $('body').height()*0.8;
		wtHeight = wtHeight < 400 ? 400 : wtHeight;	
	   $('#wtlbTreeSelectWrap').window({   
			width:wtWidth,   
			height:wtHeight,   
			modal:true,
			collapsible:false,
			maximizable:false,
			minimizable:false,
			closed:true
		});
	   $('#manuReferenceDiv').window({
			width:650, 
			height:550,  
			modal:true,
			collapsible:false,
			maximizable:false,
			minimizable:false,
			closed:true    
	    });
	   
   			
			$('#lr_openWtlbTree').bind('click',function(){
				$('#wtlbTreeSelectWrap').window('open');
				$('#wtlbTreeSelectWrap').window('resize',{
					'top':$('body')[0].scrollTop+($('body').height()-$('#wtlbTreeSelectWrap').height())/4
				});
			});
			
			$('#sureSelectWtlbTreeNode').bind('click',function(){
				var snode = $('#auditObjectTreeId').tree('getSelected');
				if(snode){
					if(!$('#auditObjectTreeId').tree('isLeaf',snode.target)){
						top.$.messager.alert('提示信息','不能添加问题类别，请选择问题点','error');
					}else{
					    var idArr = QUtil.getPriorNodeIds(snode.id,"/ais/commonPlug/getPriorNodeIdsById.action?beanName=LedgerTemplateNew&treeId=id&treeText=code&treeParentId=fid");
					    var str='';
					    for(var i=0;i<idArr.length;i++){
					    	str+=idArr[i]+'#';
					    }
					    $.ajax({
							type: "POST",
							dataType:'json',
							url : "/ais/proledger/problem/getLedgerTemplateNewNames.action",
							data:{
								'str':str
							},
							success: function(data){
								if(data.type == 'ok'){
									$('#att2').val(data.names);
									$('#att').val(data.ids);
									callback();
								}else{
									alert('入报告失败');
								}		
							},
							error:function(data){
								alert('请求失败！');
							}
						});
					    $('#wtlbTreeSelectWrap').window('close');
					}
				}else{
					top.$.messager.alert('提示信息','请选择问题点','error');
				}

			});
			$('#closeSelectWtlbTreeNode').bind('click',function(){
				$('#wtlbTreeSelectWrap').window('close');
			});
			if( "${ledgerProblem.manuscript_id }" == null || "${ledgerProblem.manuscript_id }" == ""){
				if('${ledgerProblem.lp_owner}'!=null && '${ledgerProblem.lp_owner}'!=''){
					$('#lp_owner').combobox('setValue','${ledgerProblem.lp_owner}');
					$('#lp_owner').combobox('setText','${ledgerProblem.lp_owner}');
				}
			}

});


function closeWinUI(){
	$('#manuReferenceDiv').window('close');
	//window.location.href="${contextPath}/auditAccessoryList/editSysAccount.action?projectId=${projectId}";
}


</script>
</head>
<body class="easyui-layout" onload="doProblemComment('${ledgerProblem.problem_name}');loadZeren('${ledgerProblem.zeren}')">
<div fit="true"   region="center" border='0'  style="overflow: auto; width: 100%;height: 100%;">
	<div region="center" border='0'>
		<s:form id="myform" action="save" namespace="/proledger/problem" cssStyle="text-align: center" >
		<div style="width: 100%;position:absolute;top:0px;"  id="div1" >
			<table class="ListTable" align="center" style='width: 98.3%; padding: 0px; margin: 0px;margin-top:0px;'>
			    
				<tr class="EditHead" >
				<td >
						<span style='float: left; text-align: left;'>
						<s:property value="#title" /></span>
			    </td> 
				<td style="text-align: left;">
				<span style='float: right; text-align: right;'>
				<s:if test="${viewFlag != 'view'}">
				<a id="" href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="this.style.disabled='disabled';saveForm1('${ledgerProblem.pro_type }');">保存</a>
				<a id="" href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="closePronlem();">关闭</a>
				&nbsp;
				<s:if test="${tableType != '1'}">
					<s:if test="${manuscriptType == 'digao'}">
		       
					&nbsp;&nbsp;
					</s:if>
					<s:else>
					<%--<a id="" href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-undo'" onclick="back();" >返回</a>
					&nbsp;&nbsp;--%>
					<a id="" href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-delete'" onclick="deletePro('${ledgerProblem.id}');" >删除</a>		       
					</s:else>
					  
				</s:if>
			</s:if>
			</span>
			</td>
			</tr>
			</table>
				</div>
		<div class="position:relative" id="div2">
				<table class="ListTable" align="center" style='margin-top: 40px; overflow: auto;'>
				<s:if test="${tableType == '1'}">
				<s:if test="${ledgerProblem.manuscript_name != null && ledgerProblem.manuscript_name != '' }">
					<tr>
						<td class="EditHead" style="width:15%;">所属底稿</td>
						<td class="editTd" colspan="3" style="width:85%;">
							<s:property value="ledgerProblem.manuscript_name"/>【<s:property value="ledgerProblem.manuscript_code"/>】
						</td>
					</tr>
					</s:if>
				</s:if>
				<tr>
					<td class="EditHead" style="width:15%;">问题类别</td>
					<td class="editTd" style="width:35%;">
						<s:textfield id="problem_all_name" name="ledgerProblem.problem_all_name" cssClass="noborder" cssStyle="width:70%" readonly="true" />&nbsp;&nbsp;<FONT color=DarkGray>自动生成</FONT>
						<s:hidden id="sort_big_code" name="ledgerProblem.sort_big_code" />
						<s:hidden id="sort_big_name" name="ledgerProblem.sort_big_name" />
						<s:hidden id="sort_small_code" name="ledgerProblem.sort_small_code" />
						<s:hidden id="sort_small_name" name="ledgerProblem.sort_small_name" />
						<s:hidden id="sort_three_code" name="ledgerProblem.sort_three_code" />
						<s:hidden id="sort_three_name" name="ledgerProblem.sort_three_name" />
						<s:hidden id="ledgerProblem_id" name="ledgerProblem.id" />
						<%--<input type="hidden" id="ledgerProblem_id" name="ledgerProblem.id"/>
					--%></td>
					<td class="EditHead" style="width:15%;">审计问题编号</td>
					<td class="editTd" style="width:35%;">
						<s:textfield name="ledgerProblem.serial_num" id="serial_num" cssClass="noborder" cssStyle="width:75%" readonly="true" />&nbsp;&nbsp;<FONT color=DarkGray>自动生成</FONT>
					</td>
				</tr>
				<tr>
					<td class="EditHead" width="15%"><FONT color=red>*</FONT>问题点</td>
					<td class="editTd" width="35%">
						<s:textfield name="ledgerProblem.problem_name" id="problem_name" cssClass="noborder" cssStyle="width:70%" readonly="true"/> 
						<s:hidden name="ledgerProblem.problem_code" id="problem_code"></s:hidden> &nbsp;
						
						<img  style="cursor:pointer;border:0" src="/ais/resources/images/s_search.gif" onclick="$('#wtlbTreeSelectWrap').window('open')"></img>
					</td>
					<td class="EditHead" id="problemCommentText"  width="15%">备注(问题点为其他)</td>
					<td class="editTd" width="35%">
					<s:textarea name="ledgerProblem.problemComment" id="problemComment" cssStyle="width:74%;height:30px;display:none" />
					<input type="hidden" id="ledgerProblem.problemComment.maxlength" value="1000">
					</td>
				</tr>
				<tr>
				
					<s:if test="${isGroupEnabled == 'false' }">
					  	<td class="EditHead"><FONT color=red>*</FONT>问题标题<br></td>
						<td class="editTd" >
							<s:textfield name="ledgerProblem.audit_con" id="audit_con" cssClass="noborder" cssStyle="width:90%"/>
							<input type="hidden" id="ledgerProblem.audit_con.maxlength" value="300">
						</td>
					</s:if>
					<s:else>
						<td class="EditHead"><FONT color=red>*</FONT>审计小组<br></td>
						<td class="editTd" >
						    <input id="auditGroup"/>
						</td>
					</s:else>
					<s:if test="${manuscriptType == 'digao' || (ledgerProblem.manuscript_id != null && ledgerProblem.manuscript_id != '') } ">
						<td class="EditHead">
							被审计单位
						</td>
						<td  class="editTd">
							<s:property value="ledgerProblem.audit_object_name"/>
						</td>
					</s:if>
					<s:elseif test="${tableType == '1'}">
						<td class="EditHead">
							<font color="red">*</font> 被审计单位
						</td>
						<td  class="editTd">
							<select id="audit_object"  class="easyui-combobox"  style="width:60%;" data-options="panelHeight:'auto'"  editable="false">
								<s:iterator value="auditObjectMap" id="entry">
									<s:if test="${ledgerProblem.audit_object==key}">
										<option selected="selected" value="<s:property value="key"/>"><s:property value="value"/></option>
									</s:if>
									<s:else>
										<option value="<s:property value="key"/>"><s:property value="value"/></option>
									</s:else>
								</s:iterator>
							</select>
						</td>
					</s:elseif>
					<s:else>
						<td class="EditHead"></td>
						<td class="editTd"></td>
					</s:else>
					

				</tr>
				<s:if test="${isGroupEnabled == 'true' }">
				<tr>
						<td class="EditHead"><FONT color=red>*</FONT>问题标题<br></td>
						<td class="editTd" colspan="3">
							<s:textfield name="ledgerProblem.audit_con" id="audit_con" cssClass="noborder" cssStyle="width:90%"/>
							<input type="hidden" id="ledgerProblem.audit_con.maxlength" value="300">
						</td>
				</tr>
				</s:if>
				<tr>
					<td class="EditHead">涉及金额</td>
					<td class="editTd">
						<%-- <input type="text" name="ledgerProblem.problem_money" id="problem_money" cssClass="noborder" cssStyle="width:45%" maxlength="15" value='<fmt:formatNumber value="${ledgerProblem.problem_money}" pattern="###.############"/>'/>		 --%>			
						<s:textfield name="ledgerProblem.problem_money" id="problem_money" cssClass="noborder" title="涉及金额" cssStyle="width:34%" doubles="true" maxlength="15" />&nbsp;万元
					</td>
					<td class="EditHead">发生数量</td>
					<td class="editTd"><s:textfield name="ledgerProblem.problemCount" id="problemCount" title="发生数量" cssClass="noborder" cssStyle="width:45%" doubles="true" maxlength="5" />&nbsp;个</td>
					
				</tr>
				
				<%-- <tr>
					<td class="EditHead">问题所属开始日期</td>
					<td class="editTd">
						<input type="text"  id="creater_startdate" name="ledgerProblem.creater_startdate" class="easyui-datebox" style="width: 160px"
							value="${ledgerProblem.creater_startdate }" editable="false"/>
					</td>
					<td class="EditHead">问题所属结束日期</td>
					<td class="editTd">
						<input type="text"  id="creater_enddate" name="ledgerProblem.creater_enddate" class="easyui-datebox" style="width: 160px"
							value="${ledgerProblem.creater_enddate }" editable="false"/>
						</td>
				</tr> --%>
				
					<tr>
						<td class="EditHead">审计发现类型</td>
						<td class="editTd">
								<%-- <s:select list="basicUtil.problemMethodList" listKey="code" listValue="name" emptyOption="true" name="ledgerProblem.problem_grade_code"></s:select> --%>
							<select id="problem_grade_code" class="easyui-combobox" name="ledgerProblem.problem_grade_code" style="width:160px;" data-options="panelHeight:100" editable="false">
								<option value="">&nbsp;</option>
								<s:iterator value="basicUtil.problemMethodList" id="entry">
									<s:if test="${ledgerProblem.problem_grade_code==code}">
										<option selected="selected" value="<s:property value="code"/>"><s:property value="name"/></option>
									</s:if>
									<s:else>
										<option value="<s:property value="code"/>"><s:property value="name"/></option>
									</s:else>
								</s:iterator>
							</select>
						</td>
						<td class="EditHead"><FONT color=red>*</FONT>重要程度</td>
						<td class="editTd">
							 <select name="ledgerProblem.orderOfSeverity" class="easyui-combobox" id="orderOfSeverity" data-options="editable:false,panelHeight:'100'" style="width:160px">
								<option value="">&nbsp;</option>
								<s:iterator value="basicUtil.importtant_degreeList" id="entry">
									<s:if test="${ledgerProblem.orderOfSeverity==code}">
										<option selected="selected" value="<s:property value="code"/>"><s:property value="name"/></option>
									</s:if>
									<s:else>
										<option value="<s:property value="code"/>"><s:property value="name"/></option>
									</s:else>
								</s:iterator>
							 </select>
							<s:hidden  name="ledgerProblem.ofsDetail" id="ofsDetail"/>
							 <%-- <select name="ledgerProblem.ofsDetail" id="ofsDetail" data-options="editable:false,panelHeight:'auto'" style="width:160px"></select> --%>
						</td>
					</tr>
				
					<s:if test="${pso.planProcess ne 'simplified'}">
						<tr>
							<s:if test="ledgerProblem.pro_type == '020312'">
								<td class="EditHead">责任
									<div><FONT color=red>(经济责任审计)</FONT></div>
								</td>
								<td class="editTd">
									<select id="zeren" class="easyui-combobox" name="ledgerProblem.zerencode"  style="width:160px;" data-options="panelHeight:100,editable:false" editable="false">
									   <option value="">&nbsp;</option>
									   <s:iterator value="basicUtil.problemDutyList" id="entry">
											 <s:if test="${ledgerProblem.zerencode==code}">
												<option selected="selected" value="<s:property value="code"/>"><s:property value="name"/></option>
											 </s:if>
											 <s:else>
												<option value="<s:property value="code"/>"><s:property value="name"/></option>
											 </s:else>
									   </s:iterator>
									</select>
								</td>
							</s:if>
							<s:else>
								<td class="EditHead">责任
									<div><FONT color=DarkGray>(非经济责任审计)</FONT></div>
								</td>
								<td class="editTd" >
									<select id="zeren" class="easyui-combobox" name="ledgerProblem.zerencode" style="width:160px;" data-options="panelHeight:100,editable:false">
									   <option value="">&nbsp;</option>
									   <s:iterator value="basicUtil.problemDuty2List" id="entry">
											 <s:if test="${ledgerProblem.zerencode==code}">
												<option selected="selected" value="<s:property value="code"/>"><s:property value="name"/></option>
											 </s:if>
											 <s:else>
												<option value="<s:property value="code"/>"><s:property value="name"/></option>
											 </s:else>
									   </s:iterator>
									</select>
								</td>
							</s:else>
							<td class="EditHead">问题发现日期</td>
							<td class="editTd">
								<s:property value="ledgerProblem.problem_date"/>
								<s:hidden  name="ledgerProblem.problem_date"/>
							</td>
						</tr>
					</s:if>
					<s:else>
						<tr>
							<td class="EditHead">问题发现日期</td>
							<td class="editTd" colspan="3">
								<s:property value="ledgerProblem.problem_date"/>
								<s:hidden  name="ledgerProblem.problem_date"/>
							</td>
						</tr>
						<tr>
							<td class="EditHead">是否入报告
							</td>
							<td class="editTd" >
								<select id="isInReport" class="easyui-combobox" name="ledgerProblem.isInReport" style="width:160px;" data-options="panelHeight:80,editable:false">
									<option value="是">是</option>
									<option value="否">否</option>
								</select>
							</td>
							<td class="EditHead">是否整改
							</td>
							<td class="editTd" >
								<select id="isNotMend" class="easyui-combobox" name="ledgerProblem.isNotMend" style="width:160px;" data-options="panelHeight:80,editable:false">
									<option value="是">是</option>
									<option value="否">否</option>
								</select>
							</td>
						</tr>
					</s:else>
					<tr>
						<td class="EditHead">问题录入人</td>
						<td class="editTd">
							<s:property value="ledgerProblem.creater_name"/>
						</td>
						<td class="EditHead">问题发现人</td>
						<td class="editTd">
							<%-- <s:textfield name="ledgerProblem.lp_owner" id="lp_owner" maxlength="100" cssClass="noborder"/> --%>
							<s:if test="${ledgerProblem.manuscript_id == null || ledgerProblem.manuscript_id == '' } ">
								 <select id="lp_owner" class="easyui-combobox"  data-options="panelHeight:'auto'"  name="ledgerProblem.lp_owner" style="width: 160px;" editable="true">
								  <s:iterator value="memberObjectMap" id="entry">
									<s:if test="${ledgerProblem.lp_owner==key}">
										<option selected="selected" value="<s:property value="key"/>"><s:property value="value" /></option>
									</s:if>
									<s:else>
										<option value="<s:property value="key"/>"><s:property value="value" /></option>
									</s:else>
								</s:iterator>
							  </select>
							</s:if>
							<s:else>
								<s:property value="ledgerProblem.lp_owner"/>
								<s:hidden name="ledgerProblem.lp_owner"/>
							</s:else>

						</td>
					</tr>
					<s:if test="${tableType == '1'}">
						<tr>
							<td class="EditHead"><FONT color=red>*</FONT>是否采纳审计意见</td>
							<td class="editTd">
								 <select class="easyui-combobox" name="ledgerProblem.sfcnsjyj" id="sfcnsjyj" data-options="editable:false,panelHeight:'100'" style="width:160px">
								 	<option value="">&nbsp;</option>
								    <s:iterator value='#@java.util.LinkedHashMap@{"是":"是","否":"否"}' id="entry">
										<s:if test="${ledgerProblem.sfcnsjyj==key}">
								       		<option selected="selected" value="<s:property value="key"/>"><s:property value="value"/></option>
								        </s:if>
								       	<s:else>
										    <option value="<s:property value="key"/>"><s:property value="value"/></option>
								       	</s:else>
								    </s:iterator>
								 </select>
							</td>
						    <s:if test="${ledgerProblem.manuscript_name != null && ledgerProblem.manuscript_name != '' }">
							<td></td>
							<td></td>
							<s:hidden  name="ledgerProblem.linkManuName" value="${ledgerProblem.linkManuName}"/>
							</s:if>
							<s:else>
							 <td class="EditHead">
								关联底稿
							 </td>
							 <td class="editTd">
							  <s:if test="${sourceSite == 'historyedit' || sourceSite == 'syEdit' }">
							  	<s:textfield name="ledgerProblem.linkManuName"  id="mylinkManuName" cssStyle='width:260px' cssClass="noborder"  />
							  </s:if>
							  <s:else>
								<s:textfield name="ledgerProblem.linkManuName"  id="mylinkManuName" cssStyle='width:260px' cssClass="noborder" readonly="true" />
								<!--一般文本框-->
								<s:hidden name="ledgerProblem.linkManuId" id="mylinkManuId" value="${ledgerProblem.linkManuId}"/>
								<img src="<%=request.getContextPath()%>/resources/images/s_search.gif" onclick="getOwerManu()" border=0 style="cursor: hand">
							 </s:else>
							 </td>
							</s:else>

						</tr>
						<tr>
							<td class="EditHead"><FONT color=red>*</FONT>违规违纪类型</td>
							<td class="editTd">
								<select id="wgwjlxCode" class="easyui-combobox" name="ledgerProblem.wgwjlxCode" style="width:160px;" data-options="panelHeight:100" editable="false">
									<option value="">&nbsp;</option>
									<s:iterator value="basicUtil.wgwjlxList" id="entry">
										<s:if test="${ledgerProblem.wgwjlxCode==code}">
											<option selected="selected" value="<s:property value="code"/>"><s:property value="name"/></option>
										</s:if>
										<s:else>
											<option value="<s:property value="code"/>"><s:property value="name"/></option>
										</s:else>
									</s:iterator>
								</select>
								<s:hidden name="ledgerProblem.wgwjlxName" id="wgwjlxName" />
							</td>
							<td class="EditHead" nowrap><FONT color=red>*</FONT>违规违纪金额（万元）</td>
							<td class="editTd">
								 <s:textfield name="ledgerProblem.wgwjje" id="wgwjje" cssClass="noborder" title="违规违纪金额" cssStyle="width:34%" doubles="true" maxlength="15" />&nbsp;万元
							</td>
						</tr>
					</s:if>
			
					<%-- <tr>
						<td class="EditHead"><FONT color=red>*</FONT>与本单位经营战略相关度</td>
						<td class="editTd">
							<select class="easyui-combobox" name="ledgerProblem.tacticRelevancy"  id='tacticRelevancy' style="width:160px" data-options="panelHeight:100" editable="false">
								<option value="">&nbsp;</option>
								<s:iterator value='#@java.util.LinkedHashMap@{"高":"高","中":"中","低":"低"}'>
									<s:if test="${ledgerProblem.tacticRelevancy == key}">
										<option selected="selected" value="${value}">${key}</option>
									</s:if>
									<s:else>
										<option value="${value}">${key}</option>
									</s:else>
								</s:iterator>
							</select>
						</td>
						<td class="EditHead">发生频率</td>
						<td class="editTd">
							<select class="easyui-combobox" name="ledgerProblem.occurrence" style="width:160px" data-options="panelHeight:100" editable="false">
								<option value="">&nbsp;</option>
								<s:iterator value='#@java.util.LinkedHashMap@{"高":"高","中":"中","低":"低"}'>
									<s:if test="${ledgerProblem.occurrence == key}">
										<option selected="selected" value="${value}">${key}</option>
									</s:if>
									<s:else>
										<option value="${value}">${key}</option>
									</s:else>
								</s:iterator>
							</select>
						</td>
					</tr> --%>
				 
					<tr>
						<td class="EditHead">问题描述<br><font color=DarkGray>(限6000字)</font></td>
						<td class="editTd" colspan="3">
							<s:textarea name="ledgerProblem.describe"  title="问题摘要" id="describe" cssClass='noborder'  rows="5" cssStyle="width:100%;overflow-y:visible;line-height:160%;"  />
							<input type="hidden" id="ledgerProblem.describe.maxlength" value="6000">
						</td>
					</tr>	
					<tr>
						<td class="EditHead">定性依据<br><a id="lr_openZcfgTree" mc='audit_law' href="javascript:void(0);" class="easyui-linkbutton"
																		data-options="iconCls:'icon-search'" onclick="resizeViewHeight();" >引用法规制度</a><br><font color=DarkGray>(限3000字)</font></td>
						<td class="editTd" colspan="3">
							<s:if test="${empty ledgerProblem.audit_law}">
								<s:textarea cssClass='noborder' id='audit_law'
									name="ledgerProblem.audit_law" rows="5"
									cssStyle="width:100%;overflow-y:visible;line-height:150%;" />
							</s:if> <s:else>
								<s:textarea cssClass='noborder' id='audit_law'
									name="ledgerProblem.audit_law" value="${ledgerProblem.audit_law}"
									rows="5"
									cssStyle="width:100%;overflow-y:visible;line-height:150%;" />
							</s:else>
						</td>
					</tr>

					<tr>
						<td class="EditHead" nowrap>审计建议<br><font color=DarkGray>(限3000字，如无建议请填写“无”)</font></td>
						<td class="editTd" colspan="3">
							<s:textarea name="ledgerProblem.audit_advice" title="审计建议" id="audit_advice" cssClass='noborder'  rows="5" cssStyle="width:100%;overflow-y:visible;line-height:160%;"  />
							<input type="hidden" id="ledgerProblem.audit_advice.maxlength" value="500">
						</td>
					</tr>		

			</table>
       
			<!-- <div align="left">
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:void(0);" onclick="triggerTab('tab2');">问题整改要求</a>
				</div> -->
			<%-- <table cellpadding=1 cellspacing=1 border=0 bgcolor="#409cce" class="ListTable" id="tab2" style="display: none;">
				<tr>
					<td class="EditHead">是否需要整改:</td>
					<td class="editTd"><s:select list="#@java.util.LinkedHashMap@{'是':'是','否':'否'}" name="ledgerProblem.isNotMend" id="isNotMend" emptyOption="true"></s:select></td>
					<td class="EditHead">整改期限:</td>
					<td class="editTd"><s:textfield name="ledgerProblem.mend_term" id="mend_term" readonly="true" title="单击选择日期" onclick="calendar()" cssStyle="width:30%" maxlength="20" /> 至 <s:textfield name="ledgerProblem.mend_term_enddate" id="mend_term_enddate" readonly="true" title="单击选择日期" onclick="calendar()" cssStyle="width:30%" maxlength="20" /></td>
				</tr>
				<tr>
					<td class="EditHead">责任单位:</td>
					<td class="editTd"><s:textfield name="ledgerProblem.zeren_company" maxlength="200" /></td>
					<td class="EditHead">整改责任部门:</td>
					<td class="editTd"><s:textfield name="ledgerProblem.zeren_dept" maxlength="200" /></td>

				</tr>
				<tr>
					<td class="EditHead">整改负责人:</td>
					<td class="editTd"><s:textfield name="ledgerProblem.zeren_person" maxlength="100" /></td>
					<td class="EditHead">监督检查人:</td>
					<td class="editTd"><s:textfield name="ledgerProblem.examine_creater_code" maxlength="100" /></td>
				</tr>
				<tr>
					<td class="EditHead">建议追责方式:</td>
					<td class="editTd"><s:select list="basicUtil.mendMethodList" listKey="code" id="mendSelect" listValue="name" emptyOption="true" name="ledgerProblem.mend_method_code">
						</s:select> <s:hidden name="ledgerProblem.mend_method"></s:hidden></td>
					<td class="EditHead">检查方式:</td>
					<td class="editTd"><s:select list="basicUtil.examineMethodList" listKey="code" id="examineSelect" listValue="name" emptyOption="true" name="ledgerProblem.examine_method_code">
						</s:select> <s:hidden name="ledgerProblem.examine_method"></s:hidden></td>
				</tr>
				<tr>
					<td class="EditHead">整改建议:<font color=DarkGray>(限3000字)</font></td>
					<td class="editTd" colspan="7"><s:textarea name="ledgerProblem.aud_action_plan" title="整改建议" cssStyle="width:90%" /> <input type="hidden" id="ledgerProblem.aud_action_plan.maxlength" value="3000"></td>
				</tr>
			</table> --%>
			
			<s:hidden name="project_id" />
			<s:hidden name="manuscript_id" />
			<s:hidden name="manuscriptType" />
			<s:hidden name="ledgerProblem.project_id" value="${project_id}" />
			<s:hidden name="ledgerProblem.manuscript_id" value="${manuscript_id}" />
			<s:hidden name="ledgerProblem.id" />
			<s:hidden name="ledgerProblem.creater_code" />
			<s:hidden name="ledgerProblem.creater_name" />
			<s:hidden name="audDoubtpage" value="${audDoubtpage}"/>
			<s:hidden name="tableType" />
			<s:hidden name="sourceSite"/>
	        <input type="hidden" id="audit_object_id" name="ledgerProblem.audit_object" /> 
			<input type="hidden" id="audit_object_name" name="ledgerProblem.audit_object_name"/>
			<input type="hidden" id="groupId" name="ledgerProblem.groupId" value="${ledgerProblem.groupId}" />
			<input type="hidden" id="groupName" name="ledgerProblem.groupName"value="${ledgerProblem.groupName}" />
			<input type="hidden" id="att" name="att" value="">
			<input type="hidden" id="att2" name="att2" value="">
            <jsp:include flush="true" page="/pages/adl/zcfgTree.jsp" />
		</div>	
		</s:form>
		   <s:if test="${sourceSite =='historyedit' || sourceSite == 'syEdit'}">
		     <jsp:include flush="true" page="/pages/ledger/problem/other/edit_history_ledgerProblem_rec.jsp" /> 
		   </s:if>
	 </div>
	</div>
	     
	<!-- 问题类别树 -->
	<div id='wtlbTreeSelectWrap' title='问题点' style='overflow:hidden; margin:0px;'>
		<div id="container" class='easyui-layout' fit='true' >
			<div  region="west"  split="true" style='width:420px;overflow: auto;' title='问题树'>
				<div style="text-align: left; padding: 5px 5px 5px 5px; border: 1px solid #cccccc;position:fixed;margin-top: 0px;background-color:#FFFFFF " >
					<font style="font-weight: bold;">搜索:</font>  &nbsp;
					<s:textfield id="contion_taskName" maxLength="100" cssClass="noborder"
								 cssStyle="width:180px;padding-top:5px;"></s:textfield>
					&nbsp;
					<button id='searchAtTree' class="easyui-linkbutton"
							iconCls="icon-search">搜索</button>
					&nbsp;
					<button id='clearAtTree' class="easyui-linkbutton"
							iconCls="icon-empty">清空</button>
				</div>
	            <div style="margin-top: 35px;">
	              <ul id='auditObjectTreeId' class='easyui-tree'></ul>
	            
	            </div>
				
		    </div>
		    <div region="center">
		    	 <div id="qtab" class="easyui-tabs"  fit="true" style="overflow-x:auto;">
		    	 	<!--
		    		<div title='问题案例信息' id='tab2'>
		    			<table id='orgTable'></table>
		    		</div>
		    		-->
		    	 </div>
		    </div>
		    <div region="south" style="height:40px;padding:5px 5px 3px 5px;text-align:right;overflow:hidden;">
			 	<button id='sureSelectWtlbTreeNode'  class="easyui-linkbutton" iconCls="icon-add">添加</button>&nbsp;&nbsp;
			 	<button id='closeSelectWtlbTreeNode' class="easyui-linkbutton" iconCls="icon-cancel">关闭</button> 
		 	</div>
		</div>
	</div>
	     <div id="manuReferenceDiv" title="关联底稿数据" style='overflow:hidden;padding:0px;'> 	  		
				<iframe id="myFrame" name="myFrame" title="引用底稿" src="" width="100%" height="100%" frameborder="0"><!-- main --></iframe>				
	      </div>
	<script language="javascript">
		function triggerTab(tab) {
			var isDisplay = document.getElementById(tab).style.display;
			if (isDisplay == '') {
				document.getElementById(tab).style.display = 'none';
			} else {
				document.getElementById(tab).style.display = '';
			}
		}

		function resizeViewHeight() {
            setTimeout(function () {
                //修改datagrid高度
                /*var viewHeight = $('#zcfgTreeSelectWrap .datagrid-view')[0].style.height;
                var height = viewHeight.replace('px', '');
                var heightNum = parseInt(height) - 28;
                $('#zcfgTreeSelectWrap .datagrid-view')[0].style.height = heightNum + 'px';*/
                // 去除全文检索包围的a标签
				if(typeof( $('#zcfgTreeSelectWrap .datagrid-toolbar a').children()[0]) != 'undefined') {
					var querySpan = $('#zcfgTreeSelectWrap .datagrid-toolbar a').children()[0].innerHTML;
					$('#zcfgTreeSelectWrap .datagrid-toolbar a')[0].remove();
					$('#zcfgTreeSelectWrap .datagrid-toolbar td')[0].innerHTML = querySpan;
				}
            }, 100)
        }
		function saveForm() {
			var problem_money = document.getElementById("problem_money").value;
			/* var creater_startdate = document.getElementById("creater_startdate").value.replace(/-/g, "/");
			var creater_enddate = document.getElementById("creater_enddate").value.replace(/-/g, "/");
			var d1 = new Date(creater_startdate);
			var d2 = new Date(creater_enddate);
			if (Date.parse(d1) - Date.parse(d2) > 0) {
				alert("问题所属开始日期不能大于结束日期!");
				return false;
			} */

			if (frmCheck(document.forms[0], 'tab1')) {
				if (!isMoneyNum1(problem_money)) {
					alert("发生数应该填写金额!");
					return false;
				}
				var p_unit = document.getElementsByName("ledgerProblem.p_unit_code")[0].value;
				if (p_unit == '' || p_unit == null) {
					alert("请选择统计数量单位!");
					return false;
				}
				//取得 select 的text值
				var selectObj = document.getElementById("mendSelect");
				document.getElementById("ledgerProblem.mend_method").value = selectObj.options[selectObj.selectedIndex].text;
				var selectObj = document.getElementById("examineSelect");
				document.getElementById("ledgerProblem.examine_method").value = selectObj.options[selectObj.selectedIndex].text;
				var mend_term = document.getElementById("mend_term").value;
				var mend_term_enddate = document.getElementById("mend_term_enddate").value;
				var isNotMend = document.getElementById("isNotMend").value;
				if (isNotMend == '是') {
					if (mend_term == null || mend_term == '') {
						alert("整改期限开始日期不能为空!");
						return false;
					}
					if (mend_term_enddate == null || mend_term_enddate == '') {
						alert("整改期限结束日期不能为空!");
						return false;
					}
					/*var dts = new Date(Date.parse(mend_term.replace(/-/g, "/")));
					var dte = new Date(Date.parse(mend_term_enddate.replace(/-/g, "/")));
					if (dte < dts) {
						alert("结束日期不能小于开始日期!");
						return false;
					}*/
					 if(judgeTimeS_E(mend_term,mend_term_enddate)){
					      return true;
					   }else{
					     return false;
					   }
				}
				
				var problemCount = document.getElementById("problemCount").value;
				if(fillNumOnly(problemCount)){
					 return true;
				}else{
					return false;
				}
				$.ajax({
					type : "POST",
					url : "${contextPath}/proledger/problem/save.action",
					data : $("#myform").serialize(),
					success : function(msg) {
						if (msg == 1) {
							parent.doSelectWrap();
						}
					}
				});
			}
		}
		  /*
		 *校验问题所属结束日期必须大于问题所属开始日期 
		 */
		function judgeTimeS_E(mend_term,mend_term_enddate){
			//结束时间必须大于开始时间的校验
			if(mend_term!=null && mend_term!="" && mend_term_enddate!=null && mend_term_enddate!=""){
			   	    var reg=new RegExp("-","g"); //创建正则RegExp对象
			        var tempBeginTime=(mend_term).replace(reg,"");
			        var tempEndTime=(mend_term_enddate).replace(reg,"");
			        var today   =   new   Date();    //获得当前时间
			        var date=today.getDate();//格式化拼接获得正确的当前时间
			        month=today.getMonth();
			        month=month+1;
			        if(month<=9)
			        month="0"+month;
			        year=today.getYear();
			        var nowDate=year+'-'+month+'-'+date;
			        var tempDate=(nowDate).replace(reg,"");
			        var ts=tempBeginTime-0;
			        var te=tempEndTime-0;
			        var tt=tempDate-0;
			        /* if(ts<tt){
			             alert("问题所属开始日期不能小于当前时间!");
			             return false;
			        }else if(te<tt){
			             alert("问题所属结束日期必须大于当前时间!");
			             return false;
			         }else */
			        if(ts>te){
			             alert("问题所属开始日期必须小于问题所属结束日期!");
			             return false;
			         }
			             return true;
			}
		             return true;
		}	

		function saveForm1(proType) {
			
		    if( "${ledgerProblem.manuscript_id }" == null || "${ledgerProblem.manuscript_id }" == ""){
		    	$('#lp_owner').combobox('setValue',$('#lp_owner').combobox('getText'));
		    }
		    if ("${isGroupEnabled}" == "true"){
		    	var text1 = $('#auditGroup').combobox('getText');
		    	var value1 = $('#auditGroup').combobox('getValue');
		    	$('#groupId').val(value1);
		    	$('#groupName').val(text1);
		    }
			
			//if (frmCheck(document.forms[0], 'tab1')) {
				var problem_name = document.getElementById("problem_name").value;
				if(null!='${tableType}'&&''!='${tableType}'&&'1'=='${tableType}' && ( '${ledgerProblem.manuscript_id}'  == null || '${ledgerProblem.manuscript_id}' =="")){
					var text = $('#audit_object').combobox('getText');
					var value = $('#audit_object').combobox('getValues');
					$('#audit_object_id').val(value);
					$('#audit_object_name').val(text);
				}

				if( checkProblemComment(problem_name)){
					if(problem_name == ''||problem_name == null){
						window.parent.top.$.messager.show({
							title:"提示信息",
							msg:"请选择问题点！"
						});
						return false;
					}
				}else{
					var problemComment = document.getElementById("problemComment").value;
					if (problemComment == '' || problemComment == null) {
						top.$.messager.show({
							title:"提示信息",
							msg:"请填写备注！"
						});
							return false;
						}
				}

				//校验字数
				var dlg = $("#describe").val().length;
				if(dlg > 6000){
                    top.$.messager.show({
                        title:"提示信息",
                        msg:"问题描述的长度不能大于6000字!"
                    });
                    return false;
				}
				var audlg = $("#audit_advice").val().length;
				if(audlg > 3000){
					top.$.messager.show({
						title:"提示信息",
						msg:"审计建议的长度不能大于3000字!"
					});
					return false;
				}
				var aualg = $("#audit_law").val().length;
				if(aualg > 3000){
					top.$.messager.show({
						title:"提示信息",
						msg:"定性依据的长度不能大于3000字!"
					});
					return false;
				}
				
				var tempVal = $("#problem_money").val();
				if(tempVal!='' && tempVal!=null){
				    if(/[^\d|\.]/.test(tempVal)){
                        top.$.messager.show({
                            title:"提示信息",
                            msg:"涉及金额格式不正确!"
                        });
                        return false;
                    }

					if(!/^(\d+(,\d\d\d)*(\.\d{2})?|\d+(\.\d{1,2})?)$/.test(tempVal)){
						top.$.messager.show({
							title:"提示信息",
							msg:"涉及金额填写数字，最多支持2位小数!"
						});
						return false;
					}
				}	
				
				var tempAudit_con=$("#audit_con").val().trim();
				if(tempAudit_con == ''||tempAudit_con == null ){
					window.parent.top.$.messager.show({
						title:"提示信息",
						msg:"问题标题不能为空！"
					});
					return false;
				}
							
				var tempVal = $("#problemCount").val();
				if(tempVal!='' && tempVal!=null){
					if(!/^\d+$/.test(tempVal)){
						top.$.messager.show({
							title:"提示信息",
							msg:"发生数量请填写整数!"
						});
						return false;
					}
				}
				
				/* var tacticRelevancy = $('#tacticRelevancy').combobox('getValue');
				if(tacticRelevancy == '') {
					window.parent.top.$.messager.show({
						title:"提示信息",
						msg:"与本单位经营战略相关度不能为空！"
					});
					return false;
				} */
				
				var orderOfSeverity = $('#orderOfSeverity').combobox('getValue');
				$('#ofsDetail').val($('#orderOfSeverity').combobox('getText'));
				if(orderOfSeverity == '') {
					window.parent.top.$.messager.show({
						title:"提示信息",
						msg:"重要程度不能为空！"
					});
					return false;
				} /* else {
					if(orderOfSeverity == '高') {
						var ofsDetail = $('#ofsDetail').combobox('getValue');
						if(ofsDetail == '') {
							window.parent.top.$.messager.show({
								title:"提示信息",
								msg:"重要程度描述不能为空！"
							});
							return false;
						}
					}
				} */
				
				/* //var mend_term = document.getElementById("creater_startdate").value;
				var mend_term = $('#creater_startdate').datebox('getValue'); 
				//var mend_term_enddate = document.getElementById("creater_enddate").value;
				var mend_term_enddate = $('#creater_enddate').datebox('getValue'); 
				if(mend_term!=null && mend_term!="" && mend_term_enddate!=null && mend_term_enddate!=""){
			   	    var reg=new RegExp("-","g"); //创建正则RegExp对象
			        var tempBeginTime=(mend_term).replace(reg,"");
			        var tempEndTime=(mend_term_enddate).replace(reg,"");
			        var today   =   new   Date();    //获得当前时间
			        var date=today.getDate();//格式化拼接获得正确的当前时间
			        month=today.getMonth();
			        month=month+1;
			        if(month<=9)
			        month="0"+month;
			        year=today.getYear();
			        var nowDate=year+'-'+month+'-'+date;
			        var tempDate=(nowDate).replace(reg,"");
			        var ts=tempBeginTime-0;
			        var te=tempEndTime-0;
			        var tt=tempDate-0; */
			       /*   if(ts<tt){
			             alert("问题所属开始日期不能小于当前时间!");
			             return false;
			        }else if(te<tt){
			             alert("问题所属结束日期必须大于当前时间!");
			             return false;
			         }else */
			        /*  if(ts>te){
			             top.$.messager.show({
								title:"提示信息",
								msg:"问题所属开始日期必须小于问题所属结束日期!"
							});
			             return false;
			         }
				} */
				
				if('${tableType}'=='1'){
					var sfcnsjyj = $('#sfcnsjyj').combobox('getValue');
					if(sfcnsjyj == '') {
						window.parent.top.$.messager.show({
							title:"提示信息",
							msg:"是否采纳审计意见不能为空！"
						});
						return false;
					}

					var wgwjlxCode = $('#wgwjlxCode').combobox('getValue');
					var wgwjlxName = $('#wgwjlxCode').combobox('getText');
					if(wgwjlxCode == '') {
						window.parent.top.$.messager.show({
							title:"提示信息",
							msg:"违规违纪类型不能为空！"
						});
						return false;
					}
					$('#wgwjlxName').val(wgwjlxName);

					var tempVal1 = $("#wgwjje").val();
					if (tempVal1 == null || tempVal1 == '' ){
						window.parent.top.$.messager.show({
							title:"提示信息",
							msg:"违规违纪金额不能为空！"
						});
						return false;
					}
					if(tempVal1!='' && tempVal1!=null){
					    if(/[^\d|\.]/.test(tempVal1)){
	                        top.$.messager.show({
	                            title:"提示信息",
	                            msg:"违规违纪金额格式不正确!"
	                        });
	                        return false;
	                    }

						if(!/^(\d+(,\d\d\d)*(\.\d{2})?|\d+(\.\d{1,2})?)$/.test(tempVal1)){
							top.$.messager.show({
								title:"提示信息",
								msg:"违规违纪金额填写数字，最多支持2位小数!"
							});
							return false;
						}
					}
				}

				var myform = $("#myform").serialize();
				var urlForm = myform;
				if ("${sourceSite}" == "historyedit" || "${sourceSite}" == "syEdit"){
					if (!checkExamine()){
						return false;
					}
					if ( "${sourceSite}" == "historyedit"  ){
						if (!checkAudTrackingRework()){
							return false;
						}
					}
					var updateTrackingProblem =  $("#updateTrackingProblem").serialize();
					urlForm = myform+"&"+updateTrackingProblem;
				}
				$.ajax({
					type : "POST",
					dataType:"json",
					async:false,
					url : "${contextPath}/proledger/problem/save.action?t="+new Date().getTime(),
					data : urlForm,
					success : function(msg) {
					
						if (msg[0] == 1) {
							 window.parent.top.$.messager.show({
									title:"提示信息",
									msg:"保存成功！"
								});
							$("#ledgerProblem_id").val(msg[1]);
							$("#serial_num").val(msg[2]);
							var audDoubtpage =msg[4];
							
							//top.$(".nav-tabs li").each(function(){ 
							top.$(".tabs li").each(function(){
						  	     var  gg = $(this).text();
						  	     if( gg == '我的事项'){
						  	    	var tabId = $(this).children('a').attr("aria-controls");
						  	    	refreshMyTaskManuGrid(tabId);
						  	     }
						  	    });
							
							if(parentTabId) {
								var frameWin = aud$getTabIframByTabId(parentTabId);
						   		frameWin.g1.datagrid('reload');
							}else{
								 window.parent.flushProblem();
							}
						}
					}
				});
				
			//}
			
		}
			
    	// 保存后 刷新我的事項 
    	function refreshMyTaskManuGrid(tabId){
    		try{
    			var browser=navigator.appName 
    			var b_version=navigator.appVersion 
    			var version=b_version.split(";"); 
    			var trim_Version=version[1].replace(/[ ]/g,""); 
    		     if(browser=="Microsoft Internet Explorer" && trim_Version=="MSIE8.0") 
    			{ 
    			 
    			} else{
    				// 刷新我的事项-疑点
    		       	//var t = top.Addtabs.options.obj.children(".tab-content");
    	            //var tabIfm = t.find('#'+tabId).find('.iframeClass');
    	            var tabIfm = top.$("#tabs").tabs("getTab",'我的事项').find('iframe');
    	            if(tabIfm.length){
    		            var ifmWin = tabIfm.get(0).contentWindow;
    		            ifmWin.$('#operate-task-detail-list-3').datagrid('reload');
						ifmWin.$('#'+ifmWin.$('#mytaskTableId').val()).treegrid('reload');
    		            //ifmWin.$('#'+ifmWin.$('#mytaskTableId').val()).datagrid('reload');
    	            }
    			}
    		}catch(e){
    			
    		}
    	}
    	
		function callback() {
			var codes = document.getElementById("att").value;
			var names = document.getElementById("att2").value;
			var sort_code = codes.split("#");
			var sort_name = names.split("#");
			var allName =sort_name[sort_name.length - 2];
			document.getElementsByName("ledgerProblem.problem_code")[0].value = sort_code[0];
			if (sort_code.length - 4 <= 0) {
				document.getElementsByName("ledgerProblem.sort_three_code")[0].value = '';
			} else {
				document.getElementsByName("ledgerProblem.sort_three_code")[0].value = sort_code[sort_code.length - 4];
			}
			if (sort_code.length - 3 == 0) {
				document.getElementsByName("ledgerProblem.sort_small_code")[0].value = '';
			} else {
				document.getElementsByName("ledgerProblem.sort_small_code")[0].value = sort_code[sort_code.length - 3];
				allName = allName+" - "+sort_name[sort_name.length - 3];
			}
			document.getElementsByName("ledgerProblem.sort_big_code")[0].value = sort_code[sort_code.length - 2];
			document.getElementsByName("ledgerProblem.problem_name")[0].value = sort_name[0];
			document.getElementsByName("ledgerProblem.audit_con")[0].value = sort_name[0];
			if (sort_name.length - 4 <= 0) {
				document.getElementsByName("ledgerProblem.sort_three_name")[0].value = '';
			} else {
				document.getElementsByName("ledgerProblem.sort_three_name")[0].value = sort_name[sort_name.length - 4];
				allName = allName+" - "+sort_name[sort_name.length - 4];
				
			}
			if (sort_name.length - 3 == 0) {
				document.getElementsByName("ledgerProblem.sort_small_name")[0].value = '';
			} else {
				document.getElementsByName("ledgerProblem.sort_small_name")[0].value = sort_name[sort_name.length - 3];
			}
			document.getElementsByName("ledgerProblem.sort_big_name")[0].value = sort_name[sort_name.length - 2];
			document.getElementsByName("ledgerProblem.problem_all_name")[0].value = allName;
			//problemUnitList(sort_code[0], '');
			doProblemComment(sort_name[0]);
		//	$("#audit_law").val("");	
			if(checkProblemComment(sort_name[0])){
				getGist(sort_code[0]);
			}
		}

		//获取定性依据
		function getGist(problemCode) {
			var problem_desc=document.getElementById("audit_law").value	;
			$.ajax({
				type : "POST",
				url : "${contextPath}/proledger/problem/saveOprateTask!getGist.action",
				data : {
					"problemCode" : problemCode
				},
				success : function(msg) {
					if (msg != "") {
					//	$("#audit_law").val(msg);
						//$("#audit_law").val("");
						$("#audit_law").val(msg);
					}else{
						$("#audit_law").val("");
					}
				}
			});
		}
		
		//是否允许填写“备注”
		 function doProblemComment(problem_name){
			 
			 if( !checkProblemComment(problem_name)){
				 $("#ft").remove();
				 $("#problemComment").css("display","block");
				 $("#problemCommentText").append("<FONT color=red id=ft>*</FONT>");
				 $("#problemComment").attr("maxlength",1000);
			 }else{
				 $("#problemComment").val("");
				 $("#problemComment").css("display","none");
				 $("#problemCommentText").html("").html("备注(问题点为其他)");
			 }
		 }
		function loadZeren(zeren){
			$('#zeren').combobox('setText',zeren);
		}

		/**
		 取得数量单位的下拉菜单
		 **/
		function problemUnitList(problemCode, problemUnitCode) {
			DWREngine.setAsync(false);
			DWREngine.setAsync(false);
			DWRActionUtil.execute({
				namespace : '/proledger/problem',
				action : 'problemUnitList',
				executeResult : 'false'
			}, {
				'problemCode' : problemCode,
				'problemUnitCode' : problemUnitCode
			}, xxx);
			function xxx(data) {
				problemUnitSelect = data['problemUnitSelect'];
				if (problemUnitSelect == null) {
					problemUnitSelect = '';
				}
				document.getElementById('unitsDiv').innerHTML = problemUnitSelect;
			}
		}

		function back() {
			//window.location.href = "${contextPath}/proledger/problem/listDigaoEditProblem.action?project_id=${project_id}&manuscript_id=${manuscript_id}&manuscriptType=${manuscriptType}&isView=false";
			parent.closeSelectWrap();
		}
		
		// 关闭问题
		function closePronlem(){
			if(parentTabId) {
				aud$closeTab(curTabId, parentTabId);
			}else{
				parent.closePronlem();
			}			
		}
	//删除问题记录
	function deletePro(id){
		DWREngine.setAsync(true);
		top.$.messager.confirm('确认对话框', '确认删除？', function(r){
			if (r){
				DWREngine.setAsync(false);DWRActionUtil.execute(
						{ namespace:"/proledger/problem", action:"deleteLedgerProblem", executeResult:"false" }, 
						{'id':id},backRefu);
						
					function backRefu(data){
						var a= 	window.parent.document.getElementById("audit_con");
					  	a.value="无问题";
					  	parent.closeSelectWrap();
					}
			}
		});

	}	
	//选择引用底稿
    function  getOwerManu(){
    	var code=document.getElementsByName("project_id")[0].value; 
    	<%-- showPopWin('/ais/pages/system/search/searchdatamuti.jsp?url=<%=request.getContextPath()%>/operate/manu/selectManu.action&a=a&manu=all&taskPid=-1&project_id='+code+'&paraname=ledgerProblem.linkManuName&paraid=ledgerProblem.linkManuId',600,400,'底稿选择') --%>
    	
    	
    	<%-- var myurl = "<%=request.getContextPath()%>/operate/manu/selectManu.action&a=a&manu=all&taskPid=-1&project_id="+code+"&paraname=ledgerProblem.linkManuName&paraid=ledgerProblem.linkManuId"; --%>
    	var myurl = "${contextPath}/operate/manu/queryManuSelect.action?project_id="+code;
		$("#myFrame").attr("src",myurl);
		$('#manuReferenceDiv').window('open');
    }

	function accountantSystemTypeFun(){
		$("#accountantSystemTypeName").val($("#accountantSystemTypeCode").find("option:selected").text());
	}
	</SCRIPT>
</body>
<script type="text/javascript">
	$(function(){
		$("#myform").find("textarea").each(function(){
			autoTextarea(this);
		});
		//$("#audit_law").attr("maxlength",3000);
		$("#audit_con").attr("maxlength",300);
        //$("#describe").attr("maxlength",6000);
		//$("#audit_advice").attr("maxlength",3000);
		$("#describe").blur(function(){
            var dl = $("#describe").val().length;
            if(dl>6000){
                top.$.messager.show({
                    title:"提示信息",
                    msg:"问题描述的长度不能大于6000字!"
                });
			}
		});
        $("#audit_advice").blur(function(){
            var aul = $("#audit_advice").val().length;
            if(aul>3000){
                top.$.messager.show({
                    title:"提示信息",
                    msg:"审计建议的长度不能大于3000字!"
                });
            }
        });
        $("#audit_law").blur(function(){
            var aual = $("#audit_law").val().length;
            if(aual>3000){
                top.$.messager.show({
                    title:"提示信息",
                    msg:"定性依据的长度不能大于3000字!"
                });
            }
        });

		$('#quantify').combobox({
			panelHeight:50,
			editable:false,
			onChange:function(newValue,oldValue){
				if(newValue=='是'){
					   document.myform.problem_money.disabled = false;
					   //document.myform.problemCount.disabled = false;
				   }else{
					   document.myform.problem_money.value = "";
					   //document.myform.problemCount.value = "";
					   document.myform.problem_money.disabled = true;
					   //document.myform.problemCount.disabled = true;
					   
				   }
			}
		});

		if('${ledgerProblem.isInReport}' != ''){
		    $('#isInReport').combobox('setValue','${ledgerProblem.isInReport}');
        }
        if('${ledgerProblem.isNotMend}' != ''){
            $('#isNotMend').combobox('setValue','${ledgerProblem.isNotMend}');
        }
        
        
		// 审计小组数据设置
		if ("${isGroupEnabled}" == "true"){
			var json1 = eval('(${groups})');
			$('#auditGroup').combobox({
				data:json1.groupList,
				valueField:'groupId',
				panelHeight:'auto',
				textField:'groupName',
				editable:false,
				onChange:function(newValue,oldValue){
					$.ajax({
						url : "<%=request.getContextPath()%>/operate/manu/getAuditObjectByGroupId.action",
						dataType:'json',
						cache:false,
						type:"POST",
						data:{'groupId':newValue},
						success:function(data){
							if (newValue != null && newValue != "" && newValue.length >3 ){
								$("#audit_object").combobox({
									valueField:'audit_object',
									textField:'audit_object_name',
									data:data.auditObject
								});
								if ( data.auditObject){
									$('#audit_object').combobox('setValue', data.auditObject[0].audit_object);
									$('#audit_object').combobox('setText', data.auditObject[0].audit_object_name);
								}

								//初始化 底稿所属人
								$("#lp_owner").combobox({
									valueField:'userCode',
									textField:'userName',
									data:data.memberObject
								});
							}
						}
					});
				}
			});
			
			// 设置审计小组
			if('${ledgerProblem.groupId}'!=null&&'${ledgerProblem.groupId}'!=''){
				$('#auditGroup').combobox('setValue','${ledgerProblem.groupId}'.split(','));
				$('#auditGroup').combobox('setText','${ledgerProblem.groupName}');
			}
		}

	});
	
	//校验问题其他  
	function checkProblemComment(name){
		var flag = true;
		if (name != null && name != "" && name.length > 1 ){
			var p = name.substring(0,2);
			if (p =="其他" || p == "其它"){
				flag = false;
			}
		}
		return flag;
	}  
	

</script>
</html>
