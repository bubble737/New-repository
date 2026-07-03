import sqlite3

DB_PATH = "cultivate.db"

def get_connection():
    return sqlite3.connect(DB_PATH)

def get_required_courses(major, university):
    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute('''
        SELECT c.name, c.credits, c.hours 
        FROM course c
        JOIN major_course mc ON c.id = mc.course_id
        JOIN major m ON m.id = mc.major_id
        JOIN university u ON u.id = m.university_id
        WHERE m.name = ? AND u.name = ? AND mc.is_required = 1
    ''', (major, university))
    results = cursor.fetchall()
    conn.close()
    return [{"name": r[0], "credits": r[1], "hours": r[2]} for r in results]

def search_courses(keyword):
    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute('''
        SELECT name, credits, hours FROM course 
        WHERE name LIKE ?
        LIMIT 50
    ''', (f'%{keyword}%',))
    results = cursor.fetchall()
    conn.close()
    return [{"name": r[0], "credits": r[1], "hours": r[2]} for r in results]

def get_course_info(course_name):
    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute('''
        SELECT credits, hours FROM course WHERE name = ?
    ''', (course_name,))
    r = cursor.fetchone()
    conn.close()
    if r:
        return {"credits": r[0], "hours": r[1]}
    return {"credits": None, "hours": None}

def get_major_credits(major, university):
    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute('''
        SELECT m.total_credits FROM major m
        JOIN university u ON u.id = m.university_id
        WHERE m.name = ? AND u.name = ?
    ''', (major, university))
    r = cursor.fetchone()
    conn.close()
    return {"major": major, "university": university, "total_credits": r[0] if r else None}

def get_course_majors(course_name):
    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute('''
        SELECT DISTINCT m.name, u.name FROM major m
        JOIN major_course mc ON m.id = mc.major_id
        JOIN course c ON c.id = mc.course_id
        JOIN university u ON u.id = m.university_id
        WHERE c.name = ?
    ''', (course_name,))
    results = cursor.fetchall()
    conn.close()
    return [{"major": r[0], "university": r[1]} for r in results]

def get_college_majors(college, university):
    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute('''
        SELECT name FROM major m
        JOIN university u ON u.id = m.university_id
        WHERE u.name = ?
    ''', (university,))
    results = cursor.fetchall()
    conn.close()
    return {"college": college, "university": university, "majors": [r[0] for r in results]}

def compare_courses(major):
    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute('''
        SELECT u.name, c.name, c.credits, mc.is_required FROM course c
        JOIN major_course mc ON c.id = mc.course_id
        JOIN major m ON m.id = mc.major_id
        JOIN university u ON u.id = m.university_id
        WHERE m.name = ?
    ''', (major,))
    results = cursor.fetchall()
    conn.close()
    
    swufe = [{"name": r[1], "credits": r[2], "is_required": r[3]} for r in results if r[0] == "西南财经大学"]
    sufe = [{"name": r[1], "credits": r[2], "is_required": r[3]} for r in results if r[0] == "上海财经大学"]
    return {"major": major, "西南财经大学": swufe, "上海财经大学": sufe}

def compare_credits(major):
    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute('''
        SELECT u.name, m.total_credits FROM major m
        JOIN university u ON u.id = m.university_id
        WHERE m.name = ?
    ''', (major,))
    results = cursor.fetchall()
    conn.close()
    data = {"major": major}
    for r in results:
        data[r[0]] = {"total_credits": r[1]}
    return data

def nl_to_sql(question):
    # 这个功能等有时间再接入真实LLM，现在返回模拟
    return {"question": question, "sql": "SELECT * FROM course WHERE name LIKE '%数据%'", "result": "这是模拟结果，接入LLM后可实现真·自然语言查询"}