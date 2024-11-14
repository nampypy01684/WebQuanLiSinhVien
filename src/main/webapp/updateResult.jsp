<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="Project.ConnectionProvider" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cập Nhật Kết Quả</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
</head>
<body>
    <div class="container my-5">
        <%
        // Lấy dữ liệu từ form
        String mssv = request.getParameter("mssv");
        String subject = request.getParameter("subject");
        String grade = request.getParameter("grade");

        // Cập nhật dữ liệu vào cơ sở dữ liệu
        Connection con = ConnectionProvider.getCon();
        PreparedStatement ps = con.prepareStatement("UPDATE ketqua SET grade = ? WHERE mssv = ? AND subject_name = ?");
        ps.setString(1, grade);
        ps.setString(2, mssv);
        ps.setString(3, subject);
        int rowsUpdated = ps.executeUpdate();

        if (rowsUpdated > 0) {
        %>
        <div class="alert alert-success" role="alert">
            Cập nhật kết quả thành công!
        </div>
        <a href="adminHome.jsp" class="btn btn-primary">Trở lại</a>
        <%
        } else {
        %>
        <div class="alert alert-danger" role="alert">
            Cập nhật kết quả thất bại!
        </div>
        <a href="adminHome.jsp" class="btn btn-primary">Trở lại</a>
        <%
        }
        %>
    </div>
</body>
</html>