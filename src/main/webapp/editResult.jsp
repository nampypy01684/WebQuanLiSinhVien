<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="Project.ConnectionProvider" %>
<%
    String mssv = request.getParameter("mssv");
    String subject = request.getParameter("subject");

    try {
        Connection con = ConnectionProvider.getCon();
        Statement st = con.createStatement();
        ResultSet rs = st.executeQuery("SELECT * FROM ketqua WHERE mssv='" + mssv + "' AND subject_name='" + subject + "'");
        if (rs.next()) {
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cập nhật kết quả</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f2f5;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .form-container {
            background-color: #ffffff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            width: 100%;
            max-width: 400px;
        }

        .form-container h2 {
            text-align: center;
            color: #333;
            margin-bottom: 20px;
        }

        .form-group {
            margin-bottom: 15px;
            margin-right: 15px;
        }

        .form-group label {
            display: block;
            font-weight: bold;
            color: #555;
            margin-bottom: 5px;
        }

        .form-group input {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 14px;
        }

        button {
            width: 100%;
            padding: 10px;
            background-color: #007bff;
            border: none;
            border-radius: 4px;
            color: white;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        button:hover {
            background-color: #0056b3;
        }

        .error {
            color: red;
            text-align: center;
        }
    </style>
</head>
<body>
    <div class="form-container">
        <h2>Cập nhật kết quả</h2>
        <form action="updateResult.jsp" method="post">
            <!-- Hidden fields to pass unique keys -->
            <input type="hidden" name="mssv" value="<%=rs.getString("mssv")%>">
            <input type="hidden" name="subject" value="<%=rs.getString("subject_name")%>">

            <!-- Điểm -->
            <div class="form-group">
                <label for="grade">Điểm:</label>
                <input type="text" class="form-control" id="grade" name="grade" value="<%=rs.getString("grade")%>">
            </div>

            <!-- Số tín chỉ -->
            <div class="form-group">
                <label for="credit">Số tín chỉ:</label>
                <input type="number" class="form-control" id="credit" name="credit" value="<%=rs.getInt("credit")%>">
            </div>

            <!-- Submit button -->
            <button type="submit" class="btn btn-primary">Lưu</button>
        </form>
    </div>
</body>
</html>
<%
        }
    } catch (Exception e) {
        e.printStackTrace();
%>
    <div class="error">Có lỗi xảy ra khi truy vấn dữ liệu: <%= e.getMessage() %></div>
<%
    }
%>
