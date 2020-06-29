<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="ais.operate.manuscript.web.RTFCreator"%>
<%@ page import="java.io.File"%>
<%@ page import="java.io.InputStream"%>
<%@ page import="java.io.FileInputStream"%>
<%@ page import="java.io.OutputStream"%>
<%
	response.reset(); 
	String manu_id = (String) request.getParameter("manuscript_id");
    String pro_id = (String) request.getParameter("pro_id");
    
    if(manu_id!=null&&!"".equals(manu_id)&&!"null".equals(manu_id)){
    String tempDir = request.getSession().getServletContext()
			.getRealPath("")
			+ File.separator
			+ "pages"
			+ File.separator
			+ "operate"
			+ File.separator + "task" + File.separator;
	RTFCreator rTFCreator = new RTFCreator();
	String s = rTFCreator.createRTF4Manu("", tempDir, manu_id);//

	File f = new File(
			//"D:\\apache-tomcat-6.0.14\\webapps\\ais\\pages\\operate\\task\\"
			tempDir
			+ s + ".rtf");
	//InputStream ins = new FileInputStream(f);
	//byte[] b = new byte[ins.available()];
	//ins.read(b);
	//ins.close();
	response.setHeader("Content-Disposition", "attachment;filename=\""
			+ new String(("审计工作底稿" + ".rtf").getBytes(), "ISO-8859-1")
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
    }else if(pro_id!=null&&!"".equals(pro_id)&&!"null".equals(pro_id)){
       String tempDir = request.getSession().getServletContext()
			.getRealPath("")
			+ File.separator
			+ "pages"
			+ File.separator
			+ "operate"
			+ File.separator + "task" + File.separator;
	RTFCreator rTFCreator = new RTFCreator();
	String s = rTFCreator.createRTF4ManuList("", tempDir, pro_id);//

	File f = new File(
	tempDir
			//"D:\\apache-tomcat-6.0.14\\webapps\\ais\\pages\\operate\\task\\"
			+ s + ".rtf");
	//InputStream ins = new FileInputStream(f);
	//byte[] b = new byte[ins.available()];
	//ins.read(b);
	//ins.close();
	response.setHeader("Content-Disposition", "attachment;filename=\""
			+ new String(("审计报告" + ".rtf").getBytes(), "ISO-8859-1")
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