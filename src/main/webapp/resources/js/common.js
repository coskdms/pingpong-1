$(document).ready(function(){
	init();
		var doc_width = $(window).width(); // 문서 로드될 때 문서 넓이 감지
		hdlr_switch(doc_width);

	$(window).resize(function(){
		var doc_width = $(window).width(); // 리사이즈 될 때 문서 넓이 감지
		hdlr_switch(doc_width);
	});

	

    $topBtn.click(function(){
    	$("html, body").stop().animate({
    		scrollTop:0
    	});
    });
	
    var hdH = $header.height();
    $(".hdMargin").css({
    	paddingTop:hdH
    });
    
    
    // 탭 개수에 따른 width
    var tab = $(".tab_s1");
    if(tab.length){
    	var tabLength = tab.find("li").length;
    	switch(tabLength){
    		case 1 : tab.find("li").css({ width:100+"%"});
    		break;
    		case 2 : tab.find("li").css({ width:49+"%" });
    		break;
    		case 3 : tab.find("li").css({ width:32+"%" });
    		break;
    		case 4 : tab.find("li").css({ width:23.5+"%" });
    		break;
    		case 5 : tab.find("li").css({ width:18.5+"%" });
    		break;
    	}
    	
    	
    	var tabContWrap = $("#tabContWrap");
    	tab.find("li").click(function(){
    		var idx = $(this).index();
    		tab.find("li").removeClass("on");
    		$(this).addClass("on");
    		tabContWrap.find("article").stop().hide();
    		tabContWrap.find("article:eq("+idx+")").stop().fadeIn();
    	})
    }
    
    //tutor일때 튜터신청 이미 했다고 말해주려고
    $("#tutorApp").on("click", function(){

    	$.ajax({
    		url: "/tutor/tutorTrue",
    		type: 'POST'
    	}).done(function(resp){
    		console.log(resp);
    		if(resp=='Y'){
    			//관리자에서 튜터신청서 pass Y로 만들어주고 멤버 grade도 tutor로 바꿔줘야함.
    			alert("이미 튜터입니다.");
    			return false;
    		}else if(resp=='N'){
    			alert("이미 신청하셨습니다. 신청 완료가 될때까지 기다려주세요.");
    			return false;
    		}
    		
    		location.href="/tutor/tutorApp"
    	})
        
    })

});


function init(){
	$gnb = $(".gnb");
	$header = $("header");
	$topBtn = $(".topBtn");
};


function initEvent_pc(val){
	//console.log(val);
	$gnb.children("li").children("a").off("click");
	$gnb.children("li").off("mouseenter");
	$gnb.children("li").on("mouseenter",function(){
		$gnb.find(".depth2").stop().slideUp();
		$(this).find(".depth2").stop().slideDown();
	}).on("mouseleave",function(){
		$(this).find(".depth2").stop().slideUp();
	})
	
	$header.find(".util > ul > li").mouseenter(function(){
		var delth2 = $(this).find(".depth2");
		if(delth2.length){
			delth2.stop().fadeIn();
		}
	}).mouseleave(function(){
		var delth2 = $(this).find(".depth2");
		if(delth2.length){
			delth2.stop().fadeOut();
		}		
	})
};


function gnbOff(obj){
	obj.find(".depth2").stop().slideUp();
};




/*
	모바일 함수 
*/
function initEvent_m(val){
	

	$gnb.children("li").children("a").off("mouseenter");
	$gnb.children("li").children("a").on("click",function(e){
		e.preventDefault();
		$gnb.find(".depth2").stop().slideUp();
		$(this).siblings(".depth2").stop().slideDown();
	});
	

};




function hdlr_switch(val) {
	if (val > 1200) {
		console.log("pc");
		initEvent_pc(val);
	} else {
		console.log("mobile");
		initEvent_m(val);
	};
};
