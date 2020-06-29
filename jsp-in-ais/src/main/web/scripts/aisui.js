/*
 * aisui.js
 *封装基本的form样式
 *样例如下：
 *var aisUi=new AisUi({
			datas:"[['审易', 'c/s'],['B/S作业', 'b/s']]",
			tagvalue:'bs',
			tagid:'paramhtml',
			tagname:'frealvalue'
			});
			aisUi.createCheckBox();
<div id="frealvalue"></div>
 */

AisUi=function(O){
if(O.datas==null || O.datas=='')
this.datas='';
else
this.datas=eval(O.datas);//数据

this.tagvalue=O.tagvalue;//结果
this.tagid=O.tagid;//容器id,调用tagid.innerhtml
this.tagname=O.tagname;//标签的名称
this.tagstyle=O.tagstyle;
};
AisUi.prototype.createSelect=function(){
var  paramsize=this.datas.length;
var paramhtml="";
paramhtml+='<select name="'+this.tagname+'">';
paramhtml+='<option  value="">&nbsp;&nbsp;&nbsp;&nbsp;</option>';
for(var i=0;i<paramsize;i++){
paramhtml+='<option  value="'+this.datas[i][1]+'"';

if(this.tagvalue==this.datas[i][1])
paramhtml+=' selected="true"';

paramhtml+='>'+this.datas[i][0]+'</option>';
}

paramhtml+='</select>';
document.getElementById(this.tagid).innerHTML=paramhtml;
};
AisUi.prototype.createCheckBox=function(){
var  paramsize=this.datas.length;
var paramhtml="";
for(var j=0;j<paramsize;j++){
paramhtml+='<input type="checkbox" onchange="aisUi.getCheckResult()" id="check_'+j+'" value="'+this.datas[j][1]+'"';

if(this.tagvalue.indexOf(this.datas[j][1])!=-1)
paramhtml+=' checked="true"';

paramhtml+='/>'+this.datas[j][0]+'</br>';

}
paramhtml+='<input type="hidden" name="'+this.tagname+'" value="'+this.tagvalue+'"/>';
document.getElementById(this.tagid).innerHTML=paramhtml;
};

AisUi.prototype.create=function(){
if(this.tagstyle=='item')
this.createSelect();
if(this.tagstyle=='checkbox')
this.createCheckBox();

}
AisUi.prototype.getCheckResult=function(){

var  paramsize=this.datas.length;
var result="";
for(var k=0;k<paramsize;k++){
if(document.getElementById("check_"+k).checked){
if(result=="")
result=document.getElementById("check_"+k).value;
else 
result=result+","+document.getElementById("check_"+k).value;
}
}
document.getElementById(this.tagname).value=result;
};
