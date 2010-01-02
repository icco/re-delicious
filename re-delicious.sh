#!/bin/bash

# Dates need to be in CCYY-MM-DDThh:mm:ssZ
dateFormat="+%Y-%m-%dT%H:%M:%S%z";
startDate=`date -d "-1 week" $dateFormat`;
endDate=`date $dateFormat`;

# api url
baseURL="api.del.icio.us/v1/posts/all";
options="&fromdt={$startDate}&todt={$endDate}";

if [ $# -lt 2 ]; then
   echo "re-delicious";
   echo " --- ";
   echo "Prints out urls and descriptions for URLs saved during the last week"
   echo "Usage: $0 username password";
   exit 1;
else
   DELICIOUS_USER="$1";
   DELICIOUS_PASSWORD="$2";
   URL="https://$DELICIOUS_USER:$DELICIOUS_PASSWORD@$baseURL?$options";
fi;

echo "Delicious links for $DELICIOUS_USER."; 
echo "From: $startDate";
echo "To: $endDate";

# Alrighty, pull and parse data
#echo "Pulled from $URL";
XML=`curl -s $URL`;
echo $XML | xsltproc "delicious-atom-0.1.xslt" -
