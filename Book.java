package com.library.model;

public class Book {
    private int id;
    private String title;
    private String author;
    private String genre;
    private int stock;
    private String description;

    public Book(int id, String title, String author, String genre, int stock, String description) {
        this.id = id;
        this.title = title;
        this.author = author;
        this.genre = genre;
        this.stock = stock;
        this.description = description;
    }

    public Book(String title, String author, String genre, int stock, String description) {
        this.title = title;
        this.author = author;
        this.genre = genre;
        this.stock = stock;
        this.description = description;
    }

    // Generate Getter and Setter here...
    public int getId() {
        return id;
    }

    public String getTitle() {
        return title;
    }

    public String getAuthor() {
        return author;
    }

    public String getGenre() {
        return genre;
    }

    public int getStock() {
        return stock;
    }

    public String getDescription() {
        return description;
    }

}
