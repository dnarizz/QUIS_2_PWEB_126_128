package com.library.web;

import com.library.dao.BookDAO;
import com.library.model.Book;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

@WebServlet("/books")
public class BookServlet extends HttpServlet {
    private BookDAO bookDAO;

    public void init() {
        bookDAO = new BookDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null)
            action = "list";

        switch (action) {

            case "list":
                List<Book> listBooks = bookDAO.selectAllBooks();
                request.setAttribute("listBooks", listBooks);
                request.getRequestDispatcher("dashboard.jsp").forward(request, response);
                break;

            case "detail":
                try {
                    int detailId = Integer.parseInt(request.getParameter("id"));
                    Book detailBook = bookDAO.selectBook(detailId);
                    request.setAttribute("book", detailBook);
                    request.getRequestDispatcher("book-detail.jsp").forward(request, response);
                } catch (NumberFormatException ex) {
                    response.sendRedirect("books?action=list");
                }
                break;

            case "new":
                request.getRequestDispatcher("form-book.jsp").forward(request, response);
                break;

            case "edit":
                try {
                    int editId = Integer.parseInt(request.getParameter("id"));
                    Book editBook = bookDAO.selectBook(editId);
                    request.setAttribute("book", editBook);
                    request.getRequestDispatcher("form-book.jsp").forward(request, response);
                } catch (NumberFormatException ex) {
                    response.sendRedirect("books?action=list");
                }
                break;

            case "delete":
                try {
                    int deleteId = Integer.parseInt(request.getParameter("id"));
                    bookDAO.deleteBook(deleteId);
                } catch (NumberFormatException ex) {
                    // ignore invalid id
                }
                response.sendRedirect("books?action=list");
                break;

            default:
                response.sendRedirect("books?action=list");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");

        // SAVE = insert atau update
        if ("save".equals(action)) {

            int id = 0;
            String idParam = request.getParameter("id");
            if (idParam != null && !idParam.isEmpty()) {
                try {
                    id = Integer.parseInt(idParam);
                } catch (NumberFormatException ex) {
                    id = 0;
                }
            }

            String title = request.getParameter("title");
            String author = request.getParameter("author");
            String genre = request.getParameter("genre");
            int stock = 0;
            try {
                stock = Integer.parseInt(request.getParameter("stock"));
            } catch (Exception ex) {
                stock = 0;
            }
            String description = request.getParameter("description");

            Book book = new Book(id, title, author, genre, stock, description);

            if (id > 0) {
                bookDAO.updateBook(book);  
            } else {
                bookDAO.insertBook(book); 

            response.sendRedirect("books?action=list");
        } else {
            response.sendRedirect("books?action=list");
        }
    }
}

