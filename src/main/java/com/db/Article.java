package com.db;

import java.util.Date;

public class Article {
   private int id;
   private String title;
   private String category;
   private String content;
   private Date newsdate;
   private String author;
   private String status;

   public Article(int id, String title, String category,String author, String content, Date newsdate,String status) {
       this.id = id;
       this.title = title;
       this.category = category; 
       this.author = author;
       this.content = content;
       this.newsdate = newsdate;
       this.status = status;
   }

   public String getAuthor() {
	return author;
}

public void setAuthor(String author) {
	this.author = author;
}

public String getStatus() {
	return status;
}

public void setStatus(String status) {
	this.status = status;
}

// Getters and setters
   public int getId() { return id; }
   public void setId(int id) { this.id = id; }
   
   public String getTitle() { return title; }
   public void setTitle(String title) { this.title = title; }
   
   public String getCategory() { return category; }
   public void setCategory(String category) { this.category = category; }
   
   public String getContent() { return content; }
   public void setContent(String content) { this.content = content; }
   
   public Date getNewsdate() { return newsdate; }
   public void setNewsdate(Date newsdate) { this.newsdate = newsdate; }
}