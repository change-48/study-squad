# 学习陪跑团 · Study Squad

> 一个 WorkBuddy 专家团（Team 型）：把课件课本整理成可引用的 Markdown 资料库，刷题解答逐条标注出处，错题与易错点自动沉淀，并按遗忘曲线安排复习。

不是"帮你搜答案"的助手，而是一个**有档案、有记录、有复习节奏**的学习闭环。所有产出（资料、刷题记录、总结）都落在你自己的本地目录里，可随时翻查、可版本管理。

## 它解决什么问题

| 自学常见问题 | 这个专家团的做法 |
|---|---|
| 课件散在各处，PPT/PDF 找不动、搜不了 | 统一归档，转成带页码定位的 Markdown，可按考点检索 |
| 答案看懂了，考试还是不会 | 讲解必须引用课件/课本原文出处，暴露"我以为我会" |
| 错题记了不看 | 错题本自动按 D1/D3/D7/D15/D30 排复习，每次学习先报到期的 |
| 学完一轮什么都没留下 | 知识点 / 解题技巧 / 易错点三类总结持续追加沉淀 |
| 有官方答案时口径不一致 | 优先按官方答案讲，与资料冲突时并列说明，不悄悄改答案 |

## 团队构成

| 成员 ID | 名字 | 职业 | 职责 |
|---|---|---|---|
| `study-squad-team-lead` | 温知新 | 学习总教练 | 学习诊断、SOP 编排、进度通报、学习档案 |
| `course-material-curator` | 章理清 | 课程资料架构师 | 目录初始化、原件归档、多格式转 Markdown、索引溯源 |
| `practice-mentor` | 解明远 | 解题与答疑教练 | 讲课、逐题解答、官方答案对照、出题批改、刷题记录 |
| `review-synthesizer` | 顾三省 | 复盘与记忆规划师 | 知识点/技巧/易错点总结、错题本、间隔复习 |

## 学习目录约定

首次使用会按下面结构初始化（根目录默认当前工作区，也可指定任意课程路径）：

```
{课程根目录}/
  学习档案.md                        # 课程信息、章节进度、掌握度、学习日志
  01-课程资料/
    课本/
      原始/                          # 课本原件，只读保留
      课本索引.md
      {课本名}.md + assets/
    课件/
      第01章-{章名}/
        原始/                        # 本章 PPT / PDF / Word 原件
        {课件名}.md + assets/
        本章资料索引.md
      第02章-{章名}/
  02-刷题记录/
    第01章-{章名}/
      答案/                          # 官方答案/解析
      {YYYY-MM-DD}-刷题.md
    错题本.md
  03-总结复盘/
    知识点/第01章-{章名}.md
    解题技巧.md
    易错点.md
    复习计划.md
```

完整规则见 [`skills/study-workspace/SKILL.md`](skills/study-workspace/SKILL.md)（唯一的目录与记录契约）。

### 三条硬规则

1. **原件只读**：所有原始文件进 `原始/`，转换不改原件，同名文件加序号而非覆盖。
2. **必带出处**：`【出处：01-课程资料/课件/第03章-牛顿定律/第三章课件.md §3.2，slide 7】`；资料没覆盖的内容明确标注为补充知识。
3. **不说假话**：识别不清标 `[待人工核对]`，掌握度按真实作答评定，已通关的错题只标记不删除。

## 支持的资料格式

| 格式 | 处理方式 |
|---|---|
| PDF（文本版/扫描版） | 提取文本与表格；扫描件按页看图识别，公式与图表逐页核对 |
| PPT / PPTX | 按页提取标题、正文、备注，保留页序与 `<!-- slide n -->` 定位 |
| DOC / DOCX | 转 GFM，图片落到 `assets/` |
| 图片 / 拍照笔记 | 视觉识别转写，公式转 LaTeX |
| XLSX | 转 Markdown 表格，注明来源工作表 |

## 安装

### 方式一：脚本安装（推荐）

```bash
git clone https://github.com/<你的用户名>/study-squad.git
cd study-squad
sh install.sh
```

### 方式二：手动安装

```bash
# 1. 把仓库内容放进专家目录（注意排除 .git）
DEST="$HOME/.workbuddy/plugins/marketplaces/my-experts/plugins/study-squad"
mkdir -p "$DEST"
tar -C ./study-squad --exclude=.git -cf - . | tar -C "$DEST" -xf -

# 2. 注册
python3 <WorkBuddy>/resources/app.asar.unpacked/resources/plugins/workbuddy-builtin/skills/expert-manager/scripts/register_expert.py "$DEST"
```

Windows 下 `$HOME/.workbuddy` 即 `C:\Users\<你>\.workbuddy`。

装好后在【专家中心 → 我的专家】启用「学习陪跑团」。

## 开始使用

- 我们开始学这门课：先建好学习目录，把我给的课件和课本转成Markdown归档，再带我过一遍本章重点
- 我在刷题：〔粘贴题目〕。有答案就按答案口径讲，没有就自己解，必须引用课件或课本出处，并记入刷题记录
- 帮我复盘这段时间的学习：更新知识点总结、解题技巧和易错点，并告诉我今天该复习哪些错题

## 包结构

```
study-squad/
├── .codebuddy-plugin/plugin.json   # 专家元信息、展示字段、成员
├── agents/                         # 主理人 + 3 名团员
├── skills/study-workspace/SKILL.md # 目录契约、转换流程、记录模板
├── avatars/                        # 团队 + 4 名成员头像（512×512）
├── settings.json
├── install.sh
└── README.md
```

## 自定义

改 `agents/*.md` 可调整角色口径与流程（如要求"解答必须给出草稿纸步骤"）；改 `skills/study-workspace/SKILL.md` 可调整目录结构与记录模板；改 `.codebuddy-plugin/plugin.json` 调整展示信息与推荐提示词。改完重跑注册脚本即可生效。

## 分类说明

`categoryId` 取 `12-IndustryConsultant`：WorkBuddy 分类表中没有"教育/学习辅导"专属项，`09-OperationsHR` 的"培训"指企业组织内训，与本项目定位不同。

## License

[MIT](LICENSE)
