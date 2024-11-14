<%@ page import="java.sql.*, java.util.*" %>
<%@ page import="Project.ConnectionProvider" %>
<%
    // Lấy dữ liệu từ form
    String mssv = request.getParameter("mssv");
    String hovaten = request.getParameter("hovaten");
    String[] subjectNames = request.getParameterValues("subject_name[]");
    String[] subjectGrades = request.getParameterValues("subject_grade[]");

    if (mssv == null || hovaten == null || subjectNames == null || subjectGrades == null) {
        out.println("Thông tin không đầy đủ. Vui lòng kiểm tra lại.");
    } else {
        try (Connection conn = ConnectionProvider.getCon();
             PreparedStatement stmt = conn.prepareStatement("INSERT INTO ketqua (mssv, hovaten, subject_name, grade) VALUES (?, ?, ?, ?)")) {

            // Duyệt qua từng môn học và lưu vào database
            for (int i = 0; i < subjectNames.length; i++) {
                stmt.setString(1, mssv);
                stmt.setString(2, hovaten);
                stmt.setString(3, subjectNames[i]);
                stmt.setString(4, subjectGrades[i]);
                stmt.addBatch(); // Thêm vào batch để tối ưu hóa
            }

            // Thực hiện batch update
            stmt.executeBatch();

            // Sau khi lưu thành công, chuyển hướng về trang adminHome.jsp
            response.sendRedirect("adminHome.jsp");

        } catch (SQLException e) {
            e.printStackTrace();
            out.println("Có lỗi xảy ra trong quá trình lưu dữ liệu: " + e.getMessage());
        }
    }
%>
