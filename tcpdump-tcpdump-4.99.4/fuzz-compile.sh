# !/bin/bash
# 运行之前记得切换到 path_fuzzer_with_path_reduction 分支 

rm ./bbid.txt ./callmap.txt ./cfg.txt ./function_list.txt ./bbnum.txt ./convert ./cfg_filtered.txt ./callmap_filtered.txt

# bash update_path_reduction.sh

make clean
export BBIDFILE="$(pwd)/bbid.txt" 
export CALLMAPFILE="$(pwd)/callmap.txt" 
export CFGFILE="$(pwd)/cfg.txt" 
export LD_LIBRARY_PATH="$HOME/pathAFLplusplus"
export AFL_LLVM_CALLER=1
export CC="afl-clang-fast"
export CXX="afl-clang-fast++"
# export AFL_USE_ASAN=1
# export AFL_USE_UBSAN=1

./configure --prefix="$(pwd)/../install/" --disable-shared
make -e -j8
make -e install

# 获取 bbnum.txt
cat cfg.txt | grep "BasicBlock: " | wc -l > bbnum.txt
# 如果是其它 PUT，这里需要一个 filter CFG 和 callmap 的操作，这里直接拷贝改名就好
bash filterCFG_Callmap_script.sh
# cp cfg.txt cfg_filtered.txt
# cp callmap.txt callmap_filtered.txt
# 获取 function_list.txt
cat cfg_filtered.txt | grep "Function: " | nl -v 0 | awk '{print $1, $3, $4, $5, $6, $7, $8, $9}' > function_list.txt

g++ convert.cpp -o convert
./convert
mv top.bin tiff_cfg.bin
