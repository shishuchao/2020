<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>

		<center>
				<div align="center" style="width:97%">
<s:button name="b1" value="保 存" onclick="return saveInfo('0');" />
					&nbsp;&nbsp;
					<s:button name="b2" value="提交归档" onclick="return saveInfo('1');" />
					&nbsp;&nbsp;
					
					<s:button value="返 回" onclick="returnBackWindows();"></s:button>
					&nbsp;&nbsp;
				</div>
		</center>



