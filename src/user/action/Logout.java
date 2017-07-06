package user.action;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

/**
 * Servlet implementation class Logout
 */
@WebServlet("/Logout")
public class Logout extends HttpServlet {
	
	private static Logger logger = Logger.getLogger(Login.class);
	
	private static final long serialVersionUID = 1L;

	private void doProcess(HttpServletRequest request, HttpServletResponse response, String view) throws ServletException, IOException {
		RequestDispatcher dispatcher = request.getRequestDispatcher(view); // 원하는 경로로 이동!!
		dispatcher.forward(request, response);
	}
	
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String user_name = (String) session.getAttribute("user_name");
		String user_id = (String) session.getAttribute("user_id");
		session.invalidate();
		logger.info(user_name + "(" + user_id + ")" +"님이 로그아웃!!");
		request.setAttribute("msg", user_name + "(" + user_id + ")" +"님이 로그아웃!!");
		request.setAttribute("url", "Login");
		doProcess(request, response, "result.jsp");	
	}

}
