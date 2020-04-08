package com.LCY.myapp.cotroller;


import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.LCY.myapp.model.dao.CafeMapper;
import com.LCY.myapp.model.dao.OrderMapper;
import com.LCY.myapp.model.dto.Cafe;
import com.LCY.myapp.model.dto.Order;
import com.LCY.myapp.model.dto.User;

@Controller
public class OrderController {
	
	@Autowired
	private OrderMapper orderMapper;
	
	@Autowired
	private CafeMapper cafeMapper;

	@RequestMapping(value = "insertOrderList.do", method = RequestMethod.POST)
	public String InsertOrderList(HttpSession session, Order order, String cafe_code) {
		User user = (User) session.getAttribute("user");
		Cafe cafe = cafeMapper.cafeSearchById(cafe_code);
		order.setUser_id(user.getUser_id());
		order.setCafe_name(cafe.getCafe_name());
		orderMapper.insertOrderList(order);
		
		return "index";
	}
}
