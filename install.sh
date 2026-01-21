#!/usr/bin/env bash
set -euo pipefail

if [[ -t 1 ]]; then
  RED=$'\033[0;31m'
  GREEN=$'\033[0;32m'
  YELLOW=$'\033[1;33m'
  NC=$'\033[0m'
else
  RED=""
  GREEN=""
  YELLOW=""
  NC=""
fi

log() { printf "%s%s%s\n" "${GREEN}" "$*" "${NC}"; }
warn() { printf "%s%s%s\n" "${YELLOW}" "$*" "${NC}" >&2; }
die() { printf "%sError:%s %s\n" "${RED}" "${NC}" "$*" >&2; exit 1; }
have() { command -v "$1" >/dev/null 2>&1; }

REPO_URL="https://github.com/harivansh-afk/nvim.git"
SKIP_NVIM=0
SKIP_CONFIG=0
NO_PATH=0
FULL_INSTALL=0

while [[ $# -gt 0 ]]; do
  case "$1" in
    --repo)
      [[ $# -ge 2 ]] || die "--repo requires a value"
      REPO_URL="$2"
      shift 2
      ;;
    --skip-nvim) SKIP_NVIM=1; shift ;;
    --skip-config) SKIP_CONFIG=1; shift ;;
    --no-path) NO_PATH=1; shift ;;
    --bells-and-whistles) FULL_INSTALL=1; shift ;;
    -h|--help)
      cat <<'EOF'
Usage: install.sh [options]

Options:
  --repo URL            Clone config from URL (default: repo in this script)
  --skip-nvim           Do not install Neovim
  --skip-config         Do not install config
  --no-path             Do not modify shell rc files
  --bells-and-whistles  Full install with LSP and AI completion (default: minimal)
EOF
      exit 0
      ;;
    *)
      die "Unknown argument: $1 (use --help)"
      ;;
  esac
done

OS="$(uname -s)"
ARCH_RAW="$(uname -m)"
case "$OS" in
  Darwin) OS="macos" ;;
  Linux) OS="linux" ;;
  *) die "Unsupported OS: $OS" ;;
esac

case "$ARCH_RAW" in
  x86_64|amd64) ARCH="x86_64" ;;
  arm64|aarch64) ARCH="arm64" ;;
  *) die "Unsupported architecture: $ARCH_RAW" ;;
esac

LOCAL_BIN="${HOME}/.local/bin"
LOCAL_NVIM_DIR="${HOME}/.local/nvim"
CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/nvim"
BACKUP_DIR="${CONFIG_DIR}.backup.$(date +%Y%m%d_%H%M%S)"

require_downloader() {
  if have curl; then
    DOWNLOADER="curl"
  elif have wget; then
    DOWNLOADER="wget"
  else
    die "Missing downloader: install curl or wget"
  fi
}

download() {
  local url="$1"
  local dest="$2"
  if [[ "${DOWNLOADER}" == "curl" ]]; then
    curl -fsSL "$url" -o "$dest"
  else
    wget -q --show-progress -O "$dest" "$url"
  fi
}

ensure_local_bin_path() {
  export PATH="${LOCAL_BIN}:${PATH}"
  [[ "$NO_PATH" -eq 1 ]] && return 0

  local export_line='export PATH="$HOME/.local/bin:$PATH"'
  local rc_candidates=()
  case "${SHELL:-}" in
    */zsh) rc_candidates+=("$HOME/.zshrc") ;;
    */bash) rc_candidates+=("$HOME/.bashrc") ;;
    *) rc_candidates+=("$HOME/.zshrc" "$HOME/.bashrc") ;;
  esac

  for rc in "${rc_candidates[@]}"; do
    [[ -f "$rc" ]] || continue
    if ! grep -qF "$export_line" "$rc" 2>/dev/null; then
      printf "\n%s\n" "$export_line" >> "$rc"
      log "Added ~/.local/bin to PATH in $(basename "$rc")"
    fi
  done
}

install_nvim_macos_tarball() {
  require_downloader
  mkdir -p "$LOCAL_BIN"

  local tmp
  tmp="$(mktemp -d 2>/dev/null || mktemp -d -t nvim-install)"
  trap 'rm -rf "$tmp"' EXIT

  local tarball="${tmp}/nvim.tar.gz"
  local urls=(
    "https://github.com/neovim/neovim/releases/download/stable/nvim-macos-${ARCH}.tar.gz"
    "https://github.com/neovim/neovim/releases/download/stable/nvim-macos.tar.gz"
  )

  local downloaded=0
  for url in "${urls[@]}"; do
    if download "$url" "$tarball" 2>/dev/null; then
      downloaded=1
      break
    fi
  done
  [[ "$downloaded" -eq 1 ]] || die "Failed to download Neovim for macOS (${ARCH})"

  tar -xzf "$tarball" -C "$tmp"
  local extracted_dir
  extracted_dir="$(find "$tmp" -maxdepth 2 -type f -path '*/bin/nvim' -print -quit | xargs -I{} dirname "{}" | xargs -I{} dirname "{}")"
  [[ -n "$extracted_dir" ]] || die "Downloaded archive did not contain bin/nvim"

  rm -rf "$LOCAL_NVIM_DIR"
  mv "$extracted_dir" "$LOCAL_NVIM_DIR"
  ln -sf "${LOCAL_NVIM_DIR}/bin/nvim" "${LOCAL_BIN}/nvim"
}

