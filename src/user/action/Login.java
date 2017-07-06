package user.action;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.codec.digest.DigestUtils;
import org.apache.log4j.Logger;

import cookie.Cooker;

@WebServlet("/Login")
public class Login extends HttpServlet {
	private static Logger logger = Logger.getLogger(Login.class); // 공유해서 사용하기 위해서 static
																  // 공유해서 사용해야 resource 절약한다!!
	
	private static final long serialVersionUID = 1L;

	private void doProcess(HttpServletRequest request, HttpServletResponse response, String view) throws ServletException, IOException {
		RequestDispatcher dispatcher = request.getRequestDispatcher(view); // 원하는 경로로 이동!!
		dispatcher.forward(request, response);
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Cooker cooker = new Cooker(request);
		String user_id = null;
		if (cooker.exist("user_id")) {
			user_id = cooker.getValue("user_id");
		}
		request.setAttribute("user_id", user_id);
		
		doProcess(request, response, "/WEB-INF/views/user/login.jsp");
				
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String user_id = request.getParameter("user_id");
		String user_pw = DigestUtils.sha512Hex(request.getParameter("user_pw"));

		HttpSession session = request.getSession();
		logger.info("id : " + user_id);
		logger.info("pw : " + user_pw);
		// Info, Debug(detail하게 보고 싶을 때), Warn, Error, Fatal

		String user_name = null;
		
		Connection cn = null;
		PreparedStatement st = null;
		ResultSet rs = null;
		
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT user_name");
		sql.append(" FROM   t_mem");
		sql.append(" WHERE  user_id=?");
		sql.append(" and    user_pw=?");
		
		try {
			Class.forName("oracle.jdbc.OracleDriver");
			cn = DriverManager.getConnection(
					"jdbc:oracle:thin:@localhost:1521:xe", 
					"bigdata", 
					"bigdata");
			st = cn.prepareStatement(sql.toString());
			st.setString(1, user_id);
			st.setString(2, user_pw);
			rs = st.executeQuery();
			if (rs.next()) {
				user_name = rs.getString("user_name");
			} 
		} catch(Exception e){
			e.printStackTrace();
		} finally {
			if (rs != null) try {rs.close();} catch(Exception e){}
			if (st != null) try {st.close();} catch(Exception e){}
			if (cn != null) try {cn.close();} catch(Exception e){}
		}
		
		if(user_name != null) {
			// session 생성
			session.setAttribute("user_id", user_id);
			session.setAttribute("user_name", user_name);
			// logger.info("success login"); // 로그 남기기!!

			// cookie 생성
			String save_id = request.getParameter("save_id");
			response.addCookie(Cooker.createCookie("user_id", user_id, save_id != null ? 60*60*24*30 : 0)); // 30일 동안 아이디 저장!
			
			request.setAttribute("msg", "success login");
			request.setAttribute("url", "Main");
			doProcess(request, response, "result.jsp");
		} else {
			// logger.info("wrong ID or Paaword, Please check about that..");
			request.setAttribute("msg", "wrong ID or Paaword, Please check about that..");
			request.setAttribute("url", "Login");
			doProcess(request, response, "result.jsp");
		}
		
	}
}



