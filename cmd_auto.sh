#!/bin/bash
copy_cmd() {
    if test -e ".$1"; then
        echo "$1 already exists."
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

if test -e "./liblist"; then
    rm ./liblist
else
    touch ./liblist
fi

if test -e "./tmplist"; then
    rm ./tmplist
else
    touch ./tmplist
fi

cat ./cmdlist | while read cmd
do
    copy_cmd $cmd
    ldd "$cmd" | grep -v linux-vdso | awk '{ print $3 }' >> ./tmplist
done
cat ./tmplist | sort | uniq > ./liblist

cat ./liblist | while read lib
do
    copy_cmd $lib
done

copy_cmd /lib64/ld-linux-x86-64.so.2
