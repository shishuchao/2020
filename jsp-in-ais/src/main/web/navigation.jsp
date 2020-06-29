<%@ page contentType="text/html; charset=utf-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<HTML>
	<HEAD>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
		<TITLE>navigation</TITLE>
		<link href="<%=request.getContextPath()%>/resources/css/site.css"
			rel="stylesheet" type="text/css">
		<script language="javascript" type="text/javascript"
			src="<%=request.getContextPath()%>/resources/js/normal.js"></script>
		<script language="javascript" type="text/javascript"
			src="<%=request.getContextPath()%>/resources/js/common.js"></script>
		<script language="Javascript">

function RightGo(url)
{

 parent.mainFrame.location.href=url;
 }
function PopWin(url,name)
{
 window.open(url,name,500,500);
} 


 		function winOpen(url){
 		
 		 window.open (url,"","height=600,width=1000,top=100,left=100,toolbar=no,menubar=no,scrollbars=yes,resizable=no,location=no,status=no");
 	
 		}
 		
 		
</script>

		<!-- start cpoy from lya -->

		<style>
   BODY {background-color: white}
   TD {font-size: 10pt; 
       font-family: verdana,helvetica; 
	   text-decoration: none;
	   white-space:nowrap;}
   A  {text-decoration: none;
       color: black}
</style>

		<script src="<%=request.getContextPath()%>/scripts/treeview/ua.js"></script>
		<script
			src="<%=request.getContextPath()%>/scripts/treeview/ftiens4.js"></script>
		<script>
USETEXTLINKS = 1  
STARTALLOPEN = 0
PRESERVESTATE = 1
ICONPATH = "<%=request.getContextPath()%>/scripts/treeview/"
BUILDALL = 1




 foldersTree= gFld("&nbsp;门户", "<s:url action="simple-firstPageAction!show" namespace="/portal/simple"></s:url>")
	<s:iterator value="menuList">
	
 	    <s:if test="${fparentid==1}">　<!-- 这里要固定根结点的id %-->
 	   
	 	    <s:if test="${isHaveChild=='N'}">
		      	insDoc(foldersTree, gLnk("R", "<s:property value="ffundisplay"/>", "${flink}"))
		    </s:if>
		    <s:else>
		      	var R<s:property value="%{ffunid}"/> = insFld(foldersTree, gFld("&nbsp;<s:property value="ffundisplay"/>", "${flink}"))
		    </s:else> 	    
 	    </s:if>
    	<s:else>
	 	    <s:if test="${isHaveChild=='N'}">
		      	insDoc(R<s:property value="fparentid"/>, gLnk("R", "<s:property value="ffundisplay"/>", "${flink}"))
		    </s:if>
		    <s:else>
		      	var R<s:property value="%{ffunid}"/> = insFld(R<s:property value="fparentid"/>, gFld("&nbsp;<s:property value="ffundisplay"/>", "${flink}"))
		    </s:else>
	    </s:else>
	    
</s:iterator>


</script>

		<!-- end cpoy from lya -->

	</HEAD>
	<BODY topmargin=0 leftmargin=0>

		<!-- start cpoy from lya -->
		<div style="position:absolute; top:0; left:0; ">
			<table border="0">
				<tr>
					<td>
						<font size="-2"><a
							style="font-size:7pt;text-decoration:none;color:silver;"
							href="http://www.treemenu.net/" target="_blank"> </a> </font>
					</td>
				</tr>
			</table>
		</div>
		<script>initializeDocument()</script>

		<!-- end cpoy from lya -->
	</BODY>
</HTML>
