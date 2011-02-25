#!/bin/bash
#
#   Bulk minify script
#   Will minify all css and js scripts without .min.css or .min.js extensions 
#   Will create a minified copy of the file in the appropriate folder
#
#   NOTE: Be sure to run script from script folder
#         ./minify.sh
#
#   Author: Craig Russell
#   Email:  craig@craig-russell.co.uk
#

CSS="css"
JS="js"
FILELIST="minify.$$.tmp"

COMPORESSOR="yuicompressor-2.4.2.jar"

MINCSS="css/styles.min.css"

echo -n "" > $MINCSS

ls $CSS | grep -v min > $FILELIST
while read LINE
do
    OLD="$CSS/$LINE"
    
    echo "$OLD -> $MINCSS"
    java -jar yuicompressor-2.4.2.jar $OLD |sed 's/and/and /g' >> $MINCSS
    
done < $FILELIST

ls $JS | grep -v min > $FILELIST
while read LINE
do
    OLD="$JS/$LINE"
    NEW=` echo "$JS/$LINE" | sed 's/.js/.min.js/g'`
    
    echo "$OLD -> $NEW"
    java -jar yuicompressor-2.4.2.jar $OLD > $NEW
    
done < $FILELIST

rm -f $FILELIST
