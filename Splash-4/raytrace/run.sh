#!/bin/sh

# Description:
#
# Runs the benchmark with a minimal problem size in a multiprocessor
# simulator.
#
# Usage:
#
# ./run.sh [ARCH [PARTYPE [NUMPROCS]]]]
#

cd $(dirname $0)

#Some default values
TARGET=RAYTRACE

#Arguments
if [ -n "$1" ]
then
  NUMPROCS="$1"
fi

if [ -n "$2" ]
then
  INPUTSIZE="$2"
fi


if [ -n "$3" ]
then
  echo "Error: Too many arguments!"
  echo 
  head -n11 $0 | tail -n9 | sed 's/#//'
  exit 1
fi


#Determine program name, file names & arguments
case "${INPUTSIZE}" in 
"test"	) 
	PROGARGS="-s -p$NUMPROCS -a4 inputs/teapot.env";;
"simdev"	) 
	PROGARGS="-s -p$NUMPROCS -a4 inputs/teapot.env";;
"simsmall"	) 
	PROGARGS="-s -p$NUMPROCS -a8 inputs/teapot.env";;
"simmedium"	) 
	PROGARGS="-s -p$NUMPROCS -a2 inputs/balls4.env";;
"simlarge"	) 
	PROGARGS="-s -p$NUMPROCS -a8 inputs/balls4.env";;
"native"	) 
	PROGARGS="-s -p$NUMPROCS -a128 inputs/car.env";;
*)  
	echo "Input size error"
	exit 1;;
esac
 

PROG="./${TARGET}"


#Some tests
if [ ! -x "$PROG" ]
then
  echo "Error: Binary ${PROG} does not exist!"
  exit 1
fi


#Execution
echo Generating input file ${INPUTFILE}...

RUN="$PROG $PROGARGS"

echo "Running $SUBMIT_CMD $RUN:"
eval $SUBMIT_CMD $RUN


