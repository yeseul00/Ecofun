<%@page import="java.util.Date"%>
<%@page import="java.util.Locale"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	String path = request.getSession().getServletContext().getRealPath("/") + "se2\\upload"; // 이미지가 저장될 주소
String fileName = "";

if (request.getContentLength() > 10 * 1024 * 1024) {
%>
<script>
	alert("업로드 용량(총 10Mytes)을 초과하였습니다.");
	history.back();
</script>
<%
	return;
} else {
try {
	MultipartRequest multi = new MultipartRequest(request, path, 15 * 1024 * 1024, "UTF-8",
	new DefaultFileRenamePolicy());
	java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyyMMddHHmmss", java.util.Locale.KOREA);
	String upfile = (multi.getFilesystemName("Filedata"));
	if (!upfile.equals("")) {
		String dateString = formatter.format(new java.util.Date()); // 년년년년월월일일시시분분초초
		String extName = upfile.substring(upfile.lastIndexOf(".")); // .확장자
		fileName = dateString + extName; // 년년년년월월일일시시분분초초.확장자

		File sourceFile = new File(path + File.separator + upfile); // File(경로\원본)
		File targetFile = new File(path + File.separator + fileName); // File(경로\년년년년월월일일시시분분초초.확장자) 

		sourceFile.renameTo(targetFile); // what????

		System.out.println("upfile : " + upfile);
		System.out.println("fileName : " + fileName);
		System.out.println("targetFile : " + targetFile);

		sourceFile.delete();
%>
<form id="fileform" name="fileform" method="post">
	<input type="hidden" name="fileName" value="<%=fileName%>">
	<input type="hidden" name="path" value="<%=path%>">
	<input type="hidden" name="fcode" value="<%=path%>">
</form>
<%
	}
} catch (Exception e) {
System.out.println("e : " + e.getMessage());
}
}
%>

<script type="text/javascript">
	function fileAttach() {
		f = document.fileform;
		fpath = f.path.value;
		fname = f.fileName.value;
		fcode = fpath + fname;

		try {
			window.opener.pasteHTML(fname);
			window.close();
		} catch (e) {
		}
	}
	fileAttach();
	this.window.close();
</script>
