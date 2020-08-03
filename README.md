# pingpong
## 1. PingPong 프로젝트 설명 및 담당 역할
  * 서로 모국어 및 자신이 할 수 있는 언어를 다른 사람들과 교환을 하여 언어를 학습 할 수 있는 사이트
  * 담당역할
    <튜터> 
    - 게시글 등록, 삭제, 출력 
    - 게시글 검색, 출력 형태 지정(모집 형태 검색 버튼, 최신순/조회순/추천순/평점순) 
    - 키워드 상세 검색 
    - Datepicker를 이용한 날짜 지정, 날짜 검색 
    - KAKAO Map API, sojaeji.js를 이용한 위치 지정, 위치 검색 
    - Summernote API를 이용한 게시글 등록 
    - 파일 업로드, 다운로드 
    - I'mport를 이용한 결제 
    - Scheduler를 이용한 진행도 관리 
    - AOP로 이용 제한(로그인 안 한 경우 로그인 페이지 이동) 

## 2. 파일 정보
* 튜터에 관한것만 설명합니다.
* src파일만 보시면 됩니다.
* main
  - java/kh/pingpong : 
    - AOP 기능 (aspect 확인)
    - 페이징 기능 (config 확인)
    - 진행도 관리 (scheduler 확인)
    - 파일 업로드 및 다운로드(file), 결제기능(payments), 좋아요(likelist), 찜하기(jjim), 신고하기(reportlist), 게시글 등록/삭제/출력, 검색
      (controller -> service -> dao -> mapper 순으로 확인)
      - controller : File, Payments, Tutor(다운로드, 결제를 제외하고 여기에 다 있음), Summernote 확인
      - dao : File, Tutor 확인
      - dto : File, Files, Jjim, Lesson, Likelist, Location, Reportlist, Summernote, Tutee, TutorApp 확인
      - service : tutor 확인
  - resources :
    - mappers -> tutor-mapper.xml 확인
  - webapp : 
    - WEB-INF :
      -views : tutor 파일 전부, mypage -> tutorRecord의 환불 코드 확인 가능, 
      index가 첫 시작페이지로 header와 footer를 참조하고있음, 신고(reportpage.jsp) 확인
    - resources : FrontEnd 참고(js, css, font, img)
      
      
