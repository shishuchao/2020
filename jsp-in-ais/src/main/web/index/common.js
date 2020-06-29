/**
 * Created by xujun on 2017/3/29.
 */
function exitSystem(){
    top.$.messager.confirm('确认','您确定要退出当前系统吗？',function(r){
        if(r){
            window.close();
        }
    });
}