<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.SQLException" %>
<%@ page import="Project.ConnectionProvider" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thông tin sinh viên</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <!-- Custom CSS -->
    <style>
        body {
            background-color: #f8f9fa;
        }
        .navbar {
            background-color: #007bff;
        }
        .navbar-brand img {
            width: 180px;
        }
        .navbar-light .navbar-nav .nav-link {
            color: #ffffff;
            font-weight: bold;
        }
        .container {
            margin-top: 30px;
        }
        h2 {
            color: #007bff;
            font-weight: bold;
            margin-bottom: 20px;
        }
        table {
            background: #ffffff;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        table thead {
            background-color: #007bff;
            color: #ffffff;
        }
        table tbody tr:hover {
            background-color: #f1f1f1;
        }
        .table-wrapper {
            overflow-x: auto;
        }
        footer {
            background-color: #007bff;
            color: white;
            text-align: center;
            padding: 10px;
            position: fixed;
            bottom: 0;
            width: 100%;
        }
    </style>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-light">
    <a class="navbar-brand" href="#"><img src="uth-logo.png" alt="Logo"></a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav ml-auto">
            <li class="nav-item"><a class="nav-link" href="index.html">Đăng xuất</a></li>
        </ul>
    </div>
</nav>

<div class="container">
    <h2>Thông tin sinh viên</h2>
    <div class="table-wrapper">
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
                String mssv = request.getParameter("mssv");
                if (mssv == null || mssv.isEmpty()) {
                    out.println("<tr><td colspan='6' class='text-danger'>Mã số sinh viên không hợp lệ.</td></tr>");
                } else {
                    try (Connection con = ConnectionProvider.getCon()) {
                        if (con == null) {
                            out.println("<tr><td colspan='6' class='text-danger'>Không thể kết nối cơ sở dữ liệu.</td></tr>");
                        } else {
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
                                out.println("<tr><td colspan='6' class='text-danger'>Không tìm thấy thông tin sinh viên.</td></tr>");
                            }
                        }
                    } catch (SQLException e) {
                        e.printStackTrace();
                        out.println("<tr><td colspan='6' class='text-danger'>Có lỗi xảy ra: " + e.getMessage() + "</td></tr>");
                    }
                }
                %>
            </tbody>
        </table>
    </div>

    <h2>Kết quả học tập</h2>
    <div class="table-wrapper">
        <table class="table table-striped">
            <thead>
                <tr>
                    <th>Tên môn học</th>
                    <th>Điểm</th>
                    <th>Số tín chỉ</th>
                </tr>
            </thead>
            <tbody>
                <%
                if (mssv != null && !mssv.isEmpty()) {
                    double weightedSum = 0.0;
                    int totalCredits = 0;
                    try (Connection con = ConnectionProvider.getCon()) {
                        if (con != null) {
                            PreparedStatement ps = con.prepareStatement("SELECT * FROM ketqua WHERE mssv = ?");
                            ps.setString(1, mssv);
                            ResultSet rs = ps.executeQuery();
                            while (rs.next()) {
                                double grade = rs.getDouble("grade");
                                int credits = rs.getInt("credit");
                                weightedSum += grade * credits;
                                totalCredits += credits;
                %>
                <tr>
                    <td><%= rs.getString("subject_name") %></td>
                    <td><%= grade %></td>
                    <td><%= credits %></td>
                </tr>
                <%
                            }
                        }
                    } catch (SQLException e) {
                        e.printStackTrace();
                        out.println("<tr><td colspan='3' class='text-danger'>Có lỗi xảy ra: " + e.getMessage() + "</td></tr>");
                    }
                    if (totalCredits > 0) {
                        double averageGrade = weightedSum / totalCredits;
                %>
                <tfoot>
                    <tr>
                        <td colspan="2" class="text-right"><strong>Tổng tín chỉ:</strong></td>
                        <td><strong><%= totalCredits %></strong></td>
                    </tr>
                    <tr>
                        <td colspan="2" class="text-right"><strong>Điểm trung bình:</strong></td>
                        <td><strong><%= String.format("%.2f", averageGrade) %></strong></td>
                    </tr>
                </tfoot>
                <%
                    } else {
                        out.println("<tr><td colspan='3'>Không có kết quả học tập.</td></tr>");
                    }
                }
                %>
            </tbody>
        </table>
    </div>
</div>

<footer>
    © 2024 Trường Đại Học Giao Thông Vận Tải TP.HCM
</footer>

<!-- Bootstrap JS -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.4.4/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
