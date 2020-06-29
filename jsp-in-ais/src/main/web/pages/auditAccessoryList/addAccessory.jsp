<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<title>添加附件</title>
<link href="${contextPath}/styles/main/ais.css" rel="stylesheet" type="text/css" />
<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
<script type="text/javascript" src="${contextPath}/scripts/ufaudTextLengthValidator.js"></script>
<s:head theme="ajax" />
<script language="javascript">
function $(nodename){
    return document.getElementsByName(nodename)[0];
}

function $$(nodeid){
    return document.getElementById(nodeid);
}

function onSubmit() {
//    self.opener.close();
}
/*
 *上传附件
*/
function Upload(id,filelist){
    var guid=$(id).value;
    var num=Math.random();
    var rnm=Math.round(num*9000000000+1000000000);//随机参数清除模态窗口缓存
    window.showModalDialog('${contextPath}/commons/file/welcome.action?table_name=AUDIT_ACCESSORYLIST&guid='+guid+'&&param='+rnm+'&&deletePermission=true',filelist,'dialogWidth:700px;dialogHeight:450px;status:yes');
}

/*
* 删除附件
*/
function deleteFile(fileId,guid,isDelete,isEdit,appType,title){
    var boolFlag=window.confirm("确认删除吗?");
    if(boolFlag==true){
    	DWREngine.setAsync(false);
        DWREngine.setAsync(false);DWRActionUtil.execute(
            { namespace:'/commons/file', action:'delFile', executeResult:'false' },
            {'fileId':fileId, 'deletePermission':isDelete, 'isEdit':isEdit, 'guid':guid, 'appType':appType,'title':title},
            xxx);
        function xxx(data){
            document.getElementById(guid).parentElement.innerHTML=data['accessoryList'];
        }
    }
}

</script>
</head>
<body onload="">
<s:form action="saveAccessory" namespace="/auditAccessoryList">
<table id="auditAccessoryListTable" cellpadding=0 cellspacing=1 border=0
        bgcolor="#409cce" class="ListTable" align="center">
<tr>
<td align="left" class="listtabletr11">资料清单<font color="red">*</font></td>
  <td align="left" class="listtabletr22">
   <s:textfield name="auditUnionName" cssStyle="width:90%" maxlength="50" value=""/>
  </td>
  <td align="left" class="listtabletr11">是否必传</td>
   <td align="left" class="listtabletr22">
       <s:select list="{'是','否'}" name="needDo"/>
   </td>
</tr>
<tr>
<td align="left" class="listtabletr11"><input type="button" value="上传附件" onclick="Upload('auditUuid',accelerys)" /></td>

<td class="ListTableTr22" colspan="3">
    <s:hidden name="auditUuid" value="${auditUuid}"/>
    <div id="accelerys" align="center">
        <s:property escape="false" value="accessoryList" />
    </div>
</td>
</tr>
</table>
<div align="right">
<input type="submit" value="保  存" onclick="onSubmit();"/>&nbsp;
<input type="button" value="关  闭" onclick="self.close()"/>
</div>
</s:form>
</body>
</html>