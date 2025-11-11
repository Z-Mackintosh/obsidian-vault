#!/bin/bash

# 脚本：使用AI将例题笔记转换为符合要求的格式
# 依赖：fzf, curl, jq

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 检查依赖
check_dependencies() {
    local missing_deps=()
    
    if ! command -v fzf &> /dev/null; then
        missing_deps+=("fzf")
    fi
    
    if ! command -v curl &> /dev/null; then
        missing_deps+=("curl")
    fi
    
    if ! command -v jq &> /dev/null; then
        missing_deps+=("jq")
    fi
    
    if [ ${#missing_deps[@]} -ne 0 ]; then
        echo -e "${RED}错误：缺少必要的依赖：${missing_deps[*]}${NC}"
        echo "请安装缺失的依赖后重试："
        for dep in "${missing_deps[@]}"; do
            echo "  - $dep"
        done
        exit 1
    fi
}

# 检查API密钥
check_api_key() {
    if [ -z "$DEEPSEEK_API_KEY" ]; then
        echo -e "${RED}错误：未设置 DEEPSEEK_API_KEY 环境变量${NC}"
        echo "请设置您的DeepSeek API密钥："
        echo "  export DEEPSEEK_API_KEY=your_api_key_here"
        exit 1
    fi
}

# 查找所有md文件
find_example_files() {
    find . -type f -name "*.md" | grep -v ".git" | grep -v "_converted.md" | sort
}

# 使用fzf选择文件
select_file() {
    local files
    files=$(find_example_files)
    
    if [ -z "$files" ]; then
        echo -e "${YELLOW}未找到任何例题文件${NC}"
        exit 1
    fi
    
    echo "$files" | fzf --height 40% --border --prompt="选择要转换的笔记文件: "
}

get_template_requirements() {
    cat << 'EOF'
请将例题笔记转换为以下结构化格式：

# 例题
[题目内容]

# 解答
## 方法分析
[解题思路分析]

## 解题步骤
### Step 1：[步骤标题]
[详细计算过程]

### Step 2：[步骤标题]
[详细计算过程]

[...更多步骤...]

[最终答案框框表示]

# 核心技巧
## [技巧类别]
- [具体技巧]

# 经验总结
1. **[关键要点]**：[说明]

要求：
1. 使用 $$ 包裹数学公式
2. 使用 \\boxed{} 标记最终答案
3. 步骤分解清晰合理
4. 核心技巧有实际指导意义
5. 使用中文输出
EOF
}

# 调用DeepSeek API
call_deepseek_api() {
    local content="$1"
    local template="$2"
    
    # 创建临时文件来构建JSON，避免转义问题
    local temp_json=$(mktemp)
    
    # 对内容进行JSON转义
    local escaped_content
    escaped_content=$(echo "$content" | jq -Rs . | sed 's/^"//;s/"$//')
    
    cat > "$temp_json" << EOF
{
    "model": "deepseek-chat",
    "messages": [
        {
            "role": "system",
            "content": "你是一个专业的数学和科学笔记整理助手。请将例题笔记转换为结构化的学习笔记。\\n\\n$template"
        },
        {
            "role": "user",
            "content": "请转换以下例题笔记：\\n\\n$escaped_content"
        }
    ],
    "stream": false,
    "temperature": 0.3
}
EOF

    # 调用API并处理响应
    local response
    response=$(curl -s https://api.deepseek.com/chat/completions \
        -H "Content-Type: application/json" \
        -H "Authorization: Bearer ${DEEPSEEK_API_KEY}" \
        -d "@$temp_json")
    
    # 清理临时文件
    rm -f "$temp_json"
    
    # 检查响应是否为空
    if [ -z "$response" ]; then
        echo -e "${RED}错误：API返回空响应${NC}" >&2
        return 1
    fi
    
    # 检查响应是否为有效的JSON
    if ! echo "$response" | jq . >/dev/null 2>&1; then
        echo -e "${RED}错误：API返回无效的JSON响应${NC}" >&2
        echo "原始响应：$response" >&2
        return 1
    fi
    
    # 提取内容
    echo "$response" | jq -r '.choices[0].message.content // empty'
}

# 处理文件转换
convert_file() {
    local file_path="$1"
    local template="$2"
    
    echo -e "${BLUE}正在处理文件: $file_path${NC}"
    
    # 读取文件内容
    local content
    content=$(cat "$file_path")
    
    if [ -z "$content" ]; then
        echo -e "${RED}错误：文件内容为空${NC}"
        return 1
    fi
    
    # 调用API转换
    echo -e "${YELLOW}正在调用AI进行转换...${NC}"
    local converted_content
    converted_content=$(call_deepseek_api "$content" "$template")
    
    if [ $? -ne 0 ] || [ -z "$converted_content" ]; then
        echo -e "${RED}错误：API调用失败${NC}"
        return 1
    fi
    
    # 生成新文件名（在同一目录下，添加_converted后缀）
    local dir_name=$(dirname "$file_path")
    local base_name=$(basename "$file_path")
    local new_file_path="${dir_name}/${base_name%.md}_converted.md"
    
    echo -e "${BLUE}新文件将保存为: $new_file_path${NC}"
    
    # 保存转换后的内容
    echo "$converted_content" > "$new_file_path"
    
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✓ 转换成功！新文件：$new_file_path${NC}"
        
        # 询问是否删除原文件
        echo -e "${YELLOW}是否删除原文件 $file_path？(y/N)${NC}"
        read -r response
        if [[ "$response" =~ ^[Yy]$ ]]; then
            rm "$file_path"
            echo -e "${GREEN}✓ 原文件已删除${NC}"
        else
            echo -e "${BLUE}原文件保留${NC}"
        fi
    else
        echo -e "${RED}错误：保存转换后的文件失败${NC}"
        return 1
    fi
}

# 主函数
main() {
    echo -e "${BLUE}=== AI笔记转换工具 ===${NC}"
    
    # 检查依赖
    check_dependencies
    
    # 检查API密钥
    check_api_key
    
    # 获取模板要求
    echo -e "${YELLOW}使用内置模板要求...${NC}"
    local template
    template=$(get_template_requirements)
    
    # 选择文件
    echo -e "${YELLOW}请选择要转换的笔记文件...${NC}"
    echo -e "${BLUE}注意：新文件将在同一目录下生成，文件名添加 '_converted' 后缀${NC}"
    local selected_file
    selected_file=$(select_file)
    
    if [ -z "$selected_file" ]; then
        echo -e "${YELLOW}未选择文件，退出${NC}"
        exit 0
    fi
    
    # 确认选择
    echo -e "${BLUE}已选择文件: $selected_file${NC}"
    echo -e "${YELLOW}确认转换此文件？(Y/n)${NC}"
    read -r confirm
    
    if [[ "$confirm" =~ ^[Nn]$ ]]; then
        echo -e "${YELLOW}取消转换${NC}"
        exit 0
    fi
    
    # 转换文件
    convert_file "$selected_file" "$template"
    
    echo -e "${GREEN}=== 转换完成 ===${NC}"
}

# 运行主函数
main "$@"
