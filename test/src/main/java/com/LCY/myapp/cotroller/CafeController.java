package com.LCY.myapp.cotroller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.LCY.myapp.model.dao.CafeMapper;
import com.LCY.myapp.model.dao.CommentMapper;
import com.LCY.myapp.model.dao.ProductMapper;
import com.LCY.myapp.model.dao.WishMapper;
import com.LCY.myapp.model.dto.Cafe;
import com.LCY.myapp.model.dto.CriteriaVO;
import com.LCY.myapp.model.dto.PageMakerVO;
import com.LCY.myapp.model.dto.User;
import com.LCY.myapp.model.dto.Wish;

@Controller
public class CafeController {
	
	@Autowired
	private CafeMapper cafeMapper;
	
	@Autowired
	private ProductMapper productMapper;
	
	@Autowired
	private CommentMapper commentMapper;
	
	@Autowired
	private WishMapper wishMapper;
	
	@RequestMapping("/admin/registCafe.do")
	public String registCafe() {	
		return "/admin/registCafe";
	}
	
	@RequestMapping(value = "/admin/insert.do", method = RequestMethod.POST)
    public String insertCafe(Cafe cafe){
		cafeMapper.insertCafe(cafe);
        return "redirect:/admin/listCafe.do";
    }
	

	@RequestMapping("/admin/{cafe_code}")
	public String viewCafe(HttpSession session, Model model, @PathVariable String cafe_code, CriteriaVO cri) {
		session.setAttribute("cafe_code", cafe_code);
		model.addAttribute("cafe", cafeMapper.cafeSearchById(cafe_code));
		model.addAttribute("commentList", commentMapper.searchCommentByCafe(cri, cafe_code));
		return "/admin/viewCafe";
	}
	
	// 상품 삭제
	@RequestMapping("/admin/delete/{cafe_code}")
	public String delteCafe(HttpSession session, Model model,
			@ModelAttribute("cafeList") List<Cafe> cafeList,
			@PathVariable String cafe_code){
		cafeMapper.deleteCafe(cafe_code);
		session.setAttribute("list", cafeList);
		return "/admin/listCafe";
	}
	
	@RequestMapping("/admin/modifyCafe.do")
	public String modifyCafe(Cafe cafe, Model model,
			@ModelAttribute("cafeList") List<Cafe> cafeList){
		cafeMapper.updateCafe(cafe);
		model.addAttribute("list", cafeList);
		return "/admin/listCafe";
	}
	
	@RequestMapping(value = "/admin/listCafe.do")
	public String listCafe(Model model,
			@ModelAttribute("cafeList") List<Cafe> cafeList) {
		model.addAttribute("list", cafeList);
		return "/admin/listCafe";
	}
	
	/////////////////////////////// 관리자 끝
	
	@RequestMapping(value = "cafeStart", method = RequestMethod.GET)
	public String cafeList(HttpServletRequest request, Cafe cafe,
			@ModelAttribute("cafeList") List<Cafe> cafeList) {
		request.getSession().setAttribute("cafeList", cafeList);
		return "cafeStart";
	}
	
	@RequestMapping(value = "searchCafe", method = RequestMethod.POST)
	public String searchCafe(Model model, String cafe_name) {
		model.addAttribute("cafeList", cafeMapper.cafeSearch(cafe_name));			
		return "cafeStart";			
	}
	
	@RequestMapping("cafeDetail/{cafe_code}")
	public String cafeDetail(HttpSession session, Model model, CriteriaVO cri, @PathVariable String cafe_code) {
		System.out.println(cri.getPageStrat());
		User user = (User) session.getAttribute("user");
		Wish wish = new Wish();
		wish.setUser_id(user.getUser_id());
		wish.setCafe_code(cafe_code);
		model.addAttribute("productList", productMapper.productSearchByCafeCode(cafe_code));
		model.addAttribute("isWish", wishMapper.searchWishListByUserAndCafeCode(wish));
		
		PageMakerVO pageMaker = new PageMakerVO();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(commentMapper.getCommentCount(cafe_code));
		model.addAttribute("commentList", commentMapper.searchCommentByCafe(cri, cafe_code));
		model.addAttribute("pageMaker", pageMaker);
		
		model.addAttribute("cafe", cafeMapper.cafeSearchById(cafe_code));
		model.addAttribute("maxComment", commentMapper.getCommentCount(cafe_code));
		
		return "cafeDetail";
	}
	
	@ModelAttribute("cafeList")
	public List<Cafe> getCafeList(){
		List<Cafe> cafeList = cafeMapper.getCafeAll();
		return cafeList;
	}

}
