//init初始化人工录入字段信息
//数组表示，字段名称、字段中文、字段类型、字段必填、默认值
//AID,ANAME,ATYPE,AREQUIRED,ADEFAULT
//setObjAttribute 增加控件的单个属性判断
//生成标题
var uniid=0;//全局变量，生成ID使用,以行为最小单位
var hcol=2;//输入值开始行,row从0开始
var ccol=1;//输入值开始列,列从0开始
var SearchQuery="";
var Query="";
var QueryView="";

function addTitle(){
var rowcount=getRows();
var row=dnmadd.insertRow(rowcount);
	row.className="igGridHeader";
  row.runtimeStyle.textAlign="center";
  row.runtimeStyle.height=20;
  setuniid();
  var cell=row.insertCell();
  cell.setAttribute('colSpan',8);
  cell.appendChild(addText("高级查询条件输入"));
addHead();


}
//生成列头
function addHead(){
var rowcount=getRows();
  var row=dnmadd.insertRow(rowcount);
  row.className="igGridColumnHeader";
  row.runtimeStyle.textAlign="center";
  setuniid();
  row.insertCell().appendChild(addText("行号"));
  row.insertCell().appendChild(addText("括号"));
  row.insertCell().appendChild(addText("列"));
  row.insertCell().appendChild(addText("操作符"));
  row.insertCell().appendChild(addText("值"));
  row.insertCell().appendChild(addText("括号"));
  row.insertCell().appendChild(addText("关系符"));
  row.insertCell().appendChild(addText("操作"));

addContent();
}
//生成输入内容
function addContent(){
var rowcount=getRows();
  var row=dnmadd.insertRow(rowcount);
  row.runtimeStyle.textAlign="center";
  setuniid();
  row.id="row_"+getuniid();
  row.hno=rowcount;
 // row.onmouseover=biMouseover;
 // row.onmouseout=biMouseout;
  row.insertCell().appendChild(addText(rowcount-1));//行号
  row.insertCell().appendChild(addKuoHaoSelect1());//括号
  row.insertCell().appendChild(addPidSelect());//列
  row.insertCell().appendChild(addOpreSelect(0));//操作符
  row.insertCell().appendChild(addValue(0));//值
  row.insertCell().appendChild(addKuoHaoSelect2());//括号
  row.insertCell().appendChild(addRelaSelect());//关系符
  if(rowcount<3)
		   row.insertCell().appendChild(addAddButton());
  else
		  row.insertCell().appendChild(addDelButton(rowcount-1));
		  
}
//生成列属性
function addHeadAttribute(obj,i){
var headname=document.createElement("font");
  headname.innerHTML=ANAME[i];
  obj.appendChild(headname);
  if(getAREQUIRED(i)=='Y'){
  var required=document.createElement("font");
  required.runtimeStyle.color = "red";
  required.innerHTML="*";
  obj.appendChild(required);
  }
}



 
//删除条目
function delContent(rowindex){
dnmadd.deleteRow(rowindex);
refreshSn();
}

//获得table行数
function getRows(){

return dnmadd.rows.length;
}
//获得后缀数字
function getPos(str){

var iend=str.length;
if(iend==0)
return "";
else{
var  ibegin=str.lastIndexOf("_");
return  str.substring(ibegin+1, iend);

}

}


//生成文本
function addText(name){
var obj=document.createElement("font");
  obj.innerHTML=name;
  return obj;
}
//生成输入单元格控件
function Edit(name,parent,i)
{
  switch(getATYPE(i))
	{
	case 'S'://字符
	var obj=new addInput(name,parent,'text',i);
	break;
	case 'I'://整数
	var obj=new addInput(name,parent,'text',i);
	//obj.onblur=checkInt;
	break;
	case 'F'://小数
	var obj=new addInput(name,parent,'text',i);
	//obj.onblur=checkDouble;
	break;
	//case 3://下拉列表
	//var obj=new addSelect(name,parent,'select',i);
	//break;
	//case 4://弹出窗口
	//var obj=new addInput(name,parent,'text',i);
	//break;
	case 'D'://日期
	var obj=new addInput(name,parent,'text',i);
	//var obj=new addHtcDate(name,parent,'date',i);
	break;
	case 'T'://带时间日期
	var obj=new addInput(name,parent,'text',i);
	break;
	}

	
  //obj.onmouseover=EDIT_onmouseover;
  return obj;
}
//生成列
function addPidSelect(){
var obj=document.createElement('select');
obj.style.width=100;
	addPidOption(obj);
	obj.attachEvent("onchange",changeInputControl); 
	return obj;

}
function addPidOption(obj)
{
  for(i=0;i<PID.length;i++){
	   addOption(obj,PID[i],PNAME[i]);
  }
  }
  //生成括号选择1
