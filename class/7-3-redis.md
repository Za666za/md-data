# Redis

- 单线程模型

- ![1783066482379](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1783066482379.png)

- 父类处问题子顶替

- ![1783066571435](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1783066571435.png)

- ![1783066610318](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1783066610318.png)

- ![1783066626314](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1783066626314.png)

- 有序: 下标查询

- ![1783066700036](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1783066700036.png)

- ![1783066745924](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1783066745924.png)

- > ![1783066784876](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1783066784876.png)
  >
  > 类似map

  > ![1783066816963](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1783066816963.png)

  > ![1783066867488](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1783066867488.png)
  >
  > S : set; + 操作

  > ![1783066977744](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1783066977744.png)

  > ![1783067018729](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1783067018729.png)

  > ![1783067049125](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1783067049125.png)
  >
  > RDB: 单位 : `s`
  >
  > pop ...阻塞
  >
  > ...不阻碍进程
  >
  > ...save 不使用大的

  > ![1783067235840](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1783067235840.png)

  > ![1783067262025](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1783067262025.png)
  >
  > ![1783067275379](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1783067275379.png)

  > ![1783067324642](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1783067324642.png)
  >
  > get
  >
  > del
  >
  > 互删情况...

> ![1783067440220](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1783067440220.png)

> ![1783067452354](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1783067452354.png)

> ![1783067508912](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1783067508912.png)

> ![1783067567466](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1783067567466.png)
>
> **把 Session 数据从内存中拿出来，放到一个所有服务都能访问的地方——Redis。**

> ![1783067652775](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1783067652775.png)
>
> **if ("NULL".equals(cached))**：这是一个非常关键的**防穿透**设计。如果缓存里存的是字符串 `"NULL"`，说明之前查询过这个商品，但数据库里没有（即商品不存在）。直接返回 `null`，避免再次查询数据库

> ![1783067751524](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1783067751524.png)

> ![1783067819822](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1783067819822.png)

> ![1783067829536](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1783067829536.png)

> ![1783067893028](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1783067893028.png)
>
> 想象一下，你的 Redis 服务器内存是有限的（比如 8GB）。如果你把所有数据都设置为永久，那么：
>
> 1. **内存无法回收**：即使这些数据很久没人用了，它们也会一直占用内存，无法被释放。
> 2. **内存耗尽**：当永久 key 占满 Redis 内存后，你再想存入新的数据（即使是临时的），就会失败，因为 Redis 会报 `OOM (Out Of Memory)` 错误。
> 3. **性能下降**：Redis 需要维护大量无用的数据，会增加内存管理和查找的开销

> ![1783067990650](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1783067990650.png)

# MQ

- 先进先出

- ![1783068099370](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1783068099370.png)

  > ![1783068120775](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1783068120775.png)
  >
  > 发布订阅
  >
  > 路由
  >
  > Topic

  > ![1783068359466](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1783068359466.png)
  >
  > ![1783068377055](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1783068377055.png)

  > ![1783068440992](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1783068440992.png)

  > ![1783068451133](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1783068451133.png)
  >
  > Kafka吞吐大
  >
  >

  > ![1783068517819](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1783068517819.png)

> ![1783068563646](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1783068563646.png)
>
> 异步: 先必要`注册步骤`,后`消息队列`异步其余功能
>
> 订单: 下单,库存扣减,扣积分,`创建订单`,其余队列执行
>
> QPS(查询每秒)过大,放入队列

> ![1783068963125](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1783068963125.png)
>
> 实时同步压力大,异步MQ(消息队列)来缓解

> ![1783069060132](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1783069060132.png)
>
> 绑定到交换机到...

> ![1783069085255](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1783069085255.png)
>
> 注意`#`含义

> rocketMQ事务
>
> ![1783069179522](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1783069179522.png)
>
> sendMessageInTransaction

> ![1783069259870](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1783069259870.png)
>
> 注意回滚

> kafka![1783069301712](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1783069301712.png)

> 死信队列(死去的消息):
>
> 10个订单30min过期, 等待...,
>
> 过期时候,
>
> 队列管理`死信队列`,设置错峰的消息处理方式处理消息

> ![1783069576924](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1783069576924.png)

> ### 设计思路：
>
> 1. **消息大小限制**：RocketMQ对单条消息有1MB的容量限制
>
> 2. 大文件解决方案
>
>    ：
>
>    - 将大文件存储到对象存储服务（OSS）
>    - 消息中只传递文件的URL链接
>    - 消费者通过URL获取实际文件内容

> ![1783070059667](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1783070059667.png)
>
> Canal监控