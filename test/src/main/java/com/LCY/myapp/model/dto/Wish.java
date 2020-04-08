package com.LCY.myapp.model.dto;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import lombok.Data;

@Configuration
@Data
public class Wish {
	private int wish_num;
	private String user_id;
	private String cafe_code;
	private String cafe_name;
	private String cafe_addr;
	
	@Bean(name = "wish")
	public Wish getWish() {
		return new Wish();
	}
}
