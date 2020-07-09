<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/header.jsp" />
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=521d781cfe9fe7597693f2dc29a10601&libraries=services"></script>

<style>
	#title{width:80%;}
	#clickLatlng{width:100%;}
    .hAddr {position:absolute;left:10px;top:10px;border-radius: 2px;background:#fff;background:rgba(255,255,255,0.8);z-index:1;padding:5px;}
    #centerAddr {display:block;margin-top:2px;font-weight: normal;}
    .bAddr {padding:5px;text-overflow: ellipsis;overflow: hidden;white-space: nowrap;}
</style>
<script>
	$(function() {
		
		$("input, textarea").blur(function(){
			var thisVal = $(this).val();
			$(this).val(textChk(thisVal));
		})
		
		function textChk(thisVal){
			var replaceId  = /(script)/gi;
			var textVal = thisVal;
		    if (textVal.length > 0) {
		        if (textVal.match(replaceId)) {
		        	textVal = thisVal.replace(replaceId, "");
		        }
		    }
		    return textVal;
		}
	
		//오늘날짜 전에 클릭 안되게 걸어주기 
		$('#apply_start').datepicker({
			dateFormat : 'yy-mm-dd',
			minDate : 0,
			maxDate : '+1m',
			onClose : function(selectedDate){
				$('#apply_end').datepicker("option", "minDate", selectedDate);
			},
			onSelect: function(dateText, inst){
				var stDate = dateText.split("-");
				var dt = new Date(stDate[0], stDate[1], stDate[2]);
				var year = dt.getFullYear(); //년도구하기
				var month = dt.getMonth() +1;	//한달뒤의 달 구하기
				var month = month +"";	//문자형태
				if(month.length=="1") var month="0"+month;	//두자리 정수형태
				var day = dt.getDate();
				var day = day+"";
				if(day.length=="1") var day="0"+day;
				
				var nextMonth = year +"-" + month+"-"+ day;
				$("#apply_end").datepicker("option", "maxDate", nextMonth);
			}
		}).datepicker('setDate', new Date());

		$('#apply_end').datepicker({
			dateFormat : 'yy-mm-dd',
			minDate : 0,
			maxDate : '+1m',
			onClose : function(selectedDate) {
				$('#apply_start').datepicker("option", "maxDate", selectedDate);
			}
		});

		$('#start_date').datepicker({
			dateFormat : 'yy-mm-dd',
			minDate : 7,
			maxDate : '+1m +7d',
			onClose : function(selectedDate) {
				$('#end_date').datepicker("option", "minDate", selectedDate);
			},
			onSelect: function(dateText, inst){
				var stDate = dateText.split("-");
				var dt = new Date(stDate[0], stDate[1], stDate[2]);
				var year = dt.getFullYear();
				var month = dt.getMonth() +1;
				var month = month +"";
				if(month.length=="1") var month="0"+month;   
				var day = dt.getDate();
				var day = day+"";
				if(day.length=="1") var day="0"+day;
				
				var nextMonth = year +"-" + month+"-"+ day;
				$("#end_date").datepicker("option", "maxDate", nextMonth);
			}
		});
		
		$('#end_date').datepicker({
			dateFormat : 'yy-mm-dd',
			minDate : 7,
			maxDate : '+1m +7d',
			onClose : function(selectedDate) {
				$('#start_date').datepicker("option", "maxDate", selectedDate);
			}
		});
		
		
/* 
 		
		$('#start_date').on('change', function() {
			var endDate = $('#end_date').val();
			if (endDate != '') {
				$('#end_date').val('');
			}
		})  */

		$("#price").focusout(function() {
			var priceVal = $(this).val();
			if (priceVal>300000) {
				alert("최대 30만원입니다.");
				$(this).val('');
			}
		})

		var start_hourVal = $("#start_hour").val();
		var end_hourVal = $("#end_hour").val();

		$("#max_num").focusout(function() {
			var maxVal = $(this).val();
			if(maxVal<5){
				alert("최소 5명입니다.");
				$(this).val('');
			}else if(maxVal>30){
				alert("최대 30명입니다.");
				$(this).val('');
			}
		})

		$("#frm").on("submit", function() {
			var titleVal = $("#title").val();
			var summernoteVal = $("#summernote").val();
			var priceVal = $("#price").val()
			var apply_startVal = $("#apply_start").val();
			var apply_endVal = $("#apply_end").val();
			var start_dateVal = $("#start_date").val();
			var end_dateVal = $("#end_date").val();
			var max_numVal = $("#max_num").val();
			var sidoVal = $("#sido1").val();
			var gugunVal = $("#gugun1").val();

			if (titleVal.length == 0) {
				alert("제목을 입력해주세요");
				return false;
			} else if (priceVal == 0) {
				alert("가격을 입력해주세요");
				return false;
			} else if (apply_startVal.length == 0) {
				alert("모집시작 기간을 선택해주세요");
				return false;
			} else if (apply_endVal.length == 0) {
				alert("모집마감 기간을 선택해주세요");
				return false;
			} else if (start_dateVal.length == 0) {
				alert("수업시작 기간을 선택해주세요");
				return false;
			} else if (end_dateVal.length == 0) {
				alert("수업마감 기간을 선택해주세요");
				return false;
			} else if (max_numVal.length == 0) {
				alert("인원을 입력해주세요");
				return false;
			} else if (sidoVal == '시, 도 선택') {
				alert("시,도 를 선택해주세요.");
				return false;
			} else if (gugunVal == '구, 군 선택') {
				alert("구,군 을 선택해주세요.");
				return false;
			} else if (summernoteVal.length == 0) {
				alert("내용을 입력해주세요");
				return false;
			}
		})

		$('#summernote').summernote({
			height: 300,
			lang: "ko-KR",
			callbacks:{
				onImageUpload : function(files){
					uploadSummernoteImageFile(files[0],this);
				}
			}
		}); 

	});

	function uploadSummernoteImageFile(file, editor) {
		data = new FormData();
		data.append("file", file);
		$.ajax({
			data : data,
			type : "POST",
			url : "/summerNote/uploadSummernoteImageFile",
			contentType : false,
			processData : false,
			success : function(data) {
	        	//항상 업로드된 파일의 url이 있어야 한다.
				$(editor).summernote('insertImage', data.url);
			}
		});
	}		
</script>

<div id="subWrap" class="hdMargin">
	<section id="subContents">
		<article id="lessonApp_view" class="inner1200">
			<div class="tit_s1">
				<h2>Lesson</h2>
				<p>새 강의 등록하기</p>
			</div>

			<form action="lessonAppProc" id="frm" method="post">
				<div class="title_wrap">
					<div class="tit_s3">
						<h4>제목</h4>
					</div>
					<div class="right">
						<input type="text" id="title" name="title"
							placeholder="강의 성격이 드러날 키워드를 포함하여 간결한 제목으로 설정해 주세요.">
					</div>

				</div>


				<div class="price_wrap">
					<div class="tit_s3">
						<h4>가격</h4>
						<span class="notice">*한달기준 최대 30만원 입니다. 일기준 최대 만원으로 잡아 날짜에 맞춰 금액을 정해주세요.</span>
					</div>
					<div class="right">
						<input type="text" id="price" name="price" placeholder="총 가격">
						원 
					</div>
				</div>


				<div class="language_wrap">
					<div class="tit_s3">
						<h4>언어</h4>
					</div>
					<div class="right">
						<select id="language" name="language">
							<c:forEach var="i" items="${lanList}">
								<option value="${i.language}">${i.language}</option>
							</c:forEach>
						</select>
					</div>
				</div>



				<div class="apply_date">
					<div class="tit_s3">
						<h4>모집 기간</h4>
					</div>
					<label for="apply_start" class="calendar_icon">
						<i class="fa fa-calendar" aria-hidden="true"></i>
					</label>
					<input type="text" id="apply_start" name="apply_start" size="12" readonly> 
					~ 
					<label for="apply_end" class="calendar_icon">
						<i class="fa fa-calendar" aria-hidden="true"></i>
					</label>
					<input type="text" id="apply_end" name="apply_end" size="12" readonly> 
				</div>

				<div class="lesson_date">
					<div class="tit_s3">
						<h4>수업 기간</h4>
						<span class="notice">*수업기간은 최대 한달만 가능합니다.</span>
					</div>
					<label for="start_date" class="calendar_icon">
						<i class="fa fa-calendar" aria-hidden="true"></i>
					</label>
					<input type="text" id="start_date" name="start_date" size="12" readonly>
					 ~ 
					<label for="end_date" class="calendar_icon">
						<i class="fa fa-calendar" aria-hidden="true"></i>
					</label>
					<input type="text" id="end_date" name="end_date" size="12" readonly> 
				</div>

				<div class="lesson_time">
					<div class="tit_s3">
						<h4>수업 시간</h4>
					</div>
					<!-- <input type="time" id="start_hour" name="start_hour"> : 
					<input type="time" id="end_hour" name="end_hour"> -->
					<select id="start_hour" name="start_hour">
						<option>01</option>
						<option>02</option>
						<option>03</option>
						<option>04</option>
						<option>05</option>
						<option>06</option>
						<option>07</option>
						<option>08</option>
						<option>09</option>
						<option>10</option>
						<option>11</option>
						<option>12</option>
						<option>13</option>
						<option>14</option>
						<option>15</option>
						<option>16</option>
						<option>17</option>
						<option>18</option>
						<option>19</option>
						<option>20</option>
						<option>21</option>
						<option>22</option>
						<option>23</option>
						<option>24</option>
					</select> : <select id="start_minute" name="start_minute">
						<option>00</option>
						<option>15</option>
						<option>30</option>
						<option>45</option>
					</select> ~ <select id="end_hour" name="end_hour">
						<option>01</option>
						<option>02</option>
						<option>03</option>
						<option>04</option>
						<option>05</option>
						<option>06</option>
						<option>07</option>
						<option>08</option>
						<option>09</option>
						<option>10</option>
						<option>11</option>
						<option>12</option>
						<option>13</option>
						<option>14</option>
						<option>15</option>
						<option>16</option>
						<option>17</option>
						<option>18</option>
						<option>19</option>
						<option>20</option>
						<option>21</option>
						<option>22</option>
						<option>23</option>
						<option>24</option>
					</select> : <select id="end_minute" name="end_minute">
						<option>00</option>
						<option>15</option>
						<option>30</option>
						<option>45</option>
					</select>
				</div>

				<div class="max_num_wrap">
					<div class="tit_s3">
						<h4>최대 인원</h4>
					</div>
					<!-- 조건 걸기 -->
					<input type="text" id="max_num" name="max_num"
						placeholder="최소5명 최대30명">
				</div>

				<div class="map">
					<div class="tit_s3">
						<h4>장소</h4>
					</div>
					<select name="sido1" id="sido1"></select> 
					<select name="gugun1" id="gugun1"></select>
					<div class="hAddr">
				        <span class="title">지도중심기준 행정동 주소정보</span>
				        <span id="centerAddr"></span>
			 		</div>
					<div id="map" style="width:500px;height:400px;"></div>
						
				</div>

				<div class="contents">
					<div class="tit_s3">
						<h4>커리큘럼</h4>
					</div>
					<textarea id="summernote" name="curriculum"></textarea>
				</div>
				<div>
					<button id="submit">신청하기</button>
				</div>
			</form>
		</article>
	</section>
	<script>
		new sojaeji('sido1', 'gugun1');
		
		var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
		var options = { //지도를 생성할 때 필요한 기본 옵션
			center : new kakao.maps.LatLng(33.450701, 126.570667), //지도의 중심좌표.
			level : 3
		//지도의 레벨(확대, 축소 정도)
		};
		var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴

		var sidogugun;
		$("#gugun1").change(function() {
			var sido = $("#sido1").val();
			var gugun = $("#gugun1").val();
			sidogugun = sido + ' ' + gugun;
			
			$(this).wrap('<input type="text" name="location" value="'+sidogugun+'">');
			
			// 주소-좌표 변환 객체를 생성합니다
			var geocoder = new kakao.maps.services.Geocoder();

			// 주소로 좌표를 검색합니다
			geocoder.addressSearch(sidogugun, function(result, status) {
				// 정상적으로 검색이 완료됐으면 
				if (status === kakao.maps.services.Status.OK) {

					var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

					// 결과값으로 받은 위치를 마커로 표시합니다
					var marker = new kakao.maps.Marker({
						map : map,
						position : coords
					});

					// 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
					map.setCenter(coords);
				
				}
				
			});
		})
		
		var marker = new kakao.maps.Marker(), // 클릭한 위치를 표시할 마커입니다
		    infowindow = new kakao.maps.InfoWindow({zindex:1}); // 클릭한 위치에 대한 주소를 표시할 인포윈도우입니다

		// 지도를 클릭했을 때 클릭 위치 좌표에 대한 주소정보를 표시하도록 이벤트를 등록합니다
		kakao.maps.event.addListener(map, 'click', function(mouseEvent) {
		    searchDetailAddrFromCoords(mouseEvent.latLng, function(result, status) {
		        if (status === kakao.maps.services.Status.OK) {
		            var detailAddr = !!result[0].road_address ? '<div>도로명주소 : ' + result[0].road_address.address_name + '</div>' : '';
		            detailAddr += '<div>지번 주소 : ' + result[0].address.address_name + '</div>';
		            
		            var content = '<div class="bAddr">' +
		                            '<span class="title">법정동 주소정보</span>' + 
		                            detailAddr + 
		                        '</div>';

		            // 마커를 클릭한 위치에 표시합니다 
		            marker.setPosition(mouseEvent.latLng);
		            marker.setMap(map);

		            // 인포윈도우에 클릭한 위치에 대한 법정동 상세 주소정보를 표시합니다
		            infowindow.setContent(content);
		            infowindow.open(map, marker);
		        }   
		    });
		});

	</script>
</div>

<jsp:include page="/WEB-INF/views/footer.jsp" />