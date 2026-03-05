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

At these moments the AI scans `SESSION_MEMORY.md`, surfaces up to 3 candidate patterns, and writes only what you confirm. Never auto-written.

---

## Layer 2 — Project Memory

**Location:** `{project_root}/docs/00_MEMORY/`
**Visibility:** Visible to user, committed to git. This is the explicit memory of the project.

---

### docs/00_MEMORY/CONTEXT_SNAPSHOT.md

**Role:** The "Evidence Locker". Records raw user inputs, constraints, and story samples that serve as the factual basis for decisions. **Append-only.**

```markdown
# Context Snapshots
> 事实快照库。记录关键的用户原始输入，作为决策依据。

## [CNT-001] 2026-03-05
> User: "我希望用户在断网时也能看到缓存的最近 5 条记录，但不能编辑。"
- **Tags**: #offline #constraint
- **Ref**: Session 2026-03-05 (Value Discovery)

## [CNT-002] 2026-03-06
> User: "这个流程太复杂了，我想要的是一键完成，不需要确认。"
- **Tags**: #ux #simplification
- **Ref**: Session 2026-03-06 (Logic Structuring)
```

**Update trigger:** 
- User tells a specific story (Scene 1).
- User sets a hard constraint.
- User explicitly corrects a misunderstanding.

---

### docs/00_MEMORY/SESSION_MEMORY.md

**Role:** The "Narrative Log". Records what happened, connecting facts (Context) to conclusions (Decisions). **Append-only.**

```markdown
# Project Session Log

## 2026-03-05 · 离线模式讨论
- **Discussion**: 确认了离线缓存策略。
- **Evidence**: 基于 [CNT-001] 的用户约束。
- **Outcome**: 
  - 决定采用 LocalStorage 缓存方案 (见 DECISIONS.md -> DEC-005)
  - 拒绝了 SQLite 方案 (太重)
  - 新增 TODO: "验证 LocalStorage 容量限制"

## 2026-03-06 · 交互简化
- **Discussion**: 优化下单流程。
- **Evidence**: [CNT-002] 用户反馈。
- **Outcome**: 移除确认弹窗，改为 Toast 撤回机制。
```

**Update trigger:** End of a meaningful discussion loop or session.

---

### docs/TODO.md

**Role:** The "Action List". Single source of truth for tasks.

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

### docs/01_STRATEGY/DECISIONS.md

**Role:** The "Rule Book". Human-readable record of business judgments.

```markdown
# Business Decisions — {project_id}

## DEC-001 · {Short decision title}
- **Date:** 2026-03-01
- **Context:** Based on [CNT-001]
- **Decision:** One sentence summary of what was decided
- **Rationale:** Why this direction, not alternatives
- **Trade-offs accepted:** What was explicitly de-prioritized
- **Residual risk:** Known open questions from this decision

---
```

**Written when:** Consensus Detection fires — user signals agreement on a business judgment.

**Critical rule:** DECISIONS are **never written without explicit user confirmation**. The AI may draft a decision, but it must present the draft and wait for the user to approve before writing to `DECISIONS.md`. If the decision overrides or conflicts with an existing Context entry, the decision must explicitly reference the affected `[CNT-XXX]` and state the override reason.

---

## Project Initialization Protocol

When a new `project_id` is mentioned for the first time, create this skeleton in one step:

```
{project_root}/
├── docs/
│   ├── 00_MEMORY/               ← [NEW] Explicit Memory
│   │   ├── CONTEXT_SNAPSHOT.md  ← Header + "事实快照库..."
│   │   └── SESSION_MEMORY.md    ← Header + "Project Session Log"
│   ├── 01_STRATEGY/             ← 立项与战略记忆
│   │   └── DECISIONS.md         ← empty, filled as business judgments are made
│   ├── 02_PRD/                  ← PRD docs — framework + feature level
│   │   ├── README.md            ← 目录与各 PRD 文件用途说明（不再承载 Framework PRD 正文）
│   │   └── framework-prd.md     ← 默认的 Framework PRD 主文档（可按项目约定更名）
│   ├── 03_DESIGN/               ← 设计与中间产物
│   │   ├── design-tokens.md     ← placeholder
│   │   ├── screens/
│   │   ├── handoff/
│   │   ├── ui_ux/
│   │   ├── prototypes/
│   │   ├── ai_prompts/
│   │   └── tech_design/
│   ├── 04_RESOURCES/            ← competitor research, raw inputs
│   └── TODO.md                  ← initialized with empty sections
```

**No .gitignore changes needed** (docs are meant to be committed).

Confirm to user: `"Project '{project_id}' initialized. Memory structure ready in docs/00_MEMORY/. PRD docs initialized in docs/02_PRD/ (README + framework-prd.md)."`

---

## Two-Layer Principle Within Layer 2

| Sub-layer | Records | Files |
|-----------|---------|-------|
| **Objective facts** | What happened & User's raw input | `docs/00_MEMORY/SESSION_MEMORY.md`, `docs/00_MEMORY/CONTEXT_SNAPSHOT.md` |
| **Logic assets** | Conclusions — decisions, flows, specs | `docs/01_STRATEGY/DECISIONS.md`, other `docs/` |

Facts layer = history. Logic layer = conclusions.

**When they conflict — stop and flag, do not auto-resolve.** The AI must:
1. Surface the conflict to the user: *"I noticed [DEC-XXX] may conflict with the earlier constraint [CNT-XXX] — here's what I see: [brief description]. How would you like to handle this?"*
2. Wait for the user's judgment.
3. If the user decides to override: record a new decision in `DECISIONS.md` that explicitly references `[CNT-XXX]` and explains why the override is justified.
4. The original Context entry is never deleted or modified — it remains as historical evidence.
