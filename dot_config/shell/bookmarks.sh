# Turns bm-dirs and bm-files into shortcuts. Sourced by both bash and zsh.

_bm_expand() { case "$1" in "~") printf '%s' "$HOME" ;; "~/"*) printf '%s' "$HOME/${1#\~/}" ;; *) printf '%s' "$1" ;; esac; }

# Open a bookmarked file: through chezmoi when it manages the file, else directly
_bm_edit() {
  if command -v chezmoi >/dev/null 2>&1 && chezmoi source-path "$1" >/dev/null 2>&1; then
    chezmoi edit --apply "$1"
  else
    "${EDITOR:-nvim}" "$1"
  fi
}

if [ -r "$HOME/.config/shell/bm-dirs" ]; then
  while read -r _bm_name _bm_path; do
    case "$_bm_name" in ''|\#*) continue ;; esac
    _bm_path=$(_bm_expand "$_bm_path")
    [ -d "$_bm_path" ] || continue
    alias "$_bm_name=cd \"$_bm_path\""
    [ -n "${ZSH_VERSION:-}" ] && hash -d "$_bm_name=$_bm_path"
  done < "$HOME/.config/shell/bm-dirs"
fi

if [ -r "$HOME/.config/shell/bm-files" ]; then
  while read -r _bm_name _bm_path; do
    case "$_bm_name" in ''|\#*) continue ;; esac
    alias "$_bm_name=_bm_edit \"$(_bm_expand "$_bm_path")\""
  done < "$HOME/.config/shell/bm-files"
fi

unset _bm_name _bm_path
