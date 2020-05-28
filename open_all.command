tr ':' '\n' <<< "$PATH"

cd "$(dirname "$0")"
atom .
echo -n -e "\033]0;open\007"
osascript -e 'tell application "Terminal" to close (every window whose name contains "open")' &
