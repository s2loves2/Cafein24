package com.LCY.myapp.model.dto;

import lombok.Data;

@Data
public class Comment {
	private int cnum;
	private String user_id;
	private String cafe_code;
	private String content;
	private String comment_date;
	private double user_star;
}
