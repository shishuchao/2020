<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML >
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<title></title>
<script type="text/javascript" src="${contextPath}/easyui/boot.js"></script>  
<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script> 
<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>	
<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
<link href="${contextPath}/index/assets/global/plugins/simple-line-icons/simple-line-icons.min.css" rel="stylesheet" type="text/css" />
<link href="${contextPath}/index/assets/global/plugins/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css" />

<s:head theme="ajax" />
<script type="text/javascript">		
 $(document).ready(function(){
	$('#myTabs').tabs({
		border:false,
		onSelect:function(title,index){
			if(index == 0){
			}else if(index == 1){
				var src = $('#oppNode').attr('src');
				if(src == ''){
					$('#oppNode').attr('src','${contextPath}/system/menu/omListNode.action?abf.ffunid=${abf.ffunid}');
				}
			}else if(index == 2){
				var src = $('#chgNode').attr('src');
				if(src == ''){
					$('#chgNode').attr('src','${contextPath}/pages/system/menu/chgNode.jsp?abf.ffunid=${abf.ffunid}');
				}
			}
		}
	});
	}); 
	function divOneSave(){
		if(frmCheck(document.forms[0],'tab1')){
			id=document.getElementsByName("abf.ffunid")[0].value;
			pid=document.getElementsByName("abf.fparentid")[0].value;
			content=document.getElementsByName("bfEx.content")[0].value;
			if(content.length>2000){
				showMessage1("您只能输入2000个字，请删减!");
				return false;
			}
			if(id.indexOf('0')==0){id=id.substring(1);}
			if(pid.indexOf('0')==0){pid=pid.substring(1);}
			if(id<=pid){
				showMessage1("功能序号要大于父功能序号!");
				return false;
			}
			var obj=document.getElementsByName('abf.flink')[0];
			var obj2=document.getElementsByName('abf.fmoduleid')[0];
			if(obj.id!='link_one'){
				obj2.value=obj.value;
			}
			if(!checkNumber(id,pid)){
				return false;
			}
			document.forms[0].submit();
		}
	}
	function checkNumber(id, pid){
		var flag = false;
		$.ajax({
            url :"/ais/system/checkNumber.action",
            type:'POST',
            async: false,
            data:{
            	id:id,'edit':'${edit}','pid':pid
            },            
            dataType:'json',
            success:function(data){
                 if(data.count=="0"){
                	 flag = true; 
                 } else if(data.count=="1") {
                    showMessage1("功能序号重复!");
                 } else if(data.count=="2") {
                    showMessage1("父功能序号对应的系统菜单不存在!");
                }
            }
        });
		return flag;
	}
	function divOneDel(delId){
		$.messager.confirm('提示信息', '确定要删除明细信息吗?如果删除,将会导致所有用户丢失该功能的权限信息？', function(isDel){
			if(isDel){
				url="/ais/system/omDel.action?abf.ffunid="+delId;
				window.location.href=url;
				//send(url,proce); 
			}
		});
	}
	function divOneAdd(id){
		url="/ais/system/omAdd.action?isMenu=Y&abf.ffunid="+id;
		window.location.href=url;
	}
	function divOneEdit(id){
		url="/ais/system/omEdit.action?abf.ffunid="+id;
		window.location.href=url;
	}
	function mshow(){
		var evt = window.event;
		var eventSrc = evt.target || evt.srcElement;
		try{
			var obj=document.getElementById("mzzspan");
			obj.style.posLeft=document.body.scrollLeft+event.clientX;
		    obj.style.posTop=document.body.scrollTop+event.clientY;
		    if(obj.style.display=="none"){
		   		obj.style.display="block";
		   		eventSrc.innerText="隐藏操作说明";
		   	}else{
		   		obj.style.display="none";
		   		eventSrc.innerText="显示操作说明";
		   	}
	    }catch(e){}
	}
	function setfmid(obj){
		var str;
		str=obj.options[obj.selectedIndex].text;
		if(str.indexOf("[")!=-1)
			str=str.substring(str.lastIndexOf('[')+1,str.lastIndexOf(']'));
		else
			str=0;
		document.getElementsByName("abf.fmoduleid")[0].value=str;
	}
	function handwork(){
		var one=document.getElementById("link_one");
		var two=document.getElementById("link_two");
		var aclick=document.getElementById("aclick");
		two.style.display="";
		two.disabled=false;
		two.value="${abf.flink}";
		one.style.display="none";
		one.disabled=true;
		one.value="";
		aclick.innerText="下拉选择";
		aclick.onclick=handwork2;
		$('#qtid2').show();
	}
	function handwork2(){
		var one=document.getElementById("link_one");
		var two=document.getElementById("link_two");
		var aclick=document.getElementById("aclick");
		two.style.display="none";
		two.disabled=true;
		two.value="";
		one.style.display="";
		one.disabled=false;
		one.value="";
		aclick.innerText="手工输入";
		aclick.onclick=handwork;
		$('#qtid2').hide();
	}
