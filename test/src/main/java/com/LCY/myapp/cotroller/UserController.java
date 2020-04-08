package com.LCY.myapp.cotroller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.LCY.myapp.model.dao.CafeMapper;
import com.LCY.myapp.model.dao.OrderMapper;
import com.LCY.myapp.model.dao.UserMapper;
import com.LCY.myapp.model.dao.WishMapper;
import com.LCY.myapp.model.dto.User;

@Controller
public class UserController {
	
	@Autowired
	private UserMapper userMapper;
	
	@Autowired
	private OrderMapper orderMapper;
	
	@Autowired
	private WishMapper wishMapper;
	
	@Autowired
	private CafeMapper cafeMapper;

	@RequestMapping("/")
	public String index() {
		return "index";
	}
	
	@RequestMapping("goLogin")
	public String goLogin() {
		return "login";
	}
	
	@RequestMapping("goJoin")
	public String goJoin() {
		return "join";
	}
	
	@RequestMapping("goUpdate")
	public String goUserUpdate() {
		return "userUpdate";
	}
	
	@RequestMapping("logout")
	public String logOut(HttpSession session) {
		session.removeAttribute("user");
		return "index";
	}
	
	@RequestMapping(value = "myPage.do", method = RequestMethod.GET)
	public String MyPageAllList(Model model, HttpSession session) {
		User user = (User) session.getAttribute("user");
		model.addAttribute("orderList", orderMapper.orderList(user.getUser_id()));
		model.addAttribute("wishList", wishMapper.searchWishListByUser(user.getUser_id()));
		return "myPage";
	}

	@RequestMapping(value = "delete/{wish_num}")
	public String getDelete(Model model, @PathVariable int wish_num) {
		wishMapper.delete(wish_num);
		return "redirect:/myPage.do";
	}

	@RequestMapping(value = "/login.do", method = RequestMethod.POST)
	public String login(HttpServletRequest request, User user) {
		User user1 = userMapper.searchUser(user);
		if(user1 != null) {
			if(user.getUser_id().equals("admin")) {
				request.getSession().setAttribute("list", cafeMapper.getCafeAll());
				return "admin/listCafe";
			}
			request.getSession().setAttribute("user", user1);
			return "index";
		} else return "login";	
	}
	
	@RequestMapping(value = "/join.do", method = RequestMethod.POST)
	public String join(User user) {
		userMapper.insertUser(user);
		return "login";
	}
	
	@RequestMapping(value = "/idCheck", method = RequestMethod.POST, produces = "application/json; charset=utf8")
	@ResponseBody
	public Map<String, Boolean> idCheck(String user_id) {
		System.out.println(user_id);
		Map<String, Boolean> map = new HashMap<String, Boolean>();
		int check_num = userMapper.userIdCheck(user_id);
		
		if (check_num > 0) map.put("check", false);
		else map.put("check", true);
		
		return map;
	}

	@RequestMapping(value = "/nickNameCheck", method = RequestMethod.POST, produces = "application/json; charset=utf8")
	@ResponseBody
	public Map<String, Boolean> nickNameCheck(String user_nickName) {
		Map<String, Boolean> map = new HashMap<String, Boolean>();
		int check_num = userMapper.userNickNameCheck(user_nickName);
		
		if (check_num > 0) map.put("check", false);
		else map.put("check", true);
		
		return map;
	}
	
	@RequestMapping(value = "memberUpdate.do", method = RequestMethod.POST)
	public String userUpate(HttpSession session, User user) {
		userMapper.updateUser(user);
		return "index";
	}
}
