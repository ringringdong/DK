<%@ page language="java" contentType="text/html; charset=UTF-8" import="javax.servlet.http.*,java.io.*,java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>User Information</title>
</head>
<body>
    <h1>User Information</h1>
    
    <%-- 세션이 없거나 userID가 null이면 로그인 페이지로 리다이렉트 --%>
    <% if(session == null || session.getAttribute("userID") == null) { %>
        <% response.sendRedirect("login.jsp"); %>
    <% } else { %>
        <%-- 세션에서 사용자 정보를 가져와 변수에 저장 --%>
        <% String userID = (String)session.getAttribute("userID"); %>
        <% String email = (String)session.getAttribute("email"); %>
        <% String phone_num = (String)session.getAttribute("phone_num"); %>

        <%-- 사용자 정보를 출력 --%>
        <p>User ID: <%= userID %></p>
        <p>Email: <%= email %></p>
        <p>Phone Number: <%= phone_num %></p>

        <%-- 로그아웃 링크 --%>
        <a href="logout.jsp">Logout</a>
    <% } %>
</body>
</html>
