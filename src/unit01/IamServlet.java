package unit01;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class IamServlet
 */
@WebServlet("/IamServlet")
public class IamServlet extends HttpServlet {
	//html 코드 servlet에서 하기 힘들다. 그래서 이와 같이 한다!!
	private static final long serialVersionUID = 1L;

	private void doProcess( HttpServletRequest request, 
     						HttpServletResponse response, 
							String url) throws ServletException, IOException {
		RequestDispatcher dispatcher = request.getRequestDispatcher(url);
		dispatcher.forward(request, response);		
	}
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		처리하고 다음 url로 보낸다. view를 분리하기 위해서!!하는거임.
		doProcess(request, response, "/WEB-INF/views/form.jsp");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String iam = "그래, 난 " +  request.getParameter("name");
		request.setAttribute("iam", iam);
		doProcess(request, response, "/WEB-INF/views/process.jsp");
		
	}

}
