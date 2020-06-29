<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://fckeditor.net/tags-fckeditor" prefix="FCK"%>
<s:if test="${assistSuportLawslib.id}=='0'">
	<s:text id="title" name="'添加法律法规'"></s:text>
</s:if>
<s:else>
	<s:text id="title" name="'修改法律法规'"></s:text>
</s:else>
<html>
<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/resources/js/normal.js"></script>
	<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/resources/js/common.js"></script>
	<script type="text/javascript"src="${contextPath}/scripts/calendar.js"></script>
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/csswin/subModal.css" />
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/csswin/common.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/csswin/subModal.js"></script>
	<!-- 公共样式 -->
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
	<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
	<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
	<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
	<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
	<script type="text/javascript" src="${contextPath}/resources/js/jquery-fileUpload.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/ueditor/ueditor.config.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/ueditor/ueditor.all.js"></script>
	<title>法律法规</title>
    <style>
        .panel-title{
            text-align: left;
        }
		.EditHead{
			width: 130px;
		}
    </style>
	<script type="text/javascript">
        function myclick(nodeid,mCodeType){
            if(check()){
                $.ajax({
                    type: "POST",
                    url: "${contextPath}/pages/assist/suport/lawsLib/save!saveOpr.action?",
                    data: $("#myform").serialize(),
                    dataType:"text",
                    success: function(msg){
                        if(msg=='1'){
                            showMessage2('保存成功！','消息');

                            window.location.href='../lawsLib/listByTypeKey.action?nodeid='+nodeid+'&mCodeType='+mCodeType;
                        }
                    }
                });
            }

        }

        function deleteFile(fileId,guid,isDelete,isEdit,appType){
            $.messager.confirm('确认','确认删除吗?',function(boolFlag){
                if (boolFlag){
                    DWREngine.setAsync(false);
                    DWREngine.setAsync(false);DWRActionUtil.execute(
                        { namespace:'/commons/file', action:'delFile', executeResult:'false' },
                        {'fileId':fileId, 'deletePermission':isDelete, 'isEdit':isEdit, 'guid':guid, 'appType':appType},
                        xxx);
                    function xxx(data){
                        document.getElementById("accelerys").innerHTML=data['accessoryList'];
                    }
                }
            });
        }
        function publish2(){
            $.messager.confirm('确认','确认发布吗?',function(boolFlag){
                if (boolFlag){
                    var _marked = document.getElementById('marked').value;
                    var url = "<%=request.getContextPath()%>/pages/assist/suport/lawsLib/publish.action?ids=${assistSuportLawslib.id}&nodeid=${assistSuportLawslib.categoryFk}&mCodeType=${mCodeType}&listpub=Y&marked=" + _marked;
                    window.location = url;
                }
            });
        }

        function check(){
			var idElement = document.getElementsByName("assistSuportLawslib.id")[0];
			var title = $('#asltitle').val();
			var codification = $('#codification').val();
			var categoryFk = document.getElementsByName("assistSuportLawslib.categoryFk")[0].value;
			if (title == "") {
				showMessage1('名称不能为空，请填写名称！', '消息');
				return false;
			} else {
				var flag = "false";
				$.ajax({
					type: "POST",
					async: false,
					url: "${contextPath}/pages/assist/suport/lawsLib/save!checkTitleOrCodification.action?",
					data: {"title": title, "codification": codification, "lawId": idElement.value, "categoryFk": categoryFk},
					dataType: "json",
					success: function (msg) {
						if (msg.flag == '2') {
							$.messager.confirm("提示", "名称重复，是否保存！", function (r) {
								if (r) {
									$.ajax({
										url: "${contextPath}/pages/assist/suport/lawsLib/saveLawEdit.action",
										dataType: 'json',
										type: "post",
										async: false,
										data: $('#myform').serialize(),
										success: function (data) {
											if (data.type == "success") {
												idElement.value = data.lawId;
												showMessage1("保存成功");
												parent.window.$('#editLawslib').window('close');
												parent.window.$('#objectList').datagrid('reload');
											} else {
												showMessage1("保存失败");
											}
										},
										error: function (data) {
											showMessage1("请求失败！请检查网络配置或者与管理员联系！");
										}
									});
								}
							});
						} else if (msg.flag == '1') {
							$.messager.confirm("提示", "文号重复，是否保存！", function (r) {
								if (r) {
									$.ajax({
										url: "${contextPath}/pages/assist/suport/lawsLib/saveLawEdit.action",
										dataType: 'json',
										type: "post",
										async: false,
										data: $('#myform').serialize(),
										success: function (data) {
											if (data.type == "success") {
												idElement.value = data.lawId;
												showMessage1("保存成功");
												parent.window.$('#editLawslib').window('close');
												parent.window.$('#objectList').datagrid('reload');
											} else {
												showMessage1("保存失败");
											}
										},
										error: function (data) {
											showMessage1("请求失败！请检查网络配置或者与管理员联系！");
										}
									});
								}
							});
						} else if (msg.flag == '3') {
							flag = "true";
						}
					}
				});
				if (flag == "false") {
					return false;
				}
			}
			var _categoryType = document.getElementsByName("assistSuportLawslib.category")[0].value;
			if (_categoryType == "") {
				showMessage1('类别不能为空，请您选择类别！', '消息');
				return false;
			}
			return true;
		}

        function getLength(){
            var oEditor = FCKeditorAPI.GetInstance("assistSuportLawslib.content");
            var oDOM = oEditor.EditorDocument;
            var iLength ;
            if(document.all){
                iLength = oDOM.body.innerText.length;
            }else{
                var r = oDOM.createRange();
                r.selectNodeContents(oDOM.body);
                iLength = r.toString().length;
            }
        }


        function compareDate(DateOne,DateTwo){
            if(DateTwo.length<1||DateOne.length<1) return false;
            var OneMonth = DateOne.substring(5,DateOne.lastIndexOf ("-"));
            var OneDay = DateOne.substring(DateOne.length,DateOne.lastIndexOf ("-")+1);
            var OneYear = DateOne.substring(0,DateOne.indexOf ("-"));

            var TwoMonth = DateTwo.substring(5,DateTwo.lastIndexOf ("-"));
            var TwoDay = DateTwo.substring(DateTwo.length,DateTwo.lastIndexOf ("-")+1);
            var TwoYear = DateTwo.substring(0,DateTwo.indexOf ("-"));

            if (Date.parse(OneMonth+"/"+OneDay+"/"+OneYear) >
                Date.parse(TwoMonth+"/"+TwoDay+"/"+TwoYear)){
                return true;
            }
            else{
                return false;
            }
        }
        function chgEffect(){
            var tempdata=document.getElementsByName('assistSuportLawslib.invalidationDate')[0].value;
            if(tempdata.length>1&&compareDate(showDate(),tempdata)){
                document.getElementById('effect').innerHTML ='无效';
                document.getElementsByName('assistSuportLawslib.effective')[0].value ='无效';
            }else{
                document.getElementById('effect').innerHTML ='有效';
                document.getElementsByName('assistSuportLawslib.effective')[0].value ='有效';
            }
        }
        function mload(){
            var mobj=document.getElementsByName('assistSuportLawslib.invalidationDate')[0];
            mobj.onpropertychange=function(){
                chgEffect();
            }
        }
        function showDate(){
            var today = new Date();
            var day = today.getDate();
            var month = today.getMonth()+1;
            var year = today.getYear();
            var date = year + "-" + month + "-" + day;
            return date;
        }
        function getUrlParam(){
            return "&mCodeType=${mCodeType}";
        }
        function goback(){
            var _marked = document.getElementById('marked').value;
            window.history.go(-1);
        }
        function doSearch(){
            var submit=document.getElementById("searchForm");
            submit.submit();
        }

        function mySubmitForm(){
			var ue = UE.getEditor('content', {
				elementPathEnabled: false
			});
			$('#content_value').val(ue.getContent('content'));
			if (check()) {
				$.ajax({
					url: "${contextPath}/pages/assist/suport/lawsLib/saveLawEdit.action",
					dataType: 'json',
					type: "post",
					async: false,
					data: $('#myform').serialize(),
					success: function (data) {
						if (data.type == "success") {
							var idElement = document.getElementsByName("assistSuportLawslib.id")[0];
							idElement.value = data.lawId;
							showMessage1("保存成功");
							parent.window.$('#editLawslib').window('close');
							parent.window.$('#objectList').datagrid('reload');
						} else {
							showMessage1("保存失败");
						}
					},
					error: function (data) {
						showMessage1("请求失败！请检查网络配置或者与管理员联系");
					}
				});
			}
		}

        // true : 有相同法规文件
        function checkSameFile(fileName){
            var rt = false;
            try{
                $.ajax({
                    url : "${contextPath}/pages/assist/suport/lawsLib/isHaveSameFile.action",
                    dataType:'json',
                    type: "post",
                    async:false,
                    data: {
                        'fileName':fileName
                    },
                    success: function(data){
                        rt = data.type == 'error' ? true : false;
                        if(rt){
                            data.msg ? showMessage1(data.msg,'我的消息') : null;
                            rt = false;
                        }

                    },
                    error:function(data){
                        top.$.messager.show({title:'提示信息',msg:'请求失败！请检查网络配置或者与管理员联系！'});
                    }
                });
            }catch(e){
                alert(e.message);
            }
            return rt;
        }
	</script>

