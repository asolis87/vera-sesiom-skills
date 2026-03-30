# Vera Sesiom Skills

**Standardized AI agent skills and development conventions for Vera Sesiom** — covering architecture, workflows, and best practices across Vue, Node, Flutter, Astro, and AWS/VPS infrastructure.

![Skills: 15](https://img.shields.io/badge/Skills-15-2563eb)
![Tools: 6](https://img.shields.io/badge/Tools_Supported-6-16a34a)
![License: Proprietary](https://img.shields.io/badge/License-Proprietary-6b7280)
![Architecture: Hexagonal](https://img.shields.io/badge/Architecture-Hexagonal-7c3aed)

---

## What Are Skills?

Skills are structured documents that encode the **technical DNA** of the organization: conventions, architectures, workflows, and rules. They serve as a **single source of truth** for both AI agents and human developers.

- **AI Agents** consume skills automatically to generate code that follows company standards — no prompt engineering required.
- **Developers** use them as living documentation to understand how things are built at Vera Sesiom.

Each `SKILL.md` contains four sections:
1. **When to Use** — context triggers for the skill
2. **Critical Rules** — non-negotiable constraints
3. **Patterns** — recommended patterns with examples
4. **Commands** — copy-paste ready commands

---

## How It Works

```
vera-sesiom-skills repo
        │
        ▼
   install.sh
        │
        ├── Detects installed AI tools (OpenCode, Claude, Cursor, etc.)
        │
        ├── --project  → Installs into current project directory
        ├── --global   → Installs into each tool's global config
        └── --all      → Both project + global
```

The installer reads which AI coding tools you have installed, then copies the skills and configuration files into each tool's expected location — no manual setup needed.

---

## Quick Start

```bash
git clone https://github.com/vera-sesiom/vera-sesiom-skills.git && cd vera-sesiom-skills && ./install.sh --all
```

Or step by step:

```bash
# 1. Clone the repository
git clone https://github.com/vera-sesiom/vera-sesiom-skills.git
cd vera-sesiom-skills

# 2. Run the interactive installer
./install.sh

# 3. That's it — your AI tools now follow Vera Sesiom conventions
```

---

## Tech Stack

| Layer | Technology |
|-------|-----------|
| **Frontend** | Vue 3 (Composition API) |
| **Backend** | Node.js (TypeScript) |
| **Mobile** | Flutter (Dart) |
| **Infrastructure** | AWS or VPS + Dokploy ([decision criteria](skills/_shared/conventions.md#infraestructura---criterio-de-decision)) |
| **Architecture** | Hexagonal + Screaming Architecture |
| **Structure** | Monorepo (pnpm workspaces + Turborepo) |

---

## Skills Index

### Foundations — Strict

> These are non-negotiable. Every project follows them.

| Skill | Description | Level |
|-------|------------|-------|
| [hexagonal-architecture](skills/hexagonal-architecture/SKILL.md) | Hexagonal Architecture — layers, ports, adapters | **MUST** |
| [monorepo-structure](skills/monorepo-structure/SKILL.md) | Monorepo structure with pnpm + Turborepo | **MUST** |
| [git-workflow](skills/git-workflow/SKILL.md) | Git flow, branching, conventional commits, PRs | **MUST** |

### Stack-Specific

> One skill per technology in the stack. Mix of strict and recommended rules.

| Skill | Description | Level |
|-------|------------|-------|
| [astro-landing](skills/astro-landing/SKILL.md) | Astro for landing pages, content sites, SSG | Mix |
| [vue-frontend](skills/vue-frontend/SKILL.md) | Vue 3 + Screaming Architecture + Atomic Design | Mix |
| [node-backend](skills/node-backend/SKILL.md) | Node.js + Hexagonal Architecture | Mix |
| [flutter-mobile](skills/flutter-mobile/SKILL.md) | Flutter + Clean Architecture | Mix |

### Quality & API

> Testing, reviews, and API design conventions.

| Skill | Description | Level |
|-------|------------|-------|
| [testing-strategy](skills/testing-strategy/SKILL.md) | Testing strategy per stack | Mix |
| [code-review](skills/code-review/SKILL.md) | Code review checklist | Guidelines |
| [api-design](skills/api-design/SKILL.md) | REST API conventions | **MUST** |

### Infrastructure & Security

> Cloud, deployment, and security practices.

| Skill | Description | Level |
|-------|------------|-------|
| [aws-infra](skills/aws-infra/SKILL.md) | AWS conventions (CDK, Lambda, managed services) | Mix |
| [vps-dokploy](skills/vps-dokploy/SKILL.md) | VPS + Dokploy conventions (Docker, self-hosted) | Mix |
| [security-practices](skills/security-practices/SKILL.md) | Security practices | **MUST** |

### Process

> Documentation and onboarding for humans and agents.

| Skill | Description | Level |
|-------|------------|-------|
| [documentation-standards](skills/documentation-standards/SKILL.md) | Documentation standards and ADRs | Guidelines |
| [onboarding](skills/onboarding/SKILL.md) | Onboarding guide for new devs and agents | Guidelines |

---

## Prescription Levels

| Level | Meaning |
|-------|---------|
| **MUST** | Mandatory. Non-negotiable. Violations block PRs. |
| **SHOULD** | Highly recommended. You need justification to skip it. |
| **MAY** | Optional but suggested. Use your judgment. |

---

## Installation

### Automatic Installer (recommended)

The installer detects your installed AI tools and configures everything automatically.

```bash
./install.sh            # Interactive — asks which mode
./install.sh --project  # Install in current project only
./install.sh --global   # Install globally for all tools
./install.sh --all      # Both project + global
```

#### Installer Flags

| Flag | Description |
|------|------------|
| `--project`, `-p` | Install in the current directory |
| `--global`, `-g` | Install globally for all detected tools |
| `--all`, `-a` | Install in both project and global |
| `--force`, `-f` | Overwrite existing files without asking |
| `--dry-run`, `-d` | Show what would be done without executing |
| `--help`, `-h` | Show help |

### Manual Installation

If you prefer not to use the installer:

```bash
# Copy skills to your tool (example: OpenCode)
cp -r skills/ ~/.config/opencode/skills/

# Copy AGENTS.md to your project
cp AGENTS.md /path/to/your/project/
```

### Uninstall

```bash
./uninstall.sh           # Interactive
./uninstall.sh --force   # No confirmations
```

---

## Supported Tools

| Tool | Project-level | Global | Format |
|------|:---:|:---:|--------|
| **OpenCode** | `AGENTS.md` | `~/.config/opencode/skills/` | AGENTS.md + skills directory |
| **Claude Code** | `CLAUDE.md` → `@AGENTS.md` | `~/.claude/skills/` | CLAUDE.md reference |
| **Cursor** | `.cursor/rules/vera-sesiom.mdc` | `~/.cursor/skills/` | MDC rules |
| **VS Code Copilot** | `.github/copilot-instructions.md` | — | Inline instructions |
| **Windsurf** | `.windsurf/rules/vera-sesiom.md` | `~/.codeium/windsurf/skills/` | Rules with trigger |
| **OpenAI Codex** | `AGENTS.md` + `.agents/skills/` | `~/.agents/skills/` | AGENTS.md + skills directory |

---

## For Developers (Reference)

You don't need an AI tool to benefit from skills. Browse them as documentation:

```
skills/
├── _shared/conventions.md    ← Global conventions (start here)
├── hexagonal-architecture/   ← Architecture patterns
├── vue-frontend/             ← Vue 3 patterns
├── node-backend/             ← Node.js patterns
├── flutter-mobile/           ← Flutter patterns
└── ...                       ← 15 skills total
```

---

## Contributing

1. Create an issue describing the proposed skill or change
2. Branch: `feat/skill-name` or `fix/skill-name`
3. Follow the `SKILL.md` structure (use any existing skill as a template)
4. Open a PR with review from at least 1 tech lead

---

## License

Proprietary — Vera Sesiom. Internal use only.

---

<p align="center"><sub>Built and maintained by <strong>Vera Sesiom</strong></sub></p>
