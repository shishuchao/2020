<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<jsp:directive.page import="ais.framework.util.UUID"/>
<%
    response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
    response.setHeader("Pragma", "no-cache"); //HTTP 1.0
    response.setDateHeader("Expires", 0); //prevents caching at the proxy server
%>
<!DOCTYPE HTML>
<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <title>审计项目档案文件列表</title>
    <link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css"/>
    <link href="<%=request.getContextPath()%>/resources/css/common.css" rel="stylesheet" type="text/css" />
    
    <script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
    <script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
    <script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
    <script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
    <script type="text/javascript" src="${contextPath}/resources/js/jquery-fileUpload.js"></script>
    <script type="text/javascript" src="${contextPath}/pages/tlInteractive/tlInteractiveCommon.js"></script>
    
    
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/createOrgTree.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/common.js"></script>



    <script language="javascript">

        function editwppd(wppdid, wppdupid, index, ledgernode) {
            var bObject = event.srcElement;
            var tdObject = bObject.parentNode;
            var trObject = tdObject.parentNode;
            var archives_redfile = '<s:property escape="false" value="@ais.workprogram.util.WorkprogramConstant@ARCHIVES_REDFILE"/>'
            var guid = "";
            if (wppdupid) {
                guid = wppdupid;
            } else {
                guid = "<%=new UUID().toString()%>" + index;
            }

            var num = Math.random();
            var rnm = Math.round(num * 9000000000 + 1000000000);//随机参数清除模态窗口缓存
            if (ledgernode != null && archives_redfile == ledgernode) {

                window.open('${contextPath}/commons/file/welcome4wparchives.action?table_name=mng_aud_wp_pro_arch&table_guid=uploadfile_id&guid=' + guid + '&param=' + rnm + '&deletePermission=true&wppid=' + wppdid + "&rowIndex=" + trObject.rowIndex, '', 'toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no');
            } else {
                var viewUrl = '${contextPath}/commons/file/welcome4wparchives.action?table_name=mng_aud_wp_pro_arch&table_guid=uploadfile_id&guid=' + guid + '&param=' + rnm + '&deletePermission=true&wppid=' + wppdid + "&rowIndex=" + trObject.rowIndex;
                $('#toUpload').attr("src", viewUrl);
                $('#upload').window('open');
            }
        }

        function editUploadFileUrl(rowIndex, filename, fileid) {
            var trObject = document.getElementById("archivesdetailTable").rows(rowIndex / 1);
            var fileurl = "";
            for (var i = 0; i < filename.length; i++) {
                fileurl += "<a href='${contextPath}/commons/file/downloadFile.action?fileId=" + fileid[i] + "'>" + filename[i] + "</a><br/>"
            }
            if (trObject.cells.length == 6) {
                trObject.cells(4).innerHTML = fileurl;
            } else {
                trObject.cells(3).innerHTML = fileurl;
            }
        }

        /*
         * 导出档案文件zip
         */
        function exportArchivesZip(project_id) {
            document.getElementById("layerCenter").style.display = "none";
            document.getElementById("layer").style.display = "";

            DWREngine.setAsync(false);
            DWREngine.setAsync(false);
            DWRActionUtil.execute({
                    namespace: '/archives/workprogram/pigeonhole',
                    action: 'outZip',
                    executeResult: 'false'
                },
                {'project_id': project_id}, xxx);

            function xxx(data) {
                var tempZipName = data["tempZipName"];
                if (tempZipName != 'NO') {
                    var url = "${contextPath}/archives/workprogram/pigeonhole/exportFileZip.action?project_id=" + project_id + "&tempZipName=" + tempZipName;
                    document.location.href = url;
                    document.getElementById("layerCenter").style.display = "";
                    document.getElementById("layer").style.display = "none";
                } else {
                    alert("文件压缩失败!");
                    DWREngine.setAsync(false);
                    DWREngine.setAsync(false);
                    DWRActionUtil.execute({
                            namespace: '/archives/workprogram/pigeonhole',
                            action: 'deleteTempZip',
                            executeResult: 'false'
                        },
                        {'tempZipName': tempZipName}, xx);
                }

            }

            function xx() {
            }
        }

        /**
         * 部分导出文件zip
         */
        function exportArchivesZipByCh() {

            var fileIds = document.getElementsByName("fileIds")
            var fileIdsString = [];
            if (fileIds != null && fileIds.length > 0) {
                for (var i = 0; i < fileIds.length; i++) {
                    if (fileIds[i].checked) {
                        fileIdsString.push(fileIds[i].value);
                    }
                }
            }
            if ( fileIdsString.length == 0 ){
            	showMessage1('请选择一条记录！');
				return false;
            }
            $.ajax({
                url: '${contextPath}/archives/workprogram/pigeonhole/sjAndZgReportExportZip.action?sjAndZgIds=' + fileIdsString + '&' + new Date().getTime(),
                dataType: 'json',
                method: 'post',
                async: false,
                success: function (data) {
                    var tempZipName = data["tempZipName"];
                    if (tempZipName != 'NO') {
                        var url = "${contextPath}/archives/workprogram/pigeonhole/batchExportFilesjAndZgZip.action";
                        document.location.href = url;
                    } else {
                        $.messager.show({
                            title: '提示信息',
                            msg: '文件压缩失败!',
                            timeout: 5000,
                            showType: 'slide'
                        });
                    }
                }

            })


        }


        /**
         *删除上传文件
         */
        function deleteArchives() {

            var fileIds = document.getElementsByName("fileIds")
            var fileIdsString = [];
            if (fileIds != null && fileIds.length > 0) {
                for (var i = 0; i < fileIds.length; i++) {
                    if (fileIds[i].checked) {
                        fileIdsString.push(fileIds[i].value);
                    }
                }
            }
            if ( fileIdsString.length == 0 ){
            	showMessage1("请选择一个记录删除！");
            	return false;
            }
        	top.$.messager.confirm('确认对话框', '确认删除吗？请确认!', function(r){
				if (r){
					
		            $.ajax({
		                url: '${contextPath}/commonPlug/deleteFiles.action?fileIds=' + fileIdsString + '&' + new Date().getTime(),
		                dataType: 'json',
		                method: 'post',
		                async: false,
		                success: function (data) {
		                    if (data.msg.search("成功") == -1) {
		                        $.messager.show({
		                            title: '提示信息',
		                            msg: '删除失败!',
		                            timeout: 5000,
		                            showType: 'slide'
		                        });
		                        window.location.reload();

		                    } else {
		                        $.messager.show({
		                            title: '提示信息',
		                            msg: '删除成功!',
		                            timeout: 5000,
		                            showType: 'slide'
		                        });

		                        window.location.reload();
		                    }

		                }

		            })
				  }
				})


        }

    </script>
