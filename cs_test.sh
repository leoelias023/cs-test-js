#!/bin/bash 

# Define general constants
NAME_SCRIPT_FILE=`basename "$0"`
NAME_CONFIG_FILE="cs_config.json"
NAME_TEMP_WORKDIR="csjstesttemp"

# Define colors 
RED='\033[0;31m'
YELLOW='\033[0;33m' 
NC='\033[0m'

# Define log prefix
LOG_CONFIG="${YELLOW}  [CONFIG]  - "
LOG_INFO="${NC}  [INFO]  - "
LOG_ERROR="${RED}  [ERROR]  - "

log()
{
    LOG_COLOR=$1
    LOG_NV=$2
    MESSAGE=$3
    MESSAGE_INFO=$4

    echo -e "${LOG_COLOR}${LOG_NV} ${MESSAGE} ${MESSAGE_INFO}"
}

# Verify if the shell was executed as sudo user.
if [[ $(id -u) -ne 0 ]] ; 
then 
    log ${LOG_ERROR} "Sem permissão.${NC}\nTente novamente executando como administrador: ${YELLOW}sudo ${NAME_SCRIPT_FILE}" ;
    exit 1 ; 
fi

# Verify if the nodeJS is not installed and install it
log ${LOG_CONFIG} "Configurando runtime NodeJS"
if which node > /dev/null
then
    NODE_VERSION=$(node -v)
    log ${LOG_INFO} "Runtime NodeJS encontrada e configurada..."
    log ${LOG_INFO} "Runtime Target ${NODE_VERSION}"
else 
    log ${LOG_CONFIG} "NodeJS nao encontrado, iniciando instalação..."
    apt install nodejs
fi

# Create temp workers directory
log ${LOG_CONFIG} "Configurando pastas temporarias dos workers"

# If the worker folder not created, create it now
if [ ! -d "$NAME_TEMP_WORKDIR" ]; then
  log ${LOG_INFO} "Criando pasta temporaria para os workers"
  mkdir $NAME_TEMP_WORKDIR
fi




