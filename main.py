from fastapi import FastAPI
from database import *
from fastapi.responses import HTMLResponse

app = FastAPI()

# ========== HTTP接口 ==========

@app.get("/api/required-courses")
def required_courses(major: str, university: str = "西南财经大学"):
    courses = get_required_courses(major, university)
    return {"success": True, "major": major, "university": university, "courses": courses}

@app.get("/api/search")
def search(keyword: str):
    courses = search_courses(keyword)
    return {"success": True, "keyword": keyword, "courses": courses}

@app.get("/api/course-info")
def course_info(course_name: str):
    info = get_course_info(course_name)
    return {"success": True, "course_name": course_name, **info}

@app.get("/api/major-credits")
def major_credits(major: str, university: str = "西南财经大学"):
    data = get_major_credits(major, university)
    return {"success": True, **data}

@app.get("/api/course-majors")
def course_majors(course_name: str):
    data = get_course_majors(course_name)
    return {"success": True, "course_name": course_name, "majors": data}

@app.get("/api/college-majors")
def college_majors(college: str, university: str = "西南财经大学"):
    data = get_college_majors(college, university)
    return {"success": True, **data}

@app.get("/api/compare-courses")
def compare_courses_api(major: str):
    data = compare_courses(major)
    return {"success": True, **data}

@app.get("/api/compare-credits")
def compare_credits_api(major: str):
    data = compare_credits(major)
    return {"success": True, **data}

@app.get("/api/nl-query")
def nl_query(question: str):
    data = nl_to_sql(question)
    return {"success": True, **data}


