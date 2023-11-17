<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>DK3_tier_SV</title>
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

        form {
            text-align: left;
        }

        label {
            display: block;
            margin-bottom: 10px;
        }
        input[type="text"],
        input[type="password"] {
            width: 90%;
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 3px;
        }

        input[type="submit"] {
            background-color: #007BFF;
            color: #fff;
            border: none;
            padding: 10px 20px;
            border-radius: 3px;
            cursor: pointer;
            margin-bottom : 5px;
        }

        input[type="submit"]:hover {
            background-color: #0056b3;
        }

        form:last-child input[type="submit"] {
            margin-right: 0;
        }
    </style>
</head>
<body>
    <div id="container">
        <h1>DB조회 및 삭제(SERVER1)</h1>

        <!-- Add a form to enter the user to delete -->
        <form action="" method="post">
            <label for="userIDToDelete">사용자 ID</label>
            <input type="text" id="userIDToDelete" name="userIDToDelete">
            <input type="submit" value="사용자 삭제">
        </form>

        <form action="index.html">
            <input type="submit" value="로그인 페이지">
        </form>

        <form action="sign_up.html">
            <input type="submit" value="회원가입  페이지">
        </form>

        <%-- Check if the form is submitted and perform user deletion --%>
        <%
            if (request.getMethod().equals("POST")) {
                String userIDToDelete = request.getParameter("userIDToDelete");

                Connection con = null; // Connection 객체 정의
                Statement deleteStatement = null;
                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    String myUrl = "jdbc:mysql://tier-3-rds.ckpqfjkmk5sf.ap-northeast-3.rds.amazonaws.com/micom";
                    con = DriverManager.getConnection(myUrl, "root", "mypassword"); // Connection 초기화

                    deleteStatement = con.createStatement();
                    int rowCount = deleteStatement.executeUpdate("DELETE FROM user WHERE userID = '" + userIDToDelete + "'");
                    if (rowCount > 0) {
                        out.println("사용자 " + userIDToDelete + "를 성공적으로 삭제했습니다.");
                    } else {
                        out.println("사용자 " + userIDToDelete + "를 찾을 수 없거나 삭제 중 오류가 발생했습니>다.");
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
                    if (deleteStatement != null) {
                        deleteStatement.close();
                    }
                    if (con != null) {
                        con.close(); // 연결 닫기
                    }
                }
            }
        %>
        <!-- Display the current user data from the database -->
<h2 style="text-align: left;">사용자 목록</h2>
<div style="display: flex; justify-content: left;">
    <table style="text-align: left;">
        <tr>
            <th>ID</th>
            <th>PW</th>
        </tr>
        <%
            Connection con = null; // Connection 객체 정의
            Statement stm = null;
            ResultSet rs = null;
            try {
                Class.forName("com.mysql.jdbc.Driver");
                String myUrl = "jdbc:mysql://tier-3-rds.ckpqfjkmk5sf.ap-northeast-3.rds.amazonaws.com/micom";
                con = DriverManager.getConnection(myUrl, "root", "mypassword"); // Connection 초기화

                stm = con.createStatement();
                if (stm.execute("SELECT * FROM user")) {
                    rs = stm.getResultSet();
                }
                while (rs.next()) {
        %>
                <tr>
                    <td style="padding: 5px;"><%= rs.getString("userID") %></td>
                    <td style="padding: 5px;"><%= rs.getString("userPassword") %></td>
                </tr>
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
                    con.close(); // 연결 닫기
                }
            }
        %>
    </table>
</div>
</body>
</html>
