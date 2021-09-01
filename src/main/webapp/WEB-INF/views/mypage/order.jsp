<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>  
<c:set var="rv" value="${rvlist}"/>

<fmt:requestEncoding value="utf-8"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>orderPage</title>
<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
	<title>Cart</title>
	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css" integrity="sha384-UHRtZLI+pbxtHCWp1t77Bi1L4ZtiqrqD80Kn4Z8NTSRyMA2Fd33n5dQ8lWUE00s/" crossorigin="anonymous">
	<link rel="stylesheet" href="css/10-11.css" />
	<link href="css/styles.css" rel="stylesheet" /> 
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>
<div align="center" style="height: 100px">
    		<a>로고</a><br>
    		<a href="home.do">메인으로 이동</a><br>
    		<a href="marketmain.do">상품페이지 메인으로 이동</a><br>
    		<a href="marketwrite.do">상품등록</a><br>
    		<a href="order.do">결제완료 목록</a>
</div>
    
<table class="table">
  <thead>
    <tr>
      <th scope="col">주문번호</th>
      <th scope="col">상품 사진</th>
      <th scope="col">상품명</th>
      <th scope="col">수량</th>
      <th scope="col">가격</th>
      <th scope="col"></th>
    </tr>
  </thead>
  <tbody>
  <c:forEach var="list" items="${orderList}" varStatus="i" >
    <tr>
      <th scope="row">${list.ordernum}</th>
      <td><img src="./marketimage/${list.mainpt}" width="60" onclick="location.href='marketdetail2.do?itemnum=${list.itemnum}'"></td>
      <td onclick="location.href='marketdetail2.do?itemnum=${list.itemnum}'">${list.title}</td>
      <td>${list.count}개</td>
      <td>
      	<fmt:formatNumber value="${list.price * list.count}" pattern="#,###,###" />원
      	<br><a style="color: gray;">개당가격 : <fmt:formatNumber value="${list.price}" pattern="#,###,###" />원</a>
      </td>
      <c:choose>
      <%-- <c:when test="${fn:contains(cm, cclist.title) eq true and fn:contains(cm, cclist.content) eq true}"> --%>
      	<c:when test="${fn:contains(rv, list.itemnum) eq true}">
      		<td><input type="button" value="리뷰작성완료"></td>
      	</c:when>
      	<c:otherwise>
      		<td><input type="button" value="리뷰작성" onclick="location.href='writeReview.do?itemnum=${list.itemnum}&ordernum=${list.ordernum}'"></td>
      	</c:otherwise>
      </c:choose>	
    </tr>
  </c:forEach>  
  </tbody>
</table>
</body>
</html>
