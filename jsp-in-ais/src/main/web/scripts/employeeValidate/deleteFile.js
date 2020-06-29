
/**
 * @author wangyuan
 */

var XMLHttpReq = false;
//创建一个XMLHttpRequest对象
function createXMLHttpRequest(){
	if(window.XMLHttpRequest){//Mozilla 浏览器
		XMLHttpReq = new XMLHttpRequest();
	}else if(window.ActiveXObject){//微软IE 浏览器
		try{
			XMLHttpReq = new ActiveXObject("Msxml2.XMLHTTP");//IE 6.0及6.0以上版本
		}catch(e){
			try{
				XMLHttpReq = new ActiveXObject("Microsoft.XMLHTTP");//IE 5.0版本
			}catch(e){
			}
		}
	}
}
var layerName = "";//指定删除之后回显的DIV标签对的id属性
//发送请求函数
function send(url, guid){
	createXMLHttpRequest();
	XMLHttpReq.open("GET", url, true);
	this.layerName = document.getElementById(guid).parentElement.id;
	XMLHttpReq.onreadystatechange = proce;//指定响应的函数
	XMLHttpReq.send(null);//发送请求
}
function proce(layerName){
	if(XMLHttpReq.readyState == 4){//对象状态
		if(XMLHttpReq.status == 200){//信息已成功返回，开始处理信息
			var resText = XMLHttpReq.responseText;
			document.getElementById(this.layerName).innerHTML=resText;
			window.alert("删除成功");
		}else{
			window.alert("所请求的页面有异常");
		}
	}
}
