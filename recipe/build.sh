#!/bin/bash

mkdir build
cd build
if [ ${float_prec}=="high" ]; then
    export PREC_DEF="-DHIGH_PREC"
fi

cmake -D CMAKE_BUILD_TYPE=Release -D BUILD_LIB=on -D BUILD_SHARED_LIBS=on -DOPENMM_DIR=${PREFIX} -DDEEPMD_DIR=${PREFIX} -DTENSORFLOW_DIR=${PREFIX}  -DCMAKE_CXX_FLAGS="-DHIGH_PREC -I${PREFIX}/include -L${PREFIX}/lib -Wl,--no-as-needed -lrt -ldeepmd_op -ldeepmd -ldeepmd_cc -ltensorflow_cc -ltensorflow_framework -Wl,-rpath=${PREFIX}/lib" ..
export LD_LIBRARY_PATH=${PREFIX}

make #-j${NUM_CPUS}
make install
make test
make PythonInstall
