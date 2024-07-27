# constants
$TEMPDIR = "./src" # folder to store downloaded archives
$BULMA_URL = "https://api.github.com/repos/jgthms/bulma"

# get releases and extract needed information
$BulmaReleases = Invoke-RestMethod -FollowRelLink -Uri "$BULMA_URL/releases?per_page=100" | %{$_}| ForEach-Object {
   if ($_.tag_name) {
      [PSCustomObject]@{
         version = [version]$_.tag_name
         archive = [string]$_.assets.name
         download = [string]$_.assets.browser_download_url
      }
   } else {
      Write-Warning "found untagged release for $($_.assets.name)"
   }
} | Sort-Object -Property version
$tags = git tag
foreach ($release in $BulmaReleases) {
   if ($tags -contains $release.version) {
      Write-Output "already packed: $release"
      continue
   }
   # download
   Write-Output "new release   : $release"
   $archive = Join-Path -Path $TEMPDIR -ChildPath $release.archive
   Invoke-WebRequest -Uri $release.download -OutFile $archive
   $bulmaFolder = (Get-Item $archive).Basename
   Remove-Item -Recurse .\assets -ErrorAction SilentlyContinue
   if (Test-Path .\assets) { throw ".\assets should not exist"}
   if (Test-Path .\build.ps1) { throw ".\build.ps1 should not exist"}
   git checkout -b $bulmaFolder
   git status
   [void](New-Item -Type Directory ./assets -ErrorAction Stop)
   if (-Not (Test-Path .\assets -PathType Container)) { throw ".\assets should exist"}
   Expand-Archive -LiteralPath $archive -DestinationPath .\assets
   if (Test-Path .\assets\__MACOSX) { Remove-Item .\assets\__MACOSX -ErrorAction SilentlyContinue -Recurse }
   Rename-Item .\assets\$bulmaFolder "bulma"
   dir .
   dir .\assets
   if (-Not (Test-Path ./assets/bulma -PathType Container)) { throw "missing ./assets/bulma folder"}
   git add assets\bulma
   Write-Output "committing..."
   git commit -m "add $bulmaFolder"
   git tag "v$($release.version)"
   Write-Output "Cleanup ..."
   git checkout main
   git branch -D $bulmaFolder
   git log --oneline -n 5
   git tag
   git branch
   git push --tags 
   gh release create "v$($release.version)"
   break
}
