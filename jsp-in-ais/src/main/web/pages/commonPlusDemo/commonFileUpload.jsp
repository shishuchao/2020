<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE HTML >
<html>
<title>通用控件(树形、数据表格)Demo</title>
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">        
    <script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
    <script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>        
    <script type="text/javascript" src="${contextPath}/resources/js/jquery-fileUpload.js"></script>
</head>
<body>
<div id="container" class='easyui-layout' fit='true' border='0'>	
    <div region="center"  border='0'>
         <div id="qtab" class="easyui-tabs"  fit="true" border='0'>
         <!-- 
         	 <div title='simple' id='tab1'>
         	 	<form action="/ais/commonPlug/commonUploadFiles.action" method="post" enctype="multipart/form-data">
         	 	    <input type="file" name="simpleUpload"/>
         	 		<input type='submit'/>
         	 	</form>
            </div>
          -->
            <div title='class初始化上传' id='tab4'>
                <div id="upload01" 
                    data-options="
                    fileGuid:-1, 
                    isAdd:true, 
                    isEdit:true, 
                    isDel:true, 
                    isView:true, 
                    isDownload:true, 
                    isdebug:true, 
                    fileGridTitle:'附件上传测试',
                    msgShowType:2,
                    gridBorder:false,
                    zipPackageName:'附件导出.zip'"
                    class="easyui-fileUpload"></div>
                
            </div> 
           
            <div title='JS初始化上传' id='tab5'>
                <button id='upload02Tg'>JS初始化控件</button>
                <button id='upload02Tg2'>文件信息(用于自定义回显)</button>
                <button id='upload02Tg3'>查询(fileName like '%审计%')</button>
                <div id="upload02"></div>
                <div id="showFileDataJson" 
                    style='text-align:left;
                    border:1px solid gray;
                    background-color:#fcfcfc; 
                    padding:5px;'>
                </div>
                <script type="text/javascript">
                    $('#upload02Tg').bind('click', function(){
                        // 只执行一次
                        $('#upload02').fileUpload({
                            fileGuid:-1
                        });
                       // $('#upload02Tg').hide();
                    });
                    $('#upload02Tg2').bind('click',function(){
                        var rtData = $('#upload02').fileUpload('getUploadFiles', {}); 
                        var arr = [];
                        for(var p in rtData){
                            arr.push("'"+p+"':"+rtData[p]);
                        }
                        $("#showFileDataJson").html("{"+arr.join(",</br>")+"}");
                    });
                    $('#upload02Tg3').bind('click',function(){
                        $('#upload02').fileUpload('reloadFileGrid', {
                            query_like_fileName:'审计' // 针对fileban的查询条件
                        });
                    });
                    
                </script>
            </div>
            <div title='自定义回显文件' id='tab6'>
                <button id='upload03Tg'>上传界面</button>
                <button id='upload03Tg2'>文件信息(用于自定义回显)</button>
                <div id="upload03"  
                        class="easyui-fileUpload"
                        data-options="
                        fileGuid:-1, 
                        triggerId:'upload03Tg', 
                        echoType:3" ></div>
                <div id="showFileDataJson2" 
                        style='text-align:left;
                        border:1px solid gray;
                        background-color:#fcfcfc; 
                        padding:5px;'>
                </div>
                <script type="text/javascript">
                    $('#upload03Tg2').bind('click',function(){
                        var rtData = $('#upload03').fileUpload('getUploadFiles');  
                        var arr = [];
                        for(var p in rtData){
                            arr.push("'"+p+"':"+rtData[p]);
                        }
                        $("#showFileDataJson2").html("{"+arr.join(",</br>")+"}");
                    });                           
                </script>
            </div>
            <div title='menuButton回显文件' id='tab7'>
                <button id='upload04Tg'>上传界面</button>
                <button id='upload04Tg2'>文件信息(用于自定义回显)</button>
                <button id='upload04Tg3'>刷新回显</button>
                
                <div id="showFileDataJson3" 
                        style='text-align:left;
                        border:1px solid gray;
                        background-color:#fcfcfc; 
                        padding:5px;'>
                </div>
                
                <div id="upload04"></div>
                
                <script type="text/javascript">
                    $('#upload04').fileUpload({
                        fileGuid:-1,
                        triggerId:'upload04Tg',
                        isDel:true,
                        echoType:2,
                        onFileSubmitSuccess:function(data){
                            
                        }
                    });
                    $('#upload04Tg2').bind('click',function(){
                        var rtData = $('#upload04').fileUpload('getUploadFiles');  
                        var arr = [];
                        for(var p in rtData){
                            arr.push("'"+p+"':"+rtData[p]);
                        }
                        $("#showFileDataJson3").html("{"+arr.join(",</br>")+"}");
                    });  
                    $('#upload04Tg3').bind('click', function(){
                        $('#upload04').fileUpload('reloadFileMenuBtn'); 
                    });
                </script>
            </div>
            <div title='简单上传' id='tab8'>   
                <div id='upload05Tg'></div>
                <button id='upload05Tg1'>刷新回显</button></br>
                动态改变参数, 如:fileGuid
                <input type='text' id='changeFileGuid2' value="-1"/>
                <button onclick="changeFileUploadProerty('upload05', 'fileGuid', changeFileGuid2.value)">改变控件属性</button>
                <div id="upload05"  
                        class="easyui-fileUpload"
                        data-options="
                        fileGuid:-1, 
                        uploadFace:1,
                        triggerId:'upload05Tg',
                        onDeleteFile:function(fileIdList){
                            alert('onDeleteFile:\n'+fileIdList)
                            var rt = true;//true:执行删除， false：终止删除
                            return rt;
                        },
                        onDeleteFileSuccess:function(data, fileIdList){ 
                            alert('onDeleteFileSuccess:\n'+data.type +'\n'+data.msg+'\n'+fileIdList) 
                        }
                     " >
                </div>
                <script type="text/javascript">
                    $('#upload05Tg1').bind('click', function(){
                        $('#upload05').fileUpload('reloadFile'); 
                    });
                </script>
            </div>
            
            <div title='简单上传2' id='tab9'>   
                <div id='upload06Tg'></div>
                <button id='upload06Tg1'>刷新回显</button></br>
                动态改变参数, 如:fileGuid
                <input type='text' id='changeFileGuid' value="-1"/>
                <button onclick="changeFileUploadProerty('upload06', 'fileGuid', changeFileGuid.value)">改变控件属性</button>
                <button onclick="getGuid()">获得guid</button>
                <div id="upload06"  
                        class="easyui-fileUpload"
                        data-options="
                        fileGuid:-1, 
                        uploadFace:1,
                        triggerId:'upload06Tg', 
                        echoType:2" >
                </div>
                <script type="text/javascript">
                    function changeFileUploadProerty(objId, key, value){
                        //alert(key+'='+value)
                        $('#'+objId).fileUpload('property', key, value); 
                    }
                    $('#upload06Tg1').bind('click', function(){
                        $('#upload06').fileUpload('reloadFile'); 
                    });
                    function getGuid(){
                        var opt1 = $('#upload05').fileUpload('options'); 
                        var opt2 = $('#upload06').fileUpload('options'); 
                        alert('upload05.guid:'+opt1.fileGuid+'\nupload06.guid:'+opt2.fileGuid);
                    }
                </script>
            </div>
            

            <div title="自定义menubutton" id='tab9'>
                <div id='upload07Tg'></div>
                <button id='upload07Tg1'>刷新回显</button>&nbsp;
                <button id='upload07Tg2'>添加menuitem</button></br>
                <div id="upload07"  
                        class="easyui-fileUpload"
                        data-options="
                        fileGuid:-1, 
                        uploadFace:1,
                        triggerId:'upload07Tg', 
                        echoType:2 " >
                </div>
                <script type="text/javascript">
                    $('#upload07Tg1').bind('click', function(){
                        $('#upload07').fileUpload('reloadFile'); 
                    });
                    $('#upload07Tg2').bind('click', function(){
                        // 第一种写法， 添加多个条目
                        $('#upload07').fileUpload('addmenutiem', [{
                             text:'发送消息',
                             //iconCls:'icon-ok', 如果没有默认为icon-ok
                             handler:function(fileId, fileName){
                                 alert("发送消息\nfileId="+fileId+"\nfileName="+fileName);
                             }
                         },{
                             text:'发送邮件',
                             iconCls:'icon-email',
                             handler:function(fileId, fileName){
                                 alert("发送邮件\nfileId="+fileId+"\nfileName="+fileName);
                             }
                         }]);
                         // 第二种写法， 添加单个条目
                         $('#upload07').fileUpload('addmenutiem',{
                             handler:function(fileId, fileName){
                                 alert("自定义\nfileId="+fileId+"\nfileName="+fileName);
                             }
                         });
                    });
                </script>
            </div>
            
             <div title="JS和HTML同时定义" id='tab10'>
				<button id='t1'>加载1</button>
				<button id='t2'>加载2</button>
				<button id='t3'>加载3</button>
				<button id='t4'>删除全部</button>
				<button id='t5'>上传全部</button>
				<button id='tt'>刷新</button>
				<div id="upload10" class="easyui-fileUpload" singleSubmit=false></div>
				
				<script type="text/javascript">
					function showGuid(){
						alert($('#upload10').fileUpload('options').callbackGridParams.query_eq_guid +"\n"+$('#upload10').fileUpload('property', 'fileGuid'));
					}
				
					$('#t1').bind('click', function(){
						//showGuid();
						$('#upload10').fileUpload('property','fileGuid','9E96E8EF-AAF5-E6BD-EED0-4B13C16B1353');
						$('#upload10').fileUpload('reloadFile');
						//showGuid();
					});
					$('#t2').bind('click', function(){
						//showGuid();
						//更新控件options时，重新加载附件list
						$('#upload10').fileUpload({
							'fileGuid':'F207C7EA-BC79-826B-BABF-6C8B26753E69'
						});
						//showGuid();
					});
				
					$('#t3').bind('click', function(){
						//showGuid();
						$('#upload10').fileUpload('property','fileGuid','08EF1EDA-87BA-886F-267E-0D93C6549FEC');
						$('#upload10').fileUpload('reloadFile');
						//showGuid();
					});
					
					$('#t4').bind('click', function(){
						$('#upload10').fileUpload('deleteAll');
					});
					
					$('#tt').bind('click', function(){
						//showGuid();
						//$('#upload10').fileUpload('property','fileGuid','65039709-DB35-03AC-DF80-68F6D142B27A');
						$('#upload10').fileUpload('reloadFile');
						//showGuid();
					});	
				</script>
             
             </div>
             <!---->
        </div>	
    </div>
</div>
</body>
</html>