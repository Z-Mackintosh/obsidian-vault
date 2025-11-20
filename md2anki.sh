#!/usr/bin/env bash

INPUT_MD="$1"
OUTPUT_CSV="$2"

# 设置 UTF-8 编码
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

if [ -z "$INPUT_MD" ] || [ -z "$OUTPUT_CSV" ]; then
  echo "用法: $0 输入文件.md 输出文件.csv"
  exit 1
fi

# 检查输入文件是否存在
if [ ! -f "$INPUT_MD" ]; then
  echo "❌ 错误：输入文件 '$INPUT_MD' 不存在"
  exit 1
fi

# 清空输出文件
> "$OUTPUT_CSV"

# 处理CSV转义函数
csv_escape() {
  local field="$1"
  # 如果字段包含逗号、引号或换行符，则进行转义
  if echo "$field" | grep -q '[,"]'; then
      # 将双引号替换为两个双引号
    field=$(echo "$field" | sed 's/"/""/g')
    # 用双引号包围整个字段
    echo "\"$field\""
  else
    echo "$field"
  fi
}

line_num=0
while IFS= read -r line; do
  line_num=$((line_num + 1))
  
  # 忽略空行和注释行
  [ -z "$line" ] && continue
  echo "$line" | grep -q '^[[:space:]]*#' && continue
  
  # 只处理包含 :: 的行
  echo "$line" | grep -q '::' && {
    # 拆分正面和背面
    front="${line%%::*}"
    back="${line#*::}"
    
    # 清理空白字符
    front="$(echo "$front" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')"
    back="$(echo "$back" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')"
    
    # 跳过空字段
    [ -z "$front" ] || [ -z "$back" ] && continue
    
    # 转换 *词性* → <i>词性</i>
    back="$(echo "$back" | sed -E 's/\*([^*]+)\*/<i>\1<\/i>/g')"
    
    # 转义CSV特殊字符并写入
    printf "%s,%s\n" "$(csv_escape "$front")" "$(csv_escape "$back")" >> "$OUTPUT_CSV"
  }
done < "$INPUT_MD"

echo "✅ Generated CSV: $OUTPUT_CSV"


