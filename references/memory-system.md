# Memory System Reference

Schemas, update rules, and initialization protocol for project memory (Layer 2), plus guidance on personal preferences (Layer 1).

---

## Layer 1 — Personal Preferences (outside this skill)

Layer 1 lives in your host environment's global config, not in any project directory or skill file. **Used only in Claude Code;** in Cursor and other hosts, Layer 1 is not used — no check or read for it.

**Location (Claude Code only):** `~/.claude/CLAUDE.md` (Claude Code global config)
**Scope:** You, across all projects — loaded automatically by Claude Code on every session.

### Recommended structure for `~/.claude/CLAUDE.md`

```markdown
# Personal Preferences

## Working Style & Communication
- [e.g., I prefer to discuss ideal flow before touching entities]
- [e.g., Think in Chinese for strategy, English for technical specs]
- [e.g., Keep responses concise unless I ask for depth]
- [e.g., Always show the tradeoff, not just the recommendation]
- [e.g., Push back when feature list grows — I tend to over-scope]

## Cross-Project Methodology

### Validated Patterns
- **[Pattern name]** | Source: {project-id} | Confirmed: {date}
  - Context: when does this apply
  - Approach: what to do
  - Why it works: one sentence

### Anti-Patterns
- **[Anti-pattern name]** | Source: {project-id} | Confirmed: {date}
  - Context: what triggers this mistake
  - What goes wrong: one sentence

### Open Hypotheses
- **[Hypothesis]** | Source: {project-id} | Status: watching
  - Observation: what was noticed
  - Needs: one more project to confirm or refute
```

### Update rules

**Working Style** — update anytime via `[Meta]`. Low friction, high frequency.

**Cross-Project Methodology** — update only at two milestone moments:
1. When a Framework PRD is finalized
2. When a project phase closes

At these moments the AI scans `GENEALOGY_LOG.json` and `SESSION_MEMORY.md`, surfaces up to 3 candidate patterns, and writes only what you confirm. Never auto-written.

---

## Layer 2 — Project Memory

**Location:** `{project_root}/.ai_pm/`
**Gitignore:** Always add `.ai_pm/` to `.gitignore` — this is internal working memory, not a project deliverable.

---

### SESSION_MEMORY.md

Project history log. **Append-only — never overwrite past entries.**

```markdown
# Project: {project_id} — Session Log

## Update Rules
- Append only. Never delete historical entries.
- One entry per working session or major milestone.

## {YYYY-MM-DD} · {Session Theme}

### Key Discussions
- [Core insight or decision reached]

### Artifacts Created / Modified
- `path/to/file`: [what changed and why]

### Next Steps
- [Concrete, specific next action]
```

---

### docs/TODO.md

Project-wide todo list. Lives in `docs/`, committed to git — visible and versioned alongside other deliverables.

```markdown
# TODO — {project_id}

## Open
- [ ] **TODO-001** `[value]` Description of what needs to be resolved
  - Trigger: "user's exact words"
  - Linked to: entity / flow step / screen / feature name
  - Added: 2026-03-01

## In Progress
- [ ] **TODO-002** `[flow]` Currently being worked on

## Done
- [x] **TODO-003** `[entity]` Resolved item — brief resolution note
  - Resolved: 2026-03-02

## Dropped
- [-] **TODO-004** `[value]` Item no longer relevant
  - Reason: scope cut in MVP decision DEC-003
```

**Dimension tags:** `[value]` `[flow]` `[entity]` `[interaction]` `[design]`

**Update triggers:**
- User signals uncertainty → append to Open
- Decision resolves a pending item → move to Done with resolution note
- Item becomes irrelevant → move to Dropped with reason

---

### GENEALOGY_LOG.json

Decision lineage. `user_original_quote` is sacred — never paraphrase or summarize.

```json
{
  "decisions": [
    {
      "id": "DEC-001",
      "timestamp": "2026-03-01",
      "user_original_quote": "Verbatim words — never paraphrase",
      "decision_summary": "One sentence: what was decided",
      "logic_pillar": "value_anchor | flow_logic | entity_definition | interaction | design",
      "decision_type": "strategic | boundary | interaction_detail | visual",
      "residual_risk": "Known gaps or open questions from this decision",
      "status": "closed | pending_alignment | suspended",
      "linked_doc": "path/to/relevant/section — optional"
    }
  ]
}
```

**Update trigger:** User signals consensus ("ok", "sounds good", "let's go with that") → generate ID → log immediately.

---

### docs/01_STRATEGY/DECISIONS.md

Human-readable record of business judgments. Committed to git — this is the authoritative record of *why* decisions were made, readable by the whole team.

