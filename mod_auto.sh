#!/bin/bash
copy_cmd() {
    if test -e ".$1"; then
        echo ".$1 already exists."
    else
	    lib=$1
		dir=${lib%/*}
		if test -e ".$dir"; then
		    echo ".$dir already exists"
	    else
		    mkdir -p ".$dir"
			echo ".$dir already created."
	    fi
        cp -LR "$1" ".$1"
        echo "$1 has copied."
    fi
}

if test -e ./listmod; then
    rm ./listmod
else
    touch ./listmod
fi

lsmod | awk '{ print $1 }' | grep -v Module | while read mod
do
    mod_lib=`modinfo $mod | head -n 1 | awk '{ print $2 }'`
	copy_cmd $mod_lib
	echo $mod_lib >> ./listmod
done
