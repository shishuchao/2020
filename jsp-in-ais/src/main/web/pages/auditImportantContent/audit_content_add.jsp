<!DOCTYPE HTML>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%
 String s = (String)request.getAttribute("success");
 System.out.print(s);
 %>
<html>
<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<title><s:property value="#title" /></title>
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
	<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
	<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
	<script language="javascript">
			
	    function closeWindow(){
		   parent.closeWin('editWin');
		}
	    //打开项目类别选择窗口
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
	    //保存项目类别
	    function saveF(){
			var ayy = $('#item_ifr')[0].contentWindow.saveF();
			var res = ayy[0].split(',');
			var name = ayy[1].split(',');
			if(res.length != 1){
				document.all('auditImportant.typeCode2').value=res[0];
				document.all('auditImportant.typeCode').value=res[1];
    			document.all('auditImportant.typeName').value=name[0];
    			document.all('auditImportant.typeName2').value=name[1];
    			document.getElementById('typeName2').style.display='';
			}else{
				document.all('auditImportant.typeCode2').value='';
				document.all('auditImportant.typeCode').value=ayy[0];
				document.all('auditImportant.typeName').value=name[0];
    			document.all('auditImportant.typeName2').value='';
    			document.getElementById('typeName2').style.display='none';
			}
    		closeWin();
		}
	    //项目类别窗口清空按钮
		function cleanF(){
			document.all('auditImportant.typeCode').value='';
    		document.all('auditImportant.typeCode2').value='';
    		document.all('auditImportant.typeName').value='';
    		document.all('auditImportant.typeName2').value='';
    		document.getElementById('typeName2').style.display='none';
    		closeWin();
		}
	    function closeWin(){
			$('#subwindow').window('close');
		}
	    //校验
		function check(){
			var v_3 = "auditImportant.importantContentName";  // field
			var title_3 = '名称';// field name
			var notNull = 'true'; // notnull
			var t=document.getElementsByName(v_3)[0].value;
			if(t.length>200){
				showMessage1("方案名称的长度不能大于200字！");
				document.getElementById(v_3).focus();
				return false;
			} 
			return true;
	    }
		 //保存并增加表单
		 function saveForm(){
			var v_3 = "auditImportant.importantContentName";  // field
			var title_3 = '名称';// field name
			var notNull = 'true'; // notnull
			if(document.getElementsByName(v_3)[0].value=="" && notNull=="true"　&& notNull != ""){
				showMessage1(title_3+"不能为空!");
				bool = false;
				return false;
			}
			
			if(document.getElementsByName(v_3)[0].value.replace(/\s+$|^\s+/g,"")==""){
				showMessage1(title_3+"不能为空!");
				bool = false;
				document.getElementById(v_3).focus();
				return false;
			}
			if(!check()){
				return false;
			}	
			$.ajax({
				type:"post",
				data:$('#myform').serialize(),
				url:"${contextPath}/auditImportantContent/saveContent.action",
				async:false,
				success:function(){
			    	parent.$('#editWin').window('close');
			    	parent.datagridReload('its');
			    	showMessage1('保存成功！');
				}
			});
		}  				
	
		//显示成功信息
		function test(s){
			if(s == true){
				showMessage1('保存成功！');
				parent.datagridReload('its');
			}
		}
	</script>
</head>
<body onload="test(<%=s%>)" style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout" border="0" fit="true">
	<div region="center" border="0">
		<s:form id="myform" action="view" method="post">
			<table cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
				<tr>
					<td style="width: 15%" class="EditHead">
						<font color="red">*</font>名称
					</td>
					<!--标题栏-->
					<td style="width: 35%" class="editTd">
						<s:textfield cssClass="noborder" name="auditImportant.importantContentName" />
					</td>
					<td class="EditHead" style="width:15%">
						项目类别
					</td>
					<td class="editTd" style="width:35%">
						<div style="float: left;">
							<s:textfield cssClass="noborder" name="auditImportant.typeName"  id="typeName" cssStyle="width:150px" readonly="true"/>
							<s:textfield cssClass="noborder" name="auditImportant.typeName2"  id="typeName2" cssStyle="width:150px; display:none" readonly="true"/>
							<img style="cursor:pointer;border:0" src="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png"
						    	onclick="getItem('/ais/pages/basic/code_name_tree_select.jsp','&nbsp;请选择项目类别',500,400)"/>
								<input type="hidden" id="typeCode" name="auditImportant.typeCode" value="<s:property value='auditImportant.typeCode'/>">
								<input type="hidden" id="typeCode2" name="auditImportant.typeCode2" value="<s:property value='auditImportant.typeCode2'/>">
						</div>
					</td>					
				</tr>
				<s:hidden name="auditImportant.importantContentId" />
				<tr>
					<td class="EditHead">
						<font color="red" ></font>编制人
					</td>
					<td class="editTd">
						<s:property value="auditImportant.proAuthorName" />						
						<s:hidden name="auditImportant.proAuthorName" />
					</td>
					<td  class="EditHead">
						<font color="red"></font>编制日期:
					</td>
					<td class="editTd">
						<s:property value="auditImportant.proDate" />
						<s:hidden name="auditImportant.proDate" />
					</td>
				</tr>
			</table>
			<div style="margin-top:20px;text-align:center">				
				<a class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="saveForm();">保存</a>
				<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="closeWindow();">关闭</a>
			</div>
		</s:form>
		<div id="subwindow" class="easyui-window" title="项目类别" iconCls="icon-search" style="width:500px;height:500px;padding:5px;" closed="true">
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
	</div>
</body>
</html>
