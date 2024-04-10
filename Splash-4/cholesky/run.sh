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
TARGET=CHOLESKY

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
	INPUTFILE="inputs/tk14.O";;
"simdev"	) 
	INPUTFILE="inputs/tk14.O";;
"simsmall"	) 
	INPUTFILE="inputs/tk29.O";;
"simmedium"	) 
	INPUTFILE="inputs/tk29.O";;
"simlarge"	) 
	INPUTFILE="inputs/tk29.O";;
"native"	) 
	INPUTFILE="inputs/tk29.O";;
*)  
	echo "Input size error"
	exit 1;;
esac
 
PROGARGS="-p${NUMPROCS} < ${INPUTFILE}"
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


