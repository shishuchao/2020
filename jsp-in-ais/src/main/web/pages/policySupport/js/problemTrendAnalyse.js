//根据维度更换图表  
function changeRadioType(aType){
	$('#myIframe').attr('src',defaultUrl+'ayalyseType='+aType+'&from='+from+'&contextPath=${contextPath}&projectYear='+projectYear
		+'&auditDept='+auditDept+'&auditObject='+auditObject+'&projectType='+projectType+'&problemType='+problemType+'&reformStatus='+reformStatus);
}

//查询
function doSearch(){
	from = 'serach';
	projectYear = $('#project_year').selectedValuesString();
	auditDept = $('#audit_dept').val();
	auditObject = $('#audit_object').val();
	projectType = $('#project_type').selectedValuesString();
	problemType = $('#sort_big_code').val();
	reformStatus = $('#rectify_state').selectedValuesString();
			
	if($('#proType')[0].checked){
		ayalyseType = '1';
	}else if($('#quetype')[0].checked){
		ayalyseType = '2';
	}
			
	//必输检查
	if(projectYear==''){
		showMessage1('请选择项目年度');
		return false;
	}
	if(auditDept==''){
		showMessage1('请选择审计单位');
		return false;
	}
	$('#myIframe').attr('src', defaultUrl+'ayalyseType='+ayalyseType+'&from='+from+'&contextPath=${contextPath}&projectYear='+projectYear
			+'&auditDept='+auditDept+'&auditObject='+auditObject+'&projectType='+projectType+'&problemType='+problemType+'&reformStatus='+reformStatus);
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
