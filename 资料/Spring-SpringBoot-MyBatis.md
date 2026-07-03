# Java企业级开发核心框架：Spring、Spring Boot与MyBatis

## 第一部分：框架介绍与Spring Boot的实现机制
### 1. 框架概述
* **什么是框架？**

  *   框架是应用程序的骨架。在编程领域，它是通用的、可复用的软件环境，提供特定功能，汇集代码、库和API以支持系统开发。
* **框架的优势**
  *   **提高开发效率**：事务处理、安全性等通用工作交给框架，开发人员专注业务逻辑。
  *   **提高代码规范性和可维护性**：成熟框架有严格的代码规范，保证团队开发风格统一。
  *   **提高软件性能**：减少冗余代码（如Spring的IoC解耦，MyBatis的动态SQL）。
* **主流框架及技术定位**

  * **Servlet规范**：底层标准（地基），定义HTTP请求接收方式。

    * 与Tomcat服务器关系:

      > Tomcat监听对应服务端口 
      >
      > Servlet将网络请求分发到对应的处理方法
      >
      > Servlet将处理结果以json形式返回

    *   Tomcat及Spring Boot 的`容器`概念: 

        > Tomcat提供了一个服务器运行环境,
        >
        > 在这里可以处理java的Servlet代码,路由请求
        >
        > 同时Tomcat还为许多网络异常行为提供了默认处理方案
        >
        > 让开发者专注于业务逻辑

  * **Spring**：核心指挥官，解决企业应用复杂性。

    > 通过控制反转和依赖注入减少复杂对象的创建与管理

  * **MyBatis**：档案员，半自动化ORM，负责SQL执行和数据映射。

    > 通过对象关系映射(ORM)将`数据表结构`映射到`对象`
    >
    > 支持自行编写sql逻辑,或插件(如`MyBatisX`)自动产生常见sql语句
### 2. Spring Boot如何实现框架及内嵌容器原理

* **什么是Spring Boot？**

  * Spring Boot不是替代Spring，而是与Spring紧密结合以提升开发体验的工具。它集成常用第三方库配置，实现“开箱即用”。

    > Spring 是一种思想,容器,代理模式稍后再说.

    > Spring Boot 在Web层面可以说是 `Spring MVC + Tomcat` 实现代码和部署一体化(将tomcat作为依赖配置)
    >
    >  此外Spring Boot 支持注解,集成大量第三方库配置,因此简化代码开发

    > 如注解
    >
    > `@Bean`: 作用于方法创建新对象
    >
    > `@Component` (及衍生的 @Service, @Repository): 作用于类创建新对象
    >
    > `@Autowired`: 注入对象
* **【深化】内嵌容器与微服务多实例原理**

  * **内嵌Tomcat机制**：传统JSP需外部安装Tomcat；Spring Boot将Tomcat封装为依赖包（`tomcat-embed-core`）。程序执行`main`方法时，在Java进程内部`new`一个Tomcat对象并启动。

  * **打Fat Jar**：代码、依赖库、内嵌Tomcat全被打包成一个`.jar`文件，实现`java -jar`一键启动。

  * **微服务多实例**：启动多个微服务即启动多个独立Tomcat实例，通过配置不同`server.port`实现物理隔离与独立部署。也可无感替换为Jetty或Undertow。

    > 因此Spring Boot的运行结果是许多的后端接口
* **为什么学习Spring Boot？**

  *   简化编码、简化配置、简化部署、简化监控。它是微服务趋势下的核心技术。
---
## 第二部分：从JSP到Spring MVC再到Spring Boot的演进
### 3. 传统Java EE开发的弊端（JSP+Servlet时代）
*   **可维护性差**：分层不清晰，业务逻辑难以分离。
*   **代码重用性低**：重复开发底层功能，易出漏洞。
*   **原生Servlet的痛点**：每个请求需手动编写`doGet/doPost`，手动解析参数，路由配置繁琐。
### 4. Spring MVC：Web层的核心调度框架
*   **从Servlet到Spring MVC的演进**
    *   **Servlet的映射规则**：基于代码逻辑（`@WebServlet`），与物理文件结构无关。
    *   **Spring MVC的解法**：提供核心`DispatcherServlet`（前端控制器）拦截所有请求，通过注解化开发将URL映射到普通Java方法。
*   **核心组件（“高级预制板”）**
    *   **DispatcherServlet（总包工头）**：统一分发请求。
    *   **HandlerMapping（任务分配簿）**：维护URL与方法映射关系。
    *   **HandlerAdapter（全能翻译官）**：解析参数，绑定到Java方法，并执行方法。
    *   **HttpMessageConverter（数据打包机器）**：将对象序列化为JSON，或反序列化JSON为对象。
