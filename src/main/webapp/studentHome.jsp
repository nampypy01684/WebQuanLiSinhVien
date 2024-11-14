<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="Project.ConnectionProvider" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thông tin sinh viên</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-size: cover;
        }
        .container {
            margin-top: 80px;
        }
        footer {
            background-color: rgba(0, 123, 255, 0.8);
            color: white;
            padding: 10px;
            position: fixed;
            bottom: 0;
            width: 100%;
            text-align: center;
        }
    </style>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-light">
		<a class="navbar-brand" href="#"><img src="uth-logo.png" style="width: 200px; height: 50px"></a>
	
		<div class="collapse navbar-collapse" id="navbarNav">
			<ul class="navbar-nav ml-auto">
				<li class="nav-item"><a class="nav-link" href="StudentServlet"><i><a href="dgiOneView.html">Đăng xuất</a>
			</ul>
		</div>
	</nav>
    <div class="container" style="margin-top: -5px">
        <h2 style="text-align: center">Thông tin sinh viên</h2>
        <div class="row">
            <div class="col-md-12">
                <h4>Thông tin cá nhân</h4>
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th>Mã số sinh viên</th>
                            <th>Họ và tên</th>
                            <th>Lớp</th>
                            <th>Chuyên ngành</th>
                            <th>Ngày sinh</th>
                            <th>Giới tính</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                        String mssv = request.getParameter("mssv"); // Lấy mã số sinh viên từ tham số URL
                        try {
                            Connection con = ConnectionProvider.getCon();
                            PreparedStatement ps = con.prepareStatement("SELECT * FROM sinhvien WHERE mssv = ?");
                            ps.setString(1, mssv);
                            ResultSet rs = ps.executeQuery();
                            if (rs.next()) {
                        %>
                        <tr>
                            <td><%= rs.getString("mssv") %></td>
                            <td><%= rs.getString("hovaten") %></td>
                            <td><%= rs.getString("lop") %></td>
                            <td><%= rs.getString("chuyennganh") %></td>
                            <td><%= rs.getString("ngaysinh") %></td>
                            <td><%= rs.getString("gioitinh") %></td>
                        </tr>
                        <%
                            } else {
                        %>
                        <tr>
                            <td colspan="6" class="text-center">Không tìm thấy thông tin sinh viên.</td>
                        </tr>
                        <%
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                        %>
                    </tbody>
                </table>
            </div>
        </div>

        <div class="row">
            <div class="col-md-12">
                <h4>Kết quả học tập</h4>
                <table class="table table-striped">
                    <thead>
                        <tr>
                          
                            <th>Tên môn học</th>
                            <th>Điểm</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                        double totalPoints = 0.0;
                        int subjectCount = 0;

                        try {
                            Connection con = ConnectionProvider.getCon();
                            PreparedStatement ps = con.prepareStatement("SELECT * FROM ketqua WHERE mssv = ?");
                            ps.setString(1, mssv);
                            ResultSet rs = ps.executeQuery();
                            while (rs.next()) {
                                totalPoints += rs.getDouble("grade"); // Tính tổng điểm
                                subjectCount++; // Đếm số môn học
                        %>
                        <tr>
                           
                            <td><%= rs.getString("subject_name") %></td>
                            <td><%= rs.getString("grade") %></td>
                        </tr>
                        <%
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                        %>
                    </tbody>
                </table>
                <%
                if (subjectCount > 0) {
                    double averageGrade = totalPoints / subjectCount; // Tính điểm trung bình
                %>
                <table class="table table-striped">
                    <tfoot>
                        <tr>
                            <td colspan="3" class="text-right"><strong>Tổng điểm trung bình:</strong></td>
                            <td><strong><%= String.format("%.2f", averageGrade) %></strong></td>
                        </tr>
                    </tfoot>
                </table>
                <%
                } else {
                %>
                <div class="alert alert-warning" role="alert">
                    Không có kết quả học tập nào cho sinh viên này.
                </div>
                <%
                }
                %>
            </div>
        </div>
    </div>

    <footer>
        <p>© 2024 Hệ thống quản lý sinh viên</p>
    </footer>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>