function addKuoHaoSelect1(){
var obj=document.createElement('select');
obj.style.width=50;
	addOption(obj,'','');
	addOption(obj,' ( ','  (');
	//obj.attachEvent("onchange",changeInputControl); 
	return obj;

}
//生成操作符
//@等于@不等于@包含@不包含@大于@大于等于@小于@小于等于@非空@为空
function addOpreSelect(metano)
{
 var obj=document.createElement("Select");
     obj.size=1;
	 obj.style.width=60;
 var list_ay=getPOPERATE(metano).split("@");
     for (var j=1;j<list_ay.length;j++)
     {
        var o_opt=document.createElement("OPTION");
       obj.add(o_opt);
        if(list_ay[j]=='等于'){
        o_opt.value='=';
	    o_opt.innerText=list_ay[j];
        }else if(list_ay[j]=='不等于'){
        o_opt.value='!=';
	    o_opt.innerText=list_ay[j];
        }else if(list_ay[j]=='包含'){
        o_opt.value='like';
	    o_opt.innerText=list_ay[j];
        }else if(list_ay[j]=='不包含'){
        o_opt.value='not like';
	    o_opt.innerText=list_ay[j];
        }else if(list_ay[j]=='大于'){
        o_opt.value='>';
	    o_opt.innerText=list_ay[j];
        }else if(list_ay[j]=='大于等于'){
        o_opt.value='>=';
	    o_opt.innerText=list_ay[j];
        }else if(list_ay[j]=='小于'){
        o_opt.value='<';
	    o_opt.innerText=list_ay[j];
        }else if(list_ay[j]=='小于等于'){
        o_opt.value='<=';
	    o_opt.innerText=list_ay[j];
        }else if(list_ay[j]=='非空'){
        o_opt.value='is not null';
	    o_opt.innerText=list_ay[j];
        }else if(list_ay[j]=='为空'){
        o_opt.value='is null';
	    o_opt.innerText=list_ay[j];
        }
        
	}
	return obj;
/*
  addOption(obj,"=","等于");
  addOption(obj,"!=","不等于");
  addOption(obj,"like","包含");
  addOption(obj,"not like","不包含");
  addOption(obj,">","大于");
  addOption(obj,">=","大于等于");
  addOption(obj,"<","小于");
  addOption(obj,"<=","小于等于");
  addOption(obj,"is not null","非空");
  addOption(obj,"is null","为空");
  */
  
  
   }

 //生成值
function addValue(metano)
{var control=getPCONTROLTYPE(metano);
  var obj;
  if (control=='INPUT')//输入框
  {
     obj = document.createElement("input");
     obj.type="text";
	obj.size=20;
	 
  }
  if (control=='DATE'||control=='TIME')//日期框
  {
     
     obj = document.createElement("input");
     obj.type="text";
	obj.size=20;
	//obj.value='oooo';
	obj.attachEvent("onclick",calendar); 

  }

  if (control=='SELECT')//下拉框
  {  
     obj=document.createElement("Select");
     obj.size=1;
	 obj.style.width=120;
     var list_ay=getPITEMS(metano).split(";");

     for (var j=0;j<list_ay.length;j++)
     {
        var o_opt=document.createElement("OPTION");
		obj.add(o_opt);
        var double;
        double=list_ay[j].split(",");
       
		o_opt.value=double[0];
	    o_opt.innerText=double[1];
	}
	 }
 return obj;

}

 //改变输入控件类型
function changeInputControl()
{
   //获取列位置
   var row=event.srcElement.parentElement.parentElement;
   var cell=row.cells(4);//获取值列
   //删除原有输入控件
   if (cell.children.length>0)
   cell.removeChild(cell.children[0]);
   //获取重建参数
   var dropdown=row.cells(2).children[0];//ccj
   //var fieldname=dropdown.options[dropdown.selectedIndex].value;
   
   
   //重建输入控件
   cell.appendChild(addValue(dropdown.selectedIndex));
   var cell3=row.cells(3);//获取操作符列
    //改变操作符
    if (cell3.children.length>0)
   cell3.removeChild(cell3.children[0]);
    cell3.appendChild(addOpreSelect(dropdown.selectedIndex));
}
  //生成括号选择2
