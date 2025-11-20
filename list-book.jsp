<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Daftar Buku</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container">
            <a class="navbar-brand" href="books?action=list">Library Book</a>
            <div class="collapse navbar-collapse">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item"><a class="nav-link active" href="books?action=list">Buku</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container mt-4">
        <h2>Daftar Buku</h2>
        <a href="books?action=new" class="btn btn-success mb-3">+ Tambah Buku</a>

        <table class="table table-bordered table-striped">
            <thead>
                <tr>
                    <th>Judul</th>
                    <th>Penulis</th>
                    <th>Genre</th>
                    <th>Stok</th>
                    <th>Aksi</th>
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
                            <a href="books?action=delete&id=${book.id}" class="btn btn-danger btn-sm" onclick="return confirm('Hapus buku ini?')">Hapus</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</body>
</html>
