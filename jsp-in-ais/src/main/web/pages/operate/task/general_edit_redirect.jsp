<%@ page import="ais.operate.doubt.service.util.GenerateFile"%>
<%@ page import="java.io.File,ais.framework.util.UUID"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page
        import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@ page import="org.springframework.web.context.WebApplicationContext"%>
<%@ page import="ais.project.start.model.ProjectStartObject"%>
<%@ page import="ais.operate.task.service.ITaskService"%>
<%@ page import="ais.user.service.IUUserService"%>
<%@ page import="java.util.List"%>

<%@page import="ais.user.model.UUser"%>
<%@ page import="java.net.URLDecoder" %>


<%
    UUser user = (UUser) session.getAttribute("user");
%>
<%
    String project_id = URLDecoder.decode(request.getAttribute("pro_id").toString(), "UTF-8");//交互过来的编项目码
    String type = (String) request.getAttribute("type");//交互的类型
    String file_id = (String) request.getAttribute("file_id");//附件id
    String mod_id = (String) request.getAttribute("mod_id");//附件名称
    if(mod_id != null) {
        mod_id = URLDecoder.decode(mod_id, "UTF-8");
    }
    String bns_id = (String) request.getAttribute("bns_id");//没有使用
    String url = (String) request.getAttribute("url");//没有使用
    String content =  URLDecoder.decode(request.getAttribute("content").toString(), "UTF-8");//联网交互内容

    String attach_name = (String) request.getAttribute("attach_name");//附件名称
    String fj = (String) request.getAttribute("fj");//附件名称base64字符串


    if (attach_name == null || attach_name.equals("")) {

        if (mod_id != null && !mod_id.equals("")) {
            attach_name = mod_id;
        } else {
            attach_name = "证据";
        }

    }
    String flag = "0";
    UUID uuid = new UUID();

    if (file_id != null && !"".equals(file_id.trim())) {

    } else {

        file_id = uuid.toString();
    }

    UUID uuid2 = new UUID();

    String file_id2 = uuid2.toString();

    if ("YD".equals(type)) {//疑点
        String tempDir = request.getSession().getServletContext()
                .getRealPath("")
                + File.separator
                + "pages"
                + File.separator
                + "operate"
                + File.separator
                + "task"
                + File.separator;
        GenerateFile test = new GenerateFile();
        if(fj!=null && !fj.trim().equals("") && !fj.equals("undefined")){
            try{
                test.write3(tempDir, fj, file_id, attach_name, file_id2, user);
            }catch(Exception e){
                e.printStackTrace();
            }
        }else{
            test.write2(tempDir, content, file_id, attach_name, file_id2, user);
        }
        //}

    } else if ("DG".equals(type)) {//底稿
        String tempDir = request.getSession().getServletContext()
                .getRealPath("")
                + File.separator
                + "pages"
                + File.separator
                + "operate"
                + File.separator
                + "task"
                + File.separator;
        GenerateFile test = new GenerateFile();
        if(fj!=null && !fj.trim().equals("") && !fj.equals("undefined")){
            try{
                test.write3(tempDir, fj, file_id, attach_name, file_id2, user);
            }catch(Exception e){
                e.printStackTrace();
            }
        }else{
            test.write2(tempDir, content, file_id, attach_name, file_id2, user);
        }
        //}
    } else if ("YDRE".equals(type)) {//只有附件的疑点
        //if (content != null && !"".equals(content.trim())) {//
        String tempDir = request.getSession().getServletContext()
                .getRealPath("")
                + File.separator
                + "pages"
                + File.separator
                + "operate"
                + File.separator
                + "task"
                + File.separator;
        GenerateFile test = new GenerateFile();
        test.writeYDRE(content, file_id,  attach_name, user);
        //}
    }
    if (project_id == null || "".equals(project_id)
            || "null".equals(project_id)) {
        flag = "1";
        out.print("请求错误！项目编码错误,请重新输入!");
    } else {
        //actual?
        WebApplicationContext ctx = WebApplicationContextUtils
                .getWebApplicationContext(application);
        ITaskService service2 = (ITaskService) ctx
                .getBean("operate-taskService");
        List pro_idList = service2
                .query("from ProjectStartObject where  project_code='"
                        + project_id + "'");
        String pro_id = "";
        if (pro_idList != null && pro_idList.size() > 0) {
            ProjectStartObject pro = (ProjectStartObject) pro_idList
                    .get(0);
            pro_id = pro.getFormId();
        }
        project_id = pro_id;//联网审计仍然使用项目编码

        if (pro_idList != null && pro_idList.size() > 0) {
            ProjectStartObject projectStartObject = (ProjectStartObject) pro_idList
                    .get(0);
            if (projectStartObject != null
                    && "0".equals(projectStartObject
                    .getActualize_closed())) {
                flag = "1";
                if ("BW".equals(type)) {
                    response
                            .sendRedirect("/ais/operate/doubt/fapEdit.action?project_id="
                                    + project_id
                                    + "&type="
                                    + type
                                    + "&file_id=" + file_id);

                } else if ("YD".equals(type)) {
                    response
                            .sendRedirect("/ais/operate/doubt/fapRedirect.action?project_id="
                                    + project_id
                                    + "&type="
                                    + type
                                    + "&file_id2="
                                    + file_id2
                                    + "&file_id=" + file_id);

                } else if ("YDRE".equals(type)) {
                    response
                            .sendRedirect("/ais/operate/doubt/fapEdit.action?project_id="
                                    + project_id
                                    + "&YDRE=true&&type=YD"
                                    + "&file_id2="
                                    + file_id2
                                    + "&file_id=" + file_id);

                } else if ("FX".equals(type)) {

                    response
                            .sendRedirect("/ais/pages/operate/task/found_add_fap.jsp?project_id="
                                    + project_id
                                    + "&type="
                                    + type
                                    + "&file_id=" + file_id);

                } else if ("DS".equals(type)) {

                    response
                            .sendRedirect("/ais/pages/operate/task/matters_add_fap.jsp?project_id="
                                    + project_id
                                    + "&type="
                                    + type
                                    + "&file_id=" + file_id);

                } else if ("DG".equals(type)) {
                    response
                            .sendRedirect("/ais/operate/manu/fapRedirect.action?project_id="
                                    + project_id
                                    + "&type="
                                    + type
                                    + "&file_id2="
                                    + file_id2
                                    + "&file_id=" + file_id);
                } else {

                    out.print("请求错误！");
                }

            } else {

            }

        } else {
        }

    }
%>
<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">

    <script lang="javascript">
        function test(s){

            if(s=='1'){

            }else{
                alert("该项目不处于实施阶段，不能添加疑点底稿！");
                window.close();
            }

        }
    </script>
</head>
<body onload=test(<%=flag%>)>
<br>
<br>
</body>
</html>