function addKuoHaoSelect2(){
var obj=document.createElement('select');
obj.style.width=50;
	addOption(obj,'','   ');
	addOption(obj,' ) ',')  ');
	addOption(obj,' ( ','  (');
	//obj.attachEvent("onchange",changeInputControl); 
	return obj;

}
//生成关系符
function addRelaSelect(){

var obj=document.createElement('select');
	addRelaOption(obj);
	return obj;
}
function addRelaOption(obj)
{
  addOption(obj,"and","并且");
  addOption(obj,"or","或者");
  }

//生成删除按钮
function addDelButton(rowno)
{
  var objbutton=document.createElement("img"); 
  objbutton.src="/ais/ui/search/themes/blue/sdel.gif";
  objbutton.rowno=rowno;
  objbutton.runtimeStyle.cursor="hand";
  objbutton.attachEvent("onclick",removeRow);
  return objbutton;
}
//生成增加按钮
function addAddButton()
{
  var objbutton=document.createElement("img"); 
  objbutton.src="/ais/ui/search/themes/blue/sadd.gif";
  objbutton.runtimeStyle.cursor="hand";
  objbutton.attachEvent("onclick",addNewRow);
  return objbutton;
}
//增加新行
function addNewRow(){
addContent();
}
//删除行
function removeRow(){
	delContent(event.srcElement.parentElement.parentElement.rowIndex);
}
 //common
  function addOption(obj,key,value){
 var oOption = document.createElement("OPTION");
  obj.add(oOption);
 oOption.value=key;
 oOption.innerText=value;
  return obj;
  }

  //鼠标移出row背景色
function biMouseout(){
this.className="igGridRow";


}
//鼠标进入row背景色
function biMouseover(){
this.className="igGridRowHover";


}
//生成html控件
function addInput(cell,parent,type,i){
//type:text,select,date,datetime
var obj=document.createElement('input');
	obj.setAttribute('type',type);
	obj.size=12;
	//var rowindex=cell.parentElement.rowIndex;
	obj=setObjAttribute(obj,i);
	cell.appendChild(obj);
return obj;
}
//select
function addSelect(cell,parent,type,i){
var obj=document.createElement('select');
	//obj=setObjAttribute(obj,i);
	//obj.onblur=checkSelect;
	//obj.oncontextmenu=div_oncontextmenu;
	SELE_add(obj,i);
	cell.appendChild(obj);
return obj;
}

