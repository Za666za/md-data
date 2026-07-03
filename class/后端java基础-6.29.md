# Java

> 编译后JVM运行

> JRE = JVM +库; 运行环境

> JDK = JRE+ 编译 + 调试

> final int ; final修饰常量

> `/` :整数相除 得到整数,小数部分直接截掉;  浮点数相除得到结果有小数
>
> `|| ` `&&` 存在短路后面
>
> `switch` 通过`break` 跳出后面判断

>`do{} while:`

> 同名方法 -> 重载;   返回值不可设定不同

## 规范

> 包名: 小写
>
> 关键逻辑写注释

> 输入 `new Scanner(System.in)`

# 面向对象

> throw new Exception()

> 继承: `extends`

> `abstract: is -a`; `interfact: 能力`

> `extends Exception` : 自定义异常

> 多态: 使用父类调用子类重写方法

> 异常捕获:`try catch`

# string

> StringBuffer: 可变 多线程 安全
>
> StringBuilder: 单线程 拼接
>
> Sting: 不可变

# 包装类

> Byte-byte 
>
> 包装类是对象可放入 List

# 日期时间

> LocalData/LocalDataTime : 安全

# 集合 List,Set,Map

> add(e);  remove(idx); `list` : set(idx,e); `map`: put(idx,"")
>
>

> currentHashMap

# IO流

> inputStream
>
> 持久化

# 进阶

## 多线程

> extends Thread

> `implements Runnable` 推荐, 灵活
>
> new Thread(new MyT()).start() 

> Thread.getCuttent... 得到当前线程

> synchronized(){} 锁
>
> 可重入锁?
>
> 无锁原子
>
> 线程安全

## Lambde

> a = () -> {}

## Stream API : 流式

> map 转换
>
> ditinct 去重
>
> a::get() 掉方法

## 反射

> 使用class 反射获得

## 注解

> `@` 标识
>
> 本质: 自定义注解+反射 

## 成绩管理系统

 stream?

>  ORM: 自定义注解+反射 ?

# 练习

> int a,b = 1
>
> 只有b=1
>
> ![1782720184159](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1782720184159.png)



> BigDecimal ?

> int [] b = ; 指针

> 接口里的变量默认是常量

> 父不调子

> 子类属性不重载父类, 调用时看左边 Amimal a = Dog b里的Animal



mybits_plus 黑马?

spring Cloud 微服务?

# 题

- 1 

  - ![1782722033478](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1782722033478.png)
  - ![1782722225253](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1782722225253.png)

- 2

  - javac: 语法检查, 转换字节码, 升级文件
  - java: 启动JVM, 加载类,校验,运行main方法
  - java 后是类名
  - class 字节码通用, 各平台有自己JVM运行

- 3

  - ![1782722594248](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1782722594248.png)
  - JVM 执行代码
  - JRE = JVM +库; 运行环境
  - JDK = JRE+ 编译 + 调试
  - `3`需要JRE: 执行+ 类库

- 4

  - ![1782722951508](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1782722951508.png)

  - ![1782723017839](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1782723017839.png)

  - ```
    javac PlatformCheck.java
    java PlatformCheck    
    ```

  - `2`JVM是翻译官, 使得class 各平台可以用

  - `3` .class: 二级制, 平台无关,在机器和源码之间,可反编译为源码

- 5

  - `1`编译无输出; 运行输出`Hello World`
  - `2` : `+` 起字符串拼接作用
  - `3`:`.class`在java文件同级目录
  - `4` 用`java Test` 命令运行

- 6

  - ![1782723694582](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1782723694582.png)

- 7

  - ![1782723820295](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1782723820295.png)

- 8

  - ![1782724183494](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1782724183494.png)

- 36 内部类与使用

  - 成员内部类: 变量都可用
    - 实例化: `Outer.Inner in = out.new Inner()`
  - 静态内部类: 只能调用静态变量; 
    - 实例化: `Outer.StaticInner in = new Out.StaticInner()`
  - 局部内部类:  函数内调用类
  - 匿名内部类: new 接口(){ @Override 重写方法}

- 37 Object类方法

  - hashCode() 和 equals 返回值要相同; 基于相同判断标准
  - 在hashset, 根据hash划分不同元素所属块,根据equals决定是否同一个
  - hashCode(){`Object.hash(name, age)`}
  - return p.age == age && Object.equals(name, p.name)