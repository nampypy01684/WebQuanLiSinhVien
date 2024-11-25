<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Student Management System</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<style>
body {
	font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
	background: url('bg.jpg') no-repeat center center fixed;
	background-size: cover;
}

.navbar {
	background-color: rgba(0, 123, 255, 0.8);
	color: white;
}

.navbar a {
	color: white;
}

.container {
	position: relative;
	z-index: 1;
	margin-top: 80px;
}

.container::after {
	content: "";
	background: url('image-below.png') no-repeat center center;
	background-size: cover;
	opacity: 0.2;
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	z-index: -1;
}

.card {
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	border: none;
	border-radius: 10px;
	background-color: rgba(255, 255, 255, 0.9);
}

.card h5 {
	color: #007bff;
}

.card-text {
	text-align: center;
}

.card-title {
	text-align: center;
	font-weight: bold;
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

.popup {
	display: none; /* Ẩn popup ban đầu */
	position: fixed;
	left: 50%;
	top: 50%;
	transform: translate(-50%, -50%);
	width: 750px; /* Đặt width tự động để vừa với nội dung */
	max-width: 90%; /* Giới hạn chiều rộng tối đa */
	background-color: white;
	padding: 20px;
	border-radius: 5px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	z-index: 100;
	overflow-x: auto;
	/* Thêm scroll ngang nếu nội dung vượt quá chiều rộng */
}

.close-popup {
	position: absolute;
	top: 10px;
	right: 10px;
	cursor: pointer;
}

.add-student-button {
	display: block;
	margin: 5px auto;
	width: 200px; /* Độ rộng nút */
	padding: 10px 20px; /* Khoảng cách nội dung trong nút */
	border: none; /* Bỏ viền */
	border-radius: 5px; /* Bo tròn góc */
	background-color: #007bff; /* Màu nền */
	color: white; /* Màu chữ */
	cursor: pointer;
	width: 200px; /* Hiển thị con trỏ tay khi di chuột */
}

.view-result-button {
	display: block;
	margin: 5px auto;
	width: 200px; /* Độ rộng nút */
	padding: 10px 20px; /* Khoảng cách nội dung trong nút */
	border: none; /* Bỏ viền */
	border-radius: 5px; /* Bo tròn góc */
	background-color: #007bff; /* Màu nền */
	color: white; /* Màu chữ */
	cursor: pointer;
}

.view-list-student-button {
	display: block;
	margin: 5px auto;
	width: 200px; /* Độ rộng nút */
	padding: 10px 20px; /* Khoảng cách nội dung trong nút */
	border: none; /* Bỏ viền */
	border-radius: 5px; /* Bo tròn góc */
	background-color: #007bff; /* Màu nền */
	color: white; /* Màu chữ */
	cursor: pointer;
}

/* CSS cho bảng popup */
.popup table {
	width: 100%; /* Extend table width to fit popup */
	border-collapse: collapse;
	overflow-x: auto;
}

.popup th, .popup td {
	text-align: left;
	padding: 12px;
	border: 1px solid #ddd;
	white-space: nowrap; /* Prevent text wrapping */
}

.popup th {
	background-color: #f2f2f2;
}

.popup #studentTable, .popup #resultTable {
	margin-top: 20px;
}
.popup #resultTable th:first-child,
.popup #resultTable td:first-child {
    width: 15%; /* Độ rộng cột Mã số sinh viên */
}

.popup #resultTable th:nth-child(2),
.popup #resultTable td:nth-child(2) {
    width: 25%; /* Độ rộng cột Họ và tên */
}

.popup #resultTable th:nth-child(3),
.popup #resultTable td:nth-child(3) {
    width: 30%; /* Độ rộng cột Tên môn học */
}

