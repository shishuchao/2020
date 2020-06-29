<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<title>工作方案明细列表</title>
<s:head theme="ajax" />
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
		<link rel="stylesheet" type="text/css" href="${contextPath}/resources/csswin/subModal.css">
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
		<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
<script language="javascript">
	function $$(nodename){
	    return document.getElementsByName(k)[0];
	}
	
	function $$(nodeid){
	    return document.getElementById(nodeid);
	}
	function editFlowNode(rowIndex,wpdid,wpdname,needdo,filename,fileid){
		location.reload();
		var trObject = $$("workprogramdetailTable").rows(rowIndex/1);
		var fileurl="";
	    for(var i=0;i<filename.length;i++){
	        fileurl+="<a href='${contextPath}/commons/file/downloadFile.action?fileId="+fileid[i]+"'>"+filename[i]+"</a><br/>"
	    }
	 
	    if(trObject.cells.length==6){
	    	trObject.cells(1).innerHTML=wpdname;
	    	trObject.cells(2).innerHTML=needdo;
	    	trObject.cells(3).innerHTML=fileurl;
	    	//trObject.cells(4).innerHTML=documentType;
	    	trObject.cells(1).style.backgroundColor="#ffffff"
	    	trObject.cells(2).style.backgroundColor="#ffffff"
	    	trObject.cells(3).style.backgroundColor="#ffffff"
	    	//trObject.cells(4).style.backgroundColor="#ffffff"
	    }else{
	    	trObject.cells(0).innerHTML=wpdname;
	    	trObject.cells(1).innerHTML=needdo;
	    	trObject.cells(2).innerHTML=fileurl;    	
	    	trObject.cells(0).style.backgroundColor="#ffffff"
	    	trObject.cells(1).style.backgroundColor="#ffffff"
	    	trObject.cells(2).style.backgroundColor="#ffffff"
	    }
	}
	
	function insertFlowNode(stage,wpdid,wpdname,needdo,filename,fileid){
		location.reload();
		var _obj=$$(stage);
		var currrowspan= _obj.getAttribute("rowspan")/1
		var _parobj = _obj.parentNode;
		var fileurl="";
	    for(var i=0;i<filename.length;i++){
	        fileurl+="<a href='${contextPath}/commons/file/downloadFile.action?fileId="+fileid[i]+"'>"+filename[i]+"</a><br/>"
	    }
	    if(currrowspan==1&&(_parobj.childNodes(1).innerHTML=="&nbsp;"||_parobj.childNodes(1).innerHTML=="")){
	        _parobj.childNodes(1).innerHTML=wpdname;
	        _parobj.childNodes(2).innerHTML=needdo;
	        _parobj.childNodes(3).innerHTML=fileurl;
	        _parobj.childNodes(4).innerHTML="<input type='button' name='editbutton' value='修改' onclick='editProgramDetail(\""+wpdid+"\")'/>&nbsp;<input type='button' name='editbutton' value='删除' onclick='deleteProgramDetail(\""+stage+"\",\""+wpdid+"\")'/>";
	    }else{
	    	_obj.rowSpan=currrowspan+1;
	    	var _tr = document.createElement("tr");
	    	var _row = $$("workprogramdetailTable").insertRow(_parobj.rowIndex+currrowspan);
	    	var c = _row.insertCell(0);
	    	var c1 = _row.insertCell(1);
	    	var c2 = _row.insertCell(2);
	    	var c3 = _row.insertCell(3);
	        c.align="left";
	        c1.align="left";
	        c2.align="left";
	        c3.align="left";
	
	        c.className="ListTableTrStageF";
	        c1.className="ListTableTrStageN";
	        c2.className="listtabletr22";
	        c3.className="listtabletr22";
	        
	    	c.innerHTML=wpdname;
	    	c1.innerHTML=needdo;
	    	c2.innerHTML=fileurl;
	    	c3.innerHTML="<input type='button' name='editbutton' value='修改' onclick='editProgramDetail(\""+wpdid+"\")'/>&nbsp;<input type='button' name='editbutton' value='删除' onclick='deleteProgramDetail(\""+stage+"\",\""+wpdid+"\")'/>";
	    }
	}
