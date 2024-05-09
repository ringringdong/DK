<%@ page contentType="text/html; charset=utf-8" import="java.sql.*" %>

<%
request.setCharacterEncoding("utf-8"); //Set encoding

//INPUT.JSP 페이지로부터 받아온 파라미터를 각각 get메소드로 가져옴
String userID = request.getParameter("userID");
String userPassword = request.getParameter("userPassword");
String email = request.getParameter("email");
String phone_num = request.getParameter("phone_num");

//POST로 Input.html로부터 입력받은 내용을 변수화
try{
    //jdbc 참조변수 준비
    PreparedStatement pstmt = null;
    //드라이버 로딩
    Class.forName("org.mariadb.jdbc.Driver");
    String url = "jdbc:mariadb://localhost:3306/micom";
    //db연동
    Connection con = DriverManager.getConnection(url,"user","password1234!");
    //SQL준비
    String query = "INSERT INTO user(userID, userPassword, email, phone_num) VALUES(?,?,?,?)";
    //prepareStatement 가 객체의 동일한 질의문을 특정값만 바꾸어서 여러번 실행할시유용
    //Statement 객체는 단순 질의문 사용에 적합
    pstmt = con.prepareStatement(query);
    pstmt.setString(1, userID);
    pstmt.setString(2, userPassword);
    pstmt.setString(3, email);
    pstmt.setString(4, phone_num);
    //실행
    pstmt.executeUpdate();
    //JDBC자원닫기
    pstmt.close();
    con.close();
}
catch (SQLException e) {
    // SQL 예외 처리
    out.println("SQLException: " + e.getMessage());
    out.println("SQLState: " + e.getSQLState());
    out.println("VendorError: " + e.getErrorCode());
    e.printStackTrace();
} catch (Exception e) {
    // 기타 모든 예외 처리
    out.println("Exception: " + e.getMessage());
    e.printStackTrace();
}

    response.sendRedirect("http://192.168.56.210/sign_success.html");
%>