function getQuery()
{
    getSearchResult();
	//alert(Query);
	//alert(SearchQuery);
    return Query;
}
function getQueryView()
{
    getSearchResult();
	//alert(QueryView);
	//alert(SearchQuery);
    return QueryView;
}
//获取条件
function getSearchQuery()
{
   GetSearchResult();
return SearchQuery;
}
//合并选取的多条件结果
function getSearchResult()
{
  var sql="";//返回实际的查询语句
  var sqlview=""//返回生成的查询语句，供客户查看
  var errors="";
  var s_array=new Array();
  var rows=getRows();
    for (j=hcol;j<rows;j++)
    {
       var s_con;
       var tmp=' ';
       var tmpview=' ';
      //dnmadd.rows[i].cells[0].children[0]
	  var row=dnmadd.rows[j];
	  //获取括号1
	  var dropdownkuohao1=row.cells(1).children[0];
	   var  kuohao1=dropdownkuohao1.options[dropdownkuohao1.selectedIndex].value;
	   //获取字段名
	   var dropdownf=row.cells(2).children[0];
	   var  fieldname=dropdownf.options[dropdownf.selectedIndex].value;
	   var  fieldnameview=dropdownf.options[dropdownf.selectedIndex].text;
	   var fieldindex=dropdownf.selectedIndex;
        var fieldtype=getPDATATYPE(fieldindex);
        var control=getPCONTROLTYPE(fieldindex);
         //获取操作符
           var dropdownc=row.cells(3).children[0];
	     var  con=dropdownc.options[dropdownc.selectedIndex].value;
	var  conview=dropdownc.options[dropdownc.selectedIndex].text;
	   //获取输入值
            var inputvalue=""; 
            var inputtext="";
	    var input=row.cells(4).children[0];
	    /**
	      if (control=='INPUT')//文本
	      {
              var s_tmp=new RegExp("'","g");
              inputvalue=input.value;
	      inputvalue=inputvalue.replace(s_tmp,"");

	      }
	      if (control=='DATE'||control=='TIME')//日期
	      {
			
	      	if (fieldtype=="T"){
	      		//inputvalue="'"+input.value+"'";
	      		
	      		inputvalue=getDateStr2(input.value);
	      		
	        	//inputvalue="TO_DATE('"+input.value+"','yyyy-MM-dd HH24:MI:SS')";
	        	}
	      	else
	      	{
	       
	        //fieldname="to_Char("+fieldname+",'yyyy-MM-dd')";
			//inputvalue=input.value;
		 inputvalue=getDateStr(input.value);
	      	}
	        
	      }

	      if (control=='SELECT')//下拉菜单
              {
              inputvalue=input.options[input.selectedIndex].value;
              inputtext=input.options[input.selectedIndex].text;
	      }
	   
	   **/
	   var tempvalue="";
	   var temptext="";
	   if (control=='SELECT')//下拉菜单
              {
              tempvalue=input.options[input.selectedIndex].value;
              temptext=input.options[input.selectedIndex].text;
	      }
	      else{
	       tempvalue=input.value;
	      }
	      
	      
	    if (fieldtype.toUpperCase()=='S')//字符
	      {
              var s_tmp=new RegExp("'","g");
              inputvalue=tempvalue;
	      inputvalue=inputvalue.replace(s_tmp,"");

	      }
	      if (fieldtype.toUpperCase()=='D')//日期
	      {
		 inputvalue=getDateStr(tempvalue);
	      }
	       if (fieldtype.toUpperCase()=='T')//日期(带时间)
	      {
		 inputvalue=getDateStr2(tempvalue);
	      }
	       if (fieldtype.toUpperCase()=='I')//整数
	      {
		 inputvalue=tempvalue;
	      }
	      if (fieldtype.toUpperCase()=='F')//小数
	      {
		 inputvalue=tempvalue;
	      }
	     

	   if (fieldtype.toUpperCase()=="I")
	      {
	         if (!isInt(inputvalue))
		 {
		    errors=errors+"["+fieldname+"]的查询值必须是数字！\n";
		 }
	      
	      }

              if (con=="is not null"||con=="is null")
	      {
	         tmp=tmp+kuohao1+fieldname+" "+con;
	         tmpview=tmpview+kuohao1+fieldnameview+"   "+conview;
	      }
	      else
	      {
	
              //判断条件
              if (con=="like"||con=="not like")
	      {
	          tmp=tmp+kuohao1+fieldname+" "+con+" '%"+inputvalue+"%'";
	          if(inputtext=='')
	          inputtext=inputvalue;
	          tmpview=tmpview+kuohao1+fieldnameview+"   "+conview+"   '%"+inputtext+"%'";
                  if (fieldtype.toLowerCase()=="int"&&control==1)
		  {
		     errors=errors+"使用匹配查询时，数据类型与查询方式冲突！\n";
		  }           
	            
	      }else{
                 if (isNumber(inputvalue)){
		    if (fieldtype.toUpperCase()=="I")
		    {
		     errors=errors+"使用比较查询时，数据类型与查询方式冲突！\n";
		    }
		    if (fieldtype.toUpperCase()!="T")
		    inputvalue="'"+inputvalue+"'";
		    
		 }else
		 {
		    if (fieldtype.toUpperCase()=="S")
		    {
		      inputvalue="'"+inputvalue+"'";
		    }
		 }

                 
                    tmp=kuohao1+fieldname+con+inputvalue;
                    if(inputtext=='')
	          inputtext=inputvalue;
                    tmpview=kuohao1+fieldnameview+'    '+conview+'    '+inputtext;
	       }
	      }

//
 //获取括号2
	  var dropdownkuohao2=row.cells(5).children[0];
	   var  kuohao2=dropdownkuohao2.options[dropdownkuohao2.selectedIndex].value;
	   
	   //判断是否有下一个条件，获取条件连接符And 和 Or
	   var andor;
	   if (j<rows-1)
	   {
	      var dropdownAo=row.cells(6).children[0];//ccj
              
	      with(dropdownAo)
	      {
	         andor=options[selectedIndex].value;
	      }
	      tmp=tmp+" "+kuohao2+andor+" ";
	      tmpview=tmpview+"   "+kuohao2+'    '+andor+"   ";
	   }else{
	   tmp=tmp+" "+kuohao2;
	      tmpview=tmpview+"   "+kuohao2;
	   }
	   
           s_con=new Condition(kuohao1,fieldname,con,inputvalue,kuohao2,andor);
	   s_array[j-hcol]=s_con;
	   //获取查询条件并查询数据合并
	   sql=sql+tmp;
	   sqlview=sqlview+tmpview;
	}

  
  
    
    if (s_array.length>0)
    {   SearchQuery="";
        
        for (var m=0;m<s_array.length;m++)
	{
	  
	  SearchQuery+=s_array[m].fieldname+","+s_array[m].condi+","+s_array[m].value+","+s_array[m].relation;
	  if (m!=s_array.length-1)
	    SearchQuery+=";";
	 
	}
    
    }
   
    
    Query=sql;
    QueryView=sqlview;
   
}
//查询条件属性类
function Condition(kuohao1,fieldname,condi,value,kuohao2,relation)
{
   this.kuohao1=kuohao1;//kuohao
  this.fieldname=fieldname;//字段名
  this.condi=condi;//条件
  this.value=value;//输入值
  this.kuohao2=kuohao2;//kuohao
  this.relation=relation;//And、or关联
}