install_nvim_linux_appimage() {
  require_downloader
  mkdir -p "$LOCAL_BIN"

  local tmp
  tmp="$(mktemp -d 2>/dev/null || mktemp -d -t nvim-install)"
  trap 'rm -rf "$tmp"' EXIT

  local appimage="${tmp}/nvim.appimage"
  local url="https://github.com/neovim/neovim/releases/download/stable/nvim-linux-${ARCH}.appimage"
  download "$url" "$appimage" || die "Failed to download Neovim AppImage for Linux (${ARCH})"
  chmod u+x "$appimage"

  (cd "$tmp" && ./nvim.appimage --appimage-extract >/dev/null 2>&1) || true

  if [[ -d "${tmp}/squashfs-root" ]]; then
    rm -rf "$LOCAL_NVIM_DIR"
    mv "${tmp}/squashfs-root" "$LOCAL_NVIM_DIR"
    ln -sf "${LOCAL_NVIM_DIR}/AppRun" "${LOCAL_BIN}/nvim"
  else
    mv "$appimage" "${LOCAL_BIN}/nvim"
    chmod u+x "${LOCAL_BIN}/nvim"
  fi
}

install_nvim() {
  if have nvim; then
    log "Neovim already installed: $(nvim --version | head -1)"
    return 0
  fi

  log "Neovim not found; installing (no sudo)..."
  ensure_local_bin_path

  if [[ "$OS" == "macos" ]]; then
    if have brew; then
      if brew list neovim >/dev/null 2>&1; then
        brew upgrade neovim >/dev/null || true
      else
        brew install neovim
      fi
    else
      install_nvim_macos_tarball
    fi
  else
    install_nvim_linux_appimage
  fi

  ensure_local_bin_path
  have nvim || die "Neovim install completed but 'nvim' is not on PATH"
  log "Neovim version: $(nvim --version | head -1)"
}

install_config() {
  have git || die "git is required (install git first)"
  mkdir -p "$(dirname "$CONFIG_DIR")"

  if [[ -d "$CONFIG_DIR" ]]; then
    if [[ -d "${CONFIG_DIR}/.git" ]]; then
      local remote
      remote="$(git -C "$CONFIG_DIR" remote get-url origin 2>/dev/null || true)"
      if [[ "$remote" == "$REPO_URL" ]]; then
        if git -C "$CONFIG_DIR" diff --quiet && git -C "$CONFIG_DIR" diff --cached --quiet; then
          log "Updating existing config in ${CONFIG_DIR}..."
          git -C "$CONFIG_DIR" pull --ff-only || true
          mkdir -p "${CONFIG_DIR}/undodir"
          return 0
        fi
      fi
    fi

    warn "Backing up existing config to ${BACKUP_DIR}"
    mv "$CONFIG_DIR" "$BACKUP_DIR"
  fi

  log "Cloning config into ${CONFIG_DIR}..."
  git clone "$REPO_URL" "$CONFIG_DIR"
  mkdir -p "${CONFIG_DIR}/undodir"
}

strip_heavy_plugins() {
  local plugins_dir="${CONFIG_DIR}/lua/plugins"
  local heavy_plugins=(
    "supermaven.lua"
    "lsp.lua"
  )
  for plugin in "${heavy_plugins[@]}"; do
    if [[ -f "${plugins_dir}/${plugin}" ]]; then
      rm "${plugins_dir}/${plugin}"
      log "Removed ${plugin} (minimal install)"
    fi
  done
}

log "Installing nvim config from ${REPO_URL} (${OS}/${ARCH})"
ensure_local_bin_path

if [[ "$SKIP_NVIM" -eq 0 ]]; then
  install_nvim
fi

if [[ "$SKIP_CONFIG" -eq 0 ]]; then
  install_config
  if [[ "$FULL_INSTALL" -eq 0 ]]; then
    strip_heavy_plugins
  fi
fi

if have nvim; then
  # Basic sanity check: confirm Neovim can start headlessly.
  nvim --headless "+qall" >/dev/null 2>&1 || warn "Neovim failed to start headlessly; run 'nvim' to see errors."
fi

log "Done."
if [[ "$NO_PATH" -eq 0 ]]; then
  warn "Open a new terminal (or 'source' your shell rc) if 'nvim' isn't found."
fi
