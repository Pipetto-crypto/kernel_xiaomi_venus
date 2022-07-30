#!/bin/bash

export OUTDIR=out
export CROSS_COMPILE=$(pwd)/proton-clang/bin/aarch64-linux-gnu-
export ARCH=arm64
export CC=$(pwd)/proton-clang/bin/clang
export TRIPLE=aarch64-linux-gnu-

clear(){
rm -rf $OUTDIR
}

build(){

mkdir -p $OUTDIR
if test -f $OUTDIR/.config
then
	make -j$(nproc) O=$OUTDIR ARCH=$ARCH CROSS_COMPILE=$CROSS_COMPILE REAL_CC=$CC CLANG_TRIPLE=$TRIPLE 2>&1 | tee kernel.log
else
	make O=$OUTDIR ARCH=$ARCH venus-qgki_defconfig	
	make -j$(nproc) O=$OUTDIR ARCH=$ARCH CROSS_COMPILE=$CROSS_COMPILE REAL_CC=$CC CLANG_TRIPLE=$TRIPLE 2>&1 | tee kernel.log

fi

}

help(){

echo -e "\nA simple build script to compile Venus kernel\n"
echo -e "Syntax: build-kernel.sh [help|clear|build]\n"
echo -e "Options:\n"
echo -e "build  -   Build the target kernel\n"
echo -e "clear  -   Clean the working directory\n"
echo -e "help   -    Display help\n"

}

while [ True ];
do
	if [ "$1" == "help" ];
	then
		help
		break
	elif [ "$1" == "build" ];
	then
		build
		break
	elif [ "$1" == "clear" ];
	then
		clear
		break
	else
		help
		break
	fi

done