function div_oncontextmenu()
{
	var popupmenu=this.PopupMenu;
	if(popupmenu)if(popupmenu.AutoPopup)this.PopupMenu.Popup(event.clientX,event.clientY);
    event.returnValue = false;
    event.cancelBubble=true;
}

//刷新行号
function refreshSn(){
var rows=getRows();
var j=1;
 for(var i=hcol;i<rows;i++){
	dnmadd.rows[i].cells[0].innerHTML="";
	dnmadd.rows[i].cells[0].appendChild(addText(j));
	j++;
      }   
}
//处理obj属性
function setObjAttribute(obj,i){
	obj.hno=i;//自定义属性，保存列的索引
	
	obj.id="C_"+getuniid()+"_"+i;
	obj.name=getAID(i);//name
	obj.atype=getATYPE(i);
	obj.atypeext=getATYPEEXT(i);
	obj.arequired=getAREQUIRED(i);
	obj.adefault=getADEFAULT(i);
	obj.onblur=checkObj;
return obj;
}

//获得字段名称
function getPID(index){
return PID.length>index?PID[index]:"";
}
//获得字段中文
function getPNAME(index){
return PNAME.length>index?PNAME[index]:"";
}
//获得字段类型
function getPDATATYPE(index){
return PDATATYPE.length>index?PDATATYPE[index]:"";
}
//获得控制类型
function getPCONTROLTYPE(index){
return PCONTROLTYPE.length>index?PCONTROLTYPE[index]:"";
}
//获得字段下拉选单值
function getPITEMS(index){
return PITEMS.length>index?PITEMS[index]:"";
}
//获得操作符下拉选单值
function getPOPERATE(index){
return POPERATE.length>index?POPERATE[index]:"";
}

//校验函数
//整个校验
function checkAllObj(){

 var row;
 var hnoc;
 var obj;
 var isgood=true;
	   for (var i = hcol; i < getRows(); i++)
	   {
	   row=dnmadd.rows[i];
           hnoc=row.hno;
	   for(var j=0;j<AID.length;j++){
	   obj=row.cells[ccol+j].children[0];
	   if(!checkSObj(obj))
	   isgood=false;
	   }
	   
	   }

return isgood;

}
//单个校验
function checkObj(){
if(!ischeck){
ischeck=!ischeck;
return false;
}
var hno=this.hno;
var value=this.value;
if(hno==null || hno=="undefined")
return false;
//必填项校验
if(getAREQUIRED(hno)=='Y'){
if(trim(value).length==0){
alert("请输入有效内容");
if(this.type!='select-one'){
this.focus();
this.select();
}

this.runtimeStyle.backgroundColor = "red";
ischeck=!ischeck;
return false;
}
}
//类型校验
switch(getATYPE(hno))
	{
	case 'S'://字符
	break;
	case 'I'://整数
	if(!isInt(value)){
	alert("请输入有效整数.");
	this.runtimeStyle.backgroundColor = "red";
	this.focus();
	this.select();
	ischeck=!ischeck;
	return false;
	}
	break;
	case 'F'://小数
	if(!isNumber(value)){
	alert("请输入有效数字.");
	this.runtimeStyle.backgroundColor = "red";
	this.focus();
	this.select();
	ischeck=!ischeck;
	return false;
	}
	break;
	case 'DATE'://日期
	if(!isDate(value)){
	alert("日期格式yyyy-mm-dd.\r\n如：2006-01-01.");
	this.runtimeStyle.backgroundColor = "red";
	this.focus();
	this.select();
	ischeck=!ischeck;
	return false;
	}
	break;
	case 'TIME'://带时间日期
	if(!isDateTime(value)){
	alert("日期格式yyyy-mm-dd HH:mm:ss.\r\n如：2006-01-01 23:07:59'.");
	this.runtimeStyle.backgroundColor = "red";
	this.focus();
	this.select();
	ischeck=!ischeck;
	return false;
	}
	break;
	}
this.runtimeStyle.backgroundColor = "white";
ischeck=true;
return true;
}
//////
function checkSObj(obj){
var hno=obj.hno;
var value=obj.value;
if(hno==null || hno=="undefined"){
alert("error.");
return false;
}
//必填项校验
if(getAREQUIRED(hno)=='Y'){
if(trim(value).length==0){
obj.runtimeStyle.backgroundColor = "red";
return false;
}
}
//输入默认值
if(trim(value).length==0){
obj.value=getADEFAULT(hno);
value=obj.value;
}
//类型校验
switch(getATYPE(hno))
	{
	case 'S'://字符
	break;
	case 'I'://整数
	if(!isInt(value)){
	obj.runtimeStyle.backgroundColor = "red";
	return false;
	}
	break;
	case 'F'://小数
	if(!isNumber(value)){
	obj.runtimeStyle.backgroundColor = "red";
	return false;
	}
	break;
	case 'DATE'://日期
	if(!isDate(value)){
	obj.runtimeStyle.backgroundColor = "red";
	return false;
	}
	break;
	case 'TIME'://带时间日期
	if(!isDateTime(value)){
	obj.runtimeStyle.backgroundColor = "red";
	return false;
	}
	break;
	}

obj.runtimeStyle.backgroundColor = "white";
return true;
}

