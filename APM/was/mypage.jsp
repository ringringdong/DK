<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>APM SV</title>
    <style>
        body {
            background-color: #f0f0f0;
            font-family: Arial, sans-serif;
            text-align: center;
            margin: 0;
            padding: 0;
        }

        #container {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background-color: #fff;
            width : 430px;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        h1 {
            color: #333;
        }

        table {
            margin: 0 auto;
        }

        table th, table td {
            padding: 10px;
            border-bottom: 1px solid #ccc;
        }

        /* 추가된 스타일 */
        #topbar {
            background-color: #007bff;
            color: #fff;
            padding: 10px;
            text-align: left;
        }

        #topbar h2 {
            margin: 0;
            padding-left: 20px;
        }

        #logout-btn {
            float: right;
            background-color: #dc3545;
            color: #fff;
            border: none;
            padding: 10px 20px;
            border-radius: 3px;
            cursor: pointer;
            margin-top: 20px; /* 수정된 부분: 로그아웃 버튼을 조금 아래로 이동 */
        }

        #logout-btn:hover {
            background-color: #bd2130;
        }
    </style>
</head>
<body>

    <!-- 상단 바 -->
    <div id="topbar">
        <h2>APM Server</h2>
        <form action="logout.jsp" method="post"> <!-- 로그아웃 처리를 위한 JSP 페이지로 액션 설정 -->
            <input id="logout-btn" type="submit" value="로그아웃">
        </form>
    </div>

    <div id="container">
        <h1>My Page</h1>

        <!-- Display User Information -->
        <div style="text-align: left; margin-bottom: 20px;">
            <%  
                request.setCharacterEncoding("utf-8"); //Set encoding

                Connection con = null;
                Statement stm = null;
                ResultSet rs = null;
                try {
                    Class.forName("org.mariadb.jdbc.Driver");
                    String myUrl = "jdbc:mariadb://localhost:3306/micom";
                    con = DriverManager.getConnection(myUrl, "root", "password1234!");

                    stm = con.createStatement();
                    if (stm.execute("SELECT * FROM session")) {
                        rs = stm.getResultSet();
            %>
            <table>
                <tr>
                    <th>User ID</th>
                    <td>
                        <%
                            while (rs.next()) {
                                out.println(rs.getString("userID") + "<br>");
                            }
                        %>
                    </td>
                </tr>
                <tr>
                    <th>Password</th>
                    <td>
                        <%
                            rs.beforeFirst();
                            while (rs.next()) {
                                out.println(rs.getString("userPassword") + "<br>");
                            }
                        %>
                    </td>
                </tr>
                <tr>
                    <th>Email</th>
                    <td>
                        <%
                            rs.beforeFirst();
                            while (rs.next()) {
                                out.println(rs.getString("email") + "<br>");
                            }
                        %>
                    </td>
                </tr>
                <tr>
                    <th>Phone Number</th>
                    <td>
                        <%
                            rs.beforeFirst();
                            while (rs.next()) {
                                out.println(rs.getString("phone_num") + "<br>");
                            }
                        %>
                    </td>
                </tr>
            </table>
            <%
                    }
                } catch (SQLException e) {
                    out.println("SQLException: " + e.getMessage());
                    out.println("SQLState: " + e.getSQLState());
                    out.println("VendorError: " + e.getErrorCode());
                    e.printStackTrace();
                } catch (Exception e) {
                    out.println("Exception: " + e.getMessage());
                    e.printStackTrace();
                } finally {
                    if (stm != null) {
                        stm.close();
                    }
                    if (con != null) {
                        con.close();
                    }
                }
            %>
        </div>
    </div>
</body>
</html>