<body style="overflow:auto;">
<div style="position:fixed;width: 100%;background-color:#FFFFFF;top: 0px;" >
<%-- <div >
         <table id="dg">
         
         
         </table>  
         <div id="tb" >
      <a class="easyui-linkbutton" data-options="iconCls:'icon-export',plain:true"
           onclick="exportArchivesZipByCh()">导出</a>&nbsp;&nbsp;
            <s:if test="${editFile == 'view'}">
            </s:if>
            <s:else>
               <a class="easyui-linkbutton" data-options="iconCls:'icon-delete',plain:true"
                onclick="deleteArchives()">删除</a>&nbsp;&nbsp;
            </s:else>

        <s:if test="${taskInstanceId!=null&&taskInstanceId>0}">
         <s:if test="${editFile == null && editFile == ''}">
             <a class="easyui-linkbutton" data-options="iconCls:'icon-undo',plain:true"
               onclick="this.style.disabled='disabled';window.location.href='${contextPath}/portal/simple/simple-firstPageAction!show.action'">返回</a>&nbsp;&nbsp;
         </s:if>

        </s:if>
        <s:else>
         <s:if test="${editFile == null || editFile == ''}">
                     <s:if test="backURL != null && backURL != ''">
                <a class="easyui-linkbutton" data-options="iconCls:'icon-undo',plain:true" onclick="backURLFun();">返回</a>&nbsp;&nbsp;
            </s:if>
            <s:else>
                <a class="easyui-linkbutton" data-options="iconCls:'icon-undo',plain:true"
                   onclick="javascript:history.go(-1);">返回</a>&nbsp;&nbsp;
            </s:else>
         </s:if>
        </s:else> 
      </div>
    </div> --%>
  <table cellpadding=0 cellspacing=0 border=0 align="center"  class="ListTable" style="margin-top: 5px;">
   <colgroup>
       <col style="width: 15%;"  />
      <col style="width: 15%;" />
      <col style="width: 10%;" />
      <col style="width: 15%;" />
      <col style="width: 25%;" />
       <s:if test="${editFile != 'view'}">
        <col style="width: 20%;"  />
       </s:if>
     
    </colgroup>
  
      <thead>
        <tr>
            <th style="text-align: center" class="EditHead">审计阶段</th>
            <th style="text-align: center" class="EditHead">流程节点</th>
            <th style="text-align: center" class="EditHead" nowrap="nowrap">是否必做</th>
            <th style="text-align: center" class="EditHead">文件类型</th>
            <th style="text-align: center" class="EditHead tdHead" nowrap="nowrap">审计文书</th>
              <s:if test="${editFile != 'view'}">
               <th style="text-align: center" class="EditHead">操作</th>
              </s:if>
           
        </tr>
        </thead>
  </table>
 </div> 
