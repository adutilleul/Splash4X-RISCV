#!/bin/sh

# Description:
#
# Runs the benchmark with a minimal problem size in a multiprocessor
# simulator.
#
# Usage:
#
# ./run.sh [NUMPROCS]
#

cd $(dirname $0)

#Some default values
TARGET=LU-NOCONT

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
	PROGARGS="-p$NUMPROCS -n512 -b16";;
"simdev"	) 
	PROGARGS="-p$NUMPROCS -n512 -b16";;
"simsmall"	) 
	PROGARGS="-p$NUMPROCS -n512 -b16";;
"simmedium"	) 
	PROGARGS="-p$NUMPROCS -n1024 -b16";;
"simlarge"	) 
	PROGARGS="-p$NUMPROCS -n2048 -b16";;
"native"	) 
	PROGARGS="-p$NUMPROCS -n8096 -b32";;
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