</script>
<script type="text/javascript">
	var XMLHttpReq=false;
	//创建一个XMLHttpRequest对象
	function createXMLHttpRequest(){
		if(window.XMLHttpRequest){ //Mozilla 浏览器
			XMLHttpReq=new XMLHttpRequest();
		}
		else if(window.ActiveXObject){ //微软IE 浏览器
			try{
				XMLHttpReq=new ActiveXObject("Msxml2.XMLHTTP");//IE 6.0及6.0以上版本
			}catch(e){
				try{
					XMLHttpReq=new ActiveXObject("Microsoft.XMLHTTP");
				//IE 5.0版本
				}catch(e){}
			}
		}
	}
	//发送请求函数
	function send(url,functionName){
		createXMLHttpRequest();
		XMLHttpReq.open("GET",url,true);
		XMLHttpReq.onreadystatechange=functionName;//指定响应的函数
		XMLHttpReq.send(null);  //发送请求
	};
	function proce(){
		if(XMLHttpReq.readyState==4){
			if(XMLHttpReq.status==200){ //对象状态,信息已成功返回，开始处理信息
				var resText = XMLHttpReq.responseText;
				if(resText.split(",")[0]==1){
					meth1();
				}else if(resText.split(",")[0]==2){
					meth2();
					
					if(resText.split(",")[1].length>0){
						if(resText.split(",")[1]==1){
						 parent.location.reload();
						}else{
						window.location.href="/ais/system/omEdit.action?view=view&abf.ffunid="+resText.split(",")[1];
						}
					}
				}
			}else{
				showMessage1('请求页面出现异常');
			}
		}
	}
	function meth1(){
		showMessage1('请先将该节点的子类删除!');
	}
	function meth2(){
		showMessage1('删除成功!');
		//parent.menuLeft.location.reload();
	}
	<s:if test="${not empty (turnTo)}">
		${turnTo}
	</s:if>