<div id="layerCenter" style="margin-bottom: 40px;margin-top: 35px;">
    <s:hidden name="project_id" value="${project_id}"/>
    <table cellpadding=0 cellspacing=0 border=0 align="center" id="reloadTable" class="ListTable" >
   <colgroup>
      <col style="width: 15%;" />
      <col style="width: 15%;" />
      <col style="width: 10%;" />
      <col style="width: 15%;" />
      <col style="width: 25%;" />
       <s:if test="${editFile != 'view'}">
        <col style="width: 20%;"  />
       </s:if>
    </colgroup>
  
        <tbody>
        <c:forEach items="${projectStageList}" var="projstage">
            <tr>
                <c:choose>
                    <c:when test="${empty projstage.wppdArchivesList}">
                        <td id="${projstage.stagecode}" rowspan='1' align="left"
                            class="editTd"> ${projstage.stagename} </td>
                    </c:when>
                    <c:otherwise>
                        <td id="${projstage.stagecode}"
                            rowspan='<c:out value="${fn:length(projstage.wppdArchivesList)}"></c:out>' align="left"
                            class="editTd"> ${projstage.stagename}</td>
                    </c:otherwise>
                </c:choose>
                <c:choose>
                    <c:when test="${empty projstage.wppdArchivesList}">
                        <td align="left" class="ListTableTrStageF">&nbsp;</td>
                        <td align="left" class="ListTableTrStageN">&nbsp;</td>
                        <td align="left" class="ListTableTrStageF">&nbsp;</td>
                        <td align="left" class="ListTableTrStageF" nowrap="nowrap">&nbsp;</td>
                          <s:if test="${editFile != 'view'}">
                        <td align="left" class="ListTableTrStageF">&nbsp;</td>
                        </s:if>
                    </c:when>
                    <c:otherwise>
                        <c:forEach items="${projstage.wppdArchivesList}" var="wppd" begin="0" end="0">
                            <td style="text-align:left" class="editTd">${wppd.workprogramdetailname}</td>
                            <td style="text-align:center" class="editTd">${wppd.needdo}</td>
                            <td align="left" class="editTd" nowrap="nowrap">
                                <s:if test="${projstage.stagename=='准备阶段'}">立项性文件</s:if>
                                <s:if test="${projstage.stagename=='实施阶段'}">证明性文件</s:if>
                                <s:if test="${projstage.stagename=='报告阶段'}">结论性文件</s:if>
                                <s:if test="${projstage.stagename=='整改跟踪阶段'}">整改性文件</s:if>
                            </td>

                            <td style="text-align:left" class="editTd tdWidth" >
                                <div>${wppd.uploadFileUrl}</div>
                                <%-- <div style="display: none" id="shenjizuFiles_${wppd.projdetailid}">
                                </div> --%>
                            </td>
                            <s:if test="${editFile != 'view'}">
                                <td align="left" class="editTd">
                                <%-- <div id="shenjizuBtn_${wppd.projdetailid}"></div> --%>
                                 <s:if test="${editFile  !='view'}">
                                  <div onclick="addAttachFile('${wppd.uploadfileid}')" class="icon-addFile" style="background-position: 0px 5px; margin: 6px 10px 5px; padding: 5px; border: 0px solid red; border-image: none; width: 100px; height: 28px; line-height: 28px; float: none; cursor: pointer; background-repeat: no-repeat;">
                                  </div>
                                  </s:if>
                                  </td>
                             </s:if>


                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </tr>
            <c:if test="${not empty projstage.wppdArchivesList}">
                <c:if test="${fn:length(projstage.wppdArchivesList)>1}">
                    <c:forEach items="${projstage.wppdArchivesList}" begin="1" var="wppd" varStatus="state">
                        <tr>
                            <td style="text-align:left" class="editTd">${wppd.workprogramdetailname}</td>
                            <td style="text-align:center" class="editTd">${wppd.needdo}</td>
                            <td class="editTd" nowrap="nowrap">
                                <s:if test="${projstage.stagename=='准备阶段'}">立项性文件</s:if>
                                <s:if test="${projstage.stagename=='实施阶段'}">证明性文件</s:if>
                                <s:if test="${projstage.stagename=='报告阶段'}">结论性文件</s:if>
                                <s:if test="${projstage.stagename=='整改跟踪阶段'}">整改性文件</s:if>
                            </td>
                            <td style="text-align:left" class="editTd tdWidth"  >
                                <div>${wppd.uploadFileUrl}</div>
                              <%--   <div style="display: none" id="shenjizuFiles_${wppd.projdetailid}">
                                </div> --%>

                            </td>
                         <s:if test="${editFile != 'view'}">
                          <td align="left" class="editTd">
                              <%--   <div id="shenjizuBtn_${wppd.projdetailid}"></div> --%>
                              <s:if test="${editFile  !='view'}">
                                <div onclick="addAttachFile('${wppd.uploadfileid}')" class="icon-addFile" style="background-position: 0px 5px; margin: 6px 10px 5px; padding: 5px; border: 0px solid red; border-image: none; width: 100px; height: 28px; line-height: 28px; float: none; cursor: pointer; background-repeat: no-repeat;">
                                </div>
                             </s:if>
                            </td>
                         </s:if>

                        </tr>
                    </c:forEach>
                </c:if>
            </c:if>
        </c:forEach>
