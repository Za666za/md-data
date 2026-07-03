# react

> 声明式: 直接在组件声明
>
> 命令式: 给属性赋值
>
> `npm create vite@latest my-react-app -- --template react-ts`

## 对比其他

> vue 渐进式框架, 框架
>
> react 视图库, JSX

> 使用react原因: 
>
> 1. hooks 管理状态简单
>
> 2. 可同时做手机和网页
> 3. 丰富成熟

## 介绍

> node_modules 组件位置

![1782783366157](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1782783366157.png)

> ![1782783423312](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1782783423312.png)
>
> ![1782783444391](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1782783444391.png)
>
> ![1782783522130](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1782783522130.png) 
>
>  ![1782783601434](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1782783601434.png)
>
> 子要在上
>
> ```
> function Button({age}){}
> function App(){
>     return <Button age=""><button/>
> }
> ```
>
> 子组件通知父组件
>
> ![1782784168804](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1782784168804.png)
>
> 1
>
> 1
>
> ![1782784234645](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1782784234645.png)
>
> 1
>
> ![1782784251425](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1782784251425.png)
>
> ![1782789502940](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1782789502940.png)
>
> 这是新值依赖旧值
>
> ![1782789565912](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1782789565912.png)
>
> 应该使用[] 或{} 创建权限数组或对象再 set相关()

> ![1782789749527](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1782789749527.png)
>
> 依次定义内部新的
>
> ![1782790136124](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1782790136124.png)
>
> 取值获取值即可
>
>
>
> ![1782790248462](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1782790248462.png)



> 受控组件: 根据事件获取组件的值
>
> 节流: 均匀取
>
> 防抖: 取最后一次
>
> 事件频繁触发导致性能下降

> ![1782790586451](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1782790586451.png)
>
> li 设置 key

> 根据idx时, idx不消失, 值就不会改

> 不允许中文做key 可能有编码问题
>
> 若id不唯一,拼接得到唯一
>
> 时间戳有时间问题, 时间差会过小