//////
function checkSelect(){
if(!ischeck){
ischeck=!ischeck;
return false;
}
var hno=this.hno;
var value=this.value;
if(hno==null || hno=="undefined")
return false;
//必填项校验
if(getAREQUIRED(hno)=='Y'){
if(!isString(value)){
alert("请选择有效内容");
this.focus();
ischeck=!ischeck;
this.runtimeStyle.backgroundColor = "red";
return false;
}
}
this.runtimeStyle.backgroundColor = "white";
ischeck=true;
}
function checkInt()
{
if(!isInt(this.value))
{
alert("请输入有效整数.");
this.focus();
return false;
}
}
function checkDouble(){
if(isNaN(this.value)){
	alert("请输入有效数字.");
 this.focus();
 }
}
//必填项校验

function checkString(s)
{if(s.length==0){
alert("请输入有效内容.");
 this.focus();
 return false;
}
}

//整数
function isInt(s)
{
if(s.length==0)
return true;
var patrn=/^[-,+]{0,1}[0-9]{0,}$/;
if (!patrn.exec(s))
return false;
return true;
}
//数字
function isNumber(s)
{
if(s.length==0)
return true;
var patrn=/^[-,+]{0,1}[0-9]{0,}[.]{0,1}[0-9]{0,}$/;
if (!patrn.exec(s))
return false;
return true;
}
//
function isString(s){
if(s.length==0)
return true;
if(trim(s).length==0)
 return false;
return true;

}


  function isTime(s)
      {
        var a = s.match(/^(\d{1,2})(:)?(\d{1,2})\2(\d{1,2})$/);
        if (a == null) {return false;}
        if (a[1]>23 || a[3]>59 || a[4]>59)
        {
          
          return false
        }
        return true;
      }
	  
function isDate(s){
if(s.length==0)
return true;
var r = s.match(/^(\d{1,4})(-|\/)(\d{1,2})\2(\d{1,2})$/); 
if(r==null)
{
return false;
}
 if (s.substr(4,1)!="-" || s.substr(7,1)!=="-")
      return false; 
         
 var sdate=s.substr(s.lastIndexOf("-")+1,s.length);
 if(sdate.length==1)
 return false;
var d= new Date(r[1], r[3]-1, r[4]); 
if(!(d.getFullYear()==r[1]&&(d.getMonth()+1)==r[3]&&d.getDate()==r[4]))
{ 
return false;
}
return true;




}
//
function getuniid(){
return this.uniid;
}
//
function setuniid(){
this.uniid=this.uniid+1;
}
//去除空格
function trim(str){
return str.replace(/(^\s*)|(\s*$)/g,"");

}
//enter-tab
document.onkeydown=function(){   
  //event.keyCode=(event.keyCode==13)?9:event.keyCode;

 //if(event.keyCode==13)
// event.keyCode=9;
//if(event.keyCode==116 ){
 // event.keyCode=0;                 
 //  event.returnValue=false;
//}

 }