<%--        <tr>
            <td align=right class="EditHead" colspan="6">
                <a class="easyui-linkbutton" data-options="iconCls:'icon-export'"
                   onclick="exportArchivesZipByCh()">导出</a>&nbsp;&nbsp;
                <a class="easyui-linkbutton" data-options="iconCls:'icon-export'"
                   onclick="deleteArchives()">删除</a>&nbsp;&nbsp;
                <s:if test="${taskInstanceId!=null&&taskInstanceId>0}">
                    <a class="easyui-linkbutton" data-options="iconCls:'icon-undo'"
                       onclick="this.style.disabled='disabled';window.location.href='${contextPath}/portal/simple/simple-firstPageAction!show.action'">返回</a>&nbsp;&nbsp;
                </s:if>
                <s:else>
                    <s:if test="backURL != null && backURL != ''">
                        <a class="easyui-linkbutton" data-options="iconCls:'icon-undo'" onclick="backURLFun();">返回</a>&nbsp;&nbsp;
                    </s:if>
                    <s:else>
                        <a class="easyui-linkbutton" data-options="iconCls:'icon-undo'"
                           onclick="javascript:history.go(-1);">返回</a>&nbsp;&nbsp;
                    </s:else>
                </s:else>
            </td>
        </tr>--%>
        </tbody>
    </table>
