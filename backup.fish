#!/usr/bin/fish

# --- 步骤 1: 欢迎并获取提交注释 ---
gum style --border normal --margin "1" --padding "1 2" --border-foreground 212 "📝 开始备份您的笔记"

# Fish 变量赋值不需要大写，也不需要双引号包裹变量名来防止分割
set commit_msg (gum input --placeholder "您今天更新了什么？")

# 检查输入：Fish 的 if 语法更接近现代语言，不需要复杂的 [ -z ... ]
if test -z "$commit_msg"
    gum style --bold --foreground="9" "必须输入注释才能提交！操作已取消。"
    exit 1
end

# --- 步骤 2: 最终确认 ---
gum style --margin "1 0" "将要提交注释: \"$commit_msg\""

# Fish 的逻辑判断非常直观，直接用 or 关键字处理失败情况
gum confirm "确定要备份所有变更吗?" \
    --affirmative="✅ 是的，开始备份" \
    --negative="❌ 等一下"
or begin
    gum style --foreground 240 "操作已取消。"
    exit 0
end

# --- 步骤 3: 执行 Git 命令 ---
# Fish 处理字符串连接非常自然
gum spin --spinner dot --title "正在备份到远端仓库..." -- \
    sh -c "git add . && git commit -m '$commit_msg' && git push"

# --- 步骤 4: 结果反馈 ---
if test $status -eq 0
    gum style --foreground "10" --margin "1 0" "🎉 备份成功！"
else
    gum style --bold --foreground "9" --margin "1 0" "🔥 出错了！"
    exit 1
end
