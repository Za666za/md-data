# RAG优化-agent

- 查询重写 - 召回
- 查询分解 - 精确
- HYDE - 相似

- 回答方式
  - 单次
  - 紧凑式
  - 修正式

- self-rag
  - 先判断是否需要检索
  - 评估检索后的内容有消息和支持性

- langchain
  - model
  - prompt
  - index
  - memory
  - chain: 核心将prompt输入model的确定过程
  - agent: 
    - re-act: 边思考边执行
    - self-ask: 分解任务
    - 参数
      - model
      - tools:
        - 描述准确description
      - agent-type: 问题模式-代理类型（如`zero-shot-react`）
    - 垂直工具实例:
      - say-can 结合机器人
      - WebGPT  网页
      - ACT-1 excel
    - 特征
      - 自治
      - 学习
      - 通信: 人/智能体
      - 目标向导
    - 擅长调用工具的模型
      - gorilla: shell 写
      - toolformer: 擅长网页api
    - 多agent:
      - MetaGPT: 使用标准化流程(SOP)组织实现
        - PM,PRD 产品经理, 产品需求文档
      - ChatDev: 使用瀑布模型, 中间传递代码
        - 快捷开发
        - 共享记忆
        - 个体独立
        - 包含自省机制
  - 百宝箱平台
    - 更支持支付宝
  - RAG
    - 切片:
      - 固定长度
      - 根据段落,标记
      - 模型判断语言
      - 滑动窗口
      - 混合先粗切,后嵌入式模型判断再微调
    - 检索策略中余弦计算时值在[-1, 1] 之间, 接近1命中高
      - 名词: 
        - 精排: 对检索结果重打分用于过滤
    - 知识库
      - ai不主动调用可能是由于预训练知识库已具备知识,但实际不对
    - 工作流:
      - 槽位判断: 根据关键字选分支
      - 意图识别, 根据语言选择
      - 节点传参: {{节点名.output.参数名}}
      - 卡片生成属于消息， ai编辑可插入html
      - 代码接收上一个json的键，获得值
      - metaGPT ： 通过_watch订阅式传递消息，多智能体协助

- 网页启动

  - npm run start

- java 编译

  - maven clean package

# TS

- 函数语法： function a(){}

- 对象语法： b = {a:"a",b:1}, 此处直接赋予值

- 类语法：无逗号分隔， ： 后是值

  ```
  class a{
      name : string
      age : string
      name2 : string
      age2 : string
      constructor(name:string, age:string){
          this.name = name
          this.age = age
          this.name2 = name
          this.age2 = age
      }
  }
  ```

  - 使用implements 实现 type 或 interface

  - interface 通过extends 扩展原接口

  - type 通过 新type = type1 & type2 合并

  - type类型一般首字母大写

  - type 可联合基类 

    ```
    type i  = string | number
    var j : i = '1'
    ```

  - type约束函数

    ```
    type k = {
        (a:string):void
    }
    
    var say : k = function(a){
        console.log(a)
    }
    say("1")
    
    // 或
    type k =  (a:string)=>void
    ```

    ```
    // 差异
    type FnWithProp = {
        (a: string): void;         // 定义怎么调用
        count: number;             // 定义函数上的属性
    };
    
    // 使用
    const myFn: FnWithProp = ((a: string) => {}) as FnWithProp;
    ```

  - 接口模版可约束类和对象

    ```
    type k = {
        name : string,
        age : string
    }
    
    var persion : k ={
        name:'',
        age:''
    }
    ```

- 对象中方法： {a: function(){}}
  - 简写： {a(){}}
  - 箭头函数
    - {a: ()=>{}}, 它的this指向调用时上下文， 没有自己的this使用父类的this
    - 对象中方法this指向对象

- 变量语法： 

  - 变量要先声明，如const a

  - 类型中 boolen 小写 ， true

  - 有 null 和 undefined 均表示缺少值， null是主动赋予, undefined 是变量未赋值,由系统默认定义

  - 声明类型：

    - ```
      var a: number
      # 声明并赋值
      var a:number = 2
      ```

    - 数组类型

      - ```
        any[]
        # 或
        Array<any>
        ```

    - 元组类型

      - ```
        ['string']
        ```

- 函数使用

  - for循环中使用；隔开

  ```
  // 不定参数
  // var a = (a1:number, a2?:number):number=>{
  //     return a1 + (a2||0)
  // }
  
  // 默认参数
  // var a = (a1:number, a2:number = 3):number=>{
  //     return a1 + a2
  // }
  // 可变参
  var a = (a1:number, ...an: number[]):number=>{
      var num:number = a1
      for (var i:number = 0; i < an.length; i++){
          num += an[i]
      }
      return num 
  }
  console.log(a(1,2))
  ```

  多个输出，分隔

  ```
  console.log(1,2)
  ```

  不定参数和可变参数放最后，同时存在时可变参数覆盖不定参数



