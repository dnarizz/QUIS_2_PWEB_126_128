package com.library.dao;

import com.library.config.DBConnection;
import com.library.model.Borrowing;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BorrowingDAO {

    // 1. Method untuk Meminjam Buku (INSERT)
    // Mengembalikan true jika berhasil
    public boolean insertBorrowing(int userId, int bookId) {
        boolean isSuccess = false;
        String sql = "INSERT INTO borrowings (id_user, id_book, borrow_date, due_date, status, created_at) " +
                "VALUES (?, ?, CURDATE(), DATE_ADD(CURDATE(), INTERVAL 7 DAY), 'borrowed', NOW())";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ps.setInt(2, bookId);

            int result = ps.executeUpdate();
            if (result > 0) {
                isSuccess = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return isSuccess;
    }

    // 2. Method untuk Mengembalikan Buku (UPDATE status & tanggal kembali)
    public boolean returnBook(int borrowingId) {
        boolean isSuccess = false;
        String sql = "UPDATE borrowings SET status = 'returned', return_date = CURDATE(), updated_at = NOW() WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, borrowingId);

            int result = ps.executeUpdate();
            if (result > 0) {
                isSuccess = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return isSuccess;
    }

    // 3. Method untuk Melihat History User (SELECT dengan JOIN ke tabel Books)
    public List<Borrowing> getHistoryByUserId(int userId) {
        List<Borrowing> list = new ArrayList<>();
        // Kita perlu JOIN ke tabel books untuk mengambil judul buku (books.title)
        String sql = "SELECT br.id, br.id_user, br.id_book, b.title, br.borrow_date, br.return_date, br.due_date, br.status "
                +
                "FROM borrowings br " +
                "JOIN books b ON br.id_book = b.id " +
                "WHERE br.id_user = ? " +
                "ORDER BY br.borrow_date DESC";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Borrowing b = new Borrowing();
                b.setId(rs.getInt("id"));
                b.setUserId(rs.getInt("id_user"));
                b.setBookId(rs.getInt("id_book"));
                b.setBookTitle(rs.getString("title")); // Judul diambil dari tabel books
                b.setBorrowDate(rs.getDate("borrow_date"));
                b.setReturnDate(rs.getDate("return_date"));
                b.setDueDate(rs.getDate("due_date"));
                b.setStatus(rs.getString("status"));

                list.add(b);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // 4. Helper: Cek apakah user sedang meminjam buku yang sama (Optional, untuk
    // validasi)
    public boolean isBookCurrentlyBorrowedByUser(int userId, int bookId) {
        boolean isBorrowed = false;
        String sql = "SELECT id FROM borrowings WHERE id_user = ? AND id_book = ? AND status = 'borrowed'";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, bookId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                isBorrowed = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return isBorrowed;
    }
}