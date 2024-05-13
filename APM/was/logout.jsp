<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("utf-8"); //Set encoding   
    // 데이터베이스 연결 관련 변수를 초기화합니다.
    Connection con = null;
    Statement stmt = null;

    try {
        // JDBC 드라이버를 로드합니다.
        Class.forName("org.mariadb.jdbc.Driver");

        // 데이터베이스 연결을 수행합니다.
        String myUrl = "jdbc:mariadb://localhost:3306/micom";
        con = DriverManager.getConnection(myUrl, "user", "password1234!");

        // SQL 쿼리를 실행하여 session 테이블의 모든 데이터를 삭제합니다.
        String deleteQuery = "DELETE FROM session";
        stmt = con.createStatement();
        stmt.executeUpdate(deleteQuery);
    } catch (SQLException e) {
        // SQL 예외 처리
        e.printStackTrace();
    } catch (Exception e) {
        // 기타 예외 처리
        e.printStackTrace();
    } finally {
        // 모든 리소스를 해제합니다.
        try {
            if (stmt != null) {
                stmt.close();
            }
            if (con != null) {
                con.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // 로그아웃 후 리다이렉트할 URL을 지정합니다.
    String redirectURL = "http://192.168.56.220"; // 원하는 URL로 변경하세요.

    // 지정된 URL로 리다이렉트합니다.
    response.sendRedirect(redirectURL);
%>
