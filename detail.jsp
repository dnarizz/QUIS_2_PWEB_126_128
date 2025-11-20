<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Detail Buku - ${book.title}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <nav class="navbar navbar-dark bg-dark mb-4">
        <div class="container">
            <a class="navbar-brand" href="books?action=list">Library Book</a>
        </div>
    </nav>

    <div class="container">
        <div class="card shadow-sm">
            <div class="card-header">
                <h4 class="mb-0">Detail Informasi Buku</h4>
            </div>
            <div class="card-body">
                <div class="row">
                    <div class="col-md-4 text-center">
                        <div class="bg-secondary text-white d-flex align-items-center justify-content-center" style="height: 300px; width: 100%;">
                            <span>No Image Available</span>
                        </div>
                    </div>
                    
                    <div class="col-md-8">
                        <h2 class="fw-bold">${book.title}</h2>
                        <h5 class="text-muted mb-3">Penulis: ${book.author}</h5>
                        
                        <table class="table table-borderless">
                            <tr>
                                <th style="width: 150px;">Genre</th>
                                <td>: <span class="badge bg-info text-dark">${book.genre}</span></td>
                            </tr>
                            <tr>
                                <th>Stok Tersedia</th>
                                <td>: 
                                    <c:choose>
                                        <c:when test="${book.stock > 0}">
                                            <span class="badge bg-success">${book.stock} Eksemplar</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-danger">Habis</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                            <tr>
                                <th>Deskripsi</th>
                                <td>: <p class="text-justify">${book.description}</p></td>
                            </tr>
                        </table>

                        <div class="mt-4">
                            <c:if test="${book.stock > 0}">
                                <a href="borrow?action=borrow&bookId=${book.id}" class="btn btn-primary btn-lg px-5">Pinjam Buku Ini</a>
                            </c:if>
                            <c:if test="${book.stock <= 0}">
                                <button class="btn btn-secondary btn-lg px-5" disabled>Stok Habis</button>
                            </c:if>
                            <a href="books?action=list" class="btn btn-outline-secondary btn-lg ms-2">Kembali</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>