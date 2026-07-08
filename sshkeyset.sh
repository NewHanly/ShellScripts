#!/bin/bash

# 1. 使用变量管理 SSH 密钥，方便维护
# 请将下方的公钥替换为您自己的公钥
SSH_KEY="AAAAB3NzaC1yc2EAAAADAQABAAABAQChhxYKROMK4+QujOPIrzTnqOQqHfgIMiyQJ6PevvDSr7HwhWIm0mmPDJmo6p4XIYJavvfd/Si3AUrnxWY02rTI7XKzd0R6UWDasPhCxnvMD1fHUkM8p5caKUSvPz559pCoxXOyIPv7jkJKCMKttZ5dXP2HAxnZHO8wz0YzayWkh1KQy4+oxVZEcv0l5LB5Z2VmXEpKSAaiow5nMdt+MSNjOgapSaq98v/T7b4eFr3f4ZK9YyvnNrGNCcDcxGKAHqxgYZF5uVxg3CRpTbPQ5+UoaaKzGQwC1Z7o5iPcw4StFdcvr3yKbB3U/AFk75Obuv9O/vVaKnAHZJzGGFOIFLvf"

# 2. 检查并创建 ~/.ssh 目录（修复了原脚本中 "~/.ssh" 带引号导致不解析的问题）
if [ ! -d "$HOME/.ssh" ]; then
    mkdir -p "$HOME/.ssh"
    chmod 700 "$HOME/.ssh"
fi

# 3. 检查公钥是否已经存在，避免重复追加
if grep -qF "$SSH_KEY" "$HOME/.ssh/authorized_keys" 2>/dev/null; then
    echo "提示: 该 SSH 密钥已存在于 authorized_keys 中，无需重复添加。"
else
    echo "$SSH_KEY" >> "$HOME/.ssh/authorized_keys"
    echo "成功: SSH 密钥已写入。"
fi

# 4. 确保权限正确（每次运行都刷新一次权限，更安全）
chmod 600 "$HOME/.ssh/authorized_keys"
chmod 700 "$HOME/.ssh"

# 5. 修正原脚本逻辑漏洞：只有当文件真正存在且配置成功时，才提示完成
if [ -f "$HOME/.ssh/authorized_keys" ]; then
    # 通常添加公钥不需要重启 sshd 服务，
    # 如果你的系统有特殊要求，可以取消下面这行的注释（需要 sudo 权限）
    # sudo systemctl restart sshd
    echo 'All done! SSH 配置完成。'
else
    echo '错误: 配置文件未成功创建！'
    exit 1
fi
