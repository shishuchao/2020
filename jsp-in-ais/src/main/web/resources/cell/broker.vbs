Option Explicit

Const sCofiAskErr = "#COFI ASK#"

Function Broker(sCode,qstring)
	on error resume next 	
    Dim guid 
    guid = ""
    Dim pos
	Dim HttpReq
	set HttpReq=createObject("Microsoft.XMLHTTP")
	HttpReq.open "POST", "/fap/functions.jsp?guid=" + guid + "&" + qstring, False
	HttpReq.send
	Dim r
	r=HttpReq.responseText
	
	If (InStr(r, "none") > 0) Then
        Broker = CDbl("0")
    Else
        ' 尽量将返回值转换成 Double 型
        Broker = CDbl(ret)
        If Err.Number <> 0 Then
            Broker = r
        End If
    End If

End Function