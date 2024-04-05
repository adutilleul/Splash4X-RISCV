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

#Some default values
TARGET=VOLREND

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
	PROGARGS="${NUMPROCS} inputs/head-scaleddown4 4";;
"simdev"	) 
	PROGARGS="${NUMPROCS} inputs/head-scaleddown4 4";;
"simsmall"	) 
	PROGARGS="${NUMPROCS} inputs/head-scaleddown4 20";;
"simmedium"	) 
	PROGARGS="${NUMPROCS} inputs/head-scaleddown2 50";;
"simlarge"	) 
	PROGARGS="${NUMPROCS} inputs/head-scaleddown2 100";;
"native"	) 
	PROGARGS="${NUMPROCS} head 1000";;
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


