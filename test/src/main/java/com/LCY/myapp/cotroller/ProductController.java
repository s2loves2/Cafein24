package com.LCY.myapp.cotroller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.LCY.myapp.model.dao.ProductMapper;
import com.LCY.myapp.model.dto.Product;

@Controller
public class ProductController {

	@Autowired
	private ProductMapper productMapper;

	@RequestMapping(value = "/searchProductPrice.do", method = RequestMethod.POST, produces = "application/json; charset=utf8")
	@ResponseBody
	public Map<String, Integer> getProductPrice(Product product) {
		Map<String, Integer> maps = new HashMap<String, Integer>();
		maps.put("price", productMapper.getProductPrice(product));
		return maps;
	}

	// 매장에 맞는 상품 조회 (select)
	@RequestMapping(value = "/ItemRegister/{cafe_code}", method = RequestMethod.GET)
	public String creat(Model model, @PathVariable("cafe_code") String cafe_code) {
		model.addAttribute("productList", productMapper.productSearchByCafeCode(cafe_code));
		model.addAttribute("cafe_code", cafe_code);
		return "admin/ItemRegister";
	}

	// ?????
	@RequestMapping(value = "/login.do/new", method = RequestMethod.POST)
	public String create(Model model, Product product) {
		model.addAttribute(product);
		return "redirect:/ItemRegister";
	}
	
	// 상품 등록 (insert)
	@RequestMapping(value = "/productInsert.do", method = { RequestMethod.POST, RequestMethod.GET })
	@ResponseBody
	public String insertProduct(Model model, Product product) {
		String msg = "success";
		productMapper.insertProduct(product);
		return msg;
	}
	
	// 상품 삭제 (delete)
	@RequestMapping(value = "/deleteItem.do/{product_code}" , method = RequestMethod.GET)
	public String delete(@PathVariable String product_code) {
		System.out.println("delete .. product_code : "+product_code);
		productMapper.deleteProduct(product_code);
		return "admin/listCafe";
	}
}
