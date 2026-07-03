> ![1782800019524](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1782800019524.png)

> 堆在内存 new时
>
> 栈: 方法

> ![1782800923543](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1782800923543.png)

> ![1782801400562](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1782801400562.png)

> new Thread(new MyTask()).start()

> ```
> /**
>  *模拟多线程售票问题*/
> class TicketWindow implements Runnable {
>     private int ticket = 100;
>     @Override
>     public void run(){
>         while (ticket > 0){
>             try { Thread.sleep(10);}
>             catch (InterruptedException e){}//×存在问题：不是原子操作
> 
>             System.out.println(Thread.currentThread().getName() +"售出第"+ticket+"张票");
>             ticket--;//读-改-写，可能丢失
>              }
>     }
> 
> 
> }
> 
> public class MyDemo {
>     public static void main(String[] args) {
>         TicketWindow window = new TicketWindow();
>         new Thread(window,"窗口1").start();
>         new Thread(window,"窗口2").start();
>         new Thread(window,"窗口3").start();
> 
>     }
> }
> 
> ```
>
>

> ![1782802238513](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1782802238513.png)

> ![1782802260022](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1782802260022.png)
>
> ![1782802267911](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1782802267911.png)

> ![1782803308294](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1782803308294.png)
>
>

> ![1782802302067](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1782802302067.png)

> lock.lock()
>
> lock.unlock()   // 写finally里

> ![1782805354662](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1782805354662.png)

> 线程池减少开销
>
> ![1782805562296](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1782805562296.png)
>
> ![1782805592880](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1782805592880.png)
>
> ![1782805611277](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1782805611277.png)
>
> 空闲时间太长会关掉
>
> 总 - 最大线程数 = 给任务队列的
>
> ![1782805766409](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1782805766409.png)
>
> 先进先出

> ![1782805887886](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1782805887886.png)

> CyclicBarrier在有三个线程调用时才启动, 调用await()次数够了就开始
>
> ![1782806115461](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1782806115461.png)
>
> ![1782806191801](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1782806191801.png)
>
> ![1782806262093](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1782806262093.png)

> 线程安全单例 和 volatile (更改立即可见)关键字

> ![1782806437107](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1782806437107.png)
>
> 饿汉式

> ![1782806822131](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1782806822131.png)
>
>

![1782806972903](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1782806972903.png)

> ![1782807271845](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1782807271845.png)
>
> ![1782807812839](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1782807812839.png)
>
> s![1782807994586](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1782807994586.png)

![1782808087804](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1782808087804.png)

![1782808168175](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1782808168175.png)

就绪态