.popup #resultTable th:nth-child(4),
.popup #resultTable td:nth-child(4) {
    width: 20%; /* Độ rộng cột Điểm */
}
</style>
</head>
<body>

	<nav class="navbar navbar-expand-lg navbar-light">
		<a class="navbar-brand" href="#"><img src="uth-logo.png" style="width: 200px; height: 50px"></a>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navbarNav">
			<ul class="navbar-nav ml-auto">
				<li class="nav-item"><a class="nav-link" href="StudentServlet"><i><a href="adminLogin.html">Đăng xuất</a>
			</ul>
		</div>
	</nav>

	<div class="container">
		<div class="row">
			<div class="col-md-6 mb-4">
				<div class="card">
					<div class="card-body">
						<h5 class="card-title">Quản lí sinh viên</h5>
						<p class="card-text">Nhập hoặc xem kết quả sinh viên</p>
						<div class="row all-result-student">
							<button id="openPopup1" class="view-result-button">
								<i class="fas fa-user"></i> Nhập kết quả mới
							</button>
							<button id="openPopup4" class="view-result-button">
								<i class="fas fa-user"></i> Xem kết quả
							</button>
						</div>

					</div>
				</div>
			</div>
			<div class="col-md-6 mb-4">
				<div class="card">
					<div class="card-body">
						<h5 class="card-title">Thông tin sinh viên</h5>
						<p class="card-text">Thêm hoặc xem danh sách thông tin sinh
							viên</p>
						<div class="row button-student">
							<button id="openPopup2" class="add-student-button">
								<i class="fas fa-user-plus"></i> Thêm sinh viên
							</button>
							<button id="openPopup3" class="view-list-student-button">
								<i class="fas fa-users "></i>Danh sách sinh viên
							</button>
						</div>

					</div>
				</div>
			</div>
		</div>

	</div>

	<!-- Popup form -->






	<div class="popup" id="resultForm">
		<span class="close-popup" onclick="closePopup1()">X</span>
		<div class="card">
			<div class="card-header">
				<h4>Nhập kết quả mới</h4>
			</div>
			<div class="card-body">
				<form name="my-form" onsubmit="return validform()"
					action="saveResults.jsp" method="post">

					<!-- Mã số sinh viên input field -->
					<div class="form-group row">
						<label for="mssv" class="col-md-4 col-form-label text-md-right">Mã
							số sinh viên</label>
						<div class="col-md-6">
							<input type="text" class="form-control" name="mssv"
								placeholder="Nhập mã số sinh viên">
						</div>
					</div>
					
					<div class="form-group row">
    <label for="hovaten" class="col-md-4 col-form-label text-md-right">Họ và tên</label>
    <div class="col-md-6">
        <input type="text" class="form-control" name="hovaten" placeholder="Nhập họ và tên">
    </div>
