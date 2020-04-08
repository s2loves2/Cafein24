package com.LCY.myapp.cotroller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.LCY.myapp.model.dao.CafeMapper;
import com.LCY.myapp.model.dao.CommentMapper;
import com.LCY.myapp.model.dto.Comment;

@Controller
public class CommentController {

	@Autowired
	private CommentMapper commentMapper;
	
	@Autowired
	private CafeMapper cafeMapper;
	
	@RequestMapping(value = "commentInsert.do", method = RequestMethod.POST)
	@ResponseBody
	public String insertComment(Comment comment){
		String cafe_code = comment.getCafe_code();
		commentMapper.commentInsert(comment);
		double cafe_star = commentMapper.commentStarSum(cafe_code);
		cafeMapper.updateCafeStar(cafe_code, cafe_star);
		return "success";
	}
	
	@RequestMapping("/admin/commentDelete.do/{cnum}")
	public String deleteComment(HttpSession session, @PathVariable int cnum) {
		String cafe_code = (String) session.getAttribute("cafe_code");
		System.out.println(cafe_code);
		commentMapper.commentDelete(cnum);
		double cafe_star = commentMapper.commentStarSum(cafe_code);
		cafeMapper.updateCafeStar(cafe_code, cafe_star);
		return "admin/listCafe";
	}
}