</div>
 <div style="width: 100%; position: fixed; bottom: 0; background-color: #FAFAFA; text-align: center;">
    <div style="text-align: right; margin: 10px auto; width: 97%">
        <a class="easyui-linkbutton" data-options="iconCls:'icon-export'"
           onclick="exportArchivesZipByCh()">导出</a>&nbsp;&nbsp;
            <s:if test="${editFile == 'view'}">
            </s:if>
            <s:else>
               <a class="easyui-linkbutton" data-options="iconCls:'icon-delete'"
                onclick="deleteArchives()">删除</a>&nbsp;&nbsp;
            </s:else>

        <s:if test="${taskInstanceId!=null&&taskInstanceId>0}">
         <s:if test="${editFile == null && editFile == ''}">
             <a class="easyui-linkbutton" data-options="iconCls:'icon-undo'"
               onclick="this.style.disabled='disabled';window.location.href='${contextPath}/portal/simple/simple-firstPageAction!show.action'">返回</a>&nbsp;&nbsp;
         </s:if>

        </s:if>
        <s:else>
         <s:if test="${editFile == null || editFile == ''}">
                     <s:if test="backURL != null && backURL != ''">
                <a class="easyui-linkbutton" data-options="iconCls:'icon-undo'" onclick="backURLFun();">返回</a>&nbsp;&nbsp;
            </s:if>
            <s:else>
                <a class="easyui-linkbutton" data-options="iconCls:'icon-undo'"
                   onclick="javascript:history.go(-1);">返回</a>&nbsp;&nbsp;
            </s:else>
         </s:if>
        </s:else>
    </div>
</div> 
<div id="uploadWin" style="padding:10px;overflow:hidden;">
			<div id="filebtn" align="center"></div>
			<div id="filelst"></div>
</div>
<div id="layer" style="display: none" align="center">
    <img src="${contextPath}/images/uploading.gif">
    <br>
    <br>
    正在压缩档案文件，请稍候......
</div>
<div id="upload" title="上传附件" style="overflow:hidden;padding:0px">
    <iframe id="toUpload" src="" width="100%" title="" height="100%" frameborder="0"></iframe>
</div>
<div id="viewYiDian" title="查看疑点" style="overflow:hidden;padding:0px">
    <iframe id="viewYiDianSrc" src="" width="100%" title="" height="100%" frameborder="0"></iframe>
</div>
<div id="viewDiGao" title="查看底稿" style="overflow:hidden;padding:0px">
    <iframe id="viewDiGaoSrc" src="" width="100%" title="" height="100%" frameborder="0"></iframe>
