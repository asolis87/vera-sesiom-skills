# Vera Sesiom — Skills Repository

Repositorio de skills (instrucciones especializadas) para estandarizar el desarrollo de software en **Vera Sesiom**.

## Que son las Skills?

Las skills son documentos estructurados que codifican el ADN tecnico de la empresa: convenciones, arquitecturas, flujos de trabajo y reglas. Funcionan como **fuente unica de verdad** tanto para agentes AI como para desarrolladores humanos.

- **Agentes AI**: Consumen las skills automaticamente para ejecutar codigo siguiendo los estandares de la empresa.
- **Desarrolladores**: Las usan como referencia viva para entender como se trabaja en Vera Sesiom.

## Stack Tecnologico

| Capa | Tecnologia |
|------|-----------|
| Frontend | Vue 3 (Composition API) |
| Backend | Node.js (TypeScript) |
| Mobile | Flutter (Dart) |
| Infraestructura | AWS o VPS + Dokploy ([criterio de decision](skills/_shared/conventions.md#infraestructura---criterio-de-decision)) |
| Arquitectura | Hexagonal + Screaming Architecture |
| Estructura | Monorepo (pnpm workspaces + Turborepo) |

## Indice de Skills

### Fundamentos (Estrictos)

| Skill | Descripcion | Prescripcion |
|-------|------------|-------------|
| [hexagonal-architecture](skills/hexagonal-architecture/SKILL.md) | Arquitectura Hexagonal — capas, puertos, adaptadores | MUST |
| [monorepo-structure](skills/monorepo-structure/SKILL.md) | Estructura monorepo con pnpm + Turborepo | MUST |
| [git-workflow](skills/git-workflow/SKILL.md) | Git flow, branching, commits convencionales, PRs | MUST |

### Stack-Specific (Mix)

| Skill | Descripcion | Prescripcion |
|-------|------------|-------------|
| [vue-frontend](skills/vue-frontend/SKILL.md) | Vue 3 + Screaming Architecture + Atomic Design | Mix |
| [node-backend](skills/node-backend/SKILL.md) | Node.js + Hexagonal Architecture | Mix |
| [flutter-mobile](skills/flutter-mobile/SKILL.md) | Flutter + Clean Architecture | Mix |

### Calidad (Mix)

| Skill | Descripcion | Prescripcion |
|-------|------------|-------------|
| [testing-strategy](skills/testing-strategy/SKILL.md) | Estrategia de testing por stack | Mix |
| [code-review](skills/code-review/SKILL.md) | Checklist de code review | Guidelines |
| [api-design](skills/api-design/SKILL.md) | Convenciones REST API | MUST |

### Infraestructura y Seguridad

| Skill | Descripcion | Prescripcion |
|-------|------------|-------------|
| [aws-infra](skills/aws-infra/SKILL.md) | Convenciones AWS (CDK, Lambda, servicios managed) | Mix |
| [vps-dokploy](skills/vps-dokploy/SKILL.md) | Convenciones VPS + Dokploy (Docker, self-hosted) | Mix |
| [security-practices](skills/security-practices/SKILL.md) | Practicas de seguridad | MUST |

### Proceso

| Skill | Descripcion | Prescripcion |
|-------|------------|-------------|
| [documentation-standards](skills/documentation-standards/SKILL.md) | Estandares de documentacion y ADRs | Guidelines |
| [onboarding](skills/onboarding/SKILL.md) | Guia de onboarding para nuevos devs y agentes | Guidelines |

## Instalacion

### Instalador Automatico (recomendado)

El instalador detecta las herramientas AI instaladas y configura todo automaticamente.

```bash
# Clonar el repo
git clone https://github.com/vera-sesiom/vera-sesiom-skills.git
cd vera-sesiom-skills

# Instalacion interactiva (te pregunta que modo)
./install.sh

# O elegir directamente el modo:
./install.sh --project    # Solo en el proyecto actual
./install.sh --global     # Solo en las herramientas globales
./install.sh --all        # Ambos
```

Flags disponibles:

| Flag | Descripcion |
|------|------------|
| `--project`, `-p` | Instalar en el directorio actual |
| `--global`, `-g` | Instalar globalmente para todas las herramientas |
| `--all`, `-a` | Instalar en ambos |
| `--force`, `-f` | Sobreescribir sin preguntar |
| `--dry-run`, `-d` | Mostrar que se haria sin ejecutar |
| `--help`, `-h` | Mostrar ayuda |

### Herramientas Soportadas

| Herramienta | Proyecto | Global | Formato |
|-------------|----------|--------|---------|
| **OpenCode** | `AGENTS.md` | `~/.config/opencode/skills/` | AGENTS.md + skills |
| **Claude Code** | `CLAUDE.md` → `@AGENTS.md` | `~/.claude/skills/` | CLAUDE.md referencia |
| **Cursor** | `.cursor/rules/vera-sesiom.mdc` | `~/.cursor/skills/` | MDC rules |
| **VS Code Copilot** | `.github/copilot-instructions.md` | — | Instrucciones inline |
| **Windsurf** | `.windsurf/rules/vera-sesiom.md` | `~/.codeium/windsurf/skills/` | Rules con trigger |
| **OpenAI Codex** | `AGENTS.md` + `.agents/skills/` | `~/.agents/skills/` | AGENTS.md + skills |

### Desinstalar

```bash
./uninstall.sh           # Interactivo
./uninstall.sh --force   # Sin confirmaciones
```

### Instalacion Manual

Si preferis no usar el instalador:

```bash
# Copiar skills a tu herramienta (ejemplo: OpenCode)
cp -r skills/ ~/.config/opencode/skills/

# Copiar AGENTS.md a tu proyecto
cp AGENTS.md /path/to/your/project/
```

### Para Desarrolladores (referencia)

Navegar las skills como documentacion. Cada `SKILL.md` contiene:

1. **When to Use** — cuando aplica la skill
2. **Critical Rules** — reglas que NO se negocian
3. **Patterns** — patrones recomendados con ejemplos
4. **Commands** — comandos utiles copy-paste

## Niveles de Prescripcion

| Nivel | Significado |
|-------|------------|
| **MUST** | Obligatorio. No se negocia. Violarlo bloquea PRs. |
| **SHOULD** | Altamente recomendado. Necesitas justificacion para no seguirlo. |
| **MAY** | Opcional pero sugerido. Usa tu criterio. |

## Contribuir

1. Crear issue describiendo la skill o cambio propuesto
2. Branch: `feat/skill-name` o `fix/skill-name`
3. Seguir la estructura de `SKILL.md` (ver cualquier skill existente como ejemplo)
4. PR con review de al menos 1 tech lead

## Licencia

Propiedad de Vera Sesiom. Uso interno.
