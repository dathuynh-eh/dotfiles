#!/usr/bin/env bash

# Define basic colors directly
FG_DEFAULT="#[fg=colour7]"
BG_DEFAULT="#[bg=colour0]"
GREEN="#[fg=colour2]"
RED="#[fg=colour1]"
YELLOW="#[fg=colour3]"
MAGENTA="#[fg=colour5]"
BLACK="#[fg=colour8]"
BRIGHT_RED="#[fg=colour9]"
RESET="${FG_DEFAULT}${BG_DEFAULT}#[nobold,noitalics,nounderscore,nodim]"

cd "$1" || exit 1
BRANCH=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
STATUS=$(git status --porcelain 2>/dev/null | grep -cE "^(M| M)")

SYNC_MODE=0
NEED_PUSH=0

if [[ ${#BRANCH} -gt 25 ]]; then
  BRANCH="${BRANCH:0:25}…"
fi

STATUS_CHANGED=""
STATUS_INSERTIONS=""
STATUS_DELETIONS=""
STATUS_UNTRACKED=""

if [[ $STATUS -ne 0 ]]; then
  DIFF_COUNTS=($(git diff --numstat 2>/dev/null | awk 'NF==3 {changed+=1; ins+=$1; del+=$2} END {printf("%d %d %d", changed, ins, del)}'))
  CHANGED_COUNT=${DIFF_COUNTS[0]}
  INSERTIONS_COUNT=${DIFF_COUNTS[1]}
  DELETIONS_COUNT=${DIFF_COUNTS[2]}

  SYNC_MODE=1
fi

UNTRACKED_COUNT="$(git ls-files --other --directory --exclude-standard | wc -l | xargs)"

if [[ $CHANGED_COUNT -gt 0 ]]; then
  STATUS_CHANGED="$RESET$YELLOW#[bold] ${CHANGED_COUNT} "
fi

if [[ $INSERTIONS_COUNT -gt 0 ]]; then
  STATUS_INSERTIONS="$RESET$GREEN#[bold] ${INSERTIONS_COUNT} "
fi

if [[ $DELETIONS_COUNT -gt 0 ]]; then
  STATUS_DELETIONS="$RESET$RED#[bold] ${DELETIONS_COUNT} "
fi

if [[ $UNTRACKED_COUNT -gt 0 ]]; then
  STATUS_UNTRACKED="$RESET$BLACK#[bold] ${UNTRACKED_COUNT} "
fi

# Determine repository sync status
if [[ $SYNC_MODE -eq 0 ]]; then
  NEED_PUSH=$(git log @{push}.. 2>/dev/null | wc -l | xargs)
  if [[ $NEED_PUSH -gt 0 ]]; then
    SYNC_MODE=2
  else
    # Use macOS compatible stat command
    LAST_FETCH_FILE=".git/FETCH_HEAD"
    if [ -f "$LAST_FETCH_FILE" ]; then
      LAST_FETCH=$(stat -f %m "$LAST_FETCH_FILE")
      NOW=$(date +%s)

      # if 5 minutes have passed since the last fetch
      if [[ $((NOW - LAST_FETCH)) -gt 300 ]]; then
        git fetch --atomic origin --negotiation-tip=HEAD 2>/dev/null
      fi
    fi

    # Check if the remote branch is ahead of the local branch
    REMOTE_DIFF="$(git diff --numstat "${BRANCH}" "origin/${BRANCH}" 2>/dev/null)"
    if [[ -n $REMOTE_DIFF ]]; then
      SYNC_MODE=3
    fi
  fi
fi

# Set the status indicator based on the sync mode
case "$SYNC_MODE" in
1)
  REMOTE_STATUS="$RESET$BRIGHT_RED#[bold]▒ 󱓎"
  ;;
2)
  REMOTE_STATUS="$RESET$RED#[bold]▒ 󰛃"
  ;;
3)
  REMOTE_STATUS="$RESET$MAGENTA#[bold]▒ 󰛀"
  ;;
*)
  REMOTE_STATUS="$RESET$GREEN#[bold]▒ "
  ;;
esac

if [[ -n $BRANCH ]]; then
  echo "$REMOTE_STATUS $RESET$BRANCH $STATUS_CHANGED$STATUS_INSERTIONS$STATUS_DELETIONS$STATUS_UNTRACKED"
fi
