<%@ page contentType="text/html; charset=utf-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://fckeditor.net/tags-fckeditor" prefix="FCK" %>
<%@ taglib uri="http://www.ufaud.com/aistld" prefix="ais"%>
<HTML>
	<HEAD><meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<TITLE>navigation</TITLE>
		<link href="<%=request.getContextPath()%>/resources/css/site.css"
			rel="stylesheet" type="text/css">

		<link rel="stylesheet" type="text/css"
			href="<%=request.getContextPath()%>/resources/csswin/style.css" />
		<link rel="stylesheet" type="text/css"
			href="<%=request.getContextPath()%>/resources/csswin/subModal.css" />
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/resources/csswin/common.js"></script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/resources/csswin/subModal.js"></script>
			<link rel="stylesheet" type="text/css"
			href="<%=request.getContextPath()%>/resources/fckedit/sample.css" />
			<script type="text/javascript" src="<%=request.getContextPath()%>/resources/fckedit/fckeditor.js"></script>
			<script type="text/javascript" src="<%=request.getContextPath()%>/ui/search/search.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/scripts/calendar.js"></script>
		<link rel="stylesheet" type="text/css"
			href="<%=request.getContextPath()%>/ui/search/themes/blue/blue.css" />
			<script type="text/javascript"
			src="/ais/scripts/portal/ext-base.js"></script>
		<script type="text/javascript"
			src="/ais/scripts/portal/ext-all.js"></script>
		
		<link href="/ais/styles/portal/ext-all.css" rel="stylesheet" type="text/css">
		<script type="text/javascript">
		//===========================combox数据读取=================================   
		Ext.onReady(function(){
		 
var datas = [
        ['AL', 'Alabama']
        ];
	var store = new Ext.data.SimpleStore({
	fields: ['name', 'value'],
	data : datas

});

var combo = new Ext.form.ComboBox({

    store: store,

    displayField:'name',

    typeAhead: true,

    mode: 'local',

    triggerAction: 'all',

    emptyText:'Select a state...',

    selectOnFocus:true,

    applyTo: 'combo'

});
});
		</script>
		<script language="Javascript">