</head>
<body  style="overflow:hidden;" >
<div class="easyui-layout" fit='true' border="0" style='overflow:hidden;'>
	<div region='center' border='0'>
		<div style="width: 100%;height:30px;position:fixed;top:0;z-index:1000;">
			<table class="ListTable" style="width:100%;border:0;padding:0;margin:0;">
				<tr class="EditHead">
					<td>
					<span style="float:right;">
					<s:hidden name="m_message" value="${m_message}"/>
					<s:if test="${not empty(assistSuportLawslib.id) && assistSuportLawslib.id!='0'}">
						<s:if test="${empty(assistSuportLawslib.pub_state)}||${assistSuportLawslib.pub_state=='N'}">
							<a class="easyui-linkbutton" data-options="iconCls:'icon-publish'" onclick="publish2()">发布</a>&nbsp;
						</s:if>
					</s:if>
					<a class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="mySubmitForm();">保存</a>
					&nbsp;
				</span>
					</td>
				</tr>
			</table>
		</div>
		<s:form id="myform" action="saveLawEdit" namespace="/pages/assist/suport/lawsLib"
				theme="simple">

			<s:hidden name="nodeid" value="${nodeid}" />
			<%--<s:hidden name="assistSuportLawslib.categoryFk"
					  value="${assistSuportLawslib.categoryFk}" />--%>
			<s:hidden name="assistSuportLawslib.id"
					  value="${assistSuportLawslib.id}" />
			<s:hidden name="assistSuportLawslib.muuid"
					  value="${assistSuportLawslib.muuid}" />
			<%-- 发布状态 --%>
		<s:if test="${empty(assistSuportLawslib.pub_state)}">
			<s:hidden name="assistSuportLawslib.pub_state" value="N"/>
		</s:if>
		<s:else>
			<s:hidden name="assistSuportLawslib.pub_state"/>
		</s:else>
			<%-- 发布人 --%>
			<s:hidden name="assistSuportLawslib.pub_man"/>
			<s:hidden name="assistSuportLawslib.classification"
					  value="${assistSuportLawslib.classification}" />
			<s:hidden name="mCodeType"
					  value="${mCodeType}" />
			<%-- 创建人 --%>
		<s:if test="${empty(assistSuportLawslib.upman)}">
			<s:hidden name="assistSuportLawslib.upman" value="${user.floginname}"/>
		</s:if>
		<s:else>
			<s:hidden name="assistSuportLawslib.upman"/>
		</s:else>
			<s:hidden name="assistSuportLawslib.createDate"/>
			<%--<s:hidden name="assistSuportLawslib.effective"/>--%>
			<s:hidden name="assistSuportLawslib.hitCount"/>
		<table name="editList" cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable" id="mytable" style="margin-top:35px">
			<tr>
				<td class="EditHead" nowrap="nowrap">
					<font color="red">*</font>&nbsp;名称

				</td>
				<td class="editTd">
					<s:textfield cssClass="noborder" title="名称(题目/条目)" id="asltitle" name="assistSuportLawslib.title"/>
				</td>
				<td class="EditHead">
					文号
				</td>
				<td class="editTd">
					<s:textfield label="%{'文号'}" cssClass="noborder" id="codification"
								 name="assistSuportLawslib.codification"/>
				</td>
			</tr>
			<tr>
				<td class="EditHead" >
					发文单位
				</td>
				<td class="editTd">
					<s:textfield label="发文单位" cssClass="noborder"
								 name="assistSuportLawslib.promulgationDept"/>
				</td>
				<td class="EditHead" nowrap="nowrap">
					发文时间
				</td>

				<td class="editTd" nowrap="nowrap">
					<input type="text" class="easyui-datebox noborder" label="发文日期"  id="promulgationDate" name="assistSuportLawslib.promulgationDate" value="${assistSuportLawslib.promulgationDate}" title="单击选择日期" editable="false">
				</td>

			</tr>
			<tr>
				<td class="EditHead" nowrap="nowrap">
					实施日期
				</td>

				<td class="editTd" nowrap="nowrap">
					<input type="text" class="easyui-datebox noborder" label="实施日期"  id="effctiveDate" name="assistSuportLawslib.effctiveDate" value="${assistSuportLawslib.effctiveDate}" title="单击选择日期" editable="false">
				</td>
			</tr>
			<tr>
				<td class="EditHead">
					效力级别
				</td>
				<td class="editTd" >
					<select class="easyui-combobox" editable="false" name="assistSuportLawslib.summary" style="width:80%;"  data-options="panelHeight:75">
						<option value="">&nbsp;</option>
						<s:iterator value="basicUtil.effectiveLevelList" id="entry">
							<s:if test="${assistSuportLawslib.summary==name}">
								<option selected="selected" value="${name }">${name}</option>
							</s:if>
							<s:else>
								<option value="<s:property value="name"/>"><s:property value="name"/></option>
							</s:else>
						</s:iterator>
							<%--<s:iterator value="#@java.util.LinkedHashMap@{'法律':'法律','行政法规':'行政法规','部门规章':'部门规章'}" id="entry">
                                <option value="<s:property value="key"/>"><s:property value="value"/></option>
                            </s:iterator>--%>
					</select>
				</td>
				<td class="EditHead">
					时效性
				</td>
				<td class="editTd" id="effect">
					<select class="easyui-combobox" editable="false" name="assistSuportLawslib.effective" style="width:80%;"  data-options="panelHeight:75">
						<s:iterator value='#@java.util.LinkedHashMap@{"有效":"有效","无效":"无效"}' id="entry">
							<s:if test="${assistSuportLawslib.effective == key}">
								<option selected="selected" value="${key}"/>${value}</option>
							</s:if>
							<s:else>
								<option value="${key}"/>${value}</option>
							</s:else>
						</s:iterator>
					</select>
				</td>


			</tr>
			<tr>
				<td class="EditHead">
					<font color="red">*</font>&nbsp;类别
				</td>
				<td class="editTd">

					<%--<s:buttonText2 id="category" hiddenId="category" cssClass="noborder"
								   name="assistSuportLawslib.category"
								   hiddenName="assistSuportLawslib.categoryFk"
								   doubleCssStyle="cursor:pointer;border:0"
								   readonly="true"
								   doubleDisabled="!(varMap['audit_objectWrite']==null?true:varMap['audit_objectWrite'])" title="法规类别" maxlength="1500"/>
