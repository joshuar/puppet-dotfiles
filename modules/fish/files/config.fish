# journalctl:
abbr -a journalctl_errors journalctl -p err
abbr -a journalctl_kernel journalctl -k
abbr -a journalctl_today journalctl --since today
abbr -a journalctl_boot journalctl -b 0
# ls:
abbr -a lst ls -t
abbr -a lstr ls -tr
abbr -a lsl ls -l
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

# micro:
abbr -a m $HOME/gocode/bin/micro
abbr -a mr sudo $HOME/gocode/bin/micro

# cpustat:
alias cpustat 'sudo $HOME/gocode/bin/cpustat'

# ps:
alias ps_all 'ps -AlF | eval $PAGER'
alias ps_all_threads 'ps -AlFH | eval $PAGER'

# grep:
abbr -a grep grep -I -d skip -D skip
alias grepr 'grep -nsIE -d recurse -D skip'

# dmesg:
abbr -a dmesg dmesg -T -L
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

function vagrant_set_provider -d "Set the default Vagrant box provider"
  switch $argv[1]
    case aws
      set -xg VAGRANT_DEFAULT_PROVIDER aws
    case '*'
      set -xg VAGRANT_DEFAULT_PROVIDER virtualbox
  end
end

set -xg EDITOR micro
set -xg VISUAL code
set -xg WINEDEBUG -all

set fish_color_command white

if grep -q bobthefish ~/.config/omf/theme
  set -g theme_color_scheme solarized
end
