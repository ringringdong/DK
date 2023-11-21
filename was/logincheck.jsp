<%@ page language="java" contentType="text/html; charset=UTF-8" import="java.sql.*, javax.servlet.http.*" %>

<%
request.setCharacterEncoding("UTF-8");

// 사용자가 입력한 아이디와 비밀번호 가져오기
String userID = request.getParameter("userID");
String userPassword = request.getParameter("userPassword");

try {
    // jdbc 참조변수 준비
    Connection con = null;
    PreparedStatement pstmt = null;

    // 드라이버 로딩
    Class.forName("com.mysql.jdbc.Driver");
    String url = "jdbc:mysql://tier-3-rds.ckpqfjkmk5sf.ap-northeast-3.rds.amazonaws.com/micom";
    // db연동
    con = DriverManager.getConnection(url,"root","mypassword");

    // SQL 쿼리 준비
    String query = "SELECT * FROM user WHERE userID=? AND userPassword=?";
    pstmt = con.prepareStatement(query);
    pstmt.setString(1, userID);
    pstmt.setString(2, userPassword);

    // 쿼리 실행
    ResultSet rs = pstmt.executeQuery();

    // 로그인 확인
    if (rs.next()) {

    %>
        <script>
            window.location.href = "login_success.html";
        </script>
    <%
        
    } else {
        // 로그인 실패 시 처리
    %>
        <script>
            window.location.href = "login_failed.html";
        </script>
    <%
    }

    // 자원 해제
    rs.close();
    pstmt.close();
    con.close();
} catch (SQLException e) {
    // 예외 처리
    e.printStackTrace();
    out.println("SQLException: " + e.getMessage());
} catch (ClassNotFoundException e) {
    e.printStackTrace();
    out.println("ClassNotFoundException: " + e.getMessage());
}
%>
