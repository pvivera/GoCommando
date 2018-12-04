@echo off

echo GoCommand build thing.
echo.

set buildVersion=%1

if "%buildVersion%"=="" (
	echo.
	echo Please specify which version to build as an argument
	echo.
	goto exit
)

echo Building version %buildVersion%...

dotnet clean src\GoCommando\GoCommando.csproj -c Release

dotnet build src\GoCommando\GoCommando.csproj -c Release

echo Tagging...

git tag %buildVersion%

echo Packing...

dotnet pack src\GoCommando\GoCommando.csproj -c Release -p:PackageVersion=%buildVersion%

echo Pushing...

git push
git push --tags

:exit
