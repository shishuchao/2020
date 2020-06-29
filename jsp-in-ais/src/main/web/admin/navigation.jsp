<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<HTML>
<head><meta http-equiv="content-type" content="text/html; charset=UTF-8">
<TITLE> navigation </TITLE>
<script language="javascript" type="text/javascript" src="../css/normal.js"></script>
<link href="../css/site.css" rel="stylesheet" type="text/css">
<script language="Javascript">

function RightGo(url)
{

 parent.allFrame.location.href=url;
 }
 function getCheck(){
 alert(configtree.GetSelected());
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
			
		    foldersTree= gFld("&nbsp;功能树", "")
			
			insDoc(foldersTree, gLnk("R", "组织机构维护", "orgindex.jsp"))
			insDoc(foldersTree, gLnk("R", "人员维护", "uuser_index.jsp"))
			insDoc(foldersTree, gLnk("R", "密码维护", "../general/changePassWord.jsp"))
			insDoc(foldersTree, gLnk("R", "基础信息设置", "../pages/basic/codename_index.jsp"))
			insDoc(foldersTree, gLnk("R", "注销", "<%=request.getContextPath()%>/j_acegi_logout"))
			
		</script>

		<!-- end cpoy from lya -->
</HEAD>
<BODY  topmargin=0 leftmargin=0>
<%--<div class="TreeView" id="configtree" Checkbox="0" SelectedColor="#FFFF00" topVisible="FALSE">
<p title="" sid="1" pid="0"></p>
<p title="组织机构维护" sid="2" pid="1" click="RightGo('orgindex.jsp')"></p>
<p title="人员维护" sid="3" pid="1" click="RightGo('uuser_index.jsp')"></p>
<p title="密码维护" sid="7" pid="1" click="RightGo('../general/changePassWord.jsp')"></p>
<p title="基础信息设置" sid="7" pid="1" click="RightGo('../pages/basic/codename_index.jsp')"></p>

</div>
--%><!-- start cpoy from lya -->
		<div style="position:absolute; top:0; left:0; ">
			<table border="0">
				<tr>
					<td>
						<font size="-2"><a
							style="font-size:7pt;text-decoration:none;color:silver;"
							href="http://www.treemenu.net/" target="_blank"> </a>
						</font>
					</td>
				</tr>
			</table>
		</div>
		<script>initializeDocument()</script>

		<!-- end cpoy from lya -->
</BODY>
</HTML>
