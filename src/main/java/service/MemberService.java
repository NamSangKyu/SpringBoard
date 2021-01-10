package service;

import java.util.ArrayList;

import org.springframework.context.annotation.AnnotationConfigApplicationContext;

import config.DIContext;
import dao.MemberDAO;
import exception.MemberException;
import vo.MemberVO;

public class MemberService {
	private static MemberService instance = new MemberService();
	private MemberDAO dao;
	private MemberService() {
		AnnotationConfigApplicationContext context = new AnnotationConfigApplicationContext(DIContext.class);
		dao = context.getBean("memberDao",MemberDAO.class);
	}
	
	public static MemberService getInstance() {
		if(instance==null)
			instance= new MemberService();
		return instance;
	}
	
	public void insertMemberVO(MemberVO vo) throws MemberException {
		//회원정보 조회
		if(dao.selectMemberVO(vo.getId())!=null)
			throw new MemberException("이미 회원정보가 있습니다.");
		//회원정보 등록
		dao.insertMemberVO(vo);
	}

	public void findMemberVO(String id, String name) throws Exception {
		MemberVO vo = dao.selectMemberVO(id);
		System.out.println(vo.toString());
		System.out.println(name);
		if(!vo.getName().equals(name))
			throw new Exception("정보에 해당하는 회원정보가 없습니다.");
	}
	
	public void updatePass(String id, String pass) throws MemberException {
		dao.updatePass(id,pass);
	}
	
	public MemberVO login(String id, String pass) {
		return dao.login(id,pass);
	}
	public MemberVO selectMemberVO(String id) {
		return dao.selectMemberVO(id);
	}
	
	public void updateMemberVO(MemberVO vo) throws MemberException {
		dao.updateMember(vo);
	}
	public boolean updateManageMemberVO(MemberVO vo) throws MemberException {
		return dao.updateManageMember(vo);
	}
	public ArrayList<MemberVO> selectAllMemberVO(){
		return dao.selectAllMemberVO();
	}
	public ArrayList<MemberVO> searchMember(String kind, String search){
		return dao.searchMember(kind,search);
	}
	
	
}










