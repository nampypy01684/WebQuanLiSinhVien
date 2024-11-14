<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="Project.ConnectionProvider" %>
<%
    String mssv = request.getParameter("mssv");
    String hovaten = request.getParameter("hovaten");
    String lop = request.getParameter("lop");
    String chuyennganh = request.getParameter("chuyennganh");
    String ngaysinh = request.getParameter("ngaysinh");
    String gioitinh = request.getParameter("gioitinh");

    Connection con = ConnectionProvider.getCon();
    PreparedStatement ps = con.prepareStatement("UPDATE sinhvien SET hovaten=?, lop=?, chuyennganh=?, ngaysinh=?, gioitinh=? WHERE mssv=?");
    ps.setString(1, hovaten);
    ps.setString(2, lop);
    ps.setString(3, chuyennganh);
    ps.setString(4, ngaysinh);
    ps.setString(5, gioitinh);
    ps.setString(6, mssv);

    int rows = ps.executeUpdate();

    if (rows > 0) {
        out.println("<script>alert('Cập nhật sinh viên thành công!'); window.location='adminHome.jsp';</script>");
    } else {
        out.println("<script>alert('Không thể cập nhật sinh viên!'); window.location='adminHome.jsp';</script>");
    }
%>
    