</div>
<jsp:include flush="true" page="/pages/frReportFlow/ajaxloading.jsp"/>
</body>
<script type="text/javascript">

    
    $(function () {
    	
    	$('#uploadWin').css({
			'height':'0px',
			'display':''
		});
    	
        var editFile = "${editFile}";
        var isFile = true;
        if (editFile == "view" ){
       	 isFile = false;
        }
/*         <c:forEach items="${projectStageList}" var="projstage">
        <c:forEach items="${projstage.wppdArchivesList}" var="wppd" >
        if ('${wppd.canEdit}' == '1') {
        	var sj = "";
        	if ( isFile ){
        		sj = 'shenjizuBtn' + '_${wppd.projdetailid}';
        	}
        	
            $("#shenjizuFiles_${wppd.projdetailid}").fileUpload({
                fileGuid: '${wppd.uploadfileid}' == '' ? '${wppd.projdetailid}' : '${wppd.uploadfileid}',
                echoType: 2,
                isAdd: isFile,
                isDel: isFile,
                isEdit: isFile,
                uploadFace: 1,
                triggerId: sj,
                isReload:1,
                onFileSubmitSuccess:function(data,options){
                    window.location.reload();
                }
            });
        } else {
        	var sj = "";
        	if ( isFile ){
        		'shenjizuBtn' + '_${wppd.projdetailid}'
        	}
        	
            $("#shenjizuFiles_${wppd.projdetailid}").fileUpload({
                fileGuid: '${wppd.uploadfileid}' == '' ? '${wppd.projdetailid}' : '${wppd.uploadfileid}',
                echoType: 2,
                isAdd: isFile,
                isDel: isFile,
                isEdit: isFile,
                uploadFace: 1,
                triggerId: sj,
                isReload:1,
                onFileSubmitSuccess:function(data,options){
                    window.location.reload();
                }
            });
        }
        </c:forEach>
        </c:forEach> */
        
 /*        $('#dg').datagrid({
        	toolbar: [{
        		id:'searchObj',
        		text:'导出',
        		iconCls: 'icon-export',
        		handler: function(){alert('编辑按钮')}
        	}
        	 <s:if test="${editFile != 'view'}">
        	,'-',{
        		id:'searchObj',
        		text:'删除',
        		iconCls: 'icon-delete',
        		handler: function(){alert('帮助按钮')}
        	}
        	 </s:if>
        	]
        }); */


       /*  $('#dg').datagrid({
        	toolbar: '#tb'
        }); */

    });


    function readAudDoudt(doubt_id, contextPath) {
        var url = contextPath + "/operate/doubt/view.action?type=YD&doubt_id=" + doubt_id;
        $('#viewYiDianSrc').attr("src", url);
        $('#viewYiDian').window('open');
    }

    function readMenuScriptMInArchives(menuscript_id, contextPath) {
        var url = contextPath + "/operate/manu/viewAll.action?crudId=" + menuscript_id;
        $('#viewDiGaoSrc').attr("src", url);
        $('#viewDiGao').window('open');
    }

    function readMenuScriptArchives(project_id, contextPath) {
        var url = contextPath + "/operate/manuExt/mainUi.action?projectview=view&project_id=" + project_id;
        $('#viewDiGaoSrc').attr("src", url);
        $('#viewDiGao').window('open');
    }

    $('#upload').window({
        width: 950,
        height: 450,
        modal: true,
        collapsible: false,
        maximizable: true,
        minimizable: false,
        closed: true
    });
    $('#viewYiDian').window({
        width: 950,
        height: 450,
        modal: true,
        collapsible: false,
        maximizable: true,
        minimizable: false,
        closed: true
    });
    $('#viewDiGao').window({
        width: 1000,
        height: 500,
        modal: true,
        collapsible: false,
        maximizable: true,
        minimizable: false,
        closed: true
    });
    
    
	  function addAttachFile(guid){
	    	 if(guid){
	    	 	$('#filelst').fileUpload({
	    			fileGuid:guid,
	    			uploadFace:1,
	    			isAdd:false,
	    			isDel:true,
	    			isEdit:false,
	    			isDownload:false,
	    			isView:false,
	    			triggerId:'filebtn',
	    			echoType:3,
	    			callBackGridHeight:1,
	    			onFileSubmitSuccess:function(data){
	    				window.location.reload();
	    			}
	    		});
	    		$("#uploadWin .icon-addFile").trigger("click");  
	    	}
  	}
</script>
</html>
