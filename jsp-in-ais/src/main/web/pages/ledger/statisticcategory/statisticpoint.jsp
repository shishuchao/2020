<!DOCTYPE HTML>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>统计类别</title>
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
		<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/scripts/check.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
	<SCRIPT type="text/javascript">
	var tip = "${tip}";
	if(tip == "1"){
		 showMessage1("保存成功");
	}
	<s:if test="${refresh=='Y'}">
	window.parent.parent.frames[0].location.reload();
	</s:if>
	/*
	判断问题点编号是否存在
	*/
	function isCodeExist(code){
	  var isCategoryExist=false;
	  DWREngine.setAsync(false);
			DWREngine.setAsync(false);DWRActionUtil.execute(
				{ namespace:'/ledger/problemledger', action:'isCategoryCodeExist', executeResult:'false' }, 
				{'categoryCode':code,'currentId':'${statisticCategory.id}'},
				xxx);
			function xxx(data){
				isCategoryExist = data['isCategoryExist'];
			} 
			return isCategoryExist;
	}

	function toDelete(id){
         $.messager.confirm('提示信息','确定执行删除操作吗？',function(flag){
			if(flag){
	        	window.location.href='<%=request.getContextPath()%>/ledger/problemledger/deleteCategory.action?statisticCategory.id='+id;
			}
		});
	}
	function check(){
		var belong_pro_type=$("#belong_pro_type").val();
		$.ajax({
			   type: "POST",
			   dataType:"json",
			   async:false,
			   data : {
					"belong_pro_type" : belong_pro_type
				},
			   url: "${contextPath}/ledger/problemledger/checkLedgerTreeViewByAsyn.action",
			   success: function(data){
				   if("true"== data.type){
					   showMessage1("没有问题点，请维护后选择！")
				   }else{
					   showSysTree(this,{
		    				url:'${contextPath}/ledger/problemledger/ledgerTreeViewByAsyn.action',
		    				param:{
		    					'belong_pro_type':$('#belong_pro_type').val()
		    				},
		    				cache:false,				    							    				
		    				onlyLeafCheck:true,
		    				title:'请选择问题点',
		    				checkbox:true
		    			})
				   }
			  	 }
			});
	}
	
	function toSave(){
	     var code=document.getElementsByName('statisticCategory.code')[0].value;
	     var name=document.getElementsByName('statisticCategory.name')[0].value;
	     var problemPoints=document.getElementsByName('statisticCategory.problemPoints')[0].value;
	     if(code==null||code==''){
	    	 showMessage1("统计类别编号不能为空!");
		     return false;
		 }
	     if(name==null||name==''){
	    	 showMessage1("统计类别名称不能为空!");
		     return false;
		 }
		 if(isCodeExist(code)=='true'){
			  showMessage1("该统计类别编号已经存在!");
			   return false;
		 }
		 if(problemPoints==null||problemPoints==''){
	    	 showMessage1("该项目类别所属问题点为空，请维护问题点");
		     return false;
		 }
		 $.ajax({
			type:"post",
			data:$('#form2').serialize(),
			url:"${contextPath}/ledger/problemledger/save_statisticcategory.action",
			async:false,
			success:function(){
				 parent.parent.reloadSelectedNode();
				 showMessage1('保存成功!');
			}
		 });
	}
	</SCRIPT>
	</head>
	<body >
	<div style="overflow:hidden;" class="easyui-layout">
		<div class="easyui-panel" title="统计类别"  fit="true" style="overflow: auto;width:100%;" border='0'>
			<s:form id="form2" name="form2" action="save_statisticcategory.action" namespace="/ledger/problemledger">
				<s:if test="${param.view!='yes'}">
					<table cellpadding=1 cellspacing=1 border=0  class="ListTable" id="tab1" name="tab1" width="100%">
						<tr>
							<td class="EditHead" style="width:40%">
								<FONT color=red>*</FONT>
								&nbsp;统计类别编号:
	
							</td>
							<td class="editTd" style="width:60%">
								<s:textfield cssClass="noborder" cssStyle="width:320px;" name="statisticCategory.code" maxlength="50"></s:textfield>
							</td>
						</tr>
						<tr>
							<td class="EditHead">
								<FONT color=red>*</FONT>
								&nbsp;统计类别名称:
	
							</td>
							<td class="editTd">
								<s:textfield name="statisticCategory.name" cssClass="noborder" cssStyle="width:320px;" maxlength="50"></s:textfield>
							</td>
						</tr>
						<tr>
							<td class="EditHead">
								所属项目类别:
							</td>
							<td class="editTd" >
								<div style="float: left;">
									<s:textfield cssClass="noborder" name="statisticCategory.belong_pro_type_name"  id="belong_pro_type_name" cssStyle="width:150px" readonly="true"/>
									<s:textfield cssClass="noborder" name="statisticCategory.belong_pro_type_child_name"  id="belong_pro_type_child_name" cssStyle="width:150px" readonly="true"/>
									<img style="cursor:pointer;border:0" src="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png"
								    	onclick="getItem('/ais/pages/basic/code_name_tree_select.jsp','&nbsp;请选择项目类别',500,400)"/>
										<input type="hidden" id="belong_pro_type" name="statisticCategory.belong_pro_type" value="<s:property value='statisticCategory.belong_pro_type'/>">
										<input type="hidden" id="belong_pro_type_child" name="statisticCategory.belong_pro_type_child" value="<s:property value='statisticCategory.belong_pro_type_child'/>">
								</div>									
							</td>
						</tr>
						<tr>
							<td class="EditHead">
								对应问题点:
							</td>
							<td class="editTd">
								<%-- <s:buttonText2 id="problemPoints" hiddenId="problemPoint_codes" cssClass="noborder"
									name="statisticCategory.problemPoints"
									hiddenName="statisticCategory.problemPoint_codes"
									doubleOnclick="check();"
									doubleSrc="${pageContext.request.contextPath}/resources/images/s_search.gif"
									doubleCssStyle="cursor:hand;border:0" readonly="true" cssStyle="width:320px;"/> --%>
									
									<input type="text" name="statisticCategory.problemPoints" value="${statisticCategory.problemPoints}" readonly="readonly" id="problemPoints" class="noborder" style="width:350px;">
									<a href="javascript:void(0)" id='lr_openWtlbTree' class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-search'" onclick=""></a>
									<input type='hidden' id='problemPoint_codes' name='statisticCategory.problemPoint_codes'  value="${statisticCategory.problemPoint_codes}"/>
									
							</td>
						</tr>
					</table>
				</s:if>
				<s:else>
					<table cellpadding=1 cellspacing=1 border=0  class="ListTable" id="tab1" name="tab1" width="100%">
						<tr>
							<td class="EditHead" style="width:40%">
								&nbsp;统计类别编号:
							</td>
							<td class="editTd" style="width:60%">
								${statisticCategory.code}
							</td>
						</tr>
						<tr>
							<td class="EditHead">
								&nbsp;统计类别名称:
							</td>
							<td class="editTd">
								${statisticCategory.name}
							</td>
						</tr>
						<tr>
							<td class="EditHead">
								所属项目类别:
							</td>
							<td class="editTd" > 
									${statisticCategory.belong_pro_type_name}&nbsp;&nbsp;&nbsp;&nbsp;${statisticCategory.belong_pro_type_child_name}
							</td>
						</tr>
						<tr>
							<td class="EditHead">
								对应问题点:
							</td>
							<td class="editTd">
								<%-- <s:buttonText2 id="problemPoints" hiddenId="problemPoint_codes" cssClass="noborder"
									name="statisticCategory.problemPoints"
									hiddenName="statisticCategory.problemPoint_codes"
									doubleOnclick="check();"
									doubleSrc="${pageContext.request.contextPath}/resources/images/s_search.gif"
									doubleCssStyle="cursor:hand;border:0" readonly="true" cssStyle="width:320px;"/> --%>
									${statisticCategory.problemPoints}
							</td>
						</tr>
					</table>
				</s:else>
				<s:if test="${param.view!='yes'}">
					<div style="text-align:right;padding-right:5px;" >
						<a class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="toSave()">保存</a>
						<a class="easyui-linkbutton" data-options="iconCls:'icon-delete'" onclick="toDelete('${statisticCategory.id}')">删除</a>
						<s:hidden name="statisticCategory.id"></s:hidden>
						<s:hidden name="statisticCategory.fid"></s:hidden>
						<s:hidden name="statisticCategory.fname"></s:hidden>
						<s:hidden name="statisticCategory.isSort" value="N"></s:hidden>
						<s:hidden name="id"></s:hidden>
					</div>
				</s:if>
			</s:form>
		</div>
		</div>
		<!-- 问题类别树 -->
		 <div id='wtlbTreeSelectWrap' title='请选择问题点' style='overflow:hidden;padding:5px; border:1px solid #cccccc;'>
		 	<div style='padding:0 0 2px 5px; text-align:left;'>
		 		<button id='sureSelectWtlbTreeNode'  class="easyui-linkbutton" iconCls="icon-add">添加</button>
		 		<button id='clearSelectWtlbTreeNode' class="easyui-linkbutton" iconCls="icon-empty">清 空</button> 		
		 	</div>
		 	<ul id='wtlbTreeSelect' class='easyui-tree' style='height:350px;width:99%;border:1px solid #cccccc; padding:5px;overflow:auto;'></ul>
		 </div>
		 <script type="text/javascript">
		 $(function(){
		 	if($("#belong_pro_type_child_name").val()==''){
		 		document.getElementById('belong_pro_type_child_name').style.display='none';
		 	}
		 });
		function getItem(url,title,width,height){
			$('#item_ifr').attr('src',url);
			$('#subwindow').window({
				title: title,
				top:'20px',
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
			var res = ayy[0].split(',');
			var name = ayy[1].split(',');
			if(res.length != 1){
				document.all('statisticCategory.belong_pro_type_child').value=res[0];
				document.all('statisticCategory.belong_pro_type').value=res[1];
    			document.all('statisticCategory.belong_pro_type_name').value=name[0];
    			document.all('statisticCategory.belong_pro_type_child_name').value=name[1];
    			document.getElementById('belong_pro_type_child_name').style.display='';
			}else{
				document.all('statisticCategory.belong_pro_type_child').value='';
				document.all('statisticCategory.belong_pro_type').value=ayy[0];
				document.all('statisticCategory.belong_pro_type_name').value=name[0];
    			document.all('statisticCategory.belong_pro_type_child_name').value='';
    			document.getElementById('belong_pro_type_child_name').style.display='none';
			}
    		closeWin();
		}
		function cleanF(){
			document.all('statisticCategory.belong_pro_type').value='';
    		document.all('statisticCategory.belong_pro_type_child').value='';
    		document.all('statisticCategory.belong_pro_type_name').value='';
    		document.all('statisticCategory.belong_pro_type_child_name').value='';
    		document.getElementById('belong_pro_type_child_name').style.display='none';
    		closeWin();
		}
		function closeWin(){
			$('#subwindow').window('close');
		}			 
		 
		 //打开类别树窗口
		 $('#lr_openWtlbTree').bind('click',function(){
				$('#wtlbTreeSelectWrap').window('open');
			});
		 $('#wtlbTreeSelectWrap').window({   
				width:700,   
				height:400,   
				modal:true,
				collapsible:false,
				maximizable:false,
				minimizable:false,
				closed:true
			});
		// 加载问题类别树
		 $('#wtlbTreeSelect').tree({
				url:"<%=request.getContextPath()%>/adl/getWtlbTree.action",
				checkbox:true,
				onlyLeafCheck:true,
				lines:true,
		        onClick:function(node){},
				onDblClick:function(node){
					$('#sureSelectWtlbTreeNode').trigger('click');
				}
			});
		//添加问题点
			$('#sureSelectWtlbTreeNode').bind('click',function(){
				var nodes = $('#wtlbTreeSelect').tree('getChecked');
				var dms = [];
				var mcs = [];
				if(nodes.length > 0){
					if((nodes[0].children == null || nodes[0].children == '') && nodes[0].state != 'closed'){
						$.each(nodes, function(i,node){
							dms.push(node.id);
							mcs.push(node.text);
						})
						$('#problemPoint_codes').val(dms.join(','));
						$('#problemPoints').val(mcs.join(','));
						$('#wtlbTreeSelectWrap').window('close');
					}else{
						$.messager.alert('提示信息','只能选择【问题点】！', 'error', function(){  });
						return false;
					}
				}
			});
			$('#clearSelectWtlbTreeNode').bind('click',function(){
				$('#problemPoints,#problemPoint_codes').val('');
				$('#wtlbTreeSelectWrap').window('close');
			});
		 </script>
	<div id="subwindow" class="easyui-window" title="项目类别" style="width:500px;height:500px;padding:5px;" closed="true">
		<div class="easyui-layout" fit="true">
			<div region="center" border="false" style="padding:10px;background:#fff;border:1px solid #ccc;">
				<iframe id="item_ifr" name="item_ifr" src="" frameborder="0" width="100%" height="100%" scrolling="auto" ></iframe>
			</div>
			<div region="south" border="false" style="text-align:right;padding:5px 0;">
			    <div style="display: inline;" align="right">
					<a class="easyui-linkbutton" iconCls="icon-ok" href="javascript:void(0)" onclick="saveF()">确定</a>
					<a class="easyui-linkbutton" iconCls="icon-empty" href="javascript:void(0)" onclick="cleanF()">清空</a>
					<a class="easyui-linkbutton" iconCls="icon-delete" href="javascript:void(0)" onclick="closeWin()">关闭</a>
			    </div>
			</div>
		</div>
	</div>			 
	</body>
</html>