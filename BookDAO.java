package com.library.dao;

import com.library.config.DBConnection;
import com.library.model.Book;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BookDAO {
    // SELECT ALL
    public List<Book> selectAllBooks() {
        List<Book> books = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement("SELECT * FROM books ORDER BY created_at DESC");
                ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                books.add(new Book(rs.getInt("id"), rs.getString("title"), rs.getString("author"),
                        rs.getString("genre"), rs.getInt("stock"), rs.getString("description")));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return books;
    }

    // SELECT SINGLE
    public Book selectBook(int id) {
        Book book = null;
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement("SELECT * FROM books WHERE id = ?")) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    book = new Book(id, rs.getString("title"), rs.getString("author"), rs.getString("genre"),
                            rs.getInt("stock"), rs.getString("description"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return book;
    }

    // INSERT
    public void insertBook(Book book) {
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(
                        "INSERT INTO books (title, author, genre, stock, description, created_at) VALUES (?, ?, ?, ?, ?, NOW())")) {
            ps.setString(1, book.getTitle());
            ps.setString(2, book.getAuthor());
            ps.setString(3, book.getGenre());
            ps.setInt(4, book.getStock());
            ps.setString(5, book.getDescription());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // UPDATE
    public boolean updateBook(Book book) {
        boolean rowUpdated = false;
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(
                        "UPDATE books SET title = ?, author = ?, genre = ?, stock = ?, description = ?, updated_at = NOW() WHERE id = ?")) {
            ps.setString(1, book.getTitle());
            ps.setString(2, book.getAuthor());
            ps.setString(3, book.getGenre());
            ps.setInt(4, book.getStock());
            ps.setString(5, book.getDescription());
            ps.setInt(6, book.getId());
            rowUpdated = ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return rowUpdated;
    }

    // DELETE
    public boolean deleteBook(int id) {
        boolean rowDeleted = false;
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement("DELETE FROM books WHERE id = ?")) {
            ps.setInt(1, id);
            rowDeleted = ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return rowDeleted;
    }

    // Method kurangi stok saat dipinjam
    public boolean decreaseStock(int bookId) {
        boolean rowUpdated = false;
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn
                        .prepareStatement("UPDATE books SET stock = stock - 1 WHERE id = ? AND stock > 0")) {
            ps.setInt(1, bookId);
            rowUpdated = ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rowUpdated;
    }

    // Method tambah stok saat dikembalikan
    public boolean increaseStock(int bookId) {
        boolean rowUpdated = false;
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement("UPDATE books SET stock = stock + 1 WHERE id = ?")) {
            ps.setInt(1, bookId);
            rowUpdated = ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rowUpdated;
    }
}
