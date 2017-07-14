package util.upload;

import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.awt.image.renderable.ParameterBlock;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Enumeration;

import javax.imageio.ImageIO;
import javax.media.jai.JAI;
import javax.media.jai.RenderedOp;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;


@WebServlet("/upload2.do")
public class MultiUploadServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		String savePath = "upload";
		int uploadFileSizeLimit = 50 * 1024 * 1024;
		String encType = "UTF-8";
		
		ServletContext context = getServletContext();
		String uploadFilePath = "C:/dev/upload";//context.getRealPath(savePath);

		System.out.println("서버상의 실제 디렉토리 : ");
		System.out.println(uploadFilePath);
		
		File dir = new File(uploadFilePath);
		if (!dir.exists()) {
			dir.mkdir();
		}

		try{
			MultipartRequest multi = new MultipartRequest(
				  request,
				  uploadFilePath,
				  uploadFileSizeLimit,
				  encType,
				  new DefaultFileRenamePolicy());
			
			Enumeration files = multi.getFileNames();
			
			while(files.hasMoreElements()) {
				boolean isImage = false;

				String file = (String) files.nextElement();
				String fileName = multi.getFilesystemName(file); // To check duplicate filename
				//중복된 파일을 업로드할 경우 파일명이 바뀐다.
				String ori_file_name = multi.getOriginalFileName(file); // To check duplicate filename

				System.out.println(multi.getContentType(file));

				isImage = multi.getContentType(file)
						 .substring(0,6)
						 .toLowerCase()
						 .equals("image/");
				String ext = multi.getContentType(file)
						  .substring(6).toLowerCase();

				if (isImage) {
					ParameterBlock pb = new ParameterBlock();
					pb.add(uploadFilePath + "/" + fileName);
					RenderedOp rOp = JAI.create("fileload", pb);
					BufferedImage bi = rOp.getAsBufferedImage();
					BufferedImage thumb = new BufferedImage(
							100, 100, BufferedImage.TYPE_INT_BGR);
					Graphics2D g = thumb.createGraphics();
					g.drawImage(bi, 0, 0, 100, 100, null);
					
					File f = new File(uploadFilePath + "/thumb_" + fileName);
					ImageIO.write(thumb, ext, f); // 기존의 type 그대로 이용 ext
				}
				
				if(fileName == null) { // 파일이 업로드 되지 않았을 때
					System.out.println("파일 업로드 되지 않았습니다.");
				} else { // 파일이 업로드 되었을 때
					out.print("<br> 업로드된 파일명 : " + fileName);
					out.print("<br> 원본 파일명 : " + ori_file_name);
					out.println("<br> 파일명 : <a href='download.do?filename=" + fileName + "'>" + fileName + "</a>");
					if (isImage) {
						out.println("<br/><img src='download.do?filename=" + 
								"thumb_" + fileName + "' />");	
						out.println("<br/><img src='download.do?filename=" + 
								fileName + "' />");					
						out.println("<hr/>");
					}
					if (multi.getContentType(file).equals("audio/mp3")) {
						out.println("<div><audio src='download.do?filename="+ fileName + 
								"' autoplay='autoplay' controls='controls'/></div>");
						out.println("<hr/>");
					}
				}
			}
		}catch(Exception e){
			e.printStackTrace();
//			System.out.println("예외 발생 : " + e.);
		} 
	}
}
