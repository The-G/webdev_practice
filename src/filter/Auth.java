package filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class Auth implements Filter{

	@Override
	public void init(FilterConfig fc) throws ServletException { // DB에서 뭔가 가져와야 할 때 이곳에서 수행!!
		// TODO Auto-generated method stub
		System.out.println("Auth Filter init() 수행중...");
	}

	@Override
	public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
			throws IOException, ServletException {
		// TODO Auto-generated method stub
		System.out.println("Auth Filter doFilter() 수행중...");
		HttpServletRequest request = (HttpServletRequest) req;
		HttpServletResponse response = (HttpServletResponse) res;
		HttpSession session = request.getSession();
		String contextPath = request.getContextPath();
		String action = request.getRequestURI().substring(
				contextPath.length());
		if (!(action.equals("/session2/session_form.jsp") ||
			  action.equals("/session2/session_add.jsp") ||
			  action.equals("/session2/main.jsp"))) { // 로그인 파일이 아닌데.
		
			if(session.getAttribute("user_id") == null) {  // 로그인도 안했으면. 아래 실행!!
				request.setAttribute("msg", "먼저 로그인이 필요합니다.");
				request.setAttribute("url", contextPath + "/session2/session_form.jsp");
				RequestDispatcher dispatcher = 
						request.getRequestDispatcher("/result.jsp");
				dispatcher.forward(request, response);
				return;
			}
		}  
		chain.doFilter(request, response); // 원래 하려 했던 것을 그대로 수행!!
	}

	@Override
	public void destroy() {
		// TODO Auto-generated method stub
		System.out.println("Auth Filter destory() 수행중...");
	}



}
