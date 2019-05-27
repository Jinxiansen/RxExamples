#! /bin/bash

### 懒人脚本。
# 脚本说明：本 command 脚本用于拉取当前分支代码，并提交改动。
# 使用方法：将本脚本放在 .git 同级目录，双击运行即可。
# 注意事项：如果提示无权限运行，请在本脚本所在目录下执行 chmod +x Push.command
###

shellDir="$(dirname "$BASH_SOURCE")"
cd ${shellDir}/

current_time=`date +%Y年%m月%d日%H时%M分%S秒`

git pull
git add .
git commit -m "$current_time"
git push
if [ "$?" == "0" ]; then
  echo "---------------- 提交成功 ----------------"
  echo "---------------- 5秒后将自动关闭 ----------------"
  sleep 5
  osascript -e 'tell application "Terminal" to close first window' & exit
else
  echo "执行终止！错误码：$?。请检查终端日志。"
  exit 1
fi
