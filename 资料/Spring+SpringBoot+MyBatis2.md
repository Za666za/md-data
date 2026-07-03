# Java企业级开发核心框架：Spring、Spring Boot与MyBatis 
## 目录 
1. **框架概述**：从传统Java EE到主流框架**及前后端分离演进** 
2. **Spring框架基础**：IoC容器与Bean的管理 
3. **MyBatis框架**：半自动化ORM持久层方案 
4. **Spring MVC**：**Web层的核心调度框架解析**
5. **Spring Boot**：简化企业级开发的利器**及内嵌容器原理** 
6. **课程总结与学习路径** 
---
## 1. 框架概述 
### 1.1 什么是框架？ 
“框架”一词最早出现在建筑领域，指的是在建造房屋前期构建的建筑骨架。在编程领域，框架就是应用程序的骨架，开发人员可以在这个骨架上加入自己的代码，搭建出符合需求的应用系统。 
软件框架是一种通用的、可复用的软件环境，它提供特定的功能，把支撑程序、编译器、代码、库、工具集以及API汇集在一起，以支持项目或系统的开发。 
### 1.2 传统Java EE开发的弊端 
在早期开发中，企业通常利用JSP+Servlet技术进行开发，存在以下弊端： 
* **可维护性差**：分层不够清晰，业务逻辑无法单独分离出来，造成后期维护困难。 
* **代码重用性低**：每次开发都需要重新开发底层功能，投入大量人力物力，且容易产生漏洞。 
* 网页组成: HTML (结构) + CSS (表现) + JavaScript (行为)。 
### 1.3 框架的优势 
1. **提高开发效率**：事务处理、安全性、数据流控制等通用工作交给框架处理，开发人员专注业务逻辑。 
2. **提高代码规范性和可维护性**：成熟框架有严格代码规范，保证团队开发风格统一。 
3. **提高软件性能**：减少冗余代码。例如Spring的IOC方便解耦，MyBatis支持动态SQL简化代码。 
### 1.4 当前主流框架**及技术定位** 
* **Servlet规范**：底层标准，定义了如何接收HTTP请求，需Tomcat等容器实现。
* **Spring**：为解决企业应用程序开发复杂性而创建的开源框架，核心是分层架构与依赖注入。 
* **Spring MVC**：基于MVC设计模式实现的Web开发框架，作为控制器实现模型与视图的数据交互。**它封装了原生Servlet，提供了DispatcherServlet作为前端控制器。** 
* **MyBatis**：优秀的持久层框架，支持普通SQL查询、存储过程及高级映射，是半自动化的ORM实现。 
* **Spring Boot**：致力于简化Spring配置、提升开发体验的微框架，是未来发展的趋势。 
### 1.5 **【新增】MVC架构模式与前后端分离演进**
* **传统MVC时代**：Model(数据)、View(JSP页面)、Controller(Servlet)全部在后端。后端负责渲染HTML页面发给浏览器。
* **现代前后端分离时代**：
  * **View的剥离**：View不再由后端渲染，而是交由前端框架（如React/Vue）。前端编译生成的JS/CSS等静态文件就是最终的View。
  * **Spring Boot的角色**：退化为纯粹的API数据提供者。前端通过Ajax请求获取后端返回的JSON数据，在浏览器端自行渲染页面。
