package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Repository;

import config.DBManager;
import exception.MemberException;
import vo.MemberVO;

public class MemberDAO {
	DataSource source;
	private JdbcTemplate jdbcTemplate;
	
	public MemberDAO(DataSource source) {
		this.source = source;
		jdbcTemplate = new JdbcTemplate(source);
	}

	public MemberVO selectMemberVO(String id) {
		MemberVO vo = null;
		String sql = "select * from member where id like ?";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			pstmt = source.getConnection().prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				vo = new MemberVO(rs.getString(1), rs.getString(2), rs.getString(3), rs.getInt(4));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} 

		return vo;
	}

	public void insertMemberVO(MemberVO vo) throws MemberException {
		PreparedStatement pstmt = null;
		String sql = "insert into member(id,pass,name,age) values(?,?,?,?)";
		try {
			Connection conn = source.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getId());
			pstmt.setString(2, vo.getPass());
			pstmt.setString(3, vo.getName());
			pstmt.setInt(4, vo.getAge());
			int count = pstmt.executeUpdate();
			if (count == 0)
				throw new MemberException("회원등록에 실패했습니다.");
			conn.commit();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public void updatePass(String id, String pass) throws MemberException {
		PreparedStatement pstmt = null;
		String sql = "update  member set pass = ? where id = ?";
		try {
			Connection conn = source.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, pass);
			pstmt.setString(2, id);
			int count = pstmt.executeUpdate();
			if (count == 0)
				throw new MemberException("암호수정에 실패했습니다.");
			
			conn.commit();
		} catch (SQLException e) {
			e.printStackTrace();
		}

	}

	public MemberVO login(String id, String pass) {
		MemberVO vo = null;
		String sql = "select id, name, pass, age, grade_name from member, grade_list where grade_no = grade and id like ? and pass like ?";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			pstmt = source.getConnection().prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pass);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				vo = new MemberVO(rs.getString(1), null, rs.getString(3), rs.getInt(4), rs.getString(5));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} 

		return vo;
	}

	public void updateMember(MemberVO vo) throws MemberException {
		String sql = "update member set pass=?,name=?,age=? where id=?";
		PreparedStatement pstmt = null;
		try {
			Connection conn = source.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getPass());
			pstmt.setString(2, vo.getName());
			pstmt.setInt(3, vo.getAge());
			pstmt.setString(4, vo.getId());

			int count = pstmt.executeUpdate();
			if (count == 0)
				throw new MemberException("수정할 회원정보가 없습니다.");
			conn.commit();
		} catch (SQLException e) {
			e.printStackTrace();
			throw new MemberException("수정할 회원정보가 없습니다.");
		}
	}

	public ArrayList<MemberVO> selectAllMemberVO() {
		ArrayList<MemberVO> list = new ArrayList<MemberVO>();
		String sql = "select id, name, pass, age, grade_name "
				+ "from member, grade_list where grade_no = grade order by grade desc";
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			pstmt = source.getConnection().prepareStatement(sql);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				list.add(new MemberVO(rs.getString(1), null, rs.getString(2), rs.getInt(4), rs.getString(5)));
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} 

		return list;
	}

	public ArrayList<MemberVO> searchMember(String kind, String search) {
		ArrayList<MemberVO> list = new ArrayList<MemberVO>();
		String sql = "select id, name, pass, age, grade_name " + "from member, grade_list where grade_no = grade and "
				+ kind + " like ? order by grade desc";
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			pstmt =source.getConnection().prepareStatement(sql);
			pstmt.setString(1, "%" + search + "%");
			rs = pstmt.executeQuery();
			while (rs.next()) {
				list.add(new MemberVO(rs.getString(1), null, rs.getString(2), rs.getInt(4), rs.getString(5)));
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return list;
	}

	public boolean updateManageMember(MemberVO vo) {
		String sql = "update member set name=?,age=?,grade="
				+ "(select grade_no from grade_list where grade_name = ?) where id=?";

		PreparedStatement pstmt = null;
		try {
			Connection conn = source.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getName());
			pstmt.setInt(2, vo.getAge());
			pstmt.setString(3, vo.getGrade());
			pstmt.setString(4, vo.getId());

			int count = pstmt.executeUpdate();
			if (count == 0)
				return false;
			conn.commit();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return true;
	}

	public boolean deleteMember(String id) {
		String sql = "delete from member where id=?";

		PreparedStatement pstmt = null;
		try {
			Connection conn = source.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);

			int count = pstmt.executeUpdate();
			if (count == 0)
				return false;
			conn.commit();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return true;
	}

}
