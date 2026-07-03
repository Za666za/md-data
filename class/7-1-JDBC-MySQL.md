> ![1782871795246](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1782871795246.png)

> ![1782871964684](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1782871964684.png)

> ![1782872338438](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1782872338438.png)
>
> 多线程工具学习?

# MySQL

> 缓存查询(8后作废), 类似缓存池

> 分析器: 类似 `javac`
>
> 存储引擎: 存储数据`InnoDB / MyISAM / Memory `

> key + 地址 + 模型名称  GRM

> 长时间不使用`Mysql`连接会断开

> EXPLAIN SELECT 查看最终计划

> redo log 用于日志回滚

> `binlog` 总日志 
>
> 一个是` InnoDB `的、循环写；一个是 Server 层的、追加写