```markdown
# Business Decisions — {project_id}

## DEC-001 · {Short decision title}
- **Date:** 2026-03-01
- **Original quote:** "User's verbatim words"
- **Decision:** One sentence summary of what was decided
- **Rationale:** Why this direction, not alternatives
- **Trade-offs accepted:** What was explicitly de-prioritized
- **Residual risk:** Known open questions from this decision

---

## DEC-002 · {Short decision title}
...
```

**Written when:** Consensus Detection fires — user signals agreement on a business judgment.
**Relationship to GENEALOGY_LOG.json:** The log is the raw internal record; DECISIONS.md is the structured, readable version. Both are updated together.

---

### CONTEXT_SNAPSHOT.json

Current session state. Overwritten each session.

```json
{
  "project_id": "my-project",
  "current_scene": "value_discovery | logic_structuring | entity_definition | interaction_design | design_handoff",
  "active_topic": "Brief description of current discussion focus",
  "suspended_threads": [
    {
      "thread": "Description of a paused branch",
      "resume_trigger": "What would bring this back"
    }
  ],
  "last_updated": "2026-03-01"
}
```

---

## Project Initialization Protocol

When a new `project_id` is mentioned for the first time, create this skeleton in one step:

```
{project_root}/
├── .ai_pm/
│   ├── SESSION_MEMORY.md      ← header + rules, no entries yet
│   ├── GENEALOGY_LOG.json     ← { "decisions": [] }
│   └── CONTEXT_SNAPSHOT.json ← scene: value_discovery, empty threads
├── .gitignore                 ← include .ai_pm/ entry
└── docs/
    ├── 01_STRATEGY/           ← 立项与战略记忆（见 references/strategy-foundation.md）
    │   └── DECISIONS.md       ← empty, filled as business judgments are made；另需维护立项文档（价值与范围）
    ├── 02_PRD/
    │   └── README.md
    ├── 03_DESIGN/             ← 设计与中间产物（见 references/design-artifacts.md）
    │   ├── design-tokens.md   ← placeholder, fill in Scene 5
    │   ├── screens/
    │   ├── handoff/
    │   ├── ui_ux/
    │   ├── prototypes/
    │   ├── ai_prompts/
    │   └── tech_design/
    ├── 04_RESOURCES/          ← competitor research, raw inputs
    └── TODO.md                ← initialized with empty sections
```

**.gitignore minimum content:**
```
.ai_pm/
```

Confirm to user: `"Project '{project_id}' initialized. Ready to start Value Discovery."`

---

## 01_STRATEGY — 立项与战略记忆

**定位：** 存放立项与价值决策的依据信息，便于项目推进一段时间后仍能回顾「当时为什么这么做」。

| 内容 | 说明 |
|------|------|
| **立项文档** | 价值与范围类文档（如 value_and_scope），沉淀价值锚点、范围边界、目标用户与场景、痛点与成功指标、关键结构性决策；结构不强制，以沟通中明确的信息为准。 |
| **DECISIONS.md** | 业务决策的可读记录，与 GENEALOGY_LOG 对应；重大价值/范围判断可同时在立项文档与 DECISIONS 中保留。 |

详细说明 → [references/strategy-foundation.md](strategy-foundation.md)

---

## 03_DESIGN — 设计与中间产物（PRD → 开发）

**定位：** PRD 定稿之后、真正开始开发之前的设计与中间产物存放地。

| 子目录/文件 | 内容 |
|-------------|------|
| `design-tokens.md`、`screens/`、`handoff/` | 设计 token、定稿界面、每屏交付说明（见 design-handoff.md） |
| `ui_ux/` | 设计指导文档（页面拆分、每页功能/内容/字段）、设计原则；可含 `[待定项-XXX]`，解决后按 design-artifacts 整理（结论入文档、DECISIONS、PRD 同步、TODO） |
| `prototypes/` | 核心用户流程的线稿；从流程提取的关键组件的 demo（AI 生成，便于对 demo 提修改建议） |
| `ai_prompts/` | 模拟的 AI Prompt：话术草稿、示例对话、边界 case |
| `tech_design/` | 技术设计文档：架构、接口约定、数据流、技术选型与风险 |

详细说明（含待定项标记与整理策略）→ [references/design-artifacts.md](design-artifacts.md)

---

## Two-Layer Principle Within Layer 2

| Sub-layer | Records | Files |
|-----------|---------|-------|
| **Objective facts** | What happened — conversations, tasks, output locations | `SESSION_MEMORY.md` |
| **Logic assets** | Conclusions — decisions, business judgments, flows agreed | `GENEALOGY_LOG.json` (raw), `docs/01_STRATEGY/DECISIONS.md` (human-readable), other `docs/` |

Facts layer = history. Logic layer = truth. When they conflict, logic layer wins.
