# journalctl:
abbr -a journalctl_errors journalctl -p err
abbr -a journalctl_kernel journalctl -k
abbr -a journalctl_today journalctl --since today
abbr -a journalctl_boot journalctl -b 0
# ls:
abbr -a lst ls -t
abbr -a lstr ls -tr
abbr -a lslt ls -lt
abbr -a lsltr ls -ltr
# cp:
abbr -a cpa cp -a
abbr -a cpr cp -r
# df/du:
abbr -a df df -h
abbr -a du du -h
# tmux:
abbr -a tm tmux -2
abbr -a tma tmux attach-session
abbr -a tmls tmux list-sessions

# dmesg:
alias dmesg 'dmesg -T -L'
alias dmesg_errors 'dmesg -xT -l err,crit,emerg'
# sysstat:
alias watch_vmstat='vmstat 1'
alias watch_mpstat='mpstat -p ALL 1'
alias watch_pidstat='pidstat 1'
alias watch_iostat='iostat -xz 1'
# misc:
alias weather 'curl http://wttr.in/'
alias moon 'curl http://wttr.in/Moon'
alias root 'sudo -i -H'
