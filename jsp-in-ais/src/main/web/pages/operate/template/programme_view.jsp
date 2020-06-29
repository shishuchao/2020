<!DOCTYPE HTML >
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<s:text id="title" name="'方案查看'"></s:text>
<html>

	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title><s:property value="#title" />
		</title>
		<s:head />


		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
		<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script> 
		<script type="text/javascript" src="${contextPath}/resources/csswin/subModal.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/calendar.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
		<script type="text/javascript" src="${contextPath}/scripts/base64_Encode_Decode.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>  
	<script type="text/javascript">

	/**
	 * 实施作业
	 */
	function sszy(){
		 
		var h = window.screen.availHeight;
		var w = window.screen.width;
	 
				check="1";
				var num=Math.random();
				var rnm=Math.round(num*9000000000+1000000000);
				win = window.open('${contextPath}/operate/task/mainReadyEdit.action?project_id=${project_id}','ready',',"height=768,width=1024,status=no,toolbar=no,menubar=no,location=no,resizable=no');
				//win = window.open('<%=request.getContextPath()%>/pages/operate/index.jsp?project_id='+projectCodeRadios[i].value,'cw11',',"height='+h+',width='+w+',status=yes,toolbar=yes,menubar=yes,location=yes,resizable=yes');
				win.moveTo(0,0)   
				win.resizeTo(w,h) 
				if(win && win.open && !win.closed) 
                  win.focus();
	}
	
 
function goedit(){
//返回上级list页面
	location.href='${contextPath}/operate/template/relistAll.action?project_id=${project_id}';

}
function goedit2(){
//返回上级list页面
	//window.open('${contextPath}/operate/task/mainReadyEdit.action?project_id=${project_id}');
	sszy()

}

function goView2(){
	var flag='${flag}';
	var temp ='${contextPath}/operate/task/mainReadyView.action?project_id=${project_id}';
		if(flag == 'yes'){
			parent.parent.goMenu('实施方案查看',temp,'2');
		}else{
			window.parent.addTab('tabs','实施方案查看 ','tempframe',temp,true);
		}
}

function goedit3(){
//返回上级list页面
	var title="保存至方案模板库";
    showPopWin('${contextPath}/operate/task/generate.action?project_id=${project_id}',500,300,title);
    
    
}
	function goedit6(){
        var flag='${flag}';
        var temp = '${contextPath}/operate/task/project/showContentTypeWorkView.action?project_id=${project_id}&view=view';
        if(flag == 'yes'){
            parent.parent.goMenu('审计分工',temp,'2');
        }else{
            window.parent.addTab('tabs','审计分工 ','tempframe',temp,true);
        }
	}
function goedit4(){
//返回上级list页面
	location.href='${contextPath}/operate/doubt/exportTask.action?project_id=${project_id}';//

}

function export2word(){
    //var _url = "${contextPath}/commons/oaprint/manuTemplateList.action?moduleid=EnforceTemplate&projectId=${project_id}";
    
    var url ='${contextPath}/commons/oaprint/exportEnforeTemplate.action?moduleid=EnforceTemplate&projectId=${project_id}';
    location.href=url;
}
        

jQuery(document).ready(function(){
    jQuery.ajax({
        url:'${contextPath}/project/prepare/isMyProjectEdit.action',
        type:'POST',
        data:{"crudId":'${project_id}'},
        dataType:'json',
        success:function(data){
			 if(data.role == 0) {
				 if('${param.view}' != 'view'){
					 document.getElementById("auditlabor").style.display = "none";
					 document.getElementById("generation").style.display = "none";
					 document.getElementById("saveGenerate").style.display = "none";
				 }
			}	

			 
			 if(data.formState == 1){
				 document.getElementById("auditlabor").style.display = "none";
				 document.getElementById("generation").style.display = "none";
				 document.getElementById("saveGenerate").style.display = "none";

			}else if(data.formState == 2||data.formState == 4 ){ 
				$("#saveGenerate").hide();
			}else if(data.formState == 6&&'${param.view}' != 'view'){
				 document.getElementById("saveGenerate").style.display = "";
				 document.getElementById("auditlabor").style.display = "";
				 document.getElementById("generation").style.display = "";

			}
        },
        error:function(){
        }
    });
    
    
     $('#sendBack_div').window({   
            width:400,   
            height:150,   
            modal:true,
            collapsible:false,
            maximizable:false,
            minimizable:false,
            closed:true
     });
      $('#saveGenerate').bind('click',function(){
            $('#sendBack_div').window('open');
      });
    // 关闭录入窗口
    $('#closeWinSjyd').bind('click',function(){
        $('#sendBack_div').window('close');
    })	

    // 保存方案库 
    $('#sendId').bind('click',function(){
        if(document.getElementById("title").value.replace(/\s+$|^\s+/g,"")==""){
            top.$.messager.alert('警告',"请输入保存方案名称!","error");
            return false;
        }
        $.ajax({
            dataType:'json',
            url : "<%=request.getContextPath()%>/operate/task/generateTemplate.action",
            data:{
                "project_id":'${project_id}',
                "taskInstanceId":'${taskInstanceId}',
                "ppFormId":'${crudId}',
                "title"   :$('#title').val()
            },
            type: "POST",
            success: function(data){
                if(data.type == 'success'){
                    $('#sendBack_div').window('close');
                    $.messager.show({
                        title:'保存成功',
                        msg:'对话框将在5秒后关闭。',
                        timeout:5000,
                        showType:'slide'
                    });
                }
            },
            error:function(data){
                $('#sendBack_div').window('close');
                $.messager.alert('提示信息','保存失败！','error');
            }
        });
    }) 
});

