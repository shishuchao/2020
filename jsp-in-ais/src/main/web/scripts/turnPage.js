     var maxPage=1;
   //是否打开缩进功能
   var isOmission = true;
   //如果超过规定字数自动缩进
   var countOfWord = 21;

   // add by qfuce, 2013.3.19, 解决页数调整input第二次不能填入页数的问题
   function setSearchput(){
       var obj = document.getElementById('searchput');
       if(obj){
          obj.setAttribute('maxLength',2); 
       }
    }

   function initGoToPage() { 

   	var spans = document.getElementsByTagName("span");
   	var v;
   	var ee = "";
   	var pagebanner;
   	var totalRecord = 0;
   	for (var i = 0; i < spans.length; i++) {
   		if (spans[i].className == "pagelinks") {
   			v = spans[i];
   			ee = i;
   		}
   		if(spans[i].className == "pagebanner"){
   			pagebanner = spans[i];
   			var totalRecordText = pagebanner.innerText;
   			totalRecord = totalRecordText.substring(totalRecordText.indexOf('到')+1,totalRecordText.indexOf('条'));
   			pagebanner.clearAttributes();
   			pagebanner.innerHTML = '';
   		}
   	}
   	maxPage=findMaxPage(spans[ee],maxPage);
   	var aa = document.createElement("a");
   	var input = document.createElement("input");
   	input.size = 2;
   	input.type = 'text';
   	input.id = "searchput";
   	//v.innerHTML += "&nbsp;&nbsp;&nbsp;&nbsp;<font color='#1b6252' > 共<strong>"+maxPage+"</strong>页/<strong>"+totalRecord+"</strong>条&nbsp;&nbsp;跳转至</font>";
   	v.innerHTML += "&nbsp;&nbsp;&nbsp;&nbsp;<font color='#1b6252' > </font>";
   	v.appendChild(aa);      
    v.appendChild(input);
   	var ft=document.createElement("span");
   	ft.innerHTML+="<font color='#1b6252'>页&nbsp;&nbsp;&nbsp;共<strong>"+maxPage+"</strong>页/<strong>"+totalRecord+"</strong>条</font>";

    v.appendChild(ft);

   	aa.innerHTML += "\u8df3\u5230";
   	aa.href = "#";
   	aa.attachEvent('onclick', function () {
   		goToPage(ee);
   	});
   	input.onkeypress=function(){
   		 if(event.keyCode==13){
            window.event.returnValue = false; 
   		 	goToPage(ee);
   		 }
   	};
   	//改变table显示内容，如果超长就缩进，并出来按钮，点击全部显示内容。
   	if(isOmission){
   		var _tabListObj;
   		var _tabObjs = document.getElementsByTagName("tbody");
   		if(_tabObjs){
   			if(_tabObjs.length){
   				//针对于用display-tag的页面，目前所有页面获得的tbody的个数是3个，这里先写死，如果有特殊情况，再做处理
   				if(_tabObjs.length==3){
   					_tabListObj = _tabObjs[2];
   				}else{
   					return;
   				}
   			}
   		}
   		//列表的每行
   		var _row;
   		//每行中的每个格
   		var _cell;
   		for(var i=0;i<_tabListObj.rows.length;i++){
   			_row = _tabListObj.rows[i];
   			for(var j=0;j<_row.childNodes.length;j++){
   				_cell = _row.childNodes[j];
   				var _cellContent = _cell.innerText;
   				//去除内容中的空格
   				_cellContent = _cellContent.replace(/\s+/g,'');
   				//如果内容的长度大于规定的长度则进行处理
   				//根据屏幕分辨率设定截取字符大小
   				var _sWidth = screen.width;
   				var _sHeight = screen.height;
   				//宽屏是1.6 普屏是1.33333...
   				if(_sWidth/_sHeight>1.5){
   					countOfWord=30;
   				}
   				if(_cellContent.length>countOfWord){
   					var _tempHTML = _cell.innerHTML+"";
   					var _tempString = _cellContent.substring(0,countOfWord)+"...";
   					_cell.innerHTML = _tempHTML.replace(_cellContent,_tempString);
   					_cell.setAttribute("title",_cellContent);
   				}
   			}
   		}
   		
   	}
   	setSearchput();
   }
   function goToPage(ee) {
   	var objInput = document.getElementById("searchput");
   	var value = objInput.value;
   	var reg = /^[0-9]*$/;
   	if (value.length < 1 || !reg.test(value)) {
   		alert("请输入大于0的数字");
   		objInput.value ='';
   		objInput.focus();
   		return false;
   	}
   	if (value.length > 20) {
   		alert("\u8f93\u5165\u6570\u5b57\u957f\u5ea6\u8fc7\u957f");
   		objInput.value ='';
   		objInput.focus();
   		return false;
   	}
   	if (value == 0) {
   		alert("\u8f93\u5165\u5927\u4e8e0\u7684\u6570\u5b57");
   		objInput.value ='';
   		objInput.focus();
   		return false;
   	}
   	var temp = document.getElementsByTagName("span");
   	v = temp[ee];
   	var aas = v.getElementsByTagName("a");
   	var href = "";
   	var reg = /^d-[0-9]+-p=[0-9]*$/;
   	for (var i = 0; i < aas.length; i++) {
   		var h = aas[i].href.split("?");
   		href2 = h[0];
   		var cc = h[1].split("&");
   		var hhhh = "";
   		for(var j=0;j<cc.length;j++){
   			if(reg.test(cc[j])){
   				hhhh = cc[j];
   				break;
   			}
   		}
   		if (hhhh.length>0&&aas[i].href.length > href.length) {
   			href = aas[i].href;
            break;
   		}
   	}
   	if(value-maxPage>0){
   		alert("总共页数为"+maxPage+"页,请重新输入页数!");
   		objInput.value ='';
   		objInput.focus();
   		return false;
   	}
   	if(maxPage==1){
   		objInput.value ='';
   		objInput.focus();
   		alert("就一页,不需要跳转!");return false;
   	}
   	href = chghref(href);
   	//if(href.length<3){alert("当前没有要跳转的页数");return false;}
   	window.location.href = href;
   }
   function chghref(href) {
   	if (href.length < 2) {
   		return href;
   	}
   	var href2 = "";
   	var h = href.split("?");
   	href2 = h[0];
   	var cc = h[1].split("&");
   	var reg = /^d-[0-9]+-p=[0-9]*$/;
   	var first=true;
   	for (var i = 0; i < cc.length; i++) {
   		if (reg.test(cc[i])) {
   			var dd = cc[i].split("=");
   			cc[i] = dd[0] + "=" + document.getElementById("searchput").value;
   		}
   		if(cc[i].split("=")[1].length==0) continue;
   		if (first) {
   			first=false;
   			href2 += "?" + cc[i];
   		} else {
   			href2 += "&" + cc[i];
   		}
   	}
   	return href2;
   }
   function findMaxPage(obj,maxPage2){
   	var aa=obj.getElementsByTagName("a");
   	for(var m=0;m<aa.length;m++){
   		var arr=aa[m].href.split("?");
   		if(arr[1]&&arr[1].length>0){
   			var arr2=arr[1].split("&");
   			var reg = /^d-[0-9]+-p=[0-9]*$/;
   			for(var i=0;i<arr2.length;i++){
   				if(reg.test(arr2[i])){
   					var maxp=arr2[i].split("=")[1];
   					if((maxp.length>0)&&(maxp-maxPage2>0)){
   						maxPage2=maxp;
   					}
   				}
   			}
   		}
   	}
   	var href=window.location.href;
   	var arr=href.split("?");
   		if(arr[1]&&arr[1].length>0){
   			var arr2=arr[1].split("&");
   			var reg = /^d-[0-9]+-p=[0-9]*$/;
   			for(var i=0;i<arr2.length;i++){
   				if(reg.test(arr2[i])){
   					var maxp=arr2[i].split("=")[1];
   					if((maxp.length>0)&&(maxp-maxPage2>0)){
   						maxPage2=maxp;
   					}
   				}
   			}
   		}
   	return maxPage2;
   }
   //-----
   if(document.addEventListener){
   window.addEventListener('load',initGoToPage,false);
   }else{
   window.attachEvent('onload',initGoToPage);
   }