//修改工作方案明细
function editProgramDetail(wpdid,isIntctet){
	var bObject = event.srcElement;
	var tdObject = bObject.parentNode;
	var trObject = tdObject.parentNode;
	/*
    if(trObject.childNodes.length==5){
    	trObject.childNodes(1).style.backgroundColor="#EEF7FF";
        trObject.childNodes(2).style.backgroundColor="#EEF7FF";
        trObject.childNodes(3).style.backgroundColor="#EEF7FF";
    }else{
    	trObject.childNodes(0).style.backgroundColor="#EEF7FF";
        trObject.childNodes(1).style.backgroundColor="#EEF7FF";
        trObject.childNodes(2).style.backgroundColor="#EEF7FF";
    }
    
    var url="${contextPath}/workprogram/editWorkProgramDetail4one.action?wpdid="+wpdid+"&option=edit&rowIndex="+trObject.rowIndex;
    window.open(url,"","height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no");
   */ 
   window.location.href = "${contextPath}/workprogram/editWorkProgramDetail4one.action?wpdid="+wpdid+"&option=edit&rowIndex="+trObject.rowIndex+"&isIntctet="+isIntctet;
//    var width = ($(window).width()-1200)*0.5;
//    var height = ($(window).height()-550)*0.2;
//    var myurl = "${contextPath}/workprogram/editWorkProgramDetail4one.action?wpdid="+wpdid+"&option=edit&rowIndex="+trObject.rowIndex;
//    parent.addTab("tabs","工作方案明细修改","editWorkprogramDetail",myurl,false);
}

function addProgramDetail(wpid,stagecode,isIntctet){

	window.location.href = "${contextPath}/workprogram/editWorkProgramDetail4one.action?options=add&wpid="+wpid+"&wpd_stagecode="+stagecode+"&isIntctet="+isIntctet;
    //var url="${contextPath}/workprogram/editWorkProgramDetail4one.action?options=add&wpid="+wpid+"&wpd_stagecode="+stagecode;   
    //window.open(url,"","height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no");
}

function deleteProgramDetail(stagecode,wpdid){
	$.messager.confirm('提示信息','是否删除该节点？',function(isDel){
		if(isDel){
			DWREngine.setAsync(false);
        DWREngine.setAsync(false);DWRActionUtil.execute(
        { namespace:'/workprogram', action:'deleteWorkProgramDetail', executeResult:'false' }, 
        {'wpdid':wpdid},
        xxx);
        function xxx(data){
            retmessage=data['ret_message'];
        } 
        if(retmessage=="ok"){
            showMessage1("删除成功！");
            location.reload();
            var tableObj = $$("workprogramdetailTable");
            var bObject = event.srcElement;
        	var tdObject = bObject.parentNode;
        	var trObject = tdObject.parentNode; 
            rowIndex=trObject.rowIndex;
            if(rowIndex==1){
                if($$(stagecode).rowSpan==1){
                	trObject.cells(1).innerHTML="";
                	trObject.cells(2).innerHTML="";
                	trObject.cells(3).innerHTML="";
                	trObject.cells(4).innerHTML="";
                }else{
                	trObject = $$("workprogramdetailTable").rows(rowIndex/1);
                	nextTrObject = $$("workprogramdetailTable").rows(rowIndex/1+1);
                	trObject.cells(1).innerHTML=nextTrObject.cells(0).innerHTML;
                	trObject.cells(2).innerHTML=nextTrObject.cells(1).innerHTML;
                	trObject.cells(3).innerHTML=nextTrObject.cells(2).innerHTML;
                	trObject.cells(4).innerHTML=nextTrObject.cells(3).innerHTML;
                	trObject1 = $$("workprogramdetailTable").rows(rowIndex/1+1);
                	tableObj.deleteRow(rowIndex/1+1);
                	$$(stagecode).rowSpan=$$(stagecode).rowSpan/1-1;
                }
            }else{
            	 if($$(stagecode).rowSpan==1){
                 	trObject.cells(1).innerHTML="";
                 	trObject.cells(2).innerHTML="";
                 	trObject.cells(3).innerHTML="";
                 	trObject.cells(4).innerHTML="";
            	 }else{
            		 if(trObject.cells.length==5){
                        var nextTrObject = tableObj.rows(rowIndex+1);
            			trObject.cells(1).innerHTML=nextTrObject.cells(0).innerHTML;
                      	trObject.cells(2).innerHTML=nextTrObject.cells(1).innerHTML;
                      	trObject.cells(3).innerHTML=nextTrObject.cells(2).innerHTML;
                      	trObject.cells(4).innerHTML=nextTrObject.cells(3).innerHTML;
                      	tableObj.deleteRow(rowIndex+1);
                      	$$(stagecode).rowSpan=$$(stagecode).rowSpan/1-1;
            		 }else{
            			 tableObj.deleteRow(rowIndex);
                         $$(stagecode).rowSpan=$$(stagecode).rowSpan/1-1;
                     }
                	
            	 }
            }
        }
		}
	});
}

