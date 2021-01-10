package service;

import java.sql.SQLException;
import java.util.ArrayList;

import javax.sql.DataSource;

import org.springframework.context.annotation.AnnotationConfigApplicationContext;

import config.DBManager;
import config.DIContext;
import dao.BoardDAO;
import dto.BoardDTO;
import dto.CommentDTO;

public class BoardService {
	private static BoardService instance = new BoardService();
	private BoardDAO dao;
	public BoardService() {
		AnnotationConfigApplicationContext context = new AnnotationConfigApplicationContext(DIContext.class);
		dao = context.getBean("boardDao",BoardDAO.class);
		System.out.println("BoardService Instance");
	}
	public static BoardService getInstance() {
		if(instance == null)
			instance = new BoardService();
		return instance;
	}

	public BoardDTO insertBoardDTO(BoardDTO dto) {
		int bno = dao.getBoardNO(); //게시글 번호 뽑음
		System.out.println("bno : "+bno);
		dto.setBno(bno);//게시글 번호 셋팅
		dao.insertBoardDTO(dto);
		return dao.selectBoardDTO(bno);
	}
	
	public BoardDTO selectBoardDTO(int bno) {
		//조회수 카운트
		dao.addCount(bno);
		return dao.selectBoardDTO(bno);
	}
	public ArrayList<BoardDTO> selectBoardList(){
		return dao.selectBoardList();		
	}
	
	public int insertBoardComment(CommentDTO dto) throws SQLException {
		return dao.insertBoardComment(dto);
	}
}	









