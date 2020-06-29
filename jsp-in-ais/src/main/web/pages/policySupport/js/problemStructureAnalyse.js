//根据维度更换图表  
function changeRadioType(param){
     type=param;                             
     $('#iframe').attr('src',defaultUrl+'pro_year='+pro_year+'&audit_dept='+audit_dept+'&audit_object='+audit_object+'&pro_type='+pro_type+'&sort_big_code='+sort_big_code+'&mend_state='+mend_state+'&type='+type);
}
	 
//查询
function doSearch(){  			
	pro_year=$('#project_year').selectedValuesString();
	audit_dept=$('#audit_dept').val();
	audit_object=$('#audit_object').val();
	topN=$('#topN').val();
	sort_big_code=$('#sort_big_code').val();
	pro_type=$('#project_type').selectedValuesString();
	mend_state=$('#rectify_state').selectedValuesString();
	type = $("input[name='totleDimension']:checked").val();
			
	if((pro_year == "" || pro_year == null)){
		showMessage1("请选择项目年度");
		return false;
	}
	if((audit_dept =="" || audit_dept == null) ){
		showMessage1("请选择审计单位");
		return false;
	}
	$('#iframe').attr('src',defaultUrl+'pro_year='+pro_year+'&audit_dept='+audit_dept+'&audit_object='+audit_object+'&pro_type='+pro_type+'&sort_big_code='+sort_big_code+'&mend_state='+mend_state+'&type='+type);
}
		  
//判断是否一级分类
function checkIsSortBigCode(code){
	var flag = true;
	$.ajax({
	     url: '${contextPath}/proledger/problem/checkIsSortBigCode.action?problemcode='+code,
	     dataType: 'json',
	     method: 'post',
	     async: false,
	     success: function (data) {
			if(data.flag == 'one'){
			}else{
				flag = false;
			    alert("请选择一级分类！");
			}
	     }
	  });
	  return flag;
}  