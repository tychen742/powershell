
# Import the Chocolatey Profile that contains the necessary code to enable
# tab-completions to function for `choco`.
# Be aware that if you are missing these lines from your profile, tab completion
# for `choco` will not function.
# See https://ch0.co/tab-completion for details.
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}

Set-Location C:\Users\tychen

function CD-Home { Set-Location $HOME }
Set-Alias -Name home -Value CD-Home

function Git-It {
  git pull origin main
  git add .
  # git commit -m "committed @ `date +%Y-%m%d-%H%M%S`"
  $timestamp = Get-Date -Format "yyyy-mmdd hhmmss"
  
  # git commit -m "committed $timestamp"
  git push origin main
}
Set-Alias "gitit" "Git-It"


# ######### venv code ############################################################
# #### dsm: change directory to introdsm ######

function CDIntroDSM { set-location ~\workspace\dsm\ }	### create the function
New-Alias "dsm" CDIntroDSM				### create the alias dsm

##### venv: activate virtual environment #####
New-Alias -Name "venv" -Value .\.venv\Scripts\activate	### activate venv

##### j: start jupyter notebook ##############
function JupyterNotebook {
  param(
    [string]$notebook = "notebook"
  )
  jupyter $notebook
}
New-Alias -Name "jn" -Value JupyterNotebook  
# ######### end of venv code ##########################################################