- 联合类似使用 | ， 交叉类型使用&，分别如 

  - string|number
  - type a = type1 & type2

- 泛型， <T>写在 函数名后

  ```
  function fun<T>(a1:T):T{
      return a1
  }
  fun<string>("1")
  var value1 : <T>(arg:T) => T = fun
  // value1 : <T>(arg:T) 表示类型是这个
  value1<number>(1)
  ```

  - 具体将泛型定义为类型, 

    - 使用 type 或interface的对函数的限制方式实现， 注意<T>位置不同， 使用时不同

    ```
    function fun<T>(a1:T):T{
        return a1
    }
    
    interface fun2 {
        <T>(a:T):T
    }
    
    
    var value2 : fun2 = fun
    // <>
    value2<string>('i')
    
    
    
    // type fun3<T> = {
    //     (a:T):T
    // }
    
    // <>
    type fun3<T> = (a:T)=>T
    
    
    var value3 : fun3<string> = fun
    value3('i')
    
    
    // 示例
    
    function f<T extends string|number>(a: T, b: T) {
        if (typeof a === 'string') {
            return a + ':' + b; // no error but b can be number!
        } else  {
            return (a as number) + (b as number); // error as b can be number | string
        } 
    }
    ```

    - 使用extends 可以使得T具有扩展性， 包含必须属性

      ```
      interface fun2 {
          length: number
      }
      
      function a<T extends fun2>(b:T):T{
          return b
      }
      
      a('h')
      ```

      - 需要被扩展的类型或对象的使用用interface更清晰
      - 可将结果as 为对应类型结束报错

  - 对象键值

    - 对象的键无论你是否加引号，它本质上都是**字符串**。

    - keyof 得到 type 的键, 要用type接收

    - typeof 得到 对象的type, 要用type接收

    - key in 只在{}内遍历 key

      ```
      type str1 = {
          name : string
          age : number
      } 
      
      type a = keyof str1 // "name"||"age"
      var b : a
      b = 'name'
      
      var l : str1 = {
          name: 'za',
          age: 1
      }
      
      type c = typeof l
      
      type d = keyof c
      
      // var type1 : string  
      // 模版的模版
      type typecase<T> = {
          [key in keyof T]: number
      }
      var typecase1 : typecase<str1> = {
          name:1,
          age:2
      }
      
      ```

  - 根据泛型选择模版

    - <>内部使用{}时定义的是type模版而非对象

    ```
    // 演示泛型条件选择
    interface Father{
        boolen: "XY"
    }
    
    interface Mother{
        boolen:"XX"
    }
    
    interface Son{
        boolen: "XY",
        names : string
    }
    
    type next<T> = T extends Father ? Son  : Mother;
    
    
    var son1 : next<Father> = {
        boolen: "XY",
        names : "ls"
    }
    
    ```

    - 联合条件情况

      ```
      // 处理联合类型的分布式特性
      // 当条件类型的检查类型是联合类型时，会分别应用到每个成员
      // (A | B) extends U ? X : Y 等价于 (A extends U ? X : Y) | (B extends U ? X : Y)
      type DistributedCheck<T> = T extends string ? 'is-string' : 'not-string';
      
      // 对联合类型进行条件判断
      // 'a' | 'b' | number -> 'is-string' | 'is-string' | 'not-string' -> 'is-string' | 'not-string'
      type ResultOfUnion = DistributedCheck<'a' | 'b' | number>; 
      ```

  - extends+ infer ? :  , 提取type内部类型

    ```
    // 演示infer将具体化的泛型模版， 中的参数提取出来
    // 提取泛型为类型
    
    // 提取type声明处位置
    type fruit<T> = {
        name:T
    }
    
    type fetch<T> = T extends fruit<infer R> ? R : boolean;
    
    var apple : fetch<fruit<"apple">> = "apple"
    var el : fetch<string> = false
    console.log(apple)
    
    // 提取type对应键位置
    type fruitn<T> = {
        name:string
    }
    
    type fetch_n<T> = T extends {name : infer R} ? R : boolean;
    
    var applen : fetch_n<fruitn<"apple">> = "apple1"
    var apple2n : fetch_n<string> = false
    console.log(applen)
    ```

    - extends infer函数格式 参数param只做占位， 

      - ...args: any[]  表任意数量， 类型数组内元素类型任意

        ```
        // 提取函数对应位置参数
        // 使用 infer 提取函数参数类型
        // infer P 在条件类型的 extends 右侧捕获参数类型
        type GetParameterType<T> = T extends (param : infer R) => any ? R : never;
        
        function exampleFunction(num : number):string{
            return num.toString()
        }
        
        
        // 从函数类型中提取参数类型
        type Type_of_fun = GetParameterType<typeof exampleFunction>
        
        // 提取函数返回值类型（类似内置的 ReturnType）
        type MyReturnType<T> = T extends (...args: any[]) => infer P ? P : never;
        
        
        const funcWithReturn = (x: number, y: string): boolean => x > 0 && y.length > 5;
        type ExtractedReturnType = MyReturnType<typeof funcWithReturn>; // boolean
        
        
        
        ```

    - 得到数组类型内部元素 

      - 数组写法 : `number[]` `Array<number>`

      ```
      var aa :number[] = [1,2,3]
      var bb:Array<number> = [1,2,3]
      
      type cc<T> = T extends (infer R)[]? R:never
      
      var dd :cc<number[]> = 2
      ```

    - 解析构造函数内部类型

      ```
      // 解析构造函数参数类型
      type ConstructorParameter<T> = T extends new(...args:infer P) => any ? P: never;
      class ExampleClass{
          constructor(public id:number,public name:string){}
      }
      
      type CtorParams = ConstructorParameter<typeof ExampleClass>; // [number, string]
      var a : CtorParams = [1,'1']
      
      // 当你加上 public 关键字时，TypeScript 编译器在底层会自动帮你（声明属性 + this.xxx = xxx 赋值）
      ```

    - 嵌套实现判断数组和内部对象类型`{}`

      ```
      // 嵌套条件类型实现复杂的类型操作
      type DeepConditional<T> = T extends any[]
        ? T extends (infer U)[]
          ? U extends object
            ? 'object-array'
            : 'primitive-array'
          : 'not-array'
        : 'not-array';
      
      // 测试不同类型
      const primitiveArray: DeepConditional<number[]> = 'primitive-array';
      const objectArray: DeepConditional<{a: number}[]> = 'object-array';
      const notArray: DeepConditional<string> = 'not-array';
      ```

    - 检查返回promise异步对象

      ```
      // 提取函数返回值类型（类似内置的 ReturnType）
      type MyReturnType<T> = T extends (...args: any[]) => infer R ? R : never;
      // 实际应用场景：类型安全的函数包装器
      type SafeWrapper<T extends (...args: any[]) => any> = 
        (...args: Parameters<T>) => Promise<MyReturnType<T>>;
      
      function asyncWrapper<F extends (...args: any[]) => any>(func: F): SafeWrapper<F> {
        return async (...args: Parameters<F>): Promise<MyReturnType<F>> => {
          try {
            const result = await func(...args);
            return result;
          } catch (error) {
            console.error('Error in wrapped function:', error);
            throw error;
          }
        };
      }
      
      // 使用包装器
      const originalFunc = (x: number, y: string): boolean => x > 0 && y.length > 0;
      const wrappedFunc = asyncWrapper(originalFunc);
      // wrappedFunc 的类型为 (x: number, y: string) => Promise<boolean>
      
      console.log('所有类型检查通过！');
      ```

    - 涉及异步`promise`场景

      - promise.resolve() 异步允诺 + await解包(处理异常) 

        ```
        function fetchUserData(userId: number): Promise<User> {
          return Promise.resolve({
            id: userId,
            name: 'Fetched User',
            email: 'fetched@example.com',
          });
        }
        
        // 使用 ReturnType 获取 fetchUserData 的返回值类型
        // 这样即使函数返回类型改变，这里的类型也会自动更新
        type FetchedUser = ReturnType<typeof fetchUserData>;
        
        // 实际应用：处理 API 响应
        async function handleUserResponse(): Promise<void> {
          try {
            const response: Awaited<FetchedUser> = await fetchUserData(1); // 使用 Awaited 解包 Promise
            console.log('获取到的用户数据:', response.name, response.email);
          } catch (error) {
            console.error('获取用户数据失败:', error);
          }
        }
        
        // 实际调用
        handleUserResponse();
        ```

      - 多种typeg工具: Partial Required Omit(省略) 

        ```
        // 综合示例：结合多种工具类型
        
        // 原始配置类型
        type AppConfig = {
          apiUrl: string;
          timeout: number;
          debugMode: boolean;
          version: string;
        };
        
        // 创建可选配置类型（用于部分更新）
        type OptionalConfig = Partial<AppConfig>;
        
        // 创建必需配置类型（用于验证）
        type RequiredConfig = Required<Omit<AppConfig, 'debugMode'>> & { debugMode?: boolean };
        
        
        // 配置更新函数
        function updateAppConfig(configUpdates: OptionalConfig): RequiredConfig {
          // 模拟配置更新逻辑
          const defaultConfig: RequiredConfig = {
            apiUrl: 'https://api.example.com',
            timeout: 5000,
            version: '1.0.0',
            debugMode: false,
          };
          
          return { ...defaultConfig, ...configUpdates };
        }
        
        // 使用示例
        const updatedConfig = updateAppConfig({ timeout: 10000, debugMode: true });
        console.log('更新后的配置:', updatedConfig);
        ```

        - Record  联结键

        - Pick 联结值

          ```
          // 3. Record<K, T> - 创建键值对映射类型
          // 用途：定义具有特定键类型的对象
          
          type UserRole = 'admin' | 'user' | 'guest';
          
          type UserPermissions = Record<UserRole, boolean>;
          
          const permissions: UserPermissions = {
            admin: true,
            user: false,
            guest: false,
          };
          
          // 动态角色权限检查
          const checkPermission = (role: UserRole): boolean => {
            return permissions[role];
          };
          console.log('Admin permission:', checkPermission('admin'));
          
          // 4. Pick<T, K> - 从类型 T 中挑选指定的属性 K
          // 用途：创建包含原类型子集的新类型
          type UserProfile = Pick<User, 'name' | 'email'>; // 只保留 name 和 email
          
          const userProfile: UserProfile = {
            name: 'John Doe',
            email: 'john@example.com',
            // age: 30, // 错误：age 不在 UserProfile 类型中
          };
          ```

