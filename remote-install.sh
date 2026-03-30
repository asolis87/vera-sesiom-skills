#!/usr/bin/env bash
set -euo pipefail

# ─── Colors ───────────────────────────────────────────────────────────────────

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

# ─── Config ───────────────────────────────────────────────────────────────────

REPO_URL="https://github.com/asolis87/vera-sesiom-skills.git"
TMPDIR_PREFIX="vera-sesiom-skills"

# ─── Cleanup trap ─────────────────────────────────────────────────────────────

CLONE_DIR=""

cleanup() {
    if [ -n "$CLONE_DIR" ] && [ -d "$CLONE_DIR" ]; then
        eaction "Cleaning up temporary files..."
        rm -rf "$CLONE_DIR"
        einfo "Temporary files removed"
    fi
}

trap cleanup EXIT

# ─── Banner ───────────────────────────────────────────────────────────────────

echo ""
ebold "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
ebold "  ${MAGENTA}Vera Sesiom Skills — Remote Installer${RESET}"
ebold "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# ─── Check prerequisites ─────────────────────────────────────────────────────

if ! command -v git &>/dev/null; then
    eerror "git is not installed. Please install git first:"
    echo ""
    echo "    macOS:  brew install git"
    echo "    Ubuntu: sudo apt install git"
    echo "    Fedora: sudo dnf install git"
    echo ""
    exit 1
fi

# ─── Create temp directory ────────────────────────────────────────────────────

CLONE_DIR="$(mktemp -d "${TMPDIR:-/tmp}/${TMPDIR_PREFIX}-XXXXXX")"
eaction "Created temporary directory: ${CLONE_DIR}"

# ─── Clone repository ────────────────────────────────────────────────────────

eaction "Cloning vera-sesiom-skills (shallow clone)..."
if ! git clone --depth 1 "$REPO_URL" "$CLONE_DIR" 2>&1; then
    eerror "Failed to clone repository from: ${REPO_URL}"
    echo ""
    echo "  Possible causes:"
    echo "    • No internet connection"
    echo "    • Repository URL changed or is private"
    echo "    • GitHub is down"
    echo ""
    exit 1
fi
einfo "Repository cloned successfully"

# ─── Run installer ────────────────────────────────────────────────────────────

INSTALLER="${CLONE_DIR}/install.sh"

if [ ! -f "$INSTALLER" ]; then
    eerror "install.sh not found in cloned repository"
    exit 1
fi

chmod +x "$INSTALLER"

echo ""
eaction "Running installer..."
echo ""

# Default to --project mode when no arguments are provided, since the user
# is most likely running this from their project directory.
if [ $# -eq 0 ]; then
    ewarn "No flags provided — defaulting to ${BOLD}--project${RESET} mode"
    echo ""
    "$INSTALLER" --project
else
    "$INSTALLER" "$@"
fi

# ─── Done (cleanup runs automatically via trap) ──────────────────────────────

echo ""
einfo "${BOLD}Remote installation complete!${RESET}"
echo ""
