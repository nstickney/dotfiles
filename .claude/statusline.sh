#!/bin/bash

# Read all of stdin into a variable
input=$(cat)

# Extract fields with jq, "// 0" provides fallback for null
MODEL=$(echo "$input" | jq -r '.model.display_name')
PCT=$(echo "$input" | jq -r '.context_window.used_percentage // 0' | cut -d. -f1)
CWD=$(echo "$input" | jq -r '.cwd // empty')

# Sub-character precision: 8 steps per cell using eighth-block characters
PARTIALS=("" "▏" "▎" "▍" "▌" "▋" "▊" "▉")

render_bar() {
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

# Fetch PRO usage data
USAGE_5H=""
USAGE_7D=""
RESET_5H=""
RESET_7D=""
CACHE_FILE="$HOME/.claude/plugins/claude-hud/.usage-cache.json"
CREDS_FILE="$HOME/.claude/.credentials.json"

fetch_usage() {
	local now
	now=$(date +%s)

	# Load cache if it exists (used for fresh reads and stale fallback)
	local cache_ts=0
	if [[ -f "$CACHE_FILE" ]]; then
		cache_ts=$(jq -r '.timestamp // 0' "$CACHE_FILE" 2>/dev/null)
	fi

	load_cache() {
		USAGE_5H=$(jq -r '.data.fiveHour // empty' "$CACHE_FILE" 2>/dev/null)
		USAGE_7D=$(jq -r '.data.sevenDay // empty' "$CACHE_FILE" 2>/dev/null)
		RESET_5H=$(jq -r '.data.fiveHourResetAt // empty' "$CACHE_FILE" 2>/dev/null)
		RESET_7D=$(jq -r '.data.sevenDayResetAt // empty' "$CACHE_FILE" 2>/dev/null)
	}

	# Fresh cache (< 5 min old) — use directly
	local cache_age=$((now - cache_ts / 1000))
	if [[ -f "$CACHE_FILE" ]] && ((cache_age < 300)); then
		load_cache
		return 0
	fi

	# Need to fetch — get OAuth token
	[[ -f "$CREDS_FILE" ]] || { load_cache; return 0; }
	local token
	token=$(jq -r '.claudeAiOauth.accessToken // empty' "$CREDS_FILE" 2>/dev/null)
	[[ -n "$token" ]] || { load_cache; return 0; }

	local resp
	resp=$(curl -sf --max-time 3 \
		-H "Authorization: Bearer $token" \
		-H "anthropic-beta: oauth-2025-04-20" \
		"https://api.anthropic.com/api/oauth/usage" 2>/dev/null)
	if [[ $? -ne 0 ]]; then
		# API failed — fall back to stale cache
		load_cache
		return 0
	fi

	local five_hour seven_day five_hour_reset seven_day_reset
	five_hour=$(echo "$resp" | jq -r '.five_hour.utilization // empty' 2>/dev/null)
	seven_day=$(echo "$resp" | jq -r '.seven_day.utilization // empty' 2>/dev/null)
	five_hour_reset=$(echo "$resp" | jq -r '.five_hour.resets_at // empty' 2>/dev/null)
	seven_day_reset=$(echo "$resp" | jq -r '.seven_day.resets_at // empty' 2>/dev/null)
	if [[ -z "$five_hour" || -z "$seven_day" ]]; then
		# Bad response — fall back to stale cache
		load_cache
		return 0
	fi

	# Round to integers
	five_hour=$(printf '%.0f' "$five_hour")
	seven_day=$(printf '%.0f' "$seven_day")

	USAGE_5H="$five_hour"
	USAGE_7D="$seven_day"
	RESET_5H="$five_hour_reset"
	RESET_7D="$seven_day_reset"

	# Write back to shared cache
	mkdir -p "$(dirname "$CACHE_FILE")"
	local now_ms=$((now * 1000))
	local reset_5h_json="" reset_7d_json=""
	[[ -n "$five_hour_reset" ]] && reset_5h_json="\"fiveHourResetAt\":\"${five_hour_reset}\","
	[[ -n "$seven_day_reset" ]] && reset_7d_json="\"sevenDayResetAt\":\"${seven_day_reset}\","
	cat >"$CACHE_FILE" <<-CACHE
		{"data":{"fiveHour":${five_hour},"sevenDay":${seven_day},${reset_5h_json}${reset_7d_json}"planName":"Pro"},"timestamp":${now_ms}}
	CACHE
}

fetch_usage 2>/dev/null

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
	[[ -n "$RESET_5H" ]] && reset_5h_fmt="$(date -d "$RESET_5H" '+%H:%M' 2>/dev/null)"
	[[ -n "$RESET_7D" ]] && reset_7d_fmt="$(date -d "$RESET_7D" '+%-d%^b' 2>/dev/null)"
	USAGE_STR=" | 🕐$(render_bar "$USAGE_5H" 3) ${USAGE_5H}% (${reset_5h_fmt}) |  📅 $(render_bar "$USAGE_7D" 3) ${USAGE_7D}% (${reset_7d_fmt})"
fi

echo "[$MODEL] $(render_bar "$PCT" 3) $PCT%${USAGE_STR}$GSP"
