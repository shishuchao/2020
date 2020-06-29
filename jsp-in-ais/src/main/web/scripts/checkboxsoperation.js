function checkall(checkboxs)

{
var oj = document.getElementsByName(checkboxs);
      for (var i=0;i<oj.length;i++ )

            {

              oj[i].checked=true;

            }

}

    //checkback为设置反选

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
