function insertObject(url_prefix) {
	var str = '';
	str += '<object classid="clsid:00000103-92E6-4AB6-A701-C40315913A5D"';
    str += 'id="oFramer"';
    str += 'width="100%"';
    str += 'height="100%"';
    str += 'codebase="'+url_prefix+'/scripts/CofiAskExt.CAB#version=1,0,0,1"';
    str += '>';
    str += '<param name="IsPromptSave" value="false">';
    str += '<param name="BorderStyle" value="0">';
    str += '<param name="Caption" value="This is the Caption">';
	str += '</object>';
	//alert('codebase="'+url_prefix+'/scripts/CofiAskExt.CAB#version=1,0,0,1"');
	document.getElementById("oFramerDiv").innerHTML = str;
}