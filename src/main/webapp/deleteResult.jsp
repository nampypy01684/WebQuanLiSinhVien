<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="Project.ConnectionProvider" %>

<%
    String mssv = request.getParameter("mssv");
    String subject = request.getParameter("subject");

    if (mssv != null && subject != null) {
        try (Connection con = ConnectionProvider.getCon()) {
            // Prepare the SQL delete statement
            String query = "DELETE FROM ketqua WHERE mssv = ? AND subject_name = ?";
            try (PreparedStatement ps = con.prepareStatement(query)) {
                ps.setString(1, mssv);
                ps.setString(2, subject);

                // Execute the update and check the number of rows affected
                int rowsDeleted = ps.executeUpdate();

                if (rowsDeleted > 0) {
                    response.sendRedirect("adminHome.jsp?status=success");
                } else {
                    out.println("<div class='container my-5'>");
                    out.println("<div class='alert alert-danger' role='alert'>");
                    out.println("Xóa kết quả thất bại! Không tìm thấy kết quả cần xóa.");
                    out.println("</div>");
                    out.println("<a href='adminHome.jsp' class='btn btn-primary'>Trở lại</a>");
                    out.println("</div>");
                }
            }
        } catch (Exception e) {
            out.println("<div class='container my-5'>");
            out.println("<div class='alert alert-danger' role='alert'>");
            out.println("Đã xảy ra lỗi: " + e.getMessage());
            out.println("</div>");
            out.println("<a href='adminHome.jsp' class='btn btn-primary'>Trở lại</a>");
            out.println("</div>");
            e.printStackTrace();
        }
    } else {
        out.println("<div class='container my-5'>");
        out.println("<div class='alert alert-warning' role='alert'>");
        out.println("Thông tin sinh viên hoặc môn học không hợp lệ.");
        out.println("</div>");
        out.println("<a href='adminHome.jsp' class='btn btn-primary'>Trở lại</a>");
        out.println("</div>");
    }
%>
