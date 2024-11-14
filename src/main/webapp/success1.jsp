<%@page import="java.text.SimpleDateFormat"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="Project.ConnectionProvider" %>
<%@ page import= "java.util.Date" %>
<!DOCTYPE html>
<html>
<head>
    <title>Thêm Sinh Viên Mới</title>
</head>
<body>
    <%
        // Get data from form
     //   String tenhocphan = request.getParameter("tenhocphan");
        String mssv = request.getParameter("mssv");
        String hovaten = request.getParameter("hovaten");
        String lop = request.getParameter("lop");
        String chuyennganh = request.getParameter("chuyennganh");
        String ngaysinh = request.getParameter("ngaysinh");
        SimpleDateFormat inputFormat = new
        		SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat outputFortmat = new
        		SimpleDateFormat("yyyy-MM-dd");
        Date date = inputFormat.parse(ngaysinh);
        ngaysinh = outputFortmat.format(date);
        String gioitinh = request.getParameter("gioitinh");

        // Connect to database
        Connection con = ConnectionProvider.getCon();
        
        // Create a PreparedStatement object
        PreparedStatement ps = con.prepareStatement("INSERT INTO sinhvien (mssv, hovaten, lop, chuyennganh, ngaysinh, gioitinh) VALUES (?, ?, ?, ?, ?, ?)");

        // Set the values of the parameters
      //  ps.setString(1, tenhocphan);
        ps.setString(1, mssv);
        ps.setString(2, hovaten);
        ps.setString(3, lop);
        ps.setString(4, chuyennganh);
        ps.setString(5, ngaysinh);
        ps.setString(6, gioitinh);

        // Execute the query
        int i = ps.executeUpdate();

        // Check if the query was successful
        if (i > 0) {
        	response.sendRedirect("adminHome.jsp");
          //  out.print("Thêm sinh viên thành công!");
        } else {
            out.print("Lỗi khi thêm sinh viên. Vui lòng thử lại!");
        }

        // Close the connection
        con.close();
        ps.close();
    %>
</body>
</html>