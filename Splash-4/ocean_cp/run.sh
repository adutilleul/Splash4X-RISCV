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
TARGET=OCEAN-CONT

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
	PROGARGS="-n258 -p$NUMPROCS -e1e-07 -r20000 -t28800";;
"simdev"	) 
	PROGARGS="-n258 -p$NUMPROCS -e1e-07 -r20000 -t28800";;
"simsmall"	) 
	PROGARGS="-n514 -p$NUMPROCS -e1e-07 -r20000 -t28800";;
"simmedium"	) 
	PROGARGS="-n1026 -p$NUMPROCS -e1e-07 -r20000 -t28800";;
"simlarge"	) 
	PROGARGS="-n2050 -p$NUMPROCS -e1e-07 -r20000 -t28800";;
"native"	) 
	PROGARGS="-n4098 -p$NUMPROCS -e1e-07 -r10000 -t14400";;
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


