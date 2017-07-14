package util.upload;

import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.awt.image.renderable.ParameterBlock;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

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

@WebServlet("/upload3.do")
public class UploadServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, 
			HttpServletResponse response) throws ServletException, IOException {
		System.out.println("testtest");
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		// 여기를 바꿔주면 다운받는 경로가 바뀜
		String savePath = "C:/Users/student/Desktop";
		// 최대 업로드 파일 크기 5MB로 제한
		int uploadFileSizeLimit= 50 * 1024 * 1024;
		String encType = "UTF-8";
		
		ServletContext context = getServletContext();
		String uploadFilePath = "C:/dev/upload";//context.getRealPath(savePath);
		// RealPath가 아닌 외부에 노출되지 않는 특정 경로를 지정해 주는 것이 좋다!!!! 
		System.out.println("서버상의 실제 디렉토리 : ");
		System.out.println(uploadFilePath);
		
		File dir = new File(uploadFilePath);
		if (!dir.exists()) {
			dir.mkdir();
		}
		
		boolean isImage = false;
		
		try{
			MultipartRequest multi = new MultipartRequest(
					request, 				// request 객체
					uploadFilePath, 		// 서버상의 실제 디렉토리
					uploadFileSizeLimit, 	// 최대 업로드 파일 크기
					encType, 				// 인코딩 방법
					new DefaultFileRenamePolicy());	// 동일한 이름이 존재하면 새로운 이름이 부여됨
			
			String fileName = multi.getFilesystemName("uploadFile"); // 업로드된 파일의 이름 얻기
						
			isImage = multi.getContentType("uploadFile")
				 .substring(0,6)
				 .toLowerCase()
				 .equals("image/");
			
			String ext = multi.getContentType("uploadFile")
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
				out.println("<br> 글쓴이 : " + multi.getParameter("name"));
				out.println("<br> 제 &nbsp; 목 : " + multi.getParameter("title"));
				out.println("<br> 파일명 : <a href='download.do?filename=" + fileName + "'>" + fileName + "</a>");
				if (isImage){
					out.println("<hr/>");
//					out.println("<br/><img src='../upload" + 
//							"/" + fileName + "' />"); 		  // 이 방법 권장 X, 보안성 떨어진다!!, 위치가 노출되니까!!
															  // 다운로드 프로그램을 만들어야 한다!!
					out.println("<br/><img src='download.do?filename=" + 
							"thumb_" + fileName + "' />");	
					out.println("<br/><img src='download.do?filename=" + 
							fileName + "' />");					
				}
				if (multi.getContentType("uploadFile").equals("audio/mp3")) {
					out.println("<audio src='download.do?filename="+ fileName + 
							"' autoplay='autoplay' controls='controls'/>");
				}
			}
		}catch(Exception e){
			System.out.println("예외 발생 : " + e);
		}
		
	}

}