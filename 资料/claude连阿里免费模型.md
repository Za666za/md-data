# 方案1: 改`settings.json` 

- 在`C:\Users\-你的用户名-\.claude` 找到`settings.json`

- 修改示例:

  >  ```
  > {
  >   "env": {
  >     "ANTHROPIC_AUTH_TOKEN": "你的api-key",
  >     "ANTHROPIC_BASE_URL": "https://dashscope.aliyuncs.com/apps/anthropic",
  >     "ANTHROPIC_MODEL": "glm-5.1(你的模型名)"
  >   },
  >   "model": "glm-5.1",
  >   "theme": "dark-ansi"
  > }
  >  ```
  >
  > 完整示例:
  >
  > ```
  > {
  >   "env": {
  >     "ANTHROPIC_AUTH_TOKEN": "sk-ws",
  >     "ANTHROPIC_BASE_URL": "https://dashscope.aliyuncs.com/apps/anthropic",
  >     "ANTHROPIC_DEFAULT_HAIKU_MODEL": "glm-5.1",
  >     "ANTHROPIC_DEFAULT_OPUS_MODEL": "glm-5.1",
  >     "ANTHROPIC_DEFAULT_SONNET_MODEL": "glm-5.1",
  >     "ANTHROPIC_MODEL": "glm-5.1"
  >   },
  >   "model": "glm-5.1",
  >   "theme": "dark-ansi"
  > }
  > ```
  >
  >

> 创建`api-key ` :[大模型服务平台百炼控制台](https://bailian.console.aliyun.com/cn-beijing?tab=model#/api-key)
>
> 查看可用免费模型:[大模型服务平台百炼控制台](https://bailian.console.aliyun.com/cn-beijing?tab=costing-balance#/costing-balance/free-quota)
>
> 建议开启免费额度用完即停,
>
> 否则若一个模型欠费必须充值才可切换其他模型继续调用

# 方案2: 使用`CC switch`

![1782883134784](C:\Users\6\AppData\Roaming\Typora\typora-user-images\1782883134784.png)

红框改为自己的

黄框需设置为截图中的即可