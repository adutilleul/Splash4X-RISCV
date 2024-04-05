#!/bin/bash

BUILD_DIR=Splash-4
INSTALL_DIR=/mnt/Murcia/Internship/riscv-rss-sdk-stripped-v2/build/buildroot_initramfs_sysroot
INSTALL_DIR_ROOT=/mnt/Murcia/Internship/riscv-rss-sdk-stripped-v2/build/buildroot_initramfs_sysroot/root

cp $BUILD_DIR/barnes/BARNES $INSTALL_DIR_ROOT/barnes/BARNES
cp $BUILD_DIR/barnes/run.sh $INSTALL_DIR_ROOT/barnes/run.sh
cp -R $BUILD_DIR/barnes/inputs $INSTALL_DIR_ROOT/barnes

cp $BUILD_DIR/cholesky/CHOLESKY $INSTALL_DIR_ROOT/cholesky/CHOLESKY
cp $BUILD_DIR/cholesky/run.sh $INSTALL_DIR_ROOT/cholesky/run.sh
cp -R $BUILD_DIR/cholesky/inputs $INSTALL_DIR_ROOT/cholesky

cp $BUILD_DIR/fft/FFT $INSTALL_DIR_ROOT/fft/FFT
cp $BUILD_DIR/fft/run.sh $INSTALL_DIR_ROOT/fft/run.sh

cp $BUILD_DIR/fmm/FMM $INSTALL_DIR_ROOT/fmm
cp $BUILD_DIR/fmm/run.sh $INSTALL_DIR_ROOT/fmm/run.sh
cp -R $BUILD_DIR/fmm/inputs $INSTALL_DIR_ROOT/fmm

cp $BUILD_DIR/lu_cb/LU-CONT $INSTALL_DIR_ROOT/lu_cb
cp $BUILD_DIR/lu_cb/run.sh $INSTALL_DIR_ROOT/lu_cb/run.sh

cp $BUILD_DIR/lu_ncb/LU-NOCONT $INSTALL_DIR_ROOT/lu_ncb
cp $BUILD_DIR/lu_ncb/run.sh $INSTALL_DIR_ROOT/lu_ncb/run.sh

cp $BUILD_DIR/ocean_cp/OCEAN-CONT $INSTALL_DIR_ROOT/ocean_cp/OCEAN-CONT
cp $BUILD_DIR/ocean_cp/run.sh $INSTALL_DIR_ROOT/ocean_cp/run.sh

cp $BUILD_DIR/ocean_ncp/OCEAN-NOCONT $INSTALL_DIR_ROOT/ocean_ncp/OCEAN-NOCONT
cp $BUILD_DIR/ocean_ncp/run.sh $INSTALL_DIR_ROOT/ocean_ncp/run.sh

cp $BUILD_DIR/raytrace/RAYTRACE $INSTALL_DIR_ROOT/raytrace/RAYTRACE
cp $BUILD_DIR/raytrace/run.sh $INSTALL_DIR_ROOT/raytrace/run.sh
cp -R $BUILD_DIR/raytrace/inputs $INSTALL_DIR_ROOT/raytrace

cp $BUILD_DIR/radiosity/RADIOSITY $INSTALL_DIR_ROOT/radiosity/RADIOSITY
cp $BUILD_DIR/radiosity/run.sh $INSTALL_DIR_ROOT/radiosity/run.sh

cp $BUILD_DIR/radix/RADIX $INSTALL_DIR_ROOT/radix/RADIX
cp $BUILD_DIR/radix/run.sh $INSTALL_DIR_ROOT/radix/run.sh

cp $BUILD_DIR/volrend/VOLREND $INSTALL_DIR_ROOT/volrend/VOLREND
cp $BUILD_DIR/volrend/run.sh $INSTALL_DIR_ROOT/volrend/run.sh
cp -R $BUILD_DIR/volrend/inputs $INSTALL_DIR_ROOT/volrend/inputs

cp $BUILD_DIR/water_nsquared/WATER-NSQUARED $INSTALL_DIR_ROOT/water_nsquared/WATER-NSQUARED
cp $BUILD_DIR/water_nsquared/run.sh $INSTALL_DIR_ROOT/water_nsquared/run.sh
cp -R $BUILD_DIR/water_nsquared/inputs $INSTALL_DIR_ROOT/water_nsquared

cp $BUILD_DIR/water_spatial/WATER-SPATIAL $INSTALL_DIR_ROOT/water_spatial/WATER-SPATIAL
cp $BUILD_DIR/water_spatial/run.sh $INSTALL_DIR_ROOT/water_spatial/run.sh
cp -R $BUILD_DIR/water_spatial/inputs $INSTALL_DIR_ROOT/water_spatial

touch $INSTALL_DIR