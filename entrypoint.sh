#!/bin/bash

# 如果提供了NODE_ID环境变量，则自动配置
if [ -n "$NODE_ID" ]; then
    # 创建node-id文件
    echo "$NODE_ID" > /root/.nexus/node-id
    # 模拟交互输入：
    # 1. "y" - 同意条款（如果提示）
    # 2. "y" - 使用现有账户（如果存在）
    # 3. "2" - 选择连接节点ID
    # 4. NODE_ID - 输入节点ID
    echo "y" > /tmp/input.txt
    echo "y" >> /tmp/input.txt
    echo "2" >> /tmp/input.txt
    echo "$NODE_ID" >> /tmp/input.txt
    # 执行nexus-network start并提供输入
    exec /root/.nexus/nexus-network start --env beta < /tmp/input.txt
else
    # 如果没有NODE_ID，提示用户并运行默认命令
    echo "NODE_ID environment variable not set. Please provide a node ID."
    exec "$@"
fi
