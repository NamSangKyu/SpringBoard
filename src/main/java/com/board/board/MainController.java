package com.board.board;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import dto.BoardDTO;
import service.BoardService;
import service.MemberService;
import vo.MemberVO;

@Controller
public class MainController {
	@RequestMapping("/")
	public String test() {
		return "index";
	}
	
	@RequestMapping("/boardView.do")
	public String boardView(@RequestParam String bno, Model model) {
		BoardDTO dto = BoardService.getInstance().selectBoardDTO(Integer.parseInt(bno));
		model.addAttribute("board", dto);
		return "board/board_view";
	}
	@RequestMapping("/boardWriteView.do")
	public String boardWriteView() {
		return "board/board_write_view";
	}
	@RequestMapping("/boardWrite.do")
	public String boardWriteController(HttpServletRequest request, Model model) {
		String title = request.getParameter("title");
		String writer= request.getParameter("writer");
		String content = request.getParameter("content");
		BoardDTO dto = BoardService.getInstance().insertBoardDTO(new BoardDTO(title, writer, content));
		model.addAttribute("board", dto);
		return "board/board_view";
	}
	@RequestMapping("/login.do")
	public String login() {
		return "member/login";
	}
	@RequestMapping("/loginAction.do")
	public String loginAction(HttpServletRequest request, Model model) {
		String id= request.getParameter("id");
		String pass = request.getParameter("pass");
		MemberVO vo = MemberService.getInstance().login(id, pass);
		HttpSession session = request.getSession();
		String result = null;
		if(vo == null) {
			session.setAttribute("login", false);
			result = "member/login";
		}else {
			session.setAttribute("login", true);
			session.setAttribute("name", vo.getName());
			session.setAttribute("id", vo.getId());
			session.setAttribute("grade", vo.getGrade().toLowerCase());
			result = "index";
			if(session.getAttribute("result_url").equals("write")){
				result = "board/board_write_view";
			}
		}
		return result;
	}
	@RequestMapping("/logout.do")
	public String login(HttpServletRequest request, Model model) {
		request.getSession().invalidate();
		return "index";
	}
}
