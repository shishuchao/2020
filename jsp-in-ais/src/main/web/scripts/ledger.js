function select(tr)  
{  
 if(grid.selectedTr!=null)  
 {  
  grid.selectedTr.style.backgroundColor="";  
 }  
  
 grid.selectedTr=tr;  
 tr.style.backgroundColor="#FFCC00";  
}  
function isselected()  
{  
 if(grid.selectedTr==null)  
  return false;  
   
 return true;  
}  
function push(s)  
{  
 if(grid.stack==null)  
  grid.stack=[];  
   
 grid.stack.push(s);  
}  
function pop()  
{  
 if(grid.stack==null)  
  return null;  
   
 return grid.stack.pop();  
}  
function movetop()  
{  
 if(!isselected()) return;  
  
 var s=[];  
 s.push(grid.selectedTr.rowIndex);  
 s.push(0);  
 push(s);  
  
 grid.moveRow(grid.selectedTr.rowIndex, 0);  
}  
function moveup()  
{  
 if(!isselected()) return;  
  
 var s=[];
 s.push(grid.selectedTr.rowIndex);  
 s.push(Math.max(grid.selectedTr.rowIndex-1,0));  
 push(s);  
 var num=Math.max(grid.selectedTr.rowIndex-1,0);
 if(num==0){
 	return false;
 }
 grid.moveRow(grid.selectedTr.rowIndex, Math.max(grid.selectedTr.rowIndex-1,0));
}  
function movedown()  
{  
 if(!isselected()) return;  
  
 var s=[];  
 s.push(grid.selectedTr.rowIndex);  
 s.push(Math.min(grid.selectedTr.rowIndex+1,grid.rows.length-1));  
 push(s);  
  
 grid.moveRow(grid.selectedTr.rowIndex, Math.min(grid.selectedTr.rowIndex+1,grid.rows.length-1));  
}  
function movebottom()  
{  
 if(!isselected()) return;  
  
 var s=[];  
 s.push(grid.selectedTr.rowIndex);  
 s.push(grid.rows.length-1);  
 push(s);  
  
 grid.moveRow(grid.selectedTr.rowIndex, grid.rows.length-1);  
}  
function cancelmove()  
{  
 if(grid.stack==null || grid.stack.length==0)  
  return;  
   
 var s=pop();  
 if(s!=null)  
 {  
  select(grid.rows[s[1]]);  
  grid.moveRow(s[1],s[0]);  
 }  
}  
function cancelall()  
{  
 if(grid.stack!=null && grid.stack.length>0)  
 {  
  cancelmove();  
  window.setTimeout(cancelall, 2000);  
 }  
 else if(grid.stack!=null)  
 {  
  alert("over!!!");  
 }  
} 
