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
TARGET=WATER-SPATIAL

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
INPUTFILE="inputs/input_${NUMPROCS}"
INPUTTEMPLATE="inputs/input.template"
PROGARGS=" < ${INPUTFILE}"
PROG="./${TARGET}"


#Some tests
if [ ! -x "$PROG" ]
then
  echo "Error: Binary ${PROG} does not exist!"
  exit 1
fi


#Execution
echo Generating input file ${INPUTFILE}...
cat ${INPUTTEMPLATE} | sed s/NUMPROCS/$NUMPROCS/ > ${INPUTFILE}

RUN="$PROG $PROGARGS"

echo "Running $SUBMIT_CMD $RUN:"
eval $SUBMIT_CMD $RUN


