package com.yuliana.cafe.dao.impl;

import com.yuliana.cafe.connection.ConnectionPool;
import com.yuliana.cafe.dao.DaoException;
import com.yuliana.cafe.dao.DishDao;
import com.yuliana.cafe.entity.Category;
import com.yuliana.cafe.entity.Dish;
import org.apache.logging.log4j.Level;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DishDaoImpl implements DishDao {

    private static final Logger logger = LogManager.getLogger();
    private static final ConnectionPool pool = ConnectionPool.INSTANCE;
    private static final String SELECT_ALL_DISHES = "SELECT dish_id, name, category, picture_name, price FROM dishes";
    private static final String SELECT_DISHES_BY_CATEGORY = "SELECT dish_id, name, category, picture_name, price FROM dishes WHERE category = ?";
    private static final String SELECT_DISHES_BY_NAME = "SELECT dish_id, name, category, picture_name, price FROM dishes WHERE name = ?";
    private static final String SELECT_DISHES_BY_PRICE= "SELECT dish_id, name, category, picture_name, price FROM dishes WHERE price > ? and price < ?";

    @Override
    public List<Dish> getAllDishes() throws DaoException{
        Connection connection = pool.getConnection();
        List<Dish> dishes = new ArrayList<>();
        try (Statement statement = connection.createStatement()){
            ResultSet result = statement.executeQuery(SELECT_ALL_DISHES);
            while (result.next()) {
                dishes.add(createDish(result));
            }
        }catch (SQLException e){
            logger.log(Level.ERROR, e.getMessage());
            throw new DaoException(e.getMessage());
        }finally {
            pool.releaseConnection(connection);
        }
        return dishes;
    }

    @Override
    public List<Dish> findDishesByPrice(double min, double max) throws DaoException{
        Connection connection = pool.getConnection();
        List<Dish> dishes = new ArrayList<>();
        try (PreparedStatement statement = connection.prepareStatement(SELECT_DISHES_BY_PRICE)){
            statement.setDouble(1, min);
            statement.setDouble(2, max);
            ResultSet result = statement.executeQuery();
            while (result.next()) {
                dishes.add(createDish(result));
            }
        }catch (SQLException e){
            throw new DaoException(e.getMessage());
        }finally {
            pool.releaseConnection(connection);
        }
        return dishes;
    }

    @Override
    public List<Dish> findDishesByCategory(Category category) throws DaoException{
        Connection connection = pool.getConnection();
        List<Dish> dishes = new ArrayList<>();
        try (PreparedStatement statement = connection.prepareStatement(SELECT_DISHES_BY_CATEGORY)){
            statement.setString(1, category.name().toLowerCase());
            ResultSet result = statement.executeQuery();
            while (result.next()) {
                dishes.add(createDish(result));
            }
        }catch (SQLException e){
            throw new DaoException(e.getMessage());
        }finally {
            pool.releaseConnection(connection);
        }
        return dishes;
    }

    @Override
    public List<Dish> findDishesByName(String name) throws DaoException{
        Connection connection = pool.getConnection();
        List<Dish> dishes = new ArrayList<>();
        try (PreparedStatement statement = connection.prepareStatement(SELECT_DISHES_BY_NAME)){
            statement.setString(1, name);
            ResultSet result = statement.executeQuery();
            while (result.next()) {
                dishes.add(createDish(result));
            }
        }catch (SQLException e){
            throw new DaoException(e.getMessage());
        }finally {
            pool.releaseConnection(connection);
        }
        return dishes;
    }

    private Dish createDish(ResultSet dishData) throws DaoException{
        Dish dish;
        try {
            int dishId = dishData.getInt(1);
            String name = dishData.getString(2);
            String dishCategory = dishData.getString(3);
            Category category = Category.valueOf(dishCategory.toUpperCase());
            String pictureName = dishData.getString(4);
            double price = dishData.getDouble(5);
            dish = new Dish(dishId, name, category, pictureName,price);
        } catch (SQLException e) {
            throw new DaoException(e.getMessage());
        }
        return dish;
    }

}