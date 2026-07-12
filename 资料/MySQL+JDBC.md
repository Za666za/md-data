# MySQL + JDBC 

(可安装使用`Typroa`打开md文档)

## 目录
1. MySQL数据库基础
2. JDBC基础概念
3. JDBC连接MySQL
4. JDBC执行SQL语句
5. JDBC事务处理
6. JDBC连接池
7. 实践案例
---
## 第一部分：MySQL数据库基础
### 1.1 数据库概述
- **数据库定义**：存储数据的仓库，本质是文件系统，按照特定格式存储数据
- **数据库分类**：

  - 关系型数据库：MySQL、Oracle、DB2、SQLserver、SQLite

    - ![1782828405048](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1782828405048.png)

  - 非关系型数据库：Redis、Hbase、MongoDB

    - ![1782828427433](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1782828427433.png)

- **MySQL特点**：
  - 开源免费
  - 支持大型数据库
  - 使用标准SQL语言
  - 跨平台支持
### 1.2 SQL语句基础
**SQL分类**：
1. **DDL** (数据定义语言)：create, alter, drop
2. **DML** (数据操作语言)：insert, delete, update
3. **DQL** (数据查询语言)：select
4. **DCL** (数据控制语言)：grant, revoke
    **SQL通用语法**：
- 以分号结尾
- 不区分大小写，建议关键字大写
- 支持`/* */`, `--`, `#`注释
### 1.3 常用数据类型
```sql
-- 数值类型
INT, BIGINT, FLOAT, DOUBLE, DECIMAL(M,D)
-- 字符串类型
CHAR(固定长度), VARCHAR(可变长度), TEXT
-- 日期类型
DATE, TIME, DATETIME, TIMESTAMP
```
> 数值类型
>
> ![1782829118639](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1782829118639.png)

> 日期类型
>
> ![1782829134866](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1782829134866.png)

> 字符串类型
>
> ![1782829152488](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1782829152488.png)

### 1.4 数据库操作

```sql
-- 创建数据库
CREATE DATABASE mydb CHARACTER SET utf8;
-- 使用数据库
USE mydb;
-- 创建表
CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(20) NOT NULL,
    password VARCHAR(20) NOT NULL,
    email VARCHAR(50),
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP
);
-- 插入数据
INSERT INTO users(username, password, email) VALUES('admin', '123456', 'admin@example.com');
-- 查询数据
SELECT * FROM users WHERE username = 'admin';
-- 更新数据
UPDATE users SET password = 'newpass' WHERE id = 1;
-- 删除数据
DELETE FROM users WHERE id = 1;
```
#### 主键自增和删除数据

- TRUNCATE: **删除表中的所有数据并重建该表**

- ```python
  # 按条件删除记录
  格式：delete from 表名 [where 条件];
  delete from category where cid = '005‘; # 删除cid为005的纪录
  
  # 清空表记录
  格式：truncate table 表名; 
  truncate category; # 清空表数据
  
  # 注意：
  清空表记录和删除表记录的区别：
  使用delete删除表记录时，主键自增序列不清零。
  使用truncate删除表记录时，主键自增序列清零。
  ```

### 1.5 多表查询

```sql
-- 内连接 共有数据保存
SELECT * FROM users u INNER JOIN orders o ON u.id = o.user_id;
-- 左连接
SELECT * FROM users u LEFT JOIN orders o ON u.id = o.user_id;
-- 子查询
SELECT * FROM users WHERE id IN (SELECT user_id FROM orders WHERE amount > 100);
```
#### 分组查询 

> 分组查询是指使用group by字句对查询信息进行分组。

>  格式：`SELECT 字段1,字段2… FROM 表名 GROUP BY 分组字段 HAVING 分组条件;`
>
> 分组操作中的having子语句，是用于在分组后对数据进行过滤的，作用类似于where条件。 

having与where的区别: 

1).having是在分组后对数据进行过滤,where是在分组前对数据进行过滤 

2).having后面可以使用分组函数(统计函数),where后面不可以使用分组函数。

```mssql
-- 1 统计各个分类商品的个数
SELECT category_id ,COUNT(*) FROM product GROUP BY category_id ;

-- 2 统计各个分类商品的个数,且只显示个数大于1的信息
SELECT category_id ,COUNT(*) FROM product GROUP BY category_id HAVING COUNT(*) > 1;
```

#### 分页查询

> ![1782830596827](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1782830596827.png)

---
## 第二部分：JDBC基础概念

### 2.0 Java SPI 思想

#### 1. 核心设计思想
官方定义标准接口，第三方厂商提供实现，运行时通过 `ServiceLoader` 自动发现加载，实现业务与底层实现解耦、组件可插拔。

#### 2. JDBC 中的具体落地体现
- **定义标准 SPI 接口**：
  JDK 提供 `java.sql.Driver` 统一规范接口，所有数据库驱动（如 MySQL、Oracle）都必须实现该接口。

- **厂商实现 + SPI 配置文件**：
  数据库厂商驱动包内置于路径 `META-INF/services/java.sql.Driver` 中配置文件，文件内容为驱动实现类的全类名（如 `com.mysql.cj.jdbc.Driver`），作为服务注册标识。

