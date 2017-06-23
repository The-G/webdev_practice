package unit01;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/AdditionServlet01") // 이 주소에서 아래의 get 방식과 post 방식이 작동한다!!!
public class AdditionServlet01 extends HttpServlet { // AdditionServlet도
														// class이다. HttpServlet을
														// 상속받은!!!
	// private static final long serialVersionUID = 1L; // 대형 프로젝트 분산서버 운영시
	// 필요하다..

	// public AdditionServlet01() { // 생성자임
	// super();
	// }

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.println("<html><body>");
		out.println("doGet 수행중");
		String name = request.getParameter("name");
		// out.println("그래, 난 " + name + ". 포기를 모르는 남자.");
		out.println("hi get " + name + "</body></html>");
		
		out.close();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		out.println("doPost 수행중");
		String name = request.getParameter("name");
		// out.println("그래, 난" + name + ". 포기를 모르는 남자.");
		out.println("hi post " + name);
		out.close();
	}

}
