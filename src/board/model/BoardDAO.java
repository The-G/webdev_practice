package board.model;

import java.io.FileInputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

public class BoardDAO {
	private static BoardDAO boardDAO = null;
	
	private String driver = null;
	private String url = null;
	private String username = null;
	private String password = null;	
	
	private BoardDAO() { // 생성자. 생성될 때 이부분 수행!!

		// compile이 아닌 runtime 때 이 값이 필요하도록 셋팅!!! (url, username, password)
		Properties pr = new Properties();
		String props =
				this.getClass().getResource("").getPath() + "/database.properties"; // 현재 경로의 파일!!
		
		try {
			pr.load(new FileInputStream(props));
			driver = pr.getProperty("driver");
			url = pr.getProperty("url");
			username = pr.getProperty("username");
			password = pr.getProperty("password");
			
			Class.forName(driver);
			
		} catch (ClassNotFoundException | IOException e) {
			e.printStackTrace();
		}
	}
	
	////
	private Connection getConnection() throws SQLException {
		// compile이 아닌 runtime 때 이 값이 필요하도록 셋팅!!! (url, username, password)
		return DriverManager.getConnection(url, username, password);
	}

	private void dbClose(PreparedStatement ps, Connection cn) {
		// TODO Auto-generated method stub
		if (ps != null) try{ps.close();} catch(Exception e){}
		if (cn != null) try{cn.close();} catch(Exception e){}
	}

	private void dbClose(ResultSet rs, PreparedStatement ps, Connection cn) {
		if (rs !=null) try{rs.close();} catch(Exception e) {}
		if (ps !=null) try{rs.close();} catch(Exception e) {}
		if (cn !=null) try{rs.close();} catch(Exception e) {}
	}
	////

	// Singleton 패턴이지!!
	public static BoardDAO getInstance() {
		if(boardDAO == null) {
			boardDAO = new BoardDAO();			
		}
		return boardDAO;
	}

	public boolean insertBoard(BoardVO boardVO) {
		// DB access module 분리
		Connection cn = null;
		PreparedStatement ps = null;

		boolean result = false;

		StringBuffer sql = new StringBuffer();
		sql.append(" INSERT INTO tb_board(no, title, name, content, pwd)");
		sql.append(" VALUES(seq_board.nextval, ?, ?, ?, ?)");

		try {
			cn = getConnection();
			ps = cn.prepareStatement(sql.toString());
			ps.setString(1, boardVO.getTitle());
			ps.setString(2, boardVO.getName());
			ps.setString(3, boardVO.getContent());
			ps.setString(4, boardVO.getPwd());
		 	ps.executeUpdate();
		 	result = true;
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			dbClose(ps,cn);
		}
		
		return result;
	}
	
	public boolean updateBoard(BoardVO boardVO) {
		// DB access module
		Connection cn = null;
		PreparedStatement ps = null;
		
		boolean result = false;
		
		StringBuffer sql = new StringBuffer();
		sql.append(" UPDATE tb_board SET");
		sql.append(" 		title = ?, name=?, content=?");
		sql.append(" WHERE  no=? AND pwd=?");
		
		try {
			cn = getConnection();
			ps = cn.prepareStatement(sql.toString());
			ps.setString(1, boardVO.getTitle());
			ps.setString(2, boardVO.getName());
			ps.setString(3, boardVO.getContent());
			ps.setLong(4, boardVO.getNo());
			ps.setString(5, boardVO.getPwd());
			
			if (ps.executeUpdate() > 0) {
				result = true;
			} // 잘 수행 되었으면, 비밀번호도 맞으면 true(1) 이 반환되니까!!
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			dbClose(ps,cn);
		}
		return result;	
	}
	
	public boolean deleteBoard(BoardVO boardVO) {
		Connection cn = null;
		PreparedStatement ps = null;
		
		boolean result = false;
		
		StringBuffer sql = new StringBuffer();
		sql.append(" DELETE FROM tb_board");
		sql.append(" WHERE  no=? AND pwd=?");
			
		try {
			cn = getConnection();
			ps = cn.prepareStatement(sql.toString());
			ps.setLong(1, boardVO.getNo());
			ps.setString(2, boardVO.getPwd());
			
			if (ps.executeUpdate() > 0) {
				result = true;
			} // 잘 수행 되었으면, 비밀번호도 맞으면 true(1) 이 반환되니까!!
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			dbClose(ps,cn);
		}
		return result;
	}
	
	public List<BoardVO> getBoardList(long startnum, long endnum) { // 현재 페이지 게시물 list 뽑아냄!!
		Connection cn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
				
		List<BoardVO> list = new ArrayList<BoardVO>();
		
		StringBuffer sql = new StringBuffer();
		sql.append(" select B.*");
		sql.append(" from (select rownum AS rnum, A.*");
		sql.append("       from (select no, title, name, regdate, viewcount");
		sql.append("             from tb_board");
		sql.append("             order by no desc) A) B");
		sql.append(" where rnum between ? and ?"); // 이부분을 더 빠르게 처리하는 방법 있다!!
		/* 	
			1. query를 원하는 순서로 정렬
			2. rownum을 붙인다.
			3. 원하는 부분을 가져온다..
		*/
		
		try{
			cn = getConnection();
			ps = cn.prepareStatement(sql.toString());
			ps.setLong(1, startnum);
			ps.setLong(2, endnum);
			
			rs = ps.executeQuery();
			while(rs.next()) { // 맨 윗줄은 빈줄이라고 하네, 그래서 next가 있으면 계속 돌아감!!
				BoardVO boardVO = new BoardVO();
				boardVO.setNo(rs.getLong("no"));
				boardVO.setName(rs.getString("name"));
				boardVO.setTitle(rs.getString("title"));
				boardVO.setRegdate(rs.getDate("regdate"));
				boardVO.setViewcount(rs.getInt("viewcount"));
				
				list.add(boardVO);			
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			dbClose(rs,ps,cn);
		}
		return list;
	}
	
	public long getTotalCount() {	// 게시물 전체 개수를 구함!
		Connection cn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		String sql_total_count = " select count(no) as cnt from tb_board";
		long result = 0;
		try{
			cn = getConnection();		
			ps = cn.prepareStatement(sql_total_count);
			rs = ps.executeQuery();
			
			if (rs.next()) {
				result = rs.getLong("cnt");		
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dbClose(rs,ps,cn);
		}
		return result;		
	}
	
	public BoardVO getBoard(long no){
		Connection cn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		StringBuffer sql = new StringBuffer();
		sql.append(" select no, name, title, content, regdate, viewcount");
		sql.append(" from TB_BOARD");
		sql.append(" where no = ?");
		
		BoardVO boardVO = null;

		try {
			cn = getConnection();
			ps = cn.prepareStatement(sql.toString());
			ps.setLong(1, no);
			rs = ps.executeQuery();
			if (rs.next()) {
				boardVO = new BoardVO();
				boardVO.setNo(rs.getLong("no"));
				boardVO.setName(rs.getString("name"));
				boardVO.setTitle(rs.getString("title"));
				boardVO.setContent(rs.getString("content"));
				boardVO.setViewcount(rs.getInt("viewcount"));
				boardVO.setRegdate(rs.getDate("regdate"));
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dbClose(rs,ps,cn);
		}
		return boardVO;		
	}	
}

