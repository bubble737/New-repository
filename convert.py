import sqlite3

# 使用 utf-8-sig 处理可能的 BOM 头
with open('cultivation.sql', 'r', encoding='utf-8-sig') as f:
    sql_content = f.read()

# 尝试执行
conn = sqlite3.connect('cultivate.db')
cursor = conn.cursor()

try:
    # 执行整个脚本
    cursor.executescript(sql_content)
    conn.commit()
    print("✅ 数据库创建成功！")
except Exception as e:
    print(f"❌ 出错：{e}")
    # 打印出错前的一部分SQL，帮助调试
    print("出错位置附近的内容：")
    # 找到出错的行号（大概）
    lines = sql_content.split('\n')
    for i, line in enumerate(lines):
        if '"' in line:  # 找包含双引号的行
            print(f"第{i+1}行: {line[:100]}")
            break

conn.close()