## TS配置

> 以下关于 tsconfig.json 中 compilerOptions 配置项的说法，哪些是正确的？
>
> target 设置为 'es5' 时，TypeScript 编译器会将箭头函数转换为传统的 function 表达式以保证兼容性
>
> removeComments 设为 true 时，不仅移除源文件中的注释，还会删除 JSDoc 注释

## TS习题

```
// 通用一类型
function f<T extends string|number>(a: T, b: T) {
    if (typeof a === 'string') {
        return a + ':' + b; // no error but b can be number!
    } else  {
        return (a as number) + (b as number); // error as b can be number | string
    } 
}


//

type Foo = {
    a: number;
    b: string;
    c: boolean;
}

type Mutable<T, Keys extends keyof T = keyof T> = {
  // 第二部分：处理差集 (Exclude T 中的 Keys，保持原样)
  // 这里使用了 Exclude 来筛选出不需要修改的属性
   readonly [P in Exclude<keyof T,Keys>]: T[P];
}&{
  // 第一部分：处理 Keys (变成可变)
   -readonly [P in Keys]: T[P];
} 
// type Mutable<T, Keys extends keyof T = keyof T> = {
//   // 第一部分：处理 Keys (加上 readonly)
//   +readonly [P in Keys]: T[P];
// } & {
//   // 第二部分：处理差集 (保持原样，即非 readonly)
//   [P in Exclude<keyof T, Keys>]: T[P];
// };

const test: Mutable<Foo, 'a'> = { a: 1, b: '2', c: true };

test.a = 10; // ✅ 可变 (来自第一部分)
test.b = 'hello'; // ❌ 仍然是 readonly (来自第二部分，原样保留)

// pickle
interface Todo {
title:string
description:string
completed:boolean
}
type MyPick<T, K extends keyof T> = { [P in K]: T[P]; }

type TodoPreview = MyPick<Todo, 'title'|'completed'>
const todo: TodoPreview = {
title:'clean room',
completed: false,
}


// 递归

//实现一个泛型 DeepReadonly<T>，它将对象的每个参数及其子对象递归地设为只读。
//您可以假设在此挑战中我们仅处理对象。不考虑数组、函数、类等。但是，您仍然可以通过覆盖尽可能多的不同案例来挑战自己。例如:
type X = {
    x: {

        a: 1

        b: 'hi!'

    }
    y:'hey'
}
type Expected = {
    readonly x: {
        readonly a: 1
        readonly b: 'hi'
    }
    readonly y: 'hey'
}
type DeepReadonly<T> = {
    readonly  [k in keyof T]:T[k] extends object?
    DeepReadonly<T[k]>:T[k]
};

type Todo = DeepReadonly<X> // should be same as Expected'
// type Todo2 = 
var a : Todo = {
    
    x: {

        a: 1,

        b: 'hi!'

    },
    y:'hey'
}
// a.x.a =
```

- 总结

- > 函数参数类型一致使用fun<T>()约束
  >
  > 访问修饰符readonly 可使用 -readonly 去除, 有&无 得到无 是从readonly里做减法
  >
  > [P in typeof T]:T[P] 的T[P] 可以得到属性
  >
  > T[P] 作为属性可进一步 extends
  >
  >  `&` 会取read+write
  >
  > Exclude<keyof T,keys> 得到keyof T 和keys的差集 但使用 [k in Exclude<keyof T,keys>] 时默认是没readonly的