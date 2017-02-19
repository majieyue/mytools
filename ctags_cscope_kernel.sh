#!/bin/sh

kernel_path=$1
kernel_platform=$2

remove_arch=""
for dir in `ls arch`; do
  if [ "$dir" == "x86" ]; then
    continue
  fi

  if [ "$dir" == "Kconfig" ]; then
    continue
  fi

  remove_arch="$dir $remove_arch"
done

echo $remove_arch

ctags_param=""
for arch in $remove_arch; do
  #ctags_param="--exclude=${kernel_path}/arch/${arch} ${ctags_param}"
  ctags_param="--exclude=\"arch/${arch}*\" ${ctags_param}"
done

#echo $ctags_param
#ctags -R ${ctags_param}


prune_dirs="( -path ./tmp -o -path ./Documentation -o -path ./scripts -o -path ./usr -o -path ./sound -o -path ./tools -o -path ./samples"

for arch in $remove_arch; do
  prune_dirs="${prune_dirs} -o -path ./arch/$arch"
done

prune_dirs="${prune_dirs} )"

echo "${prune_dirs}"

find \. ${prune_dirs} -prune -o -name *.[chxsS] -type f -print > cscope.files

