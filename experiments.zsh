#!/bin/zsh
# COLOR
# print %F{$COLOR}TEXT%f
REQUIRED=001
WARNING=226
SUCCESS=082
EXP_PATH=$HOME'/Documents/experiments/'
function mkexp() {
if [ -z $1 ]; then
    print -P "%F{$REQUIRED}Nombre - Parametro requerido%f"
    return -1
fi
EXP_PATH_W_ARG1="$EXP_PATH$1"
if [ -d "$EXP_PATH_W_ARG1" ]; then
    print -P "%F{$WARNING}El directorio ya existe%f"
else
    print -P "%F{$SUCCESS}El directorio se ha creado exitosamente%f"
    mkdir "$EXP_PATH_W_ARG1"
fi
cd $EXP_PATH_W_ARG1
return 1
}

function rmexp() {
    if [ -z $1 ]; then
        print -P "%F{$REQUIRED}Nombre -Parametro requerido%f"
        return -1
    fi
    EXP_PATH_W_ARG1="$EXP_PATH$1"
    if [ -d "$EXP_PATH_W_ARG1" ]; then
        rm -r -f $EXP_PATH_W_ARG1
        print -P "%F{SUCCESS}\uf00c Experimento $1 eliminado%f"
    else
        print -P "%F{$WARNING}Ojo, no existe un expermiento llamado $1%f"
    fi    
}

function lsexp() {
    if [ -d "$EXP_PATH" ]; then
            str_content=$(ls $EXP_PATH )
            arr_content=( $str_content )
            echo $arr_content
    else
        print -P "%F{WARNING}La ruta $EXP_PATH no existe%f"
    fi
}

function cdexp() {
    if [ -z $1 ]; then
        print -P "%F{$REQUIRED}Nombre - Parametro requerido%f"
        return -1
    fi

    EXP_PATH_W_ARG1="$EXP_PATH$1"
    if [ -d "$EXP_PATH_W_ARG1" ]; then
        cd $EXP_PATH_W_ARG1
    else
        print -P "%F{WARNING} No existe el experimento $1%f"
    fi
}
