#!/usr/bin/bash

# Will exit the Bash script the moment any command will itself exit with a non-zero status, thus an error.
set -e

EXTRACT_PATH=$1
INSTALL_PATH=${REZ_BUILD_INSTALL_PATH}
FLEX_VERSION=${REZ_BUILD_PROJECT_VERSION}

# We print the arguments passed to the Bash script.
echo -e "\n"
echo -e "================="
echo -e "=== CONFIGURE ==="
echo -e "================="
echo -e "\n"

echo -e "[CONFIGURE][ARGS] EXTRACT PATH: ${EXTRACT_PATH}"
echo -e "[CONFIGURE][ARGS] INSTALL PATH: ${INSTALL_PATH}"
echo -e "[CONFIGURE][ARGS] FLEX VERSION: ${FLEX_VERSION}"

# We check if the arguments variables we need are correctly set.
# If not, we abort the process.
if [[ -z ${EXTRACT_PATH} || -z ${INSTALL_PATH} || -z ${FLEX_VERSION} ]]; then
    echo -e "\n"
    echo -e "[CONFIGURE][ARGS] One or more of the argument variables are empty. Aborting..."
    echo -e "\n"

    exit 1
fi

# We run the configuration script of flex.
echo -e "\n"
echo -e "[CONFIGURE] Running the configuration script from flex-${FLEX_VERSION}..."
echo -e "\n"

cd ${EXTRACT_PATH}

${EXTRACT_PATH}/autogen.sh

${EXTRACT_PATH}/configure \
    --prefix=${INSTALL_PATH} \
    CFLAGS="-fPIC" \
    CXXFLAGS="-fPIC" \
    --with-pic

echo -e "\n"
echo -e "[CONFIGURE] Finished configuring flex-${FLEX_VERSION}!"
echo -e "\n"
