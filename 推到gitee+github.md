# 前置需要(ssh配置)

# 1. 将当前的 origin（GitHub）设置为第一个推送地址

# (如果你的 origin 已是 GitHub 地址，此步可省略，但为确保正确，执行也无妨)
git remote set-url --add --push origin git@github.com:Za666za/md-data.git

# 2. 为 origin 添加 Gitee 作为第二个推送地址
git remote set-url --add --push origin git@gitee.com:za666za/data-md.git

# 3

git remote -v

# 4


现在，你可以像往常一样推送，但这次会同时推送到两个平台