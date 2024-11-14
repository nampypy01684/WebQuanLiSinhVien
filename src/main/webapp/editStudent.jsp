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
    <form action="updateStudent.jsp" method="post">
        <input type="hidden" name="mssv" value="<%= rs.getString("mssv") %>">
        Họ và tên: <input type="text" name="hovaten" value="<%= rs.getString("hovaten") %>"><br>
        Lớp: <input type="text" name="lop" value="<%= rs.getString("lop") %>"><br>
        Chuyên ngành: <input type="text" name="chuyennganh" value="<%= rs.getString("chuyennganh") %>"><br>
        Ngày sinh: <input type="date" name="ngaysinh" value="<%= rs.getString("ngaysinh") %>"><br>
        Giới tính: <input type="text" name="gioitinh" value="<%= rs.getString("gioitinh") %>"><br>
        <button type="submit">Cập nhật</button>
    </form>
<%
    }
%>
