<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Daftar Akun - Library Book</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-5">
                <div class="card shadow">
                    <div class="card-header bg-success text-white text-center">
                        <h3>Registrasi Anggota</h3>
                    </div>
                    <div class="card-body">
                        <form action="auth" method="post">
                            <input type="hidden" name="action" value="register">
                            
                            <div class="mb-3">
                                <label class="form-label">Nama Lengkap</label>
                                <input type="text" name="name" class="form-control" placeholder="Contoh: Budi Santoso" required>
                            </div>
                            
                            <div class="mb-3">
                                <label class="form-label">Alamat Email</label>
                                <input type="email" name="email" class="form-control" placeholder="nama@email.com" required>
                            </div>
                            
                            <div class="mb-3">
                                <label class="form-label">Password</label>
                                <input type="password" name="password" class="form-control" required>
                                <small class="text-muted">Gunakan password yang kuat.</small>
                            </div>
                            
                            <div class="d-grid">
                                <button type="submit" class="btn btn-success">Daftar Sekarang</button>
                            </div>
                        </form>
                        <hr>
                        <p class="text-center">Sudah punya akun? <a href="login.jsp">Login disini</a></p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>