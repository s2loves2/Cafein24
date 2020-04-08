package com.LCY.myapp.model.dto;

import lombok.Data;

@Data
public class Order {
	private int order_code;
	private String user_id;
	private String cafe_name;
	private String product_name;
	private int product_code;
	private int product_price;
}
