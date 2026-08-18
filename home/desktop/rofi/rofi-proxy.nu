#! /usr/bin/env nu

def main [] {
  let proxies = list-proxies
  let sel_name = select-proxy-name $proxies

  if ($sel_name | is-empty) {
    print "nothing selected"
    exit 0
  }

  let sel = $proxies
    | where { |p| $p.name == $sel_name }
    | first

  if ($sel.active) {
    ssh -O exit $sel.name
    notify-send "Proxy" $"Disconnected from ($sel.name)"
    return 1
  }
  if (ssh -fN $sel.name | complete).exit_code == 0 {
    notify-send "SOCKS5 Proxy" $"Connected to ($sel.name)"
  } else {
    notify-send -u critical "SOCKS5 Proxy" $"Failed to connect to ($sel.name)"
  }
}

def ssh-config-files [] {
  let ssh_dir = ($env.HOME | path join ".ssh")
  let main = ($ssh_dir | path join "config")
  let includes = (open $main
    | lines
    | where { |l| ($l | str trim) =~ '(?i)^include\s' }
    | each { |l|
        let raw = ($l | str trim | str replace -r '(?i)^include\s+' '' | str trim)
        if ($raw | str starts-with "/") {
          $raw
        } else if ($raw | str starts-with "~") {
          $raw | str replace "~" $env.HOME
        } else {
          $ssh_dir | path join $raw
        }
      })
  [$main] ++ $includes
}

def list-proxy-hosts [] {
  ssh-config-files
    | each { |f| open $f | lines }
    | flatten
    | where { |l| ($l | str trim) =~ '(?i)^host\s' }
    | each { |l| $l | str trim | str replace -r '(?i)^host\s+' '' | split row -r '\s+' }
    | flatten
    | uniq
    | where { |h| not ($h | str contains '*') }
    | where { |h| has-dynamic-forward $h }
}

def has-dynamic-forward [host: string] {
  (ssh -G $host | complete).stdout | lines | any { |l| $l | str starts-with "dynamicforward " }
}

def list-proxies [] {
  list-proxy-hosts
    | each { |host|
        let active = ((ssh -O check $host | complete).exit_code == 0)
        { name: $host, active: $active }
      }
}

def select-proxy-name [proxies: list, prompt: string = "Proxy: "] {
  alias choose = rofi -dmenu -i -p $prompt
  $proxies
    | each { |p|
        let state_indicator = if $p.active { 'x' } else ' '
        $"[($state_indicator)] ($p.name)"
      }
    | to text
    | choose
    | str replace -r '^\[.\] ' ''
    | str trim
}