### 5. 传统MVC到现代Spring Boot的架构转变
*   **传统MVC时代**：Model、View(JSP)、Controller全部在后端。后端渲染HTML发给浏览器（甚至需要拼接字符串）。
*   **Spring Boot时代**：基于Spring MVC，但通过自动配置和内嵌容器，极大地简化了繁琐的XML配置和部署流程，使其成为现代Web开发的标准底座。
---
## 第三部分：Spring Boot、后端接口与前后端分离机制
### 6. MVC架构模式与前后端分离演进
* **现代前后端分离时代**
  * **View的剥离**：View不再由后端渲染，交由前端框架（React/Vue）。前端打包生成的静态文件由Nginx提供访问。
  * **角色分工**：

    * **React与Nginx**：React打包为静态文件，由Nginx（文件仓库管理员）负责物理映射，提供静态资源服务。

      > 即前端工作流程

    * **Spring Boot**：退化为纯粹的API数据提供者（加工车间），运行在Tomcat中，执行Java代码，生成JSON数据。

      > 后端工作流程

* **交互流程**：前端通过Ajax请求后端接口，获取JSON数据并在浏览器端自行渲染。



  > ![1783037751074](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1783037751074.png)

  > ![1783037770860](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1783037770860.png)
  >
  >
### 7. Spring Boot核心功能实战（接口开发）
*   **JSON数据封装**：使用 `@RestController`（组合`@Controller`和`@ResponseBody`），默认使用Jackson(库)解析。支持统一返回结构封装（如`JsonResult`）。**这是后端分离架构下Spring Boot最核心的产出。**
*   **MVC支持注解**：`@RequestMapping`、`@PathVariable`、`@RequestParam`、`@RequestBody`。
*   **全局异常处理**：使用 `@ControllerAdvice` 和 `@ExceptionHandler` 拦截异常，返回统一JSON结构。
*   **AOP切面处理**：通过 `@Aspect` 定义切面，实现日志记录、权限校验等解耦操作。
*   **拦截器**：实现 `HandlerInterceptor` 接口，通过 `WebMvcConfigurer` 注册拦截器。
---
## 第四部分：Spring、Spring Boot、MyBatis配置详解
### 8. Spring框架基础配置
*   **核心接口**：`BeanFactory`（基本容器）、`ApplicationContext`（丰富特性，如`ClassPathXmlApplicationContext`）。
*   **Bean的配置与装配**
    *   **XML配置**：根元素 `<beans>`，常用属性包括 `id`、`class`、`scope`。
    *   如`<bean id="userA" class="com.example.User" />`
    *   **注入方式**：
        *   属性setter方法注入（`<property>`）。
        *   构造方法注入（`<constructor-arg>`）。
        *   注解方式注入：`@Component`、`@Service`、`@Autowired`、`@Resource`等。
*   **Bean的生命周期**
    *   `singleton`：容器管理完整生命周期。每个Spring IoC容器中同一个Bean定义只有一个实例
    *   `prototype`：容器仅负责创建。`prototype` 作用域的 Bean 在**每次被请求时**（无论是通过 `getBean()` 还是依赖注入）都会创建一个全新的实例
    *   监控注解：`@PostConstruct`、`@PreDestroy`。
### 9. Spring Boot配置与属性管理
*   **简化配置**：摒弃繁琐XML，采用Java Config（`@Configuration`、`@Bean`）和 `application.yml`。
*   **属性配置**：
    *   `@Value("${key}")`：获取单个配置。
    *   `@ConfigurationProperties`：批量绑定配置到实体类。
    *   支持多环境配置（`application-dev.yml` / `application-pro.yml`）。
### 10. MyBatis配置与集成
*   **MyBatis概述**：半自动化ORM，解决JDBC硬编码问题。
*   **MyBatis环境搭建（传统方式）**
    *   导入JAR包（或Maven坐标）。
    *   编写实体类与Mapper映射文件（`Mapper.xml`）。
    *   编写核心配置文件（`mybatis-config.xml`）：配置环境、数据源、Mapper路径。
*   **Spring Boot集成MyBatis**
    *   **依赖导入**：`mybatis-spring-boot-starter`、`mysql-connector-java`。
    *   **配置文件**：在 `application.yml` 中配置数据源及MyBatis属性（如驼峰命名开启）。
    *   **整合方式**：
        *   基于XML：添加 `@Mapper` 或 `@MapperScan`，编写XML映射文件。
        *   基于注解：使用 `@Select`、`@Insert` 等注解直接写在Mapper接口上。
