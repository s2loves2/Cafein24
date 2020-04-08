package com.LCY.myapp.cotroller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.LCY.myapp.model.dao.WishMapper;
import com.LCY.myapp.model.dto.Wish;

// @RestController 
// -> @ResponseBody 포함되어있다.

@Controller
public class WishController {
	
	@Autowired
	private WishMapper wishMapper;
	
	@RequestMapping(value = "insertWishList.do", method = RequestMethod.POST, produces = "application/json; charset=utf8")
	@ResponseBody
	public String insertWishList(Wish wish) {
		String msg = ""; 
		
		int insertNum = wishMapper.wishListInsert(wish);
		System.out.println("insertNum : " + insertNum);
		if(insertNum > 0 ) msg = "success"; 
		else msg = "fail";
		
		return msg;
	}
	
	@RequestMapping(value = "/deleteWishList.do", method = RequestMethod.POST, produces = "application/json; charset=utf8")
	@ResponseBody
	public String deleteWishList(Wish wish) {
		System.out.println(wish);
		wishMapper.wishListDelete(wish);
		
		return "success";
	}

}