--%>
					<%--根据左侧树形确定法规类型 ，此处树形没有类别权限，显示节点过多--%>
								<s:buttonText2 id="category" hiddenId="category" cssClass="noborder"
									name="assistSuportLawslib.category"
									hiddenName="assistSuportLawslib.categoryFk"
									doubleOnclick="showSysTree(this,{
		                                  title:'请选择法律法规类别',
		                                  type:'tree',
		                                  onlyLeafClick:true,
										  param:{
										    'serverCache':false,
										  	'rootId':'3',
						                    'beanName':'AssistSuportLawslibMenu',
						                    'treeId'  :'id',
						                    'treeText':'category_name',
						                    'treeParentId':'parent_id',
						                    'treeOrder':'priority'
						                 }
									})"
									doubleSrc="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png"
									doubleCssStyle="cursor:pointer;border:0"
									readonly="true"
									doubleDisabled="!(varMap['audit_objectWrite']==null?true:varMap['audit_objectWrite'])" title="法规类别" maxlength="1500"/>

				</td>
					<%--是否发布--%>
				<%@include file="/pages/assist/suport/pub_state2.jsp"%>
			</tr>
			<tr>
				<td class="EditHead">
					创建单位
				</td>
				<td class="editTd">
					<s:property value = "assistSuportLawslib.sundept" ></s:property>
					<s:hidden name="assistSuportLawslib.sundept"/>
					<s:hidden name="assistSuportLawslib.sundeptId"/>
				</td>
				<td class="EditHead">
					创建时间
				</td>
				<td class="editTd">
					<s:property value = "assistSuportLawslib.createDate" ></s:property>
					<s:hidden name="assistSuportLawslib.createDate"/>
				</td>

			</tr>
			<tr>
				<td class="EditHead" colspan="4" style="text-align: center">正 文
			</tr>
			<tr>

				<td class="editTd" colspan="4" >
					<textarea id="content"  type="text/plain" style="width:100%;" height="560"  name="content">
                            ${assistSuportLawslib.content}
					</textarea>
                   <s:hidden name="assistSuportLawslib.content" id="content_value"></s:hidden>
			    </td>

			</tr>
		</table>
			<s:hidden id="marked" name="marked"></s:hidden>
		</s:form>
		<table id="its"></table>
	</div>
	<div region='south' border='0'>
		<div id='flfgUploadDiv' data-options="fileGuid:'${assistSuportLawslib.muuid}', isDownload:false,callbackGridHeight:230, onFileSubmit:function(options){
				var fileArr = $(options.target).data('fileArr');
				var fileNames = [];
				if(fileArr && fileArr.length){
					$.each(fileArr, function(i, fileInfo){
						fileNames.push(fileInfo.name);
					});
				}
				var rt = true;
				if(fileNames && fileNames.length){
					for(var i=0; i<fileNames.length; i++){
						var fileName = fileNames[i];
						var isHaveSameFile = checkSameFile(fileName);
						//alert(fileName+'\n'+isHaveSameFile)
						if(isHaveSameFile){
							rt = false;
							break;
						}
					}
				}
				return rt;
			}" class="easyui-fileUpload"></div>
	</div>
</div>
<script type="text/javascript">
	var ue = UE.getEditor('content',{elementPathEnabled:false,initialFrameHeight:window.innerHeight-400});
	ue.ready(function(){
        $('.edui-editor').css('z-index', 0);
    });
</script>
</body>
</html>