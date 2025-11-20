<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Dashboard - Library Book</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body>

    <!-- NAVBAR -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container">
            <a class="navbar-brand" href="books?action=list">Library Book</a>

            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">

                    <li class="nav-item">
                        <a class="nav-link active" href="books?action=list">Buku</a>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link" href="borrow?action=history">Histori Saya</a>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link btn btn-danger btn-sm text-white" href="auth?action=logout">Logout</a>
                    </li>

                </ul>
            </div>
        </div>
    </nav>

    <!-- MAIN CONTENT -->
    <div class="container mt-4">

        <h2 class="mb-3">Daftar Buku</h2>

        <a href="books?action=new" class="btn btn-success mb-3">+ Tambah Buku</a>

        <table class="table table-bordered table-striped">
            <thead>
                <tr>
                    <th>Judul</th>
                    <th>Penulis</th>
                    <th>Genre</th>
                    <th>Stok</th>
                    <th style="width: 200px;">Aksi</th>
                </tr>
            </thead>

            <tbody>
                <c:forEach var="book" items="${listBooks}">
                    <tr>
                        <td>
                            <a href="books?action=detail&id=${book.id}">
                                <c:out value="${book.title}" />
                            </a>
                        </td>

                        <td><c:out value="${book.author}" /></td>
                        <td><c:out value="${book.genre}" /></td>
                        <td><c:out value="${book.stock}" /></td>

                        <td>

                            <a href="books?action=edit&id=${book.id}" class="btn btn-warning btn-sm">Edit</a>

                            <c:choose>
                                <c:when test="${book.stock > 0}">
                                    <a href="borrow?action=borrow&bookId=${book.id}" class="btn btn-primary btn-sm">Pinjam</a>
                                </c:when>
                                <c:otherwise>
                                    <button class="btn btn-secondary btn-sm" disabled>Habis</button>
                                </c:otherwise>
                            </c:choose>

                            <a href="books?action=delete&id=${book.id}" 
                               class="btn btn-danger btn-sm"
                               onclick="return confirm('Hapus buku ini?')">
                                Hapus
                            </a>

                        </td>
                    </tr>
                </c:forEach>

                <c:if test="${empty listBooks}">
                    <tr>
                        <td colspan="5" class="text-center">Tidak ada data buku.</td>
                    </tr>
                </c:if>

            </tbody>
        </table>

    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
