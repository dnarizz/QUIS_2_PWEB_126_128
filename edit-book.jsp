<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Buku</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container mt-4">

<h2>Edit Buku</h2>

<form action="BookServlet?action=update" method="post">

    <input type="hidden" name="id" value="${book.id}">

    <div class="mb-3">
        <label>Judul</label>
        <input type="text" name="title" class="form-control" value="${book.title}" required>
    </div>

    <div class="mb-3">
        <label>Penulis</label>
        <input type="text" name="author" class="form-control" value="${book.author}" required>
    </div>

    <div class="mb-3">
        <label>Genre</label>
        <input type="text" name="genre" class="form-control" value="${book.genre}" required>
    </div>

    <div class="mb-3">
        <label>Stok</label>
        <input type="number" name="stock" class="form-control" value="${book.stock}" required>
    </div>

    <div class="mb-3">
        <label>Deskripsi</label>
        <textarea name="description" class="form-control" rows="4">${book.description}</textarea>
    </div>

    <button type="submit" class="btn btn-success">Update</button>
    <a href="BookServlet?action=list" class="btn btn-secondary">Kembali</a>
</form>

</body>
</html>
