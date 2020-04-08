$(function(){
	var isId = 'false';
	var isNickName = 'false';
	
	$('#id_btn').on('click', function() {
		event.preventDefault();
		var userid = $('#user_id').val();
		$.ajax({
			url : "idCheck",
			type : "POST",
			data : {
				user_id : userid
			},
			dataType : "json",
			async : false,
			success : function(data) {
				if (data.check) {
					alert('사용가능한 아이디입니다.');
					isId = 'true';
				} else {
					alert('이미 존재하는 아이디입니다.');
				}

				console.log('아이디 : ' + isId);
			},
			error : function(request, status, error) {
				console.log(request.responseText);
			}

		});
	}); // 아이디 중복체크
	
	$('#nickName_btn').on('click', function() {
		event.preventDefault();
		var userName = $('#user_nickName').val();
		$.ajax({
			url : "nickNameCheck",
			type : "POST",
			data : {
				user_nickName : userName
			},
			dataType : "json",
			async : false,
			success : function(data) {
				if (data.check) {
					alert('사용 가능한 닉네임 입니다.');
					isNickName = 'true';
				} else {
					alert('이미 존재하는 닉네임 입니다.');
				}

				console.log('닉네임 : ' + isNickName);
			},
			error : function(request, status, error) {
				console.log(request.responseText);
			}
		})

	}); // 닉네임 중복체크 
	
	$('#join_btn').on('click', function(event) {
		event.preventDefault();
		var is = 'true';
		console.log(isId + " : " + isNickName);

		if ($('#user_id').val() == "") {
			alert('아이디란이 비어있습니다.');
			is = 'false';
		}

		if ($('#user_pw').val() == "") {
			alert('암호란이 비어있습니다.');
			is = 'false';
		}

		if ($('#user_pw').val() != $('#pw_confirm').val()) {
			alert('암호가 일치하지 않습니다.');
			is = 'false';
		}

		if ($('#user_nickName').val() == "") {
			alert('닉네임란이 비어있습니다.');
			is = 'false';
		}

		if ($('#user_tel').val() == "") {
			alert('전화번호란이 비어있습니다.');
			is = 'false';
		}

		if (isId != 'true') {
			alert('아이디 중복체크를 해주세요');
			is = 'false'
		}

		if (isNickName != 'true') {
			alert('닉네임 중복체크를 해주세요');
			is = 'false';
		}

		if (is == 'true') {
			alert('회원가입이 완료 되었습니다. 로그인해 주세요!');
			joinForm.action = "join.do";
			joinForm.method = "POST";
			joinForm.submit();
		} else if (is == 'false') {
			alert('조건을 충족해주세요.');
		}
	}) // 회원가입 버튼
	
})