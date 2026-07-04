# 跨校培养方案数据库系统

## 项目简介
本系统整合西南财经大学和上海财经大学经济学专业培养方案数据，提供课程查询、跨校对比等功能。

## 数据库设计
包含5张核心表：university、department、major、course、major_course

## 技术栈
- 数据库：PostgreSQL / SQLite
- 语言：Python
- 驱动：psycopg2

## 文件说明
- `database.py`：封装所有SQL查询函数
- `cultivation.sql`：PostgreSQL数据库导出文件
- `main.py`：FastAPI主程序
- `*.csv`：原始数据文件

## 运行方式
```bash
pip install fastapi uvicorn psycopg2-binary
uvicorn main:app --reload --port 8001