</script>
</head>
<body>
<s:form id="workprogramDetailForm" action="saveWorkprogramDetail" namespace="/workprogram">
    <s:hidden name="wpid" value="${wpid}"/>
  <table cellpadding=0 cellspacing=1 border=0 class="ListTable" width="100%" align="center">
    <tr>
        <td colspan="5" align="left" class="topTd">
            <div style="display: inline;width:80%;">
               	工作方案模板名称：<s:property value="wp_name"/>
            </div>
        </td>
    </tr>
</table>
    
    <table id="workprogramdetailTable"  class="ListTable" align="center">
        <tr>
            <td class="EditHead" style='text-align:center;'>阶段名称</td>
            <td class="EditHead" style='text-align:center;'>流程节点</td>
            <td class="EditHead" style='text-align:center;'>是否必做</td>
            <td class="EditHead" style='text-align:center;'>对应模板</td>
            <td class="EditHead" style='text-align:center;'>文件类型</td>
            <td class="EditHead" style='text-align:center;'>操作</td>
        </tr>
        <c:forEach items="${projectStageList}" var="projstage">
            <tr>
                 <c:choose>
                  <c:when test="${empty projstage.wpdList}">
                        <td id="${projstage.stagecode}" rowspan='1' align="left" class="editTd"> 
                            ${projstage.stagename} 
                            <a class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="addProgramDetail('${wpid}','${projstage.stagecode}','${isIntctet}')">增加节点</a>
                        </td>
                  </c:when>
                   <c:otherwise>
                        <td id="${projstage.stagecode}" rowspan='<c:out value="${fn:length(projstage.wpdList)}"></c:out>' align="left" class="editTd">
	                         ${projstage.stagename} 
                             <a class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="addProgramDetail('${wpid}','${projstage.stagecode}','${isIntctet}')">增加节点</a>
                        </td>
                   </c:otherwise>
                  </c:choose>
               <c:choose>
                   <c:when test="${empty projstage.wpdList}">
                        <td align="left" class="editTd">&nbsp;</td>
                        <td align="left" class="editTd">&nbsp;</td>
                        <td align="left" class="editTd">&nbsp;</td>
                        <td align="left" class="editTd" nowrap="nowrap">&nbsp;</td>
                        <td align="left" class="editTd">&nbsp;</td>
                   </c:when>
                   <c:otherwise>
                   <c:forEach items="${projstage.wpdList}" var="wpd" begin="0" end="0">
                        <td align="left" class="editTd">${wpd.workprogramdetailname}</td>
                        <td style='text-align:center;' class="editTd">${wpd.needdo}</td>
                        <td align="left" class="editTd">${wpd.fileurl}</td>
                        <td align="left" class="editTd" nowrap="nowrap">${wpd.documentType}</td>
                        <td style='text-align:center;' class="editTd">
                           <a class="easyui-linkbutton" data-options="iconCls:'icon-edit'" onclick="editProgramDetail('${wpd.workprogramdetailid}','${isIntctet}')">修改</a>
                           <a class="easyui-linkbutton" data-options="iconCls:'icon-delete'" onclick="deleteProgramDetail('${projstage.stagecode}','${wpd.workprogramdetailid}')">删除</a>
                        
                        </td>
                   </c:forEach>
                   </c:otherwise>
                </c:choose>
                 </tr>
                <c:if test="${not empty projstage.wpdList}">
                   <c:if test="${fn:length(projstage.wpdList)>1}">
                         <c:forEach items="${projstage.wpdList}" begin="1" var="wpd">
                         <tr>
                            <td align="left" class="editTd">${wpd.workprogramdetailname}</td>
                            <td style='text-align:center;' class="editTd">${wpd.needdo}</td>
                            <td align="left" class="editTd">${wpd.fileurl}</td>
                            <td align="left" class="editTd" nowrap="nowrap">${wpd.documentType}</td>
                            <td style='text-align:center;' class="editTd">
                                <a class="easyui-linkbutton" data-options="iconCls:'icon-edit'" onclick="editProgramDetail('${wpd.workprogramdetailid}','${isIntctet}')">修改</a>
                                <a class="easyui-linkbutton" data-options="iconCls:'icon-delete'" onclick="deleteProgramDetail('${projstage.stagecode}','${wpd.workprogramdetailid}')">删除</a>
                            </td>
                         </tr>                    
                        </c:forEach>
                    </c:if>
                </c:if>
           
        </c:forEach>
        <tr>
		<td align=right  class="bottomTd" colspan="6">
		    <a class="easyui-linkbutton" data-options="iconCls:'icon-undo'" onclick="window.location='${contextPath}/workprogram/listWorkProgram.action'">返回列表</a>
		</td>
</tr>
    </table>
   
</s:form>
</body>
</html>