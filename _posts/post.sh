#!/bin/bash

# 接收参数
title=$1
tags=${2:-"default"}

# 获取当前日期
current_date=$(date +"%Y-%m-%d")
current_year=$(date +"%Y")
current_month=$(date +"%m")
current_day=$(date +"%d")

# 生成文件名和permalink
formatted_title=$(echo "$title" | tr '[:upper:]' '[:lower:]' | sed 's/ /-/g')
file_date=$(date +"%Y-%m-%d")
file_name="${file_date}-${formatted_title}.md"

# 获取今天的博客编号（这里假设每次运行脚本是当天的第一个编号）
post_count=$(ls | grep "^${file_date}.*.md$" | wc -l)
blog_number=$((post_count + 1))
permalink="/posts/${current_year}/${current_month}/blog-post-${blog_number}/"

# 生成Markdown抬头
markdown_header="---
title: '$title'
date: $current_date
permalink: $permalink
tags:
"

# 分割tags字符串并添加到markdown_header
IFS=',' read -ra ADDR <<< "$tags"
for tag in "${ADDR[@]}"; do
    markdown_header+="  - $tag
"
done

# 添加结束标记
markdown_header+="---"

# 将抬头写入Markdown文件
echo "$markdown_header" > "$file_name"

echo "Markdown文件 '$file_name' 已生成"
