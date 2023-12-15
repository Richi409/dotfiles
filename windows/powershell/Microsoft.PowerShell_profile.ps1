using namespace System.Management.Automation
using namespace System.Management.Automation.Language
 
# if ($host.Name -eq 'ConsoleHost')
# {
#     Import-Module PSReadLine
#     echo 3
# }
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -EditMode Windows


#oh-my-posh --init --shell pwsh --config C:\Users\richa\AppData\Local\Programs\oh-my-posh\themes\powerlevel10k_rainbow.omp.json | Invoke-Expression
#Invoke-Expression (&starship init powershell)
Import-Module -Name Terminal-Icons

# function sudo {
#     Start-Process @args -verb RunAs
# }


Set-Alias -Name "ss" -Value "Select-String"
Set-Alias -Name "se" -Value "Search-Everything"


function tk($ProgName) {
    taskkill /IM $ProgName /f
}

function Get-Directory-Size($fodler) {
    if ((Get-ChildItem $folder -Recurse | Measure-Object -Property Length -Sum -ErrorAction Stop).Sum > 100) {
        "{0} GB" -f ((Get-ChildItem $folder -Recurse | Measure-Object -Property Length -Sum -ErrorAction Stop).Sum / 1GB)
        echo gggg
        echo 1
    } else {
        "{0} MB" -f ((Get-ChildItem $folder -Recurse | Measure-Object -Property Length -Sum -ErrorAction Stop).Sum / 1MB)
        echo gggg
        echo 2
    }
}
Set-Alias -Name "Get-Folder-Size" -Value "Get-Directory-Size"


function edge ($Item){
    $ItemPath  = Get-ChildItem $Item -Recurse | %{$_.FullName}
    $withqoutes = "`"" + $ItemPath + "`""
    Start-Process msedge $withqoutes
}

function e($path) {
    if($path -eq $null) {
        explorer .\
    } else {
        explorer $path
    }
}


function gimp ($Item){
     $ItemPath  = Get-ChildItem $Item -Recurse | %{$_.FullName}
    $withqoutes = "`"" + $ItemPath + "`""
    Start-Process "C:\Users\richa\AppData\Local\Programs\GIMP 2\bin\gimp-2.10.exe" $withqoutes
}
