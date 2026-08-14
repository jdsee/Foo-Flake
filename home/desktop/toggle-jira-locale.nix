{ pkgs, ... }:
let
  jira-host = "servicedesk.zitis.ivbb.bund.de";
  jira-pat-secret = "personal/websites/servicedesk.zitis.bund.de/seeligj";

  toggle-jira-locale = pkgs.writeShellScriptBin "toggle-jira-locale" ''
    set -euo pipefail

    pat=$(gopass -o ${jira-pat-secret} pat)

    current=$(https --verify=no GET ${jira-host}/rest/api/2/mypreferences \
      key==jira.user.locale \
      "Authorization:Bearer $pat" | jq -r)

    if [[ "$current" == "de_DE" ]]; then
      new="en_US"
    else
      new="de_DE"
    fi

    echo "Switching Jira locale from $current to $new..."

    https --verify=no PUT ${jira-host}/rest/api/2/mypreferences \
      key==jira.user.locale \
      "Authorization:Bearer $pat" \
      Content-Type:application/json \
      --raw="\"$new\""
  '';
in
{
  home.packages = [ toggle-jira-locale ];
}
