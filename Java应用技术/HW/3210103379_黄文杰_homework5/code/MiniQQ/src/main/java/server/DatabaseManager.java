package server;

import java.sql.*;

public class DatabaseManager {
    private final String JDBC_URL;
    private final String USER;
    private final String PASSWORD;

    public DatabaseManager(String jdbcUrl, String user, String password) {
        this.JDBC_URL = jdbcUrl;
        this.USER = user;
        this.PASSWORD = password;
    }

    // 获取数据库连接
    public Connection getConnection() throws SQLException {
        try {
            // 加载 JDBC 驱动
            Class.forName("com.mysql.cj.jdbc.Driver");

            // 建立数据库连接
            return DriverManager.getConnection(JDBC_URL, USER, PASSWORD);
        } catch (ClassNotFoundException e) {
            throw new SQLException("Failed to load JDBC driver: " + e.getMessage(), e);
        }
    }

    // 查询登录结果
    public boolean login(String username, String password) {
        String sql = "SELECT * FROM user WHERE username = ? AND password = ?";

        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            // 设置参数
            preparedStatement.setString(1, username);
            preparedStatement.setString(2, password);

            // 执行查询
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                // 如果查询结果有数据，表示登录成功
                return resultSet.next();
            }

        } catch (SQLException e) {
            e.printStackTrace();
            // 登录失败，返回 false
            return false;
        }
    }


    // 注册新用户
    public boolean register(String username, String password) {
        String sql = "INSERT INTO user (username, password) VALUES (?, ?)";

        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            // 设置参数
            preparedStatement.setString(1, username);
            preparedStatement.setString(2, password);

            // 执行更新
            int rowsAffected = preparedStatement.executeUpdate();

            // 注册成功，返回 true
            return rowsAffected > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            // 注册失败，返回 false
            return false;
        }
    }

    // 检查用户名是否已经存在
    public boolean checkIfUsernameExists(String username) {
        String sql = "SELECT COUNT(*) FROM user WHERE username = ?";

        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            // 设置参数
            preparedStatement.setString(1, username);

            // 执行查询
            ResultSet resultSet = preparedStatement.executeQuery();

            // 获取查询结果
            if (resultSet.next()) {
                int count = resultSet.getInt(1);
                return count > 0; // 如果 count 大于 0，说明用户名已存在
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        // 查询失败或用户名不存在，返回 false
        return false;
    }
}
