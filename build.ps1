$releases = Invoke-RestMethod -FollowRelLink -Uri https://api.github.com/repos/jgthms/bulma/releases
$releases.assets."browser_download_url"
