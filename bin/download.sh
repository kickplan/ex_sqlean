#/usr/bin/env bash

PLATFORMS=("linux-arm64" "linux-x86" "macos-arm64" "macos-x86" "win-x64" "win-x86")
VERSION=0.24.2

download() {
    platform=$1
    path="priv/$platform"
    filename="sqlean-$platform.zip"

    if ! [[ "${PLATFORMS[@]}" =~ $platform ]]; then
        echo "$platform is not a valid platform"
        return 0
    fi

    # Prepare output directory
    rm -rf $path
    mkdir $path

    # Retrieve latest build asset for platform
    wget https://github.com/nalgeon/sqlean/releases/download/$VERSION/$filename

    # Unzip asset and remove asset file
    unzip $filename -d $path
    rm $filename
}

for platform in ${PLATFORMS[@]}; do
  download $platform
done
