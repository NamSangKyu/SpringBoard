package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import dto.BoardDTO;
import dto.CommentDTO;

public class BoardDAO{
	
	private JdbcTemplate jdbcTemplate;
	public BoardDAO(DataSource source) {
		
		jdbcTemplate = new JdbcTemplate(source);
	}

	// 게시글 번호 뽑는 부분
	public int getBoardNO() {
		String sql = "select bno_seq.nextval from dual";
		List<Integer> list = jdbcTemplate.query(sql, new RowMapper<Integer>() {

			@Override
			public Integer mapRow(ResultSet rs, int rowNum) throws SQLException {
				return rs.getInt(1);
			}
			
		});
		return list.get(0);
	}

	public void insertBoardDTO(BoardDTO dto) {
		String sql = "insert into board(bno,title,writer,content) values(?,?,?,?)";
		int count = jdbcTemplate.update(sql,dto.getBno(),dto.getTitle(),dto.getWriter(),dto.getContent());
		System.out.println("게시글 삽입 결과 : "+count);
	}

	public BoardDTO selectBoardDTO(int bno) {
		String sql = "select * from board where bno = ?";
		List<BoardDTO> list= jdbcTemplate.query(sql, new RowMapper<BoardDTO>() {

			@Override
			public BoardDTO mapRow(ResultSet rs, int rowNum) throws SQLException {
				return new BoardDTO(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getInt(4), rs.getString(5),
						rs.getString(6), rs.getInt(7), rs.getInt(8));
			}
		},bno);
		return list.get(0);
	}

	public void addCount(int bno) {
		String sql = "update board set bcount=bcount + 1 where bno = ?";
		int count = jdbcTemplate.update(sql,bno);
		System.out.println("카운트 업데이트 결과 : "+ count);
	}

	public void addLikeHate(int bno, int mode) {
		String sql;
		if (mode == 0)
			sql = "update board set blike = blike + 1 where bno=?";
		else
			sql = "update board set bhate = bhate + 1 where bno=?";
		
		int count = jdbcTemplate.update(sql, bno);
		System.out.println("좋아요/싫어요 업데이트 결과 : "+ count);
	}

	public int selectLikeHate(int bno, int mode) {
		String sql;
		if (mode == 0)
			sql = "select blike from board where bno=?";
		else
			sql = "select bhate from board where bno=?";
		List<Integer> list = jdbcTemplate.query(sql, new RowMapper<Integer>() {

			@Override
			public Integer mapRow(ResultSet rs, int bno) throws SQLException {
				return rs.getInt(1);
			}
			
		});
		return list.get(0);
	}

	public ArrayList<BoardDTO> selectBoardList() {
		String sql = "select * from board";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<BoardDTO> list = (ArrayList<BoardDTO>) jdbcTemplate.query(sql, new RowMapper<BoardDTO>() {

			@Override
			public BoardDTO mapRow(ResultSet rs, int rowNum) throws SQLException {
				//							int, String, String, int, String, int, int) is undefined
				BoardDTO dto = new BoardDTO(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getInt(4), rs.getString(5), rs.getString(6), rs.getInt(7), rs.getInt(8));
				return dto;
			}
			
		});
		return list;
	}

	public int insertBoardComment(CommentDTO dto) throws SQLException {
		String sql = "insert into board_comment(cno, bno, writer, content) values(cno_seq.nextval,?,?,?)";
		int count = jdbcTemplate.update(sql, dto.getBno(),dto.getWriter(),dto.getContent());
		return count;
	}

	

}








