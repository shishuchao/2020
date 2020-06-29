<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<html>
	<base target="_self">
	<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
		<title>上传督导项目底稿</title>
		<link href="<%=request.getContextPath()%>/styles/main/ais.css" rel="stylesheet"
			rel="stylesheet" type="text/css">
		<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
		<script type='text/javascript' src='${pageContext.request.contextPath}/scripts/turnPage.js'></script>
        <script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
		<style type="text/css">
			marquee {
			    border:        0px solid #bac5d1;
			    background:    #e7eef6;
			    /*height:        12px;*/
			    font-size:    1px;
			    margin:        1px;
			    /*width:        400px;*/
			    -moz-binding:    url("marquee-binding.xml#marquee");
			    -moz-box-sizing:    border-box;
			    display:        block;
			    overflow:        hidden;
			}
			marquee span {
			    height:            18px;
			    margin:            1px;
			    width:            6px;
			    background:        #2e7de4;
			    float:            left;
			    font-size:        1px;
			    font-color:black;
			}
			.progressBarHandle-0 {
			    filter:        alpha(opacity=20);
			    -moz-opacity:    0.20;
			}
			.progressBarHandle-1 {
			    filter:        alpha(opacity=40);
			    -moz-opacity:    0.40;
			}
			.progressBarHandle-2 {
			    filter:        alpha(opacity=60);
			    -moz-opacity:    0.6;
			}
			.progressBarHandle-3 {
			    filter:        alpha(opacity=80);
			    -moz-opacity:    0.8;
			}
			.progressBarHandle-4 {
			    filter:        alpha(opacity=100);
			    -moz-opacity:    1;    
			}
			.progressBarHandle-5 {
			    filter:        alpha(opacity=100);
			    -moz-opacity:    1.2;    
			}
			.progressBarHandle-6 {
			    filter:        alpha(opacity=100);
			    -moz-opacity:    1.4;    
			}
			.progressBarHandle-7 {
			    filter:        alpha(opacity=100);
			    -moz-opacity:    1.8;    
			}
			.progressBarHandle-8 {
			    filter:        alpha(opacity=100);
			    -moz-opacity:    2;    
			}
			.progressBarHandle-9 {
			    filter:        alpha(opacity=100);
			    -moz-opacity:    2.2;    
			}
	</style>
	</head>
	<script language="javascript">
    var flag=true;
    function savefile(){
        var uploadfileid = document.getElementsByName("guid")[0].value;
        var projectid = opener.window.document.getElementsByName("projectid")[0].value;
        var wppdid = "${param.wppid}";
        var rowindex="${param.rowIndex}";
        DWREngine.setAsync(false);
        DWREngine.setAsync(false);DWRActionUtil.execute(
        { namespace:'/workprogram', action:'saveUploadFileId', executeResult:'false' }, 
        {'projectid':projectid,'wppd_uploadfileid':uploadfileid,'wppd_id':wppdid},
        xxx);
        function xxx(data){
        	filename = data['fileName'].split(",");
            fileid = data['fileId'].split(",");
            retmessage=data['ret_message'];
        } 
        if(retmessage="ok"){
            alert("保存成功");
            flag=false;
            opener.editUploadFileUrl(rowindex,filename,fileid,projectid,uploadfileid);
        	self.close();    
        }else{
            alert("保存失败！");
        }
        
    }
    function savefileonunload(){
        if(flag){ 
        	var uploadfileid = document.getElementsByName("guid")[0].value;
            var projectid = opener.window.document.getElementsByName("projectid")[0].value;
            var wppdid = "${param.wppid}";
            var rowindex="${param.rowIndex}";
            DWREngine.setAsync(false);
            DWREngine.setAsync(false);DWRActionUtil.execute(
            { namespace:'/project', action:'saveUploadFileId', executeResult:'false' }, 
            {'project_id':projectid,'wppd_uploadfileid':uploadfileid,'wppd_id':wppdid},
            xxx);
            function xxx(data){
            	filename = data['fileName'].split(",");
                fileid = data['fileId'].split(",");
                retmessage=data['ret_message'];
            } 
            if(retmessage="ok"){
                flag=false;
                opener.editUploadFileUrl(rowindex,filename,fileid,projectid,uploadfileid);
            }else{filename[i]
                alert("保存失败！");
            }

        }
    }
    function selectFile(fileId,guid){
        var projectid = opener.window.document.getElementsByName("projectid")[0].value;
        //var wpd_stagecode = opener.window.document.getElementsByName("wpd_stagecode")[0].value;
        DWREngine.setAsync(false);
    	DWREngine.setAsync(false);DWRActionUtil.execute(
    		{ namespace:'/commons/file', action:'selectFile', executeResult:'false' }, 
    		{'fileId':fileId, 'guid':guid,'deletePermission':true,'isEdit':true},xxx);
    		function xxx(data){
    			//var ur = "/ais/workprogram/editWorkProgramProjectDetail.action?projectid="+projectid;
    			//url += "&wpd_stagecode="+wpd_stagecode;
    			opener.window.document.execCommand('refresh',false,0);
    			alert('已添加该文档到审计文书！');
    		} 
    }

    function deleteFile(fileId){
        if(confirm("是否删除这个文件？")){
            var url="${contextPath}/commons/file/delFile4wp.action?guid="+document.getElementsByName("guid")[0].value+"&fileId="+fileId+"&wppid=${param.wppid}&rowIndex=${param.rowIndex}";
            window.location=url;
        }
            
    }
	</script>
	<body onunload="savefileonunload()">
		<form name="tempForm" method="post">
	<s:hidden name="title"/>
	<s:hidden name="guid" />
	<s:hidden name="deletePermission" />
	<s:hidden name="isEdit" />
	<s:hidden name="fromCheckFile"/>
	<s:hidden id="onlyOne" name="onlyOne" />
	<s:hidden name="upload_id"/><!-- 附件上传人id -->
	<s:hidden name="upload_name"/><!-- 附件上传人name -->
	</form>
	
		<s:form action="saveFile4wpSupervision" method="POST" namespace="/commons/file"
			enctype="multipart/form-data" onsubmit="addUploadProssess();" id="uploadForm">
			<!-- 获取删除文件的权限 --- LIHAIFENG 2007-07-29 -->
			<s:hidden name="deletePermission" /><!-- 删除 -->
			<s:hidden name="isEdit" /><!-- 编辑 -->
			<s:hidden name="isEdit2" />
			<s:hidden name="fileId" />
			<s:hidden name="fromCheckFile"/><!-- 审计方案 -->
			<s:hidden name="title"/><!-- 标题 -->
			<s:hidden name="checkFileType"/><!-- 指定上传附件类型 -->
			<s:hidden name="sideRemark"/><!-- 侧边提示 -->
			<s:hidden name="upload_id"/><!-- 附件上传人id -->
			<s:hidden name="upload_name"/><!-- 附件上传人name -->
            <s:hidden name="wppid"/>
            <s:hidden name="rowIndex"/>
            
            <s:hidden name="table_name"/>
            <s:hidden name="talbe_guid"/>
			
			<!-- <s:file/>标志将文件上传控件绑定到Action的fileContent属性,
		     -->
			<s:fielderror />
			
			<table cellpadding=0 cellspacing=1 border=0 bgcolor="#409cce"
				class="ListTable" align="center">
				<tr class="listtablehead">
					<td colspan="4" align="left" class="edithead">
						&nbsp;上传督导项目底稿
						<s:if  test="title!=null &&　!fromCheckFile.equals('')">
						-<s:property  value="title" />
						</s:if>
					</td>
				</tr>
				 <s:if test="fromCheckFile==null||fromCheckFile.equals('')">
				<tr class="listtablehead">
					<td class="listtabletr2" align="right">
						<s:file label="上传附件" name="myfile" cssStyle="width:80%;font-size:12px"  /><%--
						&nbsp;单个附件&lt=10M
