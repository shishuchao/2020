
		function delOrEdit(checkboxName){//修改或删除时候的没有选择处理
			 var entries=document.getElementsByName(checkboxName);
			 var count=0;
			 for(var i=0;i<entries.length;i++){
			 	if(entries[i].checked==true)
			 	count++;
			 }
			 if(count==0){
			 
				 alert("请选择记录!");
				 return false;			 	 		 	
			 }
			 return true;
		}
		function selall_inform(name,selected){//全选处理  
		    if (selected==null || selected===''){
		   		 selected=true;
		    }
		    var checkbox=document.getElementsByName(name); 	
			    for(var i=0;i<checkbox.length;i++)
			     checkbox[i].checked=selected;   	    	  
		  } 
		  
		  
   function delete_submit(checkboxName){//删除处理                 
            if(delOrEdit(checkboxName)){            
              if(window.confirm("确定要删除选中的记录吗？")){

              document.forms[1].action="deleteAction.action";
              document.forms[1].submit();}
            }            
           }  
   function initUpdate_submit(checkboxName){//修改处理 
                  
            if(delOrEdit(checkboxName)){             
              document.forms[1].action="initUpdateAction.action";             
              document.forms[1].submit();
            }            
           }  
           
//***********************************************************************
   function delete_submit_other(checkboxName,url){//删除处理                 
            if(delOrEdit(checkboxName)){            
              if(window.confirm("确定要删除选中的记录吗？")){              
               openWindowByUrl(url+'&'+checkboxName+'='+getSelectedId(checkboxName));             
              }
            }            
           }  
   function initUpdate_submit_other(checkboxName,url){//修改处理                 
            if(delOrEdit(checkboxName)){            
                if(getSelectedId(checkboxName).length>1){//如果编辑选择多个，不让走                
                 alert('只能选择一个记录进行编辑！');
                 var checkbox=document.getElementsByName(checkboxName); 	
			     for(var i=0;i<checkbox.length;i++){//让中的都消失
			     checkbox[i].checked=false; 
			     }                
                 return false;
                }     
                     
               openWindowByUrl(url+'&'+checkboxName+'='+getSelectedId(checkboxName));
              
              }            
           }  

	
   function getSelectedId(checkboxName){ //得到选中的家伙  （如：'001,002'）
            var arr=Array();        
		    var checkbox=document.getElementsByName(checkboxName); 	
		    var count=0;  
			    for(var i=0;i<checkbox.length;i++){
			  	
			   
			    if(checkbox[i].checked==true){			   	  
			     arr[count]=checkbox[i].value;
			     count=count+1;
                }
                }
                
                return arr;               
}		         
//-------------普通弹出窗口----刷新父窗口-------------------------------------
function openWindowByUrl_common(url){//打开模态窗口
window.open(url,'操作窗口',  'height=600,width=900,top=0,left=200,toolbar=no,menubar=no,scrollbars=auto, resizable=no,location=no, status=no');
}

function init_common(){
window.opener.location.href=window.opener.location.href;//最新解决
//window.opener.location.reload();//曾经不好使过
}
//-----------------模态窗口------刷新父窗口------------------------------
function openWindowByUrl(url){//打开模态窗口
var arg=new Object();//传递进去的参数
arg.win=window;//把当前窗口的引用当参数传进去
//arg.str="argument";//要传进去的其他参数
//window.showModalDialog("son.htm",arg,'help:no');
//newopen=window.open(url, 'newopen',  'height=300,width=800,top=0,left=200,toolbar=no,menubar=no,scrollbars=auto, resizable=no,location=no, status=no')   
//setInterval('wen()',10); 
newopen=showModalDialog(url,arg ,"dialogHeight:548px;dialogWidth:708px;center:yes;status:no;resizable:no;");
}

function refreshWindow(){//模态窗口刷新父窗口
window.location.reload();
}


function reWin(){
//window.opener.parent.location.reload();window.close()
//window.returnValue="这里存放返回的结果";
var arg=window.dialogArguments;
arg.win.refreshWindow();
window.close();
}

function init(){
reWin();
}

			/*
			*  打开或关闭查询面板
			*/
			function triggerSearchTable(){
				var isDisplay = document.getElementById('searchTable').style.display;
				if(isDisplay==''){
					document.getElementById('searchTable').style.display='none';
				}else{
					document.getElementById('searchTable').style.display='';
				}
			}
//***********************************************************************                     		  