</script>
</head>
<body style="overflow:hidden;">
	<div id="myTabs" class="easyui-tabs" fit="true" border="0" style="overflow:hidden" >
		<div title="基本信息" style="overflow:hidden;" >
			<s:form action="omSave" namespace="/system" >
				<table id="tab1"  align="center" class="ListTable" style='table-layout:fixed;'>
					<tr>
						<s:if test="%{view!='view'}">
							<td class="EditHead" nowrap="nowrap" style='width:150px;'>
								<font color="red">*</font>&nbsp;功能序号
							</td>
							<td class="editTd" nowrap>
								<s:if test="${empty (abf.ffunid)}">
									<input Class="noborder" type="text" name="abf.ffunid"
										value="${abf.fparentid}">
								</s:if>
								<s:else>
									<input Class="noborder" type="text" name="abf.ffunid" value="${abf.ffunid}"
										readonly="true">
								</s:else>
							</td>
						</s:if>
						<s:else>
							<td class="EditHead" nowrap="nowrap" style='width:150px;'>
								功能序号
							</td>
							<td class="editTd" nowrap>
								${abf.ffunid}
							</td>
						</s:else>


						<s:if test="%{view!='view'}">
							<td class="EditHead" nowrap="nowrap" style='width:150px;'>
								<font color="red">*</font>&nbsp;功能名称
							</td>
							<td class="editTd" nowrap>

								<s:textfield cssClass="noborder" name="abf.ffundisplay"></s:textfield>
							</td>
						</s:if>

						<s:else>
							<td class="EditHead" nowrap="nowrap" style='width:150px;'>
								功能名称
							</td>
							<td class="editTd" nowrap>
								${abf.ffundisplay}
							</td>
						</s:else>

					</tr>
					<tr>
						<s:if test="%{view!='view'}">
							<td class="EditHead" nowrap="nowrap" >
								<font color="red">*</font>&nbsp;父功能序号
							</td>
							<td class="editTd">

								<input type="text" name="abf.fparentid" Class="noborder"
									value="${abf.fparentid}">
							</td>
						</s:if>
						<s:else>
							<td class="EditHead"  nowrap="nowrap">
								父功能序号
							</td>
							<td class="editTd">
								${abf.fparentid}
							</td>
						</s:else>

						<s:if test="%{view!='view'}">
							<td class="EditHead"  nowrap="nowrap">
								<font color="red">*</font>&nbsp;父功能名称
							</td>
							<td class="editTd">

								<s:textfield cssClass="noborder" name="parentName" readonly="true"></s:textfield>
							</td>
						</s:if>
						<s:else>
							<td class="EditHead"  nowrap="nowrap">
								父功能名称
							</td>
							<td class="editTd">
								${parentName}
							</td>
						</s:else>
					</tr>

					<tr>
						<s:if test="%{view!='view'}">
							<td class="EditHead"  >
								<font color="red">*</font>&nbsp;打开方式
							</td>
							<td class="editTd">
								<select id="target" class="easyui-combobox" name="abf.target" style="width:150px;"  editable="false">
							   	    <option value="">&nbsp;</option>
							      	 <s:iterator value="#@java.util.LinkedHashMap@{'basefrm':'工作台','_blank':'新窗口'}" id="status">
										<s:if test="${abf.target==key}">
								       	 <option selected="selected" value="<s:property value="key"/>"><s:property value="value"/></option>
								       	</s:if>
								       	<s:else>
								         <option value="<s:property value="key"/>"><s:property value="value"/></option>
										</s:else>
								      </s:iterator>
							    </select>
							
							</td>
						</s:if>
						<s:else>
							<td class="EditHead"  >
								打开方式
							</td>
							<td class="editTd">
								<s:if test="${abf.target=='basefrm'}">工作台</s:if>
								<s:else>新窗口</s:else>
							</td>
						</s:else>

						<td class="EditHead"  >
							操作说明
						</td>
							<td class="editTd" >
							<a href="javascript:;" onclick="mshow()">显示操作说明</a>
						</td>

					</tr>
					<tr>
						<td class="EditHead"   nowrap="nowrap">
							链接地址
							<s:if test="%{view!='view'}">
								<a href="javascript:;" onclick="handwork();" id="aclick">手工输入</a>
							</s:if>
						</td>
						<td class="editTd" colspan='3'>
							<s:if test="%{view!='view'}">
                                <input type='hidden' id="frTemplateId" name="frTemplateId"/>
								<s:select id="link_one"  cssStyle="width:95%;"
									list="@ais.mainmenu.util.MenuUtil@getMenuList()"
									emptyOption="true" name="abf.flink" listKey="code"
									listValue="name" onchange="setfmid(this);"></s:select>
								<s:textfield name="abf.flink" display="false" disabled="true" cssClass="noborder" cssStyle='width:95%;'
									id="link_two"></s:textfield>
									<input type='hidden' class="noborder" id='qtid'/><img  id='qtid2' 
									style="display:none;cursor:hand;border:0"
									src="/ais/resources/images/s_search.gif" 
									alt='报表模板选择' 
									onclick="showSysTree(this,{
			                                  title:'报表模板选择',
											  param:{
												'whereHql':'status=\'1\'',
											  	'rootParentId':'1',
							                    'beanName':'ReportTemplateInfo',
							                    'treeId'  :'url',
							                    'treeText':'templateName',
							                    'treeParentId':'pid',
							                    'treeOrder':'uploadTime',
                                                'treeAtrributes':'id'
							                 },
			                                 onBeforeLoad:function(){
		                                	    $.post('<%=request.getContextPath()%>/commonPlug/synchronizeTemplate.action', function(data){
		                                	        //alert(data.type+'\n'+data.msg)
		                                	        if(data.type == 'error' && data.msg){
		                                	            $.messager.alert('提示信息',data.msg,'info');
		                                	        }														
		                                	    });
			                                 },
			                                 onAfterSure:flowReportWinOpen,
                                             onTreeClick:function(node,treeDom){
                                                 var attributes = node.attributes;
                                                 //alert(attributes)
                                                 if(attributes){
                                                    var json = jQuery.parseJSON(attributes);
                                                    $('#frTemplateId').val(json.id);
                                                 }
                                             }                             
									})"/>
									
							</s:if>
							<s:else>
								${abf.flink}
							</s:else>
						</td>
					</tr>
					<s:if test="${abf.fparentid eq '1'}">
						<tr>
							<td class="EditHead">
								子系统图标
							</td>
							<td class="editTd" colspan="3">
								<select name="abf.iconCls">
									<option value="gl" <s:if test="${abf.iconCls eq 'gl'}">selected="selected"</s:if>>审计管理系统</option>
									<option value="zx" <s:if test="${abf.iconCls eq 'zx'}">selected="selected"</s:if>>在线作业系统</option>
									<option value="jc" <s:if test="${abf.iconCls eq 'jc'}">selected="selected"</s:if>>决策支持系统</option>
									<option value="fx" <s:if test="${abf.iconCls eq 'fx'}">selected="selected"</s:if>>风险管理系统</option>
									<option value="nkpj" <s:if test="${abf.iconCls eq 'nkpj'}">selected="selected"</s:if>>内控评价系统</option>
									<option value="gc" <s:if test="${abf.iconCls eq 'gc'}">selected="selected"</s:if>>工程审计系统</option>
									<option value="sjfx" <s:if test="${abf.iconCls eq 'sjfx'}">selected="selected"</s:if>>数据分析系统</option>
									<option value="yujing" <s:if test="${abf.iconCls eq 'yujing'}">selected="selected"</s:if>>监控预警系统</option>
									<option value="system" <s:if test="${abf.iconCls eq 'system'}">selected="selected"</s:if>>系统管理</option>
									<option value="audCloud" <s:if test="${abf.iconCls eq 'audCloud'}">selected="selected"</s:if>>审友云</option>
								</select>
							</td>
						</tr>
					</s:if>
					<s:else>
						<tr>
							<td class="EditHead">
								菜单图标
							</td>
							<td class="editTd" colspan="3"><i style="font-size: 22px;" id="iconShow" class="${abf.iconCls }"/>&nbsp;&nbsp;
								<s:if test="${param.view ne 'view'}">
									<a class="easyui-linkbutton" data-options="iconCls:'icon-edit'" onclick="showIconWin();">更换</a>
								</s:if>
								<input type="hidden" id="menuIcons" name="abf.iconCls" value="${abf.iconCls }">
							</td>
						</tr>
					</s:else>
					<tr>
						<td class="EditHead">
							是否在审计作业显示
						</td>
						<td class="editTd" colspan="3">
							<s:if test="${param.view ne 'view'}">
								<s:if test="${abf.showInOnline eq 'Y'}">
									<input type="checkbox" value="Y" name="abf.showInOnline" checked/>
								</s:if>
								<s:else>
									<input type="checkbox" value="Y" name="abf.showInOnline"/>
								</s:else>
							</s:if>
							<s:else>
								<s:if test="${abf.showInOnline eq 'Y'}">
									<input type="checkbox" value="Y" name="abf.showInOnline" checked  disabled="disabled"/>
								</s:if>
								<s:else>
									<input type="checkbox" value="Y" name="abf.showInOnline" disabled="disabled"/>
								</s:else>
							</s:else>
						</td>
					</tr>
					<tr>
						<td class="EditHead"   colspan="1">
							使用帮助
						</td>
							<td class="editTd" colspan="3" style="text-align: left;">
							<s:if test="%{view!='view'}">
								<textarea class="noborder"  name="bfEx.content"
									style="width: 100%; height: 50px">${bfEx.content}</textarea>
							</s:if>
							<s:else>
								<textarea class="noborder"  readonly name="bfEx.content"
									style="width: 100%; height: 50px; color: #aca899;">${bfEx.content}</textarea>
							</s:else>
						</td>
					</tr>
				</table>
				<s:hidden name="abf.ffunvalue"></s:hidden>
				<s:hidden name="bfEx.id"></s:hidden>
				<s:hidden name="bfEx.bfUnvalue"></s:hidden>
				<input type="hidden" name="abf.fismenu" value="Y">
				<s:if test="${empty (abf.fmoduleid)}">
					<input type="hidden" name="abf.fmoduleid" value="0">
				</s:if>
				<s:else>
					<input type="hidden" name="abf.fmoduleid"
						value="${abf.fmoduleid}">
				</s:else>
				<div style="text-align:right;padding-top:10px;">
					<s:if test="%{view!='view'}">
						<a class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="divOneSave()">保存</a>&nbsp;&nbsp;
					</s:if>
					<s:if test="!${empty (abf.ffunid)}">
						<a class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="divOneAdd('${abf.ffunid}')">增加</a>&nbsp;&nbsp;
						<s:if test="%{view=='view'}">
							<a class="easyui-linkbutton" data-options="iconCls:'icon-edit'" onclick="divOneEdit('${abf.ffunid}')">修改</a>&nbsp;&nbsp;
						</s:if>
							<a class="easyui-linkbutton" data-options="iconCls:'icon-delete'" onclick="divOneDel('${abf.ffunid}')">删除</a>&nbsp;&nbsp;
						<s:if test="%{view!='view'}">
							<a class="easyui-linkbutton" data-options="iconCls:'icon-undo'" onclick="javascript:history.back()">返回</a>&nbsp;&nbsp;
						</s:if>
					</s:if>
				</div>
				<br>
				<div id="mzzspan" name="mzzspan"
					style="background-color: #dbdbdb; font-size: 12pt; color: #555; position: absolute; left: 200px; top: 120px; display: none">
					在添加子节点的时候,子节点的功能序号ID应该与父节点的功能序号PID存在相应的对应关系.
					<br>
					即ID=PID*100+NUM;其中num为PID*100~PID*101之间没有重复的数字
				</div>
			</s:form>
		</div>
		<s:if test="!${empty (abf.ffunid)}">
			<div title="动作节点" style="overflow: hidden;">
				<iframe id="oppNode"
					src=""
					frameborder="0" scrolling="yes"
					style="width: 100%; height: 100%;"></iframe>
			</div>
			<div title="节点调整" style="overflow: hidden;">
				<iframe id="chgNode"
					src=""
					frameborder="0" scrolling="yes"
					style="width: 100%; height: 100%;"></iframe>
			</div>
		</s:if>
	</div>
	
      <div id="flowReportWin" name="flowReportWin"  style='height:200px; '>
          <table cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
              <tr>
                  <td class="EditHead">审计单位</td>
                  <td class="editTd" >
                      <input type="text"  id="frf_orgName" name="frf_orgName"  class="noborder" readonly='readonly' style='width:80%'/>
                      <input type="hidden"  id="frf_orgId" name="frf_orgId" class="noborder"/><img  style="cursor:pointer;border:0"
                          src="/ais/resources/images/s_search.gif"
                          onclick="showSysTree(this,{
                                    title:'请选择报表审计单位',
                                    param:{
                                      'rootParentId':'0',
                                      'beanName':'UOrganizationTree',
                                      'treeId'  :'fid',
                                      'treeText':'fname',
                                      'treeParentId':'fpid',
                                      'treeOrder':'fcode'
                                   }                                  
                          })"/>
                  </td>
              </tr>
              <tr>
                  <td class="EditHead">审计年度</td>
                  <td class="editTd" >
                  		<s:select id="reportYear" 
                  		name="reportYear"  
	                    list="@ais.framework.util.DateUtil@getIncrementYearList(3,5)"  
	                    theme="ufaud_simple" 
	                    templateDir="/strutsTemplate"  />
                  </td>
              </tr>
          </table>
      </div>

	<!--一级菜单图标-->
	<div id="iconWin">
		<table cellpadding=0 cellspacing=0 border=0 align="center" id="iconTable" style="width: 98%;font-size: 22px;text-align: center;border-collapse: collapse;">
			<tr>
				<td><i class="icon-user" style="background: none;"/></td>
				<td><i class="icon-users"/></td>
				<td><i class="icon-speedometer"/></td>
				<td><i class="icon-screen-tablet"/></td>
				<td><i class="icon-screen-desktop"/></td>
				<td><i class="icon-trophy"/></td>
				<td><i class="icon-social-youtube"/></td>
				<td><i class="icon-social-dropbox"/></td>
				<td><i class="icon-social-dribbble"/></td>
				<td><i class="fa fa-database"/></td>
			</tr>
			<tr>
				<td><i class="icon-settings"/></td>
				<td><i class="icon-notebook"/></td>
				<td><i class="icon-graduation"/></td>
				<td><i class="icon-envelope-open"/></td>
				<td><i class="icon-envelope-letter"/></td>
				<td><i class="icon-mouse"/></td>
				<td><i class="icon-eyeglasses"/></td>
				<td><i class="icon-disc"/></td>
				<td><i class="icon-chemistry"/></td>
				<td><i class="icon-bell"/></td>
			</tr>
			<tr>
				<td><i class="icon-compass"/></td>
				<td><i class="icon-diamond"/></td>
				<td><i class="icon-directions"/></td>
				<td><i class="icon-docs"/></td>
				<td><i class="icon-drawer"/></td>
				<td><i class="icon-basket"/></td>
				<td><i class="icon-calculator"/></td>
				<td><i class="icon-bulb"/></td>
				<td><i class="icon-calendar"/></td>
				<td><i class="icon-graph"/></td>
			</tr>
			<tr>
				<td><i class="icon-globe-alt"/></td>
				<td><i class="icon-folder-alt"/></td>
				<td><i class="icon-globe"/></td>
				<td><i class="icon-layers"/></td>
				<td><i class="icon-grid"/></td>
				<td><i class="icon-question"/></td>
				<td><i class="icon-shuffle"/></td>
				<td><i class="icon-share-alt"/></td>
				<td><i class="icon-clock"/></td>
				<td><i class="icon-link"/></td>
			</tr>
			<tr>
				<td><i class="icon-home"/></td>
				<td><i class="icon-like"/></td>
				<td><i class="icon-list"/></td>
				<td><i class="icon-pie-chart"/></td>
				<td><i class="icon-share"/></td>
				<td><i class="icon-refresh"/></td>
				<td><i class="fa fa-internet-explorer"/></td>
				<td><i class="fa fa-area-chart"/></td>
				<td><i class="fa fa-bar-chart"/></td>
				<td><i class="fa fa-bank"/></td>
			</tr>
			<tr>
				<td><i class="icon-support"/></td>
				<td><i class="icon-eye"/></td>
				<td><i class="icon-folder"/></td>
				<td><i class="icon-flag"/></td>
				<td><i class="icon-star"/></td>
				<td><i class="fa fa-building-o"/></td>
				<td><i class="fa fa-warning"/></td>
				<td><i class="fa fa-users"/></td>
				<td><i class="fa fa-support"/></td>
				<td><i class="fa fa-road"/></td>
			</tr>
			<tr>
				<td><i class="icon-paper-plane"/></td>
				<td><i class="icon-target"/></td>
				<td><i class="icon-info"/></td>
				<td><i class="icon-link"/></td>
				<td><i class="icon-heart"/></td>
				<td><i class="fa fa-newspaper-o"/></td>
				<td><i class="fa fa-pencil-square-o"/></td>
				<td><i class="fa fa-thumbs-o-up"/></td>
				<td><i class="fa fa-tree"/></td>
				<td><i class="fa fa-line-chart"/></td>
			</tr>
		</table>
	</div>
      <script type="text/javascript">
          function flowReportWinOpen(dm, mc){
	          	$('#link_two').val(dm)
	          	//$('#flowReportWin').dialog('open');
	          	/**/
	          	$.messager.confirm('提示','此报表是否要配置工作流？',function(f){
	          		if(f){  
	                	$('#flowReportWin').dialog('open');
	          		}
	          	});        	
          }

	$(document).ready(function(){
		
		$('#reportYear').combobox({
			editable:false
		});

		/*('#flowReportWin').dialog({
            title:'报表所属信息',
	        closed:true,
	        modal:true,
	        width:600,
	        buttons:[{
	        	 text:"保存",
                 iconCls:'icon-save',
                 handler:function(){
                      var templateId = $('#frTemplateId').val();
                      if(templateId){
                          var reportUrl = $('#link_two').val();
                          //alert(reportUrl+"")
                          var orgName = $('#frf_orgName').val();
                          if(!orgName){
                        	  showMessage1("请选择审计单位");
                              $('#frf_orgId').next('img').trigger('click');
                              return;
                          }
                          var reportYear = $('#reportYear').combobox('getValue');
                          if(!reportYear){
                        	  showMessage1("请选择报表年度");
                              return;
                          }
                          var orgId = $('#frf_orgId').val();
                          $.post('${contextPath}/fr/report/flow/genFlowUrl.action',
                              {'templateId':templateId,
                               'reportUrl' :reportUrl,
                               'orgName':orgName,
                               'orgId'  :orgId,
                               'reportYear':reportYear
                              },
                              function(data){
                                  if(data.type == 'info'){
                                	  $('#link_two').val(data.flowFormUrl);
                                      $('#flowReportWin').dialog('close');
                                  }
                                  data.msg ? showMessage1(data.msg) : null;
                              })
                      }else{
                          showMessage1("参数错误，无法获得报表模板ID");
                      }
                 }
             },'-',{
                 text:'关闭',
                 iconCls:'icon-cancel',
                 handler:function(){
                	 $('#flowReportWin').dialog('close');
                 }
             },'-']
		});*/

		//菜单图标窗口
        $('#iconWin').dialog({
            title: '选择菜单图标',
            width: 800,
            height: 300,
            closed: true,
            modal: true
        });

        $('#iconTable').find('td').each(function(){
            $(this).attr('style','border: 1px solid #ccc;cursor:pointer;');
		});
        $('#iconTable').on('click','td',function(){
            var icon = $(this).children('i').attr('class');
            $('#iconShow').attr('class',icon);
            $('#menuIcons').val(icon);
            $('#iconWin').window('close');
		});
	});

          function showIconWin(){
              $('#iconWin').window('open');
		  }
</script>
</body>
</html>