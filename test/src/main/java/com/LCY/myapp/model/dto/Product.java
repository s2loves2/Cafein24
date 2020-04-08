package com.LCY.myapp.model.dto;

import lombok.Data;

@Data
public class Product {
	private String product_code;
	private String cafe_code;
	private int product_price;
	private String product_name;
	private int product_type;
	private String product_img;

}
