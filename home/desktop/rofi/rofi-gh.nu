#!/usr/bin/env nu

def main [] {
  let repos = list-repos
  let selection = select-repo $repos

  if ($selection | is-empty) {
    print "nothing selected"
    exit 0
  }

  open-repo $selection
}

def list-repos [] {
  gh repo list --json name,nameWithOwner,url,description,owner --limit 1000
    | from json
    | each { |repo|
        {
          name: $repo.name,
          full_name: $repo.nameWithOwner,
          url: $repo.url,
          description: ($repo.description | default ""),
          owner: $repo.owner.login
        }
      }
}

def select-repo [repos: list] {
  alias choose = rofi -dmenu -i -p "GitHub: "
  let formatted = $repos
    | each { |repo|
        let desc = if ($repo.description | is-empty) { "" } else { $" - ($repo.description)" }
        $"($repo.name) \(($repo.owner)\)($desc)"
      }

  let selection = $formatted | to text | choose | str trim

  if ($selection | is-empty) {
    return ""
  }

  # Parse selection to extract repo name and owner
  let parts = $selection | parse "{name} ({owner}){rest}"
  if ($parts | is-empty) {
    return ""
  }

  let selected_name = $parts.0.name
  let selected_owner = $parts.0.owner
  
  $repos | where { |repo| $repo.name == $selected_name and $repo.owner == $selected_owner } | first
}

def open-repo [repo: record] {
  let input = $repo.full_name
  
  # Check for page modifiers (e.g., "repo:pulls")
  if ($input | str contains ":") {
    let parts = $input | split column ":" repo_part page_part
    let page = $parts.0.page_part
    
    let url = match $page {
      "pulls" | "pr" => $"($repo.url)/pulls",
      "actions" => $"($repo.url)/actions",
      "releases" => $"($repo.url)/releases",
      "issues" => $"($repo.url)/issues", 
      "wiki" => $"($repo.url)/wiki",
      "settings" => $"($repo.url)/settings",
      "projects" => $"($repo.url)/projects",
      "security" => $"($repo.url)/security",
      "insights" => $"($repo.url)/pulse",
      _ => $repo.url
    }
    
    xdg-open $url
  } else {
    xdg-open $repo.url
  }
}