### 11. 其他进阶配置
*   **事务管理**：使用 `@Transactional` 注解（注意默认回滚RuntimeException）。
*   **模板引擎**：集成Thymeleaf（注：前后端分离主流下使用频率降低）。

#  其他

## Spring依赖注入(Dependency Injection)和控制反转(IoC)



- 依赖注入

  - 调用者如`UserService` 只声明“我需要一个 `UserDao`”，然后由 Spring 容器在背后默默地把现成的 `UserDao` 对象**塞给它**。

- 控制反转

  - **如何创建、创建哪个实例**由容器决定。这就是“控制权”的**反转**。

  > ![1783003069394](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1783003069394.png)
  >
  >

## mybatis在SpringBoot中使用示例

> 目录结构
>
> ![1783035323805](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1783035323805.png)

> ## pom.xml
>
> ![1783035415477](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1783035415477.png)
>
> ## application.yml
>
> ![1783035481159](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1783035481159.png)
>
> ## 实体类
>
> ![1783035505038](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1783035505038.png)
>
> ## Mapper接口
>
> ![1783035539169](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1783035539169.png)
>
> ## Mapper XML文件
>
> ![1783035605874](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1783035605874.png)
>
> ## Service 层
>
> ![1783035680642](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1783035680642.png)
>
> ## Controller
>
> ![1783035709845](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1783035709845.png)
>
> ## 启动类
>
> ![1783035735548](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1783035735548.png)

> 启动应用后，可以使用以下API进行测试：
>
> - 获取所有用户：GET <http://localhost:8080/users>
> - 根据ID获取用户：GET [http://localhost:8080/users/{id}](http://localhost:8080/users/%7Bid%7D)
> - 添加用户：POST <http://localhost:8080/users> (JSON body)
> - 更新用户：PUT <http://localhost:8080/users> (JSON body)
> - 删除用户：DELETE [http://localhost:8080/users/{id}](http://localhost:8080/users/%7Bid%7D)



> ![1783041701615](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1783041701615.png)
>
> ![1783041812243](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1783041812243.png)
>
> mybatis plus函数实现sql

> CGLIB（Code Generation Library）是一个强大的、高性能的**代码生成库**，它可以在运行期扩展Java类与实现Java接口baidu.com+1。其核心作用是**为没有实现接口的类提供动态代理功能**，是JDK动态代理的重要补充runoob.com+1

> ![1783042512010](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1783042512010.png)
>
>



> ![1783042749712](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1783042749712.png)
>
> Link 是不刷新页面内部跳转

> ![1783042854180](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1783042854180.png)
>
> ![1783043070092](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1783043070092.png)
>
> 你可以主动获取 Spring 容器中的其他 Bean 或资源，实现更复杂的逻辑。
>
> - **作用**：在这个方法中，你可以对即将初始化的 Bean 进行“前置”处理，例如修改 Bean 的属性、包装 Bean（代理模式）等。**这是 AOP 实现的关键步骤之一**。

> 你可以对即将初始化的 Bean 进行“前置”处理，例如修改 Bean 的属性、包装 Bean（代理模式）等。**这是 AOP 实现的关键步骤之一**。

> Spring Boot 通过以下几个关键技术来实现这一理念：
>
> #### 1. 自动配置 (Auto-configuration)
>
> 这是“约定大于配置”最核心的体现。Spring Boot 会根据你添加的依赖（通过 Maven/Gradle 的 “Starter”），自动为你配置相应的功能。
>
> **举个例子：**
>
> - **传统 Spring**：如果你想使用 JPA（Java Persistence API）来操作数据库，你需要手动在 XML 或 Java 配置类中定义 `DataSource`、`EntityManagerFactory`、`TransactionManager` 等 Bean。
>
> - **Spring Boot**：你只需要在 `pom.xml` 中添加 `spring-boot-starter-data-jpa` 依赖。Spring Boot 会自动检测到这个依赖，并根据默认的“约定”（例如，数据源 URL、用户名、密码通常在 `application.properties` 中配置），为你创建并配置好所有必要的 Bean。
>
> - > ![1783046125395](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1783046125395.png)
>   >
>   > ![1783046137375](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1783046137375.png)
>   >
>   > ![1783046313882](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1783046313882.png)
>   >
>   > 当我们在一个事务方法（A）中，调用了另一个事务方法（B）时，Spring 允许我们通过 `@Transactional` 的 `propagation` 属性来定义 **方法 B 应该如何对待事务**。