---
## 2. Spring框架基础 
### 2.1 Spring之父与设计理念 
* **创始人**：Rod Johnson（2002年著写《Expert one-on-one J2EE设计与开发》，改变了Java世界）。 
* **理念**：技术实用为本。Spring是轻量级框架，目标是使现有技术更加易用，推进编码最佳实践。 
### 2.2 为什么使用依赖注入（DI）？ 
当系统复杂到一定程度时，仅仅面向对象是不够的。依赖注入强制将**组件的构建和使用分开**。 
* **目的**：解耦合。实现每个组件块时只关注组件内部的事情。 
* **原理**：明确定义组件间的接口，在运行时由容器注入依赖，而不是在代码中硬编码创建被调用者。 
### 2.3 Spring IoC容器 
IoC（控制反转）有时候也叫DI（依赖注入）。创建被调用者实例的工作由Spring容器完成，然后注入调用者。 
#### 核心接口 
1. **BeanFactory接口**：Spring提供的基本容器，提供完整的IoC服务支持。常用方法包括 `getBean(String name)`、`containsBean(String name)` 等。 
2. **ApplicationContext接口**：建立在BeanFactory基础之上，丰富了特性（如国际化、资源访问、事件传播），并对单例Bean实行预初始化，提升性能。 
* 常用实现类：`ClassPathXmlApplicationContext`、`FileSystemXmlApplicationContext`、`AnnotationConfigApplicationContext`。 
### 2.4 Bean的配置与装配 
Spring支持XML和Properties配置文件，最常用的是XML。根元素 `<beans>` 包含 `<bean>` 子元素。 
#### `<bean>` 元素的常用属性 
* `id`：唯一标识符。 
* `name`：指定多个名称（逗号或分号隔开）。 
* `class`：指定Bean的具体实现类全路径。 
* `scope`：作用范围（singleton单例、prototype原型、request、session等）。 
#### 常用的注入方式 
1. **属性setter方法注入**：通过 `<property>` 元素调用setter方法完成赋值。 
* 基本类型：使用 `value` 属性。 
* 对象类型：使用 `ref` 属性指定其他Bean的引用。 
* 集合类型：使用 `<list>`、`<set>`、`<map>`、`<props>` 子元素标签。 
2. **构造方法注入**：通过 `<constructor-arg>` 元素注入，通过 `index` 属性指定参数位置。 
3. **注解方式注入**： 
* 组件注解：`@Component`（泛指组件）、`@Controller`（表现层）、`@Service`（业务层）、`@Repository`（数据层）。 
* 注入注解：`@Value`（基本类型）、`@Autowired`（自动注入）、`@Qualifier`（指定bean名称）、`@Resource`（JSR-250标准）。 
### 2.5 Bean的生命周期 
Bean的生命周期指Bean实例被创建、初始化和销毁的过程。 
* **singleton作用域**：Spring容器管理Bean的完整生命周期（创建、初始化、销毁）。 
* **prototype作用域**：Spring容器只负责创建Bean实例，不管理其生命周期。 
* **生命周期监控**： 
* `@PostConstruct`：监控Bean对象初始化节点。 
* `@PreDestroy`：监控Bean对象销毁节点。 
---
## 3. MyBatis框架 
### 3.1 传统JDBC的劣势 
1. 数据库连接创建、释放频繁造成系统资源浪费。 
2. SQL语句在代码中硬编码，造成代码不易维护，违反开闭原则。 
3. PreparedStatement传参存在硬编码。 
4. 结果集解析存在硬编码（查询列名）。 
### 3.2 MyBatis概述与ORM 
* **什么是MyBatis**：MyBatis是一个支持普通SQL查询、存储过程以及高级映射的持久层框架。它消除了几乎所有的JDBC代码和参数的手动设置，使用简单的XML或注解进行配置和原始映射。 
* **持久化与ORM**： 
* **持久化**：将程序数据在瞬时状态（内存）和持久状态（磁盘）之间转换的机制。 
* **ORM（对象-关系映射）**：完成对象数据到关系型数据映射的机制。MyBatis是一种半自动化的ORM实现，性能优越、简单易学。 
### 3.3 MyBatis环境搭建（三个准备） 
1. **导入JAR包**：MyBatis核心包、依赖包、数据库驱动包（或通过Maven配置坐标）。 
2. **编写实体类，配置映射文件**：创建POJO类，并在 `Mapper.xml` 文件中编写SQL语句。 
```xml 
<mapper namespace="com.itheima.mapper.CustomerMapper"> 
<select id="findCustomerById" parameterType="Integer" resultType="com.itheima.po.Customer"> 
select * from t_customer where id = #{id} 
</select> 
</mapper> 
```
3. **编写核心配置文件**：在 `mybatis-config.xml` 中配置环境、数据源和Mapper映射文件路径。 
* `environments`：配置多套运行环境（事务管理器、数据源）。 
* `mappers`：引入映射文件。 
### 3.4 MyBatis使用步骤（七个步骤） 
1. 创建 `SqlSessionFactoryBuilder`。 
2. 加载核心配置文件。 
3. 创建 `SqlSessionFactory`。 
4. 创建 `SqlSession` 对象。 
5. 使用 `SqlSession` 对象操作数据库（执行SQL）。 
6. 打印/处理结果。 
7. 关闭 `SqlSession`。 
---
## 4. **【新增】Spring MVC：Web层的核心调度框架解析**
虽然Spring Boot简化了配置，但底层依然是由Spring MVC框架处理Web请求。
### 4.1 **从Servlet到Spring MVC的演进**
* **原生Servlet的痛点**：每个请求需手动编写`doGet/doPost`，手动解析参数，手动拼接JSON，路由配置繁琐。
* **Spring MVC的解法**：提供一个核心的`DispatcherServlet`（前端控制器）拦截所有请求，通过“注解化开发”将URL直接映射到普通Java方法上。
### 4.2 **Spring MVC的核心组件（“高级预制板”）**
1. **DispatcherServlet（总包工头）**：核心总控制器，负责统一分发请求。
2. **HandlerMapping（任务分配簿）**：维护URL与`@RequestMapping`注解方法的映射关系。
3. **HandlerAdapter（全能翻译官）**：负责解析HTTP参数，自动绑定到Java方法的参数上（如将字符串ID转为Integer），并执行方法。
4. **HttpMessageConverter（数据打包机器）**：自动将方法返回的Java对象序列化为JSON响应给前端，或将前端传来的JSON反序列化为Java对象。
### 4.3 **工作流程**
用户请求 -> `DispatcherServlet` -> 查询`HandlerMapping`找到对应方法 -> `HandlerAdapter`执行方法并转换数据 -> 返回JSON/视图给前端。
--- 
## 5. Spring Boot 
### 5.1 什么是Spring Boot？ 
Spring Boot并不是用来替代Spring的解决方案，而是和Spring框架紧密结合用于提升Spring开发者体验的工具。它集成了大量常用的第三方库配置，使得这些库几乎可以是零配置的开箱即用，开发者能够更加专注于业务逻辑。 
### 5.2 为什么学习Spring Boot？ 
1. **简化编码**：通过 `spring-boot-starter-web` 等starter依赖，简化pom文件中繁琐的依赖导入。 
2. **简化配置**：摒弃繁琐的XML配置，采用Java Config方式（如 `@Configuration` 和 `@Bean`），只需一个 `application.yml` 即可完成配置。 
3. **简化部署**：内嵌Tomcat，无需在服务器上单独部署，直接打成jar包通过 `java -jar` 一键启动。 
4. **简化监控**：引入 `spring-boot-starter-actuator` 即可使用REST方式获取运行期性能参数。 
5. **发展趋势**：微服务是未来趋势，Spring Boot官方大力推荐，与Spring Cloud一脉相承。 
### 5.3 **【深化】内嵌容器与微服务多实例原理**
* **内嵌Tomcat机制**：在传统JSP时代，需外部安装Tomcat并部署war包；在Spring Boot中，Tomcat被封装为一个普通的jar包依赖。当执行`main`方法时，Java程序先启动，然后在内部`new`一个Tomcat对象并启动它。
* **打Fat Jar**：代码、依赖库、内嵌Tomcat全被打包成一个单独的`.jar`文件，实现`java -jar`一键启动。
* **微服务多实例**：启动多个Spring Boot微服务，本质就是在底层启动了多个独立的Tomcat实例。每个微服务需配置不同的`server.port`以避免冲突，从而实现微服务的物理隔离与独立部署。
* **容器替换**：若不使用Tomcat，可通过排除`spring-boot-starter-tomcat`并引入Jetty或Undertow依赖，无感替换底层容器。
### 5.4 Spring Boot核心功能实战 
* **JSON数据封装**：使用 `@RestController` 注解（组合了 `@Controller` 和 `@ResponseBody`），默认使用Jackson解析。支持统一返回结构封装（如包含 code、msg、data 的 `JsonResult`）。**在后端分离架构下，这是Spring Boot最核心的产出。** 
* **属性配置**：使用 `@Value("${key}")` 获取单个配置；使用 `@ConfigurationProperties(prefix = "prefix")` 批量获取并封装到实体类。支持多环境配置（`application-dev.yml` / `application-pro.yml`）。 
* **MVC支持**：常用注解 `@RestController`、`@RequestMapping`、`@PathVariable`、`@RequestParam`、`@RequestBody`。 
* **全局异常处理**：使用 `@ControllerAdvice` 和 `@ExceptionHandler` 拦截系统异常和自定义业务异常，返回统一的JSON结构。 
* **AOP切面处理**：通过 `@Aspect` 定义切面，使用 `@Before`、`@After`、`@AfterReturning`、`@AfterThrowing` 等注解实现日志记录、权限校验等解耦操作。 
### 5.5 Spring Boot集成MyBatis 
1. **依赖导入**：引入 `mybatis-spring-boot-starter` 和 `mysql-connector-java`。 
2. **配置**：在 `application.yml` 中配置数据源及MyBatis属性（如开启驼峰命名 `map-underscore-to-camel-case: true`）。 
3. **整合方式**： 
* **基于XML**：在Mapper接口上添加 `@Mapper` 或在启动类添加 `@MapperScan("com.xxx.dao")`，编写XML映射文件。 
* **基于注解**：使用 `@Select`、`@Insert`、`@Update`、`@Delete` 注解直接写在Mapper接口方法上，配合 `@Param` 和 `@Results` 使用。 
### 5.6 Spring Boot其他进阶特性 
* **事务管理**：使用 `@Transactional` 注解。注意：默认只回滚RuntimeException，建议指定 `rollbackFor = Exception.class`；避免在事务方法中手动吞掉异常。 
* **拦截器**：实现 `HandlerInterceptor` 接口（重写 `preHandle`、`postHandle`、`afterCompletion`），通过实现 `WebMvcConfigurer` 接口注册拦截器。 
* **模板引擎**：集成Thymeleaf，通过 `@Controller` 返回视图，使用 `th:` 标签动态渲染数据。**（注：在前后端分离主流下，此功能使用频率降低）** 
---
## 6. 课程总结与学习路径 
本课程从传统Java EE开发的痛点出发，系统讲解了三大主流框架： 
1. **底层规范**：Servlet是Java Web的地基，所有上层框架均基于此构建。
2. **Spring框架**是基石，其核心的IoC和AOP思想解决了组件耦合问题，规范了企业级开发。 
3. **MyBatis框架**作为持久层方案，灵活高效地处理了Java对象与关系型数据库之间的映射，化解了JDBC的硬编码痛点。 
4. **Spring MVC框架**是Web层的核心，通过DispatcherServlet和注解化开发，彻底封装了原生Servlet的繁琐操作。
5. **Spring Boot框架**是效率倍增器，通过“约定优于配置”和内嵌Tomcat的理念，极大地简化了Spring应用的搭建与部署。同时，它顺应了前后端分离的趋势，让后端专注提供API接口，让前端专注View渲染。
  **学习建议**：先掌握Spring的IoC容器原理，再学习MyBatis的SQL映射机制，**理解Spring MVC的请求流转过程**，最后将三者结合，通过Spring Boot实现快速的项目工程搭建与开发，逐步深入微服务生态。

