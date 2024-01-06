#!/usr/bin/env bash

resultDir="$(pwd)/results"
if [[ ! -d "$resultDir" ]]; then
    echo "> Preparing results directory"
    mkdir -p "$resultDir"
fi

echo "> Building image"
docker build -t ps5-kstuff-porting-tool:latest .

echo "> Executing tool"
docker run \
    -it \
    --rm \
    --mount type=bind,source="${resultDir}",target=/kstuff/results \
    ps5-kstuff-porting-tool:latest "$@"


if [[ $? -ne 0 ]]; then
    echo "> Execution of porting tool failed"
    exit 1
fi

echo "> Done"
echo "> Results saved to: ${resultDir}"


