<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="Project.ConnectionProvider" %>
<%
    String mssv = request.getParameter("mssv");
    Connection con = ConnectionProvider.getCon();
    PreparedStatement ps = con.prepareStatement("SELECT * FROM sinhvien WHERE mssv = ?");
    ps.setString(1, mssv);
    ResultSet rs = ps.executeQuery();

    if (rs.next()) {
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cập nhật sinh viên</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .form-container {
            background-color: #ffffff;
            border: 1px solid #ccc;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            padding: 20px;
            max-width: 400px;
            width: 100%;
        }
        .form-container h2 {
            text-align: center;
            color: #333;
            margin-bottom: 20px;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
            color: #555;
            font-weight: bold;
        }
        .form-group input {
            width: 100%;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }
        button {
            width: 100%;
            background-color: #007bff;
            color: white;
            border: none;
            padding: 10px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
        }
        button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <div class="form-container">
        <h2>Cập nhật sinh viên</h2>
        <form action="updateStudent.jsp" method="post">
            <input type="hidden" name="mssv" value="<%= rs.getString("mssv") %>">
            <div class="form-group">
                <label for="hovaten">Họ và tên:</label>
                <input type="text" id="hovaten" name="hovaten" value="<%= rs.getString("hovaten") %>">
            </div>
            <div class="form-group">
                <label for="lop">Lớp:</label>
                <input type="text" id="lop" name="lop" value="<%= rs.getString("lop") %>">
            </div>
            <div class="form-group">
                <label for="chuyennganh">Chuyên ngành:</label>
                <input type="text" id="chuyennganh" name="chuyennganh" value="<%= rs.getString("chuyennganh") %>">
            </div>
            <div class="form-group">
                <label for="ngaysinh">Ngày sinh:</label>
                <input type="date" id="ngaysinh" name="ngaysinh" value="<%= rs.getString("ngaysinh") %>">
            </div>
            <div class="form-group">
                <label for="gioitinh">Giới tính:</label>
                <input type="text" id="gioitinh" name="gioitinh" value="<%= rs.getString("gioitinh") %>">
            </div>
            <button type="submit">Cập nhật</button>
        </form>
    </div>
</body>
</html>
<%
    }
%>
