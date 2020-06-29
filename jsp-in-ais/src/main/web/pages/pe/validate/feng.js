	function doOther(select1,select2){
	
      var os1=document.getElementsByName(select1)[0];   
      var id=os1.value;   

    var os2=document.getElementsByName(select2)[0]; 
      for(var i=0;i<os2.options.length;i++){
        var vv=os2.options[i].value
        var v1=vv.split('~')[0];
        var v2=vv.split('~')[1];
        if(((new Number(id)<=new Number(v2))&&(new Number(id)>=new Number(v1)))){
        os2.options[i].selected=true;
        }    
      }     
   }
	
	
function sumValidate_feng(weightNameList,nameList,objname){

	var arr=nameList.split(',');
	var allValue=0;
	for(var i=0;i<arr.length;i++){		
		var tmp=document.getElementsByName(arr[i])[0].value;
		if(new Number(tmp)>100){alert('输入有误,请输入1-100之间的数字'); document.getElementsByName(arr[i])[0].value=''; return false;}
		if(!isNaN(tmp)){ 	     
			allValue+=new Number(tmp)*new Number(weightNameList.split(',')[i]);		       
	     }	
	}	
	 document.getElementsByName(objname)[0].value=allValue/100;	
}