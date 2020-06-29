<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%

    String s = (String)request.getAttribute("success");
%>
<!DOCTYPE HTML>
<s:if test="audManuscript.formId!=null">
	<s:text id="title" name="'修改底稿'"></s:text>
</s:if>
<s:else>
	<s:text id="title" name="'增加底稿'"></s:text>
</s:else>
<!-- 审计底稿   -->
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<title><s:property value="#title" /></title>
<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
<script type="text/javascript" src="${contextPath}/scripts/validate.js"></script>
<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/autosize.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/jquery-fileUpload.js"></script>
<script type="text/javascript" src="${contextPath}/scripts/ufaudTextLengthValidator.js"></script>
<style type="text/css">
/* 浮动最上层 */
#div1 {
	z-index: 2;
}

#div2 {
	z_index: 1;
}
</style>
<script type="text/javascript">
    function sucFun(){
        if(<%=s%> == true){
            parent.$.messager.alert(function(){
                window.opener=null;
                window.open('','_self');
                window.close();
            });
        }
    }
    	//去掉前后空格
		String.prototype.Trim =function() {
   			return this.replace(/(^\s*)|(\s*$)/g,"");
   		}  
		<%String pb = (String) request.getParameter("back");%>
		<%String fap = (String) request.getParameter("fap");%>
		//保存成功   显示信息
		/*var msg="${requestScope.tipMessage}";
	  	if(msg!=""&&msg=='true'){
	  		window.parent.$.messager.show({
				title:'提示信息',
				msg:'保存成功',
				timeout:5000,
				showType:'slide'
			});
	  	//	var mytaskTab = top.$("#tabs").tabs("getTab","我的事项");
	  		top.$(".nav-tabs li").each(function(){ 
	  	     var  gg = $(this).text();
	  	     if( gg == '我的事项'){
	  	    	var tabId = $(this).children('a').attr("aria-controls");
	  	    	refreshMyTaskManuGrid(tabId);
	  	     }
	  	    });


		/!* 	if(mytaskTab){
				refreshMyTaskManuGrid();
			} *!/
		}*/
	  	
	/* 	if ('${audManuscript.audit_dept}' != '') {
			$('#audit_dept').combobox('setValue','${audManuscript.audit_dept}');
		} */
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
    				// 刷新我的事项-底稿表格
    			/* 	var mytaskTab = top.$("#tabs").tabs("getTab","我的事项");
    				if(mytaskTab){
    					var mytaskIfm = mytaskTab.find('iframe');
    					if(mytaskIfm.length){					
    						var cwin = mytaskIfm[0].contentWindow;
    						cwin.$('#operate-task-detail-list-1').datagrid('reload');
    						cwin.$('#'+cwin.$('#mytaskTableId').val()).datagrid('reload');
    						
    					}
    				} */
    		       	var t = top.Addtabs.options.obj.children(".tab-content");
    	            var tabIfm = t.find('#'+tabId).find('.iframeClass');
    	            if(tabIfm.length){
    		            var ifmWin = tabIfm.get(0).contentWindow;
    		            ifmWin.$('#operate-task-detail-list-1').datagrid('reload');
    		            ifmWin.$('#'+ifmWin.$('#mytaskTableId').val()).datagrid('reload');
    	            }
    			}
    		}catch(e){
    			
    		}
    	}
		</script>
</head>

<s:if test="taskInstanceId!=null&&taskInstanceId!=''">
	<body onload="end();chang2link();"
		style="overflow: auto; overflow-x: hidden;" class="easyui-layout">
</s:if>
<s:else>
	<body onload="chang2link();sucFun();"
		style="overflow: auto; overflow-x: hidden;" class="easyui-layout">
</s:else>

