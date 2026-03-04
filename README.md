# AI Product Manager

**An AI strategic partner that guides you from fuzzy ideas to shipped products.**
**一个引导你完成从模糊想法到产品交付全过程的 AI 战略伙伴。**

---

## Introduction / 简介

**AI Product Manager** is not just a chatbot; it acts as a **Senior Product Manager agent** living in your IDE (Cursor / Claude Code). It bridges the gap between "PM work", "Design work", and "Dev work", guiding you through the full product delivery chain.

**AI Product Manager** 不是一个聊天机器人，它是驻留在你 IDE（Cursor / Claude Code）中的**资深产品经理智能体**。它旨在消除“产品经理”、“设计师”和“开发人员”之间的隔阂，引导你完成全链路的产品交付。

> **Core Belief:** PRDs are not written. They *emerge* as understanding deepens.
>
> **核心理念：** PRD 不是写出来的，而是随着理解的加深而*涌现*的。

---

## Why I built this / 初心

> 这个文档里只有这段是手写的，写这句话就是希望吸引你花30s读一下这段话
> This is the only section of this documentation written by a human. I hope it’s worth 30 seconds of your time.

我为什么要做这个项目？

AI能替代人类完成很多工作已经成为一个共识，目前只是还需要在如何重新定义工作和组织上花点时间。

我作为一个前大厂的产品经理，虽然也体会到了AI在一些场景下的帮助，但我自己的工作并没有被完全颠覆掉，我希望**加速**这一天的到来，让我从工作中的脏活累活里面解脱出来，从而能更关注我的工作中那些**没有被清晰定义的事情**，然后有更多时间追求**humanity**。

希望大家用得开心，也希望我们都能早点从“生存”中毕业


Why I Built This Project? 

It is now a consensus that AI will eventually replace most human labor; we are simply in a transitional phase of redefining "work" and "organizations."

As a former Product Manager from a Tech background, I’ve felt the assistance of AI in fragmented scenarios, but my core workflow has yet to be fully disrupted. I want to accelerate that disruption. 

My goal is to liberate us from the "grunt work"—the repetitive and mundane—so we can dedicate our energy to the undefined challenges and reclaim more time for humanity.

I hope you find this tool useful. May we all "graduate" from the struggle for survival sooner rather than later.

---

## Core Capabilities / 核心能力

The skill divides the product delivery process into 5 continuous **Scenes**, providing professional guidance in each:
本技能将产品交付过程划分为 5 个连续的**场景（Scenes）**，并在每个场景中提供专业的引导：

### 1. Value Discovery / 价值发现
- **Goal:** Mine for truth, reject fake needs, and establish a "Tangible Anchor".
- **Output:** Strategy Doc & Value Decisions.
- **目标：** 挖掘真实痛点，拒绝伪需求，确立“价值锚点”（Tangible Anchor）。
- **产出：** 立项文档与价值决策。

### 2. Logic Structuring / 逻辑梳理
- **Goal:** Design Critical User Journeys (CUJs) and define MVP scope based on scenarios (not feature lists).
- **Output:** Framework PRD.
- **目标：** 设计关键用户旅程（CUJs），定义 MVP 范围（基于场景而非功能列表）。
- **产出：** Framework PRD（框架层需求文档）。

### 3. Entity Definition / 实体定义
- **Goal:** Abstract data models from business flows; design State Machines.
- **Output:** Entity Graphs & State Tables.
- **目标：** 基于业务流定义数据模型，设计状态机（State Machines）和流转规则。
- **产出：** 实体关系图与状态表。

### 4. Interaction Design / 交互设计
- **Goal:** Define the Screen Tree and validate cross-module consistency.
- **Output:** Interaction Logic & Screen Hierarchy.
- **目标：** 定义屏幕流（Screen Tree），检查模块间的交互一致性。
- **产出：** 交互逻辑与页面层级。

### 5. Design & Handoff / 设计与交付
- **Goal:** Generate high-fidelity HTML Mockups and write detailed Handoff Notes for developers.
- **Output:** Previewable UI & Dev Specs.
- **目标：** 生成高保真 HTML Mockups，编写给开发的详细交付说明（Handoff Notes）。
- **产出：** 可直接预览的 UI 界面与开发文档。

