<%@ page language="java" errorPage="/error.jsp" pageEncoding="UTF-8"
	contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE HTML>
<html>
	<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<title>法律法规</title>
	<!-- 长度验证 -->
	<script type="text/javascript" src="${contextPath}/scripts/ufaudTextLengthValidator.js"></script>
	<!-- 全局 -->			
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
	<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
	<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
	<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
	<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
	<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
	<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
	<script type="text/javascript">
	
	$(function(){
		
		if("${jspRefresh}"){
			showMessage1('保存成功！','我的消息');
		}
		
		var s = "${assistSuportLawslibMenu.canView}";
		var rt = '';
		if(s == '' || s == '0'){
			rt = '否';
		}else if(s == '1'){
			rt = '是';
		}
		
		if(document.getElementById('canView')){
			var sele = document.getElementById('canView');
			for(var i=0; i<sele.options.length; i++){
				var op = sele.options[i];
				if(op.value == s){
					op.setAttribute('selected',true);
					break;
				}
			}
		}
		$('#canViewName').html(rt);
	});
	
	
	${jspRefresh}
	function mydelSubmit(){
		top.$.messager.confirm('确认','确认删除吗?',function(r){    
			if(r){  			
				window.location.href = "${contextPath}/pages/assist/suport/lawsLib/delMenu.action?assistSuportLawslibMenu.parent_id=${assistSuportLawslibMenu.parent_id}&assistSuportLawslibMenu.id=${assistSuportLawslibMenu.id}&assistSuportLawslibMenu.classification=${assistSuportLawslibMenu.classification}";
				//parent.loadParentTree('${assistSuportLawslibMenu.parent_id}'); 
				
				/*
				var delUrl = "${contextPath}/pages/assist/suport/lawsLib/delMenu.action";
				
				$.ajax({
					url : delUrl,
					type: "POST",
					data:{
						'assistSuportLawslibMenu.id':'${assistSuportLawslibMenu.id}',
						'assistSuportLawslibMenu.classification':'${assistSuportLawslibMenu.classification}'
					},
					success: function(data){
						alert(data)
						$('body').html(data);
						//showMessage1('删除成功！','我的消息','0');
						parent.loadParentTree('${assistSuportLawslibMenu.parent_id}');           
					},
					error:function(data){
						top.$.messager.alert('提示信息','请求失败！请检查网络配置或者与管理员联系！','error');
					}
				});*/
				
			}else{
				return false;
			}    
		});
	}
	function myeditSubmit(){
		window.location.href="editMenu.action?isLeaf=${isLeaf}&assistSuportLawslibMenu.id=${assistSuportLawslibMenu.id}&assistSuportLawslibMenu.classification=${assistSuportLawslibMenu.classification}&nodeid=${nodeid}";
	}
	function myaddSubmit(){
		window.location.href="addMenu.action?mCodeType=${mCodeType}&nodeid=${nodeid}&parentDeptId=${assistSuportLawslibMenu.deptId}";
	}
	function mydelCheck(){
		s=document.getElementsByName("assistSuportLawslibMenu.id");
		j=0;
		for(i=0;i<s.length;i++){
			if(s[i].checked)
				j=j+1;
		}
		if(j<1){
			showMessage1('请先至少选中一个在进行删除操作！','消息','0');
			return  false;
		}
		return true;
	}
	//查看是否指定节点下有内容
	function exsitContent(){
        try{
            //校验项目类别名
            var category_name = document.getElementsByName("assistSuportLawslibMenu.category_name")[0].value;
            if(category_name==null || category_name==''){
                showMessage1('类别名称不能为空！','消息','0');
                return false;
            }
            var priority = document.getElementsByName("assistSuportLawslibMenu.priority")[0].value;
            if(priority!="" && !isDigit(priority)){
                showMessage1('优先级 只能是数字!','消息','0');
                return false;
            }

            var deptName = document.getElementById('deptName').value;
            if(deptName == null || deptName == "") {
                showMessage1('请选择一个类别所属单位!','消息','0');
                return false;
            }
            //ajax验证内容是否存在
            var flag = 'false';
            DWREngine.setAsync(false);
            DWREngine.setAsync(false);DWRActionUtil.execute({ namespace:'/pages/assist/suport/lawsLib', action:'exsitMenuContent', executeResult:'false' },
            {'id':'${assistSuportLawslibMenu.id}'},xxx);
            function xxx(data){
                flag = data['flag'];
                document.getElementsByName("flag")[0].value = data['flag'];
                document.getElementById("from1").submit();
                parent.loadParentTree('${assistSuportLawslibMenu.id}');
            } 
            if(flag=='true'){
                top.$.messager.confirm('提示信息',"此节点下有内容，是否同步内容的分类名称！", function(r){			
                    if(r){
                        document.getElementsByName("flag")[0].value="true";
                        document.getElementById("from1").submit();
                        parent.loadParentTree('${assistSuportLawslibMenu.id}');
                    }
                });
            }
            
        }catch(e){
            alert("exsitContent:\n"+e.message);
        }
		
	}
	
	function myeditCheck(){
		s=document.getElementsByName("assistSuportLawslibMenu.id");
		j=0;
		for(i=0;i<s.length;i++){
			if(s[i].checked)
				j=j+1;
		}
		if(j<1){
			showMessage1('请先选择一个再进行修改！','消息','0');
			return false;
		}
		if(j>1){
			showMessage1('修改操作只能选择一个进行修改！','消息','0');
			return false;
		}
		return true;
	}
	function myaddCheck(){
		s=document.getElementsByName("assistSuportLawslibMenu.id");
		j=0;
		for(i=0;i<s.length;i++){
			if(s[i].checked)
				j=j+1;
		}
		if(j!=0){
			showMessage1('请不要在复选框中选中任何东西！','消息','0');
			return false;
		}
		return true;
	}
	//重置
	function clearInfo(){
		document.getElementsByName("assistSuportLawslibMenu.category_name")[0].value="";
		document.getElementsByName("assistSuportLawslibMenu.priority")[0].value="";
	}
	${malert}
	//数字校验
	function isDigit(s) { var patrn=/^[0-9]{1,4}$/; if (!patrn.exec(s)) return false; return true; }
	

	</script>
	</head>
	<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout">
		${message}
		<s:form action="saveMenu" id="from1" namespace="/pages/assist/suport/lawsLib"
			name="lawsMenuForm" method="post" theme="simple">
			<s:if test="!${empty(m_view)}">
				<table style="width: 100%; border: 0">
					<tr>
						<td>
							<span style="float: left;">
							<s:if test="${isLeaf == true || deptId == '1'}">
								<a class="easyui-linkbutton" data-options="iconCls:'icon-delete'" onclick="mydelSubmit()">删除</a>&nbsp;&nbsp;
								<a class="easyui-linkbutton" data-options="iconCls:'icon-edit'" onclick="myeditSubmit()">修改</a>&nbsp;&nbsp;
							</s:if>
							<a class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="myaddSubmit()">新增</a>&nbsp;&nbsp;
							</span>
						</td>
					</tr>
				</table>
			</s:if>
			<s:if test="${empty(m_view)}">
				<table style="width: 100%; border: 0">
					<tr>
						<td>
							<span style="float: left;">
							 	<!--<s:submit value="保存" align="center" onclick="return exsitContent()"></s:submit>-->
							 	<a class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="exsitContent()">保存</a>&nbsp;&nbsp;
								<a class="easyui-linkbutton" data-options="iconCls:'icon-reload'" onclick="clearInfo()">重置</a>&nbsp;&nbsp;
							</span>
						</td>
					</tr>
				</table>
			</s:if>			
			
			<s:hidden name="flag" />
			<s:hidden name="nodeid" value="${nodeid}" />
			<s:hidden name="mCodeType" value="${mCodeType}" />

			<s:hidden name="assistSuportLawslibMenu.parent_id"
				value="%{assistSuportLawslibMenu.parent_id}" />
			<s:hidden name="assistSuportLawslibMenu.id"
				value="%{assistSuportLawslibMenu.id}" />
			<s:hidden name="assistSuportLawslibMenu.classification"
				value="%{assistSuportLawslibMenu.classification}" />
				
		    <input type="hidden" name="assistSuportLawslibMenu.parentDeptId" value="${assistSuportLawslibMenu.parentDeptId}"/>
		    <input type="hidden" name='assistSuportLawslibMenu.canView' value="1">
			<table cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
				<tr>
					<td class="EditHead" width="25%">
						所属类别
					</td>
					<td class="editTd">
						<s:text name="%{parentTypeName}"></s:text>
					</td>
				</tr>
				<tr>
					<s:if test="${empty(m_view)}">
						<td class="EditHead">
							<font style="color: red;">*</font>&nbsp;类别名
						</td>
						<td class="editTd">

							<s:textfield cssStyle="width:160px;"  cssClass="noborder" 
								name="assistSuportLawslibMenu.category_name"
								value="%{assistSuportLawslibMenu.category_name}" maxlength="40"></s:textfield>
						</td>
					</s:if>
					<s:else>
						<td class="EditHead">
							类别名
						</td>
						<td class="editTd">
							${assistSuportLawslibMenu.category_name}
						</td>
					</s:else>

				</tr>
				<tr>
					<td class="EditHead">
						创建人
					</td>
					<td class="editTd">
						<s:hidden name="assistSuportLawslibMenu.create_man"
							value="%{assistSuportLawslibMenu.create_man}"></s:hidden>
						${assistSuportLawslibMenu.create_man}

					</td>
				</tr>
				<tr>
					<td class="EditHead">
						创建人所属单位
					</td>
					<td class="editTd">
						<s:hidden name="assistSuportLawslibMenu.man_dept"></s:hidden>
						${assistSuportLawslibMenu.man_dept}
					</td>
				</tr>
				<tr>
					<s:if test="${empty(m_view)}">
						<td class="EditHead">
							<font style="color: red;">*</font>&nbsp;类别所属单位
						</td>
						<td class="editTd"> 
							<s:buttonText2 cssStyle="width:200px;" id="deptName" cssClass="noborder"
								hiddenId="deptId" name="assistSuportLawslibMenu.deptName"
								hiddenName="assistSuportLawslibMenu.deptId"
								doubleOnclick="showSysTree(this,{
		                                  title:'类别所属单位',
		                                  
										  param:{
										  	'rootId':'${assistSuportLawslibMenu.parentDeptId}',
						                    'beanName':'UOrganizationTree',
						                    'treeId'  :'fid',
						                    'treeText':'fname',
						                    'treeParentId':'fpid',
						                    'treeOrder':'fcode'
						                 }                                  
								})"
								doubleSrc="${pageContext.request.contextPath}/resources/images/s_search.gif"
								doubleCssStyle="cursor:pointer;border:0" readonly="true"
								title="所属单位" maxlength="100" />
						</td>
					</s:if>
					<s:else>
						<td class="EditHead">
							类别所属单位
						</td>
						<td class="editTd">
							<s:hidden name="assistSuportLawslibMenu.deptName"></s:hidden>
							<s:hidden name="assistSuportLawslibMenu.deptId"></s:hidden>
							${assistSuportLawslibMenu.deptName }

						</td>
					</s:else>
				</tr>
				<tr>
					<td class="EditHead">
						创建日期
					</td>
					<td class="editTd">
						<s:hidden name="assistSuportLawslibMenu.create_date"
							value="${fn:substring(assistSuportLawslibMenu.create_date, 0, 10)}"></s:hidden>
						<s:if test="!${empty(assistSuportLawslibMenu.create_date)}">
								${fn:substring(assistSuportLawslibMenu.create_date, 0, 10)}
						</s:if>
					</td>
				</tr>
				<tr>
					<td class="EditHead">
						优先级
					</td>
					<td class="editTd">
						<s:if test="${empty(m_view)}"> 
							<s:textfield cssStyle="width:160px;"  cssClass="noborder"
								name="assistSuportLawslibMenu.priority"
								value="%{assistSuportLawslibMenu.priority}" maxlength="40"></s:textfield>
						</s:if>
						<s:else>
							${assistSuportLawslibMenu.priority}
						</s:else>
					</td>
				</tr>
			</table>
		</s:form>
	</body>
</html>