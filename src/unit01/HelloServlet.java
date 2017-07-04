package unit01;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class HelloServlet
 */
// @WebServlet("/HelloServlet") // annotation 이라고 한다. 주소로 기록되네!!
								// @WebServlet("/HelloServlet") (value="/HelloServlet") 이랑 같은거네
// web.xml에서 servlet 추가해서 annotation을 대체 할 수 있다!!
public class HelloServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		out.println("<html>");
		out.println("<head><title>Hello Servlet</title></head>");
		out.println("<body><h1>Hello Servlet</h1></body></html>");
		out.close();
	
	}


}
