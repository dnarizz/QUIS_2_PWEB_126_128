package com.library.web;

import com.library.dao.BookDAO;
import com.library.dao.BorrowingDAO;
import com.library.model.Borrowing;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

@WebServlet("/borrow")
public class BorrowServlet extends HttpServlet {

    private BorrowingDAO borrowingDAO;
    private BookDAO bookDAO;

    public void init() {
        borrowingDAO = new BorrowingDAO();
        bookDAO = new BookDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        if (userId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        switch (action) {
            case "borrow":
                handleBorrow(request, response, userId);
                break;
            case "return":
                handleReturn(request, response);
                break;
            case "history":
                showHistory(request, response, userId);
                break;
            default:
                response.sendRedirect("dashboard.jsp");
                break;
        }
    }

    private void handleBorrow(HttpServletRequest request, HttpServletResponse response, int userId) throws IOException {
        int bookId = Integer.parseInt(request.getParameter("bookId"));

        // 1. Kurangi Stok dulu
        boolean stockUpdated = bookDAO.decreaseStock(bookId);

        if (stockUpdated) {
            // 2. Jika stok aman, catat peminjaman
            borrowingDAO.insertBorrowing(userId, bookId);
        }

        response.sendRedirect("borrow?action=history");
    }

    private void handleReturn(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int borrowId = Integer.parseInt(request.getParameter("borrowId"));
        int bookId = Integer.parseInt(request.getParameter("bookId"));

        boolean returned = borrowingDAO.returnBook(borrowId);

        if (returned) {
            bookDAO.increaseStock(bookId);
        }

        response.sendRedirect("borrow?action=history");
    }

    private void showHistory(HttpServletRequest request, HttpServletResponse response, int userId)
            throws ServletException, IOException {
        List<Borrowing> historyList = borrowingDAO.getHistoryByUserId(userId);

        request.setAttribute("historyList", historyList);
        request.getRequestDispatcher("history.jsp").forward(request, response);
    }

}
