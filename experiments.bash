#!/bin/bash
# COLOR
# print TEXT
EXP_PATH=$HOME'/Documents/experiments/'
function mkexp() {
if [ -z $1 ]; then
    echo "Nombre - Parametro requerido"
    return -1
fi
EXP_PATH_W_ARG1="$EXP_PATH$1"
if [ -d "$EXP_PATH_W_ARG1" ]; then
    echo "El directorio ya existe"
else
    echo "El directorio se ha creado exitosamente"
    mkdir "$EXP_PATH_W_ARG1"
fi
cd $EXP_PATH_W_ARG1
return 1
}

function rmexp() {
    if [ -z $1 ]; then
        echo "Nombre -Parametro requerido"
        return -1
    fi
    EXP_PATH_W_ARG1="$EXP_PATH$1"
    if [ -d "$EXP_PATH_W_ARG1" ]; then
        rm -r -f $EXP_PATH_W_ARG1
        echo " Experimento $1 eliminado"
    else
        echo "Ojo, no existe un expermiento llamado $1"
    fi
}

function lsexp() {
    if [ -d "$EXP_PATH" ]; then
            str_content=$(ls $EXP_PATH )
            arr_content=( $str_content )
            echo $arr_content
    else
        echo "La ruta $EXP_PATH no existe"
    fi
}

function cdexp() {
    if [ -z $1 ]; then
        echo "Nombre - Parametro requerido"
        return -1
    fi

    EXP_PATH_W_ARG1="$EXP_PATH$1"
    if [ -d "$EXP_PATH_W_ARG1" ]; then
        cd $EXP_PATH_W_ARG1
    else
        echo " No existe el experimento $1"
    fi
}
function getfile() {
    mv $HOME'/Downloads/'$1 .
}
