<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>


   
    <!-- 以下为自定义查询条件 -->
    
    <div id="reportYearBox">
        <select name="query_eq_reportYear" id="query_eq_reportYear" style='width:130px;'>
        </select>
    </div>
    
    <div id="statusBox">
        <select name="query_eq_status" id="query_eq_status" style='width:130px;'>
        </select>
    </div>
    
    <div id='orgNameBox'>
        <input type="text"   name="query_like_orgName"   />
        <input type="hidden"  /><img  style="cursor:hand;border:0"
            src="/ais/resources/images/s_search.gif"
            onclick="showSysTree(this,{
                              title:'请选择-审计单位',
                              defaultDeptId:'${user.fdepid}',
                              defaultUserId:'${user.floginname}',
                              param:{
                                'rootParentId':'0',
                                'beanName':'UOrganizationTree',
                                'treeId'  :'fid',
                                'treeText':'fname',
                                'treeParentId':'fpid',
                                'treeOrder':'fcode'
                             }                                  
                    })"></img>      
    </div>
    
     <div id='orgNameBox2'>
	     <input type="text"   name="query_like_orgName"   />
	     <input type="hidden"  /><img  style="cursor:hand;border:0"
	         src="/ais/resources/images/s_search.gif"
	         onclick="showSysTree(this,{
	                           title:'请选择-审计单位',
	                           defaultDeptId:'${user.fdepid}',
	                           defaultUserId:'${user.floginname}',
	                           param:{
	                             'rootParentId':'0',
	                             'beanName':'UOrganizationTree',
	                             'treeId'  :'fid',
	                             'treeText':'fname',
	                             'treeParentId':'fpid',
	                             'treeOrder':'fcode'
	                          }                                  
	                 })"></img>      
    </div>
    
    <div id='informantBox'>
        <input type="text"   name="query_like_informant"  />
        <input type="hidden"  /><img  style="cursor:hand;border:0"
            src="/ais/resources/images/s_search.gif" 
            onclick="showSysTree(this,{url:'/ais/systemnew/orgListByAsyn.action?org=local',
                      title:'请选择填报人',
                      type:'treeAndUser',
                      defaultDeptId:'${user.fdepid}',
                      defaultUserId:'${user.floginname}'
                    })"></img>         
    </div>
    
    <div id='creatorBox'>
        <input type="text"   name="query_like_creator"  />
        <input type="hidden"  /><img  style="cursor:hand;border:0"
            src="/ais/resources/images/s_search.gif" 
            onclick="showSysTree(this,{url:'/ais/systemnew/orgListByAsyn.action?org=local',
                      title:'请选择创建人',
                      type:'treeAndUser',
                      defaultDeptId:'${user.fdepid}',
                      defaultUserId:'${user.floginname}'
                    })"></img>         
    </div>
    
    <div id='reportToDiv' style='display:none;'>
        <input type="text"   name="fr_recipients"   />
        <input type="hidden" name="fr_recipientsId"/>
        <img  style="cursor:hand;border:0"
            src="${contextPath}/resources/images/s_search.gif" 
            onclick="showSysTree(this,{
                      title:'请选择上报接收人',
                      type:'treeAndUser',
                      defaultDeptId:'1',
                     // defaultUserId:'${user.floginname}',
                      checkbox:false,
                      onAfterSure:qreportToZJ_,
                      param:{
                        'rootParentId':'0',
                        'whereHql':'fid=\'1\'',
                        'beanName':'UOrganizationTree',
                        'treeId'  :'fid',
                        'treeText':'fname',
                        'treeParentId':'fpid',
                        'treeOrder':'fcode'
                     }                                 
            })"></img>
    </div>

