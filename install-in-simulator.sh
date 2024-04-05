#!/bin/bash

BUILD_DIR=Splash-4
INSTALL_DIR=/mnt/Murcia/Internship/riscv-rss-sdk-stripped-v2/build/buildroot_initramfs_sysroot
INSTALL_DIR_ROOT=/mnt/Murcia/Internship/riscv-rss-sdk-stripped-v2/build/buildroot_initramfs_sysroot/root

cp $BUILD_DIR/barnes/BARNES $INSTALL_DIR_ROOT
cp -R $BUILD_DIR/barnes/inputs $INSTALL_DIR_ROOT/barnes
cp $BUILD_DIR/cholesky/CHOLESKY $INSTALL_DIR_ROOT
cp -R $BUILD_DIR/cholesky/inputs $INSTALL_DIR_ROOT/cholesky
cp $BUILD_DIR/fft/FFT $INSTALL_DIR_ROOT
cp $BUILD_DIR/fmm/FMM $INSTALL_DIR_ROOT
cp -R $BUILD_DIR/fmm/inputs $INSTALL_DIR_ROOT/fmm
cp $BUILD_DIR/lu_cb/LU-CONT $INSTALL_DIR_ROOT
cp $BUILD_DIR/lu_ncb/LU-NOCONT $INSTALL_DIR_ROOT
cp $BUILD_DIR/ocean_cp/OCEAN-CONT $INSTALL_DIR_ROOT
cp $BUILD_DIR/ocean_ncp/OCEAN-NOCONT $INSTALL_DIR_ROOT
cp $BUILD_DIR/raytrace/RAYTRACE $INSTALL_DIR_ROOT
cp -R $BUILD_DIR/raytrace/inputs $INSTALL_DIR_ROOT/raytrace
cp $BUILD_DIR/radiosity/RADIOSITY $INSTALL_DIR_ROOT
cp $BUILD_DIR/radix/RADIX $INSTALL_DIR_ROOT
cp $BUILD_DIR/volrend/VOLREND $INSTALL_DIR_ROOT
cp -R $BUILD_DIR/volrend/inputs $INSTALL_DIR_ROOT/volrend
cp $BUILD_DIR/water_nsquared/WATER-NSQUARED $INSTALL_DIR_ROOT
cp -R $BUILD_DIR/water_nsquared/inputs $INSTALL_DIR_ROOT/water_nsquared
cp $BUILD_DIR/water_spatial/WATER-SPATIAL $INSTALL_DIR_ROOT
cp -R $BUILD_DIR/water_spatial/inputs $INSTALL_DIR_ROOT/water_spatial

touch $INSTALL_DIR