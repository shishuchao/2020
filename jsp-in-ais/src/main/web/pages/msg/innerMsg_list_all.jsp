<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML>
<html>
<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<title>消息</title>
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>  
</head>

<body>
<div class="easyui-layout" fit="true" id="layout" style="width: 100%;">
       	   <div style="width: 60%;position:absolute;top:0px;right:10px;text-align: right;z-index: 1000;">
                   <a class="easyui-linkbutton" data-options="iconCls:'icon-edit'" onclick="return addMsg()">新建消息</a>
			</div>
			
  <div region="center">
    <div class="easyui-tabs" fit="true" id="yearTabs" border='0'>
         		<div  id='mynews' title='提示信息' >
		                 <iframe id="news_ifr" name="news_ifr" src="<%=request.getContextPath()%>/msg/innerMsg_list.action?readFlag=-1" width="100%"  height="100%" marginheight="0" marginwidth="0" frameborder="0" scrolling="hidden" ></iframe>
		        </div>
		        <div  id='weidu' title='未读消息' style="overflow:hidden;">
		                 <iframe id="weidu_ifr" name="weidu_ifr" src="" width="100%" height="100%" marginheight="0" marginwidth="0" frameborder="0" scrolling="hidden" ></iframe>
				</div> 
				<div id='yidu' title='已读消息' style="overflow:hidden;">
					     <iframe id="yidu_ifr" name="yidu_ifr" src="" width="100%" height="100%" marginheight="0" marginwidth="0" frameborder="0" scrolling="hidden"></iframe>
				</div>
				<div id='yifa' title="已发消息" style="overflow:hidden;">
					     <iframe id="yifa_ifr" name="yifa_ifr" src="" width="100%" height="100%" marginheight="0" marginwidth="0" frameborder="0" scrolling="hidden" ></iframe>
				</div>
				<div  id='eamil' title='已发邮件' style="overflow:hidden;">
					     <iframe id="email_ifr" name="email_ifr" src="" width="100%" height="100%" marginheight="0" marginwidth="0" frameborder="0" scrolling="hidden"></iframe>
				</div>
    </div>

    		<div id="tempMailDiv"  title='新建消息' style='width:100%;overflow: hidden;' >
	  			<iframe id="innermsg_ifr"  frameborder="0" scrolling="hidden" style="width:100%;height:100%;" src="" ></iframe>
	  		</div>
 </div>
</div>
	</body>
	<script type="text/javascript">
	$(function(){
		$('#yearTabs').tabs({
            onSelect:function(title){
                  if(title == '未读消息') {
                    if ($('#weidu_ifr')){
                        var url = "<%=request.getContextPath()%>/msg/innerMsg_list.action?readFlag=2";
                        $('#weidu_ifr').attr('src', url);
                    }
                }else if(title == '已读消息') {
                    if ($('#yidu_ifr')){
                        var url = "<%=request.getContextPath()%>/msg/innerMsg_list.action?readFlag=1";
                        $('#yidu_ifr').attr('src', url);
                    }
                }else if(title == '已发消息') {
                    if ($('#yifa_ifr')){
                        var url = "<%=request.getContextPath()%>/msg/innerMsg_list.action?readFlag=3";
                        $('#yifa_ifr').attr('src', url);
                    }
                }else if(title == '已发邮件') {
                    if ($('#email_ifr')){
                        var url = "<%=request.getContextPath()%>/msg/innerMsg_list.action?readFlag=4";
                        $('#email_ifr').attr('src', url);
                    }
                }
            }
        })
        
        
		$('#tempMailDiv').window({
			width: $('body').width()*0.95< 800 ? 800 : $('body').width()*0.95,
			height:550,
			top:$('body').height()*0.1< 100 ? 100 : $('body').height()*0.1,
			modal: true,
			shadow: true,
			closed: true,
			collapsible:false,
			maximizable:true,
			minimizable:true
		});
	});


	function addMsg(){
		var vurl = "";
		vurl ="${contextPath}/msg/innerMsg_edit.action?readFlag=3&toFirst=1";
		$('#innermsg_ifr').attr("src",vurl);
        $('#tempMailDiv').window('open');
	}


	</script>
</html>
