<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="Project.ConnectionProvider" %>
<%
    String mssv = request.getParameter("mssv");
    String subject = request.getParameter("subject");
    String grade = request.getParameter("grade");
    String credit = request.getParameter("credit");

    try {
        Connection con = ConnectionProvider.getCon();
        PreparedStatement ps = con.prepareStatement(
            "UPDATE ketqua SET grade=?, credit=? WHERE mssv=? AND subject_name=?");
        
        ps.setString(1, grade);
        ps.setInt(2, Integer.parseInt(credit));
        ps.setString(3, mssv);
        ps.setString(4, subject);

        int updatedRows = ps.executeUpdate();

        if (updatedRows > 0) {
            out.println("Cập nhật thành công.");
            response.sendRedirect("adminHome.jsp");
        } else {
            out.println("Không tìm thấy dữ liệu để cập nhật.");
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.println("Có lỗi xảy ra khi cập nhật dữ liệu: " + e.getMessage());
    }
%>
