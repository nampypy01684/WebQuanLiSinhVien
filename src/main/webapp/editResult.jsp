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
        ResultSet rs = st.executeQuery("select * from ketqua where mssv='" + mssv + "' and subject_name='" + subject + "'");
        if (rs.next()) {
%>
<form action="updateResult.jsp" method="post">
    <input type="hidden" name="mssv" value="<%=rs.getString(1)%>">
    <input type="hidden" name="subject" value="<%=rs.getString(3)%>">
    <div class="form-group">
        <label for="grade">Điểm:</label>
        <input type="text" class="form-control" id="grade" name="grade" value="<%=rs.getString(4)%>">
    </div>
    <button type="submit" class="btn btn-primary">Lưu</button>
</form>
<%
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
%>