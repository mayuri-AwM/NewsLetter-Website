package com.db;
public class News {
    private int id;
    private String title;
    private String author;
    private String category;
    private String content;
    private String newsDate;
    private String status;
    
    public News() {
    	super();
    }
    
    
    public News(int id, String title, String author, String category, String content, String newsDate,String status) {
        this.id = id;
        this.title = title;
        this.status = status;
        this.author = author;
        this.category = category;
        this.content = content;
        this.newsDate = newsDate;   
    }

    // Getters and setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getNewsDate() {
        return newsDate;
    }

    public void setNewsDate(String newsDate) {
        this.newsDate = newsDate;
    }


}
