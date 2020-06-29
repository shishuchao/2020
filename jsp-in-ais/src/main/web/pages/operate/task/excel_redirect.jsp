<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="ais.operate.task.service.util.WriteExcel"%>
<%@ page import="java.io.File"%>
<%@ page import="java.io.InputStream"%>
<%@ page import="java.io.FileInputStream"%>
<%@ page import="java.io.OutputStream"%>
<%
	response.reset();
	 
    String project_id = (String) request.getParameter("project_id");
    
    if(project_id!=null&&!"".equals(project_id)&&!"null".equals(project_id)){
       String tempDir = request.getSession().getServletContext()
			.getRealPath("")
			+ File.separator
			+ "pages"
			+ File.separator
			+ "operate"
			+ File.separator + "task" + File.separator;
	WriteExcel writeExcel = new WriteExcel();
 

	File f =  writeExcel.exportExcel(tempDir, project_id);//
	 
	//InputStream ins = new FileInputStream(f);
	//byte[] b = new byte[ins.available()];
	//ins.read(b);
	//ins.close();
	response.setHeader("Content-Disposition", "attachment;filename=\""
			+ new String(("审计方案" + ".xls").getBytes(), "ISO-8859-1")
			+ "\";");
	//response.getOutputStream().write(b);
	OutputStream outputStream = response.getOutputStream();
	InputStream inputStream = new FileInputStream(f);
	byte[] buffer = new byte[1024];
	int i = -1;
	try {
		while ((i = inputStream.read(buffer)) != -1) {
			outputStream.write(buffer, 0, i);
		}
		outputStream.flush();
	} catch (Exception e) {
	} finally {

		outputStream.close();
		inputStream.close();
		outputStream = null;
		//response.reset();
		if (f != null) {
		f.delete();
			//System.out.println(" boolean " + f.delete());
		}

	}
    }
	
%>