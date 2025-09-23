#!/bin/bash
# 修复 Markdown 笔记中公式的空格问题: $ a $ -> $a$

# 1. 选择文件
file=$(fd -e md | fzf --prompt="选择要修复的笔记 > ")

# 如果没选文件，退出
[ -z "$file" ] && echo "未选择文件，退出。" && exit 1

# 2. 修复公式空格
sed -E -i 's/\$[[:space:]]+([^$]+)[[:space:]]+\$/\$\1\$/g' "$file"

# 3. 用 bat 显示结果
echo "✅ 已修复：$file"
bat --style=plain --paging=never "$file" | grep '\$.*\$' || echo "未发现公式。"

