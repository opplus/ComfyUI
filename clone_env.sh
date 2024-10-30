#!/bin/bash

# 打印脚本的使用方法
print_usage() {
    echo "Usage: $0 <source_env> <target_env>"
    echo "This script clones a Conda environment."
    echo "  <source_env>: The name of the source environment to clone from."
    echo "  <target_env>: The name of the new environment to create."
    exit 1
}

# 检查参数个数
if [ $# -ne 2 ]; then
    echo "Error: Exactly two arguments are required."
    print_usage
fi

# 赋值参数到变量
SOURCE_ENV="$1"
TARGET_ENV="$2"

# 打印参数值
echo "Source environment: $SOURCE_ENV"
echo "Target environment: $TARGET_ENV"

# 使用conda创建新环境，克隆自指定的源环境
conda create -n "$TARGET_ENV" --clone "$SOURCE_ENV"
