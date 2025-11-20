<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>
        <c:choose>
            <c:when test="${book != null}">Edit Buku</c:when>
            <c:otherwise>Tambah Buku Baru</c:otherwise>
        </c:choose>
    </title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">

        <h2 class="mb-4">
            <c:choose>
                <c:when test="${book != null}">Edit Buku</c:when>
                <c:otherwise>Tambah Buku Baru</c:otherwise>
            </c:choose>
        </h2>

        <form action="books" method="post">

            <!-- WAJIB: gunakan 'save' untuk insert & update -->
            <input type="hidden" name="action" value="save">

            <!-- Jika edit, sertakan ID -->
            <c:if test="${book != null}">
                <input type="hidden" name="id" value="${book.id}">
            </c:if>

            <!-- JUDUL -->
            <div class="mb-3">
                <label class="form-label">Judul</label>
                <input type="text" name="title" class="form-control"
                       value="${book.title}" required>
            </div>

            <!-- PENULIS -->
            <div class="mb-3">
                <label class="form-label">Penulis</label>
                <input type="text" name="author" class="form-control"
                       value="${book.author}" required>
            </div>

            <!-- GENRE -->
            <div class="mb-3">
                <label class="form-label">Genre</label>
                <input type="text" name="genre" class="form-control"
                       value="${book.genre}">
            </div>

            <!-- STOK -->
            <div class="mb-3">
                <label class="form-label">Stok</label>
                <input type="number" name="stock" class="form-control"
                       value="${book.stock}" required>
            </div>

            <!-- DESKRIPSI -->
            <div class="mb-3">
                <label class="form-label">Deskripsi</label>
                <textarea name="description" class="form-control" rows="4">${book.description}</textarea>
            </div>

            <button type="submit" class="btn btn-success">Simpan</button>
            <a href="books?action=list" class="btn btn-secondary">Batal</a>

        </form>
    </div>
</body>
</html>
