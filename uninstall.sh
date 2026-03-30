#!/usr/bin/env bash
set -euo pipefail

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
BOLD='\033[1m'
RESET='\033[0m'

if [ ! -t 1 ]; then
    RED='' GREEN='' YELLOW='' BLUE='' MAGENTA='' CYAN='' BOLD='' RESET=''
fi

einfo() { echo -e "${GREEN}✓${RESET} $*"; }
eerror() { echo -e "${RED}✗${RESET} $*"; }
ewarn() { echo -e "${YELLOW}⚠${RESET} $*"; }
eaction() { echo -e "${CYAN}→${RESET} $*"; }
ebold() { echo -e "${BOLD}$*${RESET}"; }

usage() {
    cat <<EOF
${BOLD}Vera Sesiom Skills Uninstaller${RESET}

${BOLD}USAGE${RESET}
    $(basename "$0") [OPTIONS]

${BOLD}OPTIONS${RESET}
    -f, --force    Skip confirmation prompts
    -h, --help     Show this help message

${BOLD}DESCRIPTION${RESET}
    Removes Vera Sesiom AI agent skills from global tool directories
    and project-level files created by install.sh.

    Note: Does NOT remove AGENTS.md (may contain customizations).

${BOLD}EXAMPLES${RESET}
    $(basename "$0")            # Interactive mode
    $(basename "$0") --force    # Remove without asking

EOF
    exit 0
}

FORCE=false

while [[ $# -gt 0 ]]; do
    case "$1" in
        -f|--force) FORCE=true ;;
        -h|--help) usage ;;
        *) eerror "Unknown option: $1"; usage ;;
    esac
    shift
done

prompt_confirm() {
    if [ "$FORCE" = "true" ]; then return 0; fi
    printf "  ${YELLOW}%s${RESET} [y/N] " "$1"
    local ans
    read -r ans
    if [ "$ans" != "y" ] && [ "$ans" != "Y" ]; then
        return 1
    fi
    return 0
}

remove_path() {
    local path="$1"
    local desc="$2"
    if [ -e "$path" ]; then
        if prompt_confirm "Remove $desc?"; then
            rm -rf "$path"
            einfo "Removed: $path"
        else
            ewarn "Skipped: $path"
        fi
    else
        ewarn "Not found (skipping): $path"
    fi
}

remove_global() {
    echo ""
    ebold "━━━ ${MAGENTA}Global Uninstall${RESET} ━━━"

    remove_path "$HOME/.config/opencode/skills" "OpenCode skills"
    remove_path "$HOME/.claude/skills" "Claude Code skills"
    remove_path "$HOME/.cursor/skills" "Cursor skills"
    remove_path "$HOME/.codeium/windsurf/skills" "Windsurf skills"
    remove_path "$HOME/.agents/skills" "Codex skills"
}

remove_project() {
    echo ""
    ebold "━━━ ${MAGENTA}Project-Level Uninstall${RESET} ━━━"

    if [ -f "./CLAUDE.md" ]; then
        remove_path "./CLAUDE.md" "CLAUDE.md"
    fi

    if [ -f "./.cursor/rules/vera-sesiom.mdc" ]; then
        remove_path "./.cursor/rules/vera-sesiom.mdc" "Cursor rule"
    fi

    if [ -f "./.github/copilot-instructions.md" ]; then
        remove_path "./.github/copilot-instructions.md" "Copilot instructions"
    fi

    if [ -f "./.windsurf/rules/vera-sesiom.md" ]; then
        remove_path "./.windsurf/rules/vera-sesiom.md" "Windsurf rule"
    fi

    remove_path "./.claude/skills" "Claude Code project skills"
    remove_path "./.agents/skills" "Codex project skills"
    remove_path "./.windsurf/skills" "Windsurf project skills"
}

print_warnings() {
    echo ""
    ebold "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    ebold "  ${YELLOW}Warnings${RESET}"
    ebold "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""
    echo "  ${YELLOW}⚠${RESET} AGENTS.md was NOT removed (may contain customizations)"
    echo "    If you want it gone, remove it manually:"
    echo "    ${CYAN}rm AGENTS.md${RESET}"
    echo ""
    echo "  ${YELLOW}⚠${RESET} Empty directories may remain:"
    echo "    ${CYAN}.cursor/rules/${RESET}"
    echo "    ${CYAN}.github/${RESET}"
    echo "    ${CYAN}.windsurf/rules/${RESET}"
    echo "    ${CYAN}.claude/${RESET}"
    echo "    ${CYAN}.agents/${RESET}"
    echo "    ${CYAN}.windsurf/${RESET}"
    echo ""
    echo "    Clean up with:"
    echo "    ${CYAN}rm -rf .cursor .github .windsurf .claude .agents${RESET}"
    echo ""
}

echo ""
ebold "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
ebold "  ${MAGENTA}Vera Sesiom Skills Uninstaller${RESET}"
ebold "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

if ! prompt_confirm "Remove global skills?"; then
    ewarn "Global uninstall cancelled"
else
    remove_global
fi

if ! prompt_confirm "Remove project-level files?"; then
    ewarn "Project-level uninstall cancelled"
else
    remove_project
fi

if [ "$FORCE" = "true" ]; then
    print_warnings
else
    echo ""
    if prompt_confirm "Show cleanup warnings?"; then
        print_warnings
    fi
fi

echo ""
einfo "Uninstall complete!"
echo ""
