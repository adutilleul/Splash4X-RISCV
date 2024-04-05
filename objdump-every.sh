#!/bin/bash

BUILD_DIR=/mnt/Murcia/Internship/Splash-4/Splash-4-adapt
OBJDUMP="/mnt/Murcia/Internship/riscv-rss-sdk-stripped-v2/toolchain/bin/riscv64-unknown-linux-gnu-objdump -d "
$OBJDUMP $BUILD_DIR/barnes/BARNES $INSTALL_DIR_ROOT > $BUILD_DIR/barnes/BARNES.riscv.log
$OBJDUMP $BUILD_DIR/cholesky/CHOLESKY $INSTALL_DIR_ROOT > $BUILD_DIR/cholesky/CHOLESKY.riscv.log
$OBJDUMP $BUILD_DIR/fft/FFT $INSTALL_DIR_ROOT > $BUILD_DIR/fft/FFT.riscv.log
$OBJDUMP $BUILD_DIR/fmm/FMM $INSTALL_DIR_ROOT > $BUILD_DIR/fmm/FMM.riscv.log
$OBJDUMP $BUILD_DIR/lu_cb/LU-CONT $INSTALL_DIR_ROOT > $BUILD_DIR/lu_cb/LU-CONT.riscv.log
$OBJDUMP $BUILD_DIR/lu_ncb/LU-NOCONT $INSTALL_DIR_ROOT > $BUILD_DIR/lu_ncb/LU-NOCONT.riscv.log
$OBJDUMP $BUILD_DIR/ocean_cp/OCEAN-CONT $INSTALL_DIR_ROOT > $BUILD_DIR/ocean_cp/OCEAN-CONT.riscv.log
$OBJDUMP $BUILD_DIR/ocean_ncp/OCEAN-NOCONT $INSTALL_DIR_ROOT > $BUILD_DIR/ocean_ncp/OCEAN-NOCONT.riscv.log
$OBJDUMP $BUILD_DIR/radiosity/RADIOSITY $INSTALL_DIR_ROOT > $BUILD_DIR/radiosity/RADIOSITY.riscv.log
$OBJDUMP $BUILD_DIR/radix/RADIX $INSTALL_DIR_ROOT > $BUILD_DIR/radix/RADIX.riscv.log
$OBJDUMP $BUILD_DIR/volrend/VOLREND $INSTALL_DIR_ROOT > $BUILD_DIR/volrend/VOLREND.riscv.log
$OBJDUMP $BUILD_DIR/water_nsquared/WATER-NSQUARED $INSTALL_DIR_ROOT > $BUILD_DIR/water_nsquared/WATER-NSQUARED.riscv.log
$OBJDUMP $BUILD_DIR/water_spatial/WATER-SPATIAL $INSTALL_DIR_ROOT > $BUILD_DIR/water_spatial/WATER-SPATIAL.riscv.log

