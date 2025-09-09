﻿$T = 'gYw'   # The test text
$esc = [char]27

Write-Host
Write-Host "                 40m     41m     42m     43m     44m     45m     46m     47m"
$FGsArray = @('    m', '   1m', '  30m', '1;90m', '  31m', '1;91m', '  32m', '1;92m', '  33m', '1;93m', '  34m', '1;94m', '  35m', '1;95m', '  36m', '1;96m', '  37m', '1;97m')

foreach ($FGs in $FGsArray) {
  $FG = $FGs.Trim()
  Write-Host -NoNewline " $FGs $esc[$FG  $T  "
  $BGArray = @('40m', '41m', '42m', '43m', '44m', '45m', '46m', '47m')
  foreach ($BG in $BGArray) {
    Write-Host -NoNewline "$esc[$FG$esc[$BG   $T  $esc[0m"
  }
  Write-Host
}
Write-Host
