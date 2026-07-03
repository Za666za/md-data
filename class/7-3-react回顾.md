- 副作用 != `负作用`: 这里的`副`是`其他`的意思,表示除了原有逻辑还会产生其他作用如:

  - 发送网络请求
  - 修改DOM
  - 存储数据到浏览器
  - 启动定时器

- `useEffect()` 组件渲染之后进行 (函数)

  > ![1783040906857](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1783040906857.png)
  >
  > 因为会之后进行`dom`操作

  > `useEffect(,[])`监听空数组,页面加载时执行

  > ![1783041872653](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1783041872653.png)
  >
  > B

  > ![1783041937092](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1783041937092.png)
  >
  > B

  > yml
  >
  > ![1783042530656](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1783042530656.png)

> ![1783042654081](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1783042654081.png)
>
> ![1783042963880](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1783042963880.png)



![1783043140397](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1783043140397.png)

> useEffect(() => {
> setCount(count + 1);
> }, []); // 依赖项数组为空

> ![1783043489174](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1783043489174.png)
>
>

> ![1783043643534](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1783043643534.png)

> ![1783044003696](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1783044003696.png)
>
> ![1783044008484](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1783044008484.png)

```react
useEffect(() => {
  if (count >= 10) return; // 终止条件

  const timer = setTimeout(() => {
    setCount(count + 1);
  }, 1000);

  return () => clearTimeout(timer);
}, [count]); // 依赖项是 [count]
// 这个是在每次count变化时都产生一个计数器1s后+1
```

