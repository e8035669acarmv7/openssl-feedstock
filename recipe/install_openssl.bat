@echo on
setlocal enabledelayedexpansion

nmake install
if %ERRORLEVEL% neq 0 exit 1

:: don't include html docs that get installed
rd /s /q %LIBRARY_PREFIX%\html

:: install pkgconfig metadata (useful for downstream packages);
:: adapted from inspecting the conda-forge .pc files for unix, as well as
:: https://github.com/microsoft/vcpkg/blob/master/ports/openssl/install-pc-files.cmake
mkdir %LIBRARY_PREFIX%\lib\pkgconfig
for %%F in (openssl libssl libcrypto) DO (
    copy %RECIPE_DIR%\win_pkgconfig\%%F.pc.in %LIBRARY_PREFIX%\lib\pkgconfig\%%F.pc
    sed -i "s|@PREFIX@|%LIBRARY_PREFIX:\=/%|g" %LIBRARY_PREFIX%\lib\pkgconfig\%%F.pc
    sed -i "s|@VERSION@|%PKG_VERSION%|g" %LIBRARY_PREFIX%\lib\pkgconfig\%%F.pc
)

REM Install step
rem copy out32dll\openssl.exe %PREFIX%\openssl.exe
rem copy out32\ssleay32.lib %LIBRARY_LIB%\ssleay32_static.lib
rem copy out32\libeay32.lib %LIBRARY_LIB%\libeay32_static.lib
rem copy out32dll\ssleay32.lib %LIBRARY_LIB%\ssleay32.lib
rem copy out32dll\libeay32.lib %LIBRARY_LIB%\libeay32.lib
rem copy out32dll\ssleay32.dll %LIBRARY_BIN%\ssleay32.dll
rem copy out32dll\libeay32.dll %LIBRARY_BIN%\libeay32.dll
rem mkdir %LIBRARY_INC%\openssl
rem xcopy /S inc32\openssl\*.* %LIBRARY_INC%\openssl\