- **运行时自动加载**：
  `DriverManager` 的静态代码块通过 `ServiceLoader.load(Driver.class)` 扫描全部驱动配置，反射实例化并自动注册。在 JDBC 4.0+ 版本中，无需手动编写 `Class.forName()` 加载驱动。

- **解耦与可插拔效果**：
  业务代码仅依赖 `java.sql.Driver` 标准接口，不绑定任何具体数据库厂商实现；切换数据库时仅需替换驱动 jar 包，业务代码无需修改；新增数据库支持时，厂商只需实现接口并添加 SPI 配置即可无缝接入。

- > ![1782811661656](D:\新桌面\2\work\data_work\img\%5CUsers%5C6%5CAppData%5CRoaming%5CTypora%5Ctypora-user-images%5C1782811661656.png)

### 2.1 什么是JDBC
- **JDBC** (Java Database Connectivity) 是Java程序连接数据库的标准API
- **作用**：提供统一接口访问不同数据库
- **组成**：
  - JDBC API：Java标准库中的接口
  - JDBC驱动管理器：管理驱动程序
  - JDBC驱动：实现JDBC接口的具体类
### 2.2 JDBC核心接口
```java
// 主要接口
java.sql.Driver          // 驱动接口
java.sql.Connection      // 连接接口
java.sql.Statement       // 执行SQL语句接口
java.sql.ResultSet       // 结果集接口
java.sql.PreparedStatement // 预编译SQL语句接口
```
### 2.3 JDBC工作原理
```
Java程序 → JDBC API → JDBC驱动 → 数据库
```
---
## 第三部分：JDBC连接MySQL
### 3.1 准备工作
1. **下载MySQL驱动**：mysql-connector-java.jar
2. **添加到项目**：
   - Maven项目：添加依赖
   ```xml
   <dependency>
       <groupId>mysql</groupId>
       <artifactId>mysql-connector-java</artifactId>
       <version>8.0.28</version>
   </dependency>
   ```
   - 普通项目：添加到build path
### 3.2 JDBC连接步骤
```java
import java.sql.*;
public class JDBCDemo {
    public static void main(String[] args) {
        // 1. 加载驱动
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        
        // 2. 获取连接
        String url = "jdbc:mysql://localhost:3306/mydb?useSSL=false&serverTimezone=UTC";
        String username = "root";
        String password = "password";
        
        try (Connection conn = DriverManager.getConnection(url, username, password)) {
            // 3. 执行SQL语句
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM users");
            
            // 4. 处理结果
            while (rs.next()) {
                System.out.println(rs.getInt("id") + " " + rs.getString("username"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
```
### 3.3 连接字符串详解
```
jdbc:mysql://host:port/database?参数
```
**常用参数**：
- `useSSL=false`：禁用SSL(加密通信)
- `serverTimezone=UTC`：设置时区
- `characterEncoding=utf8`：设置字符编码
---
## 第四部分：JDBC执行SQL语句
### 4.1 Statement执行SQL
```java
// 执行查询
Statement stmt = conn.createStatement();
ResultSet rs = stmt.executeQuery("SELECT * FROM users");
// 执行更新
int rows = stmt.executeUpdate("UPDATE users SET password='newpass' WHERE id=1");
// 执行任意SQL
boolean hasResultSet = stmt.execute("SELECT * FROM users");
```
### 4.2 PreparedStatement执行SQL
**优势**：
- 防止SQL注入
- 预编译提高性能
- 参数化查询
```java
String sql = "SELECT * FROM users WHERE username = ? AND password = ?";
try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
    pstmt.setString(1, "admin");
    pstmt.setString(2, "password");
    
    try (ResultSet rs = pstmt.executeQuery()) {
        while (rs.next()) {
            // 处理结果
        }
    }
}
```
### 4.3 处理ResultSet
```java
while (rs.next()) {
    // 通过列名获取
    int id = rs.getInt("id");
    String name = rs.getString("username");
    
    // 通过列索引获取(从1开始)
    String email = rs.getString(4);
    
    // 获取不同类型数据
    Date date = rs.getDate("create_time");
    Timestamp timestamp = rs.getTimestamp("create_time");
}
```
---
## 第五部分：JDBC事务处理
### 5.1 事务概念
- **ACID特性**：原子性、一致性、隔离性、持久性
- **JDBC事务控制**：
  ```java
  conn.setAutoCommit(false); // 关闭自动提交
  conn.commit(); // 提交事务
  conn.rollback(); // 回滚事务
  ```