--%><%--  隐藏                   <s:if  test="sideRemark!=null">--%>
<%--                     <font color="red"><s:property value="sideRemark" /></font>--%>
<%--                     </s:if>--%>
						<s:hidden name="uploader_name" value="${uploader_name}" />
						</td>
				</tr>
				</s:if>
				<s:hidden  name="guid" />
				<!-- 限制只能上传一个附件 LIHAIFENG 2008-01-08 -->
				<s:hidden id="onlyOne" name="onlyOne" />
				<!-- 是否允许向父窗口回写附件列表 LIHAIFENG 2008-01-10 -->
				<s:hidden id="rewrite" name="rewrite" />
				<!-- 父页面可以自定义刷新附件列表javascript函数= -->
				<s:hidden id="parentReloadFunction" name="parentReloadFunction" />
			</table>
	<div align="center">
			<display:table name="fileList" id="row" class="its" pagesize="10"
				requestURI="/commons/file/welcome4wp.action" size="100%">
				<%-- 
				<display:column title="操作">
					<s:if test="${row.guid!=requestScope.guid}">
						<a href="javascript:;" onclick="selectFile('${row.fileId}','${guid}')">复制</a>
					</s:if>
				</display:column>
				 --%>
				<display:column property="fileName" title="附件名称" style="WHITE-SPACE: nowrap" headerClass="center" class="center" sortable="true"></display:column>
