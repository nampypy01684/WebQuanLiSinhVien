<%@ page import="java.sql.*" %>
<%@ page import="Project.ConnectionProvider" %>

<%
    String mssv = request.getParameter("mssv");

    try {
        Connection con = ConnectionProvider.getCon();
        Statement st = con.createStatement();
        ResultSet rs = st.executeQuery("SELECT * FROM sinhvien WHERE mssv='" + mssv + "'");

        if (rs.next()) {
            out.print("true"); // Trả về "true" nếu có bản ghi trùng
        } else {
            out.print("false"); // Trả về "false" nếu không có bản ghi trùng
        }
    } catch (Exception e) {
        out.print("error"); // Trả về "error" nếu có lỗi
    }
%>