/**
 * Created by xujun on 2017/2/24.
 */
/*var ProjectIndex = function(){
  return {
      /!*initSteps:function(prevMenu,pid){
          $.ajax({
              url:contextPath+'/project/prepare/menuTree.action',
              type:'get',
              cache:false,
              async:false,
              data:{'crudId':crudId,'source':source,'projectview':projectview,'id':pid},
              dataType:'json',
              success:function(json){
                  for(var i = 0;i<json.length;i++){
                      if(json[i].state=='closed'){
                          console.log(json[i].attributes.iconCls)
                          var menu = $('<li>',{'class':'nav-item'});
                          menu.append($('<a>',{'href':'javascript:;','class':'nav-link nav-toggle'}).append($('<i>',{'class':''+json[i].attributes.iconCls+''})).append($('<span>',{'class':'title'}).append(json[i].text)).append($('<span>',{'class':'arrow'})));
                          var submenu = $('<ul>',{'class':'sub-menu'});
                          ProjectIndex.initSteps(submenu,json[i].id);
                          menu.append(submenu);
                          prevMenu.append(menu);
                      }else{
                          prevMenu.append($('<li>',{'class':'nav-item'})
                              .append($('<a>',{'href':'javascript:;','id':json[i].id,'onclick':'ProjectIndex.goMenu(\''+json[i].text+'\',\''+json[i].attributes.url+'\',\''+json[i].id+'\')'}).append($('<i>',{'class':''+json[i].attributes.iconCls+''}))
                                  .append($('<span>',{'class':'title'}).append(json[i].text))));
                      }
                  }
                  $('#tabs').addtabs({contextmenu:true});
                  $('#'+menuIds.split(',')[0]).click();
              }
          });
      },*!/
      goMenu:function(tabName,flink,tabId){
          Addtabs.add({
              id:tabId,
              title:tabName,
              url:flink,
              close:true,
              refresh:true
          });
          Layout.setSidebarMenuActiveLink('click',$('#'+tabId));
      },
      changeProject:function(crudId,stage){
          window.location.href = contextPath+'/project/prepare/projectIndex.action?crudId='+crudId+'&stage='+stage;
      }
  }
}();*/

function goMenu(tabName,flink,tabId){
    Addtabs.add({
        id:tabId,
        title:tabName,
        url:flink,
        close:true,
        refresh:true
    });
    Layout.setSidebarMenuActiveLink('click',$('#'+tabId));
}
function addTab(navId,tabName,tabId,flink,refresh){
    Addtabs.add({
        id:tabId,
        title:tabName,
        url:flink,
        close:true,
        refresh:true
    });
}
/* 用户注销 */
function logout(){
    top.$.messager.confirm('确认','您确定要注销系统登录吗？',function(r){
        if(r){
            if(window.opener && window.opener.open && !window.opener.closed)
                window.opener.closeAllWindow();
            else{
                window.location=contextPath+'/system/uSystemAction!loginOut.action';
            }
        }
    });
};
jQuery(document).ready(function(){
    if(stage=="prepare"){
        $('#tabs').addtabs({contextmenu:true});
        Addtabs.add({
            id:'',
            title:'评价方案',
            url:contextPath+'/intctet/prepare/assessScheme/showFrame.action?view='+prepareView+'&projectFormId='+crudId,
            close:true
        });
    }else if(stage=="actualize"){
        $('#tabs').addtabs({contextmenu:true});
        Addtabs.add({
            id:'',
            title:'评价工具',
            url:contextPath+'/intctet/evaluationActualize/showEvaluationTool.action?view='+actualizeView+'&projectId='+crudId,
            close:true
        });
    }else if(stage=="archives"){
        $('#tabs').addtabs({contextmenu:true});
        Addtabs.add({
            id:'',
            title:'项目归档',
            url:contextPath+'/intctet/proArchive/listTobeStarted.action?view='+archivesView+'&epId='+crudId,
            close:true
        });
    }else if(stage=="report"){
        $('#tabs').addtabs({contextmenu:true});
        Addtabs.add({
            id:'',
            title:'评价报告',
            url:contextPath+'/intctet/evaProjectReport/edit.action?view='+reportView+'&projectId='+crudId,
            close:true
        });
    }else if(stage=='rework') {
    	 $('#tabs').addtabs({contextmenu:true});
         Addtabs.add({
             id:'',
             title:'缺陷整改',
             url:contextPath+'/intctet/rework/edit.action?view='+reworkView+'&epId='+crudId,
             close:true
         });
    }
    /*ProjectIndex.initSteps($('#menuList'),'-1');*/
    $('.page-sidebar-menu').css('margin',0);
    $('.page-sidebar-menu').height($('.page-content-wrapper').height()-17);
    $('.tab-content').height($('.page-content-wrapper').height()-$('.nav-tabs').height());
    $(window).resize(function () {
        $('.page-sidebar-menu').css('margin',0);
        $('.page-sidebar-menu').height($('.page-content-wrapper').height()-17);
        $('.tab-content').height($('.page-content-wrapper').height()-$('.nav-tabs').height());
    });

    $('.sidebar-toggler').on('click',function(e){
        if($(this).hasClass('icon-logout')){
            $(this).removeClass('icon-logout');
            $(this).addClass('icon-login');
            $(this).attr('title','展开菜单');
        }else if($(this).hasClass('icon-login')){
            $(this).removeClass('icon-login');
            $(this).addClass('icon-logout');
            $(this).attr('title','收起菜单');
        }
    });

});