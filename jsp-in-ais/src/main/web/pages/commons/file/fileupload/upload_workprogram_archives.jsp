<%-- <%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<html>
	<base target="_self">
	<head>
	<meta http-equiv="X-UA-Compatible" content="IE=5">
	<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
		<title>档案阶段--上传补充文书</title>
		<link href="<%=request.getContextPath()%>/styles/main/ais.css" rel="stylesheet"
			type="text/css">
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
    function savefileonunload(){
        if(flag){
       
        	var uploadfileid = document.getElementsByName("guid")[0].value;
            var project_id = opener.window.document.getElementsByName("project_id")[0].value;
            var wppdid = "${param.wppid}";
            var rowindex="${param.rowIndex}";
            DWREngine.setAsync(false);
            DWREngine.setAsync(false);DWRActionUtil.execute(
            { namespace:'/archives/workprogram/pigeonhole', action:'saveUploadFileId', executeResult:'false' }, 
            {'project_id':project_id,'uploadfile_id':uploadfileid,'wppda_id':wppdid},
            xxx);

            if(retmessage="ok"){
                flag=false;
                opener.editUploadFileUrl(rowindex,filename,fileid);
            }else{
            }
        }
    }
    function xxx(data){
    	filename = data['fileName'].split(",");
        fileid = data['fileId'].split(",");
        retmessage=data['ret_message'];
    } 
    function deleteFile(fileId){
        if(confirm("是否删除这个文件？")){
            var url="${contextPath}/commons/file/delFile4wparchives.action?deletePermission=true&guid="+document.getElementsByName("guid")[0].value+"&fileId="+fileId+"&wppid=${param.wppid}&rowIndex=${param.rowIndex}";
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
	
		<s:form action="saveFile4wpArchives" method="POST" namespace="/commons/file"
			enctype="multipart/form-data" onsubmit="addUploadProssess();">
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
			
			<!-- <s:file/>标志将文件上传控件绑定到Action的fileContent属性,
		     -->
			<s:fielderror />
			
			<table cellpadding=0 cellspacing=1 border=0 bgcolor="#409cce"
				class="ListTable" align="center">
				<tr class="listtablehead">
					<td colspan="4" align="left" class="edithead">
						&nbsp;档案阶段补充审计文档
						<s:if  test="title!=null &&　!fromCheckFile.equals('')">
						-<s:property  value="title" />
						</s:if>
					</td>
				</tr>
				 <s:if test="fromCheckFile==null||fromCheckFile.equals('')">
				<tr class="listtablehead">
					<td class="listtabletr2" align="right">
					 	<s:file label="上传附件" name="myfile" cssStyle="width:80%;font-size:12px;"  />
						<s:hidden name="uploader_name" value="${uploader_name}" /> 
						</td>
				</tr>
				</s:if>
				<s:hidden name="guid" />
				<!-- 限制只能上传一个附件 LIHAIFENG 2008-01-08 -->
				<s:hidden id="onlyOne" name="onlyOne" />
				<!-- 是否允许向父窗口回写附件列表 LIHAIFENG 2008-01-10 -->
				<s:hidden id="rewrite" name="rewrite" />
				<!-- 父页面可以自定义刷新附件列表javascript函数= -->
				<s:hidden id="parentReloadFunction" name="parentReloadFunction" />
			</table>
	<div align="center">
			<display:table name="fileList" id="row" class="its" pagesize="10"
				requestURI="/commons/file/welcome4wparchives.action" size="100%">
				<display:column property="fileName" title="附件名称" style="WHITE-SPACE: nowrap" headerClass="center" class="center" sortable="true"></display:column>
				<display:column property="fileTime" title="上传时间" style="WHITE-SPACE: nowrap" headerClass="center" class="center" sortable="true"></display:column>
				<display:column property="uploader_name" title="附件上传人" style="WHITE-SPACE: nowrap" headerClass="center" class="center" sortable="true"></display:column>
				<display:column property="fileEditTime" title="最后修改时间" style="WHITE-SPACE: nowrap" headerClass="center" class="center" sortable="true"></display:column>
				<display:column property="remark_name" title="最后修改人" style="WHITE-SPACE: nowrap" headerClass="center" class="center" sortable="true"></display:column>
                <display:column title="操作" class="center" headerClass="center">
					<a
						href='javascript:void(0);'
						onclick="javascript:deleteFile('${row.fileId}') " target="_self">删除</a>
				</display:column>
			</display:table>
			</div>
			<br>
			<div align="center">
				<s:if test="%{fileList.size>=1&&onlyOne==true}">
				</s:if>
				<s:else>
					  <s:submit name="上 传" value="上 传" id="btnSub"/>  
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


function addUploadProssess(){
	document.all.btnSub.disabled=true;
	document.getElementById("imgDiv").style.visibility="visible";
	return true;
}
 </script> --%>

	
	<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<html>
	<base target="_self">
	<head>
		<meta http-equiv="X-UA-Compatible" content="IE=5">
		<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
		<title>上传附件</title>
		<link href="${contextPath}/styles/default.css" rel="stylesheet" type="text/css" />
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet" rel="stylesheet" type="text/css">
		
	</head>
	<script type='text/javascript' src='${contextPath}/scripts/turnPage.js'></script>
	
	<script type="text/javascript" src="${contextPath}/scripts/swfload/swfupload.js"></script>
	<script type="text/javascript" src="${contextPath}/scripts/swfload/swfupload.queue.js"></script>
	<script type="text/javascript" src="${contextPath}/scripts/swfload/fileprogress.js"></script>
	<script type="text/javascript" src="${contextPath}/scripts/swfload/handlers.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/pages/introcontrol/util/jquery-1.7.1.min.js"></script>

	<body>
	<!-- 重载本页面使用 -->
	<a id="reload" href="" style="display:none"></a>

		<s:form action="saveFile" method="POST" namespace="/commons/file"
			enctype="multipart/form-data">
			<s:hidden name="deletePermission" /><!-- 删除 -->
			<s:hidden name="isEdit" /><!-- 编辑 -->
			<s:hidden name="isEdit2" />
			<s:hidden name="fileId" />
			<s:hidden name="fromCheckFile"/><!-- 审计方案 -->
			<s:hidden name="title"/><!-- 标题 -->
			<s:hidden name="checkFileType"/><!-- 指定上传附件类型 -->
			<s:hidden name="sideRemark"/><!-- 侧边提示 -->
			<s:fielderror />
			<table cellpadding=0 cellspacing=1 border=0 bgcolor="#409cce"
				class="ListTable" align="center">
				<tr class="listtablehead">
					<td colspan="4" align="left" class="edithead">
						
						<s:if  test="title!=null">
							&nbsp;<s:property  value="title" />
						</s:if>
						<s:else>
							&nbsp;文件列表
						</s:else>
					</td>
				</tr>
			<s:if test="fromCheckFile==null||fromCheckFile.equals('')">
				<tr class="listtablehead">
					<td class="listtabletr2" align="right">
						<div class="fieldset flash" id="fsUploadProgress" style="width: 100%">
							<span class="legend"></span>
						</div>
						<div>
							&nbsp;
							<span id="spanButtonPlaceHolder"></span>&nbsp;&nbsp; 
							<input id="uploadManual" type="button" value="开始上传" onclick=" swfu.startUpload();"
							  	style="border-color: black;height: 18;width: 58;background-image: url(${contextPath}/pages/commons/file/fileupload/button_zhang.PNG)" />
							 &nbsp;
							<input id="btnCancel" type="button" value="取消全部" onclick="swfu.cancelQueue();"  
								style="border-color: black;height: 18;width: 58;background-image: url(${contextPath}/pages/commons/file/fileupload/button_zhang.PNG)"/>
							</br><font color="red">提示：单个文件请小于30M</font>	
						</div>

					</td>
				</tr>
				</s:if>
			</table>
			<div align="center">
				<display:table name="fileList" id="row" class="its" pagesize="10"
					requestURI="/commons/file/welcome.action" size="100%">
					<display:column property="fileName" title="附件名称" style="WHITE-SPACE: nowrap" headerClass="center" class="center" sortable="true"></display:column>
					<display:column property="fileTime" title="上传时间" style="WHITE-SPACE: nowrap" headerClass="center" class="center" sortable="true"></display:column>
					<display:column property="uploader_name" title="附件上传人" style="WHITE-SPACE: nowrap" headerClass="center" class="center" sortable="true"></display:column>
					<display:column property="fileEditTime" title="最后修改时间" style="WHITE-SPACE: nowrap" headerClass="center" class="center" sortable="true"></display:column>
					<display:column property="remark_name" title="最后修改人" style="WHITE-SPACE: nowrap" headerClass="center" class="center" sortable="true"></display:column>
				 <display:column title="操作" class="center" headerClass="center">
					 <a
						href='javascript:void(0);'
						onclick="javascript:deleteFile('${row.fileId}') " target="_self">删除</a> 
				</display:column>
				</display:table>
			</div>
			<br>
			<div align="center">
                     <br><br>
                     <s:if  test="remark!=null">
                     <font color="red"><s:property value="remark" /></font>
                     </s:if>
			</div>
			
		</s:form>
	</body>
</html>

<script type="text/javascript">
		var swfu;
		window.onload = function() {
			var settings = {
				flash_url : "${contextPath}/scripts/swfload/swfupload.swf",			//设置绝对或者相对于此上传页面的完整URL，一旦SWFupload实例化以后，此设置不能再被修改。
				upload_url: "${contextPath}/commons/file/swfUploadFiles.action",	//pload_url设置接收的是一个绝对的或者相对于SWF文件的完整URL。推荐使用完整的绝对路径，以避免由浏览器和FlashPlayer修改了基准路径设置而造成的请求路径错误。
				post_params: {"guid" : "${guid}","table_name":"${table_name}","table_guid":"${table_guid}"},			//定义的是一个包含值对的object类型数据，每个文件上传的时候，其中的值对都会被一同发送到服务端。
				use_query_string : false,		//post_params定义的是一个包含值对的object类型数据，每个文件上传的时候，其中的值对都会被一同发送到服务端。
				requeue_on_error : false,		//该属性可选值为true和false。如果设置为true，当文件对象发生uploadError时（除开fileQueue错误和FILE_CANCELLED错误），该文件对象会被重新插入到文件上传队列的前端，而不是被丢弃。如果需要，重新入队的文件可以被再次上传。如果要从上传队列中删除该文件对象，那么必须使用cancelUpload方法。
				
				file_size_limit : "30 MB",						//设置文件选择对话框的文件大小过滤规则，该属性可接收一个带单位的数值，可用的单位有B,KB,MB,GB。如果忽略了单位，那么默认使用KB。特殊值0表示文件大小无限制。
				file_types : "*.doc;*.docx;*.xls;*.xlsx;*.rar;*.zip;*.pdf;*.jpg;*.png;*.bmp",								//设置文件选择对话框的文件类型过滤规则，该属性接收的是以分号分隔的文件类型扩展名，例如“ *.jpg;*.gif”，则只允许用户在文件选择对话框中可见并可选jpg和gif类型的文件。默认接收所有类型的文件。
				file_types_description : "All Files",			//设置文件选择对话框中显示给用户的文件描述。
				file_upload_limit : 100,		//设置SWFUpload实例允许上传的最多文件数量，同时也是设置对象中file_queue_limit属性的上限。一旦用户已经上传成功或者添加文件到队列达到上最大数量，那么就不能继续添加文件了。特殊值0表示允许上传的数量无限制。只有上传成功（上传触发了uploadSuccess事件）的文件才会在上传数量限制中记数。使用setStats方法可以修改成功上传的文件数量。
				file_queue_limit : 0,			//设置文件上传队列中等待文件的最大数量限制。当一个文件被成功上传，出错，或者被退出上传时，如果文件队列中文件数量还没有达到上限，那么可以继续添加新的文件入队，以顶替该文件在文件上传队列中的位置。如果允许上传的文件上限（file_upload_limit）或者剩余的允许文件上传数量小于文件队列上限（file_queue_limit），那么该值将采用这个更小的值。
				file_post_name:"myfile",		//加了这个，在webwork的action中要用
				custom_settings : {			
					progressTarget : "fsUploadProgress",			
					cancelButtonId : "btnCancel"
				},			
				debug: false,					//该值是布尔类型，设置debug事件是否被触发。

				// Button settings
				button_image_url: "${contextPath}/images/button_70x18.png",			//该按钮图片需要经过一定规则（CSS Sprite）的处理。按钮图片中需要包括按钮的4个状态，从上到下依次是normal, hover, down/click, disabled.(可以参照官方demo中的图片)
				button_width: "70",				//设置该SWF的宽度属性。
				button_height: "20",			//设置该SWF的高度属性
				button_placeholder_id: "spanButtonPlaceHolder",						//该必要参数指定了swfupload.swf将要替换的页面内的DOM元素的ID值。当对应的DOM元素被替换为SWF元素时，SWF的容器会被添加一个名称为"swfupload"的样式选择器供CSS自定义使用。
				button_text: '<span class="theFont">浏&nbsp;	&nbsp;&nbsp;览</span>',	//该属性设置Flash Button中显示的文字，支持HTML。HTML文本的样式可以通过CSS选择器并配合button_text_style参数来设置。
				button_text_style: ".theFont { font-size: 12; border-color: black;}",					//默认值："color: #000000; font-size: 16pt;"(v2.2.0新增)此参数配合button_text参数，可以通过CSS样式来设置Flash Button中的文字样式。
				button_text_left_padding: 9,										//设置Flash Button上文字距离左侧的距离，可以使用负值。
				button_text_top_padding: 0,			
				
				// The event handler functions are defined in handlers.js
				file_queued_handler : fileQueued,					//当文件选择对话框关闭消失时，如果选择的文件成功加入上传队列，那么针对每个成功加入的文件都会触发一次该事件（N个文件成功加入队列，就触发N次此事件）。
				file_queue_error_handler : fileQueueError,			//当选择文件对话框关闭消失时，如果选择的文件加入到上传队列中失败，那么针对每个出错的文件都会触发一次该事件(此事件和fileQueued事件是二选一触发，文件添加到队列只有两种可能，成功和失败)。文件添加队列出错的原因可能有：超过了上传大小限制，文件为零字节，超过文件队列数量限制，设置之外的无效文件类型。具体的出错原因可由error code参数来获取，error code的类型可以查看SWFUpload.QUEUE_ERROR中的定义。
				upload_start_handler : uploadStart,					//在文件往服务端上传之前触发此事件，可以在这里完成上传前的最后验证以及其他你需要的操作，例如添加、修改、删除post数据等。在完成最后的操作以后，如果函数返回false，那么这个上传不会被启动，并且触发uploadError事件（code为ERROR_CODE_FILE_VALIDATION_FAILED），如果返回true或者无返回，那么将正式启动上传。
				upload_progress_handler : uploadProgress,			
				upload_error_handler : uploadError,			
				upload_success_handler : uploadSuccess,			
				upload_complete_handler : uploadComplete,		
				queue_complete_handler : function(){
					
					window.document.getElementById("reload").href = window.location.href;
					reload.click();
				}
			};
			swfu = new SWFUpload(settings);	
			reloadParentFileList();
	     };
	     //刷新父页面附件列表
	     function reloadParentFileList(){
	     	var parent = window.dialogArguments;
	     	if(parent.document.getElementById("accelerys")!=null){
	     		
				parent.document.getElementById("accelerys").innerHTML='${accessoryList}';
			}
	     }
	    function deleteFile(fileId){
	         if(confirm("是否删除这个文件？")){
	             var url="${contextPath}/commons/file/delFile4wparchives.action?deletePermission=true&guid=${guid}&fileId="+fileId+"&wppid=${param.wppid}&rowIndex=${param.rowIndex}";
	             window.location=url;
	             window.opener.location.href = window.opener.location.href;
	         } 
	             
	     }  
	    function uploadComplete(){   
	    	  window.opener.location.href = window.opener.location.href;
	      
	    }   
	</script>
	
	