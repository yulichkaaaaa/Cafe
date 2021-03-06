package com.yuliana.cafe.entity;

public class Review {

    private int reviewId;
    private String header;
    private String text;
    private int rating;

    public Review(){}

    public Review(int reviewId, String header, String text, int rating) {
        this.reviewId = reviewId;
        this.header = header;
        this.text = text;
        this.rating = rating;
    }

    public Review(String header, String text, int rating) {
        this.header = header;
        this.text = text;
        this.rating = rating;
    }

    public int getReviewId() {
        return reviewId;
    }

    public String getHeader() {
        return header;
    }

    public String getText() {
        return text;
    }

    public int getRating() {
        return rating;
    }

    public void setHeader(String header) {
        this.header = header;
    }

    public void setText(String text) {
        this.text = text;
    }

    public void setRating(int rating) {
        this.rating = rating;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Review review = (Review) o;
        if (reviewId != review.reviewId) return false;
        if (rating != review.rating) return false;
        if (header != null ? !header.equals(review.header) : review.header != null) return false;
        return text != null ? text.equals(review.text) : review.text == null;
    }

    @Override
    public int hashCode() {
        int result = reviewId;
        result = 31 * result + (header != null ? header.hashCode() : 0);
        result = 31 * result + (text != null ? text.hashCode() : 0);
        result = 31 * result + rating;
        return result;
    }

    @Override
    public String toString() {
        final StringBuilder sb = new StringBuilder("Review{");
        sb.append("reviewId=").append(reviewId);
        sb.append(", header='").append(header).append('\'');
        sb.append(", text='").append(text).append('\'');
        sb.append(", rating=").append(rating);
        sb.append('}');
        return sb.toString();
    }
}