### 5.2 事务示例
```java
try (Connection conn = DriverManager.getConnection(url, username, password)) {
    conn.setAutoCommit(false); // 开启事务
    
    try {
        // 执行多个SQL操作
        PreparedStatement pstmt1 = conn.prepareStatement("UPDATE account SET balance = balance - 100 WHERE id = 1");
        pstmt1.executeUpdate();
        
        PreparedStatement pstmt2 = conn.prepareStatement("UPDATE account SET balance = balance + 100 WHERE id = 2");
        pstmt2.executeUpdate();
        
        conn.commit(); // 提交事务
        System.out.println("转账成功");
    } catch (SQLException e) {
        conn.rollback(); // 回滚事务
        System.out.println("转账失败: " + e.getMessage());
    }
}
```
---
## 第六部分：JDBC连接池
### 6.1 连接池概念
- **作用**：管理数据库连接，提高性能
- **常用连接池**：
  - DBCP
  - C3P0
  - Druid (阿里巴巴)
### 6.2 Druid连接池配置
```java
import com.alibaba.druid.pool.DruidDataSource;
public class DruidDemo {
    public static void main(String[] args) {
        DruidDataSource dataSource = new DruidDataSource();
        dataSource.setUrl("jdbc:mysql://localhost:3306/mydb");
        dataSource.setUsername("root");
        dataSource.setPassword("password");
        dataSource.setInitialSize(5); // 初始连接数
        dataSource.setMaxActive(10); // 最大连接数
        
        try (Connection conn = dataSource.getConnection()) {
            // 使用连接执行SQL
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
```
---
## 第七部分：实践案例
### 7.1 用户管理系统
**需求**：
- 用户注册、登录
- 用户信息查询
- 用户信息修改
  **数据库设计**：
```sql
CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(20) NOT NULL UNIQUE,
    password VARCHAR(20) NOT NULL,
    email VARCHAR(50),
    phone VARCHAR(11),
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP
);
```
**Java实现**：
```java
public class UserService {
    private DataSource dataSource;
    
    public UserService(DataSource dataSource) {
        this.dataSource = dataSource;
    }
    
    // 用户注册
    public boolean register(String username, String password, String email) {
        String sql = "INSERT INTO users(username, password, email) VALUES(?, ?, ?)";
        try (Connection conn = dataSource.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, username);
            pstmt.setString(2, password);
            pstmt.setString(3, email);
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // 用户登录
    public User login(String username, String password) {
        String sql = "SELECT * FROM users WHERE username = ? AND password = ?";
        try (Connection conn = dataSource.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, username);
            pstmt.setString(2, password);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    User user = new User();
                    user.setId(rs.getInt("id"));
                    user.setUsername(rs.getString("username"));
                    user.setEmail(rs.getString("email"));
                    return user;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
```
### 7.2 商品查询系统
**需求**：
- 商品列表查询
- 商品分类查询
- 商品价格区间查询
  **数据库设计**：
```sql
CREATE TABLE category (
    cid VARCHAR(32) PRIMARY KEY,
    cname VARCHAR(50)
);
CREATE TABLE products (
    pid VARCHAR(32) PRIMARY KEY,
    pname VARCHAR(50),
    price DOUBLE,
    category_id VARCHAR(32),
    flag VARCHAR(2),
    FOREIGN KEY (category_id) REFERENCES category(cid)
);
```
**Java实现**：
```java
public class ProductService {
    private DataSource dataSource;
    
    // 查询所有商品
    public List<Product> getAllProducts() {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT * FROM products";
        
        try (Connection conn = dataSource.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                Product product = new Product();
                product.setPid(rs.getString("pid"));
                product.setPname(rs.getString("pname"));
                product.setPrice(rs.getDouble("price"));
                products.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }
    
    // 按分类查询商品
    public List<Product> getProductsByCategory(String categoryId) {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT p.*, c.cname FROM products p JOIN category c ON p.category_id = c.cid WHERE p.category_id = ?";
        
        try (Connection conn = dataSource.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, categoryId);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Product product = new Product();
                    product.setPid(rs.getString("pid"));
                    product.setPname(rs.getString("pname"));
                    product.setPrice(rs.getDouble("price"));
                    products.add(product);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }
}
```
---
## 总结
### MySQL要点
1. 基本SQL语句编写
2. 数据库设计原则
3. 多表查询技巧
4. 索引和优化
### JDBC要点
1. 连接数据库的基本步骤
2. Statement与PreparedStatement的使用
3. ResultSet结果处理
4. 事务管理
5. 连接池使用
### 最佳实践
1. 使用PreparedStatement防止SQL注入
2. 合理使用连接池提高性能
3. 正确处理异常和资源释放
4. 使用try-with-resources自动关闭资源
5. 合理设计事务边界
---
## 练习题
1. 编写一个Java程序，实现用户注册和登录功能
2. 使用JDBC实现商品的增删改查功能
3. 实现一个简单的转账系统，演示事务的使用
4. 配置Druid连接池，重写之前的练习题
5. 实现商品的多条件查询（按名称、价格、分类）

# 扩展: 开窗函数

> 也常被称为**窗口函数**或**分析函数**,能在不合并数据行的情况下，对数据进行灵活的分组、排序和计算.
>
> ![1782831162298](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1782831162298.png)

> ![-1782831173038](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1782831173038.png)

> ![1782831217423](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1782831217423.png)
>
> ![1782831228055](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1782831228055.png)
>
> ![1782831239683](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1782831239683.png)
>
> ![1782831256973](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1782831256973.png)
>
>