</div>

					<!-- Section where new subjects will be added -->
					<div id="subject-list"></div>

					<!-- Button to add a new subject -->
					<div class="form-group row">
						<div class="col-md-6 offset-md-4">
							<button type="button" class="btn btn-secondary"
								onclick="addSubject()">Thêm môn học</button>
						</div>
					</div>

					<!-- Submit button -->
					<div class="form-group row">
						<div class="col-md-6 offset-md-4">
							<button type="submit" class="btn btn-primary">Lưu kết
								quả</button>
						</div>
					</div>
				</form>
			</div>
		</div>

	</div>

	<div class="popup" id="studentForm">
		<span class="close-popup" onclick="closePopup2()">×</span>
		<div class="card">
			<div class="card-header">
				<h4>
					<b>Thêm Sinh Viên Mới</b>
				</h4>
			</div>
			<div class="card-body">
				<form name="my-form" onsubmit="return validform()"
					action="success1.jsp" method="post">

					<div class="form-group row">
						<label for="user_name"
							class="col-md-4 col-form-label text-md-right">Mã số sinh
							viên</label>
						<div class="col-md-6">
							<input type="text" class="form-control" name="mssv">
						</div>
					</div>

					<div class="form-group row">
						<label for="phone_number"
							class="col-md-4 col-form-label text-md-right">Họ và tên</label>
						<div class="col-md-6">
							<input type="text" class="form-control" name="hovaten">
						</div>
					</div>

					<div class="form-group row">
						<label for="present_address"
							class="col-md-4 col-form-label text-md-right">Lớp</label>
						<div class="col-md-6">
							<input type="text" class="form-control" name="lop">
						</div>
					</div>

					<div class="form-group row">
						<label for="user_name"
							class="col-md-4 col-form-label text-md-right">Chuyên
							ngành</label>
						<div class="col-md-6">
							<input type="text" class="form-control" name="chuyennganh">
						</div>
					</div>

					<div class="form-group row">
						<label for="user_name"
							class="col-md-4 col-form-label text-md-right">Ngày sinh</label>
						<div class="col-md-6">
							<input type="date" class="form-control" name="ngaysinh">
						</div>
					</div>

					<div class="form-group row">
						<label for="permanent_address"
							class="col-md-4 col-form-label text-md-right">Giới tính</label>
						<div class="col-md-6">
							<input type="text" class="form-control" name="gioitinh">
						</div>
					</div>

					<div class="form-group row">
						<div class="col-md-6 offset-md-4">
							<button type="submit" class="btn btn-primary">Lưu</button>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>

	<div class="popup" id="list-student-table">
		<span class="close-popup" onclick="closePopup3()">X</span>
		<h4>Danh sách sinh viên đã thêm</h4>
		<div class="container">
			<div class="row justify-content">
				<div class="col-md-10">
					<table id="studentTable" class="table table-striped">
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
							<!-- Dữ liệu sinh viên sẽ được hiển thị ở đây -->
							<%@ page import="java.sql.*"%>
							<%@ page import="Project.ConnectionProvider"%>
							<%
							try {
								Connection con = ConnectionProvider.getCon();
								Statement st = con.createStatement();
								ResultSet rs = st.executeQuery("select *from sinhvien");
								while (rs.next()) {
							%>
							<tr>
								<th><%=rs.getString(1)%></th>
								<th><%=rs.getString(2)%></th>
								<th><%=rs.getString(3)%></th>
								<th><%=rs.getString(4)%></th>
								<th><%=rs.getString(5)%></th>
								<th><%=rs.getString(6)%></th>
								<th><a href="editStudent.jsp?mssv=<%=rs.getString(1)%>">Sửa</a></th>
            <!-- Thêm nút xóa với liên kết đến trang xử lý xóa -->
            <th><a href="deleteStudent.jsp?mssv=<%=rs.getString(1)%>" onclick="return confirm('Bạn có chắc muốn xóa sinh viên này không?')">Xóa</a></th>
							</tr>

						</tbody>
						<%
						}
						} catch (Exception e) {
						}
						%>
					</table>
				</div>
			</div>
		</div>
	</div>

	<div class="popup" id="list-result-table">
		<span class="close-popup" onclick="closePopup4()">X</span>
		<h4>Kết quả của sinh viên</h4>
		<div class="container">
			<div class="row justify-content">
				<div class="col-md-10">
					<table id="resultTable" class="table table-striped">
						<thead>
							<tr>
								<th>Mã số sinh viên</th>
								<th>Họ và tên</th>
								<th>Tên môn học</th>
								<th>Điểm</th>
								<th>Số tín chỉ</th> 
							</tr>
						</thead>
						<tbody>
							<!-- Dữ liệu kết quả sinh viên sẽ được hiển thị ở đây -->
							<%@ page import="java.sql.*"%>
							<%@ page import="Project.ConnectionProvider"%>
							<%
							try {
								Connection con = ConnectionProvider.getCon();
								Statement st = con.createStatement();
								ResultSet rs = st.executeQuery("select * from ketqua");
								while (rs.next()) {
							%>
							<tr>
								<th><%=rs.getString(1)%></th>
								<th><%=rs.getString(2)%></th>
								<th><%=rs.getString(3)%></th>
								<th><%=rs.getString(4)%></th>
								<th><%=rs.getString(5)%></th>
								<!-- Nút Sửa -->
             <!-- Nút Sửa -->
                            <td><a href="editResult.jsp?mssv=<%=rs.getString(1)%>&subject=<%=rs.getString(3)%>">Sửa</a></td>
                            <!-- Nút Xóa với xác nhận trước khi xóa -->
                            <td><a href="deleteResult.jsp?mssv=<%=rs.getString(1)%>&subject=<%=rs.getString(3)%>" onclick="return confirm('Bạn có chắc muốn xóa kết quả này không?')">Xóa</a></td>
							</tr>
						</tbody>
						<%
						}
						} catch (Exception e) {
							   e.printStackTrace();
						}
						%>
					</table>
				</div>
			</div>
		</div>
	</div>

	<footer>
		<p>© 2024 Student Management System</p>
	</footer>

	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

	<script>
