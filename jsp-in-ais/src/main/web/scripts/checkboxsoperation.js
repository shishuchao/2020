function checkall(checkboxs)

{
var oj = document.getElementsByName(checkboxs);
      for (var i=0;i<oj.length;i++ )

            {

              oj[i].checked=true;

            }

}

    //checkbackΪ���÷�ѡ

     function checkback(checkboxs)

{
		var oj = document.getElementsByName(checkboxs);
      for (var i=0;i<oj.length;i++ )

            {

              if (oj[i].checked)

              {

               oj[i].checked=false;

              }

     else

     {

     oj[i].checked=true;

     }

            }

}
