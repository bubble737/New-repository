import sqlite3
import csv
import os

# 连接到数据库（会自动创建 cultivate.db）
conn = sqlite3.connect('cultivate.db')
cursor = conn.cursor()

# ===== 创建表结构 =====
cursor.executescript('''
DROP TABLE IF EXISTS university;
DROP TABLE IF EXISTS major;
DROP TABLE IF EXISTS course;
DROP TABLE IF EXISTS major_course;

CREATE TABLE university (
    id INTEGER PRIMARY KEY,
    name TEXT
);

CREATE TABLE major (
    id INTEGER PRIMARY KEY,
    name TEXT,
    university_id INTEGER,
    total_credits REAL
);

CREATE TABLE course (
    id INTEGER PRIMARY KEY,
    name TEXT,
    credits REAL,
    hours INTEGER
);

CREATE TABLE major_course (
    major_id INTEGER,
    course_id INTEGER,
    is_required INTEGER
);
''')

# ===== 导入 CSV 数据 =====
def import_csv(table_name, csv_file, columns):
    file_path = os.path.join(os.path.dirname(__file__), csv_file)
    if not os.path.exists(file_path):
        print(f"⚠️ 文件不存在: {csv_file}，跳过")
        return
    with open(file_path, 'r', encoding='utf-8') as f:
        reader = csv.reader(f)
        header = next(reader)  # 跳过表头
        placeholders = ','.join(['?' for _ in columns])
        sql = f"INSERT INTO {table_name} ({','.join(columns)}) VALUES ({placeholders})"
        count = 0
        for row in reader:
            # 补齐空值
            while len(row) < len(columns):
                row.append(None)
            cursor.execute(sql, row[:len(columns)])
            count += 1
        print(f"✅ {table_name} 导入 {count} 条数据")

# 导入各个表（根据CSV列名调整）
import_csv('university', 'university.csv', ['id', 'name'])
import_csv('major', 'major.csv', ['id', 'name', 'university_id', 'total_credits'])
import_csv('course', 'course.csv', ['id', 'name', 'credits', 'hours'])
import_csv('major_course', 'major_course.csv', ['major_id', 'course_id', 'is_required'])

conn.commit()
conn.close()

print("🎉 数据库创建成功！生成 cultivate.db")