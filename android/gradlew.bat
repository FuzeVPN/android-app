@rem
@rem Copyright © 2015-2026 the original authors.
@rem SPDX-License-Identifier: Apache-2.0
@rem
@rem Self-contained Windows Gradle wrapper bootstrap for the pinned Gradle
@rem 9.5.0 distribution. It verifies the release checksum before it executes
@rem Gradle, since a standalone wrapper JAR is not reliably published.
@rem
@if "%DEBUG%"=="" @echo off
@setlocal

set "GRADLE_VERSION=9.5.0"
set "GRADLE_SHA256=553c78f50dafcd54d65b9a444649057857469edf836431389695608536d6b746"
set "GRADLE_URL=https://services.gradle.org/distributions/gradle-9.5.0-bin.zip"
if not defined GRADLE_USER_HOME set "GRADLE_USER_HOME=%USERPROFILE%\.gradle"
set "DIST_ROOT=%GRADLE_USER_HOME%\wrapper\dists\fuzevpn-gradle-%GRADLE_VERSION%"
set "DIST_HOME=%DIST_ROOT%\gradle-%GRADLE_VERSION%"
set "ZIP_PATH=%DIST_ROOT%\gradle-%GRADLE_VERSION%-bin.zip"

if not exist "%DIST_HOME%\bin\gradle.bat" (
  if not exist "%DIST_ROOT%" mkdir "%DIST_ROOT%"
  powershell.exe -NoProfile -NonInteractive -ExecutionPolicy Bypass -Command ^
    "$ErrorActionPreference='Stop'; $zip=$env:ZIP_PATH; $temporary=$zip+'.tmp'; Invoke-WebRequest -UseBasicParsing -Uri $env:GRADLE_URL -OutFile $temporary; if ((Get-FileHash -Algorithm SHA256 $temporary).Hash.ToLowerInvariant() -ne $env:GRADLE_SHA256) { Remove-Item -LiteralPath $temporary -Force; throw 'Gradle distribution checksum mismatch.' }; Move-Item -LiteralPath $temporary -Destination $zip -Force; Expand-Archive -LiteralPath $zip -DestinationPath $env:DIST_ROOT -Force; Remove-Item -LiteralPath $zip -Force"
  if errorlevel 1 (
    echo ERROR: Gradle %GRADLE_VERSION% could not be downloaded and verified. 1>&2
    exit /b 1
  )
)

call "%DIST_HOME%\bin\gradle.bat" %*
set "EXIT_CODE=%ERRORLEVEL%"
endlocal & exit /b %EXIT_CODE%