<div fit="true"   class='easyui-layout'  region="center" border='0'  style="overflow: auto; width: 100%;height: 100%;">
	<div region="center" border='0'>
		<s:form id="myform" action="submit" namespace="/operate/manu" onsubmit="return testStatus()">
		   <div style="width: 100%;position:absolute;top:0px;" id="div1" align="center" >
				<table class="ListTable" align="center" style='width: 98.3%; padding: 0px; margin: 0px;'>
					<tr class="EditHead">
						<td >
						<span style='float: left; text-align: left;'>
						<s:property value="#title" /></span>
					   </td> 
						<td  >
						<span style='float: right; text-align: right;'>
							  <a href="javascript:void(0);" id="root" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="saveForm();">保存</a>&nbsp; 
						    </span>
						</td>
					</tr>
			
				</table>
			</div>
			<div class="position:relative" id="div2">
				<table class="ListTable" align="center" style='margin-top: 40px; overflow: auto;'>
					<tr>
						<td class="EditHead" style="width: 15%;"><font color="red"></font>&nbsp;&nbsp;&nbsp;底稿状态
						</td>
						<td class="editTd" style="width: 35%;" colspan="3"><s:if
								test="audManuscript.ms_status == '010'">
			                         底稿草稿
		                        </s:if> <s:if test="audManuscript.ms_status == '020'">
			                         正在征求
		                        </s:if> <s:if test="audManuscript.ms_status == '030'">
			                         等待复核
		                        </s:if> <s:if test="audManuscript.ms_status == '040'">
			                         正在复核
		                        </s:if> <s:if test="audManuscript.ms_status == '050'">
			                         复核完毕
		                        </s:if> 
								<input type="hidden" name="manu_id" id="manu_id" value="${audManuscript.formId}" /></td>
					</tr>
					<tr>
								<s:hidden name="audManuscript.task_id" id="task_id" />
						
							<td class="EditHead" style="width: 15%">
							<s:hidden name="audManuscript.change_code" /> 
							<font color="red">*</font>
								审计事项
							</td>
							<td class="editTd" style="width: 35%">
							<input type='text' name="audManuscript.task_name" value="${audManuscript.task_name}" readonly="readonly" 
							id="task_name" style="width: 90%;" class="noborder" /> 
							<img style="cursor: pointer; border: 0"src="/ais/resources/images/s_search.gif"
								onclick="$('#atTreeWrap').window('open')"></img>

							</td>
			
						
						<%-- <td class="EditHead" style="width: 15%"><font color="red"></font>
							参与人</td>
						<td class="editTd" style="width: 35%">
						<input id="attendPerson" /> 
						<input type="hidden" id="attendMemberIds" name="audManuscript.attendMemberIds" value="${audManuscript.attendMemberIds}" /> 
						<input type="hidden" id="attendMemberNames" name="audManuscript.attendMemberNames" value="${audManuscript.attendMemberNames}" /></td> --%>
					  	
					  	<td class="EditHead" >
					  	<span style="display:none">
						<font color="red">*</font> 审计小组</td>
						</span>
						<td class="editTd">
						<span  style="display:none">
						<input id="auditGroup" /> 
						<input type="hidden" id="groupId" name="audManuscript.groupId" value="${audManuscript.groupId}" /> 
						<input type="hidden" id="groupName" name="audManuscript.groupName"value="${audManuscript.groupName}" /> 
						</span>
						<s:hidden name="audManuscript.manu_start" /> 
						<s:hidden name="audManuscript.audit_found" /> 
						<s:hidden name="audManuscript.audit_matter" />  
						<s:hidden name="audManuscript.manu_end" /></td> 
					</tr>

					<tr>
			            <td class="EditHead" style="width: 15%">
						   <font color="red">*</font>
							底稿名称</td>
						<!--标题栏-->
						<td class="editTd" style="width: 35%">
						<!--一般文本框-->
						<s:textfield name="audManuscript.ms_name" id="ms_name" cssStyle='width:90%' cssClass="noborder" maxlength="500" /> 
						<s:hidden name="audManuscript.customId" />
						<s:hidden name="audManuscript.customName" /> 
						<s:hidden name="audManuscript.task_code" />
						</td>

						<s:hidden name="audManuscript.project_name" />
				
						<td class="EditHead" style="width: 15%">
								底稿编码
						</td>
	
						<td class="editTd" style="width: 35%">
						<s:property value="audManuscript.ms_code" />
						<s:hidden name="audManuscript.ms_code" />
						<s:hidden id="audManuscript.ms_status" name="audManuscript.ms_status" /> 
							<%-- 	</s:else> --%>
					    </td>
					</tr>
					<tr>
						<td class="EditHead">&nbsp;&nbsp;&nbsp;关联索引</td>
						<td class="editTd"><span id="p1"></span></td>


						<td class="EditHead"><font color="red">*</font> 被审计单位</td>
						<td class="editTd">
						<select id="audit_dept" class="easyui-combobox" panelHeight="auto" name="audManuscript.audit_dept"   editable="false" >
					       <s:iterator value="auditObjectMap" id="entry">
						         <s:if test="${audManuscript.audit_dept==key}">
					       			<option selected="selected" value="<s:property value="key"/>"><s:property value="value"/></option>
					       		 </s:if>
					       		 <s:else>
							        <option value="<s:property value="key"/>"><s:property value="value"/></option>
					       		 </s:else>
					       </s:iterator>
					    </select>
 						</td>
					</tr>
					<tr>
						<td class="EditHead">撰写人</td>
						<!--标题栏-->
						<td class="editTd">
						  <s:property value="audManuscript.ms_author_name" /> <!--一般文本框--> 
						  <s:hidden name="audManuscript.project_id" /> 
						  <s:hidden name="audManuscript.ms_author_name" /> 
						  <s:hidden name="audManuscript.ms_author" />
						</td>
						<td class="EditHead">创建日期</td>
						<!--标题栏-->
						<td class="editTd">
						<s:property value="audManuscript.ms_date" />
							<!--一般文本框--> 
						<s:hidden name="audManuscript.ms_date" />
						</td>
					</tr>

					<tr>
						<td class="EditHead">引用底稿</td>
						<td class="editTd"><s:textfield
								name="audManuscript.linkManuName" id="mylinkManuName"
								cssStyle='width:90%' cssClass="noborder" /> <!--一般文本框-->
							<input type="hidden" name="audManuscript.linkManuId"
							id="mylinkManuId" value="${audManuscript.linkManuId}" /> <img
							src="<%=request.getContextPath()%>/resources/images/s_search.gif"
							onclick="getOwerManu()" border=0 style="cursor: pointer">
							</td>
							<td class="EditHead"></td>
						    <td class="editTd"></td>
						
					</tr>
				<tr id="record">
						<td class="EditHead">审计过程记录
							<div>
								<font color=DarkGray>(限5000字)</font>
							</div>
						</td>
						<td class="editTd" colspan="3"><s:textarea
								cssClass="noborder" title="审计过程记录"
								name="audManuscript.audit_record" id='crudaudit_record'
								value="${audManuscript.audit_record}" rows="5"
								cssStyle="width:100%;overflow:hidden;line-height:150%;" /> 
							<input type="hidden" id="audManuscript.audit_record.maxlength" value="5000">
						</td>
					</tr>
				 <tr id="tr_audit_con" >
							<td class="EditHead">
										<span id="auditconclusion" ></span>审计结论
							   <div>
								<font color=DarkGray>(限5000字)</font>
							   </div>
							</td>
							<td class="editTd" colspan="3">
							<s:textarea cssClass="noborder" title="审计结论" name="audManuscript.audit_con" id='audit_con'
							value="${audManuscript.audit_con}" rows="5" cssStyle="width:100%;overflow:hidden;line-height:150%;" />
							<input type="hidden" id="audManuscript.audit_con.maxlength" value="5000">
							</td>
					</tr>
	
		          <s:hidden name="audManuscript.interact" />
					<s:if test="digaofankui=='enabled'">
						<tr>
							<td class="EditHead">&nbsp;&nbsp;&nbsp;被审计单位反馈意见
								<font color=DarkGray>(限3000字)</font>
							</td>
							<td class="editTd" colspan="3"><s:textarea
									cssClass='autoResizeTexareaHeight'
									name="audManuscript.audit_dept_feedback"
									cssStyle="width:100%;height:200px;overflow-y:hidden;" /></td>

						</tr>
					</s:if>
					<s:else>
						<s:hidden name="audManuscript.audit_dept_feedback" />
					</s:else>
					<s:hidden name="audManuscript.audit_regulation" />
					<s:hidden name="audManuscript.audit_file" />
					<s:hidden name="project_id" id='curProjectId' />
					<s:hidden name="taskPid" />
					<s:hidden name="taskId" />
					<s:hidden name="back" value="<%=pb%>" />
					<s:hidden name="fap" value="<%=fap%>" />
					<s:hidden name="audManuscript.id" />
					<s:hidden name="audManuscript.task_code_sort" />
					<s:hidden name="audManuscript.ms_code_sort" />
					<s:hidden name="taskInstanceId" />
					<s:hidden name="audManuscript.prom" />
					<s:hidden name="audManuscript.feedback" />
					<s:hidden name="audManuscript.batch" />
					<s:hidden name="audManuscript.audit_law" />
					<s:hidden name="owner" />
					<s:hidden name="groupCode" />
					<s:hidden id="w_file" name="audManuscript.file_id" />
				</table>
			</div>

		
			<s:hidden name="audManuscript.formId" />
			<s:hidden name="processName" />
			<s:hidden name="project_name" />
			<s:hidden name="formNameDetail" />
			</s:form>
		
	<div id="sjproblemtr" style="display:none">
	      
			<table class="ListTable" align="center" style='width: 98%; padding: 0px; margin: 0px;'>
					<tr>
					
				 <td class="EditHead" id="sjproblemtd1" style="text-align: left;">审计问题
					</td>
					</tr>

					<tr>

				<td class="EditHead" colspan="3" id="sjproblemtd2">
					<iframe  width=100% height=150 frameborder=0 scrolling=auto id="mainIFrame" src=""></iframe>
					</td>
			</tr>
			</table>
		</div>
		
	</div>

	<div region="south" border="0" > 
		<div id="manu_file" class="easyui-fileUpload" 
			data-options="fileGuid:'${audManuscript.file_id}',callbackGridHeight:200"></div>
	</div>
			
