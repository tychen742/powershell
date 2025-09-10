
# Import the Chocolatey Profile that contains the necessary code to enable
# tab-completions to function for `choco`.
# Be aware that if you are missing these lines from your profile, tab completion
# for `choco` will not function.
# See https://ch0.co/tab-completion for details.
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}

Set-Location C:\Users\tychen      ### powershell loads in user home

Set-Alias "home" Switch-Home      ### home to cd ~
Set-Alias "gitit" Sync-It         ### gitit to pull & push
Set-Alias gs Git-Status           ### git status

function Git-Status { git status }
function Switch-Home { Set-Location $HOME }
function Sync-It {
  git pull origin main
  git add .
  # git commit -m "committed @ `date +%Y-%m%d-%H%M%S`"
  $timestamp = Get-Date -Format "yyyy-mmdd hhmmss"
  git commit -m "committed $timestamp"
  git push origin main
}



# ######### venv code ############################################################
Set-Alias "dsm" CDIntoDSM				                      ### create the alias dsm
Set-Alias "venv" .\.venv\Scripts\activate	            ### activate venv
Set-Alias "jn" JupyterNotebook                        ### start Jupyter Notebook

# #### dsm: change directory to introdsm #####
function CDIntoDSM { set-location ~\workspace\dsm\ }	### create the function

##### jn: start jupyter notebook ##############
function JupyterNotebook {
  param(
    [string]$notebook = "notebook"
  )
  jupyter $notebook
}
########## end of venv code ##########################################################

########## from https://github.com/scottmckendry/Windots ##########
########## from https://github.com/scottmckendry/Windots ##########
########## from https://github.com/scottmckendry/Windots ##########

Set-Alias -Name ff -Value Find-File
Set-Alias -Name grep -Value Find-String
Set-Alias -Name ll -Value Get-ChildItemPretty
Set-Alias -Name la -Value Get-ChildItemPretty
Set-Alias -Name touch -Value New-File
Set-Alias -Name vim -Value nvim
function Find-File {
  <#
    .SYNOPSIS
        Finds a file in the current directory and all subdirectories. Alias: ff
    #>
  [CmdletBinding()]
  param (
    [Parameter(ValueFromPipeline, Mandatory = $true, Position = 0)]
    [string]$SearchTerm
  )

  Write-Verbose "Searching for '$SearchTerm' in current directory and subdirectories"
  $result = Get-ChildItem -Recurse -Filter "*$SearchTerm*" -ErrorAction SilentlyContinue

  Write-Verbose "Outputting results to table"
  $result | Format-Table -AutoSize
}

function Find-String {
  <#
    .SYNOPSIS
        Searches for a string in a file or directory. Alias: grep
    #>
  [CmdletBinding()]
  param (
    [Parameter(Mandatory = $true, Position = 0)]
    [string]$SearchTerm,
    [Parameter(ValueFromPipeline, Mandatory = $false, Position = 1)]
    [string]$Directory,
    [Parameter(Mandatory = $false)]
    [switch]$Recurse
  )

  Write-Verbose "Searching for '$SearchTerm' in '$Directory'"
  if ($Directory) {
    if ($Recurse) {
      Write-Verbose "Searching for '$SearchTerm' in '$Directory' and subdirectories"
      Get-ChildItem -Recurse $Directory | Select-String $SearchTerm
      return
    }

    Write-Verbose "Searching for '$SearchTerm' in '$Directory'"
    Get-ChildItem $Directory | Select-String $SearchTerm
    return
  }

  if ($Recurse) {
    Write-Verbose "Searching for '$SearchTerm' in current directory and subdirectories"
    Get-ChildItem -Recurse | Select-String $SearchTerm
    return
  }

  Write-Verbose "Searching for '$SearchTerm' in current directory"
  Get-ChildItem | Select-String $SearchTerm
}

function Get-ChildItemPretty {
  <#
    .SYNOPSIS
        Runs eza with a specific set of arguments. Plus some line breaks before and after the output.
        Alias: ls, ll, la, l
    #>
  [CmdletBinding()]
  param (
    [Parameter(Mandatory = $false, Position = 0)]
    [string]$Path = $PWD
  )

  Write-Host ""
  eza -a -l --header --icons --hyperlink --time-style relative $Path
  Write-Host ""
}


function New-File {
    <#
    .SYNOPSIS
        Creates a new file with the specified name and extension. Alias: touch
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, Position = 0)]
        [string]$Name
    )

    Write-Verbose "Creating new file '$Name'"
    New-Item -ItemType File -Name $Name -Path $PWD | Out-Null
}

########## end of Windots code ##########################################################


########## oh-my-posh ##########################################################
oh-my-posh init pwsh | Invoke-Expression