<%@ page contentType="text/html;charset=utf-8" import="java.sql.*" %>

<%
request.setCharacterEncoding("utf-8"); //Set encoding
//INPUT.JSP 페이지로부터 받아온 파라미터를 각각 get메소드로 가져옴
String userID = request.getParameter("userID");
String userPassword = request.getParameter("userPassword");
//POST로 Input.html로부터 입력받은 내용을 변수화
try{
    //jdbc 참조변수 준비
    PreparedStatement pstmt = null;
    //드라이버 로딩
    Class.forName("com.mysql.jdbc.Driver");
    String url = "jdbc:mysql://tier-3-rds.ckpqfjkmk5sf.ap-northeast-3.rds.amazonaws.com/micom";
    //db연동
    Connection con = DriverManager.getConnection(url,"root","mypassword");
    //SQL준비
    String query = "INSERT INTO user(userID, userPassword) VALUES(?,?)";
    //prepareStatement 가 객체의 동일한 질의문을 특정값만 바꾸어서 여러번 실행할
시유용
    //Statement 객체는 단순 질의문 사용에 적합
    pstmt = con.prepareStatement(query);
    pstmt.setString(1, userID);
    pstmt.setString(2, userPassword);
    //실행
    pstmt.executeUpdate();
    //JDBC자원닫기
    pstmt.close();
    con.close();
}
catch (SQLException e) {
        out.println("SQLException: " + e.getMessage());
        out.println("SQLState: " + e.getSQLState());
        out.println("VendorError: " + e.getErrorCode());
        e.printStackTrace(); // 에러 스택 트레이스 출력
    } catch (Exception e) {
    }
response.sendRedirect("dbcon.jsp");

%>
