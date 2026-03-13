@echo off
echo Checking OPSEC installation...

powershell -Command ^
"if (Test-Path $PROFILE) { ^
    $content = Get-Content $PROFILE -Raw; ^
    if ($content -match 'function opsec') { ^
        Write-Output 'Opsec already installed'; ^
        exit ^
    } ^
}; ^
if (!(Test-Path $PROFILE)) { New-Item -ItemType File -Path $PROFILE -Force }; ^
Add-Content -Path $PROFILE -Value ''; ^
Add-Content -Path $PROFILE -Value 'function opsec {'; ^
Add-Content -Path $PROFILE -Value 'param([string]$action)'; ^
Add-Content -Path $PROFILE -Value 'if (-not $global:OPSEC_INSTALLED) { $global:OPSEC_INSTALLED = $false }'; ^
Add-Content -Path $PROFILE -Value 'switch ($action) {'; ^
Add-Content -Path $PROFILE -Value '  \"install\" {'; ^
Add-Content -Path $PROFILE -Value '    if (-not $global:OPSEC_INSTALLED) {'; ^
Add-Content -Path $PROFILE -Value '      Write-Output \"Starting Opsec installation...\"'; ^
Add-Content -Path $PROFILE -Value '      Start-Sleep -Seconds 3'; ^
Add-Content -Path $PROFILE -Value '      Write-Output \"Opsec has been successfully installed\"'; ^
Add-Content -Path $PROFILE -Value '      $global:OPSEC_INSTALLED = $true'; ^
Add-Content -Path $PROFILE -Value '    } else {'; ^
Add-Content -Path $PROFILE -Value '      Write-Output \"Opsec already installed\"'; ^
Add-Content -Path $PROFILE -Value '    }'; ^
Add-Content -Path $PROFILE -Value '  }'; ^
Add-Content -Path $PROFILE -Value '  \"uninstall\" {'; ^
Add-Content -Path $PROFILE -Value '    if ($global:OPSEC_INSTALLED) {'; ^
Add-Content -Path $PROFILE -Value '      Write-Output \"Starting Opsec uninstallation...\"'; ^
Add-Content -Path $PROFILE -Value '      Start-Sleep -Seconds 2'; ^
Add-Content -Path $PROFILE -Value '      Write-Output \"Opsec has been successfully uninstalled\"'; ^
Add-Content -Path $PROFILE -Value '      $global:OPSEC_INSTALLED = $false'; ^
Add-Content -Path $PROFILE -Value '    } else {'; ^
Add-Content -Path $PROFILE -Value '      Write-Output \"Opsec is not installed\"'; ^
Add-Content -Path $PROFILE -Value '    }'; ^
Add-Content -Path $PROFILE -Value '  }'; ^
Add-Content -Path $PROFILE -Value '  default {'; ^
Add-Content -Path $PROFILE -Value '    Write-Output \"Usage: opsec install | uninstall\"'; ^
Add-Content -Path $PROFILE -Value '  }'; ^
Add-Content -Path $PROFILE -Value '}'; ^
Add-Content -Path $PROFILE -Value '}'; ^
Write-Output 'Opsec installed successfully'"

echo.
echo To use Opsec, open PowerShell and run:
echo.
echo    opsec install
echo.
echo You can uninstall later with:
echo.
echo    opsec uninstall
echo.
pause