package com.yuliana.cafe.dao.impl;

import com.yuliana.cafe.connection.ConnectionPool;
import com.yuliana.cafe.dao.ReviewDao;
import com.yuliana.cafe.entity.Review;
import com.yuliana.cafe.exception.DaoException;
import org.apache.logging.log4j.Level;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ReviewDaoImpl implements ReviewDao {

    private static final Logger logger = LogManager.getLogger();
    private static final ConnectionPool pool = ConnectionPool.INSTANCE;
    private static final String INSERT_REVIEW = "INSERT INTO reviews (user_id, header, text, rating) " +
            "VALUES (?, ?, ?, ?)";
    private static final String SELECT_ALL_REVIEWS = "SELECT review_id, user_id, header, text, rating FROM reviews";

    @Override
    public void addReview(Review review, int userId) throws DaoException{
        Connection connection = pool.getConnection();
        try(PreparedStatement statement = connection.prepareStatement(INSERT_REVIEW)){
            statement.setInt(1, userId);
            statement.setString(2, review.getHeader());
            statement.setString(3, review.getText());
            statement.setInt(4, review.getRating());
            statement.executeUpdate();
        } catch (SQLException e) {
            logger.log(Level.ERROR, e.getMessage());
            throw new DaoException();
        } finally {
            pool.releaseConnection(connection);
        }
    }

    @Override
    public List<Review> getAllReviews() throws DaoException {
        Connection connection = pool.getConnection();
        List<Review> reviews = new ArrayList<>();
        try (Statement statement = connection.createStatement()){
            ResultSet result = statement.executeQuery(SELECT_ALL_REVIEWS);
            while (result.next()) {
                Review review = createReview(result);
                reviews.add(review);
            }
        }catch (SQLException e){
            throw new DaoException(e);
        }finally {
            pool.releaseConnection(connection);
        }
        return reviews;
    }

    private Review createReview(ResultSet userData) throws DaoException{
        Review review;
        try {
            int reviewId = userData.getInt(1);
            int userId = userData.getInt(2);
            String header = userData.getString(3);
            String text = userData.getString(4);
            int rating = userData.getInt(5);
            review = new Review(reviewId, header, text, rating);
        } catch (SQLException e) {
            throw new DaoException(e);
        }
        return review;
    }


}
