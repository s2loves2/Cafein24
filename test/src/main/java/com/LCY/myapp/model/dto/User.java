package com.LCY.myapp.model.dto;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import lombok.Data;

@Configuration
@Data
public class User {
	private String user_id;
	private String user_pw;
	private String user_nickName;
	private String user_tel;
	
	@Bean(name="user")
	public User getUser() {
		return new User();
	}
}