# ========== HTML页面 ==========
@app.get("/")
def index():
    return HTMLResponse("""
<!DOCTYPE html>
<html>
<head>
    <title>培养方案查询系统 - 西南财经大学 vs 上海财经大学</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', 'PingFang SC', 'Microsoft YaHei', sans-serif;
            background: linear-gradient(135deg, #e8f4f8 0%, #d1e9f0 100%);
            min-height: 100vh;
            padding: 30px 20px;
        }
        
        .container {
            max-width: 1400px;
            margin: 0 auto;
        }
        
        /* 头部卡片 */
        .header {
            background: white;
            border-radius: 20px;
            padding: 25px 35px;
            margin-bottom: 30px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.08);
            border: 1px solid rgba(52,152,219,0.2);
        }
        
        h1 {
            font-size: 28px;
            color: #1a6b8a;
            letter-spacing: -0.5px;
            font-weight: 600;
        }
        
        h1 small {
            font-size: 14px;
            color: #7f8c8d;
            font-weight: normal;
            margin-left: 15px;
        }
        
        .subtitle {
            color: #5a7d8a;
            margin-top: 8px;
            font-size: 14px;
        }
        
        .note {
            background: #ecf9ff;
            border-left: 4px solid #3498db;
            padding: 12px 20px;
            border-radius: 12px;
            margin-top: 15px;
            font-size: 13px;
            color: #2c6b7e;
        }
        
        /* 两列布局 */
        .row {
            display: flex;
            flex-wrap: wrap;
            gap: 25px;
        }
        
        .col {
            flex: 1;
            min-width: 320px;
        }
        
        /* 卡片样式 */
        .card {
            background: white;
            border-radius: 20px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.05);
            transition: transform 0.2s, box-shadow 0.2s;
            border: 1px solid rgba(52,152,219,0.15);
        }
        
        .card:hover {
            transform: translateY(-2px);
            box-shadow: 0 12px 30px rgba(0,0,0,0.1);
        }
        
        .card h3 {
            font-size: 18px;
            color: #1a6b8a;
            margin-bottom: 15px;
            padding-bottom: 8px;
            border-bottom: 2px solid #c5e6f0;
            font-weight: 500;
        }
        
        /* 输入框样式 */
        .input-group {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            align-items: center;
        }
        
        input, select {
            flex: 1;
            min-width: 150px;
            padding: 10px 14px;
            border: 1px solid #cbd5e0;
            border-radius: 12px;
            font-size: 14px;
            transition: all 0.2s;
            background: #fafcfd;
        }
        
        input:focus, select:focus {
            outline: none;
            border-color: #3498db;
            box-shadow: 0 0 0 3px rgba(52,152,219,0.15);
            background: white;
        }
        
        button {
            padding: 10px 24px;
            background: linear-gradient(135deg, #3498db, #2980b9);
            color: white;
            border: none;
            border-radius: 12px;
            font-size: 14px;
            cursor: pointer;
            transition: all 0.2s;
            font-weight: 500;
            box-shadow: 0 2px 5px rgba(0,0,0,0.05);
        }
        
        button:hover {
            background: linear-gradient(135deg, #2980b9, #1c6d9e);
            transform: scale(1.01);
            box-shadow: 0 4px 10px rgba(52,152,219,0.3);
        }

        
           /* 结果区域 */
        .result-section {
            margin-top: 30px;
        }
        
        .result-card {
            background: white;
            border-radius: 20px;
            padding: 20px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.08);
        }
        
        .result-card h3 {
            font-size: 18px;
            color: #1a6b8a;
            margin-bottom: 15px;
            font-weight: 500;
        }
        
        pre {
            background: #2c3e50;
            color: #ecf0f1;
            padding: 20px;
            border-radius: 14px;
            overflow-x: auto;
            font-size: 12px;
            font-family: 'Monaco', 'Menlo', monospace;
            line-height: 1.5;
        }
        
        /* 小标签 */
        .badge {
            background: #e8f4f8;
            color: #1a6b8a;
            padding: 4px 10px;
            border-radius: 20px;
            font-size: 11px;
            display: inline-block;
            margin-left: 10px;
        }
        
        /* 响应式 */
        @media (max-width: 768px) {
            body { padding: 15px; }
            .header { padding: 18px; }
            h1 { font-size: 22px; }
            .card h3 { font-size: 16px; }
            button { padding: 8px 18px; }
        }
    </style>
</head>
<body>
<div class="container">
    <div class="header">
        <h1>培养方案数据库系统 <small>西南财经大学 | 上海财经大学</small></h1>
        <div class="subtitle">跨校培养方案对比分析平台</div>
            </div>

    <div class="row">
        <div class="col">
            <div class="card">
                <h3>📖 必修课查询</h3>
                <div class="input-group">
                    <input type="text" id="q1_major" placeholder="专业名，如：金融学">
                    <select id="q1_uni">
                        <option value="西南财经大学">西南财经大学</option>
                        <option value="上海财经大学">上海财经大学</option>
                    </select>
                    <button onclick="queryRequired()">查询</button>
                </div>
            </div>
            
            <div class="card">
                <h3>🔎 课程搜索</h3>
                <div class="input-group">
                    <input type="text" id="q2_keyword" placeholder="关键词，如：数据">
                    <button onclick="querySearch()">搜索</button>
                </div>
            </div>
            
            <div class="card">
                <h3>📘 课程详情</h3>
                <div class="input-group">
                    <input type="text" id="q3_course" placeholder="课程名，如：数据库原理">
                    <button onclick="queryCourseInfo()">查询</button>
                </div>
            </div>
            
            <div class="card">
                <h3>📊 专业总学分</h3>
                <div class="input-group">
                    <input type="text" id="q4_major" placeholder="专业名">
                    <select id="q4_uni">
                        <option value="西南财经大学">西南财经大学</option>
                        <option value="上海财经大学">上海财经大学</option>
                    </select>
                    <button onclick="queryMajorCredits()">查询</button>
                </div>
            </div>
            
            <div class="card">
                <h3>🏛️ 课程开课专业</h3>
                <div class="input-group">
                    <input type="text" id="q5_course" placeholder="课程名">
                    <button onclick="queryCourseMajors()">查询</button>
                </div>
            </div>
            
            <div class="card">
                <h3>🎓 学院专业列表</h3>
                <div class="input-group">
                    <input type="text" id="q6_college" placeholder="学院名，如：金融学院">
                    <select id="q6_uni">
                        <option value="西南财经大学">西南财经大学</option>
                        <option value="上海财经大学">上海财经大学</option>
                    </select>
                    <button onclick="queryCollegeMajors()">查询</button>
                </div>
            </div>
        </div>

        <div class="col">
            <div class="card">
                <h3>🔄 跨校课程对比</h3>
                <div class="input-group">
                    <input type="text" id="q7_major" placeholder="专业名，如：金融学">
                    <button onclick="queryCompareCourses()">对比</button>
                </div>
            </div>
            
            <div class="card">
                <h3>📊 跨校学分对比</h3>
                <div class="input-group">
                    <input type="text" id="q8_major" placeholder="专业名">
                    <button onclick="queryCompareCredits()">对比</button>
                </div>
            </div>
            
            <div class="card">
                <h3>🤖 自然语言查询</h3>
                <div class="input-group">
                    <input type="text" id="q9_question" placeholder="输入问题，如：金融学有哪些必修课">
                    <button onclick="queryNL()">查询</button>
                </div>
                <div style="margin-top: 12px; font-size: 12px; color: #7f8c8d;">
                    测试：金融学有哪些必修课 | 数据库原理的学分是多少 | 金融学总学分要求
                </div>
            </div>
        </div>
    </div>

    <div class="result-section">
        <div class="result-card">
            <h3>📋 查询结果</h3>
            <pre id="result">等待查询...</pre>
        </div>
    </div>
</div>

<script>
    const resultDiv = document.getElementById("result");

    // ===== 美化显示函数 =====
    function renderResult(data) {
        // 判断数据类型，用不同方式展示
        if (data.courses && Array.isArray(data.courses) && data.courses.length > 0) {
            // 课程列表 → 表格
            renderCoursesTable(data);
        } else if (data.majors && Array.isArray(data.majors)) {
            // 专业列表 → 表格
            renderMajorsList(data);
        } else if (data.西南财经大学 && data.上海财经大学) {
            // 跨校对比 → 双栏对比
            renderCompareTable(data);
        } else if (data.total_credits) {
            // 总学分 → 卡片
            renderCreditsCard(data);
        } else if (data.sql) {
            // 自然语言查询 → 显示SQL + 结果
            renderNLResult(data);
        } else {
            // 其他情况 → 格式化JSON
            resultDiv.innerHTML = `<pre style="background:#2c3e50;color:#ecf0f1;padding:20px;border-radius:14px;font-size:13px;">${JSON.stringify(data, null, 2)}</pre>`;
        }
    }

    // ===== 课程列表 → 表格 =====
    function renderCoursesTable(data) {
        let title = data.major || data.keyword || "查询结果";
        let html = `<div style="margin-bottom:12px;font-weight:600;color:#1a6b8a;">📚 ${title}</div>`;
        html += `<table style="width:100%;border-collapse:collapse;font-size:14px;">
            <thead>
                <tr style="background:linear-gradient(135deg,#3498db,#2980b9);color:white;">
                    <th style="padding:12px 16px;text-align:left;border-radius:8px 0 0 0;">课程名称</th>
                    <th style="padding:12px 16px;text-align:center;">学分</th>
                    <th style="padding:12px 16px;text-align:center;border-radius:0 8px 0 0;">学时</th>
                </tr>
            </thead>
            <tbody>`;
        for (let c of data.courses) {
            html += `<tr style="border-bottom:1px solid #eef2f7;">
                <td style="padding:10px 16px;">${c.name || '-'}</td>
                <td style="padding:10px 16px;text-align:center;">${c.credits ?? '-'}</td>
                <td style="padding:10px 16px;text-align:center;">${c.hours ?? '-'}</td>
            </tr>`;
        }
        html += `</tbody></table>`;
        html += `<div style="margin-top:10px;color:#7f8c8d;font-size:13px;">共 ${data.courses.length} 门课程</div>`;
        resultDiv.innerHTML = html;
    }

    // ===== 跨校对比 → 双栏对比 =====
   function renderCompareTable(data) {
    let major = data.major || "专业";
    let swufe = data["西南财经大学"] || [];
    let sufe = data["上海财经大学"] || [];
    
    let html = `<div style="margin-bottom:12px;font-weight:600;color:#1a6b8a;font-size:16px;">🔄 ${major} 跨校对比</div>`;
    html += `<div style="display:flex;gap:20px;flex-wrap:wrap;">`;
    
    // 西财
    html += `<div style="flex:1;min-width:250px;background:#e8f4f8;border-radius:12px;padding:16px;border:1px solid #b8d4e0;">
        <div style="font-weight:600;color:#1a5276;margin-bottom:10px;font-size:15px;">🏫 西南财经大学</div>`;
    if (swufe.length === 0) {
        html += `<div style="color:#7f8c8d;font-size:14px;">暂无课程数据</div>`;
    } else {
        for (let c of swufe) {
            html += `<div style="padding:8px 0;border-bottom:1px solid #d4e4ec;font-size:14px;color:#1a2a3a;">
                ${c.name || '-'} ${c.is_required ? '⭐' : ''}
                <span style="float:right;color:#2c6b7e;font-weight:500;">${c.credits || '-'} 学分</span>
            </div>`;
        }
    }
    html += `</div>`;
    
    // 上财
    html += `<div style="flex:1;min-width:250px;background:#f0eaf5;border-radius:12px;padding:16px;border:1px solid #d4c4e0;">
        <div style="font-weight:600;color:#5b2d7a;margin-bottom:10px;font-size:15px;">🏫 上海财经大学</div>`;
    if (sufe.length === 0) {
        html += `<div style="color:#7f8c8d;font-size:14px;">暂无课程数据</div>`;
    } else {
        for (let c of sufe) {
            html += `<div style="padding:8px 0;border-bottom:1px solid #e0d4e8;font-size:14px;color:#1a2a3a;">
                ${c.name || '-'} ${c.is_required ? '⭐' : ''}
                <span style="float:right;color:#5b2d7a;font-weight:500;">${c.credits || '-'} 学分</span>
            </div>`;
        }
    }
    html += `</div>`;
    
    html += `</div>`;
    resultDiv.innerHTML = html;
}
    // ===== 总学分 → 卡片 =====
    function renderCreditsCard(data) {
        let html = `<div style="display:flex;gap:20px;flex-wrap:wrap;">`;
        let uni = data.university || "西南财经大学";
        html += `<div style="background:linear-gradient(135deg,#e8f4f8,#d1e9f0);padding:20px 30px;border-radius:16px;flex:1;min-width:200px;">
            <div style="font-size:13px;color:#2c6b7e;">📘 ${uni}</div>
            <div style="font-size:32px;font-weight:700;color:#1a6b8a;margin-top:4px;">${data.total_credits || '-'}</div>
            <div style="font-size:13px;color:#5a7d8a;">总学分要求</div>
        </div>`;
        html += `</div>`;
        resultDiv.innerHTML = html;
    }
// ===== 自然语言查询 =====
    function renderNLResult(data) {
        let html = `<div style="margin-bottom:12px;font-weight:600;color:#1a6b8a;">🤖 自然语言查询结果</div>`;
        html += `<div style="background:#f5f7fa;padding:14px 18px;border-radius:10px;font-size:14px;margin-bottom:12px;">
            <span style="color:#5a7d8a;">❓ 问题：</span> ${data.question || '-'}
        </div>`;
        if (data.sql) {
            html += `<div style="background:#2c3e50;color:#a8d5a2;padding:14px 18px;border-radius:10px;font-family:monospace;font-size:13px;overflow-x:auto;">
                📝 ${data.sql}
            </div>`;
        }
        if (data.result) {
            html += `<div style="background:#eef6f5;padding:14px 18px;border-radius:10px;margin-top:12px;font-size:14px;">
                ✅ 结果：${data.result}
            </div>`;
        }
        resultDiv.innerHTML = html;
    }

    // ===== 专业列表 =====
    function renderMajorsList(data) {
        let html = `<div style="margin-bottom:12px;font-weight:600;color:#1a6b8a;">🎓 专业列表</div>
            <div style="display:flex;flex-wrap:wrap;gap:10px;">`;
        for (let m of data.majors) {
            html += `<span style="background:#e8f4f8;padding:6px 16px;border-radius:20px;font-size:14px;color:#1a6b8a;">${m}</span>`;
        }
        html += `</div>`;
        resultDiv.innerHTML = html;
    }

    // ===== API调用（保持不变） =====
    async function apiCall(url, params) {
        const query = new URLSearchParams(params).toString();
        try {
            const res = await fetch(`${url}?${query}`);
            const data = await res.json();
            renderResult(data);
            return data;
        } catch (e) {
            resultDiv.innerHTML = `<div style="color:#e74c3c;padding:20px;">❌ 请求失败：${e.message}</div>`;
        }
    }

    // ===== 各查询函数（保持不变） =====
    function queryRequired() {
        let major = document.getElementById("q1_major").value;
        let uni = document.getElementById("q1_uni").value;
        if (!major) { alert("请输入专业名"); return; }
        apiCall("/api/required-courses", { major: major, university: uni });
    }

    function querySearch() {
        let keyword = document.getElementById("q2_keyword").value;
        if (!keyword) { alert("请输入关键词"); return; }
        apiCall("/api/search", { keyword: keyword });
    }

    function queryCourseInfo() {
        let course = document.getElementById("q3_course").value;
        if (!course) { alert("请输入课程名"); return; }
        apiCall("/api/course-info", { course_name: course });
    }

    function queryMajorCredits() {
        let major = document.getElementById("q4_major").value;
        let uni = document.getElementById("q4_uni").value;
        if (!major) { alert("请输入专业名"); return; }
        apiCall("/api/major-credits", { major: major, university: uni });
    }

    function queryCourseMajors() {
        let course = document.getElementById("q5_course").value;
        if (!course) { alert("请输入课程名"); return; }
        apiCall("/api/course-majors", { course_name: course });
    }

    function queryCollegeMajors() {
        let college = document.getElementById("q6_college").value;
        let uni = document.getElementById("q6_uni").value;
        if (!college) { alert("请输入学院名"); return; }
        apiCall("/api/college-majors", { college: college, university: uni });
    }

    function queryCompareCourses() {
        let major = document.getElementById("q7_major").value;
        if (!major) { alert("请输入专业名"); return; }
        apiCall("/api/compare-courses", { major: major });
    }

    function queryCompareCredits() {
        let major = document.getElementById("q8_major").value;
        if (!major) { alert("请输入专业名"); return; }
        apiCall("/api/compare-credits", { major: major });
    }

    function queryNL() {
        let question = document.getElementById("q9_question").value;
        if (!question) { alert("请输入问题"); return; }
        apiCall("/api/nl-query", { question: question });
    }
</script>
    </body>
</html>
    """)