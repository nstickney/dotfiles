#!/bin/bash

# Create a bar showing a percentage: render_bar <percent> [blocks,default=10]
render_bar() {
  # Sub-character precision: 8 steps per cell using eighth-block characters
  local PARTIALS=("" "▏" "▎" "▍" "▌" "▋" "▊" "▉")
  local pct=$1
  local width=$2
  [ -n "$width" ] || width=10
  local units=$((pct * width * 8 / 100))
  local full=$((units / 8))
  local partial=$((units % 8))
  local empty=$((width - full - (partial > 0 ? 1 : 0)))

  local bar=""
  if [ "$pct" -ge 85 ]; then
    bar=$'\e[31;100m'
  elif [ "$pct" -ge 70 ]; then
    bar=$'\e[33;100m'
  else
    bar=$'\e[32;100m'
  fi

  for ((i = 0; i < full; i++)); do bar="${bar}█"; done
  [ "$partial" -gt 0 ] && bar="${bar}${PARTIALS[$partial]}"
  if [ "$empty" -gt 0 ]; then
    for ((i = 0; i < empty; i++)); do bar="${bar} "; done
  fi
  bar="${bar}"$'\e[0m'
  echo -n "$bar"
}

# Read all of stdin into a variable
input=$(cat)

# Extract fields with jq, "// 0" provides fallback for null
# https://code.claude.com/docs/en/statusline#available-data
MODEL=$(echo "$input" | jq -r '.model.display_name')
PCT=$(echo "$input" | jq -r '.context_window.used_percentage // 0' | cut -d. -f1)
USAGE_5H=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // 0')
RESET_5H=$(echo "$input" | jq -r '.rate_limits.five_hour.resets_at // empty')
USAGE_7D=$(echo "$input" | jq -r '.rate_limits.seven_day.used_percentage // 0')
RESET_7D=$(echo "$input" | jq -r '.rate_limits.seven_day.resets_at // empty')
CWD=$(echo "$input" | jq -r '.cwd // empty')

# Git Status
GSP=""
if [[ -n "$CWD" ]] && git -C "$CWD" rev-parse --is-inside-work-tree &>/dev/null; then
  local_branch=$(git -C "$CWD" symbolic-ref --short HEAD 2>/dev/null)
  tag=$(git -C "$CWD" describe --tags --exact-match HEAD 2>/dev/null)
  short_commit=$(git -C "$CWD" rev-parse --short HEAD 2>/dev/null)

  reset=$'\e[0m'
  clean=$'\e[0;32m'
  pbranch=$'\e[0;35m'
  otag=$'\e[0;96m'
  untracked_c=$'\e[0;94m'
  modified_c=$'\e[0;93m'
  conflicted_c=$'\e[0;91m'

  p="${pbranch}"

  if [[ -n "$local_branch" ]]; then
    where="$local_branch"
  elif [[ -n "$tag" ]]; then
    p+="${otag}#"
    where="$tag"
  else
    p+="${otag}@"
    where="${short_commit}"
  fi

  ((${#where} > 32)) && where="${where:0:12}…${where: -12}"
  p+="${where}"

  # ahead/behind
  left_right=$(git -C "$CWD" rev-list --count --left-right '@{upstream}...HEAD' 2>/dev/null)
  if [[ -n "$left_right" ]]; then
    behind=${left_right%%	*}
    ahead=${left_right##*	}
    ((behind)) && p+=" ${clean}⇣${behind}"
    ((ahead && !behind)) && p+=" "
    ((ahead)) && p+="${clean}⇡${ahead}"
  fi

  stashes=$(git -C "$CWD" stash list 2>/dev/null | wc -l)
  ((stashes)) && p+=" ${clean}*${stashes}"

  # unusual state (merge, rebase, etc.)
  git_dir=$(git -C "$CWD" rev-parse --git-dir 2>/dev/null)
  action=""
  if [[ -d "$git_dir/rebase-merge" || -d "$git_dir/rebase-apply" ]]; then
    action="rebase"
  elif [[ -f "$git_dir/MERGE_HEAD" ]]; then
    action="merge"
  elif [[ -f "$git_dir/CHERRY_PICK_HEAD" ]]; then
    action="cherry-pick"
  elif [[ -f "$git_dir/REVERT_HEAD" ]]; then
    action="revert"
  elif [[ -f "$git_dir/BISECT_LOG" ]]; then
    action="bisect"
  fi
  [[ -n "$action" ]] && p+=" ${conflicted_c}${action}"

  porcelain=$(git -C "$CWD" status --porcelain 2>/dev/null)
  conflicted=$(echo "$porcelain" | grep -c '^UU' || true)
  staged=$(echo "$porcelain" | grep -c '^[MADRC].' || true)
  unstaged=$(echo "$porcelain" | grep -c '^.[MADRC]' || true)
  untracked=$(echo "$porcelain" | grep -c '^??' || true)

  ((conflicted)) && p+=" ${conflicted_c}~${conflicted}"
  ((staged)) && p+=" ${modified_c}+${staged}"
  ((unstaged)) && p+=" ${modified_c}!${unstaged}"
  ((untracked)) && p+=" ${untracked_c}?${untracked}"

  GSP=" | ${p}${reset}"
fi

USAGE_STR=""
if [[ -n "$USAGE_5H" && -n "$USAGE_7D" ]]; then
  # Format reset times in local timezone
  reset_5h_fmt=""
  reset_7d_fmt=""
  [[ -n "$RESET_5H" ]] && reset_5h_fmt="$(date -d "@$RESET_5H" '+%H:%M' 2>/dev/null)"
  [[ -n "$RESET_7D" ]] && reset_7d_fmt="$(date -d "@$RESET_7D" '+%-d%^b' 2>/dev/null)"
  USAGE_STR=" | 🕐$(render_bar "$USAGE_5H" 3) ${USAGE_5H}% (${reset_5h_fmt}) |  📅 $(render_bar "$USAGE_7D" 3) ${USAGE_7D}% (${reset_7d_fmt})"
fi

echo "[$MODEL] $(render_bar "$PCT" 3) $PCT%${USAGE_STR}$GSP"
