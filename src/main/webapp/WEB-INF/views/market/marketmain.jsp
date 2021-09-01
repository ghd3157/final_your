<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:requestEncoding value="utf-8"/>
<c:set var="cartCount" value="${cartCount}"/>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>MainMarketList</title>
        <!-- Favicon-->
        <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
        <!-- Bootstrap icons-->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="css/styles.css" rel="stylesheet" />
        <link href="css/modal2.css" rel="stylesheet" />
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script type="text/javascript">
        $(document).ready(function() {
        	$('#ca_manu .dropdown-menu').hide();
        	
        	$('#ca_manu').mouseover(function () {
				$('.dropdown-menu').slideDown();
			});
        	$('.dropdown-menu').mouseleave(function () {
				$('.dropdown-menu').hide();
			});
		});
        </script>
        
        <script type="text/javascript">
        $(document).ready(function() {
        $("#btnSearch").click(function () {
        	location.href = "getSearchList.do?search=" + $("#_search").val();	
        	});
        });
        </script>
    </head>
    <body>
    	<div align="center" style="height: 100px">
    		<a href="home.do">메인으로 이동</a><br>
    		<a href="marketmain.do">상품페이지 메인으로 이동</a><br>
    		<a href="marketwrite.do">상품등록</a><br>
    		<a href="order.do">결제완료 목록</a>
    	</div>
    	<div align="right">회원가입/로그인</div>
        <!-- Navigation-->
        <nav class="navbar navbar-expand-lg navbar-light bg-light">
            <div class="container px-4 px-lg-5">
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav me-auto mb-2 mb-lg-0 ms-lg-4">
                    	<li class="nav-item dropdown" >
                            <a class="nav-link dropdown-toggle" id="ca_manu">전체 카테고리</a>
                            <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                                <li><a class="dropdown-item" href="marketlist.do?canum=1" id="canum1">
                                	<img src="./image/meat.png" alt="카테고리 아이콘" style="width: 24px; height: 24px;">
                                	정육</a>
                                </li>
                                <li><a class="dropdown-item" href="marketlist.do?canum=2" id="canum2">
                                	<img src="./image/fish.png" alt="카테고리 아이콘" style="width: 24px; height: 24px;">
                                	수산</a></li>
                                <li><a class="dropdown-item" href="marketlist.do?canum=3" id="canum3">
                                	<img src="./image/carrot.png" alt="카테고리 아이콘" style="width: 24px; height: 24px;">
                                	채소</a></li>
                                <li><a class="dropdown-item" href="marketlist.do?canum=4" id="canum4">
	                                <img src="./image/fruit.png" alt="카테고리 아이콘" style="width: 24px; height: 24px;">
	                                과일</a>
                                </li>
                                <li><a class="dropdown-item" href="'marketlist.do?canum=5">
                                	<img src="./image/kit.png" alt="카테고리 아이콘" style="width: 24px; height: 24px;">
                                	밀키트</a>
                                </li>
                            </ul>
                        </li>&nbsp;&nbsp;&nbsp;&nbsp;
                        <li class="nav-item"><a class="nav-link" aria-current="page" href="newMarketList.do">신상품</a></li>&nbsp;&nbsp;&nbsp;&nbsp;
                        <li class="nav-item"><a class="nav-link" href="#!">베스트</a></li>&nbsp;&nbsp;&nbsp;&nbsp;
                        <li class="nav-item"><a class="nav-link" href="#!">할인/특가</a></li>&nbsp;&nbsp;&nbsp;&nbsp;
                    </ul>
                    <form class="d-flex" action="getSearchList.do">
					    <input class="form-control me-2" placeholder="Search" aria-label="Search" id="_search">
					    <button class="btn btn-outline-success" type="button" id="btnSearch">Search</button>
				    </form>&nbsp;&nbsp;&nbsp;&nbsp;
                    <form class="d-flex" action="goCart.do">
                        <button class="btn btn-outline-dark" type="submit">
                            <i class="bi-cart-fill me-1"></i>
                            Cart
                            <span class="badge bg-dark text-white ms-1 rounded-pill">${cartCount}</span>
                        </button>
                    </form>
                </div>
            </div>
        </nav>
        <!-- Header-->
        <header class="bg-dark py-5">
            <div class="container px-4 px-lg-5 my-5">
                <div class="text-center text-white"> <!-- 광고 사진 링크 걸어둘곳 -->
                    <h1 class="display-4 fw-bolder">광고 사진</h1>
                    <p class="lead fw-normal text-white-50 mb-0">광고 서브 문구</p>
                </div>
            </div>
        </header>
        
        <!-- Section-->
        <section class="py-5">
        <h3 align="center">이 상품 어때요?</h3>
            <div class="container px-4 px-lg-5 mt-5">
                <div class="row gx-4 gx-lg-5 row-cols-2 row-cols-md-3 row-cols-xl-4 justify-content-center">
                    <c:forEach var="market" items="${marketlist}" varStatus="i" begin="0" end="3">
                    <div class="col mb-5">
                        <div class="card h-100">
                            <!-- Product image-->
                            <img class="card-img-top" src="./marketimage/${market.newmainpt}" alt="메인이미지" onclick="location.href='marketdetail.do?seq=${market.seq}'"/>
                            <!-- Product details-->
                            <div class="card-body p-4">
                                <div class="text-center">
                                    <!-- Product name-->
                                    <h5 class="fw-bolder" onclick="location.href='marketdetail.do?seq=${market.seq}'">${market.title}</h5>
                                    <!-- Product price-->
                                    <fmt:formatNumber value="${market.price}" pattern="#,###,###"/>원<br>
                                    <a style="font-size: 12px; color: gray;">${market.subtitle}</a>
                                </div>
                            </div>
                            <!-- Product actions-->
                            <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
                                <!--<div class="text-center"><a class="btn btn-outline-dark mt-auto" href="#">장바구니 담기</a></div> -->
                                <button type="button" class="btntt">장바구니 담기</button>
					  			<div class="modal">
						    		<div class="modal__overlay">
							    		<div class="modal__content">
								    		<div>${market.title}</div>
								    		<div><fmt:formatNumber value="${market.price}" pattern="#,###,###"/>원</div>
								     		<button type="button" class="close">닫기</button>
		    							</div>
	    							</div>
 			 					</div>
                            </div>
                        </div>
                    </div>
                    </c:forEach>
                </div>
            </div>
        </section>
        <section class="py-5">
        <h3 align="center">인기 상품</h3>
            <div class="container px-4 px-lg-5 mt-5">
                <div class="row gx-4 gx-lg-5 row-cols-2 row-cols-md-3 row-cols-xl-4 justify-content-center">
                    <c:forEach var="best" items="${bestmarketlist}" varStatus="i" begin="0" end="3">
                    <div class="col mb-5">
                        <div class="card h-100">
                            <!-- Product image-->
                            <img class="card-img-top" src="./marketimage/${best.newmainpt}" alt="..." onclick="location.href='marketdetail.do?seq=${best.seq}'"/>
                            <!-- Product details-->
                            <div class="card-body p-4">
                                <div class="text-center">
                                    <!-- Product name-->
                                    <h5 class="fw-bolder" onclick="location.href='marketdetail.do?seq=${best.seq}'">${best.title}</h5>
                                    <!-- Product price-->
                                    <fmt:formatNumber value="${best.price}" pattern="#,###,###"/>원<br>
                                    <a style="font-size: 12px; color: gray;">${best.subtitle}</a>
                                </div>
                            </div>
                            <!-- Product actions-->
                            <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
                            	<button type="button" class="btntt">장바구니 담기</button>
					  			<div class="modal">
						    		<div class="modal__overlay">
							    		<div class="modal__content">
								    		<div>${best.title}</div>
								    		<div><fmt:formatNumber value="${best.price}" pattern="#,###,###"/>원</div>
								     		<button type="button" class="close">닫기</button>
		    							</div>
	    							</div>
 			 					</div>
                            </div>
                        </div>
                    </div>
                    </c:forEach>
                </div>
            </div>
        </section>
		<!-- Page Content-->
        <div class="container px-4 px-lg-5">
            <!-- Heading Row-->
            <div class="row gx-4 gx-lg-5 align-items-center my-5">
                <div class="col-lg-7"><img class="img-fluid rounded mb-4 mb-lg-0" src="https://dummyimage.com/900x400/dee2e6/6c757d.jpg" alt="..." /></div>
                <div class="col-lg-5">
                    <h1 class="font-weight-light">행사 상품명</h1>
                    <p>간단한 상품 설명</p>
                    <br><br><br><br><br><br><br><br><br>
                </div>
            </div>
        </div>
        <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Core theme JS-->
        <script src="js/scripts.js"></script>
        
        <!-- 모달창 -->
		<script type="text/javascript">
			
			// Modal을 가져온다
			var modals = document.getElementsByClassName("modal");
			// Modal을 띄우는 클래스 이름을 가져온다.
			var btns = document.getElementsByClassName("btntt");
			// Modal을 닫는 close 클래스를 가져온다.
			var spanes = document.getElementsByClassName("close");
			var funcs = [];
			
			// Modal을 띄우고 닫는 클릭 이벤트를 정의한 함수
			function Modal(num) {
				return function(){
					// 해당 클래스의 내용을 클릭하면 Modal을 띄운다.
					btns[num].onclick = function(){
						modals[num].style.display = "block";
						console.log(num);
					};
					
					// 닫기 버튼 클릭하면 Modal이 닫힌다.
					spanes[num].onclick = function() {
						modals[num].style.display = "none";
					};
				};
			}
			// 원하는 Modal 수만큼 Modal 함수를 호출해서 funcs 함수에 정의한다.
			for(var i = 0; i< btns.length; i++){
				funcs[i] = Modal(i);
			}
			// 원하는 Modal 수만큼 funcs 함수를 호출한다.
			for(var j = 0; j< btns.length; j++){
				funcs[j]();
			}
			// Modal 영역 밖을 클릭하면 Modal을 닫는다.
			window.onclick = function(event) {
				if(event.target.className == "modal"){
					event.target.style.display = "none";	
				}
			};
		
		</script>
		
    </body>
</html>



