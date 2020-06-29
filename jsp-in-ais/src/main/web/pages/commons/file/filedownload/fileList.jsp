<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib prefix="s" uri="/struts-tags" %>


<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
<title>附件列表页面</title>
<link href="${contextPath}/styles/main/ais.css" rel="stylesheet" type="text/css">
</head>
<body>
        <h3>附件列表: </h3>
        

        
        <display:table name="fileList"  id="row" class="its" pagesize="10" size="listsize" requestURI="/mng/file/fileList.action" partialList="true"  >
        
                         		
			           <display:column property="fileId" title="fileId" sortable="true"></display:column>

				       <display:column property="fileName" title="fileName" sortable="true" href="javascript:;" url="/commons/file/downloadFile.action?fileId=${row.fileId}"></display:column>
				
					   <display:column property="fileType" title="fileType" sortable="true"></display:column>
					   
					   <display:column property="guid" title="guid" sortable="true" href="javascript:;" url="/commons/file/downloadFile.action?guid=${row.guid}"></display:column>
					   
					   <display:column title="操作" href="javascript:;" url="/commons/file/delFile.action?fileId=${row.fileId}"> 删 除</display:column>
				
        
			
		</display:table>
  
</body>
</html>
