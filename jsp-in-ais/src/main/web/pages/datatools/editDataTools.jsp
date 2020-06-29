<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <head>
        <title>基本设置</title>
        <meta http-equiv="content-type" content="text/html; charset=UTF-8">
        <meta http-equiv="pragma" content="no-cache">
        <meta http-equiv="cache-control" content="no-cache">
        <meta http-equiv="expires" content="0">
        <link href="${contextPath}/styles/main/ais.css" rel="stylesheet" type="text/css" />
        <script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
        <script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
        <script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
        <script type="text/javascript" src="${contextPath}/scripts/ufaudTextLengthValidator.js"></script>
   
        <style type="text/css">
          
    </style>
    </head>
    <body>
        
        <table cellpadding=0 cellspacing=1 border=0 bgcolor="#409cce"
            class="ListTable" width="100%" align="center">
            <tr class="listtablehead">
                <td colspan="4" class="edithead" style="text-align: left;width: 100%;">
                    <s:property escape="false" value="@ais.framework.util.NavigationUtil@getNavigation('/ais/datatools/editDataTools.action')"/>
                </td>
            </tr>
        </table>
        <s:form id="dataToolsForm" action="saveDataTools" namespace="/datatools" >
            <table id="dataToolsTable" cellpadding=0 cellspacing=1 border=0
                bgcolor="#409cce" class="ListTable" align="center" style="width: 100%;">
                <tr>
                    <td class="ListTableTr11" nowrap="nowrap" style="text-align: left;">
                        <br>
                        
                        <fieldset>
                            <legend>源数据库信息</legend>
                            <br>
                            <table >
                            <tr>
                            <td>
                          服务器IP：<s:textfield id="sourceHost" name="datatools.sourceHost" maxlength="50" title="服务器IP" />
                          </td>
                          <td>
                           服务器端口：<s:textfield id="sourcePort" name="datatools.sourcePort" maxlength="50" title="IP地址" />
                           </td>
                          <td>
                            服务器数据库名称：<s:textfield id="sourceDbName" name="datatools.sourceDbName" size="10" maxlength="10" title=" 服务器数据库名称" />
                             </td>
                            </tr>
                             <tr>
                              <td>
                            服务器类型：<s:select name="datatools.sourceType" id="sourceType"  list="#@java.util.LinkedHashMap@{'':'','db2':'DB2','mysql':'MySql','oracle':'Oracle'}" ></s:select>
                            </td>
                          <td>
                           数据库用户名：<s:textfield id="sourceUserName" name="datatools.sourceUserName" size="10" maxlength="50" title="用户名" />
                            </td>
                          <td>
                            数据库密码：
                              <input type=password id="sourcePassword" value="${datatools.sourcePassword}"/>
                            <s:hidden name="datatools.sourceTestSql" id="sourceTestSql"></s:hidden>
                            </td>
                            </tr>
                            <tr>
                             <s:button value="测试是否连通" onclick="testSourceConn()"/>
                            </tr>
                            </table>
                           
                        </fieldset>
                        <div style="display:none">
                        <fieldset>
                       <legend>目标数据库信息</legend>
                            <br>
                            <table >
                            <tr>
                            <td>
                          服务器IP：<s:textfield id="targetHost" name="datatools.targetHost" maxlength="50" title="服务器IP" />
                          </td>
                          <td>
                           服务器端口：<s:textfield id="targetPort" name="datatools.targetPort" maxlength="50" title="IP地址" />
                           </td>
                          <td>
                            服务器数据库名称：<s:textfield id="targetDbName" name="datatools.targetDbName" size="10" maxlength="10" title=" 服务器数据库名称" />
                             </td>
                            </tr>
                             <tr>
                              <td>
                            服务器类型：<s:select name="datatools.targetType" id="targetType"  list="#@java.util.LinkedHashMap@{'':'','db2':'DB2','mysql':'MySql','oracle':'Oracle'}" ></s:select>
                            </td>
                          <td>
                           数据库用户名：<s:textfield id="targetUserName" name="datatools.targetUserName" size="10" maxlength="50" title="用户名" />
                            </td>
                          <td>
                            数据库密码：
                            <input type=password id="targetPassword" value="${datatools.targetPassword}"/>
                            <s:hidden name="datatools.targetTestSql" id="targetTestSql"></s:hidden>
                            </td>
                            </tr>
                            <tr>
                             <s:button value="测试是否连通" onclick="testTargetConn()"/>
                            </tr>
                            </table>
                        </fieldset>
                        </div>
                    </td>
                </tr>
                 <tr>
                    <td class="ListTableTr11" nowrap="nowrap" style="align:right;text-align: right;">
                    <s:button value="执行采数" id="exedata" onclick="exedatatools()"/>&nbsp;&nbsp;&nbsp;
                    <s:button value="处理数据" id="exedataexchage" onclick="exedatatools4exchange()"/>&nbsp;&nbsp;&nbsp;
                         <s:button value="保存参数" id="savedata" onclick="savedatatools()"/>&nbsp;&nbsp;&nbsp;
                    <s:button value="重载参数" id="reloadpage" onclick="javascript:window.location.reload();"/>&nbsp;&nbsp;&nbsp;    
                    </td>
                  </tr>
                 <tr>
                    <td class="listtabletr11" style="height: 300px;text-align: left;vertical-align: top;" colspan="3">
                    <div id="consoleTd"  style="height:250px;text-align: left;vertical-align: top;overflow:scroll;">
                    </div>
                    </td>
                  </tr>
                 
            </table>
        </s:form>
        <div id="divCenter" style="display:none; text-align: center;position:absolute;z-index:3;">
        <table width="100%" height="100%" border="0" style="height: 50px;border: 1px;width: 100%;">
                <tr>
                    <td align="center">
                        <center>
                        <b><font color="#007fff">正在处理中，请稍候... ...</font></b>
                        </center>
                    </td>
                </tr>
            </table>
        </div>      
        <div id="cdiv" style=" display:none;background-color: #D9D9D9; filter:alpha(opacity=70);-moz-opacity:0.5; opacity:0.5;left:0px;position:absolute;top:0px; width:100%; height:800px"></div>
        <script type="text/javascript">
        var dbhost = "";
        var dbport= "";
        var dbname= "";
        var dbtype="";
        var dbusername= "";
        var dbpassword= "";
        var dbtestsql= "";
        var timerID="";
        /**
        *保存配置文件
        */
        function savedatatools(){
        	var retVal="";
        	var sourcehost = document.getElementById("sourceHost").value;
        	var sourceport= document.getElementById("sourcePort").value;
        	var sourcename= document.getElementById("sourceDbName").value;
        	var sourcetype=document.getElementById("sourceType").options[document.getElementById("sourceType").selectedIndex].value;
        	var sourceusername= document.getElementById("sourceUserName").value;
        	var sourcepassword= document.getElementById("sourcePassword").value;
        	var sourcetestsql= document.getElementById("sourceTestSql").value;

        	var targethost = document.getElementById("targetHost").value;
        	var targetport= document.getElementById("targetPort").value;
        	var targetname= document.getElementById("targetDbName").value;
        	var targettype=document.getElementById("targetType").options[document.getElementById("targetType").selectedIndex].value;
        	var targetusername= document.getElementById("targetUserName").value;
        	var targetpassword= document.getElementById("targetPassword").value;
        	var targettestsql= document.getElementById("targetTestSql").value;

            
        	DWREngine.setAsync(false);
        	DWREngine.setAsync(false);DWRActionUtil.execute(
        	{ namespace:'/datatools', action:'saveDataTools', executeResult:'false' }, 
        	{'sourceHost':sourcehost,'sourcePort':sourceport,'sourceDbName':sourcename,'sourceType':sourcetype,
             'sourceUserName':sourceusername,'sourcePassword':sourcepassword,'sourceTestSql':sourcetestsql,
             'targetHost':targethost,'targetPort':targetport,'targetDbName':targetname,'targetType':targettype,
             'targetUserName':targetusername,'targetPassword':targetpassword,'targetTestSql':targettestsql
            },
        	xxx);
        	function xxx(data){
        		retVal = data['saveFlag'];
        	}
            if(retVal=="ok"){
                alert("保存成功！");
            }else{
                alert("保存失败！");
            }
        }
        /**
         *执行存储过程 主方法
         */
        function exedatatools4exchange(){
        	showProcess();
        	dbhost = document.getElementById("targetHost").value;
            dbport= document.getElementById("targetPort").value;
            dbname= document.getElementById("targetDbName").value;
            dbtype=document.getElementById("targetType").options[document.getElementById("targetType").selectedIndex].value;
            dbusername= document.getElementById("targetUserName").value;
            dbpassword= document.getElementById("targetPassword").value;
            dbtestsql= document.getElementById("targetTestSql").value;
            //延迟执行，为了让“正在处理”出来
            setTimeout("exeProcedure()",1000);
        }
        /**
         *执行存储过程 调用方法
         */
        function exeProcedure(){
        	var retVal="";
        	DWREngine.setAsync(false);
        	DWREngine.setAsync(false);DWRActionUtil.execute(
        	{ namespace:'/datatools', action:'exedatatools4exchange', executeResult:'false' }, 
        	{'dbhost':dbhost,'dbport':dbport,'dbname':dbname,'dbusername':dbusername,'dbpassword':dbpassword,'dbtestsql':dbtestsql,'dbtype':dbtype},
        	xxx);
        	function xxx(data){
        		retVal = data['exe4chageFlag'];
        	}
            if(retVal=="10"){
                alert("数据处理成功！");
                hideProcess();
            }else{
                alert("数据处理失败1");
                hideProcess();
            }
        }
        /**
         *定时更新groovy的插入日志
         */
        function exedatatools(){
        	var retVal="";
        	document.getElementById("consoleTd").innerHTML="";
        	DWREngine.setAsync(false);
        	DWREngine.setAsync(false);DWRActionUtil.execute(
        	{ namespace:'/datatools', action:'exeDataTools', executeResult:'false' }, 
        	{},
        	xxx);
        	function xxx(data){
        		retVal = data['exeFlag'];
        	}
        	timerID = setInterval("showMessage()",15000);
            
        }
        function disableTimer(){
        	clearInterval(timerID);
        }
        function showMessage(){
        	var reValmessage="";
            var reValflagmessage="";
            DWREngine.setAsync(false);
            DWREngine.setAsync(false);DWRActionUtil.execute(
                    { namespace:'/datatools', action:'readLogFile', executeResult:'false' }, 
                    {},
                    xxx1);
            function xxx1(data){
                reValflagmessage=data['fileFlag'];
                reValmessage = data['fileOutMessage'];
                if(reValflagmessage=="true"){
                    document.getElementById("consoleTd").innerHTML=reValmessage;
                    if(reValmessage.indexOf("成功")!=-1){
                    	disableTimer();
                        alert("采集成功");
                        document.getElementById("exedataexchage").disabled="false";
                    }
                }
            }
        }
        /**
         *显示“正在处理”对话框
         */
        function showProcess(){
        	document.getElementById('divCenter').style.display="block";
         	document.getElementById('divCenter').style.left = (document.body.offsetWidth - 540) / 2; 
         	document.getElementById('divCenter').style.top = (document.body.offsetHeight - 170) / 2 + document.body.scrollTop;
            document.getElementById("cdiv").style.display="block";
        }
        /**
         *隐藏“正在处理”对话框
         */
        function hideProcess(){
            document.getElementById('divCenter').style.display="none";
       	    document.getElementById('cdiv').style.display="none";
        }
        function testSourceConn(){
        	showProcess();
        	dbhost = document.getElementById("sourceHost").value;
            dbport= document.getElementById("sourcePort").value;
            dbname= document.getElementById("sourceDbName").value;
            dbtype=document.getElementById("sourceType").options[document.getElementById("sourceType").selectedIndex].value;
            dbusername= document.getElementById("sourceUserName").value;
            dbpassword= document.getElementById("sourcePassword").value;
            dbtestsql= document.getElementById("sourceTestSql").value;
            setTimeout("testConn()",1000); 
        	
        }
        function testConn(){
        	var retVal="";
        	DWREngine.setAsync(false);
        	DWREngine.setAsync(false);DWRActionUtil.execute(
        	{ namespace:'/datatools', action:'testConn', executeResult:'false' }, 
        	{'dbhost':dbhost,'dbport':dbport,'dbname':dbname,'dbusername':dbusername,'dbpassword':dbpassword,'dbtestsql':dbtestsql,'dbtype':dbtype},
        	xxx);
        	function xxx(data){
        		retVal = data['connFlag'];
        	}
            if(retVal=="true"){
                alert("连接成功");
                hideProcess();
            }else{
                alert("连接失败，请检查配置参数!");
                hideProcess();
            }
        
        }
        function testTargetConn(){
        	showProcess();
        	dbhost = document.getElementById("targetHost").value;
            dbport= document.getElementById("targetPort").value;
            dbname= document.getElementById("targetDbName").value;
            dbtype=document.getElementById("targetType").options[document.getElementById("targetType").selectedIndex].value;
            dbusername= document.getElementById("targetUserName").value;
            dbpassword= document.getElementById("targetPassword").value;
            dbtestsql= document.getElementById("targetTestSql").value;
            setTimeout("testConn()",1000);
        }
         
            
        </script>
        
    </body>
</html>