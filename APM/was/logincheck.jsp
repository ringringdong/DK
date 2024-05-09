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
    Class.forName("org.mariadb.jdbc.Driver");
    String url = "jdbc:mariadb://localhost:3306/micom";
    // db연동
    con = DriverManager.getConnection(url,"user","password1234!");

    // SQL 쿼리 준비
    String query = "SELECT * FROM user WHERE userID=? AND userPassword=?";
    pstmt = con.prepareStatement(query);
    pstmt.setString(1, userID);
    pstmt.setString(2, userPassword);

    // 쿼리 실행
    ResultSet rs = pstmt.executeQuery();

    // 로그인 확인
    if (rs.next()) {
        // 세션 테이블에 사용자 정보 삽입
        String insertQuery = "INSERT INTO session (userID, userPassword, email, phone_num) VALUES (?, ?, ?, ?)";
        PreparedStatement insertStmt = con.prepareStatement(insertQuery);
        insertStmt.setString(1, rs.getString("userID"));
        insertStmt.setString(2, rs.getString("userPassword"));
        insertStmt.setString(3, rs.getString("email"));
        insertStmt.setString(4, rs.getString("phone_num"));
        insertStmt.executeUpdate();
        insertStmt.close();
    %>
        <script>
            window.location.href = "http://192.168.56.210/login_success.html";
        </script>
    <%
        
    } else {
        // 로그인 실패 시 처리
    %>
        <script>
            window.location.href = "http://192.168.56.210/login_failed.html";
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
