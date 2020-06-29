function log(title, msg){
	$.messager.show({
	    title: title,
	    msg: msg ,
	    timeout:2000,
	    showType:'slide',
	    style:{
			right:'',
			top: 0,
			bottom:''
	    	}
	    });
	}