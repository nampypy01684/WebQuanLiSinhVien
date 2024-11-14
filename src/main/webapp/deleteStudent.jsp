<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="Project.ConnectionProvider" %>
<%
    String mssv = request.getParameter("mssv");
    Connection con = null;
    PreparedStatement psKetQua = null;
    PreparedStatement psSinhVien = null;

    try {
        con = ConnectionProvider.getCon();
        
        // Xóa các bản ghi liên quan trong bảng ketqua trước
        psKetQua = con.prepareStatement("DELETE FROM ketqua WHERE mssv = ?");
        psKetQua.setString(1, mssv);
        psKetQua.executeUpdate();

        // Sau đó xóa sinh viên trong bảng sinhvien
        psSinhVien = con.prepareStatement("DELETE FROM sinhvien WHERE mssv = ?");
        psSinhVien.setString(1, mssv);
        int rows = psSinhVien.executeUpdate();

        if (rows > 0) {
            out.println("<script>alert('Xóa sinh viên thành công!'); window.location='adminHome.jsp';</script>");
        } else {
            out.println("<script>alert('Không thể xóa sinh viên!'); window.location='adminHome.jsp';</script>");
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<script>alert('Có lỗi xảy ra khi xóa sinh viên!'); window.location='adminHome.jsp';</script>");
    } finally {
        // Đóng các tài nguyên
        if (psKetQua != null) psKetQua.close();
        if (psSinhVien != null) psSinhVien.close();
        if (con != null) con.close();
    }
%>