document.getElementById('openPopup1').addEventListener('click', function(e) {
    e.preventDefault();
    document.getElementById('resultForm').style.display = 'block';
    });
function closePopup1() {
    document.getElementById('resultForm').style.display = 'none';
}

</script>
	<script>
    
        // Mở popup
        document.getElementById('openPopup2').addEventListener('click',function(e) {
                            e.preventDefault(); // Ngăn chặn link mặc định
                            document.getElementById('studentForm').style.display = 'block';
                        });

        // Đóng popup
        function closePopup2() {
            document.getElementById('studentForm').style.display = 'none';
        }
    
    </script>
	<script>
document.getElementById('openPopup3').addEventListener('click', function(e) {
    e.preventDefault();
    console.log("test nút 3");
    document.getElementById('list-student-table').style.display = 'block';
    });
function closePopup3() {
    document.getElementById('list-student-table').style.display = 'none';
}

</script>
	<script>
    document.getElementById('openPopup4').addEventListener('click', function(e) {
    e.preventDefault();
    console.log("test nút 4");
    document.getElementById('list-result-table').style.display = 'block';
    });
function closePopup4() {
    document.getElementById('list-result-table').style.display = 'none';
}

</script>
	<script>
    // Function to dynamically add a new subject and grade input fields
   // Function to dynamically add a new subject and grade input fields
function addSubject() {
    var subjectList = document.getElementById('subject-list');
    var newSubjectDiv = document.createElement('div');
    newSubjectDiv.classList.add('form-group', 'row');
    newSubjectDiv.innerHTML = `
        <label class="col-md-3 col-form-label text-md-right">Tên môn học</label>
        <div class="col-md-3">
            <input type="text" class="form-control" name="subject_name[]" placeholder="Tên môn học">
        </div>
        <div class="col-md-2">
            <input type="text" class="form-control" name="subject_grade[]" placeholder="Điểm">
        </div>
        <div class="col-md-2">
            <input type="number" class="form-control" name="subject_credit[]" placeholder="Số tín chỉ">
        </div>
    `;
    subjectList.appendChild(newSubjectDiv);

    // Update the result table with new subject, grade, and credit
    updateResultTable();
}

// Function to update the result table
function updateResultTable() {
    var resultTable = document.getElementById('resultTable').getElementsByTagName('tbody')[0];
    var subjectNameInputs = document.querySelectorAll('input[name="subject_name[]"]');
    var subjectGradeInputs = document.querySelectorAll('input[name="subject_grade[]"]');
    var subjectCreditInputs = document.querySelectorAll('input[name="subject_credit[]"]');
    var mssvInput = document.querySelector('input[name="mssv"]'); // Lấy mssv từ form
    var hovatenInput = document.querySelector('input[name="hovaten"]'); // Lấy họ và tên từ form

    // Get the existing data in the result table
    var existingRows = resultTable.querySelectorAll('tr');
    var existingData = [];
    existingRows.forEach(row => {
        var cells = row.querySelectorAll('td');
        existingData.push({
            mssv: cells[0].textContent,
            hovaten: cells[1].textContent,
            tenmonhoc: cells[2].textContent,
            diem: cells[3].textContent,
            tinchi: cells[4].textContent
        });
    });

    // Clear the existing table rows
    resultTable.innerHTML = '';

    // Add new subject, grade, and credit to the result table
    subjectNameInputs.forEach((nameInput, index) => {
        var gradeInput = subjectGradeInputs[index];
        var creditInput = subjectCreditInputs[index];
        var newRow = resultTable.insertRow();
        newRow.insertCell().textContent = mssvInput.value;
        newRow.insertCell().textContent = hovatenInput.value;
        newRow.insertCell().textContent = nameInput.value;
        newRow.insertCell().textContent = gradeInput.value;
        newRow.insertCell().textContent = creditInput.value;
    });

    // Add back existing data
    existingData.forEach(data => {
        var newRow = resultTable.insertRow();
        newRow.insertCell().textContent = data.mssv;
        newRow.insertCell().textContent = data.hovaten;
        newRow.insertCell().textContent = data.tenmonhoc;
        newRow.insertCell().textContent = data.diem;
        newRow.insertCell().textContent = data.tinchi;
    });
}

</script>
</body>
</html>