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

        form:last-child input[type="submit"] {
            margin-right: 0;
        }
    </style>
</head>
<body>

    <!-- 상단 바 -->
    <div id="topbar">
        <h2>DK 3 TIER</h2>
    </div>

    <div id="container">
        <h1>DB Inquire delete   (SERVER1)</h1>

        <!-- Add a form to enter the user to delete -->
        <form action="" method="post">
            <label for="userIDToDelete">USER ID</label>
            <input type="text" id="userIDToDelete" name="userIDToDelete">
            <input type="submit" value="User Delete">
        </form>

        <form action="index.html">
            <input type="submit" value="Login          ">
        </form>

        <form action="sign_up.html">
            <input type="submit" value="Sign_up      ">
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
                        out.println("User '" + userIDToDelete + "' Successfully deleted");
                    } else {
                        out.println("User '" + userIDToDelete + "' An error occurred while deleting or unable to find.");
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
<h2 style="text-align: left;">User list</h2>
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
