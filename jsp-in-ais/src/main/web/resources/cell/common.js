function isSpeUserFunc(formulaText){
	var retValue
    if (formulaText.toLowerCase().indexOf("cae_fun")>0){
    	retValue=true
    }else{
   		retValue=false
    }
  	return retValue
}
	
function isFuncWithHyper(formulaText){
	var retValue
	//var pattern = /^cae_fun\("(bz|ys)km","[^"]*"\)$/gi;
	//if(pattern.test(formulaText)){
		//retValue=true
	//}else{
		//retValue=false
	//}
	if(formulaText.toLowerCase().lastIndexOf("cae_bzkm")==0){
		retValue=true
	}else{
		retValue=false
	}
	return retValue
}


 