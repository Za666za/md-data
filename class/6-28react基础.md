# react

> 一个UI的JS库

> 状态管理
>
> UI任意时间点都可追踪本身及状态
>
> 通过划分组件集合实现

> 状态:组件的私有变量,当变化时,组件重新渲染
>
> 页面实现动态更新

> 快速开始
>
> 你不需要把它们下载到电脑里，只需要在你的 HTML 文件里加上网上的地址即可。这就叫“使用 CDN”

- 引入react库

```
<!-- 1. 引入 React 核心库 -->
<script crossorigin src="https://unpkg.com/react@18/umd/react.development.js"></script>
<!-- 2. 引入 React DOM -->
<script crossorigin src="https://unpkg.com/react-dom@18/umd/react-dom.development.js"></script>
<!-- 3. 引入 Babel 编译器 -->
<script src="https://unpkg.com/@babel/standalone/babel.min.js"></script>
```

```
<!-- 1. 引入 React 核心库 -->
<script crossorigin src="https://cdn.staticfile.net/react/18.2.0/umd/react.development.js"></script>
<!-- 2. 引入 React DOM -->
<script crossorigin src="https://cdn.staticfile.net/react-dom/18.2.0/umd/react-dom.development.js"></script>
<!-- 3. 引入 Babel 编译器 -->
<script src="https://cdn.staticfile.net/babel-standalone/7.23.8/babel.js"></script>
```

- 通过create-react-app 脚手架开始

  > npm 下载 create-react-app
  >
  > 使用create-react-app创建项目
  >
  > App.js进入

- css 扩展

  `<link rel="", href="">` 

  > style 引入
  >
  > rel = "stylesheet" 做样式用
  >
  > rel = "icon" 做图标用
  >
  > rel = "preload" 预加载

## 基础语法 JSX

> 是js扩展运行在js中写类似html结构
>
> 最终被react解析为`React.creatElememt()`调用创建虚拟`DOM`结点
>
> 内部可嵌入`js`表达式, `{}`包裹
>
> 通过内存消耗, react可以实现更精准的改变调整,快在效率

> 编译后等价于: `React.createElement(tag, props, children)`
> 创建虚拟DOM
>
> 参1: 标签名 如"h1"
>
> 参2: 属性对象,可是表单属性, 可为null
>
> 后续参数: 子节点

- 基础示例

  ```react
      <div id="root"></div>
      <script type="text/babel">
          const title = <h1 style={{color:"red"}}>Hello, React!</h1>;
  	
          ReactDOM.render(title, document.getElementById("root"));
      </script>
  // text/babel表示jsx语法
  //{{color:"red"}} 中{}表示js代码, 里面{}表示js对象
  //ReactDOM.render(a,)将虚拟结点绘制到目标位置
  ```

  ```react
  import ReactDOM from 'react-dom/client';
  const title = <h1 style={{color:"red"}}>Hello, React!</h1>;
  // 1. 创建一个根节点容器
  const root = ReactDOM.createRoot(document.getElementById("root"));
  // 2. 调用 root.render 方法把内容画上去, 此处title是元素
  root.render(title);
  // 3. 若 title是JS函数 =()=>{} 使用<title/> 会编译为元素
  // React.createElement(StyleDeclarationDemo)
  // root.render(<title/>);
  ```

  > 在 JavaScript 中，通过 `const` 声明的变量**不会被提升到作用域顶部进行初始化**。代码执行是严格按照从上到下的顺序进行的。

  ` root.render()`放对应元素声明后

- 样式声明规范

  > `class->className` `style={{kay:value}}` 值可以是数字或字符串  

- 扩展: ES5, ES6 对比

  > 它们是JS语言的核心标准
  >
  > ES6在ES5基础上增添了箭头函数, 类语法,模块化,Promise

  - js中单引号和双引号不可换行,反引号可以也叫模版字符串

- `{}` 使用:

  > 内部必须有返回值使用示例:
  >
  > `{isTrue? True: False}` `{fun()}`  
  >
  > `{items.map(item => <li>item</li>)}` 
  >
  > 而使用`for` `let a` 等无返回值,不可以

## react组件

>  组件函数

- function app(){} 

  - useState() 得到状态只能在组件函数内使用

  - ```
     <div>
                        <h1>{num}</h1>
                        <button onClick={() => { setNum(num + 1) }}>点击</button>
               </div>
    ```

  - 对可动态渲染的元素要用组件函数返回

  - 使用时通过root.render(<函数组件名/>)产生

- 默认参数 props 对象 单向传递, 如需更改使用回调函数通知父组件

## react hooks

## react 路由



