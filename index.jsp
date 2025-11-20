<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    if (session.getAttribute("userId") != null) {
        response.sendRedirect("books?action=list");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Selamat Datang - Library Book</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .hero-section {
            background: linear-gradient(rgba(0,0,0,0.6), rgba(0,0,0,0.6)), url('https://source.unsplash.com/1600x900/?library,books');
            background-size: cover;
            background-position: center;
            color: white;
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            text-align: center;
        }
    </style>
</head>
<body>
    <div class="hero-section">
        <div class="container">
            <h1 class="display-3 fw-bold">Library Book</h1>
            <p class="lead mb-4">Sistem Peminjaman Buku Terlengkap dan Mudah Digunakan.</p>
            <div class="d-grid gap-3 d-sm-flex justify-content-sm-center">
                <a href="login.jsp" class="btn btn-primary btn-lg px-4 gap-3">Login Sekarang</a>
                <a href="register.jsp" class="btn btn-outline-light btn-lg px-4">Buat Akun</a>
            </div>
        </div>
    </div>
</body>
</html>