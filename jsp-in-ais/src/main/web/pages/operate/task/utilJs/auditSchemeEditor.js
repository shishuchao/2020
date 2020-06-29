var auditFocus;
var auditAssessment;
var options = {
        resizeType : 1,
        allowFileManager : true,
		width : '100%',
		items:[
        'undo', 'redo', '|','cut', 'copy', 'paste',
        'plainpaste', 'wordpaste', '|', 'justifyleft', 'justifycenter', 'justifyright',
        'justifyfull', 'insertorderedlist', 'insertunorderedlist', 'indent', 'outdent', 'subscript',
        'superscript', 'clearhtml', 'quickformat', 'selectall', '|', 'fullscreen',
        'formatblock', 'fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold',
        'italic', 'underline', 'strikethrough', 'lineheight', 'removeformat', '|', 'multiimage',
        'insertfile', 'table', 'hr','anchor', 'link', 'unlink'
         ]
      };       
KindEditor.ready(function(K) {
		auditFocus = K.create('textarea[name="auditFocus"]',options);
		auditAssessment = K.create('textarea[name="auditAssessment"]',options);
	 });