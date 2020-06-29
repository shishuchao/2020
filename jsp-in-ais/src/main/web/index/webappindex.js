
$(function(){
	var online_parentId = null;
	var targetUrl = null;
	if(aud$isonline){
		online_parentId = '-11';
		targetUrl = contextPath+'/project/prepare/menuTree.action?crudId='+crudId+'&source='+source+'&projectview='+projectview+'&id=';
	}else if(aud$interCtrl$online){
		online_parentId = '33';
		targetUrl = contextPath+'/intctet/evaProject/evaPlan/interCtrlOnlineMenuTree.action?crudId='+crudId+'&stage='+interCtrl$stage+'&isEnd='+interCtrl$isEnd+'&id=';
	}
	//alert('online_parentId='+online_parentId)
	if(online_parentId){		
		firstMenuTree($('#pageMenubar'), online_parentId, targetUrl);
	}
    $('.nav-header').bind('mouseover', function(){
    	if(!$(this).hasClass('menuActive')){    		
    		$(this).css('font-weight', 'bold')
    	}
    }).bind('mouseout', function(){
    	if(!$(this).hasClass('menuActive')){
    		$(this).css('font-weight', 'normal')
    	}
    })
    
    
    function firstMenuTree(prevMenu, parentId, targetUrl){
        $.ajax({
            url:targetUrl + parentId,
            type:'get',
            cache:false,
            async:false,
            dataType:'json',
            success:function(json){
        		var len = json.length;
        		var index = len;
                for(var i = 0; i < len; i++){
                	var isLeaf = json[i].state =='closed' ? false : true;
                	var name = json[i].text;
                	var id = json[i].id;
                	var url = json[i].attributes.url;
        			var item = $("<a href='javascript:void(0)' >");
        			item.addClass("nav-header collapsed")
        			.attr("data-toggle","collapse")
        			.attr('id', 'menu-'+id).data('id',id).data('name', name).data('url', url).data('isLeaf', isLeaf)
        			.css({
        				'cursor':'pointer',
        				'text-decoration':'none',
        				'z-index':index
        			}).text(name)
        			.bind('click', function(){
        				menuActive(this);
        				var name_ = $(this).data('name');
        				var url_ = $(this).data('url');
        				var id_ = $(this).data('id');
        				var isLeaf_ = $(this).data('isLeaf');
        				if(isLeaf_){				
        					try{
        						$("#mTree").html('');
        					}catch(e){}
        					aud$goMenu(name_, url_, id_);
        					$("#mainLayout").layout("collapse","west");
        				}else{
        					aud$onlineSubMenu(id_, targetUrl, null);
        				}
        				$("#navMenu").panel({title:name_});
        			});                   
        			prevMenu.append(item);
        			index = index - 1;
                }
                //alert('menuIds:'+menuIds)
                var curMenuArr = menuIds.split(',');
                var curLeafMenuId = curMenuArr[0];
                var curLeafParentMenuId = curMenuArr[1];
                if($('#menu-'+curLeafMenuId).length == 0){
                	aud$onlineSubMenu(curLeafParentMenuId,targetUrl, curLeafMenuId);
                	$("#navMenu").panel({title:$('#menu-'+curLeafParentMenuId).data('name')});
                	menuActive($('#menu-'+curLeafParentMenuId).get(0));
                }else{
                	$('#menu-'+curLeafMenuId).click();
                }
                
            }
        });
    }
});

function aud$onlineSubMenu(pid, targetUrl, defaultMenuId){
	try{ 
	    $("#mTree").tree({
	        url:targetUrl + pid,
	        cache:false,
	        //async:false,
	        lines:false,
	        onLoadSuccess:function(node, data){
	        	$.each( data, function(i, n){		    
	        		var node = $('#mTree').tree('find', data[i].id);
	    	    	$('#mTree').tree('expand', node.target);
        		}); 
	        	
	        	if($("#mainLayout").data('expand') == false){	        		
	        		$("#mainLayout").layout("expand","west");
	        	}
	        	
	        	if(defaultMenuId){
	        		var defaultNode = $('#mTree').tree('find', defaultMenuId);
	        		$('#mTree').tree('select', defaultNode.target);
	        		aud$online$clickSubMenu(defaultNode);
	        	}
	        },
	        onClick:function(node){
	        	aud$online$clickSubMenu(node);	
	        }
	    });
	}catch(e){
		
	}
}

function aud$online$clickSubMenu(node){
	try{
    	var url = node.attributes.url;
        if(url!=null){
        	var target = node.attributes.target;
        	if(target && target.toLowerCase() == '_blank'){
        		var wH = window.screen.availHeight;
        		var wW = window.screen.availWidth;
        		window.open(url,'','width='+wW+'px,height='+wH+'px,toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no');
        	}else{
        		aud$goMenu(node.text,url,node.id);
        	}
        }
	}catch(e){
		
	}
}

var __valid_title_re = /<label.*?>.*?<\/label>/ig;
function validTitle(title) {
    return title.replace(__valid_title_re, "").replace("&nbsp;", "");
}
function aud$goMenu(tabName, flink, tabId){
    var tabName = validTitle(tabName);
    addTab('tabs', tabName, tabId, flink, true);

}