---

## Installation / 安装指南

### Option 1: Cursor (Recommended / 推荐)

1.  Locate your Cursor skills directory (usually `~/.cursor/skills/`). Create it if it doesn't exist.
    找到你的 Cursor 技能目录（通常在 `~/.cursor/skills/`，如果没有请新建）。
2.  Clone or copy this repository into that directory:
    将本仓库克隆或复制到该目录下：
    ```bash
    git clone https://github.com/your-username/ai-pm.git ~/.cursor/skills/ai_pm
    ```
3.  **Usage:** In Cursor, enable it in `Settings` -> `General` -> `Rules for AI`, or simply call it via `@ai_pm` in chat (depending on your Cursor version).
    **使用：** 在 Cursor 中，你可以在设置中启用，或者直接在对话中通过 `@ai_pm` 调用（取决于 Cursor 版本支持的导入方式）。
    *   *Note: You can also copy the content of `SKILL.md` into your `.cursorrules` or System Prompt.*
    *   *注：你也可以直接将 `SKILL.md` 的内容复制到你的 `.cursorrules` 或系统提示词中。*

### Option 2: Claude Code

1.  Ensure [Claude Code](https://docs.anthropic.com/en/docs/claude-code/overview) is installed.
    确保你已安装 Claude Code。
2.  Copy this repository to Claude's skills directory:
    将本仓库复制到 Claude 的技能目录：
    ```bash
    cp -r ai-pm/ ~/.claude/skills/ai-pm/
    ```
3.  Trigger it naturally in conversation.
    在对话中直接通过自然语言触发。

---

## Usage / 使用方法

Activate the AI PM in your chat using these triggers:
在对话中，你可以通过以下方式激活 AI PM：

*   **Start a new idea / 启动新想法**
    *   "I have a product idea..."
    *   "帮我梳理一个新产品的思路..."
*   **Design a feature / 设计功能**
    *   "Help me design the user flow for..."
    *   "设计一个注册流程..."
*   **Write PRD / 编写 PRD**
    *   "Write a PRD for..."
*   **Generate UI / 生成界面**
    *   "Make a mockup for this screen..."
*   **Adjust Workflow / 调整工作流**
    *   Type `[Meta]` to discuss or modify how the AI PM works.
    *   输入 `[Meta]` 来讨论和调整 AI PM 的工作方式。

### Project Initialization / 项目初始化

When used in a new directory, it will suggest initializing the project structure:
当你第一次在一个新目录中使用时，它会自动建议初始化项目结构：

```text
.ai_pm/             # Project Memory (Auto-maintained, add to .gitignore) / 项目记忆（自动维护，请忽略）
docs/               # Project Deliverables / 项目文档
  01_STRATEGY/      # Strategy & Value / 立项与战略
  02_PRD/           # Requirements / 需求文档
  03_DESIGN/        # Design & Specs / 设计稿与交付说明
  04_RESOURCES/     # Research & References / 参考资料
```

---

## Contributing / 贡献

We welcome Issues and Pull Requests!
欢迎提交 Issue 或 Pull Request 来改进工作流！

1.  Fork this repository.
2.  Create your feature branch (`git checkout -b feature/AmazingFeature`).
3.  Commit your changes (`git commit -m 'Add some AmazingFeature'`).
4.  Push to the branch (`git push origin feature/AmazingFeature`).
5.  Open a Pull Request.

---

## License / 许可证

**CC BY-NC 4.0**
(Creative Commons Attribution-NonCommercial 4.0 International)

You are free to:
- **Share** — copy and redistribute the material in any medium or format.
- **Adapt** — remix, transform, and build upon the material.

Under the following terms:
- **Attribution** — You must give appropriate credit. (保留署名)
- **NonCommercial** — You may not use the material for commercial purposes. (不可用于商业用途/卖钱)
- **No additional restrictions** — You may not apply legal terms or technological measures that legally restrict others from doing anything the license permits.

See [LICENSE](LICENSE) for the full text.
详见 [LICENSE](LICENSE) 文件。
