export AFL_I_DONT_CARE_ABOUT_MISSING_CRASHES=1
export AFL_SKIP_CPUFREQ=1
export LD_LIBRARY_PATH="$HOME/pathAFLplusplus"
export CFG_BIN_FILE="./tiff_cfg.bin"
export RUST_BACKTRACE=1
#export AFL_DEBUG=1
# afl-fuzz -m none -i $HOME/fuzzing_tiff1/tiff-4.6.0/test/images/ -o $HOME/fuzzing_tiff1/out/ -c $HOME/fuzzing_tiff1/install-cmplog/bin/tiffinfo -- $HOME/fuzzing_tiff1/install/bin/tiffinfo -D -j -c -r -s -w @@
# afl-fuzz -s 123 -m none -i $HOME/fuzzing_tiff1/tiff-4.6.0/test/images/ -o $HOME/fuzzing_tiff1/out/ -- $HOME/fuzzing_tiff1/install/bin/tiffinfo -D -j -c -r -s -w @@
afl-fuzz -s 123 -m none -i tests -o output -- ../install/bin/tcpdump -vvvvXX -ee -nn -r @@