//根据实施方案模板导出实施方案
function zip(){        	
	//判断模板数量
    jQuery.ajax({
			url:'${contextPath}/operate/manuExt/pandManuTem.action?type=enforceTemplate&project_id=${project_id}',
			type:'POST',
			dataType:'text',
			async:false,
			success:function(data){
				if(data == 2) {
					// 初始化生成表格
					$('#templateList').datagrid({
						url : "<%=request.getContextPath()%>/operate/manuExt/reportTemplateList.action?type=enforceTemplate&project_id=${project_id}",
						method:'post',
						showFooter:false,
						rownumbers:true,
						striped:true,
						autoRowHeight:false,
						fit: true,
						fitColumns:true,
						idField:'id',
						border:false,
						singleSelect:true,
						remoteSort: false,
						columns:[[
							{field:'name',
								title:'模板名称',
								width:200,
								halign:'center',
								align:'left',
								sortable:true
							},
							{field:'operate',
								title:'操作',
								width:100,
								align:'center',
							    formatter:function(value,row,index){
							    	var link = '<a href=\"javascript:void(0);\" onclick=\"expManu(\''+row.templateId+'\')">导出</a>';
									return link;
								}
							}
						]]
					});

					$('#templateWindow').window({
						title:'选择实施方案模板',
						width:600,
						height:400,
						modal:true,
						collapsible:false,
						maximizable:true,
						minimizable:false
					});
				}else if(data == 0){
					showMessage1('请维护对应的模板！');
				}else{
					expManu(data);
				}
			},
			error:function(){
				showMessage1('出错啦！');
			}
});
}

	function expManu(templateId){
	 	$("#dx").attr("src","");
	 	var uniterm_url = "${contextPath}/project/prepare/exportEnforeTemplate.action?&crudId=${crudId}&project_name=${crudObject.project_name}&project_id=${crudObject.project_id}&templateId="+templateId;
	 	$("#dx").attr("src",uniterm_url); 
	 	var obj = document.getElementById("dx").contentWindow;
		var intervalTime = 100;
		var intervalCount = 0;
		var intervalMaxCount = 50;
		var intervalObj = window.setInterval(function(){
			try{	   				
   			//alert("intervalCount = "+intervalCount+","+intervalMaxCount);
   			var msg = "";
   			var isSuccess = false;
   			var sucFlag = obj.document.getElementById("sucFlag");
   			//alert('sucFlag='+sucFlag);
   			if(sucFlag && sucFlag.value.toLowerCase() == "success_save"){
   				clearInterval(intervalObj);
   				msg = "success_save";
   				isSuccess = true;
   				//alert(msg);
   				intervalCount = null;
   			}
   			
   			if(intervalCount > intervalMaxCount){
   				clear(intervalObj);
   				msg = "导出文件等待超时！";
   				//alert(msg)
   				intervalCount = null;
   			}
   			
   			if(isSuccess){
   				//alert(msg)
   				exportZipFile();
   			}else{
   				if(null!=msg&&""!=msg){
   					alert(msg);
   				}
   			}
   			
   			intervalCount++;
			}catch(e){
				clear(intervalObj)
				//alert('interval:'+e.message);
			}
		}, intervalTime);
		
		function clear(intervalObj){
			intervalObj ? clearInterval(intervalObj) : null;
		}
		
		function exportZipFile(){
		 $("#templateWindow").window({"onOpen":function(){
			 $("#templateWindow").window('close');
		 }}); 
		 $.ajax({
			url:"${contextPath}/operate/doubt/outZip.action",
			data:{"project_id":'${project_id}',"templateId":templateId},
			type: "post",
			async:false,

			success:function(data){
				if(data != 'NO'){
					var url="${contextPath}/operate/doubt/exportFileZip.action?project_id=" + '${crudObject.project_id}' + "&tempZipName=" +data;
    				document.location.href=url;
				}else{
					var url = "${contextPath}/operate/doubt/deleteTempZip.action";
					document.location.href=url;
				}
			},
			error:function(){
			}
		});
		}
}
</script>
</head>
	<body style="overflow:hidden;">
	
			<s:form id="myform" action="view" namespace="/mng/train/train">
				<div align="left" id="iszuyuan" style='padding:10px 0px 0px 5px; text-align:left;'>
					<s:hidden name="audProgramme.project_id" />
					
					<div align='left'>
					<!-- <a href="javascript:void(0);"   class="easyui-linkbutton" data-options="iconCls:'icon-export'" onclick="export2word()">导出Word<a/>&nbsp;&nbsp;
                    <a href="javascript:void(0);"   class="easyui-linkbutton" data-options="iconCls:'icon-export'" onclick="goedit4()">导出Excel<a/>&nbsp;&nbsp; -->
                    <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-export'" id="exportZIP" onclick="zip()">导出ZIP</a>&nbsp;
						<%-- <s:button value="导出方案" onclick="goedit4()" />
						&nbsp;&nbsp; --%>
						<%
							String view = request.getParameter("view");
							if(!"view".equals(view)){
								
						%>
						<a href="javascript:void(0);"  class="easyui-linkbutton"  data-options="iconCls:'icon-save'"  id="saveGenerate">保存至方案模板库<a/>
						&nbsp;&nbsp;
						<a href="javascript:void(0);"  class="easyui-linkbutton"  data-options="iconCls:'icon-group'"  id="auditlabor"  onclick="goedit6()">审计分工<a/>
						<s:if test="${prepare_closed != 1 }">
							&nbsp;&nbsp;
							<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-edit'" id="generation"  onclick="goedit()">重新生成<a/>
						</s:if>	
						<%} %>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					</div>
					<div align="center">
						<jsp:include flush="true" page="/pages/bpm/list_taskinstanceinfo.jsp" />
					</div>
					
				</div>

				<table 
					class="ListTable">
					<tr >
						<td style="width: 15%" class="EditHead">
							方案名称
						</td>
						<td  class="editTd" style="width: 85%" COLSPAN="3">
							<a href="javascript:void(0);" onclick="goView2()"><s:property
									value="audProgramme.programmeName" />
							</a>
						</td>
					</tr>


					<tr >
						<td style="width: 15%" class="EditHead">
							方案类别
						</td>
						<td  class="editTd" style="width: 35%">
							<s:property value="audProgramme.typeName" />
						</td>

						<td style="width: 15%" class="EditHead">
							方案版本
						</td>
						<td  class="editTd" style="width: 35%">
							<s:property value="audProgramme.proVer" />
						</td>
					</tr>


					<tr >
						<td class="EditHead">
							编制人
						</td>
						<td  class="editTd">
							<s:property value="audProgramme.proAuthorName" />
						</td>

						<td class="EditHead">
							编制日期
						</td>
						<td  class="editTd">
							<s:property value="audProgramme.proDate" />
						</td>
					</tr>
				</table>

			</s:form>
			<div id="sendBack_div" title="保存方案" style='overflow:hidden;padding:0px;'>
				<s:form id="sendBackForm" action="generateTemplate" namespace="/operate/task" method="post" >
					<table class="ListTable" align="center" >
						<tr>
							<td align="left" class="EditHead">
								方案名称
							</td>
							<td class="editTd">
								<s:textfield name="title" id ="title" cssStyle="width:160px;"/>
							</td>
							 <s:hidden name="project_id"/>
							 <s:hidden name="taskInstanceId"/>
							 <s:hidden name="ppFormId" value="${crudId}" />
						</tr>
					</table>
				</s:form>
				<input type="hidden" name="s" id="s" value="${s}"/>
				<div style='text-align:center;' id='exportBtnDiv' style='padding:10px;'>
	        		<button  id='sendId'  class="easyui-linkbutton"  iconCls="icon-save">保存</button>&nbsp;&nbsp;&nbsp;&nbsp;
	        		<button  id='closeWinSjyd' class="easyui-linkbutton"  iconCls="icon-cancel">关闭</button>							        
			    </div>
		</div>
		
		<div id="templateWindow">
			<table id="templateList"></table>
		</div>
		<iframe id="dx" src="" style="display:none;"></iframe>
	</body>
</html>
