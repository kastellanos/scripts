#!/bin/zsh
#
C_DIR=001
C_SUBDIR=11
GIT_DIR=$HOME/github
function lsgit() {
    tree -L 2 -d $GIT_DIR
}
function cdgit() {
    gppath=$GIT_DIR/$1/$2
    cd $gppath
}
function chgit() {
    clear
    jsn=( $(tree -L 2 -d -J $GIT_DIR) )
    dirs=( $(echo $jsn | jq  -c '.[0]["contents"][]["name"]') )
    OUTER_INDEX=1
    declare -a OUTER_DIR=()
    declare -a INNER_DIR=()
    for i in $dirs 
    do
        oth=( $(echo $jsn | jq -c '.[0]["contents"][] | select(.name | contains('$i'))["contents"][]["name"]') )
        d_i=$(echo $i | tr -d '"')
        OUTER_DIR+=("$i")
        #printf "%s--%s\n" "$OUTER_INDEX" "$d_i"
        print -P "%F{$C_DIR}$OUTER_INDEX--$d_i%f"
        OUTER_INDEX=$(expr $OUTER_INDEX + 1)
        INDEX=1
        for j in $oth
        do
                #echo $INDEX'--->'$j
                d_j=$(echo $j | tr -d '"')
                #INNER_DIR+=("$d_j")
                print -P "%F{$C_SUBDIR}$INDEX--->$j"
                INDEX=$(expr $INDEX + 1)
        done
    done
    read s_dir s_subdir
    
    if [ "$s_dir" -le "${#OUTER_DIR[@]}" ]; then
            print "No outbound dir"
            
    else
			clear
            print "outbound dir";
            return -1
    fi
    
    subdir_query=( $(echo $jsn | jq -c '.[0]["contents"][] | select(.name | contains('${OUTER_DIR[s_dir]}'))["contents"][]["name"]')  )
	#INNER_DIR+=("placebo")
    for j in $subdir_query
	do
			d_j=$(echo $j | tr -d '"')
			INNER_DIR+=("$d_j")
	done

    if [ "$s_subdir" -le "${#INNER_DIR[@]}" ]; then
#            clear
            print "No outbound subdir";
            cd $GIT_DIR"/"$(echo ${OUTER_DIR[s_dir]}| tr -d '"')"/"${INNER_DIR[s_subdir]};
            
    else
			clear
            print "outbound subdir";
            return -1;
    fi
              clear
  #print ${OUTER_DIR[s_dir]}
    #print ${INNER_DIR[s_subdir]}
    
}
