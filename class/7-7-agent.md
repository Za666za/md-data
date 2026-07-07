# Agent

- 阿里`APC is a very` 模型向量化课程
  - 链接:  [aliyun_acp_learning/大模型ACP认证教程/C2_构造问答系统-代码预览-aliyun_acp_learning:基于阿里云大模型的ACP认证学习项目 - AtomGit](https://atomgit.com/alibabaclouddocs/aliyun_acp_learning/tree/main/%E5%A4%A7%E6%A8%A1%E5%9E%8BACP%E8%AE%A4%E8%AF%81%E6%95%99%E7%A8%8B/C2_%E6%9E%84%E9%80%A0%E9%97%AE%E7%AD%94%E7%B3%BB%E7%BB%9F)
- **ACP (Agent Communication Protocol)协议**：是**智能体间协作的通信标准**，是Agent技术生态发展的基础设施，解决了“Agent之间如何对话”的问题。
- Temperature [0-1]数值大时, 模型输出概率范围更跳脱, 将整体的词汇概率打平了一些
- top_p 候选结果累计概率范围
- top_k 输出结果前`k`条数
- token :词汇单位, 通过生成token数计费
- 上下文窗口,`context`是模型一次可以`看到`的信息容量
  - `看到` != `记忆` 因此我们仍然需要筛选历史知识成为`记忆`
  - `记忆工程`
- `Prompt` : 提示词, 给出充分的背景及期望结果
  - 通过模型输出依赖`上下文资料`,`RAG知识库`可减少模型编造
  - `few-show`:即少量示例,让ai模仿
  - 复杂任务常常需要分成小步,技术有`思维链,思维树...`
- 百宝箱地址: https://b.tbox.cn/ 
- ReACT (Reason + ACT): 思考,需要依赖外部 -> 调用外部工具
- `Self-check` ai生成后自检,如调用一些工具检验自己生成代码是否丢失了部分规范如`<>`未闭合等
- RAG(Retrieval-Augmented Generation,检索增强生成) - 类似搜索引擎, 不过是通过`数学上的向量概念`来进行相似计算
  - 可以深度集成到agent中
  - 切片
    - 固定token大小切
    - 按句子,标题,段落
    - 滑动窗口,保留上文部分
    - 按语义切(较复杂)
- 通过提示词编辑约束:在模型不确定时提高结果`不知道`的概率
- 参数:
  - hunk_size决定每张资料卡片有多大。
    chunk_overlap决定相邻卡片之间有没有重复内容。
- 句子窗口检索: 小块检索定位,返回周围几句话做上下文
- `top_p `,`Temperature `尽量同大同小,防止模型行为不可预知
- 