</div>
<!-- 审计事项树(单选,双击选择） -->
<div id='atTreeWrap' title='审计事项'
	style='text-align: center; overflow: hidden; padding: 5px; border: 1px solid #cccccc;'>
	<div style="text-align: left; padding: 0 0 2px 5px;">
		搜索:&nbsp;&nbsp;
		<s:textfield id="contion_taskName" maxLength="100"
			cssStyle="width:180px;height:24px;padding-top:5px;"></s:textfield>
		&nbsp;&nbsp;
		<button id='searchAtTree' class="easyui-linkbutton"
			iconCls="icon-search">搜索</button>
		&nbsp;&nbsp;
		<button id='sureAtTree' class="easyui-linkbutton" iconCls="icon-ok">确定</button>
		&nbsp;&nbsp;
		<button id='clearAtTree' class="easyui-linkbutton"
			iconCls="icon-empty">清空</button>
		&nbsp;&nbsp;
		<button id='exitAtTree' class="easyui-linkbutton"
			iconCls="icon-cancel">关闭</button>
	</div>
	<ul id='atTree'
		style='height: 350px; width: 670px; text-align: left; border: 1px solid #cccccc; border-bottom: 0px; padding: 5px; overflow: auto;'></ul>
</div>
<div id="manuReferenceDiv" title="引用底稿数据"
	style='overflow: hidden; padding: 0px;'>
	<iframe id="myFrame" name="myFrame" title="引用底稿" src="" width="100%"
		height="100%" frameborder="0">
		<!-- main -->
	</iframe>
</div>
<div id="manuProblemDiv" title="" style='overflow: hidden; padding: 0px;'>
	<iframe id="myFrameProblem"  title="" name="myFrameProblem" src="" width="100%" height="100%" frameborder="0">
	</iframe>
</div>
<div id="viewDoubtDiv" title="关联疑点查看"
	style='overflow: hidden; padding: 0px;'>
	<iframe id="myDoubtFrame" name="myDoubtFrame" title="关联索引" src=""
		width="100%" height="100%" frameborder="0">
		<!-- main -->
	</iframe>
</div>
<%-- <jsp:include flush="true" page="/pages/adl/zcfgTree.jsp" /> --%>
</body>
<script type="text/javascript">
	    	jQuery(document).ready(function(){
	    		// 滚动条top为0
 				window.setTimeout(function(){					
 					$('body')[0].scrollTop = 0;
 				},500);
	    		
 				$("#crudaudit_record").attr("maxlength",5000); // 查证要点
 				$("#lr_openZcfgTree").attr("maxlength",3000);
 			//	$("#audit_advice").attr("maxlength",3000);
 			//	$("#audit_law").attr("maxlength",3000);
 				$("#audit_con_max").attr("maxlength",5000);
 			
 				$('#audit_con').attr('maxlength',5000); //审计结果

 				/* var  dqxm='${dqxm}'
 				if(dqxm == 'GZNX'){
 					$("#describe").attr("maxlength",3000);
 				}else{
 					$("#describe").attr("maxlength",6000);
 				} */
 		
	    		// textarea 自动增加高度
	    		$("#myform").find("textarea").each(function(){
					autoTextarea(this);
				});
	    	
 				//  参与人 设置多选框的默认选中项。
				/* var json = eval('(${members})');
				$('#attendPerson').combobox({
					data:json.memberList,
					valueField:'userId',
					textField:'userName',
					panelHeight:'auto',
					multiple:true,
					editable:false
				});
				if('${audManuscript.attendMemberIds}'!=null&&'${audManuscript.attendMemberIds}'!=''){
					$('#attendPerson').combobox('setValues','${audManuscript.attendMemberIds}'.split(','));
					$('#attendPerson').combobox('setText','${audManuscript.attendMemberNames}');
				}
				 */
				
	 			var json1 = eval('(${groups})');
				$('#auditGroup').combobox({
					data:json1.groupList,
					valueField:'groupId',
					panelHeight:'auto',
					textField:'groupName',
					editable:false
				});
				if('${audManuscript.groupId}'!=null&&'${audManuscript.groupId}'!=''){
					$('#auditGroup').combobox('setValue','${audManuscript.groupId}'.split(','));
					$('#auditGroup').combobox('setText','${audManuscript.groupName}');
				} 
	    		
	    		// 审计事项 窗口
	    		 $('#atTreeWrap').window({   
						width:700,   
						height:460,   
						modal:true,
						collapsible:false,
						maximizable:false,
						minimizable:false,
						closed:true
					}); 
	    		
	    		 // 审计事项  确定
	    			$('#sureAtTree').bind('click',function(){
	                    var node =  $('#atTree').tree('getSelected');
	                    if(node && $('#atTree').tree('isLeaf',node.target)){
	                    	var arr = node.text.split("<font style=\"color:red;\">");
	                		var wtlbMc = node.text;
	                		for(var i=0; i<arr.length; i++){
	                			wtlbMc = wtlbMc.replace("<font style=\"color:red;\">","").replace("</font>","");
	                		}
	                        $('#task_id').val(node.id);
	                        doTaskName();
	                        $('#atTreeWrap').window('close');
	                    }else{
	                        $.messager.alert('提示信息','只能选择末级节点','error');
	                    }					
	 				});
	    		 // 审计事项  清空
	 				$('#clearAtTree').bind('click',function(){
	 					$('#contion_taskName').val('');
	 					loadSjsxTree();
	 				});
	    		  //审计事项 退出
	 				$('#exitAtTree').bind('click',function(){
	 					$('#atTreeWrap').window('close');
	 				});
	    		  //审计事项 查询
	 				$('#searchAtTree').bind('click',loadSjsxTree);
	 				loadSjsxTree();
	 				
	 				
	 				//初始化关联索引窗口
	 			    $('#viewDoubtDiv').window({
	 					width:800, 
	 					height:500,  
	 					modal:true,
	 					collapsible:false,
	 					maximizable:true,
	 					minimizable:false,
	 					closed:true    
	 			    });  
	 				
	 			    $('#manuProblemDiv').window({
	 					width: '100%', 
	 					height:'100%',  
	 					modal:true,
	 					collapsible:false,
	 					maximizable:false,
	 					minimizable:false,
	 					closed:true,
	 					closable:true
	 			    });  
	 				
	 			   
	 				//初始化引用底稿窗口
	 			    $('#manuReferenceDiv').window({
	 					width:650, 
	 					height:450,  
	 					modal:true,
	 					collapsible:false,
	 					maximizable:true,
	 					minimizable:false,
	 					closed:true    
	 			    }); 
	 				
	 				// 审计问题列表
	 				var prom = document.getElementsByName("audManuscript.prom")[0].value; 
	 				if(prom != null &&  prom != "" && prom != '0'){
	 					manuLederPro();
	 				}
	    	});
	    	
			//把关联的底稿或者疑点渲染为链接，关联索引: 点击疑点编码
	    	function chang2link(){
          		var code3=document.getElementsByName("audManuscript.audit_found")[0].value; 
        		var code4=document.getElementsByName("audManuscript.audit_matter")[0].value; 
      			var codeArray3=code3.split(',');
          		var codeArray4=code4.split(',');
          		//alert(codeArray3[0]);
          		var tt1='';
          		var tt2='';
				var tt3='';
				var tt4='';
				var tt5='';
				var strName1='关联备忘';
				var strName2='关联疑点';
				var strName4='关联重大事项';
				var strName3='关联疑点';
				var strName5='关联底稿';
       
          		if(codeArray3[0]!=null&&codeArray3[0]!=''){
            		tt3='<a href=# onclick=go2(\"'+codeArray3[0]+'\")>'+codeArray3[1]+'</a>';
            		tt3=tt3+"<br />";
          		}
          		if(codeArray4[0]!=null&&codeArray4[0]!=''){
            		tt4='<a href=# onclick=go2(\"'+codeArray4[0]+'\")>'+strName4+'</a>';
            		tt4=tt4+"<br />";
          		}
          		p1.innerHTML= tt3+tt4 ;
         	}
	    	
	    	//查看疑点
	    	function go2(s){
				var myurl = "${contextPath}/operate/doubt/view.action?type=YD&doubt_id="+s;
				$("#myDoubtFrame").attr("src",myurl);
				$('#viewDoubtDiv').window('open');
	    	}
	    	

	    	// 刷新问题列表
	    	function flushProblem(){
	    	var prom = document.getElementsByName("audManuscript.prom")[0].value; 
 			if(prom == null ||  prom == "" || prom == '0'){
 				$("#sjproblemtr").css("display","block");
 		    	getTai();
 			}
	   		 $("#mainIFrame")[0].contentWindow.$("#ledgerProblemList").datagrid('reload');  
	     	}
	    	
	    	// 关闭问题
	    	function closePronlem(){
	    		$('#manuProblemDiv').window('close');
	    	}
	    	// 审计事项 加载树
			function loadSjsxTree(){	
	          	  var contion_taskName=$("#contion_taskName").val();
	              $.ajax({
	                  url : "<%=request.getContextPath()%>/adl/getAuditTaskTree.action",
	                  dataType:'json',
	                  cache:false,
	                  type:"POST",
	                  data:{'showmanusum':'1','projectId':'${audManuscript.project_id}','contion_taskName':contion_taskName,'isdigao':'Y'},
	                  success:function(data){
	                      if(data.type=='success'){
	                          var treeData = data.atTreeJson;
	                          $('#atTree').tree({
	                              lines:true,
	                              data:treeData,
	                              onlyLeafCheck:true,
	                              onDblClick:function(node){
	                                  $('#sureAtTree').trigger('click');
	                              }
	                          }); 
	                      }else{
	                          $.messager.alert('提示信息',data.msg, 'error');
	                      }
	                  }
	              })
	          }
			
			//添加回车查询 审计事项
 			$(document).keydown(function(event){
 				if(event.keyCode == 13){
 					loadSjsxTree();
 				}
 			});	
        	//重新设置事项名称
        	function doTaskName(){
        		var task_id = $("#task_id").val();
        		var projectid = "${audManuscript.project_id}";
        		if(task_id != ""){
        			$.ajax({
        			   type: "POST",
        			   url: "${contextPath}/proledger/problem/save!resetTaskName.action",
        			   data: {"getMethod":"1","task_id":task_id,"projectid":projectid},
	        			   success: function(msg){
	        				  var arr = msg.split("||");
	        			      $("#task_name").val(arr[0]);
	        			      $("#ms_name").val(arr[0]);
	        			      var content = $('#crudaudit_record');
	        			      //先去掉审计记录自动添加的一句话
	        			      var s2 = '';
	        			      //var s2 = "\n\n结论意见（按审计人员的岗位分工或查证要点，逐条提出评价意见）:";
	        			      var s = (arr[1]==null||arr[1]=='null')?'':arr[1];
	        			      s += s2;
	        			      var t = content.val("");
	        			      content.focus().val(s);
	        			      //content.focus().val(s);
	        			      //content.autoResizeTexareaHeight();        			      
	        			   }
        			});
        		}
        	}
        	

        	//选择引用底稿
        	function  getOwerManu(){
				var myurl = "${contextPath}/operate/manu/queryManuSelect.action?project_id=${audManuscript.project_id}&manuId=${audManuscript.id}";
				$("#myFrame").attr("src",myurl);
				$('#manuReferenceDiv').window('open');
			}	
        	
        	function addManuLederPro(){
        		var myurl = "${contextPath}/proledger/problem/editDigao.action?project_id=${audManuscript.project_id}&id=0&manuscript_id=${audManuscript.formId}& manuscriptType=digao";
				$("#myFrameProblem").attr("src",myurl);
				$('#manuProblemDiv').window('open');
        	}
        	
        	//底稿返回底稿列表   返回上级list页面
			function backList(){
				//var flag=window.confirm('确定是否关闭？请先保存，以免数据丢失');//isSubmit
				
				parent.$.messager.confirm('确认对话框', '确定是否关闭？请先保存，以免数据丢失', function(r){
						if(r){
			     			if('true'=='${owner}'){
								var u='${pageContext.request.contextPath}/operate/manuExt/mainUi.action?owner=true&groupCode=${groupCode}&project_id=${audManuscript.project_id}&taskId=${taskId}&taskPid=${audManuscript.task_id}'
								window.location.href = u;
			             	}else{
			               		var u='${pageContext.request.contextPath}/operate/manuExt/mainUi.action?project_id=${audManuscript.project_id}&taskId=${taskId}&taskPid=${audManuscript.task_id}'
								window.location.href = u;
							}
			     		}else{
				 	 		return false;
				  		}
				});
				
	     		/* if(flag==true){
	     			if('true'=='${owner}'){
						var u='${pageContext.request.contextPath}/operate/manuExt/mainUi.action?owner=true&groupCode=${groupCode}&project_id=${audManuscript.project_id}&taskId=${taskId}&taskPid=${audManuscript.task_id}'
						window.location.href = u;
	             	}else{
	               		var u='${pageContext.request.contextPath}/operate/manuExt/mainUi.action?project_id=${audManuscript.project_id}&taskId=${taskId}&taskPid=${audManuscript.task_id}'
						window.location.href = u;
					}
	     		}else{
		 	 		return false;
		  		} */
				
			}
			function testStatus(){
 		  		document.getElementsByName('audManuscript.ms_status')[0].value='040';
 		  		var d=document.getElementsByName('audManuscript.ms_status')[0].value;
 		    	var bool = true;//提交表单判断参数
 		    	if( !checkEmpty("audManuscript.ms_name","底稿名称")){
           			return false;
            	}  
              	if('${audManuscript.formId}'!=null&&'${audManuscript.formId}'!='null'&&'${audManuscript.formId}'!=''){  
              		if( !checkEmpty("audManuscript.ms_code","底稿编码")){
               			return false;
                	}  
           		}
            //  	document.getElementsByName(v_3)[0].value=document.getElementsByName(v_3)[0].value.replace(/\s+$|^\s+/g,""); 
                if('${taskId}'=='-1'){
                	if( !checkEmpty("audManuscript.task_name","审计事项")){
               			return false;
                	} 
             	}
                if( !checkEmpty("audManuscript.audit_dept","被审计单位")){
           			return false;
            	}                    
               	if( !check()){
           			return false;
            	}   
 			}
			// 是否为空
			function checkEmpty(code,name){
				var v_3 = code;  // field
				var title_3 = name;// field name
               	var notNull = 'true'; // notnull
                var bool = true ;
              	if(document.getElementsByName(v_3)[0].value=="" && notNull=="true" && notNull != ""){
              		window.parent.$.messager.show({
						title:'提示信息',
						msg:title_3+"不能为空!",
						timeout:5000,
						showType:'slide'
					});
                 	bool = false;
                 	document.getElementsByName(v_3)[0].focus();
                 	return false;
               	}
            	if(document.getElementsByName(v_3)[0].value.replace(/\s+$|^\s+/g,"")==""){
            		window.parent.$.messager.show({
						title:'提示信息',
						msg:title_3+"不能为空!",
						timeout:5000,
						showType:'slide'
					});
                 	bool = false;
                 	document.getElementsByName(v_3)[0].focus();
                 	return false;
               	}
            	if(bool){
            		return true;
            	}
			}
		  //长度
			function checkNumber(code,name,num ){
				var v_3 = code;  // field
				var title_3 = name;// field name
				var bool = true ;
				var t=document.getElementsByName(v_3)[0].value;
				if(t.length> num){
					window.parent.$.messager.show({
						title:'提示信息',
						msg:title_3+"的长度不能大于"+num+"字！",
						timeout:5000,
						showType:'slide'
					});
					document.getElementsByName(v_3)[0].focus();
					bool = false;
					return false;
				}
				if(bool){
            		return true;
            	}
			}
			
		   // 为空和长度
			function checkEmptyNum(code,name,num){
				var v_3 = code;  // field
				var title_3 = name;// field name
               	var bool = 'true'; 
             	var notNull = 'true'; // notnull
             	if(document.getElementsByName(v_3)[0] != null ){
                 	var t = document.getElementsByName(v_3)[0].value ;
                  	if(t == "" && notNull=="true" && notNull != ""){
                  		window.parent.$.messager.show({
    						title:'提示信息',
    						msg:title_3+"不能为空!",
    						timeout:5000,
    						showType:'slide'
    					});
                     	bool = false;
                     	document.getElementsByName(v_3)[0].focus();
                     	return false;
                   	}
                	if(t.replace(/\s+$|^\s+/g,"")==""){
                		window.parent.$.messager.show({
    						title:'提示信息',
    						msg:title_3+"不能为空!",
    						timeout:5000,
    						showType:'slide'
    					});
                     	bool = false;
                     	document.getElementsByName(v_3)[0].focus();
                     	return false;
                   	}
                	
            		if(t.length> num){
    					window.parent.$.messager.show({
    						title:'提示信息',
    						msg:title_3+"的长度不能大于"+num+"字！",
    						timeout:5000,
    						showType:'slide'
    					});
    					document.getElementsByName(v_3)[0].focus();
    				 	bool = false;
    					return false;
    				}
             	}
        		if(bool){
            		return true;
            	}
			}
			
		   
			//保存表单
	       	function saveForm(){
				var bool = true;//提交表单判断参数                                       
              	 if(!check()){
              		bool = false;
                 	return false;
              	}
 				//完成保存表单操作
		   		if(bool){
		   			var url = '${contextPath}/operate/manu/saveFap.action';
	     			myform.action = url;
	     			document.getElementById("root").disabled=true;
	     			myform.submit();
	     			
		    	}
			}	
	    	function toSubmit(act){
			//	setAttendPerson();
			//	setAuditGroup();
				<s:if test="isUseBpm=='true'">
			 	if(document.getElementsByName('isAutoAssign')[0].value=='false'||document.getElementsByName('formInfo.toActorId')[0]!=undefined){
				 	var actor_name=document.getElementsByName('formInfo.toActorId')[0].value;
				 	if(actor_name==''){
				 		window.parent.$.messager.show({
    						title:'提示信息',
    						msg:"下一步处理人不能为空",
    						timeout:5000,
    						showType:'slide'
    					});
						return false;
					}
				}
			  	if('${dqxm}'=='GZNX'){
				  	var content_gznx=document.getElementsByName('taskInstanceInfo.comments')[0].value;
				  	if(content_gznx==''){
				  		window.parent.$.messager.show({
    						title:'提示信息',
    						msg:"处理意见不能为空",
    						timeout:5000,
    						showType:'slide'
    					});
						return false;
					}
				}
			  	</s:if>
			    var bool = true;//提交表单判断参数
	                    
              	if(!check()){
              		bool = false;
              		return false;
            	}
	       		//完成保存表单操作
	       		if(bool){
					var tip="您确认提交吗?";
				  	if('${user.floginname}'=='${audManuscript.ms_author}'){
						DWREngine.setAsync(false);
	              		DWREngine.setAsync(false);DWRActionUtil.execute(
	              			{ namespace:'/operate/manu', action:'tip', executeResult:'false' }, 
	              			{'formId':'${audManuscript.formId}'},xxx);
	                  	function xxx(data){
		                	tip =data['tip'];
		              	}
				  	}
				  	parent.$.messager.confirm('确认对话框', '确认启动审批流程吗？', function(r) {
				  		if (r) {
				  			if('${audManuscript.interact}'=='1'||'${audManuscript.interact}'=='2'){
			          		}
				  			document.getElementById('submitButton').disabled=true;
				  			 if('${owner}' == 'true'){
				  				$.ajax({
				  					type:'POST',
				  					url:"<%=request.getContextPath()%>/operate/manu/submit.action",
									data : $('#myform').serialize(),
									dataType : 'json',
									success : function(data) {
											if (data.winclose == "winclose") {
										     /*   var selectedTab = top.$('#tabs').tabs('getSelected');
											   var tabIndex = top.$('#tabs').tabs('getTabIndex',selectedTab);
			                                          top.$('#tabs').tabs('close',tabIndex); */
			                                      	top.$(".nav-tabs li").each(function(){ 
			                               	  	     var  gg = $(this).text();
			                               	  	     if( gg == '增加底稿' || gg == '编辑底稿'){
			                               	  	    	var tabId = $(this).children('a').attr("aria-controls");
			                               	  	        top.Addtabs.close(tabId);
			                               	  	     }else if (gg == '我的事项'){
			                               	  		    var tabId = $(this).children('a').attr("aria-controls");
			                               	  	        refreshMyTaskManuGrid(tabId);
			                               	  	     }
			                               	  	    
			                                      	});
														}
													}
 
												});
									} else {
										myform.action = "<s:url action="submit" includeParams="none"/>";
										myform.submit();
									}
								} else {
									return false;
								}

							});
		}
	}

	//提交表单
	function submitForm() {
		var bool = true;//提交表单判断参数                 
		if (!check()) {
			return false;
		}
		if (document.getElementsByName("formInfo.toActorId_name")[0] != null
				&& document.getElementsByName("formInfo.toActorId_name")[0].value == ""
				&& notNull == "true" && notNull != "") {
			//window.alert("请选择下一步处理人！");
			window.parent.$.messager.show({
				title : '提示信息',
				msg : "请选择下一步处理人！",
				timeout : 5000,
				showType : 'slide'
			});
			bool = false;
			document.getElementById("formInfo.toActorId_name").focus();
			return false;
		}
		var flag = window.confirm('确认提交吗?');
		if (flag == true) {
			document.getElementById("submitButton").disabled = true;
			myform.submit();
		} else {
			return false;
		}
	}

	//对输入内容校验  
	function check() {
		var manu_code = document.getElementsByName("audManuscript.ms_code")[0].value;
		var flag = true;
		var bool = true;//提交表单判断参数 
		$.ajax({
			type : "POST",
			dataType : "text",
			url : "${contextPath}/operate/manu/checkCode.action",
			async : false,
			data : {
				'project_id' : '${audManuscript.project_id}',
				'manu_code' : manu_code,
				'formId' : '${audManuscript.formId}'
			},
			success : function(data) {
				if (data != '1') {
					window.parent.$.messager.show({
						title : '提示信息',
						msg : "底稿编码重复,请重新输入!",
						timeout : 5000,
						showType : 'slide'
					});
					document.getElementById("audManuscript.ms_code").focus();
					flag = false;
				}
			}
		});
		if (!flag) {
			bool = false;
			return false;
		}

		if (!checkEmptyNum("audManuscript.ms_name", "底稿名称", 100)) {
			bool = false;
			return false;
		}
		if ('${audManuscript.formId}' != null && '${audManuscript.formId}' != 'null'
				&& '${audManuscript.formId}' != '') {
			if (!checkEmpty("audManuscript.ms_code", "底稿编码")) {
				bool = false;
				return false;
			}
			var v_3 = "audManuscript.ms_code";
		    document.getElementsByName(v_3)[0].value=document.getElementsByName(v_3)[0].value.replace(/\s+$|^\s+/g,"");
		}

		//liululu 1.将if判断去掉；2.补全判断条件。问题：taskId的获取与作用？ 
		if ('${taskId}' == '-1' || '${taskId}' == null || '' == '${taskId}'
				|| '${taskId}' == 'null') {
			if (!checkEmpty("audManuscript.task_name", "审计事项")) {
				bool = false;
				return false;
			}
		}
		if (!checkEmptyNum("audManuscript.audit_dept", "被审计单位", 3000)) {
			bool = false;
			return false;
		}

//		setAttendPerson();
	//	setAuditGroup();

		if (!checkNumber("audManuscript.linkManuName", "引用底稿", 3000)) {
			bool = false;
			return false;
		}
		if (!checkNumber("audManuscript.linkManuId", "引用底稿", 3000)) {
			bool = false;
			return false;
		}

		if (!checkNumber("audManuscript.audit_file", "查阅资料", 3000)) {
			bool = false;
			return false;
		}
		var v_3 = "audManuscript.describe"; // field
		var title_3 = '审计查证要点';// field name
/* 		if ($("#audit_con").val().indexOf("\"")) {
			var temp = $("#audit_con").val();
			$("#audit_con").val(temp.replaceAll("\"", "“"));
		} */

/* 		if ('${dqxm}' == 'GZNX') {
			if (!checkNumber("audManuscript.audit_method_name", "查证过程", 3000)) {
				bool = false;
				return false;
			}
		} */
		if (!checkNumber("audManuscript.audit_regulation", "规章制度", 3000)) {
			bool = false;
			return false;
		}
		if (!checkNumber("audManuscript.audit_dept_feedback", "底稿反馈意见", 3000)) {
			bool = false;
			return false;
		}
		if(bool){
			return true;	
		}
	}

	// 设置参与人 数据
	/* function setAttendPerson() {
		var text = $('#attendPerson').combobox('getText');
		var value = $('#attendPerson').combobox('getValues');
		$('#attendMemberIds').val(value);
		$('#attendMemberNames').val(text);
	} */

	// 设置审计小组数据
	function setAuditGroup() {
		var text = $('#auditGroup').combobox('getText');
		var value = $('#auditGroup').combobox('getValue');
		$('#groupId').val(value);
		$('#groupName').val(text);
	}
	//输入检查，只能输入数字
	function onlyNumbers1(s) {
		re = /^\d+\d*$/
		var str = s.replace(/\s+$|^\s+/g, "");
		if (str == "") {
			return false;
		}
		if (!re.test(str)) {
			window.parent.$.messager.show({
				title : '提示信息',
				msg : "只能输入正整数，请重新输入",
				timeout : 5000,
				showType : 'slide'
			});
			return true;
		}
	}
	

	//上传附件
	function Upload(id,filelist,delete_flag,edit_flag){
		var guid=document.getElementsByName(id)[0].value;
		var num=Math.random();
		var rnm=Math.round(num*9000000000+1000000000);//随机参数清除模态窗口缓存
		window.showModalDialog('${contextPath}/commons/file/welcome.action?table_name=aud_manuscript_operate&table_guid=file_id&guid='+guid+'&&param='+rnm+'&&deletePermission='+delete_flag+'&&isEdit='+edit_flag,filelist,'dialogWidth:700px;dialogHeight:450px;status:yes');
	}
	
	//删除方法
		/*
			1.第一个参数是附件表的主键ID，第二个参数是该类附件的删除权限，第三个参数是附件的应用类型
			2.该方法的参数由ais.file.service.imp.FileServiceImpl中的
				getDownloadListString(String contextPath, String guid,String bool, String appType)生成的HTML产生
		*/
    function deleteFile(fileId,guid,isDelete,isEdit,appType,title){
    	parent.$.messager.confirm('确认对话框', '确认删除吗?', function(r){
    		if (r){
    			DWREngine.setAsync(false);DWRActionUtil.execute(
						{ namespace:'/commons/file', action:'delFile', executeResult:'false' }, 
						{'fileId':fileId, 'deletePermission':isDelete, 'isEdit':isEdit, 'guid':guid, 'appType':appType,'title':title},
						xxx);
					function xxx(data){
					  	document.getElementById(guid).parentElement.innerHTML=data['accessoryList'];
					}
    		}
    	});
		/* var boolFlag=window.confirm("确认删除吗?");
		if(boolFlag==true){
			DWREngine.setAsync(false);DWRActionUtil.execute(
				{ namespace:'/commons/file', action:'delFile', executeResult:'false' }, 
				{'fileId':fileId, 'deletePermission':isDelete, 'isEdit':isEdit, 'guid':guid, 'appType':appType,'title':title},
				xxx);
			function xxx(data){
			  	document.getElementById(guid).parentElement.innerHTML=data['accessoryList'];
			}
		} */
	}
    function doStart(){
    //	setAttendPerson();
  //  	setAuditGroup();
    	document.getElementById('myform').action = "start.action";
    	document.getElementById('myform').submit();
    }				


    function closeWinUI(){
    	$('#manuReferenceDiv').window('close');
    }	
    
    // 新增审计问题
    
    function manuLederPro(){
	$("#sjproblemtr").css("display","block");
	getTai();	
    }
    
    // 改变问题的高度
    function changProblemHeight(rows){
      if(rows){
    	  document.getElementById("mainIFrame").height=100+30*rows;
       }
    }
</script>
<script type="text/javascript">
// 暂时未找到使用 位置的方法

function getTai(){
	var ms_code= '${audManuscript.formId}';
	var pro_code= '${audManuscript.project_id}';
	if(ms_code==""||ms_code=="null"){
  		return true;
 	}else{
    	var iframe = document.getElementById("mainIFrame");
    	iframe.src = "/ais/proledger/problem/listDigaoEditProblem.action?project_id=${audManuscript.project_id}&manuscript_id=${audManuscript.formId}&manuscriptType=digao&view=add&taskId=${taskId}&taskPid=${taskPid}";
   		
    	
    	/* if('${audManuscript.ms_author}' == '${user.floginname}'&&'enabled' == '${taizhang}'){
       		iframe.src = "/ais/proledger/problem/listDigaoEditProblem.action?project_id=${audManuscript.project_id}&manuscript_id=${audManuscript.formId}&view=add";
        }else if ('${audManuscript.ms_author}' != '${user.floginname}'&&'enabled' == '${taizhang}'){
        	iframe.src = "/ais/proledger/problem/listDigaoEditProblem.action?project_id=${audManuscript.project_id}&manuscript_id=${audManuscript.formId}&isView=true";
		}  */
    //	iframe.height="30";
	}

}		

//检查底稿编码是否改变
	function conCode(){
	document.onkeydown = function(){
		document.getElementsByName("audManuscript.change_code")[0].value = "1";
	 }
	}
	//查看底稿
	function go1(s){
  		window.open("${contextPath}/operate/manu/view.action?crudId="+s+"&project_id=${audManuscript.project_id}","","height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no");
	}
	
	//选择审计小组
	function getGroup(){
  		var code=document.getElementsByName("audManuscript.groupId")[0].value; 
  		var name=document.getElementsByName("audManuscript.groupName")[0].value;
  		var num=Math.random();
  		var rnm=Math.round(num*9000000000+1000000000);
  		var url='/ais/pages/system/search/searchdataManu.jsp?url=<%=request.getContextPath()%>/operate/task/selectDept.action&a=a&x='+rnm+'&group_id='+code+'&paraname=audManuscript.audit_dept_name&paraid=audManuscript.audit_dept';
   		//alert(url);
   		//alert(code);
  		if(name==null||name==""){
      		//alert(code);
      		//var s=3*5;
     		window.parent.$.messager.show({
				title:'提示信息',
				msg:"请先选择审计小组!",
				timeout:5000,
				showType:'slide'
			});
     		return false;
  		}
  		showPopWin(url,500,330,'被审计单位选择');
	}   

	
	//打开台帐页面
	function taizhangEdit(){
 		var ms_code= '${audManuscript.formId}';
 		var pro_code= '${audManuscript.project_id}';
 		if(ms_code==""||ms_code=="null"){
   			window.parent.$.messager.show({
				title:'提示信息',
				msg:"请先保存审计底稿!",
				timeout:5000,
				showType:'slide'
			});

  			return false;
 		}
 		window.open("/ais/proledger/problem/listDigaoEditProblem.action?project_id="+pro_code+"&manuscript_id="+ms_code+"&view=add","","height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no");
	}
		//打开台帐页面
   		function taizhangView(){
     		var ms_code= '${audManuscript.formId}';
     		var pro_code= '${audManuscript.project_id}';
     		window.open("/ais/proledger/problem/listDigaoEditProblem.action?project_id="+pro_code+"&manuscript_id="+ms_code+"&isView=true","","height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no");
   		}
		
   	    //查看审计底稿反馈意见  
		function viewFeedback(s,q){
			var title = "查看审计底稿反馈意见";
			//showPopWin('${contextPath}/operate/feedback/viewFeedbackInfo.action?ms_id=${audManuscript.formId}',700,350,title);
			window.open('${contextPath}/operate/feedback/viewFeedbackInfo.action?feed_id='+s,'','height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no');
			var num=Math.random();
			var rnm=Math.round(num*9000000000+1000000000);//随机参数清除模态窗口缓存
		}
		

		 	//法规制度
    	function regu(){
	   		window.open('${contextPath}/pages/assist/suport/comsys/view_lawslibFrame.jsp?zuoye=bs','law',"height=600px, width=600px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no");
		}
        //法规制度
		function law(){
			win=window.open('${contextPath}/pages/operate/manu/law_redirect.jsp','regu','height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no');if(win && win.open && !win.closed) win.focus();
		}

	
</script>
</html>