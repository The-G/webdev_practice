package user.action;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class Main
 */
@WebServlet("/Main")
public class Main extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private void doProcess(HttpServletRequest request, HttpServletResponse response, String view) throws ServletException, IOException {
		RequestDispatcher dispatcher = request.getRequestDispatcher(view); // 원하는 경로로 이동!!
		dispatcher.forward(request, response);
	}

	@Override
	protected void service(HttpServletRequest request, 
						   HttpServletResponse response) throws ServletException, IOException { // post get put delete 다 받아줌!!

		HttpSession session = request.getSession();
		String user_name = (String) session.getAttribute("user_name");
		String user_id = (String) session.getAttribute("user_id");

		if (user_name != null && user_id != null) {
			request.setAttribute("msg", user_name + "(" + user_id + ") 님이 로그인 하였습니다");
			doProcess(request, response, "/WEB-INF/views/user/main.jsp");			
		} else {
			request.setAttribute("msg", "먼저 로그인 하세요!!!");
			request.setAttribute("url", "Login");
			doProcess(request, response, "result.jsp");
		}
	}
	
}
