<%@ page import="java.util.List" %>
<%@ page import="com.library.model.Borrowing" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>History Peminjaman</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body>

    <!-- NAVBAR -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark mb-4">
        <div class="container">
            <a class="navbar-brand" href="#">Library Book</a>
            <div class="collapse navbar-collapse">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item"><a class="nav-link" href="books?action=list">Buku</a></li>
                    <li class="nav-item"><a class="nav-link active" href="borrow?action=history">Histori</a></li>
                    <li class="nav-item"><a class="nav-link btn btn-danger btn-sm text-white" href="auth?action=logout">Logout</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- CONTENT -->
    <div class="container">
        <h2 class="mb-3">Riwayat Peminjaman</h2>

        <a href="books?action=list" class="btn btn-secondary mb-3">Kembali ke Dashboard</a>

        <table class="table table-bordered table-striped">
            <thead>
                <tr>
                    <th>Judul Buku</th>
                    <th>Tanggal Pinjam</th>
                    <th>Tenggat</th>
                    <th>Tanggal Kembali</th>
                    <th>Status</th>
                    <th>Aksi</th>
                </tr>
            </thead>

            <tbody>
            <%
                List<Borrowing> borrowList = (List<Borrowing>) request.getAttribute("historyList");

                if (borrowList != null && !borrowList.isEmpty()) {
                    for (Borrowing b : borrowList) {
            %>
                <tr>
                    <td><%= b.getBookTitle() %></td>
                    <td><%= b.getBorrowDate() %></td>
                    <td><%= b.getDueDate() %></td>
                    <td><%= (b.getReturnDate() != null) ? b.getReturnDate() : "-" %></td>

                    <td>
                        <% if ("borrowed".equals(b.getStatus())) { %>
                            <span class="badge bg-warning text-dark">Sedang Dipinjam</span>
                        <% } else { %>
                            <span class="badge bg-success">Dikembalikan</span>
                        <% } %>
                    </td>

                    <td>
                        <% if ("borrowed".equals(b.getStatus())) { %>
                            <a href="borrow?action=return&borrowId=<%= b.getId() %>&bookId=<%= b.getBookId() %>"
                               class="btn btn-success btn-sm"
                               onclick="return confirm('Kembalikan buku ini?')">
                                Kembalikan
                            </a>
                        <% } else { %>
                            <button class="btn btn-secondary btn-sm" disabled>Selesai</button>
                        <% } %>
                    </td>
                </tr>

            <%      
                    } 
                } else {
            %>
                <tr>
                    <td colspan="6" class="text-center">Belum ada riwayat peminjaman.</td>
                </tr>
            <% } %>

            </tbody>
        </table>
    </div>

</body>
</html>
