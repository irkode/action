# constants
$TEMPDIR = "./src" # folder to store downloaded archives
$BULMA_URL = "https://api.github.com/repos/jgthms/bulma"

# get releases and extract needed information
$BulmaReleases = Invoke-RestMethod -FollowRelLink -Uri "$BULMA_URL/releases?per_page=100" | %{$_}| ForEach-Object {
   [PSCustomObject]@{
      version = [version]$_.tag_name
      archive = [string]$_.assets.name
      download = [string]$_.assets.browser_download_url
   }
} | Sort-Object -Property version
$tags = git tag
foreach ($release in $BulmaReleases) {
   if ($tags -contains $release.version) {
      Write-Output "already packed: $release"
      continue
   }
   # download
   $archive = Join-Path -Path $TEMPDIR -ChildPath $release.archive
   if (Test-Path -Path $archive) {
      Write-Output "is downloaded : $release"
      continue
   } else {
      Write-Output "new release   : $release"
      Invoke-WebRequest -Uri $release.download -OutFile $archive
      break
   }
}
$bulmaFolder = (Get-Item $archive).Basename
Remove-Item -Recurse .\assets
if ( Test-Path .\assets) { throw ".\assets should not exist"}
Expand-Archive -LiteralPath $archive -DestinationPath .
Rename-Item $bulmaFolder "assets"
Remove-Item __MACOSX -ErrorAction SilentlyContinue -Recurse
