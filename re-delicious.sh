#!/bin/bash

# CCYY-MM-DDThh:mm:ssZ
dateFormat="+%Y-%m-%dT%H:%M:%S%z";
startDate=`date -d "-1 week" $dateFormat`;
endDate=`date $dateFormat`;

if [ $# -lt 2 ]; then
   echo "re-delicious";
   echo " --- ";
   echo "Prints out urls and descriptions for URLs saved during the last week"
   echo "Usage: $0 username password";
   exit 1;
fi;

echo "From: $startDate"
echo "To: $endDate"
