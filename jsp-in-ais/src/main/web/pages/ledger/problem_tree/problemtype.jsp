<!DOCTYPE HTML>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>问题类别</title>
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/scripts/check.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ufaudTextLengthValidator.js"></script>
		<script type="text/javascript">
		var tip = "${tip}";
		if(tip == "1"){
			 showMessage1("保存成功！");
		}
        function addProblemtype(id){
        	if(id == ""){
        		 showMessage1("请先保存，再增加类别！");
        	}else{
           		window.location.href='<%=request.getContextPath()%>/ledger/problemledger/add_problemtype_node.action?view=&&id='+id;
        	}
        }
        function deleteProblemtype(id){
       		$.messager.confirm('确认', '注意：此操作会删除该类别下面所有问题点，您确定删除该问题类别吗?', function(r){
				if (r){
					$.ajax({
						type:"post",
						url:"${contextPath}/ledger/problemledger/delete.action?ledgerTemplateNew.id="+id,
						success:function(data){
					    	showMessage1('删除成功！');
					    	parent.parent.reloadSelectedNode('deltype');
						}
					});
				}
       		});
        }
        function addProblempoint(id){
        	if(id == ""){
        		 showMessage1("请先保存，再增加问题点！");
        	}else{
	       		window.location.href='<%=request.getContextPath()%>/ledger/problemledger/add_problempoint.action?type=add&ledgerTemplateNew.id='+id;
        	}
        }

        /*
    	判断问题点编号是否存在
    	*/
    	function isCodeExist(code){
    	  var isProblemExist=false;
    	  DWREngine.setAsync(false);
    			DWREngine.setAsync(false);DWRActionUtil.execute(
    				{ namespace:'/ledger/problemledger', action:'isProblemCodeExist', executeResult:'false' }, 
    				{'problemCode':code,'currentId':'${ledgerTemplateNew.id}'},
    				xxx);
    			function xxx(data){
    				isProblemExist = data['isProblemExist'];
    			} 
    			return isProblemExist;
    	}

    	function save(){
    		 var code=document.getElementsByName('ledgerTemplateNew.code')[0].value;
    		 var name=document.getElementsByName('ledgerTemplateNew.name')[0].value;
		     if(code==null||code==''){
		     	 showMessage1('问题类别编号不能为空!');
			     return false;
			 }
		     if(name==null||name==''){
		    	 showMessage1('问题类别不能为空!');
			     return false;
			 }
			 if(isCodeExist(code)=='true'){
		         showMessage1("该问题类别编号已经存在!");
		         return false;
		     }
		     $.ajax({
				type:"post",
				data:$('#problemtype').serialize(),
				url:"${contextPath}/ledger/problemledger/save_problemtype.action",
				async:false,
				success:function(tip){
					if(tip == '1'){
			    		showMessage1('保存成功！');
					}else{
						showMessage1('问题类别编号为数字，请重新输入！');
					}
			    	parent.parent.reloadSelectedNode();
				}
			});
			//document.forms[0].submit();
			//parent.parent.location.reload();
		}
    	//modify by liyuchen 2016-04-26 删除后刷新界面 begin
		<s:if test="${refresh=='D'}">
			parent.parent.location.reload();
		</s:if>
    	//modify by liyuchen 2016-04-26 删除后刷新界面 end
		<s:if test="${refresh=='Y'}">
 			window.parent.frames[0].location.reload();
		</s:if>
		<s:if test="${message=='error'}">
			showMessage1("删除失败，该类别存在子节点!");
		</s:if>

		function exportOrImport(){
			openWin('win','审计问题导入/导出');
		}


		$(function () {
			generateWin('win');

			// 导入/导出 excel审计问题
			$('#importSjwtBtn').bind('click',function(){
				var path = $('#sjwt_file').val();
				var arr = path.split('.');
				var suffix = arr[arr.length - 1];
				//alert(suffix.substring(0,3));
				if(suffix != 'xls'){
					document.getElementById('sjwt_file').outerHTML = document.getElementById('sjwt_file').outerHTML;
					showMessage1('导入文件后缀名错误，请导入 xls 的Excel文件！');
				}else{
					var excelType = suffix.toLowerCase() == 'xls' ? '2003' : (suffix.toLowerCase() == 'xlsx' ? '2007' : '2003');
					$('#excelType').val(excelType);
					$('#import_form').submit();
					$(this).attr('disabled',true);
				}
			});

			// 导入审计事项excel模板
			$('#importSjwtTemplateBtn').bind('click',function(){
				var path = $('#sjwt_file').val();
				var arr = path.split('.');
				var suffix = arr[arr.length - 1];
				//suffix.substring(0,3)
				if(suffix != 'xls'){
					document.getElementById('sjwt_file').outerHTML = document.getElementById('sjwt_file').outerHTML;
					showMessage1('导入文件后缀名错误，请导入 xls 的Excel文件！');
				}else{
					$('#import_form').attr('action','/ais/ledger/problemledger/importSjwtTemplate.action').submit();
				}
			});

			$('#exportSjwtBtn').bind('click',function(){
				$('#exportSjwt_form').attr('action','/ais/ledger/problemledger/exportSjwt.action').submit();
			});

			$('#exportSjwtTemplateBtn').bind('click',function(){
			/* 	$.ajax({
					type: "POST",
					url: "/ais/ledger/problemledger/exportSjwtTemplate!checkSjwtTemplate.action",
					success: function(msg){
						if(msg == 1){
							$('#exportSjwt_form').attr('action','/ais/ledger/problemledger/exportSjwtTemplate.action').submit();
						}else{
							//$.messager.alert('提示信息','请先上传模板文件！','warning');
							showMessage1('请先上传模板文件！');
							return false;
						}
					}
				}) */
				
				window.location.href = "${contextPath}/templatedownload?file=ledgerTemplateNew.xls&type=ledgerTemplateNew";

			});
		})
		</script>
	</head>
	<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout">
	<div region='center' style="overflow: hidden;">
		<div class="easyui-panel" title="问题类别" fit=true style="overflow: visibility;">
			<s:form name="problemtype" id="problemtype" action="save_problemtype.action"
				namespace="/ledger/problemledger">
				<div style="text-align:left;padding:5px;" >
					<s:if test="${param.view!='yes'}">
						<a class="easyui-linkbutton" href="javascript:void(0);"
							iconCls="icon-add" onclick="addProblemtype('${ledgerTemplateNew.id}')">
							增加类别
						</a>
						<s:if
							test="${not empty (ledgerTemplateNew.fid) and ledgerTemplateNew.fid!='0' and ledgerTemplateNew.isSort=='Y'}">
							<a class="easyui-linkbutton" href="javascript:void(0);"
								iconCls="icon-delete" onclick="deleteProblemtype('${ledgerTemplateNew.id}')">
								删除类别
							</a>	
							<a class="easyui-linkbutton" href="javascript:void(0);"
								iconCls="icon-add" onclick="addProblempoint('${ledgerTemplateNew.id}')">
								增加问题点
							</a>
						</s:if>
						<a class="easyui-linkbutton" href="javascript:void(0);"
							iconCls="icon-save" onclick="save()">
							保存
						</a>

						<a class="easyui-linkbutton" href="javascript:void(0);"
						   iconCls="icon-import" onclick="exportOrImport()">
							导入/导出审计问题
						</a>
					</s:if>
				</div>
				<table cellpadding=1 cellspacing=1 border=0 class="ListTable" id="tab1">
					<tr>
						<td class="EditHead" sytle="width:15%">
							<font color=red>*</font>&nbsp;问题类别编号
						</td>
						<td class="editTd" sytle="width:35%">
							<s:textfield cssClass="noborder"
								name="ledgerTemplateNew.code" maxlength="1000"></s:textfield>
						</td>
						<td class="EditHead" sytle="width:15%">
							<font style="color: red;">*</font>&nbsp;问题类别
						</td>
						<td class="editTd" sytle="width:35%">
							<s:textfield cssClass="noborder"
								name="ledgerTemplateNew.name" maxlength="50"></s:textfield>
						</td>
					</tr>
					<s:hidden name="ledgerTemplateNew.id"></s:hidden>
					<s:hidden name="ledgerTemplateNew.fid"></s:hidden>
					<s:hidden name="ledgerTemplateNew.fname"></s:hidden>
					<s:hidden name="ledgerTemplateNew.isSort"></s:hidden>
					<s:hidden name="id"></s:hidden>
				</table>
			</s:form>
		</div>
	</div>

	<!--审计问题导入导出-->
	<div id="win" title="审计问题导入/导出" style='overflow: hidden;'>
		<iframe id="importSjwt" name="importSjwt" style='display: none'></iframe>
		<div style='text-align: left; padding: 5px; overflow: hidden;' id='exportBtnDiv'>
			<form id='exportSjwt_form' action='exportSjwt.action'
				  style='margin: 0px; display: inline;'>
				<a id='exportSjwtTemplateBtn' class="easyui-linkbutton"
				   iconCls="icon-export">
					导出Excel模板
				</a>
				&nbsp
				<a id='exportSjwtBtn' class="easyui-linkbutton"
				   iconCls="icon-export">
					导出审计问题
				</a>
				&nbsp
			</form>
<!-- 			<a id='importSjwtTemplateBtn' class="easyui-linkbutton"
			   iconCls="icon-import">
				导入Excel模板
			</a> -->
			&nbsp
			<a id='importSjwtBtn' class="easyui-linkbutton"
			   iconCls="icon-import">
				导入审计问题
			</a>
		</div>
		<form target='importSjwt' id='import_form' name='import_form'
			  action='/ais/ledger/problemledger/importSjwt.action' method="POST"
			  enctype="multipart/form-data">
			<input type='hidden' id='excelType' name='excelType' />
			<table class="ListTable" align="center">
				<tr>
					<td class="EditHead">
						导入的Excel文件(支持MS Office Excel 2003)
					</td>
					<!--实际后台也支持2007 -->
					<td class="editTd">
						<s:file name="sjwt_file" id='sjwt_file' />
					</td>
				</tr>
			</table>
		</form>
	</div>

	</body>
</html>