function RightGo(url)
{

 parent.mainFrame.location.href=url;
 }
 function getCheck(){
 alert(configtree.GetSelected());
 }
 function getContact(){
 
 
 alert("在这里执行页面逻辑！");
 }
 function SimpleSearch()
{

  var value=document.all.svalue.value;
   var field=document.all.sfield.value;

   if (field=="")
   {
     alert("对不起，请选择要查询的字段！");
   }
   else
   {
   if (value=="")
   {
     document.all.svalue.focus();
   }
   else
   {
    
   }
   }
}
</script>
	</HEAD>
	<BODY>
	<input type="text" id="combo" size="20"/>
		<table>
			<tr height=10 bgcolor="#FDDAE0">
				<td>
					登录
					<s:textarea rows="2" cols="3"></s:textarea>
				</td>
			</tr>
		</table>
		<br><br>针对组织类型为审计部门的选单调用：<br><br>
		<div>
			<s:textfield name="comname" label="公司单选(本公司及下级公司)" theme="xhtml"></s:textfield>
			<s:textfield name="comid"></s:textfield>
			&nbsp;
			<img
				src="<%=request.getContextPath()%>/resources/images/s_search.gif"
				onclick="showPopWin('search/searchdata.jsp?url=<%=request.getContextPath()%>/system/uSystemAction!companyList.action&paraname=comname&paraid=comid',600,450,'组织机构选择')"
				border=0 style="cursor:hand">
				<ais:orgSelector height="600" width="450" title="组织机构选择" paraId="comid" paraName="comname"  companyShow="true"/>
		</div>
		<div>
			<div>
				<s:textfield name="comnames" label="公司多选(本公司及下级公司)" theme="xhtml"></s:textfield>
				<s:textfield name="comids"></s:textfield>
				&nbsp;
				<img
					src="<%=request.getContextPath()%>/resources/images/s_search.gif"
					onclick="showPopWin('search/searchdatamuti.jsp?url=<%=request.getContextPath()%>/system/uSystemAction!companyList4muti.action&paraname=comnames&paraid=comids',600,450)"
					border=0 style="cursor:hand">
				<ais:orgSelector height="600" width="450" title="组织机构选择" paraId="comids" paraName="comnames" single="false" companyShow="true"/>
			</div>
		<div>
			<s:textfield name="orgsc" label="组织机构单选(本公司含部门及下级公司含部门)" theme="xhtml"></s:textfield>
			<s:textfield name="orgsidc"></s:textfield>
			&nbsp;
			<img
				src="<%=request.getContextPath()%>/resources/images/s_search.gif"
				onclick="showPopWin('search/searchdata.jsp?url=<%=request.getContextPath()%>/system/uSystemAction!orgList.action&paraname=orgsc&paraid=orgsidc',600,450,'组织机构选择')"
				border=0 style="cursor:hand">
				<ais:orgSelector height="600" width="450" title="组织机构选择" paraId="orgsidc" paraName="orgsc"  cascadeShow="true"/>
		</div>
		<div>
			<div>
				<s:textfield name="orgm" label="组织机构多选(本公司含部门及下级公司含部门)" theme="xhtml"></s:textfield>
				<s:textfield  name="orgmid"></s:textfield>
				&nbsp;
				<img
					src="<%=request.getContextPath()%>/resources/images/s_search.gif"
					onclick="showPopWin('search/searchdatamuti.jsp?url=<%=request.getContextPath()%>/system/uSystemAction!orgList4muti.action&paraname=orgm&paraid=orgmid',600,450)"
					border=0 style="cursor:hand">
					<ais:orgSelector height="600" width="450" title="组织机构选择" paraId="orgsidc" paraName="orgsc" single="false"  cascadeShow="true"/>
			</div>
				<div>
			<s:textfield name="borgsc" label="本机构单选(本公司含部门)" theme="xhtml"></s:textfield>
			<s:textfield name="borgsidc"></s:textfield>
			&nbsp;
			<img
				src="<%=request.getContextPath()%>/resources/images/s_search.gif"
				onclick="showPopWin('search/searchdata.jsp?url=<%=request.getContextPath()%>/system/uSystemAction!orgList.action&paraname=borgsc&paraid=borgsidc&p_item=1',600,450,'组织机构选择')"
				border=0 style="cursor:hand">
				<ais:orgSelector height="600" width="450" title="组织机构选择" paraId="borgsidc" paraName="borgsc"  internalShow="true"/>
		</div>
		<div>
				<s:textfield name="borgm" label="本机构多选(本公司含部门)" theme="xhtml"></s:textfield>
				<s:textfield name="borgmid"></s:textfield>
				&nbsp;
				<img
					src="<%=request.getContextPath()%>/resources/images/s_search.gif"
					onclick="showPopWin('search/searchdatamuti.jsp?url=<%=request.getContextPath()%>/system/uSystemAction!orgList4muti.action&paraname=borgm&paraid=borgmid&p_item=1',600,450)"
					border=0 style="cursor:hand">
				<ais:orgSelector height="600" width="450" title="组织机构选择" paraId="borgmid" paraName="borgm" single="false" internalShow="true"/>
			</div>
			
			<div>
			<s:textfield name="borgscall" label="所有机构单选" theme="xhtml"></s:textfield>
			<s:textfield name="borgsidcall"></s:textfield>
			&nbsp;
			<img
				src="<%=request.getContextPath()%>/resources/images/s_search.gif"
				onclick="showPopWin('search/searchdata.jsp?url=<%=request.getContextPath()%>/system/uSystemAction!orgList.action&paraname=borgscall&paraid=borgsidcall&p_item=2',600,450,'组织机构选择')"
				border=0 style="cursor:hand">
			<ais:orgSelector height="600" width="450" title="所有机构单选" paraId="borgsidcall" paraName="borgscall"  allShow="true"/>
		</div>
		<div>
				<s:textfield name="borgmall" label="所有机构多选" theme="xhtml"></s:textfield>
				<s:textfield name="borgmidall"></s:textfield>
				&nbsp;
				<img
					src="<%=request.getContextPath()%>/resources/images/s_search.gif"
					onclick="showPopWin('search/searchdatamuti.jsp?url=<%=request.getContextPath()%>/system/uSystemAction!orgList4muti.action&paraname=borgmall&paraid=borgmidall&p_item=2',600,450)"
					border=0 style="cursor:hand">
					<ais:orgSelector height="600" width="450" title="所有机构多选" paraId="borgmidall" paraName="borgmall" single="false" allShow="true"/>
			</div>
		
			<div>
				<s:textfield name="orgmf" label="带回调函数多选" theme="xhtml"></s:textfield>
				<s:textfield name="orgmfid"></s:textfield>
				&nbsp;
				<img
					src="<%=request.getContextPath()%>/resources/images/s_search.gif"
					onclick="showPopWin('search/searchdatamuti.jsp?url=<%=request.getContextPath()%>/system/uSystemAction!orgList4muti.action&paraname=orgmf&paraid=orgmfid&funname=getContact()',600,450)"
					border=0 style="cursor:hand">
			</div>
			<div>
				<s:textfield name="users" label="人员单选(本公司含部门及下级公司含部门):" theme="xhtml"></s:textfield>
				<s:textfield name="usersid"></s:textfield>
				&nbsp;
				<img
					src="<%=request.getContextPath()%>/resources/images/s_search.gif"
					onclick="showPopWin('search/frameselect4s.jsp?url=../userindex.jsp&paraname=users&paraid=usersid',600,450)"
					border=0 style="cursor:hand">
				<!-- 
					扩展的时候,需要增加参数如下
					eg.
						search/frameselect4s.jsp?url=../userindex.jsp&paraname=users&paraid=usersid&extend=5
				 -->
				 <ais:userSelector height="600" width="450" paraId="usersid" paraName="users" title="人员单选" cascadeShow="true"/>
			</div>
			<div>
				<s:textfield name="userm" label="人员多选(本公司含部门及下级公司含部门)" theme="xhtml"></s:textfield>
				<s:textfield name="usermid"></s:textfield>
				&nbsp;
				<img
					src="<%=request.getContextPath()%>/resources/images/s_search.gif"
					onclick="showPopWin('search/mutiselect.jsp?url=../userindex.jsp&paraname=userm&paraid=usermid&p_issel=1',600,450)"
					border=0 style="cursor:hand">
					<ais:userSelector height="600" width="450" paraId="usermid" paraName="userm" title="人员多选" cascadeShow="true" single="false"/>
			</div>
			<div>
				<s:textfield name="usersc1" label="人员单选抽调" theme="xhtml"></s:textfield>
				<s:textfield name="usersidc1"></s:textfield>
				&nbsp;
				<img
					src="<%=request.getContextPath()%>/resources/images/s_search.gif"
					onclick="showPopWin('search/frameselect4s.jsp?url=../userindex.jsp&paraname=usersc1&paraid=usersidc1&extend=1&p_item=2',600,450)"
					border=0 style="cursor:hand">
				<!-- 
					扩展的时候,需要增加参数如下
					eg.
						search/frameselect4s.jsp?url=../userindex.jsp&paraname=users&paraid=usersid&extend=5
				 -->
				 <ais:userSelector height="600" width="450" paraId="usersidc1" paraName="usersc1" title="人员单选抽调" chouDiao="true"/>
			</div>
			
			<div>
				<s:textfield name="usermc" label="人员多选抽调" theme="xhtml"></s:textfield>
				<s:textfield name="usermidc"></s:textfield>
				&nbsp;
				<img
					src="<%=request.getContextPath()%>/resources/images/s_search.gif"
					onclick="showPopWin('search/mutiselect.jsp?url=../userindex.jsp&paraname=usermc&paraid=usermidc&p_issel=1&extend=1',600,450)"
					border=0 style="cursor:hand">
					<ais:userSelector height="600" width="450" paraId="usersidc1" paraName="usersc1" title="人员单选抽调" chouDiao="true" single="false"/>
			</div>
			<div>
				<s:textfield name="busers" label="本机构人员单选(本公司含部门)" theme="xhtml"></s:textfield>
				<s:textfield name="busersid"></s:textfield>
				&nbsp;
				<img
					src="<%=request.getContextPath()%>/resources/images/s_search.gif"
					onclick="showPopWin('search/frameselect4s.jsp?url=../userindex.jsp&paraname=busers&paraid=busersid&p_item=1',600,450)"
					border=0 style="cursor:hand">
			<ais:userSelector height="600" width="450" paraId="busersid" paraName="busers" title="人员单选" internalShow="true"/>
			</div>
			<div>
				<s:textfield name="buserm" label="本机构人员多选(本公司含部门)" theme="xhtml"></s:textfield>
				<s:textfield name="busermid"></s:textfield>
				&nbsp;
				<img
					src="<%=request.getContextPath()%>/resources/images/s_search.gif"
					onclick="showPopWin('search/mutiselect.jsp?url=../userindex.jsp&paraname=buserm&paraid=busermid&p_issel=1&p_item=1',600,450)"
					border=0 style="cursor:hand">
					<ais:userSelector height="600" width="450" paraId="busersid" paraName="busers" title="人员多选" internalShow="true" single="false"/>
			</div>
			<br><br>针对多组织类型的选单调用：<br><br>
			<div>
			<s:textfield name="morgsname" label="所有多机构单选" theme="xhtml"></s:textfield>
			<s:textfield name="morgsid"></s:textfield>
			&nbsp;
			<img
				src="<%=request.getContextPath()%>/resources/images/s_search.gif"
				onclick="showPopWin('search/searchdata.jsp?url=<%=request.getContextPath()%>/system/uSystemAction!morgList.action&paraname=morgsname&paraid=morgsid',600,450,'组织机构选择')"
				border=0 style="cursor:hand">
				<ais:orgSelector height="600" width="450" title="所有多机构单选" paraId="borgsidcall" paraName="borgscall"  mutipal="true" allShow="true"/>
				
				
				</div>
				</div>
				<s:textfield name="morgsname_2" label="所有多机构多选" theme="xhtml"></s:textfield>
			<s:textfield name="morgsid_2"></s:textfield>
			<ais:orgSelector height="600" width="450" title="所有多机构多选" paraId="morgsid_2" paraName="morgsname_2" single="false" mutipal="true" allShow="true"/>
				<div>
				<div>
			<s:textfield name="morgsname2" label="本单位多机构单选[本公司含部门]" theme="xhtml"></s:textfield>
			<s:textfield name="morgsid2"></s:textfield>
			&nbsp;
			<img
				src="<%=request.getContextPath()%>/resources/images/s_search.gif"
				onclick="showPopWin('search/searchdata.jsp?url=<%=request.getContextPath()%>/system/uSystemAction!morgList.action&paraname=morgsname2&paraid=morgsid2&p_item=m1',600,450,'组织机构选择')"
				border=0 style="cursor:hand">
				<ais:orgSelector height="600" width="450" title="本单位多机构单选" paraId="borgsidcall" paraName="borgscall"  mutipal="true" internalShow="true"/>
		</div>
		<div>
			<s:textfield name="morgsname2_2" label="本单位多机构多选[本公司含部门]" theme="xhtml"></s:textfield>
			<s:textfield name="morgsid2_2"></s:textfield>
			<ais:orgSelector height="600" width="450" title="本单位多机构多选" paraId="morgsid2_2" paraName="morgsname2_2" single="false" mutipal="true" internalShow="true"/>
			&nbsp;
		</div>
		<div>
			<s:textfield name="morgsname2_3" label="本单位多机构单选[本公司含部门及下级公司]" theme="xhtml"></s:textfield>
			<s:textfield name="morgsid2_3"></s:textfield>
			&nbsp;
			<ais:orgSelector height="600" width="450" title="本单位多机构单选[本公司含部门及下级公司]" paraId="morgsid2_3" paraName="morgsname2_3"  mutipal="true" cascadeShow="true"/>
		</div>
		<div>
			<s:textfield name="morgsname2_4" label="本单位多机构多选[本公司含部门及下级公司]" theme="xhtml"></s:textfield>
			<s:textfield name="morgsid2_4"></s:textfield>
			&nbsp;
			<ais:orgSelector height="600" width="450" title="本单位多机构多选[本公司含部门及下级公司]" paraId="morgsid2_4" paraName="morgsname2_4" single="false" mutipal="true" cascadeShow="true"/>
		</div>
		
		<div>
				<s:textfield name="musers" label="多组织人员单选(本公司含部门及下级公司含部门):" theme="xhtml"></s:textfield>
				<s:textfield name="musersid"></s:textfield>
				&nbsp;
				<img
					src="<%=request.getContextPath()%>/resources/images/s_search.gif"
					onclick="showPopWin('search/frameselect4s.jsp?url=../morg/userindex4morg.jsp&paraname=musers&paraid=musersid',600,450)"
					border=0 style="cursor:hand">
				
			</div>
			<div>
				<s:textfield name="musersm" label="多组织人员多选(本公司含部门及下级公司含部门):" theme="xhtml"></s:textfield>
				<s:textfield name="musersmid"></s:textfield>
				&nbsp;
				<img
					src="<%=request.getContextPath()%>/resources/images/s_search.gif"
					onclick="showPopWin('search/mutiselect.jsp?url=../morg/userindex4morg.jsp&paraname=musersm&paraid=musersmid&p_issel=1',600,450)"
					border=0 style="cursor:hand">
				
			</div>
			<div>
				<s:textfield name="musersm2" label="基于条件的多组织人员多选(本公司含部门及下级公司含部门):" theme="xhtml"></s:textfield>
				<s:textfield name="musersmid2"></s:textfield>
				&nbsp;
				<img
					src="<%=request.getContextPath()%>/resources/images/s_search.gif"
					onclick="showPopWin('search/mutiselect.jsp?url=../rulesPubWin/userindex4morg.jsp&paraname=musersm2&paraid=musersmid2&p_issel=1&feedback_unit=1',600,450)"
					border=0 style="cursor:hand">
				
			</div>
			<div>
				<s:textfield name="musersm2_1" label="全部人员单多选:" theme="xhtml"></s:textfield>
				<s:textfield name="musersmid2_2"></s:textfield>
				&nbsp;
				<ais:userSelector title="全部人员单择" width="600" height="450" paraName="musersm2_1" paraId="musersmid2_2" allShow="true"/>
				<ais:userSelector title="全部人员多择" width="600" height="450" paraName="musersm2_1" paraId="musersmid2_2" allShow="true" single="false"/>
				
			</div>
		<div>
				<s:textfield name="vgname" label="人员群组多选" theme="xhtml"></s:textfield>
				<s:textfield name="vgid"></s:textfield>
				&nbsp;
				<img
					src="<%=request.getContextPath()%>/resources/images/s_search.gif"
					onclick="showPopWin('search/searchdatamuti.jsp?url=<%=request.getContextPath()%>/system/uSystemAction!getVgList.action&paraname=vgname&paraid=vgid',600,450)"
					border=0 style="cursor:hand">
			</div>
				<div>
			<s:textfield name="basic" label="基础信息树单选" theme="xhtml"></s:textfield>
			<s:textfield name="basicn"></s:textfield>
			&nbsp;
			<img
				src="<%=request.getContextPath()%>/resources/images/s_search.gif"
				onclick="showPopWin('search/searchdata.jsp?url=<%=request.getContextPath()%>/system/uSystemAction!basicList.action&paraname=basicn&paraid=basic&p_typecode=1003&p_check=0',600,450,'基础信息树选择')"
				border=0 style="cursor:hand">
		</div>
		<div>
			<s:textfield name="basicm" label="基础信息树多选" theme="xhtml"></s:textfield>
			<s:textfield name="basicnm"></s:textfield>
			&nbsp;
			<img
				src="<%=request.getContextPath()%>/resources/images/s_search.gif"
				onclick="showPopWin('search/searchdatamuti.jsp?url=<%=request.getContextPath()%>/system/uSystemAction!basicList.action&paraname=basicnm&paraid=basicm&p_typecode=1003&p_check=1',600,450,'基础信息树选择')"
				border=0 style="cursor:hand">
		</div>
			<br>
			<div>
			
				<br>
				<input type="checkbox" disabled="disabled">
				<s:textfield name="name" label="对象名称" theme="xhtml" />
				<br>
				<s:textfield name="pk" label="对象主键222" theme="xhtml" />
				<img
					src="<%=request.getContextPath()%>/resources/images/s_search.gif"
					onclick="showPopWin('search/mutiselect.jsp?url=<%=request.getContextPath()%>/mng/audobj/object/toAuditObjectConsultFrameAction.action&paraname=name&paraid=pk',600,450)"
					border=0 style="cursor:hand">
			</div>
			多组织check
			<br>
			<s:textfield name="name_1" label="名称" theme="xhtml" />
			<s:textfield name="pk_1" label="主键" theme="xhtml" />
			&nbsp;
			<img
				src="<%=request.getContextPath()%>/resources/images/s_search.gif"
				onclick="showPopWin('morg/chkmorgs.jsp?url=<%=request.getContextPath()%>/system/getMultiOrgListForUserModule.action&paraname=name_1&paraid=pk_1',600,450,'组织机构选择')"
				border=0 style="cursor:hand">
			<br>
			<%-- 
			列表多选 check
			<s:textfield name="name_2" label="名称" theme="xhtml" />
			<s:textfield name="pk_2" label="主键" theme="xhtml" />
			<br>
			&nbsp;
			<img
				src="<%=request.getContextPath()%>/resources/images/s_search.gif"
				onclick="showPopWin('search/searchdatamuti.jsp?url=<%=request.getContextPath()%>/pages/test/sampleCheckBoxList.jsp&paraname=name_2&paraid=pk_2',600,450,'组织机构选择')"
				border=0 style="cursor:hand">
			<br>
			--%>
			<br><br>
				<FCK:editor id="edittest"  basePath="/ais/resources/fckedit/" 
				toolbarSet="Default"
				 imageBrowserURL="/ais/resources/fckedit/editor/filemanager/browser/default/browser.html?Type=Image&Connector=connectors/jsp/connector"   
     linkBrowserURL="/ais/resources/fckedit/editor/filemanager/browser/default/browser.html?Connector=connectors/jsp/connector"   
     flashBrowserURL="/ais/resources/fckedit/editor/filemanager/browser/default/browser.html?Type=Flash&Connector=connectors/jsp/connector"   
     imageUploadURL="/ais/editor/filemanager/upload/simpleuploader?Type=Image"   
     linkUploadURL="/ais/resources/fckedit/editor/filemanager/upload/simpleuploader?Type=File"   
     flashUploadURL="/ais/resources/fckedit/editor/filemanager/upload/simpleuploader?Type=Flash">   
				决定发送克里夫吉安市离开
			</FCK:editor>
			
			<br>
			<img
							src="<%=request.getContextPath()%>/resources/images/s_search.gif"
							onclick="showPopWin('<%=request.getContextPath()%>/pages/system/search/mutiselect.jsp?url=<%=request.getContextPath()%>/pages/system/rulesPubWin/userindex4morg.jsp&paraname=name_1&paraid=pk_1&p_issel=1&feedback_unit=8abcd0991b7d36db011b7d3ca37d0166&feedback_unit_name=pppppp',600,450)"
							border="0" style="cursor:hand">
			<script type="text/javascript">
				function setCookie(c_name,value,expiredays)
{
var exdate=new Date()
exdate.setDate(exdate.getDate()+expiredays)
document.cookie=c_name+ "=" +escape(value)+
((expiredays==null) ? "" : ";expires="+exdate.toGMTString())
} 
setCookie("authObjIds",'8abcd0991b7d36db011b7d3ca37d0166');

			</script>
	</BODY>
</HTML>