<%--				<display:column property="fileType" title="附件类型" sortable="true"></display:column>--%>
				<display:column property="fileTime" title="上传时间" style="WHITE-SPACE: nowrap" headerClass="center" class="center" sortable="true"></display:column>
				<display:column property="uploader_name" title="附件上传人" style="WHITE-SPACE: nowrap" headerClass="center" class="center" sortable="true"></display:column>
				<display:column property="fileEditTime" title="最后修改时间" style="WHITE-SPACE: nowrap" headerClass="center" class="center" sortable="true"></display:column>
				<display:column property="remark_name" title="最后修改人" style="WHITE-SPACE: nowrap" headerClass="center" class="center" sortable="true"></display:column>
			</display:table>
			</div>
			<br>
			<div align="center">
				<s:if test="%{fileList.size>=1&&onlyOne==true}">
				</s:if>
				<s:else>
					 <s:hidden name="checkUploadFlag" value="${fileList}"></s:hidden>
					 <s:button name="上 传" value="上 传" id="btnSub" onclick="uploadFiles(this)"></s:button>
				</s:else>
				&nbsp;
				<!-- 注明 初始化之前，确认按钮disabled设成true，不可使用-->
				<s:button name="okBnt" value="关 闭"
					onclick="self.close();" />
				&nbsp;	
			
                     <br><br>
                     <s:actionerror/>
                     <s:if  test="remark!=null">
                     <font color="red" id="fontTip"><s:property value="remark" /></font>
                     </s:if>
			</div>
			
			
		</s:form>
		
<div id="imgDiv" style="visibility : hidden; text-align: center;">
	<table width="100%" height="100%" border="0" style="height: 50px;border: 0px;width: 80%;">
			<tr>
				<td align="center">
					<center>
					<b><font color="#007fff">正在上传中，请稍候... ...</font></b>
					<marquee direction="right" scrollamount="8" scrolldelay="100">
					    <span class="progressBarHandle-0"></span>
					    <span class="progressBarHandle-1"></span>
					    <span class="progressBarHandle-2"></span>
					    <span class="progressBarHandle-3"></span>
					    <span class="progressBarHandle-4"></span>
					    <span class="progressBarHandle-5"></span>
					    <span class="progressBarHandle-6"></span>
					    <span class="progressBarHandle-7"></span>
					    <span class="progressBarHandle-8"></span>
					    <span class="progressBarHandle-9"></span>
					</marquee>
					</center>
				</td>
			</tr>
		</table>
</div>		
		
		
		
	</body>
</html>
<script>

function uploadFiles(){
	var listSize = document.getElementById("checkUploadFlag").value;
		if(listSize.length>2){
			alert("当前项目已经上传督导底稿，请先删除再进行上传操作");
			return false ; 
		}else{
			var uploadForm = document.getElementById("uploadForm") ;
			uploadForm.submit();
		}
}
function addUploadProssess(){
	document.all.btnSub.disabled=true;
	document.getElementById("imgDiv").style.visibility="visible";
	return true;
}
</script>

