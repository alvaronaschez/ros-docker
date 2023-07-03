set projectName=%1
set currentDir="%cd%"

docker run -td ^
    -e DISPLAY=host.docker.internal:0.0 ^
    --name %projectName% ^
    --volume=%currentDir%:/home/%projectName% ^
    --workdir=/home/%projectName%/ws ^
    %projectName%:%projectName%

@REM XLaunch should be enabled
