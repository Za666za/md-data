#！bin/bash
CURRENT_USR="root"
CURRENT_PWD="123456"
while true; do
    read -p "请输入用户名：" username
    read -p "请输入密码：" password
    if [ "$username" == "$CURRENT_USR" ] && [ "$password" == "$CURRENT_PWD" ]; then
        echo "登录成功! "
        break
    else
        echo "用户名或密码错误，请重新输入！"
    fi
done
